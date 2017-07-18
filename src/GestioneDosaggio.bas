Attribute VB_Name = "GestioneDosaggio"

Option Explicit

'20160421 offset per la pesata in grafica
Public Const OffsetPesViatopScarMixer As Integer = 11
'20160421 offset per la pesata in grafica

Public Enum ComponenteEnum

    CompAggregato1
    CompAggregato2
    CompAggregato3
    CompAggregato4
    CompAggregato5
    CompAggregato6
    CompRAPAgg7
    CompNonVagliato
    compfiller1
    CompFiller2
    CompFiller3
    CompLegante1
    CompLegante2
    CompLegante3
    CompLeganteSoft
    CompLeganteHard
    CompViatop
    CompNonVagliato2
    CompRAP  ' è l'altro riciclato che può essere sia caldo(tamburo parallelo) che freddo
    CompRAPSiwa  'è il riciclato freddo
    '20160421
    CompViatopScarMixer1
    CompViatopScarMixer2
    '20160421
    compMax

End Enum

Public Enum ComponenteGraficaEnum
    CompGrafAggregato1 = 0
    CompGrafAggregato2
    CompGrafAggregato3
    CompGrafAggregato4
    CompGrafAggregato5
    CompGrafAggregato6
    CompGrafRAPAgg7
    CompGrafNonVagliato
    CompGrafFiller1 = 8
    CompGrafFiller2
    CompGrafFiller3
    CompGrafLegante1 = 11
    CompGrafLegante2
    CompGrafLegante3
    CompGrafLeganteSoft
    CompGrafLeganteHard
    CompGrafViatop = 16
    CompGrafRAP = 18 ' è l'altro riciclato che può essere sia caldo(tamburo parallelo) che freddo
    CompGrafRAPSiwa = 19 'è il riciclato freddo
    '20160421
    CompGrafViatopScarMixer1 = 31
    CompGrafViatopScarMixer2 = 32
    '20160421
    CompGrafMax
End Enum



Public Enum AdditiviEnum
    AddAcqua
    AddMescolatore
    AddBacinella
    AddSacchi
    AddLAST
End Enum

'   Contiene tutte le informazioni di un componente
Public Type ComponenteType

    '   Componenete gestito
    presente As Boolean

    '   Nome del componente
    Nome As String
    
    '   Indice del frame contenitore, della label, della progress...
    progressivo As Integer

    '   Tramoggia tampone presente
    tramoggiaPresente As Boolean
    
    '   Temperatura
    temperatura As Double

    '   Gestione del livello (analogico o digitale)
    livelloPresente As Boolean

    '   Presenza livello digitale
    livelloDigitale As Boolean

    '   %
    Livello As Integer

    '   Gestione del livello teorico
    livelloTeoricoPresente As Boolean

    '   Valore empirico del contenuto della tramoggia (Kg)
    livelloTeoricoMax As Double

    '   Valore calcolato del livello (Kg)
    livelloTeorico As Double

    '   % da ricetta
    set As Double

    '   Valore da pesare (Kg)
    setCalcolato As Double

    '   Peso reale in uscita (netto Kg)
    pesoOut As Double
    '   Peso reale precedentemente uscito (netto prec. Kg)
    pesoOutPrecedente As Double

    memTaraPesoNetto As Double '20170222
    pesataAttiva As Boolean '20170222
End Type

Public Type ComponenteContalitriType
'parametri
    densita As Double
    impulsiLitro As Double
    rampaFrenatura As Double
    tempoSicurezza As Integer
    modoContalitri As Boolean
    presenzaValvola As Boolean
'dosaggio in ricetta
    SetPerc As Double
    voloKg As Double            '20160401 MR15243 da Integer a Double
    tolleranzaKg As Double      '20160401 MR15243 da Integer a Double
    tempoStabilizzazione As Integer
    dosaggioFine As Integer
    ritardoDosaggio As Integer
    setKg   As Double
    nettoKg As Double
End Type

Public AdditivoBacinella As ComponenteContalitriType
'

Public PesaturaRiciclatoAggregato7 As Boolean
'20170222
'Public DosaggioAggregati(0 To 8) As ComponenteType
Public DosaggioAggregati(0 To 7) As ComponenteType
'
Public DosaggioFiller(0 To 2) As ComponenteType
Public DosaggioLeganti(0 To 4) As ComponenteType
Public DosaggioViatop As ComponenteType
'20160420
Public DosaggioViatopScarMixer1 As ComponenteType
Public DosaggioViatopScarMixer2 As ComponenteType
'20160420
Public DosaggioRAPSiwa As ComponenteType
Public DosaggioRAP As ComponenteType

Public AbilitaControlloPressostatoFiltro As Boolean
Public AbilitaAllarmeCicalino As Boolean
Public AbilitaSirenaAvvioImpianto As Boolean
'20150112
Public TempoOnSirena As Integer
Public TempoOffSirena As Integer
Public TempoAttesaRiavvioSirena As Integer
'
Public RicettaInUsoModificata As Boolean
Public ArrestoUrgenza As Boolean
Public InclusioneBitume2 As Boolean
Public InclusioneBitume3 As Boolean
Public InclusioneBacinella2 As Boolean
Public AbilitaRAP As Boolean
Public TamburoParallelo_TramoggiaTamponeCapacita As Integer
Public TamburoParallelo_TempoCoda As Integer
Public TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaAllarmePercentuale As Integer
Public TamburoParallelo_PredosasatoriCorrezionePercentuale As Integer
Public TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaCriticaPercentuale As Integer
Public InclusioneAriaFredda As Boolean
Public InclusioneDMR As Boolean
Public InclusioneSiloFillerRecuperoDMR As Boolean
Public InclusioneDeflettoreNonPassa As Boolean
Public DeflettoreNonPassa As Boolean
Public FCNonPassaRifiuti As Boolean
Public FCNonPassaGrosso As Boolean
Public ScambioBitume2 As Integer
Public MixerCaricoPerBenna As Boolean
Public BennaPiena As Boolean
Public GestioneManualeScambioVaglio As Boolean
Public InclusioneDoppiaPesataAgg As Boolean
Public BitumeGravita As Boolean
Public BitumeKgFinali As Integer
Public AbilitaInversionePCL As Boolean
Public AbilitaValv3VieSpruzzatriceBitume As Boolean
Public Valv3VieSpruzzatriceVersoTorre As Boolean
Public AbilitaValvolaConsensoBitumeNeutro As Boolean
' 0 = nessuna gestione valvola
' 1 = gestione con bitume 1
' 2 = gestione con bitume 2
Public AbilitaValvolaBitumeEmulsione As Integer
Public ValvolaBitumeEmulsioneSelezioneEmulsione As Boolean
Public ValvolaBitumeEmulsioneVersoEmulsione As Boolean
Public ValvolaBitumeEmulsioneVersoBitume As Boolean
Public Pcl1AutoOn As Boolean
Public Pcl1Inverter As Boolean
Public SetPcl1 As Integer
Public Pcl2AutoOn As Boolean
Public Pcl2Inverter As Boolean
Public SetPcl2 As Integer
Public SospensionePesatura As Boolean
Public SelezioneCircuitoBitume2 As Boolean
Public PacchettoMixer As String
Public EvacuazioneForzataFiltroDMR As Boolean

Public EvacuazioneFiltroDMR As Boolean
Public RitornoEvacuazioneFiltroDMR As Boolean
Public ComandoEvacuazioneSiloFiller As Boolean
Public RitornoEvacuazioneSiloFiller As Boolean
Public TimeoutEvacuazioneFiller As Integer 'secondi

Public OraStartEvacuazioneSiloFiller As Long

Public AbilitaTuboTroppoPienoF1 As Boolean
Public AbilitaValvolaTroppoPienoF1 As Boolean
'
Public ScambioFillerRecuperoInApporto As Boolean        'Comando
Public ScambioFillerRecuperoInApporto_CH As Boolean     'Fine corsa
Public ScambioTuboTroppoPienoF1F2 As Boolean            '0 = F2
Public RitornoTuboTroppoPienoNonSuF2 As Boolean         'Se è true ho il ritorno su F1 o F3
'
Public OraErroreScambioFillerRecuperoInApporto As Long

Public OraErroreScambioTuboTroppoPienoF1F2 As Long

'111    = manuale
'0      = computer
Public PulsantieraPesate(1) As Long
'   Stringa SQL per lo Storico Impasti
Private Const SQL_Storico_Parte1 = "SELECT * From Vista_StoricoImpasti "
Private Const SQL_Ordinamento_Storico = "ORDER BY DataOra DESC;"
Private Const SQL_Storico_Parte1_100 = "SELECT * From Vista_StoricoImpasti_100 "
Public SQL_FROM_VistaStoricoImpasti As String
Public ValoreTempoInizioCiclo As Long
Public DosaggioInCorso As Boolean
Public CambioRicettaPrenotato As Boolean
Public Const MassimoArrayAgg As Integer = 9
Public NettoAgg(0 To MassimoArrayAgg - 1) As Long
Public NettoFiller(0 To 2) As Double
Public CambioPercentualeDosaggio As Boolean
Public NettoRAPSiwa As Long         'Valore riferiti al ciclo di dosaggio attualmente in corso
Public NettoRAPSiwaBuffer As Long   'Netto riferito all'ultimo impasto effettuato: da storicizzare
Public NettoRAP As Long             'Valore riferiti al ciclo di dosaggio attualmente in corso
Public NettoRAPBuffer As Long       'Netto riferito all'ultimo impasto effettuato: da storicizzare
'20160422
Public NettoViatopScarMixer1 As Double
Public NettoViatopScarMixer2 As Double
'20160422

Public NettoAggregatiBuffer(0 To MassimoArrayAgg - 1) As Long
Public NettoFillerBuffer(0 To 2) As Double
Public NettoBitumeBuffer(0 To 4) As Double
Public StoricoImpastoDaAggiornare As Boolean
Public FuoriTollContalitri As Boolean
Public BufferKgAggregati(0 To 8) As Double
Public BufferKgFiller(0 To 2) As Double
Public BufferKgBitume(0 To 2) As Double
Public BufferKgViatop As Double
Public BufferVoloAggregati(0 To 8) As Long
Public BufferVoloFiller(0 To 2) As Double
Public BufferVoloBitume(0 To 4) As Double
Public BufferVoloViatop As Double
'20160422
Public NettoViatopScarMixer1Buffer As Double
Public BufferKgViatopScarMixer1 As Double
Public BufferVoloViatopScarMixer1 As Double
Public BufferRitardoViatopScarMixer1 As Double
Public NettoViatopScarMixer2Buffer As Double
Public BufferKgViatopScarMixer2 As Double
Public BufferVoloViatopScarMixer2 As Double
Public BufferRitardoViatopScarMixer2 As Double
'20160422

Public VoloAggregati(0 To 8) As Long
Public VoloFiller(0 To 2) As Double
Public VoloBitume(0 To 4) As Double
Public VoloRiciclato As Double
Public VoloRiciclatoSiwa  As Double
Public VoloViatop As Double
'20160426
Public VoloViatopScarMixer1 As Double
Public VoloViatopScarMixer2 As Double
'20160426

Public PesaturaManuale As Boolean
Public DeflettoreSuVagliato As Boolean
Public RitornoPesataFiller(0 To 2) As Boolean
Public ComandoPesataFiller(0 To 2) As Boolean
Public CicliDosaggioDaEseguire As Long
Public CicliDosaggioEseguiti As Long
Public TotaleProdotto As Double
'20151105
'Public QuantitaImpastoProdotto As Long
'Public QuantitaImpastoProdottoReset As Long
Public QuantitaImpastoProdotto As Double
Public QuantitaImpastoProdottoReset As Double
Public TotaleImpastoProgressivo As Double
'
Public BitSpruzzato As Double
Public MaxTempSpruzzatura As Long
Public ParamCheckBitumenDosage As Boolean 'Abilitazione controllo integrato(Cyb500) tolleranza bitume

Public Type TypeRicettaS7
    set As Double
    Ordine As Integer
End Type

'20160223
'Public RicettaS7(0 To 5) As TypeRicettaS7
Public RicettaS7(0 To 7) As TypeRicettaS7
'
Public AggregatoForzato(0 To 7) As Boolean
Public FillerForzato(0 To 2) As Boolean

Public Enum enumStatoValvolaBitumeEsterno
    Indefinito = 0
    CircuitoEsterno = 1
    CircuitoMarini = 2
    Errore = 3
End Enum

' 0 = nessuna dichiarazione
' 1 = utilizzato il N.V.
' 2 = utilizzata qualsiasi cosa, serve se peso un po' dal vaglio e un po' da NV, non devo togliere il peso dalla coda
Public NvInManuale As Integer
'
Public InclusioneLegante100 As Boolean
Public TempoMescolazione As Long
Public RAPSiwaInPesata As Boolean
Public RAPInPesata As Boolean
Public RAPSiwaInScarico As Boolean
Public RAPSiwaPortinaAperta As Boolean
Public RAPSiwaPortinaChiusa As Boolean

Public RAPSiwaStartSemiAuto As Boolean
Public RAPInScarico As Boolean
Public MescolazioneInCorso As Boolean
Public ConsensoScaricoBilance As Boolean
Public PortinaAgg(0 To 6) As Boolean
Public PortinaNV As Boolean
Public ValorePortinaBitume(0 To 4) As Boolean
Public SommaAggregati As Long
Public SommaFiller As Double
Public ScaricoAddSacchi As Boolean
Public ScaricoAdditivo(0 To 1) As Boolean
Public ScaricoAcqua As Boolean

Public Type RicettaTramogge
    'Ordine
    NumeroTramoggia As Integer

    'Flag che indica se una tramoggia è accoppiata alla precedente
    'Accoppiata As Boolean

    'Indica il numero di portine (successive) accoppiate
    '   0 = portina accoppiata alla precedente
    '   1 = portina singola
    '   2 = 1 portina successiva accoppiata
    '   3 = 2 portine successive accoppiate
    '   ...
    NumeroAccoppiate As Integer
End Type

'20160223
'Public NumeroTramoggiaScAgg(0 To 6) As RicettaTramogge 'Integer
Public NumeroTramoggiaScAgg(0 To 7) As RicettaTramogge 'Integer
'
Public InviaStopDosaggio As Boolean
Public BitumeInSpruzzatura As Boolean

'20160421 offset per lo scarico in grafica
Public Const OffsetScarViatopScarMixer As Integer = 23
'20160421 offset per lo scarico in grafica

Public Enum ScarichiEnum
    ScaricoNiente = -1
    ScaricoAggregati
    ScaricoFiller
    ScaricoLegante
    ScaricoRAP
    ScaricoCicloneViatop
    ScaricoMescolatore
    ScaricoMescolatoreOn
    ScaricoBilanciaViatop
    '20160421
    ScaricoViatopScarMixer1
    ScaricoViatopScarMixer2
    '20160421
    ScaricoLAST
End Enum

Public ManualeScaricoComponenti As ScarichiEnum
Public ManualePesaturaComponenti As Integer
Public CaricoSpruzzatriceBitume As Boolean

'   Gestione manuale degli additivi
'   0 = acqua
'   1 = nel mixer
'   2 = nella bacinella
'   3 = sacchi
Public ManualeAdditivi(0 To 3) As Boolean
Public InversioneAdditivi(0 To 3) As Boolean

Public ScaricoMescolatoreForzato As Boolean
Public SelettoreBitume123 As Integer
Public TempoAllarmeScaricoAggregati As Double
Public TempoAllarmeScaricoFiller As Double
Public TempoAllarmeScaricoLegante As Double
Public TempoAllarmeScaricoLeganteGR As Double
Public TempoAllarmeScaricoContalitri As Double
Public TempoAllarmeScaricoRiciclato As Double
Public TempoAllarmeScaricoViatop As Double
Public TempoAllarmeScaricoMixer As Double
Public TempoPermanenzaScaricoAggregati As Double
Public TempoPermanenzaScaricoFiller As Double
Public TempoPermanenzaScaricoRiciclato As Double
Public TempoPermanenzaScaricoLeganteGR As Double
Public TonnellateImpostate As Double
'Flag che indica se la forzatura delle pesate è attiva (lo è se automatico e se AnyPushButton(22).value=2)
Public PesataExtAttiva As Boolean
Public UltimoImpastoCompletato As Boolean
Public BloccoScaricoMescolatore As Boolean
Public BloccoBenna As Boolean

Public PortataMassimaFiller1 As Integer
Public PortataMassimaFiller2 As Integer
Public PortataMassimaFiller3 As Integer
Public TempoMassimoPesataFiller As Integer
Public RiduzioneVelocitaPesataFineFiller1 As Integer
Public RiduzioneVelocitaPesataFineFiller2 As Integer
Public RiduzioneVelocitaPesataFineFiller3 As Integer
Public AnticipoPesataFineFiller1 As Integer
Public AnticipoPesataFineFiller2 As Integer
Public AnticipoPesataFineFiller3 As Integer
Public VelocitaMinimaInverterCocleaFiltro As Integer
Public VelocitaMinimaInverterCocleaFiller1 As Integer
Public VelocitaMinimaInverterCocleaFiller2 As Integer
Public VelocitaMinimaInverterCocleaFiller3 As Integer
Public RapportoFlussoCocleaPesataF1_CocleaFiltro As Integer
Public RapportoFlussoCocleaPesataF3_CocleaPesataF2 As Integer
Public NumeroCampionamentiCalcoloFlusso As Integer
Public AbilitaFineCorsaIntermedioAggregati As Boolean
Public AbilitaVoloDinamicoFlusso As Boolean
Public PesoMinimoPesataVeloce As Integer
Public PesataFineAggregatiKg(1 To 8) As Integer
Public CoeffCommutaPesataFineAggregati(1 To 8) As Double
Public CoeffVoloPesataFineAggregati(1 To 8) As Double
Public CoeffVoloPesataUnicaAggregati(1 To 8) As Double
Public MemoriaVelocitaInverterCocleaFiltro As Integer
Public MemoriaVelocitaInverterCocleaFiller1 As Integer
Public MemoriaVelocitaInverterCocleaFiller2 As Integer
Public MemoriaVelocitaInverterCocleaFiller3 As Integer
Public InclusioneTemperaturaTramogge As Boolean

Public FuoriTolleranzaBitumeSegnalato As Boolean
Public MemoriaPesataExtComando As Boolean
Public AbilitaCambioRicetta As Boolean
Public CambioRicettaPerPlc As Boolean
Public SelezioneRicettaDosaggioCambiata As Boolean

Public CambioRicettaPerScarico As Boolean
Public ManualeDeflTramScivScarBilRic As Boolean
Public DeflTramScivScarBilRicAperto As Boolean
Public DeflTramScivScarBilRicChiuso As Boolean

Public Bitume2InBlending As Boolean

Public CicloFreddoSenzaAggregati As Boolean
Public CicloRicCaldoSenzaAggregati As Boolean
Public BufferAbilitaCicloRC(1 To 2) As Boolean

Public TrasfDatiPLCCarico As Boolean

Public DoppioClickOnLblProdDos  As Boolean

Public BufferAddSacchi(1 To 3) As Integer
Public BufferAddKgSacchi(1 To 3) As Integer
Public BufferKgAddMesc(1 To 3) As Integer
Public BufferAddBacNet(1 To 2) As Double
Public BufferAddBacSet(1 To 2) As Double
Public BufferKgAddBac(1 To 3) As Double
'20150511
Public BufferSelezCistLegPCL1 As Integer
Public BufferSelezCistLegPCL2 As Integer
Public BufferMatCistLegPCL1 As String
Public BufferMatCistLegPCL2 As String

Public TempoControlloRitornoPesataFiller(0 To 2) As Long

Public DosaggioInCorsoApp As Boolean '20150109
Public Trasf_dati_PLC_scarico As Boolean '20150513
'
Public MemImpastoAutoScaricatoMan As Boolean '20151103

'20161020
Public Enum StatusDosaggio
    DOSAGGIO_STATUS_AUTO_STOP = 0
    DOSAGGIO_STATUS_AUTO_RUN
    DOSAGGIO_STATUS_AUTO_LAST
    DOSAGGIO_STATUS_MAN
End Enum
Public MemStatoDosaggio As Integer
'

'20161024
Public Enum BilancePnTypeEnum
    BILANCIA_PN_NONE = -1

    BILANCIA_PN_AGGREGATI = 1
    BILANCIA_PN_FILLER = 2
    BILANCIA_PN_BITUME = 3
    BILANCIA_PN_RICICLATO = 4
    BILANCIA_PN_VIATOP = 5
    BILANCIA_PN_VIATOP2 = 6
End Enum

Public Type BilanciaPnComboType
    BILANCIA_PN_NONE As Integer
    BILANCIA_PN_AGGREGATI As Integer
    BILANCIA_PN_FILLER As Integer
    BILANCIA_PN_BITUME As Integer
    BILANCIA_PN_RICICLATO As Integer
    BILANCIA_PN_VIATOP As Integer
    BILANCIA_PN_VIATOP2 As Integer
End Type

Public BilanciaPnCombo As BilanciaPnComboType

Public BilanciaPnAttiva As BilancePnTypeEnum

Public Enum BilancePnCommandEnum
    BILANCIA_PN_CMD_NONE = -1

    BILANCIA_PN_CMD_TARE = 1
    BILANCIA_PN_CMD_CALIBRATE = 2
    BILANCIA_PN_CMD_RESET = 3
End Enum
Public BilanciaPnCommand As BilancePnCommandEnum
Public BilanciaPnCmdRun As Boolean
Public BilanciaPnErrore As Boolean '20161104

Public BilanciaPnSampleWeight As Double
'
Public cambioVoloTempiAggRic As Boolean     '20161202
'Public DosaggioInCorsoFlomac As Boolean '20161122
Public TempoRitardoAllarmeScaricoMixer As Double '20170221
Public UltimaBennata As Boolean   '20160912


Public Sub VagliatoNonVagliato_change()

    On Error GoTo Errore

    If (VaglioEscluso And Not VaglioIncluso) Then
        CP240.AniPushButtonDeflettore(3).Value = 1
    ElseIf (Not VaglioEscluso And VaglioIncluso) Then
        CP240.AniPushButtonDeflettore(3).Value = 2
    Else
        CP240.AniPushButtonDeflettore(3).Value = 3
    End If

    If (RackVersione82x) Then
        'Nel caso di rack v8.x non esistono gli ingressi separati per le temperature delle tramogge
        CP240.LblTrTemp(NTramoggeA).Visible = VaglioIncluso
        CP240.LblTrTemp(7).Visible = (Not VaglioIncluso)
    End If

    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-001 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ScambioTuboTroppoPieno_Change()

    With CP240

        If GestioneScambioTuboTroppoPieno = ScambioF1F2 Then

            If ScambioTuboTroppoPienoF1F2 And RitornoTuboTroppoPienoNonSuF2 Then  'F1
                .AniPushButtonDeflettore(35).Value = 1
            ElseIf Not ScambioTuboTroppoPienoF1F2 And Not RitornoTuboTroppoPienoNonSuF2 Then  'F2
                .AniPushButtonDeflettore(35).Value = 2
            Else
                .AniPushButtonDeflettore(35).Value = 3
            End If

        ElseIf GestioneScambioTuboTroppoPieno = ScambioF2F3 Then

            If ScambioTuboTroppoPienoF1F2 And RitornoTuboTroppoPienoNonSuF2 Then  'F3
                .AniPushButtonDeflettore(35).Value = 1
            ElseIf Not ScambioTuboTroppoPienoF1F2 And Not RitornoTuboTroppoPienoNonSuF2 Then  'F2
                .AniPushButtonDeflettore(35).Value = 2
            Else
                .AniPushButtonDeflettore(35).Value = 3
            End If

        End If

    End With
End Sub


Public Sub DeflTramScivScarBilRic_change()

    On Error GoTo Errore

    If Not PesaturaManuale Or Not ManualeDeflTramScivScarBilRic Then
        Exit Sub
    End If
         
    If (Not DEMO_VERSION) Then
        CP240.OPCData.items.item(PLCTAG_DO_Defl_Scar_Bil_Ric).Value = Not CP240.OPCData.items.item(PLCTAG_DO_Defl_Scar_Bil_Ric).Value
    End If
    
    Call Grafica_DeflTramScivScarBilRic
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-002 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub Grafica_DeflTramScivScarBilRic()

    On Error GoTo Errore

    If DeflTramScivScarBilRicAperto And Not DeflTramScivScarBilRicChiuso Then
        CP240.AniPushButtonDeflettore(32).Value = 1 'deflettore verticale (aperto)
    ElseIf DeflTramScivScarBilRicChiuso And Not DeflTramScivScarBilRicAperto Then
        CP240.AniPushButtonDeflettore(32).Value = 2 'deflettore orizzontale (chiuso)
    ElseIf (DeflTramScivScarBilRicAperto And DeflTramScivScarBilRicChiuso) Or _
         (Not DeflTramScivScarBilRicAperto And Not DeflTramScivScarBilRicChiuso) Then
        CP240.AniPushButtonDeflettore(32).Value = 3 'deflettore incerto (ne chiuso ne aperto)
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ScambioFillerRecuperoInApporto_Change()

    On Error GoTo Errore

    If (Not ScambioFillerRecuperoInApporto) And (ScambioFillerRecuperoInApporto_CH) Then
        CP240.AniPushButtonDeflettore(23).Value = 1     'chiuso
    ElseIf (ScambioFillerRecuperoInApporto) And (Not ScambioFillerRecuperoInApporto_CH) Then
        CP240.AniPushButtonDeflettore(23).Value = 2     'aperto
    Else
        CP240.AniPushButtonDeflettore(23).Value = 3
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-004 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ArrestoPCLInDosaggio()

    Dim Criterio As String
    Dim posizione As Integer

On Error GoTo Errore

    If InclusioneBitumeEsterno Then
        Exit Sub
    End If

    If (DosaggioInCorso) Then
        If _
            (Not Pcl1AutoOn And (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) > 0) And Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePCL).ritorno) Or _
            (Not Pcl2AutoOn And (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0) And Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePCL2).ritorno) _
        Then
            If val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) > 0 And Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePCL).ritorno Then
            '
                Criterio = "AM002"
            ElseIf (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0) And Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePCL2).ritorno Then
                Criterio = "AM003"
            End If
            '
            posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
            Call IngressoAllarmePresente(posizione, True)
        End If
        
        If (ListaMotori(MotorePompaEmulsione).presente And Not ListaMotori(MotorePompaEmulsione).ritorno) Then
            If ( _
                val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0 And _
                CBool(CP240.AdoDosaggioScarico.Recordset.Fields("Emulsione").Value) _
            ) Then
                Criterio = "AM0" + CStr(MotorePompaEmulsione)
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
                Call IngressoAllarmePresente(posizione, True)
            End If
        End If
        '
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-005 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AzzeramentoDatiTrasRic()
    ValorePortinaBitume(0) = False
End Sub

Public Sub BitSpruzzato_change()

    On Error GoTo Errore

    Exit Sub
Errore:
    LogInserisci True, "DOS-006 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Gestione PESATURA BITUME.
Public Sub ValorePortinaBitume_change(portinaBitume As Integer)

    On Error GoTo Errore

    ComponenteInPesata DosaggioLeganti(portinaBitume), ValorePortinaBitume(portinaBitume)

'20150507
    If CistGestione.Gestione = GestioneSemplificata Then
        If (portinaBitume = 0) Then
            
            BufferSelezCistLegPCL1 = DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1
            
            If DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 > 0 Then
                BufferMatCistLegPCL1 = CistGestione.materiale(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 - 1)
                CP240.LblCistMateriale(10).caption = BufferMatCistLegPCL1
            Else
                CP240.LblCistMateriale(10).caption = ""
                BufferMatCistLegPCL1 = ""
            End If
        ElseIf (portinaBitume = 1) And (ListaMotori(MotorePCL2).presente) Then
            
            BufferSelezCistLegPCL2 = DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2
            
            If DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 > 0 Then
                BufferMatCistLegPCL2 = CistGestione.materiale(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 - 1)
                CP240.LblCistMateriale(11).caption = BufferMatCistLegPCL2
            Else
                BufferSelezCistLegPCL2 = 0
                CP240.LblCistMateriale(11).caption = ""
                BufferMatCistLegPCL2 = ""
            End If
        End If
    End If
'

    If (portinaBitume = 1) And (ListaMotori(MotorePCL2).presente) Then
        If ValorePortinaBitume(1) Then
            CP240.imgValvolaCisterne(219).Picture = LoadResPicture("IDB_VALVOLAORIZZON", vbResBitmap)
        Else
            CP240.imgValvolaCisterne(219).Picture = LoadResPicture("IDB_VALVOLAORIZZ", vbResBitmap)
        End If
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-007 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ContalitriErroreTimeOutAvvio_change()
    
    On Error GoTo Errore

'    If ContalitriErroreTimeOutAvvio Then
'    Else
'    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-008 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ContalitriErroreTimeOutArresto_change()
    
    On Error GoTo Errore

'    If ContalitriErroreTimeOutArresto Then
'    Else
'    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-009 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Routine di aggiornamento additivi
Public Sub ConsensoScaricoBilance_change()
    
    'storicizzazione
    BufferAddSacchi(3) = BufferAddSacchi(2)
    BufferAddKgSacchi(3) = BufferAddKgSacchi(2)
    BufferKgAddMesc(3) = BufferKgAddMesc(2)
    BufferKgAddBac(3) = BufferKgAddBac(2)
    'mescolazione
'    CP240.LblAddSacchi(1).caption = BufferAddSacchi(2)
    
    CP240.LblKgAddSacchi.caption = BufferAddKgSacchi(2)
    CP240.LblAdd(2).caption = BufferKgAddMesc(2)
    CP240.LblAdd(3).caption = BufferKgAddBac(1)
    'dosaggio
    BufferAddBacNet(2) = BufferAddBacNet(1)
    BufferAddBacSet(2) = BufferAddBacSet(1)
    BufferAddSacchi(2) = BufferAddSacchi(1)
    BufferAddKgSacchi(2) = BufferAddKgSacchi(1)
    BufferKgAddMesc(2) = BufferKgAddMesc(1)
    BufferKgAddBac(2) = BufferKgAddBac(1)

End Sub

''Gestione della segnalazione di MESCOLAZIONE.
Public Sub MescolazioneInCorso_change()

    Dim Criterio  As String
    Dim posizione As Integer


    On Error GoTo Errore

    If (MescolazioneInCorso) Then

        Criterio = "DO011"
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        IngressoAllarmePresente posizione, False
        Criterio = "DO013"
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        IngressoAllarmePresente posizione, False
        
              
        AssorbimentoMixer = ListaAmperometri(AmperometroMescolatore_1).valore
        'Campiona anche nel trend
        Call TrendCampionamentoInserisciEvento(TrendAmperometroMixer, DateTime.Now, CDbl(AssorbimentoMixer))

        CP240.LblMescolazione.Visible = True
        CP240.LblEtichetta(184).Visible = True
                
        CP240.LblKgDosaggio(2).caption = CStr(Round(CalcoloTotaleImpasto, 0))
                
        CP240.ImgMotor(0).Visible = True

'20160525
        If CP240.AdoDosaggio.Recordset.Fields("AquablackSet") > 0 Then
            Aquablack_HMI_PLC.FROM_HMI_Start = True
        Else
            Aquablack_HMI_PLC.FROM_HMI_Stop = True
        End If
'
        
        CicloScaricoSiloCompleto = False '20170303
        
    Else
        CP240.LblMescolazione.Visible = False
        CP240.LblEtichetta(184).Visible = False
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-010 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'20161027
Public Function CalcoloTotaleImpasto() As Double

    Dim totaleimpasto As Double
    
    On Error GoTo Errore
    
        totaleimpasto = (SommaAggregati + SommaFiller + NettoViatopBuffer(0))
        
        'totale bitumi con bacinella
        If BitumeGravita Then
            totaleimpasto = (totaleimpasto + RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB1Kg).Value, 1) + CP240.OPCData.items(PLCTAG_GravitaNettoB2Kg).Value)
        Else
            If CP240.AdoDosaggioScarico.Recordset.Fields("SetBitumeHard").Value > 0 Then
                totaleimpasto = (totaleimpasto + CP240.OPCData.items(PLCTAG_NettoBitume1).Value + CP240.OPCDataSchiumato.items(NettoBitumeSoft_idx).Value + CP240.OPCDataSchiumato.items(NettoBitumeHard_idx).Value)
            ElseIf CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value > 0 Then
                totaleimpasto = (totaleimpasto + CP240.OPCData.items(PLCTAG_NettoBitume1).Value)
            End If
        End If
                
        'Aggiungo il peso del bitume contalitri
        If CP240.AdoDosaggioScarico.Recordset.Fields("SetContalitri").Value > 0 Then
            totaleimpasto = totaleimpasto + CP240.OPCData.items(PLCTAG_ContalitriNettoKg).Value
        End If
        
        'Aggiungo il peso dal RAP_SIWAREX
        If CP240.AdoDosaggioScarico.Recordset.Fields("RAPSiwa").Value > 0 Then
            totaleimpasto = totaleimpasto + CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_NETTO).Value
            NettoRAPSiwaBuffer = NettoRAPSiwa
            ComponentePesoOut DosaggioRAPSiwa, CDbl(NettoRAPSiwaBuffer)
        End If
        
        '20120508 RAP
        If AbilitaRAP Then
            totaleimpasto = totaleimpasto + NettoRAPBuffer
            ComponentePesoOut DosaggioRAP, CDbl(NettoRAPBuffer)
        End If

        If InclusioneAcqua Then
            totaleimpasto = totaleimpasto + val(CP240.LblAdd(5).caption)
        End If
        
        CalcoloTotaleImpasto = totaleimpasto '20161027
    
    Exit Function

	Errore:
    LogInserisci True, "DOS-011 ", CStr(Err.Number) + " [" + Err.description + "]"
    
End Function

'ELABORAZIONE DATI DALLA VIDEATA NETTI.
Public Sub DatiResiduiNetti()
On Error GoTo Errore
    
    If (Not PesaturaManuale) Then
        PesaturaAvvenutaF(0) = False
        PesaturaAvvenutaF(1) = False
        PesaturaAvvenutaF(2) = False
    Else
        If (ManualePesaturaComponenti = compfiller1) Or FineRitardoConteggioF(0) Then
            If (PesaturaAvvenutaF(0)) Then
                FrmNetti.TimerManualeFiller1.enabled = True
                PesaturaAvvenutaF(0) = False
            End If
        ElseIf (ComandoPesataFiller(1) Or FineRitardoConteggioF(1)) Then
            If (PesaturaAvvenutaF(1)) Then
                FrmNetti.TimerManualeFiller2.enabled = True
                PesaturaAvvenutaF(1) = False
            End If
        ElseIf (ComandoPesataFiller(2) Or FineRitardoConteggioF(2)) Then
            If (PesaturaAvvenutaF(2)) Then
                FrmNetti.TimerManualeFiller3.enabled = True
                PesaturaAvvenutaF(2) = False
            End If
        End If
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-012 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub PosizionaDeflettoreVaglio()

On Error GoTo Errore

    Dim i As Integer

    With CP240.AdoDosaggio.Recordset

        If (Not GestioneManualeScambioVaglio And Not .EOF) Then
            DeflettoreSuVagliato = False
            For i = PLCTAG_SetA1 To PLCTAG_SetA6
                If (CP240.OPCData.items(i).Value > 0) Then
                    DeflettoreSuVagliato = True
                    Exit For
                End If
            Next i
        End If

    End With

    Call AggiornaTemperaturaTorre

    Exit Sub
	Errore:
    LogInserisci True, "DOS-013 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub RiempiBufferAggregatiFiller()
	Dim indice As Integer
	Dim nomeTr As String
        
    SommaAggregati = 0
    SommaFiller = 0
        
    For indice = 0 To 7
            NettoAggregatiBuffer(indice) = NettoAgg(indice)
            SommaAggregati = SommaAggregati + NettoAggregatiBuffer(indice)
    Next indice
    
    If AbilitaRAP Then
        NettoRAPBuffer = NettoRAP
    End If
        
    If (AbilitaCodaMateriale) Then
        If (PesaturaManuale) Then
            If (NvInManuale = 1) Then
                Call LivelloTeoricoOut(DosaggioAggregati(7), PesoAggregatiManuale)
            End If
        ElseIf (CP240.AdoDosaggio.Recordset.Fields("AggregatoNV").Value <> 0) Then
            Call LivelloTeoricoOut(DosaggioAggregati(7), CDbl(NettoAggregatiBuffer(7)))
        End If
    End If
    
    NvInManuale = 0
        
    'N.V.2
    NettoAggregatiBuffer(8) = NettoAgg(8)
    SommaAggregati = SommaAggregati + NettoAggregatiBuffer(8)
    For indice = 0 To 2
        NettoFillerBuffer(indice) = NettoFiller(indice)
        SommaFiller = SommaFiller + NettoFillerBuffer(indice)
    Next indice
    SommaFiller = RoundNumber(SommaFiller, 1)
    
    StoricoImpastoDaAggiornare = True
        
End Sub
'20160428
Public Sub RiempiBufferViatopScarMixer()
    On Error GoTo Errore
'        If (Not (BilanciaViatopScarMixer1.Presenza And BilanciaViatopScarMixer2.Presenza And (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer1").Value) > 0) And (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer2").Value) > 0))) Then
'            Call AzzeraBufferViatopScarMixer
'        End If
        '20160422
        If (BilanciaViatopScarMixer1.Presenza And (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer1").Value) > 0) And Not (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer2").Value) > 0)) Then
            NettoViatopScarMixer1 = RoundNumber(CP240.OPCData.items(PLCTAG_DB32_ViatopScarMixer1_NettoKg).Value, 1)
            NettoViatopScarMixer1Buffer = NettoViatopScarMixer1
            NettoViatopScarMixer2Buffer = 0
            BufferRitardoViatopScarMixer1 = CP240.OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Ritardo).Value
            BufferRitardoViatopScarMixer2 = 0
            'x debug
            'Debug.Print ("TESTRICETTA: Ricetta con solo Viatop 1 Set: " + CStr(NettoViatopScarMixer1Buffer))
            '
        End If
        If (BilanciaViatopScarMixer2.Presenza And (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer2").Value) > 0) And Not (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer1").Value) > 0)) Then
            NettoViatopScarMixer2 = RoundNumber(CP240.OPCData.items(PLCTAG_DB33_ViatopScarMixer2_NettoKg).Value, 1)
            NettoViatopScarMixer2Buffer = NettoViatopScarMixer2
            NettoViatopScarMixer1Buffer = 0
            BufferRitardoViatopScarMixer2 = CP240.OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Ritardo).Value
            BufferRitardoViatopScarMixer1 = 0
            'x debug
            'Debug.Print ("TESTRICETTA: Ricetta con solo Viatop 2 Set: " + CStr(NettoViatopScarMixer2Buffer))
            '
        End If
        If (BilanciaViatopScarMixer1.Presenza And BilanciaViatopScarMixer2.Presenza And (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer1").Value) > 0) And (String2Double(CP240.AdoDosaggioScarico.Recordset.Fields("SetViatopScarMixer2").Value) > 0)) Then
            If (BilanciaViatopScarMixer1.OutScarico) Then
                NettoViatopScarMixer1 = RoundNumber(CP240.OPCData.items(PLCTAG_DB32_ViatopScarMixer1_NettoKg).Value, 1)
                NettoViatopScarMixer1Buffer = NettoViatopScarMixer1
                BufferRitardoViatopScarMixer1 = CP240.OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Ritardo).Value
                'x debug
                'Debug.Print ("TESTRICETTA: Ricetta con Viatop 1 e 2 Set1: " + CStr(NettoViatopScarMixer1Buffer) + " Rit: " + CStr(BufferRitardoViatopScarMixer1))
                '
            End If
            If (BilanciaViatopScarMixer1.OutScarico) Then
                NettoViatopScarMixer2 = RoundNumber(CP240.OPCData.items(PLCTAG_DB33_ViatopScarMixer2_NettoKg).Value, 1)
                NettoViatopScarMixer2Buffer = NettoViatopScarMixer2
                BufferRitardoViatopScarMixer2 = CP240.OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Ritardo).Value
                'x debug
                'Debug.Print ("TESTRICETTA: Ricetta con Viatop 1 e 2 Set2: " + CStr(NettoViatopScarMixer2Buffer) + " Rit: " + CStr(BufferRitardoViatopScarMixer2))
                '
            End If
        End If
    Exit Sub
	Errore:
    LogInserisci True, "DOS-014 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
Public Sub AzzeraBufferViatopScarMixer()
    NettoViatopScarMixer1Buffer = 0
    NettoViatopScarMixer2Buffer = 0
    BufferRitardoViatopScarMixer1 = 0
    BufferRitardoViatopScarMixer2 = 0
End Sub
'20160428

Public Sub RiempiBufferKgVoli()

    Dim i As Integer
    Dim setCalcolato  As Double

    With CP240.AdoDosaggio

        If .Recordset.RecordCount = 0 Or CP240.adoComboDosaggio.text = "" Then
            Exit Sub
        End If
        
        Call RiempieBufferPortine(CP240.AdoDosaggio.Recordset, NumeroTramoggiaScAgg)
    End With

    For i = 0 To 7
        If (i <= 6) Then
            If (NumeroTramoggiaScAgg(i).NumeroAccoppiate <> 1) Then

                If (NumeroTramoggiaScAgg(i).NumeroAccoppiate > 0) Then
                    setCalcolato = DosaggioAggregati(i).setCalcolato / NumeroTramoggiaScAgg(i).NumeroAccoppiate
                End If
            Else
                setCalcolato = DosaggioAggregati(i).setCalcolato
            End If
        Else
            setCalcolato = DosaggioAggregati(i).setCalcolato
        End If

        BufferKgAggregati(i) = setCalcolato 'DosaggioAggregati(i).setCalcolato

        BufferVoloAggregati(i) = VoloAggregati(i)
    Next i

    For i = 0 To 2
        BufferKgFiller(i) = DosaggioFiller(i).setCalcolato
        BufferVoloFiller(i) = VoloFiller(i)
    Next i

    '20160426
    If (CP240.AdoDosaggio.Recordset.Fields("SetViatopScarMixer1").Value) Then
        BufferKgViatopScarMixer1 = DosaggioViatopScarMixer1.setCalcolato
        BufferVoloViatopScarMixer1 = VoloViatopScarMixer1
    End If
    If (CP240.AdoDosaggio.Recordset.Fields("SetViatopScarMixer2").Value) Then
        BufferKgViatopScarMixer2 = DosaggioViatopScarMixer2.setCalcolato
        BufferVoloViatopScarMixer2 = VoloViatopScarMixer2
    End If
    '20160426
    
    VoloViatop = CDbl(CP240.OPCData.items(PLCTAG_ResBilViatop1).Value)

End Sub

Public Sub BitumeInSpruzzatura_change()

    On Error GoTo Errore

    If Not BitumeGravita Then

        If BitumeInSpruzzatura Then  'Pompa in moto
            If InclusioneAgitatore Then
                AgitatoreBacinella = False
            End If
        End If

    End If

    If BitumeInSpruzzatura Then
        CP240.ProgressBil(2).BackColor = vbGreen
    Else
        CP240.ProgressBil(2).BackColor = &H80FFFF
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-015 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SetDosaggioScarico()

	On Error GoTo Errore

    With CP240

        .AdoDosaggioScarico.RecordSource = "Select * From Dosaggio Where [IdDosaggio] = " & .AdoDosaggio.Recordset.Fields("IdDosaggio").Value & " ;"
        .AdoDosaggioScarico.Refresh
        
        '20170124
        'QuantitaImpastoProdotto = 0
        QuantitaImpastoProdotto = JobProssimo.DosaggioPreset * CDbl(1000)

        ValvolaBitumeEmulsioneSelezioneEmulsione = False

        If (ListaMotori(MotorePompaEmulsione).presente) Then
            If ( _
                AbilitaValvolaBitumeEmulsione = 2 And _
                val(.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0 And _
                .AdoDosaggioScarico.Recordset.Fields("Emulsione").Value _
            ) Then
                ValvolaBitumeEmulsioneSelezioneEmulsione = True
            End If
            If ( _
                AbilitaValvolaBitumeEmulsione = 1 And _
                val(.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) > 0 And _
                .AdoDosaggioScarico.Recordset.Fields("Emulsione").Value _
            ) Then
                ValvolaBitumeEmulsioneSelezioneEmulsione = True
            End If
        End If
        
        Call Valv3VieBitume2Emulsione_Change
        
        If (.OPCData.items.count > 0) Then
            If (AbilitaValvolaBitumeEmulsione = 2 And GetQuality(.OPCData.items(PLCTAG_DO_Valv3VieBitume2Emulsione).quality) = STATOOK) Then
                .OPCData.items(PLCTAG_DO_Valv3VieBitume2Emulsione).Value = ValvolaBitumeEmulsioneSelezioneEmulsione
            End If
        
            If (AbilitaValvolaBitumeEmulsione = 1 And GetQuality(.OPCData.items(PLCTAG_DO_Valv3VieBitume2Emulsione).quality) = STATOOK) Then
                .OPCData.items(PLCTAG_DO_Valv3VieBitume2Emulsione).Value = ValvolaBitumeEmulsioneSelezioneEmulsione
            End If
                    
        End If

        'Call SendMessagetoPlus(PlusSendActiveDosingRecipeMixerID, val(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value))  '20170206
    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-016 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub SegnalaCambioRicettaAlPlc()

    FrmGestioneTimer.TimerTagCambioVolo.enabled = False

    With CP240.OPCData
        If (.IsConnected) Then
            .items(PLCTAG_PrenotaCambioRicDos).Value = True
            .SOUpdate

            CambioRicettaPerPlc = False

            CambioRicettaPerScarico = True
        End If
    End With

End Sub

Public Sub ScaricoAggregati_change()

    Dim indice As Integer

    On Error GoTo Errore

    'Durante lo scarico aggregati disabilito le frecce per cambiare i set di Aggregati e Filler
    If ComandoScaricoAggregati Or (BufferAbilitaCicloRC(1) And RAPInScarico) Then
        For indice = 0 To 7
            CP240.LblTrSetPeso(indice).enabled = False
        Next indice
        For indice = 0 To 2
            CP240.LblTrSetPeso(indice + compfiller1).enabled = False
        Next indice

        If (DosaggioInCorso) Then
            TempoMixSecca(0) = CDbl(Timer)
        End If

        Call AbilitazioneCambioRicetta(False)
        If (DosaggioInCorso And CambioRicettaPerPlc) Then
            SegnalaCambioRicettaAlPlc
        End If

'20170222
        BilanciaAggregati.CompAttivo = -1 '20170223
        If Not PesaturaManuale Then Call InitPbarNettoPesata(CompGrafAggregato1, CompGrafNonVagliato)
'

    Else
        For indice = 0 To 7
            CP240.LblTrSetPeso(indice).enabled = (DosaggioAggregati(indice).set > 0)
            If AggregatoForzato(indice) Then
                Call ForzaSetAggregati(indice)
                AggregatoForzato(indice) = False
            End If
        Next indice
        For indice = 0 To 2
            CP240.LblTrSetPeso(indice + compfiller1).enabled = (DosaggioFiller(indice).set > 0)
            If FillerForzato(indice) Then
                Call ForzaSetFiller(indice)
                FillerForzato(indice) = False
            End If
        Next indice
        CP240.LblTrSetPeso(18).enabled = (DosaggioRAP.set > 0)
    End If
    
    If ComandoScaricoAggregati Or (BufferAbilitaCicloRC(1) And RAPInScarico) Then
        Call AggiornaOrdinePesateForzato
        If Not CP240.AdoDosaggio.Recordset.EOF Then
            Call RiempiBufferAggregatiFiller
            '20160428 (per azzerare i netti)
            Call AzzeraBufferViatopScarMixer
            'x debug
            'Debug.Print ("azzera netti")
            '
            '20160428
            Call RiempiBufferKgVoli
        End If

        If (CP240.AdoComboClienti.text <> "") Then
            CP240.LblEtichetta(4).caption = DlookUpExt("Descrizione", "Clienti", CP240.AdoComboClienti.text, "IdLog")
        Else
            CP240.LblEtichetta(4).caption = ""
        End If

        '   Sullo scarico aggregati controllo la pesata inerti manuale
        If PulsantieraPesate(0) = 111 Then
            PulsantieraPesate(1) = PulsantieraPesate(0)
        End If
        PulsantieraPesate(0) = 0
    End If
    
    If (Not PesaturaManuale And (ComandoScaricoAggregati Or (BufferAbilitaCicloRC(1) And RAPInScarico))) Then
        If CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value <> CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value Then
            Call SetDosaggioScarico
        End If

'20161027
'        CP240.LblKgDosaggio(2).caption = CInt(SommaAggregati + SommaFiller + NettoViatopBuffer(0) + NettoRAPBuffer)
        CP240.LblKgDosaggio(2).caption = CStr(Round(CalcoloTotaleImpasto, 0))
'
        
        CP240.ImgMotor(0).Visible = True

        PLCSchiumatoPesoAggregati SommaAggregati + SommaFiller
        
        'Se stavo facendo la variazione del peso dell'impasto devo mandare al PLC la nuova grandezza
        If CP240.OPCData.items(PLCTAG_RiduzioneImpastoDos).Value <> RiduzioneImpasto Then
            CambioPercentualeDosaggio = True
        End If
    End If

    CP240.ProgressBil(0).BackColor = IIf(ComandoScaricoAggregati, vbGreen, &H80FFFF)
    
    Call ForzaSetTempi 'Verificare il perché necessitiamo di ribadire i ritardi in scarico
    
    'SCHIUMATO
    PLCSchiumatoScaricoAggregati ComandoScaricoAggregati
    FrmCalcolaImpasti.imgPulsanteForm(3).enabled = Not (ComandoScaricoAggregati Or (BufferAbilitaCicloRC(1) And RAPInScarico))

    Exit Sub
	Errore:
    LogInserisci True, "DOS-017 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub PortinaNV_change()

    On Errore GoTo Errore

    With CP240
    
        ComponenteInPesata DosaggioAggregati(7), PortinaNV

        If (PortinaNV) Then
            Call AbilitazioneCambioRicetta(True)
        End If

    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-018 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub PortinaAgg_change(portina As Integer)

    On Errore GoTo Errore
    
    ComponenteInPesata DosaggioAggregati(portina), PortinaAgg(portina)

    '   PortinaAgg(portina) : portina aperta = inizio pesata
    '   not PortinaAgg(portina) : portina chiusa = fine pesata

    If (PortinaAgg(portina)) Then
        Call AbilitazioneCambioRicetta(True)
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-019 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PesataRAP_Change()
    On Errore GoTo Errore
    
    ComponenteInPesata DosaggioRAP, RAPInPesata

    If (RAPInPesata) And BufferAbilitaCicloRC(1) Then
        Call AbilitazioneCambioRicetta(True)
    End If
    '20161205
    If (RAPInPesata) And Not BufferAbilitaCicloRC(1) Then
        Call AbilitazioneCambioRicetta(False)
    End If
    '20161205
    Exit Sub
	Errore:
    LogInserisci True, "DOS-020 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BilanciaInertiPortinaAperta_change()

    On Errore GoTo Errore
        
    Exit Sub
	Errore:
    LogInserisci True, "DOS-021 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub BilanciaInertiPortinaChiusa_change()

    On Errore GoTo Errore
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-022 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ScaricoFiller_change()

    On Error GoTo Errore

    'Scarico filler.
    If ComandoScaricoFiller Then
        CP240.ProgressBil(1).BackColor = vbGreen

        If CP240.OPCData.items(PLCTAG_AbilitaCicloRF).Value Then
            Call RiempiBufferAggregatiFiller
        End If
        
'20170222
        BilanciaFiller.CompAttivo = -1 '20170223
        If Not PesaturaManuale Then Call InitPbarNettoPesata(CompGrafFiller1, CompGrafFiller3)
'
    Else
        CP240.ProgressBil(1).BackColor = &H80FFFF
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-023 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub BilanciaFillerPortinaChiusa_change()

    On Error GoTo Errore

    Exit Sub
	Errore:
    LogInserisci True, "DOS-024 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub RAPSiwaInPesata_change()

    On Error GoTo Errore

    If AbilitaRAPSiwa Then

        If FrmSiwarexPara.Visible Then
            If RAPSiwaInPesata Then
                FrmSiwarexPara.ImgMotorTest.Picture = LoadResPicture("IDB_NASTROON", vbResBitmap)
            Else
                FrmSiwarexPara.ImgMotorTest.Picture = LoadResPicture("IDB_NASTRO", vbResBitmap)
            End If
            
            If RAPSiwaStartSemiAuto Then
                FrmSiwarexPara.CmdNastro(0).enabled = False
                FrmSiwarexPara.CmdNastro(1).enabled = False
                                
                If (FrmSiwarexPara.BilanciaAttiva = 4) Then
                    FrmSiwarexPara.CmdZero.enabled = False
                    FrmSiwarexPara.CmdPesoCampione.enabled = False
                End If
            End If

            If Not RAPSiwaInPesata Then
                RAPSiwaStartSemiAuto = False
                FrmSiwarexPara.CmdNastro(0).enabled = PesaturaManuale
                FrmSiwarexPara.CmdNastro(1).enabled = PesaturaManuale
                
                If (FrmSiwarexPara.BilanciaAttiva = 4) Then
                    FrmSiwarexPara.CmdZero.enabled = PesaturaManuale
                    FrmSiwarexPara.CmdPesoCampione.enabled = PesaturaManuale
                End If
            End If
'
        End If
'

        ComponenteInPesata DosaggioRAPSiwa, RAPSiwaInPesata
        If (RAPSiwaInPesata) Then
            NettoRAPSiwaBuffer = NettoRAPSiwa
            ComponentePesoOut DosaggioRAPSiwa, CDbl(NettoRAPSiwaBuffer)
        End If

        If CP240.OPCData.items(PLCTAG_AbilitaCicloRF).Value And DosaggioInCorso And Not RAPSiwaInPesata Then
            StoricoImpastoDaAggiornare = True
            If (CP240.AdoComboClienti.text <> "") Then
                CP240.LblEtichetta(4).caption = DlookUpExt("Descrizione", "Clienti", CP240.AdoComboClienti.text, "IdLog")
            Else
                CP240.LblEtichetta(4).caption = ""
            End If
        End If

        If DosaggioInCorso And RAPSiwaInPesata Then
            CP240.LblAdd(5).caption = RoundNumber(CP240.OPCData.items(PLCTAG_AcquaDurataSpruzzaturaStorico).Value / 1000 * PortataAcqua, 0)
        End If

        If CP240.OPCData.items(PLCTAG_AbilitaCicloRF).Value And DosaggioInCorso And RAPSiwaInPesata Then
            'Se non ho il filler nessuno azzererebbe gli ultimi netti pesati
            If (CP240.OPCData.items(PLCTAG_SetF1).Value + CP240.OPCData.items(PLCTAG_SetF2).Value + CP240.OPCData.items(PLCTAG_SetF3).Value) = 0 Then
                Call RiempiBufferAggregatiFiller
            End If

            'Memorizzazione dell'ultimo netto del contalitri emulsione
            NettoBitumeBuffer(2) = RoundNumber(CP240.OPCData.items(PLCTAG_ContalitriNettoKg).Value, 1)
        End If
        
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-025", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SetSelezioneCircuitoBitume2(bitume2 As Boolean)

    If (SelezioneCircuitoBitume2 = bitume2) Then
        Exit Sub
    End If

    SelezioneCircuitoBitume2 = bitume2

    If (SelezioneCircuitoBitume2) Then
        'Call SetMotoreUscita(MotorePCL, False)  '2
        CP240.AniPushButtonDeflettore(6).Value = 2
    Else
        'Call SetMotoreUscita(MotorePCL2, False) '3
        CP240.AniPushButtonDeflettore(6).Value = 1
    End If

End Sub

Public Sub ScambiaPompaCircLegante()

    If (AbilitaSelettoreBitume1 And InclusioneBitume2) Then
        If MotoriInAutomatico Then
            If val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value * 10) > 0 Then
                'Bitume 1
                SetSelezioneCircuitoBitume2 False
            End If
            If val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value * 10) > 0 Then
                'Bitume 2
                SetSelezioneCircuitoBitume2 True
            End If
        End If
    End If

End Sub

Public Sub RichiamoRicettaDos()

    Dim i As Integer
    Dim memoSelectedItem As Integer
    
    On Error GoTo Errore


    If CP240.adoComboDosaggio.text = "" Then
        Exit Sub
    End If

    If (Not AbilitaCambioRicetta) Then
        Exit Sub
    End If

    If RicettaInUsoModificata Then
'20160229
        Call RinfrescaNomeRicDosaggio
'
        Call RinfrescaOrigineDatiDosaggio(CP240.LblNomeRicDos(0).caption)
        CP240.adoComboDosaggio.ReFill
    End If
'

    If (CP240.LblNomeRicDos(0).caption <> CP240.adoComboDosaggio.text) Then

        If CP240.LblNomeRicDos(0).caption <> CP240.adoComboDosaggio.text Then
            If Not IsNull(CP240.adoComboDosaggio.SelectedItem) Then
                Call CP240.AdoDosaggioNext.Recordset.Move(CP240.adoComboDosaggio.SelectedItem - 1, adBookmarkFirst)

                Call SendMessagetoPlus(PlusSendActiveDosingRecipeNextID, val(CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value))
            End If
        End If
    End If

    If RicettaInUsoModificata And Not IsNull(CP240.adoComboDosaggio.SelectedItem) Then
        memoSelectedItem = CP240.adoComboDosaggio.SelectedItem
        CP240.AdoDosaggioNext.Refresh
        Call CP240.AdoDosaggioNext.Recordset.Move(memoSelectedItem - 1, adBookmarkFirst)
    
        If Not DosaggioInCorso Then
            CP240.AdoDosaggio.Refresh
            Call CP240.AdoDosaggio.Recordset.Move(memoSelectedItem - 1, adBookmarkFirst)
        End If
        
    End If

    Call AccendiVaglioCambioRicetta

    'richiamata a loop Call GestioneVaglio
    Call CfgPortineScaricoAgg
    Call ScambiaPompaCircLegante

    If (CP240.AdoDosaggioNext.Recordset.Fields("Bitume2").Value > 0 And InclusioneBitume2 And Not AbilitaSelettoreBitume1 And Not InclusioneBacinella2) Then
        CP240.AniPushButtonDeflettore(20).Value = 2
    Else
        If (CP240.AdoDosaggioNext.Recordset.Fields("SetBitumeSoft").Value > 0 And InclusioneBitume3) Then
            CP240.AniPushButtonDeflettore(20).Value = 3
        Else
            CP240.AniPushButtonDeflettore(20).Value = 1
        End If
    End If
    SelettoreBitume123 = 0

    Call InvioFormulaDosaggio

    'Se ho il Viatop lo metto in automatico
    If DosaggioViatop.set <> 0 Then
        AutomaticoViatop = True
    End If
    RicettaInUsoModificata = False
    CambioPercentualeDosaggio = False
    SelezioneRicettaDosaggioCambiata = False
    If (DosaggioInCorso) Then
        CambioRicettaPerPlc = True
    End If
    
    'Abilito le caselle per il cambio del set Kg
    For i = 0 To 7
        CP240.LblTrSetPeso(i).enabled = (DosaggioAggregati(i).set > 0)
        If i <= 2 Then
            CP240.LblTrSetPeso(i + compfiller1).enabled = (DosaggioFiller(i).set > 0)
        End If
    Next i

    Exit Sub
	Errore:
    LogInserisci True, "DOS-026 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub RiempieBufferPortine(rs As adodb.Recordset, ByRef arrayPortine() As RicettaTramogge)

    Dim i As Integer
    Dim NomeCampo1 As String
    Dim MemOrdinePortina As Integer
    Dim MemIndiceArray As Integer

    On Error GoTo Errore

'    'NumeroAccoppiate = 1 portina non accoppiata
'    'NumeroAccoppiate > 1 indica il numero di portine accoppiate
'    'NumeroAccoppiate = 0 portina accoppiata alla precedente

    With rs

        If (.RecordCount = 0) Then
            Exit Sub
        End If

        arrayPortine(0).NumeroAccoppiate = 1
        MemOrdinePortina = 0

        For i = LBound(arrayPortine) To UBound(arrayPortine)
            
            If i >= 0 And i <= 5 Then
                NomeCampo1 = "OrdPortina" & i + 1
                
                arrayPortine(i).NumeroTramoggia = .Fields(NomeCampo1).Value
                
                If (.Fields(NomeCampo1).Value <> "0" And .Fields(NomeCampo1).Value <> "") Then
                                                                                                                  
                    If (MemOrdinePortina = .Fields(NomeCampo1).Value) Then
                        arrayPortine(MemIndiceArray).NumeroAccoppiate = arrayPortine(MemIndiceArray).NumeroAccoppiate + 1
                        arrayPortine(i).NumeroAccoppiate = 0
                    Else
    '                    MemOrdinePortina = .Fields(NomeCampo1).Value
                        MemOrdinePortina = .Fields(NomeCampo1).Value
                        MemIndiceArray = i
                        arrayPortine(i).NumeroAccoppiate = 1
                    End If
                                    
                Else
                    arrayPortine(i).NumeroAccoppiate = 1
                End If
'20160223
            ElseIf i = 7 Then
                NomeCampo1 = "OrdPortina8"
                
                arrayPortine(i).NumeroTramoggia = .Fields(NomeCampo1).Value
                
                If (.Fields(NomeCampo1).Value <> "0" And .Fields(NomeCampo1).Value <> "") Then
                                                                                                                  
                    If (MemOrdinePortina = .Fields(NomeCampo1).Value) Then
                        arrayPortine(MemIndiceArray).NumeroAccoppiate = arrayPortine(MemIndiceArray).NumeroAccoppiate + 1
                        arrayPortine(i).NumeroAccoppiate = 0
                    Else
                        MemOrdinePortina = .Fields(NomeCampo1).Value
                        MemIndiceArray = i
                        arrayPortine(i).NumeroAccoppiate = 1
                    End If
                                    
                Else
                    arrayPortine(i).NumeroAccoppiate = 1
                End If
'
            Else
                arrayPortine(i).NumeroAccoppiate = 1
            End If
        
'            Debug.Print "arrayPortine(" + CStr(i) + ").NumeroAccoppiate = " + CStr(arrayPortine(i).NumeroAccoppiate)
        
        Next i

    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-027 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub CfgPortineScaricoAgg()

    Dim i As Integer
    Dim K As Integer
    Dim NomeCampo1 As String
    Dim NomeCampo2 As String

    On Error GoTo Errore

    With CP240.AdoDosaggioNext

        If .Recordset.RecordCount = 0 Or CP240.adoComboDosaggio.text = "" Then
            Exit Sub
        End If
        
        For i = 0 To 6
            ComponenteSet DosaggioAggregati(i), 0
        Next i

        Call RiempieBufferPortine(CP240.AdoDosaggioNext.Recordset, NumeroTramoggiaScAgg)

        For i = 0 To 6
            NomeCampo1 = "Aggregato" & i + 1
            
            If .Recordset.Fields(NomeCampo1).Value <> 0 Then            'Percentuale
                If NumeroTramoggiaScAgg(i).NumeroTramoggia > 0 Then                     'Ordine pesata
                    ComponenteSet DosaggioAggregati(i), .Recordset.Fields(NomeCampo1).Value
                End If
            Else
                ComponenteSet DosaggioAggregati(i), 0
            End If
        Next i

        ComponenteSet DosaggioAggregati(7), .Recordset.Fields("AggregatoNV").Value
        
        If PesaturaRiciclatoAggregato7 Then 'Riciclato in tramoggia
            ComponenteSet DosaggioAggregati(6), .Recordset.Fields("Aggregato7").Value
        End If

        If (AbilitaRAP) Then
            ComponenteSet DosaggioRAP, .Recordset.Fields("RAP").Value
        End If
        If (AbilitaRAPSiwa) Then
            ComponenteSet DosaggioRAPSiwa, .Recordset.Fields("RAPSiwa").Value
        End If

        For i = 0 To 2
            ComponenteSet DosaggioFiller(i), .Recordset.Fields("Filler" + CStr(i + 1)).Value
        Next i

        For i = 0 To 1
            ComponenteSet DosaggioLeganti(i), .Recordset.Fields("Bitume" + CStr(i + 1)).Value
        Next i
        ComponenteSet DosaggioLeganti(i), .Recordset.Fields("SetContalitri").Value

        If (PlcSchiumato.Abilitazione) Then
            'SCHIUMATO
            ComponenteSet DosaggioLeganti(3), Null2Qualcosa(.Recordset.Fields("SetBitumeSoft").Value)
            ComponenteSet DosaggioLeganti(4), Null2Qualcosa(.Recordset.Fields("SetBitumeHard").Value)
            Call PLCSchiumatoSetRicetta( _
                DosaggioLeganti(4).set, _
                DosaggioLeganti(3).set, _
                Null2Qualcosa(.Recordset.Fields("RitardoBitumeHard").Value), _
                Null2Qualcosa(.Recordset.Fields("RitardoBitumeSoft").Value), _
                Null2Qualcosa(.Recordset.Fields("TolleranzaBitumeHard").Value), _
                Null2Qualcosa(.Recordset.Fields("TolleranzaBitumeSoft").Value) _
                )

            CP240.FrameSchiumato.Visible = DosaggioLeganti(4).set > 0
        End If

        ComponenteSet DosaggioViatop, .Recordset.Fields("SetViatop").Value
        ComponenteSet DosaggioViatopScarMixer1, .Recordset.Fields("SetViatopScarMixer1").Value '20160422
        ComponenteSet DosaggioViatopScarMixer2, .Recordset.Fields("SetViatopScarMixer2").Value '20160422
        
    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-028 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ArrestoEmergenzaDosaggio()
	'20151103
    If DosaggioInCorso Then
        MemImpastoAutoScaricatoMan = True '20151103
    End If
'

    ArrestoUrgenza = True
    FrmGestioneTimer.TimerArrestoUrgenza.enabled = False
    FrmGestioneTimer.TimerArrestoUrgenza.Interval = 4000
    FrmGestioneTimer.TimerArrestoUrgenza.enabled = True

    '20160512
    CP240.OPCData.items(PLCTAG_SILI_HMI_DosaggioInCorso).Value = False
    '
    InviaStopDosaggio = True

    If AbilitaRAPSiwa Then
        CodiceComandoSiwarex = 103
        Call AttivaComandoSiwarex(SiwarexRiciclatoFreddo)
        FrmGestioneTimer.TimerAbortBatch.enabled = False
        FrmGestioneTimer.TimerAbortBatch.Interval = 100
        FrmGestioneTimer.TimerAbortBatch.enabled = True

        FrmGestioneTimer.TimerStopDosaggioBatchManuale.enabled = False
        FrmGestioneTimer.TimerStopDosaggioBatchManuale.Interval = 1000
        FrmGestioneTimer.TimerStopDosaggioBatchManuale.enabled = True
        CP240.OPCData.items(PLCTAG_DB80_StopDosaggioManuale).Value = True

        RAPSiwaStartSemiAuto = False
        CP240.CmdTrPesa(19).enabled = PesaturaManuale
        If FrmSiwarexPara.Visible Then
            FrmSiwarexPara.CmdNastro(0).enabled = PesaturaManuale
            FrmSiwarexPara.CmdNastro(1).enabled = PesaturaManuale
            
            If (FrmSiwarexPara.BilanciaAttiva = 4) Then
                FrmSiwarexPara.CmdZero.enabled = PesaturaManuale
                FrmSiwarexPara.CmdPesoCampione.enabled = PesaturaManuale
            End If
        End If
    End If

    Call PulsanteStopCicliDosaggio
    
    If (CP240.OPCData.IsConnected) Then
        CP240.OPCData.items(PLCTAG_PrenotaCambioRicDos).Value = False
        Call CP240.OPCData.SOUpdate
    End If

    CicloScaricoSiloCompleto = True '20170303
    
    '20170110
    If JobAttivo.StatusVB <> EnumStatoJobVB.Idle And Not InviaStopDosaggio Then
        Call StopEmergenzaJob
    End If
    '

End Sub


Public Sub GraficaTempoMescolazione()

    On Error GoTo Errore

    'Scambio bitume1 a bitume2
    If (AbilitaSelettoreBitume1 And Not InclusioneBacinella2) And FrmNetti.Visible Then
        If (DosaggioInCorso) Then
            FrmNetti.LblEtichetta(10).Visible = (ScambioBitume2 = 0)
            FrmNetti.LblEtichetta(11).Visible = (ScambioBitume2 = 1)
        Else
            FrmNetti.LblEtichetta(10).Visible = (Not SelezioneCircuitoBitume2)
            FrmNetti.LblEtichetta(11).Visible = SelezioneCircuitoBitume2
        End If
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-029 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub CalcoloProgressImpasto()
	'Dim silo As Integer

    On Error GoTo Errore

    '20151105
    'QuantitaImpastoProdottoReset = QuantitaImpastoProdottoReset + RoundNumber(TotaleProdotto, 0)
    'QuantitaImpastoProdotto = QuantitaImpastoProdotto + RoundNumber(TotaleProdotto, 0)
    'CP240.LblKgDosaggio(0).caption = QuantitaImpastoProdotto
    'CP240.LblKgDosaggio(1).caption = QuantitaImpastoProdottoReset
    'CP240.LblKgImpasto.caption = val(CP240.LblKgImpasto.caption) + TotaleProdotto
    QuantitaImpastoProdottoReset = QuantitaImpastoProdottoReset + TotaleProdotto
    QuantitaImpastoProdotto = QuantitaImpastoProdotto + TotaleProdotto
    '20170124
'    CP240.LblKgDosaggio(0).caption = RoundNumber(QuantitaImpastoProdotto, 0)
'    CP240.LblKgDosaggio(1).caption = RoundNumber(QuantitaImpastoProdottoReset, 0)
    CP240.LblKgDosaggio(0).caption = FormatNumber(QuantitaImpastoProdotto, 0, vbTrue, vbFalse, vbFalse)
    CP240.LblKgDosaggio(1).caption = FormatNumber(QuantitaImpastoProdottoReset, 0, vbTrue, vbFalse, vbFalse)
'
    
    TotaleImpastoProgressivo = TotaleImpastoProgressivo + TotaleProdotto
    '20170124
    'CP240.LblKgImpasto.caption = RoundNumber(TotaleImpastoProgressivo, 0)
    CP240.LblKgImpasto.caption = FormatNumber(TotaleImpastoProgressivo, 0, vbTrue, vbFalse, vbFalse)
    '
    '20170123
    'CP240.TxtImpastoRidotto(3).text = RoundNumber((QuantitaImpastoProdotto + GrandezzaImpasto(0) + (CicliDosaggioDaEseguire - CicliDosaggioEseguiti - 1) * DimensioneImpastoKg) / 1000, 1) & " T"
    CP240.TxtImpastoRidotto(3).text = FormatNumber((QuantitaImpastoProdotto + GrandezzaImpasto(0) + (CicliDosaggioDaEseguire - CicliDosaggioEseguiti - 1) * DimensioneImpastoKg) / 1000, 1, vbTrue, vbFalse, vbFalse) & " T"
    '
    
    Call ScritturaPesoMescolatore

    '20170113
    If JobAttivo.StatusVB > EnumStatoJobVB.Idle Then
        Call InviaMessaggioQuantitaJobXml(RoundNumber(QuantitaImpastoProdotto / CDbl(1000), 3), QtaDosaggio)
    End If
    '

    'Uso un buffer a 2 posizioni per memorizzare il peso da mettere nel silo
    'Posizione 0 = PesoImpastoPerSilo_InViaggio
    'Posizione 1 = PesoImpastoPerSilo_InAttesa
    'Prima metto nella posizione 0 poi nella 1 se la 0 è già occupata, ovvero se ho la benna in giro per la consegna = benna + navetta
    'PesoScaricatoTemp = RoundNumber(TotaleProdotto, 0)
    If PesoImpastoPerSilo_InViaggio = 0 Then
        PesoImpastoPerSilo_InViaggio = RoundNumber(TotaleProdotto, 0)
    Else
        PesoImpastoPerSilo_InAttesa = RoundNumber(TotaleProdotto, 0)
    End If
    '

    Exit Sub
	Errore:
    LogInserisci True, "DOS-030 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FuoriTollBitume_change()

    On Error GoTo Errore

    If (BilanciaLegante.FuoriTolleranza) Then
        FuoriTolleranza = 1
        FuoriTolleranzaBitumeSegnalato = True
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-031 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FuoriTollAggregati_change()

    On Error GoTo Errore

    If (BilanciaAggregati.FuoriTolleranza) Then
        FuoriTolleranza = 1
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-032 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FuoriTollFiller_change()

    On Error GoTo Errore

    If (BilanciaFiller.FuoriTolleranza) Then
        FuoriTolleranza = 1
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-033 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FuoriTollRiciclato_change()

    On Error GoTo Errore

    If (BilanciaRAP.FuoriTolleranza Or BilanciaRAPSiwa.FuoriTolleranza) Then
        FuoriTolleranza = 1
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-034 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FuoriTollViatop_change()

    On Error GoTo Errore

    If (BilanciaViatop.FuoriTolleranza) Then
        FuoriTolleranza = 1
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-035 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FuoriTollContalitri_change()

    On Error GoTo Errore

    If (FuoriTollContalitri) Then
        FuoriTolleranza = 1
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-036 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'CONTROLLO CONSENSO SCARICO MESCOLATORE
Public Sub TempoMescolazione_change()

    On Error GoTo Errore

    CP240.LblMescolazione.caption = CStr(TempoMescolazione)
    If CP240.LblMescolazione.BackColor = vbGreen Then
        CP240.LblMescolazione.BackColor = vbBlack
        CP240.LblMescolazione.ForeColor = vbGreen
    Else
        CP240.LblMescolazione.BackColor = vbGreen
        CP240.LblMescolazione.ForeColor = vbBlack
    End If

    'Check dosaggio bitume
    If (ParamCheckBitumenDosage And DosaggioInCorso And Not InclusioneLegante100) Then
        If (Not FuoriTolleranzaBitumeSegnalato And BitSpruzzato <> 0 And TempoMescolazione <= 5 And TempoMescolazione >= 4) Then
            Dim i As Integer
            Dim NettoInerti As Double
            Dim LeganteSetPerc As Double
            Dim LeganteSet As Double
            Dim LeganteToll As Integer
            Dim LeganteDos As Double

            ' Netto inerti + fresato + filler
            NettoInerti = 0
            For i = 0 To 7
                NettoInerti = NettoInerti + NettoAggregatiBuffer(i)
            Next i
            If AbilitaRAP Then
                NettoInerti = NettoInerti + RoundNumber(NettoRAP, 0)
            End If
            If AbilitaRAPSiwa Then
                NettoInerti = NettoInerti + RoundNumber(NettoRAPSiwa, 0)
            End If

            For i = 0 To 2
                NettoInerti = NettoInerti + NettoFillerBuffer(i)
            Next i

            ' Set legante
            LeganteSetPerc = 0
            For i = 0 To 1
                LeganteSetPerc = LeganteSetPerc + CP240.AdoDosaggioScarico.Recordset.Fields("Bitume" + CStr(i + 1)).Value
            Next i
            LeganteSetPerc = LeganteSetPerc + CP240.AdoDosaggioScarico.Recordset.Fields("SetContalitri").Value
            
            LeganteDos = RoundNumber(BitSpruzzato, 1)
            LeganteSet = RoundNumber(NettoInerti * (CDbl(LeganteSetPerc)) / 100, 1)
            LeganteToll = CP240.AdoDosaggioScarico.Recordset.Fields("TolleranzaBitume").Value

            If (Abs(LeganteSet - LeganteDos) > LeganteToll + 1) Then
                FuoriTolleranzaBitumeSegnalato = False
                If (Not DEBUGGING) Then
                    LogInserisci True, "TempoMescolazione_change", LoadXLSString(38) & " SET = " & LeganteSet & " - NET = " & LeganteDos
                End If
                CP240.LblLeganteFuoriToll.caption = LoadXLSString(38) & " SET = " & LeganteSet & " - NET = " & LeganteDos
                CP240.FrameLeganteFuoriToll.Visible = True
                AllarmeCicalino = True
                ' Call ArrestoEmergenzaDosaggio
            End If
        End If
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-037 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AggiornaGraficaScaricoMescolatore()

    On Error GoTo Errore

    If (Not MescolatoreAperto And MescolatoreChiuso) Then
        CP240.ImgScMesc.Visible = False
    ElseIf (MescolatoreAperto And Not MescolatoreChiuso) Then
        CP240.ImgScMesc.Picture = LoadResPicture("IDB_MESCOLATOREPORTINAON", vbResBitmap)
        CP240.ImgScMesc.Visible = True
    ElseIf ((MescolatoreAperto And MescolatoreChiuso) Or (Not MescolatoreAperto And Not MescolatoreChiuso)) Then
        CP240.ImgScMesc.Picture = LoadResPicture("IDB_MESCOLATOREPORTINAONERRORE", vbResBitmap)
        CP240.ImgScMesc.Visible = True
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-038 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub MescolatoreAperto_change()

    On Error GoTo Errore

    If MescolatoreAperto Then

        'Check dosaggio bitume, reset eventuale allarme fuori tolleranza bitume
        FuoriTolleranzaBitumeSegnalato = False

        CP240.ShowBenna True

        '   Riparto a cercare un picco
        MaxValoreTempSottoMesc = ListaTemperature(TempSottoMescolatore).valore
        CP240.LblTempMateriale(0).caption = MaxValoreTempSottoMesc

        Call AllarmeTemporaneo("XX119", False)

        If (PlcSchiumato.Abilitazione) Then
            Call PLCSchiumatoSetFineScaricoBitume(False)
        End If

        If ScaricoMescolatoreForzato Then
            Call NMSetMotoreUscita(MotoreMescolatore, True)
        End If


    End If

    If (Not PesaturaManuale And MescolatoreAperto) Then
        If (StoricoImpastoDaAggiornare) Then
            StoricoImpastoDaAggiornare = False
            Call CalcolaTempoCiclo
            Call SommaComponenti
            CP240.TimerFunzionamentoMotori(7).enabled = True
            
            CP240.LblKgDosaggio(2).caption = 0
                    
            CP240.ImgMotor(0).Visible = False
        
        End If
    End If

    Call AggiornaGraficaScaricoMescolatore

    Exit Sub
	Errore:
    LogInserisci True, "DOS-039 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub MescolatoreChiuso_change()

    Dim i As Integer

    On Error GoTo Errore

    If MescolatoreChiuso Then

        Call AllarmeTemporaneo("XX119", MescolatoreAperto And MixerCaricoPerBenna)
    
        If (CambioRicettaPerScarico) Then
            CP240.AdoDosaggioScarico.Refresh
            CambioRicettaPerScarico = False
        End If
    
    End If

    Call AggiornaGraficaScaricoMescolatore
'20160421
'    If (Not FronteScMescMemManuali And MescolatoreChiuso) And PesaturaManuale And _
'    (PesoTotaleAggregatiManuale + PesoTotaleFillerManuale + PesoTotaleBitumeManuale + PesoTotaleRiciclatoManuale + PesoTotaleViatopManuale) > 0 Then
    If (Not FronteScMescMemManuali And MescolatoreChiuso) And PesaturaManuale And _
    (PesoTotaleAggregatiManuale + PesoTotaleFillerManuale + PesoTotaleBitumeManuale + PesoTotaleRiciclatoManuale + PesoTotaleViatopManuale + PesoTotaleViatopScarMixer1Manuale + PesoTotaleViatopScarMixer2Manuale) > 0 Then
'20160421
'20151103
'        If Not MemPesataManualeAggregatiAttivata And Not MemPesataManualeFillerAttivata And Not MemPesataManualeBitumeAttivata And _
'            Not MemPesataManualeRiciclatoAttivata And Not MemPesataManualeViatopAttivata Then
'20160421
'        If MemImpastoAutoScaricatoMan And Not MemPesataManualeAggregatiAttivata And Not MemPesataManualeFillerAttivata And Not MemPesataManualeBitumeAttivata And _
'            Not MemPesataManualeRiciclatoAttivata And Not MemPesataManualeViatopAttivata Then
'
        If MemImpastoAutoScaricatoMan And Not MemPesataManualeAggregatiAttivata And Not MemPesataManualeFillerAttivata And Not MemPesataManualeBitumeAttivata And _
            Not MemPesataManualeRiciclatoAttivata And Not MemPesataManualeViatopAttivata And Not MemPesataManualeViatopScarMixer1Attivata And Not MemPesataManualeViatopScarMixer2Attivata Then

'20160421
'20151020
'            i = ShowMsgBox(LoadXLSString(1492), vbYesNo, vbInformation, -1, -1, False)
'            If i = vbYes Then
            If (ShowMsgBox(LoadXLSString(1492), vbYesNo, vbQuestion, -1, -1, True) = vbOK) Then
'
                Call SommaComponenti
                Call ResetVariabiliImpaManuali
                CP240.LblKgDosaggio(2).caption = "XXXX"
'                Exit Sub
            Else
                Call MemorizzaManualiDB
            End If
        Else
            Call MemorizzaManualiDB
        End If
'        FronteScMescMemManuali = MescolatoreChiuso
        CP240.LblKgDosaggio(2).caption = "XXXX"
        MemImpastoAutoScaricatoMan = False '20151103
        Call ResetVariabiliImpaManuali '20151106
    End If
    
    FronteScMescMemManuali = MescolatoreChiuso
'
    Exit Sub
	Errore:
    LogInserisci True, "DOS-040 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SommaComponenti()

    Dim i As Integer
    'Dim pp As Integer
    Dim TotNettiInerti As Double
    Dim TotNettiFiller As Double
    Dim AppoggioB1 As Double
    Dim AppoggioB2 As Double
    Dim rstStoricoImpasto As New adodb.Recordset
    Dim TotKG As Integer
    Dim rs As New adodb.Recordset
    Dim IdDosaggioLOG_Memo As Long
    Dim consbitume(1 To 5) As Double
    Dim consfiller(1 To 3) As Double
    Dim consinerti(0 To 8) As Double
    Dim consAdd1 As Double
    Dim consAddSacchi As Integer
    Dim consAdd2 As Double
    Dim consAdd2CNT As Double
    Dim setAdd2CNT As Double
    Dim consAcqua As Integer
    Dim StoricoViatop As Double
    Dim consInertiPa As Double
    Dim TramoggeScarico(0 To 6) As RicettaTramogge
    Dim AppoggioBitSpruzzato As Double
    '20160426
    Dim consviatopscarmixer1 As Double
    Dim consviatopscarmixer2 As Double
    Dim TotNettoViatopScarMixer1 As Double
    Dim TotNettoViatopScarMixer2 As Double
    '20160426
    
	On Error GoTo ErrorHandler

    IdDosaggioLOG_Memo = CP240.AdoDosaggioScarico.Recordset.Fields("IdLOG").Value
    
    With rs
        Set .ActiveConnection = DBcon
        .Source = "Select * From DosaggioLOG Where IdDosaggioLog = " & IdDosaggioLOG_Memo & " ;"
        .LockType = adLockReadOnly
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With

    If PesaturaManuale Then
        
        Call AggiornaOrdinePesateForzato
        If Not CP240.AdoDosaggio.Recordset.EOF Then
            Call RiempiBufferAggregatiFiller
            Call RiempiBufferKgVoli
        End If
        
        For i = 0 To 8
'NumeroAccoppiate = 1 portina non accoppiata
'NumeroAccoppiate > 1 indica il numero di portine accoppiate
'NumeroAccoppiate = 0 portina accoppiata alla precedente
            If (i <= 6) Then
'20151022
'                If (TramoggiaScAgg(i).NumeroAccoppiate <> 1) Then
'
'                        If (TramoggiaScAgg(i).NumeroAccoppiate > 0) Then
'                            consInertiPa = NettoAggregatiBuffer(i) / TramoggiaScAgg(i).NumeroAccoppiate
'                        End If
                If (NumeroTramoggiaScAgg(i).NumeroAccoppiate <> 1) Then
                        
                        If (NumeroTramoggiaScAgg(i).NumeroAccoppiate > 0) Then
                            consInertiPa = NettoAggregatiBuffer(i) / NumeroTramoggiaScAgg(i).NumeroAccoppiate
                        End If
'
                        consinerti(i) = consInertiPa
                Else
                    consinerti(i) = NettoAggregatiBuffer(i)
                End If
            Else
                consinerti(i) = NettoAggregatiBuffer(i)
            End If
                
            '''consinerti(i) = NettoAggregatiBuffer(i)
            TotNettiInerti = TotNettiInerti + consinerti(i)
        Next i

'20151020
        For i = 0 To 2
            consfiller(i + 1) = NettoFillerBuffer(i)
        Next i
'
        TotNettiInerti = PesoTotaleAggregatiManuale + PesoTotaleRiciclatoManuale
        TotNettiFiller = PesoTotaleFillerManuale
        StoricoViatop = PesoTotaleViatopManuale
        StoricoViatop = PesoTotaleViatopManuale
        '20160426
        consviatopscarmixer1 = NettoViatopScarMixer1Buffer
        consviatopscarmixer2 = NettoViatopScarMixer2Buffer
        TotNettoViatopScarMixer1 = consviatopscarmixer1
        TotNettoViatopScarMixer2 = consviatopscarmixer2
        '20160426
        AppoggioBitSpruzzato = PesoTotaleBitumeManuale
        consAcqua = ScManualeAcqua.Peso
        consAdd1 = ScManualeAddMesc.Peso
        consAdd2 = ScManualeAddBac.Peso
'        consAddSacchi = ScManualeAddSacchi.Peso
        
        BufferAddKgSacchi(3) = BufferAddKgSacchi(2)
                        
'20151007
        If GestionePesoSacchi And CP240.AdoDosaggio.Recordset.Fields("AdditivoSacchi").Value Then
'
            consAddSacchi = Round(BufferAddKgSacchi(3) / CP240.AdoDosaggio.Recordset.Fields("PesoSacco").Value, 0)
        Else
            consAddSacchi = Null2Qualcosa(CP240.LblAddSacchi(0).caption)
        End If
        
    Else
        StoricoViatop = NettoViatopBuffer(1)
        NettoViatopBuffer(1) = 0

        TotNettiInerti = TotNettiInerti + NettoRAPBuffer + Round(NettoRAPSiwaBuffer, 0)

        Call RiempieBufferPortine(CP240.AdoDosaggioScarico.Recordset, TramoggeScarico)
        
        For i = 0 To 8
'NumeroAccoppiate = 1 portina non accoppiata
'NumeroAccoppiate > 1 indica il numero di portine accoppiate
'NumeroAccoppiate = 0 portina accoppiata alla precedente
            If (i <= 6) Then
                If (TramoggeScarico(i).NumeroAccoppiate <> 1) Then
                        If (TramoggeScarico(i).NumeroAccoppiate > 0) Then
                            consInertiPa = NettoAggregatiBuffer(i) / TramoggeScarico(i).NumeroAccoppiate
                        End If
                        consinerti(i) = consInertiPa
                Else
                    consinerti(i) = NettoAggregatiBuffer(i)
                End If
            
'                Debug.Print CStr(DateTime.Now) + " Tramoggia nr:" + CStr(i) + " TramoggeScarico.NumeroAccoppiate =" + CStr(TramoggeScarico(i).NumeroAccoppiate)
'                Debug.Print CStr(DateTime.Now) + " consinerti :" + CStr(consinerti(i))
            
            Else
                
'                Debug.Print CStr(DateTime.Now) + " NettoAggregatiBuffer :" + CStr(NettoAggregatiBuffer(i))
                consinerti(i) = NettoAggregatiBuffer(i)
            End If
                                               
                                               
            '''consinerti(i) = NettoAggregatiBuffer(i)
            TotNettiInerti = TotNettiInerti + consinerti(i)
        Next i

        If (SommaAggregati + Round(NettoRAPSiwaBuffer, 0) + NettoRAPBuffer <> CLng(TotNettiInerti)) Then
            Debug.Print "SommaComponenti: SommaAggregati(" + CStr(SommaAggregati) + ") <> TotNettiInerti(" + CStr(CLng(TotNettiInerti)) + "), perché?"
        End If
    
        For i = 0 To 2
            consfiller(i + 1) = NettoFillerBuffer(i)
            TotNettiFiller = TotNettiFiller + consfiller(i + 1)
        Next i
    
        If (CLng(SommaFiller) <> CLng(TotNettiFiller)) Then
            Debug.Print "SommaComponenti: SommaFiller(" + CStr(CLng(SommaFiller)) + ") <> TotNettiFiller(" + CStr(CLng(TotNettiFiller)) + "), perché?"
        End If
    
        If (TotNettiInerti < 300) And Not BufferAbilitaCicloRC(2) Then
            '300 Kg di aggregati di solito si pesano
            LogInserisci False, "SommaComponenti", "TotNettiInerti < 300 -> Exit Sub"
            Exit Sub
        End If
        
        'Aggiunta la posizione 2 del buffer perchè, in caso di cambio al volo, la memorizzazione nello storico avviene quando il ciclo della nuova ricetta
        'è già iniziato e senza questa posizione aggiuntiva l'ultimo ciclo fatto senza aggregati veniva perso!
        BufferAbilitaCicloRC(2) = BufferAbilitaCicloRC(1)
       
        AppoggioBitSpruzzato = BitSpruzzato
       
        consAcqua = val(CP240.LblAdd(5).caption)

        consAdd1 = Round(BufferKgAddMesc(3), 1)  'Riporto il peso dell'additivo teoricamente immesso
        
        If AdditivoBacinella.modoContalitri Then
            consAdd2 = 0
            consAdd2CNT = BufferAddBacNet(2)
            setAdd2CNT = BufferAddBacSet(2)
        Else
            consAdd2 = Round(BufferKgAddBac(3), 1)
            consAdd2CNT = 0
            setAdd2CNT = 0
            ''Riporto il tempo di spruzzatura
        End If
             
'20151007
'        If GestionePesoSacchi And CP240.AdoDosaggio.Recordset.Fields("additivo-sacchi").Value Then
        If GestionePesoSacchi And CP240.AdoDosaggio.Recordset.Fields("AdditivoSacchi").Value Then
'
            consAddSacchi = Round(BufferAddKgSacchi(3) / CP240.AdoDosaggio.Recordset.Fields("PesoSacco").Value, 0)
        Else
            consAddSacchi = CP240.LblAddSacchi(0).caption
        End If
    
        BufferKgBitume(0) = DosaggioLeganti(0).setCalcolato
        BufferKgBitume(1) = DosaggioLeganti(1).setCalcolato
        For i = 0 To 1
            BufferVoloBitume(i) = VoloBitume(i)
        Next i
        
        If InclusioneAddContalitri Then
            BufferKgBitume(2) = DosaggioLeganti(2).setCalcolato
            BufferVoloBitume(2) = VoloBitume(2)
        Else
            BufferKgBitume(2) = 0
            BufferVoloBitume(2) = 0
        End If
    
        BufferKgViatop = DosaggioViatop.setCalcolato
        BufferVoloViatop = CDbl(CP240.OPCData.items(PLCTAG_ResBilViatop1).Value)    'TODOCAGNAZ

        '20160426
        consviatopscarmixer1 = NettoViatopScarMixer1Buffer
        consviatopscarmixer2 = NettoViatopScarMixer2Buffer
        TotNettoViatopScarMixer1 = consviatopscarmixer1
        TotNettoViatopScarMixer2 = consviatopscarmixer2
        '20160426
        
    End If
    
        
    If (AppoggioBitSpruzzato = 0 Or ((CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value + CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) = 0)) Then
        AppoggioB1 = 0
        AppoggioB2 = 0
    Else
        If BitumeGravita Then
            AppoggioB1 = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB1Kg).Value, 1)
            AppoggioB2 = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB2Kg).Value, 1)
        Else
            AppoggioB1 = RoundNumber((AppoggioBitSpruzzato / (CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value + CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) * CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value), 1)
            AppoggioB2 = RoundNumber((AppoggioBitSpruzzato / (CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value + CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) * CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value), 1)
        End If
    
    End If
    If InclusioneBitume2 Then
        consbitume(1) = AppoggioB1
        consbitume(2) = AppoggioB2
    Else
        If InclusioneBacinella2 Then
            consbitume(1) = AppoggioB1
            consbitume(2) = AppoggioB2
        Else
            consbitume(1) = AppoggioB1 + AppoggioB2
        End If
    End If
    
    
    consbitume(3) = RoundNumber(CP240.OPCData.items(PLCTAG_ContalitriNettoKg).Value, 1)
    
    If InclusioneBitume3 And (CP240.AdoDosaggioScarico.Recordset.Fields("SetBitumeSoft").Value > 0) Then
        consbitume(4) = RoundNumber(BitSpruzzato, 1)
        BufferVoloBitume(3) = VoloBitume(3)
    End If
    
    If PlcSchiumato.Abilitazione Then
        If (CSng(CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value) > 0) Then
                consbitume(5) = RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeHard_idx).Value, 1)
        End If
        If PlcSchiumato.abilitazioneSoft Then
            If (CSng(CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value) > 0) Then
                consbitume(4) = RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeSoft_idx).Value, 1)
            End If
        End If
    End If
        
    TotaleProdotto = RoundNumber(CalcoloTotaleImpasto, 0)
'
    

    With rstStoricoImpasto
        Set .ActiveConnection = DBcon
        .Source = "SELECT TOP 10 * FROM StoricoImpasto"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
                
        .AddNew

        ![Lotto] = CInt(CicliDosaggioEseguiti)
        ![DataOra] = Now
        ![IdDosaggioLOG] = IdDosaggioLOG_Memo
        If CP240.LblEtichetta(4).caption = "" Or val(CP240.LblEtichetta(4).caption) = 0 Then
            ![IdClienteLOG] = Null
        Else
            ![IdClienteLOG] = val(CP240.LblEtichetta(4).caption)
        End If
        ![Inerte1] = consinerti(0)
        ![Inerte2] = consinerti(1)
        ![Inerte3] = consinerti(2)
        ![Inerte4] = consinerti(3)
        ![Inerte5] = consinerti(4)
        ![Inerte6] = consinerti(5)
        ![Inerte7] = consinerti(6)
        ![Inerte8] = consinerti(7)
        ![Inerte9] = consinerti(8)
        ![Filler1] = consfiller(1)
        ![Filler2] = consfiller(2)
        ![Filler3] = consfiller(3)
        ![Bitume1] = consbitume(1)
        ![bitume2] = consbitume(2)
        ![Bitume3] = consbitume(3)
        ![Add1] = consAdd1
        ![Add2] = consAdd2
        ![AddSacchi] = consAddSacchi  'Num di sacchi effettivi
        ![NetAddViatop] = StoricoViatop
        ![TInertiDeposito] = TemperaturaTorre
        ![TInertiLavoro] = ListaTamburi(0).temperaturaScivolo
        ![TBitume] = ListaTemperature(TempLegante1Pompa).valore
        ![TBitume2] = ListaTemperature(TempLegante2Pompa).valore
        ![TMix] = MaxValoreTempSottoMesc
        ![TempoMix] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_setTempoMescolazione).Value)
        ![KgA1] = BufferKgAggregati(0)
        ![KgA2] = BufferKgAggregati(1)
        ![KgA3] = BufferKgAggregati(2)
        ![KgA4] = BufferKgAggregati(3)
        ![KgA5] = BufferKgAggregati(4)
        ![KgA6] = BufferKgAggregati(5)
        ![KgA7] = BufferKgAggregati(6)
        ![KgA8] = BufferKgAggregati(7)
        ![KgA9] = BufferKgAggregati(8)
        ![KgF1] = BufferKgFiller(0)
        ![KgF2] = BufferKgFiller(1)
        ![KgF3] = BufferKgFiller(2)
        ![KgB1] = BufferKgBitume(0)
        ![KgB2] = BufferKgBitume(1)
        ![KgB3] = BufferKgBitume(2)
        ![SetAdd1] = BufferKgAddMesc(3)
        ![PrimaMixAdd1] = CP240.OPCData.items(PLCTAG_ScAddPrimaDopoB).Value
        ![TempoMescolazioneAdd1] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_RitardoAdditivoMixer).Value)
        ![SetAdd2] = BufferKgAddBac(3)
        ' Num di Kg di additivo sacchi effettivamente inseriti
        If CInt(CP240.AdoDosaggio.Recordset.Fields("AdditivoSacchi").Value) = 1 Then
            ![SetAddSacchi] = BufferAddKgSacchi(3)
        Else
            ![SetAddSacchi] = "0"
        End If
        '
        ![KgV1] = BufferKgViatop
        ![TempoScaricoMix] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_SetTempoScaricoMixer).Value)
        ![RitardoScaricoFiller] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_TempoRitardoFiller).Value)
        ![RitardoScaricoBitume] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_TempoRitardoBitume).Value)
        ![RitardoScaricoViatop] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_TempoRitardoViatop).Value)
        ![RitardoB3] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_ContalitriRitardoScarico).Value)
        ![VoloA1] = BufferVoloAggregati(0)
        ![VoloA2] = BufferVoloAggregati(1)
        ![VoloA3] = BufferVoloAggregati(2)
        ![VoloA4] = BufferVoloAggregati(3)
        ![VoloA5] = BufferVoloAggregati(4)
        ![VoloA6] = BufferVoloAggregati(5)
        ![VoloA7] = BufferVoloAggregati(6)
        ![VoloA8] = BufferVoloAggregati(7)
        ![VoloA9] = BufferVoloAggregati(8)
        ![VoloF1] = BufferVoloFiller(0)
        ![VoloF2] = BufferVoloFiller(1)
        ![VoloF3] = BufferVoloFiller(2)
        ![VoloB1] = BufferVoloBitume(0)
        ![VoloB2] = BufferVoloBitume(1)
        ![VoloB3] = BufferVoloBitume(2)
        ![VoloViatop] = BufferVoloViatop
        ![ImpastoTeorico] = CInt(GrandezzaImpasto(0))
        ![CheckMAR] = PulsantieraPesate(1)
        ![AmpereMixer] = AssorbimentoMixer
        PulsantieraPesate(1) = 0

        'SCHIUMATO
        If PlcSchiumato.Abilitazione Then
            If PlcSchiumato.abilitazioneSoft Then
                'Da completare
                '![KgBitumeSoft] = consbitume(4)
                '![ritardoBitumeSoft] = CInt(CP240.OPCDataSchiumato.Items(RitardoAvvioCicloBSoft_idx).value) / 1000
                '![VoloBitumeSoft] = Non ha volo
            Else
                ![KgBitumeSoft] = consbitume(4)
                ![ritardoBitumeSoft] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_TempoRitardoBitume).Value)
                ![VoloBitumeSoft] = BufferVoloBitume(3)
            End If
            
            ![KgBitumeHard] = consbitume(5)
            ![ritardoBitumeHard] = CInt(CP240.OPCDataSchiumato.items(RitardoAvvioCiclo_idx).Value) / 1000
            '![VoloBitumeHard] = Non ha volo
        End If
        
        ![KgAcqua] = consAcqua
        ![RitardoAcqua] = CP240.OPCData.items(PLCTAG_AcquaRitardo).Value
        
        'RAP in tramoggia tampone e bilancia di dosaggio (caldo o freddo)
        ![RAP] = NettoRAPBuffer
        ![KgRAP] = DosaggioRAP.setCalcolato
        ![VoloRAP] = CP240.OPCData.items(PLCTAG_ResiduoRiciclato1).Value 'TODOPEO: che schifezza
        ![RitardoScaricoRAP] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_TempoRitardoRAP).Value)
        'RAP su nastro con unitá di peso Siwarex FTC (freddo)
        ![RAPSiwa] = DosaggioRAPSiwa.pesoOut ' oppure NettoRAPSiwa oppure DosaggioRAPSiwa.pesoOutPrecedente 'TODOPEO: verificare
        ![KgRAPSiwa] = DosaggioRAPSiwa.setCalcolato
        ![VoloRAPSiwa] = CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_VOLO).Value 'TODOPEO: che schifezza
        ![RitardoScaricoRAPSiwa] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_DB80_TempoRitardoRAPSiwa).Value)
        ![KgAdd2CNT] = consAdd2CNT
        ![setAdd2CNT] = setAdd2CNT
'201505011
        ![NumCistBitumePCL1] = BufferSelezCistLegPCL1
        ![NumCistBitumePCL2] = BufferSelezCistLegPCL2
        ![MaterialCistBitumePCL1] = BufferMatCistLegPCL1
        ![MaterialCistBitumePCL2] = BufferMatCistLegPCL2
'
        '20160426
        ![NetAddViatopScarMixer1] = consviatopscarmixer1
        ![RitardoScaricoViatopScarMixer1] = BufferRitardoViatopScarMixer1
        ![VoloViatopScarMixer1] = BufferVoloViatopScarMixer1
        ![ViatopScarMixer1SetKG] = BufferKgViatopScarMixer1

        ![NetAddViatopScarMixer2] = consviatopscarmixer2
        ![RitardoScaricoViatopScarMixer2] = BufferRitardoViatopScarMixer2
        ![VoloViatopScarMixer2] = BufferVoloViatopScarMixer2
        ![ViatopScarMixer2SetKG] = BufferKgViatopScarMixer2
        
        '20161122
        ![AddFlomac] = IIf(BilanciaStatus(IDAdditivoFlomac).FinePesata, 1, 0)
        ![SetAddFlomac] = IIf(BilanciaStatus(IDAdditivoFlomac).FinePesata, 1, 0)
        
        BilanciaStatus(IDAdditivoFlomac).FinePesata = False
        '
        
'20160729
        If Not CP240.AdoDosaggioScarico.Recordset.EOF Then
            If CP240.AdoDosaggioScarico.Recordset.Fields("AquablackSet").Value > 0 Then
                ![SetPercAquablack] = Round(AquablackRecipeActual.PercentageH2O, 1)
                ![NettokgAquablack] = Round(CDbl(Aquablack_HMI_PLC.FromPLC_H2O_Partial), 1)
                ![PiccoPressioneAquablack] = Round(CDbl(Aquablack_HMI_PLC.H2O_Press_Peak), 1)
                ![SelezioneBitumeAquablack] = AquablackRecipeActual.BitumenSelection
                ![VolokgAquablack] = 0
            Else
                ![SetPercAquablack] = 0
                ![NettokgAquablack] = 0
                ![PiccoPressioneAquablack] = 0
                ![SelezioneBitumeAquablack] = 0
                ![VolokgAquablack] = 0
            End If
        End If
'
        ![TempoRitardoScaricoAggregati] = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_TempoRitardoAggregati).Value)  '20161215
        
        '20170110
        If JobAttivo.StatusVB <> EnumStatoJobVB.Idle Then
            ![IdJob] = JobAttivo.IdJob
        End If
        '
        
        .Update
    End With

    
'20160705
'    Call StampaOgniDosaggio(rstStoricoImpasto)
'

    rstStoricoImpasto.Close
    
    Call CalcoloProgressImpasto
    
    If Not InclusioneLCPC Then
        Exit Sub
    End If
    
    TotKG = CLng(TotaleProdotto)
    PacchettoMixer = ""
    
    'Rendo comprensibile il pacchetto con le posizioni, tipo file XLS
    '1
    PacchettoMixer = PacchettoMixer + "T" + ","      'Fisso
    '2
    PacchettoMixer = PacchettoMixer + Format(rs!IdDosaggio, "0000") + ","    'N° ricetta
    '3-4-5
    PacchettoMixer = PacchettoMixer + Format(time, "hh,mm,ss") + ","      'Ora
    If DeflettoreSuVagliato Then
        PacchettoMixer = PacchettoMixer + "01," + Format(consinerti(5), "00000") + ","    'Netto tramoggia NV o sabbia
    Else
        PacchettoMixer = PacchettoMixer + "01," + Format(consinerti(7), "00000") + ","    'Netto tramoggia NV o sabbia
    End If
        PacchettoMixer = PacchettoMixer + "02," + Format(consinerti(4), "00000") + ","     'Netto tramoggia fine 1
    PacchettoMixer = PacchettoMixer + "03," + Format(consinerti(3), "00000") + ","     'Netto tramoggia fine 2
    PacchettoMixer = PacchettoMixer + "04," + Format(consinerti(2), "00000") + ","     'Netto tramoggia medio 1
    PacchettoMixer = PacchettoMixer + "05," + Format(consinerti(1), "00000") + ","     'Netto tramoggia medio 2
    PacchettoMixer = PacchettoMixer + "06," + Format(consinerti(0), "00000") + ","     'Netto tramoggia grosso
    
    '18
    PacchettoMixer = PacchettoMixer + Format(SommaAggregati, "00000") + ","      'Bilancia Aggregati
    '19
    PacchettoMixer = PacchettoMixer + "00000" + ","       'RISERVATO
    '20
    PacchettoMixer = PacchettoMixer + Format(NettoRAPSiwaBilancia, "00000") + ","  'Bilancia RAPSiwa
    '21-22
    PacchettoMixer = PacchettoMixer + "00000,000" + ","    'Bilancia fresato caldo - NO MARINI
    '
    '23
    PacchettoMixer = PacchettoMixer + CambiaChar(Format(consfiller(1), "000.0"), ",", ".") + ","     'Netto F1
    '24
    PacchettoMixer = PacchettoMixer + CambiaChar(Format(consfiller(2), "000.0"), ",", ".") + ","     'Netto F2
    '25
    PacchettoMixer = PacchettoMixer + CambiaChar(Format(consfiller(3), "000.0"), ",", ".") + ","     'Netto F3
    '26
    PacchettoMixer = PacchettoMixer + CambiaChar(Format(SommaFiller, "000.0"), ",", ".") + ","       'Bilancia Filler
    '27-28
    PacchettoMixer = PacchettoMixer + "01," + Format(AppoggioB1 * 10, "00000") + "," 'Bilancia Bitume 1
    '29-30
    PacchettoMixer = PacchettoMixer + "02," + Format(AppoggioB2 * 10, "00000") + "," 'Bilancia Bitume 2
    '31-32
    PacchettoMixer = PacchettoMixer + "01," + Format(StoricoViatop, "00000") + ","       'Viatop
    '33-34
    PacchettoMixer = PacchettoMixer + "02," + Format(consAddSacchi, "00000") + ","              'Add. Sacchi
    '35-36
    PacchettoMixer = PacchettoMixer + "01," + CambiaChar(Format(AppoggioB1, "000.0"), ",", ".") + ","     'Bilancia Bitume 1
    '37-38
    PacchettoMixer = PacchettoMixer + "01," + CambiaChar(Format(AppoggioB2, "000.0"), ",", ".") + ","     'Bilancia Bitume 2
    '
    
    If InclusioneWindQual Then
        '39
        PacchettoMixer = PacchettoMixer + Format(CInt(LimitaValore(CLng(consAddSacchi), 0, 99)), "00") + ","      'Kg Tot. Sacchi
        '40
        PacchettoMixer = PacchettoMixer + "01" + "," 'n° Sacchi
        '41
        PacchettoMixer = PacchettoMixer + Format(CInt(LimitaValore(CLng(consAddSacchi), 0, 99)), "00") + ","                 'Kg 1 Sacco
        '42-43-44
        PacchettoMixer = PacchettoMixer + "00,00,00" + ","    'Secondo add. sacchi
    Else
        PacchettoMixer = PacchettoMixer + "01" + ","    'NO MARINI
        PacchettoMixer = PacchettoMixer + "02" + ","    'NO MARINI
    End If
    '45
    PacchettoMixer = PacchettoMixer + CambiaChar(Format(consAdd1, "00.00"), ",", ".") + ","       'Kg Add. Liquido 1
    '46
    PacchettoMixer = PacchettoMixer + CambiaChar(Format(consAdd2, "00.00"), ",", ".") + ","       'Kg Add. Liquido 2
    '
    If InclusioneWindQual Then
        'Fatto perchè Windqual contiene errori
        '47
        PacchettoMixer = PacchettoMixer + Format(TempoTotaleCiclo, "000") + ","     'Tempo totale ciclo
        '48
        PacchettoMixer = PacchettoMixer + Format(TempoMixSecca(1), "000") + ","     'Tempo mescolazione secca (da apertura aggr. a inizio spruzz. bitume)
        '49
        PacchettoMixer = PacchettoMixer + Format(TempoMescolazUmida, "0000") + ","  'Tempo mescolazione umida (da inizio spruzz. bitume a scarico mixer)
        '50
        PacchettoMixer = PacchettoMixer + Format(CP240.TextTempiRitardoSc(1).text, "000") + ","     'Tempo mescolazione da ricetta
    Else
        PacchettoMixer = PacchettoMixer + Format(TempoTotaleCiclo, "000.0") + ","     'Tempo totale ciclo
        PacchettoMixer = PacchettoMixer + LCPC_ZERO(Format(TempoMixSecca(1), "000.0")) + ","        'Tempo mescolazione secca (da apertura aggr. a inizio spruzz. bitume)
        PacchettoMixer = PacchettoMixer + TempoMescolazUmida + ","    'Tempo mescolazione umida (da inizio spruzz. bitume a scarico mixer)
        PacchettoMixer = PacchettoMixer + Format(TempoMixTotale(1), "000") + ","       'Tempo mescolazione totale (da aperuta aggr. a scarico mixer)
    End If
    '51-52
    PacchettoMixer = PacchettoMixer + "01," + CambiaChar(Format(ListaTemperature(TempLegante1Pompa).valore, "000.0"), ",", ".") + "," 'Temperatura Bitume 1
    '53-54
    PacchettoMixer = PacchettoMixer + "02," + CambiaChar(Format(ListaTemperature(TempLegante2Pompa).valore, "000.0"), ",", ".") + "," 'Temperatura Bitume 2
    '55
    PacchettoMixer = PacchettoMixer + "KKK" + ","           'Temperatura Scarico Mixer la metto dove spedisco i dati
    '56-57
    PacchettoMixer = PacchettoMixer + "01,00000" + ","         'Peso silo 1
    '58-59
    PacchettoMixer = PacchettoMixer + "02,00000" + ","         'Peso silo 2
    '60-61
    PacchettoMixer = PacchettoMixer + "03,00000" + ","         'Peso silo 3
    '62
    PacchettoMixer = PacchettoMixer + Format(TotKG, "00000") + ","      'Peso reale impasto
    '63
    PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
    '64
    PacchettoMixer = PacchettoMixer + "V" + ","             'Bitume Volumetrico
    '65-66
    PacchettoMixer = PacchettoMixer + "01,00000" + ","      'Densità bitume
    '67
    PacchettoMixer = PacchettoMixer + "00000" + ","         'Valore impulsi contalitri bitume - NO MARINI
    '68
    PacchettoMixer = PacchettoMixer + "00000" + ","         'Numero impulsi contalitri bitume - NO MARINI
    '69-70
    PacchettoMixer = PacchettoMixer + "01,000" + ","        'Temperatura silo 1
    '71-72
    PacchettoMixer = PacchettoMixer + "02,000" + ","        'Temperatura silo 2
    '73-74
    PacchettoMixer = PacchettoMixer + "03,000" + ","        'Temperatura silo 3
    '75
    PacchettoMixer = PacchettoMixer + "1" + ","             '1=Automatico / 0=Manuale
    '76
    PacchettoMixer = PacchettoMixer + Format(FuoriTolleranza, "0") + ","    '1=impasto con fuori tolleranza
    '77
    PacchettoMixer = PacchettoMixer + "0" + ","             '1=Impasto non conforme
    '78
    PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
    If (InclusioneWindQual) Then
        '79
        PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
        '80
        PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
        '81
        PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
        '82
        PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
        '83
        PacchettoMixer = PacchettoMixer + "00000" + ","         'RISERVATO
    End If
    '84-85-86
    PacchettoMixer = PacchettoMixer + Format(Date, "dd,mm,yyyy") + ","      'Data
    '
    
    Exit Sub
	ErrorHandler:
    LogInserisci True, "DOS-041 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TimeOutDosaggio()
	Dim i As Integer
	Dim SchiumatoAttivo As Boolean

    On Error GoTo Errore

    If Not DosaggioInCorso Then
        For i = 0 To 20
            AllarmiDosaggio(i).OraErrore = 0
        Next i
        Exit Sub
    End If
        
    If (DEMO_VERSION) Then
        Exit Sub
    End If
        
    AllarmiDosaggio(0).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAgg1).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'A1
    AllarmiDosaggio(1).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAgg2).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'A2
    AllarmiDosaggio(2).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAgg3).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'A3
    AllarmiDosaggio(3).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAgg4).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'A4
    AllarmiDosaggio(4).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAgg5).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'A5
    AllarmiDosaggio(5).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAgg6).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'A6
    AllarmiDosaggio(6).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataAggNV).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)      'A7
    AllarmiDosaggio(7).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataFill1).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)      'F1
    AllarmiDosaggio(8).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataFill2).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)      'F2
    AllarmiDosaggio(9).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_PesataFill3).Value And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)      'F3
    AllarmiDosaggio(10).ValorePLC = ((CP240.OPCData.items(PLCTAG_DO_GravitaPesataB1).Value Or CP240.OPCData.items(PLCTAG_DO_PesataLegante1).Value) And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)       'B1
    AllarmiDosaggio(11).ValorePLC = ((CP240.OPCData.items(PLCTAG_DO_GravitaPesataB2).Value Or CP240.OPCData.items(PLCTAG_DO_PesataLegante2).Value) And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)    'B2
    AllarmiDosaggio(12).ValorePLC = (RAPSiwaInPesata And Not CP240.OPCData.items(PLCTAG_SospensionePesate).Value)     'Ric
    AllarmiDosaggio(13).ValorePLC = CP240.OPCData.items(PLCTAG_DO_ScaricoAggregati).Value      'scarico Agg
    AllarmiDosaggio(14).ValorePLC = CP240.OPCData.items(PLCTAG_DO_ScaricoFiller).Value     'scarico Filler
    AllarmiDosaggio(15).ValorePLC = (CP240.OPCData.items(PLCTAG_DO_ScaricoLegante).Value Or CP240.OPCData.items(PLCTAG_DO_GravitaScarico).Value)      'scarico Bitume
    AllarmiDosaggio(16).ValorePLC = CP240.OPCData.items(PLCTAG_DO_ScaricoBilRiciclato).Value       'scarico Ric

    For i = 0 To 16
        With AllarmiDosaggio(i)
            If (.ValorePLC) Then
                If (.OraErrore = 0) Then
                    .OraErrore = ConvertiTimer()
                Else
                    If (ConvertiTimer() > .OraErrore + .TimeOut) Then
                        Call AllarmeTemporaneo(.messaggio, True)
                        .OraErrore = 0
                    End If
                End If
            Else
                .OraErrore = 0
            End If
        End With
    Next i

    If PlcSchiumato.Abilitazione Then
        SchiumatoAttivo = CP240.OPCDataSchiumato.items(DosaggioInCorso_idx).Value
        If PlcSchiumato.abilitazioneSoft Then
            SchiumatoAttivo = (SchiumatoAttivo Or CP240.OPCDataSchiumato.items(DosaggioInCorsoBSoft_idx).Value)
        End If
    End If
    
    If (Not MescolazioneInCorso) Then
        For i = 0 To 16
            With AllarmiDosaggio(i)
                If (Not .ValorePLC) And (Not SchiumatoAttivo) And Not (RAPSiwaInPesata) And Not (ScaricoAcqua) And Not CP240.OPCData.items(PLCTAG_DO_ContalitriPesata).Value Then
                    If (AllarmiDosaggio(17).OraErrore = 0) Then
                        AllarmiDosaggio(17).OraErrore = ConvertiTimer()
                    Else
                        If (ConvertiTimer() > AllarmiDosaggio(17).OraErrore + AllarmiDosaggio(17).TimeOut) Then
                            Call AllarmeTemporaneo(AllarmiDosaggio(17).messaggio, True)
                            AllarmiDosaggio(17).OraErrore = 0
                            Exit For
                        End If
                    End If
                Else
                    AllarmiDosaggio(17).OraErrore = 0
                    Exit For
                End If
            End With
        Next i
    Else
        AllarmiDosaggio(17).OraErrore = 0
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-042 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub SetDimensioneImpastoKg(nuovaDimensione As Long)

    If (DimensioneImpastoKg <> nuovaDimensione) Then
        DimensioneImpastoKg = nuovaDimensione

        CP240.LblEtichetta(22).caption = CStr(DimensioneImpastoKg)
    End If

End Sub


Public Function RiduzioneImpastoCasoSacchi(ByRef min As Integer, ByRef passo As Integer) As Boolean

    Dim valore As Integer
    Dim numeroSacchi As Integer

    RiduzioneImpastoCasoSacchi = False

    min = 40
    passo = 1

    With CP240.AdoDosaggioNext.Recordset
        If (Not .BOF And Not .EOF) Then
            If (GestionePesoSacchi And .Fields("AdditivoSacchi").Value = 1) Then

                RiduzioneImpastoCasoSacchi = True

                numeroSacchi = .Fields("NumSacchi").Value
                
                If numeroSacchi = 0 Then Exit Function

                passo = 100 / numeroSacchi

                For valore = 100 To 40 Step (-1 * passo)
                    min = valore
                Next valore
            End If
        End If
    End With

    'CP240.UpDownProdDos.Increment = passo
    'FrmCalcolaImpasti.UpDownCalcolo.Increment = passo
    'CP240.CmdNettiSiloStoricoSommaSalva(7).enabled = (Not RiduzioneImpastoCasoSacchi)

End Function


Public Function VerificaRiduzioneImpastoCasoSacchi(ByRef riduzione As Integer, inIncremento As Boolean) As Boolean

    Dim min As Integer
    Dim passo As Integer
    Dim valore As Integer
    Dim nuovaRiduzione As Integer

    VerificaRiduzioneImpastoCasoSacchi = True

    If (RiduzioneImpastoCasoSacchi(min, passo)) Then

        If (((100 - riduzione) Mod passo) = 0) Then
            'Tutto ok
            Exit Function
        End If

        If (inIncremento) Then
            nuovaRiduzione = 100
            For valore = 100 To 40 Step (-1 * passo)
                If (valore > riduzione) Then
                    nuovaRiduzione = valore
                End If
            Next valore
        Else
            nuovaRiduzione = min
            For valore = min To 100 Step passo
                If (valore < riduzione) Then
                    nuovaRiduzione = valore
                End If
            Next valore
        End If

        riduzione = nuovaRiduzione 'min

        VerificaRiduzioneImpastoCasoSacchi = False

    End If

End Function

Public Sub SetRiduzioneImpasto(nuovaRiduzione As Integer)

    Dim min As Integer
    Dim passo As Integer
    'Dim numeroSacchi As Integer

'20170127
    If (RiduzioneImpasto <> nuovaRiduzione) Then
        If (RiduzioneImpastoCasoSacchi(min, passo)) Then
            Call VerificaRiduzioneImpastoCasoSacchi(nuovaRiduzione, (nuovaRiduzione > RiduzioneImpasto))
        End If

        RiduzioneImpasto = nuovaRiduzione

        CP240.LblProdDos.caption = RiduzioneImpasto
        Call SetDimensioneImpastoKg(CLng(ImpastoPeso() / 100 * CDbl(RiduzioneImpasto)))
    End If

End Sub

Public Sub ControlloLivelliAltiTramogge()
	Dim i As Integer
	Dim Livello As Integer

    On Error GoTo Errore

    With CP240

        For i = 0 To compMax - 1
            '20160421 i Viatop Scarico Mixer1,2 non hanno i livelli
            If (i = CompViatopScarMixer1 Or i = CompViatopScarMixer1) Then
                Exit Sub
            End If
            '20160421
            If i <> CompNonVagliato2 Then
                Livello = .PrbTrLivello(i).Value
                If (i = 18 And ParallelDrum) Then
                    If (Livello > TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaCriticaPercentuale) Then
                        .PctTrLivello(i).Visible = Not .PctTrLivello(i).Visible
                    Else
                        .PctTrLivello(i).Visible = False
                    End If
                Else
                    If (i = 6) Then
                        If (.OPCData.items(PLCTAG_DI_SicLivMaxTramRic).Value) Then
                            .PctTrLivello(i).Visible = True
                            If (ListaMotori(MotoreElevatoreRiciclato).ritorno) Then
                                AllarmeCicalino = True
                                'Call SetMotoreUscita(MotoreElevatoreRiciclato, False)
                            End If
                        Else
                            If (.PrbTrLivello(i).Visible And (Livello >= TramoggeLivelloMassimo)) Then
                                .PctTrLivello(i).Visible = (Not .PctTrLivello(i).Visible)
                            Else
                                .PctTrLivello(i).Visible = False
                            End If
                        End If
'20151130
                    ElseIf (i >= 8) And (i <= 10) Then 'filler 1,2,3
                        If (Not LivelloMaxF1 And (i = 8)) Or (Not LivelloMaxF2 And (i = 9)) Then
                            If (.PrbTrLivello(i).Visible And (Livello >= TramoggeLivelloMassimo)) Then
                                .PctTrLivello(i).Visible = (Not .PctTrLivello(i).Visible)
                            Else
                                .PctTrLivello(i).Visible = False
                            End If
                        Else
                            .PctTrLivello(i).Visible = False
                        End If
'
                    Else
                        If ( _
                            .PrbTrLivello(i).Visible And _
                            (Livello >= TramoggeLivelloMassimo Or _
                            (Livello < TramoggeLivelloMinimo And (i = 7 And TramoggeVisualizzaLivelloMinimo And CP240.AniPushButtonDeflettore(3).Value = 1))) _
                        ) Then
                            'Il NV lampeggia con il vuoto anche se ho selezionato da parametri il livello digitale solo di massimo
                            If (((TipoLivelliA And (2 ^ i)) = 0)) Then
                                .PctTrLivello(i).Visible = (Not .PctTrLivello(i).Visible)
                            Else
                                If TramoggeLivelliDigitaliMinimo Then
                                    .PctTrLivello(i).Visible = (Not .PctTrLivello(i).Visible)
                                Else
                                    .PctTrLivello(i).Visible = False
                                End If
                            End If
                            '
                        Else
                            .PctTrLivello(i).Visible = False
                        End If
                        
                    End If
                End If
            End If
        Next i

        '20160318
        'If LivelloMinSiloFiller(1) Or LivelloMaxSiloFiller(1) Then
        If (LivelloMaxSiloFiller(1)) Then
        '
            .PctFillerLivello(0).Visible = Not .PctFillerLivello(0).Visible
        Else
            .PctFillerLivello(0).Visible = False
        End If

        'PctFillerLivello(1) Filler 2 e PctFillerLivello(2) Filler 3 non sono MAI visualizzati

        If (BloccoSpruzzaturaAltaTemp) Then
            CP240.Image1(25).Visible = Not CP240.Image1(25).Visible
        Else
            CP240.Image1(25).Visible = False
        End If

    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-043 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub DeflettoreNonPassa_change()

    On Error GoTo Errore

    If (FCNonPassaGrosso And Not FCNonPassaRifiuti) Then
        CP240.ImgDeflettore(0).Picture = LoadResPicture("IDI_DEFLETTORESU", vbResIcon)
    ElseIf (FCNonPassaRifiuti And Not FCNonPassaGrosso) Then
        CP240.ImgDeflettore(0).Picture = LoadResPicture("IDI_DEFLETTOREGIU", vbResIcon)
    ElseIf (FCNonPassaGrosso = FCNonPassaRifiuti) Then
        CP240.ImgDeflettore(0).Picture = LoadResPicture("IDI_DEFLETTOREERR", vbResIcon)
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-044 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub GestioneBitumeGravita()

    On Error GoTo Errore

    If (BitumeGravita) Then

        With CP240.AdoDosaggio.Recordset

        End With

    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-045 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub RinfrescaOrigineDatiDosaggio(NomeRicDosSel As String)

    Dim NomeRicDosSelNext As String
    
    '20161202
    If Not CP240.AdoDosaggioNext.Recordset.EOF Then
        NomeRicDosSelNext = CP240.AdoDosaggioNext.Recordset.Fields("Descrizione").Value
    End If
    '20161202
    
    CP240.AdoDosaggioNext.Refresh

    CP240.AdoDosaggio.Refresh
    CP240.adoComboDosaggio.ReFill
    
    Dim Stringa2 As String
    Stringa2 = RTrim(NomeRicDosSel)
    
    Do Until CP240.AdoDosaggio.Recordset.EOF
        If RTrim(CP240.LblNomeRicDos(0).caption) = Stringa2 Then
            Exit Do
        End If
        CP240.AdoDosaggio.Recordset.MoveNext
    Loop
'

    Do Until CP240.AdoDosaggioNext.Recordset.EOF
        If NomeRicDosSelNext = CP240.AdoDosaggioNext.Recordset.Fields("Descrizione").Value Then
            Exit Do
        End If
        CP240.AdoDosaggioNext.Recordset.MoveNext
    Loop

End Sub

'20160229
Public Sub RinfrescaNomeRicDosaggio()

    Dim IdRicDosSel As String
    Dim IdRicDosSelNext As String
    Dim IdRicDosSelScar As String

    If Not CP240.AdoDosaggioNext.Recordset.EOF Then
        IdRicDosSelNext = CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value
        IdRicDosSel = CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value
        IdRicDosSelScar = CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value
    End If
    
    CP240.AdoDosaggioNext.Refresh

    CP240.AdoDosaggio.Refresh
    CP240.adoComboDosaggio.ReFill
    CP240.AdoDosaggioScarico.Refresh
                           
    Do Until CP240.AdoDosaggio.Recordset.EOF
        If IdRicDosSel = CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value Then
            CP240.adoComboDosaggio.text = CP240.AdoDosaggio.Recordset.Fields("Descrizione").Value
            Exit Do
        End If
        CP240.AdoDosaggio.Recordset.MoveNext
    Loop

    Do Until CP240.AdoDosaggioNext.Recordset.EOF
        If IdRicDosSelNext = CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value Then
            Exit Do
        End If
        CP240.AdoDosaggioNext.Recordset.MoveNext
    Loop
    
    Do Until CP240.AdoDosaggioScarico.Recordset.EOF
        If IdRicDosSelScar = CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value Then
            Call SendMessagetoPlus(PlusSendActiveDosingRecipeMixerID, IdRicDosSelScar)    '20170206
            Exit Do
        End If
        CP240.AdoDosaggioScarico.Recordset.MoveNext
    Loop


End Sub
'

Public Sub DosaggioInCorso_change()

    If (DosaggioInCorso) Then
        '   Azzeramento della portata allo start
        TrendCampionamentoInserisciEvento TrendPortataOrariaMixer, DateTime.Now, 0
    Else
        Call AbilitazioneCambioRicetta(True)
        '20160729
        Aquablack_HMI_PLC.FROM_HMI_Stop = True
        CP240.tmrAqResetComandi.enabled = True
        '
        cambioVoloTempiAggRic = False '20161210
    End If

    '20150904
    'Aggiunto "And Not PlusCommunicationBroken" in tutti i pulsanti "plus"
    '

    CP240.imgPulsanteForm(TBB_STORICO).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    CP240.imgPulsanteForm(TBB_ALLARMI).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    CP240.imgPulsanteForm(TBB_STORICOIMPMANUALI).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    CP240.imgPulsanteForm(TBB_STORICOPREDOSAGGIO).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    CP240.imgPulsanteForm(TBB_STORICOSILO).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    CP240.imgPulsanteForm(TBB_TREND).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    '20170220
    CP240.imgPulsanteForm(TBB_DOSINGMATERIALS).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    CP240.imgPulsanteForm(TBB_TOTALDOSINGRECIPE).enabled = (Not DosaggioInCorso And Not PlusCommunicationBroken)
    '
    Call CP240.UpdatePulsantiForm

    Call CP240.AbilitaCalibrazione

    '   Abilita il pulsante del manuale dosaggio
    '20150409
    'CP240.AniPushButtonDeflettore(10).enabled = (Not DosaggioInCorso) And Not HardKeyRemoved
    '
    '20170224
    CP240.AniPushButtonDeflettore(10).enabled = (Not DosaggioInCorso And Not HardKeyRemoved And Not PlusCommunicationBroken)
    '

    If (DosaggioInCorso And PesaturaManuale) Then
        PesaturaManuale = False
        CP240.AbilitaInversionePCL
        CP240.AbilitaDosaggioManuale (True)
    End If
    
    CP240.OPCData.items(PLCTAG_DO_DosaggioInCorso).Value = DosaggioInCorso
    
    CP240.CmdNettiSiloStoricoSommaSalva(8).enabled = Not DosaggioInCorso
    CP240.CmdNettiSiloStoricoSommaSalva(9).enabled = Not DosaggioInCorso

    Call SendMessagetoPlus(PlusSendDosingInStart, IIf(DosaggioInCorso, 1, 0))

    Call CP240StatusBar_Change(STB_DOSAGGIO, 1) '20161014


End Sub

Public Sub Valv3VieSpruzzatriceVersoTorre_Change()

    CP240.CmdTrPesa(11).enabled = Valv3VieSpruzzatriceVersoTorre
    
    If Valv3VieSpruzzatriceVersoTorre Then
        CP240.imgValvolaCisterne(0).Picture = LoadResPicture("IDB_VALV3VIESPRUZZATRICE_OFF", vbResBitmap)
    Else
        CP240.imgValvolaCisterne(0).Picture = LoadResPicture("IDB_VALV3VIESPRUZZATRICE_ON", vbResBitmap)
    End If
    
    If Valv3VieSpruzzatriceVersoTorre And CaricoSpruzzatriceBitume Then
        'Stop carico spruzzatrice bitume
        ManualePesaturaComponenti = compMax
        CaricoSpruzzatriceBitume = False
        CP240.imgValvolaCisterne(1).Picture = LoadResPicture("IDB_CAMIONSPRUZZATRICE_OFF", vbResBitmap)
    End If
    
End Sub

Public Sub Valv3VieBitume2Emulsione_Change()

    If (AbilitaValvolaBitumeEmulsione = 2) Then
        If (ValvolaBitumeEmulsioneSelezioneEmulsione And ValvolaBitumeEmulsioneVersoEmulsione And Not ValvolaBitumeEmulsioneVersoBitume) Then
    
            CP240.imgValvolaCisterne(4).Picture = LoadResPicture("IDB_VALV3VIESPRUZZATRICE_ON", vbResBitmap)
            CP240.LblEtichetta(72).caption = "Emuls"

        ElseIf (Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ValvolaBitumeEmulsioneVersoEmulsione And ValvolaBitumeEmulsioneVersoBitume) Then

            CP240.imgValvolaCisterne(4).Picture = LoadResPicture("IDB_VALV3VIESPRUZZATRICE_OFF", vbResBitmap)
            CP240.LblEtichetta(72).caption = "B.2"

        Else

            CP240.imgValvolaCisterne(4).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
            CP240.LblEtichetta(72).caption = "X-X"

        End If
    End If

    If (AbilitaValvolaBitumeEmulsione = 1) Then
        If (ValvolaBitumeEmulsioneSelezioneEmulsione And ValvolaBitumeEmulsioneVersoEmulsione And Not ValvolaBitumeEmulsioneVersoBitume) Then

            CP240.imgValvolaCisterne(4).Picture = LoadResPicture("IDB_VALV3VIESPRUZZATRICE_ON", vbResBitmap)
            CP240.LblEtichetta(72).caption = "Emuls"

        ElseIf (Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ValvolaBitumeEmulsioneVersoEmulsione And ValvolaBitumeEmulsioneVersoBitume) Then

            CP240.imgValvolaCisterne(4).Picture = LoadResPicture("IDB_VALV3VIESPRUZZATRICE_OFF", vbResBitmap)
            CP240.LblEtichetta(72).caption = "B.1"

        Else

            CP240.imgValvolaCisterne(4).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
            CP240.LblEtichetta(72).caption = "X-X"

        End If
    End If

End Sub

Public Sub RinfrescaOrigineDatiClienti(NomeCliente As String)
    CP240.AdoClienti.Refresh
    CP240.AdoComboClienti.ReFill

    Do Until CP240.AdoClienti.Recordset.EOF
        If CP240.AdoComboClienti.text = NomeCliente Then
            Exit Do
        End If
        CP240.AdoClienti.Recordset.MoveNext
    Loop

    IdClienteScaricoSilo = 0 '20151216
    
End Sub

'20151201
Public Sub RinfrescaOrigineDatiClientiCamion(NomeCliente As String)
    CP240.AdoClientiCamion.Refresh
    CP240.AdoComboClientiCamion.ReFill

    Do Until CP240.AdoClientiCamion.Recordset.EOF
        If CP240.AdoComboClientiCamion.text = NomeCliente Then
            Exit Do
        End If
        CP240.AdoClientiCamion.Recordset.MoveNext
    Loop
                      
    IdTargaCamionScaricoSilo = 0
    
    Call RefillTargheCamion '20160314
                      
End Sub
'
'20160314
Public Sub RefillTargheCamion()

    Dim rs As New adodb.Recordset
    
    CP240.cmbTargaCamion.Clear

    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT * FROM [CYB500].[dbo].[Camion] JOIN [CYB500].[dbo].ClientiLOG ON [CYB500].[dbo].[Camion].IdClienteLOG = [CYB500].[dbo].ClientiLOG.IdClienteLOG WHERE Descrizione='" & CP240.AdoComboClientiCamion.text & "' ORDER BY Descrizione;"
        .LockType = adLockReadOnly
        .CursorLocation = adUseClient
        .CursorType = adOpenForwardOnly
        .Open , DBcon
    
        If Not .BOF Then 'verifica se la tabella non e' vuota
            .MoveFirst
        
            Do Until .EOF
                CP240.cmbTargaCamion.AddItem rs![Targa]
                .MoveNext
            Loop
        End If
    
        .Close
    End With

End Sub
'


Public Function ControlloCondizioniStartDosaggio() As Boolean

    'STAMPA CONTINUA
    Dim lReturn As Long
    Dim lDoc As Long
    Dim MyDocInfo As DOCINFO
'20150513
    Dim MaterialeokPCL1 As Boolean
    Dim MaterialeokPCL2 As Boolean
'
    Dim rstStoricoImpasto As New adodb.Recordset
    '
    Dim messaggioerrore As String
    Dim controllierr As Boolean
    
    Dim aquablackok As Boolean
    
    On Error GoTo Errore

    ControlloCondizioniStartDosaggio = False

    If (CistGestione.Gestione = GestioneSemplificata) Then
        Call CompilaListaCistDosaggio
        Call GestioneMaterialeCisterneRidotto
        
        MaterialeokPCL1 = (VerificaMaterialeCistDosaggio(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1, ListaCisterneValideDosaggioPCL1))
        MaterialeokPCL2 = (VerificaMaterialeCistDosaggio(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2, ListaCisterneValideDosaggioPCL2))
    End If

    aquablackok = True

    If Not CP240.AdoDosaggioNext.Recordset.EOF Then
        If ((Not PlcAquablackConnesso And (CP240.AdoDosaggioNext.Recordset.Fields("AquablackSet").Value > 0)) Or Aquablack_Digital.AquablackStatoManuale) And InclusioneAquablack Then
            aquablackok = False
        End If
    End If

    
    If Not aquablackok Then
    
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1527)

    'Controllo che il filler sia in tara
    ElseIf BilanciaFiller.Peso > BilanciaFiller.Tara Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(180)
    
    'Controllo che gli aggregati siano in tara
    ElseIf BilanciaAggregati.Peso > BilanciaAggregati.Tara Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(179)
    
    'Controllo che il riciclato sia in tara
    ElseIf BilanciaRAP.Peso > BilanciaRAP.Tara Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1469)
    
    'Controllo che il viatop sia in tara
    ElseIf BilanciaViatop.Peso > BilanciaViatop.Tara Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(582)
    
    'Controllo che il compressore sia acceso
    ElseIf Not ListaMotori(MotoreCompressore).ritorno Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(580)

    'Controllo destinazione silo inserita
    ElseIf (DestinazioneSilo = 0) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(181)

    'Controllo motore mixer
    ElseIf (Not ListaMotori(MotoreMescolatore).ritorno) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(182)
    
    'Controllo che con il viatop in ricetta il ciclone non contenga materiale
    ElseIf (Not CicloneMinViatop And CP240.OPCData.items(PLCTAG_SetViatop1).Value <> 0) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(829)
        
    'Controllo bitume esterno
    ElseIf InclusioneBitumeEsterno And (Not Pcl1AutoOn And Not ListaMotori(MotorePCL).ritorno And Not StatoValvolaManCircuitoBitume = CircuitoMarini) And _
            val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) + val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0 _
        Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = MotPCLNoOk
                
    'Controllo bitume esterno
    ElseIf InclusioneBitumeEsterno And (StatoValvolaManCircuitoBitume = Indefinito) Or (StatoValvolaManCircuitoBitume = Errore) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1048)
    
    ElseIf val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) + val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0 And _
            (Not Pcl1AutoOn And (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) > 0) And Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePCL).ritorno) Or _
            (Not Pcl2AutoOn And (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0) And Not ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePCL2).ritorno) Or _
            ((val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) > 0) And ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePompaEmulsione).ritorno) Or _
            ((val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0) And ValvolaBitumeEmulsioneSelezioneEmulsione And Not ListaMotori(MotorePompaEmulsione).ritorno) _
        Then
            
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = MotPCLNoOk
        
    ElseIf val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) + val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) > 0 And _
            (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) And BassaTemperaturaBitume(0)) _
            Or (val(CP240.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) And BassaTemperaturaBitume(1)) _
        Then
            
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(384)
    
    ElseIf InclusioneBitume3 And (CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value > 0) And ListaMotori(MotorePCL3).presente _
            And Not ListaMotori(MotorePCL3).ComandoManuale And Not ListaMotori(MotorePCL3).ritorno _
        Then
        
        'PCL non è in moto
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = MotPCLNoOk
    
    'controllo selezione bitume coerente
    ElseIf (CistGestione.Gestione = GestioneSemplificata) And ((Not MaterialeokPCL1) And (MaterialeDosaggioPCL1 <> "")) _
            Or ((Not MaterialeokPCL2) And (MaterialeDosaggioPCL2 <> "")) _
        Then
            
            controllierr = True
            AllarmeCicalino = True
            messaggioerrore = LoadXLSString(1510)

    'Controllo pressione aria
    ElseIf (PressioneAriaInsufficente) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = NoAria
            
    'Controllo assorbimento del mescolatore
    ElseIf ( _
            ListaAmperometri(AmperometroMescolatore_1).Inclusione And _
            ListaAmperometri(AmperometroMescolatore_1).valore > ListaAmperometri(AmperometroMescolatore_1).sogliaMin _
            ) _
        Then
    '
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(616)
    
    'Controllo la selezione del Bitume1 o Bitume2 come da ricetta
    ElseIf Not BitumeGravita And AbilitaSelettoreBitume1 And (DosaggioLeganti(0).set <> 0) And (ScambioBitume2 = 1) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(613)
        
    ElseIf (DosaggioLeganti(1).set <> 0) And (ScambioBitume2 = 0) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(613)
        
    'Controllo ricetta inserita
    ElseIf CP240.adoComboDosaggio.text = "" Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = InsRicettaDos
        
    'Controllo inserimento numero cicli
    ElseIf (CicliDosaggioDaEseguire = 0) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = InsNumeroCicli
                
    ElseIf Not VerificaSetSicurezzeBilance Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = ""
    
    '20170222
    ElseIf Not PlcParametriOk Then
    
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1048)
    '
    End If

    Call ScambiaPompaCircLegante

    'STAMPA CONTINUA
    If (InclusioneStampaOgniDosaggio And IsPrinterReady(StampaOgniDosaggioNomeStampante)) Then
        StampaOgniDosaggioRicetta = ""
    End If
        
        
'    If (JobAttivo.StatusVB <> EnumStatoJobVB.Idle) Or (JobProssimo.StatusVB <> EnumStatoJobVB.Idle) And AllarmeCicalino Then
'        Call StopEmergenzaJob
'    End If
                               
    If controllierr And messaggioerrore = "" Then
        'in questo caso il messaggio e' gia' apparso in uno dei controlli precedenti
        Call StopEmergenzaJob
        Exit Function
    End If
        
    If controllierr Then
        Call StopEmergenzaJob
        Call ShowMsgBox(messaggioerrore, vbOKOnly, vbExclamation, -1, -1, True)
        AllarmeCicalino = False
    Else
        ControlloCondizioniStartDosaggio = True
    End If
            
    Exit Function

	Errore:

    AllarmeCicalino = True
    Call ShowMsgBox(ControllareRiprovare, vbOKOnly, vbExclamation, -1, -1, True)
    AllarmeCicalino = False
    
    LogInserisci True, "DOS-046 ", CStr(Err.Number) + " [" + Err.description + "]"
    
End Function


Public Sub ScaricoBitume_change(gravita As Boolean)

    On Error GoTo Errore

    With CP240

        If (gravita) Then
            If (ComandoScaricoBitume) Then
                NettoBitumeBuffer(0) = RoundNumber(.OPCData.items(PLCTAG_GravitaNettoB1Kg).Value, 1)
                NettoBitumeBuffer(1) = RoundNumber(.OPCData.items(PLCTAG_GravitaNettoB2Kg).Value, 1)
            End If
        Else
            If (ComandoScaricoBitume) Then
                NettoBitumeBuffer(0) = RoundNumber(.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
            End If
        End If

        If (ComandoScaricoBitume) Then
            If (DosaggioInCorso) Then
                TempoMixUmida(0) = CDbl(Timer)
            End If
        
'20170222
            BilanciaLegante.CompAttivo = -1 '20170223
            If Not PesaturaManuale Then Call InitPbarNettoPesata(CompGrafLegante1, CompLegante3)
'
        End If

    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-047 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ComandoScaricoMixer_change()

    On Error GoTo Errore

    Exit Sub
	Errore:
    LogInserisci True, "DOS-048 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub CalcolaTempoCiclo()

    Dim tonOra As Long

    On Error GoTo Errore

    If (DosaggioInCorso) Then
        TempoTotaleCiclo = ConvertiTimer() - ValoreTempoInizioCiclo
        CP240.LblTempoCiclo.caption = CStr(TempoTotaleCiclo)

        tonOra = CLng(RoundNumber((RoundNumber(3600 / CSng(TempoTotaleCiclo), 0) * (ImpastoPeso() * (RiduzioneImpasto / 100))) / 1000, 0))
        CP240.LblTonOrarie.caption = CStr(tonOra)

        Call SendMessagetoPlus(PlusSendTonPerHour, CInt(tonOra))

        Call TrendCampionamentoInserisciEvento(TrendPortataOrariaMixer, DateTime.Now, CDbl(CP240.LblTonOrarie.caption))
        ValoreTempoInizioCiclo = ConvertiTimer()

        TempoMixSecca(1) = RoundNumber(TempoMixUmida(0) - TempoMixSecca(0), 0)
        TempoMixUmida(1) = RoundNumber(CDbl(Timer) - TempoMixUmida(0), 1)
        TempoMixSecca(0) = 0
        TempoMixUmida(0) = 0
        TempoMescolazUmida = CambiaChar(Format(CStr(TempoMixUmida(1)), "000.0"), ",", ".")
        TempoMixTotale(1) = RoundNumber(TempoMixUmida(1) + TempoMixSecca(1), 0)
    Else
        TrendPortataOrariaMixerCicliEseguiti = Now
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-049 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BitumeDaCircuitoMarini_change()

    On Error GoTo Errore

    Exit Sub
	Errore:
    LogInserisci True, "DOS-050 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub BitumeDaCircuitoEsterno_change()

    On Error GoTo Errore

    Exit Sub
	Errore:
    LogInserisci True, "DOS-051 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub GestioneDosaggioBitumeEsterno()
	'gestione della pompa legante con valvola manuale 3 vie di selezione circuito esterno o Marini:
	'- in modo esterno, la pompa circolazione NON deve funzionare
	'- in modo Marini il funzionamento della pompa e' normale

    On Error GoTo Errore

    If Not InclusioneBitumeEsterno Then
        Exit Sub
    End If
    
'nelle assegnazioni di StatoValvolaManCircuitoBitume utilizzo i numeri diretti per chiarezza
    StatoValvolaManCircuitoBitume = 0
    If BitumeDaCircuitoEsterno Then
        StatoValvolaManCircuitoBitume = StatoValvolaManCircuitoBitume + 1
    End If
    If BitumeDaCircuitoMarini Then
        StatoValvolaManCircuitoBitume = StatoValvolaManCircuitoBitume + 2
    End If
    
'stato valvola manuale
    Select Case StatoValvolaManCircuitoBitume
        Case 0
            'nessun finecorsa premuto
            CP240.imgValvolaCisterne(cstIndiceImmagineValvola3VieBitumeEsterno).Picture = LoadPicture(GraphicPath + "Valvola_vert_neutra_3_vie.bmp")
        Case 1
            'circuito esterno selezionato
            CP240.imgValvolaCisterne(cstIndiceImmagineValvola3VieBitumeEsterno).Picture = LoadPicture(GraphicPath + "Valvola_vert_off_3_vie.bmp")
	Debug.Print "CYBERTRONIC_PLUS GestioneDosaggioBitumeEsterno"
			Case 2
				'circuito Marini selezionato
				CP240.imgValvolaCisterne(cstIndiceImmagineValvola3VieBitumeEsterno).Picture = LoadPicture(GraphicPath + "Valvola_vert_on_3_vie.bmp")
	Debug.Print "CYBERTRONIC_PLUS GestioneDosaggioBitumeEsterno"
			Case Else
				'allarme: entrambi i finecorsa premuti
				CP240.imgValvolaCisterne(cstIndiceImmagineValvola3VieBitumeEsterno).Picture = LoadPicture(GraphicPath + "Valvola_rossa.bmp")
		End Select

		Exit Sub
	Errore:
    LogInserisci True, "DOS-052 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BilAgg_change()

    On Error GoTo Errore
    
    With CP240.ProgressBil(0)

        .Value = BilanciaAggregati.Peso
        .caption = Format(BilanciaAggregati.Peso, "#,##0")

        If (.Value >= BilanciaAggregati.Sicurezza) Then
            .FillColor = vbRed
        Else
            .FillColor = vbBlue
        End If

    End With

    '20161104
    If FrmTaraBilancePN.Visible And BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_AGGREGATI Then
        FrmTaraBilancePN.lblValore.caption = Format(BilanciaAggregati.Peso, "#,##0.0")
    End If
    '
    
    '20170223
    If PesaturaManuale And BilanciaAggregati.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioAggregati(BilanciaAggregati.CompAttivo), BilanciaAggregati.Peso, ScManualeAggregati(BilanciaAggregati.CompAttivo).Peso, True)
    ElseIf BilanciaAggregati.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioAggregati(BilanciaAggregati.CompAttivo), BilanciaAggregati.Peso)
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-053 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub BilTamponeRiciclato_change()

    Dim valore As Double

    On Error GoTo Errore

    With CP240.ProgressBil(6)

        valore = BilanciaTamponeRiciclato.Peso
        .Value = valore
        .caption = Format(valore, "##0.0")

        If (.Value >= BilanciaTamponeRiciclato.Sicurezza) Then
            .FillColor = vbRed
        Else
            .FillColor = vbBlue
        End If

    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-054 ", CStr(Err.Number) + " [" + Err.description + "]"
    
End Sub


Public Sub BilFiller_change()

    Dim valore As Double

    On Error GoTo Errore

    With CP240.ProgressBil(1)

        valore = BilanciaFiller.Peso

        .Value = valore
        .caption = Format(valore, "##0.0")

        If (.Value >= BilanciaFiller.Sicurezza) Then
            .FillColor = vbRed
        Else
            .FillColor = vbBlue
        End If

    End With

    '20161104
    If FrmTaraBilancePN.Visible And BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_FILLER Then
        FrmTaraBilancePN.lblValore.caption = Format(BilanciaFiller.Peso, "#,##0.0")
    End If
    '

    '20170223
    If PesaturaManuale And BilanciaFiller.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioFiller(BilanciaFiller.CompAttivo), BilanciaFiller.Peso, ScManualeFiller(BilanciaFiller.CompAttivo + compfiller1).Peso, True)
    ElseIf BilanciaFiller.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioFiller(BilanciaFiller.CompAttivo), BilanciaFiller.Peso)
    End If
        
    Exit Sub
	Errore:
    LogInserisci True, "DOS-055 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BilRAP_Change()

    Dim valore As Double

    On Error GoTo Errore

    With CP240.ProgressBil(7)

        valore = BilanciaRAP.Peso

        .Value = valore
        .caption = Format(valore, "##0.0")

        If (.Value >= BilanciaRAP.Sicurezza) Then
            .FillColor = vbRed
        Else
            .FillColor = vbBlue
        End If

    End With

    '20161104
    If FrmTaraBilancePN.Visible And BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_RICICLATO Then
        FrmTaraBilancePN.lblValore.caption = Format(BilanciaRAP.Peso, "#,##0.0")
    End If
    '

    '20170222
    If DosaggioRAP.pesataAttiva Then
        Call PbarNettoPesata(DosaggioRAP, BilanciaRAP.Peso)
    End If
    '


    Exit Sub
	Errore:
    LogInserisci True, "DOS-056 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BilRAPSiwa_change()

    Dim valore As Double

    On Error GoTo Errore

    With CP240.ProgressBil(8)

        valore = BilanciaRAPSiwa.Peso

        .Value = valore
        .caption = Format(valore, "##0.0")

        If (.Value >= BilanciaRAPSiwa.Sicurezza) Then
            .FillColor = vbRed
        Else
            .FillColor = vbBlue
        End If

    End With

    '20170222
    If DosaggioRAPSiwa.pesataAttiva Then
        Call PbarNettoPesata(DosaggioRAPSiwa, BilanciaRAPSiwa.Peso)
    End If
    '

    Exit Sub
	Errore:
    LogInserisci True, "DOS-057 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub BilBit_change()

    On Error GoTo Errore

    With CP240.ProgressBil(2)

        .Value = BilanciaLegante.Peso
        .caption = Format(BilanciaLegante.Peso, "##0.0")

        If (.Value >= BilanciaLegante.Sicurezza) Then
            .FillColor = vbRed
        Else
            .FillColor = vbBlue
        End If

    End With

    '20161104
    If FrmTaraBilancePN.Visible And BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_BITUME Then
        FrmTaraBilancePN.lblValore.caption = Format(BilanciaLegante.Peso, "#,##0.0")
    End If
    '
        
    '20170223
    If PesaturaManuale And BilanciaLegante.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioLeganti(BilanciaLegante.CompAttivo), BilanciaLegante.Peso, ScManualeBitume(BilanciaLegante.CompAttivo + CompLegante1).Peso, True)
    ElseIf BilanciaLegante.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioLeganti(BilanciaLegante.CompAttivo), BilanciaLegante.Peso)
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-058 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub InvioFormulaDosaggio()

    Dim indice As Integer
    Dim NomeCampo As String
    Dim IndiceCampo As Integer
    Dim ceSoft As Boolean
    Dim ceHard As Boolean
    Dim longTmp As Long
    Dim CicloSenzaAggregati As Boolean
    'Dim numeroSacchi As Integer
    Dim KgAddMesc As Single
    Dim KgAddBac As Single
    Dim KgImpastoAdattatoBitume As Single 'kg su cui calcolare la % di bitume nel caso di bitume fuori dal 100%
    Dim SetPercBitumePLC(PLCTAG_SetB1 To PLCTAG_SetB2) As Single
    Dim errorPosition As Long
    

    'DB4: ricetta di dosaggio

    On Error GoTo Errore

    If (DEMO_VERSION) Then
        Exit Sub
    End If

	errorPosition = 0

    With CP240

        If .OPCData.items.count = 0 Then
            Exit Sub
        End If

        ceSoft = False
        If (Not IsNull(.AdoDosaggioNext.Recordset.Fields("SetBitumeSoft").Value)) Then
            If (CSng(.AdoDosaggioNext.Recordset.Fields("SetBitumeSoft").Value) > 0) Then
                ceSoft = True
            End If
        End If
        ceHard = False
        If (Not IsNull(.AdoDosaggioNext.Recordset.Fields("SetBitumeHard").Value)) Then
            If (CSng(.AdoDosaggioNext.Recordset.Fields("SetBitumeHard").Value) > 0) Then
                ceHard = True
            End If
        End If

        Dim min As Integer
        Dim passo As Integer
        Dim nuovaRiduzioneImpasto As Integer
        
        If (RiduzioneImpastoCasoSacchi(min, passo)) Then
            nuovaRiduzioneImpasto = RiduzioneImpasto
            If (Not VerificaRiduzioneImpastoCasoSacchi(nuovaRiduzioneImpasto, True)) Then
                Call SetRiduzioneImpasto(nuovaRiduzioneImpasto)
            End If
            .CmdNettiSiloStoricoSommaSalva(7).enabled = False
        Else
            .CmdNettiSiloStoricoSommaSalva(7).enabled = True
        End If

        'Numero ricetta dosaggio
        .OPCData.items(PLCTAG_NumRicDos).Value = Null2Qualcosa(.LblNumeroRicDos.caption)
        'Peso dell'impasto in base alla ricetta vagliata o N.V.
        .OPCData.items(PLCTAG_KgImpasto).Value = CSng(GrandezzaImpastoPLC())  'CSng(ImpastoPeso())
        'Faccio vedere l'impasto teorico ridotto
        Call SetDimensioneImpastoKg(CLng(ImpastoPeso() / 100 * CDbl(RiduzioneImpasto)))
        '

        'Tempo mescolazione
        .OPCData.items(PLCTAG_TimerMescolaz).Value = CSng(.TextTempiRitardoSc(1).text)
        'Tempo scarico mescolatore
        .OPCData.items(PLCTAG_TimerScMesc).Value = CSng(.TextTempiRitardoSc(3).text)
    
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementato
        .OPCData.items(PLCTAG_SetA7).Value = 0  'CSng(ValoreTODO)          'Set aggregato 7
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        'Set aggregato 8 = N.V.
        If (DosaggioAggregati(7).set > 0) Then
            .OPCData.items(PLCTAG_SetA8).Value = CSng(DosaggioAggregati(7).set)
                
            .OPCData.items(PLCTAG_MemTorSelRicNV2).Value = False
        Else
            .OPCData.items(PLCTAG_SetA8).Value = 0
            .OPCData.items(PLCTAG_MemTorSelRicNV2).Value = False
        End If

	errorPosition = 1

        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementati
        '.OPCData.Items(PLCTAG_SetA9).value = CSng(ValoreTODO)          'Set aggregato 9
        '.OPCData.Items(PLCTAG_SetA10).value = CSng(ValoreTODO)         'Set aggregato 10
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        If (InclusioneDoppiaPesataAgg) Then
    
            IndiceCampo = 1
            For indice = PLCTAG_SetPesataLentaA1 To PLCTAG_SetPesataLentaA6
                .OPCData.items(indice).Value = CSng(.AdoDosaggioNext.Recordset.Fields("PesataFineA" & IndiceCampo).Value)     'Impostazione pesata lenta aggregato 1..10
                IndiceCampo = IndiceCampo + 1
            Next indice
            '.OPCData.Items(PLCTAG_SetPesataLentaA7).value = CSng(ValoreTODO)     'Impostazione pesata lenta aggregato 7
            
            If (DosaggioAggregati(7).set > 0) Then
                .OPCData.items(PLCTAG_SetPesataLentaA8).Value = CSng(.AdoDosaggioNext.Recordset.Fields("PesataFineNV").Value)     'Impostazione pesata lenta aggregato 8 = NV
            Else
                .OPCData.items(PLCTAG_SetPesataLentaA8).Value = 0
            End If
        
        End If
        
        '.OPCData.Items(PLCTAG_SetPesataLentaA9).value = CSng(ValoreTODO)     'Impostazione pesata lenta aggregato 9
        '.OPCData.Items(PLCTAG_SetPesataLentaA10).value = CSng(ValoreTODO)    'Impostazione pesata lenta aggregato 10
        
        'IndiceCampo = 0
        'For Indice = PLCTAG_OrdineDosA1 To PLCTAG_OrdineDosA6       'Tramoggia aggregato per ordine di apertura
        '    .OPCData.Items(Indice).value = CInt(NumeroTramoggiaScAgg(IndiceCampo))
        '    Debug.Print .OPCData.Items(Indice).value
        '    IndiceCampo = IndiceCampo + 1
        'Next Indice
    
        Call TrasformaRicettaS7
        
        IndiceCampo = 1
'20160303
'        For indice = PLCTAG_SetA1 To PLCTAG_SetA6                           'Set aggregati 1..6
        For indice = PLCTAG_SetA1 To PLCTAG_SetA8                           'Set aggregati 1..6
'
            .OPCData.items(indice).Value = RicettaS7(IndiceCampo - 1).set
            IndiceCampo = IndiceCampo + 1
        Next indice
        IndiceCampo = 0
'
'        For indice = PLCTAG_OrdineDosA1 To PLCTAG_OrdineDosA6                'Tramoggia aggregato per ordine di apertura
        For indice = PLCTAG_OrdineDosA1 To PLCTAG_OrdineDosA8                'Tramoggia aggregato per ordine di apertura
'
            .OPCData.items(indice).Value = RicettaS7(IndiceCampo).Ordine
            IndiceCampo = IndiceCampo + 1
        Next indice
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementato
        '.OPCData.Items(PLCTAG_OrdineDosA7).value = CInt(ValoreTODO)     'Tramoggia aggregato per ordine di apertura
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
'20160223
'        'Con ricetta NV devo passare 1
'        If .OPCData.items(PLCTAG_SetA8).Value > 0 Then
'            .OPCData.items(PLCTAG_OrdineDosA8).Value = CInt(1)
'        Else
'            .OPCData.items(PLCTAG_OrdineDosA8).Value = CInt(0)
'        End If
        
	errorPosition = 2

        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementato
        '.OPCData.Items(PLCTAG_OrdineDosA9).value = CInt(ValoreTODO)     'Tramoggia aggregato per ordine di apertura
        '.OPCData.Items(PLCTAG_OrdineDosA10).value = CInt(ValoreTODO)     'Tramoggia aggregato per ordine di apertura
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        IndiceCampo = 1
        For indice = PLCTAG_ResA1 To PLCTAG_ResA6                       'Residuo aggregato 1..6
            NomeCampo = "ResiduoAgg" & IndiceCampo
            If .OPCData.items(PLCTAG_SetA1 + IndiceCampo - 1).Value > 0 Then
                .OPCData.items(indice).Value = CSng(.AdoDosaggioNext.Recordset.Fields(NomeCampo).Value * (-1))
            Else
                .OPCData.items(indice).Value = CSng(0)
            End If
            IndiceCampo = IndiceCampo + 1
        Next indice
    
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementato
        '.OPCData.Items(PLCTAG_ResA7).value = CSng(ValoreTODO)      'Residuo aggregato 7
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        'Residuo aggregato 8 = NV
        If (DosaggioAggregati(7).set > 0) Then
            .OPCData.items(PLCTAG_ResA8).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoNV").Value * (-1))
        Else
            .OPCData.items(PLCTAG_ResA8).Value = CSng(0)
        End If
    
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementato
        '.OPCData.Items(PLCTAG_ResA9).value = CSng(ValoreTODO)      'Residuo aggregato 9
        '.OPCData.Items(PLCTAG_ResA10).value = CSng(ValoreTODO)     'Residuo aggregato 10
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        'Tolleranza Bil. 1 aggregati
        .OPCData.items(PLCTAG_TollBil1A).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaAgg").Value)
        'Tempo stabilizzazione bilancia 1 aggregati carico
        .OPCData.items(PLCTAG_TempoStabBil1ACarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilAggregati").Value)
        'Tempo stabilizzazione bilancia 1 aggregati scarico
        .OPCData.items(PLCTAG_TempoStabBil1ASc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilAggregati").Value)
        
        '20161201
        'Tempo ritardo scarico aggregati
        If (CInt(.AdoDosaggioNext.Recordset.Fields("FirstComponent").Value) = 0) Then
            .OPCData.items(PLCTAG_TimerScA).Value = 0
        Else
            .OPCData.items(PLCTAG_TimerScA).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoAggregati").Value)
          End If
        .OPCData.items(PLCTAG_FirstComponentToDisc).Value = CInt(.AdoDosaggioNext.Recordset.Fields("FirstComponent").Value)
        '20161201
        
        If PesaturaRiciclatoAggregato7 Then
            .OPCData.items(PLCTAG_SetA7).Value = CSng(DosaggioAggregati(6).set)          'Set aggregato 7
            .OPCData.items(PLCTAG_SetPesataLentaA7).Value = CSng(.AdoDosaggioNext.Recordset.Fields("PesataFineA7").Value)  'Impostazione pesata lenta aggregato 7 = RAP
            .OPCData.items(PLCTAG_ResA7).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoAgg7").Value * (-1))   'Residuo aggregato 7
            If CSng(DosaggioAggregati(6).set) > 0 Then
                If .OPCData.items(PLCTAG_SetA8).Value > 0 Then
                    .OPCData.items(PLCTAG_OrdineDosA7).Value = CInt(2)
                Else
                    Dim MassimoOrdineAggregati As Integer
                    For indice = 0 To 5
                        If MassimoOrdineAggregati < RicettaS7(indice).Ordine Then
                            MassimoOrdineAggregati = RicettaS7(indice).Ordine
                        End If
                    Next indice
                    .OPCData.items(PLCTAG_OrdineDosA7).Value = MassimoOrdineAggregati + 1
                End If
            Else
                    .OPCData.items(PLCTAG_OrdineDosA7).Value = 0
            End If
        Else
            .OPCData.items(PLCTAG_SetA7).Value = CSng(0)          'Set aggregato 7
            .OPCData.items(PLCTAG_SetPesataLentaA7).Value = CSng(0)  'Impostazione pesata lenta aggregato 7 = RAP
            .OPCData.items(PLCTAG_ResA7).Value = CSng(0)   'Residuo aggregato 7
        End If
        '
        
	errorPosition = 3

        IndiceCampo = 1
        For indice = PLCTAG_SetF1 To PLCTAG_SetF3                           'Set Filler 1..3
            NomeCampo = "Filler" & IndiceCampo
            .OPCData.items(indice).Value = CSng(DosaggioFiller(IndiceCampo - 1).set)
            IndiceCampo = IndiceCampo + 1
        Next indice
        IndiceCampo = 1
        For indice = PLCTAG_SetPesataLentaFil1 To PLCTAG_SetPesataLentaFil3
            .OPCData.items(indice).Value = CSng(.AdoDosaggioNext.Recordset.Fields("PesataFineF" & IndiceCampo).Value)     'Impostazione pesata lenta filler 1..3
            IndiceCampo = IndiceCampo + 1
        Next indice

        IndiceCampo = 0
        If .OPCData.items(PLCTAG_SetF1).Value > 0 Then
            IndiceCampo = IndiceCampo + 1
            .OPCData.items(PLCTAG_OrdineDosFil1).Value = CSng(IndiceCampo) 'Filler per ordine di pesatura
        Else
            .OPCData.items(PLCTAG_OrdineDosFil1).Value = CSng(0)           'Filler per ordine di pesatura
        End If
        If .OPCData.items(PLCTAG_SetF2).Value > 0 Then
            IndiceCampo = IndiceCampo + 1
            .OPCData.items(PLCTAG_OrdineDosFil2).Value = CSng(IndiceCampo) 'Filler per ordine di pesatura
        Else
            .OPCData.items(PLCTAG_OrdineDosFil2).Value = CSng(0)           'Filler per ordine di pesatura
        End If
        If .OPCData.items(PLCTAG_SetF3).Value > 0 Then
            IndiceCampo = IndiceCampo + 1
            .OPCData.items(PLCTAG_OrdineDosFil3).Value = CSng(IndiceCampo) 'Filler per ordine di pesatura
        Else
            .OPCData.items(PLCTAG_OrdineDosFil3).Value = CSng(0)           'Filler per ordine di pesatura
        End If
        
        IndiceCampo = 1
        For indice = PLCTAG_ResF1 To PLCTAG_ResF3                       'Residuo filler 1..3
            NomeCampo = "ResiduoFiller" & IndiceCampo
            If .OPCData.items(PLCTAG_SetF1 + IndiceCampo - 1).Value > 0 Then
                .OPCData.items(indice).Value = CSng(.AdoDosaggioNext.Recordset.Fields(NomeCampo).Value * (-1))
            Else
                .OPCData.items(indice).Value = CSng(0)
            End If
            IndiceCampo = IndiceCampo + 1
        Next indice

        'Tolleranza Bil. 2 filler
        .OPCData.items(PLCTAG_TollBil2F).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaFiller").Value)
        'Tempo stabilizzazione bilancia 2 filler carico
        .OPCData.items(PLCTAG_TempoStabBil2FCarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilFiller").Value)
        'Tempo stabilizzazione bilancia 2 filler scarico
        .OPCData.items(PLCTAG_TempoStabBil2FSc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilFiller").Value)
        'Tempo ritardo scarico filler
        .OPCData.items(PLCTAG_TimerScF).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoFiller").Value)

	errorPosition = 4

        If (AbilitaSelettoreBitume1) Then
            If Not BitumeGravita Then
                If (CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0) Then
                    SetPercBitumePLC(PLCTAG_SetB1) = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
                    .OPCData.items(PLCTAG_SetB1).Value = SetPercBitumePLC(PLCTAG_SetB1)
                Else
                    SetPercBitumePLC(PLCTAG_SetB1) = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value)
                    .OPCData.items(PLCTAG_SetB1).Value = SetPercBitumePLC(PLCTAG_SetB1)
                End If
            Else
                SetPercBitumePLC(PLCTAG_SetB1) = 0
                .OPCData.items(PLCTAG_SetB1).Value = 0
            End If
            SetPercBitumePLC(PLCTAG_SetB2) = 0
            .OPCData.items(PLCTAG_SetB2).Value = 0
        Else
            IndiceCampo = 1
            For indice = PLCTAG_SetB1 To PLCTAG_SetB2                           'Set Bitume 1..2
                NomeCampo = "Bitume" & IndiceCampo
                If Not BitumeGravita Then
                    SetPercBitumePLC(indice) = CSng(.AdoDosaggioNext.Recordset.Fields(NomeCampo).Value)
                    .OPCData.items(indice).Value = SetPercBitumePLC(indice)
                Else
                    SetPercBitumePLC(indice) = 0
                    .OPCData.items(indice).Value = 0
                End If
                IndiceCampo = IndiceCampo + 1
            Next indice
        End If

        IndiceCampo = 1
        For indice = PLCTAG_SpruzzataLenta1 To PLCTAG_SpruzzataLenta2
            If Not BitumeGravita Then
                .OPCData.items(indice).Value = CSng(.AdoDosaggioNext.Recordset.Fields("PesataFineB" & IndiceCampo).Value)     'Impostazione spruzzata lenta bitume 1..2
            Else
                .OPCData.items(indice).Value = 0
            End If
            IndiceCampo = IndiceCampo + 1
        Next indice
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementati
        '.OPCData.Items(PLCTAG_SetB3).value = CSng(ValoreTODO)          'Set Bitume 3
        '.OPCData.Items(PLCTAG_SetB4).value = CSng(ValoreTODO)          'Set Bitume 4
        
        '.OPCData.Items(PLCTAG_Set_PesataLentaBit1).value = CSng(ValoreTODO)     'Impostazione pesata lenta legante 1
        '.OPCData.Items(PLCTAG_Set_PesataLentaBit2).value = CSng(ValoreTODO)     'Impostazione pesata lenta legante 2
        '.OPCData.Items(PLCTAG_Set_PesataLentaBit3).value = CSng(ValoreTODO)     'Impostazione pesata lenta legante 3
        '.OPCData.Items(PLCTAG_Set_PesataLentaBit4).value = CSng(ValoreTODO)     'Impostazione pesata lenta legante 4
        '.OPCData.Items(PLCTAG_SpruzzataLenta3).value = CSng(ValoreTODO)        'Impostazione spruzzata lenta legante 3
        '.OPCData.Items(PLCTAG_SpruzzataLenta4).value = CSng(ValoreTODO)        'Impostazione spruzzata lenta legante 4
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
	errorPosition = 5

        IndiceCampo = 0
        If CSng(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value) > 0 Then
            IndiceCampo = IndiceCampo + 1
            If Not BitumeGravita Then
                .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(IndiceCampo)     'Bitume per ordine di pesatura
            Else
                .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(0)
            End If
        Else
            .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(0)               'Bitume per ordine di pesatura
        End If
        If CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0 Then
            IndiceCampo = IndiceCampo + 1
            If Not BitumeGravita Then
                .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(IndiceCampo)     'Bitume per ordine di pesatura
            Else
                .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(0)
            End If
        Else
            .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(0)               'Bitume per ordine di pesatura
        End If
    
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementati
        '.OPCData.Items(PLCTAG_OrdineDosBit3).value = CSng(ValoreTODO)          'Pesata legante per ordine di apertura 3
        '.OPCData.Items(PLCTAG_OrdineDosBit4).value = CSng(ValoreTODO)          'Pesata legante per ordine di apertura 4
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        If (AbilitaSelettoreBitume1) Then
            If (CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0) Then
                .OPCData.items(PLCTAG_ResB1Scarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoBitume2").Value * (-1))
                .OPCData.items(PLCTAG_ResB2Scarico).Value = CSng(0)
            Else
                .OPCData.items(PLCTAG_ResB1Scarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoBitume1").Value * (-1))
                .OPCData.items(PLCTAG_ResB2Scarico).Value = CSng(0)
            End If
        Else
            IndiceCampo = 1
            For indice = PLCTAG_ResB1Scarico To PLCTAG_ResB2Scarico         'Residuo bitume 1..2 in scarico
                NomeCampo = "ResiduoBitume" & IndiceCampo
                If .OPCData.items(PLCTAG_SetB1 + IndiceCampo - 1).Value > 0 Then
                    If Not BitumeGravita Then
                        .OPCData.items(indice).Value = CSng(.AdoDosaggioNext.Recordset.Fields(NomeCampo).Value * (-1))
                    Else
                        .OPCData.items(indice).Value = 0
                    End If
                Else
                    .OPCData.items(indice).Value = CSng(0)
                End If
                IndiceCampo = IndiceCampo + 1
            Next indice
        End If

        
	errorPosition = 6

        'Residuo bitume 1 in pesata
        If Not BitumeGravita And .OPCData.items(PLCTAG_SetB1).Value > 0 Then
            .OPCData.items(PLCTAG_ResB1Pesata).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoPesBitume").Value * (-1))
        Else
            .OPCData.items(PLCTAG_ResB1Pesata).Value = CSng(0)
        End If
        'Residuo bitume 2 in pesata
        If Not BitumeGravita And .OPCData.items(PLCTAG_SetB2).Value > 0 Then
            .OPCData.items(PLCTAG_ResB2Pesata).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoPesBitume").Value * (-1))
        Else
            .OPCData.items(PLCTAG_ResB2Pesata).Value = CSng(0)
        End If
        
            
        'Tolleranza Bil. 3 bitume
        .OPCData.items(PLCTAG_TollBil3B1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaBitume").Value)
        'Tempo stabilizzazione bilancia 3 bitume carico
        .OPCData.items(PLCTAG_TempoStabBil3BCarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilBitume").Value)
        'Tempo stabilizzazione bilancia 3 bitume scarico
        .OPCData.items(PLCTAG_TempoStabBil3BSc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilBitume").Value)
        'Tempo ritardo scarico bitume
        .OPCData.items(PLCTAG_TimerScB).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoBitume").Value)


        'Assegno al bitume 1 anche i dati del bitume 2 e del Soft (P-P080154 Conglobit)
        If PlcSchiumato.Abilitazione Then
            If (InclusioneBitume2 And Not AbilitaSelettoreBitume1) And (CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0) Then
                .OPCData.items(PLCTAG_SetB1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
                .OPCData.items(PLCTAG_ResB1Scarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoBitume2").Value * (-1))
                .OPCData.items(PLCTAG_ResB1Pesata).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoPesBitume").Value * (-1))
                .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(1)
                .OPCData.items(PLCTAG_SetB2).Value = CSng(0)
                .OPCData.items(PLCTAG_ResB2Scarico).Value = CSng(0)
                .OPCData.items(PLCTAG_ResB2Pesata).Value = CSng(0)
                .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(0)
            End If
        End If

	errorPosition = 7

        If Bitume2InBlending Then
            .OPCData.items(PLCTAG_AbilitaBlendingBitume).Value = False
            .OPCData.items(PLCTAG_BlendingB1_Perc).Value = CSng(0)
            .OPCData.items(PLCTAG_BlendingB2_Perc).Value = CSng(0)
            .OPCData.items(PLCTAG_BlendingB3_Perc).Value = CSng(0)
            .OPCData.items(PLCTAG_BlendingB4_Perc).Value = CSng(0)
            '
            If (CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0) Then

                If (CSng(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value) = 0) Then
                    'Solo Bitume 2
                    .OPCData.items(PLCTAG_SetB1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
                    .OPCData.items(PLCTAG_ResB1Scarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoBitume2").Value * (-1))
                    .OPCData.items(PLCTAG_ResB1Pesata).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoPesBitume").Value * (-1))
                    .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(1)
                    .OPCData.items(PLCTAG_SetB2).Value = CSng(0)
                    .OPCData.items(PLCTAG_ResB2Scarico).Value = CSng(0)
                    .OPCData.items(PLCTAG_ResB2Pesata).Value = CSng(0)
                    .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(0)
'20150923
                    'Nuovi TAG per Blending
                    .OPCData.items(PLCTAG_AbilitaBlendingBitume).Value = True
                    .OPCData.items(PLCTAG_BlendingB1_Perc).Value = CSng(0)
                    .OPCData.items(PLCTAG_BlendingB2_Perc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
                    .OPCData.items(PLCTAG_BlendingB3_Perc).Value = CSng(0)
                    .OPCData.items(PLCTAG_BlendingB4_Perc).Value = CSng(0)

                    .OPCData.items(PLCTAG_NM_IN_BIT_BIT2_IN_BLENDING).Value = True 'Bitume2InBlending
                    .OPCData.items(PLCTAG_AbilitaBlendingBitume).Value = True 'Bitume2InBlending
'
                Else
                    'Blending Bitume1 + Bitume2
                    .OPCData.items(PLCTAG_SetB1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value) + CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
                    .OPCData.items(PLCTAG_ResB1Scarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoBitume1").Value * (-1))
                    .OPCData.items(PLCTAG_ResB1Pesata).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoPesBitume").Value * (-1))
                    .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(1)
                    .OPCData.items(PLCTAG_SetB2).Value = CSng(0)
                    .OPCData.items(PLCTAG_ResB2Scarico).Value = CSng(0)
                    .OPCData.items(PLCTAG_ResB2Pesata).Value = CSng(0)
                    .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(0)
                    'Nuovi TAG per Blending
                    .OPCData.items(PLCTAG_AbilitaBlendingBitume).Value = True
                    .OPCData.items(PLCTAG_BlendingB1_Perc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value)
                    .OPCData.items(PLCTAG_BlendingB2_Perc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
                    .OPCData.items(PLCTAG_BlendingB3_Perc).Value = CSng(0)
                    .OPCData.items(PLCTAG_BlendingB4_Perc).Value = CSng(0)

                    .OPCData.items(PLCTAG_NM_IN_BIT_BIT2_IN_BLENDING).Value = True 'Bitume2InBlending
                End If
                '
            End If
        End If

        If (InclusioneBitume3 And ceSoft) Then
            .OPCData.items(PLCTAG_SetB1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("SetBitumeSoft").Value)
            .OPCData.items(PLCTAG_ResB1Scarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoBitumeSoft").Value * (-1))
            .OPCData.items(PLCTAG_ResB1Pesata).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoPesBitume").Value * (-1))
            .OPCData.items(PLCTAG_OrdineDosBit1).Value = CSng(1)
            .OPCData.items(PLCTAG_SetB2).Value = CSng(0)
            .OPCData.items(PLCTAG_ResB2Scarico).Value = CSng(0)
            .OPCData.items(PLCTAG_ResB2Pesata).Value = CSng(0)
            .OPCData.items(PLCTAG_OrdineDosBit2).Value = CSng(0)
            .OPCData.items(PLCTAG_TollBil3B1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaBitumeSoft").Value)
            .OPCData.items(PLCTAG_TempoStabBil3BCarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("StabilizzazioneBitumeSoft").Value)
            .OPCData.items(PLCTAG_TempoStabBil3BSc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("StabilizzazioneBitumeSoft").Value)
        End If
        '
        
'20150511
        MaterialeDosaggioPCL1 = .AdoDosaggioNext.Recordset.Fields("Bitume1Associato").Value
        MaterialeDosaggioPCL2 = .AdoDosaggioNext.Recordset.Fields("Bitume2Associato").Value
'

	errorPosition = 8

        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Dosaggio riciclato
        'RAP (in tramoggia caldo o freddo)
        Dim enable As Boolean
        enable = (AbilitaRAP And .AdoDosaggioNext.Recordset.Fields("RAP").Value > 0)
        .OPCData.items(PLCTAG_SetRAP).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("RAP").Value, 0)) 'Set
        .OPCData.items(PLCTAG_OrdineBilRAP).Value = CSng(IIf(enable, 1, 0))
        .OPCData.items(PLCTAG_SetPesataLentaRAP).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("PesataFineRAP").Value, 0))
        .OPCData.items(PLCTAG_ResRAP).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("ResiduoRAP").Value * (-1), 0))
        .OPCData.items(PLCTAG_TollBilRAP).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TolleranzaRAP").Value, 0))
        .OPCData.items(PLCTAG_TempoStabBilRAPCarico).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TempoStabBilRAP").Value, 0))
        .OPCData.items(PLCTAG_TempoStabBilRAPSc).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TempoStabBilRAP").Value, 0)) ' Stesso valore di stabilizzazione in carico
        '.OPCData.items(PLCTAG_TimerScRAP).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAP").Value, 0)) '.TextTempiRitardoSc(16) é direttamente collegato ad AdoDosaggioScarico 20161202
        'RAPSiwa (su nastro di pesatura)
        enable = (AbilitaRAPSiwa And .AdoDosaggioNext.Recordset.Fields("RAPSiwa").Value > 0)
        .OPCData.items(PLCTAG_SetRAPSiwa).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("RAPSiwa").Value, 0))
        .OPCData.items(PLCTAG_OrdineDosRAPSiwa).Value = CSng(IIf(enable > 0, 1, 0))
        .OPCData.items(PLCTAG_SetPesataLentaRAPSiwa).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("PesataFineRAPSiwa").Value, 0))
        .OPCData.items(PLCTAG_ResRAPSiwa).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("ResiduoRAPSiwa").Value * (-1), 0))
        .OPCData.items(PLCTAG_TollBilRAPSiwa).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TolleranzaRAPSiwa").Value, 0))
        .OPCData.items(PLCTAG_TempoStabBilRAPSiwaSc).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAPSiwa").Value, 0))
        '.OPCData.items(PLCTAG_TimerScRAPSiwa).Value = CSng(IIf(enable, .AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAPSiwa").Value, 0)) '.TextTempiRitardoSc(17) é direttamente collegato ad AdoDosaggioScarico 20161202
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Dosaggio Viatop
        .OPCData.items(PLCTAG_SetViatop1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("SetViatop").Value)
        'Impostazione pesata lenta viatop 1
        .OPCData.items(PLCTAG_SetPesataLentaVia1).Value = CSng(.AdoDosaggioNext.Recordset.Fields("PesataFineV1").Value)
        'Residuo Viatop 1
        .OPCData.items(PLCTAG_ResBilViatop1).Value = CSng(IIf(.OPCData.items(PLCTAG_SetViatop1).Value > 0, .AdoDosaggioNext.Recordset.Fields("ResiduoViatop").Value * (-1), 0))
        'Pesata viatop per ordine di apertura 1
        .OPCData.items(PLCTAG_OrdineViatop_1).Value = CSng(IIf(.OPCData.items(PLCTAG_SetViatop1).Value > 0, 1, 0))
        'Tolleranza Bil. 1 Viatop
        .OPCData.items(PLCTAG_TollBilV).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaViatop").Value)
        'Tempo stabilizzazione bilancia viatop carico
        .OPCData.items(PLCTAG_TempoStabBilVCarico).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilViatop").Value)
        'Tempo stabilizzazione bilancia viatop scarico
        .OPCData.items(PLCTAG_TempoStabBilVSc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoStabBilViatop").Value)
        'Tempo ritardo scarico viatop
        .OPCData.items(PLCTAG_TimerScViatop).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScViatop").Value)

        '20160419
        'Viatop Scarico Mixer 1
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Set).Value = CSng(.AdoDosaggioNext.Recordset.Fields("SetViatopScarMixer1").Value)
        '20161012
        '.OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Volo).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoViatopScarMixer1").Value)
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Volo).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoViatopScarMixer1").Value * -1)
        '
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Ordine).Value = 1
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Tolleranza).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaViatopScarMixer1").Value)
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_TStabTara).Value = 0
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Ritardo).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TempoRitScViatopScarMixer1").Value)
        'Viatop Scarico Mixer 1
        
        'Viatop Scarico Mixer 2
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Set).Value = CSng(.AdoDosaggioNext.Recordset.Fields("SetViatopScarMixer2").Value)
        '20161012
        '.OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Volo).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoViatopScarMixer2").Value)
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Volo).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoViatopScarMixer2").Value * -1)
        '
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Volo).Value = CSng(.AdoDosaggioNext.Recordset.Fields("ResiduoViatopScarMixer2").Value)
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Ordine).Value = 1
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Tolleranza).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TolleranzaViatopScarMixer2").Value)
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_TStabTara).Value = 0
        .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Ritardo).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TempoRitScViatopScarMixer2").Value)
        'Viatop Scarico Mixer 2
        '20160419
        
        'Set Add. 1 nel mescolatore
        KgAddMesc = RoundNumber(CLng(CSng(.AdoDosaggioNext.Recordset.Fields("AdditivoTempo1").Value) * (CSng(DimensioneImpastoKg) / CSng(100))), 1)
        '20150604
        'Taglio a 32.000 msec (32 sec.) il tempo di inserimento additivo nel mescolatore
        '.OPCData.items(PLCTAG_SetAdd1Mix).Value = (KgAddMesc / CSng(PortataAddMescolatore * DensAddMixer) * 1000)
        longTmp = (KgAddMesc / CSng(PortataAddMescolatore * DensAddMixer) * 1000)
        longTmp = IIf(longTmp < 0, 0, IIf(longTmp > 32000, 32000, longTmp))
        longTmp = IIf(InclusioneAddMescolatore, longTmp, 0) '20150924
        .OPCData.items(PLCTAG_SetAdd1Mix).Value = longTmp
        '
        
	errorPosition = 9
        
        If Not DosaggioInCorso Then
	'       CP240.LblAdd(2).caption = RoundNumber(CLng(.AdoDosaggioNext.Recordset.Fields("Additivo-Tempo1").Value * RiduzioneImpasto * 10) / 1000, 1)
            CP240.LblAdd(2).caption = KgAddMesc
            BufferKgAddMesc(2) = CP240.LblAdd(2).caption
        End If
        BufferKgAddMesc(1) = Round(KgAddMesc, 1)

        'Tempo ritardo scarico add. 1 nel mescolatore
        .OPCData.items(PLCTAG_TimerScAdd1Mesc).Value = CSng(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoAdd1").Value)

        'Set Add. 2 nella bacinella di pesatura
        
'        .OPCData.items(PLCTAG_SetAdd2PesB).Value = CLng(.AdoDosaggioNext.Recordset.Fields("Additivo-Tempo2").Value * RiduzioneImpasto * 10)
        If InclusioneLegante100 Then
            KgImpastoAdattatoBitume = DimensioneImpastoKg
        Else
            KgImpastoAdattatoBitume = (DimensioneImpastoKg / (100 + SetPercBitumePLC(PLCTAG_SetB1) + SetPercBitumePLC(PLCTAG_SetB2))) * 100
        End If
        
        KgAddBac = (CSng(.AdoDosaggioNext.Recordset.Fields("AdditivoTempo2").Value) * (CSng(KgImpastoAdattatoBitume) / CSng(100) * ((SetPercBitumePLC(PLCTAG_SetB1) + SetPercBitumePLC(PLCTAG_SetB2)) / 100)))
        
	'20150608
	'   .OPCData.items(PLCTAG_SetAdd2PesB).Value = (KgAddBac / CSng(PortataAddMescolatore * DensAddMixer) * 1000)
        .OPCData.items(PLCTAG_SetAdd2PesB).Value = (KgAddBac / CSng(PortataAddBacinella * AdditivoBacinella.densita) * 1000)
	'

        If Not DosaggioInCorso Then
            .LblAdd(3).caption = RoundNumber(KgAddBac, 1)
            BufferKgAddBac(2) = CP240.LblAdd(3).caption
        End If
        BufferKgAddBac(1) = RoundNumber(KgAddBac, 1)

        'Tempo ritardo scarico add. 2 nella bacinella Bacinella
        'Campo inutilizzato fino a oggi, ora lo uso per la velocità dell'inverter della pompa additivo bacinella
        .OPCData.items(PLCTAG_TimerScAdd2Bacinella).Value = CSng(0)
        longTmp = CLng(CSng(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoAdd2").Value) / 100 * 27648)
        If (longTmp = 0) Then
            longTmp = 27648 / 2  ' Funziona almeno al 50%
        End If
        .OPCData.items(PLCTAG_AO_PompaAddLegante).Value = longTmp
        '

        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementati
        '.OPCData.Items(PLCTAG_SetAdd3Spruzz).value = CInt(ValoreTODO)  'Set Add. 3 nella spruzzatura bitume
        '.OPCData.Items(PLCTAG_TimerScAdd3SpruzzB).value = CSng(ValoreTODO)     'Tempo ritardo scarico add. 3 nella spruzzatura
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        'Set Add. 4 a sacchi
        .OPCData.items(PLCTAG_SetAdd4Sacchi).Value = CInt(.AdoDosaggioNext.Recordset.Fields("AdditivoSacchi").Value)
        'Scarico sacchi prima o dopo bitume
        .OPCData.items(PLCTAG_SacchiPrimaDopoBitume).Value = CSng(.AdoDosaggioNext.Recordset.Fields("AddPrimaDopo").Value)
        
	errorPosition = 10

        If Not DosaggioInCorso Then
            CP240.LblKgAddSacchi.caption = Round(CP240.AdoDosaggioNext.Recordset.Fields("NumSacchi").Value * (RiduzioneImpasto / 100), 0) * CP240.AdoDosaggioNext.Recordset.Fields("Pesosacco").Value
            BufferAddSacchi(2) = CP240.AdoDosaggioNext.Recordset.Fields("NumSacchi").Value * CP240.AdoDosaggioNext.Recordset.Fields("Pesosacco").Value
            BufferAddKgSacchi(2) = CP240.LblKgAddSacchi.caption
        End If
        
        If CInt(CP240.AdoDosaggioNext.Recordset.Fields("AdditivoSacchi").Value) = 1 Then
'            .LblAddSacchi(1).caption = (CLng(.AdoDosaggio.Recordset.Fields("NumSacchi").value)) * CLng(.AdoDosaggio.Recordset.Fields("PesoSacco").value)
'            .LblKgAddSacchi.caption = Round(CLng(.AdoDosaggio.Recordset.Fields("NumSacchi").value) * (RiduzioneImpasto / 100), 0) * CLng(.AdoDosaggio.Recordset.Fields("PesoSacco").value)
            BufferAddSacchi(1) = (CLng(.AdoDosaggioNext.Recordset.Fields("NumSacchi").Value)) * CLng(.AdoDosaggioNext.Recordset.Fields("PesoSacco").Value)
            BufferAddKgSacchi(1) = Round(CLng(.AdoDosaggioNext.Recordset.Fields("NumSacchi").Value) * (RiduzioneImpasto / 100), 0) * CLng(.AdoDosaggioNext.Recordset.Fields("PesoSacco").Value)
        Else
            BufferAddSacchi(1) = "0"
            BufferAddKgSacchi(1) = "0"
        End If
        '
         
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Non ancora implementato
        '.OPCData.Items(PLCTAG_TimerScAdd4Sacchi).value = CSng(ValoreTODO)      'Tempo ritardo scarico add. 4 a sacchi
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        .OPCData.items(PLCTAG_RiduzioneImpastoDos).Value = RiduzioneImpasto

        'Additivo Flomac
        If (InclusioneAddFlomac) Then
            .OPCData.items(PLCTAG_FlomacInclusione).Value = .AdoDosaggioNext.Recordset.Fields("AddFlomac").Value
        Else
            .OPCData.items(PLCTAG_FlomacInclusione).Value = False
        End If
        
        'Contalitri
        'Il PLC non tiene conto nel calcolo dell'acqua, gli passo il set maggiorato della % di acqua mancante
        If Not .OPCData.items(PLCTAG_AbilitaCicloRF).Value Then
            .OPCData.items(PLCTAG_ContalitriSetPerc).Value = CDbl(.AdoDosaggioNext.Recordset.Fields("SetContalitri").Value)
        Else
            .OPCData.items(PLCTAG_ContalitriSetPerc).Value = CDbl(.AdoDosaggioNext.Recordset.Fields("SetContalitri").Value) * ((100 + .AdoDosaggioNext.Recordset.Fields("SetAcqua").Value) / 100)
        End If

        If (Not BitumeGravita) Then
            'Aumento % bitume in caso di riciclato freddo
            .OPCData.items(PLCTAG_ContalitriSetPerc).Value = (.OPCData.items(PLCTAG_ContalitriSetPerc).Value * 100) / (100 - Null2zero(.AdoDosaggioNext.Recordset.Fields("Aggregato7").Value))
        End If
        '

        .OPCData.items(PLCTAG_ContalitriLentaPerc).Value = CDbl(100 - .AdoDosaggioNext.Recordset.Fields("FineContalitri").Value)
        .OPCData.items(PLCTAG_ContalitriResiduoKg).Value = 0 - CInt(.AdoDosaggioNext.Recordset.Fields("ResiduoContalitri").Value)
        .OPCData.items(PLCTAG_ContalitriTolleranza).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TolleranzaContalitri").Value)
        .OPCData.items(PLCTAG_ContalitriTempoStab).Value = CInt(.AdoDosaggioNext.Recordset.Fields("StabilizzazioneContalitri").Value)
        .OPCData.items(PLCTAG_ContalitriRitardoScarico).Value = CInt(.AdoDosaggioNext.Recordset.Fields("RitardoContalitri").Value)
                
	errorPosition = 11
        '20160405
        If (InclusioneAddContalitri) Then
            AdditivoBacinella.voloKg = CDbl(.AdoDosaggioNext.Recordset.Fields("ResiduoAddBacCNTReal").Value)   '20160401
            AdditivoBacinella.tolleranzaKg = CDbl(.AdoDosaggioNext.Recordset.Fields("TollAddBacCNTReal").Value)   '20160401
        Else
            AdditivoBacinella.voloKg = CDbl(.AdoDosaggioNext.Recordset.Fields("ResiduoAddBacCNT").Value)   '20160401
            AdditivoBacinella.tolleranzaKg = CDbl(.AdoDosaggioNext.Recordset.Fields("TollAddBacCNT").Value)   '20160401
        End If
        '20160405
        AdditivoBacinella.tempoStabilizzazione = CDbl(.AdoDosaggioNext.Recordset.Fields("TempoStabAddBacCNT").Value)
        AdditivoBacinella.SetPerc = CDbl(.AdoDosaggioNext.Recordset.Fields("SetAddBacCNT").Value)   'INCRIMINATO
        
        .OPCData.items(PLCTAG_SetPercAdd2).Value = AdditivoBacinella.SetPerc
        .OPCData.items(PLCTAG_Residuo_Add2).Value = AdditivoBacinella.voloKg
        .OPCData.items(PLCTAG_Tolleranza_Add2).Value = AdditivoBacinella.tolleranzaKg
        .OPCData.items(PLCTAG_Tempo_Stab_Add2).Value = AdditivoBacinella.tempoStabilizzazione
        
        If (InclusioneAcqua) Then
            'Nel primo Step di sviluppo il set lo passo in  millisecondi (es. 4,5 sec --> 4500)
            'Nel secondo Step di sviluppo il set lo passerò in percentuale
            Dim TempoMilliSec As Double
            If (PortataAcqua > 0) Then
                TempoMilliSec = RoundNumber((ImpastoPeso() / 100 * CDbl(RiduzioneImpasto)) * (.AdoDosaggioNext.Recordset.Fields("SetAcqua").Value / 100) / (PortataAcqua), 1) * 1000
            Else
                TempoMilliSec = 0
            End If
            If TempoMilliSec > 32000 Then
                TempoMilliSec = 32000
            End If
            .OPCData.items(PLCTAG_AcquaSet).Value = TempoMilliSec
            .OPCData.items(PLCTAG_AcquaRitardo).Value = CSng(.AdoDosaggioNext.Recordset.Fields("RitardoAcqua").Value)
        End If
        '
        
        CicloSenzaAggregati = True
        For indice = PLCTAG_SetA1 To PLCTAG_SetA8
            If .OPCData.items(indice).Value > 0 Then
                CicloSenzaAggregati = False
            End If
        Next indice

        'aggiunta possibilita' di ciclo senza aggregati e con riciclato caldo;
        'il ciclo per asfalto freddo deve prevedere l'utilizzo del solo riciclato freddo;
        If CicloSenzaAggregati And .AdoDosaggioNext.Recordset.Fields("RAPSiwa").Value > 0 And .AdoDosaggioNext.Recordset.Fields("RAP").Value = 0 Then
            CicloFreddoSenzaAggregati = True
        ElseIf CicloSenzaAggregati And .AdoDosaggioNext.Recordset.Fields("RAP").Value > 0 Then
            CicloRicCaldoSenzaAggregati = True
        Else
            CicloRicCaldoSenzaAggregati = False
            CicloFreddoSenzaAggregati = False
        End If

        .OPCData.items(PLCTAG_AbilitaCicloRF).Value = CicloFreddoSenzaAggregati
        .OPCData.items(PLCTAG_AbilitaCicloRC).Value = CicloRicCaldoSenzaAggregati
        
        If Not DosaggioInCorso Then
            BufferAbilitaCicloRC(1) = CicloRicCaldoSenzaAggregati
            BufferAbilitaCicloRC(2) = BufferAbilitaCicloRC(1)
        End If

	errorPosition = 12

        If Not DosaggioInCorso Then
            .LblAdd(5).caption = RoundNumber((TempoMilliSec / 1000) * PortataAcqua, 0)
        End If

        'Il PLC quando finisce la pesata degli aggregati e del filler ricalcola i Kg del Bitume applicando il set%
        'alla somma degli agg+filler e non controlla se il InclusioneLegante100
        'Gli passo io le % taroccate come se il bitume fosse fuori dal 100%
        Dim CostanteAdattamentoBitumeDentro100 As Double
        Dim SommaPercAggregatiFiller As Double
        If InclusioneLegante100 Then
            For indice = 0 To 7
                SommaPercAggregatiFiller = SommaPercAggregatiFiller + .OPCData.items(PLCTAG_SetA1 + indice).Value
            Next indice
            For indice = 0 To 2
                SommaPercAggregatiFiller = SommaPercAggregatiFiller + .OPCData.items(PLCTAG_SetF1 + indice).Value
            Next indice
            SommaPercAggregatiFiller = SommaPercAggregatiFiller + .OPCData.items(PLCTAG_SetRAP).Value + .OPCData.items(PLCTAG_SetRAPSiwa).Value

            If SommaPercAggregatiFiller > 0 Then
                CostanteAdattamentoBitumeDentro100 = 100 / SommaPercAggregatiFiller
                For indice = 0 To 7
                    .OPCData.items(PLCTAG_SetA1 + indice).Value = RoundNumber(.OPCData.items(PLCTAG_SetA1 + indice).Value * CostanteAdattamentoBitumeDentro100, 5)
                Next indice
                For indice = 0 To 2
                    .OPCData.items(PLCTAG_SetF1 + indice).Value = RoundNumber(.OPCData.items(PLCTAG_SetF1 + indice).Value * CostanteAdattamentoBitumeDentro100, 5)
                Next indice
                For indice = 0 To 1
                    .OPCData.items(PLCTAG_SetB1 + indice).Value = RoundNumber(.OPCData.items(PLCTAG_SetB1 + indice).Value * CostanteAdattamentoBitumeDentro100, 5)
                Next indice
                .OPCData.items(PLCTAG_ContalitriSetPerc + indice).Value = RoundNumber(.OPCData.items(PLCTAG_ContalitriSetPerc).Value * CostanteAdattamentoBitumeDentro100, 5)
                .OPCData.items(PLCTAG_SetRAP).Value = RoundNumber(.OPCData.items(PLCTAG_SetRAP).Value * CostanteAdattamentoBitumeDentro100, 5)
                .OPCData.items(PLCTAG_SetRAPSiwa).Value = RoundNumber(.OPCData.items(PLCTAG_SetRAPSiwa).Value * CostanteAdattamentoBitumeDentro100, 5)
            End If
        End If
        
        'Set ricetta bitume gravità
        Call RicettaParametriBitumeGravita
                
        If (Not DosaggioInCorso) Then
            FrmGestioneTimer.TimerTagCambioVolo.enabled = False
            FrmGestioneTimer.TimerTagCambioVolo.Interval = 500
            FrmGestioneTimer.TimerTagCambioVolo.enabled = True
        End If

        If AbilitaInverterSpruzzaturaLegante Then
            .OPCData.items(PLCTAG_AO_GravitaVelocitaPompa).Value = CLng(.AdoDosaggioNext.Recordset.Fields("UnitaPartenza").Value) / 100 * CLng(27648 * CLng(VoltPompaLegante) / 10)
        Else
            .OPCData.items(PLCTAG_AO_GravitaVelocitaPompa).Value = CLng(0) 'oppure CLng(27648 * CLng(VoltPompaLegante) / 10)
        End If
        .OPCData.items(PLCTAG_DO_ScambioB1).Value = ((.AdoDosaggioNext.Recordset.Fields("Bitume2").Value > 0) And InclusioneBitume2 And (Not AbilitaSelettoreBitume1) And (Not InclusioneBacinella2))
        .OPCData.items(PLCTAG_DO_ScambioB2).Value = (InclusioneBitume3 And ceSoft)

	errorPosition = 13

	'20150704
	'Debug.Print "CYBERTRONIC_PLUS PLCTAG_NM_B1_Scambio"
	'Debug.Print "CYBERTRONIC_PLUS PLCTAG_NM_B2_Scambio"
	'
        If (InclusioneBitume3 And ceSoft) Then
            .OPCData.items(PLCTAG_FondoScalaBilB).Value = CSng(GSetBSoft)
            .OPCData.items(PLCTAG_TaraMaxB).Value = TaraBitumeSoft
            .OPCData.items(PLCTAG_SicurezzaBilB).Value = CSng(SicurezzaBitumeSoft)
        Else
            .OPCData.items(PLCTAG_FondoScalaBilB).Value = CSng(BilanciaLegante.FondoScala)
            .OPCData.items(PLCTAG_TaraMaxB).Value = BilanciaLegante.Tara
            .OPCData.items(PLCTAG_SicurezzaBilB).Value = CSng(BilanciaLegante.Sicurezza)
        End If
        '

        If (PlcSchiumato.Abilitazione) Then
            .OPCData.items(PLCTAG_DI_AbilitaCompAux1).Value = ceHard
        End If

'20160729
        If InclusioneAquablack Then
            AquablackRecipeNext.PercentageH2O = Null2Qualcosa(.AdoDosaggioNext.Recordset.Fields("AquablackSet").Value)
            AquablackRecipeNext.BitumenSelection = Null2Qualcosa(.AdoDosaggioNext.Recordset.Fields("AquablackSelezioneBitume").Value)
            AquablackRecipeNext.BitumenMinFlow = Null2Qualcosa(.AdoDosaggioNext.Recordset.Fields("AquablackFlussoMin").Value)
            AquablackRecipeNext.ToleranceH2O = Null2Qualcosa(.AdoDosaggioNext.Recordset.Fields("AquablackTolleranza").Value)
            AquablackRecipeNext.BitumenDisch2Steps = Null2Qualcosa(.AdoDosaggioNext.Recordset.Fields("AquablackEn2Step").Value)
            AquablackRecipeNext.ChangeAtFlight = True
            DosaggioAquablack_ChangeAtFlight_DosInStop = True '20170203
        End If
'

        Call PosizionaBitume123

        Call PosizionaDeflettoreByPassTamburoParallelo

    End With

    Exit Sub
	Errore:
    '20150604
    'LogInserisci True, "DOS-059", CStr(Err.Number) + " [" + Err.description + "]"
    LogInserisci True, "DOS-059 ", CStr(Err.Number) + " [" + Err.description + "] - error posizion " + CStr(errorPosition)
    '
End Sub


Private Sub CalcolaVelocitaInvertPesateFiller(KgF1 As Double, KgF2 As Double, KgF3 As Double)
	'P-P090108_SpecificheTecniche Inverter Pesate Filler.pdf
	Dim TempoPesataF1 As Double
	Dim TempoPesataF2 As Double
	Dim TempoPesataF3 As Double
	Dim TempoTotalePesateFiller As Double
	Dim RiduzioneVelocitaPesate As Integer
	Dim VelocitaCocleaFiltro As Integer
	Dim VelocitaCocleaFiller1 As Integer
	Dim VelocitaCocleaFiller2 As Integer
	Dim VelocitaCocleaFiller3 As Integer
    
    If KgF1 > 0 Then
        TempoPesataF1 = (KgF1 - AnticipoPesataFineFiller1) / PortataMassimaFiller1 + AnticipoPesataFineFiller1 / (PortataMassimaFiller1 * RiduzioneVelocitaPesataFineFiller1 / 100)
        TempoTotalePesateFiller = TempoTotalePesateFiller + TempoPesataF1 + 2
    End If
    If KgF2 > 0 Then
        TempoPesataF2 = (KgF2 - AnticipoPesataFineFiller2) / PortataMassimaFiller2 + AnticipoPesataFineFiller2 / (PortataMassimaFiller2 * RiduzioneVelocitaPesataFineFiller2 / 100)
        TempoTotalePesateFiller = TempoTotalePesateFiller + TempoPesataF2 + 2
    End If
    If KgF3 > 0 Then
        TempoPesataF3 = (KgF3 - AnticipoPesataFineFiller3) / PortataMassimaFiller3 + AnticipoPesataFineFiller3 / (PortataMassimaFiller3 * RiduzioneVelocitaPesataFineFiller3 / 100)
        TempoTotalePesateFiller = TempoTotalePesateFiller + TempoPesataF3 + 2
    End If
    
    If TempoTotalePesateFiller < TempoMassimoPesataFiller Then
        RiduzioneVelocitaPesate = TempoTotalePesateFiller / TempoMassimoPesataFiller * 100
    Else
        RiduzioneVelocitaPesate = 100
    End If
    
    VelocitaCocleaFiltro = RiduzioneVelocitaPesate * RapportoFlussoCocleaPesataF1_CocleaFiltro / 100
    VelocitaCocleaFiller1 = RiduzioneVelocitaPesate
    VelocitaCocleaFiller2 = RiduzioneVelocitaPesate
    VelocitaCocleaFiller3 = RiduzioneVelocitaPesate * RapportoFlussoCocleaPesataF3_CocleaPesataF2 / 100
    
    If VelocitaCocleaFiltro < VelocitaMinimaInverterCocleaFiltro Then
        VelocitaCocleaFiltro = VelocitaMinimaInverterCocleaFiltro
        VelocitaCocleaFiller1 = VelocitaCocleaFiltro / RapportoFlussoCocleaPesataF1_CocleaFiltro * 100
    End If
    If VelocitaCocleaFiller1 < VelocitaMinimaInverterCocleaFiller1 Then
        VelocitaCocleaFiller1 = VelocitaMinimaInverterCocleaFiller1
        VelocitaCocleaFiltro = VelocitaCocleaFiller1 * RapportoFlussoCocleaPesataF1_CocleaFiltro / 100
    End If
    If VelocitaCocleaFiller3 < VelocitaMinimaInverterCocleaFiller3 Then
        VelocitaCocleaFiller3 = VelocitaMinimaInverterCocleaFiller3
        VelocitaCocleaFiller2 = VelocitaCocleaFiller3 / RapportoFlussoCocleaPesataF3_CocleaPesataF2 * 100
    End If
    If VelocitaCocleaFiller2 < VelocitaMinimaInverterCocleaFiller2 Then
        VelocitaCocleaFiller2 = VelocitaMinimaInverterCocleaFiller2
        VelocitaCocleaFiller3 = VelocitaCocleaFiller2 * RapportoFlussoCocleaPesataF3_CocleaPesataF2 / 100
    End If
    
    CP240.OPCData.items(PLCTAG_AO_SetMotore16).Value = VelocitaCocleaFiltro / 100 * 27648
    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF1).Value = VelocitaCocleaFiller1 / 100 * 27648
    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF2).Value = VelocitaCocleaFiller2 / 100 * 27648
    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF3).Value = VelocitaCocleaFiller3 / 100 * 27648
    
    'Servono per fare la riduzione della velocità durante la pesata
    MemoriaVelocitaInverterCocleaFiltro = VelocitaCocleaFiltro
    MemoriaVelocitaInverterCocleaFiller1 = VelocitaCocleaFiller1
    MemoriaVelocitaInverterCocleaFiller2 = VelocitaCocleaFiller2
    MemoriaVelocitaInverterCocleaFiller3 = VelocitaCocleaFiller3
    
End Sub

Public Sub CalcolaVelocitaInvertPesateFillerManuale()
'P-P090108_SpecificheTecniche Inverter Pesate Filler.pdf
	Dim VelocitaCocleaFiltro As Integer
	Dim VelocitaCocleaFiller1 As Integer
	Dim VelocitaCocleaFiller2 As Integer
	Dim VelocitaCocleaFiller3 As Integer
    
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    VelocitaCocleaFiltro = 100 * RapportoFlussoCocleaPesataF1_CocleaFiltro / 100
    VelocitaCocleaFiller1 = 100
    VelocitaCocleaFiller2 = 100
    VelocitaCocleaFiller3 = 100 * RapportoFlussoCocleaPesataF3_CocleaPesataF2 / 100
    
    If VelocitaCocleaFiltro < VelocitaMinimaInverterCocleaFiltro Then
        VelocitaCocleaFiltro = VelocitaMinimaInverterCocleaFiltro
        VelocitaCocleaFiller1 = VelocitaCocleaFiltro / RapportoFlussoCocleaPesataF1_CocleaFiltro * 100
    End If
    If VelocitaCocleaFiller1 < VelocitaMinimaInverterCocleaFiller1 Then
        VelocitaCocleaFiller1 = VelocitaMinimaInverterCocleaFiller1
        VelocitaCocleaFiltro = VelocitaCocleaFiller1 * RapportoFlussoCocleaPesataF1_CocleaFiltro / 100
    End If
    If VelocitaCocleaFiller3 < VelocitaMinimaInverterCocleaFiller3 Then
        VelocitaCocleaFiller3 = VelocitaMinimaInverterCocleaFiller3
        VelocitaCocleaFiller2 = VelocitaCocleaFiller3 / RapportoFlussoCocleaPesataF3_CocleaPesataF2 * 100
    End If
    If VelocitaCocleaFiller2 < VelocitaMinimaInverterCocleaFiller2 Then
        VelocitaCocleaFiller2 = VelocitaMinimaInverterCocleaFiller2
        VelocitaCocleaFiller3 = VelocitaCocleaFiller2 * RapportoFlussoCocleaPesataF3_CocleaPesataF2 / 100
    End If
    
    CP240.OPCData.items(PLCTAG_AO_SetMotore16).Value = VelocitaCocleaFiltro / 100 * 27648
    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF1).Value = VelocitaCocleaFiller1 / 100 * 27648
    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF2).Value = VelocitaCocleaFiller2 / 100 * 27648
    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF3).Value = VelocitaCocleaFiller3 / 100 * 27648
    
End Sub


Public Sub AggiornaVelocitaInvertPesateFiller(KgF1 As Double, KgF2 As Double, KgF3 As Double)
	'P-P090108_SpecificheTecniche Inverter Pesate Filler.pdf
	Dim VelocitaCocleaFiltro As Integer
	Dim VelocitaCocleaFiller1 As Integer
	Dim VelocitaCocleaFiller2 As Integer
	Dim VelocitaCocleaFiller3 As Integer

    If DosaggioInCorso Then
        
        VelocitaCocleaFiltro = MemoriaVelocitaInverterCocleaFiltro * RiduzioneVelocitaPesataFineFiller1 / 100
        VelocitaCocleaFiller1 = MemoriaVelocitaInverterCocleaFiller1 * RiduzioneVelocitaPesataFineFiller1 / 100
        VelocitaCocleaFiller2 = MemoriaVelocitaInverterCocleaFiller2 * RiduzioneVelocitaPesataFineFiller2 / 100
        VelocitaCocleaFiller3 = MemoriaVelocitaInverterCocleaFiller3 * RiduzioneVelocitaPesataFineFiller3 / 100
    
        If VelocitaCocleaFiltro < VelocitaMinimaInverterCocleaFiltro Then
            VelocitaCocleaFiltro = VelocitaMinimaInverterCocleaFiltro
            VelocitaCocleaFiller1 = VelocitaCocleaFiltro / RapportoFlussoCocleaPesataF1_CocleaFiltro * 100
        End If
        If VelocitaCocleaFiller1 < VelocitaMinimaInverterCocleaFiller1 Then
            VelocitaCocleaFiller1 = VelocitaMinimaInverterCocleaFiller1
            VelocitaCocleaFiltro = VelocitaCocleaFiller1 * RapportoFlussoCocleaPesataF1_CocleaFiltro / 100
        End If
        If VelocitaCocleaFiller3 < VelocitaMinimaInverterCocleaFiller3 Then
            VelocitaCocleaFiller3 = VelocitaMinimaInverterCocleaFiller3
            VelocitaCocleaFiller2 = VelocitaCocleaFiller3 / RapportoFlussoCocleaPesataF3_CocleaPesataF2 * 100
        End If
        If VelocitaCocleaFiller2 < VelocitaMinimaInverterCocleaFiller2 Then
            VelocitaCocleaFiller2 = VelocitaMinimaInverterCocleaFiller2
            VelocitaCocleaFiller3 = VelocitaCocleaFiller2 * RapportoFlussoCocleaPesataF3_CocleaPesataF2 / 100
        End If
        
        If (CP240.OPCData.items(PLCTAG_DO_PesataFill1).Value) Then
            If BilanciaFiller.Peso > (KgF1 - AnticipoPesataFineFiller1) Then
                'Riduco la velocità
                CP240.OPCData.items(PLCTAG_AO_SetMotore16).Value = VelocitaCocleaFiltro / 100 * 27648
                CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF1).Value = VelocitaCocleaFiller1 / 100 * 27648
            End If
        Else
            CP240.OPCData.items(PLCTAG_AO_SetMotore16).Value = MemoriaVelocitaInverterCocleaFiltro / 100 * 27648
            CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF1).Value = MemoriaVelocitaInverterCocleaFiller1 / 100 * 27648
        End If
        If (CP240.OPCData.items(PLCTAG_DO_PesataFill2).Value) Then
            If (BilanciaFiller.Peso - NettoFiller(0)) > (KgF2 - AnticipoPesataFineFiller2) Then
                'Riduco la velocità
                CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF2).Value = VelocitaCocleaFiller2 / 100 * 27648
            End If
        Else
            If (CP240.OPCData.items(PLCTAG_DO_PesataFill3).Value) Then
                If (BilanciaFiller.Peso - NettoFiller(0) - NettoFiller(1)) > (KgF3 - AnticipoPesataFineFiller3) Then
                    'Riduco la velocità
                    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF2).Value = VelocitaCocleaFiller2 / 100 * 27648
                    CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF3).Value = VelocitaCocleaFiller3 / 100 * 27648
                End If
            Else
                CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF2).Value = MemoriaVelocitaInverterCocleaFiller2 / 100 * 27648
                CP240.OPCData.items(PLCTAG_AO_VelocitaCocleaPesataF3).Value = MemoriaVelocitaInverterCocleaFiller3 / 100 * 27648
            End If
        End If
        
    End If
    
End Sub

Public Sub PosizionaBitume123()

    If InclusioneBitume2 And (Not AbilitaSelettoreBitume1) And (Not InclusioneBacinella2) Then
        If CP240.AdoDosaggio.Recordset.EOF Then
            CP240.ProgressBil(2).width = 117
            CP240.CmdTrPesa(CompLegante1).Visible = PesaturaManuale
            CP240.CmdTrPesa(CompLegante2).Visible = False
        Else
        '
            If (CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value > 0) Then
                'Bitume 2
                CP240.ProgressBil(2).width = 117
                CP240.CmdTrPesa(CompLegante1).Visible = False
                CP240.CmdTrPesa(CompLegante2).Visible = PesaturaManuale
            Else
                If (CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value > 0) And InclusioneBitume3 Then
                    'Bitume 3
                    CP240.ProgressBil(2).width = 60
                    CP240.CmdTrPesa(CompLeganteSoft).Visible = PesaturaManuale
                    CP240.CmdTrPesa(CompLeganteHard).Visible = False
                Else
                    CP240.ProgressBil(2).width = 117
                    CP240.CmdTrPesa(CompLegante1).Visible = PesaturaManuale
                    CP240.CmdTrPesa(CompLegante2).Visible = False
                End If
            End If
        End If
    Else
        'Inizializzazione come su form_load
        If InclusioneBitume2 And InclusioneAddContalitri Then
            CP240.ProgressBil(2).width = 170
        Else
            If InclusioneBitume2 Then
                CP240.ProgressBil(2).width = 117
            Else
                CP240.ProgressBil(2).width = 60
            End If
        End If
        CP240.CmdTrPesa(CompLegante1).Visible = PesaturaManuale
        CP240.CmdTrPesa(CompLegante2).Visible = PesaturaManuale
        CP240.CmdTrPesa(CompLeganteSoft).Visible = PesaturaManuale
        'CP240.CmdTrPesa(CompLeganteHard).Visible = PesaturaManuale 'Fatto in FrmSchiumato
    End If
    
    CP240.CmdScarica(2).left = CP240.ProgressBil(2).left + CP240.ProgressBil(2).width - CP240.CmdScarica(2).width
    '20161024
    'CP240.CmdTipoPesate(102).left = CP240.CmdScarica(2).left - 29
    '
    CP240.Frame1(13).left = CP240.ProgressBil(2).left + CP240.ProgressBil(2).width / 2 - CP240.Frame1(13).width / 2
    
    If Bitume2InBlending Then
        CP240.CmdTrPesa(CompLegante1).Visible = PesaturaManuale
        CP240.CmdTrPesa(CompLegante2).Visible = PesaturaManuale
    End If
    
End Sub

Private Sub RicettaParametriBitumeGravita()

    With CP240

        'AdoDosaggio --> AdoDosaggioNext

        If BitumeGravita Then
            .OPCData.items(PLCTAG_GravitaSetPercB1).Value = CDbl(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value)
            .OPCData.items(PLCTAG_GravitaSetPercB2).Value = CDbl(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value)
            .OPCData.items(PLCTAG_GravitaPercVelocePrimaPesata).Value = CInt(.AdoDosaggioNext.Recordset.Fields("PercentualePesata1").Value)
            .OPCData.items(PLCTAG_GravitaPercVeloceSecondaPesata).Value = CInt(.AdoDosaggioNext.Recordset.Fields("PercentualePesata2").Value)
            .OPCData.items(PLCTAG_GravitaPercRiduzionePrimaPesata).Value = CInt(.AdoDosaggioNext.Recordset.Fields("MinimoLenta1").Value)
            .OPCData.items(PLCTAG_GravitaPercRiduzioneSecondaPesata).Value = CInt(.AdoDosaggioNext.Recordset.Fields("MinimoLenta2").Value)
            If CDbl(.AdoDosaggioNext.Recordset.Fields("Bitume1").Value) > 0 Then
                .OPCData.items(PLCTAG_GravitaOrdineDosB1).Value = 1
                If CDbl(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0 Then
                    .OPCData.items(PLCTAG_GravitaOrdineDosB2).Value = 2
                Else
                    .OPCData.items(PLCTAG_GravitaOrdineDosB2).Value = 0
                End If
            Else
                If CDbl(.AdoDosaggioNext.Recordset.Fields("Bitume2").Value) > 0 Then
                    .OPCData.items(PLCTAG_GravitaOrdineDosB1).Value = 0
                    .OPCData.items(PLCTAG_GravitaOrdineDosB2).Value = 1
                Else
                    .OPCData.items(PLCTAG_GravitaOrdineDosB1).Value = 0
                    .OPCData.items(PLCTAG_GravitaOrdineDosB2).Value = 0
                End If
            End If
            .OPCData.items(PLCTAG_GravitaResiduoB1).Value = CInt(0 - .AdoDosaggioNext.Recordset.Fields("ResiduoBitume1").Value)
            .OPCData.items(PLCTAG_GravitaResiduoB2).Value = CInt(0 - .AdoDosaggioNext.Recordset.Fields("ResiduoBitume2").Value)
            .OPCData.items(PLCTAG_GravitaTolleranza).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TolleranzaBitume").Value)
            .OPCData.items(PLCTAG_GravitaTempoStabCarico).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TempoStabGrossa").Value)
            .OPCData.items(PLCTAG_GravitaTempoStabScarico).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TempoStabBilBitume").Value)
            .OPCData.items(PLCTAG_GravitaRitardoScarico).Value = CInt(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoBitume").Value)
            .OPCData.items(PLCTAG_GravitaPortataMinKgBitume).Value = BitumeKgFinali
            .OPCData.items(PLCTAG_GravitaPercRabbocco).Value = CInt(.AdoDosaggioNext.Recordset.Fields("PercentualeGrossa").Value)
        Else
            .OPCData.items(PLCTAG_GravitaSetPercB1).Value = 0
            .OPCData.items(PLCTAG_GravitaSetPercB2).Value = 0
            .OPCData.items(PLCTAG_GravitaPercVelocePrimaPesata).Value = 0
            .OPCData.items(PLCTAG_GravitaPercVeloceSecondaPesata).Value = 0
            .OPCData.items(PLCTAG_GravitaPercRiduzionePrimaPesata).Value = 0
            .OPCData.items(PLCTAG_GravitaPercRiduzioneSecondaPesata).Value = 0
            .OPCData.items(PLCTAG_GravitaOrdineDosB1).Value = 0
            .OPCData.items(PLCTAG_GravitaOrdineDosB2).Value = 0
            .OPCData.items(PLCTAG_GravitaResiduoB1).Value = 0
            .OPCData.items(PLCTAG_GravitaResiduoB2).Value = 0
            .OPCData.items(PLCTAG_GravitaTolleranza).Value = 0
            .OPCData.items(PLCTAG_GravitaTempoStabCarico).Value = 0
            .OPCData.items(PLCTAG_GravitaTempoStabScarico).Value = 0
            .OPCData.items(PLCTAG_GravitaRitardoScarico).Value = 0
            .OPCData.items(PLCTAG_GravitaPortataMinKgBitume).Value = 0
            .OPCData.items(PLCTAG_GravitaPercRabbocco).Value = 0
        End If

    End With

End Sub


Public Sub SetCicliDosaggioDaEseguire(ByVal cicli As Long)

	'20170120
	'    If (CicliDosaggioDaEseguire <> cicli) Then

        CicliDosaggioDaEseguire = cicli
        CP240.TxtCicloDos.text = CStr(CicliDosaggioDaEseguire)

        If (Not DosaggioInCorso) Then
            '20170118
            'CP240.TxtImpastoRidotto(3).text = RoundNumber(CDbl(CicliDosaggioDaEseguire) * CDbl(DimensioneImpastoKg) / 1000, 1) & " T"
            CP240.TxtImpastoRidotto(3).text = FormatNumber(CDbl(CicliDosaggioDaEseguire) * CDbl(DimensioneImpastoKg) / CDbl(1000), 1, vbTrue, vbFalse, vbFalse) & " T"
            '
        End If

'    End If
'

End Sub
    
Public Sub CicliDosaggioEseguiti_change()

    CP240.LblCicli.caption = CicliDosaggioEseguiti  'cicli di dosaggio in accumulo

    If CicliDosaggioEseguiti >= 0 Then
        Call GestioneStopPredosatori
        If CicliDosaggioEseguiti = 1 Then
            GrandezzaImpasto(0) = DimensioneImpastoKg
            GrandezzaImpasto(1) = DimensioneImpastoKg
        Else
            GrandezzaImpasto(0) = GrandezzaImpasto(1)
            GrandezzaImpasto(1) = DimensioneImpastoKg
        End If
    End If

End Sub


Public Sub AbilitazioneCambioRicetta(abilita As Boolean)
    'La combo di selezione ricetta dosaggio non deve essere attiva finchè il PLC non mi ha restituito i set
    'Non posso disabilitare la combo direttamente perchè altrimenti non funziona più il richiamo
    'della ricetta da tastiera (tasto enter). Perdendo lo stato attivo la combo non azzera il buffer
    'dei caratteri digitati e non funziona più.
    
    If (Not DosaggioInCorso) Then
        abilita = True
    End If
    
    If (abilita) Then
        If (CP240.Picture1(2).Visible) Then
            Call CalcolaVelocitaInvertPesateFiller(DosaggioFiller(0).setCalcolato, DosaggioFiller(1).setCalcolato, DosaggioFiller(2).setCalcolato)
        End If
    End If

    CP240.Picture1(2).Visible = (Not abilita)
    CP240.adoComboDosaggio.Visible = abilita
    
    If JobAttivo.StatusVB = EnumStatoJobVB.Idle Then '20170127
    
        CP240.LblProdDos.enabled = abilita
        CP240.UpDownProdDos.enabled = abilita
    
        CP240.CmdNettiSiloStoricoSommaSalva(7).enabled = abilita
        FrmCalcolaImpasti.imgPulsanteForm(2).enabled = abilita
    End If

    AbilitaCambioRicetta = abilita
End Sub


Public Sub CambioRicettaPrenotato_change()
    If (Not CambioRicettaPrenotato) Then
        'Il PLC ha appena fatto il cambio

        If (Not CP240.AdoDosaggioNext.Recordset.EOF) Then
            Call CP240.AdoDosaggio.Recordset.Move(CP240.AdoDosaggioNext.Recordset.AbsolutePosition - 1, adBookmarkFirst)
            
            Call SendMessagetoPlus(PlusSendActiveDosingRecipeHopperID, val(CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value))

            Call AggiornaSetKgCP240
        End If

    End If
End Sub


Public Sub GestioneStatoDosaggio()
	'Dim valoreBool As Boolean
	Dim DosaggioInCorsoTMP As Boolean
	Dim CambioRicettaPrenotatoTMP As Boolean
	Dim statodosaggiotemp As Integer '20161020
    
    If (DEMO_VERSION) Then
        DosaggioInCorsoTMP = False
        
        If DosaggioInCorso <> DosaggioInCorsoTMP Then
            DosaggioInCorso = DosaggioInCorsoTMP
            DosaggioInCorso_change
        End If
        Exit Sub
    End If
    
    'PLCTAG_DosaggioAttivo --> vale 1 fino all'ultimo scarico dei componenti
    'PLCTAG_DosaggioInArresto --> vale 1 fino allo scarico mixer (usato per l'ultimo impasto)
    'DosaggioInArresto diventa False appena finisce il tempo di mescolazione, devo invece aspettare faccia il tempo di apertura mixer
    If CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value Then
        UltimoImpastoCompletato = False
    End If
    If Not UltimoImpastoCompletato And CP240.OPCData.items(PLCTAG_MescolatoreScaricoCompletato).Value Then
        UltimoImpastoCompletato = True
        CP240.OPCData.items(PLCTAG_SILI_HMI_DosaggioInCorso).Value = False   '20160125
    End If
    DosaggioInCorsoTMP = CP240.OPCData.items(PLCTAG_DosaggioAttivo).Value Or Not UltimoImpastoCompletato
    
    If DosaggioInCorso <> DosaggioInCorsoTMP Then
        If (DosaggioInCorsoTMP And Not DosaggioInCorso) Then                    '20160125
            CP240.OPCData.items(PLCTAG_SILI_HMI_DosaggioInCorso).Value = True   '20160125
        End If
        DosaggioInCorso = DosaggioInCorsoTMP
        '20160125
        If (Not AbilitaLetturaSiliDeposito) Then
            FrmGestioneTimer.TimerAbilitaSiliDeposito.enabled = True
        End If
        '20160125
        DosaggioInCorso_change
    End If
    CambioRicettaPrenotatoTMP = FrmGestioneTimer.TimerTagCambioVolo.enabled Or CambioRicettaPrenotato
    '20150409
    'CP240.CmdStartDosaggio.enabled = (Not CmdStartDosaggioLock) And Not DosaggioInCorso And Not CambioRicettaPrenotatoTMP And Not PesaturaManuale
    
'20161020
'    CP240.CmdStartDosaggio.enabled = ( _
'        Not CmdStartDosaggioLock And _
'        Not DosaggioInCorso And _
'        Not CambioRicettaPrenotatoTMP And _
'        Not PesaturaManuale And _
'        Not HardKeyRemoved And _
'        Not PlusCommunicationBroken _
'    )
            
    CP240.CmdStartDosaggio.enabled = ( _
        Not CmdStartDosaggioLock And _
        Not DosaggioInCorso And _
        Not CambioRicettaPrenotatoTMP And _
        Not HardKeyRemoved And _
        Not PlusCommunicationBroken _
    )
'
    
    ''
    '
    '20160512
    ''20160125
    'If (ArrestoUrgenza) Then
    '    CP240.OPCData.items(PLCTAG_SILI_HMI_DosaggioInCorso).Value = False   '20160125
    'End If
    '
    '20160125
    If DosaggioInCorso Then
        If CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value Then
            '20170104
            'CP240.PctDosaggioWorking.BackColor = vbYellow
            UltimoBatchPrinter = True '20150707
            statodosaggiotemp = StatusDosaggio.DOSAGGIO_STATUS_AUTO_LAST '20161020
'            '20170116
'            If (JobAttivo.StatusVB = EnumStatoJobVB.Running) Then
'                JobAttivo.StatusVB = EnumStatoJobVB.Stopping
'            End If
'            '
        Else
            '20170104
            'CP240.PctDosaggioWorking.BackColor = vbGreen
            statodosaggiotemp = StatusDosaggio.DOSAGGIO_STATUS_AUTO_RUN '20161020
        End If
    Else
        CP240.OPCData.items(PLCTAG_SILI_HMI_DosaggioInCorso).Value = False   '20160125
        '20170104
        'CP240.PctDosaggioWorking.BackColor = vbRed
        statodosaggiotemp = StatusDosaggio.DOSAGGIO_STATUS_AUTO_STOP '20161020
    End If

    '20161020
    If PesaturaManuale Then
        statodosaggiotemp = StatusDosaggio.DOSAGGIO_STATUS_MAN '20161020
    End If

    If MemStatoDosaggio <> statodosaggiotemp Then
        Call CP240StatusBar_Change(STB_DOSAGGIO, statodosaggiotemp)
    End If
    MemStatoDosaggio = statodosaggiotemp
    '

    If JobAttivo.StatusVB = EnumStatoJobVB.Idle Then '20170127
        If CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value Then
            CP240.TxtCicloDos.enabled = False
            CP240.UpDownCicli.enabled = False
        Else
            CP240.TxtCicloDos.enabled = True
            CP240.UpDownCicli.enabled = True
        End If
    End If

    Call LeggiNettiResiduiCP240
    
    If (Not DosaggioInCorso) Then
        CP240.Picture1(2).Visible = CambioRicettaPrenotatoTMP
        CP240.adoComboDosaggio.Visible = Not CambioRicettaPrenotatoTMP
    End If
    
    Dim posizione As Integer

    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "VA001", "IdDescrizione")
    If DosaggioInCorso And Not MotoriInAutomatico Then
        IngressoAllarmePresente posizione, True
    Else
        IngressoAllarmePresente posizione, False
    End If

    Call AggiornaVelocitaInvertPesateFiller(DosaggioFiller(0).setCalcolato, DosaggioFiller(1).setCalcolato, DosaggioFiller(2).setCalcolato)
    
End Sub

Public Sub AggiornaSetKgCP240()
Dim i As Integer

    'Aggregati
    For i = 0 To 6
        ComponenteSetCalcolato DosaggioAggregati(i), CP240.OPCData.items(PLCTAG_SetAggregato1 + i).Value
        If FrmNetti.Visible Then
            FrmNetti.LblSetA(i).caption = CLng(DosaggioAggregati(i).setCalcolato)
        End If
        Call ComponenteSetDisplay(DosaggioAggregati(i))

        '20161010
        'If i >= 2 And i <= 5 Then
        '20170111
        'If i >= 2 And i <= 6 Then
        If i >= 2 And i <= 6 And Not (CP240.AdoDosaggio.Recordset.BOF And CP240.AdoDosaggio.Recordset.EOF) Then
        '
            Call StatoAccoppiataDisplay(DosaggioAggregati(i), CP240.AdoDosaggio.Recordset.Fields("Portina" + CStr(i) + "Accoppiata").Value)
        End If
    Next i
    
    If AbilitaRAPSiwa Then
        If Not DosaggioInCorso Then
            Call INVIA_DatiRapSiwa
        End If
        ComponenteSetCalcolato DosaggioRAPSiwa, CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_SETCALCOLATO).Value
        If FrmNetti.Visible Then
            FrmNetti.LblSetR(0).caption = CLng(DosaggioRAPSiwa.setCalcolato)
        End If
        Call ComponenteSetDisplay(DosaggioRAPSiwa)
    End If
    If AbilitaRAP Then
        ComponenteSetCalcolato DosaggioRAP, CP240.OPCData.items(PLCTAG_SetRiciclato1).Value
        If FrmNetti.Visible Then
            FrmNetti.LblSetR(1).caption = CLng(DosaggioRAP.setCalcolato)
        End If
        Call ComponenteSetDisplay(DosaggioRAP)
    End If
    
    'N.V.
    ComponenteSetCalcolato DosaggioAggregati(7), CP240.OPCData.items(PLCTAG_SetNV).Value
    FrmNetti.LblSetA(7).caption = CLng(CP240.OPCData.items(PLCTAG_SetNV).Value)
    
    ComponenteSetDisplay DosaggioAggregati(7)

    'Filler
    For i = 0 To 2
        ComponenteSetCalcolato DosaggioFiller(i), CP240.OPCData.items(PLCTAG_SetFiller1 + i).Value
        If FrmNetti.Visible Then
            FrmNetti.LblSetFiller(i).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetFiller1 + i).Value, 1)
        End If
        ComponenteSetDisplay DosaggioFiller(i)
    Next i

    If DosaggioLeganti(1).set <> 0 Then
        If Not BitumeGravita Then
            ScambioBitume2 = 1
        End If
    Else
        If Not BitumeGravita Then
            ScambioBitume2 = 0
        End If
    End If

    For i = 0 To 1
        ComponenteSetDisplay DosaggioLeganti(i)
    Next i
    ComponenteSetDisplay DosaggioLeganti(i)

    'Viatop
    ComponenteSetCalcolato DosaggioViatop, CP240.OPCData.items(PLCTAG_SetViatop1_DB38).Value 'PLCTAG_SetViatop1
    ComponenteSetDisplay DosaggioViatop, 2
    '20160422
    ComponenteSetCalcolato DosaggioViatopScarMixer1, CP240.OPCData.items(PLCTAG_DB32_ViatopScarMixer1_SetKg).Value
    ComponenteSetCalcolato DosaggioViatopScarMixer2, CP240.OPCData.items(PLCTAG_DB33_ViatopScarMixer2_SetKg).Value
    ComponenteSetDisplay DosaggioViatopScarMixer1, 2
    ComponenteSetDisplay DosaggioViatopScarMixer2, 2
    '20160422
    
    If (AbilitaRAP) And FrmNetti.Visible Then
        FrmNetti.LblSetR(1).caption = CLng(CP240.OPCData.items(PLCTAG_SetRiciclato1).Value)
    End If

    If AdditivoBacinella.modoContalitri Then
        CP240.LblAdd(6).caption = Round(AdditivoBacinella.SetPerc, 1)
        CP240.LblAdd(7).caption = Round(AdditivoBacinella.setKg, 1)
        CP240.LblAdd(8).caption = Round(AdditivoBacinella.nettoKg, 0)
        CP240.TextTempiRitardoSc(18).text = AdditivoBacinella.ritardoDosaggio
    End If

    Call PosizionaDeflettoreVaglio

End Sub

Public Sub LeggiNettiResiduiCP240()

    Dim i As Integer
    Dim ceSoft As Boolean
    Dim ceHard As Boolean
    Dim BlendingB1_Perc As Double
    Dim BlendingB2_Perc As Double
    Dim BlendingB1_NettoKg As Double
    Dim BlendingB2_NettoKg As Double
    Dim BlendingB1_SetKg As Double
    Dim BlendingB2_SetKg As Double
    Dim BlendingB1_VoloKg As Double
    Dim BlendingB2_VoloKg As Double

    ceSoft = False
    ceHard = False
    If Not CP240.AdoDosaggio.Recordset.EOF Then
        If (Not IsNull(CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value)) Then
            If (CSng(CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value) > 0) Then
                ceSoft = True
            End If
        End If
        If (Not IsNull(CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value)) Then
            If (CSng(CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value) > 0) Then
                ceHard = True
            End If
        End If
    Else
        Exit Sub
    End If
    
    'Aggregati
    For i = 0 To 6
        NettoAgg(i) = CInt(CP240.OPCData.items(PLCTAG_NettoAggregato1 + i).Value)
        VoloAggregati(i) = Round(CP240.OPCData.items(PLCTAG_ResiduoAggregato1 + i).Value, 1)
        If FrmNetti.Visible Then
            FrmNetti.LblNettoAgg(i).caption = NettoAgg(i)
            FrmNetti.LblResAgg(i).caption = CStr(VoloAggregati(i))
            FrmNetti.LblNettiStampaA(i).caption = NettoAggregatiBuffer(i)
        End If
    Next i
    
    If AbilitaRAPSiwa Then
        '20160430
        'NettoRAPSiwa = CInt(CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_NETTO).Value)
        NettoRAPSiwa = CLng(CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_NETTO).Value)
        '
        '20170208
        'VoloRiciclatoSiwa = Round(CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_VOLO).Value, 1)
        VoloRiciclatoSiwa = CP240.OPCData.items(PLCTAG_DB101_SIWA_BATCH_VOLO).Value
        '
        If FrmNetti.Visible Then
            FrmNetti.LblNettoRic(0).caption = NettoRAPSiwa
            '20170208
            'FrmNetti.LblResRic(0).caption = CStr(VoloRiciclatoSiwa)
            FrmNetti.LblResRic(0).caption = CStr(Round(VoloRiciclatoSiwa, 0))
            '
            FrmNetti.LblNettiStampaR(0).caption = NettoRAPSiwaBuffer
        End If
    End If
    
    If AbilitaRAP Then
        NettoRAP = CLng(CP240.OPCData.items(PLCTAG_NettoRiciclato1).Value)
        VoloRiciclato = Round(CP240.OPCData.items(PLCTAG_ResiduoRiciclato1).Value, 1)
        If FrmNetti.Visible Then
            FrmNetti.LblNettoRic(1).caption = NettoRAP
            FrmNetti.LblResRic(1).caption = CStr(VoloRiciclato)
            FrmNetti.LblNettiStampaR(1).caption = NettoRAPBuffer
        End If
    End If

	NettoAgg(7) = CInt(CP240.OPCData.items(PLCTAG_NettoNV).Value)
	VoloAggregati(7) = Round(CP240.OPCData.items(PLCTAG_ResiduoNV).Value, 1)
	If FrmNetti.Visible Then
		FrmNetti.LblNettoAgg(7).caption = NettoAgg(7)
		FrmNetti.LblResAgg(7).caption = CStr(VoloAggregati(7))
		FrmNetti.LblNettiStampaA(7).caption = NettoAggregatiBuffer(7)
	End If
    
'20170222
    For i = LBound(DosaggioAggregati) To UBound(DosaggioAggregati)
        Call ComponentePesoOut(DosaggioAggregati(i), CDbl(NettoAgg(i)))
    Next i
    
    'Filler
    For i = 0 To 2
        NettoFiller(i) = RoundNumber(CP240.OPCData.items(PLCTAG_NettoFiller1 + i).Value, 1)
        VoloFiller(i) = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoFiller1 + i).Value, 1)
        If FrmNetti.Visible Then
            FrmNetti.LblNettoFiller(i).caption = NettoFiller(i)
            FrmNetti.LblResFiller(i).caption = CStr(VoloFiller(i))
            FrmNetti.LblNettiStampaf(i).caption = NettoFillerBuffer(i)
        End If
    Next i

    For i = 0 To 2
        Call ComponentePesoOut(DosaggioFiller(i), CDbl(NettoFiller(i)))
    Next i

    If CP240.OPCData.items(PLCTAG_AbilitaBlendingBitume).Value And Bitume2InBlending Then
    
        BlendingB1_Perc = RoundNumber(CP240.AdoDosaggio.Recordset.Fields("Bitume1").Value, 2)
                
        BlendingB2_Perc = RoundNumber(CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value, 2)
        
'20150923
        If BlendingB1_Perc = 0 And BlendingB2_Perc > 0 Then
            'Solo B2
            BlendingB2_NettoKg = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            If DosaggioInCorso Then
                BlendingB1_SetKg = 0
                BlendingB2_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
            Else
                BlendingB1_SetKg = 0
                BlendingB2_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
            End If
            BlendingB1_VoloKg = 0
            BlendingB2_VoloKg = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
            
            ComponentePesoOut DosaggioLeganti(0), 0
            ComponenteSetCalcolato DosaggioLeganti(0), 0
            ComponentePesoOut DosaggioLeganti(1), BlendingB2_NettoKg
            ComponenteSetCalcolato DosaggioLeganti(1), BlendingB2_SetKg
        
            If FrmNetti.Visible Then
                FrmNetti.LblSetB12(0).caption = "0"
                FrmNetti.LblNettoB12(0).caption = "0"
                FrmNetti.LblResBit(0).caption = "0"
                FrmNetti.LblNettiStampaB12(0).caption = "0"
                FrmNetti.LblSetB12(1).caption = CStr(BlendingB2_SetKg)
                FrmNetti.LblNettoB12(1).caption = CStr(BlendingB2_NettoKg)
                FrmNetti.LblResBit(1).caption = CStr(BlendingB2_VoloKg)
                FrmNetti.LblNettiStampaB12(1).caption = CStr(RoundNumber(NettoBitumeBuffer(0) * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1))
            End If
        
        ElseIf BlendingB1_Perc = 0 Or BlendingB2_Perc = 0 Then
            'Nessun bitume
            Exit Sub 'pezza per impedire divisione per zero!
        Else
            'Blending B1+B2
            BlendingB1_NettoKg = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            BlendingB2_NettoKg = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            If DosaggioInCorso Then
                BlendingB1_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
                BlendingB2_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            Else
                BlendingB1_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
                BlendingB2_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            End If
            BlendingB1_VoloKg = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
            BlendingB2_VoloKg = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
            
            ComponentePesoOut DosaggioLeganti(0), BlendingB1_NettoKg
            ComponenteSetCalcolato DosaggioLeganti(0), BlendingB1_SetKg
            
            If FrmNetti.Visible Then
                FrmNetti.LblSetB12(0).caption = BlendingB1_SetKg
                FrmNetti.LblNettoB12(0).caption = BlendingB1_NettoKg
                FrmNetti.LblResBit(0).caption = BlendingB1_VoloKg
                FrmNetti.LblNettiStampaB12(0).caption = RoundNumber(NettoBitumeBuffer(0) * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
                FrmNetti.LblSetB12(1).caption = BlendingB2_SetKg
                FrmNetti.LblNettoB12(1).caption = BlendingB2_NettoKg
                FrmNetti.LblResBit(1).caption = BlendingB2_VoloKg
                FrmNetti.LblNettiStampaB12(1).caption = RoundNumber(NettoBitumeBuffer(0) * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            End If
            
            ComponentePesoOut DosaggioLeganti(1), BlendingB2_NettoKg
            ComponenteSetCalcolato DosaggioLeganti(1), BlendingB2_SetKg
        End If
'
    Else

        If Not BitumeGravita Then
            'Bitume1
            ComponentePesoOut DosaggioLeganti(0), CP240.OPCData.items(PLCTAG_NettoBitume1).Value
            If DosaggioInCorso Then
                If CP240.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value Then
                    ComponenteSetCalcolato DosaggioLeganti(0), CP240.OPCData.items(PLCTAG_SetBitume1).Value
                Else
                    ComponenteSetCalcolato DosaggioLeganti(0), 0
                End If
                
                If FrmNetti.Visible Then
                    FrmNetti.LblSetB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
                End If
'
            Else
                ComponenteSetCalcolato DosaggioLeganti(0), CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value
                If FrmNetti.Visible Then
                    FrmNetti.LblSetB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
                End If
            End If
            VoloBitume(0) = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
            If FrmNetti.Visible Then
                FrmNetti.LblNettoB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
                FrmNetti.LblResBit(0).caption = CStr(VoloBitume(0))
                FrmNetti.LblNettiStampaB12(0).caption = NettoBitumeBuffer(0)
            End If
    
            'Gestione di 3 bitumi in scambio, in pratica ho la gestione di un solo bitume
            'Bitume2
            If (InclusioneBitume2 And Not AbilitaSelettoreBitume1) Then
                If Not CP240.AdoDosaggio.Recordset.EOF Then
                    If (CSng(CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value) > 0) Then
                        ComponentePesoOut DosaggioLeganti(1), CP240.OPCData.items(PLCTAG_NettoBitume1).Value
                        If DosaggioInCorso Then
                            ComponenteSetCalcolato DosaggioLeganti(1), CP240.OPCData.items(PLCTAG_SetBitume1).Value
                            If FrmNetti.Visible Then
                                FrmNetti.LblSetB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
                            End If
                        Else
                            ComponenteSetCalcolato DosaggioLeganti(1), CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value
                            If FrmNetti.Visible Then
                                FrmNetti.LblSetB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
                            End If
                        End If
                        VoloBitume(1) = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
                        If FrmNetti.Visible Then
                            FrmNetti.LblNettoB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
                            FrmNetti.LblResBit(1).caption = CStr(VoloBitume(1))
                            FrmNetti.LblNettiStampaB12(1).caption = NettoBitumeBuffer(0)
                            
                            FrmNetti.LblSetB12(0).caption = "0"
                            FrmNetti.LblNettoB12(0).caption = "0"
                            FrmNetti.LblResBit(0).caption = "0"
                            FrmNetti.LblNettiStampaB12(0).caption = "0"
                        End If
                        'Azzero il Bitume 1
                        ComponentePesoOut DosaggioLeganti(0), 0
                        ComponenteSetCalcolato DosaggioLeganti(0), 0
                        VoloBitume(0) = 0
                        
                    Else
                        ComponentePesoOut DosaggioLeganti(1), 0
                        ComponenteSetCalcolato DosaggioLeganti(1), 0
                        VoloBitume(1) = 0
                        If FrmNetti.Visible Then
                            FrmNetti.LblSetB12(1).caption = "0"
                            FrmNetti.LblNettoB12(1).caption = "0"
                            FrmNetti.LblResBit(1).caption = "0"
                            FrmNetti.LblNettiStampaB12(1).caption = "0"
                        End If
                    End If
                End If
            End If
    
            'Bitume3
            If (InclusioneBitume3) Then
                If Not CP240.AdoDosaggio.Recordset.EOF Then
                    If ceSoft Then
                        ComponentePesoOut DosaggioLeganti(3), CP240.OPCData.items(PLCTAG_NettoBitume1).Value
                        If DosaggioInCorso Then
                            ComponenteSetCalcolato DosaggioLeganti(3), CP240.OPCData.items(PLCTAG_SetBitume1).Value
                            If FrmNetti.Visible Then
                                FrmNetti.LblSetB12(3).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
                            End If
                        Else
                            ComponenteSetCalcolato DosaggioLeganti(3), CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value
                            If FrmNetti.Visible Then
                                FrmNetti.LblSetB12(3).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
                            End If
                        End If
                        VoloBitume(3) = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
                        If FrmNetti.Visible Then
                            FrmNetti.LblNettoB12(3).caption = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
                            FrmNetti.LblResBit(3).caption = CStr(VoloBitume(3))
                            FrmNetti.LblNettiStampaB12(3).caption = NettoBitumeBuffer(0)
                        End If
                        'Azzero il Bitume 1
                        ComponentePesoOut DosaggioLeganti(0), 0
                        ComponenteSetCalcolato DosaggioLeganti(0), 0
                        VoloBitume(0) = 0
                        If FrmNetti.Visible Then
                            FrmNetti.LblSetB12(0).caption = "0"
                            FrmNetti.LblNettoB12(0).caption = "0"
                            FrmNetti.LblResBit(0).caption = "0"
                            FrmNetti.LblNettiStampaB12(0).caption = "0"
                        End If
                    Else
                        ComponentePesoOut DosaggioLeganti(3), 0
                        ComponenteSetCalcolato DosaggioLeganti(3), 0
                        VoloBitume(3) = 0
                        If FrmNetti.Visible Then
                            FrmNetti.LblSetB12(3).caption = "0"
                            FrmNetti.LblNettoB12(3).caption = "0"
                            FrmNetti.LblResBit(3).caption = "0"
                            FrmNetti.LblNettiStampaB12(3).caption = "0"
                        End If
                    End If
                End If
            End If
    
        Else
            'Bitume1
            ComponentePesoOut DosaggioLeganti(0), CP240.OPCData.items(PLCTAG_GravitaNettoB1Kg).Value
            ComponenteSetCalcolato DosaggioLeganti(0), CP240.OPCData.items(PLCTAG_GravitaSetB1Kg).Value
            'Bitume2
            ComponentePesoOut DosaggioLeganti(1), CP240.OPCData.items(PLCTAG_GravitaNettoB2Kg).Value
            ComponenteSetCalcolato DosaggioLeganti(1), CP240.OPCData.items(PLCTAG_GravitaSetB2Kg).Value
            VoloBitume(0) = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaResB1Kg).Value, 1)
            VoloBitume(1) = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaResB2Kg).Value, 1)
            
            If FrmNetti.Visible Then
                'Bitume1
                FrmNetti.LblSetB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaSetB1Kg).Value, 1)
                FrmNetti.LblNettoB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB1Kg).Value, 1)
                FrmNetti.LblResBit(0).caption = CStr(VoloBitume(0))
                FrmNetti.LblNettiStampaB12(0).caption = NettoBitumeBuffer(0)
                'Bitume2
                FrmNetti.LblSetB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaSetB2Kg).Value, 1)
                FrmNetti.LblNettoB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB2Kg).Value, 1)
                FrmNetti.LblResBit(1).caption = CStr(VoloBitume(1))
                FrmNetti.LblNettiStampaB12(1).caption = NettoBitumeBuffer(1)
            End If
        End If
    End If
    
    If InclusioneAddContalitri Then
        ComponentePesoOut DosaggioLeganti(2), CP240.OPCData.items(PLCTAG_ContalitriNettoKg).Value
        ComponenteSetCalcolato DosaggioLeganti(2), CP240.OPCData.items(PLCTAG_ContalitriSetKg).Value
        VoloBitume(2) = RoundNumber(CP240.OPCData.items(PLCTAG_ContalitriResKg).Value, 1)
        If FrmNetti.Visible Then
            FrmNetti.LblSetB12(2).caption = RoundNumber(CP240.OPCData.items(PLCTAG_ContalitriSetKg).Value, 1)
            FrmNetti.LblNettoB12(2).caption = RoundNumber(CP240.OPCData.items(PLCTAG_ContalitriNettoKg).Value, 1)
            FrmNetti.LblResBit(2).caption = CStr(VoloBitume(2))
            FrmNetti.LblNettiStampaB12(2).caption = NettoBitumeBuffer(2)
        End If
    End If
    
    If PlcSchiumato.Abilitazione Then
        If Not CP240.AdoDosaggio.Recordset.EOF Then
            If (ceHard) Then
                PLCSchiumatoSetBitumeHard           'Set Kg e Net Kg del B.Hard
                PLCSchiumatoPercentoBitumeHard      'Visualizzazione del Set% del B.Hard
                PLCSchiumatoRitardoBitumeHard       'Visualizzazione del ritardo all'immissione B.Hard
                ComponentePesoOut DosaggioLeganti(4), RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeHard_idx).Value, 1)
                VoloBitume(4) = 0
                If FrmNetti.Visible Then
                    FrmNetti.LblNettoB12(4).caption = RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeHard_idx).Value, 1)
                    FrmNetti.LblResBit(4).caption = "0"
                    FrmNetti.LblNettiStampaB12(4).caption = NettoBitumeBuffer(4)
                End If
            End If
        End If
        If PlcSchiumato.abilitazioneSoft Then
            If Not CP240.AdoDosaggio.Recordset.EOF Then
                If (ceSoft) Then
                    PLCSchiumatoSetBitumeSoft       'Set Kg e Net Kg del B.Soft
                    PLCSchiumatoPercentoBitumeSoft  'Visualizzazione del Set% del B.Soft
                    PLCSchiumatoRitardoBitumeSoft   'Visualizzazione del ritardo all'immissione B.Soft
                    ComponentePesoOut DosaggioLeganti(3), RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeSoft_idx).Value, 1)
                    VoloBitume(3) = 0
                    If FrmNetti.Visible Then
                        FrmNetti.LblNettoB12(3).caption = RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeSoft_idx).Value, 1)
                        FrmNetti.LblResBit(3).caption = "0"
                        FrmNetti.LblNettiStampaB12(3).caption = NettoBitumeBuffer(3)
                    End If
                End If
            End If
        End If
    End If
    
    If AbilitaRAP Then
        NettoRAP = RoundNumber(CP240.OPCData.items(PLCTAG_NettoRiciclato1).Value, 1)
        ComponentePesoOut DosaggioRAP, CDbl(NettoRAP)
    End If

    If (NettoViatopBuffer(0) > 0 And CP240.AdoDosaggio.Recordset.Fields("SetViatop").Value = 0) Then
        NettoViatopBuffer(0) = 0
    End If
    If (AutomaticoViatop) Then
        Call ComponentePesoOut(DosaggioViatop, NettoViatopBuffer(0))
    End If

    '20160426 Netti e Voli Viatop Scarico Mixer
    If (BilanciaViatopScarMixer1.Presenza) Then
        Call ComponentePesoOut(DosaggioViatopScarMixer1, NettoViatopScarMixer1)
        VoloViatopScarMixer1 = Round(CP240.OPCData.items(PLCTAG_DB32_ViatopScarMixer1_VoloKg).Value, 1)
    End If
    If (BilanciaViatopScarMixer2.Presenza) Then
        Call ComponentePesoOut(DosaggioViatopScarMixer2, NettoViatopScarMixer2)
        VoloViatopScarMixer1 = Round(CP240.OPCData.items(PLCTAG_DB33_ViatopScarMixer2_VoloKg).Value, 1)
    End If
    '20160426
End Sub


Public Function RicalcolaSetRicetta(SetOLD As Double, KgImpasto As Long, PercBitume As Double, KgNew As Long) As Double
	Dim KgOriginali As Double
	Dim FattoreMoltiplica As Double

    If SetOLD = 0 Then
        SetOLD = 1 / 100
    End If
    KgOriginali = CDbl(KgImpasto) / (100 + PercBitume) * 100 * SetOLD / 100
    FattoreMoltiplica = CDbl(KgNew) / KgOriginali * 100
    RicalcolaSetRicetta = CSng(SetOLD * FattoreMoltiplica / 100)

End Function
'

Public Sub ForzaSetAggregati(Index As Integer)
	'Index va da 0 a 7

    Dim SetOLD As Double
    Dim KgNew As Long
    Dim PercBitume As Double

    With CP240

        If (Not .OPCData.IsConnected) Then
            Exit Sub
        End If
        '

        If DosaggioAggregati(Index).setCalcolato < Abs(.OPCData.items(PLCTAG_ResiduoAggregato1 + Index).Value) Then
            ComponenteSetCalcolato DosaggioAggregati(Index), 0
        End If
    
        .OPCData.items(PLCTAG_SetA1forzato1 + Index).Value = val(DosaggioAggregati(Index).setCalcolato)
        .OPCData.items(PLCTAG_SetA1forzato2 + Index).Value = val(DosaggioAggregati(Index).setCalcolato)
        .OPCData.items(PLCTAG_SetAggregato1 + Index).Value = val(DosaggioAggregati(Index).setCalcolato)
        

        SetOLD = CDbl(DosaggioAggregati(Index).set)
        KgNew = CLng(DosaggioAggregati(Index).setCalcolato)
        PercBitume = .AdoDosaggio.Recordset.Fields("Bitume1").Value + .AdoDosaggio.Recordset.Fields("Bitume2").Value + .AdoDosaggio.Recordset.Fields("SetContalitri").Value
        .OPCData.items(PLCTAG_SetA1 + Index).Value = RicalcolaSetRicetta(SetOLD, DimensioneImpastoKg, PercBitume, KgNew)
        ComponenteSet DosaggioAggregati(Index), RoundNumber(.OPCData.items(PLCTAG_SetA1 + Index).Value, 2)

        .LblTrSetPeso(Index).enabled = (DosaggioAggregati(Index).set > 0 Or Not DosaggioInCorso)
        If Not DosaggioInCorso Then
            'Dico al PLC di aggiornare la ricetta
            FrmGestioneTimer.TimerTagCambioVolo.enabled = False
            FrmGestioneTimer.TimerTagCambioVolo.Interval = 500
            FrmGestioneTimer.TimerTagCambioVolo.enabled = True
        End If
        '

    End With

End Sub

Public Sub ForzaSetFiller(Index As Integer)
	'Index va da 0 a 2

    Dim SetOLD As Double
    Dim KgNew As Long
    Dim PercBitume As Double

    With CP240

        If (Not .OPCData.IsConnected) Then
            Exit Sub
        End If

        If DosaggioFiller(Index).setCalcolato < Abs(.OPCData.items(PLCTAG_ResiduoFiller1 + Index).Value) Then
            ComponenteSetCalcolato DosaggioFiller(Index), 0
        End If

        .OPCData.items(PLCTAG_SetF1forzato1 + Index).Value = val(DosaggioFiller(Index).setCalcolato)
        .OPCData.items(PLCTAG_SetF1forzato2 + Index).Value = val(DosaggioFiller(Index).setCalcolato)
        .OPCData.items(PLCTAG_SetFiller1 + Index).Value = val(DosaggioFiller(Index).setCalcolato)

        SetOLD = CDbl(DosaggioFiller(Index).set)
        KgNew = CLng(DosaggioFiller(Index).setCalcolato)
        PercBitume = .AdoDosaggio.Recordset.Fields("Bitume1").Value + .AdoDosaggio.Recordset.Fields("Bitume2").Value + .AdoDosaggio.Recordset.Fields("SetContalitri").Value
        .OPCData.items(PLCTAG_SetF1 + Index).Value = RicalcolaSetRicetta(SetOLD, DimensioneImpastoKg, PercBitume, KgNew)
        ComponenteSet DosaggioFiller(Index), RoundNumber(.OPCData.items(PLCTAG_SetF1 + Index).Value, 2)

        .LblTrSetPeso(Index + compfiller1).enabled = (DosaggioFiller(Index).set > 0 Or Not DosaggioInCorso)
        If Not DosaggioInCorso Then
            'Dico al PLC di aggiornare la ricetta
            FrmGestioneTimer.TimerTagCambioVolo.enabled = False
            FrmGestioneTimer.TimerTagCambioVolo.Interval = 500
            FrmGestioneTimer.TimerTagCambioVolo.enabled = True
        End If

    End With

End Sub

Public Sub ForzaSetTempi(Optional soloagg_ric As Boolean)

    On Error GoTo Errore

    With CP240

        If (Not .OPCData.IsConnected) Then
            Exit Sub
        End If

        '20161230
        If (.AdoDosaggioNext.Recordset.BOF Or .AdoDosaggioNext.Recordset.EOF) Then
            Exit Sub
        End If
        '

        If (soloagg_ric) Then '20161202

            .OPCData.items(PLCTAG_TimerScA).Value = val(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoAggregati").Value)    '20161201
            .OPCData.items(PLCTAG_TempoRitardoAggregati).Value = ConvertiTempoSECtoS7(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoAggregati").Value)    '20161201 val(.TextTempiRitardoSc(19).text)
            'RAP
            .OPCData.items(PLCTAG_TimerScRAP).Value = val(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAP").Value) 'valore di ricetta DB15   '20151202 .TextTempiRitardoSc(16).text
            .OPCData.items(PLCTAG_TempoRitardoRAP).Value = ConvertiTempoSECtoS7(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAP").Value) 'valore istantaneo  '20151202 .TextTempiRitardoSc(16).text
            'RAPSiwa
            .OPCData.items(PLCTAG_TimerScRAPSiwa).Value = val(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAPSiwa").Value) 'valore di ricetta DB15 '20161202 .TextTempiRitardoSc(17).text
            .OPCData.items(PLCTAG_DB80_TempoRitardoRAPSiwa).Value = ConvertiTempoSECtoS7(.AdoDosaggioNext.Recordset.Fields("TempoRitardoScaricoRAPSiwa").Value) 'valore istantaneo '20161202 .TextTempiRitardoSc(17).text

        '20161230
        'End If
        'If (Not soloagg_ric) Then '20161202
        Else
        '

            .OPCData.items(PLCTAG_setTempoMescolazione).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(1).text))
            .OPCData.items(PLCTAG_SetTempoScaricoMixer).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(3).text))
            .OPCData.items(PLCTAG_TempoRitardoFiller).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(2).text))
            .OPCData.items(PLCTAG_TempoRitardoBitume).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(0).text))
            .OPCData.items(PLCTAG_TempoRitardoViatop).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(5).text))
            '20160420
            .OPCData.items(PLCTAG_DB15_ViatopScarMixer1_Ritardo).Value = String2Int(val(.TextTempiRitardoSc(31).text))
            .OPCData.items(PLCTAG_DB15_ViatopScarMixer2_Ritardo).Value = String2Int(val(.TextTempiRitardoSc(32).text))
            '20160420
            .OPCData.items(PLCTAG_RitardoAdditivoMixer).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(4).text))
            .OPCData.items(PLCTAG_TempoRitardoBitumeGR).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(0).text))
            .OPCData.items(PLCTAG_TimerMescolaz).Value = val(.TextTempiRitardoSc(1).text)
            .OPCData.items(PLCTAG_TimerScMesc).Value = val(.TextTempiRitardoSc(3).text)
            
            .OPCData.items(PLCTAG_TimerScF).Value = val(.TextTempiRitardoSc(2).text)
            .OPCData.items(PLCTAG_TimerScB).Value = val(.TextTempiRitardoSc(0).text)
            .OPCData.items(PLCTAG_TimerScViatop).Value = val(.TextTempiRitardoSc(5).text)
            .OPCData.items(PLCTAG_TimerScAdd1Mesc).Value = val(.TextTempiRitardoSc(4).text)
            .OPCData.items(PLCTAG_AcquaRitardoScaricoForzatura).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(7).text))
            .OPCData.items(PLCTAG_ContalitriRitardoScaricoForzatura).Value = ConvertiTempoSECtoS7(val(.TextTempiRitardoSc(8).text))
    
    
            AntiadesivoScivoloScarBilRAP.tempo_spruzzatura = val(.TextTempiRitardoSc(15).text)
            .OPCData.items(PLCTAG_TempoSpruzAntiadScarBilR).Value = AntiadesivoScivoloScarBilRAP.tempo_spruzzatura
    
            Call PLCSchiumatoSetRitardoBitumeHard(val(.TextTempiRitardoSc(6).text))
    
            'PLCSchiumatoSetRitardoBitumeSoft --> Da fare
            'TAG Ritardo Acqua --> Da fare

        End If '20161202


    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-060 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TrasformaRicettaS7()

    Dim indice As Integer
    Dim NumeroAccoppiate As Integer
    '20161013  Dim ultimaNonAccoppiata As Integer
    Dim MemIndiceArray As Integer
    Dim minimo As Integer
    Dim ultimoOrdineAssegnato As Integer '20161013 per le portine accoppiate

'Il PLC attualmente vuole che la ricetta sia composta cosi':
' Aggregato 1 : set in percentuale + ordine pesata
' Aggregato 2 : set in percentuale + ordine pesata
'...
' Aggregato 6 : set in percentuale + ordine pesata
'
'ordine pesata deve essere sempre diverso da zero se il set% e' maggiore di zero
'ordine pesata deve avere valori da 1 a 6

'Se ho portine con apertura accoppiata
'il primo aggregato della serie deve contenere in % il totale
'gli aggregati successivi devono avere il set% a zero e l'ordine di pesata uguale all'aggregato che contiene la somma:
'ESEMPIO
'Aggregato1 set% = 60%      ordine pesata = 1
'Aggregato2 set% = 0%      ordine pesata = 1
'Aggregato3 set% = 0%      ordine pesata = 1
'Aggregato4 set% = 20%      ordine pesata = 2
'Aggregato5 set% = 20%      ordine pesata = 3

'In questo modo si apriranno contemporaneamente le portine aggregati 1,2,3 e la bilancia raggiungera' il 60% del peso totale dell'impasto, poi
'verranno effettuate le due pesate singole da 20% ciascuna dell'aggregato 4 e poi del 5.

'OrdinePesata contiene la sequenza di pesata (1= prima pesata, 2=seconda pesata, ecc..)
'1. Scorro i set da Aggregato1 a Aggregato6
'2. Se l'aggregato ha set <> 0 guardo il suo OrdinePesata
'3. Se l'ordine pesata = posizione Aggregato (Aggregato1 + Ordine=1) verifico se ci sono portine accoppiate
'4. Se l'ordine pesata <> posizione Aggregato (Aggregato3 + Ordine=1)

'20160223
'    For indice = 0 To 5
    For indice = 0 To 7
'
        RicettaS7(indice).set = 0
        RicettaS7(indice).Ordine = 0
    Next indice

'20160223
'    For indice = 0 To 5
    For indice = 0 To 7
'
        With NumeroTramoggiaScAgg(indice)
        
            If .NumeroTramoggia > 0 Then
                If val(DosaggioAggregati(indice).set) <> 0 Then
                    If (.NumeroAccoppiate = 0) Then
                        'Caso di portina accoppiata alla precedente
                        RicettaS7(indice).set = 0
                        '20161013
                        ''RicettaS7(indice).Ordine = ultimaNonAccoppiata '20161011
                        ' RicettaS7(indice).Ordine = .NumeroTramoggia '20161011
                        RicettaS7(indice).Ordine = ultimoOrdineAssegnato
                        '
                    ElseIf (.NumeroAccoppiate = 1) Then
                        'Caso di portina singola
                        RicettaS7(indice).set = DosaggioAggregati(indice).set
                        RicettaS7(indice).Ordine = .NumeroTramoggia
                    Else
                        'La prima delle portine accoppiate

                        '20161013
                        ''ultimaNonAccoppiata = .NumeroTramoggia '20161011
                        '
                        'NumeroAccoppiate = .NumeroAccoppiate
                        '
                        'ultimaNonAccoppiata = indice + (NumeroAccoppiate - 1) '20161011
                        '''20161011
                        '''20160705
                        '''                        RicettaS7(indice).set = RoundNumber(DosaggioAggregati(ultimaNonAccoppiata).set * NumeroAccoppiate, 2)
                        ''                        RicettaS7(indice).set = RoundNumber(DosaggioAggregati(indice).set * NumeroAccoppiate, 2)
                        ''                       RicettaS7(indice).set = RoundNumber(DosaggioAggregati(ultimaNonAccoppiata).set * NumeroAccoppiate, 2)  '20161011
                        '
                        ''20161011
                        'RicettaS7(indice).Ordine = .NumeroTramoggia

                        NumeroAccoppiate = .NumeroAccoppiate

                        RicettaS7(indice).set = RoundNumber(DosaggioAggregati(indice).set * NumeroAccoppiate, 2)
                        RicettaS7(indice).Ordine = .NumeroTramoggia

                        ultimoOrdineAssegnato = RicettaS7(indice).Ordine
                        '

                    End If
    
                End If
            End If
        
        End With
    
    Next indice

End Sub
'

Public Sub AggiornaOrdinePesateForzato()
	Dim IndiceCampo As Integer
	Dim indice As Integer
		
		On Error GoTo Errore
		
		With CP240
			'Ordine pesate aggregati
			IndiceCampo = 0
			For indice = PLCTAG_OrdineAggForzato1 To PLCTAG_OrdineAggForzato6
				If CDbl(DosaggioAggregati(IndiceCampo).set) > 1 Then    'Metto 1% per evitare di avere pesate di pochi Kg
					.OPCData.items(indice).Value = RicettaS7(IndiceCampo).Ordine
				Else
					If (CDbl(DosaggioAggregati(IndiceCampo).set) = 0 And RicettaS7(IndiceCampo).Ordine > 0 And IndiceCampo > 0) Then
					'
						If (RicettaS7(IndiceCampo).Ordine = RicettaS7(IndiceCampo - 1).Ordine) And (IndiceCampo > 0) Then
							'Caso di portine accoppiate ho il set=0
							.OPCData.items(indice).Value = RicettaS7(IndiceCampo).Ordine
						Else
							.OPCData.items(indice).Value = CSng(0)
						End If
					Else
						.OPCData.items(indice).Value = CSng(0)
					End If
				End If

				IndiceCampo = IndiceCampo + 1
			Next indice
			
			'Ordine pesate filler
			IndiceCampo = 0
			If .OPCData.items(PLCTAG_SetF1).Value > 0 Then
				IndiceCampo = IndiceCampo + 1
				.OPCData.items(PLCTAG_OrdineFillForzato1).Value = CSng(IndiceCampo) 'Filler per ordine di pesatura
			Else
				.OPCData.items(PLCTAG_OrdineFillForzato1).Value = CSng(0)           'Filler per ordine di pesatura
			End If
			If .OPCData.items(PLCTAG_SetF2).Value > 0 Then
				IndiceCampo = IndiceCampo + 1
				.OPCData.items(PLCTAG_OrdineFillForzato2).Value = CSng(IndiceCampo) 'Filler per ordine di pesatura
			Else
				.OPCData.items(PLCTAG_OrdineFillForzato2).Value = CSng(0)           'Filler per ordine di pesatura
			End If
			If .OPCData.items(PLCTAG_SetF3).Value > 0 Then
				IndiceCampo = IndiceCampo + 1
				.OPCData.items(PLCTAG_OrdineFillForzato3).Value = CSng(IndiceCampo) 'Filler per ordine di pesatura
			Else
				.OPCData.items(PLCTAG_OrdineFillForzato4).Value = CSng(0)           'Filler per ordine di pesatura
			End If
		End With
		
		Exit Sub
	Errore:
    LogInserisci True, "DOS-061 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub InizializzaComponenti()

    Dim indice As Integer
    Dim progressivo As Integer
    Dim leftPos As Integer

    ' Aggregati (progressivo/componente 0-5)
    For indice = 0 To 5
        ComponenteInit _
            DosaggioAggregati(indice), _
            progressivo, _
            (indice <= NTramoggeA), _
            NomePortina(indice), _
            (indice = NTramoggeA) Or InclusioneTemperaturaTramogge, _
            (NLivelliA <> 0), _
            False, _
            True
            
        progressivo = progressivo + 1
    Next indice
    
    ' Fresato (progressivo/componente 6) .... STEFANO: componente definito RAP dentro bilancia aggregati ?!?!
    ComponenteInit _
        DosaggioAggregati(6), _
        progressivo, _
        (PesaturaRiciclatoAggregato7 And Not ParallelDrum), _
        NomePortina(indice), _
        False, _
        True, _
        (AbilitaCodaMateriale And ParallelDrum), _
        PesaturaRiciclatoAggregato7
    progressivo = progressivo + 1

    ' Non Vagliato (progressivo/componente 7)
    ComponenteInit DosaggioAggregati(7), progressivo, True, NomePortina(7), True, (NLivelliA = 2), AbilitaCodaMateriale, True
    progressivo = progressivo + 1
    ' Filler (progressivo/componente 8,9,10)
    ComponenteInit DosaggioFiller(0), progressivo, True, "F1", False, (InclusioneTramoggiaTamponeF1 And Not AbilitaBindicatorFillerEsterni), False, True
    progressivo = progressivo + 1

'20150624
'    ComponenteInit DosaggioFiller(1), progressivo, InclusioneF2, "F2", False, (InclusioneTramoggiaTamponeF2 And Not AbilitaBindicatorFillerEsterni), False, True
    ComponenteInit DosaggioFiller(1), progressivo, InclusioneF2 Or (GestioneFiller2 = FillerSoloTramTamp), "F2", False, (InclusioneTramoggiaTamponeF2 And Not AbilitaBindicatorFillerEsterni) Or (GestioneFiller2 = FillerSoloTramTamp), False, (GestioneFiller2 <> FillerSoloTramTamp)
'
    progressivo = progressivo + 1
'20151030
'20150708
'    ComponenteInit DosaggioFiller(2), progressivo, InclusioneF3, "F3", False, (False And Not AbilitaBindicatorFillerEsterni), False, True
'    ComponenteInit DosaggioFiller(2), progressivo, InclusioneF3 Or (GestioneFiller2 = FillerSoloTramTamp), "F3", False, (InclusioneTramoggiaTamponeF2 And Not AbilitaBindicatorFillerEsterni) Or (GestioneFiller3 = FillerSoloTramTamp), False, (GestioneFiller3 <> FillerSoloTramTamp)
    ComponenteInit DosaggioFiller(2), progressivo, InclusioneF3 Or (GestioneFiller3 = FillerSoloTramTamp), "F3", False, (GestioneFiller3 = FillerSoloTramTamp), False, (GestioneFiller3 <> FillerSoloTramTamp)
'
    progressivo = progressivo + 1
    ' Bitume (progressivo/componente 11,12,13)
    ComponenteInit DosaggioLeganti(0), progressivo, True, "B1", False, False, False, False
    progressivo = progressivo + 1
    ComponenteInit DosaggioLeganti(1), progressivo, InclusioneBitume2, "B2", False, False, False, False
    progressivo = progressivo + 1
    'ComponenteInit DosaggioLeganti(2), progressivo, InclusioneAddContalitri, "B3", False, False, False, False   20160229
    ComponenteInit DosaggioLeganti(2), progressivo, InclusioneBitume3, "B3", False, False, False, False         '20160209
    progressivo = progressivo + 1
    ' Wam foam soft/hard (progressivo/componente 14,15)
    ComponenteInit DosaggioLeganti(3), progressivo, PlcSchiumato.Abilitazione, "B.Soft", False, False, False, False
    progressivo = progressivo + 1
    ComponenteInit DosaggioLeganti(4), progressivo, PlcSchiumato.Abilitazione, "B.Hard", False, False, False, False
    progressivo = progressivo + 1
    ' Viatop (progressivo/componente 16)
    ComponenteInit DosaggioViatop, progressivo, InclusioneViatop, LoadXLSString(491), False, False, False, False
    '20160420
    'progressivo = progressivo + 2
    progressivo = 31
    '20160512
    'CP240.CmdComprViatop(31).Picture = LoadResPicture("IDB_VIATOPSCARMIX_COMPOFF", vbResBitmap)
    '
    'Viatop Scarico Mixer 1
    ComponenteInit DosaggioViatopScarMixer1, progressivo, BilanciaViatopScarMixer1.Presenza, LoadXLSString(1521), False, False, False, False
    progressivo = 32
    '20160512
    'CP240.CmdComprViatop(32).Picture = LoadResPicture("IDB_VIATOPSCARMIX_COMPOFF", vbResBitmap)
    '
    'Viatop Scarico Mixer 2
    ComponenteInit DosaggioViatopScarMixer2, progressivo, BilanciaViatopScarMixer2.Presenza, LoadXLSString(1522), False, False, False, False
    progressivo = 18
    '20160420
    
    ' RAP (Progressivo/componente 18)
    ComponenteInit DosaggioRAP, progressivo, AbilitaRAP, "RAP", False, True, False, True
    progressivo = progressivo + 1
    ' RAPSiwa (Progressivo/componente 19)
    ComponenteInit DosaggioRAPSiwa, progressivo, AbilitaRAPSiwa, "RAPSiwa", False, True, False, False
    progressivo = progressivo + 1
    'Debug.Assert (progressivo = compMax)

    '20160420
    Call PosizionaAdditivi
    
    With CP240

        leftPos = .ImgMotor(100 + MotoreElevatoreCaldo).left
        leftPos = leftPos + .ImgMotor(100 + MotoreElevatoreCaldo).width
        leftPos = leftPos + 2
        .FrameTr(7).left = leftPos
        For indice = 0 To 5
            .FrameTr(indice).left = leftPos + ((6 - indice) * 57)
        Next indice
    
    
        'Ridimensiono la bilancia e lo scarico del filler e del bitume
        If InclusioneF2 And InclusioneF3 Then
            .ProgressBil(1).width = 170
        Else
            If InclusioneF2 Then
                .ProgressBil(1).width = 115
            Else
                .ProgressBil(1).width = 60
            End If
        End If
        
        .Frame1(11).left = .ProgressBil(1).left + .ProgressBil(1).width / 2 - .Frame1(11).width / 2
        .CmdScarica(1).left = .ProgressBil(1).left + .ProgressBil(1).width - .CmdScarica(1).width
        '20161024
        'CP240.CmdTipoPesate(101).left = CP240.CmdScarica(1).left - 29
        '

        If InclusioneBitume2 And InclusioneAddContalitri Then
            .ProgressBil(2).width = 170
        Else
            If InclusioneBitume2 Then
                .ProgressBil(2).width = 117
            Else
                .ProgressBil(2).width = 60
            End If
        End If

        .Frame1(13).left = .ProgressBil(2).left + .ProgressBil(2).width / 2 - .Frame1(13).width / 2
        .CmdScarica(2).left = .ProgressBil(2).left + .ProgressBil(2).width - .CmdScarica(2).width

    End With

End Sub

Public Sub ComponenteInit( ByRef componente As ComponenteType, progessivo As Integer, esiste As Boolean, Nome As String, temperatura As Boolean, Livello As Boolean, livelloTeorico As Boolean, pesaExt As Boolean )

    With componente

        .progressivo = progessivo
        .presente = esiste
        .Nome = Nome
        .livelloPresente = Livello
        .livelloTeoricoPresente = livelloTeorico

        CP240.FrameTr(.progressivo).BackColor = CP240.BackColor
        CP240.FrameTr(.progressivo).Visible = .presente
        If .progressivo <> 16 Then
            CP240.ImgTr(.progressivo).Picture = LoadResPicture("IDB_TRAMOGGIA", vbResBitmap)
            If .progressivo <> 31 And .progressivo <> 32 Then   '20160420
                CP240.LblTrTemp(.progressivo).Visible = temperatura
                CP240.LblTrTemp(.progressivo).ToolTipText = LoadXLSString(698)
                ComponenteTemperatura componente, 0
            End If   '20160420
            CP240.LblTrLivTeorico(.progressivo).Visible = .livelloTeoricoPresente
            .livelloTeorico = 0
            CP240.LblTrLivTeorico(.progressivo).caption = CStr(.livelloTeorico)
        End If

        CP240.LblTrNome(.progressivo).caption = .Nome

        CP240.PrbTrLivello(.progressivo).Visible = .livelloPresente
        ComponenteLivello componente, 0
        CP240.PctTrLivello(.progressivo).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)

        CP240.LblTrSet(.progressivo).caption = "0"
        CP240.LblTrSet(.progressivo).ToolTipText = LoadXLSString(692)
        CP240.LblTrSetPeso(.progressivo).caption = "0"
        CP240.LblTrSetPeso(.progressivo).ToolTipText = LoadXLSString(692)
        CP240.LblTrNet(.progressivo).caption = "0"

'20170222
        If .progressivo >= CompGrafAggregato1 And .progressivo < CompGrafMax Then
            CP240.ProgressBil(.progressivo + 100).caption = "0"
            CP240.ProgressBil(.progressivo + 100).Value = 0
        End If
'

'20150624
        CP240.LblTrSet(.progressivo).Visible = (GestioneFiller2 <> FillerSoloTramTamp) Or .progressivo <> 9
        CP240.LblTrSetPeso(.progressivo).Visible = (GestioneFiller2 <> FillerSoloTramTamp) Or .progressivo <> 9
        CP240.LblTrNet(.progressivo).Visible = (GestioneFiller2 <> FillerSoloTramTamp) Or .progressivo <> 9
        CP240.CmdTrPesa(.progressivo).Visible = (GestioneFiller2 <> FillerSoloTramTamp) Or .progressivo <> 9
'

'20170222
        If .progressivo >= CompGrafAggregato1 And .progressivo < CompGrafMax Then
            CP240.ProgressBil(.progressivo + 100).Visible = (GestioneFiller2 <> FillerSoloTramTamp) Or .progressivo <> 9
        End If
'

'20151030
        CP240.LblTrSet(.progressivo).Visible = (GestioneFiller3 <> FillerSoloTramTamp) Or .progressivo <> 10
        CP240.LblTrSetPeso(.progressivo).Visible = (GestioneFiller3 <> FillerSoloTramTamp) Or .progressivo <> 10
        CP240.LblTrNet(.progressivo).Visible = (GestioneFiller3 <> FillerSoloTramTamp) Or .progressivo <> 10
        CP240.CmdTrPesa(.progressivo).Visible = (GestioneFiller3 <> FillerSoloTramTamp) Or .progressivo <> 10
'
        
'20170222
        If .progressivo >= CompGrafAggregato1 And .progressivo < CompGrafMax Then
            CP240.ProgressBil(.progressivo + 100).Visible = (GestioneFiller3 <> FillerSoloTramTamp) Or .progressivo <> 10
        End If
'

        CP240.CmdTrPesa(.progressivo).Picture = LoadResPicture("IDI_VALVOLA", vbResIcon)
        CP240.CmdTrPesa(.progressivo).ToolTipText = LoadXLSString(357)

        If (pesaExt) Then
            CP240.CmdPesaEXT(.progressivo).Picture = LoadResPicture("IDI_VALVOLA", vbResIcon)
        End If

    End With

End Sub


Public Sub StatoAccoppiataDisplay(ByRef componente As ComponenteType, Stato As Boolean)

    With componente
        '20161010
        'If .progressivo >= 2 And .progressivo <= 5 Then
        If .progressivo >= 2 And .progressivo <= 6 Then
        '
            CP240.pctTrAccoppiata(.progressivo - 1).Visible = Stato
        End If
    End With

End Sub


Public Sub ComponenteSetDisplay(ByRef componente As ComponenteType, Optional decimalDigit As Integer)

    With componente

        If (Not .presente) Then
            Exit Sub
        End If

        CP240.LblTrSet(.progressivo).caption = RoundNumber(.set, IIf(decimalDigit < 1, 1, decimalDigit))

    End With

End Sub

Public Sub ComponenteSet(ByRef componente As ComponenteType, Value As Double)

    With componente

        If (Not .presente) Then
            Exit Sub
        End If

        .set = Value

    End With

End Sub

Public Sub ComponenteSetCalcolato(ByRef componente As ComponenteType, Value As Double)

    With componente

        If (Not .presente) Then
            Exit Sub
        End If

        .setCalcolato = Value

        CP240.LblTrSetPeso(.progressivo).caption = RoundNumber(.setCalcolato, 1)

    End With

End Sub

Public Sub ComponenteTemperatura(ByRef componente As ComponenteType, Value As Double)

    With componente

        If (Not .presente) Then
            Exit Sub
        End If

        .temperatura = Value

        CP240.LblTrTemp(.progressivo).caption = RoundNumber(.temperatura, 0)

    End With

End Sub

Public Sub ComponenteLivello(ByRef componente As ComponenteType, Value As Integer)

    On Error GoTo Errore

    With componente

        If (Not .presente Or Not .livelloPresente) Then
            Exit Sub
        End If

        .Livello = Value

        CP240.PrbTrLivello(.progressivo).Value = .Livello
        CP240.PrbTrLivello(.progressivo).caption = CP240.PrbTrLivello(.progressivo).Value

        'RAP
        If (.progressivo = 18) Then
                If (.Livello > TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaAllarmePercentuale) Then
                CP240.PrbTrLivello(.progressivo).FillColor = vbRed
            Else
                CP240.PrbTrLivello(.progressivo).FillColor = vbBlue
            End If
'20151130
        ElseIf .progressivo >= 8 Or .progressivo <= 10 Then
            If ((LivelloMaxF1 And .progressivo = 8) Or (LivelloMaxF2 And .progressivo = 9)) Then
                If (.Livello < TramoggeLivelloMassimo - 5) Then
                    CP240.PrbTrLivello(.progressivo).FillColor = vbRed
                Else
                    CP240.PrbTrLivello(.progressivo).FillColor = vbBlue
                End If
            Else
                If (.Livello < TramoggeLivelloMinimo Or .Livello >= TramoggeLivelloMassimo) Then
                    CP240.PrbTrLivello(.progressivo).FillColor = vbRed
                ElseIf (.Livello > TramoggeLivelloMinimo + 5 And .Livello < TramoggeLivelloMassimo - 5) Then
                    CP240.PrbTrLivello(.progressivo).FillColor = vbBlue
                End If
        
            End If
'fine 20151130
        Else
            If (.Livello < TramoggeLivelloMinimo Or .Livello >= TramoggeLivelloMassimo) Then
                CP240.PrbTrLivello(.progressivo).FillColor = vbRed
            ElseIf (.Livello > TramoggeLivelloMinimo + 5 And .Livello < TramoggeLivelloMassimo - 5) Then
                CP240.PrbTrLivello(.progressivo).FillColor = vbBlue
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "DOS-062 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ComponenteInPesata(ByRef componente As ComponenteType, Value As Boolean)

    With componente

        If (Not .presente) Then
            Exit Sub
        End If

        If (Value) Then
            CP240.ImgTr(.progressivo).Picture = LoadResPicture("IDB_TRAMOGGIAON", vbResBitmap)
        Else
            CP240.ImgTr(.progressivo).Picture = LoadResPicture("IDB_TRAMOGGIA", vbResBitmap)
        End If

'20170223
'Memoria tara componente per visualizzazione progress bar peso netto
        .pesataAttiva = Value
                        
        If Not SospensionePesatura And Value Then
            Select Case .progressivo
                Case CompGrafAggregato1 To CompGrafNonVagliato
                    .memTaraPesoNetto = BilanciaAggregati.Peso
                    BilanciaAggregati.CompAttivo = .progressivo - ComponenteEnum.CompAggregato1
                Case CompGrafFiller1 To CompGrafFiller3
                    .memTaraPesoNetto = BilanciaFiller.Peso
                    BilanciaFiller.CompAttivo = .progressivo - ComponenteEnum.compfiller1
                Case CompGrafLegante1 To CompGrafLegante3
                    .memTaraPesoNetto = BilanciaLegante.Peso
                    BilanciaLegante.CompAttivo = .progressivo - ComponenteEnum.CompLegante1
                Case CompGrafRAP
                    .memTaraPesoNetto = BilanciaRAP.Peso
                    BilanciaRAP.CompAttivo = .progressivo - ComponenteEnum.CompRAP
                Case CompGrafRAPSiwa
                    .memTaraPesoNetto = BilanciaRAPSiwa.Peso
                    BilanciaRAPSiwa.CompAttivo = .progressivo - ComponenteEnum.CompRAPSiwa
                Case CompGrafViatop
'                    .memTaraPesoNetto = BilanciaViatop.Peso
'                    BilanciaViatop.CompAttivo = .progressivo - ComponenteEnum.CompViatop
                Case CompGrafViatopScarMixer1
                    .memTaraPesoNetto = BilanciaViatopScarMixer1.Peso
'                    BilanciaViatopScarMixer1.CompAttivo = .progressivo - ComponenteEnum.CompViatopScarMixer1
                Case CompGrafViatopScarMixer2
                    .memTaraPesoNetto = BilanciaViatopScarMixer2.Peso
'                    BilanciaViatopScarMixer2.CompAttivo = .progressivo - ComponenteEnum.CompViatopScarMixer2
            End Select
        End If
'

    End With

End Sub

Public Sub LivelloTeoricoIn(ByRef componente As ComponenteType, Value As Double)

    With componente

        If (Not .presente Or Not .livelloTeoricoPresente) Then
            Exit Sub
        End If

        .livelloTeorico = .livelloTeorico + Value

        CP240.LblTrLivTeorico(.progressivo).caption = RoundNumber(.livelloTeorico / 1000, 1)

    End With

End Sub

Public Sub ComponentePesoOut(ByRef componente As ComponenteType, Value As Double)

    With componente

        If (Not .presente) Then
            Exit Sub
        End If
        

        .pesoOutPrecedente = .pesoOut
        .pesoOut = Value

        CP240.LblTrNet(.progressivo).caption = Format(.pesoOut, "##0.0")
        
'20170222
        If .progressivo >= CompGrafAggregato1 And .progressivo < CompGrafMax And Not PesaturaManuale Then
            CP240.ProgressBil(.progressivo + 100).caption = Format(.pesoOut, "##0.0")
        End If
'

    End With

End Sub

Public Sub LivelloTeoricoOut(ByRef componente As ComponenteType, Value As Double)
	'Devo scalare i Kg dal tramoggione solo quando scarico gli aggregati all'interno del mescolatore

    With componente

        If (Not .presente) Then
            Exit Sub
        End If
        
        .livelloTeorico = .livelloTeorico - Value
        If (.livelloTeorico < 0) Then
            .livelloTeorico = 0
        End If
        
        CP240.LblTrLivTeorico(.progressivo).caption = RoundNumber(.livelloTeorico / 1000, 1)

    End With
    
End Sub

Public Sub PulsanteStopCicliDosaggio()

    InviaStopDosaggio = True    'Tasto di Stop dosaggio premuto.
    If (Not DEMO_VERSION) Then
        '20161024
        If (IsPlcConnected(CP240.OPCData)) Then
    '
            CP240.OPCData.items(PLCTAG_StartDosaggio).Value = False
        End If
    End If

End Sub


Public Sub GestioneCambioRicettaDosaggio()

	On Error GoTo Errore
    
    If (AbilitaCambioRicetta) Then
        If (SelezioneRicettaDosaggioCambiata Or RicettaInUsoModificata Or CambioPercentualeDosaggio) Then
            Call RichiamoRicettaDos
        End If
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-063 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function ImpastoPeso() As Long
    
    ImpastoPeso = CLng(ImpastoVagliato)
    
    If Not CP240.AdoDosaggioNext.Recordset.EOF Then
        If CP240.AdoDosaggioNext.Recordset.Fields("AggregatoNV").Value > 0 Then
            ImpastoPeso = CLng(ImpastoNonVagliato)
        End If
    End If
    
End Function

Public Function GrandezzaImpastoPLC() As Integer
    
    GrandezzaImpastoPLC = ImpastoVagliato
    
    If Not CP240.AdoDosaggioNext.Recordset.EOF Then
        If CP240.AdoDosaggioNext.Recordset.Fields("AggregatoNV").Value > 0 Then
            GrandezzaImpastoPLC = ImpastoNonVagliato
        End If
        If CP240.AdoDosaggioNext.Recordset.Fields("SetBitumeHard").Value > 0 Then
            'Considero lo schiumato dentro al 100%
            GrandezzaImpastoPLC = GrandezzaImpastoPLC / ((100 + CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value) / 100)
        End If

    End If
    
End Function

Public Sub PressioneAriaInsufficente_change()

    On Error GoTo Errore

    CP240.Image1(26).Visible = PressioneAriaInsufficente

    'Se l'aria è insufficente, viene arrestato il dosaggio ed i predosatori.
    If (PressioneAriaInsufficente And DosaggioInCorso) Then
        'Arresta il predosaggio.
        Call PulsanteStopPred

        'Arresta con urgenza il dosaggio
        Call ArrestoEmergenzaDosaggio
    End If

    Exit Sub
	Errore:
    LogInserisci True, "DOS-064 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TemperaturaLegante_change(indiceEtichetta As Integer, temperatura As Long)

    On Error GoTo Errore

    With CP240

'20150704

        If Not .AdoDosaggioScarico.Recordset.EOF Then
            If (val(.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value) And BassaTemperaturaBitume(0)) _
                Or (val(.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) And BassaTemperaturaBitume(1)) _
            Then
                Call PulsanteStopCicliDosaggio
            End If
        End If
'
        
        .LblTempBitume(indiceEtichetta).caption = temperatura

        'Colora di grigio la casella della temperatura se è inferiore al limite impostato;
        'di azzurro se è superiore al limite impostato
        If temperatura < TempMinimaBitume Then
            Call ColoreCasellaTemperatura(CP240.LblTempBitume(indiceEtichetta), grigioblu)
        Else
            Call ColoreCasellaTemperatura(CP240.LblTempBitume(indiceEtichetta), azzurroblu)
        End If

    End With

    Exit Sub
	Errore:
    LogInserisci True, "DOS-065 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PosizionaDeflettoreByPassTamburoParallelo()

    On Error GoTo Errore

    If (Not ParallelDrum Or Not ListaMotori(MotoreNastroBypassEssicatore).presente Or ManualeDeflettoreByPassTamburoParallelo) Then
        Exit Sub
    End If

    If (CP240.AdoDosaggioNext.Recordset.Fields("RAP").Value > 0) Then
        'RAP -> in tramoggia per caldo -> utilizzo il tamburo ER
        DeflettoreByPassTamburoParalleloVersoNastro = False
    ElseIf (CP240.AdoDosaggioNext.Recordset.Fields("RAPSiwa").Value > 0) Then
        'RAPSiwa -> in tramoggia per freddo -> utilizzo il nastro bypass
        DeflettoreByPassTamburoParalleloVersoNastro = True
    End If

    Call GestioneDeflettoreByPassTamburoParallelo

    Exit Sub
	Errore:
    LogInserisci True, "DOS-066 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub GestioneDeflettoreByPassTamburoParallelo()

    On Error GoTo Errore

    If (Not ParallelDrum Or Not ListaMotori(MotoreNastroBypassEssicatore).presente) Then
        Exit Sub
    End If
    

    '1 = verso il nastro
    '2 = verso il tamburo
    '3 = uscita e ritorno non coerente
    CP240.AniPushButtonDeflettore(30).Value = IIf( _
        DeflettoreByPassTamburoParalleloVersoNastro And DeflettoreByPassTamburoParalleloFCNastro, 1, IIf( _
        Not DeflettoreByPassTamburoParalleloVersoNastro And DeflettoreByPassTamburoParalleloFCTamburo, 2, _
        3) _
    )
    FrmGestioneTimer.TimerDeflettoreBypassRap.enabled = True
    
    Exit Sub
	Errore:
    LogInserisci True, "DOS-067 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BilAdditivoBacCNT_change()

    With CP240
        .LblAdd(7).caption = Round(AdditivoBacinella.setKg, 1)
        .LblAdd(8).caption = Round(AdditivoBacinella.nettoKg, 1)
        BufferAddBacNet(1) = Round(AdditivoBacinella.nettoKg, 1)
        BufferAddBacSet(1) = Round(AdditivoBacinella.setKg, 1)
    End With

End Sub

Public Sub LetturaPesoMescolatore()
    Dim nomeFile As String

    nomeFile = UserDataPath + "Pesi Vari.ini"
    '20151105
    'QuantitaImpastoProdottoReset = CLng(FileGetValue(nomeFile, "Mescolatore", "PesoResettabile", 0))
    'CP240.LblKgDosaggio(1).caption = QuantitaImpastoProdottoReset
    QuantitaImpastoProdottoReset = CDbl(FileGetValue(nomeFile, "Mescolatore", "PesoResettabile", 0))
    CP240.LblKgDosaggio(1).caption = RoundNumber(QuantitaImpastoProdottoReset, 0)
    '
End Sub

Public Sub ScritturaPesoMescolatore()
    Dim nomeFile As String

    nomeFile = UserDataPath + "Pesi Vari.ini"
    '20151105
    'FileSetValue nomeFile, "Mescolatore", "PesoResettabile", CStr(QuantitaImpastoProdottoReset)
    FileSetValue nomeFile, "Mescolatore", "PesoResettabile", RoundNumber(QuantitaImpastoProdottoReset, 0)
    '
End Sub

Public Sub VerificaRitornoPesataFiller(componente As Integer, comando As Boolean, ritorno As Boolean)

    On Error GoTo Errore

    If (componente = 1 And Not InclusioneF2) Or (componente = 2 And Not InclusioneF3) Then
        Call AllarmeTemporaneo("XX" + Format(componente + 130, "000"), False)
        Exit Sub
    End If

    If (comando And Not ritorno) And TempoControlloRitornoPesataFiller(componente) = 0 Then
        TempoControlloRitornoPesataFiller(componente) = ConvertiTimer()
    ElseIf (comando = ritorno) Then
        TempoControlloRitornoPesataFiller(componente) = 0
    End If
    
    Call AllarmeTemporaneo("XX" + Format(componente + 130, "000"), TempoControlloRitornoPesataFiller(componente) <> 0 And (ConvertiTimer() >= (TempoControlloRitornoPesataFiller(componente) + 3)))

    Exit Sub
	Errore:
    LogInserisci True, "DOS-068 ", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function VerificaSetSicurezzeBilance() As Boolean

    Dim indice As Integer
    Dim result As Boolean
    Dim codicemessaggio As Long

    '20170222
    'For indice = 0 To 8
    For indice = LBound(DosaggioAggregati) To UBound(DosaggioAggregati)
    '
        If DosaggioAggregati(indice).setCalcolato > BilanciaAggregati.Sicurezza Then
            codicemessaggio = 1487
            GoTo TestFallito
        End If
    Next indice
                
    '20170222
    'For indice = 0 To 2
    For indice = LBound(DosaggioFiller) To UBound(DosaggioFiller)
    '
        If DosaggioFiller(indice).setCalcolato > BilanciaAggregati.Sicurezza Then
            codicemessaggio = 1488
            GoTo TestFallito
        End If
    Next indice
    
    '20170222
    'For indice = 0 To 2
    For indice = LBound(DosaggioLeganti) To UBound(DosaggioLeganti)
    '
        If DosaggioLeganti(indice).setCalcolato > BilanciaLegante.Sicurezza Then
            codicemessaggio = 1489
            GoTo TestFallito
        End If
    Next indice
                
    If DosaggioRAP.setCalcolato > BilanciaRAP.Sicurezza Or DosaggioRAPSiwa.setCalcolato > BilanciaRAPSiwa.Sicurezza Then
        codicemessaggio = 1490
        GoTo TestFallito
    End If
    
    If DosaggioViatop.setCalcolato > BilanciaViatop.Sicurezza Then
        codicemessaggio = 1491
        GoTo TestFallito
    End If

    VerificaSetSicurezzeBilance = True
    
    Exit Function
    
	TestFallito:
            
    result = ShowMsgBox( _
            LoadXLSString(codicemessaggio), _
            vbOKOnly, _
            vbExclamation, _
            -1, _
            -1, _
            True _
            )

    VerificaSetSicurezzeBilance = False

End Function


'20160229
Public Sub SelezionaRicettaDosaggio()
    Dim i As Integer
    Dim TotKG As Double
    Dim TotPerc As Double
    Dim rs As New adodb.Recordset
    'Dim numeroSacchi As Integer
    
    With CP240

        If (.adoComboDosaggio.text = "") Then
            Exit Sub
        End If
    
        For i = 1 To 8
            TotKG = TotKG + DosaggioAggregati(i - 1).setCalcolato
            TotPerc = TotPerc + DosaggioAggregati(i - 1).set
        Next i
         
        'RAP
        TotKG = TotKG + DosaggioRAP.setCalcolato
        TotPerc = TotPerc + DosaggioRAP.set
    
        'RAPSiwa
        TotKG = TotKG + DosaggioRAPSiwa.setCalcolato
        TotPerc = TotPerc + DosaggioRAPSiwa.set
        
        If (.LblNomeRicDos(0).caption = .adoComboDosaggio.text) Then
            If (TotPerc <> 0 And TotKG <> 0) Then
                'ricetta invariata
                Exit Sub
            End If
        End If
           
        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * From Dosaggio Where [Descrizione] = N'" & CP240.adoComboDosaggio.text & "' ;"
            .LockType = adLockReadOnly
            .CursorLocation = adUseClient
            .CursorType = adOpenForwardOnly
            .Open , DBcon
        End With
        
        If DosaggioInCorso And Not BitumeGravita Then
            If (val(.AdoDosaggioScarico.Recordset.Fields("Bitume1").Value * 10) > 0) Then
                'Bitume1 --> Bitume2
                If Not rs.EOF Then
                    If rs![bitume2] <> 0 Then
                        .adoComboDosaggio.text = .LblNomeRicDos(0).caption
                        AllarmeCicalino = True
                        ShowMsgBox _
                            NoOperazione & vbCrLf & LoadXLSString(37), _
                            vbOKOnly, _
                            vbExclamation, _
                            -1, _
                            -1, _
                            True
                        AllarmeCicalino = False
                    End If
                End If
            End If
            If (val(.AdoDosaggioScarico.Recordset.Fields("Bitume2").Value) * 10 > 0) Then
                'Bitume2 --> Bitume1
                If Not rs.EOF Then
                    If rs![Bitume1] <> 0 Then
                        .adoComboDosaggio.text = .LblNomeRicDos(0).caption
                        AllarmeCicalino = True
                        ShowMsgBox _
                            NoOperazione & vbCrLf & LoadXLSString(37), _
                            vbOKOnly, _
                            vbExclamation, _
                            -1, _
                            -1, _
                            True
                        AllarmeCicalino = False
                    End If
                End If
                'Bitume2 --> Emulsione e viceversa
                If Not rs.EOF Then
                    If (CBool(.AdoDosaggioScarico.Recordset.Fields("Emulsione").Value)) <> CBool(rs![Emulsione]) Then
                        .adoComboDosaggio.text = .LblNomeRicDos(0).caption
                        AllarmeCicalino = True
                        ShowMsgBox _
                            NoOperazione & vbCrLf & LoadXLSString(37), _
                            vbOKOnly, _
                            vbExclamation, _
                            -1, _
                            -1, _
                            True
                        AllarmeCicalino = False
                    End If
                End If
            End If
        End If
    
        SelezioneRicettaDosaggioCambiata = True
    
        If Not BitumeGravita Then
            If DosaggioLeganti(1).set <> 0 Then
                ScambioBitume2 = 1
            Else
                ScambioBitume2 = 0
            End If
        End If
    
        .LblProdDos.caption = PlcSchiumatoControllaB_Hard_sec(PlcSchiumato.TempoMinimoSchiumatura, PlcSchiumato.TempoMassimoSchiumatura)
    End With
    
    Call GestioneCambioRicettaDosaggio '20160229

End Sub
'

'20170110
'20160404
Public Sub SelectDosingRecipeByCS(IdRecipe As Long)
    
    If (Not CP240.Picture1(2).Visible) Then
        Dim found As Boolean
        found = False

        If (IdRecipe > 0) Then
            CP240.AdoDosaggioNext.Recordset.MoveFirst
             Do Until CP240.AdoDosaggioNext.Recordset.EOF
                 If CStr(IdRecipe) = CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value Then
                    found = True
                    Exit Do
                 End If
                 CP240.AdoDosaggioNext.Recordset.MoveNext
             Loop
             If (found) Then
                CP240.adoComboDosaggio.text = CP240.AdoDosaggioNext.Recordset.Fields("Descrizione").Value
                Call SelezionaRicettaDosaggio
             End If
      End If
    End If
End Sub

'20170110
Public Sub SelectClienteByCS(IdCliente As Long)
        
        Dim found As Boolean
        found = False

        If (IdCliente > 0) Then
            CP240.AdoClienti.Recordset.MoveFirst
             Do Until CP240.AdoClienti.Recordset.EOF
                 If CStr(IdCliente) = CP240.AdoClienti.Recordset.Fields("IdCliente").Value Then
                    found = True
                    Exit Do
                 End If
                 CP240.AdoClienti.Recordset.MoveNext
             Loop
             If (found) Then
                CP240.AdoComboClienti.text = CP240.AdoClienti.Recordset.Fields("Descrizione").Value
             End If
      End If
End Sub
'



'20160420?
Public Sub PosizionaAdditivi()
    'posizionamento in base alla commessa MP16006
    Dim numeroviatop As Integer
    numeroviatop = 0

    With CP240
        If (InclusioneViatop And BilanciaViatopScarMixer2.Presenza) Or (BilanciaViatopScarMixer2.Presenza And BilanciaViatopScarMixer2.Presenza) Then
            numeroviatop = 2
        End If
         If ((InclusioneViatop And Not BilanciaViatopScarMixer1.Presenza And Not BilanciaViatopScarMixer2.Presenza) Or (Not InclusioneViatop And BilanciaViatopScarMixer1.Presenza And Not BilanciaViatopScarMixer2.Presenza) Or (Not InclusioneViatop And Not BilanciaViatopScarMixer1.Presenza And BilanciaViatopScarMixer2.Presenza)) Then
            numeroviatop = 1
        End If
        
        .Frame1(65).Visible = BilanciaViatopScarMixer1.Presenza Or BilanciaViatopScarMixer2.Presenza
        .Frame1(35).Visible = (InclusioneAddMescolatore Or InclusioneAddBacinella Or InclusioneAddSacchi Or InclusioneAddContalitri Or InclusioneAcqua)
        '.Frame1(1).Visible = InclusioneViatop
        If (numeroviatop = 1) Then
            'in caso di 1 solo viatop è previsto sia incluso il Viatop o il Viatop Scarico Mixer1
            If (BilanciaViatopScarMixer1.Presenza) Then
                .FrameTr(31).left = 1725
            End If
        End If
        If (numeroviatop = 2) Then
            'in caso di 2 viatop è previsto sia incluso il Viatop e il Viatop Scarico Mixer2 oppure il Viatop Scarico Mixer1 e il Viatop Scarico Mixer2
            If (BilanciaViatopScarMixer1.Presenza And BilanciaViatopScarMixer2.Presenza) Then
                .FrameTr(31).left = 1725
                '20160512
                'CP240.FrameTr(32).left = 1845
                .FrameTr(32).left = .FrameTr(31).left + .FrameTr(31).width + 10
                '
                .Frame1(65).left = 1695
                .Frame1(35).left = 1665
                '.Frame1(1).left = 1660
            End If
            If (Not BilanciaViatopScarMixer1.Presenza And BilanciaViatopScarMixer2.Presenza) Then
                .FrameTr(32).left = 1845
                .Frame1(65).left = 1815
                .Frame1(35).left = 1665
                '.Frame1(1).left = 1715
            End If
        End If
    End With
End Sub
'20160420?


'20140620
Public Sub RefreshDatiFormNetti()

    Dim indice As Integer
    Dim BlendingB1_Perc As Double
    Dim BlendingB2_Perc As Double
    Dim BlendingB1_NettoKg As Double
    Dim BlendingB2_NettoKg As Double
    Dim BlendingB1_SetKg As Double
    Dim BlendingB2_SetKg As Double
    Dim BlendingB1_VoloKg As Double
    Dim BlendingB2_VoloKg As Double
    
'20140620
    'AGGREGATI
    For indice = 0 To 7
        FrmNetti.LblSetA(indice).caption = CStr(Round(DosaggioAggregati(indice).setCalcolato, 1))
        FrmNetti.LblNettoAgg(indice) = CStr(Round(NettoAgg(indice), 1))
        FrmNetti.LblNettiStampaA(indice) = CStr(Round(NettoAggregatiBuffer(indice), 1))
        FrmNetti.LblResAgg(indice).caption = CStr(Round(VoloAggregati(indice), 1))
    Next indice
            
    'FILLER
    For indice = 0 To 2
        FrmNetti.LblSetFiller(indice).caption = CStr(Round(DosaggioFiller(indice).setCalcolato, 1))
        FrmNetti.LblNettoFiller(indice) = CStr(Round(NettoFiller(indice), 1))
        '20151123
        'FrmNetti.LblNettiStampaA(indice) = CStr(Round(NettoFillerBuffer(indice), 1))
        FrmNetti.LblNettiStampaf(indice) = CStr(Round(NettoFillerBuffer(indice), 1))
        '
        FrmNetti.LblResFiller(indice).caption = CStr(Round(VoloFiller(indice), 1))
    Next indice
            
    'BITUME 1 e 2
    If CP240.OPCData.items(PLCTAG_AbilitaBlendingBitume).Value And Bitume2InBlending Then
        BlendingB1_Perc = RoundNumber(CP240.AdoDosaggio.Recordset.Fields("Bitume1").Value, 2)
        BlendingB2_Perc = RoundNumber(CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value, 2)
        If BlendingB1_Perc <> 0 Or BlendingB2_Perc <> 0 Then
            BlendingB1_NettoKg = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            BlendingB2_NettoKg = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            If DosaggioInCorso Then
                BlendingB1_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
                BlendingB2_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            Else
                BlendingB1_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
                BlendingB2_SetKg = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            End If
            BlendingB1_VoloKg = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
            BlendingB2_VoloKg = RoundNumber(CP240.OPCData.items(PLCTAG_ResiduoBitume1).Value, 1)
            FrmNetti.LblNettiStampaB12(0).caption = RoundNumber(NettoBitumeBuffer(0) * BlendingB1_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
            FrmNetti.LblNettiStampaB12(1).caption = RoundNumber(NettoBitumeBuffer(0) * BlendingB2_Perc / (BlendingB1_Perc + BlendingB2_Perc), 1)
        Else
            BlendingB1_SetKg = 0
            BlendingB2_SetKg = 0
            BlendingB1_NettoKg = 0
            BlendingB2_NettoKg = 0
            BlendingB1_VoloKg = 0
            BlendingB1_VoloKg = 0
            FrmNetti.LblNettiStampaB12(0).caption = "0"
            FrmNetti.LblNettiStampaB12(1).caption = "0"
        End If
                
        FrmNetti.LblSetB12(0).caption = BlendingB1_SetKg
        FrmNetti.LblNettoB12(0).caption = BlendingB1_NettoKg
        FrmNetti.LblResBit(0).caption = BlendingB1_VoloKg
        FrmNetti.LblSetB12(1).caption = BlendingB2_SetKg
        FrmNetti.LblNettoB12(1).caption = BlendingB2_NettoKg
        FrmNetti.LblResBit(1).caption = BlendingB2_VoloKg
    
    Else
        If Not BitumeGravita Then
            'Bitume1
            If DosaggioInCorso Then
                FrmNetti.LblSetB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
            Else
                FrmNetti.LblSetB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
            End If
            
            FrmNetti.LblNettoB12(0).caption = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
            FrmNetti.LblResBit(0).caption = CStr(Round(VoloBitume(0), 1))
            FrmNetti.LblNettiStampaB12(0).caption = CStr(Round(NettoBitumeBuffer(0), 1))
    
            'Gestione di 3 bitumi in scambio, in pratica ho la gestione di un solo bitume
            'Bitume2
            If (InclusioneBitume2 And Not AbilitaSelettoreBitume1) Then
                If Not CP240.AdoDosaggio.Recordset.EOF Then
                    If (CSng(CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value) > 0) Then
                        If DosaggioInCorso Then
                            FrmNetti.LblSetB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
                        Else
                            FrmNetti.LblSetB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
                        End If
                        FrmNetti.LblNettoB12(1).caption = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
                        FrmNetti.LblResBit(1).caption = CStr(Round(VoloBitume(1), 1))
                        FrmNetti.LblNettiStampaB12(1).caption = CStr(Round(NettoBitumeBuffer(0), 1))
                        
                        FrmNetti.LblSetB12(0).caption = "0"
                        FrmNetti.LblNettoB12(0).caption = "0"
                        FrmNetti.LblResBit(0).caption = "0"
                        FrmNetti.LblNettiStampaB12(0).caption = "0"
                    Else
                        FrmNetti.LblSetB12(1).caption = "0"
                        FrmNetti.LblNettoB12(1).caption = "0"
                        FrmNetti.LblResBit(1).caption = "0"
                        FrmNetti.LblNettiStampaB12(1).caption = "0"
                    End If
                End If
            End If
            'Bitume3
            If (InclusioneBitume3) Then
                If Not CP240.AdoDosaggio.Recordset.EOF Then
                    If (CSng(CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value) > 0) Then
                        If DosaggioInCorso Then
                            FrmNetti.LblSetB12(3).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1).Value, 1)
                        Else
                            FrmNetti.LblSetB12(3).caption = RoundNumber(CP240.OPCData.items(PLCTAG_SetBitume1_DosaggioStop).Value, 1)
                        End If
                        FrmNetti.LblNettoB12(3).caption = RoundNumber(CP240.OPCData.items(PLCTAG_NettoBitume1).Value, 1)
                        FrmNetti.LblResBit(3).caption = CStr(Round(VoloBitume(3), 1))
                        FrmNetti.LblNettiStampaB12(3).caption = CStr(Round(NettoBitumeBuffer(0), 1))
                        FrmNetti.LblSetB12(0).caption = "0"
                        FrmNetti.LblNettoB12(0).caption = "0"
                        FrmNetti.LblResBit(0).caption = "0"
                        FrmNetti.LblNettiStampaB12(0).caption = "0"
                    Else
                        FrmNetti.LblSetB12(3).caption = "0"
                        FrmNetti.LblNettoB12(3).caption = "0"
                        FrmNetti.LblResBit(3).caption = "0"
                        FrmNetti.LblNettiStampaB12(3).caption = "0"
                    End If
                End If
            End If
        Else
            'Bitume1
            FrmNetti.LblSetB12(0).caption = CStr(RoundNumber(CP240.OPCData.items(PLCTAG_GravitaSetB1Kg).Value, 1))
            FrmNetti.LblNettoB12(0).caption = CStr(RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB1Kg).Value, 1))
            FrmNetti.LblResBit(0).caption = CStr(Round(VoloBitume(0), 1))
            FrmNetti.LblNettiStampaB12(0).caption = CStr(Round(NettoBitumeBuffer(0), 1))
            'Bitume2
            FrmNetti.LblSetB12(1).caption = CStr(RoundNumber(CP240.OPCData.items(PLCTAG_GravitaSetB2Kg).Value, 1))
            FrmNetti.LblNettoB12(1).caption = CStr(RoundNumber(CP240.OPCData.items(PLCTAG_GravitaNettoB2Kg).Value, 1))
            FrmNetti.LblResBit(1).caption = CStr(VoloBitume(1))
            FrmNetti.LblNettiStampaB12(1).caption = CStr(Round(NettoBitumeBuffer(1), 1))
        End If
        
    End If
    
    'BITUME 3 e 4(wam foam)
    
    If PlcSchiumato.Abilitazione Then
    
        If DosaggioInCorso Then
            FrmNetti.LblSetB12(4).caption = CStr(RoundNumber(CP240.OPCDataSchiumato.items(SetImpulsiBitume_idx).Value, 1))
            FrmNetti.LblSetB12(3).caption = CStr(RoundNumber(CP240.OPCDataSchiumato.items(SetImpulsiBSoft_idx).Value, 1))
        Else
            FrmNetti.LblSetB12(4).caption = CP240.LblTrSetPeso(CompLeganteHard).caption
            FrmNetti.LblSetB12(3).caption = CP240.LblTrSetPeso(CompLeganteSoft).caption
        End If
    End If
                
    'RICICLATO
    FrmNetti.LblSetR(0).caption = CStr(Round(DosaggioRAPSiwa.setCalcolato, 0))
    FrmNetti.LblNettoRic(0).caption = CStr(Round(NettoRAPSiwa, 0))
    FrmNetti.LblNettiStampaR(0).caption = CStr(Round(NettoRAPSiwaBuffer, 0))
    FrmNetti.LblResRic(0).caption = CStr(Round(VoloRiciclatoSiwa, 0))
    FrmNetti.LblSetR(1).caption = CStr(Round(DosaggioRAP.setCalcolato, 0))
    FrmNetti.LblNettoRic(1).caption = CStr(Round(NettoRAP, 0))
    FrmNetti.LblNettiStampaR(1).caption = CStr(Round(NettoRAPBuffer, 0))
    FrmNetti.LblResRic(1).caption = CStr(Round(VoloRiciclato, 0))

'

End Sub

'20160729
Private Sub RefreshRicettaAquablack()
    
    With CP240.AdoDosaggioNext.Recordset
        If Not .EOF Then
            AquablackRecipeNext.PercentageH2O = Null2Qualcosa(.Fields("AquablackSet").Value)
            AquablackRecipeNext.BitumenSelection = Null2Qualcosa(.Fields("AquablackSelezioneBitume").Value)
            AquablackRecipeNext.BitumenMinFlow = Null2Qualcosa(.Fields("AquablackFlussoMin").Value)
            AquablackRecipeNext.ToleranceH2O = Null2Qualcosa(.Fields("AquablackTolleranza").Value)
            AquablackRecipeNext.BitumenDisch2Steps = Null2Qualcosa(.Fields("AquablackEn2Step").Value)
        End If
    End With

End Sub
'

'20161104
Public Sub StatusCalibrazioneBilPN()
    
    If Not FrmTaraBilancePN.Visible Then
        Exit Sub
    End If
    
    With FrmTaraBilancePN
    
        BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_NONE
        
        .LblWorking.Visible = BilanciaPnCmdRun Or BilanciaPnErrore

'&H0000FF00& verde
        If BilanciaPnErrore Then
            .LblWorking.BackColor = vbRed
            .LblCalibration.caption = UCase(LoadXLSString(292))
        ElseIf BilanciaPnCmdRun Then
            .LblWorking.BackColor = vbGreen
            .LblCalibration.caption = UCase(LoadXLSString(1424))
        Else
            .LblWorking.BackColor = vbWhite
        End If
        
        '.LblWorking.BackColor = IIf(BilanciaPnCmdRun, vbYellow, &H8000000F)
    
        .CmdTare.enabled = (Not BilanciaPnCmdRun)
        .CmdCalibrate.enabled = (Not BilanciaPnCmdRun)
        .BtnReset.enabled = (Not BilanciaPnCmdRun)

    End With

End Sub
'

'20161122
Public Sub AggiornaGraficaFlomac_Change()

    CP240.Frame1(16).BackColor = IIf(BilanciaStatus(IDAdditivoFlomac).DosaggioAttivo, &HFF00&, &H808080)
    
    If BilanciaStatus(IDAdditivoFlomac).DosaggioAttivo Then
        BilanciaStatus(IDAdditivoFlomac).FinePesata = True
    End If

End Sub

'20161122
Public Function AdditivoFlomacInserito() As Boolean
'Se ho l'additivo flomac restituisco TRUE
    
    AdditivoFlomacInserito = (CP240.AdoDosaggio.Recordset.Fields("AddFlomac").Value = 1)
    
End Function
'

Public Sub StartDosaggio()

    On Error GoTo Errore

    With CP240

        .AniPushButtonDeflettore(10).Value = 1
        PesaturaManuale = False
        Call CP240.AbilitaDosaggioManuale(True)
    
        .AbilitaInversionePCL
        Call .AbilitaDosaggioManuale(True)
        .LblKgDosaggio(2).caption = "XXXX"
        Call ResetVariabiliImpaManuali '20160920
        
        .ImgMotor(0).Visible = False
        
        Call PLCSchiumatoSetAutomaticoCiclo(Not PesaturaManuale)
    
        .AniPushButtonDeflettore(33).enabled = PesaturaManuale 'gestione auto/man del deflettore scarico bilancia rap nel mescolatore
        If Not PesaturaManuale Then
            .AniPushButtonDeflettore(32).enabled = False 'deflettore scarico bilancia rapSiwa nel mescolatore
            .AniPushButtonDeflettore(33).Value = 1
        End If
        '
    
        If PesaturaManuale Then
            Call CalcolaVelocitaInvertPesateFillerManuale
        End If
    
    '
        If ( _
            OraAltaTemperaturaScivolo > 0 And _
            ConvertiTimer() > OraAltaTemperaturaScivolo + TempoPermanenza_AllarmeTemperaturaScivolo _
        ) Then
            Call ShowMsgBox(LoadXLSString(193), vbOKOnly, vbExclamation, -1, -1, True)
            Exit Sub
        End If
    
        '20170124
        'QuantitaImpastoProdotto = 0
        QuantitaImpastoProdotto = JobAttivo.DosaggioPreset * CDbl(1000)
        '
    
        If Not ControlloCondizioniStartDosaggio Then
            '20170131
'            If JobAttivo.StatusVB <> EnumStatoJobVB.Idle Then
'                Call StopEmergenzaJob
'            End If
            '
            
            Exit Sub
        End If
    
        InviaStopDosaggio = False    'Tasto di Stop dosaggio premuto.
    
        TempoMixUmida(0) = 0
    
        .OPCData.items(PLCTAG_StartDosaggio).Value = True
        
        If .AdoDosaggioNext.Recordset.Fields("AquablackSet") > 0 Then
            Aquablack_HMI_PLC.FROM_HMI_Start = True
        End If
        
        FrmGestioneTimer.TimerAzzeraStartDosaggio.enabled = False
        FrmGestioneTimer.TimerAzzeraStartDosaggio.Interval = 3000
        FrmGestioneTimer.TimerAzzeraStartDosaggio.enabled = True
    
        ValoreTempoInizioCiclo = ConvertiTimer()
    
        Call CheckContenutoSili '20160218
    
    End With
    
    
    Exit Sub
	Errore:

    LogInserisci True, "DOS-069 ", "ApplicaJob : " + CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20170224
Public Sub PulsanteControlloPortineManuale(Optional automatico As Boolean)

    Dim statoauto As Boolean

    If automatico Or (DosaggioInCorso Or HardKeyRemoved Or PlusCommunicationBroken) Then
'        'forzatura stato in automatico
        statoauto = True
    
        CP240.AniPushButtonDeflettore(10).Value = IIf(statoauto, 1, 2)
        CP240.AniPushButtonDeflettore(10).enabled = Not statoauto
        Call DosaggioAutoMan(True)
    Else
        'lettura stato variabili
        'statoauto = (DosaggioInCorso Or HardKeyRemoved Or PlusCommunicationBroken)
        CP240.AniPushButtonDeflettore(10).enabled = True
    End If

End Sub

'20170224
Public Sub DosaggioAutoMan(auto As Boolean)

    With CP240
    
        PesaturaManuale = Not auto
        'CP240.AniPushButtonDeflettore(10).Value = IIf(auto, 1, 2)
        'CP240.AniPushButtonDeflettore(10).enabled = Not auto
                
        Call CP240.AbilitaInversionePCL
        Call CP240.AbilitaDosaggioManuale(True)
        .LblKgDosaggio(2).caption = "XXXX"
'        Call ResetVariabiliImpaManuali '20160920
        Call AbilitaPulsantiPortineMan(Not auto) '20170301
    
        .ImgMotor(0).Visible = False
    
        Call PLCSchiumatoSetAutomaticoCiclo(Not PesaturaManuale)
    
        .AniPushButtonDeflettore(33).enabled = PesaturaManuale 'gestione auto/man del deflettore scarico bilancia rap nel mescolatore
        If Not PesaturaManuale Then
            .AniPushButtonDeflettore(32).enabled = False 'deflettore scarico bilancia rapSiwa nel mescolatore
            .AniPushButtonDeflettore(33).Value = 1
        End If
        '
    
        If PesaturaManuale Then
            Call RefreshPbarNettoPesate '20170302
            Call CalcolaVelocitaInvertPesateFillerManuale
        End If
    End With


End Sub

'20170301
Public Sub LeggiNettiParziali()

        If BilanciaAggregati.CompAttivo >= 0 Then
            Call MemPesiAggManEmergenzaDosaggio '20170301
            BilanciaAggregati.MemFronteDosaEmergPbarNetti = True  '20170301
            Call ResettaTimerAggregatiMan
        End If
        
        If BilanciaFiller.CompAttivo >= 0 Then
            Call MemPesiFillManEmergenzaDosaggio '20170301
            BilanciaFiller.MemFronteDosaEmergPbarNetti = True  '20170301
            Call ResettaTimerFillerMan
        End If
                
        If BilanciaLegante.CompAttivo >= 0 Then
            Call MemPesiBitManEmergenzaDosaggio '20170301
            BilanciaLegante.MemFronteDosaEmergPbarNetti = True  '20170301
            Call ResettaTimerBitumeMan
        End If
        
        If BilanciaViatop.CompAttivo >= 0 Then
            Call MemPesiViatopManEmergenzaDosaggio '20170301
            BilanciaViatop.MemFronteDosaEmergPbarNetti = True  '20170301
            Call ResettaTimerViatopMan
        End If

End Sub





