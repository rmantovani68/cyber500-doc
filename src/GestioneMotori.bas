Attribute VB_Name = "GestioneMotori"
Option Explicit

'   Gestione motori
Public Enum MotorManagementEnum
    AutomaticMotor = 1
    SemiAutomaticMotor
    ForcingMotor
    CoolingTime '20161017
    AutomaticStop   '20161017
    SemiAutomaticMotorOn '20161020
    ForcingMotorOn '20161020
End Enum
Public MotorManagement As MotorManagementEnum

Public Enum MotorSequenceEnum
    StartAutoMotor = 4
    StartAutoMotor1
    StartAutoMotor2
    StartAutoMotor3
    StartAutoMotor4
    StopAutoMotor
End Enum

Public MotorSequence As MotorSequenceEnum
Public SequenzaInCorso As Boolean
'20151130
Public TimeoutSequenzaInCorso As Long       'Tempo in secondi di timeout
Public TmrTimeoutSequenzaInCorso As Long    'Start del conteggio (o stop se = 0)
'
Public SirenaInCorso As Boolean

Public MotorManagementPlcAutomatic As Boolean
Public MotorManagementPlcSemiAutomatic As Boolean
Public MotorManagementPlcForcing As Boolean

Public MotorManagementPlcOutSirena As Boolean
Public MotorPrenotaAvvCaldo As Boolean

Public MotorManagementPlcCountDownMaxNv As Integer
Public MotorManagementPlcCountDownPausaSirena As Integer
Public MotorManagementPlcCountDownLavoroSirena As Integer
Public MotorManagementPlcMotoreAvviamentoSpegnimento As Integer
Public MotorManagementPlcCountDownMotoreAvviamento As Integer
Public MotorManagementPlcCountDownMotoreSpegnimento As Integer
Public MotoreForzato As Integer
Public primotrasferimentoparametri As Boolean
Public DustfixEnable As Boolean '20151020
Public TermicaDustfix As Boolean '20150731
Public PompaDustfix As Boolean '20150731
Public MixerDustfix As Boolean '20150731

'   Numero di motori gestibili
Public Enum MotoriEnum

    MotoreCompressore = 1

    MotorePCL

    MotorePCL2

    MotoreAspiratoreFiltro

    MotoreMescolatore

    MotoreAspiratoreVaglio

    MotoreVaglio

    MotoreElevatoreCaldo

    MotoreCocleaRitorno

    '10
    MotoreElevatoreF1

    MotoreCoclea123         'Coclea recupero

    MotoreCocleaEstrazioneFillerRecupero

    MotoreCocleaPreseparatrice

    MotoreElevatoreF2

    MotoreCocleaEstrazioneFillerApporto

    MotoreCocleaFiltro

    MotoreRotazioneEssiccatore

    MotorePompaCombustibile

    MotoreVentolaBruciatore

    '20
    MotoreNastroElevatoreFreddo

    MotoreNastroCollettore1

    MotoreNastroCollettore2

    MotorePCL3

    MotoreNastroTrasportatoreRiciclato

    MotoreNastroCollettoreRiciclato

    MotoreArganoBenna

    MotoreVentolaViatop

    MotoreElevatoreRiciclato

    MotoreNastroCollettoreRiciclatoFreddo

    '30
    MotoreNastroTrasportatoreRiciclatoFreddo 'ex MotoreVaglioRiciclatoFreddo

    MotoreVaglioInerti

    MotoreNastroLanciatore

    MotoreNastroAuxRiciclato

    MotoreCompressoreBruciatore     '= 34

    MotorePompaAltaPressione        '= 35

    MotorePompaEmulsione            '= 36

    MotoreNastroCollettore3         '= 37

    MotoreNastroRapJolly            '= 38

    MotoreRotazioneEssiccatore2     '= 39

    MotorePompaCombustibile2        '= 40

    MotoreVentolaBruciatore2        '= 41

    MotorePompaAltaPressione2       '= 42

    MotoreCompressoreBruciatore2    '= 43
    '

    MotoreNastroBypassEssicatore    '= 44

    MotoreTrasportoFillerizzazioneFiltro    '= 45

    MotoreFillerizzazioneFiltroRecupero     '= 46

    MotoreFillerizzazioneFiltroApporto      '= 47
    
    MotoreCoclea123_2         'Coclea recupero 2 =48
    
    MotoreCoclea123_3         'Coclea recupero 2 =49
    
    MotoreCoclea123_4         'Coclea recupero 2 =50
    
    MotoreCoclea123_5         'Coclea recupero 2 =51
    
    MotoreCocleaPreseparatrice_2         'Coclea preseparatrice 2 =52
    
    MotoreCocleaPreseparatrice_3         'Coclea preseparatrice 2 =53
    
    MotoreCocleaPreseparatrice_4         'Coclea preseparatrice 2 =54
       
    MotoreCocleaPreseparatrice_5         'Coclea preseparatrice 2 =55
    
    MotoreCocleaEstrazioneFillerApporto2     'Coclea Estrazione F3 = 56 20151218
    
    MotoreUltimo

End Enum

Public Const MAXMOTORI As Integer = MotoreUltimo - 1
Public Const MAXNEWMOTORS As Integer = 100

Public Type MotorePausaLavoro
    'Deve essere gestita la pausa/lavoro
    abilitato As Boolean

