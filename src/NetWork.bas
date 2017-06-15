Attribute VB_Name = "NetWork"

Option Explicit

Public Enum AnalogEnum

    analog10Volt
    analog420mA
    analog020mA
    analogPt100
    analogPt1000
    analogNi100
    analogNi1000
    analogTermocoppia

End Enum

Public Type AnalogType
    Value As Integer
    Type As AnalogEnum
End Type


'Per le analogiche il numero è il numero di ingressi/uscite
Public Const NUMANALOGIN As Integer = 56
Public Const NUMANALOGOUT As Integer = 32
'
Public AnalogIO(NUMANALOGIN + NUMANALOGOUT) As AnalogType


Public Const SetIP = "127.0.0.1" 'LOCALHOST
Public Const OpcServerName = "Softing.OPC.S7.DA"
Public PlcDisabilitaConnessione As Boolean


Public Enum QualityEnum

    STATOERRORE = 0
    STATONONDEFINITO = 1
    STATONONDISPONIBILE = 2
    STATOOK = 3

End Enum

Public PlcParametriOk As Boolean '20150109

Public MancanzaComunicazione As Boolean
Private PlcInDigitali_Fatta As Boolean
Private plcInAnalogici_Fatta As Boolean
Private plcInAnalogici_Gestfumitamb_Fatta   '20161128
Private plcInAnalogici_Gestveltamb_Fatta   '20161130

Public TemperaturaTorre As Long
Public MaxValoreTempSottoMesc As Long

Private TimerVideataPrincipale As Long

Public ParallelDrum As Boolean

Public PlcSimulation As Boolean

'I TAG ed i relativi indirizzi sono definiti nel file OPCTags.xls (v 9.5.25)
' Per aggiungere/rimuovere TAGs é sufficiente:
' - modificare il relativo foglio del file XLS
' - copiare la prima colonna del foglio e ripopolare l'Enum ed aggiungere sempre l'ultimo valore "PLCTAG_COUNT")
'La registrazione dei TAG definiti nel file XLS viene effettuata dalla funzione LoadOPCTags()
Public Enum PlcTagEnum

	PLCTAG_KgImpasto
	PLCTAG_ThImpianto
	PLCTAG_UnitaPLC
	PLCTAG_FondoScalaBilA
	PLCTAG_FondoScalaBilF
	PLCTAG_FondoScalaBilB
	PLCTAG_FondoScalaBilV
	PLCTAG_FondoScalaBilAdd
	PLCTAG_FondoScalaBilRic
	PLCTAG_FondoScalaBil7
	PLCTAG_TaraMaxA
	PLCTAG_TaraMaxF
	PLCTAG_TaraMaxB
	PLCTAG_TaraMaxViatop
	PLCTAG_TaraMaxAdd
	PLCTAG_TaraMaxBil4
	PLCTAG_TaraMaxBil7
	PLCTAG_SicurezzaBilA
	PLCTAG_SicurezzaBilF
	PLCTAG_SicurezzaBilB
	PLCTAG_SicurezzaBilViatop
	PLCTAG_SicurezzaBilAdd
	PLCTAG_SicurezzaBilRAP
	PLCTAG_SicurezzaBil7
	PLCTAG_FondoScalaBilNastroA
	PLCTAG_FondoScalaBilNastroR
	PLCTAG_MaxThRamseyA
	PLCTAG_MaxThRamseyR
	PLCTAG_FScalaBilPondPred1
	PLCTAG_FScalaBilPondPred2
	PLCTAG_FScalaBilPondPred3
	PLCTAG_FondoScalaTempMaxDry
	PLCTAG_FondoScalaTempMinDry
	PLCTAG_FondoScalaTempMaxSab
	PLCTAG_FondoScalaTempMinSab
	PLCTAG_FondoScalaTempMaxBit
	PLCTAG_FondoScalaTempMinBit
	PLCTAG_PortataPred1
	PLCTAG_PortataPred2
	PLCTAG_PortataPred3
	PLCTAG_PortataPred4
	PLCTAG_PortataPred5
	PLCTAG_PortataPred6
	PLCTAG_PortataPred7
	PLCTAG_PortataPred8
	PLCTAG_PortataPred9
	PLCTAG_PortataPred10
	PLCTAG_PortataPred11
	PLCTAG_PortataPred12
	PLCTAG_PortataPredRic1
	PLCTAG_PortataPredRic2
	PLCTAG_PortataPredRic3
	PLCTAG_PortataPredRic4
	PLCTAG_ImpostPred1
	PLCTAG_ImpostPred2
	PLCTAG_ImpostPred3
	PLCTAG_ImpostPred4
	PLCTAG_ImpostPred5
	PLCTAG_ImpostPred6
	PLCTAG_ImpostPred7
	PLCTAG_ImpostPred8
	PLCTAG_ImpostPred9
	PLCTAG_ImpostPred10
	PLCTAG_ImpostPred11
	PLCTAG_ImpostPred12
	PLCTAG_ImpostPredRic1
	PLCTAG_ImpostPredRic2
	PLCTAG_ImpostPredRic3
	PLCTAG_ImpostPredRic4
	PLCTAG_AttenuazCorrezPondP1
	PLCTAG_AttenuazCorrezPondP2
	PLCTAG_AttenuazCorrezPondP3
	PLCTAG_AttenuazCorrezPondPR1
	PLCTAG_AttenuazCorrezPondPR2
	PLCTAG_AttenuazCorrezPondPR3
	PLCTAG_AttenuazCorrezPondPR4
	PLCTAG_LimiteMinCorrPondP1
	PLCTAG_LimiteMinCorrPondP2
	PLCTAG_LimiteMinCorrPondP3
	PLCTAG_LimiteMaxCorrPondP1
	PLCTAG_LimiteMaxCorrPondP2
	PLCTAG_LimiteMaxCorrPondP3
	PLCTAG_TimerPausaCorrezP1
	PLCTAG_TimerPausaCorrezP2
	PLCTAG_TimerPausaCorrezP3
	PLCTAG_TimerPausaCorrezPR1
	PLCTAG_TimerPausaCorrezPR2
	PLCTAG_TimerPausaCorrezPR3
	PLCTAG_TimerPausaCorrezPR4
	PLCTAG_TPausaLavoroFiltro
	PLCTAG_TimerLavoro1Filtro
	PLCTAG_TimerLavoro2Filtro
	PLCTAG_NumeroCamere
	PLCTAG_ModoFunzFiltro
	PLCTAG_PressFiltroMax
	PLCTAG_SicurezzaTemperatura
	PLCTAG_ValoreMaxVolo
	PLCTAG_ValoreMaxVoloBit
	PLCTAG_ValoreSetMaggioratoBit
	PLCTAG_TempoSvuotTraspViatop
	PLCTAG_TempoSvuotCicviatop
	PLCTAG_TempoRitApValvPresep
	PLCTAG_TempoRitChValvPresep
	PLCTAG_InclusioneLegante100
	PLCTAG_AbilitaVoloDinamicoFlusso
	PLCTAG_UnitaMaxPCL
	PLCTAG_CelleSiloStabBilancia
	PLCTAG_VeloxMax_SiwarexPESA
	PLCTAG_VeloxMin_SiwarexPESA
	PLCTAG_Kg_Lenta_SiwarexPESA
	PLCTAG_FlomacAbilitazione '20161125
	PLCTAG_UnitaMaxContalitri
	PLCTAG_UnitaMinContalitri
	PLCTAG_DensitaContalitri
	PLCTAG_ContalitriImpulsiLitro
	PLCTAG_ContalitriTempoMaxSpruzzatura
	PLCTAG_AbilitaPesataFineA1
	PLCTAG_AbilitaPesataFineA2
	PLCTAG_AbilitaPesataFineA3
	PLCTAG_AbilitaPesataFineA4
	PLCTAG_AbilitaPesataFineA5
	PLCTAG_AbilitaPesataFineA6
	PLCTAG_AbilitaPesataFineA7
	PLCTAG_AbilitaPesataFineNV
	PLCTAG_Densita_Add2_CNT
	PLCTAG_ImpulsiLitro_Add2_CNT
	PLCTAG_Rampa_dec_Add2_CNT
	PLCTAG_Tempo_sicurez_Add2_CNT
	PLCTAG_Add2_modo_CNT
	PLCTAG_Add2_presenza_valvola
	PLCTAG_Simulatore_S7_interno
	PLCTAG_AbilitaSicurezzaGalleggianteB2
	PLCTAG_AbilitaSicurezzaGalleggianteB3
	PLCTAG_AbilitaSiwarex6
	PLCTAG_AbilitaSiwarex7
	PLCTAG_AbilitaIME1096HDPLUS
	PLCTAG_AbilitaBennaApribile
	PLCTAG_GrigliaVibranteRic1Abilita
	PLCTAG_GrigliaVibranteRic2Abilita
	PLCTAG_GrigliaVibranteRic3Abilita
	PLCTAG_GrigliaVibranteRic4Abilita
	PLCTAG_AbilitaBilanciaAggregati
	PLCTAG_AbilitaBilanciaFiller
	PLCTAG_AbilitaBilanciaBitume
	PLCTAG_AbilitaBilanciaBitumeGR
	PLCTAG_AbilitaBilanciaContalitri
	PLCTAG_AbilitaBilanciaAddMix
	PLCTAG_AbilitaBilanciaAddBaci
	PLCTAG_AbilitaBilanciaViatop
	PLCTAG_AbilitaBilanciaRiciclato
	PLCTAG_AbilitaBilanciaRiciclatoSiwa
	PLCTAG_AbilitaBilanciaAddSacchi
	PLCTAG_AbilitaBilanciaAcqua
	PLCTAG_AbilitaAquablack
	PLCTAG_InclusioneCocleeRecupero
	PLCTAG_AbilitazSpruzzBennaTemporiz
	PLCTAG_EN_Pes_Fill_2_Coclee
	PLCTAG_EN_Flap_Sciv_Scar_Bil_ri
	PLCTAG_EN_Antiad_Sciv_Sc_BilRAP
	PLCTAG_EN_Pes_Fill_2_Forzata
	PLCTAG_AbilitaBlendingBitume
	PLCTAG_EN_SiloSoloDiretto
	PLCTAG_Pres_Selett_Scambio_B1B2 '20150923
	PLCTAG_TimeOutScaricoAggregati
	PLCTAG_TimeOutScaricoFiller
	PLCTAG_TimeOutScaricoLegante
	PLCTAG_TimeOutScaricoLeganteGR
	PLCTAG_TimeOutScaricoContalitri
	PLCTAG_TimeOutScaricoRiciclato
	PLCTAG_TimeOutScaricoViatop
	PLCTAG_TimeOutScaricoMixer
	PLCTAG_PermanenzaScaricoAggregati
	PLCTAG_PermanenzaScaricoFiller
	PLCTAG_PermanenzaScaricoRiciclato
	PLCTAG_DB5_DBW588
	PLCTAG_DB5_DBW590
	PLCTAG_PermanenzaScaricoLeganteGR
	PLCTAG_SiloS7RitardoPosizionaSottoMixer
	PLCTAG_PercConsensoFillerRF
	PLCTAG_PercConsensoAcquaRF
	PLCTAG_GrigliaVibranteRic1RitardoStart
	PLCTAG_GrigliaVibranteRic1RitardoStop
	PLCTAG_GrigliaVibranteRic2RitardoStart
	PLCTAG_GrigliaVibranteRic2RitardoStop
	PLCTAG_GrigliaVibranteRic3RitardoStart
	PLCTAG_GrigliaVibranteRic3RitardoStop
	PLCTAG_GrigliaVibranteRic4RitardoStart
	PLCTAG_GrigliaVibranteRic4RitardoStop
	PLCTAG_VibratoriPredTempoOn
	PLCTAG_VibratoriPredTempoOff
	PLCTAG_VibratoriPredRicTempoOn
	PLCTAG_VibratoriPredRicTempoOff
	PLCTAG_SoffioAriaPredRicTempoOn
	PLCTAG_SoffioAriaPredRicTempoOff
	PLCTAG_Tempo_Perm_Flap_Sc_Ric
	PLCTAG_NrImpAttAntiadScarBilRic
	PLCTAG_TempoSpruzAntiadScarBilR
	PLCTAG_Tempo_On_Soffio_Silo_Filler
	PLCTAG_Tempo_Off_Soffio_Silo_Filler
	PLCTAG_Tempo_Rit_All_FC_Mixer '20170221
	PLCTAG_NumCampionamentiCalcoloFlusso
	PLCTAG_MinimoPesataVeloce_Kg
	PLCTAG_PesataFineA1_Kg
	PLCTAG_PesataFineA2_Kg
	PLCTAG_PesataFineA3_Kg
	PLCTAG_PesataFineA4_Kg
	PLCTAG_PesataFineA5_Kg
	PLCTAG_PesataFineA6_Kg
	PLCTAG_PesataFineRAP_Kg
	PLCTAG_PesataFineNV_Kg
	PLCTAG_CoefficienteGrossaFineA1_Kg
	PLCTAG_CoefficienteGrossaFineA2_Kg
	PLCTAG_CoefficienteGrossaFineA3_Kg
	PLCTAG_CoefficienteGrossaFineA4_Kg
	PLCTAG_CoefficienteGrossaFineA5_Kg
	PLCTAG_CoefficienteGrossaFineA6_Kg
	PLCTAG_CoefficienteGrossaFineRAP_Kg
	PLCTAG_CoefficienteGrossaFineNV_Kg
	PLCTAG_CoefficienteFineChiusoA1_Kg
	PLCTAG_CoefficienteFineChiusoA2_Kg
	PLCTAG_CoefficienteFineChiusoA3_Kg
	PLCTAG_CoefficienteFineChiusoA4_Kg
	PLCTAG_CoefficienteFineChiusoA5_Kg
	PLCTAG_CoefficienteFineChiusoA6_Kg
	PLCTAG_CoefficienteFineChiusoRAP_Kg
	PLCTAG_CoefficienteFineChiusoNV_Kg
	PLCTAG_CoefficienteGrossaChiusoA1_Kg
	PLCTAG_CoefficienteGrossaChiusoA2_Kg
	PLCTAG_CoefficienteGrossaChiusoA3_Kg
	PLCTAG_CoefficienteGrossaChiusoA4_Kg
	PLCTAG_CoefficienteGrossaChiusoA5_Kg
	PLCTAG_CoefficienteGrossaChiusoA6_Kg
	PLCTAG_CoefficienteGrossaChiusoRAP_Kg
	PLCTAG_CoefficienteGrossaChiusoNV_Kg
	PLCTAG_MaxValKgAquablack
	PLCTAG_DI_PortinaAggChiusa
	PLCTAG_DI_PortinaAggAperta
	PLCTAG_DI_SicAggregati
	PLCTAG_DI_AbilitaAggregati
	PLCTAG_DO_PesataAgg1
	PLCTAG_DO_PesataAgg2
	PLCTAG_DO_PesataAgg3
	PLCTAG_DO_PesataAgg4
	PLCTAG_DO_PesataAgg5
	PLCTAG_DO_PesataAgg6
	PLCTAG_DO_PesataAgg7
	PLCTAG_DO_PesataAgg8
	PLCTAG_DO_PesataAgg9
	PLCTAG_DO_PesataAggNV
	PLCTAG_DO_ScaricoAggregati_Vers8_2
	PLCTAG_AI_BilanciaAggregati
	PLCTAG_DO_PesataEXTAgg1
	PLCTAG_DO_PesataEXTAgg2
	PLCTAG_DO_PesataEXTAgg3
	PLCTAG_DO_PesataEXTAgg4
	PLCTAG_DO_PesataEXTAgg5
	PLCTAG_DO_PesataEXTAgg6
	PLCTAG_DO_PesataEXTAggNV
	PLCTAG_DO_PesataEXTAggNV2
	PLCTAG_DO_PesataEXTAgg7
	PLCTAG_ScambioPesataTramoggione
	PLCTAG_DI_PortFillBil1Ch
	PLCTAG_DI_PortFillBil1Ap
	PLCTAG_DI_PortFillBil2Ch
	PLCTAG_DI_PortFillBil2Ap
	PLCTAG_DI_SicFiller
	PLCTAG_DI_AbilitaFiller
	PLCTAG_DO_PesataFill1
	PLCTAG_DO_PesataFill2
	PLCTAG_DO_PesataFill3
	PLCTAG_DO_PesataFill4
	PLCTAG_DO_ScaricoFiller_Vers8_2
	PLCTAG_DI_TermVibrScarBilFil
	PLCTAG_DI_TermIntroFillerMix
	PLCTAG_AI_BilanciaFiller
	PLCTAG_DO_PesataEXTFill1
	PLCTAG_DO_PesataEXTFill2
	PLCTAG_DO_PesataEXTFill3
	PLCTAG_DO_ApertTuboTroppoPienoF1
	PLCTAG_DI_ScambioFillerRecuperoInApporto_CH
	PLCTAG_AO_VelocitaCocleaPesataF1
	PLCTAG_AO_VelocitaCocleaPesataF2
	PLCTAG_AO_VelocitaCocleaPesataF3
	PLCTAG_DI_ValvLegChiusa
	PLCTAG_DI_ValvLegAperta
	PLCTAG_DI_SicLegante
	PLCTAG_DI_AbilitaBitume
	PLCTAG_DI_PompaLeganteON
	PLCTAG_DO_PesataLegante1
	PLCTAG_DO_PesataLegante2
	PLCTAG_DO_PesataLegante3
	PLCTAG_DO_ScambioB1
	PLCTAG_DO_ScaricoLegante_Vers8_2
	PLCTAG_DI_SicurezzaGalleggianteB2
	PLCTAG_DI_SicurezzaGalleggianteB3
	PLCTAG_DO_ScambioB2
	PLCTAG_DI_FC_Valv3Vie_Schiumato_norm
	PLCTAG_DI_FC_Valv3Vie_Schiumato_Soft
	PLCTAG_DI_Valv3VieSpruzzatriceVersoTorre
	PLCTAG_DO_Valv3VieBitume2Emulsione
	PLCTAG_DI_Valv3VieBitume2EmulsioneVersoBitume2
	PLCTAG_DI_Valv3VieBitume2EmulsioneVersoEmulsione
	PLCTAG_DO_invAddBacinella
	PLCTAG_DI_FillerRecuperoAusiliarioInserito
	PLCTAG_AI_BilanciaLegante
	PLCTAG_DI_PortBilViatopChiusa
	PLCTAG_DI_PortBilViatAperta
	PLCTAG_DI_SicViatop
	PLCTAG_DI_AbilitaViatop
	PLCTAG_DI_LivMinViatop
	PLCTAG_DI_PresenzaMatCiclone
	PLCTAG_DI_ScarCicloneChiuso
	PLCTAG_DI_RitMotTrasport
	PLCTAG_DI_TermMotTrasport
	PLCTAG_DO_MotoreVentolaViatop
	PLCTAG_DO_PesataViatop
	PLCTAG_DO_ScaricoBilViatop_Vers8_2
	PLCTAG_DO_ScaricoCicloneViatop_Vers8_2
	PLCTAG_DI_Term_Vibr_Viatop
	PLCTAG_AI_BilanciaViatop
	PLCTAG_DI_portBilRicChiusa
	PLCTAG_DI_portBilRicAperta
	PLCTAG_DI_SicBilRic
	PLCTAG_DI_AbilitaBilRiciclato
	PLCTAG_DO_PesataBilRiciclato
	PLCTAG_DO_ScaricoBilRiciclato_Vers8_2
	PLCTAG_DI_SicLivMaxTramRic
	PLCTAG_AI_BilanciaRAP
	PLCTAG_AI_TamponeRiciclato
	PLCTAG_AI_LivTramogTampRic
	PLCTAG_DO_Defl_Scar_Bil_Ric_RESERVED
	PLCTAG_FC_Defl_Scar_Bil_Ric_AP
	PLCTAG_FC_Defl_Scar_Bil_Ric_CH
	PLCTAG_DO_Antiadesivo_Sciv_Ric
	PLCTAG_DI_SicurezzaTamponeRiciclatoCaldo
	PLCTAG_DI_PortinaMescChiusa
	PLCTAG_DI_PortinaMescAperta
	PLCTAG_DI_ConsScaricoMesc
	PLCTAG_DI_MixerON
	PLCTAG_DO_MescolaInCorso
	PLCTAG_DO_ScaricoMesc_Vers8_2
	PLCTAG_DO_SpruzzaAntiadesivoScivoloRiciclatoMixer
	PLCTAG_DI_abilitaAdditivoMix
	PLCTAG_DI_PompaAddMix
	PLCTAG_DO_PompaAddMixer_Vers8_2
	PLCTAG_DI_TermPompaAddMixer
	PLCTAG_DI_PompaAcquaRitorno
	PLCTAG_DO_PompaAcquaComando
	PLCTAG_DI_PompaAcquaScattoTermica
	PLCTAG_DI_abilitaAdditivoLega
	PLCTAG_DI_PompaAddLegante
	PLCTAG_DO_PompaAddLegante_Vers8_2
	PLCTAG_DI_TermPompaAddLegante
	PLCTAG_DI_PesataAddLegante
	PLCTAG_DI_Valv_Add_leg_CH
	PLCTAG_DO_Valv_Add_leg
	PLCTAG_DI_Reset_man_Add_leg_CNT
	PLCTAG_AO_PompaAddLegante
	PLCTAG_DI_PortinaSacchiCh
	PLCTAG_DI_PortinaSacchiAp
	PLCTAG_Sacchi3_RIS
	PLCTAG_Sacchi4_RIS
	PLCTAG_DI_RitornoNastroSacchi
	PLCTAG_DI_TermicaNastroSacchi
	PLCTAG_DO_MotoreNastroSacchi_Vers8_2
	PLCTAG_DO_ConsensoIntroSacchi_Vers8_2
	PLCTAG_Sacchi9
	PLCTAG_Sacchi10
	PLCTAG_Sacchi11
	PLCTAG_Sacchi12
	PLCTAG_Sacchi13
	PLCTAG_Sacchi14
	PLCTAG_Sacchi15
	PLCTAG_Sacchi16
	PLCTAG_Sacchi17
	PLCTAG_Sacchi18
	PLCTAG_Sacchi19
	PLCTAG_Sacchi20
	PLCTAG_DI_GravitaValvScaricoCh
	PLCTAG_DI_GravitaValvScaricoAp
	PLCTAG_DI_GravitaSicurezza
	PLCTAG_DI_Gravita_RIS1
	PLCTAG_DI_Gravita_RIS2
	PLCTAG_DO_GravitaPesataB1
	PLCTAG_DO_GravitaPesataB2
	PLCTAG_DO_GravitaPesataB3
	PLCTAG_DO_GravitaPesataB4
	PLCTAG_DO_GravitaPesataB5
	PLCTAG_DO_GravitaPesataB6
	PLCTAG_DO_GravitaPesataB7
	PLCTAG_DI_Gravita_RIS3
	PLCTAG_DO_GravitaScarico_Vers8_2
	PLCTAG_AO_GravitaVelocitaPompa
	PLCTAG_DI_ContalitriValvolaPesataChiusa
	PLCTAG_DO_ContalitriPesata_Vers8_2
	PLCTAG_DI_ContalitriSicurezza
	PLCTAG_DI_ContalitriAbilitazione
	PLCTAG_DI_ContalitriReset
	PLCTAG_DI_Pesata_In_Corso_FLOM '20161122
	PLCTAG_DI_AbilitaCompAux1
	PLCTAG_DI_FinePesataCompAux1
	PLCTAG_DI_FineScaricoCompAux1
	PLCTAG_DI_SIWA_Batch_PortinaChiusa
	PLCTAG_DI_SIWA_Batch_PortinaAperta
	PLCTAG_XX_SIWA_Batch_RISERVA_228_2
	PLCTAG_DI_SIWA_Batch_RitornoNastro
	PLCTAG_DI_SIWA_Batch_SicurezzaNastro
	PLCTAG_DO_SIWA_Batch_ComandoAvvioNastro
	PLCTAG_DI_SIWA_Batch_StartNastroDaSIWA
	PLCTAG_DI_SIWA_Batch_DosaggioInCorsoDaSIWA
	PLCTAG_DI_SIWA_Batch_DosaggioTerminatoDaSIWA
	PLCTAG_DO_SIWA_Batch_ComandoArrestoNastro
	PLCTAG_DO_SIWA_Batch_StartCiclo
	PLCTAG_DO_SIWA_Batch_AbortCiclo
	PLCTAG_DO_SIWA_Batch_ComandoPortina
	PLCTAG_DO_SIWA_Batch_ModalitaTaratura
	PLCTAG_DO_SIWA_Batch_StartPesataSemiAuto
	PLCTAG_AckAllarmiAggregati
	PLCTAG_AckAllarmiFiller
	PLCTAG_AckAllarmiBitume
	PLCTAG_AckAllarmiBitumeGravita
	PLCTAG_AckAllarmiContalitri
	PLCTAG_AckAllarmiRiciclato
	PLCTAG_AckAllarmiViatop
	PLCTAG_AckAllarmiAddMixer
	PLCTAG_AckAllarmiAddLegante
	PLCTAG_AckAllarmiAddSacchi
	PLCTAG_AckAllarmiSiwaBatch
	PLCTAG_AckAllarmiAcqua
	PLCTAG_AckAllarmiDisp6
	PLCTAG_AckAllarmiDisp7
	PLCTAG_AckAllarmiMixer
	PLCTAG_AckAllarmiBenna
	PLCTAG_SospensionePesate
	PLCTAG_MixerPienoAmpere
	PLCTAG_BennaPienaAmpere
	PLCTAG_ImpCambioAlVoloDos
	PLCTAG_F_WatchdogPC
	PLCTAG_F_AbilPortineManuali
	PLCTAG_StartDosaggio
	PLCTAG_StartImpProlungato
	PLCTAG_OkStartDosaggio
	PLCTAG_StopDosaggio
	PLCTAG_Abort
	PLCTAG_MemAbort
	PLCTAG_TrasfDatiPlcDosaggio
	PLCTAG_PrenotaCambioRicDos
	PLCTAG_MemTrasfPlcScarico
	PLCTAG_AckFuoriTollSca
	PLCTAG_AckFuoriTollPes
	PLCTAG_AzzeramentoTotaliParz
	PLCTAG_AzzeramentoTotaliGen
	PLCTAG_MemPesAggrInCorso
	PLCTAG_DI_EsclusioneStampa
	PLCTAG_DO_DosaggioInCorso
	PLCTAG_DO_emergenza
	PLCTAG_DO_LampadaStopInCorso
	PLCTAG_DI_AlarmReset
	PLCTAG_DO_RicettaCoerente
	PLCTAG_DO_StampaIntestazione
	PLCTAG_DO_AllarmeSirenaSilo
	PLCTAG_DO_AllarmeAcustico
	PLCTAG_DO_AllarmeVisivo
	PLCTAG_MemTrasfDatiPLCcar
	PLCTAG_DI_TermPompaSpruzzLegante
	PLCTAG_DI_TermCocleaPesataF1
	PLCTAG_DI_TermCocleaPesataF2
	PLCTAG_DI_TermCocleaPesataF3
	PLCTAG_DI_TermicaComune
	PLCTAG_DI_RitornoCocleaPesataF2
	PLCTAG_DeflettoreVaglioManuale
	PLCTAG_DO_Dest_Trop_Pieno_F1F2
	PLCTAG_DI_Dest_trop_Pieno_F1
	PLCTAG_DO_PesataAggNV2
	PLCTAG_MemTorSelRicNV2
	PLCTAG_DO_LampScarMixPronto
	PLCTAG_DI_TermVentPulizPirom
	PLCTAG_DI_TermVentCentrIdr
	PLCTAG_DI_TermInverterTamburo
	PLCTAG_DI_TermInverterFiltro
	PLCTAG_DI_PressInsufComprBrucNONUSARE
	PLCTAG_DI_TermBennaTraslata
	PLCTAG_DI_AllTenutaValvoleOCNONUSARE
	PLCTAG_DI_RitornoCocleaPesataF1
	PLCTAG_DI_RitornoCocleaPesataF3
	PLCTAG_DO_TorScambiovaglio
	PLCTAG_DI_TorVagliato
	PLCTAG_DI_TorNonVagliato
	PLCTAG_DO_TorAttNpRifiuti
	PLCTAG_DI_TorAttNpRifGr
	PLCTAG_DI_TorAttNpRifRf
	PLCTAG_DI_TorAttNpRifTer
	PLCTAG_DI_TorMemApPortMan
	PLCTAG_DI_TorBassaPress
	PLCTAG_DI_TorRiscTramNVTer
	PLCTAG_DI_TorLivMinTramRic
	PLCTAG_DI_TorLivMaxTramRic
	PLCTAG_DI_TorLivMaxNP
	PLCTAG_DI_TorTermFrenoVaglio
	PLCTAG_AI_TorTempTorre2_Sabbia
	PLCTAG_AI_TorTempLegante
	PLCTAG_AI_TorPressioneAria
	PLCTAG_DI_TorLivMinTamponeF1
	PLCTAG_DI_TorLivMaxTamponeF1
	PLCTAG_DI_TorLivMinTamponeF2
	PLCTAG_DI_TorLivMaxTamponeF2
	PLCTAG_DI_TorLivMinTamponeF3
	PLCTAG_DI_TorLivMaxTamponeF3
	PLCTAG_DI_TorLivMinAgg1
	PLCTAG_DI_TorLivMedAgg1
	PLCTAG_DI_TorLivMaxAgg1
	PLCTAG_AI_TorLivAgg1
	PLCTAG_DI_TorLivMinAgg2
	PLCTAG_DI_TorLivMedAgg2
	PLCTAG_DI_TorLivMaxAgg2
	PLCTAG_AI_TorLivAgg2
	PLCTAG_DI_TorLivMinAgg3
	PLCTAG_DI_TorLivMedAgg3
	PLCTAG_DI_TorLivMaxAgg3
	PLCTAG_AI_TorLivAgg3
	PLCTAG_DI_TorLivMinAgg4
	PLCTAG_DI_TorLivMedAgg4
	PLCTAG_DI_TorLivMaxAgg4
	PLCTAG_AI_TorLivAgg4
	PLCTAG_DI_TorLivMinAgg5
	PLCTAG_DI_TorLivMedAgg5
	PLCTAG_DI_TorLivMaxAgg5
	PLCTAG_AI_TorLivAgg5
	PLCTAG_DI_TorLivMinAgg6
	PLCTAG_DI_TorLivMedAgg6
	PLCTAG_DI_TorLivMaxAgg6
	PLCTAG_AI_TorLivAgg6
	PLCTAG_DI_TorLivMinAgg7
	PLCTAG_DI_TorLivMedAgg7
	PLCTAG_DI_TorLivMaxAgg7
	PLCTAG_AI_TorLivAgg7
	PLCTAG_DI_TorLivMinAgg8
	PLCTAG_DI_TorLivMedAgg8
	PLCTAG_DI_TorLivMaxAgg8
	PLCTAG_AI_TorLivAgg8
	PLCTAG_DI_TorLivMinAggNV
	PLCTAG_DI_TorLivMedAggNV
	PLCTAG_DI_TorLivMaxAggNV
	PLCTAG_AI_TorLivAggNV
	PLCTAG_DO_MixAttAspFumi
	PLCTAG_DI_MixAttAspFumiCh
	PLCTAG_DI_MixAttAspFumiAp
	PLCTAG_DI_MixAttAspFumiTer
	PLCTAG_DO_MixIngrassatore
	PLCTAG_DI_MixIngrLivMinimo
	PLCTAG_DI_MixIngrassatore2
	PLCTAG_DI_MixIngrassatoreTer
	PLCTAG_DO_TorDeflettore_2_Tramoggioni
	PLCTAG_DI_TorDeflettore_2_FC_tram2
	PLCTAG_DI_TorDeflettore_2_FC_tram3
	PLCTAG_DI_Pompa_Soft_Ritorno
	PLCTAG_DI_Pompa_Soft_Termica
	PLCTAG_DI_Pompa_Soft_Ritorno_Inversione
	PLCTAG_AI_MixTempscarico
	PLCTAG_AI_TorTempBacinLeg
	PLCTAG_AI_TorTempLegante2
	PLCTAG_AI_TorTempTuboLeg1
	PLCTAG_AI_TorTempTuboLeg2
	PLCTAG_AI_TorTempTorre1_NV
	PLCTAG_AI_TorTempTorre3
	PLCTAG_AI_TorTempTorre4
	PLCTAG_AI_TorTempTorre5
	PLCTAG_AI_TorTempTorre6
	PLCTAG_AI_TorTempTorre7
	PLCTAG_AI_TorTempTuboLeg3
	PLCTAG_AI_PompaEmulsioneTemp
	PLCTAG_TrasfDatiPlcPredosag
	PLCTAG_DI_MarciaPredosatHOLD
	PLCTAG_DI_StopPredosatImmed
	PLCTAG_DI_PredInManuale
	PLCTAG_En_ArrestoPredFinePrd
	PLCTAG_AI_PesoNastroInerti
	PLCTAG_AI_PesoNastroRiciclat
	PLCTAG_DO_NastrinoRiciclatoAnello2Elevatore
	PLCTAG_DI_NastrinoRiciclatoAnello2Elevatore
	PLCTAG_DO_SirenaPredosatoreVuoto
	PLCTAG_DI_PredosatoriTermica
	PLCTAG_AI_BrucModRic
	PLCTAG_DI_TermVibratoriPred
	PLCTAG_DI_TermVibratoriPRic
	PLCTAG_DO_Predosatore1
	PLCTAG_DI_RitPredosatore1
	PLCTAG_DI_TermPredosatore1
	PLCTAG_DI_AllPred1
	PLCTAG_DI_PalpatorePred1
	PLCTAG_DI_LivMinPred1
	PLCTAG_DO_VibratoreP1
	PLCTAG_DI_VibratoreP1
	PLCTAG_DO_LampadaP1
	PLCTAG_AO_SetPredosatore1
	PLCTAG_AI_RitPredosatore1
	PLCTAG_AI_LivPredosatore1
	PLCTAG_DO_Predosatore2
	PLCTAG_DI_RitPredosatore2
	PLCTAG_DI_TermPredosatore2
	PLCTAG_DI_AllPred2
	PLCTAG_DI_PalpatorePred2
	PLCTAG_DI_LivMinPred2
	PLCTAG_DO_VibratoreP2
	PLCTAG_DI_VibratoreP2
	PLCTAG_DO_LampadaP2
	PLCTAG_AO_SetPredosatore2
	PLCTAG_AI_RitPredosatore2
	PLCTAG_AI_LivPredosatore2
	PLCTAG_DO_Predosatore3
	PLCTAG_DI_RitPredosatore3
	PLCTAG_DI_TermPredosatore3
	PLCTAG_DI_AllPred3
	PLCTAG_DI_PalpatorePred3
	PLCTAG_DI_LivMinPred3
	PLCTAG_DO_VibratoreP3
	PLCTAG_DI_VibratoreP3
	PLCTAG_DO_LampadaP3
	PLCTAG_AO_SetPredosatore3
	PLCTAG_AI_RitPredosatore3
	PLCTAG_AI_LivPredosatore3
	PLCTAG_DO_Predosatore4
	PLCTAG_DI_RitPredosatore4
	PLCTAG_DI_TermPredosatore4
	PLCTAG_DI_AllPred4
	PLCTAG_DI_PalpatorePred4
	PLCTAG_DI_LivMinPred4
	PLCTAG_DO_VibratoreP4
	PLCTAG_DI_VibratoreP4
	PLCTAG_DO_LampadaP4
	PLCTAG_AO_SetPredosatore4
	PLCTAG_AI_RitPredosatore4
	PLCTAG_AI_LivPredosatore4
	PLCTAG_DO_Predosatore5
	PLCTAG_DI_RitPredosatore5
	PLCTAG_DI_TermPredosatore5
	PLCTAG_DI_AllPred5
	PLCTAG_DI_PalpatorePred5
	PLCTAG_DI_LivMinPred5
	PLCTAG_DO_VibratoreP5
	PLCTAG_DI_VibratoreP5
	PLCTAG_DO_LampadaP5
	PLCTAG_AO_SetPredosatore5
	PLCTAG_AI_RitPredosatore5
	PLCTAG_AI_LivPredosatore5
	PLCTAG_DO_Predosatore6
	PLCTAG_DI_RitPredosatore6
	PLCTAG_DI_TermPredosatore6
	PLCTAG_DI_AllPred6
	PLCTAG_DI_PalpatorePred6
	PLCTAG_DI_LivMinPred6
	PLCTAG_DO_VibratoreP6
	PLCTAG_DI_VibratoreP6
	PLCTAG_DO_LampadaP6
	PLCTAG_AO_SetPredosatore6
	PLCTAG_AI_RitPredosatore6
	PLCTAG_AI_LivPredosatore6
	PLCTAG_DO_Predosatore7
	PLCTAG_DI_RitPredosatore7
	PLCTAG_DI_TermPredosatore7
	PLCTAG_DI_AllPred7
	PLCTAG_DI_PalpatorePred7
	PLCTAG_DI_LivMinPred7
	PLCTAG_DO_VibratoreP7
	PLCTAG_DI_VibratoreP7
	PLCTAG_DO_LampadaP7
	PLCTAG_AO_SetPredosatore7
	PLCTAG_AI_RitPredosatore7
	PLCTAG_AI_LivPredosatore7
	PLCTAG_DO_Predosatore8
	PLCTAG_DI_RitPredosatore8
	PLCTAG_DI_TermPredosatore8
	PLCTAG_DI_AllPred8
	PLCTAG_DI_PalpatorePred8
	PLCTAG_DI_LivMinPred8
	PLCTAG_DO_VibratoreP8
	PLCTAG_DI_VibratoreP8
	PLCTAG_DO_LampadaP8
	PLCTAG_AO_SetPredosatore8
	PLCTAG_AI_RitPredosatore8
	PLCTAG_AI_LivPredosatore8
	PLCTAG_DO_Predosatore9
	PLCTAG_DI_RitPredosatore9
	PLCTAG_DI_TermPredosatore9
	PLCTAG_DI_AllPred9
	PLCTAG_DI_PalpatorePred9
	PLCTAG_DI_LivMinPred9
	PLCTAG_DO_VibratoreP9
	PLCTAG_DI_VibratoreP9
	PLCTAG_DO_LampadaP9
	PLCTAG_AO_SetPredosatore9
	PLCTAG_AI_RitPredosatore9
	PLCTAG_AI_LivPredosatore9
	PLCTAG_DO_Predosatore10
	PLCTAG_DI_RitPredosatore10
	PLCTAG_DI_TermPredosatore10
	PLCTAG_DI_AllPred10
	PLCTAG_DI_PalpatorePred10
	PLCTAG_DI_LivMinPred10
	PLCTAG_DO_VibratoreP10
	PLCTAG_DI_VibratoreP10
	PLCTAG_DO_LampadaP10
	PLCTAG_AO_SetPredosatore10
	PLCTAG_AI_RitPredosatore10
	PLCTAG_AI_LivPredosatore10
	PLCTAG_DO_Predosatore11
	PLCTAG_DI_RitPredosatore11
	PLCTAG_DI_TermPredosatore11
	PLCTAG_DI_AllPred11
	PLCTAG_DI_PalpatorePred11
	PLCTAG_DI_LivMinPred11
	PLCTAG_DO_VibratoreP11
	PLCTAG_DI_VibratoreP11
	PLCTAG_DO_LampadaP11
	PLCTAG_AO_SetPredosatore11
	PLCTAG_AI_RitPredosatore11
	PLCTAG_AI_LivPredosatore11
	PLCTAG_DO_Predosatore12
	PLCTAG_DI_RitPredosatore12
	PLCTAG_DI_TermPredosatore12
	PLCTAG_DI_AllPred12
	PLCTAG_DI_PalpatorePred12
	PLCTAG_DI_LivMinPred12
	PLCTAG_DO_VibratoreP12
	PLCTAG_DI_VibratoreP12
	PLCTAG_DO_LampadaP12
	PLCTAG_AO_SetPredosatore12
	PLCTAG_AI_RitPredosatore12
	PLCTAG_AI_LivPredosatore12
	PLCTAG_DO_Predosatore13
	PLCTAG_DI_RitPredosatore13
	PLCTAG_DI_TermPredosatore13
	PLCTAG_DI_AllPred13
	PLCTAG_DI_PalpatorePred13
	PLCTAG_DI_LivMinPred13
	PLCTAG_DO_VibratoreP13
	PLCTAG_DI_VibratoreP13
	PLCTAG_DO_LampadaP13
	PLCTAG_AO_SetPredosatore13
	PLCTAG_AI_RitPredosatore13
	PLCTAG_AI_LivPredosatore13
	PLCTAG_DO_Predosatore14
	PLCTAG_DI_RitPredosatore14
	PLCTAG_DI_TermPredosatore14
	PLCTAG_DI_AllPred14
	PLCTAG_DI_PalpatorePred14
	PLCTAG_DI_LivMinPred14
	PLCTAG_DO_VibratoreP14
	PLCTAG_DI_VibratoreP14
	PLCTAG_DO_LampadaP14
	PLCTAG_AO_SetPredosatore14
	PLCTAG_AI_RitPredosatore14
	PLCTAG_AI_LivPredosatore14
	PLCTAG_DO_Predosatore15
	PLCTAG_DI_RitPredosatore15
	PLCTAG_DI_TermPredosatore15
	PLCTAG_DI_AllPred15
	PLCTAG_DI_PalpatorePred15
	PLCTAG_DI_LivMinPred15
	PLCTAG_DO_VibratoreP15
	PLCTAG_DI_VibratoreP15
	PLCTAG_DO_LampadaP15
	PLCTAG_AO_SetPredosatore15
	PLCTAG_AI_RitPredosatore15
	PLCTAG_AI_LivPredosatore15
	PLCTAG_DO_Predosatore16
	PLCTAG_DI_RitPredosatore16
	PLCTAG_DI_TermPredosatore16
	PLCTAG_DI_AllPred16
	PLCTAG_DI_PalpatorePred16
	PLCTAG_DI_LivMinPred16
	PLCTAG_DO_VibratoreP16
	PLCTAG_DI_VibratoreP16
	PLCTAG_DO_LampadaP16
	PLCTAG_AO_SetPredosatore16
	PLCTAG_AI_RitPredosatore16
	PLCTAG_AI_LivPredosatore16
	PLCTAG_DO_Riciclato1
	PLCTAG_DI_RitRiciclato1
	PLCTAG_DI_TermRiciclato1
	PLCTAG_DI_AllRiciclato1
	PLCTAG_DI_PalpatoreRiciclato1
	PLCTAG_DI_LivMinRiciclato1
	PLCTAG_DO_SoffioAriaR1
	PLCTAG_DI_SoffioAriaR1
	PLCTAG_DO_LampadaR1
	PLCTAG_DI_GrigliaVibrante_Ric1_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric1
	PLCTAG_DI_TermGrigliaVibrante_Ric1
	PLCTAG_DO_Vibratore_Ric1
	PLCTAG_DI_Vibratore_Ric1
	PLCTAG_AO_SetRiciclato1
	PLCTAG_AI_RitRiciclato1
	PLCTAG_AI_LivRiciclato1
	PLCTAG_DO_Riciclato2
	PLCTAG_DI_RitRiciclato2
	PLCTAG_DI_TermRiciclato2
	PLCTAG_DI_AllRiciclato2
	PLCTAG_DI_PalpatoreRiciclato2
	PLCTAG_DI_LivMinRiciclato2
	PLCTAG_DO_SoffioAriaR2
	PLCTAG_DI_SoffioAriaR2
	PLCTAG_DO_LampadaR2
	PLCTAG_DI_GrigliaVibrante_Ric2_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric2
	PLCTAG_DI_TermGrigliaVibrante_Ric2
	PLCTAG_DO_Vibratore_Ric2
	PLCTAG_DI_Vibratore_Ric2
	PLCTAG_AO_SetRiciclato2
	PLCTAG_AI_RitRiciclato2
	PLCTAG_AI_LivRiciclato2
	PLCTAG_DO_Riciclato3
	PLCTAG_DI_RitRiciclato3
	PLCTAG_DI_TermRiciclato3
	PLCTAG_DI_AllRiciclato3
	PLCTAG_DI_PalpatoreRiciclato3
	PLCTAG_DI_LivMinRiciclato3
	PLCTAG_DO_SoffioAriaR3
	PLCTAG_DI_SoffioAriaR3
	PLCTAG_DO_LampadaR3
	PLCTAG_DI_GrigliaVibrante_Ric3_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric3
	PLCTAG_DI_TermGrigliaVibrante_Ric3
	PLCTAG_DO_Vibratore_Ric3
	PLCTAG_DI_Vibratore_Ric3
	PLCTAG_AO_SetRiciclato3
	PLCTAG_AI_RitRiciclato3
	PLCTAG_AI_LivRiciclato3
	PLCTAG_DO_Riciclato4
	PLCTAG_DI_RitRiciclato4
	PLCTAG_DI_TermRiciclato4
	PLCTAG_DI_AllRiciclato4
	PLCTAG_DI_PalpatoreRiciclato4
	PLCTAG_DI_LivMinRiciclato4
	PLCTAG_DO_SoffioAriaR4
	PLCTAG_DI_SoffioAriaR4
	PLCTAG_DO_LampadaR4
	PLCTAG_DI_GrigliaVibrante_Ric4_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric4
	PLCTAG_DI_TermGrigliaVibrante_Ric4
	PLCTAG_DO_Vibratore_Ric4
	PLCTAG_DI_Vibratore_Ric4
	PLCTAG_AO_SetRiciclato4
	PLCTAG_AI_RitRiciclato4
	PLCTAG_AI_LivRiciclato4
	PLCTAG_DO_Riciclato5
	PLCTAG_DI_RitRiciclato5
	PLCTAG_DI_TermRiciclato5
	PLCTAG_DI_AllRiciclato5
	PLCTAG_DI_PalpatoreRiciclato5
	PLCTAG_DI_LivMinRiciclato5
	PLCTAG_DO_SoffioAriaR5
	PLCTAG_DI_SoffioAriaR5
	PLCTAG_DO_LampadaR5
	PLCTAG_DI_GrigliaVibrante_Ric5_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric5
	PLCTAG_DI_TermGrigliaVibrante_Ric5
	PLCTAG_DO_Vibratore_Ric5
	PLCTAG_DI_Vibratore_Ric5
	PLCTAG_AO_SetRiciclato5
	PLCTAG_AI_RitRiciclato5
	PLCTAG_AI_LivRiciclato5
	PLCTAG_DO_Riciclato6
	PLCTAG_DI_RitRiciclato6
	PLCTAG_DI_TermRiciclato6
	PLCTAG_DI_AllRiciclato6
	PLCTAG_DI_PalpatoreRiciclato6
	PLCTAG_DI_LivMinRiciclato6
	PLCTAG_DO_SoffioAriaR6
	PLCTAG_DI_SoffioAriaR6
	PLCTAG_DO_LampadaR6
	PLCTAG_DI_GrigliaVibrante_Ric6_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric6
	PLCTAG_DI_TermGrigliaVibrante_Ric6
	PLCTAG_DO_Vibratore_Ric6
	PLCTAG_DI_Vibratore_Ric6
	PLCTAG_AO_SetRiciclato6
	PLCTAG_AI_RitRiciclato6
	PLCTAG_AI_LivRiciclato6
	PLCTAG_DO_Riciclato7
	PLCTAG_DI_RitRiciclato7
	PLCTAG_DI_TermRiciclato7
	PLCTAG_DI_AllRiciclato7
	PLCTAG_DI_PalpatoreRiciclato7
	PLCTAG_DI_LivMinRiciclato7
	PLCTAG_DO_SoffioAriaR7
	PLCTAG_DI_SoffioAriaR7
	PLCTAG_DO_LampadaR7
	PLCTAG_DI_GrigliaVibrante_Ric7_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric7
	PLCTAG_DI_TermGrigliaVibrante_Ric7
	PLCTAG_DO_Vibratore_Ric7
	PLCTAG_DI_Vibratore_Ric7
	PLCTAG_AO_SetRiciclato7
	PLCTAG_AI_RitRiciclato7
	PLCTAG_AI_LivRiciclato7
	PLCTAG_DO_Riciclato8
	PLCTAG_DI_RitRiciclato8
	PLCTAG_DI_TermRiciclato8
	PLCTAG_DI_AllRiciclato8
	PLCTAG_DI_PalpatoreRiciclato8
	PLCTAG_DI_LivMinRiciclato8
	PLCTAG_DO_SoffioAriaR8
	PLCTAG_DI_SoffioAriaR8
	PLCTAG_DO_LampadaR8
	PLCTAG_DI_GrigliaVibrante_Ric8_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric8
	PLCTAG_DI_TermGrigliaVibrante_Ric8
	PLCTAG_DO_Vibratore_Ric8
	PLCTAG_DI_Vibratore_Ric8
	PLCTAG_AO_SetRiciclato8
	PLCTAG_AI_RitRiciclato8
	PLCTAG_AI_LivRiciclato8
	PLCTAG_DO_Riciclato9
	PLCTAG_DI_RitRiciclato9
	PLCTAG_DI_TermRiciclato9
	PLCTAG_DI_AllRiciclato9
	PLCTAG_DI_PalpatoreRiciclato9
	PLCTAG_DI_LivMinRiciclato9
	PLCTAG_DO_SoffioAriaR9
	PLCTAG_DI_SoffioAriaR9
	PLCTAG_DO_LampadaR9
	PLCTAG_DI_GrigliaVibrante_Ric9_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric9
	PLCTAG_DI_TermGrigliaVibrante_Ric9
	PLCTAG_DO_Vibratore_Ric9
	PLCTAG_DI_Vibratore_Ric9
	PLCTAG_AO_SetRiciclato9
	PLCTAG_AI_RitRiciclato9
	PLCTAG_AI_LivRiciclato9
	PLCTAG_DO_Riciclato10
	PLCTAG_DI_RitRiciclato10
	PLCTAG_DI_TermRiciclato10
	PLCTAG_DI_AllRiciclato10
	PLCTAG_DI_PalpatoreRiciclato10
	PLCTAG_DI_LivMinRiciclato10
	PLCTAG_DO_SoffioAriaR10
	PLCTAG_DI_SoffioAriaR10
	PLCTAG_DO_LampadaR10
	PLCTAG_DI_GrigliaVibrante_Ric10_PalaPresente
	PLCTAG_DO_GrigliaVibrante_Ric10
	PLCTAG_DI_TermGrigliaVibrante_Ric10
	PLCTAG_DO_Vibratore_Ric10
	PLCTAG_DI_Vibratore_Ric10
	PLCTAG_AO_SetRiciclato10
	PLCTAG_AI_RitRiciclato10
	PLCTAG_AI_LivRiciclato10
	PLCTAG_ComandiAux00_Uscita
	PLCTAG_ComandiAux00_Ritorno
	PLCTAG_ComandiAux00_Termica
	PLCTAG_ComandiAux00_Inclusione
	PLCTAG_ComandiAux01_Uscita
	PLCTAG_ComandiAux01_Ritorno
	PLCTAG_ComandiAux01_Termica
	PLCTAG_ComandiAux01_Inclusione
	PLCTAG_ComandiAux02_Uscita
	PLCTAG_ComandiAux02_Ritorno
	PLCTAG_ComandiAux02_Termica
	PLCTAG_ComandiAux02_Inclusione
	PLCTAG_ComandiAux03_Uscita
	PLCTAG_ComandiAux03_Ritorno
	PLCTAG_ComandiAux03_Termica
	PLCTAG_ComandiAux03_Inclusione
	PLCTAG_ComandiAux04_Uscita
	PLCTAG_ComandiAux04_Ritorno
	PLCTAG_ComandiAux04_Termica
	PLCTAG_ComandiAux04_Inclusione
	PLCTAG_ComandiAux05_Uscita
	PLCTAG_ComandiAux05_Ritorno
	PLCTAG_ComandiAux05_Termica
	PLCTAG_ComandiAux05_Inclusione
	PLCTAG_ComandiAux06_Uscita
	PLCTAG_ComandiAux06_Ritorno
	PLCTAG_ComandiAux06_Termica
	PLCTAG_ComandiAux06_Inclusione
	PLCTAG_ComandiAux07_Uscita
	PLCTAG_ComandiAux07_Ritorno
	PLCTAG_ComandiAux07_Termica
	PLCTAG_ComandiAux07_Inclusione
	PLCTAG_ComandiAux08_Uscita
	PLCTAG_ComandiAux08_Ritorno
	PLCTAG_ComandiAux08_Termica
	PLCTAG_ComandiAux08_Inclusione
	PLCTAG_ComandiAux09_Uscita
	PLCTAG_ComandiAux09_Ritorno
	PLCTAG_ComandiAux09_Termica
	PLCTAG_ComandiAux09_Inclusione
	PLCTAG_ComandiAux10_Uscita
	PLCTAG_ComandiAux10_Ritorno
	PLCTAG_ComandiAux10_Termica
	PLCTAG_ComandiAux10_Inclusione
	PLCTAG_ComandiAux11_Uscita
	PLCTAG_ComandiAux11_Ritorno
	PLCTAG_ComandiAux11_Termica
	PLCTAG_ComandiAux11_Inclusione
	PLCTAG_ComandiAux12_Uscita
	PLCTAG_ComandiAux12_Ritorno
	PLCTAG_ComandiAux12_Termica
	PLCTAG_ComandiAux12_Inclusione
	PLCTAG_ComandiAux13_Uscita
	PLCTAG_ComandiAux13_Ritorno
	PLCTAG_ComandiAux13_Termica
	PLCTAG_ComandiAux13_Inclusione
	PLCTAG_ComandiAux14_Uscita
	PLCTAG_ComandiAux14_Ritorno
	PLCTAG_ComandiAux14_Termica
	PLCTAG_ComandiAux14_Inclusione
	PLCTAG_ComandiAux15_Uscita
	PLCTAG_ComandiAux15_Ritorno
	PLCTAG_ComandiAux15_Termica
	PLCTAG_ComandiAux15_Inclusione
	PLCTAG_ComandiAux16_Uscita
	PLCTAG_ComandiAux16_Ritorno
	PLCTAG_ComandiAux16_Termica
	PLCTAG_ComandiAux16_Inclusione
	PLCTAG_ComandiAux17_Uscita
	PLCTAG_ComandiAux17_Ritorno
	PLCTAG_ComandiAux17_Termica
	PLCTAG_ComandiAux17_Inclusione
	PLCTAG_ComandiAux18_Uscita
	PLCTAG_ComandiAux18_Ritorno
	PLCTAG_ComandiAux18_Termica
	PLCTAG_ComandiAux18_Inclusione
	PLCTAG_ComandiAux19_Uscita
	PLCTAG_ComandiAux19_Ritorno
	PLCTAG_ComandiAux19_Termica
	PLCTAG_ComandiAux19_Inclusione
	PLCTAG_ComandiAux20_Uscita
	PLCTAG_ComandiAux20_Ritorno
	PLCTAG_ComandiAux20_Termica
	PLCTAG_ComandiAux20_Inclusione
	PLCTAG_ComandiAux21_Uscita
	PLCTAG_ComandiAux21_Ritorno
	PLCTAG_ComandiAux21_Termica
	PLCTAG_ComandiAux21_Inclusione
	PLCTAG_ComandiAux22_Uscita
	PLCTAG_ComandiAux22_Ritorno
	PLCTAG_ComandiAux22_Termica
	PLCTAG_ComandiAux22_Inclusione
	PLCTAG_ComandiAux23_Uscita
	PLCTAG_ComandiAux23_Ritorno
	PLCTAG_ComandiAux23_Termica
	PLCTAG_ComandiAux23_Inclusione
	PLCTAG_ComandiAux24_Uscita
	PLCTAG_ComandiAux24_Ritorno
	PLCTAG_ComandiAux24_Termica
	PLCTAG_ComandiAux24_Inclusione
	PLCTAG_ComandiAux25_Uscita
	PLCTAG_ComandiAux25_Ritorno
	PLCTAG_ComandiAux25_Termica
	PLCTAG_ComandiAux25_Inclusione
	PLCTAG_ComandiAux26_Uscita
	PLCTAG_ComandiAux26_Ritorno
	PLCTAG_ComandiAux26_Termica
	PLCTAG_ComandiAux26_Inclusione
	PLCTAG_ComandiAux27_Uscita
	PLCTAG_ComandiAux27_Ritorno
	PLCTAG_ComandiAux27_Termica
	PLCTAG_ComandiAux27_Inclusione
	PLCTAG_ComandiAux28_Uscita
	PLCTAG_ComandiAux28_Ritorno
	PLCTAG_ComandiAux28_Termica
	PLCTAG_ComandiAux28_Inclusione
	PLCTAG_ComandiAux29_Uscita
	PLCTAG_ComandiAux29_Ritorno
	PLCTAG_ComandiAux29_Termica
	PLCTAG_ComandiAux29_Inclusione
	PLCTAG_DO_Motore01
	PLCTAG_DI_RitMotore01
	PLCTAG_DI_TermMotore01
	PLCTAG_DI_SicMotore01
	PLCTAG_DO_InvMotore01
	PLCTAG_DI_Al_Slittamento01
	PLCTAG_AO_SetMotore01
	PLCTAG_AI_AmpMotore01
	PLCTAG_DO_Motore02
	PLCTAG_DI_RitMotore02
	PLCTAG_DI_TermMotore02
	PLCTAG_DI_SicMotore02
	PLCTAG_DO_InvMotore02
	PLCTAG_DI_Al_Slittamento02
	PLCTAG_AO_SetMotore02
	PLCTAG_AI_AmpMotore02
	PLCTAG_DO_Motore03
	PLCTAG_DI_RitMotore03
	PLCTAG_DI_TermMotore03
	PLCTAG_DI_SicMotore03
	PLCTAG_DO_InvMotore03
	PLCTAG_DI_Al_Slittamento03
	PLCTAG_AO_SetMotore03
	PLCTAG_AI_AmpMotore03
	PLCTAG_DO_Motore04
	PLCTAG_DI_RitMotore04
	PLCTAG_DI_TermMotore04
	PLCTAG_DI_SicMotore04
	PLCTAG_DO_InvMotore04
	PLCTAG_DI_Al_Slittamento04
	PLCTAG_AO_SetMotore04
	PLCTAG_AI_AmpMotore04
	PLCTAG_DO_Motore05
	PLCTAG_DI_RitMotore05
	PLCTAG_DI_TermMotore05
	PLCTAG_DI_SicMotore05
	PLCTAG_DO_InvMotore05
	PLCTAG_DI_Al_Slittamento05
	PLCTAG_AO_SetMotore05
	PLCTAG_AI_Amp1Motore05
	PLCTAG_DO_Motore06
	PLCTAG_DI_RitMotore06
	PLCTAG_DI_TermMotore06
	PLCTAG_DI_SicMotore06
	PLCTAG_DO_InvMotore06
	PLCTAG_DI_Al_Slittamento06
	PLCTAG_AO_SetMotore06
	PLCTAG_AI_AmpMotore06
	PLCTAG_DO_Motore07
	PLCTAG_DI_RitMotore07
	PLCTAG_DI_TermMotore07
	PLCTAG_DI_SicMotore07
	PLCTAG_DO_InvMotore07
	PLCTAG_DI_Al_Slittamento07
	PLCTAG_AO_SetMotore07
	PLCTAG_AI_AmpMotore07
	PLCTAG_DO_Motore08
	PLCTAG_DI_RitMotore08
	PLCTAG_DI_TermMotore08
	PLCTAG_DI_SicMotore08
	PLCTAG_DO_InvMotore08
	PLCTAG_DI_Al_Slittamento08
	PLCTAG_AO_SetMotore08
	PLCTAG_AI_AmpMotore08
	PLCTAG_DO_Motore09
	PLCTAG_DI_RitMotore09
	PLCTAG_DI_TermMotore09
	PLCTAG_DI_SicMotore09
	PLCTAG_DO_InvMotore09
	PLCTAG_DI_Al_Slittamento09
	PLCTAG_AO_SetMotore09
	PLCTAG_AI_AmpMotore09
	PLCTAG_DO_Motore10
	PLCTAG_DI_RitMotore10
	PLCTAG_DI_TermMotore10
	PLCTAG_DI_SicMotore10
	PLCTAG_DO_InvMotore10
	PLCTAG_DI_Al_Slittamento10
	PLCTAG_AO_SetMotore10
	PLCTAG_AI_AmpMotore10
	PLCTAG_DO_Motore11
	PLCTAG_DI_RitMotore11
	PLCTAG_DI_TermMotore11
	PLCTAG_DI_SicMotore11
	PLCTAG_DO_InvMotore11
	PLCTAG_DI_Al_Slittamento11
	PLCTAG_AO_SetMotore11
	PLCTAG_AI_AmpMotore11
	PLCTAG_DO_Motore12
	PLCTAG_DI_RitMotore12
	PLCTAG_DI_TermMotore12
	PLCTAG_DI_SicMotore12
	PLCTAG_DO_InvMotore12
	PLCTAG_DI_Al_Slittamento12
	PLCTAG_AO_SetMotore12
	PLCTAG_AI_AmpMotore12
	PLCTAG_DO_Motore13
	PLCTAG_DI_RitMotore13
	PLCTAG_DI_TermMotore13
	PLCTAG_DI_SicMotore13
	PLCTAG_DO_InvMotore13
	PLCTAG_DI_Al_Slittamento13
	PLCTAG_AO_SetMotore13
	PLCTAG_AI_AmpMotore13
	PLCTAG_DO_Motore14
	PLCTAG_DI_RitMotore14
	PLCTAG_DI_TermMotore14
	PLCTAG_DI_SicMotore14
	PLCTAG_DO_InvMotore14
	PLCTAG_DI_Al_Slittamento14
	PLCTAG_AO_SetMotore14
	PLCTAG_AI_AmpMotore14
	PLCTAG_DO_Motore15
	PLCTAG_DI_RitMotore15
	PLCTAG_DI_TermMotore15
	PLCTAG_DI_SicMotore15
	PLCTAG_DO_InvMotore15
	PLCTAG_DI_Al_Slittamento15
	PLCTAG_AO_SetMotore15
	PLCTAG_AI_AmpMotore15
	PLCTAG_DO_Motore16
	PLCTAG_DI_RitMotore16
	PLCTAG_DI_TermMotore16
	PLCTAG_DI_SicMotore16
	PLCTAG_DO_InvMotore16
	PLCTAG_DI_Al_Slittamento16
	PLCTAG_AO_SetMotore16
	PLCTAG_AI_AmpMotore16
	PLCTAG_DO_Motore17
	PLCTAG_DI_RitMotore17
	PLCTAG_DI_TermMotore17
	PLCTAG_DI_SicMotore17
	PLCTAG_DO_InvMotore17
	PLCTAG_DI_Al_Slittamento17
	PLCTAG_AO_SetMotore17
	PLCTAG_AI_Amp1Motore17
	PLCTAG_DO_Motore18
	PLCTAG_DI_RitMotore18
	PLCTAG_DI_TermMotore18
	PLCTAG_DI_SicMotore18
	PLCTAG_DO_InvMotore18
	PLCTAG_DI_Al_Slittamento18
	PLCTAG_AO_SetMotore18
	PLCTAG_AI_AmpMotore18
	PLCTAG_DO_Motore19
	PLCTAG_DI_RitMotore19
	PLCTAG_DI_TermMotore19
	PLCTAG_DI_SicMotore19
	PLCTAG_DO_InvMotore19
	PLCTAG_DI_Al_Slittamento19
	PLCTAG_AO_SetMotore19
	PLCTAG_AI_AmpMotore19
	PLCTAG_DO_Motore20
	PLCTAG_DI_RitMotore20
	PLCTAG_DI_TermMotore20
	PLCTAG_DI_SicMotore20
	PLCTAG_DO_InvMotore20
	PLCTAG_DI_Al_Slittamento20
	PLCTAG_AO_SetMotore20
	PLCTAG_AI_AmpMotore20
	PLCTAG_DO_Motore21
	PLCTAG_DI_RitMotore21
	PLCTAG_DI_TermMotore21
	PLCTAG_DI_SicMotore21
	PLCTAG_DO_InvMotore21
	PLCTAG_DI_Al_Slittamento21
	PLCTAG_AO_SetMotore21
	PLCTAG_AI_AmpMotore21
	PLCTAG_DO_Motore22
	PLCTAG_DI_RitMotore22
	PLCTAG_DI_TermMotore22
	PLCTAG_DI_SicMotore22
	PLCTAG_DO_InvMotore22
	PLCTAG_DI_Al_Slittamento22
	PLCTAG_AO_SetMotore22
	PLCTAG_AI_AmpMotore22
	PLCTAG_DO_Motore23
	PLCTAG_DI_RitMotore23
	PLCTAG_DI_TermMotore23
	PLCTAG_DI_SicMotore23
	PLCTAG_DO_InvMotore23
	PLCTAG_DI_Al_Slittamento23
	PLCTAG_AO_SetMotore23
	PLCTAG_AI_AmpMotore23
	PLCTAG_DO_Motore24
	PLCTAG_DI_RitMotore24
	PLCTAG_DI_TermMotore24
	PLCTAG_DI_SicMotore24
	PLCTAG_DO_InvMotore24
	PLCTAG_DI_Al_Slittamento24
	PLCTAG_AO_SetMotore24
	PLCTAG_AI_AmpMotore24
	PLCTAG_DO_Motore25
	PLCTAG_DI_RitMotore25
	PLCTAG_DI_TermMotore25
	PLCTAG_DI_SicMotore25
	PLCTAG_DO_InvMotore25
	PLCTAG_DI_Al_Slittamento25
	PLCTAG_AO_SetMotore25
	PLCTAG_AI_AmpMotore25
	PLCTAG_DO_Motore26
	PLCTAG_DI_RitMotore26
	PLCTAG_DI_TermMotore26
	PLCTAG_DI_SicMotore26
	PLCTAG_DO_InvMotore26
	PLCTAG_DI_Al_Slittamento26
	PLCTAG_AO_SetMotore26
	PLCTAG_AI_AmpMotore26
	PLCTAG_DO_Motore27
	PLCTAG_DI_RitMotore27
	PLCTAG_DI_TermMotore27
	PLCTAG_DI_SicMotore27
	PLCTAG_DO_InvMotore27
	PLCTAG_DI_Al_Slittamento27
	PLCTAG_AO_SetMotore27
	PLCTAG_AI_AmpMotore27
	PLCTAG_DO_Motore28
	PLCTAG_DI_RitMotore28
	PLCTAG_DI_TermMotore28
	PLCTAG_DI_SicMotore28
	PLCTAG_DO_InvMotore28
	PLCTAG_DI_Al_Slittamento28
	PLCTAG_AO_SetMotore28
	PLCTAG_AI_AmpMotore28
	PLCTAG_DO_Motore29
	PLCTAG_DI_RitMotore29
	PLCTAG_DI_TermMotore29
	PLCTAG_DI_SicMotore29
	PLCTAG_DO_InvMotore29
	PLCTAG_DI_Al_Slittamento29
	PLCTAG_AO_SetMotore29
	PLCTAG_AI_AmpMotore29
	PLCTAG_DO_Motore30
	PLCTAG_DI_RitMotore30
	PLCTAG_DI_TermMotore30
	PLCTAG_DI_SicMotore30
	PLCTAG_DO_InvMotore30
	PLCTAG_DI_Al_Slittamento30
	PLCTAG_AO_SetMotore30
	PLCTAG_AI_AmpMotore30
	PLCTAG_DO_Motore31
	PLCTAG_DI_RitMotore31
	PLCTAG_DI_TermMotore31
	PLCTAG_DI_SicMotore31
	PLCTAG_DO_InvMotore31
	PLCTAG_DI_Al_Slittamento31
	PLCTAG_AO_SetMotore31
	PLCTAG_AI_AmpMotore31
	PLCTAG_DO_Motore32
	PLCTAG_DI_RitMotore32
	PLCTAG_DI_TermMotore32
	PLCTAG_DI_SicMotore32
	PLCTAG_DO_InvMotore32
	PLCTAG_DI_Al_Slittamento32
	PLCTAG_AO_SetMotore32
	PLCTAG_AI_AmpMotore32
	PLCTAG_DO_Motore33
	PLCTAG_DI_RitMotore33
	PLCTAG_DI_TermMotore33
	PLCTAG_DI_SicMotore33
	PLCTAG_DO_InvMotore33
	PLCTAG_DI_Al_Slittamento33
	PLCTAG_AO_SetMotore33
	PLCTAG_AI_AmpMotore33
	PLCTAG_DO_Motore34
	PLCTAG_DI_RitMotore34
	PLCTAG_DI_TermMotore34
	PLCTAG_DI_SicMotore34
	PLCTAG_DO_InvMotore34
	PLCTAG_DI_Al_Slittamento34
	PLCTAG_AO_SetMotore34
	PLCTAG_AI_AmpMotore34
	PLCTAG_DO_Motore35
	PLCTAG_DI_RitMotore35
	PLCTAG_DI_TermMotore35
	PLCTAG_DI_SicMotore35
	PLCTAG_DO_InvMotore35
	PLCTAG_DI_Al_Slittamento35
	PLCTAG_AO_SetMotore35
	PLCTAG_AI_AmpMotore35
	PLCTAG_DO_Motore36
	PLCTAG_DI_RitMotore36
	PLCTAG_DI_TermMotore36
	PLCTAG_DI_SicMotore36
	PLCTAG_DO_InvMotore36
	PLCTAG_DI_Al_Slittamento36
	PLCTAG_AO_SetMotore36
	PLCTAG_AI_AmpMotore36
	PLCTAG_DO_Motore37
	PLCTAG_DI_RitMotore37
	PLCTAG_DI_TermMotore37
	PLCTAG_DI_SicMotore37
	PLCTAG_DO_InvMotore37
	PLCTAG_DI_Al_Slittamento37
	PLCTAG_AO_SetMotore37
	PLCTAG_AI_AmpMotore37
	PLCTAG_DO_Motore38
	PLCTAG_DI_RitMotore38
	PLCTAG_DI_TermMotore38
	PLCTAG_DI_SicMotore38
	PLCTAG_DO_InvMotore38
	PLCTAG_DI_Al_Slittamento38
	PLCTAG_AO_SetMotore38
	PLCTAG_AI_AmpMotore38
	PLCTAG_DO_Motore39
	PLCTAG_DI_RitMotore39
	PLCTAG_DI_TermMotore39
	PLCTAG_DI_SicMotore39
	PLCTAG_DO_InvMotore39
	PLCTAG_DI_Al_Slittamento39
	PLCTAG_AO_SetMotore39
	PLCTAG_AI_AmpMotore39
	PLCTAG_DO_Motore40
	PLCTAG_DI_RitMotore40
	PLCTAG_DI_TermMotore40
	PLCTAG_DI_SicMotore40
	PLCTAG_DO_InvMotore40
	PLCTAG_DI_Al_Slittamento40
	PLCTAG_AO_SetMotore40
	PLCTAG_AI_AmpMotore40
	PLCTAG_DO_Motore41
	PLCTAG_DI_RitMotore41
	PLCTAG_DI_TermMotore41
	PLCTAG_DI_SicMotore41
	PLCTAG_DO_InvMotore41
	PLCTAG_DI_Al_Slittamento41
	PLCTAG_AO_SetMotore41
	PLCTAG_AI_AmpMotore41
	PLCTAG_DO_Motore42
	PLCTAG_DI_RitMotore42
	PLCTAG_DI_TermMotore42
	PLCTAG_DI_SicMotore42
	PLCTAG_DO_InvMotore42
	PLCTAG_DI_Al_Slittamento42
	PLCTAG_AO_SetMotore42
	PLCTAG_AI_AmpMotore42
	PLCTAG_DO_Motore43
	PLCTAG_DI_RitMotore43
	PLCTAG_DI_TermMotore43
	PLCTAG_DI_SicMotore43
	PLCTAG_DO_InvMotore43
	PLCTAG_DI_Al_Slittamento43
	PLCTAG_AO_SetMotore43
	PLCTAG_AI_AmpMotore43
	PLCTAG_DO_Motore44
	PLCTAG_DI_RitMotore44
	PLCTAG_DI_TermMotore44
	PLCTAG_DI_SicMotore44
	PLCTAG_DO_InvMotore44
	PLCTAG_DI_Al_Slittamento44
	PLCTAG_AO_SetMotore44
	PLCTAG_AI_AmpMotore44
	PLCTAG_DO_Motore45
	PLCTAG_DI_RitMotore45
	PLCTAG_DI_TermMotore45
	PLCTAG_DI_SicMotore45
	PLCTAG_DO_InvMotore45
	PLCTAG_DI_Al_Slittamento45
	PLCTAG_AO_SetMotore45
	PLCTAG_AI_AmpMotore45
	PLCTAG_DO_Motore46
	PLCTAG_DI_RitMotore46
	PLCTAG_DI_TermMotore46
	PLCTAG_DI_SicMotore46
	PLCTAG_DO_InvMotore46
	PLCTAG_DI_Al_Slittamento46
	PLCTAG_AO_SetMotore46
	PLCTAG_AI_AmpMotore46
	PLCTAG_DO_Motore47
	PLCTAG_DI_RitMotore47
	PLCTAG_DI_TermMotore47
	PLCTAG_DI_SicMotore47
	PLCTAG_DO_InvMotore47
	PLCTAG_DI_Al_Slittamento47
	PLCTAG_AO_SetMotore47
	PLCTAG_AI_AmpMotore47
	PLCTAG_DO_Motore48
	PLCTAG_DI_RitMotore48
	PLCTAG_DI_TermMotore48
	PLCTAG_DI_SicMotore48
	PLCTAG_DO_InvMotore48
	PLCTAG_DI_Al_Slittamento48
	PLCTAG_AO_SetMotore48
	PLCTAG_AI_AmpMotore48
	PLCTAG_DO_Motore49
	PLCTAG_DI_RitMotore49
	PLCTAG_DI_TermMotore49
	PLCTAG_DI_SicMotore49
	PLCTAG_DO_InvMotore49
	PLCTAG_DI_Al_Slittamento49
	PLCTAG_AO_SetMotore49
	PLCTAG_AI_AmpMotore49
	PLCTAG_DO_Motore50
	PLCTAG_DI_RitMotore50
	PLCTAG_DI_TermMotore50
	PLCTAG_DI_SicMotore50
	PLCTAG_DO_InvMotore50
	PLCTAG_DI_Al_Slittamento50
	PLCTAG_AO_SetMotore50
	PLCTAG_AI_AmpMotore50
	PLCTAG_DO_Motore51
	PLCTAG_DI_RitMotore51
	PLCTAG_DI_TermMotore51
	PLCTAG_DI_SicMotore51
	PLCTAG_DO_InvMotore51
	PLCTAG_DI_Al_Slittamento51
	PLCTAG_AO_SetMotore51
	PLCTAG_AI_AmpMotore51
	PLCTAG_DO_Motore52
	PLCTAG_DI_RitMotore52
	PLCTAG_DI_TermMotore52
	PLCTAG_DI_SicMotore52
	PLCTAG_DO_InvMotore52
	PLCTAG_DI_Al_Slittamento52
	PLCTAG_AO_SetMotore52
	PLCTAG_AI_AmpMotore52
	PLCTAG_DO_Motore53
	PLCTAG_DI_RitMotore53
	PLCTAG_DI_TermMotore53
	PLCTAG_DI_SicMotore53
	PLCTAG_DO_InvMotore53
	PLCTAG_DI_Al_Slittamento53
	PLCTAG_AO_SetMotore53
	PLCTAG_AI_AmpMotore53
	PLCTAG_DO_Motore54
	PLCTAG_DI_RitMotore54
	PLCTAG_DI_TermMotore54
	PLCTAG_DI_SicMotore54
	PLCTAG_DO_InvMotore54
	PLCTAG_DI_Al_Slittamento54
	PLCTAG_AO_SetMotore54
	PLCTAG_AI_AmpMotore54
	PLCTAG_DO_Motore55
	PLCTAG_DI_RitMotore55
	PLCTAG_DI_TermMotore55
	PLCTAG_DI_SicMotore55
	PLCTAG_DO_InvMotore55
	PLCTAG_DI_Al_Slittamento55
	PLCTAG_AO_SetMotore55
	PLCTAG_AI_AmpMotore55
	PLCTAG_DO_Motore56
	PLCTAG_DI_RitMotore56
	PLCTAG_DI_TermMotore56
	PLCTAG_DI_SicMotore56
	PLCTAG_DO_InvMotore56
	PLCTAG_DI_Al_Slittamento56
	PLCTAG_AO_SetMotore56
	PLCTAG_AI_AmpMotore56
	PLCTAG_DO_Motore57
	PLCTAG_DI_RitMotore57
	PLCTAG_DI_TermMotore57
	PLCTAG_DI_SicMotore57
	PLCTAG_DO_InvMotore57
	PLCTAG_DI_Al_Slittamento57
	PLCTAG_AO_SetMotore57
	PLCTAG_AI_AmpMotore57
	PLCTAG_DO_Motore58
	PLCTAG_DI_RitMotore58
	PLCTAG_DI_TermMotore58
	PLCTAG_DI_SicMotore58
	PLCTAG_DO_InvMotore58
	PLCTAG_DI_Al_Slittamento58
	PLCTAG_AO_SetMotore58
	PLCTAG_AI_AmpMotore58
	PLCTAG_DO_Motore59
	PLCTAG_DI_RitMotore59
	PLCTAG_DI_TermMotore59
	PLCTAG_DI_SicMotore59
	PLCTAG_DO_InvMotore59
	PLCTAG_DI_Al_Slittamento59
	PLCTAG_AO_SetMotore59
	PLCTAG_AI_AmpMotore59
	PLCTAG_DO_Motore60
	PLCTAG_DI_RitMotore60
	PLCTAG_DI_TermMotore60
	PLCTAG_DI_SicMotore60
	PLCTAG_DO_InvMotore60
	PLCTAG_DI_Al_Slittamento60
	PLCTAG_AO_SetMotore60
	PLCTAG_AI_AmpMotore60
	PLCTAG_DO_Motore61
	PLCTAG_DI_RitMotore61
	PLCTAG_DI_TermMotore61
	PLCTAG_DI_SicMotore61
	PLCTAG_DO_InvMotore61
	PLCTAG_DI_Al_Slittamento61
	PLCTAG_AO_SetMotore61
	PLCTAG_AI_AmpMotore61
	PLCTAG_DO_Motore62
	PLCTAG_DI_RitMotore62
	PLCTAG_DI_TermMotore62
	PLCTAG_DI_SicMotore62
	PLCTAG_DO_InvMotore62
	PLCTAG_DI_Al_Slittamento62
	PLCTAG_AO_SetMotore62
	PLCTAG_AI_AmpMotore62
	PLCTAG_DO_Motore63
	PLCTAG_DI_RitMotore63
	PLCTAG_DI_TermMotore63
	PLCTAG_DI_SicMotore63
	PLCTAG_DO_InvMotore63
	PLCTAG_DI_Al_Slittamento63
	PLCTAG_AO_SetMotore63
	PLCTAG_AI_AmpMotore63
	PLCTAG_DO_Motore64
	PLCTAG_DI_RitMotore64
	PLCTAG_DI_TermMotore64
	PLCTAG_DI_SicMotore64
	PLCTAG_DO_InvMotore64
	PLCTAG_DI_Al_Slittamento64
	PLCTAG_AO_SetMotore64
	PLCTAG_AI_AmpMotore64
	PLCTAG_AI_Amp2Motore05
	PLCTAG_AI_Amp2Motore07
	PLCTAG_AI_Amp2Motore17
	PLCTAG_AI_Amp3Motore17
	PLCTAG_AI_Amp4Motore17
	PLCTAG_AI_Amp2Motore39
	PLCTAG_AI_Amp3Motore39
	PLCTAG_AI_Amp4Motore39
	PLCTAG_NM_PRED_Start_Auto
	PLCTAG_NM_PRED_Stop_Auto
	PLCTAG_NM_PRED_Auto_Man
	PLCTAG_NM_PRED_RICFUT_Inerte_Set1
	PLCTAG_NM_PRED_RICFUT_Inerte_Set2
	PLCTAG_NM_PRED_RICFUT_Inerte_Set3
	PLCTAG_NM_PRED_RICFUT_Inerte_Set4
	PLCTAG_NM_PRED_RICFUT_Inerte_Set5
	PLCTAG_NM_PRED_RICFUT_Inerte_Set6
	PLCTAG_NM_PRED_RICFUT_Inerte_Set7
	PLCTAG_NM_PRED_RICFUT_Inerte_Set8
	PLCTAG_NM_PRED_RICFUT_Inerte_Set9
	PLCTAG_NM_PRED_RICFUT_Inerte_Set10
	PLCTAG_NM_PRED_RICFUT_Inerte_Set11
	PLCTAG_NM_PRED_RICFUT_Inerte_Set12
	PLCTAG_NM_PRED_RICFUT_Ricic_Set1
	PLCTAG_NM_PRED_RICFUT_Ricic_Set2
	PLCTAG_NM_PRED_RICFUT_Ricic_Set3
	PLCTAG_NM_PRED_RICFUT_Ricic_Set4
	PLCTAG_NM_PRED_RICFUT_Ricic_Set5
	PLCTAG_NM_PRED_RICFUT_Ricic_Set6
	PLCTAG_NM_PRED_RICFUT_Ricic_Set7
	PLCTAG_NM_PRED_RICFUT_Afreddo   '20161205
	PLCTAG_NM_PRED_Lancia_Ricetta
	PLCTAG_NM_PRED_Arresta_Ricetta
	PLCTAG_NM_NC1
	PLCTAG_NM_NC2
	PLCTAG_NM_NC3
	PLCTAG_NM_NCRIC
	PLCTAG_NM_NCRICFREDDO
	PLCTAG_NM_CMD_SemiAuto_1
	PLCTAG_NM_CMD_SemiAuto_2
	PLCTAG_NM_CMD_SemiAuto_3
	PLCTAG_NM_CMD_SemiAuto_4
	PLCTAG_NM_CMD_SemiAuto_5
	PLCTAG_NM_CMD_SemiAuto_6
	PLCTAG_NM_CMD_SemiAuto_7
	PLCTAG_NM_CMD_SemiAuto_8
	PLCTAG_NM_CMD_SemiAuto_9
	PLCTAG_NM_CMD_SemiAuto_10
	PLCTAG_NM_CMD_SemiAuto_11
	PLCTAG_NM_CMD_SemiAuto_12
	PLCTAG_NM_CMD_SemiAuto_13
	PLCTAG_NM_CMD_SemiAuto_14
	PLCTAG_NM_CMD_SemiAuto_15
	PLCTAG_NM_CMD_SemiAuto_16
	PLCTAG_NM_CMD_SemiAuto_17
	PLCTAG_NM_CMD_SemiAuto_18
	PLCTAG_NM_CMD_SemiAuto_19
	PLCTAG_NM_CMD_SemiAuto_20
	PLCTAG_NM_CMD_SemiAuto_21
	PLCTAG_NM_CMD_SemiAuto_22
	PLCTAG_NM_CMD_SemiAuto_23
	PLCTAG_NM_CMD_SemiAuto_24
	PLCTAG_NM_CMD_SemiAuto_25
	PLCTAG_NM_CMD_SemiAuto_26
	PLCTAG_NM_CMD_SemiAuto_27
	PLCTAG_NM_CMD_SemiAuto_28
	PLCTAG_NM_CMD_SemiAuto_29
	PLCTAG_NM_CMD_SemiAuto_30
	PLCTAG_NM_CMD_SemiAuto_31
	PLCTAG_NM_CMD_SemiAuto_32
	PLCTAG_NM_CMD_SemiAuto_33
	PLCTAG_NM_CMD_SemiAuto_34
	PLCTAG_NM_CMD_SemiAuto_35
	PLCTAG_NM_CMD_SemiAuto_36
	PLCTAG_NM_CMD_SemiAuto_37
	PLCTAG_NM_CMD_SemiAuto_38
	PLCTAG_NM_CMD_SemiAuto_39
	PLCTAG_NM_CMD_SemiAuto_40
	PLCTAG_NM_CMD_SemiAuto_41
	PLCTAG_NM_CMD_SemiAuto_42
	PLCTAG_NM_CMD_SemiAuto_43
	PLCTAG_NM_CMD_SemiAuto_44
	PLCTAG_NM_CMD_SemiAuto_45
	PLCTAG_NM_CMD_SemiAuto_46
	PLCTAG_NM_CMD_SemiAuto_47
	PLCTAG_NM_CMD_SemiAuto_48
	PLCTAG_NM_CMD_SemiAuto_49
	PLCTAG_NM_CMD_SemiAuto_50
	PLCTAG_NM_CMD_SemiAuto_51
	PLCTAG_NM_CMD_SemiAuto_52
	PLCTAG_NM_CMD_SemiAuto_53
	PLCTAG_NM_CMD_SemiAuto_54
	PLCTAG_NM_CMD_SemiAuto_55
	PLCTAG_NM_CMD_SemiAuto_56
	PLCTAG_NM_CMD_SemiAuto_57
	PLCTAG_NM_CMD_SemiAuto_58
	PLCTAG_NM_CMD_SemiAuto_59
	PLCTAG_NM_CMD_SemiAuto_60
	PLCTAG_NM_CMD_SemiAuto_61
	PLCTAG_NM_CMD_SemiAuto_62
	PLCTAG_NM_CMD_SemiAuto_63
	PLCTAG_NM_CMD_SemiAuto_64
	PLCTAG_NM_CMD_SemiAuto_65
	PLCTAG_NM_CMD_SemiAuto_66
	PLCTAG_NM_CMD_SemiAuto_67
	PLCTAG_NM_CMD_SemiAuto_68
	PLCTAG_NM_CMD_SemiAuto_69
	PLCTAG_NM_CMD_SemiAuto_70
	PLCTAG_NM_CMD_SemiAuto_71
	PLCTAG_NM_CMD_SemiAuto_72
	PLCTAG_NM_CMD_SemiAuto_73
	PLCTAG_NM_CMD_SemiAuto_74
	PLCTAG_NM_CMD_SemiAuto_75
	PLCTAG_NM_CMD_SemiAuto_76
	PLCTAG_NM_CMD_SemiAuto_77
	PLCTAG_NM_CMD_SemiAuto_78
	PLCTAG_NM_CMD_SemiAuto_79
	PLCTAG_NM_CMD_SemiAuto_80
	PLCTAG_NM_CMD_SemiAuto_81
	PLCTAG_NM_CMD_SemiAuto_82
	PLCTAG_NM_CMD_SemiAuto_83
	PLCTAG_NM_CMD_SemiAuto_84
	PLCTAG_NM_CMD_SemiAuto_85
	PLCTAG_NM_CMD_SemiAuto_86
	PLCTAG_NM_CMD_SemiAuto_87
	PLCTAG_NM_CMD_SemiAuto_88
	PLCTAG_NM_CMD_SemiAuto_89
	PLCTAG_NM_CMD_SemiAuto_90
	PLCTAG_NM_CMD_SemiAuto_91
	PLCTAG_NM_CMD_SemiAuto_92
	PLCTAG_NM_CMD_SemiAuto_93
	PLCTAG_NM_CMD_SemiAuto_94
	PLCTAG_NM_CMD_SemiAuto_95
	PLCTAG_NM_CMD_SemiAuto_96
	PLCTAG_NM_CMD_SemiAuto_97
	PLCTAG_NM_CMD_SemiAuto_98
	PLCTAG_NM_CMD_SemiAuto_99
	PLCTAG_NM_CMD_SemiAuto_100
	PLCTAG_NM_CMD_InvSemiAuto_1
	PLCTAG_NM_CMD_InvSemiAuto_2
	PLCTAG_NM_CMD_InvSemiAuto_3
	PLCTAG_NM_CMD_InvSemiAuto_4
	PLCTAG_NM_CMD_InvSemiAuto_5
	PLCTAG_NM_CMD_InvSemiAuto_6
	PLCTAG_NM_CMD_InvSemiAuto_7
	PLCTAG_NM_CMD_InvSemiAuto_8
	PLCTAG_NM_CMD_InvSemiAuto_9
	PLCTAG_NM_CMD_InvSemiAuto_10
	PLCTAG_NM_CMD_ManutenzioneMotore
	PLCTAG_NM_F1_Gestione
	PLCTAG_NM_F2_Gestione
	PLCTAG_NM_F3_Gestione
	PLCTAG_NM_B1_Scambio
	PLCTAG_NM_B2_Scambio
	PLCTAG_NM_FORZA_PCL
	PLCTAG_NM_RicettaVagliata
	PLCTAG_NM_TestPredosatori
	PLCTAG_NM_TamburoArrestoImmediato
	PLCTAG_NM_Tamburo2ArrestoImmediato
	PLCTAG_NM_FILERIZ_AUTO_MAN
	PLCTAG_NM_FILERIZ_START_MAN
	PLCTAG_NM_FILERIZ_VEL_MAN
	PLCTAG_NM_FILERIZ_SEL_F1F2
	PLCTAG_NM_FILERIZ_PRES_OK
	PLCTAG_NM_FILLER1_EVAC_TIMEOUT
	PLCTAG_NM_FILLER1_EVAC_FORZ_FILTRODMR
	PLCTAG_NM_EV_FORZATO_AP
	PLCTAG_NM_EV_FORZATO_CH
	PLCTAG_NM_FILLER1_TSF_TIMEOUT
	PLCTAG_NM_FILLER1_FILTRODMR
	PLCTAG_NM_IN_BIT_BASSA_TEMP_BIT1
	PLCTAG_NM_IN_BIT_BIT2_IN_BLENDING
	PLCTAG_NM_IN_BIT_PES_BITUME1
	PLCTAG_NM_IN_BIT_PES_BITUME2
	PLCTAG_NM_IN_BRUC_AL_TEMP_ENT_FILTRO
	PLCTAG_NM_IN_ARRESTO_IMM
	PLCTAG_NM_Ritorno_1
	PLCTAG_NM_Ritorno_2
	PLCTAG_NM_Ritorno_3
	PLCTAG_NM_Ritorno_4
	PLCTAG_NM_Ritorno_5
	PLCTAG_NM_Ritorno_6
	PLCTAG_NM_Ritorno_7
	PLCTAG_NM_Ritorno_8
	PLCTAG_NM_Ritorno_9
	PLCTAG_NM_Ritorno_10
	PLCTAG_NM_Ritorno_11
	PLCTAG_NM_Ritorno_12
	PLCTAG_NM_Ritorno_13
	PLCTAG_NM_Ritorno_14
	PLCTAG_NM_Ritorno_15
	PLCTAG_NM_Ritorno_16
	PLCTAG_NM_Ritorno_17
	PLCTAG_NM_Ritorno_18
	PLCTAG_NM_Ritorno_19
	PLCTAG_NM_Ritorno_20
	PLCTAG_NM_Ritorno_21
	PLCTAG_NM_Ritorno_22
	PLCTAG_NM_Ritorno_23
	PLCTAG_NM_Ritorno_24
	PLCTAG_NM_Ritorno_25
	PLCTAG_NM_Ritorno_26
	PLCTAG_NM_Ritorno_27
	PLCTAG_NM_Ritorno_28
	PLCTAG_NM_Ritorno_29
	PLCTAG_NM_Ritorno_30
	PLCTAG_NM_Ritorno_31
	PLCTAG_NM_Ritorno_32
	PLCTAG_NM_Ritorno_33
	PLCTAG_NM_Ritorno_34
	PLCTAG_NM_Ritorno_35
	PLCTAG_NM_Ritorno_36
	PLCTAG_NM_Ritorno_37
	PLCTAG_NM_Ritorno_38
	PLCTAG_NM_Ritorno_39
	PLCTAG_NM_Ritorno_40
	PLCTAG_NM_Ritorno_41
	PLCTAG_NM_Ritorno_42
	PLCTAG_NM_Ritorno_43
	PLCTAG_NM_Ritorno_44
	PLCTAG_NM_Ritorno_45
	PLCTAG_NM_Ritorno_46
	PLCTAG_NM_Ritorno_47
	PLCTAG_NM_Ritorno_48
	PLCTAG_NM_Ritorno_49
	PLCTAG_NM_Ritorno_50
	PLCTAG_NM_Ritorno_51
	PLCTAG_NM_Ritorno_52
	PLCTAG_NM_Ritorno_53
	PLCTAG_NM_Ritorno_54
	PLCTAG_NM_Ritorno_55
	PLCTAG_NM_Ritorno_56
	PLCTAG_NM_Ritorno_57
	PLCTAG_NM_Ritorno_58
	PLCTAG_NM_Ritorno_59
	PLCTAG_NM_Ritorno_60
	PLCTAG_NM_Ritorno_61
	PLCTAG_NM_Ritorno_62
	PLCTAG_NM_Ritorno_63
	PLCTAG_NM_Ritorno_64
	PLCTAG_NM_Ritorno_65
	PLCTAG_NM_Ritorno_66
	PLCTAG_NM_Ritorno_67
	PLCTAG_NM_Ritorno_68
	PLCTAG_NM_Ritorno_69
	PLCTAG_NM_Ritorno_70
	PLCTAG_NM_Ritorno_71
	PLCTAG_NM_Ritorno_72
	PLCTAG_NM_Ritorno_73
	PLCTAG_NM_Ritorno_74
	PLCTAG_NM_Ritorno_75
	PLCTAG_NM_Ritorno_76
	PLCTAG_NM_Ritorno_77
	PLCTAG_NM_Ritorno_78
	PLCTAG_NM_Ritorno_79
	PLCTAG_NM_Ritorno_80
	PLCTAG_NM_Ritorno_81
	PLCTAG_NM_Ritorno_82
	PLCTAG_NM_Ritorno_83
	PLCTAG_NM_Ritorno_84
	PLCTAG_NM_Ritorno_85
	PLCTAG_NM_Ritorno_86
	PLCTAG_NM_Ritorno_87
	PLCTAG_NM_Ritorno_88
	PLCTAG_NM_Ritorno_89
	PLCTAG_NM_Ritorno_90
	PLCTAG_NM_Ritorno_91
	PLCTAG_NM_Ritorno_92
	PLCTAG_NM_Ritorno_93
	PLCTAG_NM_Ritorno_94
	PLCTAG_NM_Ritorno_95
	PLCTAG_NM_Ritorno_96
	PLCTAG_NM_Ritorno_97
	PLCTAG_NM_Ritorno_98
	PLCTAG_NM_Ritorno_99
	PLCTAG_NM_Ritorno_100
	PLCTAG_NM_RitornoIndietro_1
	PLCTAG_NM_RitornoIndietro_2
	PLCTAG_NM_RitornoIndietro_3
	PLCTAG_NM_RitornoIndietro_4
	PLCTAG_NM_RitornoIndietro_5
	PLCTAG_NM_RitornoIndietro_6
	PLCTAG_NM_RitornoIndietro_7
	PLCTAG_NM_RitornoIndietro_8
	PLCTAG_NM_RitornoIndietro_9
	PLCTAG_NM_RitornoIndietro_10
	PLCTAG_NM_RitornoIndietro_11
	PLCTAG_NM_RitornoIndietro_12
	PLCTAG_NM_RitornoIndietro_13
	PLCTAG_NM_RitornoIndietro_14
	PLCTAG_NM_RitornoIndietro_15
	PLCTAG_NM_RitornoIndietro_16
	PLCTAG_NM_RitornoIndietro_17
	PLCTAG_NM_RitornoIndietro_18
	PLCTAG_NM_RitornoIndietro_19
	PLCTAG_NM_RitornoIndietro_20
	PLCTAG_NM_RitornoIndietro_21
	PLCTAG_NM_RitornoIndietro_22
	PLCTAG_NM_RitornoIndietro_23
	PLCTAG_NM_RitornoIndietro_24
	PLCTAG_NM_RitornoIndietro_25
	PLCTAG_NM_RitornoIndietro_26
	PLCTAG_NM_RitornoIndietro_27
	PLCTAG_NM_RitornoIndietro_28
	PLCTAG_NM_RitornoIndietro_29
	PLCTAG_NM_RitornoIndietro_30
	PLCTAG_NM_RitornoIndietro_31
	PLCTAG_NM_RitornoIndietro_32
	PLCTAG_NM_RitornoIndietro_33
	PLCTAG_NM_RitornoIndietro_34
	PLCTAG_NM_RitornoIndietro_35
	PLCTAG_NM_RitornoIndietro_36
	PLCTAG_NM_RitornoIndietro_37
	PLCTAG_NM_RitornoIndietro_38
	PLCTAG_NM_RitornoIndietro_39
	PLCTAG_NM_RitornoIndietro_40
	PLCTAG_NM_RitornoIndietro_41
	PLCTAG_NM_RitornoIndietro_42
	PLCTAG_NM_RitornoIndietro_43
	PLCTAG_NM_RitornoIndietro_44
	PLCTAG_NM_RitornoIndietro_45
	PLCTAG_NM_RitornoIndietro_46
	PLCTAG_NM_RitornoIndietro_47
	PLCTAG_NM_RitornoIndietro_48
	PLCTAG_NM_RitornoIndietro_49
	PLCTAG_NM_RitornoIndietro_50
	PLCTAG_NM_RitornoIndietro_51
	PLCTAG_NM_RitornoIndietro_52
	PLCTAG_NM_RitornoIndietro_53
	PLCTAG_NM_RitornoIndietro_54
	PLCTAG_NM_RitornoIndietro_55
	PLCTAG_NM_RitornoIndietro_56
	PLCTAG_NM_RitornoIndietro_57
	PLCTAG_NM_RitornoIndietro_58
	PLCTAG_NM_RitornoIndietro_59
	PLCTAG_NM_RitornoIndietro_60
	PLCTAG_NM_RitornoIndietro_61
	PLCTAG_NM_RitornoIndietro_62
	PLCTAG_NM_RitornoIndietro_63
	PLCTAG_NM_RitornoIndietro_64
	PLCTAG_NM_RitornoIndietro_65
	PLCTAG_NM_RitornoIndietro_66
	PLCTAG_NM_RitornoIndietro_67
	PLCTAG_NM_RitornoIndietro_68
	PLCTAG_NM_RitornoIndietro_69
	PLCTAG_NM_RitornoIndietro_70
	PLCTAG_NM_RitornoIndietro_71
	PLCTAG_NM_RitornoIndietro_72
	PLCTAG_NM_RitornoIndietro_73
	PLCTAG_NM_RitornoIndietro_74
	PLCTAG_NM_RitornoIndietro_75
	PLCTAG_NM_RitornoIndietro_76
	PLCTAG_NM_RitornoIndietro_77
	PLCTAG_NM_RitornoIndietro_78
	PLCTAG_NM_RitornoIndietro_79
	PLCTAG_NM_RitornoIndietro_80
	PLCTAG_NM_RitornoIndietro_81
	PLCTAG_NM_RitornoIndietro_82
	PLCTAG_NM_RitornoIndietro_83
	PLCTAG_NM_RitornoIndietro_84
	PLCTAG_NM_RitornoIndietro_85
	PLCTAG_NM_RitornoIndietro_86
	PLCTAG_NM_RitornoIndietro_87
	PLCTAG_NM_RitornoIndietro_88
	PLCTAG_NM_RitornoIndietro_89
	PLCTAG_NM_RitornoIndietro_90
	PLCTAG_NM_RitornoIndietro_91
	PLCTAG_NM_RitornoIndietro_92
	PLCTAG_NM_RitornoIndietro_93
	PLCTAG_NM_RitornoIndietro_94
	PLCTAG_NM_RitornoIndietro_95
	PLCTAG_NM_RitornoIndietro_96
	PLCTAG_NM_RitornoIndietro_97
	PLCTAG_NM_RitornoIndietro_98
	PLCTAG_NM_RitornoIndietro_99
	PLCTAG_NM_RitornoIndietro_100
	PLCTAG_NM_ForzatoDarwin_1
	PLCTAG_NM_ForzatoDarwin_2
	PLCTAG_NM_ForzatoDarwin_3
	PLCTAG_NM_ForzatoDarwin_4
	PLCTAG_NM_ForzatoDarwin_5
	PLCTAG_NM_ForzatoDarwin_6
	PLCTAG_NM_ForzatoDarwin_7
	PLCTAG_NM_ForzatoDarwin_8
	PLCTAG_NM_ForzatoDarwin_9
	PLCTAG_NM_ForzatoDarwin_10
	PLCTAG_NM_ForzatoDarwin_11
	PLCTAG_NM_ForzatoDarwin_12
	PLCTAG_NM_ForzatoDarwin_13
	PLCTAG_NM_ForzatoDarwin_14
	PLCTAG_NM_ForzatoDarwin_15
	PLCTAG_NM_ForzatoDarwin_16
	PLCTAG_NM_ForzatoDarwin_17
	PLCTAG_NM_ForzatoDarwin_18
	PLCTAG_NM_ForzatoDarwin_19
	PLCTAG_NM_ForzatoDarwin_20
	PLCTAG_NM_ForzatoDarwin_21
	PLCTAG_NM_ForzatoDarwin_22
	PLCTAG_NM_ForzatoDarwin_23
	PLCTAG_NM_ForzatoDarwin_24
	PLCTAG_NM_ForzatoDarwin_25
	PLCTAG_NM_ForzatoDarwin_26
	PLCTAG_NM_ForzatoDarwin_27
	PLCTAG_NM_ForzatoDarwin_28
	PLCTAG_NM_ForzatoDarwin_29
	PLCTAG_NM_ForzatoDarwin_30
	PLCTAG_NM_ForzatoDarwin_31
	PLCTAG_NM_ForzatoDarwin_32
	PLCTAG_NM_ForzatoDarwin_33
	PLCTAG_NM_ForzatoDarwin_34
	PLCTAG_NM_ForzatoDarwin_35
	PLCTAG_NM_ForzatoDarwin_36
	PLCTAG_NM_ForzatoDarwin_37
	PLCTAG_NM_ForzatoDarwin_38
	PLCTAG_NM_ForzatoDarwin_39
	PLCTAG_NM_ForzatoDarwin_40
	PLCTAG_NM_ForzatoDarwin_41
	PLCTAG_NM_ForzatoDarwin_42
	PLCTAG_NM_ForzatoDarwin_43
	PLCTAG_NM_ForzatoDarwin_44
	PLCTAG_NM_ForzatoDarwin_45
	PLCTAG_NM_ForzatoDarwin_46
	PLCTAG_NM_ForzatoDarwin_47
	PLCTAG_NM_ForzatoDarwin_48
	PLCTAG_NM_ForzatoDarwin_49
	PLCTAG_NM_ForzatoDarwin_50
	PLCTAG_NM_ForzatoDarwin_51
	PLCTAG_NM_ForzatoDarwin_52
	PLCTAG_NM_ForzatoDarwin_53
	PLCTAG_NM_ForzatoDarwin_54
	PLCTAG_NM_ForzatoDarwin_55
	PLCTAG_NM_ForzatoDarwin_56
	PLCTAG_NM_ForzatoDarwin_57
	PLCTAG_NM_ForzatoDarwin_58
	PLCTAG_NM_ForzatoDarwin_59
	PLCTAG_NM_ForzatoDarwin_60
	PLCTAG_NM_ForzatoDarwin_61
	PLCTAG_NM_ForzatoDarwin_62
	PLCTAG_NM_ForzatoDarwin_63
	PLCTAG_NM_ForzatoDarwin_64
	PLCTAG_NM_ForzatoDarwin_65
	PLCTAG_NM_ForzatoDarwin_66
	PLCTAG_NM_ForzatoDarwin_67
	PLCTAG_NM_ForzatoDarwin_68
	PLCTAG_NM_ForzatoDarwin_69
	PLCTAG_NM_ForzatoDarwin_70
	PLCTAG_NM_ForzatoDarwin_71
	PLCTAG_NM_ForzatoDarwin_72
	PLCTAG_NM_ForzatoDarwin_73
	PLCTAG_NM_ForzatoDarwin_74
	PLCTAG_NM_ForzatoDarwin_75
	PLCTAG_NM_ForzatoDarwin_76
	PLCTAG_NM_ForzatoDarwin_77
	PLCTAG_NM_ForzatoDarwin_78
	PLCTAG_NM_ForzatoDarwin_79
	PLCTAG_NM_ForzatoDarwin_80
	PLCTAG_NM_ForzatoDarwin_81
	PLCTAG_NM_ForzatoDarwin_82
	PLCTAG_NM_ForzatoDarwin_83
	PLCTAG_NM_ForzatoDarwin_84
	PLCTAG_NM_ForzatoDarwin_85
	PLCTAG_NM_ForzatoDarwin_86
	PLCTAG_NM_ForzatoDarwin_87
	PLCTAG_NM_ForzatoDarwin_88
	PLCTAG_NM_ForzatoDarwin_89
	PLCTAG_NM_ForzatoDarwin_90
	PLCTAG_NM_ForzatoDarwin_91
	PLCTAG_NM_ForzatoDarwin_92
	PLCTAG_NM_ForzatoDarwin_93
	PLCTAG_NM_ForzatoDarwin_94
	PLCTAG_NM_ForzatoDarwin_95
	PLCTAG_NM_ForzatoDarwin_96
	PLCTAG_NM_ForzatoDarwin_97
	PLCTAG_NM_ForzatoDarwin_98
	PLCTAG_NM_ForzatoDarwin_99
	PLCTAG_NM_ForzatoDarwin_100
	PLCTAG_NM_AllarmeMotore_1
	PLCTAG_NM_AllarmeMotore_2
	PLCTAG_NM_AllarmeMotore_3
	PLCTAG_NM_AllarmeMotore_4
	PLCTAG_NM_AllarmeMotore_5
	PLCTAG_NM_AllarmeMotore_6
	PLCTAG_NM_AllarmeMotore_7
	PLCTAG_NM_AllarmeMotore_8
	PLCTAG_NM_AllarmeMotore_9
	PLCTAG_NM_AllarmeMotore_10
	PLCTAG_NM_AllarmeMotore_11
	PLCTAG_NM_AllarmeMotore_12
	PLCTAG_NM_AllarmeMotore_13
	PLCTAG_NM_AllarmeMotore_14
	PLCTAG_NM_AllarmeMotore_15
	PLCTAG_NM_AllarmeMotore_16
	PLCTAG_NM_AllarmeMotore_17
	PLCTAG_NM_AllarmeMotore_18
	PLCTAG_NM_AllarmeMotore_19
	PLCTAG_NM_AllarmeMotore_20
	PLCTAG_NM_AllarmeMotore_21
	PLCTAG_NM_AllarmeMotore_22
	PLCTAG_NM_AllarmeMotore_23
	PLCTAG_NM_AllarmeMotore_24
	PLCTAG_NM_AllarmeMotore_25
	PLCTAG_NM_AllarmeMotore_26
	PLCTAG_NM_AllarmeMotore_27
	PLCTAG_NM_AllarmeMotore_28
	PLCTAG_NM_AllarmeMotore_29
	PLCTAG_NM_AllarmeMotore_30
	PLCTAG_NM_AllarmeMotore_31
	PLCTAG_NM_AllarmeMotore_32
	PLCTAG_NM_AllarmeMotore_33
	PLCTAG_NM_AllarmeMotore_34
	PLCTAG_NM_AllarmeMotore_35
	PLCTAG_NM_AllarmeMotore_36
	PLCTAG_NM_AllarmeMotore_37
	PLCTAG_NM_AllarmeMotore_38
	PLCTAG_NM_AllarmeMotore_39
	PLCTAG_NM_AllarmeMotore_40
	PLCTAG_NM_AllarmeMotore_41
	PLCTAG_NM_AllarmeMotore_42
	PLCTAG_NM_AllarmeMotore_43
	PLCTAG_NM_AllarmeMotore_44
	PLCTAG_NM_AllarmeMotore_45
	PLCTAG_NM_AllarmeMotore_46
	PLCTAG_NM_AllarmeMotore_47
	PLCTAG_NM_AllarmeMotore_48
	PLCTAG_NM_AllarmeMotore_49
	PLCTAG_NM_AllarmeMotore_50
	PLCTAG_NM_AllarmeMotore_51
	PLCTAG_NM_AllarmeMotore_52
	PLCTAG_NM_AllarmeMotore_53
	PLCTAG_NM_AllarmeMotore_54
	PLCTAG_NM_AllarmeMotore_55
	PLCTAG_NM_AllarmeMotore_56
	PLCTAG_NM_AllarmeMotore_57
	PLCTAG_NM_AllarmeMotore_58
	PLCTAG_NM_AllarmeMotore_59
	PLCTAG_NM_AllarmeMotore_60
	PLCTAG_NM_AllarmeMotore_61
	PLCTAG_NM_AllarmeMotore_62
	PLCTAG_NM_AllarmeMotore_63
	PLCTAG_NM_AllarmeMotore_64
	PLCTAG_NM_AllarmeMotore_65
	PLCTAG_NM_AllarmeMotore_66
	PLCTAG_NM_AllarmeMotore_67
	PLCTAG_NM_AllarmeMotore_68
	PLCTAG_NM_AllarmeMotore_69
	PLCTAG_NM_AllarmeMotore_70
	PLCTAG_NM_AllarmeMotore_71
	PLCTAG_NM_AllarmeMotore_72
	PLCTAG_NM_AllarmeMotore_73
	PLCTAG_NM_AllarmeMotore_74
	PLCTAG_NM_AllarmeMotore_75
	PLCTAG_NM_AllarmeMotore_76
	PLCTAG_NM_AllarmeMotore_77
	PLCTAG_NM_AllarmeMotore_78
	PLCTAG_NM_AllarmeMotore_79
	PLCTAG_NM_AllarmeMotore_80
	PLCTAG_NM_AllarmeMotore_81
	PLCTAG_NM_AllarmeMotore_82
	PLCTAG_NM_AllarmeMotore_83
	PLCTAG_NM_AllarmeMotore_84
	PLCTAG_NM_AllarmeMotore_85
	PLCTAG_NM_AllarmeMotore_86
	PLCTAG_NM_AllarmeMotore_87
	PLCTAG_NM_AllarmeMotore_88
	PLCTAG_NM_AllarmeMotore_89
	PLCTAG_NM_AllarmeMotore_90
	PLCTAG_NM_AllarmeMotore_91
	PLCTAG_NM_AllarmeMotore_92
	PLCTAG_NM_AllarmeMotore_93
	PLCTAG_NM_AllarmeMotore_94
	PLCTAG_NM_AllarmeMotore_95
	PLCTAG_NM_AllarmeMotore_96
	PLCTAG_NM_AllarmeMotore_97
	PLCTAG_NM_AllarmeMotore_98
	PLCTAG_NM_AllarmeMotore_99
	PLCTAG_NM_AllarmeMotore_100
	PLCTAG_NM_MOTORI_StatoAutomatico
	PLCTAG_NM_MOTORI_StatoSemiAutomatico
	PLCTAG_NM_MOTORI_StatoManutenzione
	PLCTAG_NM_COUNTDOWN_MAX_Nv
	PLCTAG_NM_COUNTDOWN_PAUSA_Sirena
	PLCTAG_NM_COUNTDOWN_LAVORO_Sirena
	PLCTAG_NM_COUNTDOWN_MOTORE_Avviamento
	PLCTAG_NM_COUNTDOWN_MOTORE_Spegnimento
	PLCTAG_NM_OUT_ValvolaTSF
	PLCTAG_NM_OUT_Sirena
	PLCTAG_NM_OUT_SeqInCorso
	PLCTAG_NM_OUT_Ciclo_Sirena
	PLCTAG_NM_BloccoMotore_1
	PLCTAG_NM_BloccoMotore_2
	PLCTAG_NM_BloccoMotore_3
	PLCTAG_NM_BloccoMotore_4
	PLCTAG_NM_BloccoMotore_5
	PLCTAG_NM_BloccoMotore_6
	PLCTAG_NM_BloccoMotore_7
	PLCTAG_NM_BloccoMotore_8
	PLCTAG_NM_BloccoMotore_9
	PLCTAG_NM_BloccoMotore_10
	PLCTAG_NM_BloccoMotore_11
	PLCTAG_NM_BloccoMotore_12
	PLCTAG_NM_BloccoMotore_13
	PLCTAG_NM_BloccoMotore_14
	PLCTAG_NM_BloccoMotore_15
	PLCTAG_NM_BloccoMotore_16
	PLCTAG_NM_BloccoMotore_17
	PLCTAG_NM_BloccoMotore_18
	PLCTAG_NM_BloccoMotore_19
	PLCTAG_NM_BloccoMotore_20
	PLCTAG_NM_BloccoMotore_21
	PLCTAG_NM_BloccoMotore_22
	PLCTAG_NM_BloccoMotore_23
	PLCTAG_NM_BloccoMotore_24
	PLCTAG_NM_BloccoMotore_25
	PLCTAG_NM_BloccoMotore_26
	PLCTAG_NM_BloccoMotore_27
	PLCTAG_NM_BloccoMotore_28
	PLCTAG_NM_BloccoMotore_29
	PLCTAG_NM_BloccoMotore_30
	PLCTAG_NM_BloccoMotore_31
	PLCTAG_NM_BloccoMotore_32
	PLCTAG_NM_BloccoMotore_33
	PLCTAG_NM_BloccoMotore_34
	PLCTAG_NM_BloccoMotore_35
	PLCTAG_NM_BloccoMotore_36
	PLCTAG_NM_BloccoMotore_37
	PLCTAG_NM_BloccoMotore_38
	PLCTAG_NM_BloccoMotore_39
	PLCTAG_NM_BloccoMotore_40
	PLCTAG_NM_BloccoMotore_41
	PLCTAG_NM_BloccoMotore_42
	PLCTAG_NM_BloccoMotore_43
	PLCTAG_NM_BloccoMotore_44
	PLCTAG_NM_BloccoMotore_45
	PLCTAG_NM_BloccoMotore_46
	PLCTAG_NM_BloccoMotore_47
	PLCTAG_NM_BloccoMotore_48
	PLCTAG_NM_BloccoMotore_49
	PLCTAG_NM_BloccoMotore_50
	PLCTAG_NM_BloccoMotore_51
	PLCTAG_NM_BloccoMotore_52
	PLCTAG_NM_BloccoMotore_53
	PLCTAG_NM_BloccoMotore_54
	PLCTAG_NM_BloccoMotore_55
	PLCTAG_NM_BloccoMotore_56
	PLCTAG_NM_BloccoMotore_57
	PLCTAG_NM_BloccoMotore_58
	PLCTAG_NM_BloccoMotore_59
	PLCTAG_NM_BloccoMotore_60
	PLCTAG_NM_BloccoMotore_61
	PLCTAG_NM_BloccoMotore_62
	PLCTAG_NM_BloccoMotore_63
	PLCTAG_NM_BloccoMotore_64
	PLCTAG_NM_BloccoMotore_65
	PLCTAG_NM_BloccoMotore_66
	PLCTAG_NM_BloccoMotore_67
	PLCTAG_NM_BloccoMotore_68
	PLCTAG_NM_BloccoMotore_69
	PLCTAG_NM_BloccoMotore_70
	PLCTAG_NM_BloccoMotore_71
	PLCTAG_NM_BloccoMotore_72
	PLCTAG_NM_BloccoMotore_73
	PLCTAG_NM_BloccoMotore_74
	PLCTAG_NM_BloccoMotore_75
	PLCTAG_NM_BloccoMotore_76
	PLCTAG_NM_BloccoMotore_77
	PLCTAG_NM_BloccoMotore_78
	PLCTAG_NM_BloccoMotore_79
	PLCTAG_NM_BloccoMotore_80
	PLCTAG_NM_BloccoMotore_81
	PLCTAG_NM_BloccoMotore_82
	PLCTAG_NM_BloccoMotore_83
	PLCTAG_NM_BloccoMotore_84
	PLCTAG_NM_BloccoMotore_85
	PLCTAG_NM_BloccoMotore_86
	PLCTAG_NM_BloccoMotore_87
	PLCTAG_NM_BloccoMotore_88
	PLCTAG_NM_BloccoMotore_89
	PLCTAG_NM_BloccoMotore_90
	PLCTAG_NM_BloccoMotore_91
	PLCTAG_NM_BloccoMotore_92
	PLCTAG_NM_BloccoMotore_93
	PLCTAG_NM_BloccoMotore_94
	PLCTAG_NM_BloccoMotore_95
	PLCTAG_NM_BloccoMotore_96
	PLCTAG_NM_BloccoMotore_97
	PLCTAG_NM_BloccoMotore_98
	PLCTAG_NM_BloccoMotore_99
	PLCTAG_NM_BloccoMotore_100
	PLCTAG_NM_MOTORE_AvviamentoSpegnimento
	PLCTAG_NM_MOTORI_CmdAutomatico
	PLCTAG_NM_MOTORI_CmdSemiAutomatico
	PLCTAG_NM_MOTORI_CmdManutenzione
	PLCTAG_NM_MOTORI_StartSequenza
	PLCTAG_NM_MOTORI_AvviamentoRidotto
	PLCTAG_NM_MOTORI_GruppoAvviamentoRidotto
	PLCTAG_NM_MOTORI_StopSequenza
	PLCTAG_NM_MOTORI_ACK
	PLCTAG_NM_MOTORI_TrasfParam
	PLCTAG_NM_CountDown_NV
	PLCTAG_NM_Sequenze_ListaAvvCompleta_1
	PLCTAG_NM_Sequenze_ListaAvvCompleta_2
	PLCTAG_NM_Sequenze_ListaAvvCompleta_3
	PLCTAG_NM_Sequenze_ListaAvvCompleta_4
	PLCTAG_NM_Sequenze_ListaAvvCompleta_5
	PLCTAG_NM_Sequenze_ListaAvvCompleta_6
	PLCTAG_NM_Sequenze_ListaAvvCompleta_7
	PLCTAG_NM_Sequenze_ListaAvvCompleta_8
	PLCTAG_NM_Sequenze_ListaAvvCompleta_9
	PLCTAG_NM_Sequenze_ListaAvvCompleta_10
	PLCTAG_NM_Sequenze_ListaAvvCompleta_11
	PLCTAG_NM_Sequenze_ListaAvvCompleta_12
	PLCTAG_NM_Sequenze_ListaAvvCompleta_13
	PLCTAG_NM_Sequenze_ListaAvvCompleta_14
	PLCTAG_NM_Sequenze_ListaAvvCompleta_15
	PLCTAG_NM_Sequenze_ListaAvvCompleta_16
	PLCTAG_NM_Sequenze_ListaAvvCompleta_17
	PLCTAG_NM_Sequenze_ListaAvvCompleta_18
	PLCTAG_NM_Sequenze_ListaAvvCompleta_19
	PLCTAG_NM_Sequenze_ListaAvvCompleta_20
	PLCTAG_NM_Sequenze_ListaAvvCompleta_21
	PLCTAG_NM_Sequenze_ListaAvvCompleta_22
	PLCTAG_NM_Sequenze_ListaAvvCompleta_23
	PLCTAG_NM_Sequenze_ListaAvvCompleta_24
	PLCTAG_NM_Sequenze_ListaAvvCompleta_25
	PLCTAG_NM_Sequenze_ListaAvvCompleta_26
	PLCTAG_NM_Sequenze_ListaAvvCompleta_27
	PLCTAG_NM_Sequenze_ListaAvvCompleta_28
	PLCTAG_NM_Sequenze_ListaAvvCompleta_29
	PLCTAG_NM_Sequenze_ListaAvvCompleta_30
	PLCTAG_NM_Sequenze_ListaAvvCompleta_31
	PLCTAG_NM_Sequenze_ListaAvvCompleta_32
	PLCTAG_NM_Sequenze_ListaAvvCompleta_33
	PLCTAG_NM_Sequenze_ListaAvvCompleta_34
	PLCTAG_NM_Sequenze_ListaAvvCompleta_35
	PLCTAG_NM_Sequenze_ListaAvvCompleta_36
	PLCTAG_NM_Sequenze_ListaAvvCompleta_37
	PLCTAG_NM_Sequenze_ListaAvvCompleta_38
	PLCTAG_NM_Sequenze_ListaAvvCompleta_39
	PLCTAG_NM_Sequenze_ListaAvvCompleta_40
	PLCTAG_NM_Sequenze_ListaAvvCompleta_41
	PLCTAG_NM_Sequenze_ListaAvvCompleta_42
	PLCTAG_NM_Sequenze_ListaAvvCompleta_43
	PLCTAG_NM_Sequenze_ListaAvvCompleta_44
	PLCTAG_NM_Sequenze_ListaAvvCompleta_45
	PLCTAG_NM_Sequenze_ListaAvvCompleta_46
	PLCTAG_NM_Sequenze_ListaAvvCompleta_47
	PLCTAG_NM_Sequenze_ListaAvvCompleta_48
	PLCTAG_NM_Sequenze_ListaAvvCompleta_49
	PLCTAG_NM_Sequenze_ListaAvvCompleta_50
	PLCTAG_NM_Sequenze_ListaAvvCompleta_51
	PLCTAG_NM_Sequenze_ListaAvvCompleta_52
	PLCTAG_NM_Sequenze_ListaAvvCompleta_53
	PLCTAG_NM_Sequenze_ListaAvvCompleta_54
	PLCTAG_NM_Sequenze_ListaAvvCompleta_55
	PLCTAG_NM_Sequenze_ListaAvvCompleta_56
	PLCTAG_NM_Sequenze_ListaAvvCompleta_57
	PLCTAG_NM_Sequenze_ListaAvvCompleta_58
	PLCTAG_NM_Sequenze_ListaAvvCompleta_59
	PLCTAG_NM_Sequenze_ListaAvvCompleta_60
	PLCTAG_NM_Sequenze_ListaAvvCompleta_61
	PLCTAG_NM_Sequenze_ListaAvvCompleta_62
	PLCTAG_NM_Sequenze_ListaAvvCompleta_63
	PLCTAG_NM_Sequenze_ListaAvvCompleta_64
	PLCTAG_NM_Sequenze_ListaAvvCompleta_65
	PLCTAG_NM_Sequenze_ListaAvvCompleta_66
	PLCTAG_NM_Sequenze_ListaAvvCompleta_67
	PLCTAG_NM_Sequenze_ListaAvvCompleta_68
	PLCTAG_NM_Sequenze_ListaAvvCompleta_69
	PLCTAG_NM_Sequenze_ListaAvvCompleta_70
	PLCTAG_NM_Sequenze_ListaAvvCompleta_71
	PLCTAG_NM_Sequenze_ListaAvvCompleta_72
	PLCTAG_NM_Sequenze_ListaAvvCompleta_73
	PLCTAG_NM_Sequenze_ListaAvvCompleta_74
	PLCTAG_NM_Sequenze_ListaAvvCompleta_75
	PLCTAG_NM_Sequenze_ListaAvvCompleta_76
	PLCTAG_NM_Sequenze_ListaAvvCompleta_77
	PLCTAG_NM_Sequenze_ListaAvvCompleta_78
	PLCTAG_NM_Sequenze_ListaAvvCompleta_79
	PLCTAG_NM_Sequenze_ListaAvvCompleta_80
	PLCTAG_NM_Sequenze_ListaAvvCompleta_81
	PLCTAG_NM_Sequenze_ListaAvvCompleta_82
	PLCTAG_NM_Sequenze_ListaAvvCompleta_83
	PLCTAG_NM_Sequenze_ListaAvvCompleta_84
	PLCTAG_NM_Sequenze_ListaAvvCompleta_85
	PLCTAG_NM_Sequenze_ListaAvvCompleta_86
	PLCTAG_NM_Sequenze_ListaAvvCompleta_87
	PLCTAG_NM_Sequenze_ListaAvvCompleta_88
	PLCTAG_NM_Sequenze_ListaAvvCompleta_89
	PLCTAG_NM_Sequenze_ListaAvvCompleta_90
	PLCTAG_NM_Sequenze_ListaAvvCompleta_91
	PLCTAG_NM_Sequenze_ListaAvvCompleta_92
	PLCTAG_NM_Sequenze_ListaAvvCompleta_93
	PLCTAG_NM_Sequenze_ListaAvvCompleta_94
	PLCTAG_NM_Sequenze_ListaAvvCompleta_95
	PLCTAG_NM_Sequenze_ListaAvvCompleta_96
	PLCTAG_NM_Sequenze_ListaAvvCompleta_97
	PLCTAG_NM_Sequenze_ListaAvvCompleta_98
	PLCTAG_NM_Sequenze_ListaAvvCompleta_99
	PLCTAG_NM_Sequenze_ListaAvvCompleta_100
	PLCTAG_NM_Sequenze_ListaSpegnimento_1
	PLCTAG_NM_Sequenze_ListaSpegnimento_2
	PLCTAG_NM_Sequenze_ListaSpegnimento_3
	PLCTAG_NM_Sequenze_ListaSpegnimento_4
	PLCTAG_NM_Sequenze_ListaSpegnimento_5
	PLCTAG_NM_Sequenze_ListaSpegnimento_6
	PLCTAG_NM_Sequenze_ListaSpegnimento_7
	PLCTAG_NM_Sequenze_ListaSpegnimento_8
	PLCTAG_NM_Sequenze_ListaSpegnimento_9
	PLCTAG_NM_Sequenze_ListaSpegnimento_10
	PLCTAG_NM_Sequenze_ListaSpegnimento_11
	PLCTAG_NM_Sequenze_ListaSpegnimento_12
	PLCTAG_NM_Sequenze_ListaSpegnimento_13
	PLCTAG_NM_Sequenze_ListaSpegnimento_14
	PLCTAG_NM_Sequenze_ListaSpegnimento_15
	PLCTAG_NM_Sequenze_ListaSpegnimento_16
	PLCTAG_NM_Sequenze_ListaSpegnimento_17
	PLCTAG_NM_Sequenze_ListaSpegnimento_18
	PLCTAG_NM_Sequenze_ListaSpegnimento_19
	PLCTAG_NM_Sequenze_ListaSpegnimento_20
	PLCTAG_NM_Sequenze_ListaSpegnimento_21
	PLCTAG_NM_Sequenze_ListaSpegnimento_22
	PLCTAG_NM_Sequenze_ListaSpegnimento_23
	PLCTAG_NM_Sequenze_ListaSpegnimento_24
	PLCTAG_NM_Sequenze_ListaSpegnimento_25
	PLCTAG_NM_Sequenze_ListaSpegnimento_26
	PLCTAG_NM_Sequenze_ListaSpegnimento_27
	PLCTAG_NM_Sequenze_ListaSpegnimento_28
	PLCTAG_NM_Sequenze_ListaSpegnimento_29
	PLCTAG_NM_Sequenze_ListaSpegnimento_30
	PLCTAG_NM_Sequenze_ListaSpegnimento_31
	PLCTAG_NM_Sequenze_ListaSpegnimento_32
	PLCTAG_NM_Sequenze_ListaSpegnimento_33
	PLCTAG_NM_Sequenze_ListaSpegnimento_34
	PLCTAG_NM_Sequenze_ListaSpegnimento_35
	PLCTAG_NM_Sequenze_ListaSpegnimento_36
	PLCTAG_NM_Sequenze_ListaSpegnimento_37
	PLCTAG_NM_Sequenze_ListaSpegnimento_38
	PLCTAG_NM_Sequenze_ListaSpegnimento_39
	PLCTAG_NM_Sequenze_ListaSpegnimento_40
	PLCTAG_NM_Sequenze_ListaSpegnimento_41
	PLCTAG_NM_Sequenze_ListaSpegnimento_42
	PLCTAG_NM_Sequenze_ListaSpegnimento_43
	PLCTAG_NM_Sequenze_ListaSpegnimento_44
	PLCTAG_NM_Sequenze_ListaSpegnimento_45
	PLCTAG_NM_Sequenze_ListaSpegnimento_46
	PLCTAG_NM_Sequenze_ListaSpegnimento_47
	PLCTAG_NM_Sequenze_ListaSpegnimento_48
	PLCTAG_NM_Sequenze_ListaSpegnimento_49
	PLCTAG_NM_Sequenze_ListaSpegnimento_50
	PLCTAG_NM_Sequenze_ListaSpegnimento_51
	PLCTAG_NM_Sequenze_ListaSpegnimento_52
	PLCTAG_NM_Sequenze_ListaSpegnimento_53
	PLCTAG_NM_Sequenze_ListaSpegnimento_54
	PLCTAG_NM_Sequenze_ListaSpegnimento_55
	PLCTAG_NM_Sequenze_ListaSpegnimento_56
	PLCTAG_NM_Sequenze_ListaSpegnimento_57
	PLCTAG_NM_Sequenze_ListaSpegnimento_58
	PLCTAG_NM_Sequenze_ListaSpegnimento_59
	PLCTAG_NM_Sequenze_ListaSpegnimento_60
	PLCTAG_NM_Sequenze_ListaSpegnimento_61
	PLCTAG_NM_Sequenze_ListaSpegnimento_62
	PLCTAG_NM_Sequenze_ListaSpegnimento_63
	PLCTAG_NM_Sequenze_ListaSpegnimento_64
	PLCTAG_NM_Sequenze_ListaSpegnimento_65
	PLCTAG_NM_Sequenze_ListaSpegnimento_66
	PLCTAG_NM_Sequenze_ListaSpegnimento_67
	PLCTAG_NM_Sequenze_ListaSpegnimento_68
	PLCTAG_NM_Sequenze_ListaSpegnimento_69
	PLCTAG_NM_Sequenze_ListaSpegnimento_70
	PLCTAG_NM_Sequenze_ListaSpegnimento_71
	PLCTAG_NM_Sequenze_ListaSpegnimento_72
	PLCTAG_NM_Sequenze_ListaSpegnimento_73
	PLCTAG_NM_Sequenze_ListaSpegnimento_74
	PLCTAG_NM_Sequenze_ListaSpegnimento_75
	PLCTAG_NM_Sequenze_ListaSpegnimento_76
	PLCTAG_NM_Sequenze_ListaSpegnimento_77
	PLCTAG_NM_Sequenze_ListaSpegnimento_78
	PLCTAG_NM_Sequenze_ListaSpegnimento_79
	PLCTAG_NM_Sequenze_ListaSpegnimento_80
	PLCTAG_NM_Sequenze_ListaSpegnimento_81
	PLCTAG_NM_Sequenze_ListaSpegnimento_82
	PLCTAG_NM_Sequenze_ListaSpegnimento_83
	PLCTAG_NM_Sequenze_ListaSpegnimento_84
	PLCTAG_NM_Sequenze_ListaSpegnimento_85
	PLCTAG_NM_Sequenze_ListaSpegnimento_86
	PLCTAG_NM_Sequenze_ListaSpegnimento_87
	PLCTAG_NM_Sequenze_ListaSpegnimento_88
	PLCTAG_NM_Sequenze_ListaSpegnimento_89
	PLCTAG_NM_Sequenze_ListaSpegnimento_90
	PLCTAG_NM_Sequenze_ListaSpegnimento_91
	PLCTAG_NM_Sequenze_ListaSpegnimento_92
	PLCTAG_NM_Sequenze_ListaSpegnimento_93
	PLCTAG_NM_Sequenze_ListaSpegnimento_94
	PLCTAG_NM_Sequenze_ListaSpegnimento_95
	PLCTAG_NM_Sequenze_ListaSpegnimento_96
	PLCTAG_NM_Sequenze_ListaSpegnimento_97
	PLCTAG_NM_Sequenze_ListaSpegnimento_98
	PLCTAG_NM_Sequenze_ListaSpegnimento_99
	PLCTAG_NM_Sequenze_ListaSpegnimento_100
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_1
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_2
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_3
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_4
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_5
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_6
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_7
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_8
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_9
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_10
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_11
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_12
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_13
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_14
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_15
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_16
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_17
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_18
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_19
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_20
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_21
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_22
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_23
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_24
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_25
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_26
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_27
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_28
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_29
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_30
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_31
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_32
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_33
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_34
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_35
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_36
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_37
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_38
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_39
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_40
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_41
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_42
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_43
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_44
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_45
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_46
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_47
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_48
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_49
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_50
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_51
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_52
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_53
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_54
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_55
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_56
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_57
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_58
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_59
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_60
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_61
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_62
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_63
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_64
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_65
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_66
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_67
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_68
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_69
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_70
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_71
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_72
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_73
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_74
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_75
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_76
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_77
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_78
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_79
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_80
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_81
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_82
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_83
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_84
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_85
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_86
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_87
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_88
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_89
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_90
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_91
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_92
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_93
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_94
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_95
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_96
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_97
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_98
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_99
	PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_100
	PLCTAG_NM_SIRENA_Abilitazione
	PLCTAG_NM_SIRENA_Tintervento
	PLCTAG_NM_SIRENA_Tlavoro
	PLCTAG_NM_SIRENA_Tpausa
	PLCTAG_NM_NV_Timeout
	PLCTAG_NM_NV_TipoLiv
	PLCTAG_NM_NV_Anal_MinIN
	PLCTAG_NM_NV_Anal_MaxIN
	PLCTAG_NM_NV_Anal_MinOUT
	PLCTAG_NM_NV_Anal_MaxOUT
	PLCTAG_NM_NV_LivelloAnalMax
	PLCTAG_NM_RIF_Timeout    '20161129
	PLCTAG_NM_FILLER_ElevatoreF2SuF1
	PLCTAG_NM_FILLER_ElevatoreF2SuF3
	PLCTAG_NM_FILLER_InclusioneF2
	PLCTAG_NM_FILLER_InclusioneF3
	PLCTAG_NM_FILLER_ModTopTowerF1
	PLCTAG_NM_FILLER_ModTopTowerF2
	PLCTAG_NM_FILLER_ModTopTowerF3   '20151218
	PLCTAG_NM_FILLER_LivEsterni
	PLCTAG_NM_FILLER_TramTamp_F2
	PLCTAG_NM_FILLER_EvacSiloFiller1 '20161122
	PLCTAG_NM_BITUME_Bit_InBlending
	PLCTAG_NM_BITUME_AvvioPCLConDosaggio
	PLCTAG_NM_BITUME_AvvioPCL2ConDosaggio
	PLCTAG_NM_FILLERIZZAZIONE_SogliaMinima
	PLCTAG_NM_FILLERIZZAZIONE_IsterersiMinDep
	PLCTAG_NM_DEFLETTORI_AbilitaDefAnelloElev
	PLCTAG_NM_ELEVCALDO_AbilitaDefAnelloRif
	PLCTAG_NM_ELEVCALDO_AbilitaDefMod
	PLCTAG_NM_BRUCIATORE1_TipoCombGas
	PLCTAG_NM_BRUCIATORE2_TipoCombGas
	PLCTAG_NM_BRUCIATORE1_InclAvvCaldo
	PLCTAG_NM_BRUCIATORE2_InclAvvCaldo
	PLCTAG_NM_BRUCIATORE1_TipoCombOlio
	PLCTAG_NM_BRUCIATORE2_TipoCombOlio
	PLCTAG_NM_NASTRITimeoutNC
	PLCTAG_NM_NASTRITimeoutNRicF
	PLCTAG_NM_NASTRITimeoutNRicC
	PLCTAG_NM_ParametriOK
	PLCTAG_NM_AccesoForzatoPLC_1
	PLCTAG_NM_AccesoForzatoPLC_2
	PLCTAG_NM_AccesoForzatoPLC_3
	PLCTAG_NM_AccesoForzatoPLC_4
	PLCTAG_NM_AccesoForzatoPLC_5
	PLCTAG_NM_AccesoForzatoPLC_6
	PLCTAG_NM_AccesoForzatoPLC_7
	PLCTAG_NM_AccesoForzatoPLC_8
	PLCTAG_NM_AccesoForzatoPLC_9
	PLCTAG_NM_AccesoForzatoPLC_10
	PLCTAG_NM_AccesoForzatoPLC_11
	PLCTAG_NM_AccesoForzatoPLC_12
	PLCTAG_NM_AccesoForzatoPLC_13
	PLCTAG_NM_AccesoForzatoPLC_14
	PLCTAG_NM_AccesoForzatoPLC_15
	PLCTAG_NM_AccesoForzatoPLC_16
	PLCTAG_NM_AccesoForzatoPLC_17
	PLCTAG_NM_AccesoForzatoPLC_18
	PLCTAG_NM_AccesoForzatoPLC_19
	PLCTAG_NM_AccesoForzatoPLC_20
	PLCTAG_NM_AccesoForzatoPLC_21
	PLCTAG_NM_AccesoForzatoPLC_22
	PLCTAG_NM_AccesoForzatoPLC_23
	PLCTAG_NM_AccesoForzatoPLC_24
	PLCTAG_NM_AccesoForzatoPLC_25
	PLCTAG_NM_AccesoForzatoPLC_26
	PLCTAG_NM_AccesoForzatoPLC_27
	PLCTAG_NM_AccesoForzatoPLC_28
	PLCTAG_NM_AccesoForzatoPLC_29
	PLCTAG_NM_AccesoForzatoPLC_30
	PLCTAG_NM_AccesoForzatoPLC_31
	PLCTAG_NM_AccesoForzatoPLC_32
	PLCTAG_NM_AccesoForzatoPLC_33
	PLCTAG_NM_AccesoForzatoPLC_34
	PLCTAG_NM_AccesoForzatoPLC_35
	PLCTAG_NM_AccesoForzatoPLC_36
	PLCTAG_NM_AccesoForzatoPLC_37
	PLCTAG_NM_AccesoForzatoPLC_38
	PLCTAG_NM_AccesoForzatoPLC_39
	PLCTAG_NM_AccesoForzatoPLC_40
	PLCTAG_NM_AccesoForzatoPLC_41
	PLCTAG_NM_AccesoForzatoPLC_42
	PLCTAG_NM_AccesoForzatoPLC_43
	PLCTAG_NM_AccesoForzatoPLC_44
	PLCTAG_NM_AccesoForzatoPLC_45
	PLCTAG_NM_AccesoForzatoPLC_46
	PLCTAG_NM_AccesoForzatoPLC_47
	PLCTAG_NM_AccesoForzatoPLC_48
	PLCTAG_NM_AccesoForzatoPLC_49
	PLCTAG_NM_AccesoForzatoPLC_50
	PLCTAG_NM_AccesoForzatoPLC_51
	PLCTAG_NM_AccesoForzatoPLC_52
	PLCTAG_NM_AccesoForzatoPLC_53
	PLCTAG_NM_AccesoForzatoPLC_54
	PLCTAG_NM_AccesoForzatoPLC_55
	PLCTAG_NM_AccesoForzatoPLC_56
	PLCTAG_NM_AccesoForzatoPLC_57
	PLCTAG_NM_AccesoForzatoPLC_58
	PLCTAG_NM_AccesoForzatoPLC_59
	PLCTAG_NM_AccesoForzatoPLC_60
	PLCTAG_NM_AccesoForzatoPLC_61
	PLCTAG_NM_AccesoForzatoPLC_62
	PLCTAG_NM_AccesoForzatoPLC_63
	PLCTAG_NM_AccesoForzatoPLC_64
	PLCTAG_NM_AccesoForzatoPLC_65
	PLCTAG_NM_AccesoForzatoPLC_66
	PLCTAG_NM_AccesoForzatoPLC_67
	PLCTAG_NM_AccesoForzatoPLC_68
	PLCTAG_NM_AccesoForzatoPLC_69
	PLCTAG_NM_AccesoForzatoPLC_70
	PLCTAG_NM_AccesoForzatoPLC_71
	PLCTAG_NM_AccesoForzatoPLC_72
	PLCTAG_NM_AccesoForzatoPLC_73
	PLCTAG_NM_AccesoForzatoPLC_74
	PLCTAG_NM_AccesoForzatoPLC_75
	PLCTAG_NM_AccesoForzatoPLC_76
	PLCTAG_NM_AccesoForzatoPLC_77
	PLCTAG_NM_AccesoForzatoPLC_78
	PLCTAG_NM_AccesoForzatoPLC_79
	PLCTAG_NM_AccesoForzatoPLC_80
	PLCTAG_NM_AccesoForzatoPLC_81
	PLCTAG_NM_AccesoForzatoPLC_82
	PLCTAG_NM_AccesoForzatoPLC_83
	PLCTAG_NM_AccesoForzatoPLC_84
	PLCTAG_NM_AccesoForzatoPLC_85
	PLCTAG_NM_AccesoForzatoPLC_86
	PLCTAG_NM_AccesoForzatoPLC_87
	PLCTAG_NM_AccesoForzatoPLC_88
	PLCTAG_NM_AccesoForzatoPLC_89
	PLCTAG_NM_AccesoForzatoPLC_90
	PLCTAG_NM_AccesoForzatoPLC_91
	PLCTAG_NM_AccesoForzatoPLC_92
	PLCTAG_NM_AccesoForzatoPLC_93
	PLCTAG_NM_AccesoForzatoPLC_94
	PLCTAG_NM_AccesoForzatoPLC_95
	PLCTAG_NM_AccesoForzatoPLC_96
	PLCTAG_NM_AccesoForzatoPLC_97
	PLCTAG_NM_AccesoForzatoPLC_98
	PLCTAG_NM_AccesoForzatoPLC_99
	PLCTAG_NM_AccesoForzatoPLC_100
	PLCTAG_NM_SpentoForzatoPLC_1
	PLCTAG_NM_SpentoForzatoPLC_2
	PLCTAG_NM_SpentoForzatoPLC_3
	PLCTAG_NM_SpentoForzatoPLC_4
	PLCTAG_NM_SpentoForzatoPLC_5
	PLCTAG_NM_SpentoForzatoPLC_6
	PLCTAG_NM_SpentoForzatoPLC_7
	PLCTAG_NM_SpentoForzatoPLC_8
	PLCTAG_NM_SpentoForzatoPLC_9
	PLCTAG_NM_SpentoForzatoPLC_10
	PLCTAG_NM_SpentoForzatoPLC_11
	PLCTAG_NM_SpentoForzatoPLC_12
	PLCTAG_NM_SpentoForzatoPLC_13
	PLCTAG_NM_SpentoForzatoPLC_14
	PLCTAG_NM_SpentoForzatoPLC_15
	PLCTAG_NM_SpentoForzatoPLC_16
	PLCTAG_NM_SpentoForzatoPLC_17
	PLCTAG_NM_SpentoForzatoPLC_18
	PLCTAG_NM_SpentoForzatoPLC_19
	PLCTAG_NM_SpentoForzatoPLC_20
	PLCTAG_NM_SpentoForzatoPLC_21
	PLCTAG_NM_SpentoForzatoPLC_22
	PLCTAG_NM_SpentoForzatoPLC_23
	PLCTAG_NM_SpentoForzatoPLC_24
	PLCTAG_NM_SpentoForzatoPLC_25
	PLCTAG_NM_SpentoForzatoPLC_26
	PLCTAG_NM_SpentoForzatoPLC_27
	PLCTAG_NM_SpentoForzatoPLC_28
	PLCTAG_NM_SpentoForzatoPLC_29
	PLCTAG_NM_SpentoForzatoPLC_30
	PLCTAG_NM_SpentoForzatoPLC_31
	PLCTAG_NM_SpentoForzatoPLC_32
	PLCTAG_NM_SpentoForzatoPLC_33
	PLCTAG_NM_SpentoForzatoPLC_34
	PLCTAG_NM_SpentoForzatoPLC_35
	PLCTAG_NM_SpentoForzatoPLC_36
	PLCTAG_NM_SpentoForzatoPLC_37
	PLCTAG_NM_SpentoForzatoPLC_38
	PLCTAG_NM_SpentoForzatoPLC_39
	PLCTAG_NM_SpentoForzatoPLC_40
	PLCTAG_NM_SpentoForzatoPLC_41
	PLCTAG_NM_SpentoForzatoPLC_42
	PLCTAG_NM_SpentoForzatoPLC_43
	PLCTAG_NM_SpentoForzatoPLC_44
	PLCTAG_NM_SpentoForzatoPLC_45
	PLCTAG_NM_SpentoForzatoPLC_46
	PLCTAG_NM_SpentoForzatoPLC_47
	PLCTAG_NM_SpentoForzatoPLC_48
	PLCTAG_NM_SpentoForzatoPLC_49
	PLCTAG_NM_SpentoForzatoPLC_50
	PLCTAG_NM_SpentoForzatoPLC_51
	PLCTAG_NM_SpentoForzatoPLC_52
	PLCTAG_NM_SpentoForzatoPLC_53
	PLCTAG_NM_SpentoForzatoPLC_54
	PLCTAG_NM_SpentoForzatoPLC_55
	PLCTAG_NM_SpentoForzatoPLC_56
	PLCTAG_NM_SpentoForzatoPLC_57
	PLCTAG_NM_SpentoForzatoPLC_58
	PLCTAG_NM_SpentoForzatoPLC_59
	PLCTAG_NM_SpentoForzatoPLC_60
	PLCTAG_NM_SpentoForzatoPLC_61
	PLCTAG_NM_SpentoForzatoPLC_62
	PLCTAG_NM_SpentoForzatoPLC_63
	PLCTAG_NM_SpentoForzatoPLC_64
	PLCTAG_NM_SpentoForzatoPLC_65
	PLCTAG_NM_SpentoForzatoPLC_66
	PLCTAG_NM_SpentoForzatoPLC_67
	PLCTAG_NM_SpentoForzatoPLC_68
	PLCTAG_NM_SpentoForzatoPLC_69
	PLCTAG_NM_SpentoForzatoPLC_70
	PLCTAG_NM_SpentoForzatoPLC_71
	PLCTAG_NM_SpentoForzatoPLC_72
	PLCTAG_NM_SpentoForzatoPLC_73
	PLCTAG_NM_SpentoForzatoPLC_74
	PLCTAG_NM_SpentoForzatoPLC_75
	PLCTAG_NM_SpentoForzatoPLC_76
	PLCTAG_NM_SpentoForzatoPLC_77
	PLCTAG_NM_SpentoForzatoPLC_78
	PLCTAG_NM_SpentoForzatoPLC_79
	PLCTAG_NM_SpentoForzatoPLC_80
	PLCTAG_NM_SpentoForzatoPLC_81
	PLCTAG_NM_SpentoForzatoPLC_82
	PLCTAG_NM_SpentoForzatoPLC_83
	PLCTAG_NM_SpentoForzatoPLC_84
	PLCTAG_NM_SpentoForzatoPLC_85
	PLCTAG_NM_SpentoForzatoPLC_86
	PLCTAG_NM_SpentoForzatoPLC_87
	PLCTAG_NM_SpentoForzatoPLC_88
	PLCTAG_NM_SpentoForzatoPLC_89
	PLCTAG_NM_SpentoForzatoPLC_90
	PLCTAG_NM_SpentoForzatoPLC_91
	PLCTAG_NM_SpentoForzatoPLC_92
	PLCTAG_NM_SpentoForzatoPLC_93
	PLCTAG_NM_SpentoForzatoPLC_94
	PLCTAG_NM_SpentoForzatoPLC_95
	PLCTAG_NM_SpentoForzatoPLC_96
	PLCTAG_NM_SpentoForzatoPLC_97
	PLCTAG_NM_SpentoForzatoPLC_98
	PLCTAG_NM_SpentoForzatoPLC_99
	PLCTAG_NM_SpentoForzatoPLC_100
	PLCTAG_NM_OUT_Blocca_Scar_F1
	PLCTAG_NM_OUT_Blocca_Scar_F2
	PLCTAG_NM_OUT_PrenotaAvvCaldo
	PLCTAG_NM_IN_START_BRUC1
	PLCTAG_NM_IN_START_BRUC2
	PLCTAG_NM_IN_START_RID_BRUC1
	PLCTAG_NM_IN_START_RID_BRUC2
	PLCTAG_NM_IN_START_STOPBRUC1
	PLCTAG_NM_IN_START_STOPBRUC2
	PLCTAG_NM_MOTORE1_Presente
	PLCTAG_NM_MOTORE1_UscitaInvertita
	PLCTAG_NM_MOTORE1_RitornoInvertito
	PLCTAG_NM_MOTORE1_TipoInversione
	PLCTAG_NM_MOTORE1_IO_InverterPresente
	PLCTAG_NM_MOTORE1_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE1_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE1_Esclusioni_Uscita
	PLCTAG_NM_MOTORE1_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE1_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE1_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE1_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE1_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE1_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE1_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE1_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE1_Timeout_Avvio
	PLCTAG_NM_MOTORE1_Timeout_Arresto
	PLCTAG_NM_MOTORE1_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE1_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE1_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE1_Antislittamento_Presente
	PLCTAG_NM_MOTORE1_Antislittamento_Tempo
	PLCTAG_NM_MOTORE1_Amperometri_Presente
	PLCTAG_NM_MOTORE1_Amperometri_LimMin
	PLCTAG_NM_MOTORE1_Amperometri_LimMax
	PLCTAG_NM_MOTORE1_Amperometri_MaxOut
	PLCTAG_NM_MOTORE2_Presente
	PLCTAG_NM_MOTORE2_UscitaInvertita
	PLCTAG_NM_MOTORE2_RitornoInvertito
	PLCTAG_NM_MOTORE2_TipoInversione
	PLCTAG_NM_MOTORE2_IO_InverterPresente
	PLCTAG_NM_MOTORE2_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE2_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE2_Esclusioni_Uscita
	PLCTAG_NM_MOTORE2_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE2_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE2_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE2_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE2_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE2_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE2_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE2_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE2_Timeout_Avvio
	PLCTAG_NM_MOTORE2_Timeout_Arresto
	PLCTAG_NM_MOTORE2_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE2_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE2_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE2_Antislittamento_Presente
	PLCTAG_NM_MOTORE2_Antislittamento_Tempo
	PLCTAG_NM_MOTORE2_Amperometri_Presente
	PLCTAG_NM_MOTORE2_Amperometri_LimMin
	PLCTAG_NM_MOTORE2_Amperometri_LimMax
	PLCTAG_NM_MOTORE2_Amperometri_MaxOut
	PLCTAG_NM_MOTORE3_Presente
	PLCTAG_NM_MOTORE3_UscitaInvertita
	PLCTAG_NM_MOTORE3_RitornoInvertito
	PLCTAG_NM_MOTORE3_TipoInversione
	PLCTAG_NM_MOTORE3_IO_InverterPresente
	PLCTAG_NM_MOTORE3_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE3_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE3_Esclusioni_Uscita
	PLCTAG_NM_MOTORE3_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE3_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE3_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE3_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE3_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE3_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE3_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE3_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE3_Timeout_Avvio
	PLCTAG_NM_MOTORE3_Timeout_Arresto
	PLCTAG_NM_MOTORE3_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE3_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE3_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE3_Antislittamento_Presente
	PLCTAG_NM_MOTORE3_Antislittamento_Tempo
	PLCTAG_NM_MOTORE3_Amperometri_Presente
	PLCTAG_NM_MOTORE3_Amperometri_LimMin
	PLCTAG_NM_MOTORE3_Amperometri_LimMax
	PLCTAG_NM_MOTORE3_Amperometri_MaxOut
	PLCTAG_NM_MOTORE4_Presente
	PLCTAG_NM_MOTORE4_UscitaInvertita
	PLCTAG_NM_MOTORE4_RitornoInvertito
	PLCTAG_NM_MOTORE4_TipoInversione
	PLCTAG_NM_MOTORE4_IO_InverterPresente
	PLCTAG_NM_MOTORE4_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE4_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE4_Esclusioni_Uscita
	PLCTAG_NM_MOTORE4_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE4_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE4_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE4_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE4_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE4_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE4_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE4_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE4_Timeout_Avvio
	PLCTAG_NM_MOTORE4_Timeout_Arresto
	PLCTAG_NM_MOTORE4_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE4_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE4_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE4_Antislittamento_Presente
	PLCTAG_NM_MOTORE4_Antislittamento_Tempo
	PLCTAG_NM_MOTORE4_Amperometri_Presente
	PLCTAG_NM_MOTORE4_Amperometri_LimMin
	PLCTAG_NM_MOTORE4_Amperometri_LimMax
	PLCTAG_NM_MOTORE4_Amperometri_MaxOut
	PLCTAG_NM_MOTORE5_Presente
	PLCTAG_NM_MOTORE5_UscitaInvertita
	PLCTAG_NM_MOTORE5_RitornoInvertito
	PLCTAG_NM_MOTORE5_TipoInversione
	PLCTAG_NM_MOTORE5_IO_InverterPresente
	PLCTAG_NM_MOTORE5_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE5_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE5_Esclusioni_Uscita
	PLCTAG_NM_MOTORE5_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE5_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE5_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE5_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE5_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE5_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE5_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE5_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE5_Timeout_Avvio
	PLCTAG_NM_MOTORE5_Timeout_Arresto
	PLCTAG_NM_MOTORE5_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE5_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE5_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE5_Antislittamento_Presente
	PLCTAG_NM_MOTORE5_Antislittamento_Tempo
	PLCTAG_NM_MOTORE5_Amperometri_Presente
	PLCTAG_NM_MOTORE5_Amperometri_LimMin
	PLCTAG_NM_MOTORE5_Amperometri_LimMax
	PLCTAG_NM_MOTORE5_Amperometri_MaxOut
	PLCTAG_NM_MOTORE6_Presente
	PLCTAG_NM_MOTORE6_UscitaInvertita
	PLCTAG_NM_MOTORE6_RitornoInvertito
	PLCTAG_NM_MOTORE6_TipoInversione
	PLCTAG_NM_MOTORE6_IO_InverterPresente
	PLCTAG_NM_MOTORE6_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE6_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE6_Esclusioni_Uscita
	PLCTAG_NM_MOTORE6_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE6_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE6_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE6_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE6_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE6_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE6_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE6_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE6_Timeout_Avvio
	PLCTAG_NM_MOTORE6_Timeout_Arresto
	PLCTAG_NM_MOTORE6_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE6_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE6_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE6_Antislittamento_Presente
	PLCTAG_NM_MOTORE6_Antislittamento_Tempo
	PLCTAG_NM_MOTORE6_Amperometri_Presente
	PLCTAG_NM_MOTORE6_Amperometri_LimMin
	PLCTAG_NM_MOTORE6_Amperometri_LimMax
	PLCTAG_NM_MOTORE6_Amperometri_MaxOut
	PLCTAG_NM_MOTORE7_Presente
	PLCTAG_NM_MOTORE7_UscitaInvertita
	PLCTAG_NM_MOTORE7_RitornoInvertito
	PLCTAG_NM_MOTORE7_TipoInversione
	PLCTAG_NM_MOTORE7_IO_InverterPresente
	PLCTAG_NM_MOTORE7_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE7_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE7_Esclusioni_Uscita
	PLCTAG_NM_MOTORE7_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE7_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE7_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE7_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE7_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE7_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE7_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE7_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE7_Timeout_Avvio
	PLCTAG_NM_MOTORE7_Timeout_Arresto
	PLCTAG_NM_MOTORE7_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE7_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE7_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE7_Antislittamento_Presente
	PLCTAG_NM_MOTORE7_Antislittamento_Tempo
	PLCTAG_NM_MOTORE7_Amperometri_Presente
	PLCTAG_NM_MOTORE7_Amperometri_LimMin
	PLCTAG_NM_MOTORE7_Amperometri_LimMax
	PLCTAG_NM_MOTORE7_Amperometri_MaxOut
	PLCTAG_NM_MOTORE8_Presente
	PLCTAG_NM_MOTORE8_UscitaInvertita
	PLCTAG_NM_MOTORE8_RitornoInvertito
	PLCTAG_NM_MOTORE8_TipoInversione
	PLCTAG_NM_MOTORE8_IO_InverterPresente
	PLCTAG_NM_MOTORE8_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE8_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE8_Esclusioni_Uscita
	PLCTAG_NM_MOTORE8_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE8_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE8_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE8_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE8_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE8_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE8_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE8_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE8_Timeout_Avvio
	PLCTAG_NM_MOTORE8_Timeout_Arresto
	PLCTAG_NM_MOTORE8_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE8_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE8_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE8_Antislittamento_Presente
	PLCTAG_NM_MOTORE8_Antislittamento_Tempo
	PLCTAG_NM_MOTORE8_Amperometri_Presente
	PLCTAG_NM_MOTORE8_Amperometri_LimMin
	PLCTAG_NM_MOTORE8_Amperometri_LimMax
	PLCTAG_NM_MOTORE8_Amperometri_MaxOut
	PLCTAG_NM_MOTORE9_Presente
	PLCTAG_NM_MOTORE9_UscitaInvertita
	PLCTAG_NM_MOTORE9_RitornoInvertito
	PLCTAG_NM_MOTORE9_TipoInversione
	PLCTAG_NM_MOTORE9_IO_InverterPresente
	PLCTAG_NM_MOTORE9_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE9_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE9_Esclusioni_Uscita
	PLCTAG_NM_MOTORE9_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE9_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE9_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE9_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE9_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE9_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE9_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE9_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE9_Timeout_Avvio
	PLCTAG_NM_MOTORE9_Timeout_Arresto
	PLCTAG_NM_MOTORE9_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE9_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE9_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE9_Antislittamento_Presente
	PLCTAG_NM_MOTORE9_Antislittamento_Tempo
	PLCTAG_NM_MOTORE9_Amperometri_Presente
	PLCTAG_NM_MOTORE9_Amperometri_LimMin
	PLCTAG_NM_MOTORE9_Amperometri_LimMax
	PLCTAG_NM_MOTORE9_Amperometri_MaxOut
	PLCTAG_NM_MOTORE10_Presente
	PLCTAG_NM_MOTORE10_UscitaInvertita
	PLCTAG_NM_MOTORE10_RitornoInvertito
	PLCTAG_NM_MOTORE10_TipoInversione
	PLCTAG_NM_MOTORE10_IO_InverterPresente
	PLCTAG_NM_MOTORE10_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE10_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE10_Esclusioni_Uscita
	PLCTAG_NM_MOTORE10_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE10_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE10_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE10_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE10_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE10_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE10_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE10_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE10_Timeout_Avvio
	PLCTAG_NM_MOTORE10_Timeout_Arresto
	PLCTAG_NM_MOTORE10_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE10_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE10_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE10_Antislittamento_Presente
	PLCTAG_NM_MOTORE10_Antislittamento_Tempo
	PLCTAG_NM_MOTORE10_Amperometri_Presente
	PLCTAG_NM_MOTORE10_Amperometri_LimMin
	PLCTAG_NM_MOTORE10_Amperometri_LimMax
	PLCTAG_NM_MOTORE10_Amperometri_MaxOut
	PLCTAG_NM_MOTORE11_Presente
	PLCTAG_NM_MOTORE11_UscitaInvertita
	PLCTAG_NM_MOTORE11_RitornoInvertito
	PLCTAG_NM_MOTORE11_TipoInversione
	PLCTAG_NM_MOTORE11_IO_InverterPresente
	PLCTAG_NM_MOTORE11_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE11_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE11_Esclusioni_Uscita
	PLCTAG_NM_MOTORE11_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE11_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE11_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE11_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE11_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE11_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE11_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE11_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE11_Timeout_Avvio
	PLCTAG_NM_MOTORE11_Timeout_Arresto
	PLCTAG_NM_MOTORE11_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE11_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE11_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE11_Antislittamento_Presente
	PLCTAG_NM_MOTORE11_Antislittamento_Tempo
	PLCTAG_NM_MOTORE11_Amperometri_Presente
	PLCTAG_NM_MOTORE11_Amperometri_LimMin
	PLCTAG_NM_MOTORE11_Amperometri_LimMax
	PLCTAG_NM_MOTORE11_Amperometri_MaxOut
	PLCTAG_NM_MOTORE12_Presente
	PLCTAG_NM_MOTORE12_UscitaInvertita
	PLCTAG_NM_MOTORE12_RitornoInvertito
	PLCTAG_NM_MOTORE12_TipoInversione
	PLCTAG_NM_MOTORE12_IO_InverterPresente
	PLCTAG_NM_MOTORE12_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE12_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE12_Esclusioni_Uscita
	PLCTAG_NM_MOTORE12_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE12_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE12_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE12_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE12_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE12_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE12_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE12_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE12_Timeout_Avvio
	PLCTAG_NM_MOTORE12_Timeout_Arresto
	PLCTAG_NM_MOTORE12_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE12_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE12_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE12_Antislittamento_Presente
	PLCTAG_NM_MOTORE12_Antislittamento_Tempo
	PLCTAG_NM_MOTORE12_Amperometri_Presente
	PLCTAG_NM_MOTORE12_Amperometri_LimMin
	PLCTAG_NM_MOTORE12_Amperometri_LimMax
	PLCTAG_NM_MOTORE12_Amperometri_MaxOut
	PLCTAG_NM_MOTORE13_Presente
	PLCTAG_NM_MOTORE13_UscitaInvertita
	PLCTAG_NM_MOTORE13_RitornoInvertito
	PLCTAG_NM_MOTORE13_TipoInversione
	PLCTAG_NM_MOTORE13_IO_InverterPresente
	PLCTAG_NM_MOTORE13_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE13_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE13_Esclusioni_Uscita
	PLCTAG_NM_MOTORE13_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE13_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE13_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE13_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE13_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE13_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE13_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE13_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE13_Timeout_Avvio
	PLCTAG_NM_MOTORE13_Timeout_Arresto
	PLCTAG_NM_MOTORE13_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE13_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE13_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE13_Antislittamento_Presente
	PLCTAG_NM_MOTORE13_Antislittamento_Tempo
	PLCTAG_NM_MOTORE13_Amperometri_Presente
	PLCTAG_NM_MOTORE13_Amperometri_LimMin
	PLCTAG_NM_MOTORE13_Amperometri_LimMax
	PLCTAG_NM_MOTORE13_Amperometri_MaxOut
	PLCTAG_NM_MOTORE14_Presente
	PLCTAG_NM_MOTORE14_UscitaInvertita
	PLCTAG_NM_MOTORE14_RitornoInvertito
	PLCTAG_NM_MOTORE14_TipoInversione
	PLCTAG_NM_MOTORE14_IO_InverterPresente
	PLCTAG_NM_MOTORE14_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE14_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE14_Esclusioni_Uscita
	PLCTAG_NM_MOTORE14_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE14_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE14_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE14_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE14_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE14_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE14_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE14_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE14_Timeout_Avvio
	PLCTAG_NM_MOTORE14_Timeout_Arresto
	PLCTAG_NM_MOTORE14_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE14_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE14_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE14_Antislittamento_Presente
	PLCTAG_NM_MOTORE14_Antislittamento_Tempo
	PLCTAG_NM_MOTORE14_Amperometri_Presente
	PLCTAG_NM_MOTORE14_Amperometri_LimMin
	PLCTAG_NM_MOTORE14_Amperometri_LimMax
	PLCTAG_NM_MOTORE14_Amperometri_MaxOut
	PLCTAG_NM_MOTORE15_Presente
	PLCTAG_NM_MOTORE15_UscitaInvertita
	PLCTAG_NM_MOTORE15_RitornoInvertito
	PLCTAG_NM_MOTORE15_TipoInversione
	PLCTAG_NM_MOTORE15_IO_InverterPresente
	PLCTAG_NM_MOTORE15_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE15_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE15_Esclusioni_Uscita
	PLCTAG_NM_MOTORE15_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE15_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE15_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE15_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE15_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE15_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE15_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE15_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE15_Timeout_Avvio
	PLCTAG_NM_MOTORE15_Timeout_Arresto
	PLCTAG_NM_MOTORE15_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE15_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE15_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE15_Antislittamento_Presente
	PLCTAG_NM_MOTORE15_Antislittamento_Tempo
	PLCTAG_NM_MOTORE15_Amperometri_Presente
	PLCTAG_NM_MOTORE15_Amperometri_LimMin
	PLCTAG_NM_MOTORE15_Amperometri_LimMax
	PLCTAG_NM_MOTORE15_Amperometri_MaxOut
	PLCTAG_NM_MOTORE16_Presente
	PLCTAG_NM_MOTORE16_UscitaInvertita
	PLCTAG_NM_MOTORE16_RitornoInvertito
	PLCTAG_NM_MOTORE16_TipoInversione
	PLCTAG_NM_MOTORE16_IO_InverterPresente
	PLCTAG_NM_MOTORE16_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE16_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE16_Esclusioni_Uscita
	PLCTAG_NM_MOTORE16_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE16_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE16_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE16_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE16_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE16_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE16_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE16_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE16_Timeout_Avvio
	PLCTAG_NM_MOTORE16_Timeout_Arresto
	PLCTAG_NM_MOTORE16_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE16_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE16_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE16_Antislittamento_Presente
	PLCTAG_NM_MOTORE16_Antislittamento_Tempo
	PLCTAG_NM_MOTORE16_Amperometri_Presente
	PLCTAG_NM_MOTORE16_Amperometri_LimMin
	PLCTAG_NM_MOTORE16_Amperometri_LimMax
	PLCTAG_NM_MOTORE16_Amperometri_MaxOut
	PLCTAG_NM_MOTORE17_Presente
	PLCTAG_NM_MOTORE17_UscitaInvertita
	PLCTAG_NM_MOTORE17_RitornoInvertito
	PLCTAG_NM_MOTORE17_TipoInversione
	PLCTAG_NM_MOTORE17_IO_InverterPresente
	PLCTAG_NM_MOTORE17_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE17_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE17_Esclusioni_Uscita
	PLCTAG_NM_MOTORE17_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE17_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE17_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE17_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE17_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE17_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE17_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE17_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE17_Timeout_Avvio
	PLCTAG_NM_MOTORE17_Timeout_Arresto
	PLCTAG_NM_MOTORE17_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE17_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE17_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE17_Antislittamento_Presente
	PLCTAG_NM_MOTORE17_Antislittamento_Tempo
	PLCTAG_NM_MOTORE17_Amperometri_Presente
	PLCTAG_NM_MOTORE17_Amperometri_LimMin
	PLCTAG_NM_MOTORE17_Amperometri_LimMax
	PLCTAG_NM_MOTORE17_Amperometri_MaxOut
	PLCTAG_NM_MOTORE18_Presente
	PLCTAG_NM_MOTORE18_UscitaInvertita
	PLCTAG_NM_MOTORE18_RitornoInvertito
	PLCTAG_NM_MOTORE18_TipoInversione
	PLCTAG_NM_MOTORE18_IO_InverterPresente
	PLCTAG_NM_MOTORE18_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE18_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE18_Esclusioni_Uscita
	PLCTAG_NM_MOTORE18_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE18_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE18_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE18_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE18_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE18_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE18_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE18_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE18_Timeout_Avvio
	PLCTAG_NM_MOTORE18_Timeout_Arresto
	PLCTAG_NM_MOTORE18_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE18_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE18_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE18_Antislittamento_Presente
	PLCTAG_NM_MOTORE18_Antislittamento_Tempo
	PLCTAG_NM_MOTORE18_Amperometri_Presente
	PLCTAG_NM_MOTORE18_Amperometri_LimMin
	PLCTAG_NM_MOTORE18_Amperometri_LimMax
	PLCTAG_NM_MOTORE18_Amperometri_MaxOut
	PLCTAG_NM_MOTORE19_Presente
	PLCTAG_NM_MOTORE19_UscitaInvertita
	PLCTAG_NM_MOTORE19_RitornoInvertito
	PLCTAG_NM_MOTORE19_TipoInversione
	PLCTAG_NM_MOTORE19_IO_InverterPresente
	PLCTAG_NM_MOTORE19_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE19_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE19_Esclusioni_Uscita
	PLCTAG_NM_MOTORE19_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE19_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE19_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE19_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE19_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE19_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE19_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE19_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE19_Timeout_Avvio
	PLCTAG_NM_MOTORE19_Timeout_Arresto
	PLCTAG_NM_MOTORE19_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE19_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE19_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE19_Antislittamento_Presente
	PLCTAG_NM_MOTORE19_Antislittamento_Tempo
	PLCTAG_NM_MOTORE19_Amperometri_Presente
	PLCTAG_NM_MOTORE19_Amperometri_LimMin
	PLCTAG_NM_MOTORE19_Amperometri_LimMax
	PLCTAG_NM_MOTORE19_Amperometri_MaxOut
	PLCTAG_NM_MOTORE20_Presente
	PLCTAG_NM_MOTORE20_UscitaInvertita
	PLCTAG_NM_MOTORE20_RitornoInvertito
	PLCTAG_NM_MOTORE20_TipoInversione
	PLCTAG_NM_MOTORE20_IO_InverterPresente
	PLCTAG_NM_MOTORE20_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE20_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE20_Esclusioni_Uscita
	PLCTAG_NM_MOTORE20_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE20_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE20_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE20_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE20_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE20_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE20_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE20_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE20_Timeout_Avvio
	PLCTAG_NM_MOTORE20_Timeout_Arresto
	PLCTAG_NM_MOTORE20_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE20_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE20_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE20_Antislittamento_Presente
	PLCTAG_NM_MOTORE20_Antislittamento_Tempo
	PLCTAG_NM_MOTORE20_Amperometri_Presente
	PLCTAG_NM_MOTORE20_Amperometri_LimMin
	PLCTAG_NM_MOTORE20_Amperometri_LimMax
	PLCTAG_NM_MOTORE20_Amperometri_MaxOut
	PLCTAG_NM_MOTORE21_Presente
	PLCTAG_NM_MOTORE21_UscitaInvertita
	PLCTAG_NM_MOTORE21_RitornoInvertito
	PLCTAG_NM_MOTORE21_TipoInversione
	PLCTAG_NM_MOTORE21_IO_InverterPresente
	PLCTAG_NM_MOTORE21_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE21_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE21_Esclusioni_Uscita
	PLCTAG_NM_MOTORE21_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE21_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE21_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE21_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE21_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE21_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE21_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE21_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE21_Timeout_Avvio
	PLCTAG_NM_MOTORE21_Timeout_Arresto
	PLCTAG_NM_MOTORE21_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE21_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE21_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE21_Antislittamento_Presente
	PLCTAG_NM_MOTORE21_Antislittamento_Tempo
	PLCTAG_NM_MOTORE21_Amperometri_Presente
	PLCTAG_NM_MOTORE21_Amperometri_LimMin
	PLCTAG_NM_MOTORE21_Amperometri_LimMax
	PLCTAG_NM_MOTORE21_Amperometri_MaxOut
	PLCTAG_NM_MOTORE22_Presente
	PLCTAG_NM_MOTORE22_UscitaInvertita
	PLCTAG_NM_MOTORE22_RitornoInvertito
	PLCTAG_NM_MOTORE22_TipoInversione
	PLCTAG_NM_MOTORE22_IO_InverterPresente
	PLCTAG_NM_MOTORE22_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE22_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE22_Esclusioni_Uscita
	PLCTAG_NM_MOTORE22_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE22_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE22_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE22_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE22_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE22_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE22_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE22_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE22_Timeout_Avvio
	PLCTAG_NM_MOTORE22_Timeout_Arresto
	PLCTAG_NM_MOTORE22_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE22_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE22_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE22_Antislittamento_Presente
	PLCTAG_NM_MOTORE22_Antislittamento_Tempo
	PLCTAG_NM_MOTORE22_Amperometri_Presente
	PLCTAG_NM_MOTORE22_Amperometri_LimMin
	PLCTAG_NM_MOTORE22_Amperometri_LimMax
	PLCTAG_NM_MOTORE22_Amperometri_MaxOut
	PLCTAG_NM_MOTORE23_Presente
	PLCTAG_NM_MOTORE23_UscitaInvertita
	PLCTAG_NM_MOTORE23_RitornoInvertito
	PLCTAG_NM_MOTORE23_TipoInversione
	PLCTAG_NM_MOTORE23_IO_InverterPresente
	PLCTAG_NM_MOTORE23_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE23_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE23_Esclusioni_Uscita
	PLCTAG_NM_MOTORE23_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE23_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE23_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE23_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE23_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE23_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE23_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE23_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE23_Timeout_Avvio
	PLCTAG_NM_MOTORE23_Timeout_Arresto
	PLCTAG_NM_MOTORE23_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE23_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE23_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE23_Antislittamento_Presente
	PLCTAG_NM_MOTORE23_Antislittamento_Tempo
	PLCTAG_NM_MOTORE23_Amperometri_Presente
	PLCTAG_NM_MOTORE23_Amperometri_LimMin
	PLCTAG_NM_MOTORE23_Amperometri_LimMax
	PLCTAG_NM_MOTORE23_Amperometri_MaxOut
	PLCTAG_NM_MOTORE24_Presente
	PLCTAG_NM_MOTORE24_UscitaInvertita
	PLCTAG_NM_MOTORE24_RitornoInvertito
	PLCTAG_NM_MOTORE24_TipoInversione
	PLCTAG_NM_MOTORE24_IO_InverterPresente
	PLCTAG_NM_MOTORE24_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE24_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE24_Esclusioni_Uscita
	PLCTAG_NM_MOTORE24_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE24_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE24_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE24_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE24_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE24_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE24_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE24_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE24_Timeout_Avvio
	PLCTAG_NM_MOTORE24_Timeout_Arresto
	PLCTAG_NM_MOTORE24_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE24_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE24_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE24_Antislittamento_Presente
	PLCTAG_NM_MOTORE24_Antislittamento_Tempo
	PLCTAG_NM_MOTORE24_Amperometri_Presente
	PLCTAG_NM_MOTORE24_Amperometri_LimMin
	PLCTAG_NM_MOTORE24_Amperometri_LimMax
	PLCTAG_NM_MOTORE24_Amperometri_MaxOut
	PLCTAG_NM_MOTORE25_Presente
	PLCTAG_NM_MOTORE25_UscitaInvertita
	PLCTAG_NM_MOTORE25_RitornoInvertito
	PLCTAG_NM_MOTORE25_TipoInversione
	PLCTAG_NM_MOTORE25_IO_InverterPresente
	PLCTAG_NM_MOTORE25_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE25_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE25_Esclusioni_Uscita
	PLCTAG_NM_MOTORE25_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE25_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE25_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE25_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE25_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE25_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE25_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE25_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE25_Timeout_Avvio
	PLCTAG_NM_MOTORE25_Timeout_Arresto
	PLCTAG_NM_MOTORE25_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE25_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE25_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE25_Antislittamento_Presente
	PLCTAG_NM_MOTORE25_Antislittamento_Tempo
	PLCTAG_NM_MOTORE25_Amperometri_Presente
	PLCTAG_NM_MOTORE25_Amperometri_LimMin
	PLCTAG_NM_MOTORE25_Amperometri_LimMax
	PLCTAG_NM_MOTORE25_Amperometri_MaxOut
	PLCTAG_NM_MOTORE26_Presente
	PLCTAG_NM_MOTORE26_UscitaInvertita
	PLCTAG_NM_MOTORE26_RitornoInvertito
	PLCTAG_NM_MOTORE26_TipoInversione
	PLCTAG_NM_MOTORE26_IO_InverterPresente
	PLCTAG_NM_MOTORE26_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE26_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE26_Esclusioni_Uscita
	PLCTAG_NM_MOTORE26_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE26_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE26_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE26_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE26_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE26_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE26_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE26_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE26_Timeout_Avvio
	PLCTAG_NM_MOTORE26_Timeout_Arresto
	PLCTAG_NM_MOTORE26_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE26_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE26_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE26_Antislittamento_Presente
	PLCTAG_NM_MOTORE26_Antislittamento_Tempo
	PLCTAG_NM_MOTORE26_Amperometri_Presente
	PLCTAG_NM_MOTORE26_Amperometri_LimMin
	PLCTAG_NM_MOTORE26_Amperometri_LimMax
	PLCTAG_NM_MOTORE26_Amperometri_MaxOut
	PLCTAG_NM_MOTORE27_Presente
	PLCTAG_NM_MOTORE27_UscitaInvertita
	PLCTAG_NM_MOTORE27_RitornoInvertito
	PLCTAG_NM_MOTORE27_TipoInversione
	PLCTAG_NM_MOTORE27_IO_InverterPresente
	PLCTAG_NM_MOTORE27_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE27_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE27_Esclusioni_Uscita
	PLCTAG_NM_MOTORE27_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE27_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE27_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE27_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE27_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE27_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE27_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE27_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE27_Timeout_Avvio
	PLCTAG_NM_MOTORE27_Timeout_Arresto
	PLCTAG_NM_MOTORE27_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE27_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE27_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE27_Antislittamento_Presente
	PLCTAG_NM_MOTORE27_Antislittamento_Tempo
	PLCTAG_NM_MOTORE27_Amperometri_Presente
	PLCTAG_NM_MOTORE27_Amperometri_LimMin
	PLCTAG_NM_MOTORE27_Amperometri_LimMax
	PLCTAG_NM_MOTORE27_Amperometri_MaxOut
	PLCTAG_NM_MOTORE28_Presente
	PLCTAG_NM_MOTORE28_UscitaInvertita
	PLCTAG_NM_MOTORE28_RitornoInvertito
	PLCTAG_NM_MOTORE28_TipoInversione
	PLCTAG_NM_MOTORE28_IO_InverterPresente
	PLCTAG_NM_MOTORE28_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE28_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE28_Esclusioni_Uscita
	PLCTAG_NM_MOTORE28_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE28_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE28_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE28_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE28_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE28_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE28_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE28_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE28_Timeout_Avvio
	PLCTAG_NM_MOTORE28_Timeout_Arresto
	PLCTAG_NM_MOTORE28_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE28_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE28_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE28_Antislittamento_Presente
	PLCTAG_NM_MOTORE28_Antislittamento_Tempo
	PLCTAG_NM_MOTORE28_Amperometri_Presente
	PLCTAG_NM_MOTORE28_Amperometri_LimMin
	PLCTAG_NM_MOTORE28_Amperometri_LimMax
	PLCTAG_NM_MOTORE28_Amperometri_MaxOut
	PLCTAG_NM_MOTORE29_Presente
	PLCTAG_NM_MOTORE29_UscitaInvertita
	PLCTAG_NM_MOTORE29_RitornoInvertito
	PLCTAG_NM_MOTORE29_TipoInversione
	PLCTAG_NM_MOTORE29_IO_InverterPresente
	PLCTAG_NM_MOTORE29_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE29_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE29_Esclusioni_Uscita
	PLCTAG_NM_MOTORE29_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE29_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE29_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE29_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE29_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE29_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE29_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE29_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE29_Timeout_Avvio
	PLCTAG_NM_MOTORE29_Timeout_Arresto
	PLCTAG_NM_MOTORE29_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE29_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE29_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE29_Antislittamento_Presente
	PLCTAG_NM_MOTORE29_Antislittamento_Tempo
	PLCTAG_NM_MOTORE29_Amperometri_Presente
	PLCTAG_NM_MOTORE29_Amperometri_LimMin
	PLCTAG_NM_MOTORE29_Amperometri_LimMax
	PLCTAG_NM_MOTORE29_Amperometri_MaxOut
	PLCTAG_NM_MOTORE30_Presente
	PLCTAG_NM_MOTORE30_UscitaInvertita
	PLCTAG_NM_MOTORE30_RitornoInvertito
	PLCTAG_NM_MOTORE30_TipoInversione
	PLCTAG_NM_MOTORE30_IO_InverterPresente
	PLCTAG_NM_MOTORE30_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE30_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE30_Esclusioni_Uscita
	PLCTAG_NM_MOTORE30_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE30_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE30_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE30_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE30_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE30_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE30_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE30_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE30_Timeout_Avvio
	PLCTAG_NM_MOTORE30_Timeout_Arresto
	PLCTAG_NM_MOTORE30_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE30_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE30_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE30_Antislittamento_Presente
	PLCTAG_NM_MOTORE30_Antislittamento_Tempo
	PLCTAG_NM_MOTORE30_Amperometri_Presente
	PLCTAG_NM_MOTORE30_Amperometri_LimMin
	PLCTAG_NM_MOTORE30_Amperometri_LimMax
	PLCTAG_NM_MOTORE30_Amperometri_MaxOut
	PLCTAG_NM_MOTORE31_Presente
	PLCTAG_NM_MOTORE31_UscitaInvertita
	PLCTAG_NM_MOTORE31_RitornoInvertito
	PLCTAG_NM_MOTORE31_TipoInversione
	PLCTAG_NM_MOTORE31_IO_InverterPresente
	PLCTAG_NM_MOTORE31_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE31_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE31_Esclusioni_Uscita
	PLCTAG_NM_MOTORE31_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE31_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE31_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE31_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE31_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE31_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE31_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE31_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE31_Timeout_Avvio
	PLCTAG_NM_MOTORE31_Timeout_Arresto
	PLCTAG_NM_MOTORE31_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE31_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE31_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE31_Antislittamento_Presente
	PLCTAG_NM_MOTORE31_Antislittamento_Tempo
	PLCTAG_NM_MOTORE31_Amperometri_Presente
	PLCTAG_NM_MOTORE31_Amperometri_LimMin
	PLCTAG_NM_MOTORE31_Amperometri_LimMax
	PLCTAG_NM_MOTORE31_Amperometri_MaxOut
	PLCTAG_NM_MOTORE32_Presente
	PLCTAG_NM_MOTORE32_UscitaInvertita
	PLCTAG_NM_MOTORE32_RitornoInvertito
	PLCTAG_NM_MOTORE32_TipoInversione
	PLCTAG_NM_MOTORE32_IO_InverterPresente
	PLCTAG_NM_MOTORE32_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE32_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE32_Esclusioni_Uscita
	PLCTAG_NM_MOTORE32_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE32_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE32_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE32_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE32_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE32_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE32_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE32_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE32_Timeout_Avvio
	PLCTAG_NM_MOTORE32_Timeout_Arresto
	PLCTAG_NM_MOTORE32_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE32_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE32_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE32_Antislittamento_Presente
	PLCTAG_NM_MOTORE32_Antislittamento_Tempo
	PLCTAG_NM_MOTORE32_Amperometri_Presente
	PLCTAG_NM_MOTORE32_Amperometri_LimMin
	PLCTAG_NM_MOTORE32_Amperometri_LimMax
	PLCTAG_NM_MOTORE32_Amperometri_MaxOut
	PLCTAG_NM_MOTORE33_Presente
	PLCTAG_NM_MOTORE33_UscitaInvertita
	PLCTAG_NM_MOTORE33_RitornoInvertito
	PLCTAG_NM_MOTORE33_TipoInversione
	PLCTAG_NM_MOTORE33_IO_InverterPresente
	PLCTAG_NM_MOTORE33_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE33_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE33_Esclusioni_Uscita
	PLCTAG_NM_MOTORE33_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE33_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE33_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE33_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE33_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE33_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE33_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE33_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE33_Timeout_Avvio
	PLCTAG_NM_MOTORE33_Timeout_Arresto
	PLCTAG_NM_MOTORE33_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE33_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE33_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE33_Antislittamento_Presente
	PLCTAG_NM_MOTORE33_Antislittamento_Tempo
	PLCTAG_NM_MOTORE33_Amperometri_Presente
	PLCTAG_NM_MOTORE33_Amperometri_LimMin
	PLCTAG_NM_MOTORE33_Amperometri_LimMax
	PLCTAG_NM_MOTORE33_Amperometri_MaxOut
	PLCTAG_NM_MOTORE34_Presente
	PLCTAG_NM_MOTORE34_UscitaInvertita
	PLCTAG_NM_MOTORE34_RitornoInvertito
	PLCTAG_NM_MOTORE34_TipoInversione
	PLCTAG_NM_MOTORE34_IO_InverterPresente
	PLCTAG_NM_MOTORE34_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE34_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE34_Esclusioni_Uscita
	PLCTAG_NM_MOTORE34_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE34_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE34_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE34_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE34_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE34_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE34_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE34_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE34_Timeout_Avvio
	PLCTAG_NM_MOTORE34_Timeout_Arresto
	PLCTAG_NM_MOTORE34_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE34_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE34_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE34_Antislittamento_Presente
	PLCTAG_NM_MOTORE34_Antislittamento_Tempo
	PLCTAG_NM_MOTORE34_Amperometri_Presente
	PLCTAG_NM_MOTORE34_Amperometri_LimMin
	PLCTAG_NM_MOTORE34_Amperometri_LimMax
	PLCTAG_NM_MOTORE34_Amperometri_MaxOut
	PLCTAG_NM_MOTORE35_Presente
	PLCTAG_NM_MOTORE35_UscitaInvertita
	PLCTAG_NM_MOTORE35_RitornoInvertito
	PLCTAG_NM_MOTORE35_TipoInversione
	PLCTAG_NM_MOTORE35_IO_InverterPresente
	PLCTAG_NM_MOTORE35_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE35_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE35_Esclusioni_Uscita
	PLCTAG_NM_MOTORE35_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE35_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE35_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE35_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE35_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE35_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE35_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE35_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE35_Timeout_Avvio
	PLCTAG_NM_MOTORE35_Timeout_Arresto
	PLCTAG_NM_MOTORE35_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE35_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE35_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE35_Antislittamento_Presente
	PLCTAG_NM_MOTORE35_Antislittamento_Tempo
	PLCTAG_NM_MOTORE35_Amperometri_Presente
	PLCTAG_NM_MOTORE35_Amperometri_LimMin
	PLCTAG_NM_MOTORE35_Amperometri_LimMax
	PLCTAG_NM_MOTORE35_Amperometri_MaxOut
	PLCTAG_NM_MOTORE36_Presente
	PLCTAG_NM_MOTORE36_UscitaInvertita
	PLCTAG_NM_MOTORE36_RitornoInvertito
	PLCTAG_NM_MOTORE36_TipoInversione
	PLCTAG_NM_MOTORE36_IO_InverterPresente
	PLCTAG_NM_MOTORE36_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE36_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE36_Esclusioni_Uscita
	PLCTAG_NM_MOTORE36_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE36_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE36_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE36_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE36_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE36_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE36_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE36_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE36_Timeout_Avvio
	PLCTAG_NM_MOTORE36_Timeout_Arresto
	PLCTAG_NM_MOTORE36_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE36_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE36_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE36_Antislittamento_Presente
	PLCTAG_NM_MOTORE36_Antislittamento_Tempo
	PLCTAG_NM_MOTORE36_Amperometri_Presente
	PLCTAG_NM_MOTORE36_Amperometri_LimMin
	PLCTAG_NM_MOTORE36_Amperometri_LimMax
	PLCTAG_NM_MOTORE36_Amperometri_MaxOut
	PLCTAG_NM_MOTORE37_Presente
	PLCTAG_NM_MOTORE37_UscitaInvertita
	PLCTAG_NM_MOTORE37_RitornoInvertito
	PLCTAG_NM_MOTORE37_TipoInversione
	PLCTAG_NM_MOTORE37_IO_InverterPresente
	PLCTAG_NM_MOTORE37_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE37_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE37_Esclusioni_Uscita
	PLCTAG_NM_MOTORE37_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE37_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE37_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE37_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE37_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE37_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE37_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE37_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE37_Timeout_Avvio
	PLCTAG_NM_MOTORE37_Timeout_Arresto
	PLCTAG_NM_MOTORE37_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE37_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE37_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE37_Antislittamento_Presente
	PLCTAG_NM_MOTORE37_Antislittamento_Tempo
	PLCTAG_NM_MOTORE37_Amperometri_Presente
	PLCTAG_NM_MOTORE37_Amperometri_LimMin
	PLCTAG_NM_MOTORE37_Amperometri_LimMax
	PLCTAG_NM_MOTORE37_Amperometri_MaxOut
	PLCTAG_NM_MOTORE38_Presente
	PLCTAG_NM_MOTORE38_UscitaInvertita
	PLCTAG_NM_MOTORE38_RitornoInvertito
	PLCTAG_NM_MOTORE38_TipoInversione
	PLCTAG_NM_MOTORE38_IO_InverterPresente
	PLCTAG_NM_MOTORE38_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE38_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE38_Esclusioni_Uscita
	PLCTAG_NM_MOTORE38_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE38_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE38_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE38_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE38_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE38_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE38_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE38_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE38_Timeout_Avvio
	PLCTAG_NM_MOTORE38_Timeout_Arresto
	PLCTAG_NM_MOTORE38_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE38_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE38_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE38_Antislittamento_Presente
	PLCTAG_NM_MOTORE38_Antislittamento_Tempo
	PLCTAG_NM_MOTORE38_Amperometri_Presente
	PLCTAG_NM_MOTORE38_Amperometri_LimMin
	PLCTAG_NM_MOTORE38_Amperometri_LimMax
	PLCTAG_NM_MOTORE38_Amperometri_MaxOut
	PLCTAG_NM_MOTORE39_Presente
	PLCTAG_NM_MOTORE39_UscitaInvertita
	PLCTAG_NM_MOTORE39_RitornoInvertito
	PLCTAG_NM_MOTORE39_TipoInversione
	PLCTAG_NM_MOTORE39_IO_InverterPresente
	PLCTAG_NM_MOTORE39_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE39_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE39_Esclusioni_Uscita
	PLCTAG_NM_MOTORE39_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE39_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE39_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE39_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE39_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE39_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE39_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE39_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE39_Timeout_Avvio
	PLCTAG_NM_MOTORE39_Timeout_Arresto
	PLCTAG_NM_MOTORE39_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE39_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE39_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE39_Antislittamento_Presente
	PLCTAG_NM_MOTORE39_Antislittamento_Tempo
	PLCTAG_NM_MOTORE39_Amperometri_Presente
	PLCTAG_NM_MOTORE39_Amperometri_LimMin
	PLCTAG_NM_MOTORE39_Amperometri_LimMax
	PLCTAG_NM_MOTORE39_Amperometri_MaxOut
	PLCTAG_NM_MOTORE40_Presente
	PLCTAG_NM_MOTORE40_UscitaInvertita
	PLCTAG_NM_MOTORE40_RitornoInvertito
	PLCTAG_NM_MOTORE40_TipoInversione
	PLCTAG_NM_MOTORE40_IO_InverterPresente
	PLCTAG_NM_MOTORE40_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE40_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE40_Esclusioni_Uscita
	PLCTAG_NM_MOTORE40_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE40_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE40_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE40_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE40_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE40_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE40_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE40_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE40_Timeout_Avvio
	PLCTAG_NM_MOTORE40_Timeout_Arresto
	PLCTAG_NM_MOTORE40_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE40_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE40_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE40_Antislittamento_Presente
	PLCTAG_NM_MOTORE40_Antislittamento_Tempo
	PLCTAG_NM_MOTORE40_Amperometri_Presente
	PLCTAG_NM_MOTORE40_Amperometri_LimMin
	PLCTAG_NM_MOTORE40_Amperometri_LimMax
	PLCTAG_NM_MOTORE40_Amperometri_MaxOut
	PLCTAG_NM_MOTORE41_Presente
	PLCTAG_NM_MOTORE41_UscitaInvertita
	PLCTAG_NM_MOTORE41_RitornoInvertito
	PLCTAG_NM_MOTORE41_TipoInversione
	PLCTAG_NM_MOTORE41_IO_InverterPresente
	PLCTAG_NM_MOTORE41_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE41_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE41_Esclusioni_Uscita
	PLCTAG_NM_MOTORE41_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE41_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE41_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE41_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE41_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE41_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE41_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE41_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE41_Timeout_Avvio
	PLCTAG_NM_MOTORE41_Timeout_Arresto
	PLCTAG_NM_MOTORE41_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE41_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE41_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE41_Antislittamento_Presente
	PLCTAG_NM_MOTORE41_Antislittamento_Tempo
	PLCTAG_NM_MOTORE41_Amperometri_Presente
	PLCTAG_NM_MOTORE41_Amperometri_LimMin
	PLCTAG_NM_MOTORE41_Amperometri_LimMax
	PLCTAG_NM_MOTORE41_Amperometri_MaxOut
	PLCTAG_NM_MOTORE42_Presente
	PLCTAG_NM_MOTORE42_UscitaInvertita
	PLCTAG_NM_MOTORE42_RitornoInvertito
	PLCTAG_NM_MOTORE42_TipoInversione
	PLCTAG_NM_MOTORE42_IO_InverterPresente
	PLCTAG_NM_MOTORE42_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE42_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE42_Esclusioni_Uscita
	PLCTAG_NM_MOTORE42_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE42_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE42_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE42_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE42_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE42_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE42_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE42_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE42_Timeout_Avvio
	PLCTAG_NM_MOTORE42_Timeout_Arresto
	PLCTAG_NM_MOTORE42_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE42_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE42_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE42_Antislittamento_Presente
	PLCTAG_NM_MOTORE42_Antislittamento_Tempo
	PLCTAG_NM_MOTORE42_Amperometri_Presente
	PLCTAG_NM_MOTORE42_Amperometri_LimMin
	PLCTAG_NM_MOTORE42_Amperometri_LimMax
	PLCTAG_NM_MOTORE42_Amperometri_MaxOut
	PLCTAG_NM_MOTORE43_Presente
	PLCTAG_NM_MOTORE43_UscitaInvertita
	PLCTAG_NM_MOTORE43_RitornoInvertito
	PLCTAG_NM_MOTORE43_TipoInversione
	PLCTAG_NM_MOTORE43_IO_InverterPresente
	PLCTAG_NM_MOTORE43_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE43_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE43_Esclusioni_Uscita
	PLCTAG_NM_MOTORE43_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE43_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE43_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE43_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE43_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE43_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE43_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE43_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE43_Timeout_Avvio
	PLCTAG_NM_MOTORE43_Timeout_Arresto
	PLCTAG_NM_MOTORE43_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE43_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE43_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE43_Antislittamento_Presente
	PLCTAG_NM_MOTORE43_Antislittamento_Tempo
	PLCTAG_NM_MOTORE43_Amperometri_Presente
	PLCTAG_NM_MOTORE43_Amperometri_LimMin
	PLCTAG_NM_MOTORE43_Amperometri_LimMax
	PLCTAG_NM_MOTORE43_Amperometri_MaxOut
	PLCTAG_NM_MOTORE44_Presente
	PLCTAG_NM_MOTORE44_UscitaInvertita
	PLCTAG_NM_MOTORE44_RitornoInvertito
	PLCTAG_NM_MOTORE44_TipoInversione
	PLCTAG_NM_MOTORE44_IO_InverterPresente
	PLCTAG_NM_MOTORE44_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE44_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE44_Esclusioni_Uscita
	PLCTAG_NM_MOTORE44_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE44_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE44_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE44_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE44_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE44_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE44_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE44_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE44_Timeout_Avvio
	PLCTAG_NM_MOTORE44_Timeout_Arresto
	PLCTAG_NM_MOTORE44_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE44_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE44_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE44_Antislittamento_Presente
	PLCTAG_NM_MOTORE44_Antislittamento_Tempo
	PLCTAG_NM_MOTORE44_Amperometri_Presente
	PLCTAG_NM_MOTORE44_Amperometri_LimMin
	PLCTAG_NM_MOTORE44_Amperometri_LimMax
	PLCTAG_NM_MOTORE44_Amperometri_MaxOut
	PLCTAG_NM_MOTORE45_Presente
	PLCTAG_NM_MOTORE45_UscitaInvertita
	PLCTAG_NM_MOTORE45_RitornoInvertito
	PLCTAG_NM_MOTORE45_TipoInversione
	PLCTAG_NM_MOTORE45_IO_InverterPresente
	PLCTAG_NM_MOTORE45_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE45_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE45_Esclusioni_Uscita
	PLCTAG_NM_MOTORE45_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE45_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE45_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE45_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE45_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE45_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE45_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE45_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE45_Timeout_Avvio
	PLCTAG_NM_MOTORE45_Timeout_Arresto
	PLCTAG_NM_MOTORE45_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE45_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE45_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE45_Antislittamento_Presente
	PLCTAG_NM_MOTORE45_Antislittamento_Tempo
	PLCTAG_NM_MOTORE45_Amperometri_Presente
	PLCTAG_NM_MOTORE45_Amperometri_LimMin
	PLCTAG_NM_MOTORE45_Amperometri_LimMax
	PLCTAG_NM_MOTORE45_Amperometri_MaxOut
	PLCTAG_NM_MOTORE46_Presente
	PLCTAG_NM_MOTORE46_UscitaInvertita
	PLCTAG_NM_MOTORE46_RitornoInvertito
	PLCTAG_NM_MOTORE46_TipoInversione
	PLCTAG_NM_MOTORE46_IO_InverterPresente
	PLCTAG_NM_MOTORE46_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE46_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE46_Esclusioni_Uscita
	PLCTAG_NM_MOTORE46_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE46_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE46_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE46_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE46_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE46_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE46_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE46_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE46_Timeout_Avvio
	PLCTAG_NM_MOTORE46_Timeout_Arresto
	PLCTAG_NM_MOTORE46_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE46_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE46_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE46_Antislittamento_Presente
	PLCTAG_NM_MOTORE46_Antislittamento_Tempo
	PLCTAG_NM_MOTORE46_Amperometri_Presente
	PLCTAG_NM_MOTORE46_Amperometri_LimMin
	PLCTAG_NM_MOTORE46_Amperometri_LimMax
	PLCTAG_NM_MOTORE46_Amperometri_MaxOut
	PLCTAG_NM_MOTORE47_Presente
	PLCTAG_NM_MOTORE47_UscitaInvertita
	PLCTAG_NM_MOTORE47_RitornoInvertito
	PLCTAG_NM_MOTORE47_TipoInversione
	PLCTAG_NM_MOTORE47_IO_InverterPresente
	PLCTAG_NM_MOTORE47_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE47_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE47_Esclusioni_Uscita
	PLCTAG_NM_MOTORE47_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE47_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE47_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE47_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE47_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE47_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE47_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE47_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE47_Timeout_Avvio
	PLCTAG_NM_MOTORE47_Timeout_Arresto
	PLCTAG_NM_MOTORE47_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE47_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE47_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE47_Antislittamento_Presente
	PLCTAG_NM_MOTORE47_Antislittamento_Tempo
	PLCTAG_NM_MOTORE47_Amperometri_Presente
	PLCTAG_NM_MOTORE47_Amperometri_LimMin
	PLCTAG_NM_MOTORE47_Amperometri_LimMax
	PLCTAG_NM_MOTORE47_Amperometri_MaxOut
	PLCTAG_NM_MOTORE48_Presente
	PLCTAG_NM_MOTORE48_UscitaInvertita
	PLCTAG_NM_MOTORE48_RitornoInvertito
	PLCTAG_NM_MOTORE48_TipoInversione
	PLCTAG_NM_MOTORE48_IO_InverterPresente
	PLCTAG_NM_MOTORE48_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE48_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE48_Esclusioni_Uscita
	PLCTAG_NM_MOTORE48_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE48_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE48_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE48_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE48_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE48_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE48_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE48_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE48_Timeout_Avvio
	PLCTAG_NM_MOTORE48_Timeout_Arresto
	PLCTAG_NM_MOTORE48_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE48_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE48_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE48_Antislittamento_Presente
	PLCTAG_NM_MOTORE48_Antislittamento_Tempo
	PLCTAG_NM_MOTORE48_Amperometri_Presente
	PLCTAG_NM_MOTORE48_Amperometri_LimMin
	PLCTAG_NM_MOTORE48_Amperometri_LimMax
	PLCTAG_NM_MOTORE48_Amperometri_MaxOut
	PLCTAG_NM_MOTORE49_Presente
	PLCTAG_NM_MOTORE49_UscitaInvertita
	PLCTAG_NM_MOTORE49_RitornoInvertito
	PLCTAG_NM_MOTORE49_TipoInversione
	PLCTAG_NM_MOTORE49_IO_InverterPresente
	PLCTAG_NM_MOTORE49_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE49_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE49_Esclusioni_Uscita
	PLCTAG_NM_MOTORE49_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE49_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE49_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE49_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE49_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE49_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE49_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE49_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE49_Timeout_Avvio
	PLCTAG_NM_MOTORE49_Timeout_Arresto
	PLCTAG_NM_MOTORE49_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE49_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE49_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE49_Antislittamento_Presente
	PLCTAG_NM_MOTORE49_Antislittamento_Tempo
	PLCTAG_NM_MOTORE49_Amperometri_Presente
	PLCTAG_NM_MOTORE49_Amperometri_LimMin
	PLCTAG_NM_MOTORE49_Amperometri_LimMax
	PLCTAG_NM_MOTORE49_Amperometri_MaxOut
	PLCTAG_NM_MOTORE50_Presente
	PLCTAG_NM_MOTORE50_UscitaInvertita
	PLCTAG_NM_MOTORE50_RitornoInvertito
	PLCTAG_NM_MOTORE50_TipoInversione
	PLCTAG_NM_MOTORE50_IO_InverterPresente
	PLCTAG_NM_MOTORE50_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE50_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE50_Esclusioni_Uscita
	PLCTAG_NM_MOTORE50_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE50_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE50_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE50_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE50_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE50_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE50_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE50_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE50_Timeout_Avvio
	PLCTAG_NM_MOTORE50_Timeout_Arresto
	PLCTAG_NM_MOTORE50_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE50_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE50_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE50_Antislittamento_Presente
	PLCTAG_NM_MOTORE50_Antislittamento_Tempo
	PLCTAG_NM_MOTORE50_Amperometri_Presente
	PLCTAG_NM_MOTORE50_Amperometri_LimMin
	PLCTAG_NM_MOTORE50_Amperometri_LimMax
	PLCTAG_NM_MOTORE50_Amperometri_MaxOut
	PLCTAG_NM_MOTORE51_Presente
	PLCTAG_NM_MOTORE51_UscitaInvertita
	PLCTAG_NM_MOTORE51_RitornoInvertito
	PLCTAG_NM_MOTORE51_TipoInversione
	PLCTAG_NM_MOTORE51_IO_InverterPresente
	PLCTAG_NM_MOTORE51_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE51_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE51_Esclusioni_Uscita
	PLCTAG_NM_MOTORE51_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE51_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE51_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE51_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE51_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE51_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE51_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE51_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE51_Timeout_Avvio
	PLCTAG_NM_MOTORE51_Timeout_Arresto
	PLCTAG_NM_MOTORE51_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE51_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE51_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE51_Antislittamento_Presente
	PLCTAG_NM_MOTORE51_Antislittamento_Tempo
	PLCTAG_NM_MOTORE51_Amperometri_Presente
	PLCTAG_NM_MOTORE51_Amperometri_LimMin
	PLCTAG_NM_MOTORE51_Amperometri_LimMax
	PLCTAG_NM_MOTORE51_Amperometri_MaxOut
	PLCTAG_NM_MOTORE52_Presente
	PLCTAG_NM_MOTORE52_UscitaInvertita
	PLCTAG_NM_MOTORE52_RitornoInvertito
	PLCTAG_NM_MOTORE52_TipoInversione
	PLCTAG_NM_MOTORE52_IO_InverterPresente
	PLCTAG_NM_MOTORE52_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE52_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE52_Esclusioni_Uscita
	PLCTAG_NM_MOTORE52_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE52_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE52_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE52_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE52_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE52_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE52_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE52_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE52_Timeout_Avvio
	PLCTAG_NM_MOTORE52_Timeout_Arresto
	PLCTAG_NM_MOTORE52_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE52_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE52_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE52_Antislittamento_Presente
	PLCTAG_NM_MOTORE52_Antislittamento_Tempo
	PLCTAG_NM_MOTORE52_Amperometri_Presente
	PLCTAG_NM_MOTORE52_Amperometri_LimMin
	PLCTAG_NM_MOTORE52_Amperometri_LimMax
	PLCTAG_NM_MOTORE52_Amperometri_MaxOut
	PLCTAG_NM_MOTORE53_Presente
	PLCTAG_NM_MOTORE53_UscitaInvertita
	PLCTAG_NM_MOTORE53_RitornoInvertito
	PLCTAG_NM_MOTORE53_TipoInversione
	PLCTAG_NM_MOTORE53_IO_InverterPresente
	PLCTAG_NM_MOTORE53_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE53_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE53_Esclusioni_Uscita
	PLCTAG_NM_MOTORE53_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE53_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE53_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE53_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE53_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE53_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE53_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE53_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE53_Timeout_Avvio
	PLCTAG_NM_MOTORE53_Timeout_Arresto
	PLCTAG_NM_MOTORE53_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE53_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE53_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE53_Antislittamento_Presente
	PLCTAG_NM_MOTORE53_Antislittamento_Tempo
	PLCTAG_NM_MOTORE53_Amperometri_Presente
	PLCTAG_NM_MOTORE53_Amperometri_LimMin
	PLCTAG_NM_MOTORE53_Amperometri_LimMax
	PLCTAG_NM_MOTORE53_Amperometri_MaxOut
	PLCTAG_NM_MOTORE54_Presente
	PLCTAG_NM_MOTORE54_UscitaInvertita
	PLCTAG_NM_MOTORE54_RitornoInvertito
	PLCTAG_NM_MOTORE54_TipoInversione
	PLCTAG_NM_MOTORE54_IO_InverterPresente
	PLCTAG_NM_MOTORE54_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE54_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE54_Esclusioni_Uscita
	PLCTAG_NM_MOTORE54_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE54_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE54_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE54_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE54_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE54_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE54_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE54_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE54_Timeout_Avvio
	PLCTAG_NM_MOTORE54_Timeout_Arresto
	PLCTAG_NM_MOTORE54_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE54_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE54_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE54_Antislittamento_Presente
	PLCTAG_NM_MOTORE54_Antislittamento_Tempo
	PLCTAG_NM_MOTORE54_Amperometri_Presente
	PLCTAG_NM_MOTORE54_Amperometri_LimMin
	PLCTAG_NM_MOTORE54_Amperometri_LimMax
	PLCTAG_NM_MOTORE54_Amperometri_MaxOut
	PLCTAG_NM_MOTORE55_Presente
	PLCTAG_NM_MOTORE55_UscitaInvertita
	PLCTAG_NM_MOTORE55_RitornoInvertito
	PLCTAG_NM_MOTORE55_TipoInversione
	PLCTAG_NM_MOTORE55_IO_InverterPresente
	PLCTAG_NM_MOTORE55_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE55_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE55_Esclusioni_Uscita
	PLCTAG_NM_MOTORE55_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE55_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE55_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE55_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE55_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE55_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE55_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE55_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE55_Timeout_Avvio
	PLCTAG_NM_MOTORE55_Timeout_Arresto
	PLCTAG_NM_MOTORE55_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE55_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE55_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE55_Antislittamento_Presente
	PLCTAG_NM_MOTORE55_Antislittamento_Tempo
	PLCTAG_NM_MOTORE55_Amperometri_Presente
	PLCTAG_NM_MOTORE55_Amperometri_LimMin
	PLCTAG_NM_MOTORE55_Amperometri_LimMax
	PLCTAG_NM_MOTORE55_Amperometri_MaxOut
	PLCTAG_NM_MOTORE56_Presente
	PLCTAG_NM_MOTORE56_UscitaInvertita
	PLCTAG_NM_MOTORE56_RitornoInvertito
	PLCTAG_NM_MOTORE56_TipoInversione
	PLCTAG_NM_MOTORE56_IO_InverterPresente
	PLCTAG_NM_MOTORE56_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE56_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE56_Esclusioni_Uscita
	PLCTAG_NM_MOTORE56_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE56_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE56_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE56_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE56_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE56_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE56_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE56_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE56_Timeout_Avvio
	PLCTAG_NM_MOTORE56_Timeout_Arresto
	PLCTAG_NM_MOTORE56_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE56_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE56_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE56_Antislittamento_Presente
	PLCTAG_NM_MOTORE56_Antislittamento_Tempo
	PLCTAG_NM_MOTORE56_Amperometri_Presente
	PLCTAG_NM_MOTORE56_Amperometri_LimMin
	PLCTAG_NM_MOTORE56_Amperometri_LimMax
	PLCTAG_NM_MOTORE56_Amperometri_MaxOut
	PLCTAG_NM_MOTORE57_Presente
	PLCTAG_NM_MOTORE57_UscitaInvertita
	PLCTAG_NM_MOTORE57_RitornoInvertito
	PLCTAG_NM_MOTORE57_TipoInversione
	PLCTAG_NM_MOTORE57_IO_InverterPresente
	PLCTAG_NM_MOTORE57_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE57_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE57_Esclusioni_Uscita
	PLCTAG_NM_MOTORE57_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE57_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE57_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE57_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE57_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE57_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE57_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE57_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE57_Timeout_Avvio
	PLCTAG_NM_MOTORE57_Timeout_Arresto
	PLCTAG_NM_MOTORE57_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE57_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE57_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE57_Antislittamento_Presente
	PLCTAG_NM_MOTORE57_Antislittamento_Tempo
	PLCTAG_NM_MOTORE57_Amperometri_Presente
	PLCTAG_NM_MOTORE57_Amperometri_LimMin
	PLCTAG_NM_MOTORE57_Amperometri_LimMax
	PLCTAG_NM_MOTORE57_Amperometri_MaxOut
	PLCTAG_NM_MOTORE58_Presente
	PLCTAG_NM_MOTORE58_UscitaInvertita
	PLCTAG_NM_MOTORE58_RitornoInvertito
	PLCTAG_NM_MOTORE58_TipoInversione
	PLCTAG_NM_MOTORE58_IO_InverterPresente
	PLCTAG_NM_MOTORE58_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE58_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE58_Esclusioni_Uscita
	PLCTAG_NM_MOTORE58_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE58_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE58_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE58_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE58_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE58_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE58_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE58_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE58_Timeout_Avvio
	PLCTAG_NM_MOTORE58_Timeout_Arresto
	PLCTAG_NM_MOTORE58_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE58_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE58_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE58_Antislittamento_Presente
	PLCTAG_NM_MOTORE58_Antislittamento_Tempo
	PLCTAG_NM_MOTORE58_Amperometri_Presente
	PLCTAG_NM_MOTORE58_Amperometri_LimMin
	PLCTAG_NM_MOTORE58_Amperometri_LimMax
	PLCTAG_NM_MOTORE58_Amperometri_MaxOut
	PLCTAG_NM_MOTORE59_Presente
	PLCTAG_NM_MOTORE59_UscitaInvertita
	PLCTAG_NM_MOTORE59_RitornoInvertito
	PLCTAG_NM_MOTORE59_TipoInversione
	PLCTAG_NM_MOTORE59_IO_InverterPresente
	PLCTAG_NM_MOTORE59_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE59_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE59_Esclusioni_Uscita
	PLCTAG_NM_MOTORE59_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE59_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE59_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE59_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE59_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE59_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE59_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE59_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE59_Timeout_Avvio
	PLCTAG_NM_MOTORE59_Timeout_Arresto
	PLCTAG_NM_MOTORE59_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE59_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE59_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE59_Antislittamento_Presente
	PLCTAG_NM_MOTORE59_Antislittamento_Tempo
	PLCTAG_NM_MOTORE59_Amperometri_Presente
	PLCTAG_NM_MOTORE59_Amperometri_LimMin
	PLCTAG_NM_MOTORE59_Amperometri_LimMax
	PLCTAG_NM_MOTORE59_Amperometri_MaxOut
	PLCTAG_NM_MOTORE60_Presente
	PLCTAG_NM_MOTORE60_UscitaInvertita
	PLCTAG_NM_MOTORE60_RitornoInvertito
	PLCTAG_NM_MOTORE60_TipoInversione
	PLCTAG_NM_MOTORE60_IO_InverterPresente
	PLCTAG_NM_MOTORE60_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE60_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE60_Esclusioni_Uscita
	PLCTAG_NM_MOTORE60_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE60_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE60_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE60_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE60_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE60_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE60_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE60_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE60_Timeout_Avvio
	PLCTAG_NM_MOTORE60_Timeout_Arresto
	PLCTAG_NM_MOTORE60_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE60_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE60_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE60_Antislittamento_Presente
	PLCTAG_NM_MOTORE60_Antislittamento_Tempo
	PLCTAG_NM_MOTORE60_Amperometri_Presente
	PLCTAG_NM_MOTORE60_Amperometri_LimMin
	PLCTAG_NM_MOTORE60_Amperometri_LimMax
	PLCTAG_NM_MOTORE60_Amperometri_MaxOut
	PLCTAG_NM_MOTORE61_Presente
	PLCTAG_NM_MOTORE61_UscitaInvertita
	PLCTAG_NM_MOTORE61_RitornoInvertito
	PLCTAG_NM_MOTORE61_TipoInversione
	PLCTAG_NM_MOTORE61_IO_InverterPresente
	PLCTAG_NM_MOTORE61_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE61_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE61_Esclusioni_Uscita
	PLCTAG_NM_MOTORE61_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE61_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE61_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE61_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE61_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE61_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE61_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE61_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE61_Timeout_Avvio
	PLCTAG_NM_MOTORE61_Timeout_Arresto
	PLCTAG_NM_MOTORE61_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE61_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE61_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE61_Antislittamento_Presente
	PLCTAG_NM_MOTORE61_Antislittamento_Tempo
	PLCTAG_NM_MOTORE61_Amperometri_Presente
	PLCTAG_NM_MOTORE61_Amperometri_LimMin
	PLCTAG_NM_MOTORE61_Amperometri_LimMax
	PLCTAG_NM_MOTORE61_Amperometri_MaxOut
	PLCTAG_NM_MOTORE62_Presente
	PLCTAG_NM_MOTORE62_UscitaInvertita
	PLCTAG_NM_MOTORE62_RitornoInvertito
	PLCTAG_NM_MOTORE62_TipoInversione
	PLCTAG_NM_MOTORE62_IO_InverterPresente
	PLCTAG_NM_MOTORE62_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE62_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE62_Esclusioni_Uscita
	PLCTAG_NM_MOTORE62_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE62_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE62_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE62_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE62_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE62_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE62_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE62_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE62_Timeout_Avvio
	PLCTAG_NM_MOTORE62_Timeout_Arresto
	PLCTAG_NM_MOTORE62_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE62_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE62_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE62_Antislittamento_Presente
	PLCTAG_NM_MOTORE62_Antislittamento_Tempo
	PLCTAG_NM_MOTORE62_Amperometri_Presente
	PLCTAG_NM_MOTORE62_Amperometri_LimMin
	PLCTAG_NM_MOTORE62_Amperometri_LimMax
	PLCTAG_NM_MOTORE62_Amperometri_MaxOut
	PLCTAG_NM_MOTORE63_Presente
	PLCTAG_NM_MOTORE63_UscitaInvertita
	PLCTAG_NM_MOTORE63_RitornoInvertito
	PLCTAG_NM_MOTORE63_TipoInversione
	PLCTAG_NM_MOTORE63_IO_InverterPresente
	PLCTAG_NM_MOTORE63_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE63_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE63_Esclusioni_Uscita
	PLCTAG_NM_MOTORE63_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE63_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE63_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE63_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE63_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE63_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE63_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE63_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE63_Timeout_Avvio
	PLCTAG_NM_MOTORE63_Timeout_Arresto
	PLCTAG_NM_MOTORE63_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE63_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE63_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE63_Antislittamento_Presente
	PLCTAG_NM_MOTORE63_Antislittamento_Tempo
	PLCTAG_NM_MOTORE63_Amperometri_Presente
	PLCTAG_NM_MOTORE63_Amperometri_LimMin
	PLCTAG_NM_MOTORE63_Amperometri_LimMax
	PLCTAG_NM_MOTORE63_Amperometri_MaxOut
	PLCTAG_NM_MOTORE64_Presente
	PLCTAG_NM_MOTORE64_UscitaInvertita
	PLCTAG_NM_MOTORE64_RitornoInvertito
	PLCTAG_NM_MOTORE64_TipoInversione
	PLCTAG_NM_MOTORE64_IO_InverterPresente
	PLCTAG_NM_MOTORE64_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE64_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE64_Esclusioni_Uscita
	PLCTAG_NM_MOTORE64_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE64_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE64_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE64_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE64_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE64_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE64_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE64_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE64_Timeout_Avvio
	PLCTAG_NM_MOTORE64_Timeout_Arresto
	PLCTAG_NM_MOTORE64_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE64_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE64_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE64_Antislittamento_Presente
	PLCTAG_NM_MOTORE64_Antislittamento_Tempo
	PLCTAG_NM_MOTORE64_Amperometri_Presente
	PLCTAG_NM_MOTORE64_Amperometri_LimMin
	PLCTAG_NM_MOTORE64_Amperometri_LimMax
	PLCTAG_NM_MOTORE64_Amperometri_MaxOut
	PLCTAG_NM_MOTORE65_Presente
	PLCTAG_NM_MOTORE65_UscitaInvertita
	PLCTAG_NM_MOTORE65_RitornoInvertito
	PLCTAG_NM_MOTORE65_TipoInversione
	PLCTAG_NM_MOTORE65_IO_InverterPresente
	PLCTAG_NM_MOTORE65_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE65_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE65_Esclusioni_Uscita
	PLCTAG_NM_MOTORE65_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE65_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE65_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE65_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE65_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE65_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE65_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE65_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE65_Timeout_Avvio
	PLCTAG_NM_MOTORE65_Timeout_Arresto
	PLCTAG_NM_MOTORE65_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE65_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE65_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE65_Antislittamento_Presente
	PLCTAG_NM_MOTORE65_Antislittamento_Tempo
	PLCTAG_NM_MOTORE65_Amperometri_Presente
	PLCTAG_NM_MOTORE65_Amperometri_LimMin
	PLCTAG_NM_MOTORE65_Amperometri_LimMax
	PLCTAG_NM_MOTORE65_Amperometri_MaxOut
	PLCTAG_NM_MOTORE66_Presente
	PLCTAG_NM_MOTORE66_UscitaInvertita
	PLCTAG_NM_MOTORE66_RitornoInvertito
	PLCTAG_NM_MOTORE66_TipoInversione
	PLCTAG_NM_MOTORE66_IO_InverterPresente
	PLCTAG_NM_MOTORE66_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE66_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE66_Esclusioni_Uscita
	PLCTAG_NM_MOTORE66_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE66_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE66_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE66_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE66_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE66_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE66_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE66_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE66_Timeout_Avvio
	PLCTAG_NM_MOTORE66_Timeout_Arresto
	PLCTAG_NM_MOTORE66_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE66_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE66_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE66_Antislittamento_Presente
	PLCTAG_NM_MOTORE66_Antislittamento_Tempo
	PLCTAG_NM_MOTORE66_Amperometri_Presente
	PLCTAG_NM_MOTORE66_Amperometri_LimMin
	PLCTAG_NM_MOTORE66_Amperometri_LimMax
	PLCTAG_NM_MOTORE66_Amperometri_MaxOut
	PLCTAG_NM_MOTORE67_Presente
	PLCTAG_NM_MOTORE67_UscitaInvertita
	PLCTAG_NM_MOTORE67_RitornoInvertito
	PLCTAG_NM_MOTORE67_TipoInversione
	PLCTAG_NM_MOTORE67_IO_InverterPresente
	PLCTAG_NM_MOTORE67_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE67_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE67_Esclusioni_Uscita
	PLCTAG_NM_MOTORE67_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE67_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE67_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE67_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE67_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE67_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE67_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE67_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE67_Timeout_Avvio
	PLCTAG_NM_MOTORE67_Timeout_Arresto
	PLCTAG_NM_MOTORE67_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE67_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE67_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE67_Antislittamento_Presente
	PLCTAG_NM_MOTORE67_Antislittamento_Tempo
	PLCTAG_NM_MOTORE67_Amperometri_Presente
	PLCTAG_NM_MOTORE67_Amperometri_LimMin
	PLCTAG_NM_MOTORE67_Amperometri_LimMax
	PLCTAG_NM_MOTORE67_Amperometri_MaxOut
	PLCTAG_NM_MOTORE68_Presente
	PLCTAG_NM_MOTORE68_UscitaInvertita
	PLCTAG_NM_MOTORE68_RitornoInvertito
	PLCTAG_NM_MOTORE68_TipoInversione
	PLCTAG_NM_MOTORE68_IO_InverterPresente
	PLCTAG_NM_MOTORE68_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE68_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE68_Esclusioni_Uscita
	PLCTAG_NM_MOTORE68_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE68_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE68_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE68_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE68_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE68_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE68_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE68_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE68_Timeout_Avvio
	PLCTAG_NM_MOTORE68_Timeout_Arresto
	PLCTAG_NM_MOTORE68_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE68_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE68_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE68_Antislittamento_Presente
	PLCTAG_NM_MOTORE68_Antislittamento_Tempo
	PLCTAG_NM_MOTORE68_Amperometri_Presente
	PLCTAG_NM_MOTORE68_Amperometri_LimMin
	PLCTAG_NM_MOTORE68_Amperometri_LimMax
	PLCTAG_NM_MOTORE68_Amperometri_MaxOut
	PLCTAG_NM_MOTORE69_Presente
	PLCTAG_NM_MOTORE69_UscitaInvertita
	PLCTAG_NM_MOTORE69_RitornoInvertito
	PLCTAG_NM_MOTORE69_TipoInversione
	PLCTAG_NM_MOTORE69_IO_InverterPresente
	PLCTAG_NM_MOTORE69_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE69_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE69_Esclusioni_Uscita
	PLCTAG_NM_MOTORE69_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE69_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE69_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE69_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE69_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE69_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE69_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE69_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE69_Timeout_Avvio
	PLCTAG_NM_MOTORE69_Timeout_Arresto
	PLCTAG_NM_MOTORE69_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE69_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE69_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE69_Antislittamento_Presente
	PLCTAG_NM_MOTORE69_Antislittamento_Tempo
	PLCTAG_NM_MOTORE69_Amperometri_Presente
	PLCTAG_NM_MOTORE69_Amperometri_LimMin
	PLCTAG_NM_MOTORE69_Amperometri_LimMax
	PLCTAG_NM_MOTORE69_Amperometri_MaxOut
	PLCTAG_NM_MOTORE70_Presente
	PLCTAG_NM_MOTORE70_UscitaInvertita
	PLCTAG_NM_MOTORE70_RitornoInvertito
	PLCTAG_NM_MOTORE70_TipoInversione
	PLCTAG_NM_MOTORE70_IO_InverterPresente
	PLCTAG_NM_MOTORE70_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE70_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE70_Esclusioni_Uscita
	PLCTAG_NM_MOTORE70_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE70_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE70_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE70_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE70_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE70_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE70_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE70_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE70_Timeout_Avvio
	PLCTAG_NM_MOTORE70_Timeout_Arresto
	PLCTAG_NM_MOTORE70_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE70_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE70_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE70_Antislittamento_Presente
	PLCTAG_NM_MOTORE70_Antislittamento_Tempo
	PLCTAG_NM_MOTORE70_Amperometri_Presente
	PLCTAG_NM_MOTORE70_Amperometri_LimMin
	PLCTAG_NM_MOTORE70_Amperometri_LimMax
	PLCTAG_NM_MOTORE70_Amperometri_MaxOut
	PLCTAG_NM_MOTORE71_Presente
	PLCTAG_NM_MOTORE71_UscitaInvertita
	PLCTAG_NM_MOTORE71_RitornoInvertito
	PLCTAG_NM_MOTORE71_TipoInversione
	PLCTAG_NM_MOTORE71_IO_InverterPresente
	PLCTAG_NM_MOTORE71_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE71_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE71_Esclusioni_Uscita
	PLCTAG_NM_MOTORE71_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE71_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE71_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE71_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE71_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE71_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE71_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE71_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE71_Timeout_Avvio
	PLCTAG_NM_MOTORE71_Timeout_Arresto
	PLCTAG_NM_MOTORE71_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE71_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE71_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE71_Antislittamento_Presente
	PLCTAG_NM_MOTORE71_Antislittamento_Tempo
	PLCTAG_NM_MOTORE71_Amperometri_Presente
	PLCTAG_NM_MOTORE71_Amperometri_LimMin
	PLCTAG_NM_MOTORE71_Amperometri_LimMax
	PLCTAG_NM_MOTORE71_Amperometri_MaxOut
	PLCTAG_NM_MOTORE72_Presente
	PLCTAG_NM_MOTORE72_UscitaInvertita
	PLCTAG_NM_MOTORE72_RitornoInvertito
	PLCTAG_NM_MOTORE72_TipoInversione
	PLCTAG_NM_MOTORE72_IO_InverterPresente
	PLCTAG_NM_MOTORE72_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE72_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE72_Esclusioni_Uscita
	PLCTAG_NM_MOTORE72_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE72_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE72_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE72_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE72_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE72_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE72_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE72_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE72_Timeout_Avvio
	PLCTAG_NM_MOTORE72_Timeout_Arresto
	PLCTAG_NM_MOTORE72_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE72_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE72_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE72_Antislittamento_Presente
	PLCTAG_NM_MOTORE72_Antislittamento_Tempo
	PLCTAG_NM_MOTORE72_Amperometri_Presente
	PLCTAG_NM_MOTORE72_Amperometri_LimMin
	PLCTAG_NM_MOTORE72_Amperometri_LimMax
	PLCTAG_NM_MOTORE72_Amperometri_MaxOut
	PLCTAG_NM_MOTORE73_Presente
	PLCTAG_NM_MOTORE73_UscitaInvertita
	PLCTAG_NM_MOTORE73_RitornoInvertito
	PLCTAG_NM_MOTORE73_TipoInversione
	PLCTAG_NM_MOTORE73_IO_InverterPresente
	PLCTAG_NM_MOTORE73_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE73_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE73_Esclusioni_Uscita
	PLCTAG_NM_MOTORE73_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE73_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE73_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE73_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE73_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE73_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE73_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE73_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE73_Timeout_Avvio
	PLCTAG_NM_MOTORE73_Timeout_Arresto
	PLCTAG_NM_MOTORE73_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE73_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE73_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE73_Antislittamento_Presente
	PLCTAG_NM_MOTORE73_Antislittamento_Tempo
	PLCTAG_NM_MOTORE73_Amperometri_Presente
	PLCTAG_NM_MOTORE73_Amperometri_LimMin
	PLCTAG_NM_MOTORE73_Amperometri_LimMax
	PLCTAG_NM_MOTORE73_Amperometri_MaxOut
	PLCTAG_NM_MOTORE74_Presente
	PLCTAG_NM_MOTORE74_UscitaInvertita
	PLCTAG_NM_MOTORE74_RitornoInvertito
	PLCTAG_NM_MOTORE74_TipoInversione
	PLCTAG_NM_MOTORE74_IO_InverterPresente
	PLCTAG_NM_MOTORE74_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE74_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE74_Esclusioni_Uscita
	PLCTAG_NM_MOTORE74_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE74_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE74_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE74_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE74_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE74_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE74_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE74_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE74_Timeout_Avvio
	PLCTAG_NM_MOTORE74_Timeout_Arresto
	PLCTAG_NM_MOTORE74_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE74_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE74_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE74_Antislittamento_Presente
	PLCTAG_NM_MOTORE74_Antislittamento_Tempo
	PLCTAG_NM_MOTORE74_Amperometri_Presente
	PLCTAG_NM_MOTORE74_Amperometri_LimMin
	PLCTAG_NM_MOTORE74_Amperometri_LimMax
	PLCTAG_NM_MOTORE74_Amperometri_MaxOut
	PLCTAG_NM_MOTORE75_Presente
	PLCTAG_NM_MOTORE75_UscitaInvertita
	PLCTAG_NM_MOTORE75_RitornoInvertito
	PLCTAG_NM_MOTORE75_TipoInversione
	PLCTAG_NM_MOTORE75_IO_InverterPresente
	PLCTAG_NM_MOTORE75_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE75_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE75_Esclusioni_Uscita
	PLCTAG_NM_MOTORE75_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE75_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE75_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE75_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE75_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE75_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE75_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE75_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE75_Timeout_Avvio
	PLCTAG_NM_MOTORE75_Timeout_Arresto
	PLCTAG_NM_MOTORE75_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE75_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE75_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE75_Antislittamento_Presente
	PLCTAG_NM_MOTORE75_Antislittamento_Tempo
	PLCTAG_NM_MOTORE75_Amperometri_Presente
	PLCTAG_NM_MOTORE75_Amperometri_LimMin
	PLCTAG_NM_MOTORE75_Amperometri_LimMax
	PLCTAG_NM_MOTORE75_Amperometri_MaxOut
	PLCTAG_NM_MOTORE76_Presente
	PLCTAG_NM_MOTORE76_UscitaInvertita
	PLCTAG_NM_MOTORE76_RitornoInvertito
	PLCTAG_NM_MOTORE76_TipoInversione
	PLCTAG_NM_MOTORE76_IO_InverterPresente
	PLCTAG_NM_MOTORE76_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE76_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE76_Esclusioni_Uscita
	PLCTAG_NM_MOTORE76_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE76_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE76_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE76_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE76_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE76_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE76_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE76_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE76_Timeout_Avvio
	PLCTAG_NM_MOTORE76_Timeout_Arresto
	PLCTAG_NM_MOTORE76_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE76_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE76_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE76_Antislittamento_Presente
	PLCTAG_NM_MOTORE76_Antislittamento_Tempo
	PLCTAG_NM_MOTORE76_Amperometri_Presente
	PLCTAG_NM_MOTORE76_Amperometri_LimMin
	PLCTAG_NM_MOTORE76_Amperometri_LimMax
	PLCTAG_NM_MOTORE76_Amperometri_MaxOut
	PLCTAG_NM_MOTORE77_Presente
	PLCTAG_NM_MOTORE77_UscitaInvertita
	PLCTAG_NM_MOTORE77_RitornoInvertito
	PLCTAG_NM_MOTORE77_TipoInversione
	PLCTAG_NM_MOTORE77_IO_InverterPresente
	PLCTAG_NM_MOTORE77_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE77_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE77_Esclusioni_Uscita
	PLCTAG_NM_MOTORE77_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE77_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE77_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE77_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE77_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE77_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE77_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE77_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE77_Timeout_Avvio
	PLCTAG_NM_MOTORE77_Timeout_Arresto
	PLCTAG_NM_MOTORE77_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE77_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE77_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE77_Antislittamento_Presente
	PLCTAG_NM_MOTORE77_Antislittamento_Tempo
	PLCTAG_NM_MOTORE77_Amperometri_Presente
	PLCTAG_NM_MOTORE77_Amperometri_LimMin
	PLCTAG_NM_MOTORE77_Amperometri_LimMax
	PLCTAG_NM_MOTORE77_Amperometri_MaxOut
	PLCTAG_NM_MOTORE78_Presente
	PLCTAG_NM_MOTORE78_UscitaInvertita
	PLCTAG_NM_MOTORE78_RitornoInvertito
	PLCTAG_NM_MOTORE78_TipoInversione
	PLCTAG_NM_MOTORE78_IO_InverterPresente
	PLCTAG_NM_MOTORE78_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE78_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE78_Esclusioni_Uscita
	PLCTAG_NM_MOTORE78_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE78_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE78_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE78_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE78_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE78_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE78_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE78_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE78_Timeout_Avvio
	PLCTAG_NM_MOTORE78_Timeout_Arresto
	PLCTAG_NM_MOTORE78_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE78_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE78_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE78_Antislittamento_Presente
	PLCTAG_NM_MOTORE78_Antislittamento_Tempo
	PLCTAG_NM_MOTORE78_Amperometri_Presente
	PLCTAG_NM_MOTORE78_Amperometri_LimMin
	PLCTAG_NM_MOTORE78_Amperometri_LimMax
	PLCTAG_NM_MOTORE78_Amperometri_MaxOut
	PLCTAG_NM_MOTORE79_Presente
	PLCTAG_NM_MOTORE79_UscitaInvertita
	PLCTAG_NM_MOTORE79_RitornoInvertito
	PLCTAG_NM_MOTORE79_TipoInversione
	PLCTAG_NM_MOTORE79_IO_InverterPresente
	PLCTAG_NM_MOTORE79_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE79_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE79_Esclusioni_Uscita
	PLCTAG_NM_MOTORE79_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE79_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE79_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE79_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE79_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE79_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE79_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE79_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE79_Timeout_Avvio
	PLCTAG_NM_MOTORE79_Timeout_Arresto
	PLCTAG_NM_MOTORE79_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE79_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE79_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE79_Antislittamento_Presente
	PLCTAG_NM_MOTORE79_Antislittamento_Tempo
	PLCTAG_NM_MOTORE79_Amperometri_Presente
	PLCTAG_NM_MOTORE79_Amperometri_LimMin
	PLCTAG_NM_MOTORE79_Amperometri_LimMax
	PLCTAG_NM_MOTORE79_Amperometri_MaxOut
	PLCTAG_NM_MOTORE80_Presente
	PLCTAG_NM_MOTORE80_UscitaInvertita
	PLCTAG_NM_MOTORE80_RitornoInvertito
	PLCTAG_NM_MOTORE80_TipoInversione
	PLCTAG_NM_MOTORE80_IO_InverterPresente
	PLCTAG_NM_MOTORE80_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE80_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE80_Esclusioni_Uscita
	PLCTAG_NM_MOTORE80_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE80_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE80_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE80_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE80_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE80_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE80_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE80_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE80_Timeout_Avvio
	PLCTAG_NM_MOTORE80_Timeout_Arresto
	PLCTAG_NM_MOTORE80_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE80_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE80_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE80_Antislittamento_Presente
	PLCTAG_NM_MOTORE80_Antislittamento_Tempo
	PLCTAG_NM_MOTORE80_Amperometri_Presente
	PLCTAG_NM_MOTORE80_Amperometri_LimMin
	PLCTAG_NM_MOTORE80_Amperometri_LimMax
	PLCTAG_NM_MOTORE80_Amperometri_MaxOut
	PLCTAG_NM_MOTORE81_Presente
	PLCTAG_NM_MOTORE81_UscitaInvertita
	PLCTAG_NM_MOTORE81_RitornoInvertito
	PLCTAG_NM_MOTORE81_TipoInversione
	PLCTAG_NM_MOTORE81_IO_InverterPresente
	PLCTAG_NM_MOTORE81_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE81_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE81_Esclusioni_Uscita
	PLCTAG_NM_MOTORE81_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE81_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE81_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE81_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE81_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE81_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE81_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE81_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE81_Timeout_Avvio
	PLCTAG_NM_MOTORE81_Timeout_Arresto
	PLCTAG_NM_MOTORE81_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE81_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE81_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE81_Antislittamento_Presente
	PLCTAG_NM_MOTORE81_Antislittamento_Tempo
	PLCTAG_NM_MOTORE81_Amperometri_Presente
	PLCTAG_NM_MOTORE81_Amperometri_LimMin
	PLCTAG_NM_MOTORE81_Amperometri_LimMax
	PLCTAG_NM_MOTORE81_Amperometri_MaxOut
	PLCTAG_NM_MOTORE82_Presente
	PLCTAG_NM_MOTORE82_UscitaInvertita
	PLCTAG_NM_MOTORE82_RitornoInvertito
	PLCTAG_NM_MOTORE82_TipoInversione
	PLCTAG_NM_MOTORE82_IO_InverterPresente
	PLCTAG_NM_MOTORE82_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE82_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE82_Esclusioni_Uscita
	PLCTAG_NM_MOTORE82_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE82_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE82_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE82_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE82_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE82_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE82_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE82_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE82_Timeout_Avvio
	PLCTAG_NM_MOTORE82_Timeout_Arresto
	PLCTAG_NM_MOTORE82_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE82_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE82_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE82_Antislittamento_Presente
	PLCTAG_NM_MOTORE82_Antislittamento_Tempo
	PLCTAG_NM_MOTORE82_Amperometri_Presente
	PLCTAG_NM_MOTORE82_Amperometri_LimMin
	PLCTAG_NM_MOTORE82_Amperometri_LimMax
	PLCTAG_NM_MOTORE82_Amperometri_MaxOut
	PLCTAG_NM_MOTORE83_Presente
	PLCTAG_NM_MOTORE83_UscitaInvertita
	PLCTAG_NM_MOTORE83_RitornoInvertito
	PLCTAG_NM_MOTORE83_TipoInversione
	PLCTAG_NM_MOTORE83_IO_InverterPresente
	PLCTAG_NM_MOTORE83_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE83_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE83_Esclusioni_Uscita
	PLCTAG_NM_MOTORE83_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE83_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE83_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE83_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE83_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE83_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE83_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE83_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE83_Timeout_Avvio
	PLCTAG_NM_MOTORE83_Timeout_Arresto
	PLCTAG_NM_MOTORE83_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE83_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE83_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE83_Antislittamento_Presente
	PLCTAG_NM_MOTORE83_Antislittamento_Tempo
	PLCTAG_NM_MOTORE83_Amperometri_Presente
	PLCTAG_NM_MOTORE83_Amperometri_LimMin
	PLCTAG_NM_MOTORE83_Amperometri_LimMax
	PLCTAG_NM_MOTORE83_Amperometri_MaxOut
	PLCTAG_NM_MOTORE84_Presente
	PLCTAG_NM_MOTORE84_UscitaInvertita
	PLCTAG_NM_MOTORE84_RitornoInvertito
	PLCTAG_NM_MOTORE84_TipoInversione
	PLCTAG_NM_MOTORE84_IO_InverterPresente
	PLCTAG_NM_MOTORE84_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE84_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE84_Esclusioni_Uscita
	PLCTAG_NM_MOTORE84_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE84_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE84_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE84_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE84_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE84_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE84_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE84_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE84_Timeout_Avvio
	PLCTAG_NM_MOTORE84_Timeout_Arresto
	PLCTAG_NM_MOTORE84_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE84_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE84_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE84_Antislittamento_Presente
	PLCTAG_NM_MOTORE84_Antislittamento_Tempo
	PLCTAG_NM_MOTORE84_Amperometri_Presente
	PLCTAG_NM_MOTORE84_Amperometri_LimMin
	PLCTAG_NM_MOTORE84_Amperometri_LimMax
	PLCTAG_NM_MOTORE84_Amperometri_MaxOut
	PLCTAG_NM_MOTORE85_Presente
	PLCTAG_NM_MOTORE85_UscitaInvertita
	PLCTAG_NM_MOTORE85_RitornoInvertito
	PLCTAG_NM_MOTORE85_TipoInversione
	PLCTAG_NM_MOTORE85_IO_InverterPresente
	PLCTAG_NM_MOTORE85_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE85_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE85_Esclusioni_Uscita
	PLCTAG_NM_MOTORE85_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE85_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE85_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE85_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE85_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE85_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE85_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE85_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE85_Timeout_Avvio
	PLCTAG_NM_MOTORE85_Timeout_Arresto
	PLCTAG_NM_MOTORE85_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE85_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE85_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE85_Antislittamento_Presente
	PLCTAG_NM_MOTORE85_Antislittamento_Tempo
	PLCTAG_NM_MOTORE85_Amperometri_Presente
	PLCTAG_NM_MOTORE85_Amperometri_LimMin
	PLCTAG_NM_MOTORE85_Amperometri_LimMax
	PLCTAG_NM_MOTORE85_Amperometri_MaxOut
	PLCTAG_NM_MOTORE86_Presente
	PLCTAG_NM_MOTORE86_UscitaInvertita
	PLCTAG_NM_MOTORE86_RitornoInvertito
	PLCTAG_NM_MOTORE86_TipoInversione
	PLCTAG_NM_MOTORE86_IO_InverterPresente
	PLCTAG_NM_MOTORE86_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE86_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE86_Esclusioni_Uscita
	PLCTAG_NM_MOTORE86_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE86_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE86_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE86_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE86_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE86_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE86_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE86_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE86_Timeout_Avvio
	PLCTAG_NM_MOTORE86_Timeout_Arresto
	PLCTAG_NM_MOTORE86_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE86_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE86_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE86_Antislittamento_Presente
	PLCTAG_NM_MOTORE86_Antislittamento_Tempo
	PLCTAG_NM_MOTORE86_Amperometri_Presente
	PLCTAG_NM_MOTORE86_Amperometri_LimMin
	PLCTAG_NM_MOTORE86_Amperometri_LimMax
	PLCTAG_NM_MOTORE86_Amperometri_MaxOut
	PLCTAG_NM_MOTORE87_Presente
	PLCTAG_NM_MOTORE87_UscitaInvertita
	PLCTAG_NM_MOTORE87_RitornoInvertito
	PLCTAG_NM_MOTORE87_TipoInversione
	PLCTAG_NM_MOTORE87_IO_InverterPresente
	PLCTAG_NM_MOTORE87_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE87_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE87_Esclusioni_Uscita
	PLCTAG_NM_MOTORE87_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE87_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE87_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE87_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE87_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE87_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE87_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE87_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE87_Timeout_Avvio
	PLCTAG_NM_MOTORE87_Timeout_Arresto
	PLCTAG_NM_MOTORE87_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE87_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE87_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE87_Antislittamento_Presente
	PLCTAG_NM_MOTORE87_Antislittamento_Tempo
	PLCTAG_NM_MOTORE87_Amperometri_Presente
	PLCTAG_NM_MOTORE87_Amperometri_LimMin
	PLCTAG_NM_MOTORE87_Amperometri_LimMax
	PLCTAG_NM_MOTORE87_Amperometri_MaxOut
	PLCTAG_NM_MOTORE88_Presente
	PLCTAG_NM_MOTORE88_UscitaInvertita
	PLCTAG_NM_MOTORE88_RitornoInvertito
	PLCTAG_NM_MOTORE88_TipoInversione
	PLCTAG_NM_MOTORE88_IO_InverterPresente
	PLCTAG_NM_MOTORE88_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE88_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE88_Esclusioni_Uscita
	PLCTAG_NM_MOTORE88_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE88_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE88_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE88_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE88_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE88_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE88_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE88_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE88_Timeout_Avvio
	PLCTAG_NM_MOTORE88_Timeout_Arresto
	PLCTAG_NM_MOTORE88_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE88_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE88_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE88_Antislittamento_Presente
	PLCTAG_NM_MOTORE88_Antislittamento_Tempo
	PLCTAG_NM_MOTORE88_Amperometri_Presente
	PLCTAG_NM_MOTORE88_Amperometri_LimMin
	PLCTAG_NM_MOTORE88_Amperometri_LimMax
	PLCTAG_NM_MOTORE88_Amperometri_MaxOut
	PLCTAG_NM_MOTORE89_Presente
	PLCTAG_NM_MOTORE89_UscitaInvertita
	PLCTAG_NM_MOTORE89_RitornoInvertito
	PLCTAG_NM_MOTORE89_TipoInversione
	PLCTAG_NM_MOTORE89_IO_InverterPresente
	PLCTAG_NM_MOTORE89_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE89_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE89_Esclusioni_Uscita
	PLCTAG_NM_MOTORE89_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE89_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE89_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE89_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE89_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE89_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE89_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE89_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE89_Timeout_Avvio
	PLCTAG_NM_MOTORE89_Timeout_Arresto
	PLCTAG_NM_MOTORE89_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE89_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE89_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE89_Antislittamento_Presente
	PLCTAG_NM_MOTORE89_Antislittamento_Tempo
	PLCTAG_NM_MOTORE89_Amperometri_Presente
	PLCTAG_NM_MOTORE89_Amperometri_LimMin
	PLCTAG_NM_MOTORE89_Amperometri_LimMax
	PLCTAG_NM_MOTORE89_Amperometri_MaxOut
	PLCTAG_NM_MOTORE90_Presente
	PLCTAG_NM_MOTORE90_UscitaInvertita
	PLCTAG_NM_MOTORE90_RitornoInvertito
	PLCTAG_NM_MOTORE90_TipoInversione
	PLCTAG_NM_MOTORE90_IO_InverterPresente
	PLCTAG_NM_MOTORE90_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE90_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE90_Esclusioni_Uscita
	PLCTAG_NM_MOTORE90_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE90_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE90_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE90_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE90_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE90_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE90_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE90_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE90_Timeout_Avvio
	PLCTAG_NM_MOTORE90_Timeout_Arresto
	PLCTAG_NM_MOTORE90_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE90_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE90_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE90_Antislittamento_Presente
	PLCTAG_NM_MOTORE90_Antislittamento_Tempo
	PLCTAG_NM_MOTORE90_Amperometri_Presente
	PLCTAG_NM_MOTORE90_Amperometri_LimMin
	PLCTAG_NM_MOTORE90_Amperometri_LimMax
	PLCTAG_NM_MOTORE90_Amperometri_MaxOut
	PLCTAG_NM_MOTORE91_Presente
	PLCTAG_NM_MOTORE91_UscitaInvertita
	PLCTAG_NM_MOTORE91_RitornoInvertito
	PLCTAG_NM_MOTORE91_TipoInversione
	PLCTAG_NM_MOTORE91_IO_InverterPresente
	PLCTAG_NM_MOTORE91_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE91_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE91_Esclusioni_Uscita
	PLCTAG_NM_MOTORE91_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE91_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE91_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE91_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE91_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE91_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE91_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE91_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE91_Timeout_Avvio
	PLCTAG_NM_MOTORE91_Timeout_Arresto
	PLCTAG_NM_MOTORE91_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE91_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE91_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE91_Antislittamento_Presente
	PLCTAG_NM_MOTORE91_Antislittamento_Tempo
	PLCTAG_NM_MOTORE91_Amperometri_Presente
	PLCTAG_NM_MOTORE91_Amperometri_LimMin
	PLCTAG_NM_MOTORE91_Amperometri_LimMax
	PLCTAG_NM_MOTORE91_Amperometri_MaxOut
	PLCTAG_NM_MOTORE92_Presente
	PLCTAG_NM_MOTORE92_UscitaInvertita
	PLCTAG_NM_MOTORE92_RitornoInvertito
	PLCTAG_NM_MOTORE92_TipoInversione
	PLCTAG_NM_MOTORE92_IO_InverterPresente
	PLCTAG_NM_MOTORE92_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE92_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE92_Esclusioni_Uscita
	PLCTAG_NM_MOTORE92_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE92_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE92_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE92_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE92_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE92_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE92_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE92_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE92_Timeout_Avvio
	PLCTAG_NM_MOTORE92_Timeout_Arresto
	PLCTAG_NM_MOTORE92_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE92_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE92_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE92_Antislittamento_Presente
	PLCTAG_NM_MOTORE92_Antislittamento_Tempo
	PLCTAG_NM_MOTORE92_Amperometri_Presente
	PLCTAG_NM_MOTORE92_Amperometri_LimMin
	PLCTAG_NM_MOTORE92_Amperometri_LimMax
	PLCTAG_NM_MOTORE92_Amperometri_MaxOut
	PLCTAG_NM_MOTORE93_Presente
	PLCTAG_NM_MOTORE93_UscitaInvertita
	PLCTAG_NM_MOTORE93_RitornoInvertito
	PLCTAG_NM_MOTORE93_TipoInversione
	PLCTAG_NM_MOTORE93_IO_InverterPresente
	PLCTAG_NM_MOTORE93_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE93_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE93_Esclusioni_Uscita
	PLCTAG_NM_MOTORE93_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE93_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE93_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE93_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE93_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE93_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE93_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE93_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE93_Timeout_Avvio
	PLCTAG_NM_MOTORE93_Timeout_Arresto
	PLCTAG_NM_MOTORE93_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE93_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE93_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE93_Antislittamento_Presente
	PLCTAG_NM_MOTORE93_Antislittamento_Tempo
	PLCTAG_NM_MOTORE93_Amperometri_Presente
	PLCTAG_NM_MOTORE93_Amperometri_LimMin
	PLCTAG_NM_MOTORE93_Amperometri_LimMax
	PLCTAG_NM_MOTORE93_Amperometri_MaxOut
	PLCTAG_NM_MOTORE94_Presente
	PLCTAG_NM_MOTORE94_UscitaInvertita
	PLCTAG_NM_MOTORE94_RitornoInvertito
	PLCTAG_NM_MOTORE94_TipoInversione
	PLCTAG_NM_MOTORE94_IO_InverterPresente
	PLCTAG_NM_MOTORE94_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE94_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE94_Esclusioni_Uscita
	PLCTAG_NM_MOTORE94_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE94_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE94_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE94_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE94_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE94_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE94_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE94_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE94_Timeout_Avvio
	PLCTAG_NM_MOTORE94_Timeout_Arresto
	PLCTAG_NM_MOTORE94_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE94_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE94_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE94_Antislittamento_Presente
	PLCTAG_NM_MOTORE94_Antislittamento_Tempo
	PLCTAG_NM_MOTORE94_Amperometri_Presente
	PLCTAG_NM_MOTORE94_Amperometri_LimMin
	PLCTAG_NM_MOTORE94_Amperometri_LimMax
	PLCTAG_NM_MOTORE94_Amperometri_MaxOut
	PLCTAG_NM_MOTORE95_Presente
	PLCTAG_NM_MOTORE95_UscitaInvertita
	PLCTAG_NM_MOTORE95_RitornoInvertito
	PLCTAG_NM_MOTORE95_TipoInversione
	PLCTAG_NM_MOTORE95_IO_InverterPresente
	PLCTAG_NM_MOTORE95_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE95_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE95_Esclusioni_Uscita
	PLCTAG_NM_MOTORE95_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE95_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE95_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE95_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE95_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE95_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE95_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE95_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE95_Timeout_Avvio
	PLCTAG_NM_MOTORE95_Timeout_Arresto
	PLCTAG_NM_MOTORE95_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE95_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE95_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE95_Antislittamento_Presente
	PLCTAG_NM_MOTORE95_Antislittamento_Tempo
	PLCTAG_NM_MOTORE95_Amperometri_Presente
	PLCTAG_NM_MOTORE95_Amperometri_LimMin
	PLCTAG_NM_MOTORE95_Amperometri_LimMax
	PLCTAG_NM_MOTORE95_Amperometri_MaxOut
	PLCTAG_NM_MOTORE96_Presente
	PLCTAG_NM_MOTORE96_UscitaInvertita
	PLCTAG_NM_MOTORE96_RitornoInvertito
	PLCTAG_NM_MOTORE96_TipoInversione
	PLCTAG_NM_MOTORE96_IO_InverterPresente
	PLCTAG_NM_MOTORE96_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE96_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE96_Esclusioni_Uscita
	PLCTAG_NM_MOTORE96_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE96_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE96_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE96_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE96_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE96_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE96_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE96_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE96_Timeout_Avvio
	PLCTAG_NM_MOTORE96_Timeout_Arresto
	PLCTAG_NM_MOTORE96_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE96_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE96_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE96_Antislittamento_Presente
	PLCTAG_NM_MOTORE96_Antislittamento_Tempo
	PLCTAG_NM_MOTORE96_Amperometri_Presente
	PLCTAG_NM_MOTORE96_Amperometri_LimMin
	PLCTAG_NM_MOTORE96_Amperometri_LimMax
	PLCTAG_NM_MOTORE96_Amperometri_MaxOut
	PLCTAG_NM_MOTORE97_Presente
	PLCTAG_NM_MOTORE97_UscitaInvertita
	PLCTAG_NM_MOTORE97_RitornoInvertito
	PLCTAG_NM_MOTORE97_TipoInversione
	PLCTAG_NM_MOTORE97_IO_InverterPresente
	PLCTAG_NM_MOTORE97_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE97_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE97_Esclusioni_Uscita
	PLCTAG_NM_MOTORE97_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE97_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE97_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE97_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE97_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE97_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE97_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE97_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE97_Timeout_Avvio
	PLCTAG_NM_MOTORE97_Timeout_Arresto
	PLCTAG_NM_MOTORE97_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE97_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE97_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE97_Antislittamento_Presente
	PLCTAG_NM_MOTORE97_Antislittamento_Tempo
	PLCTAG_NM_MOTORE97_Amperometri_Presente
	PLCTAG_NM_MOTORE97_Amperometri_LimMin
	PLCTAG_NM_MOTORE97_Amperometri_LimMax
	PLCTAG_NM_MOTORE97_Amperometri_MaxOut
	PLCTAG_NM_MOTORE98_Presente
	PLCTAG_NM_MOTORE98_UscitaInvertita
	PLCTAG_NM_MOTORE98_RitornoInvertito
	PLCTAG_NM_MOTORE98_TipoInversione
	PLCTAG_NM_MOTORE98_IO_InverterPresente
	PLCTAG_NM_MOTORE98_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE98_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE98_Esclusioni_Uscita
	PLCTAG_NM_MOTORE98_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE98_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE98_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE98_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE98_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE98_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE98_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE98_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE98_Timeout_Avvio
	PLCTAG_NM_MOTORE98_Timeout_Arresto
	PLCTAG_NM_MOTORE98_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE98_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE98_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE98_Antislittamento_Presente
	PLCTAG_NM_MOTORE98_Antislittamento_Tempo
	PLCTAG_NM_MOTORE98_Amperometri_Presente
	PLCTAG_NM_MOTORE98_Amperometri_LimMin
	PLCTAG_NM_MOTORE98_Amperometri_LimMax
	PLCTAG_NM_MOTORE98_Amperometri_MaxOut
	PLCTAG_NM_MOTORE99_Presente
	PLCTAG_NM_MOTORE99_UscitaInvertita
	PLCTAG_NM_MOTORE99_RitornoInvertito
	PLCTAG_NM_MOTORE99_TipoInversione
	PLCTAG_NM_MOTORE99_IO_InverterPresente
	PLCTAG_NM_MOTORE99_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE99_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE99_Esclusioni_Uscita
	PLCTAG_NM_MOTORE99_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE99_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE99_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE99_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE99_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE99_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE99_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE99_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE99_Timeout_Avvio
	PLCTAG_NM_MOTORE99_Timeout_Arresto
	PLCTAG_NM_MOTORE99_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE99_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE99_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE99_Antislittamento_Presente
	PLCTAG_NM_MOTORE99_Antislittamento_Tempo
	PLCTAG_NM_MOTORE99_Amperometri_Presente
	PLCTAG_NM_MOTORE99_Amperometri_LimMin
	PLCTAG_NM_MOTORE99_Amperometri_LimMax
	PLCTAG_NM_MOTORE99_Amperometri_MaxOut
	PLCTAG_NM_MOTORE100_Presente
	PLCTAG_NM_MOTORE100_UscitaInvertita
	PLCTAG_NM_MOTORE100_RitornoInvertito
	PLCTAG_NM_MOTORE100_TipoInversione
	PLCTAG_NM_MOTORE100_IO_InverterPresente
	PLCTAG_NM_MOTORE100_IO_InverterScaling_MinIN
	PLCTAG_NM_MOTORE100_IO_InverterScaling_MaxIN
	PLCTAG_NM_MOTORE100_Esclusioni_Uscita
	PLCTAG_NM_MOTORE100_Esclusioni_Ritorno
	PLCTAG_NM_MOTORE100_Sequenza_SoloVisualizzazione
	PLCTAG_NM_MOTORE100_Sequenza_EsclusionAvv
	PLCTAG_NM_MOTORE100_Sequenza_EsclusionSpe
	PLCTAG_NM_MOTORE100_Sequenza_InclAvvRidotto
	PLCTAG_NM_MOTORE100_Sequenza_GruppoAvvRidotto
	PLCTAG_NM_MOTORE100_Sequenza_TempoRitAvvMotSuc
	PLCTAG_NM_MOTORE100_Sequenza_TempoRitSpeMotSuc
	PLCTAG_NM_MOTORE100_Timeout_Avvio
	PLCTAG_NM_MOTORE100_Timeout_Arresto
	PLCTAG_NM_MOTORE100_PausaLavoro_Presenza
	PLCTAG_NM_MOTORE100_PausaLavoro_Tpausa
	PLCTAG_NM_MOTORE100_PausaLavoro_Tlavoro
	PLCTAG_NM_MOTORE100_Antislittamento_Presente
	PLCTAG_NM_MOTORE100_Antislittamento_Tempo
	PLCTAG_NM_MOTORE100_Amperometri_Presente
	PLCTAG_NM_MOTORE100_Amperometri_LimMin
	PLCTAG_NM_MOTORE100_Amperometri_LimMax
	PLCTAG_NM_MOTORE100_Amperometri_MaxOut
	PLCTAG_NM_MOTORE1_Amperometri_ValScal
	PLCTAG_NM_MOTORE2_Amperometri_ValScal
	PLCTAG_NM_MOTORE3_Amperometri_ValScal
	PLCTAG_NM_MOTORE4_Amperometri_ValScal
	PLCTAG_NM_MOTORE5_Amperometri_ValScal
	PLCTAG_NM_MOTORE6_Amperometri_ValScal
	PLCTAG_NM_MOTORE7_Amperometri_ValScal
	PLCTAG_NM_MOTORE8_Amperometri_ValScal
	PLCTAG_NM_MOTORE9_Amperometri_ValScal
	PLCTAG_NM_MOTORE10_Amperometri_ValScal
	PLCTAG_NM_MOTORE11_Amperometri_ValScal
	PLCTAG_NM_MOTORE12_Amperometri_ValScal
	PLCTAG_NM_MOTORE13_Amperometri_ValScal
	PLCTAG_NM_MOTORE14_Amperometri_ValScal
	PLCTAG_NM_MOTORE15_Amperometri_ValScal
	PLCTAG_NM_MOTORE16_Amperometri_ValScal
	PLCTAG_NM_MOTORE17_Amperometri_ValScal
	PLCTAG_NM_MOTORE18_Amperometri_ValScal
	PLCTAG_NM_MOTORE19_Amperometri_ValScal
	PLCTAG_NM_MOTORE20_Amperometri_ValScal
	PLCTAG_NM_MOTORE21_Amperometri_ValScal
	PLCTAG_NM_MOTORE22_Amperometri_ValScal
	PLCTAG_NM_MOTORE23_Amperometri_ValScal
	PLCTAG_NM_MOTORE24_Amperometri_ValScal
	PLCTAG_NM_MOTORE25_Amperometri_ValScal
	PLCTAG_NM_MOTORE26_Amperometri_ValScal
	PLCTAG_NM_MOTORE27_Amperometri_ValScal
	PLCTAG_NM_MOTORE28_Amperometri_ValScal
	PLCTAG_NM_MOTORE29_Amperometri_ValScal
	PLCTAG_NM_MOTORE30_Amperometri_ValScal
	PLCTAG_NM_MOTORE31_Amperometri_ValScal
	PLCTAG_NM_MOTORE32_Amperometri_ValScal
	PLCTAG_NM_MOTORE33_Amperometri_ValScal
	PLCTAG_NM_MOTORE34_Amperometri_ValScal
	PLCTAG_NM_MOTORE35_Amperometri_ValScal
	PLCTAG_NM_MOTORE36_Amperometri_ValScal
	PLCTAG_NM_MOTORE37_Amperometri_ValScal
	PLCTAG_NM_MOTORE38_Amperometri_ValScal
	PLCTAG_NM_MOTORE39_Amperometri_ValScal
	PLCTAG_NM_MOTORE40_Amperometri_ValScal
	PLCTAG_NM_MOTORE41_Amperometri_ValScal
	PLCTAG_NM_MOTORE42_Amperometri_ValScal
	PLCTAG_NM_MOTORE43_Amperometri_ValScal
	PLCTAG_NM_MOTORE44_Amperometri_ValScal
	PLCTAG_NM_MOTORE45_Amperometri_ValScal
	PLCTAG_NM_MOTORE46_Amperometri_ValScal
	PLCTAG_NM_MOTORE47_Amperometri_ValScal
	PLCTAG_NM_MOTORE48_Amperometri_ValScal
	PLCTAG_NM_MOTORE49_Amperometri_ValScal
	PLCTAG_NM_MOTORE50_Amperometri_ValScal
	PLCTAG_NM_MOTORE51_Amperometri_ValScal
	PLCTAG_NM_MOTORE52_Amperometri_ValScal
	PLCTAG_NM_MOTORE53_Amperometri_ValScal
	PLCTAG_NM_MOTORE54_Amperometri_ValScal
	PLCTAG_NM_MOTORE55_Amperometri_ValScal
	PLCTAG_NM_MOTORE56_Amperometri_ValScal
	PLCTAG_NM_MOTORE57_Amperometri_ValScal
	PLCTAG_NM_MOTORE58_Amperometri_ValScal
	PLCTAG_NM_MOTORE59_Amperometri_ValScal
	PLCTAG_NM_MOTORE60_Amperometri_ValScal
	PLCTAG_NM_MOTORE61_Amperometri_ValScal
	PLCTAG_NM_MOTORE62_Amperometri_ValScal
	PLCTAG_NM_MOTORE63_Amperometri_ValScal
	PLCTAG_NM_MOTORE64_Amperometri_ValScal
	PLCTAG_NM_MOTORE65_Amperometri_ValScal
	PLCTAG_NM_MOTORE66_Amperometri_ValScal
	PLCTAG_NM_MOTORE67_Amperometri_ValScal
	PLCTAG_NM_MOTORE68_Amperometri_ValScal
	PLCTAG_NM_MOTORE69_Amperometri_ValScal
	PLCTAG_NM_MOTORE70_Amperometri_ValScal
	PLCTAG_NM_MOTORE71_Amperometri_ValScal
	PLCTAG_NM_MOTORE72_Amperometri_ValScal
	PLCTAG_NM_MOTORE73_Amperometri_ValScal
	PLCTAG_NM_MOTORE74_Amperometri_ValScal
	PLCTAG_NM_MOTORE75_Amperometri_ValScal
	PLCTAG_NM_MOTORE76_Amperometri_ValScal
	PLCTAG_NM_MOTORE77_Amperometri_ValScal
	PLCTAG_NM_MOTORE78_Amperometri_ValScal
	PLCTAG_NM_MOTORE79_Amperometri_ValScal
	PLCTAG_NM_MOTORE80_Amperometri_ValScal
	PLCTAG_NM_MOTORE81_Amperometri_ValScal
	PLCTAG_NM_MOTORE82_Amperometri_ValScal
	PLCTAG_NM_MOTORE83_Amperometri_ValScal
	PLCTAG_NM_MOTORE84_Amperometri_ValScal
	PLCTAG_NM_MOTORE85_Amperometri_ValScal
	PLCTAG_NM_MOTORE86_Amperometri_ValScal
	PLCTAG_NM_MOTORE87_Amperometri_ValScal
	PLCTAG_NM_MOTORE88_Amperometri_ValScal
	PLCTAG_NM_MOTORE89_Amperometri_ValScal
	PLCTAG_NM_MOTORE90_Amperometri_ValScal
	PLCTAG_NM_MOTORE91_Amperometri_ValScal
	PLCTAG_NM_MOTORE92_Amperometri_ValScal
	PLCTAG_NM_MOTORE93_Amperometri_ValScal
	PLCTAG_NM_MOTORE94_Amperometri_ValScal
	PLCTAG_NM_MOTORE95_Amperometri_ValScal
	PLCTAG_NM_MOTORE96_Amperometri_ValScal
	PLCTAG_NM_MOTORE97_Amperometri_ValScal
	PLCTAG_NM_MOTORE98_Amperometri_ValScal
	PLCTAG_NM_MOTORE99_Amperometri_ValScal
	PLCTAG_NM_MOTORE100_Amperometri_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux1_Presente
	PLCTAG_NM_MOTORE_AmperometrAux1_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux1_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux1_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux2_Presente
	PLCTAG_NM_MOTORE_AmperometrAux2_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux2_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux2_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux3_Presente
	PLCTAG_NM_MOTORE_AmperometrAux3_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux3_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux3_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux4_Presente
	PLCTAG_NM_MOTORE_AmperometrAux4_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux4_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux4_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux5_Presente
	PLCTAG_NM_MOTORE_AmperometrAux5_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux5_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux5_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux6_Presente
	PLCTAG_NM_MOTORE_AmperometrAux6_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux6_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux6_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux7_Presente
	PLCTAG_NM_MOTORE_AmperometrAux7_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux7_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux7_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux8_Presente
	PLCTAG_NM_MOTORE_AmperometrAux8_ValMaxOut
	PLCTAG_NM_MOTORE_AmperometrAux8_ValLimMin
	PLCTAG_NM_MOTORE_AmperometrAux8_ValLimMax
	PLCTAG_NM_MOTORE_AmperometrAux1_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux2_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux3_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux4_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux5_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux6_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux7_ValScal
	PLCTAG_NM_MOTORE_AmperometrAux8_ValScal
	PLCTAG_DI_SiloSottoScambOK
	PLCTAG_DI_SiloMemTempScar
	PLCTAG_DI_BloccoScMescolatore
	PLCTAG_DI_BloccoBenna
	PLCTAG_DO_SiloConsensoCarico_Celle
	PLCTAG_DO_SiloConsensoScarico_Celle
	PLCTAG_DO_SiloArganoBinario_Salita
	PLCTAG_DO_SiloArganoBinario_Discesa
	PLCTAG_DO_Silo01
	PLCTAG_DO_ComandoScaricoSilo01
	PLCTAG_DI_TelescaricoSilo01
	PLCTAG_DI_RitSilo01
	PLCTAG_DI_PortScarSilo01
	PLCTAG_DI_LivMaxSilo01
	PLCTAG_DI_CappelloSilo01_Aperto
	PLCTAG_DI_CappelloSilo01_Chiuso
	PLCTAG_AI_LivSilo01
	PLCTAG_AI_PesoSilo01
	PLCTAG_AI_TempSilo01
	PLCTAG_DO_Silo02
	PLCTAG_DO_ComandoScaricoSilo02
	PLCTAG_DI_TelescaricoSilo02
	PLCTAG_DI_RitSilo02
	PLCTAG_DI_PortScarSilo02
	PLCTAG_DI_LivMaxSilo02
	PLCTAG_DI_CappelloSilo02_Aperto
	PLCTAG_DI_CappelloSilo02_Chiuso
	PLCTAG_AI_LivSilo02
	PLCTAG_AI_PesoSilo02
	PLCTAG_AI_TempSilo02
	PLCTAG_DO_Silo03
	PLCTAG_DO_ComandoScaricoSilo03
	PLCTAG_DI_TelescaricoSilo03
	PLCTAG_DI_RitSilo03
	PLCTAG_DI_PortScarSilo03
	PLCTAG_DI_LivMaxSilo03
	PLCTAG_DI_CappelloSilo03_Aperto
	PLCTAG_DI_CappelloSilo03_Chiuso
	PLCTAG_AI_LivSilo03
	PLCTAG_AI_PesoSilo03
	PLCTAG_AI_TempSilo03
	PLCTAG_DO_Silo04
	PLCTAG_DO_ComandoScaricoSilo04
	PLCTAG_DI_TelescaricoSilo04
	PLCTAG_DI_RitSilo04
	PLCTAG_DI_PortScarSilo04
	PLCTAG_DI_LivMaxSilo04
	PLCTAG_DI_CappelloSilo04_Aperto
	PLCTAG_DI_CappelloSilo04_Chiuso
	PLCTAG_AI_LivSilo04
	PLCTAG_AI_PesoSilo04
	PLCTAG_AI_TempSilo04
	PLCTAG_DO_Silo05
	PLCTAG_DO_ComandoScaricoSilo05
	PLCTAG_DI_TelescaricoSilo05
	PLCTAG_DI_RitSilo05
	PLCTAG_DI_PortScarSilo05
	PLCTAG_DI_LivMaxSilo05
	PLCTAG_DI_CappelloSilo05_Aperto
	PLCTAG_DI_CappelloSilo05_Chiuso
	PLCTAG_AI_LivSilo05
	PLCTAG_AI_PesoSilo05
	PLCTAG_AI_TempSilo05
	PLCTAG_DO_Silo06
	PLCTAG_DO_CocmandoScaricoSilo06
	PLCTAG_DI_TelescaricoSilo06
	PLCTAG_DI_RitSilo06
	PLCTAG_DI_PortScarSilo06
	PLCTAG_DI_LivMaxSilo06
	PLCTAG_DI_CappelloSilo06_Aperto
	PLCTAG_DI_CappelloSilo06_Chiuso
	PLCTAG_AI_LivSilo06
	PLCTAG_AI_PesoSilo06
	PLCTAG_AI_TempSilo06
	PLCTAG_DO_Silo07
	PLCTAG_DO_ComandoScaricoSilo07
	PLCTAG_DI_TelescaricoSilo07
	PLCTAG_DI_RitSilo07
	PLCTAG_DI_PortScarSilo07
	PLCTAG_DI_LivMaxSilo07
	PLCTAG_DI_CappelloSilo07_Aperto
	PLCTAG_DI_CappelloSilo07_Chiuso
	PLCTAG_AI_LivSilo07
	PLCTAG_AI_PesoSilo07
	PLCTAG_AI_TempSilo07
	PLCTAG_DO_Silo08
	PLCTAG_DO_ComandoScaricoSilo08
	PLCTAG_DI_TelescaricoSilo08
	PLCTAG_DI_RitSilo08
	PLCTAG_DI_PortScarSilo08
	PLCTAG_DI_LivMaxSilo08
	PLCTAG_DI_CappelloSilo08_Aperto
	PLCTAG_DI_CappelloSilo08_Chiuso
	PLCTAG_AI_LivSilo08
	PLCTAG_AI_PesoSilo08
	PLCTAG_AI_TempSilo08
	PLCTAG_DO_Silo09
	PLCTAG_DO_ComandoScaricoSilo09
	PLCTAG_DI_TelescaricoSilo09
	PLCTAG_DI_RitSilo09
	PLCTAG_DI_PortScarSilo09
	PLCTAG_DI_LivMaxSilo09
	PLCTAG_DI_CappelloSilo09_Aperto
	PLCTAG_DI_CappelloSilo09_Chiuso
	PLCTAG_AI_LivSilo09
	PLCTAG_AI_PesoSilo09
	PLCTAG_AI_TempSilo09
	PLCTAG_DO_Silo10
	PLCTAG_DO_ComandoScaricoSilo10
	PLCTAG_DI_TelescaricoSilo10
	PLCTAG_DI_RitSilo10
	PLCTAG_DI_PortScarSilo10
	PLCTAG_DI_LivMaxSilo10
	PLCTAG_DI_CappelloSilo10_Aperto
	PLCTAG_DI_CappelloSilo10_Chiuso
	PLCTAG_AI_LivSilo10
	PLCTAG_AI_PesoSilo10
	PLCTAG_AI_TempSilo10
	PLCTAG_DO_Silo11
	PLCTAG_DO_ComandoScaricoSilo11
	PLCTAG_DI_TelescaricoSilo11
	PLCTAG_DI_RitSilo11
	PLCTAG_DI_PortScarSilo11
	PLCTAG_DI_LivMaxSilo11
	PLCTAG_DI_CappelloSilo11_Aperto
	PLCTAG_DI_CappelloSilo11_Chiuso
	PLCTAG_AI_LivSilo11
	PLCTAG_AI_PesoSilo11
	PLCTAG_AI_TempSilo11
	PLCTAG_DO_Silo12
	PLCTAG_DO_ComandoScaricoSilo12
	PLCTAG_DI_TelescaricoSilo12
	PLCTAG_DI_RitSilo12
	PLCTAG_DI_PortScarSilo12
	PLCTAG_DI_LivMaxSilo12
	PLCTAG_DI_CappelloSilo12_Aperto
	PLCTAG_DI_CappelloSilo12_Chiuso
	PLCTAG_AI_LivSilo12
	PLCTAG_AI_PesoSilo12
	PLCTAG_AI_TempSilo12
	PLCTAG_DO_AsseA_BennaStart
	PLCTAG_DO_AsseA_SpruzzAntiad
	PLCTAG_DI_AsseA_BennaChiusa
	PLCTAG_DI_AsseA_BennaAperta
	PLCTAG_DI_BennaPronta
	PLCTAG_DI_AsseA_FC_PuntoCarico
	PLCTAG_DI_AsseA_BennaFcSuperiore
	PLCTAG_DI_BinarioPosDiretto
	PLCTAG_DI_BinarioPosSilo
	PLCTAG_DO_BinarioSalita
	PLCTAG_DO_BinarioDiscesa
	PLCTAG_DO_AsseA_Scarico
	PLCTAG_DI_AsseA_FC_LavoroSX
	PLCTAG_DI_AsseA_ExtraCorsaSX
	PLCTAG_DI_AsseA_ExtraCorsaDX
	PLCTAG_DI_BinarioTermica
	PLCTAG_DI_AsseA_Sicurezza
	PLCTAG_AI_AsseA_Posizione
	PLCTAG_DO_AsseP_NavettaStart
	PLCTAG_DO_AsseP_SpruzzAntiad
	PLCTAG_DI_AsseP_NavettaChiusa
	PLCTAG_DI_AsseP_NavettaAperta
	PLCTAG_DI_AsseP_FC_PuntoCarico
	PLCTAG_DI_AsseP_ExtraCorsaSX
	PLCTAG_DI_AsseP_ExtraCorsaDX
	PLCTAG_DI_AsseP_Scarico
	PLCTAG_DI_AsseP_FC_LavoroSX
	PLCTAG_DI_AsseA_FC_ScambioRifiuti
	PLCTAG_DI_AsseA_FC_ScambioSilo
	PLCTAG_DI_Assi_SbloccoSicurezza
	PLCTAG_DI_AsseP_Sicurezza
	PLCTAG_DI_AsseP_BennaFcSuperiore
	PLCTAG_Enable_Navetta_Con_Benna   '20160121 MP15038
	PLCTAG_DO_Silo1D2_Pistone1
	PLCTAG_DO_Silo1D2_Pistone2
	PLCTAG_AI_NavettaPosizione
	PLCTAG_DO_AsseP_Scarico
	PLCTAG_DI_Silo1D2_FC_Pistone1_AP
	PLCTAG_DI_Silo1D2_FC_Pistone1_CH
	PLCTAG_DI_Silo1D2_FC_Pistone2_AP
	PLCTAG_DI_Silo1D2_FC_Pistone2_CH
	PLCTAG_DO_AbilitaSpruzzaturaAntiadesivoBenna
	PLCTAG_DO_FiltCamera01
	PLCTAG_DO_FiltCamera02
	PLCTAG_DO_FiltCamera03
	PLCTAG_DO_FiltCamera04
	PLCTAG_DO_FiltCamera05
	PLCTAG_DO_FiltCamera06
	PLCTAG_DO_FiltCamera07
	PLCTAG_DO_FiltCamera08
	PLCTAG_DO_FiltCamera09
	PLCTAG_DO_FiltCamera10
	PLCTAG_DO_FiltCamera11
	PLCTAG_DO_FiltCamera12
	PLCTAG_DO_FiltCamera13
	PLCTAG_DO_FiltCamera14
	PLCTAG_DO_FiltCamera15
	PLCTAG_DO_FiltCamera16
	PLCTAG_DO_FiltCamera17
	PLCTAG_DO_FiltCamera18
	PLCTAG_DO_FiltCamera19
	PLCTAG_DO_FiltCamera20
	PLCTAG_DO_FiltCamera21
	PLCTAG_DO_FiltCamera22
	PLCTAG_DO_FiltCamera23
	PLCTAG_DO_FiltCamera24
	PLCTAG_DO_FiltCamera25
	PLCTAG_DO_FiltCamera26
	PLCTAG_DO_FiltCamera27
	PLCTAG_DO_FiltCamera28
	PLCTAG_DO_FiltCamera29
	PLCTAG_DO_FiltCamera30
	PLCTAG_DO_FiltCamera31
	PLCTAG_DO_FiltCamera32
	PLCTAG_DO_FiltChModulatore
	PLCTAG_DO_FiltApModulatore
	PLCTAG_DI_FiltChModulatore
	PLCTAG_DI_FiltApModulatore
	PLCTAG_DI_FiltTermModulatore
	PLCTAG_AI_FiltPosModulatore
	PLCTAG_DO_FiltChModAriaFr
	PLCTAG_DO_FiltApModAriaFr
	PLCTAG_DI_FiltChModAriaFr
	PLCTAG_DI_FiltApModAriaFr
	PLCTAG_DI_FiltTermModAriaFr
	PLCTAG_AI_FiltPosModAriaFr
	PLCTAG_AI_FiltDepressione
	PLCTAG_AI_FiltTempEntrata
	PLCTAG_AI_FiltTempUscita
	PLCTAG_DI_FiltSictempITT
	PLCTAG_DI_DepressFiltroOK
	PLCTAG_DI_ConsPuliziaFiltro
	PLCTAG_DO_FiltValvPresep
	PLCTAG_DI_FiltValvPresepAp
	PLCTAG_DI_FiltValvPresepCh
	PLCTAG_DO_ValvPresepAnello
	PLCTAG_DI_ValvPresepAnello_Ap
	PLCTAG_disp_2857_0
	PLCTAG_disp_2857_1
	PLCTAG_disp_2857_2
	PLCTAG_disp_2857_3
	PLCTAG_DO_FiltAttuat01
	PLCTAG_SelezioneF3                  '20151218
	PLCTAG_DI_FiltAttuatCh01
	PLCTAG_DI_FiltAttuatAp01
	PLCTAG_DI_FiltTermAttuat01
	PLCTAG_DO_FiltValvola1
	PLCTAG_DI_FiltValvola1Ch
	PLCTAG_DI_FiltValvola1Ap
	PLCTAG_DI_FiltValvola1Ris
	PLCTAG_DO_FiltValvola2
	PLCTAG_DI_FiltValvola2Ch
	PLCTAG_DI_FiltValvola2Ap
	PLCTAG_DI_FiltValvola2Ris
	PLCTAG_DO_FiltValvola3
	PLCTAG_DI_FiltValvola3Ch
	PLCTAG_DI_FiltValvola3Ap
	PLCTAG_DI_FiltValvola3Ris
	PLCTAG_DI_FiltLivMaxMacCina
	PLCTAG_AI_Depress_Ingresso_Filt
	PLCTAG_DI_Term_Coclea_Evac
	PLCTAG_DO_BrucChModulatore
	PLCTAG_DO_BrucApModulatore
	PLCTAG_DI_BrucModulatoreCh
	PLCTAG_DI_BrucModulatoreAp
	PLCTAG_DI_BrucTermModulatore
	PLCTAG_DO_ChiusuraFumiTamburo1
	PLCTAG_DO_AperturaFumiTamburo1
	PLCTAG_DI_FC_FumiTamburo1_CH
	PLCTAG_DI_FC_FumiTamburo1_AP
	PLCTAG_DI_Term_Modul_Aspiraz_Bruc1
	PLCTAG_AI_BrucPosModulatore
	PLCTAG_AI_BrucDepressione
	PLCTAG_DO_BrucAttuat01
	PLCTAG_DI_BrucAttuatCh01
	PLCTAG_DI_BrucAttuatAp01
	PLCTAG_DI_BrucTermAttuat01
	PLCTAG_DO_BrucAttuat02
	PLCTAG_DI_BrucAttuatCh02
	PLCTAG_DI_BrucAttuatAp02
	PLCTAG_DI_BrucTermAttuat02
	PLCTAG_DO_BrucAttuat03
	PLCTAG_DI_BrucAttuatCh03
	PLCTAG_DI_BrucAttuatAp03
	PLCTAG_DI_BrucTermAttuat03
	PLCTAG_DO_BrucStart
	PLCTAG_DI_BrucAcceso
	PLCTAG_DI_BrucBlocco
	PLCTAG_DI_BrucPosAccensione
	PLCTAG_DI_BrucPressGasOK
	PLCTAG_DI_BrucBloccoLDU
	PLCTAG_DI_BrucPressCombBass
	PLCTAG_DI_BrucTempCombOK
	PLCTAG_DI_BrucSicTempcomb
	PLCTAG_DI_AllTenutaValvoleOC
	PLCTAG_DI_PressInsufComprBruc
	PLCTAG_AI_BrucTempscivolo
	PLCTAG_DO_BrucDeflRic
	PLCTAG_DI_BrucDeflRicTamb
	PLCTAG_DI_BrucDeflRicElev
	PLCTAG_DO_BrucModRicApre
	PLCTAG_DO_BrucModRicChiude
	PLCTAG_DI_BrucModRicTamb
	PLCTAG_DI_BrucModRicElev
	PLCTAG_DI_BrucModRicTerm
	PLCTAG_AI_BrucModRic_UNUSED
	PLCTAG_DO_BrucDeflVaglRic
	PLCTAG_DI_BrucDeflVaglRicN
	PLCTAG_DI_BrucDeflVaglRicP
	PLCTAG_DI_BrucSelezGas
	PLCTAG_DI_BrucSelezOlio
	PLCTAG_DI_BrucSelezGasolio
	PLCTAG_AI_BrucTempTermocoppiaUscita
	PLCTAG_AI_Bruc_Contalitri
	PLCTAG_AI_BrucTempIngressoTamburo
	PLCTAG_AI_Bruc_Contalitri_DI
	PLCTAG_AI_ModulatoreFumiTamburo1
	PLCTAG_AI_TempScambiatBruc1
	PLCTAG_DI_AltaPressione_PompaCombustibile
	PLCTAG_DI_SiloFilMin01
	PLCTAG_DI_SiloFilMed01
	PLCTAG_DI_SiloFilMax01
	PLCTAG_DO_SiloFilAria01
	PLCTAG_DO_SiloFilDeum01
	PLCTAG_DO_SiloFilVibr01
	PLCTAG_DI_SiloFilAria01
	PLCTAG_DI_SiloFilDeum01
	PLCTAG_DI_SiloFilVibr01
	PLCTAG_DI_SiloFilVibrTerm01
	PLCTAG_AI_SiloFilLiv01
	PLCTAG_DI_SiloFilMin02
	PLCTAG_DI_SiloFilMed02
	PLCTAG_DI_SiloFilMax02
	PLCTAG_DO_SiloFilAria02
	PLCTAG_DO_SiloFilDeum02
	PLCTAG_DO_SiloFilVibr02
	PLCTAG_DI_SiloFilAria02
	PLCTAG_DI_SiloFilDeum02
	PLCTAG_DI_SiloFilVibr02
	PLCTAG_DI_SiloFilVibrTerm02
	PLCTAG_AI_SiloFilLiv02
	PLCTAG_DI_SiloFilMin03
	PLCTAG_DI_SiloFilMed03
	PLCTAG_DI_SiloFilMax03
	PLCTAG_DO_SiloFilAria03
	PLCTAG_DO_SiloFilDeum03
	PLCTAG_DO_SiloFilVibr03
	PLCTAG_DI_SiloFilAria03
	PLCTAG_DI_SiloFilDeum03
	PLCTAG_DI_SiloFilVibr03
	PLCTAG_DI_SiloFilVibrTerm03
	PLCTAG_AI_SiloFilLiv03
	PLCTAG_DI_SiloFilMin04
	PLCTAG_DI_SiloFilMed04
	PLCTAG_DI_SiloFilMax04
	PLCTAG_DO_SiloFilAria04
	PLCTAG_DO_SiloFilDeum04
	PLCTAG_DO_SiloFilVibr04
	PLCTAG_DI_SiloFilAria04
	PLCTAG_DI_SiloFilDeum04
	PLCTAG_DI_SiloFilVibr04
	PLCTAG_DI_SiloFilVibrTerm04
	PLCTAG_AI_SiloFilLiv04
	PLCTAG_DI_SiloFilMin05
	PLCTAG_DI_SiloFilMed05
	PLCTAG_DI_SiloFilMax05
	PLCTAG_DO_SiloFilAria05
	PLCTAG_DO_SiloFilDeum05
	PLCTAG_DO_SiloFilVibr05
	PLCTAG_DI_SiloFilAria05
	PLCTAG_DI_SiloFilDeum05
	PLCTAG_DI_SiloFilVibr05
	PLCTAG_DI_SiloFilVibrTerm05
	PLCTAG_AI_SiloFilLiv05
	PLCTAG_DI_SiloFilMin06
	PLCTAG_DI_SiloFilMed06
	PLCTAG_DI_SiloFilMax06
	PLCTAG_DO_SiloFilAria06
	PLCTAG_DO_SiloFilDeum06
	PLCTAG_DO_SiloFilVibr06
	PLCTAG_DI_SiloFilAria06
	PLCTAG_DI_SiloFilDeum06
	PLCTAG_DI_SiloFilVibr06
	PLCTAG_DI_SiloFilVibrTerm06
	PLCTAG_AI_SiloFilLiv06
	PLCTAG_DI_SiloFilMin07
	PLCTAG_DI_SiloFilMed07
	PLCTAG_DI_SiloFilMax07
	PLCTAG_DO_SiloFilAria07
	PLCTAG_DO_SiloFilDeum07
	PLCTAG_DO_SiloFilVibr07
	PLCTAG_DI_SiloFilAria07
	PLCTAG_DI_SiloFilDeum07
	PLCTAG_DI_SiloFilVibr07
	PLCTAG_DI_SiloFilVibrTerm07
	PLCTAG_AI_SiloFilLiv07
	PLCTAG_DI_SiloFilMinSxDMR
	PLCTAG_DI_SiloFilMedSxDMR
	PLCTAG_DI_SiloFilMaxSxDMR
	PLCTAG_DI_SiloFilMinCnDMR
	PLCTAG_DI_SiloFilMedCnDMR
	PLCTAG_DI_SiloFilMaxCnDMR
	PLCTAG_DI_SiloFilMinDxDMR
	PLCTAG_DI_SiloFilMedDxDMR
	PLCTAG_DI_SiloFilMaxDxDMR
	PLCTAG_DO_SiloFilAriaDMR
	PLCTAG_DO_SiloFilDeumDMR
	PLCTAG_DO_SiloFilVibrDMR
	PLCTAG_DI_SiloFilAriaDMR
	PLCTAG_DI_SiloFilDeumDMR
	PLCTAG_DI_SiloFilVibrDMR
	PLCTAG_DI_SiloFilVibrTermDMR
	PLCTAG_AI_SiloFilLivDMR
	PLCTAG_DO_EvacuazFillerSilo
	PLCTAG_DI_EvacuazFillerSilo
	PLCTAG_CocleeManualeComandoComposto
	PLCTAG_CocleeManualeRitorno1
	PLCTAG_CocleeManualeRitorno2
	PLCTAG_CocleeManualeRitorno3
	PLCTAG_CocleeManualeRitorno4
	PLCTAG_CocleeManualeRitorno5
	PLCTAG_CocleeManualeRitorno6
	PLCTAG_CocleeManualeRitorno7
	PLCTAG_CocleeManualeRitorno8
	PLCTAG_CocleeManualeRitorno9
	PLCTAG_CocleeManualeRitorno10
	PLCTAG_CocleeManualeRitorno11
	PLCTAG_CocleeManualeRitorno12
	PLCTAG_CocleeManualeRitorno13
	PLCTAG_CocleeManualeRitorno14
	PLCTAG_CocleeManualeRitorno15
	PLCTAG_CocleeManualeRitorno16
	PLCTAG_AI_ModulatoreBruciatore2
	PLCTAG_AI_DepressioneBruciatore2
	PLCTAG_AI_TempScivoloTamburo2
	PLCTAG_AI_ModulatoreFumiTamburo2
	PLCTAG_DO_ModulatoreBruc2Chiusura
	PLCTAG_DO_ModulatoreBruc2Apertura
	PLCTAG_DI_TermicaModulatoreBruc2
	PLCTAG_DO_ChiusuraFumiTamburo2
	PLCTAG_DO_AperturaFumiTamburo2
	PLCTAG_DI_FC_FumiTamburo2_CH
	PLCTAG_DI_FC_FumiTamburo2_AP
	PLCTAG_DI_Term_Modul_Aspiraz_Bruc2
	PLCTAG_DO_Bruciatore2Start
	PLCTAG_DI_Bruciatore2Acceso
	PLCTAG_DI_Bruciatore2Blocco
	PLCTAG_DI_Bruciatore2ModulPosizAccens
	PLCTAG_DI_PressioneGasOK2
	PLCTAG_DI_BloccoLdu2
	PLCTAG_DI_OlioCombustibile2_PressioneInsufficiente
	PLCTAG_DI_OlioCombustibile2_TemperaturaOK
	PLCTAG_DI_OlioCombustibile2_SicurezzaTemp
	PLCTAG_DI_OlioCombustibile2_AllarmeTenutaValvole
	PLCTAG_DI_CompressoreBruciatore2_PressioneInsufficiente
	PLCTAG_AI_Temp_Fumi_Out_Tamb2
	PLCTAG_DO_Flap_Antincendio_Tamb2
	PLCTAG_DO_DeflettoreBypassATamburo_Tamb2
	PLCTAG_DI_FC_DeflettoreBypassATamburo_Tamb2
	PLCTAG_DI_FC_DeflettoreBypassANastro_Tamb2
	PLCTAG_DI_Rit_Press_Fillerizz
	PLCTAG_Motore08_Slittamento_PrimaSoglia
	PLCTAG_Motore28_Slittamento_PrimaSoglia
	PLCTAG_Termica_Alim_FCD
	PLCTAG_Ter_Coclea_Da_EF_A_PesF1 '20160505
	PLCTAG_Ter_Coclea_Da_EF_A_PesF2 '20160505
	PLCTAG_TermicaVibrSoffioEstrazF
	PLCTAG_NumRicDos
	PLCTAG_TimerMescolaz
	PLCTAG_TimerScMesc
	PLCTAG_SetA1
	PLCTAG_SetA2
	PLCTAG_SetA3
	PLCTAG_SetA4
	PLCTAG_SetA5
	PLCTAG_SetA6
	PLCTAG_SetA7
	PLCTAG_SetA8
	PLCTAG_SetA9
	PLCTAG_SetA10
	PLCTAG_SetPesataLentaA1
	PLCTAG_SetPesataLentaA2
	PLCTAG_SetPesataLentaA3
	PLCTAG_SetPesataLentaA4
	PLCTAG_SetPesataLentaA5
	PLCTAG_SetPesataLentaA6
	PLCTAG_SetPesataLentaA7
	PLCTAG_SetPesataLentaA8
	PLCTAG_SetPesataLentaA9
	PLCTAG_SetPesataLentaA10
	PLCTAG_OrdineDosA1
	PLCTAG_OrdineDosA2
	PLCTAG_OrdineDosA3
	PLCTAG_OrdineDosA4
	PLCTAG_OrdineDosA5
	PLCTAG_OrdineDosA6
	PLCTAG_OrdineDosA7
	PLCTAG_OrdineDosA8
	PLCTAG_OrdineDosA9
	PLCTAG_OrdineDosA10
	PLCTAG_ResA1
	PLCTAG_ResA2
	PLCTAG_ResA3
	PLCTAG_ResA4
	PLCTAG_ResA5
	PLCTAG_ResA6
	PLCTAG_ResA7
	PLCTAG_ResA8
	PLCTAG_ResA9
	PLCTAG_ResA10
	PLCTAG_TollBil1A
	PLCTAG_TempoStabBil1ACarico
	PLCTAG_TempoStabBil1ASc
	PLCTAG_SetF1
	PLCTAG_SetF2
	PLCTAG_SetF3
	PLCTAG_SetF4
	PLCTAG_SetF5
	PLCTAG_SetF6
	PLCTAG_SetF7
	PLCTAG_SetF8
	PLCTAG_SetPesataLentaFil1
	PLCTAG_SetPesataLentaFil2
	PLCTAG_SetPesataLentaFil3
	PLCTAG_SetPesataLentaFil4
	PLCTAG_SetPesataLentaFil5
	PLCTAG_SetPesataLentaFil6
	PLCTAG_SetPesataLentaFil7
	PLCTAG_SetPesataLentaFil8
	PLCTAG_OrdineDosFil1
	PLCTAG_OrdineDosFil2
	PLCTAG_OrdineDosFil3
	PLCTAG_OrdineDosFil4
	PLCTAG_OrdineDosFil5
	PLCTAG_OrdineDosFil6
	PLCTAG_OrdineDosFil7
	PLCTAG_OrdineDosFil8
	PLCTAG_ResF1
	PLCTAG_ResF2
	PLCTAG_ResF3
	PLCTAG_ResF4
	PLCTAG_ResF5
	PLCTAG_ResF6
	PLCTAG_ResF7
	PLCTAG_ResF8
	PLCTAG_TollBil2F
	PLCTAG_TempoStabBil2FCarico
	PLCTAG_TempoStabBil2FSc
	PLCTAG_TimerScF
	PLCTAG_SetB1
	PLCTAG_SetB2
	PLCTAG_SetB3
	PLCTAG_SetB4
	PLCTAG_SetPesataLentabit1
	PLCTAG_SetPesataLentabit2
	PLCTAG_SetPesataLentabit3
	PLCTAG_SetPesataLentabit4
	PLCTAG_SpruzzataLenta1
	PLCTAG_SpruzzataLenta2
	PLCTAG_SpruzzataLenta3
	PLCTAG_SpruzzataLenta4
	PLCTAG_OrdineDosBit1
	PLCTAG_OrdineDosBit2
	PLCTAG_OrdineDosBit3
	PLCTAG_OrdineDosBit4
	PLCTAG_ResB1Scarico
	PLCTAG_ResB2Scarico
	PLCTAG_ResB3Scarico
	PLCTAG_ResB4Scarico
	PLCTAG_ResB1Pesata
	PLCTAG_ResB2Pesata
	PLCTAG_ResB3Pesata
	PLCTAG_ResB4Pesata
	PLCTAG_TollBil3B1
	PLCTAG_TempoStabBil3BCarico
	PLCTAG_TempoStabBil3BSc
	PLCTAG_TimerScB
	PLCTAG_BlendingB1_Perc
	PLCTAG_BlendingB2_Perc
	PLCTAG_BlendingB3_Perc
	PLCTAG_BlendingB4_Perc
	PLCTAG_SetRAP
	PLCTAG_SetR2
	PLCTAG_SetR3
	PLCTAG_SetPesataLentaRAP
	PLCTAG_SetPesataLenta_ric2
	PLCTAG_SetPesataLenta_ric3
	PLCTAG_OrdineBilRAP
	PLCTAG_OrdineBilRic2
	PLCTAG_OrdineBilRic3
	PLCTAG_ResRAP
	PLCTAG_ResRic2
	PLCTAG_ResRic3
	PLCTAG_TollBilRAP
	PLCTAG_TempoStabBilRAPCarico
	PLCTAG_TempoStabBilRAPSc
	PLCTAG_TimerScRAP
	PLCTAG_SetViatop1
	PLCTAG_SetViatop2
	PLCTAG_SetViatop3
	PLCTAG_SetViatop4
	PLCTAG_SetViatop5
	PLCTAG_SetViatop6
	PLCTAG_SetPesataLentaVia1
	PLCTAG_SetPesataLentaVia2
	PLCTAG_SetPesataLentaVia3
	PLCTAG_SetPesataLentaVia4
	PLCTAG_SetPesataLentaVia5
	PLCTAG_SetPesataLentaVia6
	PLCTAG_ResBilViatop1
	PLCTAG_ResBilViatop2
	PLCTAG_ResBilViatop3
	PLCTAG_ResBilViatop4
	PLCTAG_ResBilViatop5
	PLCTAG_ResBilViatop6
	PLCTAG_OrdineViatop_1
	PLCTAG_OrdineViatop_2
	PLCTAG_OrdineViatop_3
	PLCTAG_OrdineViatop_4
	PLCTAG_OrdineViatop_5
	PLCTAG_OrdineViatop_6
	PLCTAG_TollBilV
	PLCTAG_TempoStabBilVCarico
	PLCTAG_TempoStabBilVSc
	PLCTAG_TimerScViatop
	PLCTAG_SetAdd1Mix
	PLCTAG_ScAddPrimaDopoB
	PLCTAG_TimerScAdd1Mesc
	PLCTAG_AcquaSet
	PLCTAG_AcquaRitardo
	PLCTAG_SetAdd2PesB
	PLCTAG_TimerScAdd2Bacinella
	PLCTAG_Residuo_Add2
	PLCTAG_Tolleranza_Add2
	PLCTAG_Tempo_Stab_Add2
	PLCTAG_SetPercAdd2
	PLCTAG_SetAdd3Spruzz
	PLCTAG_TimerScAdd3SpruzzB
	PLCTAG_SetAdd4Sacchi
	PLCTAG_TimerScAdd4Sacchi
	PLCTAG_SacchiPrimaDopoBitume
	PLCTAG_GravitaSetPercB1
	PLCTAG_GravitaSetPercB2
	PLCTAG_GravitaSetPercB3
	PLCTAG_GravitaSetPercB4
	PLCTAG_GravitaSetPercB5
	PLCTAG_GravitaSetPercB6
	PLCTAG_GravitaSetPercB7
	PLCTAG_GravitaPercVelocePrimaPesata
	PLCTAG_GravitaPercVeloceSecondaPesata
	PLCTAG_GravitaPercRiduzionePrimaPesata
	PLCTAG_GravitaPercRiduzioneSecondaPesata
	PLCTAG_GravitaOrdineDosB1
	PLCTAG_GravitaOrdineDosB2
	PLCTAG_GravitaOrdineDosB3
	PLCTAG_GravitaOrdineDosB4
	PLCTAG_GravitaOrdineDosB5
	PLCTAG_GravitaOrdineDosB6
	PLCTAG_GravitaOrdineDosB7
	PLCTAG_GravitaRis01
	PLCTAG_GravitaResiduoB1
	PLCTAG_GravitaResiduoB2
	PLCTAG_GravitaResiduoB3
	PLCTAG_GravitaResiduoB4
	PLCTAG_GravitaResiduoB5
	PLCTAG_GravitaResiduoB6
	PLCTAG_GravitaResiduoB7
	PLCTAG_GravitaRis02
	PLCTAG_GravitaTolleranza
	PLCTAG_GravitaTempoStabCarico
	PLCTAG_GravitaTempoStabScarico
	PLCTAG_GravitaRitardoScarico
	PLCTAG_GravitaPortataMinKgBitume
	PLCTAG_GravitaPercRabbocco
	PLCTAG_ContalitriSetPerc
	PLCTAG_ContalitriLentaPerc
	PLCTAG_ContalitriResiduoKg
	PLCTAG_ContalitriTolleranza
	PLCTAG_ContalitriTempoStab
	PLCTAG_ContalitriRitardoScarico
	PLCTAG_FlomacInclusione
	PLCTAG_AbilitaCicloRF
	PLCTAG_AbilitaCicloRC
	PLCTAG_SetRAPSiwa
	PLCTAG_SetPesataLentaRAPSiwa
	PLCTAG_OrdineDosRAPSiwa
	PLCTAG_ResRAPSiwa
	PLCTAG_TollBilRAPSiwa
	PLCTAG_TempoStabBilRAPSiwaSc
	PLCTAG_TimerScRAPSiwa
	PLCTAG_AB0
	PLCTAG_AB1
	PLCTAG_AB2
	PLCTAG_AB3
	PLCTAG_AB4
	PLCTAG_AB5
	PLCTAG_AB6
	PLCTAG_AB7
	PLCTAG_AB8
	PLCTAG_AB9
	PLCTAG_AB10
	PLCTAG_AB11
	PLCTAG_AB12
	PLCTAG_AB13
	PLCTAG_AB14
	PLCTAG_AB15
	PLCTAG_AB16
	PLCTAG_AB17
	PLCTAG_AB18
	PLCTAG_AB19
	PLCTAG_EB20
	PLCTAG_EB21
	PLCTAG_EB22
	PLCTAG_EB23
	PLCTAG_EB24
	PLCTAG_EB25
	PLCTAG_EB26
	PLCTAG_EB27
	PLCTAG_EB28
	PLCTAG_EB29
	PLCTAG_EB30
	PLCTAG_EB31
	PLCTAG_EB32
	PLCTAG_EB33
	PLCTAG_EB34
	PLCTAG_EB35
	PLCTAG_EB36
	PLCTAG_EB37
	PLCTAG_EB38
	PLCTAG_EB39
	PLCTAG_EB40
	PLCTAG_EB41
	PLCTAG_EB42
	PLCTAG_EB43
	PLCTAG_EB44
	PLCTAG_EB45
	PLCTAG_EB46
	PLCTAG_EB47
	PLCTAG_EB48
	PLCTAG_EB49
	PLCTAG_EB50
	PLCTAG_EB51
	PLCTAG_EB52
	PLCTAG_EB53
	PLCTAG_EB54
	PLCTAG_EB55
	PLCTAG_AB56
	PLCTAG_AB57
	PLCTAG_AB58
	PLCTAG_AB59
	PLCTAG_EB60
	PLCTAG_EB61
	PLCTAG_EB62
	PLCTAG_EB63
	PLCTAG_AB64
	PLCTAG_AB65
	PLCTAG_AB66
	PLCTAG_AB67
	PLCTAG_EB68
	PLCTAG_EB69
	PLCTAG_EB70
	PLCTAG_EB71
	PLCTAG_AB72
	PLCTAG_AB73
	PLCTAG_AB74
	PLCTAG_AB75
	PLCTAG_AB20
	PLCTAG_AB21
	PLCTAG_AB22
	PLCTAG_AB23
	PLCTAG_EB00
	PLCTAG_EB01
	PLCTAG_EB02
	PLCTAG_EB03
	PLCTAG_EB04
	PLCTAG_EB05
	PLCTAG_EB06
	PLCTAG_EB07
	PLCTAG_EB08
	PLCTAG_EB09
	PLCTAG_AB42
	PLCTAG_AB43
	PLCTAG_AB44
	PLCTAG_AB45
	PLCTAG_EB216
	PLCTAG_EB217
	PLCTAG_EB218
	PLCTAG_EB219
	PLCTAG_EB220
	PLCTAG_EB221
	PLCTAG_AB24
	PLCTAG_AB25
	PLCTAG_EB10
	PLCTAG_EB11
	PLCTAG_RiduzioneImpastoDos
	PLCTAG_GravitaNettoB1Kg
	PLCTAG_GravitaNettoB2Kg
	PLCTAG_GravitaNettoB3Kg
	PLCTAG_GravitaNettoB4Kg
	PLCTAG_GravitaNettoB5Kg
	PLCTAG_GravitaNettoB6Kg
	PLCTAG_GravitaNettoB7Kg
	PLCTAG_GravitaSetB1Kg
	PLCTAG_GravitaSetB2Kg
	PLCTAG_GravitaSetB3Kg
	PLCTAG_GravitaSetB4Kg
	PLCTAG_GravitaSetB5Kg
	PLCTAG_GravitaSetB6Kg
	PLCTAG_GravitaSetB7Kg
	PLCTAG_GravitaResB1Kg
	PLCTAG_GravitaResB2Kg
	PLCTAG_GravitaResB3Kg
	PLCTAG_GravitaResB4Kg
	PLCTAG_GravitaResB5Kg
	PLCTAG_GravitaResB6Kg
	PLCTAG_GravitaResB7Kg
	PLCTAG_ContalitriNettoKg_NO
	PLCTAG_ContalitriResKg_NO
	PLCTAG_GestGenArrestoEmergenzaDosaggio
	PLCTAG_CicliDaEseguire
	PLCTAG_CicliEseguiti
	PLCTAG_GestMescBool0_0
	PLCTAG_GestMescBool0_1
	PLCTAG_GestMescBool0_2
	PLCTAG_GestMescBool0_3
	PLCTAG_Fine_Pesatura_Materiali
	PLCTAG_DosaggioAttivo
	PLCTAG_GestMescBool0_6
	PLCTAG_GestMescBool0_7
	PLCTAG_GestMescBool2_0
	PLCTAG_GestMescBool2_1
	PLCTAG_GestMescBool2_2
	PLCTAG_GestMescBool2_3
	PLCTAG_GestMescBool2_4
	PLCTAG_DosaggioInArresto
	PLCTAG_MescolazioneInCorso
	PLCTAG_GestMescBool2_7
	PLCTAG_ConsensoScaricoBilance
	PLCTAG_MescolatoreScaricoCompletato
	PLCTAG_setTempoMescolazione
	PLCTAG_TempoMescolazioneInCorso
	PLCTAG_SetTempoScaricoMixer
	PLCTAG_TempoScaricoMixerInCorso
	PLCTAG_DO_ScaricoMesc
	PLCTAG_SetA1forzato1
	PLCTAG_SetA2forzato1
	PLCTAG_SetA3forzato1
	PLCTAG_SetA4forzato1
	PLCTAG_SetA5forzato1
	PLCTAG_SetA6forzato1
	PLCTAG_SetA7forzato1
	PLCTAG_SetNVforzato1
	PLCTAG_SetA1forzato2
	PLCTAG_SetA2forzato2
	PLCTAG_SetA3forzato2
	PLCTAG_SetA4forzato2
	PLCTAG_SetA5forzato2
	PLCTAG_SetA6forzato2
	PLCTAG_SetA7forzato2
	PLCTAG_SetNVforzato2
	PLCTAG_PesataInCorsoA1
	PLCTAG_PesataInCorsoA2
	PLCTAG_PesataInCorsoA3
	PLCTAG_PesataInCorsoA4
	PLCTAG_PesataInCorsoA5
	PLCTAG_PesataInCorsoA6
	PLCTAG_PesataInCorsoA7
	PLCTAG_PesataInCorsoNV
	PLCTAG_SetAggregato1
	PLCTAG_SetAggregato2
	PLCTAG_SetAggregato3
	PLCTAG_SetAggregato4
	PLCTAG_SetAggregato5
	PLCTAG_SetAggregato6
	PLCTAG_SetAggregato7
	PLCTAG_SetNV
	PLCTAG_ResiduoAggregato1
	PLCTAG_ResiduoAggregato2
	PLCTAG_ResiduoAggregato3
	PLCTAG_ResiduoAggregato4
	PLCTAG_ResiduoAggregato5
	PLCTAG_ResiduoAggregato6
	PLCTAG_ResiduoAggregato7
	PLCTAG_ResiduoNV
	PLCTAG_NettoAggregato1
	PLCTAG_NettoAggregato2
	PLCTAG_NettoAggregato3
	PLCTAG_NettoAggregato4
	PLCTAG_NettoAggregato5
	PLCTAG_NettoAggregato6
	PLCTAG_NettoAggregato7
	PLCTAG_NettoNV
	PLCTAG_PercAggregato1
	PLCTAG_PercAggregato2
	PLCTAG_PercAggregato3
	PLCTAG_PercAggregato4
	PLCTAG_PercAggregato5
	PLCTAG_PercAggregato6
	PLCTAG_PercAggregato7
	PLCTAG_PercNV
	PLCTAG_OrdineAggForzato1
	PLCTAG_OrdineAggForzato2
	PLCTAG_OrdineAggForzato3
	PLCTAG_OrdineAggForzato4
	PLCTAG_OrdineAggForzato5
	PLCTAG_OrdineAggForzato6
	PLCTAG_OrdineAggForzato7
	PLCTAG_OrdineAggForzato8
	PLCTAG_SetF1forzato1
	PLCTAG_SetF2forzato1
	PLCTAG_SetF3forzato1
	PLCTAG_SetF4forzato1
	PLCTAG_SetF5forzato1
	PLCTAG_SetF6forzato1
	PLCTAG_SetF7forzato1
	PLCTAG_SetF8forzato1
	PLCTAG_SetF1forzato2
	PLCTAG_SetF2forzato2
	PLCTAG_SetF3forzato2
	PLCTAG_SetF4forzato2
	PLCTAG_SetF5forzato2
	PLCTAG_SetF6forzato2
	PLCTAG_SetF7forzato2
	PLCTAG_SetF8forzato2
	PLCTAG_SetFiller1
	PLCTAG_SetFiller2
	PLCTAG_SetFiller3
	PLCTAG_SetFiller4
	PLCTAG_SetFiller5
	PLCTAG_SetFiller6
	PLCTAG_SetFiller7
	PLCTAG_SetFiller8
	PLCTAG_ResiduoFiller1
	PLCTAG_ResiduoFiller2
	PLCTAG_ResiduoFiller3
	PLCTAG_ResiduoFiller4
	PLCTAG_ResiduoFiller5
	PLCTAG_ResiduoFiller6
	PLCTAG_ResiduoFiller7
	PLCTAG_ResiduoFiller8
	PLCTAG_NettoFiller1
	PLCTAG_NettoFiller2
	PLCTAG_NettoFiller3
	PLCTAG_NettoFiller4
	PLCTAG_NettoFiller5
	PLCTAG_NettoFiller6
	PLCTAG_NettoFiller7
	PLCTAG_NettoFiller8
	PLCTAG_PercFiller1
	PLCTAG_PercFiller2
	PLCTAG_PercFiller3
	PLCTAG_PercFiller4
	PLCTAG_PercFiller5
	PLCTAG_PercFiller6
	PLCTAG_PercFiller7
	PLCTAG_PercFiller8
	PLCTAG_OrdineFillForzato1
	PLCTAG_OrdineFillForzato2
	PLCTAG_OrdineFillForzato3
	PLCTAG_OrdineFillForzato4
	PLCTAG_OrdineFillForzato5
	PLCTAG_OrdineFillForzato6
	PLCTAG_OrdineFillForzato7
	PLCTAG_OrdineFillForzato8
	PLCTAG_Forzatura_Pes_Comp
	PLCTAG_SetV1forzato1
	PLCTAG_SetV2forzato1
	PLCTAG_SetV3forzato1
	PLCTAG_SetV4forzato1
	PLCTAG_SetV5forzato1
	PLCTAG_SetV6forzato1
	PLCTAG_SetV7forzato1
	PLCTAG_SetV8forzato1
	PLCTAG_SetV1forzato2
	PLCTAG_SetV2forzato2
	PLCTAG_SetV3forzato2
	PLCTAG_SetV4forzato2
	PLCTAG_SetV5forzato2
	PLCTAG_SetV6forzato2
	PLCTAG_SetV7forzato2
	PLCTAG_SetV8forzato2
	PLCTAG_SetViatop1_DB38
	PLCTAG_SetViatop2_DB38
	PLCTAG_SetViatop3_DB38
	PLCTAG_SetViatop4_DB38
	PLCTAG_SetViatop5_DB38
	PLCTAG_SetViatop6_DB38
	PLCTAG_SetViatop7_DB38
	PLCTAG_SetViatop8_DB38
	PLCTAG_ResiduoViatop1
	PLCTAG_ResiduoViatop2
	PLCTAG_ResiduoViatop3
	PLCTAG_ResiduoViatop4
	PLCTAG_ResiduoViatop5
	PLCTAG_ResiduoViatop6
	PLCTAG_ResiduoViatop7
	PLCTAG_ResiduoViatop8
	PLCTAG_NettoViatop1
	PLCTAG_NettoViatop2
	PLCTAG_NettoViatop3
	PLCTAG_NettoViatop4
	PLCTAG_NettoViatop5
	PLCTAG_NettoViatop6
	PLCTAG_NettoViatop7
	PLCTAG_NettoViatop8
	PLCTAG_DB80_StopDosaggioManuale
	PLCTAG_DB80_TempoRitardoRAPSiwa
	PLCTAG_DB80_ComandoDirettoPortina
	PLCTAG_DB101_SIWA_BATCH_SETCALCOLATO
	PLCTAG_DB101_SIWA_BATCH_NETTO
	PLCTAG_DB101_SIWA_BATCH_VOLO
	PLCTAG_SetR1forzato1
	PLCTAG_SetR2forzato1
	PLCTAG_SetR3forzato1
	PLCTAG_SetR4forzato1
	PLCTAG_SetR5forzato1
	PLCTAG_SetR6forzato1
	PLCTAG_SetR7forzato1
	PLCTAG_SetR8forzato1
	PLCTAG_SetR1forzato2
	PLCTAG_SetR2forzato2
	PLCTAG_SetR3forzato2
	PLCTAG_SetR4forzato2
	PLCTAG_SetR5forzato2
	PLCTAG_SetR6forzato2
	PLCTAG_SetR7forzato2
	PLCTAG_SetR8forzato2
	PLCTAG_SetRiciclato1
	PLCTAG_SetRiciclato2
	PLCTAG_SetRiciclato3
	PLCTAG_SetRiciclato4
	PLCTAG_SetRiciclato5
	PLCTAG_SetRiciclato6
	PLCTAG_SetRiciclato7
	PLCTAG_SetRiciclato8
	PLCTAG_ResiduoRiciclato1
	PLCTAG_ResiduoRiciclato2
	PLCTAG_ResiduoRiciclato3
	PLCTAG_ResiduoRiciclato4
	PLCTAG_ResiduoRiciclato5
	PLCTAG_ResiduoRiciclato6
	PLCTAG_ResiduoRiciclato7
	PLCTAG_ResiduoRiciclato8
	PLCTAG_NettoRiciclato1
	PLCTAG_NettoRiciclato2
	PLCTAG_NettoRiciclato3
	PLCTAG_NettoRiciclato4
	PLCTAG_NettoRiciclato5
	PLCTAG_NettoRiciclato6
	PLCTAG_NettoRiciclato7
	PLCTAG_NettoRiciclato8
	PLCTAG_ResiduoBitume1
	PLCTAG_MaggiorazioneBitume1
	PLCTAG_SetBitume1_DosaggioStop
	PLCTAG_SetBitume1
	PLCTAG_NettoBitume1
	PLCTAG_All_Aggregati_PortinaAperta
	PLCTAG_All_Aggregati_PortinaChiusa
	PLCTAG_All_Aggregati_NonTara
	PLCTAG_All_Aggregati_Sicurezza
	PLCTAG_All_Aggregati_FuoriTolleranza
	PLCTAG_All_Aggregati_PerditaPeso
	PLCTAG_All_Aggregati_FineCorsaGenerico
	PLCTAG_AllarmiBool0_7
	PLCTAG_AllarmiBool1_0
	PLCTAG_AllarmiBool1_1
	PLCTAG_AllarmiBool1_2
	PLCTAG_AllarmiBool1_3
	PLCTAG_AllarmiBool1_4
	PLCTAG_AllarmiBool1_5
	PLCTAG_AllarmiBool1_6
	PLCTAG_AllarmiBool1_7
	PLCTAG_All_Filler_PortinaAperta
	PLCTAG_All_Filler_PortinaChiusa
	PLCTAG_All_Filler_NonTara
	PLCTAG_All_Filler_Sicurezza
	PLCTAG_All_Filler_FuoriTolleranza
	PLCTAG_All_Filler_PerditaPeso
	PLCTAG_All_Filler_FineCorsaGenerico
	PLCTAG_AllarmiBool2_7
	PLCTAG_AllarmiBool3_0
	PLCTAG_AllarmiBool3_1
	PLCTAG_AllarmiBool3_2
	PLCTAG_AllarmiBool3_3
	PLCTAG_AllarmiBool3_4
	PLCTAG_AllarmiBool3_5
	PLCTAG_AllarmiBool3_6
	PLCTAG_AllarmiBool3_7
	PLCTAG_All_Bitume_ValvolaAperta
	PLCTAG_All_Bitume_ValvolaChiusa
	PLCTAG_All_Bitume_NonTara
	PLCTAG_All_Bitume_Sicurezza
	PLCTAG_All_Bitume_FuoriTolleranza
	PLCTAG_All_Bitume_PerditaPeso
	PLCTAG_All_Bitume_PompaCircolazioneFerma
	PLCTAG_All_Bitume_FineCorsaGenerico
	PLCTAG_AllarmiBool5_0
	PLCTAG_AllarmiBool5_1
	PLCTAG_AllarmiBool5_2
	PLCTAG_AllarmiBool5_3
	PLCTAG_AllarmiBool5_4
	PLCTAG_AllarmiBool5_5
	PLCTAG_AllarmiBool5_6
	PLCTAG_AllarmiBool5_7
	PLCTAG_All_Mixer_PortinaApertura
	PLCTAG_All_Mixer_PortinaChiusa
	PLCTAG_All_Mixer_MotoreFermo
	PLCTAG_All_Mixer_FineCorsaGenerico
	PLCTAG_AllarmiBool6_4
	PLCTAG_AllarmiBool6_5
	PLCTAG_AllarmiBool6_6
	PLCTAG_AllarmiBool6_7
	PLCTAG_AllarmiBool7_0
	PLCTAG_AllarmiBool7_1
	PLCTAG_AllarmiBool7_2
	PLCTAG_AllarmiBool7_3
	PLCTAG_AllarmiBool7_4
	PLCTAG_AllarmiBool7_5
	PLCTAG_AllarmiBool7_6
	PLCTAG_AllarmiBool7_7
	PLCTAG_All_InserireNumeroRicetta
	PLCTAG_All_PressioneAria
	PLCTAG_AllarmiBool8_2
	PLCTAG_AllarmiBool8_3
	PLCTAG_AllarmiBool8_4
	PLCTAG_AllarmiBool8_5
	PLCTAG_AllarmiBool8_6
	PLCTAG_AllarmiBool8_7
	PLCTAG_All_AdditivoMixer_PompaAccesa
	PLCTAG_All_AdditivoMixer_PompaNoRitorno
	PLCTAG_All_AdditivoMixer_PompaTimeOutAvvio
	PLCTAG_All_AdditivoMixer_PompaTimeOutArresto
	PLCTAG_AllarmiBool9_4
	PLCTAG_AllarmiBool9_5
	PLCTAG_AllarmiBool9_6
	PLCTAG_AllarmiBool9_7
	PLCTAG_All_AdditivoBacinella_PompaAccesa
	PLCTAG_All_AdditivoBacinella_PompaNoRitorno
	PLCTAG_All_AdditivoBacinella_PompaTimeOutAvvio
	PLCTAG_All_AdditivoBacinella_PompaTimeOutArresto
	PLCTAG_All_TermicaPompaAdditivoBacinella
	PLCTAG_All_SicurezzaAdditivoLegante
	PLCTAG_AllarmiBool10_6
	PLCTAG_AllarmiBool10_7
	PLCTAG_All_AdditivoBacinella_ValvolaTimeOutApertura
	PLCTAG_All_AdditivoBacinella_ValvolaTimeOutChiusura
	PLCTAG_All_AdditivoBacinella_ErroreFinecorsaValvola
	PLCTAG_All_AdditivoBacinella_FuoriTolleranza
	PLCTAG_AllarmiBool11_4
	PLCTAG_AllarmiBool11_5
	PLCTAG_AllarmiBool11_6
	PLCTAG_AllarmiBool11_7
	PLCTAG_All_DeflettoreVaglio
	PLCTAG_All_AltaTemperaturaMateriale
	PLCTAG_AllarmiBool12_2
	PLCTAG_AllarmiBool12_3
	PLCTAG_AllarmiBool12_4
	PLCTAG_AllarmiBool12_5
	PLCTAG_AllarmiBool12_6
	PLCTAG_AllarmiBool12_7
	PLCTAG_All_Viatop_FineCorsaBilancia
	PLCTAG_All_Viatop_FineCorsaCiclone
	PLCTAG_All_Viatop_NonTara
	PLCTAG_All_Viatop_Sicurezza
	PLCTAG_All_Viatop_FuoriTolleranza
	PLCTAG_All_Viatop_LivelloMinimo
	PLCTAG_All_Viatop_CiclonePieno
	PLCTAG_All_Viatop_TrasportoViatopFermo
	PLCTAG_All_Viatop_TermicaTrasporto
	PLCTAG_All_Viatop_ScaricoBilanciaAperto
	PLCTAG_All_Viatop_ScaricoBilanciaChiuso
	PLCTAG_All_Viatop_ScaricoCicloneAperto
	PLCTAG_All_Viatop_ScaricoCicloneChiuso
	PLCTAG_All_Viatop_Perdita_Peso '20170224
	PLCTAG_All_Viatop_Timeout_Trasporto_Viatop '20170224
	PLCTAG_All_Viatop_Timeout_Scarico_Ciclone '20170224
	PLCTAG_All_RAP_PortinaAperta
	PLCTAG_All_RAP_PortinaChiusa
	PLCTAG_All_RAP_NonTara
	PLCTAG_All_RAP_Sicurezza
	PLCTAG_All_RAP_FuoriTolleranza
	PLCTAG_All_RAP_PerditaPeso
	PLCTAG_All_RAP_FineCorsaGenerico
	PLCTAG_All_RAP_DeflScarScivAperto
	PLCTAG_All_RAP_DeflScarScivChiuso
	PLCTAG_All_RAP_FCDeflScarSciv
	PLCTAG_AllarmiBool16_2
	PLCTAG_AllarmiBool16_3
	PLCTAG_AllarmiBool16_4
	PLCTAG_AllarmiBool16_5
	PLCTAG_AllarmiBool16_6
	PLCTAG_AllarmiBool16_7
	PLCTAG_All_AdditivoSacchi_NastroTimeOutAvvio
	PLCTAG_All_AdditivoSacchi_NastroNoRitorno
	PLCTAG_All_AdditivoSacchi_NastroTermica
	PLCTAG_All_AdditivoSacchi_NastroTimeOutArresto
	PLCTAG_AllarmiBool17_4
	PLCTAG_AllarmiBool17_5
	PLCTAG_AllarmiBool17_6
	PLCTAG_AllarmiBool17_7
	PLCTAG_All_AdditivoSacchi_PortinaAperta
	PLCTAG_All_AdditivoSacchi_FineCorsa
	PLCTAG_All_AdditivoSacchi_PortinaChiusa
	PLCTAG_All_AdditivoSacchi_TimeOutIntroduzione
	PLCTAG_AllarmiBool18_4
	PLCTAG_AllarmiBool18_5
	PLCTAG_AllarmiBool18_6
	PLCTAG_AllarmiBool18_7
	PLCTAG_All_BitumeGR_ValvolaAperta
	PLCTAG_All_BitumeGR_ValvolaChiusa
	PLCTAG_All_BitumeGR_NonTara
	PLCTAG_All_BitumeGR_Sicurezza
	PLCTAG_All_BitumeGR_FuoriTolleranza
	PLCTAG_All_BitumeGR_PerditaPeso
	PLCTAG_All_BitumeGR_PompaCircolazioneFerma
	PLCTAG_All_BitumeGR_FineCorsaGenerico
	PLCTAG_All_Contalitri_ValvolaAperta
	PLCTAG_All_Contalitri_ValvolaChiusa
	PLCTAG_All_Contalitri_FineCorsaGenerico
	PLCTAG_All_Contalitri_Sicurezza
	PLCTAG_All_Contalitri_FuoriTolleranza
	PLCTAG_All_Contalitri_PompaTimeOutAvvio
	PLCTAG_All_Contalitri_PompaTimeOutArresto
	PLCTAG_AllarmiBool20_7
	PLCTAG_All_SiwaBatch_NastroTimeOutAvvio
	PLCTAG_All_SiwaBatch_NastroNoRitorno
	PLCTAG_All_SiwaBatch_NastroTermica
	PLCTAG_All_SiwaBatch_NastroTimeOutArresto
	PLCTAG_All_SiwaBatch_PortinaTimeOutApertura
	PLCTAG_All_SiwaBatch_PortinaTimeOutChiusura
	PLCTAG_All_SiwaBatch_PortinaErroreFC_Generico
	PLCTAG_All_SiwaBatch_PortinaErroreFC_Chiusa
	PLCTAG_All_SiwaBatch_ErroreDatiDosaggioBilancia
	PLCTAG_All_SiwaBatch_FuoriTolleranza
	PLCTAG_All_Acqua_PompaAccesaSenzaComando
	PLCTAG_All_Acqua_PompaErroreRitorno
	PLCTAG_All_Acqua_PompaTimeOutAvvio
	PLCTAG_All_Acqua_PompaTimeOutArresto
	PLCTAG_All_Acqua_PompaScattoTermica
	PLCTAG_All_Acqua_SicurezzaLivelloMIN
	PLCTAG_All_FineCorsaIntermedioPesataFineA1
	PLCTAG_All_FineCorsaIntermedioPesataFineA2
	PLCTAG_All_FineCorsaIntermedioPesataFineA3
	PLCTAG_All_FineCorsaIntermedioPesataFineA4
	PLCTAG_All_FineCorsaIntermedioPesataFineA5
	PLCTAG_All_FineCorsaIntermedioPesataFineA6
	PLCTAG_All_FineCorsaIntermedioPesataFineA7
	PLCTAG_All_FineCorsaIntermedioPesataFineNV
	PLCTAG_All_RicettaNonCoerente
	PLCTAG_All_RicettaOrdinePortine
	PLCTAG_All_SILO_BassaVel
	PLCTAG_All_SILO_TimeoutAP
	PLCTAG_All_SILO_TimeoutCH
	PLCTAG_All_SILO_ErroreComInverter
	PLCTAG_All_SILO_ErroreInverter
	PLCTAG_All_SILO_ErroreNpInverter
	PLCTAG_All_SILO_FCsicurezzaMin
	PLCTAG_All_SILO_FCsicurezzaMax
	PLCTAG_All_SILO_TermIverterEXT
	PLCTAG_All_SILO_AllarmeBenna
	PLCTAG_All_SILO_Disponibile2
	PLCTAG_All_SILO_Disponibile3
	PLCTAG_All_SILO_Disponibile4
	PLCTAG_All_SILO_Disponibile5
	PLCTAG_All_SILO_Disponibile6
	PLCTAG_All_SILO_Disponibile7
	PLCTAG_All_SILO2_BassaVel
	PLCTAG_All_SILO2_TimeoutAP
	PLCTAG_All_SILO2_TimeoutCH
	PLCTAG_All_SILO2_ErroreComInverter
	PLCTAG_All_SILO2_ErroreInverter
	PLCTAG_All_SILO2_ErroreNpInverter
	PLCTAG_All_SILO2_FCsicurezzaMin
	PLCTAG_All_SILO2_FCsicurezzaMax
	PLCTAG_All_SILO2_TermIverterEXT
	PLCTAG_All_SILO2_AllarmeBenna
	PLCTAG_All_SILO2_Disponibile2
	PLCTAG_All_SILO2_Disponibile3
	PLCTAG_All_SILO2_Disponibile4
	PLCTAG_All_SILO2_Disponibile5
	PLCTAG_All_SILO2_Disponibile6
	PLCTAG_All_SILO2_Disponibile7
	PLCTAG_All_SILO2_MovimentoContemporaneoAssi
	PLCTAG_All_SILOGEN_ErroreCoperchiSIlo
	PLCTAG_ProdottoRicettaOLD
	PLCTAG_ProdottoRicettaInCorso
	PLCTAG_DO_ScaricoAggregati
	PLCTAG_TempoRitardoFiller
	PLCTAG_DO_ScaricoFiller
	PLCTAG_TempoRitardoBitume
	PLCTAG_DO_ScaricoLegante
	PLCTAG_TempoRitardoBitumeGR
	PLCTAG_DO_GravitaScarico
	PLCTAG_ContalitriRitardoScaricoForzatura
	PLCTAG_DO_ContalitriPesataManuale
	PLCTAG_DO_ContalitriPesata
	PLCTAG_DO_PompaAcquaComandoManuale
	PLCTAG_AcquaRitardoScaricoForzatura
	PLCTAG_AcquaDurataSpruzzaturaStorico
	PLCTAG_TempoRitardoViatop
	PLCTAG_DO_ScaricoBilViatop
	PLCTAG_DO_ScaricoCicloneViatop
	PLCTAG_TempoRitardoRAP
	PLCTAG_DO_ScaricoBilRiciclato
	PLCTAG_DO_Defl_Scar_Bil_Ric
	PLCTAG_RitardoAdditivoMixer
	PLCTAG_SetTempoAdditivoMixer
	PLCTAG_DO_PompaAddMixer
	PLCTAG_RitardoAdditivoBacinella
	PLCTAG_SetTempoAdditivoBacinella
	PLCTAG_DO_PompaAddLegante
	PLCTAG_DO_ConsensoIntroSacchi
	PLCTAG_DO_MotoreNastroSacchi
	PLCTAG_NetKgAdditivoBacinella
	PLCTAG_SetKgAdditivoBacinella
	PLCTAG_AI_PEW128
	PLCTAG_AI_PEW130
	PLCTAG_AI_PEW132
	PLCTAG_AI_PEW134
	PLCTAG_AI_PEW136
	PLCTAG_AI_PEW138
	PLCTAG_AI_PEW140
	PLCTAG_AI_PEW142
	PLCTAG_AI_PEW144
	PLCTAG_AI_PEW146
	PLCTAG_AI_PEW148
	PLCTAG_AI_PEW150
	PLCTAG_AI_PEW152
	PLCTAG_AI_PEW154
	PLCTAG_AI_PEW156
	PLCTAG_AI_PEW158
	PLCTAG_AI_PEW160
	PLCTAG_AI_PEW162
	PLCTAG_AI_PEW164
	PLCTAG_AI_PEW166
	PLCTAG_AI_PEW168
	PLCTAG_AI_PEW170
	PLCTAG_AI_PEW172
	PLCTAG_AI_PEW174
	PLCTAG_AI_PEW176
	PLCTAG_AI_PEW178
	PLCTAG_AI_PEW180
	PLCTAG_AI_PEW182
	PLCTAG_AI_PEW184
	PLCTAG_AI_PEW186
	PLCTAG_AI_PEW188
	PLCTAG_AI_PEW190
	PLCTAG_AI_PEW192
	PLCTAG_AI_PEW194
	PLCTAG_AI_PEW196
	PLCTAG_AI_PEW198
	PLCTAG_AI_PEW200
	PLCTAG_AI_PEW202
	PLCTAG_AI_PEW204
	PLCTAG_AI_PEW206
	PLCTAG_AI_PEW208
	PLCTAG_AI_PEW210
	PLCTAG_AI_PEW212
	PLCTAG_AI_PEW214
	PLCTAG_AO_PEW208
	PLCTAG_AO_PEW210
	PLCTAG_AO_PEW212
	PLCTAG_AO_PEW214
	PLCTAG_AO_PEW216
	PLCTAG_AO_PEW218
	PLCTAG_AO_PEW220
	PLCTAG_AO_PEW222
	PLCTAG_AO_PEW224
	PLCTAG_AO_PEW226
	PLCTAG_AO_PEW228
	PLCTAG_AO_PEW230
	PLCTAG_AO_PEW232
	PLCTAG_AO_PEW234
	PLCTAG_AO_PEW236
	PLCTAG_AO_PEW238
	PLCTAG_AI_PEW240
	PLCTAG_AI_PEW242
	PLCTAG_AI_PEW244
	PLCTAG_AI_PEW246
	PLCTAG_AI_PEW248
	PLCTAG_AI_PEW250
	PLCTAG_AI_PEW252
	PLCTAG_AI_PEW254
	PLCTAG_AO_PEW256
	PLCTAG_AO_PEW258
	PLCTAG_AO_PEW260
	PLCTAG_AO_PEW262
	PLCTAG_AI_PEW256
	PLCTAG_AI_PEW258
	PLCTAG_AI_PEW260
	PLCTAG_AI_PEW262
	PLCTAG_AO_PEW290
	PLCTAG_AO_PEW292
	PLCTAG_AO_PEW294
	PLCTAG_AO_PEW296
	PLCTAG_AI_PEW216
	PLCTAG_AI_PEW218
	PLCTAG_AI_PEW220
	PLCTAG_AI_PEW222
	PLCTAG_AI_PEW224
	PLCTAG_AI_PEW226
	PLCTAG_AI_PEW228
	PLCTAG_AI_PEW230
	PLCTAG_AO_PEW240
	PLCTAG_AO_PEW242
	PLCTAG_AO_PEW244
	PLCTAG_AO_PEW246
	PLCTAG_AI_PEW468
	PLCTAG_AI_PEW470
	PLCTAG_AI_PEW472
	PLCTAG_AI_PEW474
	PLCTAG_AI_PEW476
	PLCTAG_AI_PEW478
	PLCTAG_AI_PEW480
	PLCTAG_AI_PEW482
	PLCTAG_AI_PEW484
	PLCTAG_AI_PEW486
	PLCTAG_AI_PEW488
	PLCTAG_AI_PEW490
	PLCTAG_AO_PAW200
	PLCTAG_AO_PAW202
	PLCTAG_AO_PAW204
	PLCTAG_AO_PAW206
	PLCTAG_AI_PEW492
	PLCTAG_AI_PEW494
	PLCTAG_AI_PEW496
	PLCTAG_AI_PEW498
	PLCTAG_AI_PEW232
	PLCTAG_AI_PEW234
	PLCTAG_AI_PEW236
	PLCTAG_AI_PEW238
	PLCTAG_AO_PEW248
	PLCTAG_AO_PEW250
	PLCTAG_AO_PEW252
	PLCTAG_AO_PEW254
	PLCTAG_AI_PEW290
	PLCTAG_AI_PEW292
	PLCTAG_AI_PEW294
	PLCTAG_AI_PEW296
	PLCTAG_BrucAutoStartImpulso
	PLCTAG_BrucAutoEnable
	PLCTAG_BrucAutoApreModulatore
	PLCTAG_BrucAutoDurataImpulso
	PLCTAG_ContalitriNettoKg
	PLCTAG_ContalitriResKg
	PLCTAG_ContalitriSetKg
	PLCTAG_SIWA0_CMD_INPUT
	PLCTAG_SIWA0_CMD_ENABLED
	PLCTAG_SIWA0_CMD_IN_PROGRESS
	PLCTAG_SIWA0_FINISHED_OK
	PLCTAG_SIWA0_CMD_ERR
	PLCTAG_SIWA0_CMD_ERR_CODE
	PLCTAG_SIWA0_SIM_VALUE
	PLCTAG_SIWA0_ANALOG_OUT_VALUE
	PLCTAG_SIWA0_RESERVE_18
	PLCTAG_SIWA0_DIG_OUT_FORCE
	PLCTAG_SIWA0_INFO_REFRESH_COUNT
	PLCTAG_SIWA0_PROCESS_VALUE1
	PLCTAG_SIWA0_PROCESS_VALUE2
	PLCTAG_SIWA0_SCALE_STATUS
	PLCTAG_SIWA0_ERR_MSG
	PLCTAG_SIWA0_ERR_MSG_QUIT
	PLCTAG_SIWA0_ERR_MSG_TYPE
	PLCTAG_SIWA0_ERR_MSG_CODE
	PLCTAG_SIWA0_FB_ERR
	PLCTAG_SIWA0_FB_ERR_CODE
	PLCTAG_SIWA0_COMANDO1_CODICE
	PLCTAG_SIWA0_COMANDO1_ESEGUI
	PLCTAG_SIWA0_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA0_DIGIT_ZERO
	PLCTAG_SIWA0_DIGIT_TARATURA
	PLCTAG_SIWA0_PESO_TARATURA
	PLCTAG_SIWA0_MILLIVOLT
	PLCTAG_SIWA0_FILTRO_FREQ
	PLCTAG_SIWA0_FILTRO_MEDIA
	PLCTAG_SIWA0_ZERO_SETTING_START_UP
	PLCTAG_SIWA0_AUTOZERO
	PLCTAG_SIWA0_MIN_RANGE
	PLCTAG_SIWA0_MAX_RANGE
	PLCTAG_SIWA0_INCREMENT_RANGE
	PLCTAG_SIWA0_PERC_SOTTO_ZERO
	PLCTAG_SIWA0_PERC_SOPRA_ZERO
	PLCTAG_SIWA0_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA0_STANDARD_BELT_SPEED
	PLCTAG_SIWA0_MEASURING_TIME_SPEED
	PLCTAG_SIWA0_IMPULSI_METRO
	PLCTAG_SIWA0_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA0_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA0_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA0_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA0_STANDARD_FLOW
	PLCTAG_SIWA0_LUNGHEZZA
	PLCTAG_SIWA0_CORREZIONE
	PLCTAG_SIWA0_MIN_FLOW_VALUE
	PLCTAG_SIWA0_MAX_FLOW_VALUE
	PLCTAG_SIWA0_MIN_LOAD_VALUE
	PLCTAG_SIWA0_MAX_LOAD_VALUE
	PLCTAG_SIWA0_MIN_TOTALIZING
	PLCTAG_SIWA0_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA0_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA0_TOTALIZING_STEP_1
	PLCTAG_SIWA0_TOTALIZING_STEP_2
	PLCTAG_SIWA0_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA0_PULSE_1_DURATION
	PLCTAG_SIWA0_MINIMUM_PAUSE_1
	PLCTAG_SIWA0_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA0_PULSE_2_DURATION
	PLCTAG_SIWA0_MINIMUM_PAUSE_2
	PLCTAG_SIWA0_OVERLOAD_TIME
	PLCTAG_SIWA0_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA0_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA0_ANALOG_OUT_ZERO
	PLCTAG_SIWA0_ANALOG_OUT_END
	PLCTAG_SIWA0_ANALOG_OUT_CONST
	PLCTAG_SIWA0_ANALOG_OUT_SOURCE
	PLCTAG_SIWA0_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA0_DEFINITION_DO1
	PLCTAG_SIWA0_DEFINITION_DO2
	PLCTAG_SIWA0_DEFINITION_DO3
	PLCTAG_SIWA0_DEFINITION_DI1
	PLCTAG_SIWA0_DEFINITION_DI2
	PLCTAG_SIWA0_DEFINITION_DI3
	PLCTAG_SIWA0_SET_KG
	PLCTAG_SIWA0_VOLO_KG
	PLCTAG_SIWA0_LOG_SELECTION
	PLCTAG_SIWA0_STATUS_SERVICE_ON
	PLCTAG_SIWA0_CALIBRAZIONE_ON
	PLCTAG_SIWA0_PESO_NASTRO
	PLCTAG_SIWA0_VELOX_NASTRO
	PLCTAG_SIWA0_PORTATA_NASTRO
	PLCTAG_SIWA0_AD_DIGIT_FILTERED
	PLCTAG_SIWA0_LETTURASTATO_DI
	PLCTAG_SIWA0_TOTALIZER_5
	PLCTAG_SIWA0_TOTALIZER_6
	PLCTAG_SIWA1_CMD_INPUT
	PLCTAG_SIWA1_CMD_ENABLED
	PLCTAG_SIWA1_CMD_IN_PROGRESS
	PLCTAG_SIWA1_FINISHED_OK
	PLCTAG_SIWA1_CMD_ERR
	PLCTAG_SIWA1_CMD_ERR_CODE
	PLCTAG_SIWA1_SIM_VALUE
	PLCTAG_SIWA1_ANALOG_OUT_VALUE
	PLCTAG_SIWA1_RESERVE_18
	PLCTAG_SIWA1_DIG_OUT_FORCE
	PLCTAG_SIWA1_INFO_REFRESH_COUNT
	PLCTAG_SIWA1_PROCESS_VALUE1
	PLCTAG_SIWA1_PROCESS_VALUE2
	PLCTAG_SIWA1_SCALE_STATUS
	PLCTAG_SIWA1_ERR_MSG
	PLCTAG_SIWA1_ERR_MSG_QUIT
	PLCTAG_SIWA1_ERR_MSG_TYPE
	PLCTAG_SIWA1_ERR_MSG_CODE
	PLCTAG_SIWA1_FB_ERR
	PLCTAG_SIWA1_FB_ERR_CODE
	PLCTAG_SIWA1_COMANDO1_CODICE
	PLCTAG_SIWA1_COMANDO1_ESEGUI
	PLCTAG_SIWA1_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA1_DIGIT_ZERO
	PLCTAG_SIWA1_DIGIT_TARATURA
	PLCTAG_SIWA1_PESO_TARATURA
	PLCTAG_SIWA1_MILLIVOLT
	PLCTAG_SIWA1_FILTRO_FREQ
	PLCTAG_SIWA1_FILTRO_MEDIA
	PLCTAG_SIWA1_ZERO_SETTING_START_UP
	PLCTAG_SIWA1_AUTOZERO
	PLCTAG_SIWA1_MIN_RANGE
	PLCTAG_SIWA1_MAX_RANGE
	PLCTAG_SIWA1_INCREMENT_RANGE
	PLCTAG_SIWA1_PERC_SOTTO_ZERO
	PLCTAG_SIWA1_PERC_SOPRA_ZERO
	PLCTAG_SIWA1_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA1_STANDARD_BELT_SPEED
	PLCTAG_SIWA1_MEASURING_TIME_SPEED
	PLCTAG_SIWA1_IMPULSI_METRO
	PLCTAG_SIWA1_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA1_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA1_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA1_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA1_STANDARD_FLOW
	PLCTAG_SIWA1_LUNGHEZZA
	PLCTAG_SIWA1_CORREZIONE
	PLCTAG_SIWA1_MIN_FLOW_VALUE
	PLCTAG_SIWA1_MAX_FLOW_VALUE
	PLCTAG_SIWA1_MIN_LOAD_VALUE
	PLCTAG_SIWA1_MAX_LOAD_VALUE
	PLCTAG_SIWA1_MIN_TOTALIZING
	PLCTAG_SIWA1_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA1_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA1_TOTALIZING_STEP_1
	PLCTAG_SIWA1_TOTALIZING_STEP_2
	PLCTAG_SIWA1_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA1_PULSE_1_DURATION
	PLCTAG_SIWA1_MINIMUM_PAUSE_1
	PLCTAG_SIWA1_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA1_PULSE_2_DURATION
	PLCTAG_SIWA1_MINIMUM_PAUSE_2
	PLCTAG_SIWA1_OVERLOAD_TIME
	PLCTAG_SIWA1_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA1_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA1_ANALOG_OUT_ZERO
	PLCTAG_SIWA1_ANALOG_OUT_END
	PLCTAG_SIWA1_ANALOG_OUT_CONST
	PLCTAG_SIWA1_ANALOG_OUT_SOURCE
	PLCTAG_SIWA1_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA1_DEFINITION_DO1
	PLCTAG_SIWA1_DEFINITION_DO2
	PLCTAG_SIWA1_DEFINITION_DO3
	PLCTAG_SIWA1_DEFINITION_DI1
	PLCTAG_SIWA1_DEFINITION_DI2
	PLCTAG_SIWA1_DEFINITION_DI3
	PLCTAG_SIWA1_SET_KG
	PLCTAG_SIWA1_VOLO_KG
	PLCTAG_SIWA1_LOG_SELECTION
	PLCTAG_SIWA1_STATUS_SERVICE_ON
	PLCTAG_SIWA1_CALIBRAZIONE_ON
	PLCTAG_SIWA1_PESO_NASTRO
	PLCTAG_SIWA1_VELOX_NASTRO
	PLCTAG_SIWA1_PORTATA_NASTRO
	PLCTAG_SIWA1_AD_DIGIT_FILTERED
	PLCTAG_SIWA1_LETTURASTATO_DI
	PLCTAG_SIWA1_TOTALIZER_5
	PLCTAG_SIWA1_TOTALIZER_6
	PLCTAG_SIWA2_CMD_INPUT
	PLCTAG_SIWA2_CMD_ENABLED
	PLCTAG_SIWA2_CMD_IN_PROGRESS
	PLCTAG_SIWA2_FINISHED_OK
	PLCTAG_SIWA2_CMD_ERR
	PLCTAG_SIWA2_CMD_ERR_CODE
	PLCTAG_SIWA2_SIM_VALUE
	PLCTAG_SIWA2_ANALOG_OUT_VALUE
	PLCTAG_SIWA2_RESERVE_18
	PLCTAG_SIWA2_DIG_OUT_FORCE
	PLCTAG_SIWA2_INFO_REFRESH_COUNT
	PLCTAG_SIWA2_PROCESS_VALUE1
	PLCTAG_SIWA2_PROCESS_VALUE2
	PLCTAG_SIWA2_SCALE_STATUS
	PLCTAG_SIWA2_ERR_MSG
	PLCTAG_SIWA2_ERR_MSG_QUIT
	PLCTAG_SIWA2_ERR_MSG_TYPE
	PLCTAG_SIWA2_ERR_MSG_CODE
	PLCTAG_SIWA2_FB_ERR
	PLCTAG_SIWA2_FB_ERR_CODE
	PLCTAG_SIWA2_COMANDO1_CODICE
	PLCTAG_SIWA2_COMANDO1_ESEGUI
	PLCTAG_SIWA2_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA2_DIGIT_ZERO
	PLCTAG_SIWA2_DIGIT_TARATURA
	PLCTAG_SIWA2_PESO_TARATURA
	PLCTAG_SIWA2_MILLIVOLT
	PLCTAG_SIWA2_FILTRO_FREQ
	PLCTAG_SIWA2_FILTRO_MEDIA
	PLCTAG_SIWA2_ZERO_SETTING_START_UP
	PLCTAG_SIWA2_AUTOZERO
	PLCTAG_SIWA2_MIN_RANGE
	PLCTAG_SIWA2_MAX_RANGE
	PLCTAG_SIWA2_INCREMENT_RANGE
	PLCTAG_SIWA2_PERC_SOTTO_ZERO
	PLCTAG_SIWA2_PERC_SOPRA_ZERO
	PLCTAG_SIWA2_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA2_STANDARD_BELT_SPEED
	PLCTAG_SIWA2_MEASURING_TIME_SPEED
	PLCTAG_SIWA2_IMPULSI_METRO
	PLCTAG_SIWA2_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA2_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA2_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA2_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA2_STANDARD_FLOW
	PLCTAG_SIWA2_LUNGHEZZA
	PLCTAG_SIWA2_CORREZIONE
	PLCTAG_SIWA2_MIN_FLOW_VALUE
	PLCTAG_SIWA2_MAX_FLOW_VALUE
	PLCTAG_SIWA2_MIN_LOAD_VALUE
	PLCTAG_SIWA2_MAX_LOAD_VALUE
	PLCTAG_SIWA2_MIN_TOTALIZING
	PLCTAG_SIWA2_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA2_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA2_TOTALIZING_STEP_1
	PLCTAG_SIWA2_TOTALIZING_STEP_2
	PLCTAG_SIWA2_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA2_PULSE_1_DURATION
	PLCTAG_SIWA2_MINIMUM_PAUSE_1
	PLCTAG_SIWA2_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA2_PULSE_2_DURATION
	PLCTAG_SIWA2_MINIMUM_PAUSE_2
	PLCTAG_SIWA2_OVERLOAD_TIME
	PLCTAG_SIWA2_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA2_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA2_ANALOG_OUT_ZERO
	PLCTAG_SIWA2_ANALOG_OUT_END
	PLCTAG_SIWA2_ANALOG_OUT_CONST
	PLCTAG_SIWA2_ANALOG_OUT_SOURCE
	PLCTAG_SIWA2_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA2_DEFINITION_DO1
	PLCTAG_SIWA2_DEFINITION_DO2
	PLCTAG_SIWA2_DEFINITION_DO3
	PLCTAG_SIWA2_DEFINITION_DI1
	PLCTAG_SIWA2_DEFINITION_DI2
	PLCTAG_SIWA2_DEFINITION_DI3
	PLCTAG_SIWA2_SET_KG
	PLCTAG_SIWA2_VOLO_KG
	PLCTAG_SIWA2_LOG_SELECTION
	PLCTAG_SIWA2_STATUS_SERVICE_ON
	PLCTAG_SIWA2_CALIBRAZIONE_ON
	PLCTAG_SIWA2_PESO_NASTRO
	PLCTAG_SIWA2_VELOX_NASTRO
	PLCTAG_SIWA2_PORTATA_NASTRO
	PLCTAG_SIWA2_AD_DIGIT_FILTERED
	PLCTAG_SIWA2_LETTURASTATO_DI
	PLCTAG_SIWA2_TOTALIZER_5
	PLCTAG_SIWA2_TOTALIZER_6
	PLCTAG_SIWA3_CMD_INPUT
	PLCTAG_SIWA3_CMD_ENABLED
	PLCTAG_SIWA3_CMD_IN_PROGRESS
	PLCTAG_SIWA3_FINISHED_OK
	PLCTAG_SIWA3_CMD_ERR
	PLCTAG_SIWA3_CMD_ERR_CODE
	PLCTAG_SIWA3_SIM_VALUE
	PLCTAG_SIWA3_ANALOG_OUT_VALUE
	PLCTAG_SIWA3_RESERVE_18
	PLCTAG_SIWA3_DIG_OUT_FORCE
	PLCTAG_SIWA3_INFO_REFRESH_COUNT
	PLCTAG_SIWA3_PROCESS_VALUE1
	PLCTAG_SIWA3_PROCESS_VALUE2
	PLCTAG_SIWA3_SCALE_STATUS
	PLCTAG_SIWA3_ERR_MSG
	PLCTAG_SIWA3_ERR_MSG_QUIT
	PLCTAG_SIWA3_ERR_MSG_TYPE
	PLCTAG_SIWA3_ERR_MSG_CODE
	PLCTAG_SIWA3_FB_ERR
	PLCTAG_SIWA3_FB_ERR_CODE
	PLCTAG_SIWA3_COMANDO1_CODICE
	PLCTAG_SIWA3_COMANDO1_ESEGUI
	PLCTAG_SIWA3_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA3_DIGIT_ZERO
	PLCTAG_SIWA3_DIGIT_TARATURA
	PLCTAG_SIWA3_PESO_TARATURA
	PLCTAG_SIWA3_MILLIVOLT
	PLCTAG_SIWA3_FILTRO_FREQ
	PLCTAG_SIWA3_FILTRO_MEDIA
	PLCTAG_SIWA3_ZERO_SETTING_START_UP
	PLCTAG_SIWA3_AUTOZERO
	PLCTAG_SIWA3_MIN_RANGE
	PLCTAG_SIWA3_MAX_RANGE
	PLCTAG_SIWA3_INCREMENT_RANGE
	PLCTAG_SIWA3_PERC_SOTTO_ZERO
	PLCTAG_SIWA3_PERC_SOPRA_ZERO
	PLCTAG_SIWA3_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA3_STANDARD_BELT_SPEED
	PLCTAG_SIWA3_MEASURING_TIME_SPEED
	PLCTAG_SIWA3_IMPULSI_METRO
	PLCTAG_SIWA3_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA3_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA3_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA3_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA3_STANDARD_FLOW
	PLCTAG_SIWA3_LUNGHEZZA
	PLCTAG_SIWA3_CORREZIONE
	PLCTAG_SIWA3_MIN_FLOW_VALUE
	PLCTAG_SIWA3_MAX_FLOW_VALUE
	PLCTAG_SIWA3_MIN_LOAD_VALUE
	PLCTAG_SIWA3_MAX_LOAD_VALUE
	PLCTAG_SIWA3_MIN_TOTALIZING
	PLCTAG_SIWA3_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA3_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA3_TOTALIZING_STEP_1
	PLCTAG_SIWA3_TOTALIZING_STEP_2
	PLCTAG_SIWA3_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA3_PULSE_1_DURATION
	PLCTAG_SIWA3_MINIMUM_PAUSE_1
	PLCTAG_SIWA3_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA3_PULSE_2_DURATION
	PLCTAG_SIWA3_MINIMUM_PAUSE_2
	PLCTAG_SIWA3_OVERLOAD_TIME
	PLCTAG_SIWA3_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA3_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA3_ANALOG_OUT_ZERO
	PLCTAG_SIWA3_ANALOG_OUT_END
	PLCTAG_SIWA3_ANALOG_OUT_CONST
	PLCTAG_SIWA3_ANALOG_OUT_SOURCE
	PLCTAG_SIWA3_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA3_DEFINITION_DO1
	PLCTAG_SIWA3_DEFINITION_DO2
	PLCTAG_SIWA3_DEFINITION_DO3
	PLCTAG_SIWA3_DEFINITION_DI1
	PLCTAG_SIWA3_DEFINITION_DI2
	PLCTAG_SIWA3_DEFINITION_DI3
	PLCTAG_SIWA3_SET_KG
	PLCTAG_SIWA3_VOLO_KG
	PLCTAG_SIWA3_LOG_SELECTION
	PLCTAG_SIWA3_STATUS_SERVICE_ON
	PLCTAG_SIWA3_CALIBRAZIONE_ON
	PLCTAG_SIWA3_PESO_NASTRO
	PLCTAG_SIWA3_VELOX_NASTRO
	PLCTAG_SIWA3_PORTATA_NASTRO
	PLCTAG_SIWA3_AD_DIGIT_FILTERED
	PLCTAG_SIWA3_LETTURASTATO_DI
	PLCTAG_SIWA3_TOTALIZER_5
	PLCTAG_SIWA3_TOTALIZER_6
	PLCTAG_SIWA4_CMD_INPUT
	PLCTAG_SIWA4_CMD_ENABLED
	PLCTAG_SIWA4_CMD_IN_PROGRESS
	PLCTAG_SIWA4_FINISHED_OK
	PLCTAG_SIWA4_CMD_ERR
	PLCTAG_SIWA4_CMD_ERR_CODE
	PLCTAG_SIWA4_SIM_VALUE
	PLCTAG_SIWA4_ANALOG_OUT_VALUE
	PLCTAG_SIWA4_RESERVE_18
	PLCTAG_SIWA4_DIG_OUT_FORCE
	PLCTAG_SIWA4_INFO_REFRESH_COUNT
	PLCTAG_SIWA4_PROCESS_VALUE1
	PLCTAG_SIWA4_PROCESS_VALUE2
	PLCTAG_SIWA4_SCALE_STATUS
	PLCTAG_SIWA4_ERR_MSG
	PLCTAG_SIWA4_ERR_MSG_QUIT
	PLCTAG_SIWA4_ERR_MSG_TYPE
	PLCTAG_SIWA4_ERR_MSG_CODE
	PLCTAG_SIWA4_FB_ERR
	PLCTAG_SIWA4_FB_ERR_CODE
	PLCTAG_SIWA4_COMANDO1_CODICE
	PLCTAG_SIWA4_COMANDO1_ESEGUI
	PLCTAG_SIWA4_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA4_DIGIT_ZERO
	PLCTAG_SIWA4_DIGIT_TARATURA
	PLCTAG_SIWA4_PESO_TARATURA
	PLCTAG_SIWA4_MILLIVOLT
	PLCTAG_SIWA4_FILTRO_FREQ
	PLCTAG_SIWA4_FILTRO_MEDIA
	PLCTAG_SIWA4_ZERO_SETTING_START_UP
	PLCTAG_SIWA4_AUTOZERO
	PLCTAG_SIWA4_MIN_RANGE
	PLCTAG_SIWA4_MAX_RANGE
	PLCTAG_SIWA4_INCREMENT_RANGE
	PLCTAG_SIWA4_PERC_SOTTO_ZERO
	PLCTAG_SIWA4_PERC_SOPRA_ZERO
	PLCTAG_SIWA4_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA4_STANDARD_BELT_SPEED
	PLCTAG_SIWA4_MEASURING_TIME_SPEED
	PLCTAG_SIWA4_IMPULSI_METRO
	PLCTAG_SIWA4_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA4_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA4_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA4_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA4_STANDARD_FLOW
	PLCTAG_SIWA4_LUNGHEZZA
	PLCTAG_SIWA4_CORREZIONE
	PLCTAG_SIWA4_MIN_FLOW_VALUE
	PLCTAG_SIWA4_MAX_FLOW_VALUE
	PLCTAG_SIWA4_MIN_LOAD_VALUE
	PLCTAG_SIWA4_MAX_LOAD_VALUE
	PLCTAG_SIWA4_MIN_TOTALIZING
	PLCTAG_SIWA4_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA4_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA4_TOTALIZING_STEP_1
	PLCTAG_SIWA4_TOTALIZING_STEP_2
	PLCTAG_SIWA4_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA4_PULSE_1_DURATION
	PLCTAG_SIWA4_MINIMUM_PAUSE_1
	PLCTAG_SIWA4_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA4_PULSE_2_DURATION
	PLCTAG_SIWA4_MINIMUM_PAUSE_2
	PLCTAG_SIWA4_OVERLOAD_TIME
	PLCTAG_SIWA4_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA4_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA4_ANALOG_OUT_ZERO
	PLCTAG_SIWA4_ANALOG_OUT_END
	PLCTAG_SIWA4_ANALOG_OUT_CONST
	PLCTAG_SIWA4_ANALOG_OUT_SOURCE
	PLCTAG_SIWA4_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA4_DEFINITION_DO1
	PLCTAG_SIWA4_DEFINITION_DO2
	PLCTAG_SIWA4_DEFINITION_DO3
	PLCTAG_SIWA4_DEFINITION_DI1
	PLCTAG_SIWA4_DEFINITION_DI2
	PLCTAG_SIWA4_DEFINITION_DI3
	PLCTAG_SIWA4_SET_KG
	PLCTAG_SIWA4_VOLO_KG
	PLCTAG_SIWA4_LOG_SELECTION
	PLCTAG_SIWA4_STATUS_SERVICE_ON
	PLCTAG_SIWA4_CALIBRAZIONE_ON
	PLCTAG_SIWA4_PESO_NASTRO
	PLCTAG_SIWA4_VELOX_NASTRO
	PLCTAG_SIWA4_PORTATA_NASTRO
	PLCTAG_SIWA4_AD_DIGIT_FILTERED
	PLCTAG_SIWA4_LETTURASTATO_DI
	PLCTAG_SIWA4_TOTALIZER_5
	PLCTAG_SIWA4_TOTALIZER_6
	PLCTAG_SIWA5_CMD_INPUT
	PLCTAG_SIWA5_CMD_ENABLED
	PLCTAG_SIWA5_CMD_IN_PROGRESS
	PLCTAG_SIWA5_FINISHED_OK
	PLCTAG_SIWA5_CMD_ERR
	PLCTAG_SIWA5_CMD_ERR_CODE
	PLCTAG_SIWA5_SIM_VALUE
	PLCTAG_SIWA5_ANALOG_OUT_VALUE
	PLCTAG_SIWA5_RESERVE_18
	PLCTAG_SIWA5_DIG_OUT_FORCE
	PLCTAG_SIWA5_INFO_REFRESH_COUNT
	PLCTAG_SIWA5_PROCESS_VALUE1
	PLCTAG_SIWA5_PROCESS_VALUE2
	PLCTAG_SIWA5_SCALE_STATUS
	PLCTAG_SIWA5_ERR_MSG
	PLCTAG_SIWA5_ERR_MSG_QUIT
	PLCTAG_SIWA5_ERR_MSG_TYPE
	PLCTAG_SIWA5_ERR_MSG_CODE
	PLCTAG_SIWA5_FB_ERR
	PLCTAG_SIWA5_FB_ERR_CODE
	PLCTAG_SIWA5_COMANDO1_CODICE
	PLCTAG_SIWA5_COMANDO1_ESEGUI
	PLCTAG_SIWA5_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA5_DIGIT_ZERO
	PLCTAG_SIWA5_DIGIT_TARATURA
	PLCTAG_SIWA5_PESO_TARATURA
	PLCTAG_SIWA5_MILLIVOLT
	PLCTAG_SIWA5_FILTRO_FREQ
	PLCTAG_SIWA5_FILTRO_MEDIA
	PLCTAG_SIWA5_ZERO_SETTING_START_UP
	PLCTAG_SIWA5_AUTOZERO
	PLCTAG_SIWA5_MIN_RANGE
	PLCTAG_SIWA5_MAX_RANGE
	PLCTAG_SIWA5_INCREMENT_RANGE
	PLCTAG_SIWA5_PERC_SOTTO_ZERO
	PLCTAG_SIWA5_PERC_SOPRA_ZERO
	PLCTAG_SIWA5_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA5_STANDARD_BELT_SPEED
	PLCTAG_SIWA5_MEASURING_TIME_SPEED
	PLCTAG_SIWA5_IMPULSI_METRO
	PLCTAG_SIWA5_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA5_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA5_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA5_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA5_STANDARD_FLOW
	PLCTAG_SIWA5_LUNGHEZZA
	PLCTAG_SIWA5_CORREZIONE
	PLCTAG_SIWA5_MIN_FLOW_VALUE
	PLCTAG_SIWA5_MAX_FLOW_VALUE
	PLCTAG_SIWA5_MIN_LOAD_VALUE
	PLCTAG_SIWA5_MAX_LOAD_VALUE
	PLCTAG_SIWA5_MIN_TOTALIZING
	PLCTAG_SIWA5_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA5_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA5_TOTALIZING_STEP_1
	PLCTAG_SIWA5_TOTALIZING_STEP_2
	PLCTAG_SIWA5_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA5_PULSE_1_DURATION
	PLCTAG_SIWA5_MINIMUM_PAUSE_1
	PLCTAG_SIWA5_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA5_PULSE_2_DURATION
	PLCTAG_SIWA5_MINIMUM_PAUSE_2
	PLCTAG_SIWA5_OVERLOAD_TIME
	PLCTAG_SIWA5_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA5_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA5_ANALOG_OUT_ZERO
	PLCTAG_SIWA5_ANALOG_OUT_END
	PLCTAG_SIWA5_ANALOG_OUT_CONST
	PLCTAG_SIWA5_ANALOG_OUT_SOURCE
	PLCTAG_SIWA5_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA5_DEFINITION_DO1
	PLCTAG_SIWA5_DEFINITION_DO2
	PLCTAG_SIWA5_DEFINITION_DO3
	PLCTAG_SIWA5_DEFINITION_DI1
	PLCTAG_SIWA5_DEFINITION_DI2
	PLCTAG_SIWA5_DEFINITION_DI3
	PLCTAG_SIWA5_SET_KG
	PLCTAG_SIWA5_VOLO_KG
	PLCTAG_SIWA5_LOG_SELECTION
	PLCTAG_SIWA5_STATUS_SERVICE_ON
	PLCTAG_SIWA5_CALIBRAZIONE_ON
	PLCTAG_SIWA5_PESO_NASTRO
	PLCTAG_SIWA5_VELOX_NASTRO
	PLCTAG_SIWA5_PORTATA_NASTRO
	PLCTAG_SIWA5_AD_DIGIT_FILTERED
	PLCTAG_SIWA5_LETTURASTATO_DI
	PLCTAG_SIWA5_TOTALIZER_5
	PLCTAG_SIWA5_TOTALIZER_6
	PLCTAG_SIWA6_CMD_INPUT
	PLCTAG_SIWA6_CMD_ENABLED
	PLCTAG_SIWA6_CMD_IN_PROGRESS
	PLCTAG_SIWA6_FINISHED_OK
	PLCTAG_SIWA6_CMD_ERR
	PLCTAG_SIWA6_CMD_ERR_CODE
	PLCTAG_SIWA6_SIM_VALUE
	PLCTAG_SIWA6_ANALOG_OUT_VALUE
	PLCTAG_SIWA6_RESERVE_18
	PLCTAG_SIWA6_DIG_OUT_FORCE
	PLCTAG_SIWA6_INFO_REFRESH_COUNT
	PLCTAG_SIWA6_PROCESS_VALUE1
	PLCTAG_SIWA6_PROCESS_VALUE2
	PLCTAG_SIWA6_SCALE_STATUS
	PLCTAG_SIWA6_ERR_MSG
	PLCTAG_SIWA6_ERR_MSG_QUIT
	PLCTAG_SIWA6_ERR_MSG_TYPE
	PLCTAG_SIWA6_ERR_MSG_CODE
	PLCTAG_SIWA6_FB_ERR
	PLCTAG_SIWA6_FB_ERR_CODE
	PLCTAG_SIWA6_COMANDO1_CODICE
	PLCTAG_SIWA6_COMANDO1_ESEGUI
	PLCTAG_SIWA6_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA6_DIGIT_ZERO
	PLCTAG_SIWA6_DIGIT_TARATURA
	PLCTAG_SIWA6_PESO_TARATURA
	PLCTAG_SIWA6_MILLIVOLT
	PLCTAG_SIWA6_FILTRO_FREQ
	PLCTAG_SIWA6_FILTRO_MEDIA
	PLCTAG_SIWA6_ZERO_SETTING_START_UP
	PLCTAG_SIWA6_AUTOZERO
	PLCTAG_SIWA6_MIN_RANGE
	PLCTAG_SIWA6_MAX_RANGE
	PLCTAG_SIWA6_INCREMENT_RANGE
	PLCTAG_SIWA6_PERC_SOTTO_ZERO
	PLCTAG_SIWA6_PERC_SOPRA_ZERO
	PLCTAG_SIWA6_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA6_STANDARD_BELT_SPEED
	PLCTAG_SIWA6_MEASURING_TIME_SPEED
	PLCTAG_SIWA6_IMPULSI_METRO
	PLCTAG_SIWA6_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA6_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA6_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA6_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA6_STANDARD_FLOW
	PLCTAG_SIWA6_LUNGHEZZA
	PLCTAG_SIWA6_CORREZIONE
	PLCTAG_SIWA6_MIN_FLOW_VALUE
	PLCTAG_SIWA6_MAX_FLOW_VALUE
	PLCTAG_SIWA6_MIN_LOAD_VALUE
	PLCTAG_SIWA6_MAX_LOAD_VALUE
	PLCTAG_SIWA6_MIN_TOTALIZING
	PLCTAG_SIWA6_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA6_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA6_TOTALIZING_STEP_1
	PLCTAG_SIWA6_TOTALIZING_STEP_2
	PLCTAG_SIWA6_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA6_PULSE_1_DURATION
	PLCTAG_SIWA6_MINIMUM_PAUSE_1
	PLCTAG_SIWA6_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA6_PULSE_2_DURATION
	PLCTAG_SIWA6_MINIMUM_PAUSE_2
	PLCTAG_SIWA6_OVERLOAD_TIME
	PLCTAG_SIWA6_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA6_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA6_ANALOG_OUT_ZERO
	PLCTAG_SIWA6_ANALOG_OUT_END
	PLCTAG_SIWA6_ANALOG_OUT_CONST
	PLCTAG_SIWA6_ANALOG_OUT_SOURCE
	PLCTAG_SIWA6_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA6_DEFINITION_DO1
	PLCTAG_SIWA6_DEFINITION_DO2
	PLCTAG_SIWA6_DEFINITION_DO3
	PLCTAG_SIWA6_DEFINITION_DI1
	PLCTAG_SIWA6_DEFINITION_DI2
	PLCTAG_SIWA6_DEFINITION_DI3
	PLCTAG_SIWA6_SET_KG
	PLCTAG_SIWA6_VOLO_KG
	PLCTAG_SIWA6_LOG_SELECTION
	PLCTAG_SIWA6_STATUS_SERVICE_ON
	PLCTAG_SIWA6_CALIBRAZIONE_ON
	PLCTAG_SIWA6_PESO_NASTRO
	PLCTAG_SIWA6_VELOX_NASTRO
	PLCTAG_SIWA6_PORTATA_NASTRO
	PLCTAG_SIWA6_AD_DIGIT_FILTERED
	PLCTAG_SIWA6_LETTURASTATO_DI
	PLCTAG_SIWA6_TOTALIZER_5
	PLCTAG_SIWA6_TOTALIZER_6
	PLCTAG_SIWA7_CMD_INPUT
	PLCTAG_SIWA7_CMD_ENABLED
	PLCTAG_SIWA7_CMD_IN_PROGRESS
	PLCTAG_SIWA7_FINISHED_OK
	PLCTAG_SIWA7_CMD_ERR
	PLCTAG_SIWA7_CMD_ERR_CODE
	PLCTAG_SIWA7_SIM_VALUE
	PLCTAG_SIWA7_ANALOG_OUT_VALUE
	PLCTAG_SIWA7_RESERVE_18
	PLCTAG_SIWA7_DIG_OUT_FORCE
	PLCTAG_SIWA7_INFO_REFRESH_COUNT
	PLCTAG_SIWA7_PROCESS_VALUE1
	PLCTAG_SIWA7_PROCESS_VALUE2
	PLCTAG_SIWA7_SCALE_STATUS
	PLCTAG_SIWA7_ERR_MSG
	PLCTAG_SIWA7_ERR_MSG_QUIT
	PLCTAG_SIWA7_ERR_MSG_TYPE
	PLCTAG_SIWA7_ERR_MSG_CODE
	PLCTAG_SIWA7_FB_ERR
	PLCTAG_SIWA7_FB_ERR_CODE
	PLCTAG_SIWA7_COMANDO1_CODICE
	PLCTAG_SIWA7_COMANDO1_ESEGUI
	PLCTAG_SIWA7_COMANDO1_IN_ESECUZIONE
	PLCTAG_SIWA7_DIGIT_ZERO
	PLCTAG_SIWA7_DIGIT_TARATURA
	PLCTAG_SIWA7_PESO_TARATURA
	PLCTAG_SIWA7_MILLIVOLT
	PLCTAG_SIWA7_FILTRO_FREQ
	PLCTAG_SIWA7_FILTRO_MEDIA
	PLCTAG_SIWA7_ZERO_SETTING_START_UP
	PLCTAG_SIWA7_AUTOZERO
	PLCTAG_SIWA7_MIN_RANGE
	PLCTAG_SIWA7_MAX_RANGE
	PLCTAG_SIWA7_INCREMENT_RANGE
	PLCTAG_SIWA7_PERC_SOTTO_ZERO
	PLCTAG_SIWA7_PERC_SOPRA_ZERO
	PLCTAG_SIWA7_TEMPO_CALIBRAZIONE
	PLCTAG_SIWA7_STANDARD_BELT_SPEED
	PLCTAG_SIWA7_MEASURING_TIME_SPEED
	PLCTAG_SIWA7_IMPULSI_METRO
	PLCTAG_SIWA7_MIN_BELT_SPEED_VALUE
	PLCTAG_SIWA7_MAX_BELT_SPEED_VALUE
	PLCTAG_SIWA7_ALARM_DELAY_START_UP_SPEED
	PLCTAG_SIWA7_ALARM_DELAY_IN_OPERATION_SPEED
	PLCTAG_SIWA7_STANDARD_FLOW
	PLCTAG_SIWA7_LUNGHEZZA
	PLCTAG_SIWA7_CORREZIONE
	PLCTAG_SIWA7_MIN_FLOW_VALUE
	PLCTAG_SIWA7_MAX_FLOW_VALUE
	PLCTAG_SIWA7_MIN_LOAD_VALUE
	PLCTAG_SIWA7_MAX_LOAD_VALUE
	PLCTAG_SIWA7_MIN_TOTALIZING
	PLCTAG_SIWA7_ALARM_DELAY_START_UP_FLOW_LOAD
	PLCTAG_SIWA7_ALARM_DELAY_IN_OPERATION_FLOW_LOAD
	PLCTAG_SIWA7_TOTALIZING_STEP_1
	PLCTAG_SIWA7_TOTALIZING_STEP_2
	PLCTAG_SIWA7_QUANTITY_PER_PULSE_1
	PLCTAG_SIWA7_PULSE_1_DURATION
	PLCTAG_SIWA7_MINIMUM_PAUSE_1
	PLCTAG_SIWA7_QUANTITY_PER_PULSE_2
	PLCTAG_SIWA7_PULSE_2_DURATION
	PLCTAG_SIWA7_MINIMUM_PAUSE_2
	PLCTAG_SIWA7_OVERLOAD_TIME
	PLCTAG_SIWA7_PROCESS_VALUE_OUTPUT
	PLCTAG_SIWA7_PROCESS_VALUE_OUTPUT_2
	PLCTAG_SIWA7_ANALOG_OUT_ZERO
	PLCTAG_SIWA7_ANALOG_OUT_END
	PLCTAG_SIWA7_ANALOG_OUT_CONST
	PLCTAG_SIWA7_ANALOG_OUT_SOURCE
	PLCTAG_SIWA7_ANALOG_OUT_4_20_M_AMP
	PLCTAG_SIWA7_DEFINITION_DO1
	PLCTAG_SIWA7_DEFINITION_DO2
	PLCTAG_SIWA7_DEFINITION_DO3
	PLCTAG_SIWA7_DEFINITION_DI1
	PLCTAG_SIWA7_DEFINITION_DI2
	PLCTAG_SIWA7_DEFINITION_DI3
	PLCTAG_SIWA7_SET_KG
	PLCTAG_SIWA7_VOLO_KG
	PLCTAG_SIWA7_LOG_SELECTION
	PLCTAG_SIWA7_STATUS_SERVICE_ON
	PLCTAG_SIWA7_CALIBRAZIONE_ON
	PLCTAG_SIWA7_PESO_NASTRO
	PLCTAG_SIWA7_VELOX_NASTRO
	PLCTAG_SIWA7_PORTATA_NASTRO
	PLCTAG_SIWA7_AD_DIGIT_FILTERED
	PLCTAG_SIWA7_LETTURASTATO_DI
	PLCTAG_SIWA7_TOTALIZER_5
	PLCTAG_SIWA7_TOTALIZER_6
	PLCTAG_NEMO_ISTANTANEO_1
	PLCTAG_NEMO_ISTANTANEO_2
	PLCTAG_NEMO_ISTANTANEO_3
	PLCTAG_NEMO_ISTANTANEO_4
	PLCTAG_NEMO_ISTANTANEO_5
	PLCTAG_NEMO_ISTANTANEO_6
	PLCTAG_NEMO_ISTANTANEO_7
	PLCTAG_NEMO_ISTANTANEO_8
	PLCTAG_NEMO_ISTANTANEO_9
	PLCTAG_NEMO_ISTANTANEO_10
	PLCTAG_NEMO_ISTANTANEO_11
	PLCTAG_NEMO_ISTANTANEO_12
	PLCTAG_NEMO_ISTANTANEO_13
	PLCTAG_NEMO_ISTANTANEO_14
	PLCTAG_NEMO_ISTANTANEO_15
	PLCTAG_NEMO_ISTANTANEO_16
	PLCTAG_NEMO_ISTANTANEO_17
	PLCTAG_NEMO_ISTANTANEO_18
	PLCTAG_NEMO_ISTANTANEO_19
	PLCTAG_NEMO_ISTANTANEO_20
	PLCTAG_NEMO_PICCO_RESET_1
	PLCTAG_NEMO_PICCO_1
	PLCTAG_NEMO_PICCO_RESET_2
	PLCTAG_NEMO_PICCO_2
	PLCTAG_NEMO_PICCO_RESET_3
	PLCTAG_NEMO_PICCO_3
	PLCTAG_NEMO_PICCO_RESET_4
	PLCTAG_NEMO_PICCO_4
	PLCTAG_NEMO_PICCO_RESET_5
	PLCTAG_NEMO_PICCO_5
	PLCTAG_NEMO_PICCO_RESET_6
	PLCTAG_NEMO_PICCO_6
	PLCTAG_NEMO_PICCO_RESET_7
	PLCTAG_NEMO_PICCO_7
	PLCTAG_NEMO_PICCO_RESET_8
	PLCTAG_NEMO_PICCO_8
	PLCTAG_NEMO_PICCO_RESET_9
	PLCTAG_NEMO_PICCO_9
	PLCTAG_NEMO_PICCO_RESET_10
	PLCTAG_NEMO_PICCO_10
	PLCTAG_NEMO_PICCO_RESET_11
	PLCTAG_NEMO_PICCO_11
	PLCTAG_NEMO_PICCO_RESET_12
	PLCTAG_NEMO_PICCO_12
	PLCTAG_NEMO_PICCO_RESET_13
	PLCTAG_NEMO_PICCO_13
	PLCTAG_NEMO_PICCO_RESET_14
	PLCTAG_NEMO_PICCO_14
	PLCTAG_NEMO_PICCO_RESET_15
	PLCTAG_NEMO_PICCO_15
	PLCTAG_NEMO_PICCO_RESET_16
	PLCTAG_NEMO_PICCO_16
	PLCTAG_NEMO_PICCO_RESET_17
	PLCTAG_NEMO_PICCO_17
	PLCTAG_NEMO_PICCO_RESET_18
	PLCTAG_NEMO_PICCO_18
	PLCTAG_NEMO_PICCO_RESET_19
	PLCTAG_NEMO_PICCO_19
	PLCTAG_NEMO_PICCO_RESET_20
	PLCTAG_NEMO_PICCO_20
	PLCTAG_SelezioneBennaS7
	PLCTAG_CelleSilo_0_0
	PLCTAG_CelleSilo_0_1
	PLCTAG_CelleSilo_0_2
	PLCTAG_CelleSilo_0_3
	PLCTAG_CelleSilo_EnableCarico_1
	PLCTAG_CelleSilo_EnableScarico_1
	PLCTAG_CelleSilo_EnableCarico_2
	PLCTAG_CelleSilo_EnableScarico_2
	PLCTAG_CelleSilo_EnableCarico_3
	PLCTAG_CelleSilo_EnableScarico_3
	PLCTAG_CelleSilo_EnableCarico_4
	PLCTAG_CelleSilo_EnableScarico_4
	PLCTAG_CelleSilo_1_4
	PLCTAG_CelleSilo_1_5
	PLCTAG_CelleSilo_1_6
	PLCTAG_CelleSilo_1_7
	PLCTAG_DB307_ZeroEnable
	PLCTAG_DB307_PosiEnable
	PLCTAG_DB307_FC_Zero
	PLCTAG_DB307_ExtraMax
	PLCTAG_DB307_FC_Min
	PLCTAG_DB307_ExtraMin
	PLCTAG_DB307_Bipolar
	PLCTAG_DB307_StartUp
	PLCTAG_DB307_Preset
	PLCTAG_DB307_Target
	PLCTAG_DB307_Finestra
	PLCTAG_DB307_Value
	PLCTAG_DB307_Speed
	PLCTAG_DB307_StartSyncro
	PLCTAG_DB307_StartPosi
	PLCTAG_DB307_Direzione
	PLCTAG_DB307_InFinestra
	PLCTAG_DB307_SyncroOn
	PLCTAG_DB307_AuxZero
	PLCTAG_DB307_DifZero
	PLCTAG_DB307_MoveMin
	PLCTAG_DB307_MoveMax
	PLCTAG_DB307_MoveZero
	PLCTAG_DB307_SeroSearch
	PLCTAG_DB307_AuxStart
	PLCTAG_DB307_Zero
	PLCTAG_DB307_ZeroError
	PLCTAG_DB307_PosiOn
	PLCTAG_DB307_InPosition
	PLCTAG_DB307_EndPos
	PLCTAG_DB307_RapportoImpulsiUnitaMisura
	PLCTAG_DB307_Zeroset_MoveSpeed
	PLCTAG_DB307_Zeroset_SearchSpeed
	PLCTAG_DB307_Zeroset_ZeroSpeed
	PLCTAG_DB307_Posiset_VeloxMax
	PLCTAG_DB307_Posiset_VeloxMin
	PLCTAG_DB307_Posiset_RampaUP
	PLCTAG_DB307_Posiset_RampaDOWN
	PLCTAG_DB307_Posiset_Tolleranza
	PLCTAG_DB307_Posiset_Posi_P
	PLCTAG_DB307_Posiset_Posi_M
	PLCTAG_DB307_Posiset_StartValue
	PLCTAG_DB307_Posiset_Differenza
	PLCTAG_DB307_RitPosi_PT
	PLCTAG_DB301_TempoSpruzzaAntiadesivo
	PLCTAG_DB301_SpruzzaturaAntiadesivo
	PLCTAG_DB310_PienoDaMescolatore
	PLCTAG_DB310_FC_Aperto
	PLCTAG_DB310_FC_Chiuso
	PLCTAG_DB310_unused1
	PLCTAG_DB310_unused2
	PLCTAG_DB310_ManuApre
	PLCTAG_DB310_ManuChiude
	PLCTAG_DB310_ManuPosi
	PLCTAG_DB310_ManuZero
	PLCTAG_DB310_ConsensoApre
	PLCTAG_DB310_ConsensoStart
	PLCTAG_DB310_InPosizione
	PLCTAG_DB310_CopyInhibit
	PLCTAG_DB310_ApreBenna
	PLCTAG_DB310_RitornoZero
	PLCTAG_DB310_StartPosiziona
	PLCTAG_DB310_ConsensoMescolatore
	PLCTAG_DB310_AllarmeApre
	PLCTAG_DB310_AllarmeChiude
	PLCTAG_DB310_BennaPiena
	PLCTAG_DB310_BennaVuota
	PLCTAG_DB310_AuxPieno
	PLCTAG_DB310_ChiudeBenna
	PLCTAG_DB310_AuxPosi
	PLCTAG_DB310_TimeOutApre_PT
	PLCTAG_DB310_TimeOutChiude_PT
	PLCTAG_DB310_TempoScarico_PT
	PLCTAG_DB310_WORK_RicettaUsata
	PLCTAG_DB310_WORK_PesoScaricato
	PLCTAG_DB310_WORK_Destinazione
	PLCTAG_DB310_WORK_Posizione
	PLCTAG_DB309_Posizione1
	PLCTAG_DB309_Posizione2
	PLCTAG_DB309_Posizione3
	PLCTAG_DB309_Posizione4
	PLCTAG_DB309_Posizione5
	PLCTAG_DB309_Posizione6
	PLCTAG_DB309_Posizione7
	PLCTAG_DB309_Posizione8
	PLCTAG_DB309_Posizione9
	PLCTAG_DB309_Posizione10
	PLCTAG_DB309_Posizione11
	PLCTAG_DB309_Posizione12
	PLCTAG_DB309_Posizione13
	PLCTAG_DB309_Posizione14
	PLCTAG_DB309_Posizione15
	PLCTAG_DB309_Posizione16
	PLCTAG_DB309_Posizione17
	PLCTAG_DB309_Posizione18
	PLCTAG_DB309_Posizione19
	PLCTAG_DB309_Posizione20
	PLCTAG_DB309_Posizione21
	PLCTAG_DB312_VelocitaCalc
	PLCTAG_DB302_VelocitaInverterTeo
	PLCTAG_DB302_VelocitaInverterReale
	PLCTAG_DB302_ErroreComunicazione
	PLCTAG_DB302_ErroreInverter
	PLCTAG_DB302_NonProntoInverter
	PLCTAG_DB322_AckAllarme
	PLCTAG_DB322_ScriviParametro
	PLCTAG_DB322_AbilitaJog
	PLCTAG_DB322_Jog_DX
	PLCTAG_DB322_Jog_SX
	PLCTAG_DB518_FwLocked
	PLCTAG_DB518_BwLocked
	PLCTAG_SILOGEN_AUTOMATICO
	PLCTAG_SILOGEN_MANUALE
	PLCTAG_ERR_ASSE_P
	PLCTAG_ERR_ASSE_A
	PLCTAG_SILOGEN_SALITAMANUALEASSE2
	PLCTAG_SILOGEN_DISCESAMANUALEASSE2
	PLCTAG_SILOGEN_SALITAMANUALEASSE
	PLCTAG_SILOGEN_DISCESAMANUALEASSE
	PLCTAG_SILOGEN_MEMSALITABENNA
	PLCTAG_SILO2_Presenza
	PLCTAG_SILO2_FwLocked
	PLCTAG_SILO2_BwLocked
	PLCTAG_SILO2_ZeroEnable
	PLCTAG_SILO2_PosiEnable
	PLCTAG_SILO2_FC_Zero
	PLCTAG_SILO2_ExtraMax
	PLCTAG_SILO2_FC_Min
	PLCTAG_SILO2_ExtraMin
	PLCTAG_SILO2_Bipolar
	PLCTAG_SILO2_StartUp
	PLCTAG_SILO2_Preset
	PLCTAG_SILO2_Target
	PLCTAG_SILO2_Finestra
	PLCTAG_SILO2_Value
	PLCTAG_SILO2_Speed
	PLCTAG_SILO2_StartSyncro
	PLCTAG_SILO2_StartPosi
	PLCTAG_SILO2_Direzione
	PLCTAG_SILO2_InFinestra
	PLCTAG_SILO2_SyncroOn
	PLCTAG_SILO2_AuxZero
	PLCTAG_SILO2_DifZero
	PLCTAG_SILO2_MoveMin
	PLCTAG_SILO2_MoveMax
	PLCTAG_SILO2_MoveZero
	PLCTAG_SILO2_SeroSearch
	PLCTAG_SILO2_AuxStart
	PLCTAG_SILO2_Zero
	PLCTAG_SILO2_ZeroError
	PLCTAG_SILO2_PosiOn
	PLCTAG_SILO2_InPosition
	PLCTAG_SILO2_EndPos
	PLCTAG_SILO2_RapportoImpulsiUnitaMisura
	PLCTAG_SILO2_Zeroset_MoveSpeed
	PLCTAG_SILO2_Zeroset_SearchSpeed
	PLCTAG_SILO2_Zeroset_ZeroSpeed
	PLCTAG_SILO2_Posiset_VeloxMax
	PLCTAG_SILO2_Posiset_VeloxMin
	PLCTAG_SILO2_Posiset_RampaUP
	PLCTAG_SILO2_Posiset_RampaDOWN
	PLCTAG_SILO2_Posiset_Tolleranza
	PLCTAG_SILO2_Posiset_Posi_P
	PLCTAG_SILO2_Posiset_Posi_M
	PLCTAG_SILO2_Posiset_StartValue
	PLCTAG_SILO2_Posiset_Differenza
	PLCTAG_SILO2_RitPosi_PT
	PLCTAG_SILO2_TempoSpruzzaAntiadesivo
	PLCTAG_SILO2_SpruzzaturaAntiadesivo
	PLCTAG_SILO2_PienoDaMescolatore
	PLCTAG_SILO2_FC_Aperto
	PLCTAG_SILO2_FC_Chiuso
	PLCTAG_SILO2_unused1
	PLCTAG_SILO2_unused2
	PLCTAG_SILO2_ManuApre
	PLCTAG_SILO2_ManuChiude
	PLCTAG_SILO2_ManuPosi
	PLCTAG_SILO2_ManuZero
	PLCTAG_SILO2_ConsensoApre
	PLCTAG_SILO2_ConsensoStart
	PLCTAG_SILO2_InPosizione
	PLCTAG_SILO2_CopyInhibit
	PLCTAG_SILO2_ApreBenna
	PLCTAG_SILO2_RitornoZero
	PLCTAG_SILO2_StartPosiziona
	PLCTAG_SILO2_ConsensoMescolatore
	PLCTAG_SILO2_AllarmeApre
	PLCTAG_SILO2_AllarmeChiude
	PLCTAG_SILO2_BennaPiena
	PLCTAG_SILO2_BennaVuota
	PLCTAG_SILO2_AuxPieno
	PLCTAG_SILO2_ChiudeBenna
	PLCTAG_SILO2_AuxPosi
	PLCTAG_SILO2_TimeOutApre_PT
	PLCTAG_SILO2_TimeOutChiude_PT
	PLCTAG_SILO2_TempoScarico_PT
	PLCTAG_SILO2_WORK_RicettaUsata
	PLCTAG_SILO2_WORK_PesoScaricato
	PLCTAG_SILO2_WORK_Destinazione
	PLCTAG_SILO2_WORK_Posizione
	PLCTAG_SILO2_Posizione1
	PLCTAG_SILO2_Posizione2
	PLCTAG_SILO2_Posizione3
	PLCTAG_SILO2_Posizione4
	PLCTAG_SILO2_Posizione5
	PLCTAG_SILO2_Posizione6
	PLCTAG_SILO2_Posizione7
	PLCTAG_SILO2_Posizione8
	PLCTAG_SILO2_Posizione9
	PLCTAG_SILO2_Posizione10
	PLCTAG_SILO2_Posizione11
	PLCTAG_SILO2_Posizione12
	PLCTAG_SILO2_Posizione13
	PLCTAG_SILO2_Posizione14
	PLCTAG_SILO2_Posizione15
	PLCTAG_SILO2_Posizione16
	PLCTAG_SILO2_Posizione17
	PLCTAG_SILO2_Posizione18
	PLCTAG_SILO2_Posizione19
	PLCTAG_SILO2_Posizione20
	PLCTAG_SILO2_Posizione21
	PLCTAG_SILO2_VelocitaCalc
	PLCTAG_SILO2_VelocitaInverterTeo
	PLCTAG_SILO2_VelocitaInverterReale
	PLCTAG_SILO2_AbilitaJog
	PLCTAG_SILO2_Jog_DX
	PLCTAG_SILO2_Jog_SX
	PLCTAG_SIWA_CMD_LIST_UltimoInserito
	PLCTAG_SIWA_CMD_LIST_Anno1
	PLCTAG_SIWA_CMD_LIST_Mese1
	PLCTAG_SIWA_CMD_LIST_Giorno1
	PLCTAG_SIWA_CMD_LIST_Ora1
	PLCTAG_SIWA_CMD_LIST_Minuto1
	PLCTAG_SIWA_CMD_LIST_Secondo1
	PLCTAG_SIWA_CMD_LIST_Valore1
	PLCTAG_SIWA_CMD_LIST_Anno2
	PLCTAG_SIWA_CMD_LIST_Mese2
	PLCTAG_SIWA_CMD_LIST_Giorno2
	PLCTAG_SIWA_CMD_LIST_Ora2
	PLCTAG_SIWA_CMD_LIST_Minuto2
	PLCTAG_SIWA_CMD_LIST_Secondo2
	PLCTAG_SIWA_CMD_LIST_Valore2
	PLCTAG_SIWA_CMD_LIST_Anno3
	PLCTAG_SIWA_CMD_LIST_Mese3
	PLCTAG_SIWA_CMD_LIST_Giorno3
	PLCTAG_SIWA_CMD_LIST_Ora3
	PLCTAG_SIWA_CMD_LIST_Minuto3
	PLCTAG_SIWA_CMD_LIST_Secondo3
	PLCTAG_SIWA_CMD_LIST_Valore3
	PLCTAG_SIWA_CMD_LIST_Anno4
	PLCTAG_SIWA_CMD_LIST_Mese4
	PLCTAG_SIWA_CMD_LIST_Giorno4
	PLCTAG_SIWA_CMD_LIST_Ora4
	PLCTAG_SIWA_CMD_LIST_Minuto4
	PLCTAG_SIWA_CMD_LIST_Secondo4
	PLCTAG_SIWA_CMD_LIST_Valore4
	PLCTAG_SIWA_CMD_LIST_Anno5
	PLCTAG_SIWA_CMD_LIST_Mese5
	PLCTAG_SIWA_CMD_LIST_Giorno5
	PLCTAG_SIWA_CMD_LIST_Ora5
	PLCTAG_SIWA_CMD_LIST_Minuto5
	PLCTAG_SIWA_CMD_LIST_Secondo5
	PLCTAG_SIWA_CMD_LIST_Valore5
	PLCTAG_SIWA_CMD_LIST_Anno6
	PLCTAG_SIWA_CMD_LIST_Mese6
	PLCTAG_SIWA_CMD_LIST_Giorno6
	PLCTAG_SIWA_CMD_LIST_Ora6
	PLCTAG_SIWA_CMD_LIST_Minuto6
	PLCTAG_SIWA_CMD_LIST_Secondo6
	PLCTAG_SIWA_CMD_LIST_Valore6
	PLCTAG_SIWA_CMD_LIST_Anno7
	PLCTAG_SIWA_CMD_LIST_Mese7
	PLCTAG_SIWA_CMD_LIST_Giorno7
	PLCTAG_SIWA_CMD_LIST_Ora7
	PLCTAG_SIWA_CMD_LIST_Minuto7
	PLCTAG_SIWA_CMD_LIST_Secondo7
	PLCTAG_SIWA_CMD_LIST_Valore7
	PLCTAG_SIWA_CMD_LIST_Anno8
	PLCTAG_SIWA_CMD_LIST_Mese8
	PLCTAG_SIWA_CMD_LIST_Giorno8
	PLCTAG_SIWA_CMD_LIST_Ora8
	PLCTAG_SIWA_CMD_LIST_Minuto8
	PLCTAG_SIWA_CMD_LIST_Secondo8
	PLCTAG_SIWA_CMD_LIST_Valore8
	PLCTAG_SIWA_CMD_LIST_Anno9
	PLCTAG_SIWA_CMD_LIST_Mese9
	PLCTAG_SIWA_CMD_LIST_Giorno9
	PLCTAG_SIWA_CMD_LIST_Ora9
	PLCTAG_SIWA_CMD_LIST_Minuto9
	PLCTAG_SIWA_CMD_LIST_Secondo9
	PLCTAG_SIWA_CMD_LIST_Valore9
	PLCTAG_SIWA_CMD_LIST_Anno10
	PLCTAG_SIWA_CMD_LIST_Mese10
	PLCTAG_SIWA_CMD_LIST_Giorno10
	PLCTAG_SIWA_CMD_LIST_Ora10
	PLCTAG_SIWA_CMD_LIST_Minuto10
	PLCTAG_SIWA_CMD_LIST_Secondo10
	PLCTAG_SIWA_CMD_LIST_Valore10
	PLCTAG_SIWA_CMD_LIST_Anno11
	PLCTAG_SIWA_CMD_LIST_Mese11
	PLCTAG_SIWA_CMD_LIST_Giorno11
	PLCTAG_SIWA_CMD_LIST_Ora11
	PLCTAG_SIWA_CMD_LIST_Minuto11
	PLCTAG_SIWA_CMD_LIST_Secondo11
	PLCTAG_SIWA_CMD_LIST_Valore11
	PLCTAG_SIWA_CMD_LIST_Anno12
	PLCTAG_SIWA_CMD_LIST_Mese12
	PLCTAG_SIWA_CMD_LIST_Giorno12
	PLCTAG_SIWA_CMD_LIST_Ora12
	PLCTAG_SIWA_CMD_LIST_Minuto12
	PLCTAG_SIWA_CMD_LIST_Secondo12
	PLCTAG_SIWA_CMD_LIST_Valore12
	PLCTAG_SIWA_CMD_LIST_Anno13
	PLCTAG_SIWA_CMD_LIST_Mese13
	PLCTAG_SIWA_CMD_LIST_Giorno13
	PLCTAG_SIWA_CMD_LIST_Ora13
	PLCTAG_SIWA_CMD_LIST_Minuto13
	PLCTAG_SIWA_CMD_LIST_Secondo13
	PLCTAG_SIWA_CMD_LIST_Valore13
	PLCTAG_SIWA_CMD_LIST_Anno14
	PLCTAG_SIWA_CMD_LIST_Mese14
	PLCTAG_SIWA_CMD_LIST_Giorno14
	PLCTAG_SIWA_CMD_LIST_Ora14
	PLCTAG_SIWA_CMD_LIST_Minuto14
	PLCTAG_SIWA_CMD_LIST_Secondo14
	PLCTAG_SIWA_CMD_LIST_Valore14
	PLCTAG_SIWA_CMD_LIST_Anno15
	PLCTAG_SIWA_CMD_LIST_Mese15
	PLCTAG_SIWA_CMD_LIST_Giorno15
	PLCTAG_SIWA_CMD_LIST_Ora15
	PLCTAG_SIWA_CMD_LIST_Minuto15
	PLCTAG_SIWA_CMD_LIST_Secondo15
	PLCTAG_SIWA_CMD_LIST_Valore15
	PLCTAG_SIWA_CMD_LIST_Anno16
	PLCTAG_SIWA_CMD_LIST_Mese16
	PLCTAG_SIWA_CMD_LIST_Giorno16
	PLCTAG_SIWA_CMD_LIST_Ora16
	PLCTAG_SIWA_CMD_LIST_Minuto16
	PLCTAG_SIWA_CMD_LIST_Secondo16
	PLCTAG_SIWA_CMD_LIST_Valore16
	PLCTAG_SIWA_CMD_LIST_Anno17
	PLCTAG_SIWA_CMD_LIST_Mese17
	PLCTAG_SIWA_CMD_LIST_Giorno17
	PLCTAG_SIWA_CMD_LIST_Ora17
	PLCTAG_SIWA_CMD_LIST_Minuto17
	PLCTAG_SIWA_CMD_LIST_Secondo17
	PLCTAG_SIWA_CMD_LIST_Valore17
	PLCTAG_SIWA_CMD_LIST_Anno18
	PLCTAG_SIWA_CMD_LIST_Mese18
	PLCTAG_SIWA_CMD_LIST_Giorno18
	PLCTAG_SIWA_CMD_LIST_Ora18
	PLCTAG_SIWA_CMD_LIST_Minuto18
	PLCTAG_SIWA_CMD_LIST_Secondo18
	PLCTAG_SIWA_CMD_LIST_Valore18
	PLCTAG_SIWA_CMD_LIST_Anno19
	PLCTAG_SIWA_CMD_LIST_Mese19
	PLCTAG_SIWA_CMD_LIST_Giorno19
	PLCTAG_SIWA_CMD_LIST_Ora19
	PLCTAG_SIWA_CMD_LIST_Minuto19
	PLCTAG_SIWA_CMD_LIST_Secondo19
	PLCTAG_SIWA_CMD_LIST_Valore19
	PLCTAG_SIWA_CMD_LIST_Anno20
	PLCTAG_SIWA_CMD_LIST_Mese20
	PLCTAG_SIWA_CMD_LIST_Giorno20
	PLCTAG_SIWA_CMD_LIST_Ora20
	PLCTAG_SIWA_CMD_LIST_Minuto20
	PLCTAG_SIWA_CMD_LIST_Secondo20
	PLCTAG_SIWA_CMD_LIST_Valore20
	PLCTAG_SIWA_CMD_LIST_Anno21
	PLCTAG_SIWA_CMD_LIST_Mese21
	PLCTAG_SIWA_CMD_LIST_Giorno21
	PLCTAG_SIWA_CMD_LIST_Ora21
	PLCTAG_SIWA_CMD_LIST_Minuto21
	PLCTAG_SIWA_CMD_LIST_Secondo21
	PLCTAG_SIWA_CMD_LIST_Valore21
	PLCTAG_SIWA_CMD_LIST_Anno22
	PLCTAG_SIWA_CMD_LIST_Mese22
	PLCTAG_SIWA_CMD_LIST_Giorno22
	PLCTAG_SIWA_CMD_LIST_Ora22
	PLCTAG_SIWA_CMD_LIST_Minuto22
	PLCTAG_SIWA_CMD_LIST_Secondo22
	PLCTAG_SIWA_CMD_LIST_Valore22
	PLCTAG_SIWA_CMD_LIST_Anno23
	PLCTAG_SIWA_CMD_LIST_Mese23
	PLCTAG_SIWA_CMD_LIST_Giorno23
	PLCTAG_SIWA_CMD_LIST_Ora23
	PLCTAG_SIWA_CMD_LIST_Minuto23
	PLCTAG_SIWA_CMD_LIST_Secondo23
	PLCTAG_SIWA_CMD_LIST_Valore23
	PLCTAG_SIWA_CMD_LIST_Anno24
	PLCTAG_SIWA_CMD_LIST_Mese24
	PLCTAG_SIWA_CMD_LIST_Giorno24
	PLCTAG_SIWA_CMD_LIST_Ora24
	PLCTAG_SIWA_CMD_LIST_Minuto24
	PLCTAG_SIWA_CMD_LIST_Secondo24
	PLCTAG_SIWA_CMD_LIST_Valore24
	PLCTAG_SIWA_CMD_LIST_Anno25
	PLCTAG_SIWA_CMD_LIST_Mese25
	PLCTAG_SIWA_CMD_LIST_Giorno25
	PLCTAG_SIWA_CMD_LIST_Ora25
	PLCTAG_SIWA_CMD_LIST_Minuto25
	PLCTAG_SIWA_CMD_LIST_Secondo25
	PLCTAG_SIWA_CMD_LIST_Valore25
	PLCTAG_SIWA_CMD_LIST_Anno26
	PLCTAG_SIWA_CMD_LIST_Mese26
	PLCTAG_SIWA_CMD_LIST_Giorno26
	PLCTAG_SIWA_CMD_LIST_Ora26
	PLCTAG_SIWA_CMD_LIST_Minuto26
	PLCTAG_SIWA_CMD_LIST_Secondo26
	PLCTAG_SIWA_CMD_LIST_Valore26
	PLCTAG_SIWA_CMD_LIST_Anno27
	PLCTAG_SIWA_CMD_LIST_Mese27
	PLCTAG_SIWA_CMD_LIST_Giorno27
	PLCTAG_SIWA_CMD_LIST_Ora27
	PLCTAG_SIWA_CMD_LIST_Minuto27
	PLCTAG_SIWA_CMD_LIST_Secondo27
	PLCTAG_SIWA_CMD_LIST_Valore27
	PLCTAG_SIWA_CMD_LIST_Anno28
	PLCTAG_SIWA_CMD_LIST_Mese28
	PLCTAG_SIWA_CMD_LIST_Giorno28
	PLCTAG_SIWA_CMD_LIST_Ora28
	PLCTAG_SIWA_CMD_LIST_Minuto28
	PLCTAG_SIWA_CMD_LIST_Secondo28
	PLCTAG_SIWA_CMD_LIST_Valore28
	PLCTAG_SIWA_CMD_LIST_Anno29
	PLCTAG_SIWA_CMD_LIST_Mese29
	PLCTAG_SIWA_CMD_LIST_Giorno29
	PLCTAG_SIWA_CMD_LIST_Ora29
	PLCTAG_SIWA_CMD_LIST_Minuto29
	PLCTAG_SIWA_CMD_LIST_Secondo29
	PLCTAG_SIWA_CMD_LIST_Valore29
	PLCTAG_SIWA_CMD_LIST_Anno30
	PLCTAG_SIWA_CMD_LIST_Mese30
	PLCTAG_SIWA_CMD_LIST_Giorno30
	PLCTAG_SIWA_CMD_LIST_Ora30
	PLCTAG_SIWA_CMD_LIST_Minuto30
	PLCTAG_SIWA_CMD_LIST_Secondo30
	PLCTAG_SIWA_CMD_LIST_Valore30
	PLCTAG_SIWA_CMD_LIST_Anno31
	PLCTAG_SIWA_CMD_LIST_Mese31
	PLCTAG_SIWA_CMD_LIST_Giorno31
	PLCTAG_SIWA_CMD_LIST_Ora31
	PLCTAG_SIWA_CMD_LIST_Minuto31
	PLCTAG_SIWA_CMD_LIST_Secondo31
	PLCTAG_SIWA_CMD_LIST_Valore31
	PLCTAG_SIWA_CMD_LIST_Anno32
	PLCTAG_SIWA_CMD_LIST_Mese32
	PLCTAG_SIWA_CMD_LIST_Giorno32
	PLCTAG_SIWA_CMD_LIST_Ora32
	PLCTAG_SIWA_CMD_LIST_Minuto32
	PLCTAG_SIWA_CMD_LIST_Secondo32
	PLCTAG_SIWA_CMD_LIST_Valore32
	PLCTAG_SIWA_CMD_LIST_Anno33
	PLCTAG_SIWA_CMD_LIST_Mese33
	PLCTAG_SIWA_CMD_LIST_Giorno33
	PLCTAG_SIWA_CMD_LIST_Ora33
	PLCTAG_SIWA_CMD_LIST_Minuto33
	PLCTAG_SIWA_CMD_LIST_Secondo33
	PLCTAG_SIWA_CMD_LIST_Valore33
	PLCTAG_SIWA_CMD_LIST_Anno34
	PLCTAG_SIWA_CMD_LIST_Mese34
	PLCTAG_SIWA_CMD_LIST_Giorno34
	PLCTAG_SIWA_CMD_LIST_Ora34
	PLCTAG_SIWA_CMD_LIST_Minuto34
	PLCTAG_SIWA_CMD_LIST_Secondo34
	PLCTAG_SIWA_CMD_LIST_Valore34
	PLCTAG_SIWA_CMD_LIST_Anno35
	PLCTAG_SIWA_CMD_LIST_Mese35
	PLCTAG_SIWA_CMD_LIST_Giorno35
	PLCTAG_SIWA_CMD_LIST_Ora35
	PLCTAG_SIWA_CMD_LIST_Minuto35
	PLCTAG_SIWA_CMD_LIST_Secondo35
	PLCTAG_SIWA_CMD_LIST_Valore35
	PLCTAG_SIWA_CMD_LIST_Anno36
	PLCTAG_SIWA_CMD_LIST_Mese36
	PLCTAG_SIWA_CMD_LIST_Giorno36
	PLCTAG_SIWA_CMD_LIST_Ora36
	PLCTAG_SIWA_CMD_LIST_Minuto36
	PLCTAG_SIWA_CMD_LIST_Secondo36
	PLCTAG_SIWA_CMD_LIST_Valore36
	PLCTAG_SIWA_CMD_LIST_Anno37
	PLCTAG_SIWA_CMD_LIST_Mese37
	PLCTAG_SIWA_CMD_LIST_Giorno37
	PLCTAG_SIWA_CMD_LIST_Ora37
	PLCTAG_SIWA_CMD_LIST_Minuto37
	PLCTAG_SIWA_CMD_LIST_Secondo37
	PLCTAG_SIWA_CMD_LIST_Valore37
	PLCTAG_SIWA_CMD_LIST_Anno38
	PLCTAG_SIWA_CMD_LIST_Mese38
	PLCTAG_SIWA_CMD_LIST_Giorno38
	PLCTAG_SIWA_CMD_LIST_Ora38
	PLCTAG_SIWA_CMD_LIST_Minuto38
	PLCTAG_SIWA_CMD_LIST_Secondo38
	PLCTAG_SIWA_CMD_LIST_Valore38
	PLCTAG_SIWA_CMD_LIST_Anno39
	PLCTAG_SIWA_CMD_LIST_Mese39
	PLCTAG_SIWA_CMD_LIST_Giorno39
	PLCTAG_SIWA_CMD_LIST_Ora39
	PLCTAG_SIWA_CMD_LIST_Minuto39
	PLCTAG_SIWA_CMD_LIST_Secondo39
	PLCTAG_SIWA_CMD_LIST_Valore39
	PLCTAG_SIWA_CMD_LIST_Anno40
	PLCTAG_SIWA_CMD_LIST_Mese40
	PLCTAG_SIWA_CMD_LIST_Giorno40
	PLCTAG_SIWA_CMD_LIST_Ora40
	PLCTAG_SIWA_CMD_LIST_Minuto40
	PLCTAG_SIWA_CMD_LIST_Secondo40
	PLCTAG_SIWA_CMD_LIST_Valore40
	PLCTAG_SIWA_CMD_LIST_Anno41
	PLCTAG_SIWA_CMD_LIST_Mese41
	PLCTAG_SIWA_CMD_LIST_Giorno41
	PLCTAG_SIWA_CMD_LIST_Ora41
	PLCTAG_SIWA_CMD_LIST_Minuto41
	PLCTAG_SIWA_CMD_LIST_Secondo41
	PLCTAG_SIWA_CMD_LIST_Valore41
	PLCTAG_SIWA_CMD_LIST_Anno42
	PLCTAG_SIWA_CMD_LIST_Mese42
	PLCTAG_SIWA_CMD_LIST_Giorno42
	PLCTAG_SIWA_CMD_LIST_Ora42
	PLCTAG_SIWA_CMD_LIST_Minuto42
	PLCTAG_SIWA_CMD_LIST_Secondo42
	PLCTAG_SIWA_CMD_LIST_Valore42
	PLCTAG_SIWA_CMD_LIST_Anno43
	PLCTAG_SIWA_CMD_LIST_Mese43
	PLCTAG_SIWA_CMD_LIST_Giorno43
	PLCTAG_SIWA_CMD_LIST_Ora43
	PLCTAG_SIWA_CMD_LIST_Minuto43
	PLCTAG_SIWA_CMD_LIST_Secondo43
	PLCTAG_SIWA_CMD_LIST_Valore43
	PLCTAG_SIWA_CMD_LIST_Anno44
	PLCTAG_SIWA_CMD_LIST_Mese44
	PLCTAG_SIWA_CMD_LIST_Giorno44
	PLCTAG_SIWA_CMD_LIST_Ora44
	PLCTAG_SIWA_CMD_LIST_Minuto44
	PLCTAG_SIWA_CMD_LIST_Secondo44
	PLCTAG_SIWA_CMD_LIST_Valore44
	PLCTAG_SIWA_CMD_LIST_Anno45
	PLCTAG_SIWA_CMD_LIST_Mese45
	PLCTAG_SIWA_CMD_LIST_Giorno45
	PLCTAG_SIWA_CMD_LIST_Ora45
	PLCTAG_SIWA_CMD_LIST_Minuto45
	PLCTAG_SIWA_CMD_LIST_Secondo45
	PLCTAG_SIWA_CMD_LIST_Valore45
	PLCTAG_SIWA_CMD_LIST_Anno46
	PLCTAG_SIWA_CMD_LIST_Mese46
	PLCTAG_SIWA_CMD_LIST_Giorno46
	PLCTAG_SIWA_CMD_LIST_Ora46
	PLCTAG_SIWA_CMD_LIST_Minuto46
	PLCTAG_SIWA_CMD_LIST_Secondo46
	PLCTAG_SIWA_CMD_LIST_Valore46
	PLCTAG_SIWA_CMD_LIST_Anno47
	PLCTAG_SIWA_CMD_LIST_Mese47
	PLCTAG_SIWA_CMD_LIST_Giorno47
	PLCTAG_SIWA_CMD_LIST_Ora47
	PLCTAG_SIWA_CMD_LIST_Minuto47
	PLCTAG_SIWA_CMD_LIST_Secondo47
	PLCTAG_SIWA_CMD_LIST_Valore47
	PLCTAG_SIWA_CMD_LIST_Anno48
	PLCTAG_SIWA_CMD_LIST_Mese48
	PLCTAG_SIWA_CMD_LIST_Giorno48
	PLCTAG_SIWA_CMD_LIST_Ora48
	PLCTAG_SIWA_CMD_LIST_Minuto48
	PLCTAG_SIWA_CMD_LIST_Secondo48
	PLCTAG_SIWA_CMD_LIST_Valore48
	PLCTAG_SIWA_CMD_LIST_Anno49
	PLCTAG_SIWA_CMD_LIST_Mese49
	PLCTAG_SIWA_CMD_LIST_Giorno49
	PLCTAG_SIWA_CMD_LIST_Ora49
	PLCTAG_SIWA_CMD_LIST_Minuto49
	PLCTAG_SIWA_CMD_LIST_Secondo49
	PLCTAG_SIWA_CMD_LIST_Valore49
	PLCTAG_SIWA_CMD_LIST_Anno50
	PLCTAG_SIWA_CMD_LIST_Mese50
	PLCTAG_SIWA_CMD_LIST_Giorno50
	PLCTAG_SIWA_CMD_LIST_Ora50
	PLCTAG_SIWA_CMD_LIST_Minuto50
	PLCTAG_SIWA_CMD_LIST_Secondo50
	PLCTAG_SIWA_CMD_LIST_Valore50
	PLCTAG_SIWA_CMD_LIST_Anno51
	PLCTAG_SIWA_CMD_LIST_Mese51
	PLCTAG_SIWA_CMD_LIST_Giorno51
	PLCTAG_SIWA_CMD_LIST_Ora51
	PLCTAG_SIWA_CMD_LIST_Minuto51
	PLCTAG_SIWA_CMD_LIST_Secondo51
	PLCTAG_SIWA_CMD_LIST_Valore51
	PLCTAG_SIWA_CMD_LIST_Anno52
	PLCTAG_SIWA_CMD_LIST_Mese52
	PLCTAG_SIWA_CMD_LIST_Giorno52
	PLCTAG_SIWA_CMD_LIST_Ora52
	PLCTAG_SIWA_CMD_LIST_Minuto52
	PLCTAG_SIWA_CMD_LIST_Secondo52
	PLCTAG_SIWA_CMD_LIST_Valore52
	PLCTAG_SIWA_CMD_LIST_Anno53
	PLCTAG_SIWA_CMD_LIST_Mese53
	PLCTAG_SIWA_CMD_LIST_Giorno53
	PLCTAG_SIWA_CMD_LIST_Ora53
	PLCTAG_SIWA_CMD_LIST_Minuto53
	PLCTAG_SIWA_CMD_LIST_Secondo53
	PLCTAG_SIWA_CMD_LIST_Valore53
	PLCTAG_SIWA_CMD_LIST_Anno54
	PLCTAG_SIWA_CMD_LIST_Mese54
	PLCTAG_SIWA_CMD_LIST_Giorno54
	PLCTAG_SIWA_CMD_LIST_Ora54
	PLCTAG_SIWA_CMD_LIST_Minuto54
	PLCTAG_SIWA_CMD_LIST_Secondo54
	PLCTAG_SIWA_CMD_LIST_Valore54
	PLCTAG_SIWA_CMD_LIST_Anno55
	PLCTAG_SIWA_CMD_LIST_Mese55
	PLCTAG_SIWA_CMD_LIST_Giorno55
	PLCTAG_SIWA_CMD_LIST_Ora55
	PLCTAG_SIWA_CMD_LIST_Minuto55
	PLCTAG_SIWA_CMD_LIST_Secondo55
	PLCTAG_SIWA_CMD_LIST_Valore55
	PLCTAG_SIWA_CMD_LIST_Anno56
	PLCTAG_SIWA_CMD_LIST_Mese56
	PLCTAG_SIWA_CMD_LIST_Giorno56
	PLCTAG_SIWA_CMD_LIST_Ora56
	PLCTAG_SIWA_CMD_LIST_Minuto56
	PLCTAG_SIWA_CMD_LIST_Secondo56
	PLCTAG_SIWA_CMD_LIST_Valore56
	PLCTAG_SIWA_CMD_LIST_Anno57
	PLCTAG_SIWA_CMD_LIST_Mese57
	PLCTAG_SIWA_CMD_LIST_Giorno57
	PLCTAG_SIWA_CMD_LIST_Ora57
	PLCTAG_SIWA_CMD_LIST_Minuto57
	PLCTAG_SIWA_CMD_LIST_Secondo57
	PLCTAG_SIWA_CMD_LIST_Valore57
	PLCTAG_SIWA_CMD_LIST_Anno58
	PLCTAG_SIWA_CMD_LIST_Mese58
	PLCTAG_SIWA_CMD_LIST_Giorno58
	PLCTAG_SIWA_CMD_LIST_Ora58
	PLCTAG_SIWA_CMD_LIST_Minuto58
	PLCTAG_SIWA_CMD_LIST_Secondo58
	PLCTAG_SIWA_CMD_LIST_Valore58
	PLCTAG_SIWA_CMD_LIST_Anno59
	PLCTAG_SIWA_CMD_LIST_Mese59
	PLCTAG_SIWA_CMD_LIST_Giorno59
	PLCTAG_SIWA_CMD_LIST_Ora59
	PLCTAG_SIWA_CMD_LIST_Minuto59
	PLCTAG_SIWA_CMD_LIST_Secondo59
	PLCTAG_SIWA_CMD_LIST_Valore59
	PLCTAG_SIWA_CMD_LIST_Anno60
	PLCTAG_SIWA_CMD_LIST_Mese60
	PLCTAG_SIWA_CMD_LIST_Giorno60
	PLCTAG_SIWA_CMD_LIST_Ora60
	PLCTAG_SIWA_CMD_LIST_Minuto60
	PLCTAG_SIWA_CMD_LIST_Secondo60
	PLCTAG_SIWA_CMD_LIST_Valore60
	PLCTAG_SIWA_CMD_LIST_Anno61
	PLCTAG_SIWA_CMD_LIST_Mese61
	PLCTAG_SIWA_CMD_LIST_Giorno61
	PLCTAG_SIWA_CMD_LIST_Ora61
	PLCTAG_SIWA_CMD_LIST_Minuto61
	PLCTAG_SIWA_CMD_LIST_Secondo61
	PLCTAG_SIWA_CMD_LIST_Valore61
	PLCTAG_SIWA_CMD_LIST_Anno62
	PLCTAG_SIWA_CMD_LIST_Mese62
	PLCTAG_SIWA_CMD_LIST_Giorno62
	PLCTAG_SIWA_CMD_LIST_Ora62
	PLCTAG_SIWA_CMD_LIST_Minuto62
	PLCTAG_SIWA_CMD_LIST_Secondo62
	PLCTAG_SIWA_CMD_LIST_Valore62
	PLCTAG_SIWA_CMD_LIST_Anno63
	PLCTAG_SIWA_CMD_LIST_Mese63
	PLCTAG_SIWA_CMD_LIST_Giorno63
	PLCTAG_SIWA_CMD_LIST_Ora63
	PLCTAG_SIWA_CMD_LIST_Minuto63
	PLCTAG_SIWA_CMD_LIST_Secondo63
	PLCTAG_SIWA_CMD_LIST_Valore63
	PLCTAG_SIWA_CMD_LIST_Anno64
	PLCTAG_SIWA_CMD_LIST_Mese64
	PLCTAG_SIWA_CMD_LIST_Giorno64
	PLCTAG_SIWA_CMD_LIST_Ora64
	PLCTAG_SIWA_CMD_LIST_Minuto64
	PLCTAG_SIWA_CMD_LIST_Secondo64
	PLCTAG_SIWA_CMD_LIST_Valore64
	PLCTAG_SIWA_CMD_LIST_Anno65
	PLCTAG_SIWA_CMD_LIST_Mese65
	PLCTAG_SIWA_CMD_LIST_Giorno65
	PLCTAG_SIWA_CMD_LIST_Ora65
	PLCTAG_SIWA_CMD_LIST_Minuto65
	PLCTAG_SIWA_CMD_LIST_Secondo65
	PLCTAG_SIWA_CMD_LIST_Valore65
	PLCTAG_SIWA_CMD_LIST_Anno66
	PLCTAG_SIWA_CMD_LIST_Mese66
	PLCTAG_SIWA_CMD_LIST_Giorno66
	PLCTAG_SIWA_CMD_LIST_Ora66
	PLCTAG_SIWA_CMD_LIST_Minuto66
	PLCTAG_SIWA_CMD_LIST_Secondo66
	PLCTAG_SIWA_CMD_LIST_Valore66
	PLCTAG_SIWA_CMD_LIST_Anno67
	PLCTAG_SIWA_CMD_LIST_Mese67
	PLCTAG_SIWA_CMD_LIST_Giorno67
	PLCTAG_SIWA_CMD_LIST_Ora67
	PLCTAG_SIWA_CMD_LIST_Minuto67
	PLCTAG_SIWA_CMD_LIST_Secondo67
	PLCTAG_SIWA_CMD_LIST_Valore67
	PLCTAG_SIWA_CMD_LIST_Anno68
	PLCTAG_SIWA_CMD_LIST_Mese68
	PLCTAG_SIWA_CMD_LIST_Giorno68
	PLCTAG_SIWA_CMD_LIST_Ora68
	PLCTAG_SIWA_CMD_LIST_Minuto68
	PLCTAG_SIWA_CMD_LIST_Secondo68
	PLCTAG_SIWA_CMD_LIST_Valore68
	PLCTAG_SIWA_CMD_LIST_Anno69
	PLCTAG_SIWA_CMD_LIST_Mese69
	PLCTAG_SIWA_CMD_LIST_Giorno69
	PLCTAG_SIWA_CMD_LIST_Ora69
	PLCTAG_SIWA_CMD_LIST_Minuto69
	PLCTAG_SIWA_CMD_LIST_Secondo69
	PLCTAG_SIWA_CMD_LIST_Valore69
	PLCTAG_SIWA_CMD_LIST_Anno70
	PLCTAG_SIWA_CMD_LIST_Mese70
	PLCTAG_SIWA_CMD_LIST_Giorno70
	PLCTAG_SIWA_CMD_LIST_Ora70
	PLCTAG_SIWA_CMD_LIST_Minuto70
	PLCTAG_SIWA_CMD_LIST_Secondo70
	PLCTAG_SIWA_CMD_LIST_Valore70
	PLCTAG_SIWA_CMD_LIST_Anno71
	PLCTAG_SIWA_CMD_LIST_Mese71
	PLCTAG_SIWA_CMD_LIST_Giorno71
	PLCTAG_SIWA_CMD_LIST_Ora71
	PLCTAG_SIWA_CMD_LIST_Minuto71
	PLCTAG_SIWA_CMD_LIST_Secondo71
	PLCTAG_SIWA_CMD_LIST_Valore71
	PLCTAG_SIWA_CMD_LIST_Anno72
	PLCTAG_SIWA_CMD_LIST_Mese72
	PLCTAG_SIWA_CMD_LIST_Giorno72
	PLCTAG_SIWA_CMD_LIST_Ora72
	PLCTAG_SIWA_CMD_LIST_Minuto72
	PLCTAG_SIWA_CMD_LIST_Secondo72
	PLCTAG_SIWA_CMD_LIST_Valore72
	PLCTAG_SIWA_CMD_LIST_Anno73
	PLCTAG_SIWA_CMD_LIST_Mese73
	PLCTAG_SIWA_CMD_LIST_Giorno73
	PLCTAG_SIWA_CMD_LIST_Ora73
	PLCTAG_SIWA_CMD_LIST_Minuto73
	PLCTAG_SIWA_CMD_LIST_Secondo73
	PLCTAG_SIWA_CMD_LIST_Valore73
	PLCTAG_SIWA_CMD_LIST_Anno74
	PLCTAG_SIWA_CMD_LIST_Mese74
	PLCTAG_SIWA_CMD_LIST_Giorno74
	PLCTAG_SIWA_CMD_LIST_Ora74
	PLCTAG_SIWA_CMD_LIST_Minuto74
	PLCTAG_SIWA_CMD_LIST_Secondo74
	PLCTAG_SIWA_CMD_LIST_Valore74
	PLCTAG_SIWA_CMD_LIST_Anno75
	PLCTAG_SIWA_CMD_LIST_Mese75
	PLCTAG_SIWA_CMD_LIST_Giorno75
	PLCTAG_SIWA_CMD_LIST_Ora75
	PLCTAG_SIWA_CMD_LIST_Minuto75
	PLCTAG_SIWA_CMD_LIST_Secondo75
	PLCTAG_SIWA_CMD_LIST_Valore75
	PLCTAG_SIWA_CMD_LIST_Anno76
	PLCTAG_SIWA_CMD_LIST_Mese76
	PLCTAG_SIWA_CMD_LIST_Giorno76
	PLCTAG_SIWA_CMD_LIST_Ora76
	PLCTAG_SIWA_CMD_LIST_Minuto76
	PLCTAG_SIWA_CMD_LIST_Secondo76
	PLCTAG_SIWA_CMD_LIST_Valore76
	PLCTAG_SIWA_CMD_LIST_Anno77
	PLCTAG_SIWA_CMD_LIST_Mese77
	PLCTAG_SIWA_CMD_LIST_Giorno77
	PLCTAG_SIWA_CMD_LIST_Ora77
	PLCTAG_SIWA_CMD_LIST_Minuto77
	PLCTAG_SIWA_CMD_LIST_Secondo77
	PLCTAG_SIWA_CMD_LIST_Valore77
	PLCTAG_SIWA_CMD_LIST_Anno78
	PLCTAG_SIWA_CMD_LIST_Mese78
	PLCTAG_SIWA_CMD_LIST_Giorno78
	PLCTAG_SIWA_CMD_LIST_Ora78
	PLCTAG_SIWA_CMD_LIST_Minuto78
	PLCTAG_SIWA_CMD_LIST_Secondo78
	PLCTAG_SIWA_CMD_LIST_Valore78
	PLCTAG_SIWA_CMD_LIST_Anno79
	PLCTAG_SIWA_CMD_LIST_Mese79
	PLCTAG_SIWA_CMD_LIST_Giorno79
	PLCTAG_SIWA_CMD_LIST_Ora79
	PLCTAG_SIWA_CMD_LIST_Minuto79
	PLCTAG_SIWA_CMD_LIST_Secondo79
	PLCTAG_SIWA_CMD_LIST_Valore79
	PLCTAG_SIWA_CMD_LIST_Anno80
	PLCTAG_SIWA_CMD_LIST_Mese80
	PLCTAG_SIWA_CMD_LIST_Giorno80
	PLCTAG_SIWA_CMD_LIST_Ora80
	PLCTAG_SIWA_CMD_LIST_Minuto80
	PLCTAG_SIWA_CMD_LIST_Secondo80
	PLCTAG_SIWA_CMD_LIST_Valore80
	PLCTAG_SIWA_CMD_LIST_Anno81
	PLCTAG_SIWA_CMD_LIST_Mese81
	PLCTAG_SIWA_CMD_LIST_Giorno81
	PLCTAG_SIWA_CMD_LIST_Ora81
	PLCTAG_SIWA_CMD_LIST_Minuto81
	PLCTAG_SIWA_CMD_LIST_Secondo81
	PLCTAG_SIWA_CMD_LIST_Valore81
	PLCTAG_SIWA_CMD_LIST_Anno82
	PLCTAG_SIWA_CMD_LIST_Mese82
	PLCTAG_SIWA_CMD_LIST_Giorno82
	PLCTAG_SIWA_CMD_LIST_Ora82
	PLCTAG_SIWA_CMD_LIST_Minuto82
	PLCTAG_SIWA_CMD_LIST_Secondo82
	PLCTAG_SIWA_CMD_LIST_Valore82
	PLCTAG_SIWA_CMD_LIST_Anno83
	PLCTAG_SIWA_CMD_LIST_Mese83
	PLCTAG_SIWA_CMD_LIST_Giorno83
	PLCTAG_SIWA_CMD_LIST_Ora83
	PLCTAG_SIWA_CMD_LIST_Minuto83
	PLCTAG_SIWA_CMD_LIST_Secondo83
	PLCTAG_SIWA_CMD_LIST_Valore83
	PLCTAG_SIWA_CMD_LIST_Anno84
	PLCTAG_SIWA_CMD_LIST_Mese84
	PLCTAG_SIWA_CMD_LIST_Giorno84
	PLCTAG_SIWA_CMD_LIST_Ora84
	PLCTAG_SIWA_CMD_LIST_Minuto84
	PLCTAG_SIWA_CMD_LIST_Secondo84
	PLCTAG_SIWA_CMD_LIST_Valore84
	PLCTAG_SIWA_CMD_LIST_Anno85
	PLCTAG_SIWA_CMD_LIST_Mese85
	PLCTAG_SIWA_CMD_LIST_Giorno85
	PLCTAG_SIWA_CMD_LIST_Ora85
	PLCTAG_SIWA_CMD_LIST_Minuto85
	PLCTAG_SIWA_CMD_LIST_Secondo85
	PLCTAG_SIWA_CMD_LIST_Valore85
	PLCTAG_SIWA_CMD_LIST_Anno86
	PLCTAG_SIWA_CMD_LIST_Mese86
	PLCTAG_SIWA_CMD_LIST_Giorno86
	PLCTAG_SIWA_CMD_LIST_Ora86
	PLCTAG_SIWA_CMD_LIST_Minuto86
	PLCTAG_SIWA_CMD_LIST_Secondo86
	PLCTAG_SIWA_CMD_LIST_Valore86
	PLCTAG_SIWA_CMD_LIST_Anno87
	PLCTAG_SIWA_CMD_LIST_Mese87
	PLCTAG_SIWA_CMD_LIST_Giorno87
	PLCTAG_SIWA_CMD_LIST_Ora87
	PLCTAG_SIWA_CMD_LIST_Minuto87
	PLCTAG_SIWA_CMD_LIST_Secondo87
	PLCTAG_SIWA_CMD_LIST_Valore87
	PLCTAG_SIWA_CMD_LIST_Anno88
	PLCTAG_SIWA_CMD_LIST_Mese88
	PLCTAG_SIWA_CMD_LIST_Giorno88
	PLCTAG_SIWA_CMD_LIST_Ora88
	PLCTAG_SIWA_CMD_LIST_Minuto88
	PLCTAG_SIWA_CMD_LIST_Secondo88
	PLCTAG_SIWA_CMD_LIST_Valore88
	PLCTAG_SIWA_CMD_LIST_Anno89
	PLCTAG_SIWA_CMD_LIST_Mese89
	PLCTAG_SIWA_CMD_LIST_Giorno89
	PLCTAG_SIWA_CMD_LIST_Ora89
	PLCTAG_SIWA_CMD_LIST_Minuto89
	PLCTAG_SIWA_CMD_LIST_Secondo89
	PLCTAG_SIWA_CMD_LIST_Valore89
	PLCTAG_SIWA_CMD_LIST_Anno90
	PLCTAG_SIWA_CMD_LIST_Mese90
	PLCTAG_SIWA_CMD_LIST_Giorno90
	PLCTAG_SIWA_CMD_LIST_Ora90
	PLCTAG_SIWA_CMD_LIST_Minuto90
	PLCTAG_SIWA_CMD_LIST_Secondo90
	PLCTAG_SIWA_CMD_LIST_Valore90
	PLCTAG_SIWA_CMD_LIST_Anno91
	PLCTAG_SIWA_CMD_LIST_Mese91
	PLCTAG_SIWA_CMD_LIST_Giorno91
	PLCTAG_SIWA_CMD_LIST_Ora91
	PLCTAG_SIWA_CMD_LIST_Minuto91
	PLCTAG_SIWA_CMD_LIST_Secondo91
	PLCTAG_SIWA_CMD_LIST_Valore91
	PLCTAG_SIWA_CMD_LIST_Anno92
	PLCTAG_SIWA_CMD_LIST_Mese92
	PLCTAG_SIWA_CMD_LIST_Giorno92
	PLCTAG_SIWA_CMD_LIST_Ora92
	PLCTAG_SIWA_CMD_LIST_Minuto92
	PLCTAG_SIWA_CMD_LIST_Secondo92
	PLCTAG_SIWA_CMD_LIST_Valore92
	PLCTAG_SIWA_CMD_LIST_Anno93
	PLCTAG_SIWA_CMD_LIST_Mese93
	PLCTAG_SIWA_CMD_LIST_Giorno93
	PLCTAG_SIWA_CMD_LIST_Ora93
	PLCTAG_SIWA_CMD_LIST_Minuto93
	PLCTAG_SIWA_CMD_LIST_Secondo93
	PLCTAG_SIWA_CMD_LIST_Valore93
	PLCTAG_SIWA_CMD_LIST_Anno94
	PLCTAG_SIWA_CMD_LIST_Mese94
	PLCTAG_SIWA_CMD_LIST_Giorno94
	PLCTAG_SIWA_CMD_LIST_Ora94
	PLCTAG_SIWA_CMD_LIST_Minuto94
	PLCTAG_SIWA_CMD_LIST_Secondo94
	PLCTAG_SIWA_CMD_LIST_Valore94
	PLCTAG_SIWA_CMD_LIST_Anno95
	PLCTAG_SIWA_CMD_LIST_Mese95
	PLCTAG_SIWA_CMD_LIST_Giorno95
	PLCTAG_SIWA_CMD_LIST_Ora95
	PLCTAG_SIWA_CMD_LIST_Minuto95
	PLCTAG_SIWA_CMD_LIST_Secondo95
	PLCTAG_SIWA_CMD_LIST_Valore95
	PLCTAG_SIWA_CMD_LIST_Anno96
	PLCTAG_SIWA_CMD_LIST_Mese96
	PLCTAG_SIWA_CMD_LIST_Giorno96
	PLCTAG_SIWA_CMD_LIST_Ora96
	PLCTAG_SIWA_CMD_LIST_Minuto96
	PLCTAG_SIWA_CMD_LIST_Secondo96
	PLCTAG_SIWA_CMD_LIST_Valore96
	PLCTAG_SIWA_CMD_LIST_Anno97
	PLCTAG_SIWA_CMD_LIST_Mese97
	PLCTAG_SIWA_CMD_LIST_Giorno97
	PLCTAG_SIWA_CMD_LIST_Ora97
	PLCTAG_SIWA_CMD_LIST_Minuto97
	PLCTAG_SIWA_CMD_LIST_Secondo97
	PLCTAG_SIWA_CMD_LIST_Valore97
	PLCTAG_SIWA_CMD_LIST_Anno98
	PLCTAG_SIWA_CMD_LIST_Mese98
	PLCTAG_SIWA_CMD_LIST_Giorno98
	PLCTAG_SIWA_CMD_LIST_Ora98
	PLCTAG_SIWA_CMD_LIST_Minuto98
	PLCTAG_SIWA_CMD_LIST_Secondo98
	PLCTAG_SIWA_CMD_LIST_Valore98
	PLCTAG_SIWA_CMD_LIST_Anno99
	PLCTAG_SIWA_CMD_LIST_Mese99
	PLCTAG_SIWA_CMD_LIST_Giorno99
	PLCTAG_SIWA_CMD_LIST_Ora99
	PLCTAG_SIWA_CMD_LIST_Minuto99
	PLCTAG_SIWA_CMD_LIST_Secondo99
	PLCTAG_SIWA_CMD_LIST_Valore99
	PLCTAG_SIWA_CMD_LIST_Anno100
	PLCTAG_SIWA_CMD_LIST_Mese100
	PLCTAG_SIWA_CMD_LIST_Giorno100
	PLCTAG_SIWA_CMD_LIST_Ora100
	PLCTAG_SIWA_CMD_LIST_Minuto100
	PLCTAG_SIWA_CMD_LIST_Secondo100
	PLCTAG_SIWA_CMD_LIST_Valore100
	PLCTAG_BS_ABILITA
	PLCTAG_BS_SIMULAZIONE
	PLCTAG_BS_SIMULAZIONE_OFFLINE
	PLCTAG_BS_R1FC1
	PLCTAG_BS_R1AO1
	PLCTAG_BS_R1AI1
	PLCTAG_BS_R1AI2
	PLCTAG_BS_R1DO1
	PLCTAG_BS_R1DO2
	PLCTAG_BS_R1DI1
	PLCTAG_BS_R1DI2
	PLCTAG_BS_R1DI3
	PLCTAG_BS_R1DI4
	PLCTAG_BS_R1DI5
	PLCTAG_BS_R1AO2
	PLCTAG_BS_R1DO3
	PLCTAG_BS_R1DO4
	PLCTAG_BS_R1DI6
	PLCTAG_BS_R1DI7
	PLCTAG_BS_R2S1
	PLCTAG_BS_R2S2
	PLCTAG_BS_R2S3
	PLCTAG_BS_R2S4
	PLCTAG_BS_R2S5
	PLCTAG_BS_R2S6
	PLCTAG_BS_R3AO1
	PLCTAG_BS_R3AO2
	PLCTAG_BS_R3AO3
	PLCTAG_BS_R3AO4
	PLCTAG_BS_R3DO1
	PLCTAG_BS_R3DO2
	PLCTAG_BS_R3DO3
	PLCTAG_BS_R3DO4
	PLCTAG_BS_R3DI1
	PLCTAG_BS_R3DI2
	PLCTAG_BS_R3DI3
	PLCTAG_BS_R3DI4
	PLCTAG_BS_R3DI5
	PLCTAG_BS_R4AI1
	PLCTAG_BS_R4AI2
	PLCTAG_BS_R4DO1
	PLCTAG_BS_R4DI1
	PLCTAG_BS_R4DI2
	PLCTAG_BS_R5AO1
	PLCTAG_BS_R5AI1
	PLCTAG_BS_R5AI2
	PLCTAG_BS_R5DO1
	PLCTAG_BS_R5DI1
	PLCTAG_BS_R5DI2
	PLCTAG_BS_R6AI1
	PLCTAG_BS_R6AI2
	PLCTAG_BS_R6DO1
	PLCTAG_BS_R6DO2
	PLCTAG_BS_R6DO3
	PLCTAG_BS_R6DI1
	PLCTAG_BS_R6DI2
	PLCTAG_BS_R6DI3
	PLCTAG_BS_R7AO1
	PLCTAG_BS_R7AI1
	PLCTAG_BS_R7DO1
	PLCTAG_BS_R7DI1
	PLCTAG_BS_R7AI2
	PLCTAG_BS_R7AI3
	PLCTAG_BS_R7DI2
	PLCTAG_BS_R8AO1
	PLCTAG_BS_R8AI1
	PLCTAG_BS_R8AI2
	PLCTAG_BS_R8AI3
	PLCTAG_BS_R8AI4
	PLCTAG_BS_R8AI5
	PLCTAG_BS_R8DO1
	PLCTAG_BS_R8DO2
	PLCTAG_BS_R8DI1
	PLCTAG_BS_R8DI2
	PLCTAG_BS_R8DI3
	PLCTAG_BS_R8AI6
	PLCTAG_BS_R9FC1
	PLCTAG_BS_R9AI1
	PLCTAG_BS_R9AI2
	PLCTAG_BS_R9AI3
	PLCTAG_BS_R9DO1
	PLCTAG_BS_R9DO2
	PLCTAG_BS_R9DI1
	PLCTAG_BS_R9DI2
	PLCTAG_BS_R9DI3
	PLCTAG_BS_R9DI4
	PLCTAG_BS_R9DI5
	PLCTAG_BS_R9DI6
	PLCTAG_BS_R10AI1
	PLCTAG_BS_R10DO1
	PLCTAG_BS_R10DI1
	PLCTAG_BS_R11S1
	PLCTAG_BS_R12AI1
	PLCTAG_BS_R12DO1
	PLCTAG_BS_R12DI1
	PLCTAG_BS_R12DI2
	PLCTAG_BS_R13FC1
	PLCTAG_BS_R13FC2
	PLCTAG_BS_R13AO1
	PLCTAG_BS_R13AI1
	PLCTAG_BS_R13AI2
	PLCTAG_BS_R13DO1
	PLCTAG_BS_R13DI1
	PLCTAG_BS_IO_R1
	PLCTAG_BS_IO_R1_Offline
	PLCTAG_BS_IO_R1_Fault
	PLCTAG_BS_IO_R1FC1_O1
	PLCTAG_BS_IO_R1FC1_O2
	PLCTAG_BS_IO_R1FC1_I1
	PLCTAG_BS_IO_R1FC1_I2
	PLCTAG_BS_IO_R1AO1_1
	PLCTAG_BS_IO_R1AO1_2
	PLCTAG_BS_IO_R1AO1_3
	PLCTAG_BS_IO_R1AO1_4
	PLCTAG_BS_IO_R1AI1_1
	PLCTAG_BS_IO_R1AI1_2
	PLCTAG_BS_IO_R1AI1_3
	PLCTAG_BS_IO_R1AI1_4
	PLCTAG_BS_IO_R1AI2_1
	PLCTAG_BS_IO_R1AI2_2
	PLCTAG_BS_IO_R1AI2_3
	PLCTAG_BS_IO_R1AI2_4
	PLCTAG_BS_IO_R1DO1_1
	PLCTAG_BS_IO_R1DO1_2
	PLCTAG_BS_IO_R1DO2_1
	PLCTAG_BS_IO_R1DO2_2
	PLCTAG_BS_IO_R1DI1_1
	PLCTAG_BS_IO_R1DI1_2
	PLCTAG_BS_IO_R1DI2_1
	PLCTAG_BS_IO_R1DI2_2
	PLCTAG_BS_IO_R1DI3_1
	PLCTAG_BS_IO_R1DI3_2
	PLCTAG_BS_IO_R1DI4_1
	PLCTAG_BS_IO_R1DI4_2
	PLCTAG_BS_IO_R1DI5_1
	PLCTAG_BS_IO_R1DI5_2
	PLCTAG_BS_IO_R1AO2_1
	PLCTAG_BS_IO_R1AO2_2
	PLCTAG_BS_IO_R1AO2_3
	PLCTAG_BS_IO_R1AO2_4
	PLCTAG_BS_IO_R1DO3_1
	PLCTAG_BS_IO_R1DO3_2
	PLCTAG_BS_IO_R1DO4_1
	PLCTAG_BS_IO_R1DO4_2
	PLCTAG_BS_IO_R1DI6_1
	PLCTAG_BS_IO_R1DI6_2
	PLCTAG_BS_IO_R1DI7_1
	PLCTAG_BS_IO_R1DI7_2
	PLCTAG_BS_IO_R2
	PLCTAG_BS_IO_R2_Offline
	PLCTAG_BS_IO_R2_Fault
	PLCTAG_BS_IO_R2S1_O
	PLCTAG_BS_IO_R2S1_I
	PLCTAG_BS_IO_R2S2_O
	PLCTAG_BS_IO_R2S2_I
	PLCTAG_BS_IO_R2S3_O
	PLCTAG_BS_IO_R2S3_I
	PLCTAG_BS_IO_R2S4_O
	PLCTAG_BS_IO_R2S4_I
	PLCTAG_BS_IO_R2S5_O
	PLCTAG_BS_IO_R2S5_I
	PLCTAG_BS_IO_R2S6_O
	PLCTAG_BS_IO_R2S6_I
	PLCTAG_BS_IO_R3
	PLCTAG_BS_IO_R3_Offline
	PLCTAG_BS_IO_R3_Fault
	PLCTAG_BS_IO_R3AO1_1
	PLCTAG_BS_IO_R3AO1_2
	PLCTAG_BS_IO_R3AO1_3
	PLCTAG_BS_IO_R3AO1_4
	PLCTAG_BS_IO_R3AO2_1
	PLCTAG_BS_IO_R3AO2_2
	PLCTAG_BS_IO_R3AO2_3
	PLCTAG_BS_IO_R3AO2_4
	PLCTAG_BS_IO_R3AO3_1
	PLCTAG_BS_IO_R3AO3_2
	PLCTAG_BS_IO_R3AO3_3
	PLCTAG_BS_IO_R3AO3_4
	PLCTAG_BS_IO_R3AO4_1
	PLCTAG_BS_IO_R3AO4_2
	PLCTAG_BS_IO_R3AO4_3
	PLCTAG_BS_IO_R3AO4_4
	PLCTAG_BS_IO_R3DO1_1
	PLCTAG_BS_IO_R3DO1_2
	PLCTAG_BS_IO_R3DO2_1
	PLCTAG_BS_IO_R3DO2_2
	PLCTAG_BS_IO_R3DO3_1
	PLCTAG_BS_IO_R3DO3_2
	PLCTAG_BS_IO_R3DO4_1
	PLCTAG_BS_IO_R3DO4_2
	PLCTAG_BS_IO_R3DI1_1
	PLCTAG_BS_IO_R3DI1_2
	PLCTAG_BS_IO_R3DI2_1
	PLCTAG_BS_IO_R3DI2_2
	PLCTAG_BS_IO_R3DI3_1
	PLCTAG_BS_IO_R3DI3_2
	PLCTAG_BS_IO_R3DI4_1
	PLCTAG_BS_IO_R3DI4_2
	PLCTAG_BS_IO_R3DI5_1
	PLCTAG_BS_IO_R3DI5_2
	PLCTAG_BS_IO_R4
	PLCTAG_BS_IO_R4_Offline
	PLCTAG_BS_IO_R4_Fault
	PLCTAG_BS_IO_R4AI1_1
	PLCTAG_BS_IO_R4AI1_2
	PLCTAG_BS_IO_R4AI1_3
	PLCTAG_BS_IO_R4AI1_4
	PLCTAG_BS_IO_R4AI2_1
	PLCTAG_BS_IO_R4AI2_2
	PLCTAG_BS_IO_R4AI2_3
	PLCTAG_BS_IO_R4AI2_4
	PLCTAG_BS_IO_R4DO1_1
	PLCTAG_BS_IO_R4DO1_2
	PLCTAG_BS_IO_R4DI1_1
	PLCTAG_BS_IO_R4DI1_2
	PLCTAG_BS_IO_R4DI2_1
	PLCTAG_BS_IO_R4DI2_2
	PLCTAG_BS_IO_R5
	PLCTAG_BS_IO_R5_Offline
	PLCTAG_BS_IO_R5_Fault
	PLCTAG_BS_IO_R5AO1_1
	PLCTAG_BS_IO_R5AO1_2
	PLCTAG_BS_IO_R5AO1_3
	PLCTAG_BS_IO_R5AO1_4
	PLCTAG_BS_IO_R5AI1_1
	PLCTAG_BS_IO_R5AI1_2
	PLCTAG_BS_IO_R5AI1_3
	PLCTAG_BS_IO_R5AI1_4
	PLCTAG_BS_IO_R5AI2_1
	PLCTAG_BS_IO_R5AI2_2
	PLCTAG_BS_IO_R5AI2_3
	PLCTAG_BS_IO_R5AI2_4
	PLCTAG_BS_IO_R5DO1_1
	PLCTAG_BS_IO_R5DO1_2
	PLCTAG_BS_IO_R5DI1_1
	PLCTAG_BS_IO_R5DI1_2
	PLCTAG_BS_IO_R5DI2_1
	PLCTAG_BS_IO_R5DI2_2
	PLCTAG_BS_IO_R6
	PLCTAG_BS_IO_R6_Offline
	PLCTAG_BS_IO_R6_Fault
	PLCTAG_BS_IO_R6AI1_1
	PLCTAG_BS_IO_R6AI1_2
	PLCTAG_BS_IO_R6AI1_3
	PLCTAG_BS_IO_R6AI1_4
	PLCTAG_BS_IO_R6AI2_1
	PLCTAG_BS_IO_R6AI2_2
	PLCTAG_BS_IO_R6AI2_3
	PLCTAG_BS_IO_R6AI2_4
	PLCTAG_BS_IO_R6DO1_1
	PLCTAG_BS_IO_R6DO1_2
	PLCTAG_BS_IO_R6DO2_1
	PLCTAG_BS_IO_R6DO2_2
	PLCTAG_BS_IO_R6DO3_1
	PLCTAG_BS_IO_R6DO3_2
	PLCTAG_BS_IO_R6DI1_1
	PLCTAG_BS_IO_R6DI1_2
	PLCTAG_BS_IO_R6DI2_1
	PLCTAG_BS_IO_R6DI2_2
	PLCTAG_BS_IO_R6DI3_1
	PLCTAG_BS_IO_R6DI3_2
	PLCTAG_BS_IO_R7
	PLCTAG_BS_IO_R7_Offline
	PLCTAG_BS_IO_R7_Fault
	PLCTAG_BS_IO_R7AO1_1
	PLCTAG_BS_IO_R7AO1_2
	PLCTAG_BS_IO_R7AO1_3
	PLCTAG_BS_IO_R7AO1_4
	PLCTAG_BS_IO_R7AI1_1
	PLCTAG_BS_IO_R7AI1_2
	PLCTAG_BS_IO_R7AI1_3
	PLCTAG_BS_IO_R7AI1_4
	PLCTAG_BS_IO_R7DO1_1
	PLCTAG_BS_IO_R7DO1_2
	PLCTAG_BS_IO_R7DI1_1
	PLCTAG_BS_IO_R7DI1_2
	PLCTAG_BS_IO_R7AI2_1
	PLCTAG_BS_IO_R7AI2_2
	PLCTAG_BS_IO_R7AI2_3
	PLCTAG_BS_IO_R7AI2_4
	PLCTAG_BS_IO_R7AI3_1
	PLCTAG_BS_IO_R7AI3_2
	PLCTAG_BS_IO_R7AI3_3
	PLCTAG_BS_IO_R7AI3_4
	PLCTAG_BS_IO_R7DI2_1
	PLCTAG_BS_IO_R7DI2_2
	PLCTAG_BS_IO_R8
	PLCTAG_BS_IO_R8_Offline
	PLCTAG_BS_IO_R8_Fault
	PLCTAG_BS_IO_R8AO1_1
	PLCTAG_BS_IO_R8AO1_2
	PLCTAG_BS_IO_R8AO1_3
	PLCTAG_BS_IO_R8AO1_4
	PLCTAG_BS_IO_R8AI1_1
	PLCTAG_BS_IO_R8AI1_2
	PLCTAG_BS_IO_R8AI1_3
	PLCTAG_BS_IO_R8AI1_4
	PLCTAG_BS_IO_R8AI2_1
	PLCTAG_BS_IO_R8AI2_2
	PLCTAG_BS_IO_R8AI2_3
	PLCTAG_BS_IO_R8AI2_4
	PLCTAG_BS_IO_R8AI3_1
	PLCTAG_BS_IO_R8AI3_2
	PLCTAG_BS_IO_R8AI3_3
	PLCTAG_BS_IO_R8AI3_4
	PLCTAG_BS_IO_R8AI4_1
	PLCTAG_BS_IO_R8AI4_2
	PLCTAG_BS_IO_R8AI4_3
	PLCTAG_BS_IO_R8AI4_4
	PLCTAG_BS_IO_R8AI5_1
	PLCTAG_BS_IO_R8AI5_2
	PLCTAG_BS_IO_R8AI5_3
	PLCTAG_BS_IO_R8AI5_4
	PLCTAG_BS_IO_R8DO1_1
	PLCTAG_BS_IO_R8DO1_2
	PLCTAG_BS_IO_R8DO2_1
	PLCTAG_BS_IO_R8DO2_2
	PLCTAG_BS_IO_R8DI1_1
	PLCTAG_BS_IO_R8DI1_2
	PLCTAG_BS_IO_R8DI2_1
	PLCTAG_BS_IO_R8DI2_2
	PLCTAG_BS_IO_R8DI3_1
	PLCTAG_BS_IO_R8DI3_2
	PLCTAG_BS_IO_R8AI6_1
	PLCTAG_BS_IO_R8AI6_2
	PLCTAG_BS_IO_R8AI6_3
	PLCTAG_BS_IO_R8AI6_4
	PLCTAG_BS_IO_R9
	PLCTAG_BS_IO_R9_Offline
	PLCTAG_BS_IO_R9_Fault
	PLCTAG_BS_IO_R9FC1_O1
	PLCTAG_BS_IO_R9FC1_O2
	PLCTAG_BS_IO_R9FC1_I1
	PLCTAG_BS_IO_R9FC1_I2
	PLCTAG_BS_IO_R9AI1_1
	PLCTAG_BS_IO_R9AI1_2
	PLCTAG_BS_IO_R9AI1_3
	PLCTAG_BS_IO_R9AI1_4
	PLCTAG_BS_IO_R9AI2_1
	PLCTAG_BS_IO_R9AI2_2
	PLCTAG_BS_IO_R9AI2_3
	PLCTAG_BS_IO_R9AI2_4
	PLCTAG_BS_IO_R9AI3_1
	PLCTAG_BS_IO_R9AI3_2
	PLCTAG_BS_IO_R9AI3_3
	PLCTAG_BS_IO_R9AI3_4
	PLCTAG_BS_IO_R9DO1_1
	PLCTAG_BS_IO_R9DO1_2
	PLCTAG_BS_IO_R9DO2_1
	PLCTAG_BS_IO_R9DO2_2
	PLCTAG_BS_IO_R9DI1_1
	PLCTAG_BS_IO_R9DI1_2
	PLCTAG_BS_IO_R9DI2_1
	PLCTAG_BS_IO_R9DI2_2
	PLCTAG_BS_IO_R9DI3_1
	PLCTAG_BS_IO_R9DI3_2
	PLCTAG_BS_IO_R9DI4_1
	PLCTAG_BS_IO_R9DI4_2
	PLCTAG_BS_IO_R9DI5_1
	PLCTAG_BS_IO_R9DI5_2
	PLCTAG_BS_IO_R9DI6_1
	PLCTAG_BS_IO_R9DI6_2
	PLCTAG_BS_IO_R10
	PLCTAG_BS_IO_R10_Offline
	PLCTAG_BS_IO_R10_Fault
	PLCTAG_BS_IO_R10AI1_1
	PLCTAG_BS_IO_R10AI1_2
	PLCTAG_BS_IO_R10AI1_3
	PLCTAG_BS_IO_R10AI1_4
	PLCTAG_BS_IO_R10DO1_1
	PLCTAG_BS_IO_R10DO1_2
	PLCTAG_BS_IO_R10DI1_1
	PLCTAG_BS_IO_R10DI1_2
	PLCTAG_BS_IO_R11
	PLCTAG_BS_IO_R11_Offline
	PLCTAG_BS_IO_R11_Fault
	PLCTAG_BS_IO_R11S1_O
	PLCTAG_BS_IO_R11S1_I
	PLCTAG_BS_IO_R12
	PLCTAG_BS_IO_R12_Offline
	PLCTAG_BS_IO_R12_Fault
	PLCTAG_BS_IO_R12AI1_1
	PLCTAG_BS_IO_R12AI1_2
	PLCTAG_BS_IO_R12AI1_3
	PLCTAG_BS_IO_R12AI1_4
	PLCTAG_BS_IO_R12DO1_1
	PLCTAG_BS_IO_R12DO1_2
	PLCTAG_BS_IO_R12DI1_1
	PLCTAG_BS_IO_R12DI1_2
	PLCTAG_BS_IO_R12DI2_1
	PLCTAG_BS_IO_R12DI2_2
	PLCTAG_BS_IO_R13
	PLCTAG_BS_IO_R13_Offline
	PLCTAG_BS_IO_R13_Fault
	PLCTAG_BS_IO_R13FC1_O1
	PLCTAG_BS_IO_R13FC1_O2
	PLCTAG_BS_IO_R13FC1_I1
	PLCTAG_BS_IO_R13FC1_I2
	PLCTAG_BS_IO_R13FC2_O1
	PLCTAG_BS_IO_R13FC2_O2
	PLCTAG_BS_IO_R13FC2_I1
	PLCTAG_BS_IO_R13FC2_I2
	PLCTAG_BS_IO_R13AO1_1
	PLCTAG_BS_IO_R13AO1_2
	PLCTAG_BS_IO_R13AO1_3
	PLCTAG_BS_IO_R13AO1_4
	PLCTAG_BS_IO_R13AI1_1
	PLCTAG_BS_IO_R13AI1_2
	PLCTAG_BS_IO_R13AI1_3
	PLCTAG_BS_IO_R13AI1_4
	PLCTAG_BS_IO_R13DO1_1
	PLCTAG_BS_IO_R13DO1_2
	PLCTAG_BS_IO_R13DI1_1
	PLCTAG_BS_IO_R13DI1_2
	PLCTAG_BS_IO_N21
	PLCTAG_BS_IO_N21_Offline
	PLCTAG_BS_IO_N21_Fault
	PLCTAG_BS_IO_N22
	PLCTAG_BS_IO_N22_Offline
	PLCTAG_BS_IO_N22_Fault
	PLCTAG_BS_IO_N23
	PLCTAG_BS_IO_N23_Offline
	PLCTAG_BS_IO_N23_Fault
	PLCTAG_BS_IO_N24
	PLCTAG_BS_IO_N24_Offline
	PLCTAG_BS_IO_N24_Fault
	PLCTAG_BS_IO_N25
	PLCTAG_BS_IO_N25_Offline
	PLCTAG_BS_IO_N25_Fault
	PLCTAG_BS_IO_N26
	PLCTAG_BS_IO_N26_Offline
	PLCTAG_BS_IO_N26_Fault
	PLCTAG_BS_IO_N27
	PLCTAG_BS_IO_N27_Offline
	PLCTAG_BS_IO_N27_Fault
	PLCTAG_BS_IO_N28
	PLCTAG_BS_IO_N28_Offline
	PLCTAG_BS_IO_N28_Fault
	PLCTAG_BS_IO_N29
	PLCTAG_BS_IO_N29_Offline
	PLCTAG_BS_IO_N29_Fault
	PLCTAG_BS_IO_N30
	PLCTAG_BS_IO_N30_Offline
	PLCTAG_BS_IO_N30_Fault
	PLCTAG_BS_IO_N31
	PLCTAG_BS_IO_N31_Offline
	PLCTAG_BS_IO_N31_Fault
	PLCTAG_BS_IO_N32
	PLCTAG_BS_IO_N32_Offline
	PLCTAG_BS_IO_N32_Fault
	PLCTAG_BS_IO_N41
	PLCTAG_BS_IO_N41_Offline
	PLCTAG_BS_IO_N41_Fault
	PLCTAG_BS_IO_N42
	PLCTAG_BS_IO_N42_Offline
	PLCTAG_BS_IO_N42_Fault
	PLCTAG_BS_IO_N43
	PLCTAG_BS_IO_N43_Offline
	PLCTAG_BS_IO_N43_Fault
	PLCTAG_BS_IO_N44
	PLCTAG_BS_IO_N44_Offline
	PLCTAG_BS_IO_N44_Fault
	PLCTAG_BS_IO_N45
	PLCTAG_BS_IO_N45_Offline
	PLCTAG_BS_IO_N45_Fault
	PLCTAG_BS_IO_N46
	PLCTAG_BS_IO_N46_Offline
	PLCTAG_BS_IO_N46_Fault
	PLCTAG_BS_IO_N47
	PLCTAG_BS_IO_N47_Offline
	PLCTAG_BS_IO_N47_Fault
	PLCTAG_BS_IO_N48
	PLCTAG_BS_IO_N48_Offline
	PLCTAG_BS_IO_N48_Fault
	PLCTAG_BS_ALL_TERM_ARMADIOPREDOSATORI
	PLCTAG_BS_ALL_SICU_ARMADIOPREDOSATORI
	PLCTAG_BS_ALL_TERM_ARMADIOBRUCIATORE
	PLCTAG_BS_ALL_SICU_ARMADIOBRUCIATORE
	PLCTAG_BS_ALL_TERM_ARMADIOTAMBURO
	PLCTAG_BS_ALL_SICU_ARMADIOTAMBURO
	PLCTAG_BS_ALL_TERM_ARMADIOFILTRO
	PLCTAG_BS_ALL_SICU_ARMADIOFILTRO
	PLCTAG_BS_ALL_TERM_ARMADIOVAGLIO
	PLCTAG_BS_ALL_SICU_ARMADIOVAGLIO
	PLCTAG_BS_ALL_TERM_ARMADIODOSAGGIO
	PLCTAG_BS_ALL_SICU_ARMADIODOSAGGIO
	PLCTAG_BS_ALL_TERM_ARMADIOSILO
	PLCTAG_BS_ALL_SICU_ARMADIOSILO
	PLCTAG_BS_ALL_TERM_ARMADIOVIATOP
	PLCTAG_BS_ALL_SICU_ARMADIOVIATOP
	PLCTAG_BS_ALL_TERM_ARMADIORICFREDDO
	PLCTAG_BS_ALL_SICU_ARMADIORICFREDDO
	PLCTAG_BS_ALL_TERM_ARMADIOLEGANTE
	PLCTAG_BS_ALL_SICU_ARMADIOLEGANTE
	PLCTAG_Bruciatore2AutomaticoImpulsoRegolazioneModulatore
	PLCTAG_Bruciatore2AutomaticoAbilitaRegolazioneModulatore
	PLCTAG_Bruciatore2AutomaticoSegnoRegolazioneModulatore
	PLCTAG_Bruciatore2AutomaticoDurataImpulsoRegolazioneModulatore
	PLCTAG_EN_FAST
	PLCTAG_Comp1_Abilitazione
	PLCTAG_Comp1_FinePesata
	PLCTAG_Comp1_FineScarico
	PLCTAG_Comp2_Abilitazione
	PLCTAG_Comp2_FinePesata
	PLCTAG_Comp2_FineScarico
	PLCTAG_Comp3_Abilitazione
	PLCTAG_Comp3_FinePesata
	PLCTAG_Comp3_FineScarico
	PLCTAG_Comp4_Abilitazione
	PLCTAG_Comp4_FinePesata
	PLCTAG_Comp4_FineScarico
	PLCTAG_Comp5_Abilitazione
	PLCTAG_Comp5_FinePesata
	PLCTAG_Comp5_FineScarico
	PLCTAG_Comp6_Abilitazione
	PLCTAG_Comp6_FinePesata
	PLCTAG_Comp6_FineScarico
	PLCTAG_Comp7_Abilitazione
	PLCTAG_Comp7_FinePesata
	PLCTAG_Comp7_FineScarico
	PLCTAG_Comp8_Abilitazione
	PLCTAG_Comp8_FinePesata
	PLCTAG_Comp8_FineScarico
	PLCTAG_Comp9_Abilitazione
	PLCTAG_Comp9_FinePesata
	PLCTAG_Comp9_FineScarico
	PLCTAG_Comp10_Abilitazione
	PLCTAG_Comp10_FinePesata
	PLCTAG_Comp10_FineScarico
	PLCTAG_Comp11_Abilitazione
	PLCTAG_Comp11_FinePesata
	PLCTAG_Comp11_FineScarico
	PLCTAG_Comp12_Abilitazione
	PLCTAG_Comp12_FinePesata
	PLCTAG_Comp12_FineScarico
	PLCTAG_Comp13_Abilitazione
	PLCTAG_Comp13_FinePesata
	PLCTAG_Comp13_FineScarico
	PLCTAG_Comp14_Abilitazione
	PLCTAG_Comp14_FinePesata
	PLCTAG_Comp14_FineScarico
	PLCTAG_Comp15_Abilitazione
	PLCTAG_Comp15_FinePesata
	PLCTAG_Comp15_FineScarico
	PLCTAG_Comp16_Abilitazione
	PLCTAG_Comp16_FinePesata
	PLCTAG_Comp16_FineScarico
	PLCTAG_Comp17_Abilitazione
	PLCTAG_Comp17_FinePesata
	PLCTAG_Comp17_FineScarico
	PLCTAG_Comp18_Abilitazione
	PLCTAG_Comp18_FinePesata
	PLCTAG_Comp18_FineScarico
	PLCTAG_Comp19_Abilitazione
	PLCTAG_Comp19_FinePesata
	PLCTAG_Comp19_FineScarico
	PLCTAG_Comp20_Abilitazione
	PLCTAG_Comp20_FinePesata
	PLCTAG_Comp20_FineScarico
	PLCTAG_Step_Bil_AGGREGATI
	PLCTAG_Step_Bil_FILLER
	PLCTAG_Step_Bil_BITUME
	PLCTAG_Step_Bil_VIATOP
	PLCTAG_Step_Bil_RICICLATO
	PLCTAG_Step_Bil_SACCHI
	PLCTAG_Step_Bil_BITUMEGRAV
	PLCTAG_Step_Bil_ADDBACLEGCNT
	PLCTAG_Step_Bil_BITUMECNT
	PLCTAG_Step_Bil_RICICLATOSIWA
	PLCTAG_Step_Bil_CICLRICICLATOFREDDO
	PLCTAG_ErrCond_SpaccFiller_F2
	PLCTAG_AvvCaldo_Prenotazione
	PLCTAG_IN_DUSTFIX_ENABLE    '20150731
	PLCTAG_IN_DUSTFIX_TERM  '20150731
	PLCTAG_IN_RIT_MIXER_DUSTFIX  '20150731
	PLCTAG_IN_RIT_POMPA_DUSTFIX  '20150731
	PLCTAG_NM_IN_BIT_BASSA_TEMP_BIT2 '20150804
	PLCTAG_Add2_Abilita_MinFlusso   '20150925
	PLCTAG_Add2_Tempo_MinFlusso   '20150925
	PLCTAG_Filler2_RompiSacchi_Presenza   '20161109 SpaccaFiller2
	PLCTAG_ALARM_Filler2_RompiSacchi      '20151110 SpaccaFiller2
	PLCTAG_ACK_Filler2_RompiSacchi        '20151110 SpaccaFiller2
	PLCTAG_VALV_F2_Rompisacchi_Codice_Allarme '20160613 Valvola SpaccaFiller2
	PLCTAG_AI_FiltroDMR_Liv_SX            '20151120 Livelli DMR Analogici
	PLCTAG_AI_FiltroDMR_Liv_DX            '20151120 Livelli DMR Analogici
	PLCTAG_AI_FiltroDMR_Liv_CE            '20151228 Livelli DMR Analogici
	PLCTAG_SILI_PAR_AbilitaCelleCaricoSilo
	PLCTAG_DB5_VisualizzaNavetta                '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_FondoScala_Peso             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_FondoScala_Temperature      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_CelleSiloStabBilancia       '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoMinPressTelescarico    '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_MaxTara                     '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_Tolleranza                  '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_NumeroSili                  '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_NumeroScomparti             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_Diretto                     '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_DirettoConPeso              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_Rifiuti                     '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_RifiutiConPeso              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_0              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_1              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_2              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_3              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_4              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_5              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_6              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_7              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_8              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_9              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_10             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoIniziale_21             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraInizialeCella_1         '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraInizialeCella_2         '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraInizialeCella_3         '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraInizialeCella_4         '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoInizialeCamion          '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraInizialeCamion          '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Num_Scomp_Res_Id_Mat        '20170221 Tecnobeton
	PLCTAG_SILI_PAR_AppScomparto_0              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_1              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_2              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_3              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_4              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_5              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_6              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_7              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_8              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_9              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_10             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_AppScomparto_21             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_EnableTempoAntBlocco        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco0        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco1        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco2        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco3        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco4        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco5        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco6        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco7        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco8        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco9        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco10       '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_PAR_TempoAnticipoBlocco21       '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TrasfPar                    '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_AggiornaPar                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_EseguiTaraCella             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_ResetTaraCella              '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_NumeroCella                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_ResetCamion                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_AzzeraScomparto             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_ScriviScomparto             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_NumeroScomparto             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_ValorePesoScomparto         '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_ParametriOK                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_0                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_1                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_2                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_3                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_4                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_5                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_6                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_7                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_8                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_9                      '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_10                     '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Peso_21                     '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoCella_1                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoCella_2                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoCella_3                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoCella_4                 '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraCella_1                 '20151203(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraCella_2                 '20151203(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraCella_3                 '20151203(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraCella_4                 '20151203(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_PesoCamion                  '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Imp_Carico                  '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Imp_Telescarico             '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_Imp_Silo_Car_Tele           '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_ImpastoNetto_Ton            '20151130(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_TaraCamion                  '20151210(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_SILI_HMI_FineCamion                  '20151210(NUOVA GESTIONE SILI DI DEPOSITO)
	PLCTAG_Totalizzatore_Nastro_Agg             '20151104(Nuova gestione totalizzatori su nastro)
	PLCTAG_Reset_Totalizzatore_Nastro_Agg       '20151104(Nuova gestione totalizzatori su nastro)
	PLCTAG_Totalizzatore_Nastro_Ric             '20151104(Nuova gestione totalizzatori su nastro)
	PLCTAG_Reset_Totalizzatore_Nastro_Ric       '20151104(Nuova gestione totalizzatori su nastro)
	PLCTAG_Totalizzatore_Nastro_Ric_Par         '20151104(Nuova gestione totalizzatori su nastro)
	PLCTAG_Reset_Totalizzatore_Nastro_Ric_Par   '20151104(Nuova gestione totalizzatori su nastro)
	PLCTAG_EN_Valvola_Diesel                    '20151107
	PLCTAG_FC_Valvola_Diesel_AP                 '20151107
	PLCTAG_PesaCamionValAnalogico               '20151107
	PLCTAG_SILI_PAR_PesaCamionEnable            '20151210
	PLCTAG_SILI_PAR_PesaCamionEnScaling         '20151110
	PLCTAG_SILI_PAR_PesaCamionScalingAnalogMin  '20151110
	PLCTAG_SILI_PAR_PesaCamionScalingAnalogMax  '20151110
	PLCTAG_SILI_PAR_PesaCamionScalingKgMin     '20151110
	PLCTAG_SILI_PAR_PesaCamionScalingKgMax     '20151110
	PLCTAG_SILI_PAR_PesaCamionEnFiltro          '20151110
	PLCTAG_SILI_PAR_PesaCamionSampleTime        '20151110
	PLCTAG_SILI_PAR_PesaCamionSampleNr          '20151110
	PLCTAG_SILI_PAR_PesaCamionEnLin             '20151110
	PLCTAG_SILI_PAR_PesaCamionNumLin            '20151110
	PLCTAG_SILI_PAR_PesaCamionLinX0             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinX1             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinX2             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinX3             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinX4             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinY0             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinY1             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinY2             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinY3             '20151110
	PLCTAG_SILI_PAR_PesaCamionLinY4             '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_0         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_1         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_2         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_3         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_4         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_5         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_6         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_7         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_8         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_9         '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_10        '20151110
	PLCTAG_SILI_PAR_AppScomparto_Temp_21        '20151110
	PLCTAG_SILI_PAR_FondoScala_Temp1            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp2            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp3            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp4            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp5            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp6            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp7            '20151215
	PLCTAG_SILI_PAR_FondoScala_Temp8            '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp1              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp2              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp3              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp4              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp5              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp6              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp7              '20151215
	PLCTAG_SILI_PAR_ScalaMin_Temp8              '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp1        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp2        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp3        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp4        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp5        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp6        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp7        '20151215
	PLCTAG_SILI_PAR_ScalaMinAnalog_Temp8        '20151215
	PLCTAG_SILI_HMI_Temperature_Piro1          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro2          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro3          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro4          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro5          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro6          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro7          '20151215
	PLCTAG_SILI_HMI_Temperature_Piro8          '20151215
	PLCTAG_SILI_HMI_Storico_ScarichiPesi0       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi1       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi2       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi3       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi4       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi5       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi6       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi7       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi8       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi9       '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi10      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi11      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi12      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi13      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi14      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi15      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi16      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi17      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi18      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi19      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi20      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiPesi21      '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature0    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature1    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature2    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature3    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature4    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature5    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature6    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature7    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature8    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature9    '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature10   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature11   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature12   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature13   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature14   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature15   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature16   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature17   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature18   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature19   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature20   '20151110
	PLCTAG_SILI_HMI_Storico_ScarichiTemperature21   '20151110
	PLCTAG_SILI_HMI_Storico_IdMateriale0 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale1 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale2 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale3 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale4 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale5 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale6 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale7 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale8 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale9 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale10 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale11 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale12 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale13 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale14 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale15 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale16 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale17 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale18 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale19 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale20 '20160211
	PLCTAG_SILI_HMI_Storico_IdMateriale21 '20160211
	PLCTAG_SILI_HMI_Id_Ricetta_Mixer      '20160211
	PLCTAG_SILI_HMI_Dest_Silo_Prenotata   '20160218
	PLCTAG_SILI_HMI_Allarme1    '20160216
	PLCTAG_SILI_HMI_Allarme2    '20160216
	PLCTAG_SILI_HMI_Allarme3    '20160216
	PLCTAG_SILI_HMI_Allarme4    '20160216
	PLCTAG_SILI_HMI_Allarme5    '20160216
	PLCTAG_SILI_HMI_Allarme6    '20160216
	PLCTAG_SILI_HMI_Allarme7    '20160216
	PLCTAG_SILI_HMI_Allarme8    '20160216
	PLCTAG_SILI_HMI_Allarme9    '20160216
	PLCTAG_SILI_HMI_Allarme10    '20160216
	PLCTAG_SILI_HMI_Allarme11    '20160216
	PLCTAG_SILI_HMI_Allarme12    '20160216
	PLCTAG_SILI_HMI_Allarme13    '20160216
	PLCTAG_SILI_HMI_Allarme14    '20160216
	PLCTAG_SILI_HMI_Allarme15    '20160216
	PLCTAG_SILI_HMI_Allarme16    '20160216
	PLCTAG_SILI_HMI_DosaggioInCorso                 '20160125
	PLCTAG_SILI_HMI_Forz_Id_Mat '20161114
	PLCTAG_SILI_HMI_CamionPresente                  '20160127
	PLCTAG_PRED_Out_Ric_Auto_Corso                  '20160201
	PLCTAG_MOT_AVVCALDO_SPEG                        '20160302
	PLCTAG_MOT_ESCLUDI_SPEGN_VAG                    '20160920
	'20160419
	PLCTAG_DB5_ViatopScarMixer1_Enable
	PLCTAG_DB5_ViatopScarMixer1_FondoScala
	PLCTAG_DB5_ViatopScarMixer1_Tara
	PLCTAG_DB5_ViatopScarMixer1_Sicurezza
	PLCTAG_DB5_ViatopScarMixer1_Tmout_Pesata
	PLCTAG_DB5_ViatopScarMixer1_Tmout_Scarico
	PLCTAG_DB5_ViatopScarMixer1_Ant_Start_Compressore
	PLCTAG_DB5_ViatopScarMixer1_Rit_Stop_Compressore
	PLCTAG_DB5_ViatopScarMixer1_TempoPermanenza
	PLCTAG_DB15_ViatopScarMixer1_Set
	PLCTAG_DB15_ViatopScarMixer1_Lenta
	PLCTAG_DB15_ViatopScarMixer1_Volo
	PLCTAG_DB15_ViatopScarMixer1_Ordine
	PLCTAG_DB15_ViatopScarMixer1_Tolleranza
	PLCTAG_DB15_ViatopScarMixer1_TStab
	PLCTAG_DB15_ViatopScarMixer1_TStabTara
	PLCTAG_DB15_ViatopScarMixer1_Ritardo
	PLCTAG_DB57_ViatopScarMixer1_PesataMan
	PLCTAG_DB57_ViatopScarMixer1_ScaricoMan
	PLCTAG_DB57_ViatopScarMixer1_StartCompressoreMan
	PLCTAG_DB46_ViatopScarMixer1_OutCmdCompressore
	PLCTAG_DB46_ViatopScarMixer1_OutPesata
	PLCTAG_DB46_ViatopScarMixer1_OutScarico
	PLCTAG_DB46_ViatopScarMixer1_RitCompressore
	PLCTAG_DB46_ViatopScarMixer1_Ack
	PLCTAG_DB46_ViatopScarMixer1_Imp_Trit
	PLCTAG_DB46_ViatopScarMixer1_AI_Peso
	PLCTAG_DB61_All_ViatopScarMixer1_FineCorsaBilancia
	PLCTAG_DB61_AllarmiBool262_1
	PLCTAG_DB61_All_ViatopScarMixer1_NonTara
	PLCTAG_DB61_All_ViatopScarMixer1_Sicurezza
	PLCTAG_DB61_All_ViatopScarMixer1_FuoriTolleranza
	PLCTAG_DB61_All_ViatopScarMixer1_LivelloMinimo
	PLCTAG_DB61_AllarmiBool262_6
	PLCTAG_DB61_All_ViatopScarMixer1_CompressoreFermo
	PLCTAG_DB61_All_ViatopScarMixer1_TermicaCompressore
	PLCTAG_DB61_All_ViatopScarMixer1_ScaricoBilanciaAperto
	PLCTAG_DB61_All_ViatopScarMixer1_ScaricoBilanciaChiuso
	PLCTAG_DB61_All_ViatopScarMixer1_Termica_Dosaggio    '20161010
	PLCTAG_DB61_All_ViatopScarMixer1_Termica_Scarico    '20161010
	PLCTAG_DB61_All_ViatopScarMixer1_PerditaPeso
	PLCTAG_DB61_All_ViatopScarMixer1_Tmout_Pesata
	PLCTAG_DB61_All_ViatopScarMixer1_Tmout_Scarico
	PLCTAG_DB32_ViatopScarMixer1_SetKg
	PLCTAG_DB32_ViatopScarMixer1_NettoKg
	PLCTAG_DB32_ViatopScarMixer1_VoloKg
	PLCTAG_DB5_ViatopScarMixer2_Enable
	PLCTAG_DB5_ViatopScarMixer2_FondoScala
	PLCTAG_DB5_ViatopScarMixer2_Tara
	PLCTAG_DB5_ViatopScarMixer2_Sicurezza
	PLCTAG_DB5_ViatopScarMixer2_Tmout_Pesata
	PLCTAG_DB5_ViatopScarMixer2_Tmout_Scarico
	PLCTAG_DB5_ViatopScarMixer2_Ant_Start_Compressore
	PLCTAG_DB5_ViatopScarMixer2_Rit_Stop_Compressore
	PLCTAG_DB5_ViatopScarMixer2_TempoPermanenza
	PLCTAG_DB15_ViatopScarMixer2_Set
	PLCTAG_DB15_ViatopScarMixer2_Lenta
	PLCTAG_DB15_ViatopScarMixer2_Volo
	PLCTAG_DB15_ViatopScarMixer2_Ordine
	PLCTAG_DB15_ViatopScarMixer2_Tolleranza
	PLCTAG_DB15_ViatopScarMixer2_TStab
	PLCTAG_DB15_ViatopScarMixer2_TStabTara
	PLCTAG_DB15_ViatopScarMixer2_Ritardo
	PLCTAG_DB58_ViatopScarMixer2_PesataMan
	PLCTAG_DB58_ViatopScarMixer2_ScaricoMan
	PLCTAG_DB58_ViatopScarMixer2_StartCompressoreMan
	PLCTAG_DB46_ViatopScarMixer2_OutCmdCompressore
	PLCTAG_DB46_ViatopScarMixer2_OutPesata
	PLCTAG_DB46_ViatopScarMixer2_OutScarico
	PLCTAG_DB46_ViatopScarMixer2_RitCompressore
	PLCTAG_DB46_ViatopScarMixer2_Ack
	PLCTAG_DB46_ViatopScarMixer2_Imp_Trit
	PLCTAG_DB46_ViatopScarMixer2_AI_Peso
	PLCTAG_DB61_All_ViatopScarMixer2_FineCorsaBilancia
	PLCTAG_DB61_AllarmiBool286_1
	PLCTAG_DB61_All_ViatopScarMixer2_NonTara
	PLCTAG_DB61_All_ViatopScarMixer2_Sicurezza
	PLCTAG_DB61_All_ViatopScarMixer2_FuoriTolleranza
	PLCTAG_DB61_All_ViatopScarMixer2_LivelloMinimo
	PLCTAG_DB61_AllarmiBool286_6
	PLCTAG_DB61_All_ViatopScarMixer2_CompressoreFermo
	PLCTAG_DB61_All_ViatopScarMixer2_TermicaCompressore
	PLCTAG_DB61_All_ViatopScarMixer2_ScaricoBilanciaAperto
	PLCTAG_DB61_All_ViatopScarMixer2_ScaricoBilanciaChiuso
	PLCTAG_DB61_All_ViatopScarMixer2_Termica_Dosaggio    '20161010
	PLCTAG_DB61_All_ViatopScarMixer2_Termica_Scarico    '20161010
	PLCTAG_DB61_All_ViatopScarMixer2_PerditaPeso
	PLCTAG_DB61_All_ViatopScarMixer2_Tmout_Pesata
	PLCTAG_DB61_All_ViatopScarMixer2_Tmout_Scarico
	PLCTAG_DB33_ViatopScarMixer2_SetKg
	PLCTAG_DB33_ViatopScarMixer2_NettoKg
	PLCTAG_DB33_ViatopScarMixer2_VoloKg
	PLCTAG_DB46_SemaforoBenna_CmdVerde
	PLCTAG_DB46_SemaforoBenna_DI_Verde
	PLCTAG_DB46_SemaforoSili_CmdVerde
	PLCTAG_DB46_SemaforoSili_DI_Verde
	'20160419
	PLCTAG_DB46_StartBennaCyb500   '20160630
	PLCTAG_DB2024_HMI_Start_Pompa_Combustibile   '20160630
	PLCTAG_DB2024_HMI_Start_Pompa_Combustibile_Caldo   '20160705
	'20160915
	PLCTAG_DB46_XTUA_DRW_Elevatore_Caldo
	PLCTAG_DB46_XTUA_DRW_Elevatore_Ric
	PLCTAG_DB46_XTUA_DRW_Tamburo
	PLCTAG_DB46_XTUA_DRW_Ventola_Bruc
	PLCTAG_DB46_XTUA_DRW_Tamburo2
	PLCTAG_DB46_XTUA_DRW_Ventola_Bruc2
	'
	'20160923
	PLCTAG_EN_Valvola_OlioComb
	PLCTAG_FC_Valvola_OlioComb_AP
	'
	'20161020
	PLCTAG_SLIT_MOTORE8_GestioneInternaSlittamento
	PLCTAG_SLIT_MOTORE8_Soglia1Slittamento
	PLCTAG_SLIT_MOTORE8_TempoSoglia1Slittamento
	PLCTAG_SLIT_MOTORE8_Soglia2Slittamento
	PLCTAG_SLIT_MOTORE8_TempoSoglia2Slittamento
	PLCTAG_SLIT_MOTORE10_GestioneInternaSlittamento
	PLCTAG_SLIT_MOTORE10_Soglia1Slittamento
	PLCTAG_SLIT_MOTORE10_TempoSoglia1Slittamento
	PLCTAG_SLIT_MOTORE10_Soglia2Slittamento
	PLCTAG_SLIT_MOTORE10_TempoSoglia2Slittamento
	PLCTAG_SLIT_MOTORE14_GestioneInternaSlittamento
	PLCTAG_SLIT_MOTORE14_Soglia1Slittamento
	PLCTAG_SLIT_MOTORE14_TempoSoglia1Slittamento
	PLCTAG_SLIT_MOTORE14_Soglia2Slittamento
	PLCTAG_SLIT_MOTORE14_TempoSoglia2Slittamento
	PLCTAG_SLIT_MOTORE21_GestioneInternaSlittamento        '20161129
	PLCTAG_SLIT_MOTORE21_Soglia1Slittamento                '20161129
	PLCTAG_SLIT_MOTORE21_TempoSoglia1Slittamento           '20161129
	PLCTAG_SLIT_MOTORE21_Soglia2Slittamento                '20161129
	PLCTAG_SLIT_MOTORE21_TempoSoglia2Slittamento           '20161129
	PLCTAG_SLIT_MOTORE24_GestioneInternaSlittamento        '20161129
	PLCTAG_SLIT_MOTORE24_Soglia1Slittamento                '20161129
	PLCTAG_SLIT_MOTORE24_TempoSoglia1Slittamento           '20161129
	PLCTAG_SLIT_MOTORE24_Soglia2Slittamento                '20161129
	PLCTAG_SLIT_MOTORE24_TempoSoglia2Slittamento           '20161129
	PLCTAG_SLIT_MOTORE28_GestioneInternaSlittamento
	PLCTAG_SLIT_MOTORE28_Soglia1Slittamento
	PLCTAG_SLIT_MOTORE28_TempoSoglia1Slittamento
	PLCTAG_SLIT_MOTORE28_Soglia2Slittamento
	PLCTAG_SLIT_MOTORE28_TempoSoglia2Slittamento
	PLCTAG_SLIT_MOTORE30_GestioneInternaSlittamento        '20161129
	PLCTAG_SLIT_MOTORE30_Soglia1Slittamento                '20161129
	PLCTAG_SLIT_MOTORE30_TempoSoglia1Slittamento           '20161129
	PLCTAG_SLIT_MOTORE30_Soglia2Slittamento                '20161129
	PLCTAG_SLIT_MOTORE30_TempoSoglia2Slittamento           '20161129
	PLCTAG_SLIT_MOTORE38_GestioneInternaSlittamento        '20161129
	PLCTAG_SLIT_MOTORE38_Soglia1Slittamento                '20161129
	PLCTAG_SLIT_MOTORE38_TempoSoglia1Slittamento           '20161129
	PLCTAG_SLIT_MOTORE38_Soglia2Slittamento                '20161129
	PLCTAG_SLIT_MOTORE38_TempoSoglia2Slittamento           '20161129
	PLCTAG_SLIT_MOTORE32_GestioneInternaSlittamento        '20161129
	PLCTAG_SLIT_MOTORE32_Soglia1Slittamento                '20161129
	PLCTAG_SLIT_MOTORE32_TempoSoglia1Slittamento           '20161129
	PLCTAG_SLIT_MOTORE32_Soglia2Slittamento                '20161129
	PLCTAG_SLIT_MOTORE32_TempoSoglia2Slittamento           '20161129
	PLCTAG_Motore21_Slittamento_PrimaSoglia             '20161129
	PLCTAG_Motore25_Slittamento_PrimaSoglia             '20161129
	PLCTAG_Motore29_Slittamento_PrimaSoglia             '20161129
	PLCTAG_Motore38_Slittamento_PrimaSoglia             '20161129
	PLCTAG_Motore44_Slittamento_PrimaSoglia             '20161129
	'20161021
	PLCTAG_BIL_PNET_Aggregati_Cmd_FormAperto
	PLCTAG_BIL_PNET_Aggregati_Cmd_EseguiTara
	PLCTAG_BIL_PNET_Aggregati_Cmd_EseguiPesoCampione
	PLCTAG_BIL_PNET_Aggregati_Cmd_ValPesoCampione
	PLCTAG_BIL_PNET_Aggregati_Cmd_ResetFabbrica
	PLCTAG_BIL_PNET_Aggregati_Cmd_InCorso
	PLCTAG_BIL_PNET_Aggregati_PesoKg
	PLCTAG_BIL_PNET_Aggregati_Presenza
	PLCTAG_BIL_PNET_Aggregati_NumeroDecimali
	PLCTAG_BIL_PNET_Aggregati_Errore
	PLCTAG_BIL_PNET_Filler_Cmd_FormAperto
	PLCTAG_BIL_PNET_Filler_Cmd_EseguiTara
	PLCTAG_BIL_PNET_Filler_Cmd_EseguiPesoCampione
	PLCTAG_BIL_PNET_Filler_Cmd_ValPesoCampione
	PLCTAG_BIL_PNET_Filler_Cmd_ResetFabbrica
	PLCTAG_BIL_PNET_Filler_Cmd_InCorso
	PLCTAG_BIL_PNET_Filler_PesoKg
	PLCTAG_BIL_PNET_Filler_Presenza
	PLCTAG_BIL_PNET_Filler_NumeroDecimali
	PLCTAG_BIL_PNET_Filler_Errore
	PLCTAG_BIL_PNET_Bitume_Cmd_FormAperto
	PLCTAG_BIL_PNET_Bitume_Cmd_EseguiTara
	PLCTAG_BIL_PNET_Bitume_Cmd_EseguiPesoCampione
	PLCTAG_BIL_PNET_Bitume_Cmd_ValPesoCampione
	PLCTAG_BIL_PNET_Bitume_Cmd_ResetFabbrica
	PLCTAG_BIL_PNET_Bitume_Cmd_InCorso
	PLCTAG_BIL_PNET_Bitume_PesoKg
	PLCTAG_BIL_PNET_Bitume_Presenza
	PLCTAG_BIL_PNET_Bitume_NumeroDecimali
	PLCTAG_BIL_PNET_Bitume_Errore
	PLCTAG_BIL_PNET_Riciclato_Cmd_FormAperto
	PLCTAG_BIL_PNET_Riciclato_Cmd_EseguiTara
	PLCTAG_BIL_PNET_Riciclato_Cmd_EseguiPesoCampione
	PLCTAG_BIL_PNET_Riciclato_Cmd_ValPesoCampione
	PLCTAG_BIL_PNET_Riciclato_Cmd_ResetFabbrica
	PLCTAG_BIL_PNET_Riciclato_Cmd_InCorso
	PLCTAG_BIL_PNET_Riciclato_PesoKg
	PLCTAG_BIL_PNET_Riciclato_Presenza
	PLCTAG_BIL_PNET_Riciclato_NumeroDecimali
	PLCTAG_BIL_PNET_Riciclato_Errore
	PLCTAG_BIL_PNET_Viatop_Cmd_FormAperto
	PLCTAG_BIL_PNET_Viatop_Cmd_EseguiTara
	PLCTAG_BIL_PNET_Viatop_Cmd_EseguiPesoCampione
	PLCTAG_BIL_PNET_Viatop_Cmd_ValPesoCampione
	PLCTAG_BIL_PNET_Viatop_Cmd_ResetFabbrica
	PLCTAG_BIL_PNET_Viatop_Cmd_InCorso
	PLCTAG_BIL_PNET_Viatop_PesoKg
	PLCTAG_BIL_PNET_Viatop_Presenza
	PLCTAG_BIL_PNET_Viatop_NumeroDecimali
	PLCTAG_BIL_PNET_Viatop_Errore
	PLCTAG_BIL_PNET_Viatop2_Cmd_FormAperto
	PLCTAG_BIL_PNET_Viatop2_Cmd_EseguiTara
	PLCTAG_BIL_PNET_Viatop2_Cmd_EseguiPesoCampione
	PLCTAG_BIL_PNET_Viatop2_Cmd_ValPesoCampione
	PLCTAG_BIL_PNET_Viatop2_Cmd_ResetFabbrica
	PLCTAG_BIL_PNET_Viatop2_Cmd_InCorso
	PLCTAG_BIL_PNET_Viatop2_PesoKg
	PLCTAG_BIL_PNET_Viatop2_Presenza
	PLCTAG_BIL_PNET_Viatop2_NumeroDecimali
	PLCTAG_BIL_PNET_Viatop2_Errore
	PLCTAG_GEST_FUMI_TAMB_CmdUp                     '20161128
	PLCTAG_GEST_FUMI_TAMB_CmdDown                   '20161128
	PLCTAG_GEST_FUMI_TAMB_Modulatore                '20161128
	PLCTAG_GEST_FUMI_TAMB_Depr_Vaglio               '20161128
	PLCTAG_GEST_FUMI_TAMB_Fondoscala_depr_vaglio    '20161128
	PLCTAG_GEST_FUMI_TAMB_Riscalatura_mod_fumi      '20161128
	PLCTAG_GEST_FUMI_TAMB_Enable                    '20161128
	PLCTAG_NM_CountDown_Rifiuti                     '20161129
	PLCTAG_GEST_VEL_TAMB_CmdUp                      '20161130
	PLCTAG_GEST_VEL_TAMB_CmdDown                    '20161130
	PLCTAG_GEST_VEL_TAMB_Trasf_DefaultVal           '20170215
	PLCTAG_GEST_VEL_TAMB_Modulatore                 '20161130
	PLCTAG_GEST_VEL_TAMB_Max_Vel_Perc               '20170202
	PLCTAG_GEST_VEL_TAMB_Def_Vel_Perc               '20170202
	PLCTAG_GEST_VEL_TAMB_Enable                     '20161130
	PLCTAG_TimerScA                                 '20161201
	PLCTAG_TempoRitardoAggregati                    '20161201
	PLCTAG_FirstComponentToDisc                      '20161201
	PLCTAG_PRED_AssociazionePredRicAJolly           '20161207
	PLCTAG_SILO_Deodorante_Enable                   '20161214
	PLCTAG_SILO_Deodorante_RitStart                 '20161214
	PLCTAG_SILO_Deodorante_RitStop                  '20161214
	PLCTAG_SILO_Deodorante_MaxDurata                '20161214
	PLCTAG_SILO_Deodorante_Start                    '20161214
	PLCTAG_SILO_Deodorante_Stop                     '20161214
	PLCTAG_SILO_Deodorante_StopMaxDurata            '20161215
	PLCTAG_Darw_ScaRicFInMixer_Term                 '20170110
	PLCTAG_COUNT
End Enum

Public Const PLCTAG_BILANCIA_1 = PLCTAG_SIWA1_CMD_INPUT
Public Const PLCTAG_BILANCIA_0 = PLCTAG_SIWA0_CMD_INPUT

Private Const OPCTagFile As String = "OPCTags.xls"

Private PlusWatchDog As Boolean
Private PlusWatchDogTimer As Long

'20150409
Public PlusWatchDogTimeoutTimer As Long
Public PlusWatchDogTimeout As Long
Public PlusCommunicationBroken As Boolean
Public PlusWatchDogTimeoutAlreadyDone As Boolean
'

'



Public Function LoadOPCTags(ByVal plc As String, ByRef OPCDataCtrl As OPCDataControl)

    Dim FileName As String
    Dim opcTagCount As Integer
    Dim rs As Recordset
    Dim DB As Database

    On Error GoTo Errore

    'Controllo presenza file xls
    FileName = InstallationPath + OPCTagFile
    If Not FileExist(FileName) Then
        Call MsgBox(OPCTagFile & " NOT FOUND", vbOKOnly + vbCritical, CaptionStart & LoadXLSString(227))
        'La storia finisce così
        End
    End If
    
    'Memorizzo il numero di TAG definiti nell'enumerato utilizzato per accedere ai tag "OPDataControl.Item(TAG)"
    Select Case UCase(plc)
        Case "PLC4" 'PLC Principale
            opcTagCount = PLCTAG_COUNT
        Case "PLC2" 'PLC parco legante
            opcTagCount = CistTAG_COUNT
        Case "WAMFOAM" 'PLC bitume schiumato
            opcTagCount = PLCTAGWAMFOAM_COUNT
'20150505
        Case "PLC4CIST"
            opcTagCount = CistRidTAG_COUNT - PLCTAG_COUNT
'
'20160729
        Case "PLC5"
            opcTagCount = PLCTAGAQUABLACK_COUNT
'
        Case Else
            LogInserisci False, "LoadOPCTags(" + plc + " )", "Plc non gestito"
            Exit Function
    End Select

    Set DB = OpenDatabase(FileName, False, True, "Excel 8.0;HDR=NO;")
    Set rs = DB.OpenRecordset(plc + "$", dbOpenTable, dbReadOnly)

    'Verifico la corrispondenza tra la dimensione dell'enumerato ed il numero di record del file XLS
    If (rs.RecordCount <> opcTagCount) Then
        'Fa uscire il messaggio di disallineamento anche in condizione di non debug!
        Call MsgBox("Verificare allineamento TAG tra file XLS ed enumerato", vbOKOnly + vbCritical, CAPTIONSTARTSIMPLE)
        LogInserisci False, "LoadOPCTags(" + plc + " )", "Verificare allineamento TAG tra file XLS ed enumerato"
    End If

    'Aggiunta dei TAG:
    ' - 1a colonna: indice dell'enumerato per mantenere l'accesso posizionele (OPCDATA.Items("EnumIdx"))
    ' - 2a colonna: indirizzo PLC
    rs.MoveFirst
    Do While (Not rs.EOF)
        If rs.Fields(0).Value <> vbNullString And rs.Fields(1).Value <> vbNullString Then
            OPCDataCtrl.items.AddItem (rs.Fields(1).Value)
        End If
        rs.MoveNext
    Loop
    rs.Close

    Exit Function
Errore:
    LogInserisci True, "LoadOPCTags(" + plc + " )", Err.description
End Function

Public Sub PlcEffettuaConnessione()

    With CP240.OPCData

        If (Not DEMO_VERSION And Not PlcDisabilitaConnessione) Then
            If (Not .IsConnected Or MancanzaComunicazione) Then
                If (MancanzaComunicazione) Then
                    .Disconnect
                End If
                .Connect

                If (.IsConnected) Then
                    .items(PLCTAG_DO_DosaggioInCorso).Value = False
                    .items(PLCTAG_NumRicDos).Value = 0
                End If
            End If
        End If
    
    End With

End Sub


Public Sub InizializzaConnessione()

    On Error GoTo Errore

    If CP240.OPCData.items.count = 0 Then
        CP240.OPCData.RemoteHost = SetIP
        CP240.OPCData.ServerName = OpcServerName
        CP240.OPCData.UseAsync = True
    
        LoadOPCTags "plc4", CP240.OPCData
'20150505
        If (CistGestione.Gestione = GestioneSemplificata) Then
             LoadOPCTags "plc4cist", CP240.OPCData
        End If
'
    End If

    PlcEffettuaConnessione
    
    'Crea i TAG per le cisterne
    'CistConnessionePLC

    'SCHIUMATO
    PlcSchiumatoConnessione True

    '20160729
    PlcAquablackConnessione True

    '20160104 A cosa serve?
    'If (DEBUGGING) Then
    '    Call StampaTagListaCompleta
    'End If
    '

    Exit Sub
Errore:
    LogInserisci True, "NET-001", CStr(Err.Number) + " [" + Err.description + "]"

    Call AllarmeTemporaneoFull(96, "XX096", True, True)
End Sub

'20160218
Public Function IsPlcConnected(ByRef opcDC As OPCDataControl) As Boolean

    With opcDC
        IsPlcConnected = False

        If Not .IsConnected Or .items.count = 0 Then
            Exit Function
        End If

        If (Not (GetQuality(.items.item(0).quality) = STATOOK)) Then
            Exit Function
        End If
    End With

    IsPlcConnected = True
End Function

Public Function GetQuality(quality As Long) As QualityEnum

    Dim QualityBit As QualityEnum

    QualityBit = (quality And &HC0) / 64
 
    GetQuality = QualityBit

End Function

Function GetQualityAsString(quality As Long)

    Dim QualityBit As QualityEnum

    QualityBit = GetQuality(quality)

    Select Case QualityBit
        Case STATOERRORE
            GetQualityAsString = UCase(LoadXLSString(292))
        Case STATONONDEFINITO
            GetQualityAsString = UCase(LoadXLSString(292))
        Case STATONONDISPONIBILE
            GetQualityAsString = UCase(LoadXLSString(292))
        Case STATOOK
            GetQualityAsString = UCase(LoadXLSString(801))
    End Select

End Function

Public Function ConversioneUnitaPT100(valore As Integer) As String
    ConversioneUnitaPT100 = Format(CStr(CLng(valore) / 10), "##000") & " *C"
End Function

Public Function ConversioneUnita10V(valore As Integer) As String
    ConversioneUnita10V = Format(CStr(10 * CLng(valore) / 27648), "##00.00") & " V"
End Function

Public Function ConversioneUnita0_20mA(valore As Integer) As String
    ConversioneUnita0_20mA = Format(CStr(20 * CLng(valore) / 27648), "##00.00") & "mA"
End Function

Public Function ConversioneUnita4_20mA(valore As Integer) As String
    ConversioneUnita4_20mA = Format(CStr(4 + (16 * CLng(valore) / 27648)), "##00.00") & "mA"
End Function


Public Sub PlcOutAnalogici()

    Dim indice As Integer
    Dim spread As Integer

    On Error GoTo Errore

    With CP240.OPCData

        If (.items.count = 0) Then
            Exit Sub
        End If

        spread = PLCTAG_AO_SetPredosatore2 - PLCTAG_AO_SetPredosatore1

        '20160405 Solo nell'ultimo assegnamento si considera il segno
        '   Predosatori
        For indice = 0 To MAXPREDOSATORI - 1
            .items(PLCTAG_AO_SetPredosatore1 + (indice * spread)).Value = IIf(Vpred > 0, ListaPredosatori(indice).uscitaAnalogica, -1# * ListaPredosatori(indice).uscitaAnalogica)
        Next indice

        spread = PLCTAG_AO_SetRiciclato2 - PLCTAG_AO_SetRiciclato1

        '   Predosatori riciclato
        For indice = 0 To MAXPREDOSATORIRICICLATO - 1
            .items(PLCTAG_AO_SetRiciclato1 + (indice * spread)).Value = IIf(VRic > 0, ListaPredosatoriRic(indice).uscitaAnalogica, -1# * ListaPredosatoriRic(indice).uscitaAnalogica)
        Next indice
        '20160405 Solo nell'ultimo assegnamento si considera il segno

        If (LivelloAltoTramoggiaRic) Then
            'La routine di azzeramento uscite analogiche pred riclato è ciclata se il deflettore anello-elevatore è abilitato ed
            'in posizione ad elevatore
            If (AbilitaDeflettoreAnelloElevatoreRic And DeflettoreRiciclatoFcElevatore And Not DeflettoreRiciclatoFcAnello) Then
                For indice = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
                    .items(PLCTAG_AO_SetRiciclato1 + (indice * spread)).Value = 0
                Next indice
            '20161213
            ElseIf ListaMotori(MotoreNastroRapJolly).ritorno Then
                'NumeroPredosatoriNastroC (NastriPredosatori.RiciclatoJolly)
                For indice = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1 - NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly)
                    .items(PLCTAG_AO_SetRiciclato1 + (indice * spread)).Value = 0
                Next indice
            '
                        
            Else
                For indice = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1
                    .items(PLCTAG_AO_SetRiciclato1 + (indice * spread)).Value = 0
                Next indice
            End If
'
        End If

        '   Motori
        .items(PLCTAG_AO_SetMotore05).Value = ListaMotori(MotoreMescolatore).uscitaAnalogica / 100 * 27648
        .items(PLCTAG_AO_SetMotore07).Value = ListaMotori(MotoreVaglio).uscitaAnalogica / 100 * 27648
        .items(PLCTAG_AO_SetMotore08).Value = ListaMotori(MotoreElevatoreCaldo).uscitaAnalogica / 100 * 27648
        .items(PLCTAG_AO_SetMotore17).Value = ListaMotori(MotoreRotazioneEssiccatore).uscitaAnalogica / 100 * 27648
        '
        .items(PLCTAG_AO_SetMotore39).Value = ListaMotori(MotoreRotazioneEssiccatore2).uscitaAnalogica / 100 * 27648

        .items(PLCTAG_AO_SetMotore46).Value = ListaMotori(MotoreFillerizzazioneFiltroRecupero).uscitaAnalogica / 100 * 27648
        .items(PLCTAG_AO_SetMotore47).Value = ListaMotori(MotoreFillerizzazioneFiltroApporto).uscitaAnalogica / 100 * 27648
    
        If (Pcl1Inverter And Not SelezioneCircuitoBitume2) Then
            .items(PLCTAG_AO_SetPredosatore16).Value = 27648 / 100 * SetPcl1
        ElseIf (Pcl2Inverter And SelezioneCircuitoBitume2) Then
            .items(PLCTAG_AO_SetPredosatore16).Value = 27648 / 100 * SetPcl2
        End If

'20160419
        '20161221
        'If Not CP240.AdoDosaggioScarico.Recordset.EOF And GetIdDosaggioLogFromIdDosaggio(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value) <> MemIdDosaggioLogScarico Then '20160419
        If (Not CP240.AdoDosaggioScarico.Recordset.EOF) Then
            If (GetIdDosaggioLogFromIdDosaggio(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value) <> MemIdDosaggioLogScarico) Then
        '
                .items(PLCTAG_SILI_HMI_Id_Ricetta_Mixer).Value = GetIdDosaggioLogFromIdDosaggio(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value)
                MemIdDosaggioLogScarico = GetIdDosaggioLogFromIdDosaggio(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value) '20160419
            End If
        End If

        If MemDestinazioneSiloPrenotata <> DestinazioneSiloPrenotata Then
            .items(PLCTAG_SILI_HMI_Dest_Silo_Prenotata).Value = SiloVBToPlc(DestinazioneSiloPrenotata)
            MemDestinazioneSiloPrenotata = DestinazioneSiloPrenotata
        End If

        If PesaturaManuale Then
            CP240.OPCData.items(PLCTAG_SILI_HMI_ImpastoNetto_Ton).Value = TotaleKgMescImpastoMan / CDbl(1000) '20151130    NUOVA GESTIONE SILI DEPOSITO
        Else
            CP240.OPCData.items(PLCTAG_SILI_HMI_ImpastoNetto_Ton).Value = TotaleProdotto / CDbl(1000) '20151130    NUOVA GESTIONE SILI DEPOSITO
        End If
'

        Call InviaParaPesaCamion  '20151103
    End With

'20160915
''20160729
'    If Not ScriviTagAquablackOnce And InclusioneAquablack Then
'        Call ParaAquablack_Scrivi
'    End If
''
'

    Exit Sub
Errore:
    LogInserisci True, "NET-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PlcInAnalogici()

    Dim indice As Integer
    Dim valoreInt As Integer
    Dim valoreLong As Long
    Dim valoreDouble As Double
    Dim posizioneErrore As Integer


    On Error GoTo Errore

    With CP240.OPCData

        If (.items.count = 0) Then
            Exit Sub
        End If
    
        posizioneErrore = 1
    
        '20161107
        If (Not PlcSimulation And BilanciaAggregati.ProfiNet) Or (BilanciaAggregati.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI) And PlcSimulation) Then
            valoreDouble = .items(PLCTAG_BIL_PNET_Aggregati_PesoKg).Value
            If (DoubleModificato(BilanciaAggregati.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                Call BilAgg_change
            End If
        Else
            valoreInt = .items(PLCTAG_AI_BilanciaAggregati).Value
            If (DoubleModificato(BilanciaAggregati.Peso, CDbl(BilanciaAggregati.FondoScala / 27648) * CDbl(valoreInt), plcInAnalogici_Fatta)) Then
                Call BilAgg_change
            End If
        End If
        '
                
        '20161107
        If (Not PlcSimulation And BilanciaFiller.ProfiNet) Or (BilanciaFiller.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER) And PlcSimulation) Then
            valoreDouble = .items(PLCTAG_BIL_PNET_Filler_PesoKg).Value
            If (DoubleModificato(BilanciaFiller.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                Call BilFiller_change
            End If
        Else
            valoreInt = .items(PLCTAG_AI_BilanciaFiller).Value
            If (DoubleModificato(BilanciaFiller.Peso, CDbl(BilanciaFiller.FondoScala / 27648) * CDbl(valoreInt), plcInAnalogici_Fatta)) Then
                Call BilFiller_change
            End If
        End If
        '
                
        '20161107
        If (Not PlcSimulation And BilanciaLegante.ProfiNet) Or (BilanciaLegante.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME) And PlcSimulation) Then
            valoreDouble = .items(PLCTAG_BIL_PNET_Bitume_PesoKg).Value
            If (DoubleModificato(BilanciaLegante.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                Call BilBit_change
            End If
        Else
            valoreInt = .items(PLCTAG_AI_BilanciaLegante).Value
            If PlcSchiumato.Abilitazione And InclusioneBitume3 And (.items(PLCTAG_DO_ScambioB2).Value) Then
                If (DoubleModificato(BilanciaLegante.Peso, CDbl(GSetBSoft / 27648) * CDbl(valoreInt), plcInAnalogici_Fatta)) Then
                    Call BilBit_change
                End If
            Else
                If (DoubleModificato(BilanciaLegante.Peso, CDbl(BilanciaLegante.FondoScala / 27648) * CDbl(valoreInt), plcInAnalogici_Fatta)) Then
                    Call BilBit_change
                End If
            End If
        End If
        '
        
        'RAPSIWA
        If (AbilitaRAPSiwa) Then
            '20160430
            'If (DoubleModificato(BilanciaRAPSiwa.Peso, CDbl(valoreInt), plcInAnalogici_Fatta)) Then
            'valoreInt = .items(PLCTAG_SIWA4_PROCESS_VALUE2).value
            valoreLong = .items(PLCTAG_SIWA4_PROCESS_VALUE2).Value
            If (DoubleModificato(BilanciaRAPSiwa.Peso, CDbl(valoreLong), plcInAnalogici_Fatta)) Then
            '
                Call BilRAPSiwa_change
            End If
        End If

        'RAP
        If (AbilitaRAP) Then
            '20161107
            If (Not PlcSimulation And BilanciaRAP.ProfiNet) Or (BilanciaRAP.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_RICICLATO) And PlcSimulation) Then
                valoreDouble = .items(PLCTAG_BIL_PNET_Riciclato_PesoKg).Value
                If (DoubleModificato(BilanciaRAP.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                    Call BilRAP_Change
                End If
            Else
                valoreInt = .items(PLCTAG_AI_BilanciaRAP).Value
                If (DoubleModificato(BilanciaRAP.Peso, CDbl(BilanciaRAP.FondoScala / 27648) * CDbl(valoreInt), plcInAnalogici_Fatta)) Then
                    Call BilRAP_Change
                End If
            End If
            '
        End If
        
        'Additivo con contalitri in bacinella bitume
        If AdditivoBacinella.modoContalitri Then
            If (DoubleModificato(AdditivoBacinella.setKg, .items(PLCTAG_SetKgAdditivoBacinella).Value, plcInAnalogici_Fatta)) Then
                Call BilAdditivoBacCNT_change
            End If
            
            If (DoubleModificato(AdditivoBacinella.nettoKg, .items(PLCTAG_NetKgAdditivoBacinella).Value, plcInAnalogici_Fatta)) Then
                Call BilAdditivoBacCNT_change
            End If
        End If
        
        If ParallelDrum Then
            valoreInt = .items(PLCTAG_AI_TamponeRiciclato).Value
            If (DoubleModificato(BilanciaTamponeRiciclato.Peso, CDbl(BilanciaTamponeRiciclato.FondoScala / 27648) * CDbl(valoreInt), plcInAnalogici_Fatta)) Then
                Call BilTamponeRiciclato_change
            End If
        End If

        If InclusioneViatop Then
            '20161107
            If (Not PlcSimulation And BilanciaViatop.ProfiNet) Or (BilanciaViatop.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP) And PlcSimulation) Then
                valoreDouble = .items(PLCTAG_BIL_PNET_Viatop_PesoKg).Value
                If (DoubleModificato(BilanciaViatop.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                    Call BilanciaViatopPeso_change
                End If
            Else
                valoreInt = .items(PLCTAG_AI_BilanciaViatop).Value
                If (DoubleModificato(BilanciaViatop.Peso, RoundNumber((BilanciaViatop.FondoScala / 27648) * CDbl(valoreInt), 1), plcInAnalogici_Fatta)) Then
                    Call BilanciaViatopPeso_change
                End If
            End If
            '
        End If

        '20160421
        If BilanciaViatopScarMixer1.Presenza Then
            '20161107
            If (Not PlcSimulation And BilanciaViatopScarMixer1.ProfiNet) Or (BilanciaViatopScarMixer1.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP) And PlcSimulation) Then
                valoreDouble = .items(PLCTAG_BIL_PNET_Viatop_PesoKg).Value
                If (DoubleModificato(BilanciaViatopScarMixer1.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                    Call BilanciaViatopScarMixerPeso_change(0)
                End If
            Else
                valoreInt = .items(PLCTAG_DB46_ViatopScarMixer1_AI_Peso).Value
                If (DoubleModificato(BilanciaViatopScarMixer1.Peso, RoundNumber((BilanciaViatopScarMixer1.FondoScala / 27648) * CDbl(valoreInt), 1), plcInAnalogici_Fatta)) Then
                    Call BilanciaViatopScarMixerPeso_change(0)
                End If
            End If
        End If
        
        If BilanciaViatopScarMixer2.Presenza Then
            '20161107
            If (Not PlcSimulation And BilanciaViatopScarMixer2.ProfiNet) Or (BilanciaViatopScarMixer2.ProfiNet And (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2) And PlcSimulation) Then
                valoreDouble = .items(PLCTAG_BIL_PNET_Viatop2_PesoKg).Value
                If (DoubleModificato(BilanciaViatopScarMixer2.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                    Call BilanciaViatopScarMixerPeso_change(1)
                End If
            Else
                valoreInt = .items(PLCTAG_DB46_ViatopScarMixer2_AI_Peso).Value
                If (DoubleModificato(BilanciaViatopScarMixer2.Peso, RoundNumber((BilanciaViatopScarMixer2.FondoScala / 27648) * CDbl(valoreInt), 1), plcInAnalogici_Fatta)) Then
                    Call BilanciaViatopScarMixerPeso_change(1)
                End If
            End If
        End If
        '20160421
                
        '   LIVELLI TRAMOGGE
        For indice = 0 To 5
            If (((TipoLivelliA And (2 ^ indice)) = 0)) Then
                valoreInt = .items(PLCTAG_AI_TorLivAgg1 + (indice * 4)).Value
                valoreInt = ScalaturaUnitaAnalogIN(CLng(valoreInt), 100, 0)
                If (IntegerModificato(LivelloTramoggia(indice), valoreInt, plcInAnalogici_Fatta)) Then
                    Call LivelloTramoggia_change(indice)
                End If
            End If
        Next indice
        
'20161212
'        If (PesaturaRiciclatoAggregato7) Then
        If (PesaturaRiciclatoAggregato7) And ((TipoLivelliA And (2 ^ indice)) = 0) Then
'
            indice = 6
            valoreInt = .items(PLCTAG_AI_TorLivAgg7).Value
            valoreInt = ScalaturaUnitaAnalogIN(CLng(valoreInt), 100, 0)
            If (IntegerModificato(LivelloTramoggia(indice), valoreInt, plcInAnalogici_Fatta)) Then
                Call LivelloTramoggia_change(indice)
            End If
        End If
        '
        indice = 7
        If (((TipoLivelliA And (2 ^ indice)) = 0)) Then
            valoreInt = .items(PLCTAG_AI_TorLivAggNV).Value
            valoreInt = ScalaturaUnitaAnalogIN(CLng(valoreInt), 100, 0)
            If (IntegerModificato(LivelloTramoggia(indice), valoreInt, plcInAnalogici_Fatta)) Then
                Call LivelloTramoggia_change(indice)
            End If
        End If
        
        If (Not ParallelDrum) Then
            indice = 18
            valoreInt = .items(PLCTAG_AI_LivTramogTampRic).Value
            valoreInt = ScalaturaUnitaAnalogIN(CLng(valoreInt), 100, 0)
            If (IntegerModificato(LivelloTramoggia(indice), valoreInt, plcInAnalogici_Fatta)) Then
                Call LivelloTramoggia_change(indice)
            End If
        End If

        If (InclusioneAriaFredda) Then
            If (PosizioneModulatoreAriaFreddaDigitale) Then
                'Lavora da sempre con fine corsa normalmente chiusi
                If (Not .items(PLCTAG_DI_FiltApModAriaFr).Value) Then
                    valoreLong = 100
                ElseIf (Not .items(PLCTAG_DI_FiltChModAriaFr).Value) Then
                    valoreLong = 0
                Else
                    valoreLong = 50
                End If
            Else
                valoreInt = .items(PLCTAG_AI_FiltPosModAriaFr).Value
                valoreLong = NormalizzazioneA100(CDbl(100 / 27648) * CDbl(valoreInt), 100, 0, MassimoAriaFredda, MinimoAriaFredda)
            End If
            If (LongModificato(PosizioneModulatoreAriaFredda, valoreLong, plcInAnalogici_Fatta)) Then
                Call PosizioneModulatoreAriaFredda_change
            End If
        End If

        posizioneErrore = 2
    
        '   Amperometri
        'Con la nuova gestione la scalatura viene fatta al PLC: per la visualizzazione si mappa una ListaAmperometriPLC comoda come interfaccia verso il PLC
        'con la vecchia lista ListaAmperometri che serve per visualizzare i valori nel Sinottico
        Dim spread As Integer
        For indice = 0 To MAXAMPEROMETRI - 1
            'Primo amperometro di ogni motore
            If (indice < MAXNEWMOTORS) Then
                spread = PLCTAG_NM_MOTORE2_Amperometri_ValScal - PLCTAG_NM_MOTORE1_Amperometri_ValScal
                '20160412
                'If (ListaAmperometri(indice).inclusione) Then
                '    If IntegerModificato(ListaAmperometri(indice).valore, .items(PLCTAG_NM_MOTORE1_Amperometri_ValScal + (spread * indice)).Value, plcInAnalogici_Fatta) Then
                '        Call ValoreAmperometri_change(indice)
                '    End If
                'End If
                valoreInt = .items(PLCTAG_NM_MOTORE1_Amperometri_ValScal + (spread * indice)).Value
                '
            'Secondi,Terzi,Quarti Amperometri
            Else
                spread = PLCTAG_NM_MOTORE_AmperometrAux2_ValScal - PLCTAG_NM_MOTORE_AmperometrAux1_ValScal
                '20160412
                'If (ListaAmperometri(indice).inclusione) Then
                '    If IntegerModificato(ListaAmperometri(indice).valore, .items(PLCTAG_NM_MOTORE_AmperometrAux1_ValScal + (spread * (indice - MAXNEWMOTORS))).Value, plcInAnalogici_Fatta) Then
                '        Call ValoreAmperometri_change(indice)
                '    End If
                'End If
                valoreInt = .items(PLCTAG_NM_MOTORE_AmperometrAux1_ValScal + (spread * (indice - MAXNEWMOTORS))).Value
                '
            End If

            '20160412
            If (ListaAmperometri(indice).Inclusione) Then
                If (ListaAmperometri(indice).filtroIncluso) Then
                    valoreInt = FiltroAmperometro(indice, valoreInt)
                End If
                If IntegerModificato(ListaAmperometri(indice).valore, valoreInt, plcInAnalogici_Fatta) Then
                    Call ValoreAmperometri_change(indice)
                End If
            End If
            '
        Next indice

        '   Temperatura ENTRATA FILTRO.
        valoreLong = CLng(.items(PLCTAG_AI_FiltTempEntrata).Value)
        If (ConversioneTemperatura(valoreLong, TempEntrataFiltro, plcInAnalogici_Fatta)) Then
            Call TempEntrataFiltro_change
        End If
    
        '   Temperatura USCITA FILTRO.
        valoreLong = CLng(.items(PLCTAG_AI_FiltTempUscita).Value)
        If (ConversioneTemperatura(valoreLong, TempUscitaFiltro, plcInAnalogici_Fatta)) Then
            Call TempUscitaFiltro_change
        End If
    
        '   Pressione aria impianto
        If (AbilitaPressioneAriaImpianto) Then
            valoreDouble = RoundNumber(ScalaturaUnitaAnalogIN_Double(CDbl(.items(PLCTAG_AI_TorPressioneAria).Value), MaxScalaPressioneAriaImpianto, MinScalaPressioneAriaImpianto), 1)
            If (DoubleModificato(PressioneAriaImpianto, valoreDouble, plcInAnalogici_Fatta)) Then
                Call PressioneAriaImpianto_change
            End If
        End If
    
        '   Temperatura del legante in bacinella
        If (AbilitaTemperaturaLeganteBacinella) Then
            valoreLong = CLng(.items(PLCTAG_AI_TorTempBacinLeg).Value)
            If (ConversioneTemperatura(valoreLong, TempLeganteBacinella, plcInAnalogici_Fatta)) Then
                Call TemperaturaLegante_change(1, ListaTemperature(TempLeganteBacinella).valore)
            End If
        End If

        posizioneErrore = 3

        'Temperatura del legante 2
        valoreLong = CLng(.items(PLCTAG_AI_PompaEmulsioneTemp).Value)
        If (ConversioneTemperatura(valoreLong, TempLegante2Pompa, plcInAnalogici_Fatta)) Then
            Call TemperaturaLegante_change(5, ListaTemperature(TempLegante2Pompa).valore)
        End If
        If (ListaMotori(MotorePCL2).presente) Then
            valoreLong = CLng(.items(PLCTAG_AI_TorTempLegante2).Value)
            If (ConversioneTemperatura(valoreLong, TempLegante2Pompa, plcInAnalogici_Fatta)) Then
                Call TemperaturaLegante_change(2, ListaTemperature(TempLegante2Pompa).valore)
            End If
        End If

        'Temperatura tubo bitume 2
        If (ListaMotori(MotorePCL3).presente) Then
            valoreLong = CLng(.items(PLCTAG_AI_TorTempTuboLeg2).Value)
            If (ConversioneTemperatura(valoreLong, TempLegante3Pompa, plcInAnalogici_Fatta)) Then
                Call TemperaturaLegante_change(4, ListaTemperature(TempLegante3Pompa).valore)
            End If
        End If

        'Temperatura tubo bitume 3
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTuboLeg3).Value)
        If (ConversioneTemperatura(valoreLong, TempLegante3Tubo, plcInAnalogici_Fatta)) Then
            Call TemperaturaLegante_change(6, ListaTemperature(TempLegante3Tubo).valore)
        End If

        'Temperatura tubo del legante 1
        If (ListaMotori(MotorePCL).presente) And InclusioneTemperaturaLineaCaricoBitume Then
            valoreLong = CLng(.items(PLCTAG_AI_TorTempTuboLeg1).Value)
            If (ConversioneTemperatura(valoreLong, TempLegante1Tubo, plcInAnalogici_Fatta)) Then
                Call TemperaturaLegante_change(3, ListaTemperature(TempLegante1Tubo).valore)
            End If
        End If

        'Temperatura tubo del legante 2
        If (ListaMotori(MotorePCL2).presente) And InclusioneTemperaturaLineaCaricoBitume Then
            valoreLong = CLng(.items(PLCTAG_AI_TorTempTuboLeg2).Value)
            If (ConversioneTemperatura(valoreLong, TempLegante2Tubo, plcInAnalogici_Fatta)) Then
                Call TemperaturaLegante_change(4, ListaTemperature(TempLegante2Tubo).valore)
            End If
        End If

        'Temperatura tubo del legante 3
        If (ListaMotori(MotorePCL3).presente) And (InclusioneTemperaturaLineaCaricoBitume And PlcSchiumato.Abilitazione) Then
            If CP240.OPCDataSchiumato.IsConnected Then
                valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(CP240.OPCDataSchiumato.items(ValoreAnalogico15_idx).Value), CLng(PlcSchiumato.HiTempOlio), CLng(PlcSchiumato.LoTempOlio)))
                If (LongModificato(ListaTemperature(TempLegante3Tubo).valore, valoreInt, plcInAnalogici_Fatta)) Then
                    Call TemperaturaLegante_change(6, ListaTemperature(TempLegante3Tubo).valore)
                End If
            End If
        End If

        'Temperatura PCL4
        If (ListaMotori(MotorePompaEmulsione).presente) Then
            valoreLong = CLng(.items(PLCTAG_AI_PompaEmulsioneTemp).Value)
            If (ConversioneTemperatura(valoreLong, TempLegante4Pompa, plcInAnalogici_Fatta)) Then
                Call TemperaturaLegante_change(7, ListaTemperature(TempLegante4Pompa).valore)
            End If
        End If

        'Temperatura tubo PCL4
        If (ListaMotori(MotorePompaEmulsione).presente And InclusioneTemperaturaLineaCaricoBitume) Then
            'valoreLong = CLng(.Items(PLCTAG_AI_TorTempTuboEmulsione).value)
            'If (ConversioneTemperatura(valoreLong, TempLegante4Tubo, PlcInAnalogici_Fatta)) Then
            '    Call TemperaturaLegante_change(8, ListaTemperature(TempLegante4Tubo).valore)
            'End If
        End If

        If (AbilitaModulatoreDeflettoreAnello) Then
            valoreInt = .items(PLCTAG_AI_BrucModRic).Value
            valoreInt = NormalizzazioneA100(CDbl(100 / 27648) * CDbl(valoreInt), 100, 0, MassimoModulatoreRAP, MinimoModulatoreRAP)
            If (IntegerModificato(PosizioneModulatoreDeflettoreAnello, valoreInt, plcInAnalogici_Fatta)) Then
                Call PosizioneModulatoreDeflettoreAnello_change
            End If
            Call VerificaNastroDeflettoreAnello
        End If
    
        If (AbilitaTemperaturaMixer) Then
            '   Temperatura SOTTO MESCOLATORE.
            valoreLong = CLng(.items(PLCTAG_AI_MixTempscarico).Value)
            If (ConversioneTemperatura(valoreLong, TempSottoMescolatore, plcInAnalogici_Fatta)) Then
                Call TempSottoMesc_change
            End If
        End If

        posizioneErrore = 4

        If (AbilitaTemperaturaSilo) Then
            'CONTROLLO TEMPERATURA SILO

            'La lettura va fatta sempre e non solo sul change, perche' se sto scaricando un silo e la temperatura non cambia,
            'allo scarico successivo di questo stesso silo la temperatura memorizzata nello storico varra' 0
'20151215
'            valoreLong = CLng(.items(PLCTAG_AI_TempSilo01).Value)
            valoreLong = CLng(.items(PLCTAG_SILI_HMI_Temperature_Piro1).Value)
            ListaTemperature(TempSilo0).valore = valoreLong
'            Call ConversioneTemperatura(valoreLong, TempSilo0, plcInAnalogici_Fatta)
            Call ValoreTempSilo_change(0, ListaTemperature(TempSilo0).valore)
        
'20151215
'            valoreLong = CLng(.items(PLCTAG_AI_TempSilo02).Value)
            valoreLong = CLng(.items(PLCTAG_SILI_HMI_Temperature_Piro2).Value)
            ListaTemperature(TempSilo1).valore = valoreLong
'            Call ConversioneTemperatura(valoreLong, TempSilo1, plcInAnalogici_Fatta)
            Call ValoreTempSilo_change(1, ListaTemperature(TempSilo1).valore)
            
'20151215
'            valoreLong = CLng(.items(PLCTAG_AI_TempSilo03).Value)
            valoreLong = CLng(.items(PLCTAG_SILI_HMI_Temperature_Piro3).Value)
            ListaTemperature(TempSilo2).valore = valoreLong
'            Call ConversioneTemperatura(valoreLong, TempSilo2, plcInAnalogici_Fatta)
            Call ValoreTempSilo_change(2, ListaTemperature(TempSilo2).valore)
        
'20151215
'            valoreLong = CLng(.items(PLCTAG_AI_TempSilo04).Value)
            valoreLong = CLng(.items(PLCTAG_SILI_HMI_Temperature_Piro4).Value)
            ListaTemperature(TempSilo3).valore = valoreLong
'            Call ConversioneTemperatura(valoreLong, TempSilo3, plcInAnalogici_Fatta)
            Call ValoreTempSilo_change(3, ListaTemperature(TempSilo3).valore)
        
'20151215
'            valoreLong = CLng(.items(PLCTAG_AI_TempSilo05).Value)
            valoreLong = CLng(.items(PLCTAG_SILI_HMI_Temperature_Piro5).Value)
            ListaTemperature(TempSilo4).valore = valoreLong
'            Call ConversioneTemperatura(valoreLong, TempSilo4, plcInAnalogici_Fatta)
            Call ValoreTempSilo_change(4, ListaTemperature(TempSilo4).valore)
            '
        End If


        If (AbilitaLetturaSiliDeposito) Then
            If (RinfrescoLetturaSiliDeposito) Then
                'sul fronte di riabilitazione lettura rinfreso i dati da leggere una volta
                plcInAnalogici_Fatta = False
            End If
'            '   Peso Silo 1.
'            valoredouble = RoundNumber(ScalaturaUnitaAnalogIN_Double(CLng(.items(PLCTAG_AI_PesoSilo01).Value), CLng(FondoScalaPesoSilo), 0), 1)
'            If (DoubleModificato(CelleSiloValoreLetto(0), valoredouble, plcInAnalogici_Fatta)) Then
'                Call CelleSiloValoreLetto_change(0)
'            End If
'            '   Peso Silo 2.
'            valoredouble = RoundNumber(ScalaturaUnitaAnalogIN_Double(CLng(.items(PLCTAG_AI_PesoSilo02).Value), CLng(FondoScalaPesoSilo), 0), 1)
'            If (DoubleModificato(CelleSiloValoreLetto(1), valoredouble, plcInAnalogici_Fatta)) Then
'                Call CelleSiloValoreLetto_change(1)
'            End If
           Dim i As Integer

            'CELLE DI CARICO
            If (AbilitaCelleCaricoSilo And NumeroVisPesoSili > 0) Then
                For i = 1 To 4
                    'ottengo il peso in tonnellate
                    valoreDouble = CDbl(.items(PLCTAG_SILI_HMI_PesoCella_1 + (i - 1)).Value)
                   If (DoubleModificato(CelleSiloValoreLetto(i), valoreDouble, plcInAnalogici_Fatta)) Then
                        'lettura tara
                        valoreDouble = CDbl(.items(PLCTAG_SILI_HMI_TaraCella_1 + (i - 1)).Value)
                        If DoubleModificato(CelleSiloDetrarreTara(i), valoreDouble, plcInAnalogici_Fatta) Then
                            
                        End If
                        Call CelleSiloValoreLetto_change(i)
                         'Tengo aggiornata la Tara memorizzata su File
                        Call CelleSiloScriviTXT(i - 1)
                        Call PesoCamion_change '20170221
                    End If
                Next i
            End If
            'FINE
            'PESO CAMION
            valoreDouble = CDbl(.items(PLCTAG_SILI_HMI_PesoCamion).Value)
            If (DoubleModificato(BilanciaPesaCamion.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
               Call PesoCamion_change
               Call CelleSiloScriviTXTCamion
            End If
            'FINE
            'SCOMPARTI
            For i = 0 To SILI_MAXPLC
                Dim j As Integer
                j = ScompartiCompattaSalta(i)
                If (j >= 0) Then
                    'ottengo il peso in tonnellate
                    valoreDouble = .items(PLCTAG_SILI_HMI_Peso_0 + j).Value
                    If (DoubleModificato(ListaSili(ScompartiSiliPLC_a_PC(i)).Peso, valoreDouble, plcInAnalogici_Fatta)) Then
                        Call AggiornaPesoSilo(ScompartiSiliPLC_a_PC(i))
                        'scrittura su file
                        If (AbilitaCelleCaricoSilo) Then
                            'celle
                            If ((CInt(.items(PLCTAG_SILI_PAR_AppScomparto_0 + j).Value) >= 1) And (CInt(.items(PLCTAG_SILI_PAR_AppScomparto_0 + j).Value) <= 4)) Then
                                Call CelleSiloScriviTXT(CInt(.items(PLCTAG_SILI_PAR_AppScomparto_0 + j).Value) - 1)
                            Else
                                'silo a lato (appartenenza Scomparto->Silo =0)
                                Call SiloScriviTXTSenzaCelle(i)
                            End If
                        Else
                            'no celle
                            Call SiloScriviTXTSenzaCelle(i)
                        End If
                    End If
                End If
            Next i
    
                If (RinfrescoLetturaSiliDeposito) Then
                    plcInAnalogici_Fatta = True
                    RinfrescoLetturaSiliDeposito = False
                End If
            End If
         'FINE
        'End If
    
        If (LivelliFillerContinui) Then
            'livello continuo filler1
            valoreLong = ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_SiloFilLiv01).Value), 100, 0)
            If (LongModificato(ValoreLivelloSiloFiller(0), valoreLong, plcInAnalogici_Fatta)) Then
                Call ValoreLivelloSiloFiller_change(0)
            End If
'20150624
'            If (GestioneFiller2 = 1 Or GestioneFiller2 = 2) Then
            If (GestioneFiller2 = FillerIncluso) Or (GestioneFiller2 = FillerSoloVisSilo) Then
'
                'livello continuo filler2
                valoreLong = ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_SiloFilLiv02).Value), 100, 0)
                If (LongModificato(ValoreLivelloSiloFiller(1), valoreLong, plcInAnalogici_Fatta)) Then
                    Call ValoreLivelloSiloFiller_change(1)
                End If
            End If
            
'20151030
''20150708
''            If InclusioneF3 Then
'            If InclusioneF3 Or (GestioneFiller3 = FillerSoloVisSilo) Then
            If (GestioneFiller3 = FillerIncluso) Or (GestioneFiller3 = FillerSoloVisSilo) Then
'
                'livello continuo filler3
                valoreLong = ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_SiloFilLiv03).Value), 100, 0)
                If (LongModificato(ValoreLivelloSiloFiller(2), valoreLong, plcInAnalogici_Fatta)) Then
                    Call ValoreLivelloSiloFiller_change(2)
                End If
            End If
        End If

        '20151228
        If (LivelliContinuiCameraEspansioneFillerRecupero) Then
            '20160105
            Dim livelloDmrModificato As Boolean
            'Dim AllarmeLivelliContinuiCameraEspansioneFillerRecupero As Boolean

            valoreLong = ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_FiltroDMR_Liv_SX).Value), 100, 0)
            If (LongModificato(ValoreLivelloContCameraEspFilRec_SX, valoreLong, plcInAnalogici_Fatta)) Then
                livelloDmrModificato = True
                'If ValoreLivelloContCameraEspFilRec_SX > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme Then
                '    AllarmeLivelliContinuiCameraEspansioneFillerRecupero = True
                'End If
                'Call GestioneLivelliFiltroDMR
            End If

            valoreLong = ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_FiltroDMR_Liv_CE).Value), 100, 0)
            If (LongModificato(ValoreLivelloContCameraEspFilRec_CE, valoreLong, plcInAnalogici_Fatta)) Then
                livelloDmrModificato = True
                'If ValoreLivelloContCameraEspFilRec_CE > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme Then
                '    AllarmeLivelliContinuiCameraEspansioneFillerRecupero = True
                'End If
                'Call GestioneLivelliFiltroDMR
            End If

            valoreLong = ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_FiltroDMR_Liv_DX).Value), 100, 0)
            If (LongModificato(ValoreLivelloContCameraEspFilRec_DX, valoreLong, plcInAnalogici_Fatta)) Then
                livelloDmrModificato = True
                'If ValoreLivelloContCameraEspFilRec_DX > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme Then
                '    AllarmeLivelliContinuiCameraEspansioneFillerRecupero = True
                'End If
                'Call GestioneLivelliFiltroDMR
            End If

            'If Not (AllarmeLivelliContinuiCameraEspansioneFillerRecupero) Then
            '    Call AllarmeTemporaneo("VA003", False)
            'End If

            Call TemporizzatoreStandard(1, 5, PersistAllMaxFiltroLivContinui(1).AppTempo, PersistAllMaxFiltroLivContinui(1).TempoExec, _
                LivelloMaxCameraEspansioneFillerRecupero, (ValoreLivelloContCameraEspFilRec_SX > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme), _
                PersistAllMaxFiltroLivContinui(1).ErrTimer)
            Call TemporizzatoreStandard(1, 5, PersistAllMaxFiltroLivContinui(2).AppTempo, PersistAllMaxFiltroLivContinui(2).TempoExec, _
                LivelloMax2CameraEspansioneFillerRecupero, (ValoreLivelloContCameraEspFilRec_DX > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme), _
                PersistAllMaxFiltroLivContinui(2).ErrTimer)
            Call TemporizzatoreStandard(1, 5, PersistAllMaxFiltroLivContinui(3).AppTempo, PersistAllMaxFiltroLivContinui(3).TempoExec, _
                LivelloMax3CameraEspansioneFillerRecupero, (ValoreLivelloContCameraEspFilRec_CE > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme), _
                PersistAllMaxFiltroLivContinui(3).ErrTimer)

'            LivelloMaxCameraEspansioneFillerRecupero = (ValoreLivelloContCameraEspFilRec_SX > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme)
'            LivelloMax2CameraEspansioneFillerRecupero = (ValoreLivelloContCameraEspFilRec_DX > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme)
'            LivelloMax3CameraEspansioneFillerRecupero = (ValoreLivelloContCameraEspFilRec_CE > LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme)

            If (livelloDmrModificato) Then
                If ( _
                    ValoreLivelloContCameraEspFilRec_SX <= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme Or _
                    ValoreLivelloContCameraEspFilRec_CE <= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme Or _
                    ValoreLivelloContCameraEspFilRec_DX <= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme _
                ) Then
                    Call AllarmeTemporaneo("VA003", False)
                End If

                Call GestioneLivelliFiltroDMR
            End If
            '

        End If
        '20151228

        '   Temperatura TERMOCOPPIA SCIVOLO
        If (AbilitaSondaAggiuntivaUscitaTamburo) Then
            'Seconda sonda di temperatura montata sullo scivolo
            '(era un ingresso termocoppia ma adesso non è più gestito come ingresso particolare)
            valoreLong = CLng(.items(PLCTAG_AI_BrucTempTermocoppiaUscita).Value)
            If (ConversioneTemperatura(valoreLong, TempTamburoUscita, plcInAnalogici_Fatta)) Then
                Call TempSondaAggiuntivaUscitaTamburo_change
            End If
        End If

        If AbilitaTemperaturaIngressoTamburo Then
            valoreLong = CLng(.items(PLCTAG_AI_BrucTempIngressoTamburo).Value)
            If (ConversioneTemperatura(valoreLong, TempTamburoIngresso, plcInAnalogici_Fatta)) Then
                Call TempIngressoTamburo_change
            End If
        End If

        '   Temperatura torre 0 (A6 o tramoggione 1)
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre2_Sabbia).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre0, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(0, ListaTemperature(TempTorre0).valore)
        End If
        '20161128
        If (GestioneFumiTamburo.Inclusione) Then
            valoreLong = CLng(.items(PLCTAG_GEST_FUMI_TAMB_Modulatore).Value)
            If (LongModificato(GestioneFumiTamburo.Modulatore.posizione, valoreLong, plcInAnalogici_Gestfumitamb_Fatta)) Then
                Call CP240.AnalogicheGestioneFumiTamburo(GestioneFumiTamburo.Modulatore.posizione, GestioneFumiTamburo.Depressione_vaglio)
            End If
            
            valoreLong = CLng(.items(PLCTAG_GEST_FUMI_TAMB_Depr_Vaglio).Value)
            If (LongModificato(GestioneFumiTamburo.Depressione_vaglio, valoreLong, plcInAnalogici_Gestfumitamb_Fatta)) Then
                Call CP240.AnalogicheGestioneFumiTamburo(GestioneFumiTamburo.Modulatore.posizione, GestioneFumiTamburo.Depressione_vaglio)
            End If
            plcInAnalogici_Gestfumitamb_Fatta = True
        End If
        '20161128

        '201611230
        If (GestioneVelocitaTamburo.Inclusione) Then
            valoreLong = CLng(.items(PLCTAG_GEST_VEL_TAMB_Modulatore).Value)
            If (LongModificato(GestioneVelocitaTamburo.Modulatore.posizione, valoreLong, plcInAnalogici_Gestveltamb_Fatta)) Then
                Call CP240.AnalogicheGestioneVelTamburo(GestioneVelocitaTamburo.Modulatore.posizione)
            End If
            plcInAnalogici_Gestveltamb_Fatta = True
        End If
        '201611230
        posizioneErrore = 5

        '   Temperatura torre 1 (N.V. o tramoggione 2)
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre1_NV).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre1, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(1, ListaTemperature(TempTorre1).valore)
        End If
    
        '   Temperatura torre 2 (tramoggione 3 oppure A5)
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre3).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre2, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(2, ListaTemperature(TempTorre2).valore)
        End If
        
         '   Temperatura torre 3
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre4).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre3, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(3, ListaTemperature(TempTorre3).valore)
        End If
         '   Temperatura torre 4
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre5).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre4, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(4, ListaTemperature(TempTorre4).valore)
        End If
         '   Temperatura torre 5
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre6).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre5, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(5, ListaTemperature(TempTorre5).valore)
        End If
         '   Temperatura torre 6
        valoreLong = CLng(.items(PLCTAG_AI_TorTempTorre7).Value)
        If (ConversioneTemperatura(valoreLong, TempTorre6, plcInAnalogici_Fatta)) Then
            Call TempTorre_change(6, ListaTemperature(TempTorre6).valore)
        End If
        '
        '   Temperatura LEGANTE.
        valoreLong = CLng(.items(PLCTAG_AI_TorTempLegante).Value)
        If (ConversioneTemperatura(valoreLong, TempLegante1Pompa, plcInAnalogici_Fatta)) Then
            Call TemperaturaLegante_change(0, ListaTemperature(TempLegante1Pompa).valore)
        End If
    
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Faccio una coda di 30 letture e faccio sempre la media per la :
        'Temperatura Scivolo 1
        'Depressione Bruciatore 1
        'Temperatura Scivolo 2
        'Depressione Bruciatore 2

        '   Temperatura SCIVOLO.
        Call LetturaScivoloTamburo(0, CLng(.items(PLCTAG_AI_BrucTempscivolo).Value), plcInAnalogici_Fatta)

        '   DEPRESSIONE BRUCIATORE.
        Call LetturaDepressioneBruciatore(0, CLng(.items(PLCTAG_AI_BrucDepressione).Value), plcInAnalogici_Fatta)

        If (ParallelDrum) Then

            '   Temperatura SCIVOLO.
            Call LetturaScivoloTamburo(1, CLng(.items(PLCTAG_AI_TempScivoloTamburo2).Value), plcInAnalogici_Fatta)

            '   DEPRESSIONE BRUCIATORE.
            Call LetturaDepressioneBruciatore(1, CLng(.items(PLCTAG_AI_DepressioneBruciatore2).Value), plcInAnalogici_Fatta)

            'Modulatore Fumi Bruciatore 1
            valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_ModulatoreFumiTamburo1).Value), 100, 0))
            If (IntegerModificato(ListaTamburi(0).ValoreLettoModulatoreFumiTamburoNN, valoreInt, plcInAnalogici_Fatta)) Then
                Call ModulatoreFumiTamburo_change(0)
            End If
            
            'Modulatore Fumi Bruciatore 2
            valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_ModulatoreFumiTamburo2).Value), 100, 0))
            If (IntegerModificato(ListaTamburi(1).ValoreLettoModulatoreFumiTamburoNN, valoreInt, plcInAnalogici_Fatta)) Then
               Call ModulatoreFumiTamburo_change(1)
            End If

            'Temperatura dei fumi all'uscita del tamburo2
            valoreLong = CLng(.items(PLCTAG_AI_Temp_Fumi_Out_Tamb2).Value)
            If (ConversioneTemperatura(valoreLong, TempFumiTamburo2, plcInAnalogici_Fatta)) Then
                Call TempFumiTamburo_change(1)
            End If

            'DEPRESSIONE FILTRO (ALL'INGRESSO)
            
            NumeroLetturaDepressioneFiltroIN = NumeroLetturaDepressioneFiltroIN + 1
            If NumeroLettureDepressione < 1 Or NumeroLettureDepressione > 10 Then
                NumeroLettureDepressione = 5
            End If
            If NumeroLetturaDepressioneFiltroIN > NumeroLettureDepressione * 3 Then
                NumeroLetturaDepressioneFiltroIN = 1
            End If
'            ArrayLettureDepressioneFiltroIN(NumeroLetturaDepressioneFiltroIN) = CInt(ScalaturaUnitaAnalogIN(CLng(.Items(PLCTAG_AI_Depress_Ingresso_Filt).value), 30, 0))
            ArrayLettureDepressioneFiltroIN(NumeroLetturaDepressioneFiltroIN) = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_Depress_Ingresso_Filt).Value), CLng(MassimoFSDeprimometroFiltroIN), 0))
'
            valoreInt = 0
            For indice = 1 To NumeroLettureDepressione * 3
                valoreInt = valoreInt + ArrayLettureDepressioneFiltroIN(indice)
            Next indice
            valoreInt = CInt(valoreInt / (NumeroLettureDepressione * 3))
            If (IntegerModificato(DepressioneFiltroIN, valoreInt, plcInAnalogici_Fatta)) Then
                Call DepressioneFiltroIN_change
            End If
'
                
        End If
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        If (AbilitaControlloPressostatoFiltro) Then
            'DEPRESSIONE FILTRO (DIFFERENZIALE IN-OUT)
            valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_FiltDepressione).Value), CInt(FondoscalaDeltaDepressione), 0))
            If (IntegerModificato(DepressioneFiltro, valoreInt, plcInAnalogici_Fatta)) Then
                Call DepressioneFiltro_change
            End If
        End If

        Call PesoNastroRiciclato
        Call PesoNastroRiciclatoParDrum
        Call PesoNastroInerti

        posizioneErrore = 6

        'LETTURA DEL MODULATORE BRUCIATORE
        '20170324
        'valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_BrucPosModulatore).Value), 100, 0))
        ListaTamburi(0).posizioneModulatoreBruciatoreNNPrecisa = CDbl(ScalaturaUnitaAnalogIN_Double(CDbl(.items(PLCTAG_AI_BrucPosModulatore).Value), 100#, 0#))
        valoreInt = Round(ListaTamburi(0).posizioneModulatoreBruciatoreNNPrecisa, 0)
        '
        If (IntegerModificato(ListaTamburi(0).posizioneModulatoreBruciatoreNN, valoreInt, plcInAnalogici_Fatta)) Then
            Call ModulatoreBruciatore_change(0)
        End If

        If (ParallelDrum) Then
            valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_ModulatoreBruciatore2).Value), 100, 0))
            If (IntegerModificato(ListaTamburi(1).posizioneModulatoreBruciatoreNN, valoreInt, plcInAnalogici_Fatta)) Then
                Call ModulatoreBruciatore_change(1)
            End If
        End If
        '

        'LETTURA DEL MODULATORE ASPIRATORE FILTRO.
        valoreInt = CInt(ScalaturaUnitaAnalogIN(CLng(.items(PLCTAG_AI_FiltPosModulatore).Value), 100, 0))
        If (IntegerModificato(ValoreLettoModulatoreAspFiltroNN, valoreInt, plcInAnalogici_Fatta)) Then
            Call ModulatoreAspFiltro_change
        End If

        'Visualizzazione Temperatura Combustibile
        valoreLong = CLng(.items(PLCTAG_AI_TempScambiatBruc1).Value)
        If (ConversioneTemperatura(valoreLong, TempScambComb, plcInAnalogici_Fatta)) Then
            Call TempScambComb_change
        End If

'20151201
        
        valoreInt = CInt(.items(PLCTAG_PesaCamionValAnalogico).Value)
        If (IntegerModificato(BilanciaPesaCamion.ValoreAnalogico, valoreInt, PlcInDigitali_Fatta)) Then
            Call AggiornaAnalogicaPesaCamion_change
        End If
'
'20160215
        Dim nrsilo As Integer
        Dim idresult As String
        For i = 0 To 21
            valoreDouble = .items(PLCTAG_SILI_HMI_Storico_IdMateriale0 + (i)).Value
            nrsilo = PlcToSiloVB(i)
            If nrsilo > 0 Then
                idresult = CStr(.items(PLCTAG_SILI_HMI_Storico_IdMateriale0 + (i)).Value)
                If (ListaSili(nrsilo).idMateriale <> idresult) Then
                    Call CheckContenutoSili
                End If
            End If
        Next i
'

        '20161213
        If ( _
            DosaggioAggregati(0).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato1).Value) Or _
            DosaggioAggregati(1).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato2).Value) Or _
            DosaggioAggregati(2).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato3).Value) Or _
            DosaggioAggregati(3).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato4).Value) Or _
            DosaggioAggregati(4).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato5).Value) Or _
            DosaggioAggregati(5).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato6).Value) Or _
            DosaggioAggregati(6).setCalcolato <> CDbl(.items(PLCTAG_SetAggregato7).Value) Or _
            DosaggioAggregati(7).setCalcolato <> CDbl(.items(PLCTAG_SetNV).Value) Or _
            DosaggioFiller(0).setCalcolato <> CDbl(.items(PLCTAG_SetFiller1).Value) Or _
            DosaggioFiller(1).setCalcolato <> CDbl(.items(PLCTAG_SetFiller2).Value) _
        ) Then
            'Chiamata aggiuntiva visto che è stato modificato un SET qualsiasi
            Call AggiornaSetKgCP240
        End If
        '

    End With

    plcInAnalogici_Fatta = True

    Exit Sub
Errore:
    LogInserisci True, "NET-003 (" + CStr(posizioneErrore) + ")", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PlcOutDigitali()

    Dim indice As Integer
    Dim spread As Integer
    Dim SirenaPredosatori As Boolean
    Dim offsetVibratori As Integer
    Dim offsetVibratoriRic As Integer
    Dim offsetSili As Integer
    Dim offsetAUX As Integer

    On Error GoTo Errore

    With CP240.OPCData

        If (.items.count = 0) Then
            Exit Sub
        End If

        If DEMO_VERSION Then
            Exit Sub
        End If

        If PesaturaManuale Then
            'Aggregati
            For indice = 0 To 6 'il valore 6 corrisponde al rap nella bilancia aggregati
                .items(PLCTAG_DO_PesataAgg1 + indice).Value = (ManualePesaturaComponenti = indice)
            Next indice
            .items(PLCTAG_DO_PesataAggNV).Value = (ManualePesaturaComponenti = CompNonVagliato)
            .items(PLCTAG_DO_PesataAggNV2).Value = False
            .items(PLCTAG_DO_ScaricoAggregati).Value = (ManualeScaricoComponenti = ScaricoAggregati)

            'Filler
            .items(PLCTAG_DO_PesataFill1).Value = (ManualePesaturaComponenti = CompFiller1)
            .items(PLCTAG_DO_PesataFill2).Value = (ManualePesaturaComponenti = CompFiller2)
            .items(PLCTAG_DO_PesataFill3).Value = (ManualePesaturaComponenti = CompFiller3)
            If (Not .items(PLCTAG_NM_OUT_Blocca_Scar_F1).Value) Then
                .items(PLCTAG_DO_ScaricoFiller).Value = (ManualeScaricoComponenti = ScaricoFiller)
            Else
                .items(PLCTAG_DO_ScaricoFiller).Value = False
            End If
            '20150909
            If (.items(PLCTAG_DI_TermIntroFillerMix).Value) Then
                .items(PLCTAG_DO_ScaricoFiller).Value = False
            End If
            'Bitume
            If BitumeGravita Then
                .items(PLCTAG_DO_GravitaPesataB1).Value = (ManualePesaturaComponenti = CompLegante1)
                .items(PLCTAG_DO_GravitaPesataB2).Value = (ManualePesaturaComponenti = CompLegante2)
                .items(PLCTAG_DO_GravitaScarico).Value = (ManualeScaricoComponenti = ScaricoLegante)
            Else
                If Bitume2InBlending Then
                    .items(PLCTAG_DO_PesataLegante1).Value = (ManualePesaturaComponenti = CompLegante1)
                    .items(PLCTAG_DO_PesataLegante2).Value = (ManualePesaturaComponenti = CompLegante2)
                Else
                    If InclusioneBitume2 And (Not AbilitaSelettoreBitume1) And (Not InclusioneBacinella2) Then
                        .items(PLCTAG_DO_PesataLegante1).Value = (ManualePesaturaComponenti = CompLegante1) Or (ManualePesaturaComponenti = CompLegante2)
                        If InclusioneBitume3 Then
                            .items(PLCTAG_DO_PesataLegante1).Value = (ManualePesaturaComponenti = CompLeganteSoft) Or (ManualePesaturaComponenti = CompLegante1) Or (ManualePesaturaComponenti = CompLegante2)
                        End If
                    Else
                        .items(PLCTAG_DO_PesataLegante1).Value = (ManualePesaturaComponenti = CompLegante1)
                        .items(PLCTAG_DO_PesataLegante2).Value = (ManualePesaturaComponenti = CompLegante2)
                    End If
                End If
                .items(PLCTAG_DO_ScaricoLegante).Value = (ManualeScaricoComponenti = ScaricoLegante)
            End If
            'Scambio bitume1 a bitume2
            If (InclusioneBitume2 And AbilitaSelettoreBitume1) Then
                If DosaggioInCorso Then
                    .items(PLCTAG_DO_ScambioB1).Value = (ScambioBitume2 = 1)
                Else
                    .items(PLCTAG_DO_ScambioB1).Value = SelezioneCircuitoBitume2
                End If
            End If
            .items(PLCTAG_DO_ScaricoLegante).Value = (ManualeScaricoComponenti = ScaricoLegante)
            '20150923 Controllo Temperatura Bitume con Torre in Manuale
'20151106
'            If (PesaturaManuale) Then
            If (PesaturaManuale) And Not ForzaturaPCL Then
'
                If (BassaTemperaturaBitume(0)) Then
                    .items(PLCTAG_DO_PesataLegante1).Value = False
                End If
                If (BassaTemperaturaBitume(1)) Then
                    .items(PLCTAG_DO_PesataLegante2).Value = False
                End If
                 If (BassaTemperaturaBitume(2)) Then
                    .items(PLCTAG_DO_PesataLegante3).Value = False
                End If
            End If
            '20150923 Controllo Temperatura Bitume
            
            'Viatop
            'NO! Motore 27 .Items(aVentolaViatop).value = ComandoVentolaViatop

            .items(PLCTAG_DO_PesataViatop).Value = (ManualePesaturaComponenti = CompViatop)
            .items(PLCTAG_DO_ScaricoBilViatop).Value = (ManualeScaricoComponenti = ScaricoBilanciaViatop)
            .items(PLCTAG_DO_ScaricoCicloneViatop).Value = (ManualeScaricoComponenti = ScaricoCicloneViatop)
            '20160421
            .items(PLCTAG_DB57_ViatopScarMixer1_PesataMan).Value = (ManualePesaturaComponenti = CompViatopScarMixer1)
            .items(PLCTAG_DB57_ViatopScarMixer1_ScaricoMan).Value = (ManualeScaricoComponenti = ScaricoViatopScarMixer1)
            .items(PLCTAG_DB57_ViatopScarMixer1_StartCompressoreMan).Value = BilanciaViatopScarMixer1.OutCmdCompressore Or (ManualeScaricoComponenti = ScaricoViatopScarMixer1)
            .items(PLCTAG_DB58_ViatopScarMixer2_PesataMan).Value = (ManualePesaturaComponenti = CompViatopScarMixer2)
            .items(PLCTAG_DB58_ViatopScarMixer2_ScaricoMan).Value = (ManualeScaricoComponenti = ScaricoViatopScarMixer2)
            .items(PLCTAG_DB58_ViatopScarMixer2_StartCompressoreMan).Value = BilanciaViatopScarMixer2.OutCmdCompressore Or (ManualeScaricoComponenti = ScaricoViatopScarMixer2)
            '20160421
            '20160421
            .items(PLCTAG_DB57_ViatopScarMixer1_PesataMan).Value = (ManualePesaturaComponenti = CompViatopScarMixer1)
            .items(PLCTAG_DB57_ViatopScarMixer1_ScaricoMan).Value = (ManualeScaricoComponenti = ScaricoViatopScarMixer1)
            .items(PLCTAG_DB57_ViatopScarMixer1_StartCompressoreMan).Value = BilanciaViatopScarMixer1.OutCmdCompressore Or (ManualeScaricoComponenti = ScaricoViatopScarMixer1)
            .items(PLCTAG_DB58_ViatopScarMixer2_PesataMan).Value = (ManualePesaturaComponenti = CompViatopScarMixer2)
            .items(PLCTAG_DB58_ViatopScarMixer2_ScaricoMan).Value = (ManualeScaricoComponenti = ScaricoViatopScarMixer2)
            .items(PLCTAG_DB58_ViatopScarMixer2_StartCompressoreMan).Value = BilanciaViatopScarMixer2.OutCmdCompressore Or (ManualeScaricoComponenti = ScaricoViatopScarMixer2)
            '20160421            'Riciclato
            .items(PLCTAG_DO_PesataBilRiciclato).Value = (ManualePesaturaComponenti = CompRAP)
            .items(PLCTAG_DO_ScaricoBilRiciclato).Value = (ManualeScaricoComponenti = ScaricoRAP)
            .items(PLCTAG_DO_SIWA_Batch_StartPesataSemiAuto).Value = (ManualePesaturaComponenti = CompRAPSiwa)

            'Scarico Mixer
            .items(PLCTAG_DO_ScaricoMesc).Value = (ManualeScaricoComponenti = ScaricoMescolatore Or ManualeScaricoComponenti = ScaricoMescolatoreOn)
    
            'Additivi
            .items(PLCTAG_DO_PompaAddMixer).Value = ManualeAdditivi(1)
            .items(PLCTAG_DO_PompaAddLegante).Value = ManualeAdditivi(2)
            .items(PLCTAG_DO_invAddBacinella).Value = InversioneAdditivi(2)
            .items(PLCTAG_DO_ConsensoIntroSacchi).Value = ManualeAdditivi(3)
            .items(PLCTAG_DO_PompaAcquaComandoManuale).Value = ManualeAdditivi(0)

        End If

        .items(PLCTAG_CicliDaEseguire).Value = CInt(CicliDosaggioDaEseguire)
        
        .items(PLCTAG_F_WatchdogPC).Value = True
        
        .items(PLCTAG_F_AbilPortineManuali).Value = PesaturaManuale
            
        .items(PLCTAG_StopDosaggio).Value = InviaStopDosaggio
        .items(PLCTAG_Abort).Value = ArrestoUrgenza


        spread = PLCTAG_NM_CMD_SemiAuto_2 - PLCTAG_NM_CMD_SemiAuto_1

        For indice = 0 To MAXMOTORI - 1
            .items(PLCTAG_NM_CMD_SemiAuto_1 + indice).Value = ListaMotori(indice + 1).ComandoManuale
        Next indice

        .items(PLCTAG_NM_CMD_ManutenzioneMotore).Value = MotoreForzato

        '20161212
'        If (ListaMotori(MotoreNastroRapJolly).presente And Not ListaMotori(MotoreNastroRapJolly).ritorno) Then
'            'Cambio il verso del nastro solo se spento (controllo una volta di più)
'            '.items(PLCTAG_DO_InvMotore38) = NastroRapJollyVersoFreddo  '20161205
'            .items(PLCTAG_NM_CMD_InvSemiAuto_9).Value = ListaMotori(MotoreNastroRapJolly).ComandoInversione  '20161205
'            If NastroRapJollyVersoFreddo Then
'                CP240.LblEtichetta(76).caption = "Freddo"
'            Else
'                CP240.LblEtichetta(76).caption = "Caldo"
'            End If
'        End If
        .items(PLCTAG_NM_CMD_InvSemiAuto_9).Value = ListaMotori(MotoreNastroRapJolly).ComandoInversione  '20161205
        '20161212
        
        spread = PLCTAG_DO_Predosatore2 - PLCTAG_DO_Predosatore1

        '   Predosatori
        For indice = 0 To MAXPREDOSATORI - 1
            .items(PLCTAG_DO_Predosatore1 + (indice * spread)).Value = ListaPredosatori(indice).motore.uscita
            .items(PLCTAG_DO_LampadaP1 + (indice * spread)).Value = ListaPredosatori(indice).UscitaLampada
                                   
            If (ListaPredosatori(indice).motore.uscita And ListaPredosatori(indice).vuoto) Then
                SirenaPredosatori = True
            End If
        Next indice

        spread = PLCTAG_DO_Riciclato2 - PLCTAG_DO_Riciclato1

        '   Predosatori riciclato
        For indice = 0 To MAXPREDOSATORIRICICLATO - 1
            .items(PLCTAG_DO_Riciclato1 + (indice * spread)).Value = ListaPredosatoriRic(indice).motore.uscita
            .items(PLCTAG_DO_LampadaR1 + (indice * spread)).Value = ListaPredosatoriRic(indice).UscitaLampada

            If (ListaPredosatoriRic(indice).motore.uscita And ListaPredosatoriRic(indice).vuoto) Then
                SirenaPredosatori = True
            End If
        Next indice

        .items(PLCTAG_DO_SirenaPredosatoreVuoto).Value = SirenaPredosatori
        
        offsetVibratori = PLCTAG_DO_Predosatore2 - PLCTAG_DO_Predosatore1
        For indice = 0 To NumeroPredosatoriInseriti - 1
            .items(PLCTAG_DO_VibratoreP1 + indice * offsetVibratori).Value = ListaPredosatori(indice).vibratoreAbilitato
        Next indice
        
        offsetVibratoriRic = PLCTAG_DO_Riciclato2 - PLCTAG_DO_Riciclato1
        For indice = 0 To NumeroPredosatoriRicInseriti - 1
            .items(PLCTAG_DO_Vibratore_Ric1 + indice * offsetVibratoriRic).Value = ListaPredosatoriRic(indice).vibratoreAbilitato
            .items(PLCTAG_DO_SoffioAriaR1 + indice * offsetVibratoriRic).Value = ListaPredosatoriRic(indice).abilitazioneSoffio
        Next indice

        offsetAUX = PLCTAG_ComandiAux02_Uscita - PLCTAG_ComandiAux01_Uscita
        
        For indice = 0 To 29
            If ListaComandi(indice).presente Then
                .items(PLCTAG_ComandiAux00_Uscita + offsetAUX * indice).Value = ListaComandi(indice).uscita
            End If
        Next indice

        '20161214
        If (Deodorante.Inclusione) Then
            .items(PLCTAG_SILO_Deodorante_Start).Value = Deodorante.CmdStart
            .items(PLCTAG_SILO_Deodorante_Stop).Value = Deodorante.CmdStop
        End If
        '20161214
        offsetSili = PLCTAG_DO_Silo02 - PLCTAG_DO_Silo01
        For indice = 0 To MAXNUMSILI - 1
            .items(PLCTAG_DO_Silo01 + (indice * offsetSili)).Value = ((indice + 1) = DestinazioneSilo)
        Next indice
'20160503
        If (AbilitazioneSemaforoBenna) Then
            .items(PLCTAG_DB46_SemaforoBenna_CmdVerde).Value = SemaforoBenna.Comando_Verde
        End If
        If (AbilitazioneSemaforoSili) Then
            .items(PLCTAG_DB46_SemaforoSili_CmdVerde).Value = SemaforoSili.Comando_Verde
        End If
'20160503
'20150420
        If (InclusioneSiloS7) And (SiloStatusLock) Then
            .items(PLCTAG_SILOGEN_MANUALE).Value = (SiloStatus = Man)
            .items(PLCTAG_SILOGEN_AUTOMATICO).Value = (SiloStatus = Auto)
            .items(PLCTAG_DB322_AbilitaJog).Value = (SiloStatus = Jog)
            .items(PLCTAG_SILO2_AbilitaJog).Value = (SiloStatus = Jog)
            FrmGestioneTimer.TmrSyncroCmdSiloS7.enabled = True
        End If
'
        If (ValvolaPreseparatore.abilitato) Then
            'If .items(PLCTAG_DO_FiltValvPresep).Value <> ValvolaPreseparatore.uscita Then
                .items(PLCTAG_DO_FiltValvPresep).Value = ValvolaPreseparatore.uscita
            'End If
        End If

        '20150805
        If (ValvolaPreseparatoreAnello.abilitato) Then
            ' PLCTAG_DO_ValvPresepAnello             'DO_FiltValvPresepAnello
            If (.items(PLCTAG_DO_ValvPresepAnello).Value <> ValvolaPreseparatoreAnello.uscita) Then
                .items(PLCTAG_DO_ValvPresepAnello).Value = (ValvolaPreseparatoreAnello.uscita And (Not ValvolaPreseparatoreAnello.ModoAutomatico Or DeflettoreRiciclatoFcAnello))
            End If
        End If

        '20161230
        ''Modulatore Bruciatore
        'If Not ListaTamburi(0).BruciatoreAutomatico Then
        '
            .items(PLCTAG_DO_BrucChModulatore).Value = ListaTamburi(0).ModulatoreBrucOnDown
            .items(PLCTAG_DO_BrucApModulatore).Value = ListaTamburi(0).ModulatoreBrucOnUp
        'End If
        If (ParallelDrum) Then
            '20161230
            ''Modulatore Bruciatore
            'If Not ListaTamburi(1).BruciatoreAutomatico Then
            '
                .items(PLCTAG_DO_ModulatoreBruc2Chiusura).Value = ListaTamburi(1).ModulatoreBrucOnDown
                .items(PLCTAG_DO_ModulatoreBruc2Apertura).Value = ListaTamburi(1).ModulatoreBrucOnUp
            'End If
        End If
        '
        '20161128
        If (GestioneFumiTamburo.Inclusione) Then
            .items(PLCTAG_GEST_FUMI_TAMB_CmdUp).Value = GestioneFumiTamburo.Modulatore.Stato = ModulatoreUP
            
            .items(PLCTAG_GEST_FUMI_TAMB_CmdDown).Value = GestioneFumiTamburo.Modulatore.Stato = Modulatoredown
        End If
        '20161128

        '20170202
        If (GestioneVelocitaTamburo.Inclusione) Then
            .items(PLCTAG_GEST_VEL_TAMB_CmdUp).Value = GestioneVelocitaTamburo.Modulatore.Stato = ModulatoreUP
            .items(PLCTAG_GEST_VEL_TAMB_CmdDown).Value = GestioneVelocitaTamburo.Modulatore.Stato = Modulatoredown
            CP240.CmdUpDownBruc(4).enabled = ListaMotori(MotoreRotazioneEssiccatore).ritorno
            If (Not ListaMotori(MotoreRotazioneEssiccatore).ritorno) Then
                'senza il comando si porta a zero la velocità
                If (GestioneVelocitaTamburo.Modulatore.posizione > 0) Then
                    ChiusuraForzVelocitaTamburo = True
                End If
            End If
            If (ChiusuraForzVelocitaTamburo) Then
                Call CP240.ComandiGestioneVelTamburo(True, False)
                If (ListaMotori(MotoreRotazioneEssiccatore).ritorno Or GestioneVelocitaTamburo.Modulatore.posizione = 0) Then
                    Call CP240.ComandiGestioneVelTamburo(False, False)
                    ChiusuraForzVelocitaTamburo = False
                End If
            End If
        Else
            ChiusuraForzVelocitaTamburo = False
        End If
        '20170202
        
        'Modulatore Filtro
        '20160128
        ' durante l'accensione del bruciatore si insegue il valore del parametro AumentoAspirazioneFiltro sia in automatico che in manuale
        GestioneAspirazioneFiltroInPreventilazione
        '20160128
        If .items(PLCTAG_DO_FiltChModulatore).Value <> (ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown) Or _
        .items(PLCTAG_DO_FiltApModulatore).Value <> (ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP) Then
            Call FiltroModulatore_change
        End If

        .items(PLCTAG_DO_FiltChModulatore).Value = (ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown)
        .items(PLCTAG_DO_FiltApModulatore).Value = (ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP)

        If ParallelDrum Then
            Call AriaTamburoModulatore_change(0, (.items(PLCTAG_DO_AperturaFumiTamburo1).Value), (.items(PLCTAG_DO_ChiusuraFumiTamburo1).Value))
            'Modulatore Fumi Tamburo 1
            .items(PLCTAG_DO_ChiusuraFumiTamburo1).Value = (ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown)
            .items(PLCTAG_DO_AperturaFumiTamburo1).Value = (ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP)
        End If

        If ParallelDrum Then
            Call AriaTamburoModulatore_change(1, (.items(PLCTAG_DO_AperturaFumiTamburo2).Value), (.items(PLCTAG_DO_ChiusuraFumiTamburo2).Value))
            'Modulatore Fumi Tamburo 2
            .items(PLCTAG_DO_ChiusuraFumiTamburo2).Value = (ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown)
            .items(PLCTAG_DO_AperturaFumiTamburo2).Value = (ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP)
        End If

        If .items(PLCTAG_DO_FiltChModAriaFr).Value <> (ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.Modulatoredown) Or _
        .items(PLCTAG_DO_FiltApModAriaFr).Value <> (ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP) Then
            Call AriaFreddaFiltroModulatore_change
        End If

        .items(PLCTAG_DO_FiltChModAriaFr).Value = ModulatoreAriaFreddaFiltro.Stato = Modulatoredown
        .items(PLCTAG_DO_FiltApModAriaFr).Value = ModulatoreAriaFreddaFiltro.Stato = ModulatoreUP

        'Comando Start Bruciatore
        .items(PLCTAG_DO_BrucStart).Value = ListaTamburi(0).ComandoAccensioneBruciatore
        If (ParallelDrum) Then
            .items(PLCTAG_DO_Bruciatore2Start).Value = ListaTamburi(1).ComandoAccensioneBruciatore
        End If
        
        'Deflettore Scambio Vaglio
        .items(PLCTAG_DO_TorScambiovaglio).Value = Not DeflettoreSuVagliato
        
    
        'Deflettore Anello Riciclato con Pistone
        .items(PLCTAG_DO_BrucDeflRic).Value = DeflettoreRiciclatoComandoElevatore

        'Allarme Cicalino
        .items(PLCTAG_DO_AllarmeAcustico).Value = (AbilitaAllarmeCicalino And AllarmeCicalino)

        'Aspiratore Fresato Freddo
        .items(PLCTAG_DO_MixAttAspFumi).Value = AspiratoreFresatoFreddo
        
        'Deflettore Non Passa
        .items(PLCTAG_DO_TorAttNpRifiuti).Value = (InclusioneDeflettoreNonPassa And DeflettoreNonPassa)

        'Scambio bitume1 a bitume2
        If AbilitaSelettoreBitume1 And InclusioneBitume2 Then
            .items(PLCTAG_DO_ScambioB1).Value = (SelezioneCircuitoBitume2 Or (ScambioBitume2 = 1))
        End If

        'Sospensione Pesate
        .items(PLCTAG_SospensionePesate).Value = SospensionePesatura

        'Maschera 16 bit per coclee in manuale
        .items(PLCTAG_CocleeManualeComandoComposto).Value = False

        'Comando NastrinoRAP tra deflettore e elevatore a caldo
        .items(PLCTAG_DO_NastrinoRiciclatoAnello2Elevatore).Value = (AbilitaModulatoreDeflettoreAnello And AbilitaNastroDeflettoreAnello And NastroDeflettoreAnelloAcceso)

        'Modulatore NastrinoRAP apre
        .items(PLCTAG_DO_BrucModRicApre).Value = (AbilitaModulatoreDeflettoreAnello And ModulatoreDeflettoreAnelloInApertura)

        'Modulatore NastrinoRAP chiude
        .items(PLCTAG_DO_BrucModRicChiude).Value = (AbilitaModulatoreDeflettoreAnello And ModulatoreDeflettoreAnelloInChiusura)

        'Mixer carico da amperometro
        .items(PLCTAG_MixerPienoAmpere).Value = MixerCaricoPerBenna
        
        'Benna carica da amperometro
'        .items(PLCTAG_BennaPienaAmpere).Value = (InclusioneBenna And bennaPiena And BennaFineCorsaInf)
        .items(PLCTAG_BennaPienaAmpere).Value = (InclusioneBenna And BennaPiena And BennaFineCorsaInf And ListaAmperometri(AmperometroArganoBenna).Inclusione)
'
        'Inversione Nastro Collettori
        .items(PLCTAG_NM_CMD_InvSemiAuto_4).Value = ListaMotori(MotoreNastroCollettore1).ComandoInversione
        .items(PLCTAG_NM_CMD_InvSemiAuto_5).Value = ListaMotori(MotoreNastroCollettore2).ComandoInversione
        .items(PLCTAG_NM_CMD_InvSemiAuto_6).Value = ListaMotori(MotoreNastroCollettore3).ComandoInversione
        
        'Inversione Nastro ElevatoreFreddo
        .items(PLCTAG_NM_CMD_InvSemiAuto_7).Value = ListaMotori(MotoreNastroElevatoreFreddo).ComandoInversione

        '20160706
        .items(PLCTAG_NM_CMD_InvSemiAuto_8) = ListaMotori(MotoreNastroLanciatore).ComandoInversione
        '

        'Inversione PCL
        .items(PLCTAG_NM_CMD_InvSemiAuto_1).Value = ListaMotori(MotorePCL).ComandoInversione
        .items(PLCTAG_NM_CMD_InvSemiAuto_2).Value = ListaMotori(MotorePCL2).ComandoInversione
        .items(PLCTAG_NM_CMD_InvSemiAuto_3).Value = ListaMotori(MotorePCL3).ComandoInversione
        
        'Deflettore Vaglio Riciclato EXTERNAL
        .items(PLCTAG_DO_BrucDeflVaglRic).Value = (DeflettoreMulinoEXT = 1)
        
        'Evacuazione filtro tipo DMR
        '20161010
        'If (InclusioneEvacuazioneFillerRecuperoDMR) Then
        '    .items(PLCTAG_DO_FiltAttuat01).Value = EvacuazioneFiltroDMR
        'Else
        '    .items(PLCTAG_DO_FiltAttuat01).Value = False
        'End If
        .items(PLCTAG_DO_FiltAttuat01).Value = IIf(InclusioneEvacuazioneFillerRecuperoDMR, EvacuazioneFiltroDMR, False)
        '
    
        '20161010
        .items(PLCTAG_DO_EvacuazFillerSilo).Value = IIf(InclusioneEvacuazioneSiloFiller, ComandoEvacuazioneSiloFiller, False)
        '
                
        '20161122
        .items(PLCTAG_NM_FILLER_EvacSiloFiller1).Value = InclusioneEvacuazioneSiloFiller
        '

        'Bruciatore Automatico
        .items(PLCTAG_BrucAutoStartImpulso).Value = False '20161230 ListaTamburi(0).ImpulsoStartCorrModulatore
        .items(PLCTAG_BrucAutoEnable).Value = False '20161230 ListaTamburi(0).BruciatoreAutomatico
        .items(PLCTAG_BrucAutoApreModulatore).Value = Not ListaTamburi(0).ChiusuraModulatore
        .items(PLCTAG_BrucAutoDurataImpulso).Value = False '20161230 ValoreForchetta(Abs(TempoDurataCorr) * 10, 100, 5000, True)
        If (ParallelDrum) Then
            .items(PLCTAG_Bruciatore2AutomaticoImpulsoRegolazioneModulatore).Value = False '20161230 ListaTamburi(1).ImpulsoStartCorrModulatore
            .items(PLCTAG_Bruciatore2AutomaticoAbilitaRegolazioneModulatore).Value = False '20161230 ListaTamburi(1).BruciatoreAutomatico
            .items(PLCTAG_Bruciatore2AutomaticoSegnoRegolazioneModulatore).Value = Not ListaTamburi(1).ChiusuraModulatore
            .items(PLCTAG_Bruciatore2AutomaticoDurataImpulsoRegolazioneModulatore).Value = False '20161230 ValoreForchetta(Abs(TempoDurataCorr) * 10, 100, 5000, True)
        End If
        .items(PLCTAG_DI_DepressFiltroOK).Value = FiltroInPulizia
        '20150302
        .items(PLCTAG_DI_ConsPuliziaFiltro).Value = ListaMotori(MotoreAspiratoreFiltro).RitornoReale
        '
        .items(PLCTAG_UnitaMaxPCL).Value = CLng(27648 * CLng(VoltPompaLegante) / 10)
        .items(PLCTAG_UnitaMaxContalitri).Value = CLng(100 * VoltMaxContalitri / 10)
        .items(PLCTAG_UnitaMinContalitri).Value = CLng(100 * VoltMinContalitri / 10)
        .items(PLCTAG_DensitaContalitri).Value = CDbl(DensitaContalitri)
        .items(PLCTAG_ContalitriImpulsiLitro).Value = CDbl(ContalitriImpulsiLitro)
        .items(PLCTAG_ContalitriTempoMaxSpruzzatura).Value = CInt(ContalitriTempoMaxSpruzzatura)
        
        .items(PLCTAG_Densita_Add2_CNT).Value = AdditivoBacinella.densita
        .items(PLCTAG_ImpulsiLitro_Add2_CNT).Value = AdditivoBacinella.impulsiLitro
        .items(PLCTAG_Rampa_dec_Add2_CNT).Value = AdditivoBacinella.rampaFrenatura
        .items(PLCTAG_Tempo_sicurez_Add2_CNT).Value = AdditivoBacinella.tempoSicurezza
        .items(PLCTAG_Add2_modo_CNT).Value = AdditivoBacinella.modoContalitri
        .items(PLCTAG_Add2_presenza_valvola).Value = AdditivoBacinella.presenzaValvola

        If AntiadesivoScivoloScarBilRAP.presente Then
            .items(PLCTAG_EN_Antiad_Sciv_Sc_BilRAP).Value = AntiadesivoScivoloScarBilRAP.Inclusione
        Else
            .items(PLCTAG_EN_Antiad_Sciv_Sc_BilRAP).Value = 0
        End If

        If ParallelDrum Then
            .items(PLCTAG_DO_Flap_Antincendio_Tamb2).Value = (ListaTamburi(1).SicurezzaTemperaturaFumiTamburoOUT = True) Or SicurezzaTemperaturaFiltroSw

            .items(PLCTAG_DO_DeflettoreBypassATamburo_Tamb2).Value = IIf(ListaMotori(MotoreNastroBypassEssicatore).presente, Not DeflettoreByPassTamburoParalleloVersoNastro, False)
        End If

        'Bitume
        .items(PLCTAG_NM_IN_BIT_BASSA_TEMP_BIT1).Value = BassaTemperaturaBitume(0) '20150804
        .items(PLCTAG_NM_IN_BIT_BASSA_TEMP_BIT2).Value = BassaTemperaturaBitume(1) '20150804
        .items(PLCTAG_NM_FORZA_PCL).Value = ForzaturaPCL
        'Inclusione Bindicator
        .items(PLCTAG_NM_F1_Gestione).Value = (CP240.AniPushButtonDeflettore(2).Value = 1)
        .items(PLCTAG_NM_F2_Gestione).Value = (CP240.AniPushButtonDeflettore(15).Value = 1)
        .items(PLCTAG_NM_F3_Gestione).Value = (CP240.AniPushButtonDeflettore(28).Value = 1)
'20150426
        .items(PLCTAG_EN_Pes_Fill_2_Forzata).Value = (GestioneFiller2 = FillerSoloTramTamp)
'
        .items(PLCTAG_Pres_Selett_Scambio_B1B2).Value = AbilitaSelettoreBitume1 '20150923

        .items(PLCTAG_SelezioneF3).Value = SelezioneF3 '20151221

        '20161024
        .items(PLCTAG_BIL_PNET_Aggregati_Cmd_FormAperto).Value = (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI)
        .items(PLCTAG_BIL_PNET_Aggregati_Cmd_EseguiTara).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE), False)
        .items(PLCTAG_BIL_PNET_Aggregati_Cmd_EseguiPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE), False)
        .items(PLCTAG_BIL_PNET_Aggregati_Cmd_ValPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI, BilanciaPnSampleWeight, 0)
        .items(PLCTAG_BIL_PNET_Aggregati_Cmd_ResetFabbrica).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET), False)

        .items(PLCTAG_BIL_PNET_Filler_Cmd_FormAperto).Value = (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER)
        .items(PLCTAG_BIL_PNET_Filler_Cmd_EseguiTara).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE), False)
        .items(PLCTAG_BIL_PNET_Filler_Cmd_EseguiPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE), False)
        .items(PLCTAG_BIL_PNET_Filler_Cmd_ValPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER, BilanciaPnSampleWeight, 0)
        .items(PLCTAG_BIL_PNET_Filler_Cmd_ResetFabbrica).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET), False)

        .items(PLCTAG_BIL_PNET_Bitume_Cmd_FormAperto).Value = (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME)
        .items(PLCTAG_BIL_PNET_Bitume_Cmd_EseguiTara).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE), False)
        .items(PLCTAG_BIL_PNET_Bitume_Cmd_EseguiPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE), False)
        .items(PLCTAG_BIL_PNET_Bitume_Cmd_ValPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, BilanciaPnSampleWeight, 0)
        .items(PLCTAG_BIL_PNET_Bitume_Cmd_ResetFabbrica).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET), False)

        .items(PLCTAG_BIL_PNET_Riciclato_Cmd_FormAperto).Value = (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME)
        .items(PLCTAG_BIL_PNET_Riciclato_Cmd_EseguiTara).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE), False)
        .items(PLCTAG_BIL_PNET_Riciclato_Cmd_EseguiPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE), False)
        .items(PLCTAG_BIL_PNET_Riciclato_Cmd_ValPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, BilanciaPnSampleWeight, 0)
        .items(PLCTAG_BIL_PNET_Riciclato_Cmd_ResetFabbrica).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET), False)

        .items(PLCTAG_BIL_PNET_Viatop_Cmd_FormAperto).Value = (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP)
        .items(PLCTAG_BIL_PNET_Viatop_Cmd_EseguiTara).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE), False)
        .items(PLCTAG_BIL_PNET_Viatop_Cmd_EseguiPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE), False)
        .items(PLCTAG_BIL_PNET_Viatop_Cmd_ValPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP, BilanciaPnSampleWeight, 0)
        .items(PLCTAG_BIL_PNET_Viatop_Cmd_ResetFabbrica).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET), False)
        
        .items(PLCTAG_BIL_PNET_Viatop2_Cmd_FormAperto).Value = (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2)
        .items(PLCTAG_BIL_PNET_Viatop2_Cmd_EseguiTara).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE), False)
        .items(PLCTAG_BIL_PNET_Viatop2_Cmd_EseguiPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE), False)
        .items(PLCTAG_BIL_PNET_Viatop2_Cmd_ValPesoCampione).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2, BilanciaPnSampleWeight, 0)
        .items(PLCTAG_BIL_PNET_Viatop2_Cmd_ResetFabbrica).Value = IIf(BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2, (BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET), False)
        '
        
        .items(PLCTAG_FlomacAbilitazione).Value = InclusioneAddFlomac '20161125
        
        'CP240.OPCData.Update
        .SOUpdate

    End With

    Exit Sub
Errore:
    LogInserisci True, "NET-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PlcInDigitali()

    Dim comando As ComandiVariEnum
    Dim indice As Integer
    Dim spread As Integer
    Dim spread2 As Integer
    Dim valoreInt As Integer
    Dim valoreBool As Boolean
    Dim digitaleModificato As Boolean
    Dim valoreByte As Byte
    Dim valoreLong As Long
    Dim tempoDiMescolazione As Long
    Dim tempoSetMescolazione As Long
    Dim posizioneErrore As Integer
    Dim SpreadMotori As Integer
    Dim offsetSili As Integer
    Dim offsetAUX As Integer

    On Error GoTo Errore

    With CP240.OPCData

        If (.items.count = 0) Then
            Exit Sub
        End If

        posizioneErrore = 1

        'AGGREGATI

        '   Portina bilancia inerti
        valoreBool = .items(PLCTAG_DI_PortinaAggAperta).Value
        If (BooleanModificato(BilanciaInertiPortinaAperta, valoreBool, PlcInDigitali_Fatta)) Then
            BilanciaInertiPortinaAperta_change
        End If
        valoreBool = .items(PLCTAG_DI_PortinaAggChiusa).Value
        If (BooleanModificato(BilanciaInertiPortinaChiusa, valoreBool, PlcInDigitali_Fatta)) Then
            BilanciaInertiPortinaChiusa_change
        End If

        For indice = 0 To 6
            valoreBool = .items(IIf(DosaggioInCorso, PLCTAG_PesataInCorsoA1, PLCTAG_DO_PesataAgg1) + indice).Value
            If (BooleanModificato(PortinaAgg(indice), valoreBool, PlcInDigitali_Fatta)) Then
                Call PortinaAgg_change(indice)
            End If
        Next indice

        'Gestione della portina N.V.
        valoreBool = .items(IIf(DosaggioInCorso, PLCTAG_PesataInCorsoNV, PLCTAG_DO_PesataAggNV)).Value
        If (BooleanModificato(PortinaNV, valoreBool, PlcInDigitali_Fatta)) Then
            PortinaNV_change
        End If
        
        'Scarico aggregati
        valoreBool = .items(PLCTAG_DO_ScaricoAggregati).Value
        If (BooleanModificato(ComandoScaricoAggregati, valoreBool, PlcInDigitali_Fatta)) Then
            ScaricoAggregati_change
        End If

        'FILLER

        posizioneErrore = 2
    
        'Scarico Filler
        valoreBool = .items(PLCTAG_DO_ScaricoFiller).Value
        If (BooleanModificato(ComandoScaricoFiller, valoreBool, PlcInDigitali_Fatta)) Then
            ScaricoFiller_change
        End If
        
        '   Portina bilancia filler
        valoreBool = .items(PLCTAG_DI_PortFillBil1Ch).Value
        If (BooleanModificato(BilanciaFillerPortinaChiusa, valoreBool, PlcInDigitali_Fatta)) Then
            BilanciaFillerPortinaChiusa_change
        End If
        
        '   Scambio tubo troppo pieno su F1 o F2
        valoreBool = .items(PLCTAG_DI_Dest_trop_Pieno_F1).Value
        If (BooleanModificato(RitornoTuboTroppoPienoNonSuF2, valoreBool, PlcInDigitali_Fatta)) Then
            ScambioTuboTroppoPieno_Change
        End If
        
        'BITUME

        If BitumeGravita Then
            valoreBool = .items(PLCTAG_DO_GravitaPesataB1).Value
            If (BooleanModificato(ValorePortinaBitume(0), valoreBool, PlcInDigitali_Fatta)) Then
                ValorePortinaBitume_change 0
            End If
            If InclusioneBitume2 Then
                valoreBool = .items(PLCTAG_DO_GravitaPesataB2).Value
                If (BooleanModificato(ValorePortinaBitume(1), valoreBool, PlcInDigitali_Fatta)) Then
                    ValorePortinaBitume_change 1
                End If
            End If
        Else
            If InclusioneBitume2 And Not AbilitaSelettoreBitume1 Then
                If Not Bitume2InBlending Then
                    valoreBool = .items(PLCTAG_DO_PesataLegante2).Value
                    If (BooleanModificato(ValorePortinaBitume(0), valoreBool, PlcInDigitali_Fatta)) Then
                        ValorePortinaBitume_change 0
                    End If
                End If

                If (InclusioneBacinella2) Then
                    valoreBool = .items(PLCTAG_DO_PesataLegante1).Value
                    If (BooleanModificato(ValorePortinaBitume(1), valoreBool, PlcInDigitali_Fatta)) Then
                        ValorePortinaBitume_change 1
                    End If
                Else
                    If Not CP240.AdoDosaggio.Recordset.EOF Then
                        If CP240.AdoDosaggio.Recordset.Fields("Bitume1").Value > 0 Then
                            valoreBool = .items(PLCTAG_DO_PesataLegante1).Value
                            If (BooleanModificato(ValorePortinaBitume(0), valoreBool, PlcInDigitali_Fatta)) Then
                                ValorePortinaBitume_change 0
                            End If
                        End If
                        If CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value > 0 Then
                            If CP240.OPCData.items(PLCTAG_AbilitaBlendingBitume).Value Then
                                valoreBool = .items(PLCTAG_DO_PesataLegante2).Value
                            Else
                                valoreBool = .items(PLCTAG_DO_PesataLegante1).Value
                            End If
                            If (BooleanModificato(ValorePortinaBitume(1), valoreBool, PlcInDigitali_Fatta)) Then
                                ValorePortinaBitume_change 1
                            End If
                        End If
                    End If
                    If Bitume2InBlending And PesaturaManuale Then
                        valoreBool = .items(PLCTAG_DO_PesataLegante1).Value
                        If (BooleanModificato(ValorePortinaBitume(0), valoreBool, PlcInDigitali_Fatta)) Then
                            ValorePortinaBitume_change 0
                        End If
                        valoreBool = .items(PLCTAG_DO_PesataLegante2).Value
                        If (BooleanModificato(ValorePortinaBitume(1), valoreBool, PlcInDigitali_Fatta)) Then
                            ValorePortinaBitume_change 1
                        End If
                    End If
                End If
            Else
                valoreBool = .items(PLCTAG_DO_PesataLegante1).Value
                If (BooleanModificato(ValorePortinaBitume(0), valoreBool, PlcInDigitali_Fatta)) Then
                    ValorePortinaBitume_change 0
                End If
                If (InclusioneBitume2 Or InclusioneBacinella2) Then
                    valoreBool = .items(PLCTAG_DO_PesataLegante2).Value
                    If (BooleanModificato(ValorePortinaBitume(1), valoreBool, PlcInDigitali_Fatta)) Then
                        ValorePortinaBitume_change 1
                    End If
                End If
            End If
        End If

        posizioneErrore = 3

        If Not CP240.AdoDosaggio.Recordset.EOF Then
            If InclusioneBitume3 And (CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value > 0) Then
                valoreBool = .items(PLCTAG_DO_PesataLegante1).Value
                If (BooleanModificato(ValorePortinaBitume(3), valoreBool, PlcInDigitali_Fatta)) Then
                    ValorePortinaBitume_change 3
                End If
            End If
        End If

        If InclusioneAddContalitri Then
            valoreBool = .items(PLCTAG_DO_ContalitriPesata).Value
            If (BooleanModificato(ValorePortinaBitume(2), valoreBool, PlcInDigitali_Fatta)) Then
                ValorePortinaBitume_change 2
            End If
            valoreBool = .items(PLCTAG_All_Contalitri_PompaTimeOutAvvio).Value
            If (BooleanModificato(ContalitriErroreTimeOutAvvio, valoreBool, PlcInDigitali_Fatta)) Then
                ContalitriErroreTimeOutAvvio_change
            End If
            valoreBool = .items(PLCTAG_All_Contalitri_PompaTimeOutArresto).Value
            If (BooleanModificato(ContalitriErroreTimeOutArresto, valoreBool, PlcInDigitali_Fatta)) Then
                ContalitriErroreTimeOutArresto_change
            End If
            
        End If

        If AbilitaValv3VieSpruzzatriceBitume Then
            valoreBool = .items(PLCTAG_DI_Valv3VieSpruzzatriceVersoTorre).Value
            If (BooleanModificato(Valv3VieSpruzzatriceVersoTorre, valoreBool, PlcInDigitali_Fatta)) Then
                Valv3VieSpruzzatriceVersoTorre_Change
            End If
            If Not Valv3VieSpruzzatriceVersoTorre And DosaggioInCorso Then
                Call ArrestoEmergenzaDosaggio
            End If
        End If

        If ListaMotori(MotorePompaEmulsione).presente Then
        
            If (AbilitaValvolaBitumeEmulsione = 2) Then
                valoreBool = .items(PLCTAG_DI_Valv3VieBitume2EmulsioneVersoBitume2).Value
                If (BooleanModificato(ValvolaBitumeEmulsioneVersoBitume, valoreBool, PlcInDigitali_Fatta)) Then
                    Call Valv3VieBitume2Emulsione_Change
                End If
                valoreBool = .items(PLCTAG_DI_Valv3VieBitume2EmulsioneVersoEmulsione).Value
                If (BooleanModificato(ValvolaBitumeEmulsioneVersoEmulsione, valoreBool, PlcInDigitali_Fatta)) Then
                    Call Valv3VieBitume2Emulsione_Change
                End If

                If Not CP240.AdoDosaggio.Recordset.EOF Then
                    If (ValvolaBitumeEmulsioneVersoEmulsione = ValvolaBitumeEmulsioneVersoBitume) And DosaggioInCorso And (CP240.AdoDosaggio.Recordset.Fields("bitume2").Value > 0) Then
                        Call ArrestoEmergenzaDosaggio
                    End If
                End If
            End If

            If (AbilitaValvolaBitumeEmulsione = 1) Then
'VERIFICARE SE UTILIZZARE LO STESSO TAG
                valoreBool = .items(PLCTAG_DI_Valv3VieBitume2EmulsioneVersoBitume2).Value
                If (BooleanModificato(ValvolaBitumeEmulsioneVersoBitume, valoreBool, PlcInDigitali_Fatta)) Then
                    Call Valv3VieBitume2Emulsione_Change
                End If
                valoreBool = .items(PLCTAG_DI_Valv3VieBitume2EmulsioneVersoEmulsione).Value
                If (BooleanModificato(ValvolaBitumeEmulsioneVersoEmulsione, valoreBool, PlcInDigitali_Fatta)) Then
                    Call Valv3VieBitume2Emulsione_Change
                End If
                If Not CP240.AdoDosaggio.Recordset.EOF Then
                    If (ValvolaBitumeEmulsioneVersoEmulsione = ValvolaBitumeEmulsioneVersoBitume) And DosaggioInCorso And (CP240.AdoDosaggio.Recordset.Fields("bitume1").Value > 0) Then
                        Call ArrestoEmergenzaDosaggio
                    End If
                End If
            End If
        End If
        '

        If BitumeGravita Then
            valoreBool = .items(PLCTAG_DO_GravitaScarico).Value
            If (BooleanModificato(ComandoScaricoBitume, valoreBool, PlcInDigitali_Fatta)) Then
                Call ScaricoBitume_change(True)
            End If
        Else
            valoreBool = .items(PLCTAG_DO_ScaricoLegante).Value
            If (BooleanModificato(ComandoScaricoBitume, valoreBool, PlcInDigitali_Fatta)) Then
                Call ScaricoBitume_change(False)
            End If
        End If
        
        If BitumeGravita Then
            valoreBool = .items(PLCTAG_DO_GravitaScarico).Value
        Else
            valoreBool = .items(PLCTAG_DO_ScaricoLegante).Value
        End If
        If (BooleanModificato(BitumeInSpruzzatura, valoreBool, PlcInDigitali_Fatta)) Then
            BitumeInSpruzzatura_change
        End If
    
        'VIATOP
    
        posizioneErrore = 4
    
         '20160421
        If BilanciaViatopScarMixer1.Presenza Then
            'Comando motore coclea per pesatura Viatop Scarico Mixer1
            valoreBool = .items(PLCTAG_DB46_ViatopScarMixer1_OutPesata).Value
            If BooleanModificato(BilanciaViatopScarMixer1.OutPesata, valoreBool, PlcInDigitali_Fatta) Then
                PesataViatopScarMixer_change (0)
            End If
            'Comando scarico Viatop Scarico Mixer1
            valoreBool = .items(PLCTAG_DB46_ViatopScarMixer1_OutScarico).Value
            If BooleanModificato(BilanciaViatopScarMixer1.OutScarico, valoreBool, PlcInDigitali_Fatta) Then
                ScaricoViatopScarMixer_change (0)
            End If
            'Comando Compressore Scarico Mixer1
            valoreBool = .items(PLCTAG_DB46_ViatopScarMixer1_RitCompressore).Value
            If BooleanModificato(BilanciaViatopScarMixer1.RitCompressore, valoreBool, PlcInDigitali_Fatta) Then
                GestioneImmagineCompressoreViatopScarMixer (0)
            End If
        End If
        If BilanciaViatopScarMixer2.Presenza Then
            'Comando motore coclea per pesatura Viatop Scarico Mixer2
             valoreBool = .items(PLCTAG_DB46_ViatopScarMixer2_OutPesata).Value
            If BooleanModificato(BilanciaViatopScarMixer2.OutPesata, valoreBool, PlcInDigitali_Fatta) Then
                PesataViatopScarMixer_change (1)
            End If
            'Comando scarico Viatop Scarico Mixer2
             valoreBool = .items(PLCTAG_DB46_ViatopScarMixer2_OutScarico).Value
            If BooleanModificato(BilanciaViatopScarMixer2.OutScarico, valoreBool, PlcInDigitali_Fatta) Then
                ScaricoViatopScarMixer_change (1)
            End If
            'Comando Compressore Scarico Mixer1
            valoreBool = .items(PLCTAG_DB46_ViatopScarMixer2_RitCompressore).Value
            If BooleanModificato(BilanciaViatopScarMixer2.RitCompressore, valoreBool, PlcInDigitali_Fatta) Then
                GestioneImmagineCompressoreViatopScarMixer (1)
            End If
        End If
        '20160421
        
        If InclusioneViatop Then
            'Livello minimo viatop Big Bag.
            valoreBool = .items(PLCTAG_DI_LivMinViatop).Value
            If (BooleanModificato(LivelloMinViatop, valoreBool, PlcInDigitali_Fatta)) Then
                ValoreLivelloMinViatop_change
            End If
            'Controllo già eseguito in ControlloLivelliAltiTramogge
            'Call SegnalazioneLivelloMinViatop(valoreBool)
            
            'Livello minimo viatop nel ciclone.
            valoreBool = Not .items(PLCTAG_DI_PresenzaMatCiclone).Value
            If BooleanModificato(CicloneMinViatop, valoreBool, PlcInDigitali_Fatta) Then
                CicloneMinViatop_Change
            End If
            
            'Bilancia Viatop chiusa
            valoreBool = .items(PLCTAG_DI_PortBilViatopChiusa).Value
            If (BooleanModificato(ScaricoBilanciaViatopChiuso, valoreBool, PlcInDigitali_Fatta)) Then
                ScaricoBilanciaViatopChiuso_change
            End If
            
            'Ciclone Viatop chiuso
            valoreBool = .items(PLCTAG_DI_ScarCicloneChiuso).Value
            If BooleanModificato(ScaricoCicloneViatopChiuso, valoreBool, PlcInDigitali_Fatta) Then
                ScaricoCicloneViatopChiuso_Change
            End If
            
            'Comando trasporto viatop dalla pesatura al ciclone.
            valoreBool = .items(PLCTAG_DO_MotoreVentolaViatop).Value
            If BooleanModificato(ComandoVentolaViatop, valoreBool, PlcInDigitali_Fatta) Then
                ComandoVentolaViatop_Change
            End If

            'Comando motore coclea per pesatura viatop.
            valoreBool = .items(PLCTAG_DO_PesataViatop).Value
            If BooleanModificato(ComandoPesataViatop, valoreBool, PlcInDigitali_Fatta) Then
                ComandoPesataViatop_Change
            End If

            'Comando scarico bilancia Viatop
            valoreBool = .items(PLCTAG_DO_ScaricoBilViatop).Value
            If BooleanModificato(ComandoScaricoBilanciaViatop, valoreBool, PlcInDigitali_Fatta) Then
                ComandoScaricoBilanciaViatop_Change
            End If

            'Comando scarico viatop verso il mescolatore.
            valoreBool = .items(PLCTAG_DO_ScaricoCicloneViatop).Value
            If BooleanModificato(ComandoScaricoCicloneViatop, valoreBool, PlcInDigitali_Fatta) Then
                ComandoScaricoCicloneViatop_Change
            End If

        End If

        posizioneErrore = 5
    
        'BILANCIA RICICLATO RAP
        valoreBool = .items(PLCTAG_DO_PesataBilRiciclato).Value
        If BooleanModificato(RAPInPesata, valoreBool, PlcInDigitali_Fatta) Then
            Call PesataRAP_Change
        End If
        
        valoreBool = .items(PLCTAG_DO_ScaricoBilRiciclato).Value
        If BooleanModificato(RAPInScarico, valoreBool, PlcInDigitali_Fatta) Then
            Call RAPInScarico_Change
        End If
        
        'Il tag PLCTAG_MemTrasfPlcScarico diventa alto un mezzo ciclo dopo il cambio ricetta
        valoreBool = .items(PLCTAG_MemTrasfPlcScarico).Value
        If BooleanModificato(TrasfDatiPLCCarico, valoreBool, PlcInDigitali_Fatta) Then
            BufferAbilitaCicloRC(1) = CP240.OPCData.items(PLCTAG_AbilitaCicloRC).Value
        End If

        'RAPSiwa
        valoreBool = .items(PLCTAG_DO_SIWA_Batch_ComandoPortina).Value
        If BooleanModificato(RAPSiwaInScarico, valoreBool, PlcInDigitali_Fatta) Then
            Call RAPSiwaInScarico_Change
        End If

        'Gestione visualizzazione portina sotto il RapSiwa
        If BooleanModificato(RAPSiwaPortinaAperta, .items(PLCTAG_DI_SIWA_Batch_PortinaAperta).Value, PlcInDigitali_Fatta) Or BooleanModificato(RAPSiwaPortinaChiusa, .items(PLCTAG_DI_SIWA_Batch_PortinaChiusa).Value, PlcInDigitali_Fatta) Then
            If .items(PLCTAG_DI_SIWA_Batch_PortinaChiusa).Value = True Then
                CP240.AniPushButtonDeflettore(21).Value = 2
            ElseIf .items(PLCTAG_DI_SIWA_Batch_PortinaAperta).Value = True Then
                CP240.AniPushButtonDeflettore(21).Value = 1
            Else
                CP240.AniPushButtonDeflettore(21).Value = 3
            End If
        End If

        'Lettura dello stato degli 8 DI sulla SIWAREX
        If AbilitaRAPSiwa Then
            For indice = 0 To 7
                valoreBool = (.items(PLCTAG_SIWA4_LETTURASTATO_DI).Value And (2 ^ indice))
                If (BooleanModificato(SiwarexStatoDI(SiwarexRiciclatoFreddo).SIWA_DI(indice), valoreBool, PlcInDigitali_Fatta)) Then

                End If
            Next indice
        End If

        'MESCOLATORE
        valoreBool = .items(PLCTAG_DO_ScaricoMesc).Value
        If (BooleanModificato(ComandoScaricoMixer, valoreBool, PlcInDigitali_Fatta)) Then
            ComandoScaricoMixer_change
        End If
        valoreBool = .items(PLCTAG_DI_PortinaMescChiusa).Value
        If (BooleanModificato(MescolatoreChiuso, valoreBool, PlcInDigitali_Fatta)) Then
            MescolatoreChiuso_change
        End If
        valoreBool = .items(PLCTAG_DI_PortinaMescAperta).Value
        If (BooleanModificato(MescolatoreAperto, valoreBool, PlcInDigitali_Fatta)) Then
            MescolatoreAperto_change
        End If
    
        valoreBool = .items(PLCTAG_MescolazioneInCorso).Value
        If (BooleanModificato(MescolazioneInCorso, valoreBool, PlcInDigitali_Fatta)) Then
            MescolazioneInCorso_change
            '20161202
            If (cambioVoloTempiAggRic) Then
                If (MescolazioneInCorso) Then
                    ForzaSetTempi (True)
                    cambioVoloTempiAggRic = False
                End If
            End If
            '20161202
        End If

        
        'CONSENSO SCARICO BILANCE
        valoreBool = .items(PLCTAG_ConsensoScaricoBilance).Value
        If (BooleanModificato(ConsensoScaricoBilance, valoreBool, PlcInDigitali_Fatta)) And ConsensoScaricoBilance Then
            ConsensoScaricoBilance_change
        End If
        
        'ADDITIVO MIXER
        If (InclusioneAddMescolatore) Then
            valoreBool = .items(PLCTAG_DI_PompaAddMix).Value
            If (BooleanModificato(ScaricoAdditivo(0), valoreBool, PlcInDigitali_Fatta)) Then
                ScaricoAdditivo_change 0
            End If
        End If

        'Additivo ACQUA
        If (InclusioneAcqua) Then
            valoreBool = .items(PLCTAG_DI_PompaAcquaRitorno).Value
            If (BooleanModificato(ScaricoAcqua, valoreBool, PlcInDigitali_Fatta)) Then
                ScaricoAcqua_change
            End If
        End If

        'ADDITIVO LEGANTE
        If (InclusioneAddBacinella) Then
            valoreBool = .items(PLCTAG_DI_PompaAddLegante).Value
            If (BooleanModificato(ScaricoAdditivo(1), valoreBool, PlcInDigitali_Fatta)) Then
                ScaricoAdditivo_change 1
            End If
        End If

        If (InclusioneAddSacchi) Then
            ScaricoAddSacchi = .items(PLCTAG_DI_PortinaSacchiAp).Value
        End If

        posizioneErrore = 6

        'VAGLIO
        valoreBool = .items(PLCTAG_DI_TorVagliato).Value
        If (BooleanModificato(VaglioIncluso, valoreBool, PlcInDigitali_Fatta)) Then
            VagliatoNonVagliato_change
        End If
        valoreBool = .items(PLCTAG_DI_TorNonVagliato).Value
        If (BooleanModificato(VaglioEscluso, valoreBool, PlcInDigitali_Fatta)) Then
            VagliatoNonVagliato_change
        End If

        'VALVOLA DEL TROPPO PIENO DEL FILLER 1
        If AbilitaValvolaTroppoPienoF1 Then
            valoreBool = .items(PLCTAG_DI_ScambioFillerRecuperoInApporto_CH).Value
            'true = deflettore su filler recupero
            If (BooleanModificato(ScambioFillerRecuperoInApporto_CH, valoreBool, PlcInDigitali_Fatta)) Then
                ScambioFillerRecuperoInApporto_Change
            End If
        End If

        valoreBool = .items(PLCTAG_DI_FiltValvola2Ap).Value
        If (BooleanModificato(ValvolaTSFAperta, valoreBool, PlcInDigitali_Fatta)) Then
            Call AggiornaGraficaValvolaTSF_Change
        End If

        valoreBool = .items(PLCTAG_NM_EV_FORZATO_CH).Value
        If (BooleanModificato(EvacuazFiltroErrore, valoreBool, PlcInDigitali_Fatta)) Then
            If (EvacuazFiltroErrore) Then '20150108 in caso di timeout toglie l'abilitazione
'                CP240.AniPushButtonDeflettore(7).Value = 1
                EvacuazioneFiltroDMR = False '20150108 in caso di timeout toglie l'abilitazione
    '            EvacuazioneFiltroDMR = (AniPushButtonDeflettore(7).Value <> 1)
    '            Call AggiornaGraficaValvolaTSF_Change
            End If
            Call EvacuazioneFiltroDMR_change
        End If

        valoreBool = .items(PLCTAG_NM_FILLER1_TSF_TIMEOUT).Value
        If (BooleanModificato(ValvolaTSFErrore, valoreBool, PlcInDigitali_Fatta)) Then
            Call AggiornaGraficaValvolaTSF_Change
        End If
'
        'DEFLETTORE NON PASSA

        If (InclusioneDeflettoreNonPassa) Then
    '    .Items(PLCTAG_DO_TorAttNpRifiuti).value
    
            valoreBool = .items(PLCTAG_DI_TorAttNpRifGr).Value
            If (BooleanModificato(FCNonPassaGrosso, valoreBool, PlcInDigitali_Fatta)) Then
                DeflettoreNonPassa_change
            End If
            valoreBool = .items(PLCTAG_DI_TorAttNpRifRf).Value
            If (BooleanModificato(FCNonPassaRifiuti, valoreBool, PlcInDigitali_Fatta)) Then
                DeflettoreNonPassa_change
            End If
    
    '    .Items(PLCTAG_DI_TorAttNpRifTer).value
        End If
    
        '   Premuto un pulsante di pesata inerti manuale
        valoreBool = .items(PLCTAG_DI_TorMemApPortMan).Value Or MemoriaPesataExtComando
        If (valoreBool And DosaggioInCorso) Then
            PulsantieraPesate(0) = 111
        End If
    
        valoreBool = .items(PLCTAG_DI_TorBassaPress).Value
        If (BooleanModificato(PressioneAriaInsufficente, valoreBool, PlcInDigitali_Fatta)) Then
            PressioneAriaInsufficente_change
        End If

        posizioneErrore = 7
        
        If (AbilitaRAPSiwa) Then  'Se è stato SELEZIONATO il riciclato freddo con scarico in tramoggia o no.
            If NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) > 0 Then
                If val(CP240.TxtPredRicSet(1).text) <> 0 Then
                    ValoreRicInTramoggia = True
                End If
                If val(CP240.TxtPredRicSet(0).text) <> 0 Then
                    ValoreRicInEssicatore = True
                End If
            Else
                ValoreRicInTramoggia = .items(PLCTAG_DI_BrucDeflRicElev).Value
                ValoreRicInEssicatore = .items(PLCTAG_DI_BrucDeflRicTamb).Value
            End If
        End If

        valoreBool = .items(PLCTAG_DI_TorLivMinTramRic).Value
        If (BooleanModificato(LivelloBassoTramoggiaRic, valoreBool, PlcInDigitali_Fatta)) Then
            Call LivelloTramoggiaRic_change
        End If
        valoreBool = .items(PLCTAG_DI_TorLivMaxTramRic).Value
        If (BooleanModificato(LivelloAltoTramoggiaRic, valoreBool, PlcInDigitali_Fatta)) Then
            Call LivelloTramoggiaRic_change
        End If

        'LIVELLI TRAMOGGE
    
        For indice = 0 To 5
            If (((TipoLivelliA And (2 ^ indice)) <> 0)) Then
                '   Digitale
    
    '           .Items(PLCTAG_DI_TorLivMedAgg1).value
    
                '   Vuoto
                valoreInt = 0
                valoreBool = .items(PLCTAG_DI_TorLivMaxAgg1 + (4 * indice)).Value
                If (valoreBool) Then
                    '   Livello 2/3
                    valoreInt = TramoggeLivelloMassimo
                '   Livelli digitali del minimo
                ElseIf (TramoggeLivelliDigitaliMinimo) Then
                    valoreBool = .items(PLCTAG_DI_TorLivMinAgg1 + (4 * indice)).Value
                    If (valoreBool) Then
                        '   Livello 1/3
                        valoreInt = TramoggeLivelloMinimo
                    End If
                End If
            
                If (IntegerModificato(LivelloTramoggia(indice), valoreInt, PlcInDigitali_Fatta)) Then
                    LivelloTramoggia_change indice
                End If
            End If
        Next indice

        posizioneErrore = 8

        indice = 7
        If (((TipoLivelliA And (2 ^ indice)) <> 0)) Then
            '   Digitale

    '       .Items(PLCTAG_DI_TorLivMedAggNV).value

            '   Vuoto
            valoreInt = 0
            valoreBool = .items(PLCTAG_DI_TorLivMaxAggNV).Value
            If (valoreBool) Then
                '   Livello 2/3
                valoreInt = TramoggeLivelloMassimo
            '   Livelli digitali del minimo
            ElseIf (TramoggeLivelliDigitaliMinimo) Then
                valoreBool = .items(PLCTAG_DI_TorLivMinAggNV).Value
                If (valoreBool) Then
                    '   Livello 1/3
                    valoreInt = TramoggeLivelloMinimo
                End If
            End If
    
            If (IntegerModificato(LivelloTramoggia(indice), valoreInt, PlcInDigitali_Fatta)) Then
                LivelloTramoggia_change indice
            End If

        End If

        posizioneErrore = 9

        'PREDOSAGGIO

        spread = PLCTAG_DI_RitPredosatore2 - PLCTAG_DI_RitPredosatore1

        '   Predosatori
        For indice = 0 To MAXPREDOSATORI - 1
            If (DEMO_VERSION) Then
                valoreBool = ListaPredosatori(indice).motore.uscita
            Else
                valoreBool = .items(PLCTAG_DI_RitPredosatore1 + (indice * spread)).Value
            End If
            If (BooleanModificato(ListaPredosatori(indice).motore.ritorno, valoreBool, PlcInDigitali_Fatta)) Then
                Call PredosatoreRitorno_change(indice)
            End If
    
            valoreBool = .items(PLCTAG_DI_PalpatorePred1 + (indice * spread)).Value
            If (BooleanModificato(ListaPredosatori(indice).vuoto, valoreBool, PlcInDigitali_Fatta)) Then
                PredosatoreMinimoVuoto_change indice
            End If

            If (ListaPredosatori(indice).livelloBassoPresente) Then
                valoreBool = (Not .items(PLCTAG_DI_LivMinPred1 + (indice * spread)).Value)
            Else
                valoreBool = False
            End If
            If (BooleanModificato(ListaPredosatori(indice).minimo, valoreBool, PlcInDigitali_Fatta)) Then
                PredosatoreMinimoVuoto_change indice
            End If

            'Per ora inutilizzato
            'valoreBool = .Items(PLCTAG_DI_TermPredosatore1 + (indice * spread)).value
            'If (valoreBool) Then
            '    PredosatoriInTermica = True
            'End If
    
            '.Items(PLCTAG_DI_AllPred1).value
        Next indice

        posizioneErrore = 10

        spread = PLCTAG_DI_RitRiciclato2 - PLCTAG_DI_RitRiciclato1

        '   Predosatori riciclato
        For indice = 0 To MAXPREDOSATORIRICICLATO - 1
            If (DEMO_VERSION) Then
                valoreBool = ListaPredosatoriRic(indice).motore.uscita
            Else
                valoreBool = .items(PLCTAG_DI_RitRiciclato1 + (indice * spread)).Value
            End If
            If (BooleanModificato(ListaPredosatoriRic(indice).motore.ritorno, valoreBool, PlcInDigitali_Fatta)) Then
                PredosatoreRiciclatoRitorno_change indice
            End If
        
            valoreBool = .items(PLCTAG_DI_PalpatoreRiciclato1 + (indice * spread)).Value
            If (BooleanModificato(ListaPredosatoriRic(indice).vuoto, valoreBool, PlcInDigitali_Fatta)) Then
                PredosatoreRiciclatoMinimoVuoto_change indice
            End If

            If (ListaPredosatoriRic(indice).livelloBassoPresente) Then
                valoreBool = (Not .items(PLCTAG_DI_LivMinRiciclato1 + (indice * spread)).Value)
            Else
                valoreBool = False
            End If
            If (BooleanModificato(ListaPredosatoriRic(indice).minimo, valoreBool, PlcInDigitali_Fatta)) Then
                PredosatoreRiciclatoMinimoVuoto_change indice
            End If

            'Per ora inutilizzato
            'valoreBool = .Items(PLCTAG_DI_TermRiciclato1 + (indice * spread)).value
            'If (valoreBool) Then
            '    PredosatoriInTermica = True
            'End If

            '.Items(PLCTAG_DI_AllRiciclato1).value
        Next indice

        If (BooleanModificato(TermicaPredosatori, .items(PLCTAG_DI_PredosatoriTermica).Value, PlcInDigitali_Fatta)) Then
            TermicaPredosatori_change
        End If

        posizioneErrore = 11

        SpreadMotori = PLCTAG_DO_Motore02 - PLCTAG_DO_Motore01
        spread = PLCTAG_NM_Ritorno_2 - PLCTAG_NM_Ritorno_1


'        '20160201
'        If (AttesaFineRicetta) Then
'            If (Not CP240.OPCData.items(PLCTAG_PRED_Out_Ric_Auto_Corso).Value) Then
'                AutomaticoPredosatori = False
'                AttesaFineRicetta = False
'            End If
'        End If
        If (AttesaFineRicetta) Then
            If (Not CP240.OPCData.items(PLCTAG_PRED_Out_Ric_Auto_Corso).Value) Then
                AutomaticoPredosatori = False
                AttesaFineRicetta = False
                If (CP240.OPCData.items.count) Then
                    CP240.OPCData.items(PLCTAG_NM_PRED_Auto_Man).Value = False
                End If
            End If
        End If
        '20160201

        
        '   Motori
        For indice = 0 To MAXMOTORI - 1
            If (ListaMotori(indice + 1).presente) Then
                Call SetMotoreRitorno(indice + 1, .items(PLCTAG_NM_Ritorno_1 + indice).Value)
                Call SetMotoreRitornoReale(indice + 1, .items(PLCTAG_DI_RitMotore01 + (indice * SpreadMotori)).Value)
                Call SetMotoreRitornoIndietro(indice + 1, .items(PLCTAG_NM_RitornoIndietro_1 + indice).Value)
                Call SetMotoreAllarme(indice + 1, .items(PLCTAG_NM_AllarmeMotore_1 + indice).Value)
                Call SetMotoreBlocco(indice + 1, .items(PLCTAG_NM_BloccoMotore_1 + indice).Value)
                Call SetMotoreForzatoAcceso(indice + 1, .items(PLCTAG_NM_AccesoForzatoPLC_1 + indice).Value)
                Call SetMotoreForzatoSpento(indice + 1, .items(PLCTAG_NM_SpentoForzatoPLC_1 + indice).Value)
                Call SetMotoreForzatoDarwin(indice + 1, .items(PLCTAG_NM_ForzatoDarwin_1 + indice).Value)
            End If
        Next indice
        
        'Start Predosaggio dopo nastri
        If (BooleanModificato(StartRicPred, .items(PLCTAG_NM_PRED_Lancia_Ricetta), PlcInDigitali_Fatta)) Then
            If (StartRicPred) Then
                Call AvvioPredAutomatico
                attesastartplc = False
            End If
        End If
        
        'Stop Predosaggio per Nastro Fermo con Predosatore in moto
        If (BooleanModificato(ArrestoImmPred, .items(PLCTAG_NM_PRED_Arresta_Ricetta), PlcInDigitali_Fatta)) Then
            If (ArrestoImmPred) Then
                Call PassaInManualePredosatori
            End If
        End If

        If (ListaMotori(MotoreCompressoreBruciatore).presente) Then
            If (BooleanModificato(CompressoreBruciatorePressioneInsuff, .items(PLCTAG_DI_PressInsufComprBruc).Value, PlcInDigitali_Fatta)) Then
                Call CompressoreBruciatorePressioneInsuff_change
            End If
        End If

        If (ListaMotori(MotoreCompressoreBruciatore2).presente) Then
            valoreBool = .items(PLCTAG_DI_CompressoreBruciatore2_PressioneInsufficiente).Value
            If (BooleanModificato(CompressoreBruciatore2PressioneInsuff, valoreBool, PlcInDigitali_Fatta)) Then
                Call CompressoreBruciatorePressioneInsuff_change
            End If
        End If
        '20161215
        If (Deodorante.Inclusione) Then
            valoreBool = .items(PLCTAG_SILO_Deodorante_StopMaxDurata).Value
            If (BooleanModificato(Deodorante.StopMaxDurata, valoreBool, PlcInDigitali_Fatta)) Then
                If (Deodorante.StopMaxDurata) Then
                    CP240.AniPushButtonDeflettore(37).Value = 1
                End If
            End If
        End If
        '20161215
        '20160127 Nuova Gestione Sili Deposito
'        valoreBool = .items(PLCTAG_DI_SiloMemTempScar).Value
''        If (BooleanModificato(LetturaTemperaturaSilo, valoreBool, PlcInDigitali_Fatta)) And Not LetturaTemperaturaSilo Then
'        If (BooleanModificato(LetturaTemperaturaSilo, valoreBool, True)) And LetturaTemperaturaSilo Then
'            LetturaTemperaturaSilo_change
'        End If

        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        spread = PLCTAG_DI_RitSilo02 - PLCTAG_DI_RitSilo01

        For indice = 0 To MAXNUMSILI - 1
            If InclusioneSiloS7 Then
                valoreBool = (.items(PLCTAG_DI_CappelloSilo01_Aperto + (indice * spread)).Value) And Not (.items(PLCTAG_DI_CappelloSilo01_Chiuso + (indice * spread)).Value)
            Else
                valoreBool = (.items(PLCTAG_DI_RitSilo01 + (indice * spread)).Value)
            End If
            If (BooleanModificato(ListaSili(indice + 1).RitornoSelezionato, valoreBool, PlcInDigitali_Fatta)) Then
                VisualizzaSiloAttivo FrmSiloGeneraleVisibile
            End If
            valoreBool = .items(PLCTAG_DI_LivMaxSilo01 + (indice * spread)).Value
            If (BooleanModificato(ListaSili(indice + 1).LivelloAlto, valoreBool, PlcInDigitali_Fatta)) Then
                LivelloAltoScomparto_change indice + 1
            End If
        Next indice
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
'20160503
        'Semaforo Benna
        If (AbilitazioneSemaforoBenna) Then
            valoreBool = .items(PLCTAG_DB46_SemaforoBenna_DI_Verde).Value
            If (BooleanModificato(SemaforoBenna.Rit_Verde, valoreBool, PlcInDigitali_Fatta)) Then
                Call AggiornaImgSemaforo(SemaforoBenna.Rit_Verde, False, False)
            End If
            If (SemaforoBenna.Comando_Verde <> SemaforoBenna.Rit_Verde) Then
                'incoerenza
                If (Not FrmGestioneTimer.TmoutSemaforoBenna.enabled) Then
                    FrmGestioneTimer.TmoutSemaforoBenna.enabled = True
                End If
                Call AggiornaImgSemaforo(False, True, False)
            End If
        End If
        'Semaforo Benna
        
        'Semaforo Sili
        If (AbilitazioneSemaforoSili) Then
            valoreBool = .items(PLCTAG_DB46_SemaforoSili_DI_Verde).Value
            If (BooleanModificato(SemaforoSili.Rit_Verde, valoreBool, PlcInDigitali_Fatta)) Then
                Call AggiornaImgSemaforo(SemaforoSili.Rit_Verde, False, True)
            End If
            If (SemaforoSili.Comando_Verde <> SemaforoSili.Rit_Verde) Then
                'incoerenza
                If (Not FrmGestioneTimer.TmoutSemaforoSili.enabled) Then
                    FrmGestioneTimer.TmoutSemaforoSili.enabled = True
                End If
                Call AggiornaImgSemaforo(False, True, True)
            End If
        End If
        'Semaforo Sili
'20160503

        posizioneErrore = 12

        valoreBool = .items(PLCTAG_DI_BennaPronta).Value
        If (BooleanModificato(BennaPronta, valoreBool, PlcInDigitali_Fatta)) Then
            CP240.ImgBenna(2).Visible = BennaPronta And InclusioneBenna
        End If

        offsetSili = PLCTAG_DO_Silo02 - PLCTAG_DO_Silo01
        For indice = 0 To MAXNUMSILI - 1
            valoreBool = .items(PLCTAG_DI_PortScarSilo01 + indice * offsetSili).Value
            If (BooleanModificato(ListaSili(indice + 1).FcPortina, valoreBool, PlcInDigitali_Fatta)) Then
                Call PortinaScaricoSilo_Change(indice + 1)
            End If
        Next indice

        If AbilitaControlloAllarmi <> 0 Then
            valoreBool = .items(PLCTAG_DI_AsseP_FC_PuntoCarico).Value
            
            '20160316
            'sul fronte (salita) del finecorsa di carico se la benna è ancora piena compare l'allarme
            'nel caso di diretto se viene selezionato e si fa tornare la benna al finecorsa di zero senza scaricare il mixer la benna rimane piena
            'e compare l'allarme; per evitarlo il controllo viene fatto per tutti i sili selezionati escluso il diretto
            Dim selezionesiloesclusodiretto As Boolean
            selezionesiloesclusodiretto = (ListaSili(1).RitornoSelezionato Or ListaSili(2).RitornoSelezionato Or ListaSili(3).RitornoSelezionato Or ListaSili(4).RitornoSelezionato Or ListaSili(12).RitornoSelezionato)
            '20160316
                        
            If (BooleanModificato(BennaFineCorsaInf, valoreBool, PlcInDigitali_Fatta)) Then
                If _
                    BennaFineCorsaInf And _
                    (InclusioneBenna Or InclusioneBennaApribile) And selezionesiloesclusodiretto And _
                    ((AbilitaControlloAllarmi = 2 And BennaPiena) Or (AbilitaControlloAllarmi = 1)) _
                Then
                    VerificareBenna = True
                    Call AllarmeTemporaneo("XX120", True)
                End If

                Call CP240.ShowBenna(BennaVisualizzata = 1 Or BennaVisualizzata = 3)

                If (BennaFineCorsaInf) Then
                    'Con la benna sotto azzero il timer di controllo benna piena
                    FrmGestioneTimer.TimerBennaPiena.enabled = False
                Else
                    'Perdendo il FC inferiore la benna è piena per definizione
                    BennaPiena = True
                    FrmGestioneTimer.TimerBennaPiena.enabled = False
                End If
                'Call CP240.ButtonSkipStartEnable   '20160718
            End If
        End If

        If (InclusioneSilo2S7) Then
            valoreBool = .items(PLCTAG_DI_AsseA_FC_PuntoCarico).Value
            If (BooleanModificato(BennaFineCorsaInfAsse2, valoreBool, PlcInDigitali_Fatta)) Then
                Call CP240.ShowBenna(BennaVisualizzata = 1 Or BennaVisualizzata = 3)
            End If
        End If

'20150420
        If (InclusioneSiloS7) And Not SiloStatusLock Then
            '20150820
            'If .items(PLCTAG_SILOGEN_EMERG_ASSE_P).Value Or .items(PLCTAG_SILOGEN_EMERG_ASSE_P).Value Then
            If (.items(PLCTAG_ERR_ASSE_P).Value) Then
            '
                SiloStatus = Warning
                .items(PLCTAG_SILOGEN_MANUALE).Value = False
                .items(PLCTAG_SILOGEN_AUTOMATICO).Value = False
                Call SiloS7IconStatusUpdate
            ElseIf .items(PLCTAG_SILOGEN_MANUALE).Value Then
                SiloStatus = Man
            ElseIf .items(PLCTAG_SILOGEN_AUTOMATICO).Value Then
                SiloStatus = Auto
            ElseIf .items(PLCTAG_DB322_AbilitaJog).Value Or CP240.OPCData.items(PLCTAG_SILO2_AbilitaJog).Value Then
                SiloStatus = Jog
            Else
                valoreBool = Not (.items(PLCTAG_SILOGEN_MANUALE).Value And .items(PLCTAG_SILOGEN_AUTOMATICO).Value And .items(PLCTAG_DB322_AbilitaJog).Value And .items(PLCTAG_SILO2_AbilitaJog).Value)
                If (BooleanModificato(SiloStatusWarningMem, valoreBool, PlcInDigitali_Fatta)) Then
                    Call SiloS7WarnigEvent
                End If
                SiloStatus = Warning
            End If
        End If

        If (InclusioneSiloS7) Then
            valoreInt = SiloStatus
            If (IntegerModificato(SiloStatusMem, SiloStatus, True)) Then
                Call SiloS7IconStatusUpdate
            End If
        End If
'
        'Binario in posizione per scarico DIRETTO.
        valoreBool = .items(PLCTAG_DI_BinarioPosDiretto).Value
        If (BooleanModificato(BinarioOkScaricoDir, valoreBool, PlcInDigitali_Fatta)) Then
            Call SegnalazioneBennaSu(BennaSu)
        End If
        '

        If (Not VisualizzaBenna And InclusioneBenna) Then
            'Navetta
            valoreBool = .items(PLCTAG_DI_AsseP_NavettaAperta).Value
        ElseIf (VisualizzaBenna And InclusioneBenna) Then
            'Benna
            If (ListaSili(11).RitornoSelezionato) Then
                'Diretto
                If (InclusioneBennaApribile) Then
                    valoreBool = .items(PLCTAG_DI_AsseP_NavettaAperta).Value
                Else
                    valoreBool = MescolatoreAperto
                End If
                '20160121
            Else
                'MP15038
                If (.items(PLCTAG_Enable_Navetta_Con_Benna).Value) Then
                    If (ListaSili(12).RitornoSelezionato) Then
                        'Rifiuti --> ci va la benna
                        valoreBool = .items(PLCTAG_DI_AsseP_BennaFcSuperiore).Value
                    Else
                        'Silo diverso da Diretto e Rifiuti  --> ci va la navetta
                        valoreBool = .items(PLCTAG_DI_AsseA_BennaFcSuperiore).Value
                    'MP15038
                    End If
                Else
                    valoreBool = .items(PLCTAG_DI_AsseP_BennaFcSuperiore).Value
                End If
                '20160121
            End If
        Else
            'Ho il silo con i due deflettori
            valoreBool = MescolatoreAperto
        End If
        '

        'Caso benna+navetta
        '    If (BooleanModificato(BennaSu, .Items(PLCTAG_DI_AsseP_BennaFcSuperiore).value, PlcInDigitali_Fatta)) Then
        '        Call SegnalazioneBennaSu(BennaSu)
        '    End If

        If (BooleanModificato(NavettaInScarico, valoreBool, PlcInDigitali_Fatta)) Then
            Call SegnalazioneScaricoBennaNavetta(NavettaInScarico)
        End If

        posizioneErrore = 13


        If (AbilitaPuliziaFiltro) Then
            For indice = 0 To 31
                CamereFiltroInPulizia(indice) = .items(PLCTAG_DO_FiltCamera01 + indice).Value
            Next indice
            VisualizzaPuliziaFiltro
        End If
    
        valoreBool = .items(PLCTAG_DI_FiltSictempITT).Value
        If (BooleanModificato(SicurezzaTemperaturaFiltro, valoreBool, PlcInDigitali_Fatta)) Then
            AltaTemperaturaFiltro_change
        End If
    
        If (ValvolaPreseparatore.abilitato) Then
            valoreBool = .items(PLCTAG_DI_FiltValvPresepAp).Value
            If (BooleanModificato(ValvolaPreseparatore.ritorno, valoreBool, PlcInDigitali_Fatta)) Then
                ValvolaPreseparatoreRitorno_change
            End If
        End If

        If (InclusioneEvacuazioneFillerRecuperoDMR) Then
            valoreBool = .items(PLCTAG_DI_FiltAttuatAp01).Value
            If (BooleanModificato(RitornoEvacuazioneFiltroDMR, valoreBool, PlcInDigitali_Fatta)) Then
                Call EvacuazioneFiltroDMR_change
            End If
        End If
        
        If (InclusioneEvacuazioneSiloFiller) Then
            valoreBool = .items(PLCTAG_DI_EvacuazFillerSilo).Value
            RitornoEvacuazioneSiloFiller = valoreBool
        End If

        posizioneErrore = 14
    
        '   Blocco bruciatore.
        valoreBool = .items(PLCTAG_DI_BrucBlocco).Value
        If (BooleanModificato(ListaTamburi(0).BloccoFiammaBruciatore, valoreBool, PlcInDigitali_Fatta)) Then
            Call BloccoFiammaBruciatore_change(0)
        End If

        '   BRUCIATORE ACCESO.
        valoreBool = .items(PLCTAG_DI_BrucAcceso).Value
        If (BooleanModificato(ListaTamburi(0).FiammaBruciatorePresente, valoreBool, PlcInDigitali_Fatta)) Then
            Call FiammaBruciatorePresente_change(0)
            If (ListaTamburi(TamburoAssociatoAlPID).AvviamentoBruciatoreCaldo) Then
                Call MotoreAggiornaGrafica(MotoreRotazioneEssiccatore)
            End If
        End If
        
        '20160302
        valoreBool = .items(PLCTAG_MOT_AVVCALDO_SPEG).Value
        If (BooleanModificato(SpegnimentoCaldoInCorso, valoreBool, PlcInDigitali_Fatta)) Then
            If (SpegnimentoCaldoInCorso) Then
                ListaTamburi(0).MemPosModulatoreAvvioCaldo = ListaTamburi(0).posizioneModulatoreBruciatore
            End If
        End If
        '20160302
        
        '   Consenso start bruciatore da F.C. modulatore bruciatore
        valoreBool = .items(PLCTAG_DI_BrucPosAccensione).Value
        If (BooleanModificato(ListaTamburi(0).BruciatorePosizioneAccensione, valoreBool, PlcInDigitali_Fatta)) Then
            Call BruciatorePosizioneAccensione_change(0)
        End If

        If (ParallelDrum) Then
            '   Blocco bruciatore.
            valoreBool = .items(PLCTAG_DI_Bruciatore2Blocco).Value
            If (BooleanModificato(ListaTamburi(1).BloccoFiammaBruciatore, valoreBool, PlcInDigitali_Fatta)) Then
                Call BloccoFiammaBruciatore_change(1)
            End If

            '   BRUCIATORE ACCESO.
            valoreBool = .items(PLCTAG_DI_Bruciatore2Acceso).Value
            If (BooleanModificato(ListaTamburi(1).FiammaBruciatorePresente, valoreBool, PlcInDigitali_Fatta)) Then
                Call FiammaBruciatorePresente_change(1)
            End If

            '   Consenso start bruciatore da F.C. modulatore bruciatore
            valoreBool = .items(PLCTAG_DI_Bruciatore2ModulPosizAccens).Value
            If (BooleanModificato(ListaTamburi(1).BruciatorePosizioneAccensione, valoreBool, PlcInDigitali_Fatta)) Then
                Call BruciatorePosizioneAccensione_change(1)
            End If
        End If
        '
       
        If (Not LivelliFillerContinui) Then
            Dim livelloModificato As Boolean

            If (BooleanModificato(LivelloMinSiloFillerRecupero, .items(PLCTAG_DI_SiloFilMin01).Value, PlcInDigitali_Fatta)) Then
                livelloModificato = True
            End If

            If (BooleanModificato(LivelloMaxSiloFillerRecupero, .items(PLCTAG_DI_SiloFilMax01).Value, PlcInDigitali_Fatta)) Then
                livelloModificato = True
            End If

            If (livelloModificato) Then
                If Not LivelloMaxSiloFillerRecupero Then
                    Call AllarmeTemporaneo("VA003", False)
                End If
                Call LivelliDigitaliSiloFiller
            End If
        End If


        'Filler recupero
        If (InclusioneDMR) Then
            If (Not LivelliContinuiCameraEspansioneFillerRecupero) Then      '20151120
                Dim livelloDmrModificato As Boolean
                'livello minimo
                If (BooleanModificato(LivelloMinCameraEspansioneFillerRecupero, .items(PLCTAG_DI_SiloFilMinSxDMR).Value, PlcInDigitali_Fatta)) Then
                    livelloDmrModificato = True
                End If
                If (BooleanModificato(LivelloMin2CameraEspansioneFillerRecupero, .items(PLCTAG_DI_SiloFilMinDxDMR).Value, PlcInDigitali_Fatta)) Then
                    livelloDmrModificato = True
                End If
                'livello medio
                If (CameraEspansioneFillerRecupero) Then
                    If (BooleanModificato(LivelloMedCameraEspansioneFillerRecupero, .items(PLCTAG_DI_SiloFilMedSxDMR).Value, PlcInDigitali_Fatta)) Then
                        livelloDmrModificato = True
                    End If
                    If (BooleanModificato(LivelloMed2CameraEspansioneFillerRecupero, .items(PLCTAG_DI_SiloFilMedDxDMR).Value, PlcInDigitali_Fatta)) Then
                        livelloDmrModificato = True
                    End If
                End If
                'livello massimo
                If (BooleanModificato(LivelloMaxCameraEspansioneFillerRecupero, .items(PLCTAG_DI_SiloFilMaxSxDMR).Value, PlcInDigitali_Fatta)) Then
                    livelloDmrModificato = True
                End If
                If (BooleanModificato(LivelloMax2CameraEspansioneFillerRecupero, .items(PLCTAG_DI_SiloFilMaxDxDMR).Value, PlcInDigitali_Fatta)) Then
                    livelloDmrModificato = True
                End If
    
                If (livelloDmrModificato) Then
                    If Not (LivelloMaxCameraEspansioneFillerRecupero Or LivelloMax2CameraEspansioneFillerRecupero) Then
                        Call AllarmeTemporaneo("VA003", False)
                    End If
                    Call GestioneLivelliFiltroDMR
                End If
            End If
        End If
'20150624
'        If ((GestioneFiller2 = 1 Or GestioneFiller2 = 2) And Not LivelliFillerContinui) Then
       If ((GestioneFiller2 = FillerIncluso) Or (GestioneFiller2 = FillerSoloVisSilo)) And Not LivelliFillerContinui Then
'
            Dim livelloF2Modificato As Boolean

            If (BooleanModificato(FCMinSiloFiller2, .items(PLCTAG_DI_SiloFilMin02).Value, PlcInDigitali_Fatta)) Then
                livelloF2Modificato = True
            End If
            If (BooleanModificato(FCMedSiloFiller2, .items(PLCTAG_DI_SiloFilMed02).Value, PlcInDigitali_Fatta)) Then
                livelloF2Modificato = True
            End If
            If (BooleanModificato(FCMaxSiloFiller2, .items(PLCTAG_DI_SiloFilMax02).Value, PlcInDigitali_Fatta)) Then
                livelloF2Modificato = True
            End If

            If (livelloF2Modificato) Then
                If Not FCMaxSiloFiller2 Then
                    Call AllarmeTemporaneo("VA003", False)
                End If
                Call LivelliDigitaliSiloFiller
            End If

        End If

'20151030
''20150708
''        If (InclusioneF3 And Not LivelliFillerContinui) Then
'        If (InclusioneF3 Or (GestioneFiller3 = FillerSoloVisSilo)) And Not LivelliFillerContinui Then
       If ((GestioneFiller3 = FillerIncluso) Or (GestioneFiller3 = FillerSoloVisSilo)) And Not LivelliFillerContinui Then
'
            Dim livelloF3Modificato As Boolean

            If (BooleanModificato(FCMinSiloFiller3, .items(PLCTAG_DI_SiloFilMin03).Value, PlcInDigitali_Fatta)) Then
                livelloF3Modificato = True
            End If
            'If (BooleanModificato(FCMedSiloFiller3, .Items(PLCTAG_DI_SiloFilMed03).value, PlcInDigitali_Fatta)) Then
            '    livelloF3Modificato = True
            'End If
            If (BooleanModificato(FCMaxSiloFiller3, .items(PLCTAG_DI_SiloFilMax03).Value, PlcInDigitali_Fatta)) Then
                livelloF3Modificato = True
            End If

            If (livelloF3Modificato) Then
                Call LivelliDigitaliSiloFiller
            End If

        End If


        offsetAUX = PLCTAG_ComandiAux02_Uscita - PLCTAG_ComandiAux01_Uscita
        For comando = 0 To NumComandiVari - 1
            valoreBool = .items(PLCTAG_ComandiAux00_Ritorno + offsetAUX * comando).Value
            Call SetComandoRitorno(comando, valoreBool)
'20150721
            valoreBool = .items(PLCTAG_ComandiAux00_Termica + offsetAUX * comando).Value
            Call VerificaTermicaComando(comando, valoreBool)
'
        Next comando
        
        RitornoAspFresatoFreddo = .items(PLCTAG_DI_MixAttAspFumiAp).Value

        ScattoTermicaCocleaPesataF1 = .items(PLCTAG_DI_TermCocleaPesataF1).Value
        ScattoTermicaCocleaPesataF2 = .items(PLCTAG_DI_TermCocleaPesataF2).Value

        posizioneErrore = 15
        
        If (BooleanModificato(LivelloFillerRecupero, .items(PLCTAG_DI_TorLivMinTamponeF1).Value, PlcInDigitali_Fatta)) Then
            Call LivelloFillerRecupero_change
        End If
        If (BooleanModificato(LivelloFillerApporto, .items(PLCTAG_DI_TorLivMinTamponeF2).Value, PlcInDigitali_Fatta)) Then
            Call LivelloFillerApporto_change
        End If
        If (BooleanModificato(LivelloFillerApporto2, .items(PLCTAG_DI_TorLivMinTamponeF2).Value, PlcInDigitali_Fatta)) Then
            Call LivelloFillerApporto2_change
        End If

        If (BooleanModificato(ListaTamburi(0).AllarmePerditaValvoleBruc, Not .items(PLCTAG_DI_BrucPressGasOK).Value, PlcInDigitali_Fatta)) Then
            Call AllarmePerditaValvoleBruc_change(0)
        End If
        If (BooleanModificato(ListaTamburi(0).AllarmePressioneBrucAlta, .items(PLCTAG_DI_BrucBloccoLDU).Value, PlcInDigitali_Fatta)) Then
            Call AllarmePressioneBrucAlta_change(0)
        End If
        If (BooleanModificato(ListaTamburi(0).SicurezzaTempOlioComb, .items(PLCTAG_DI_BrucSicTempcomb).Value, PlcInDigitali_Fatta)) Then
            Call SicurezzaTempOlioComb_change(0)
        End If
        If (BooleanModificato(ListaTamburi(0).OlioCombInTemperatura, .items(PLCTAG_DI_BrucTempCombOK).Value, PlcInDigitali_Fatta)) Then
            Call OlioCombInTemperatura_change(0)
        End If
        If (BooleanModificato(ListaTamburi(0).PressioneInsufficienteOlioCombustibile, .items(PLCTAG_DI_BrucPressCombBass).Value, PlcInDigitali_Fatta)) Then
            Call PressioneInsufficienteOlioCombustibile_change(0)
        End If
        If (BooleanModificato(ListaTamburi(0).AllarmePerditaValvoleBrucOC, .items(PLCTAG_DI_AllTenutaValvoleOC).Value, PlcInDigitali_Fatta)) Then
            Call AllarmePerditaValvoleBrucOC_change(0)
        End If

        If (ParallelDrum) Then
            If (BooleanModificato(ListaTamburi(1).AllarmePerditaValvoleBruc, Not .items(PLCTAG_DI_PressioneGasOK2).Value, PlcInDigitali_Fatta)) Then
                Call AllarmePerditaValvoleBruc_change(1)
            End If
            If (BooleanModificato(ListaTamburi(1).AllarmePressioneBrucAlta, .items(PLCTAG_DI_BloccoLdu2).Value, PlcInDigitali_Fatta)) Then
                Call AllarmePressioneBrucAlta_change(1)
            End If
            If (BooleanModificato(ListaTamburi(1).SicurezzaTempOlioComb, .items(PLCTAG_DI_OlioCombustibile2_SicurezzaTemp).Value, PlcInDigitali_Fatta)) Then
                Call SicurezzaTempOlioComb_change(1)
            End If
            If (BooleanModificato(ListaTamburi(1).OlioCombInTemperatura, .items(PLCTAG_DI_OlioCombustibile2_TemperaturaOK).Value, PlcInDigitali_Fatta)) Then
                Call OlioCombInTemperatura_change(1)
            End If
            If (BooleanModificato(ListaTamburi(1).PressioneInsufficienteOlioCombustibile, .items(PLCTAG_DI_OlioCombustibile2_PressioneInsufficiente).Value, PlcInDigitali_Fatta)) Then
                Call PressioneInsufficienteOlioCombustibile_change(1)
            End If
            If (BooleanModificato(ListaTamburi(1).AllarmePerditaValvoleBrucOC, .items(PLCTAG_DI_OlioCombustibile2_AllarmeTenutaValvole).Value, PlcInDigitali_Fatta)) Then
                Call AllarmePerditaValvoleBrucOC_change(1)
            End If
        End If

        If (BooleanModificato(RitornoPesataFiller(0), .items(PLCTAG_DI_RitornoCocleaPesataF1).Value, PlcInDigitali_Fatta)) Then
            If (Not InclusioneTramoggiaTamponeF1) Then
                Call CocleaFillerRecuperoDaAccendere(True)
            End If
        End If
        If (BooleanModificato(RitornoPesataFiller(1), .items(PLCTAG_DI_RitornoCocleaPesataF2).Value, PlcInDigitali_Fatta)) Then
'20150624
            If (GestioneFiller2 = FillerSoloTramTamp) Then
                Call ComponenteInPesata(DosaggioFiller(1), RitornoPesataFiller(1))
            End If
'
            If (Not InclusioneTramoggiaTamponeF2) Then
                Call CocleaFillerApportoDaAccendere(True)
            End If
        End If
        If (BooleanModificato(RitornoPesataFiller(2), .items(PLCTAG_DI_RitornoCocleaPesataF3).Value, PlcInDigitali_Fatta)) Then
            
        End If

        For indice = 0 To 2
            Call VerificaRitornoPesataFiller(indice, ComandoPesataFiller(indice), RitornoPesataFiller(indice))
        Next indice

        posizioneErrore = 16

        If (BooleanModificato(ComandoPesataFiller(0), .items(PLCTAG_DO_PesataFill1).Value And Not .items(PLCTAG_SospensionePesate).Value, PlcInDigitali_Fatta)) Then
            Call ComandoPesataFiller_change(0)
        End If
        If (BooleanModificato(ComandoPesataFiller(1), .items(PLCTAG_DO_PesataFill2).Value And Not .items(PLCTAG_SospensionePesate).Value, PlcInDigitali_Fatta)) Then
            Call ComandoPesataFiller_change(1)
        End If
        If (BooleanModificato(ComandoPesataFiller(2), .items(PLCTAG_DO_PesataFill3).Value And Not .items(PLCTAG_SospensionePesate).Value, PlcInDigitali_Fatta)) Then
            Call ComandoPesataFiller_change(2)
        End If


        'NUMERO CICLI.
        If (LongModificato(CicliDosaggioEseguiti, .items(PLCTAG_CicliEseguiti).Value, PlcInDigitali_Fatta)) Then
            Call CicliDosaggioEseguiti_change
        End If
        '

        tempoDiMescolazione = ConvertiTempoS7toSEC(.items(PLCTAG_TempoMescolazioneInCorso).Value)
        tempoSetMescolazione = ConvertiTempoS7toSEC(.items(PLCTAG_setTempoMescolazione).Value)
        If (tempoDiMescolazione > tempoSetMescolazione) Then
            valoreLong = 0
        Else
            valoreLong = tempoSetMescolazione - tempoDiMescolazione
        End If
        If (LongModificato(TempoMescolazione, valoreLong, PlcInDigitali_Fatta)) Then
            Call TempoMescolazione_change
        End If

        posizioneErrore = 17


        If (BooleanModificato(MemFronteEmergenzaDosaggio, .items(PLCTAG_GestGenArrestoEmergenzaDosaggio).Value, PlcInDigitali_Fatta)) Then '20170302

            If .items(PLCTAG_GestGenArrestoEmergenzaDosaggio).Value Then
                
                CP240.Image1(65).Visible = CP240.Image1(64).Visible
                CP240.LblEtichetta(61).Visible = True
                CP240.Image1(64).Visible = Not CP240.Image1(64).Visible
                '20150707
                If lhPrinter <> 0 Then
                     Call StampaOgniDosaggioEnd
                End If
    '           '20160912
                UltimaBennata = False
                
                '20170301
                If DosaggioInCorso Then
                    Call LeggiNettiParziali
                    'Call DosaggioAutoMan(False) '20170302
                End If
                'fine 20170301
    
                CicloScaricoSiloCompleto = True '20170303
                
                '20170303
                If JobAttivo.StatusVB <> EnumStatoJobVB.Idle Then
                    Call InviaMessaggioJobEmergenzaXml
                End If
                '
    '
            Else
                CP240.Image1(65).Visible = False
                CP240.LblEtichetta(61).Visible = False
                CP240.Image1(64).Visible = False
            End If
        End If
    
'20170302
        If .items(PLCTAG_GestGenArrestoEmergenzaDosaggio).Value Then
            UltimaBennata = False
        End If
'

        'Quantità di bitume spruzzato nel mescolatore.
        If BitumeGravita Then
            If (DoubleModificato(BitSpruzzato, .items(PLCTAG_GravitaNettoB1Kg).Value + .items(PLCTAG_GravitaNettoB2Kg).Value, PlcInDigitali_Fatta)) Then
                Call BitSpruzzato_change
            End If
        Else
            If (DoubleModificato(BitSpruzzato, .items(PLCTAG_NettoBitume1).Value, PlcInDigitali_Fatta)) Then
                Call BitSpruzzato_change
            End If
        End If

        NettoViatop = RoundNumber(.items(PLCTAG_NettoViatop1).Value, 1)

        If (BooleanModificato(ValoreAltoTroppoPieno, .items(PLCTAG_DI_TorLivMaxNP).Value, PlcInDigitali_Fatta)) Then
            If (ValoreAltoTroppoPieno) Then
                AllarmeCicalino = True
            End If
        End If
        '
        If (ValoreAltoTroppoPieno) Then
            CP240.Picture1(1).Visible = Not CP240.Picture1(1).Visible
        Else
            CP240.Picture1(1).Visible = False
        End If


        'Fuori tolleranza aggregati
        valoreBool = .items(PLCTAG_All_Aggregati_FuoriTolleranza).Value
        If (BooleanModificato(BilanciaAggregati.FuoriTolleranza, valoreBool, PlcInDigitali_Fatta)) Then
            FuoriTollAggregati_change
        End If
    
        'Fuori tolleranza filler
        valoreBool = .items(PLCTAG_All_Filler_FuoriTolleranza).Value
        If (BooleanModificato(BilanciaFiller.FuoriTolleranza, valoreBool, PlcInDigitali_Fatta)) Then
            FuoriTollFiller_change
        End If
        
        'Fuori tolleranza RAP
        valoreBool = .items(PLCTAG_All_RAP_FuoriTolleranza).Value
        If (BooleanModificato(BilanciaRAP.FuoriTolleranza, valoreBool, PlcInDigitali_Fatta)) Then
            FuoriTollRiciclato_change
        End If
        
        'Fuori tolleranza
        valoreBool = .items(PLCTAG_All_SiwaBatch_FuoriTolleranza).Value
        If (BooleanModificato(BilanciaRAPSiwa.FuoriTolleranza, valoreBool, PlcInDigitali_Fatta)) Then
            FuoriTollRiciclato_change
        End If
    
        posizioneErrore = 18
        
        'Fuori tolleranza bitume
        If BitumeGravita Then
            valoreBool = .items(PLCTAG_All_BitumeGR_FuoriTolleranza).Value
        Else
            valoreBool = .items(PLCTAG_All_Bitume_FuoriTolleranza).Value
        End If
        '
        If (BooleanModificato(BilanciaLegante.FuoriTolleranza, valoreBool, PlcInDigitali_Fatta)) Then
            FuoriTollBitume_change
        End If
    
        'Fuori tolleranza viatop
        If (InclusioneViatop) Then
            valoreBool = .items(PLCTAG_All_Viatop_FuoriTolleranza).Value
            If (BooleanModificato(BilanciaViatop.FuoriTolleranza, valoreBool, PlcInDigitali_Fatta)) Then
                FuoriTollViatop_change
            End If
        End If
    
        'Fuori tolleranza contalitri
        valoreBool = .items(PLCTAG_All_Contalitri_FuoriTolleranza).Value
        If (BooleanModificato(FuoriTollContalitri, valoreBool, PlcInDigitali_Fatta)) Then
            Call FuoriTollContalitri_change
        End If


        'START BRUCIATORE
        If (BooleanModificato(ListaTamburi(0).StartBruciatoreDaPLC, .items(PLCTAG_DO_BrucStart).Value, PlcInDigitali_Fatta)) Then
            Call StartBruciatoreDaPLC_change(0)
        End If

        valoreBool = .items(PLCTAG_DO_BrucApModulatore).Value
        If (BooleanModificato(ListaTamburi(0).BruciatoreModulatoreApertura, valoreBool, PlcInDigitali_Fatta)) Then
            Call BruciatoreModulatore_change(0)
        End If
        valoreBool = .items(PLCTAG_DO_BrucChModulatore).Value
        If (BooleanModificato(ListaTamburi(0).BruciatoreModulatoreChiusura, valoreBool, PlcInDigitali_Fatta)) Then
            Call BruciatoreModulatore_change(0)
        End If

        If (ParallelDrum) Then
            'START BRUCIATORE
            If (BooleanModificato(ListaTamburi(1).StartBruciatoreDaPLC, .items(PLCTAG_DO_Bruciatore2Start).Value, PlcInDigitali_Fatta)) Then
                Call StartBruciatoreDaPLC_change(1)
            End If
            valoreBool = .items(PLCTAG_DO_ModulatoreBruc2Apertura).Value
            If (BooleanModificato(ListaTamburi(1).BruciatoreModulatoreApertura, valoreBool, PlcInDigitali_Fatta)) Then
                Call BruciatoreModulatore_change(1)
            End If
            valoreBool = .items(PLCTAG_DO_ModulatoreBruc2Chiusura).Value
            If (BooleanModificato(ListaTamburi(1).BruciatoreModulatoreChiusura, valoreBool, PlcInDigitali_Fatta)) Then
                Call BruciatoreModulatore_change(1)
            End If

            valoreBool = .items(PLCTAG_DI_FC_DeflettoreBypassATamburo_Tamb2).Value
            If (BooleanModificato(DeflettoreByPassTamburoParalleloFCTamburo, valoreBool, PlcInDigitali_Fatta)) Then
                Call GestioneDeflettoreByPassTamburoParallelo
            End If
            valoreBool = .items(PLCTAG_DI_FC_DeflettoreBypassANastro_Tamb2).Value
            If (BooleanModificato(DeflettoreByPassTamburoParalleloFCNastro, valoreBool, PlcInDigitali_Fatta)) Then
                Call GestioneDeflettoreByPassTamburoParallelo
            End If
        End If
        
        valoreBool = .items(PLCTAG_DI_SIWA_Batch_RitornoNastro).Value
        If (BooleanModificato(RAPSiwaInPesata, valoreBool, PlcInDigitali_Fatta)) Then
            Call RAPSiwaInPesata_change
        End If
        
        'Deflettore scivolo scarico bilancia riciclato
        valoreBool = .items(PLCTAG_FC_Defl_Scar_Bil_Ric_AP).Value
        If (BooleanModificato(DeflTramScivScarBilRicAperto, valoreBool, PlcInDigitali_Fatta)) Then
            Call Grafica_DeflTramScivScarBilRic
        End If
        valoreBool = .items(PLCTAG_FC_Defl_Scar_Bil_Ric_CH).Value
        If (BooleanModificato(DeflTramScivScarBilRicChiuso, valoreBool, PlcInDigitali_Fatta)) Then
            Call Grafica_DeflTramScivScarBilRic
        End If

        'Antiadesivo nello scivolo di scarico della bilancia del RAPSiwa
        If (AntiadesivoScivoloScarBilRAP.presente) Then
            valoreBool = .items(PLCTAG_DO_Antiadesivo_Sciv_Ric).Value
            If (BooleanModificato(AntiadesivoScivoloScarBilRAP.spruzzatura_on, valoreBool, PlcInDigitali_Fatta)) Then
                AntiadesivoScivoloScaricoBilanciaRAP_change
            End If
        End If
        
        'Non avendo il ritorno del finecorsa, leggo lo stato dell'uscita che comanda la portina
        valoreBool = .items(PLCTAG_DO_Flap_Antincendio_Tamb2).Value
        If (BooleanModificato(ListaTamburi(1).DeflettoreAntincendioTamburoAperto, valoreBool, PlcInDigitali_Fatta)) Then
            Call DeflettoreAntincendioTamburo_change(1)
        End If

        If (AbilitaRAPSiwa) Then
            NettoRAPSiwaBilancia = CLng(.items(PLCTAG_SIWA4_PROCESS_VALUE2).Value)
        End If
        'nettoRAPBilancia va gestito nel Pacchettomixer
        If AbilitaRAP Then
            NettoRAPBilancia = CLng(.items(PLCTAG_NettoRiciclato1).Value)
        End If

        If AbilitaDeflettoreAnello Or AbilitaDeflettoreAnelloElevatoreRic Then
            If (BooleanModificato(DeflettoreRiciclatoFcAnello, .items(PLCTAG_DI_BrucDeflRicTamb).Value, PlcInDigitali_Fatta)) Then
                FrmGestioneTimer.TimerDeflettoreRiciclato.enabled = True
            End If

            If (BooleanModificato(DeflettoreRiciclatoFcElevatore, .items(PLCTAG_DI_BrucDeflRicElev).Value, PlcInDigitali_Fatta)) Then
                FrmGestioneTimer.TimerDeflettoreRiciclato.enabled = True
            End If
        End If

        If (BooleanModificato(CambioRicettaPrenotato, .items(PLCTAG_PrenotaCambioRicDos).Value, PlcInDigitali_Fatta)) Then
            Call CambioRicettaPrenotato_change
            '20161202
            If (DosaggioInCorso) Then
                cambioVoloTempiAggRic = True
            End If
            If (Not DosaggioInCorso) Then
                Call ForzaSetTempi(True)
            End If
            '20161202

        End If

        If (ListaTamburi(0).AbilitazioneConsumoCombustibile) Then
            If (LongModificato(ListaTamburi(0).ImpulsiContalitriCombustibile, CLng(.items(PLCTAG_AI_Bruc_Contalitri_DI).Value), PlcInDigitali_Fatta)) Then
                Call ImpulsiContalitriCombustibile_change(0)
            End If
        End If

        If (Not DEMO_VERSION) Then
            valoreBool = .items(PLCTAG_BS_SIMULAZIONE).Value Or .items(PLCTAG_BS_SIMULAZIONE_OFFLINE).Value Or .items(PLCTAG_Simulatore_S7_interno).Value
            If (BooleanModificato(PlcSimulation, valoreBool, PlcInDigitali_Fatta)) Then
                If (PlcSimulation) Then
                    CP240.imgPulsanteForm(TBB_PLCIO).Picture = CP240.PlusImageList(0).ListImages("PLUS_IMG_TRAINING").Picture
                End If
            End If
        End If


        If ListaMotori(MotoreTrasportoFillerizzazioneFiltro).presente Then
            valoreBool = .items(PLCTAG_DI_Rit_Press_Fillerizz).Value
            If (BooleanModificato(PressioneCompressoreFillerizOK, valoreBool, PlcInDigitali_Fatta)) Then
                If PressioneCompressoreFillerizOK Then
                    'StartMotoreFillerizzazioneF1F2 (VelocitaFillerizzazione)
                Else
                    If ListaMotori(MotoreTrasportoFillerizzazioneFiltro).presente Then
                        AbortFillerizzazione
                        Call AllarmeTemporaneo("XX029", True)
                    End If
                End If
            End If
        End If

        If (BooleanModificato(BloccoScaricoMescolatore, .items(PLCTAG_DI_BloccoScMescolatore).Value, PlcInDigitali_Fatta)) Then
            CP240.Image1(2).Visible = BloccoScaricoMescolatore
        End If
        If (BooleanModificato(BloccoBenna, .items(PLCTAG_DI_BloccoBenna).Value, PlcInDigitali_Fatta)) Then
            CP240.Image1(0).Visible = BloccoBenna
        End If

        posizioneErrore = 20
    
        'If (AbilitaCelleCaricoSilo) Then
            '20151124 NUOVA GESTIONE SILO DEPOSITI

'            If (BooleanModificato(CelleSiloNavettaInScarico, .items(PLCTAG_DI_AsseP_NavettaAperta).Value, PlcInDigitali_Fatta)) Then
'                If (Not CelleSiloNavettaInScarico) Then
'                    Call CelleSiloConsenso_change(0)
'                    Call CelleSiloConsenso_change(1)
'                End If
'            End If
            'Consensi celle carico silo
'            spread = PLCTAG_CelleSilo_EnableCarico_2 - PLCTAG_CelleSilo_EnableCarico_1
'            spread2 = PLCTAG_CelleSilo_EnableScarico_2 - PLCTAG_CelleSilo_EnableScarico_1
'            For indice = 0 To 3
'                valoreBool = .items(PLCTAG_CelleSilo_EnableCarico_1 + (spread * indice)).Value
'                If (BooleanModificato(CelleSiloConsensoCarico_IN(indice), valoreBool, PlcInDigitali_Fatta)) Then
'                    Call CelleSiloConsenso_change(indice)
'                End If
'                valoreBool = .items(PLCTAG_CelleSilo_EnableScarico_1 + (spread2 * indice)).Value
'                If (BooleanModificato(CelleSiloConsensoScarico_OUT(indice), valoreBool, PlcInDigitali_Fatta)) Then
'                    Call CelleSiloConsenso_change(indice)
'                End If
'            Next indice
            Dim bscracth As Boolean
            Dim bscratch2 As Boolean '20161003
            
            'Impulso di 500msec da PLC per avvenuto Carico/Telescarico Silo
            'EventoCaricoSilo= carico Silo e SiloCar_Tele=scomparto caricato
            bscracth = IntegerModificato(SiloCar_Tele, .items(PLCTAG_SILI_HMI_Imp_Silo_Car_Tele).Value, PlcInDigitali_Fatta)
            
            bscratch2 = BooleanModificato(EventoCaricoSilo, .items(PLCTAG_SILI_HMI_Imp_Carico).Value, PlcInDigitali_Fatta)

'20170206 da verificare
'            If (bscracth And bscratch2) Then    '20161003
'                If (SiloCar_Tele >= 0 And SiloCar_Tele <= SILI_MAXPLC And EventoCaricoSilo) Then
'                     CaricoSilo_change SiloCar_Tele
'                    'If (BooleanModificato(EventoTelescarico, .items(PLCTAG_SILI_HMI_Imp_Telescarico).Value, PlcInDigitali_Fatta)) Then
'                        'nessuna azione
'                    'End If
'                End If
'            End If  '20161003
                        
            If (SiloCar_Tele >= 0 And SiloCar_Tele <= SILI_MAXPLC) Then
                If (BooleanModificato(EventoCaricoSilo, .items(PLCTAG_SILI_HMI_Imp_Carico).Value, PlcInDigitali_Fatta)) Then
                    'aggiornamento materiale
                    CaricoSilo_change SiloCar_Tele
                End If
                'If (BooleanModificato(EventoTelescarico, .items(PLCTAG_SILI_HMI_Imp_Telescarico).Value, PlcInDigitali_Fatta)) Then
                    'nessuna azione
                'End If
            End If
            'if () the


'20160418
'            If (BooleanModificato(SiliDepositoTrasfPar, .items(PLCTAG_SILI_HMI_TrasfPar).Value, PlcInDigitali_Fatta)) Then
'                'La lettura parte solo dopo il trasferimento parametri per non sporcare i valori iniziali dei pesi dei Sili Deposito
'                If (Not SiliDepositoTrasfPar And PlcInDigitali_Fatta) Then
                    AbilitaLetturaSiliDeposito = True
                    RinfrescoLetturaSiliDeposito = True
'                End If
'            End If
            
'            If (BooleanModificato(SiliParOk, .items(PLCTAG_SILI_HMI_ParametriOK).Value, PlcInDigitali_Fatta)) Then
'                If (SiliParOk And AbilitaLetturaSiliDeposito) Then
'                    'nel caso in cui venga fatta la MMC si deve disabilitare subito la lettura dai Sili
'                    'per evitare di memorizzare su file i pesi = 0 e quindi perderli
'                    AbilitaLetturaSiliDeposito = False
'                    DopoPrimoTrasferimentoSiliDeposito = False
'                End If
'            End If
'fine 20160418
                
             '20160127 Nuova Gestione Sili Deposito
            If (Not (AbilitaBilanciaCamion Or AbilitaCelleCaricoSilo)) Then
                If (BooleanModificato(CamionPresente, .items(PLCTAG_SILI_HMI_CamionPresente).Value, PlcInDigitali_Fatta)) Then
                    If ((Not CamionPresente) And PlcInDigitali_Fatta) Then
                        Call RegistraScaricoSiloDB
                    End If
                End If
            End If
            '20160127
            
            posizioneErrore = 21

            'Telescarichi silo
            spread = PLCTAG_DI_TelescaricoSilo02 - PLCTAG_DI_TelescaricoSilo01

        'End If
        
        For indice = 1 To MAXNUMSILI - 1
            valoreBool = .items(PLCTAG_DI_TelescaricoSilo01 + (spread * (indice - 1))).Value
            If (BooleanModificato(ListaSili(indice).Telescarico, valoreBool, PlcInDigitali_Fatta)) Then
                Call TelescarichiSilo_Change(indice)
            End If
        Next indice


        If PlcSchiumato.Abilitazione Then
            valoreBool = .items(PLCTAG_DI_FC_Valv3Vie_Schiumato_norm).Value
            If (BooleanModificato(Schiumato_FC_Valv3Vie_Norm, valoreBool, PlcInDigitali_Fatta)) Then
                
            End If
            valoreBool = .items(PLCTAG_DI_FC_Valv3Vie_Schiumato_Soft).Value
            If (BooleanModificato(Schiumato_FC_Valv3Vie_Soft, valoreBool, PlcInDigitali_Fatta)) Then
                
            End If
            Call PLCSchiumatoValv3VieBitume_Norm_Soft(Schiumato_FC_Valv3Vie_Norm, Schiumato_FC_Valv3Vie_Soft)
        End If

        If .items(PLCTAG_GrigliaVibranteRic1Abilita).Value Then
            CP240.ImgPala(0).Visible = .items(PLCTAG_DI_GrigliaVibrante_Ric1_PalaPresente).Value Or .items(PLCTAG_DO_GrigliaVibrante_Ric1).Value
        End If
        If .items(PLCTAG_GrigliaVibranteRic2Abilita).Value Then
            CP240.ImgPala(1).Visible = .items(PLCTAG_DI_GrigliaVibrante_Ric2_PalaPresente).Value Or .items(PLCTAG_DO_GrigliaVibrante_Ric2).Value
        End If
        If .items(PLCTAG_GrigliaVibranteRic3Abilita).Value Then
            CP240.ImgPala(2).Visible = .items(PLCTAG_DI_GrigliaVibrante_Ric3_PalaPresente).Value Or .items(PLCTAG_DO_GrigliaVibrante_Ric3).Value
        End If
        If .items(PLCTAG_GrigliaVibranteRic4Abilita).Value Then
            CP240.ImgPala(3).Visible = .items(PLCTAG_DI_GrigliaVibrante_Ric4_PalaPresente).Value Or .items(PLCTAG_DO_GrigliaVibrante_Ric4).Value
        End If

        If FrmNetti.Visible Then

            Call FrmNetti.RefreshTagDatiStatusBil
            Call FrmNetti.DatiStatusBil_Change

        End If
        posizioneErrore = 21
        
        'CountDown NV Troppo Pieno
        CP240.Frame1(46).Visible = CP240.OPCData.items(PLCTAG_NM_CountDown_NV).Value > 0
        CP240.LblEtichetta(70).caption = CP240.OPCData.items(PLCTAG_NM_CountDown_NV).Value

        'CountDown Rifiuti Troppo Pieno 20161129
        '20170331
        'CP240.Frame1(1).Visible = CP240.OPCData.items(PLCTAG_NM_CountDown_Rifiuti).Value > 0
        CP240.Frame1(1).Visible = (ValoreAltoTroppoPieno And CP240.OPCData.items(PLCTAG_NM_CountDown_Rifiuti).Value > 0)
        '
        CP240.LblEtichetta(34).caption = CP240.OPCData.items(PLCTAG_NM_CountDown_Rifiuti).Value

        'Avviamento a Caldo
        CP240.OPCData.items(PLCTAG_NM_IN_BRUC_AL_TEMP_ENT_FILTRO) = SuperamentoSogliaAllarmeTemperaturaFiltro


        Dim CambioMod As Boolean
        CambioMod = False
        'Gestione Automatica: sul fronte del cambiamento della modalità resetto il comando che mi ha portato nella nuova modalità
        If (BooleanModificato(MotorManagementPlcAutomatic, .items(PLCTAG_NM_MOTORI_StatoAutomatico).Value, PlcInDigitali_Fatta)) Then
            Call GestionePulsantiTipoFunzMot(True)

            If (MotorManagementPlcAutomatic) Then

                Call UpdateManagement(AutomaticMotor)
                '20170223
                'If (FrmMotoriVisibile) Then
                '    Call AvvMotori.CambioMod(MotorManagementEnum.AutomaticMotor)
                'End If
                '
                'reset del comando
                CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdAutomatico).Value = False
                CP240.OPCData.items(PLCTAG_NM_MOTORI_StartSequenza).Value = False
                'disabilito inversione Test Pred e PCL
               ' CP240.CmdNettiSiloStoricoSommaSalva(18).enabled = True
                CambioMod = True
                'CP240.CmdNettiSiloStoricoSommaSalva(16).enabled = False
                'abilito avviamento a caldo
                'CP240.CmdAvviamentoBruciatoreCaldo(0).enabled = True
                '20150511AbilitaAvvCaldo

                Dim posizione As Integer
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "VA002", "IdDescrizione")
                IngressoAllarmePresente posizione, False
            End If
                        
        End If
        
        'Gestione SemiAutomatica: sul fronte del cambiamento della modalità resetto il comando che mi ha portato nella nuova modalità
        If (BooleanModificato(MotorManagementPlcSemiAutomatic, .items(PLCTAG_NM_MOTORI_StatoSemiAutomatico).Value, PlcInDigitali_Fatta)) Then
            Call GestionePulsantiTipoFunzMot(True)

            If (MotorManagementPlcSemiAutomatic) Then
                'Se si và in semiautomatica al termine di una sequenza di avvio ridotta o di spegnimento
                If (SequenzaInCorso) Then
                    CP240.OPCData.items(PLCTAG_NM_MOTORI_StopSequenza).Value = False
                    CP240.OPCData.items(PLCTAG_NM_MOTORI_AvviamentoRidotto).Value = False
                End If
                Call UpdateManagement(SemiAutomaticMotor)
                '20170223
                'If (FrmMotoriVisibile) Then
                '    Call AvvMotori.CambioMod(MotorManagementEnum.SemiAutomaticMotor)
                'End If
                '
                'reset del comando
                CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdSemiAutomatico).Value = False
                CP240.OPCData.items(PLCTAG_NM_MOTORI_StartSequenza).Value = False
                'abilito inversione Test Pred e PCL
                CambioMod = True
                'abilito avviamento a caldo
                '20150511AbilitaAvvCaldo
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "VA002", "IdDescrizione")
                If AutomaticoPredosatori Then
                    IngressoAllarmePresente posizione, True
                End If
            
            End If
        End If

        'Gestione Forcing: sul fronte del cambiamento della modalità resetto il comando che mi ha portato nella nuova modalità
        If (BooleanModificato(MotorManagementPlcForcing, .items(PLCTAG_NM_MOTORI_StatoManutenzione).Value, PlcInDigitali_Fatta)) Then
            Call GestionePulsantiTipoFunzMot(True)

            If (MotorManagementPlcForcing) Then
                Call UpdateManagement(ForcingMotor)
                '20170223
                'If (FrmMotoriVisibile) Then
                '    Call AvvMotori.CambioMod(MotorManagementEnum.ForcingMotor)
                'End If
                '
                'reset del comando
                CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdManutenzione).Value = False
                'disabilito inversione Test Pred e PCL
                CambioMod = True
                'abilito avviamento a caldo
                '20150511AbilitaAvvCaldo
            End If
        End If
        If (CambioMod) Then
            Call CP240.AbilitaCalibrazione
            Call CP240.AbilitaInversionePCL
            '20170223
            If (FrmMotoriVisibile) Then
                Call AvvMotori.CambioMod
            End If
            '
            CambioMod = False
        End If

        'Sequenza In corso
        If (BooleanModificato(SequenzaInCorso, .items(PLCTAG_NM_OUT_SeqInCorso).Value, PlcInDigitali_Fatta)) Then
            '20151120
            'If (.items(PLCTAG_NM_OUT_SeqInCorso).Value) Then
            '    SequenzaInCorso = True
            '    CP240.lblEtichetta(118).Visible = True '20150511
            'Else
            '    SequenzaInCorso = False
            '    CP240.lblEtichetta(118).Visible = False '20150511
            'End If
            CP240.LblEtichetta(118).Visible = SequenzaInCorso
            '

            '20151130
            If (SequenzaInCorso) Then
                Call IngressoAllarmePresente(DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "AM000", "IdDescrizione"), False)
            Else
                'Non si deve più controllare la sequenza
                TmrTimeoutSequenzaInCorso = 0
            End If
            '
        End If

        'Per risolvere il problema dell'aggiornamento della grafica del sinottico rispetto al fomr motori appena parte la sirena viene riaggiornata
        '(quindi non viene aggiornata solo sul fronte del ritorno reale)
        If (BooleanModificato(SirenaInCorso, .items(PLCTAG_NM_OUT_Ciclo_Sirena).Value, PlcInDigitali_Fatta)) Then
            Dim i As Integer
            For i = 1 To MAXMOTORI
                Call MotoreAggiornaGrafica(i)
            Next i

            Call GestionePulsantiTipoFunzMot(Not SirenaInCorso)
            Call MotorManagementPlcSirena_change
        End If
        'Prenotazione Avviamento a Caldo
        If (BooleanModificato(MotorPrenotaAvvCaldo, .items(PLCTAG_NM_OUT_PrenotaAvvCaldo).Value, PlcInDigitali_Fatta)) Then
            Call AbilitaAvvCaldo
        End If
        'Uscita alla Sirena
        If (BooleanModificato(MotorManagementPlcOutSirena, .items(PLCTAG_NM_OUT_Sirena).Value, PlcInDigitali_Fatta)) Then
            'Call MotorManagementPlcSirena_change
        End If
        'Pausa Sirena
        If (IntegerModificato(MotorManagementPlcCountDownPausaSirena, .items(PLCTAG_NM_COUNTDOWN_PAUSA_Sirena).Value, PlcInDigitali_Fatta)) Then
            Call MotorManagementPlcSirena_change
        End If
        'Lavoro Sirena
        If (IntegerModificato(MotorManagementPlcCountDownLavoroSirena, .items(PLCTAG_NM_COUNTDOWN_LAVORO_Sirena).Value, PlcInDigitali_Fatta)) Then
            Call MotorManagementPlcSirena_change
        End If
        'CountDown Logica NV
        If (IntegerModificato(MotorManagementPlcCountDownMaxNv, .items(PLCTAG_NM_COUNTDOWN_MAX_Nv).Value, PlcInDigitali_Fatta)) Then
            Call MotorManagementPlcTroppoPienoNV_change
        End If
        'Motore corrente in Spegnimento/Avviamento
        If (IntegerModificato(MotorManagementPlcMotoreAvviamentoSpegnimento, .items(PLCTAG_NM_MOTORE_AvviamentoSpegnimento).Value, PlcInDigitali_Fatta)) Then
            '20151130
            'Call MotorManagementPlcCountDown_change
            Call MotorManagementPlcCountDown_change(True)
            '
        End If
        'CountDown Motore Avviamento
        If (IntegerModificato(MotorManagementPlcCountDownMotoreAvviamento, .items(PLCTAG_NM_COUNTDOWN_MOTORE_Avviamento).Value, PlcInDigitali_Fatta)) Then
            '20151130
            'Call MotorManagementPlcCountDown_change
            Call MotorManagementPlcCountDown_change(False)
            '
        End If
        'CountDown Motore Spegnimento
        If (IntegerModificato(MotorManagementPlcCountDownMotoreSpegnimento, .items(PLCTAG_NM_COUNTDOWN_MOTORE_Spegnimento).Value, PlcInDigitali_Fatta)) Then
            '20151130
            'Call MotorManagementPlcCountDown_change
            Call MotorManagementPlcCountDown_change(False)
            '
        End If
        
        'Dosaggio in Corso= sul fronte del dosaggio in corso disabilito la possibilita' di lanciare la sequenza di spegnimento motori
        If (BooleanModificato(DosaggioInCorsoApp, DosaggioInCorso, PlcInDigitali_Fatta)) Then   '20150109
            Call GestionePulsantiTipoFunzMot(Not DosaggioInCorso)
        End If
                                    
'20170222
'20150109
'        If BooleanModificato(PlcParametriOk, CP240.OPCData.items(PLCTAG_NM_ParametriOK).Value , True) Then
        If BooleanModificato(PlcParametriOk, CP240.OPCData.items(PLCTAG_NM_ParametriOK).Value And CP240.OPCData.items(PLCTAG_SILI_HMI_ParametriOK).Value, True) Then
'
            If (Not PlcParametriOk And EnableControlloComunicazione) Then
                Call SetAllarmePresente("VA005", True)   '20150109
            Else
                Call SetAllarmePresente("VA005", False)   '20150109
            End If

            '20160923
'            CP240.StatusBar1.Panels(STB_STATOPARAM).text = IIf(PlcParametriOk, "", "KO")
            '
            Call CP240StatusBar_Change(STB_STATOPARAM, PlcParametriOk) '20161018
        
        End If
'
    
'20150630
        If BooleanModificato(avvCaldo_prenotazione, CP240.OPCData.items(PLCTAG_AvvCaldo_Prenotazione).Value, True) Then
            If (Not avvCaldo_prenotazione) Then
                ListaTamburi(0).AvviamentoBruciatoreCaldo = False
            End If
        End If
'

'20151020
        If BooleanModificato(DustfixEnable, CP240.OPCData.items(PLCTAG_IN_DUSTFIX_ENABLE).Value, True) Then
            CP240.ImgDustFix.Visible = DustfixEnable
            CP240.ImgDustFix.Picture = LoadResPicture("IDB_DUSTFIX_OFF", vbResBitmap)
            Call GraficaDustFix
        End If
'
        
        '20150731
        '20151020
        'If (.items(PLCTAG_IN_DUSTFIX_ENABLE).Value) Then
        If (DustfixEnable) Then
'
            If BooleanModificato(TermicaDustfix, CP240.OPCData.items(PLCTAG_IN_DUSTFIX_TERM).Value, True) Then
                GraficaDustFix
            End If
            If BooleanModificato(PompaDustfix, CP240.OPCData.items(PLCTAG_IN_RIT_POMPA_DUSTFIX).Value, True) Then
                GraficaDustFix
            End If
            If BooleanModificato(MixerDustfix, CP240.OPCData.items(PLCTAG_IN_RIT_MIXER_DUSTFIX).Value, True) Then
                GraficaDustFix
            End If
        End If
    
'20150513
        If (BooleanModificato(Trasf_dati_PLC_scarico, .items(PLCTAG_TrasfDatiPlcDosaggio).Value, PlcInDigitali_Fatta)) Then    '20150109
            Call CompilaListaCistDosaggio
            Call GestioneMaterialeCisterneRidotto
        End If
'

        '20160923
        ''20151108
        'If .items(PLCTAG_EN_Valvola_Diesel).Value Then
        '    If (BooleanModificato(ValvolaDieselAperta, .items(PLCTAG_FC_Valvola_Diesel_AP).Value, PlcInDigitali_Fatta)) Then
        '        Call AggiornaGraficaValvolaDiesel_Change(True)
        '    End If
        'Else
        '    Call AggiornaGraficaValvolaDiesel_Change(False)
        'End If
        If (BooleanModificato(ValvolaDieselPresente, .items(PLCTAG_EN_Valvola_Diesel).Value, PlcInDigitali_Fatta)) Then
            Call AggiornaGraficaValvolaCombustibile_Change
        End If
        If (ValvolaDieselPresente) Then
            If (BooleanModificato(ValvolaDieselAperta, .items(PLCTAG_FC_Valvola_Diesel_AP).Value, PlcInDigitali_Fatta)) Then
                Call AggiornaGraficaValvolaCombustibile_Change
            End If
        End If
        If (BooleanModificato(ValvolaOlioCombPresente, .items(PLCTAG_EN_Valvola_OlioComb).Value, PlcInDigitali_Fatta)) Then
            Call AggiornaGraficaValvolaCombustibile_Change
        End If
        If (ValvolaOlioCombPresente) Then
            If (BooleanModificato(ValvolaOlioCombAperta, .items(PLCTAG_FC_Valvola_OlioComb_AP).Value, PlcInDigitali_Fatta)) Then
                Call AggiornaGraficaValvolaCombustibile_Change
            End If
        End If
        '

        If (BooleanModificato(ValvolaPreseparatoreAnello.ritorno, .items(PLCTAG_DI_ValvPresepAnello_Ap).Value, PlcInDigitali_Fatta)) Then
            Call ValvolaPreseparatoreAnelloRitorno_change
        End If

        '20161024
'        If (BooleanModificato(BilanciaAggregati.ProfiNet, .items(PLCTAG_BIL_PNET_Aggregati_Presenza).Value, PlcInDigitali_Fatta)) Then
'        End If
'        If (BooleanModificato(BilanciaFiller.ProfiNet, .items(PLCTAG_BIL_PNET_Filler_Presenza).Value, PlcInDigitali_Fatta)) Then
'        End If
'        If (BooleanModificato(BilanciaLegante.ProfiNet, .items(PLCTAG_BIL_PNET_Bitume_Presenza).Value, PlcInDigitali_Fatta)) Then
'        End If
'        If (BooleanModificato(BilanciaRAP.ProfiNet, .items(PLCTAG_BIL_PNET_Riciclato_Presenza).Value, PlcInDigitali_Fatta)) Then
'        End If
'        If (BooleanModificato(BilanciaViatop.ProfiNet, .items(PLCTAG_BIL_PNET_Viatop_Presenza).Value, PlcInDigitali_Fatta)) Then
'        End If
'        If (BooleanModificato(BilanciaViatopScarMixer2.ProfiNet, .items(PLCTAG_BIL_PNET_Viatop2_Presenza).Value, PlcInDigitali_Fatta)) Then
'        End If
                
        '20170331
        ''20161104
        'CP240.CmdNettiSiloStoricoSommaSalva(0).enabled = (BilanciaAggregati.ProfiNet Or BilanciaFiller.ProfiNet Or BilanciaLegante.ProfiNet _
        '    Or BilanciaRAP.ProfiNet Or BilanciaViatop.ProfiNet Or BilanciaViatopScarMixer1.ProfiNet Or BilanciaViatopScarMixer2.ProfiNet Or DEBUGGING) _
        '    And (ActiveUser >= UsersEnum.OPERATOR) And MemStatoDosaggio <> StatusDosaggio.DOSAGGIO_STATUS_AUTO_RUN And MemStatoDosaggio <> StatusDosaggio.DOSAGGIO_STATUS_AUTO_LAST
        CP240.CmdNettiSiloStoricoSommaSalva(0).enabled = ( _
            ActiveUser >= UsersEnum.OPERATOR And _
            MemStatoDosaggio <> StatusDosaggio.DOSAGGIO_STATUS_AUTO_RUN And _
            MemStatoDosaggio <> StatusDosaggio.DOSAGGIO_STATUS_AUTO_LAST _
            )
        ''
        '
                
        '20161107
        BilanciaAggregati.Errore = .items(PLCTAG_BIL_PNET_Aggregati_Errore).Value And BilanciaAggregati.ProfiNet
        BilanciaFiller.Errore = .items(PLCTAG_BIL_PNET_Filler_Errore).Value And BilanciaFiller.ProfiNet
        BilanciaLegante.Errore = .items(PLCTAG_BIL_PNET_Bitume_Errore).Value And BilanciaLegante.ProfiNet
        BilanciaRAP.Errore = .items(PLCTAG_BIL_PNET_Riciclato_Errore).Value And BilanciaRAP.ProfiNet
        BilanciaViatop.Errore = .items(PLCTAG_BIL_PNET_Viatop_Errore).Value And BilanciaViatop.ProfiNet
        BilanciaViatopScarMixer1.Errore = .items(PLCTAG_BIL_PNET_Viatop_Errore).Value And BilanciaViatopScarMixer1.ProfiNet
        BilanciaViatopScarMixer2.Errore = .items(PLCTAG_BIL_PNET_Viatop2_Errore).Value And BilanciaViatopScarMixer2.ProfiNet
        '
               
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI) Then
            If (BooleanModificato(BilanciaPnErrore, .items(PLCTAG_BIL_PNET_Aggregati_Errore).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER) Then
            If (BooleanModificato(BilanciaPnErrore, .items(PLCTAG_BIL_PNET_Filler_Errore).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME) Then
            If (BooleanModificato(BilanciaPnErrore, .items(PLCTAG_BIL_PNET_Bitume_Errore).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_RICICLATO) Then
            If (BooleanModificato(BilanciaPnErrore, .items(PLCTAG_BIL_PNET_Riciclato_Errore).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP) Then
            If (BooleanModificato(BilanciaPnErrore, .items(PLCTAG_BIL_PNET_Viatop_Errore).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2) Then
            If (BooleanModificato(BilanciaPnErrore, .items(PLCTAG_BIL_PNET_Viatop2_Errore).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        '
        
        
        
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI) Then
            If (BooleanModificato(BilanciaPnCmdRun, .items(PLCTAG_BIL_PNET_Aggregati_Cmd_InCorso).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER) Then
            If (BooleanModificato(BilanciaPnCmdRun, .items(PLCTAG_BIL_PNET_Filler_Cmd_InCorso).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME) Then
            If (BooleanModificato(BilanciaPnCmdRun, .items(PLCTAG_BIL_PNET_Bitume_Cmd_InCorso).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_RICICLATO) Then
            If (BooleanModificato(BilanciaPnCmdRun, .items(PLCTAG_BIL_PNET_Riciclato_Cmd_InCorso).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
                                              
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP) Then
            If (BooleanModificato(BilanciaPnCmdRun, .items(PLCTAG_BIL_PNET_Viatop_Cmd_InCorso).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        If (BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2) Then
            If (BooleanModificato(BilanciaPnCmdRun, .items(PLCTAG_BIL_PNET_Viatop2_Cmd_InCorso).Value, PlcInDigitali_Fatta)) Then
                Call StatusCalibrazioneBilPN '20161104
            End If
        End If
        '

        '20161122
        If (BooleanModificato(BilanciaStatus(IDAdditivoFlomac).DosaggioAttivo, .items(PLCTAG_DI_Pesata_In_Corso_FLOM).Value, PlcInDigitali_Fatta)) And InclusioneAddFlomac Then
            'Call AggiornaGraficaFlomac_Change 20161128
        End If
        '
    
    End With
'20161024
'    If (Not PlcInDigitali_Fatta) Then
'       BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_NONE
'       BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_NONE
'    End If
    PlcInDigitali_Fatta = True

    Exit Sub
Errore:
    LogInserisci True, "NET-005 (" + CStr(posizioneErrore) + ")", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PlcCommunicationError()

    Dim motore As MotoriEnum
    Dim comando As ComandiVariEnum

    'Alla perdita della comunicazione resetta un po' di roba
    For comando = 0 To NumComandiVari - 1
        Call SetComandoUscita(comando, False)
    Next comando
    
    If (MotorManagement <> AutomaticMotor) Then
        For motore = 1 To MAXMOTORI
            Call NMSetMotoreUscita(motore, False)
        Next motore
    End If

    Call PulsanteManualePremuto
    Call AttivazioneSirena(False)

End Sub

Public Sub Main()

    Dim hMutex As Long

On Error GoTo Errore

    'DEMO
    DEMO_VERSION = False
Debug.Assert (Not DEMO_VERSION)
    PlcDisabilitaConnessione = DEMO_VERSION

    '   Mette a posto la localizzazione per evitare che l'utente possa
    '   non fare andare più niente (da pannello di controllo)
    SetLocaleInfo LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, ","
    SetLocaleInfo LOCALE_USER_DEFAULT, LOCALE_STHOUSAND, "."
    SetLocaleInfo LOCALE_USER_DEFAULT, LOCALE_SSHORTDATE, "dd/MM/yyyy"
    SetLocaleInfo LOCALE_USER_DEFAULT, LOCALE_STIME, ":"
    SetLocaleInfo LOCALE_USER_DEFAULT, LOCALE_STIMEFORMAT, "HH:mm:ss"
    SetLocaleInfo LOCALE_USER_DEFAULT, LOCALE_ILZERO, "1"

    InstallationPath = GetSystemFolder(CSIDL_PROGRAM_FILES) + "Cybertronic 500\"
    UserDataPath = GetPlantInfoString(PI_USERDATAPATH, "C:\FAYAT\Cybertronic 500\UserData\")
    Call CreatePath(UserDataPath)
    InstallDataPath = GetPlantInfoString(PI_INSTALLDATAPATH, "C:\FAYAT\Cybertronic 500\InstallData\")
    Call CreatePath(InstallDataPath)
    GraphicPath = GetPlantInfoString(PI_GRAPHICPATH, "C:\FAYAT\Cybertronic 500\InstallData\Grafica\")
    Call CreatePath(GraphicPath)
    LogPath = GetPlantInfoString(PI_LOGPATH, "C:\FAYAT\Cybertronic 500\Log\")
    Call CreatePath(LogPath)

    DEBUGGING = (Not ControlloChiaveHL)
        
    'Controllo esecuzione programma
    'Tenta di creare un nuovo Mutex
    hMutex = CreateMutex(ByVal 0&, 1, app.Title)

    'Controlla se esiste già
    If (Not DEBUGGING And Err.LastDllError = ERROR_ALREADY_EXISTS) Then
        'Trovata più di una istanza
        'Rilascia le risorse ed esce
        ReleaseMutex hMutex
        CloseHandle hMutex
        End
    End If
    '

    DataStartCyb500 = Now

    Call PredosatoreInizializza

    Set ParameterPlus = New Configuration
    Set PacchettoDatixml = New XmlJobs '20161223
                       
'    SelezioneRegPid1 = True
'    ResetPID = True

'20170223
    BilanciaAggregati.CompAttivo = -1
    BilanciaFiller.CompAttivo = -1
    BilanciaLegante.CompAttivo = -1
    BilanciaRAP.CompAttivo = -1
    BilanciaRAPSiwa.CompAttivo = -1
    BilanciaViatop.CompAttivo = -1
    BilanciaViatopScarMixer1.CompAttivo = -1
    BilanciaViatopScarMixer2.CompAttivo = -1
    UltimaBennata = False '20170302
    UltimoImpastoCompletato = False '20170302
    CicloScaricoSiloCompleto = True '20170303
'

    Call CP240.Show

    Exit Sub
Errore:
    LogInserisci True, "NET-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function VideataPrincipale()

    Dim TimerInizio As Long
    Dim TimerParziale As Long
    Dim nomeFunzione As String

	On Error GoTo Errore

    TimerVideataPrincipale = LogFunction("TimerVideataPrincipale", TimerVideataPrincipale = 0, TimerVideataPrincipale)
    TimerInizio = LogFunction("VideataPrincipale", True)

    TimerParziale = TimerInizio

    '20170223
    If DEBUGGING And PlcSimulation Then
        Call BilAgg_change
        Call BilFiller_change
        Call BilBit_change
        Call BilRAP_Change
        Call BilanciaViatopPeso_change
    End If
    '
    
    nomeFunzione = "ScriviOra"
    Call ScriviOra
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GraficaTempoMescolazione"
    Call GraficaTempoMescolazione
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneCambioRicettaDosaggio"
    Call GestioneCambioRicettaDosaggio
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "DatiResiduiNetti"
    Call DatiResiduiNetti
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneBilanciaRAPSiwa"
    Call GestioneBilanciaRAPSiwa
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneAdditivoSacchi"
    Call GestioneAdditivoSacchi
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneRiciclatoInTramoggia"
    Call GestioneRiciclatoInTramoggia
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloPosizioneDeflVaglio"
    Call ControlloPosizioneDeflVaglio
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneAspFresatoFreddo"
    Call GestioneAspFresatoFreddo
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneDosaggioBitumeEsterno"
    Call GestioneDosaggioBitumeEsterno
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlliFiammaBruciatore(0)"
    Call ControlliFiammaBruciatore(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneFunzAutomaticoBruc(0)"
    Call GestioneFunzAutomaticoBruc(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneModulatoreBruc(0)"
    Call GestioneModulatoreBruc(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ArrestoBrucTempoX(0)"
    Call ArrestoBrucTempoX(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloCadutaTamburoFiamma(0)"
    Call ControlloCadutaTamburoFiamma(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloBloccoBruciatore(0)"
    Call ControlloBloccoBruciatore(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ConteggioTempoArrestoBruciatore(0)"
    Call ConteggioTempoArrestoBruciatore(0)
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    If (ParallelDrum) Then
        nomeFunzione = "ControlliFiammaBruciatore(1)"
        Call ControlliFiammaBruciatore(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "GestioneFunzAutomaticoBruc(1)"
        Call GestioneFunzAutomaticoBruc(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "GestioneModulatoreBruc(1)"
        Call GestioneModulatoreBruc(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "ArrestoBrucTempoX(1)"
        Call ArrestoBrucTempoX(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "ControlloCadutaTamburoFiamma(1)"
        Call ControlloCadutaTamburoFiamma(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "ControlloBloccoBruciatore(1)"
        Call ControlloBloccoBruciatore(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "ConteggioTempoArrestoBruciatore(1)"
        Call ConteggioTempoArrestoBruciatore(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

        nomeFunzione = "AltaTemperaturaFumiTamburo(1)"
        Call AltaTemperaturaFumiTamburo(1)
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)
    
    End If

    nomeFunzione = "ArrestoBrucITT"
    Call ArrestoBrucITT
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "AltaTemperaturaFiltroSw"
    Call AltaTemperaturaFiltroSw
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)
    
    nomeFunzione = "AvviamentoGestionePredosatori"
    Call AvviamentoGestionePredosatori
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneConsumi"
    Call GestioneConsumi
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloRicFreddo"
    'Call ControlloRicFreddo
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloRicCaldo"
    'Call ControlloRicCaldo
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloRicJolly"
    'Call ControlloRicJolly
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneDeflettoreMulino"
    Call GestioneDeflettoreMulino
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneRifrantumazioneRiciclato"
    Call GestioneRifrantumazioneRiciclato
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "SiloGenerale"
    Call SiloGenerale
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneVaglio"
    Call GestioneVaglio
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "VerificaMotoriAccesi"
    Call VerificaMotoriAccesi
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloAsservimenti"
    Call ControlloAsservimenti
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneAspirazioneFiltro"
    Call GestioneAspirazioneFiltro
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneValvolaPreseparatore"
    Call GestioneValvolaPreseparatore
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)
	'20151107
    nomeFunzione = "GestioneValvolaPreseparatoreAnello"
    Call GestioneValvolaPreseparatoreAnello
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)
	'
    nomeFunzione = "ControlloAllarmi"
    Call ControlloAllarmi
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "ControlloLivelliAltiTramogge"
    Call ControlloLivelliAltiTramogge
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "GestioneSicurezzaBilanciaRAP"
    Call GestioneSicurezzaBilanciaRAP
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "CistGestioneLoop"
    Call CistGestioneLoop
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    nomeFunzione = "TimeOutDosaggio"
    Call TimeOutDosaggio
    TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)

    If AbilitaManutenzioni Then
        nomeFunzione = "ComunicazioneConManutenzioni"
        Call ComunicazioneConManutenzioni
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)
    End If

	'20160729
    If InclusioneAquablack Then
        nomeFunzione = "AQ_Ciclo" '20170112
        Call AQ_Ciclo
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale) '20170112
    End If
	'

	'20170112
    If 1 Then 'TODO test per attivare o no i job da parametri
        nomeFunzione = "CicloJob" '20170112
        Call CicloJob
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale) '20170112
    End If
'

    nomeFunzione = "Fine funzioni"

    'Deve fare il test degli allarmi solo dopo aver caricato completamente la Form CP240,
    'meglio se ritardo di un paio di secondi, altrimenti ho degli allarmi non veri!
    If AbilitaControlloAllarmi = 2 Then
        nomeFunzione = "ControllaIngressiAllarmi"
        Call ControllaIngressiAllarmi
        TimerParziale = LogFunction(nomeFunzione, False, TimerParziale)
    End If

    If (PlusWatchDogTimer = 0 Or (ConvertiTimer() - PlusWatchDogTimer >= 15)) Then
        Call SendMessagetoPlus(PlusSendWatchDog, IIf(PlusWatchDog, 1, 0))
        PlusWatchDog = (Not PlusWatchDog)
        PlusWatchDogTimer = ConvertiTimer()

        '20151119
        'Lo mette rosso in modo che se non risponde subito il C#, rimane in "errore"
'        CP240.StatusBar1.Panels(STB_WATCHDOGCS).Picture = LoadResPicture("IDI_LEDROSSO", vbResIcon)
        
        '20161014
        Call CP240StatusBar_Change(STB_WATCHDOGCS, False)
'        CP240.StatusBar1.Panels(STB_WATCHDOGCS).Picture = LoadResPicture("IDB_MSDN_RED", vbResBitmap) '20151214
        
        '20160502
        'CSharpInCommunication = False '20160406
        '
        '20151119
    End If

    '20150409
    If (PlusWatchDogTimeoutTimer = 0) Then
        'Partenza o ri-partenza del timeout connessione con plus
        Call SetAllarmePresente("VA006", False)
        PlusWatchDogTimeoutTimer = ConvertiTimer()
    End If
    'Timeout comunicazione: 1 min. la prima volta, dopo 15 min.
    PlusWatchDogTimeout = IIf(PlusWatchDogTimeoutAlreadyDone, 15, 1)
    '20160318
    'If (Not DEBUGGING And (ConvertiTimer() - PlusWatchDogTimeoutTimer >= (PlusWatchDogTimeout * 60))) Then
    If (ConvertiTimer() - PlusWatchDogTimeoutTimer >= (PlusWatchDogTimeout * 60)) Then
    '
        'Non c'è comunicazione tra di noi
        '20160318
        'PlusCommunicationBroken = True
        'Call SetAllarmePresente("VA006", True)
        'Call VisualizzaBarraPulsantiCP240(True)
        '
        'Call SetActiveUser(UsersEnum.NONE)
        '
        'PlusWatchDogTimeoutTimer = ConvertiTimer()
        'PlusWatchDogTimeoutAlreadyDone = True
        Call SetPlusCommunicationBroken(True)
        '
    End If
    '

    'chiama una sola volta la routine che inizializza i dati nel frame e solo quando il plc delle cisterne e' in comunicazione
    If Not DEMO_VERSION Then
        If CistGestione.Gestione = GestionePLC Then
            If Not InitFormCisterne And (GetQuality(CP240.OPCDataCisterne.items.item(0).quality) = STATOOK) Then
                CP240.FrameCisterne(2).Visible = True
                Call CistShowMenu(TBB_LEGANTE)
                InitFormCisterne = True
            End If
        ElseIf InitFormCisterne Then
            CP240.FrameCisterne(2).Visible = False
        End If
    End If


    If (DEMO_VERSION Or PlcSimulation) Then
        If (AbilitaControlloAllarmi > 0) Then
            If (CP240.LblEtichetta(90).BackColor = vbRed) Then
                CP240.LblEtichetta(90).BackColor = vbYellow
            Else
                CP240.LblEtichetta(90).BackColor = vbRed
            End If
        End If
    End If

    Call LogFunction("VideataPrincipale", False, TimerInizio)

    Exit Function
Errore:
    LogInserisci True, "NET-007 - " + nomeFunzione, CStr(Err.Number) + " [" + Err.description + "]"
End Function

'20160318
Public Sub SetPlusCommunicationBroken(isBroken As Boolean, Optional firstTime As Boolean)

    If (PlusCommunicationBroken <> isBroken Or firstTime) Then
        PlusCommunicationBroken = isBroken

        '20160502
        CSharpInCommunication = (Not PlusCommunicationBroken)
        '
        
        '20161024 non usato
'        If (CSharpInCommunication) Then
'            FrmGestioneTimer.TimerParametriDaPlc.enabled = True
'        End If
        '20161024
        
        If (Not firstTime) Then
            Call SetAllarmePresente("VA006", PlusCommunicationBroken)
        End If
        Call VisualizzaBarraPulsantiCP240(True)

        Call PulsanteControlloPortineManuale '20170224
        
        If (PlusCommunicationBroken) Then
            Call SetActiveUser(UsersEnum.NONE)

            PlusWatchDogTimeoutTimer = ConvertiTimer()
        '20160502
        Else
            Call SendMessagetoPlus(PlusSendSWVersion, CStr(app.Major) + "." + CStr(app.Minor) + "." + CStr(app.Revision) + "." + CStr(BUILDNUMBER))
        '
        End If
    End If

    'Non ha senso fare il controllo a 15 min.
    'If (Not firstTime) Then
    '    PlusWatchDogTimeoutAlreadyDone = PlusCommunicationBroken
    'End If
    PlusWatchDogTimeoutAlreadyDone = False
    '

End Sub

'20151110
Public Sub InviaParaPesaCamion()

    Dim indice As Integer

    With CP240.OPCData.items
        .item(PLCTAG_SILI_PAR_PesaCamionEnScaling).Value = BilanciaPesaCamion.PesaCamionEnScaling
        
        .item(PLCTAG_SILI_PAR_PesaCamionScalingAnalogMin).Value = BilanciaPesaCamion.PesaCamionScalingAnalogMin
        .item(PLCTAG_SILI_PAR_PesaCamionScalingAnalogMax).Value = BilanciaPesaCamion.PesaCamionScalingAnalogMax
        .item(PLCTAG_SILI_PAR_PesaCamionScalingKgMin).Value = BilanciaPesaCamion.PesaCamionScalingKgMin
        .item(PLCTAG_SILI_PAR_PesaCamionScalingKgMax).Value = BilanciaPesaCamion.PesaCamionScalingKgMax
        .item(PLCTAG_SILI_PAR_PesaCamionEnFiltro).Value = BilanciaPesaCamion.PesaCamionEnFiltro
        .item(PLCTAG_SILI_PAR_PesaCamionSampleTime).Value = BilanciaPesaCamion.PesaCamionSampleTime
        .item(PLCTAG_SILI_PAR_PesaCamionSampleNr).Value = BilanciaPesaCamion.PesaCamionSampleNr
        .item(PLCTAG_SILI_PAR_PesaCamionEnLin).Value = BilanciaPesaCamion.PesaCamionEnLin
        .item(PLCTAG_SILI_PAR_PesaCamionNumLin).Value = BilanciaPesaCamion.PesaCamionNumLin
    
        For indice = 0 To 4
            .item(PLCTAG_SILI_PAR_PesaCamionLinX0 + indice).Value = BilanciaPesaCamion.PesaCamionLinX(indice)
            .item(PLCTAG_SILI_PAR_PesaCamionLinY0 + indice).Value = BilanciaPesaCamion.PesaCamionLinY(indice)
        Next indice
    
    End With

End Sub

'20160218
Public Sub CheckContenutoSili()
        
    Dim nrsilo As Integer
    Dim idresult As String
    Dim idricettascarico As Long '20170119
    Dim i As Integer
    Dim valoreDouble As Double
        
    If (CP240.AdoDosaggioScarico.Recordset.BOF Or CP240.AdoDosaggioScarico.Recordset.EOF) Then
        Exit Sub
    End If
    idricettascarico = GetIdDosaggioLogFromIdDosaggio(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value)
        
    With CP240.OPCData
        For i = 0 To 21
            valoreDouble = .items(PLCTAG_SILI_HMI_Storico_IdMateriale0 + (i)).Value
            nrsilo = PlcToSiloVB(i)
            If nrsilo > 0 Then
                idresult = CStr(.items(PLCTAG_SILI_HMI_Storico_IdMateriale0 + (i)).Value)
                If (valoreDouble <> 0) Then
                    CP240.LblTipoMaterialeS(nrsilo).BackColor = &HC0FFFF '20170320
                    ListaSili(nrsilo).materiale = GetDescrFromIdDosaggioLOG(valoreDouble)
                    ListaSili(nrsilo).idMateriale = idresult
                    CP240.ImageSilo(nrsilo).ToolTipText = ListaSili(nrsilo).materiale
                    CP240.CmdSelezioneSilo(nrsilo).enabled = ((idresult = idricettascarico) Or (Not DosaggioInCorso And Not CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value)) And Not ListaSili(nrsilo).LivelloAlto
                ElseIf (valoreDouble = 0) Then
                    ListaSili(nrsilo).materiale = LoadXLSString(1533)
                    CP240.LblTipoMaterialeS(nrsilo).BackColor = &HC0C0C0    '20170320
                    ListaSili(nrsilo).idMateriale = ""
                    CP240.CmdSelezioneSilo(nrsilo).enabled = Not ListaSili(nrsilo).LivelloAlto
                    CP240.ImageSilo(nrsilo).ToolTipText = ListaSili(nrsilo).materiale
                End If
                
                If FrmSiloGenerale.Visible And nrsilo < 12 Then
                    FrmSiloGenerale.LblTipoMaterialeS(nrsilo).caption = ListaSili(nrsilo).materiale
                End If
                
                CP240.LblTipoMaterialeS(nrsilo).caption = ListaSili(nrsilo).materiale
            
            End If
        Next i
    End With

End Sub
'