'    'Il motore è stato "nominalmente" acceso (non vuol dire, però, che abbia fisicamente l'uscita
'    AvvioTempoPausaLavoro As Boolean
'    'Motore fisicamente acceso alle ore...
'    OraStartTempoPausaLavoro As Long
'    'Motore fisicamente spento alle ore...
'    OraStopTempoPausaLavoro As Long

    'Tempo di permanenza del motore acceso
    TempoPausa As Integer
    'Tempo di permanenza del motore spento
    TempoLavoro As Integer
End Type

'   Struttura contenente tutte le informazioni di un motore
Public Type MotoreType

    presente As Boolean

    Descrizione As String

    'ex uscita. Adesso si tratta del comando "non automatico"
    ComandoManuale As Boolean
    'comando invertito
    ComandoInversione As Boolean
    
    ritorno As Boolean
    RitornoReale As Boolean
    RitornoIndietro As Boolean
    ForzatoDarwin As Boolean
    'Bitmask di allarmi
    allarme As Integer

    AllarmeTimeoutAvvio As Boolean
    AllarmeNessunRitorno As Boolean
    AllarmeTermica As Boolean
    AllarmeTimeoutArresto As Boolean
    AllarmeSicurezza As Boolean
    AllarmeSlittamentoMotore As Boolean

    'Motore bloccato da PLC
    blocco As Boolean

    'Motore forzatamente acceso da PLC
    ForzAccesoPLC As Boolean
    'Motore forzatamente spento da PLC
    ForzSpentoPLC As Boolean

    '   Ora in cui è stato dato lo start al motore
    oraStart As Long
    '   Secondi di attesa del ritorno
    tempoAttesaRitorno As Long
    '   Secondi di start
    tempoStart As Long
    '   Secondi di stop
    tempoStop As Long

    '   Flag per non accendere il motore all'avvio automatico
    offStart As Boolean

    '   Flag per non spegnere il motore allo spegnimento automatico
    onStop As Boolean

    '   Motore asservito (0 = se stesso)
    asservimento As Integer

    '   In verità vi dico che contengono minuti, non ore
    MinutiLavoroParz As Long
    MinutiLavoroTot As Long
    MinutiLavoroUltimoControllo As Long
    
    SecondiLavoroAppoggio As Long 'Appoggio per il conteggio delle ore di lavoro dei motori con funzionamento temporizzato

    '   Ottimizzazione per salvataggio lento

    pausaLavoro As MotorePausaLavoro

    uscitaAnalogica As Integer
    
    '   Flag per inserire il motore in una lista di avviamento automatico ridotto
    EsclusioneConAvviamentoRidotto As Boolean
    '   Flag per dire se la lista dove il motore è stato inserito è anche selezionata da parte dell'utente
    EsclusioneSelezionata As Boolean
    '   Serve per discriminare l'esclusione del motore fra i vari gruppi di esclusione
    GruppoEsclusione As Integer
    
    InverterPresente As Boolean
    '20150625
    SoftStarterPresente As Boolean
    '
    
    tempoRitAllSlittamento As Long

    SoloVisualizzazione As Boolean

'20150422
    OraStartAllSlittamentoMotore As Long
'

    amperometro As Boolean

    '20161020
    GestioneInternaSlittamento  As Boolean
    Soglia1Slittamento  As Double
    TempoSoglia1Slittamento As Long
    Soglia2Slittamento As Double
    TempoSoglia2Slittamento As Long
    '20161020
End Type

Public ListaMotori(1 To MAXNEWMOTORS) As MotoreType

Public OrdineAvviamentoMotori(1 To MAXNEWMOTORS) As Integer
Public OrdineSpegnimentoMotori(1 To MAXNEWMOTORS) As Integer
Public VaglioIncluso As Boolean
Public VaglioEscluso As Boolean
Public InclusioneTramoggiaTamponeF1 As Boolean
Public InclusioneTramoggiaTamponeF2 As Boolean
Public ForzaturaPCL As Boolean
Public tempoAttesaMotOn As Long
Public ScattoTermicaCocleaPesataF1 As Boolean
Public ScattoTermicaCocleaPesataF2 As Boolean
Public ArrestoMotoriEmergenza As Boolean
'

Public Enum FuelType
    CombustibileGas
    CombustibileGasolio
    CombustibileOlioCombustibile
End Enum

Public Type TamburoType

    temperaturaScivolo As Long
    depressioneBruciatore As Long
    setTemperaturaScivolo As Long

    EsclusioneAvviamentoCaldo As Boolean
    
    TempoArrestoBrucAttivo As Boolean
    DepressioneBrucTemp As Long
    DepressioneBrucCont As Long
    TemperaturaScivoloTemp As Long
    TemperaturaScivoloCont As Long
    InPreriscaldo As Boolean
    ComandoAccensioneBruciatore As Boolean
    MemoriaAccensioneBruciatore As Boolean
    AvviamentoBruciatoreCaldo As Boolean
    FiammaBruciatorePresente As Boolean
    BloccoFiammaBruciatore As Boolean
    TempoStopBruciatore As Long
    ConteggioSecondiSpegniBruciatore As Long
    OraStartBruciatore As Long
    StartBruciatoreDaPLC As Boolean
    posizioneModulatoreBruciatoreNN As Integer 'NN = Non Normalizzato
    posizioneModulatoreBruciatore As Long
    posizioneModulatoreBruciatorePrecisa As Single '20170323
    posizioneModulatoreBruciatoreNNPrecisa As Single 'NN = Non Normalizzato
    ChiusuraModulatore As Boolean
    ModulatoreBrucOnUp As Boolean
    ModulatoreBrucOnDown As Boolean
    BruciatoreAutomatico As Boolean
    '20161230 ImpulsoStartCorrModulatore As Boolean
    '20161230 PassaggioSingolo As Boolean '<<------------------------- NB!

    'SelezioneCombustibile(0 To 1) As Boolean
    SelezioneCombustibile As FuelType
    SelezioneCombustibileName As String '20170327

    BruciatorePosizioneAccensione As Boolean
    BruciatoreInAccensione As Boolean
    MinDepressioneBruciatore As Long    'Valore letto da file
    MaxDepressioneBruciatore As Long    'Valore letto da file
    OraStartPompaCombustibile As Long
    ArrestaBrucFineConteggio As Boolean
    BruciatoreModulatoreApertura As Boolean
    BruciatoreModulatoreChiusura As Boolean
    AllarmePerditaValvoleBruc As Boolean
    AllarmePerditaValvoleBrucOC As Boolean
    OlioCombInTemperatura As Boolean
    AllarmePressioneBrucAlta As Boolean
    SicurezzaTempOlioComb As Boolean
    PressioneInsufficienteOlioCombustibile As Boolean

    '   Consumo di combustibile
    AbilitazioneConsumoCombustibile As Boolean
    ImpulsiContalitriCombustibile As Long
    ImpulsiPerLitroCombustibile As Double
    LitriCombustibileUtilizzati As Double
    PartenzaLitriCombustibileUtilizzati As Double
    ParzialeLitriCombustibile As Double
    IdCombustibileLOG As Integer '20151204

    MinimoModulatoreTamburo As Integer
    MassimoModulatoreTamburo As Integer
    MassimoFSDeprimometroTamburo As Long
    
    ModulatoreFumiTamburo As ModulatoreType

    '20161230 OkCorrezionePID As Boolean

    OraStartVentolaBruciatore As Long
    MemPosModulatoreAvvioCaldo As Integer
    MemPortaModBrucASetAvvCaldo As Boolean

    TemperatCriticaFumiTamburoOUT As Long
    TempoAllTemperatCriticaFumiTamburoOUT As Long
    SicurezzaTemperaturaFumiTamburoOUT As Boolean
    DeflettoreAntincendioTamburoAperto As Boolean
    OraSicurezzaTemperaturaFumiTamburoOUT As Long
    SuperamentoSogliaAllarmeFumiTamburo As Boolean

    NumeroLetturaDepressioneBruciatore As Integer
    ValoreLettoModulatoreFumiTamburoNN As Integer 'NN = Non Normalizzato
    ArrayLettureScivoloTamburo(1 To 30) As Long '30 letture
    NumeroLetturaScivoloTamburo As Integer

    '20161230
    'BRUCIATORE AUTOMATICO
    BAP_GuadDiffTemp As Double          'Guad.Differ. Di Temperatura
    BAP_GuadAmplMod As Double           'Guad. Ampl. Modulatore
    BAP_GuadDiffUmidita As Double       'Guad.Differ. Di Umidità
    BAP_RitRegModVerg As Long           'Ritardo Di Regol. Modul. Su Vergini
    BAP_AntRegModRicicl As Long         'Anticipo Di Regol. Modul. Su Riciclato
    BAP_AttesaSuRegolSucc As Long       'Tempo Di Risposta Alle Variaz.Di Temp.
    BAP_LimiteMinDiTempPerCorr As Long  'Tempo di attraversamento tamburo
    BAP_UMediaAlTest As Double          'Umidità Media Al Test
    BAP_TempEssAlTest As Long           'Temperatura Al Test
    BAP_TempStartUscEssic As Long       'Temp. 1* Accens. Uscita Essicc.
    BAP_PercIncrPrimaAccens As Double   '% Incremento 1* Accensione
    BAP_CorrManSetPosMod As Double

    BAP_RapportoPortataModulatore(0 To 2, 0 To 10) As Double  'ogni posizione è un 10% (0, 10%, 20%, ... 100%)

    BA_TollTempUscEssPerSegnAll As Double   'PARAMETRO?

    BA_TimerRegBruciatore As Long

    BA_DurataImpulsoUscitaRegMod As Long
    BA_AperturaTemporanea As Boolean
    BA_TimerApertura As Long
    BA_TimerOutIncrBruc As Long
    BA_ChiusuraTemporanea As Boolean
    BA_TimerChiusura As Long
    BA_TimerOutDecrBruc As Long

    BA_All_141 As Boolean 'TODO

    BA_PosizioneSetModulatore As Double
    BA_PosizioneSetModulatoreTotale As Double

    BA_TimerAttesaRegolSucc As Long
    BA_TimerPartenzaRic As Long
    BA_TimerRifTempoAttravTamb As Long '20170323

    BA_DiffPercDiTempSetEReale As Double
    BA_portataTotaleSetPredVergERicicl As Double

    BA_ValThPrVerg(0 To 1001) As Double
    BA_ValThPrRicicl(0 To 1001) As Double

    BA_LavTmpRicPrd As Double 'Valore usato per fare in modo che se vario il set di temperatura, reinizzializzo il tempo di controllo

    BA_diffPercDiUmiditaTraTestESet As Double
    BA_UmPercIstantTotVergERicicl As Double
    '
    FiammaPosLeft As Long  '20170322
    FiammaWith As Long  '20170322
End Type

Public SpegnimentoCaldoInCorso As Boolean   '20160302

Public ListaTamburi(0 To 1) As TamburoType
Public FrmMotoriVisibile As Boolean
Public NastroRapJollyVersoFreddo As Boolean

Public Enum AvviamentoMotoriRidottoEnum
    AvviamentoMotoriCompleto = -1
    AvviamentoMotoriNoTamburoPrincipale = 0
    AvviamentoMotoriNoTamburoParallelo = 1
    AvviamentoMotoriNoRiciclatoFreddo = 2

    AvviamentoMax = 3
End Enum

Public SelezioneFormTipoAvvMotori As VbMsgBoxResult

Public GruppoAvviamentoSelezionato(0 To AvviamentoMax - 1) As Boolean

Public NessunRidottoSelezionato As Boolean

Public NumeroCocleeRecupero As Integer
Public NumeroCocleePreseparatore As Integer
Public AbilitaDeflettoreMulino As Boolean
Public AssorbimentoMixer As Integer

Public ComandoValvolaTSF As Boolean
Public ValvolaTSFAperta As Boolean

Public EvacuazFiltroErrore As Boolean
Public ValvolaTSFErrore As Boolean

Public connessionestatoOK As Boolean

'20161014
Public Enum StatusMotori '20161014
    StatusManuale = 0
    StatusInArresto
    StatusTempoAttesaCooling
    StatusRunning
    StatusForzatura
End Enum
'


Public Sub MotoreRitornoTermica(motore As Integer)

    Dim Criterio As String
    Dim posizione As Integer
    Dim StopPredosatori As Boolean
    Dim CriterioSicurezza As String


    With ListaMotori(motore)

        Select Case motore
            Case MotoreAspiratoreFiltro
                ControlloPuliziaFiltro

            Case MotoreMescolatore
                'Dosaggio in start automatico and Mixer fermo
                If (DosaggioInCorso And Not .ritorno) Then
                    If Not ArrestoUrgenza Then  'Se non ho già inviato lo stop emergenza
                        Call ArrestoEmergenzaDosaggio
                    End If
                End If

        End Select

        Call IngressoAllarmePresente(DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "ST" + Format(motore, "000"), "IdDescrizione"), .AllarmeTermica And .presente)

        '20160926
        If (.allarme <> 0) And (motore = MotoreForzato) Then
            MotoreForzato = 0
        End If
        '
        
        Select Case motore
            Case MotoreNastroElevatoreFreddo
                CriterioSicurezza = "SI038"
                StopPredosatori = True
            Case MotoreNastroCollettore1
                CriterioSicurezza = "SI039"
                If (PredosatoriAccesi(False, 0)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroCollettore2
                CriterioSicurezza = "SI040"
                If (PredosatoriAccesi(False, 1)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroCollettore3
                CriterioSicurezza = "SI071"
                If (PredosatoriAccesi(False, 2)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroTrasportatoreRiciclato
                CriterioSicurezza = "SI041"
                If (PredosatoriAccesi(True, 0)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroCollettoreRiciclato
                CriterioSicurezza = "SI042"
                If (PredosatoriAccesi(True, 0)) Then
                    StopPredosatori = True
                End If
            Case MotoreElevatoreRiciclato
                CriterioSicurezza = "SI043"
                If (PredosatoriAccesi(True, 1)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroCollettoreRiciclatoFreddo, MotoreNastroTrasportatoreRiciclatoFreddo
                CriterioSicurezza = "SI044"
                If (PredosatoriAccesi(True, 1)) Then
                    StopPredosatori = True
                End If
            Case MotoreVaglioInerti
                CriterioSicurezza = ""
            Case MotoreNastroLanciatore
                CriterioSicurezza = ""
            Case MotoreNastroAuxRiciclato
                CriterioSicurezza = "SI010"
                If (PredosatoriAccesi(True, -1)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroRapJolly
                CriterioSicurezza = "SI072"
                If (PredosatoriAccesi(True, 2)) Then
                    StopPredosatori = True
                End If
            Case MotoreNastroBypassEssicatore
                CriterioSicurezza = "SI048"
                If (PredosatoriAccesi(True, 0)) Then
                    StopPredosatori = True
                End If

        End Select

        If (CriterioSicurezza <> "") Then
            Call IngressoAllarmePresente(DlookUpExt("IndirizzoPLC", "CodificaAllarmi", CriterioSicurezza, "IdDescrizione"), .AllarmeSicurezza)
            If ((.AllarmeSicurezza Or .AllarmeTermica) And PredosatoriAutomaticoOn And StopPredosatori) Then
                Call PulsanteStopPred
            End If
        End If

        Call MotoreAggiornaGrafica(motore)

    End With

End Sub

Public Sub MotoreSicurezza_change(motore As Integer)

    Call MotoreRitornoTermica(motore)

End Sub

'Fronte Ritorno Virtuale (avanti e indietro)
Public Sub MotoreRitorno_change(motore As Integer)

    On Error GoTo Errore

    Call MotoreAggiornaGrafica(motore)

    Exit Sub
Errore:
    LogInserisci True, "MOT-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Fronte Ritorno Reale
Public Sub MotoreRitornoReale_change(motore As Integer)
    On Error GoTo Errore

    Call MotoreAggiornaGrafica(motore)
    
    Exit Sub
Errore:
    LogInserisci True, "MOT-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'La routine imposta il ritorno virtuale e sul fronte aggiorna il sinottico
Public Sub SetMotoreRitorno(motore As Integer, valore As Boolean)

    On Error GoTo Errore

    If (ListaMotori(motore).ritorno <> valore) Then
    
        ListaMotori(motore).ritorno = valore
        
        '20170206 se la ricetta di predosaggio accende i nastri Riciclato commuto il deflettore a Tamburo
        If (valore) Then
            If (motore = MotoreNastroTrasportatoreRiciclato Or motore = MotoreNastroCollettoreRiciclato) Then
                If AutomaticoPredosatori And Not AbilitaDeflettoreAnelloElevatoreRic Then
                    Call SetDeflettoreRiciclato(Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno))
                End If
            End If
        End If
        '20170206
        
        Call CP240.GestioneDirezioneJolly '20161212
        If (MotorManagement = AutomaticMotor And Not ArrestoMotoriEmergenza) Then
            Call NMSetMotoreUscita(motore, ListaMotori(motore).ritorno)
        End If
        
        Call MotoreAggiornaGrafica(motore)

        If FrmInversionePCLVisibile Then
            Call AbilitaPulsFormInversione
        End If
        
        With ListaMotori(motore)
            If (Not .presente) Or .SoloVisualizzazione Then
                Exit Sub
            End If
            Select Case motore
                Case MotoreAspiratoreFiltro
                    If (.ritorno And Not ManualeModulFiltro) Then
                        'Se il filtro è appena stato acceso lo passo in manuale.
                        'Lo riporto in automatico dopo il tempo di accensione del filtro impostato dai parametri
                        Call ManualeFiltroManiche
                        Call ResettaTimerGestioneFiltro
                        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
                    End If
                '20160512
                Case MotoreNastroTrasportatoreRiciclato, MotoreNastroCollettoreRiciclato
                    If (Not AbilitaDeflettoreAnelloElevatoreRic And Not ValvolaPreseparatoreAnello.abilitato) Then
                        Call SetDeflettoreRiciclato(Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno))
                    End If
                '
            End Select
        End With
        '20160126
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'La routine imposta il ritorno reale e sul fronte aggiorna il sinottico
Public Sub SetMotoreRitornoReale(motore As Integer, valore As Boolean)

    On Error GoTo Errore

    If (ListaMotori(motore).RitornoReale <> valore) Then
        ListaMotori(motore).RitornoReale = valore
        '20170202
        If (motore = MotoreRotazioneEssiccatore And valore) Then
            If (GestioneVelocitaTamburo.inclusione) Then
                CP240.OPCData.items(PLCTAG_GEST_VEL_TAMB_Trasf_DefaultVal).Value = True
            End If
            FrmGestioneTimer.TimerResetTrasfVelDef.enabled = True
        End If
        '20170202
        Call MotoreAggiornaGrafica(motore)
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-017", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'La routine imposta il ritono virtuale e sul fronte aggiorna il sinottico
Public Sub SetMotoreRitornoIndietro(motore As Integer, valore As Boolean)

    On Error GoTo Errore

    If (ListaMotori(motore).RitornoIndietro <> valore) Then
        ListaMotori(motore).RitornoIndietro = valore
        Call CP240.GestioneDirezioneJolly '20161212
        Call MotoreAggiornaGrafica(motore)
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-013", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'La routine imposta i bit di allarme motore e sul fronte aggiorna il sinottico (nel caso in cui siano aperti i form di inversione
'PCL o TestPred invoca una routine di controllo condizioni)
Public Sub SetMotoreAllarme(motore As Integer, valore As Integer)

    Dim SingoloByte As Byte

    On Error GoTo Errore

    If (ListaMotori(motore).allarme <> valore) Then
        ListaMotori(motore).allarme = valore

        With ListaMotori(motore)
            SingoloByte = .allarme

            .AllarmeTimeoutAvvio = IsBitSet(SingoloByte, 0)
            .AllarmeNessunRitorno = IsBitSet(SingoloByte, 1)
            .AllarmeTermica = IsBitSet(SingoloByte, 2)
            .AllarmeTimeoutArresto = IsBitSet(SingoloByte, 3)
            .AllarmeSicurezza = IsBitSet(SingoloByte, 4)
            .AllarmeSlittamentoMotore = IsBitSet(SingoloByte, 5)
        End With
        'aggiorno CP240
        MotoreAggiornaGrafica (motore)
        'update nel caso di inversione PCL
        If (FrmInversionePCLVisibile) Then
            If (valore > 0) Then
                Select Case motore
                Case 2
                    'motore PCL
                    FrmInversionePCL.ControllaPCL (1)
                Case 3
                    'motore PCL2
                    FrmInversionePCL.ControllaPCL (2)
                Case 23
                    'motore PCL3
                    FrmInversionePCL.ControllaPCL (3)
                End Select
            End If
        End If
        'update nel caso di inversione PCL
        If (FrmTestPredosatoriVisible) Then
            If (valore > 0) Then
                Select Case motore
                Case 21
                    'motore PCL
                    FrmTestPredosatori.ControllaNastri (motore)
                Case 22
                    'motore PCL2
                    FrmTestPredosatori.ControllaNastri (motore)
                Case 37
                    'motore PCL3
                    FrmTestPredosatori.ControllaNastri (motore)
                End Select
            End If
        End If
        
        Call MotoreRitornoTermica(motore)
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-014", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Blocco del motore per forzature PLC, allarme o asservimento
Public Sub SetMotoreBlocco(motore As Integer, valore As Boolean)

    On Error GoTo Errore

    If (ListaMotori(motore).blocco <> valore) Then
        ListaMotori(motore).blocco = valore

        'se il motore è anche acceso forzato significa che la forzatura di accendi ha avuto effetto e devo allineare sinottico e form motori
        If (ListaMotori(motore).ForzAccesoPLC And valore) Then
            Call NMSetMotoreUscita(motore, True)
            Call MotoreAggiornaGrafica(motore)
        End If
        
        CP240.ImgMotor(motore).enabled = (Not ListaMotori(motore).blocco)
        If (FrmMotoriVisibile) Then
            AvvMotori.APButtonStartStopMotore(motore - 1).enabled = (Not ListaMotori(motore).blocco)
            '20170223
            Call AvvMotori.CambioMod
            '
        End If
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "MOT-015", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Sul fronte della forzatura da plc
'se il motore è anche bloccato significa che la forzatura di accendi ha avuto effetto e devo allineare sinottico e form motori
Public Sub SetMotoreForzatoAcceso(motore As Integer, valore As Boolean)

    On Error GoTo Errore
    
    If (ListaMotori(motore).ForzAccesoPLC <> valore) Then
        ListaMotori(motore).ForzAccesoPLC = valore

'Debug.Print "ForzAccesoPLC(" + CStr(motore) + ") = " + CStr(ListaMotori(motore).ForzAccesoPLC)
        If (ListaMotori(motore).presente And ListaMotori(motore).blocco And ListaMotori(motore).ForzAccesoPLC) Then
            If (valore And ListaMotori(motore).presente And ListaMotori(motore).blocco And ListaMotori(motore).ForzAccesoPLC) Then
                Call NMSetMotoreUscita(motore, True)
            End If
            Call MotoreAggiornaGrafica(motore)
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-016", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Sul fronte della forzatura da plc tolgo il comando del pc e aggiorno il sinottico
Public Sub SetMotoreForzatoSpento(motore As Integer, valore As Boolean)

    On Error GoTo Errore

    If (ListaMotori(motore).ForzSpentoPLC <> valore) Then
        ListaMotori(motore).ForzSpentoPLC = valore
        
        If (ListaMotori(motore).presente And ListaMotori(motore).ForzSpentoPLC) Then
            If (valore And ListaMotori(motore).presente And ListaMotori(motore).ForzSpentoPLC) Then
                Call NMSetMotoreUscita(motore, False)
                Call NMSetMotoreUscitaInv(motore, False)    '20161212
            End If

            Call MotoreAggiornaGrafica(motore)
        End If
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "MOT-019", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function MotoreAcceso(motore As Integer) As Boolean

    With ListaMotori(motore)

        MotoreAcceso = (.RitornoReale)
        
        If ( _
            (.SoloVisualizzazione And .RitornoReale) Or _
            (MotorManagement = MotorManagementEnum.ForcingMotor And (MotoreForzato = motore) And SirenaInCorso) Or _
            (MotorManagement = MotorManagementEnum.ForcingMotor And .RitornoReale And Not SirenaInCorso) Or _
            (MotorManagement = MotorManagementEnum.SemiAutomaticMotor And .ComandoManuale And SirenaInCorso) Or _
            (MotorManagement = MotorManagementEnum.SemiAutomaticMotor And .RitornoReale And Not SirenaInCorso) Or _
            (MotorManagement = MotorManagementEnum.AutomaticMotor And .RitornoReale) _
        ) Then
            MotoreAcceso = True
        Else
            MotoreAcceso = False
        End If

    End With

End Function


Public Function MotoreCocleaPreseparatriceAcceso() As Boolean

    MotoreCocleaPreseparatriceAcceso = False

    If ( _
        (ListaMotori(MotoreCocleaPreseparatrice).presente And MotoreAcceso(MotoreCocleaPreseparatrice)) Or _
        (ListaMotori(MotoreCocleaPreseparatrice_2).presente And MotoreAcceso(MotoreCocleaPreseparatrice_2)) Or _
        (ListaMotori(MotoreCocleaPreseparatrice_3).presente And MotoreAcceso(MotoreCocleaPreseparatrice_3)) Or _
        (ListaMotori(MotoreCocleaPreseparatrice_4).presente And MotoreAcceso(MotoreCocleaPreseparatrice_4)) Or _
        (ListaMotori(MotoreCocleaPreseparatrice_5).presente And MotoreAcceso(MotoreCocleaPreseparatrice_5)) _
    ) Then
        MotoreCocleaPreseparatriceAcceso = True
    End If

End Function

'20161213
Public Function MotoreCocleaPreseparatriceErrore() As Boolean

    MotoreCocleaPreseparatriceErrore = False

    With ListaMotori(MotoreCocleaPreseparatrice)
        If (MotoreCocleaPreseparatriceErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaPreseparatriceErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With
    
    With ListaMotori(MotoreCocleaPreseparatrice_2)
        If (MotoreCocleaPreseparatriceErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaPreseparatriceErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

    With ListaMotori(MotoreCocleaPreseparatrice_3)
        If (MotoreCocleaPreseparatriceErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaPreseparatriceErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

    With ListaMotori(MotoreCocleaPreseparatrice_4)
        If (MotoreCocleaPreseparatriceErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaPreseparatriceErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

    With ListaMotori(MotoreCocleaPreseparatrice_5)
        If (MotoreCocleaPreseparatriceErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaPreseparatriceErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

End Function
'

Public Function MotoreCocleaRecuperoAcceso() As Boolean

    MotoreCocleaRecuperoAcceso = False

    If ( _
        (ListaMotori(MotoreCoclea123).presente And MotoreAcceso(MotoreCoclea123)) Or _
        (ListaMotori(MotoreCoclea123_2).presente And MotoreAcceso(MotoreCoclea123_2)) Or _
        (ListaMotori(MotoreCoclea123_3).presente And MotoreAcceso(MotoreCoclea123_3)) Or _
        (ListaMotori(MotoreCoclea123_4).presente And MotoreAcceso(MotoreCoclea123_4)) Or _
        (ListaMotori(MotoreCoclea123_5).presente And MotoreAcceso(MotoreCoclea123_5)) _
    ) Then
        MotoreCocleaRecuperoAcceso = True
    End If

End Function

'20161213
Public Function MotoreCocleaRecuperoErrore() As Boolean

    MotoreCocleaRecuperoErrore = False

    With ListaMotori(MotoreCoclea123)
        If (MotoreCocleaRecuperoErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaRecuperoErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With
    
    With ListaMotori(MotoreCoclea123_2)
        If (MotoreCocleaRecuperoErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaRecuperoErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

    With ListaMotori(MotoreCoclea123_3)
        If (MotoreCocleaRecuperoErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaRecuperoErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

    With ListaMotori(MotoreCoclea123_4)
        If (MotoreCocleaRecuperoErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaRecuperoErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

    With ListaMotori(MotoreCoclea123_5)
        If (MotoreCocleaRecuperoErrore Or Not .presente) Then
            Exit Function
        End If
        MotoreCocleaRecuperoErrore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
    End With

End Function
'

'Aggiorna la grafica del form motori e sinottico
Public Sub MotoreAggiornaGrafica(motore As Integer)

    Dim Errore As Boolean
    Dim acceso As Boolean
    Dim spento As Boolean
    Dim risorsa As String
    Dim tamburo As Integer
    Dim Index As Integer


    With ListaMotori(motore)

        If (Not .presente) Then
            Exit Sub
        End If

        Errore = (.AllarmeTermica Or .AllarmeSicurezza Or .AllarmeNessunRitorno Or .AllarmeTimeoutArresto Or .AllarmeTimeoutAvvio)
        acceso = MotoreAcceso(motore)
        spento = (Not acceso And Not Errore)

        Select Case motore

            Case MotoreCompressore, MotoreCompressoreBruciatore, MotoreCompressoreBruciatore2
                risorsa = IIf(Errore, "IDB_COMPRESSOREERRORE", IIf(acceso, "IDB_COMPRESSOREON", "IDB_COMPRESSORE"))

            Case MotorePCL, MotorePCL2, MotorePCL3, MotorePompaAltaPressione, MotorePompaAltaPressione2, MotorePompaEmulsione
                risorsa = IIf(Errore, "IDB_POMPAERRORE", IIf(acceso, "IDB_POMPAON", "IDB_POMPA"))

            Case MotoreAspiratoreFiltro
                If (InclusioneDMR) Then
                    risorsa = IIf(Errore, "IDB_FILTRODMRERRORE", IIf(acceso, "IDB_FILTRODMRON", "IDB_FILTRODMR"))
                Else
                    risorsa = IIf(Errore, "IDB_FILTROERRORE", IIf(acceso, "IDB_FILTROON", "IDB_FILTRO"))
                End If

            Case MotoreMescolatore
                risorsa = IIf(Errore, "IDB_MESCOLATOREERRORE", IIf(acceso, "IDB_MESCOLATOREON", "IDB_MESCOLATORE"))

            Case MotoreAspiratoreVaglio
                risorsa = IIf(Errore, "IDB_ASPIRATOREERRORE", IIf(acceso, "IDB_ASPIRATOREON", "IDB_ASPIRATORE"))

            Case MotoreVaglio
                risorsa = IIf(Errore, "IDB_VAGLIOERRORE", IIf(acceso, "IDB_VAGLIOON", "IDB_VAGLIO"))

            Case MotoreElevatoreCaldo, MotoreElevatoreF1, MotoreElevatoreF2, MotoreElevatoreRiciclato
                risorsa = IIf(Errore, "IDB_ELEVATOREERRORE", IIf(acceso, "IDB_ELEVATOREON", "IDB_ELEVATORE"))

            Case MotoreCocleaRitorno, MotoreCocleaFiltro, MotoreFillerizzazioneFiltroRecupero, MotoreFillerizzazioneFiltroApporto
                risorsa = IIf(Errore, "IDB_COCLEAERRORE", IIf(acceso, "IDB_COCLEAON", "IDB_COCLEA"))

            Case MotoreCoclea123, MotoreCoclea123_2, MotoreCoclea123_3, MotoreCoclea123_4, MotoreCoclea123_5
                acceso = MotoreCocleaRecuperoAcceso()
                '20161213
                Errore = MotoreCocleaRecuperoErrore()
                '
                risorsa = IIf(Errore, "IDB_COCLEAERRORE", IIf(acceso, "IDB_COCLEAON", "IDB_COCLEA"))
                CP240.ImgMotor(100 + MotoreCoclea123).Picture = LoadResPicture(risorsa, vbResBitmap)

            Case MotoreCocleaPreseparatrice, MotoreCocleaPreseparatrice_2, MotoreCocleaPreseparatrice_3, MotoreCocleaPreseparatrice_4, MotoreCocleaPreseparatrice_5
                acceso = MotoreCocleaPreseparatriceAcceso()
                '20161213
                Errore = MotoreCocleaPreseparatriceErrore()
                '
                risorsa = IIf(Errore, "IDB_COCLEAERRORE", IIf(acceso, "IDB_COCLEAON", "IDB_COCLEA"))

                CP240.ImgMotor(100 + MotoreCocleaPreseparatrice).Picture = LoadResPicture(risorsa, vbResBitmap)
                CP240.ImgMotor(200 + MotoreCocleaPreseparatrice).Picture = LoadResPicture(IIf(Errore, "IDB_PRESEPARATOREERRORE", IIf(acceso, "IDB_PRESEPARATOREON", "IDB_PRESEPARATORE")), vbResBitmap)

            Case MotoreCocleaEstrazioneFillerRecupero
                risorsa = IIf(Errore, "IDB_COCLEAERRORE", IIf(acceso, "IDB_COCLEAON", "IDB_COCLEA"))
                Call SiloFillerEstrazione(0, (.ritorno))
            Case MotoreCocleaEstrazioneFillerApporto
                risorsa = IIf(Errore, "IDB_COCLEAERRORE", IIf(acceso, "IDB_COCLEAON", "IDB_COCLEA"))
                Call SiloFillerEstrazione(1, .ritorno)
'20151221
            Case MotoreCocleaEstrazioneFillerApporto2
                risorsa = IIf(Errore, "IDB_COCLEAERRORE", IIf(acceso, "IDB_COCLEAON", "IDB_COCLEA"))
                Call SiloFillerEstrazione(2, .ritorno)
'
            
            '20170322
            Case MotoreRotazioneEssiccatore, MotoreRotazioneEssiccatore2
                If (motore = MotoreRotazioneEssiccatore2) Then
                    tamburo = 1
                    CP240.Image1(77).Visible = (ListaTamburi(tamburo).FiammaBruciatorePresente)  'Fiamma on
                    CP240.Image1(78).Visible = (ListaTamburi(tamburo).BruciatoreInAccensione And Not ListaTamburi(tamburo).FiammaBruciatorePresente) 'Preventilazione
                    CP240.Image1(79).Visible = (ListaTamburi(tamburo).BloccoFiammaBruciatore) 'Blocco bruciatore
                Else
                    tamburo = 0
                    CP240.Image1(74).Visible = (ListaTamburi(tamburo).FiammaBruciatorePresente)  'Fiamma on
                    CP240.Image1(75).Visible = (ListaTamburi(tamburo).BruciatoreInAccensione And Not ListaTamburi(tamburo).FiammaBruciatorePresente) 'Preventilazione
                    CP240.Image1(76).Visible = (ListaTamburi(tamburo).BloccoFiammaBruciatore) 'Blocco bruciatore
                End If

                Call DimensionaFiamma(tamburo)

'                If (Errore) Then
'                    risorsa = "IDB_TAMBUROERRORE"
''20150610
''                ElseIf (ListaTamburi(TamburoAssociatoAlPID).AvviamentoBruciatoreCaldo And MotoriInAutomatico And ListaTamburi(TamburoAssociatoAlPID).FiammaBruciatorePresente) Then
'                ElseIf (ListaTamburi(TamburoAssociatoAlPID).AvviamentoBruciatoreCaldo And ListaTamburi(TamburoAssociatoAlPID).FiammaBruciatorePresente) Then
''
'                    'risorsa = "IDB_TAMBUROONFIAMMAON"
'                    risorsa = "IDB_TAMBUROON" '20170321
'                ElseIf (acceso) Then
'                    If (ListaTamburi(tamburo).BloccoFiammaBruciatore) Then
'                        risorsa = "IDB_TAMBUROONFIAMMA"
'                    ElseIf (ListaTamburi(tamburo).FiammaBruciatorePresente) Then
'                        risorsa = "IDB_TAMBUROONFIAMMAON"
'                    ElseIf (ListaTamburi(tamburo).BruciatoreInAccensione And Not ListaTamburi(tamburo).FiammaBruciatorePresente) Then
'                        risorsa = "IDB_TAMBUROONPREVENTILAZIONE"
'                    Else
'                        risorsa = "IDB_TAMBUROON"
'                    End If
'                Else
'                    If (ListaTamburi(tamburo).BloccoFiammaBruciatore) Then
'                        risorsa = "IDB_TAMBUROFIAMMA"
'                    ElseIf (ListaTamburi(tamburo).FiammaBruciatorePresente) Then
'                        risorsa = "IDB_TAMBUROFIAMMA"
'                    ElseIf (ListaTamburi(tamburo).BruciatoreInAccensione And Not ListaTamburi(tamburo).FiammaBruciatorePresente) Then
'                        risorsa = "IDB_TAMBUROPREVENTILAZIONE"
'                    Else
'                        risorsa = "IDB_TAMBURO"
'                    End If
'                End If

'20170322
                If (Errore) Then
                    risorsa = "IDB_TAMBUROERRORE"
                ElseIf ListaMotori(motore).ritorno Then
                    risorsa = "IDB_TAMBUROON"
                Else
                    risorsa = "IDB_TAMBURO"
                End If

                If tamburo = 1 Then
                    risorsa = risorsa + "_TP"   'Utilizzo bitmap differenti per tamburo parallelo
                End If

'                If (motore = MotoreRotazioneEssiccatore2) Then
'                    risorsa = risorsa + "_TP"   'Utilizzo bitmap differenti per tamburo parallelo
'                End If
'fine 20170322


            Case MotorePompaCombustibile, MotorePompaCombustibile2
                risorsa = IIf(Errore, "IDB_POMPAERRORE", IIf(acceso, "IDB_POMPAON", "IDB_POMPA"))

                tamburo = IIf(motore = MotorePompaCombustibile, 0, 1)
                ListaTamburi(tamburo).OraStartPompaCombustibile = IIf(.ritorno, ConvertiTimer(), 0)

            Case MotoreVentolaBruciatore, MotoreVentolaBruciatore2
                risorsa = IIf(Errore, "IDB_VENTOLABRUCERRORE", IIf(acceso, "IDB_VENTOLABRUCON", "IDB_VENTOLABRUC"))

                If (motore = MotoreVentolaBruciatore2) Then
                    risorsa = risorsa + "_TP"   'Utilizzo bitmap differenti per tamburo parallelo
                End If

            Case MotoreNastroElevatoreFreddo, MotoreNastroLanciatore, MotoreNastroCollettore1, MotoreNastroCollettore2, MotoreNastroCollettore3
                risorsa = IIf(Errore, "IDB_NASTROERRORE", IIf(acceso, "IDB_NASTROON", "IDB_NASTRO"))

            Case MotoreNastroAuxRiciclato, MotoreNastroTrasportatoreRiciclato, MotoreNastroTrasportatoreRiciclatoFreddo, MotoreNastroRapJolly, MotoreNastroBypassEssicatore
                risorsa = IIf(Errore, "IDB_NASTROERRORE", IIf(acceso, "IDB_NASTROON", "IDB_NASTRO"))

            Case MotoreNastroCollettoreRiciclato, MotoreNastroCollettoreRiciclatoFreddo
                If ((MotoreNastroCollettoreRiciclato And ShowHotRecyScreen) Or (MotoreNastroCollettoreRiciclatoFreddo And ShowColdRecyScreen)) Then 'Nastro + Vaglio
                    risorsa = IIf(Errore, "IDB_VAGLIETTINOERRORE", IIf(acceso, "IDB_VAGLIETTINOON", "IDB_VAGLIETTINO"))
                Else 'Nastro + Nastro
                    risorsa = IIf(Errore, "IDB_NASTROERRORE", IIf(acceso, "IDB_NASTROON", "IDB_NASTRO"))
                End If

            Case MotoreArganoBenna
                risorsa = IIf(Errore, "IDB_ARGANOERRORE", IIf(acceso, "IDB_ARGANOON", "IDB_ARGANO"))

            Case MotoreVentolaViatop
                risorsa = IIf(Errore, "IDB_VENTOLAVIATOPERRORE", IIf(acceso, "IDB_VENTOLAVIATOPON", "IDB_VENTOLAVIATOPOFF"))

            Case MotoreVaglioInerti
                risorsa = IIf(Errore, "IDB_VAGLIETTINOERRORE", IIf(acceso, "IDB_VAGLIETTINOON", "IDB_VAGLIETTINO"))

            Case MotoreTrasportoFillerizzazioneFiltro
                risorsa = IIf(Errore, "IDB_ASPIRATOREERRORE", IIf(acceso, "IDB_ASPIRATOREON", "IDB_ASPIRATORE"))
            Case Else
                '   Motore non ancora previsto
                Debug.Assert False
                Exit Sub

        End Select

        CP240.ImgMotor(100 + motore).Picture = LoadResPicture(risorsa, vbResBitmap)

    End With

    
    If (DEBUGGING) Then
        If (FrmMotoriVisibile) Then
            Call AvvMotori.DebugMotore(motore)
        End If
    End If

    If (FrmMotoriVisibile) Then
        Call AvvMotori.VisualizzaMotoreAcceso(motore)
    End If


    Call CP240StatusBar_Change(STB_STATOMOTORI, MotorManagement) '20161020


End Sub
Public Sub MotoreUscita_change(motore As Integer, Optional CambioStato_per_PausaLavoro As Boolean)

    Dim Criterio As String
    Dim posizione As Integer
    Dim tamburo As Integer


    With ListaMotori(motore)
        If (Not .presente) Or .SoloVisualizzazione Then
            Exit Sub
        End If

        Select Case motore

            Case MotoreCompressore

            Case MotorePCL
                Call ArrestoPCLInDosaggio

            Case MotorePCL2
                Call ArrestoPCLInDosaggio

            Case MotoreAspiratoreFiltro
                If (.ritorno And Not ManualeModulFiltro) Then
                    'Se il filtro è appena stato acceso lo passo in manuale.
                    'Lo riporto in automatico dopo il tempo di accensione del filtro impostato dai parametri
                    Call ManualeFiltroManiche
                    Call ResettaTimerGestioneFiltro
                    ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
                End If

            Case MotoreMescolatore
                Call ControlloMixerDosaggioStart
                If (Not ScaricoMescolatoreForzato) Then
                    CP240.CmdScarica(ScarichiEnum.ScaricoMescolatoreOn).enabled = (PesaturaManuale And Not .ritorno)
                End If

            Case MotoreAspiratoreVaglio

            Case MotoreVaglio

            Case MotoreElevatoreCaldo

            Case MotoreCocleaRitorno

            Case MotoreElevatoreF1

            Case MotoreCoclea123

            Case MotoreCocleaEstrazioneFillerRecupero

            Case MotoreCocleaPreseparatrice

            Case MotoreElevatoreF2
                If (.ritorno) Then
                    'Quando accendo l'elevatore F2 se ho incluso il bindicator F3 faccio partire
                    'la coclea estrattrice F2 se in automatico
                    Call CocleaFillerApporto2DaAccendere(True)
                End If

            Case MotoreCocleaEstrazioneFillerApporto
                If (.ritorno And Not CocleaFillerApportoDaAccendere(False)) Then
                    Call SetMotoreUscita(motore, False)
                    Exit Sub
                End If

            Case MotoreCocleaFiltro
                If (.ritorno And Not CocleaFillerRecuperoDaAccendere(False)) Then
                    Call SetMotoreUscita(motore, False)
                    Exit Sub
                End If

            Case MotoreRotazioneEssiccatore, MotoreRotazioneEssiccatore2

            Case MotorePompaCombustibile

            Case MotoreVentolaBruciatore

            Case MotoreNastroElevatoreFreddo
                
                If (ConfigPortataNastroInerti = schedaSiwarex) Then
                    If (.ritorno) Then
                        CodiceComandoSiwarex = 106  'Attiva totalizzazione
                    Else
                        CodiceComandoSiwarex = 101  'Disattiva totalizzazione
                    End If
                    Call AttivaComandoSiwarex(SiwarexNastroInerti)
                End If

            Case MotoreNastroCollettore1

            Case MotoreNastroCollettore2

            Case MotorePCL3

                Call ArrestoPCLInDosaggio

            Case MotoreNastroTrasportatoreRiciclato 'N. Trasp. Ric.
                
                If (ConfigPortataNastroRiciclato = schedaSiwarex) Then
                    If (.ritorno) Then
                        CodiceComandoSiwarex = 106  'Attiva totalizzazione
                    Else
                        CodiceComandoSiwarex = 101  'Disattiva totalizzazione
                    End If
                    Call AttivaComandoSiwarex(SiwarexNastroRiciclatoCaldo)
                End If

            Case MotoreNastroCollettoreRiciclato 'N. Coll. Ric.

            Case MotoreArganoBenna

            Case MotoreVentolaViatop

            Case MotoreElevatoreRiciclato

            Case MotoreNastroCollettoreRiciclatoFreddo
            Case MotoreNastroTrasportatoreRiciclatoFreddo
            Case MotoreVaglioInerti
            Case MotoreNastroLanciatore
            Case MotoreNastroAuxRiciclato
            Case MotoreCompressoreBruciatore
            Case MotorePompaAltaPressione
            
            Case MotorePompaEmulsione
                Call ArrestoPCLInDosaggio
            
            Case MotoreNastroCollettore3
            Case MotoreNastroRapJolly
            Case MotorePompaCombustibile2
            Case MotoreVentolaBruciatore2
            Case MotoreCompressoreBruciatore2
            Case MotorePompaAltaPressione2
            Case MotoreNastroBypassEssicatore
            Case MotoreTrasportoFillerizzazioneFiltro, MotoreFillerizzazioneFiltroRecupero, MotoreFillerizzazioneFiltroApporto

            Case Else
                '   Motore non ancora previsto
                Debug.Assert False
                Exit Sub

        End Select

        Call MotoreAggiornaGrafica(motore)

        'CYBERTRONIC_PLUS
        Dim inStart As Boolean
        Dim motoreIndex As Integer
        
        If (ListaMotori(motore).ritorno) Then
            inStart = True
        Else
            inStart = False
            For motoreIndex = 1 To MAXMOTORI
                With ListaMotori(motoreIndex)
                    If (.presente And .ritorno) Then
                        inStart = True
                        Exit For
                    End If
                End With
            Next motoreIndex
        End If
        
        Call SendMessagetoPlus(PlusSendMotorInstart, IIf(inStart, 1, 0))

        If (DEMO_VERSION) Then
            Call SetMotoreRitorno(motore, .ComandoManuale)
        End If

    End With

End Sub

'Comandi per la nuova gestione motori
Public Sub NMSetMotoreUscita(ByVal motore As Integer, valore As Boolean)
    '20161212
    If (motore = MotoreNastroRapJolly And NastroRapJollyVersoFreddo) Then
        Call NMSetMotoreUscitaInv(motore, valore)
        If (valore) Then
            Exit Sub
        End If
    End If
    '20161212
    With ListaMotori(motore)
        If (Not .presente) Or .SoloVisualizzazione Then
            Exit Sub
        End If

       .ComandoManuale = valore
    End With

End Sub

'Comandi Invertiti per la nuova gestione motori
Public Sub NMSetMotoreUscitaInv(ByVal motore As Integer, valore As Boolean)
    With ListaMotori(motore)
        If (Not .presente) Or .SoloVisualizzazione Then
            Exit Sub
        End If

       .ComandoInversione = valore
    End With
End Sub

'Comandi per la nuova gestione motori
Public Sub NMSetMotoreForzato(ByVal motore As Integer)
    If (motore = 0) Then
        'Azzeramento del motore attualmente forzato...non deve controllare esiste perché non esiste!
        MotoreForzato = motore
        Exit Sub
    End If

    With ListaMotori(motore)
        If (Not .presente) Or .SoloVisualizzazione Then
            Exit Sub
        End If

        MotoreForzato = motore
    End With
End Sub

'La routine imposta lo stato di forzato con sistema Darwin
Public Sub SetMotoreForzatoDarwin(motore As Integer, valore As Boolean)

    On Error GoTo Errore

    If (ListaMotori(motore).ForzatoDarwin <> valore) Then
        ListaMotori(motore).ForzatoDarwin = valore
        Call MotoreAggiornaGrafica(motore)
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'La routine è diventata inefficace per l'accensione dei motori perchè .ComandoManuale  è stato commentato
'Non è ancora stata tolta perchè è rimasto qualche richiamo in giro e perchè la routine gestisce un deflettore riciclato
Public Sub SetMotoreUscita(ByVal motore As Integer, valore As Boolean, Optional CambioStato_per_PausaLavoro As Boolean)

    On Error GoTo Errore

    If (MotorManagement = AutomaticMotor) Then
        'Il set all'uscita si può dare solo in "non automatico"
 '       Call MsgBox("SetMotoreUscita(" + CStr(motore) + ") in automatic mode", vbOKOnly + vbCritical, CAPTIONSTARTSIMPLE)
 '.Debug.Assert (MotorManagement <> AutomaticMotor)
        Exit Sub
    End If

    With ListaMotori(motore)
        If (valore And (.AllarmeTermica Or .AllarmeSicurezza)) Or .SoloVisualizzazione Then
            MotoreAggiornaGrafica motore
        Else

            If (.ComandoManuale <> valore) Then
                
                If Not ConsensoStartPCL3 And (motore = MotorePCL3) Then
                    valore = False
                    Call ShowMsgBox(LoadXLSString(292) & " - " & LoadXLSString(666), vbOKOnly, vbExclamation, -1, -1, False)
                End If
                
                If motore = MotorePCL3 And PlcSchiumato.Abilitazione Then
                    With CP240.OPCDataSchiumato
                        If .IsConnected Then
                            .items(DO_Pompa_Soft_Comando_idx).Value = valore
                        End If
                    End With
                End If
                '20170206
'                If (motore = MotoreNastroTrasportatoreRiciclato Or motore = MotoreNastroCollettoreRiciclato) Then
'                    If AutomaticoPredosatori And Not AbilitaDeflettoreAnelloElevatoreRic Then
'                        Call SetDeflettoreRiciclato(Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno))
'                    End If
'                End If
                '20170206
            End If

        End If

    End With
    
    Exit Sub
Errore:
    LogInserisci True, "MOT-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PulsanteManualePremuto()
    Dim indice As Integer

    Call SetMotorManagement(SemiAutomaticMotor)

    Call StopBruciatore(0)
    If (ParallelDrum) Then
        Call StopBruciatore(1)
    End If

    InviaStopDosaggio = True   'Tasto di Stop dosaggio premuto.

    CP240.CmdAvvMotori(2).enabled = True
    CP240.CmdAvvMotori(1).enabled = True

    'DISABILITA I PREDOSATORI.
    For indice = 0 To NumeroPredosatoriInseriti - 1
        PredosatoreManuale False, indice, False, False
    Next indice

    Call PulsanteStopPred

    For indice = 1 To MAXMOTORI
       ' Call SetMotoreUscita(indice, False)
       Call NMSetMotoreUscita(indice, False)
    Next indice

    Call SetMotorManagement(SemiAutomaticMotor)

    If PlcSchiumato.Abilitazione Then
        'Fermo la pompa acqua
        PLCSchiumatoManualePompaAcqua (False)
        FrmSchiumatura.ApbPompaAcqua.Value = 1
        PLCSchiumatoCircuitoAcqua
        
        'Fermo la pompa B.Hard
        PLCSchiumatoManualePompaBitume (False)
        FrmSchiumatura.ApbPompaBitume.Value = 1
        PLCSchiumatoCircuitoBitume
        
        'Fermo la pompa B.Soft
        If PlcSchiumato.abilitazioneSoft Then
            PLCSchiumatoManualePompaBitumeSoft (False)
            FrmSchiumatura.ApbPompaBitumeSoft.Value = 1
            PLCSchiumatoCircuitoBitumeSoft
        End If
    End If
    

    CP240.CmdAvvMotori(2).enabled = True
    CP240.CmdAvvMotori(1).enabled = True

End Sub


Public Sub RimettiAutomaticoMotori()

    Call SetMotorManagement(AutomaticMotor)

    '20161230 ResetPID = True

End Sub


Public Sub ControlloPuliziaFiltro()

    '   Pulizia del filtro
    FiltroInPulizia = (AbilitaPuliziaFiltro And ListaMotori(MotoreAspiratoreFiltro).ritorno And ((DepressioneFiltro >= MinDepressFiltro) Or (MinDepressFiltro = 0)))

End Sub


Public Sub AccendiVaglioCambioRicetta()
    Call CambioRicettaNVtoV
End Sub


Public Function CambioRicettaNVtoV() As Boolean

    With CP240.AdoDosaggioNext.Recordset
        If (Not .EOF) Then
            If (.Fields("Aggregato1") > 0 Or .Fields("Aggregato2") > 0 Or .Fields("Aggregato3") > 0 Or .Fields("Aggregato4") > 0 Or .Fields("Aggregato5") > 0 Or .Fields("Aggregato6") > 0) Then
                CambioRicettaNVtoV = True
            End If
        End If
    End With

    CP240.OPCData.items(PLCTAG_NM_RicettaVagliata).Value = CambioRicettaNVtoV

End Function

Public Sub ControlloMixerDosaggioStart()

On Error GoTo Errore

    If (DosaggioInCorso And Not ListaMotori(MotoreMescolatore).ritorno) Then

        Call ArrestoEmergenzaDosaggio

        Call AllarmeTemporaneo("XX126", True)

    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub GestioneVaglio()
    On Error GoTo Errore

    If (MotorManagementPlcCountDownMaxNv > 0) Then
        CP240.Image1(11).Visible = (Not CP240.Image1(11).Visible)
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub



'Controlli fatti a LOOP!
Public Sub ControlloAsservimenti()

	Dim i As Integer

    On Error GoTo Errore

    'CONTROLLI ANCHE IN MANUALE
    If (Not ListaTamburi(0).AvviamentoBruciatoreCaldo) Then
        If ( _
            Not ListaMotori(MotoreAspiratoreFiltro).ritorno Or _
            Not ListaMotori(MotoreRotazioneEssiccatore).ritorno Or _
            Not ListaMotori(MotoreElevatoreCaldo).ritorno _
        ) Then
            '   E' venuto a mancare un motore: stop del bruciatore
            Call StopBruciatoreTamburo(0)
        End If
    Else
        If ( _
            Not ListaMotori(MotoreAspiratoreFiltro).ritorno Or _
            Not ListaMotori(MotoreElevatoreCaldo).ritorno _
        ) Then
            '   E' venuto a mancare un motore: stop del bruciatore
            Call StopBruciatoreTamburo(0)
        End If
    End If
    If ( _
        ParallelDrum And _
        (Not ListaMotori(MotoreAspiratoreFiltro).ritorno Or _
         Not ListaMotori(MotoreRotazioneEssiccatore2).ritorno)) Then
'
        '   E' venuto a mancare un motore: stop del bruciatore
        Call StopBruciatoreTamburo(1)
    End If
    '

    If Not MotoriInAutomatico Then
        Exit Sub
    End If

    'Controllo l'asservimento dei Predosatori rispetto il Mescolatore
    If (AutomaticoPredosatori And ListaMotori(MotoreMescolatore).presente And Not ListaMotori(MotoreMescolatore).ritorno) Then
        Call PassaInManualePredosatori
    End If
    
    'Direttiva Pirazzini del 02/09/2010 in fase di analisi fascicolo tecnico e rischi con i consulenti
    If PressioneAriaInsufficente Then
        Call PassaInManualePredosatori
    End If

    'Controllo l'asservimento dei Predosatori rispetto la Coclea Filtro
    '   Il controllo che la coclea sia accesa serve solo nel caso non siano gestiti i livelli max
    If (AutomaticoPredosatori And Not InclusioneDMR And ListaMotori(MotoreCocleaFiltro).presente And Not ListaMotori(MotoreCocleaFiltro).ritorno And Not LivelloMaxF1 And Not LivelloMaxF2) Then
        Call PassaInManualePredosatori
    End If

    Exit Sub
Errore:
    LogInserisci True, "MOT-010", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub MotoriInAutomatico_change()

    Dim motore As Integer

    If (MotoriInAutomatico) Then
    Else
        CP240.Image1(28).Visible = False
    End If

    If (MotoriInAutomatico) Then
'20150704
'        AvvMotori.ChkAvvForzatoPCL.Value = False
'        Call BassaTempBitume(True)
'
        Call LivelloFillerRecupero_change
        Call LivelloFillerApporto_change
        Call LivelloFillerApporto2_change

        CP240.PctMotoriWorking.BackColor = vbGreen
    Else
        CP240.PctMotoriWorking.BackColor = vbRed
    End If
    
'20150704
'    AvvMotori.ChkAvvForzatoPCL.enabled = (Not MotoriInAutomatico And Not DosaggioInCorso)
'

    CP240.CmdStartStopGenerale(0).enabled = (Not MotoriInAutomatico)
    
    '20161003
    'CP240.CmdStartStopGenerale(1).enabled = MotoriInAutomatico
    CP240.CmdStartStopGenerale(1).enabled = (MotorManagement = AutomaticMotor) Or (MotorManagement = SemiAutomaticMotor)
    '20161003
           
    If PlcSchiumato.Abilitazione Then
        PLCSchiumatoSetAutomaticoMotori (MotoriInAutomatico)
    End If

End Sub


'20160226
Public Sub InizioAttesaStopAutomaticoMotori()
        
    FrmGestioneTimer.TmrAttesaFiltrofreddo.enabled = True
'20161014
'    CP240.StatusBar1.Panels(STB_STATOMOTORI).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
    Call CP240StatusBar_Change(STB_STATOMOTORI, MotorManagementEnum.CoolingTime)
'
    CP240.LblEtichetta(129).Visible = True
End Sub

'20160226
Public Sub FineAttesaStopAutomaticoMotori()
    
    AttesaFiltrofreddoFlipFlop = False
'20161017
'    CP240.StatusBar1.Panels(STB_STATOMOTORI).text = ""
'    CP240.StatusBar1.Panels(STB_STATOMOTORI).Picture = LoadResPicture("IDI_WORKING", vbResIcon)
    Call CP240StatusBar_Change(STB_STATOMOTORI, MotorManagementEnum.AutomaticStop)
'
    CP240.LblEtichetta(129).Visible = False

    FrmGestioneTimer.TmrAttesaFiltrofreddo.enabled = False
End Sub

'20160226
Public Sub AvvioStopAutomaticoMotori()
    Call PulsanteStopCicliDosaggio

    CP240.CmdAvvMotori(2).enabled = True
    CP240.CmdAvvMotori(1).enabled = True

    'Sequenza Spegnimento Motori
    Call SetMotorManagement(MotorSequenceEnum.StopAutoMotor)

'    Call CP240StatusBar_Change(STB_STATOMOTORI, MotorManagementEnum.AutomaticStop)  ' 20161020

    Call PulsanteStopPred
End Sub


'Routine che scrive i comandi alla nuova gestione motori
Public Sub SetMotorManagement(newMotorManagement As MotorManagementEnum)

    Dim motore As Integer

    If (MotorManagement <> newMotorManagement) Then
        'se c'è un cambio di modalità
        If (newMotorManagement = AutomaticMotor And PressioneAriaInsufficente) Then
            'Non c'è aria, non commuto in automatico
            AllarmeCicalino = True
            Call ShowMsgBox(NoAria, vbOKOnly, vbExclamation, -1, -1, True)
            AllarmeCicalino = False
            Exit Sub
        End If

        'Nel passaggio verso Forzatura spengo tutto
        If (newMotorManagement = ForcingMotor) Then
            For motore = 1 To MAXMOTORI
                With ListaMotori(motore)
                    If (.presente) Then
                        .ComandoManuale = False
                    End If
                End With
            Next motore
            Call NMSetMotoreForzato(0)
        End If
        
        'Nel passaggio da Forzatura ad altra modalità spengo tutto
        If (MotorManagement = ForcingMotor And newMotorManagement <> ForcingMotor) Then
            For motore = 1 To MAXMOTORI
                With ListaMotori(motore)
                    If (.presente) Then
                        .ComandoManuale = False
                    End If
                End With
            Next motore
            Call NMSetMotoreForzato(0)
        End If
        
        If (newMotorManagement < MotorSequenceEnum.StartAutoMotor) Then
            'Modalità da Form Motori con Selettori
            'MotorManagement = newMotorManagement
            CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdAutomatico).Value = (newMotorManagement = AutomaticMotor)
            CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdSemiAutomatico).Value = (newMotorManagement = SemiAutomaticMotor)
            CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdManutenzione).Value = (newMotorManagement = ForcingMotor)
        Else
            'Start/Stop Sequenze CP240
            If (newMotorManagement = MotorSequenceEnum.StartAutoMotor) Then
                CP240.OPCData.items(PLCTAG_NM_MOTORI_StartSequenza).Value = True
            End If
            If (newMotorManagement = MotorSequenceEnum.StartAutoMotor1) Then
                CP240.OPCData.items(PLCTAG_NM_MOTORI_AvviamentoRidotto).Value = True
                CP240.OPCData.items(PLCTAG_NM_MOTORI_GruppoAvviamentoRidotto).Value = 1
            End If
            If (newMotorManagement = MotorSequenceEnum.StartAutoMotor2) Then
                CP240.OPCData.items(PLCTAG_NM_MOTORI_AvviamentoRidotto).Value = True
               CP240.OPCData.items(PLCTAG_NM_MOTORI_GruppoAvviamentoRidotto).Value = 2
            End If
            If (newMotorManagement = MotorSequenceEnum.StartAutoMotor3) Then
                CP240.OPCData.items(PLCTAG_NM_MOTORI_AvviamentoRidotto).Value = True
                CP240.OPCData.items(PLCTAG_NM_MOTORI_GruppoAvviamentoRidotto).Value = 3
            End If
            If (newMotorManagement = MotorSequenceEnum.StartAutoMotor4) Then
                CP240.OPCData.items(PLCTAG_NM_MOTORI_AvviamentoRidotto).Value = True
                CP240.OPCData.items(PLCTAG_NM_MOTORI_GruppoAvviamentoRidotto).Value = 4
            End If
            If (newMotorManagement = MotorSequenceEnum.StopAutoMotor) Then
                CP240.OPCData.items(PLCTAG_NM_MOTORI_StopSequenza).Value = True
            End If
        End If
        
        If (CP240.OPCData.items(PLCTAG_NM_MOTORI_StartSequenza).Value Or CP240.OPCData.items(PLCTAG_NM_MOTORI_CmdAutomatico).Value) Then
            Call AvvioAutomaticoComandiAux
        End If

        ArrestoMotoriEmergenza = False

        '20160226
        Call FineAttesaStopAutomaticoMotori
        '
    End If
End Sub


'Routine che scrive i comandi alla nuova gestione motori
Public Sub UpdateManagement(newMotorManagement As MotorManagementEnum)

    'Modalità da Form Motori con Selettori
    MotorManagement = newMotorManagement
    
    'aggiorno la modalità
    Call MotorManagementPlc_change
    
    Call MotoriInAutomatico_change
            
    Call CP240.GestioneDirezioneJolly '20161212
End Sub


Public Sub MotorManagementPlc_change()

    Dim immagine As String
    Dim plcManagementString As String

    Select Case MotorManagement
        Case AutomaticMotor
            immagine = "PLUS_IMG_AUTOMATICO"
        Case SemiAutomaticMotor
            immagine = "PLUS_IMG_MANUALE"
        Case ForcingMotor
            immagine = "PLUS_IMG_MANUTENZMOT"
    End Select
    
    Call CP240StatusBar_Change(STB_STATOMOTORI, MotorManagement) '20161017
    
    CP240.ImgMotorManagement.Picture = CP240.PlusImageList(0).ListImages(immagine).Picture
    
    If (FrmMotoriVisibile) Then
        AvvMotori.UpdateManagement (MotorManagement)
    End If
    If (MotorManagementPlcAutomatic) Then
        plcManagementString = "AUTO"
    ElseIf (MotorManagementPlcSemiAutomatic) Then
        plcManagementString = "SEMI"
    ElseIf (MotorManagementPlcForcing) Then
        plcManagementString = "FRC"
    End If
    CP240.LblEtichetta(200).Visible = DEBUGGING
    CP240.LblEtichetta(200).caption = plcManagementString

    '20151130
    If (MotorManagementPlcSemiAutomatic Or MotorManagementPlcForcing) Then
        'Non si deve più controllare la sequenza
        TmrTimeoutSequenzaInCorso = 0
    End If
    '

End Sub

Public Sub MotorManagementPlcTroppoPienoNV_change()

    'Troppo pieno del N.V.
    CP240.Frame1(46).Visible = (MotorManagementPlcCountDownMaxNv > 0)
    CP240.LblEtichetta(70).caption = CStr(MotorManagementPlcCountDownMaxNv)

End Sub


Public Sub MotorManagementPlcSirena_change()

    'Sirena
'    CP240.ImgSiren.Visible = (MotorManagementPlcCountDownPausaSirena > 0 Or MotorManagementPlcCountDownLavoroSirena > 0)
    CP240.ImgSiren.Visible = SirenaInCorso
    If (MotorManagementPlcCountDownPausaSirena > 0) Then
        CP240.ImgSiren.Picture = CP240.PlusImageList(0).ListImages("PLUS_IMG_SIRENA_GRAY").Picture
    ElseIf (MotorManagementPlcCountDownLavoroSirena > 0) Then
        CP240.ImgSiren.Picture = CP240.PlusImageList(0).ListImages("PLUS_IMG_SIRENA").Picture
    End If

    '...Visible = MotorManagementPlcOutSirena ANDASSE!
    CP240.LblEtichetta(111).Visible = SirenaInCorso
'
    If (MotorManagementPlcCountDownPausaSirena > 0) Then
        CP240.LblEtichetta(111).caption = CStr(MotorManagementPlcCountDownPausaSirena)
        'CP240.LblEtichetta(111).BackColor = vbYellow
    ElseIf (MotorManagementPlcCountDownLavoroSirena > 0) Then
        CP240.LblEtichetta(111).caption = CStr(MotorManagementPlcCountDownLavoroSirena)
        'CP240.LblEtichetta(111).BackColor = vbRed
    End If

End Sub

'20151130
'Public Sub MotorManagementPlcCountDown_change()
Public Sub MotorManagementPlcCountDown_change(motoreChanged As Boolean)
	'

	'x debug
	'Debug.Print CStr(DateTime.Now) + ": " + CStr(MotorManagementPlcMotoreAvviamentoSpegnimento) + " " + CStr(MotorManagementPlcCountDownMotoreAvviamento) + " " + CStr(MotorManagementPlcCountDownMotoreSpegnimento)
	'

    On Error GoTo Errore

    'Start/stop motori
    CP240.Image1(28).Visible = (MotorManagementPlcCountDownMotoreAvviamento > 0 Or MotorManagementPlcCountDownMotoreSpegnimento > 0)
    CP240.LblMessaggioBruciatore(3).Visible = (MotorManagementPlcCountDownMotoreAvviamento > 0 Or MotorManagementPlcCountDownMotoreSpegnimento > 0)
    CP240.LblEtichetta(3).Visible = (MotorManagementPlcCountDownMotoreAvviamento > 0 Or MotorManagementPlcCountDownMotoreSpegnimento > 0)
    If (MotorManagementPlcMotoreAvviamentoSpegnimento > 0) Then
        CP240.LblEtichetta(3).caption = ListaMotori(MotorManagementPlcMotoreAvviamentoSpegnimento).Descrizione
    Else
        CP240.LblEtichetta(3).caption = ""
    End If

    If (MotorManagementPlcCountDownMotoreAvviamento > 0) Then
        CP240.LblMessaggioBruciatore(3).caption = CStr(MotorManagementPlcCountDownMotoreAvviamento)
    ElseIf (MotorManagementPlcCountDownMotoreSpegnimento > 0) Then
        CP240.LblMessaggioBruciatore(3).caption = CStr(MotorManagementPlcCountDownMotoreSpegnimento)
    End If

'20151214
    '20151130
'    If (SequenzaInCorso And motoreChanged And MotorManagementPlcMotoreAvviamentoSpegnimento > 0) Then
    If (SequenzaInCorso And Not motoreChanged And MotorManagementPlcMotoreAvviamentoSpegnimento > 0) Then
        Dim avviamento As Boolean
        
        avviamento = (MotorManagementPlcCountDownMotoreAvviamento > 0)
        
        'Uso come timeout il doppio dell'attesa del ritorno, considerando anche il ritardo allo start/stop
        With ListaMotori(MotorManagementPlcMotoreAvviamentoSpegnimento)
            TimeoutSequenzaInCorso = IIf(avviamento, .tempoStart, .tempoStop) + .tempoAttesaRitorno * 2
        End With
        TmrTimeoutSequenzaInCorso = ConvertiTimer()
'
    End If
    '

    Exit Sub
Errore:
    LogInserisci True, "MOT-018", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function MotoriInAutomatico() As Boolean

    MotoriInAutomatico = (MotorManagement = AutomaticMotor)

End Function


'   Se il motore è acceso o comunque è tutto ok ritorna TRUE
Public Function VerificaMotore(ByRef motore As MotoreType, criterioAllarme As String) As Boolean

    Dim posizione As Integer

    VerificaMotore = True

    With motore
        If (.ComandoManuale And .ritorno) Then
            .oraStart = 0
            If (criterioAllarme <> "") Then
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", criterioAllarme, "IdDescrizione")
                IngressoAllarmePresente posizione, False
            End If

        ElseIf (Not .ComandoManuale And Not .ritorno) Then

            .oraStart = 0

        End If

    End With
End Function


'   Se il motore è acceso o comunque è tutto ok ritorna TRUE
Public Function VerificaMotorePred(ByRef motore As MotorePredosatoreType, criterioAllarme As String) As Boolean
    
    Dim posizione As Integer

    VerificaMotorePred = True

    With motore
        If (.uscita And .ritorno) Then
            .oraStart = 0
            If (criterioAllarme <> "") Then
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", criterioAllarme, "IdDescrizione")
                IngressoAllarmePresente posizione, False
            End If

        ElseIf (Not .uscita And Not .ritorno) Then

            .oraStart = 0

        ElseIf (.uscita <> .ritorno) And (UCase(left(criterioAllarme, 2)) = "PR") Then

            'PREDOSATORI
            If (ConvertiTimer() - .oraStart) > .tempoAttesaRitorno Then
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", criterioAllarme, "IdDescrizione")
                IngressoAllarmePresente posizione, True
                VerificaMotorePred = False
            End If

        End If

    End With

End Function

Public Sub VerificaMotoriAccesi()
    Dim motore As Integer
    Dim Criterio As String
    Dim posizione As Integer
    Dim controlla As Boolean
    Dim eraAcceso As Boolean

    On Error GoTo Errore

    For motore = 1 To MAXMOTORI

        With ListaMotori(motore)

            controlla = True

            If (.presente) Then

                Criterio = "AM" + Format(motore, "000")

                If (Not .ritorno) Then

                    Select Case motore

                        Case MotoreMescolatore
                            controlla = Not ScaricoMescolatoreForzato

                        Case MotoreElevatoreRiciclato 'NASTRO RICICLATO A ELEVATORE + ELEVATORE RICICLATO.
                            controlla = PesaturaRiciclatoAggregato7 Or AbilitaRAPSiwa Or AbilitaRAP

                    End Select
        
                End If
                
                If (controlla) Then
                    If (motore = MotoreVentolaBruciatore Or motore = MotoreVentolaBruciatore2) Then
                        If ( _
                            Not .ritorno And _
                            ((motore = MotoreVentolaBruciatore And ListaTamburi(0).FiammaBruciatorePresente) Or _
                            (motore = MotoreVentolaBruciatore2 And ListaTamburi(1).FiammaBruciatorePresente)) _
                        ) Then
                            posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
                            IngressoAllarmePresente posizione, True

                            If motore = MotoreVentolaBruciatore Then
                                Call StopBruciatoreTamburo(0)
                            ElseIf motore = MotoreVentolaBruciatore2 Then
                                Call StopBruciatoreTamburo(1)
                            End If

                        End If
'20150302
                    ElseIf motore = MotoreAspiratoreFiltro Then
                    
                        Call ControlloPuliziaFiltro
'
                    Else
                        If (Not .ritorno And (motore = MotoreTrasportoFillerizzazioneFiltro Or motore = MotoreFillerizzazioneFiltroRecupero Or motore = MotoreFillerizzazioneFiltroApporto)) Then
                            Call AbortFillerizzazione
                        End If
                    End If

                End If

            End If

        End With

    Next motore

    Call CalcolaOreLavoroMotori

    Call VerificaEvacuazioneFiltroDMR

    Call VerificaEvacuazioneSiloFiller

    '20151130
    If (TmrTimeoutSequenzaInCorso > 0 And (ConvertiTimer() - TmrTimeoutSequenzaInCorso > TimeoutSequenzaInCorso)) Then
                
        'è scattato il timer ... brutto segno: vuol dire che è da un po' che la sequenza di avviamento è inattiva
        TmrTimeoutSequenzaInCorso = 0

        Call IngressoAllarmePresente(DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "AM000", "IdDescrizione"), True)

        'Switch su manuale
        Call SetMotorManagement(MotorManagementEnum.SemiAutomaticMotor)
                
    End If
    '

    Exit Sub
Errore:
    LogInserisci True, "MOT-011", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ChkAvvioMotoriFillerizzazione(motore As Integer, comando As Boolean)

    'Spengo l'altro motore se acceso, poiche' non si possono utilizzare contemporaneamente F1 e F2
    If motore = MotoreFillerizzazioneFiltroRecupero And ListaMotori(MotoreFillerizzazioneFiltroApporto).ritorno Then

        'Call SetMotoreUscita(MotoreFillerizzazioneFiltroApporto, False)

    End If

    If motore = MotoreFillerizzazioneFiltroApporto And ListaMotori(MotoreFillerizzazioneFiltroRecupero).ritorno Then

        'Call SetMotoreUscita(MotoreFillerizzazioneFiltroRecupero, False)

    End If

    'Call SetMotoreUscita(motore, comando)

End Sub


Public Sub AggiornaGraficaValvolaTSF_Change()

    If ValvolaTSFErrore Then
        CP240.imgValvolaCisterne(5).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
    ElseIf ValvolaTSFAperta Then
        CP240.imgValvolaCisterne(5).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
    Else
        CP240.imgValvolaCisterne(5).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)
    End If

End Sub


Public Sub GestionePulsantiTipoFunzMot(Stato As Boolean)

    If AvvMotori.Visible Then
        AvvMotori.imgPulsanteForm(3).enabled = Stato And Not MotorManagementPlcAutomatic
        AvvMotori.imgPulsanteForm(4).enabled = Stato And Not MotorManagementPlcSemiAutomatic
'20151029
'        AvvMotori.imgPulsanteForm(5).enabled = stato And Not MotorManagementPlcForcing
        AvvMotori.imgPulsanteForm(5).enabled = Stato And Not MotorManagementPlcForcing And (ActiveUser >= MANAGER)
'
        
        Call AvvMotori.UpdatePulsantiForm
    End If

    CP240.CmdStartStopGenerale(0).enabled = Stato And Not MotorManagementPlcAutomatic
    CP240.CmdStartStopGenerale(1).enabled = Stato And Not MotorManagementPlcForcing

End Sub
'

Public Sub AbilitaPulsFormInversione()

    With FrmInversionePCL
    
        .APButtonStartStopMotore(1).enabled = Not ListaMotori(MotorePCL).ritorno
        .APButtonStartStopMotore(2).enabled = Not ListaMotori(MotorePCL2).ritorno
        .APButtonStartStopMotore(3).enabled = Not ListaMotori(MotorePCL3).ritorno

    End With

End Sub

'20150731
Public Sub GraficaDustFix()
    '20151020
    'If (Not CP240.OPCData.items(PLCTAG_IN_DUSTFIX_ENABLE).Value) Then
    If (Not DustfixEnable) Then
    '
        'visible a false
        Exit Sub
    End If
    If (TermicaDustfix) Then
       CP240.ImgDustFix.Picture = LoadResPicture("IDB_DUSTFIX_ERROR", vbResBitmap)
    Else
        If (Not PompaDustfix And Not MixerDustfix) Then
            CP240.ImgDustFix.Picture = LoadResPicture("IDB_DUSTFIX_OFF", vbResBitmap)
        End If
        If (PompaDustfix And Not MixerDustfix) Then
            CP240.ImgDustFix.Picture = LoadResPicture("IDB_DUSTFIX_PUMP_ON", vbResBitmap)
        End If
        If (MixerDustfix And Not PompaDustfix) Then
            CP240.ImgDustFix.Picture = LoadResPicture("IDB_DUSTFIX_MIXER_ON", vbResBitmap)
        End If
        If (MixerDustfix And PompaDustfix) Then
            CP240.ImgDustFix.Picture = LoadResPicture("IDB_DUSTFIX_ON", vbResBitmap)
        End If
    End If

End Sub

'20170322
Public Sub DimensionaFiamma(tamburo As Integer)
    
    Dim Index As Integer

    If Not ListaTamburi(tamburo).FiammaBruciatorePresente Then Exit Sub

    If tamburo = 0 Then
        Index = 74
    Else
        Index = 77
    End If

    CP240.Controls("Image1")(Index).width = Round((CSng(100) * (CSng(ListaTamburi(tamburo).posizioneModulatoreBruciatore) / CSng(100))) + CSng(66), 0)
    CP240.Controls("Image1")(Index).left = ListaTamburi(tamburo).FiammaPosLeft + ListaTamburi(tamburo).FiammaWith - CP240.Controls("Image1")(Index).width

End Sub
'


