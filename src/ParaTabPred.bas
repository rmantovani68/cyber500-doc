Attribute VB_Name = "ParaTabPred"
'
'   Gestione dei parametri dei predosatori
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE As String = "Predosatori"


'   Lettura del file
Public Function ParaTabPred_ReadFile() As Boolean

    Dim Index As Integer


    ParaTabPred_ReadFile = False

    'CYBERTRONIC_PLUS

    Vpred = String2Long(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "Vpred"))
    VRic = String2Long(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "VRic"))
    CicliStopPred = String2Long(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "CicliStopPred"))

'segare
'        InclusioneBilanciaNastroInerti = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "InclusioneBilanciaInerti"))
'        BilanciaInertiRamsey = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "BilanciaInertiRamsey"))
'        BilanciaInertiSiwarex = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "BilanciaInertiSiwarex"))
'        InclusioneBilanciaNastroRiciclato = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "InclusioneBilanciaNastroRiciclato"))
'        InclusioneBilanciaNastroRiciclatoParDrum = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "InclusioneBilanciaNastroRiciclatoParDrum"))
'        BilanciaRiciclatoRamsey = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "BilanciaRiciclatoRamsey"))
'        BilanciaRiciclatoSiwarex = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "BilanciaRiciclatoSiwarex"))
'        VisualizzaPortataNastri = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "", "", "VisualizzaPortataNastri"))
    ConfigPortataNastroInerti = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "TipoGestioneBilanciaInerti"))
    ConfigPortataNastroRiciclato = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "TipoGestioneBilanciaRiciclato"))
    ConfigPortataNastroRiciclatoParDrum = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "TipoGestioneBilanciaRiciclatoParDrum"))
'
    'BilanciaRiciclatoParDrumRamsey = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "BilanciaRiciclatoParDrumRamsey"))
    'BilanciaRiciclatoParDrumSiwarex = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "BilanciaRiciclatoParDrumSiwarex"))
    AbilitaDeflettoreAnello = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AbilitaDeflettoreAnello"))
    AbilitaModulatoreDeflettoreAnello = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AbilitaModulatoreDeflettoreAnello"))
    AbilitaNastroDeflettoreAnello = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AbilitaNastroDeflettoreAnello"))
    NastroDeflettoreAnelloSpento0 = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "NastroDeflettoreAnelloSpento0"))
    AbilitaDeflettoreMulino = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AbilitaDeflettoreMulino"))
    AbilitaDeflettoreAnelloElevatoreRic = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AbilitaDeflAnElev"))
    ShowHotRecyScreen = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "RecyCollBelt1Screen"))
    ShowColdRecyScreen = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "RecyCollBelt2Screen"))
    PortataMaxRamseyInerti = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "PortataMaxRamseyInerti"))
    PortataMaxRamseyRic = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "PortataMaxRamseyRic"))
    RiduzioneProduzioneDefault = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "", "", "RiduzioneProduzione"))
    PidPonderaleNastroRic.ritardoTC = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "TempoInizioCorr"))
    PidPonderaleNastroRic.TC = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "TempoPausaPond"))
    PidPonderaleNastroRic.KP = String2Double(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "PidPonderaleNastroRicKP"))
    PidPonderaleNastroRic.ti = String2Double(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "PidPonderaleNastroRicTI"))
    PidPonderaleNastroRic.td = String2Double(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "PidPonderaleNastroRicTD"))
    PidPonderaleNastroRic.maxCorrezione = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "PonderaleCorrezioneMax"))
    AllarmiPredosatori = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "", "", "AllarmiPredosatori"))
    TempoPermanenzaAllarmePredosatori = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "", "", "TempoPermanenzaAllarmePredosatori"))
    EsclusioneSpegniVaglio = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "", "", "EsclusioneSpegniVaglio"))
    AbilitaInversioneLanciatore = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "AbilitaInversioneLanciatore"))
    AbilitaInversioneCollettore = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "AbilitaInversioneCollettore"))
    AbilitaInversioneRiciclato = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AbilitaInversioneRiciclato"))
    TempoSpegnimentoNastriRiciclatoCaldo = String2Long(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "TempoSpegnimentoNastriRiciclatoCaldo"))
    TempoSpegnimentoNastriCollettori = String2Long(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "TempoSpegnimentoNastriCollettori"))
    AvvioPredosatoriSenzaBruciatore = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "AvvioPredosatoriSenzaBruciatore"))
    InclusioneRifrantumazione = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "InclusioneRifrantumazione"))
    AttesaRitornoRifrantumazione = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "AttesaRitornoRifrantumazione"))
    RitardoStartVibratorePredVuoto = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "", "", "RitardoStartVibratorePredVuoto"))
    RitardoStopVibratorePredVuoto = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "", "", "RitardoStopVibratorePredVuoto"))
    RitardoStartGriglieVibranti = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "RitardoStartGriglieVibranti"))
    RitardoStopGriglieVibranti = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "RitardoStopGriglieVibranti"))
    PredosatoriCambioSet = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "", "", "PredosatoriCambioSet"))
    AbilitaCodaMateriale = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "", "", "AbilitaCodaMateriale"))
    TempoCodaInerti = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "", "", "TempoCodaInerti"))
    PercentualeFillerRecuperatoFiltro = String2Double(ParameterPlus.GetParameterValue("Predosaggio", "", "", "PercentualeFillerRecuperatoFiltro"))
    AbilitaPredosatoreVuotoComune = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "", "", "AbilitaPredosatoreVuotoComune"))
    ColdFeederVibratorWorkingCycle.On = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "VibratoriPredTempoOn"))
    ColdFeederVibratorWorkingCycle.Idle = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "VibratoriPredTempoOff"))
    RecyColdFeederVibratorWorkingCycle.On = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "VibratoriPredRicTempoOn"))
    RecyColdFeederVibratorWorkingCycle.Idle = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "VibratoriPredRicTempoOff"))
    RecyColdFeederBlowerWorkingCycle.On = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "SoffiPredRicTempoOn"))
    RecyColdFeederBlowerWorkingCycle.Idle = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "SoffiPredRicTempoOff"))
    
    NumeroPredosatoriNastroC(0) = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "NumPredNastroC0"))
    NumeroPredosatoriNastroC(1) = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "NumPredNastroC1"))
    NumeroPredosatoriNastroC(2) = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "NumPredNastroC2"))
    NumeroPredosatoriNastroC(3) = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "NumPredNastroC3"))
    NumeroPredosatoriNastroC(4) = String2Int(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "NumPredNastroC4"))
    InvertiNumerazionePred(0) = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "InvertiNumerazionePredNastroC0"))
    InvertiNumerazionePred(1) = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "InvertiNumerazionePredNastroC1"))
    InvertiNumerazionePred(2) = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "InvertiNumerazionePredNastroC2"))
    InvertiNumerazionePred(3) = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Riciclato", "", "InvertiNumerazionePredNastroC3"))
    InvertiNumerazionePred(4) = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", "Inerti", "", "InvertiNumerazionePredNastroC4"))

    For Index = 0 To MAXPREDOSATORI - 1
        Call CaricaDatiGrafPredosatore(ListaPredosatori(Index))
    Next Index
    For Index = 0 To MAXPREDOSATORIRICICLATO - 1
        Call CaricaDatiGrafPredosatore(ListaPredosatoriRic(Index))
    Next Index

    '20160420
    'If (Not CP240.AdoPredosaggio.Recordset.BOF And CP240.AdoPredosaggio.Recordset.EOF) Then
    ''
    '    '20160405
    '    If (CP240.AdoPredosaggio.Recordset.Fields("Descrizione") <> "") Then
    '        Call ChkCoherenceMaterial(CInt(CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio")))   '20160405 '20160405
    '    End If
    '    '20160405
    'End If
    '

    Call SiwarexLeggiTutteDaFile
    Call ParaTabPred_ToDB

    Call LeggiUmiditaPredSQL

    ParaTabPred_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabPred_Apply()

    Dim predosatore As Integer

    With CP240

        Call VisualizzaPredosatoriImpostati

        .AniPushButtonDeflettore(11).Visible = AbilitaDeflettoreAnello Or AbilitaDeflettoreAnelloElevatoreRic
        .AniPushButtonDeflettore(12).Visible = AbilitaDeflettoreMulino
        .FrameModDeflAnello.Visible = AbilitaModulatoreDeflettoreAnello

        .AniPushButtonDeflettore(13).Visible = InclusioneRifrantumazione

        If (AvvioPredosatoriSenzaBruciatore) Then
            .CmdAvvPredPrimaDopoBruc.Picture = LoadResPicture("IDI_BRUCESCLUSO", vbResIcon)
        Else
            .CmdAvvPredPrimaDopoBruc.Picture = LoadResPicture("IDI_BRUCINCLUSO", vbResIcon)
        End If

        .TxtStopPredosatori.text = CStr(CicliStopPred)
        
        'In questo punto la variabile ParallelDrum all'avvio non ha un valore valido, quindi viene ripetuto il controllo dentro la
        'routine "ParallelDrumManagement"
        ParallelDrum = ListaMotori(MotoreRotazioneEssiccatore2).presente

        FrmGestioneTimer.TmrCodaMateriale.enabled = AbilitaCodaMateriale Or ParallelDrum

        CqInit CodaInerti, TempoCodaInerti

        .ImgMotor(248).Visible = AbilitaNastroDeflettoreAnello
        NastroDeflettoreAnelloAccesoOld = True

        Call VisualizzaNastroDeflettoreAnello

        For predosatore = 0 To MAXPREDOSATORI - 1
            .LblPredNome(predosatore).caption = PredosatoreOttieniNome(ListaPredosatori(predosatore))
        Next predosatore
        
        For predosatore = 0 To MAXPREDOSATORIRICICLATO - 1
            .LblPredRicNome(predosatore).caption = PredosatoreOttieniNome(ListaPredosatoriRic(predosatore))
        Next predosatore

        For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
            If ListaPredosatoriRic(predosatore).GrigliaVibrantePresente Then
                CP240.ImgPala(predosatore).Picture = LoadResPicture("IDB_PALAVERDE", vbResBitmap)
            End If
        Next predosatore

        NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly) = 0
        For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
            If (ListaPredosatoriRic(predosatore).SuNastroJolly) Then
                NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly) = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly) + 1
            End If
        Next predosatore

        '20170323
        'If Not DosaggioInCorso Then
        If Not AutomaticoPredosatori Then
        '
            Call SetRiduzioneProduzione(RiduzioneProduzioneDefault)
        End If

'20151106 TODO: da gestire come parametro
        TolleranzaNastroInerti.Tolleranza = 20
        TolleranzaNastroInerti.TempoRitardoControllo = 40 'secondi
        TolleranzaNastroRAP.Tolleranza = 20
        TolleranzaNastroRAP.TempoRitardoControllo = 30 'secondi
'

        '20160420
        If (Not .AdoPredosaggio.Recordset.BOF And Not .AdoPredosaggio.Recordset.EOF) Then
            '20160405
            If (.AdoPredosaggio.Recordset.Fields("Descrizione") <> "") Then
                Call ChkCoherenceMaterial(CInt(.AdoPredosaggio.Recordset.Fields("IdPredosaggio")))   '20160405 '20160405
            End If
            '20160405
        End If
        '

    End With

End Sub


Private Sub ParaTabPred_ToDB()

    '   Controlli di coerenza

    If (NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) = 0) Then
        NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) = 4
    End If

    If (NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) > MAXPREDOSATORI) Then
        NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) = 0
    End If
    If (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly) > MAXPREDOSATORIRICICLATO) Then
        NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) = 0
        NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly) = 0
    End If


    If (NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) = 0 Or Not ListaMotori(MotoreNastroCollettore2).presente) Then
        NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) = 0
    End If

    If (NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) = 0 Or Not ListaMotori(MotoreNastroCollettore3).presente) Then
        NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) = 0
    End If


    NumeroPredosatoriInseriti = NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore3)
'20161213
'    NumeroPredosatoriRicInseriti = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly)
    NumeroPredosatoriRicInseriti = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo)
'
End Sub


Private Sub LeggiConfigurazionePredosatore(Pred As PredosatoreType)

    Dim nomeFile As String
    Dim sezionePred As String

    'CYBERTRONIC_PLUS

    With Pred

        If (.riciclato) Then
            nomeFile = "Riciclato"
            sezionePred = "PredosatoreRic" + CStr(.progressivo)
        Else
            nomeFile = "Inerti"
            sezionePred = "Predosatore" + CStr(.progressivo)
        End If
        
        .bilanciaPresente = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "bilanciaPresente"))
        .bilanciaSiwarex = (1 = String2Int(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "tipoBilancia")))
        .bilanciaRamsey = Not .bilanciaSiwarex
        .bilanciaSiwarexIndice = String2Int(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "bilanciaSiwarexIndice"))
        .vibratorePresente = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "vibratorePresente"))
        .livelloBassoPresente = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "livelloBassoPresente"))
        .soffioPresente = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "soffioPresente"))
        .abilitaSuVuotoVibratore = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "abilitaSuVuotoVibratore"))
        .autoOnVibratore = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "autoOnVibratore"))
        .ingressoAnalogicoBilancia = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "ingressoAnalogicoBilancia"))
        .portataMaxBilancia = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "portataMaxBilancia"))
        .pid.maxCorrezione = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "pidMaxCorrezione"))
        .pid.KP = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "pidKP"))
        .pid.ti = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "pidTI"))
        .pid.td = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "pidTD"))
        .pid.TC = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "pidTC"))
        .pid.ritardoTC = String2Double(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "pidRitardoTC"))

        If (.riciclato) Then
            .GrigliaVibrantePresente = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "GrigliaVibrantePresente"))
            .SuNastroJolly = String2Bool(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "SuNastroJolly"))
        End If

    End With

End Sub

Public Sub CaricaDatiGrafPredosatore(ByRef Pred As PredosatoreType)

    Dim indice As Integer
    Dim serie As Integer
    Dim nomeFile As String
    Dim sezionePred As String
    Dim nomeDefault As String


    'CYBERTRONIC_PLUS

    With Pred

        If (.riciclato) Then
            nomeFile = "Riciclato"
            sezionePred = "PredosatoreRic" + CStr(.progressivo)
        Else
            nomeFile = "Inerti"
            sezionePred = "Predosatore" + CStr(.progressivo)
        End If

        '20151119
        '.Grafico.curvaAttiva = CInt(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficocurvaAttiva"))
        .Grafico.curvaAttiva = CInt(ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficocurvaAttiva", "0"))
        '
        For serie = 0 To MAXCURVEPREDOSATORE - 1
            .Grafico.curva(serie).Nome = _
                ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficonome" + CStr(serie))
            For indice = 0 To MAXPUNTICURVAPREDOSATORE - 1
                '20151119
                '.Grafico.curva(serie).valori(indice) = CInt( _
                '    ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficovalori" + CStr(serie) + "_" + CStr(indice)) _
                '    )
                '.Grafico.curva(serie).percento(indice) = CInt( _
                '    ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficopercento" + CStr(serie) + "_" + CStr(indice)) _
                '    )
                .Grafico.curva(serie).valori(indice) = CInt( _
                    ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficovalori" + CStr(serie) + "_" + CStr(indice), "0") _
                    )
                .Grafico.curva(serie).percento(indice) = CInt( _
                    ParameterPlus.GetParameterValue("Predosaggio", nomeFile, sezionePred, "graficopercento" + CStr(serie) + "_" + CStr(indice), "0") _
                    )
                '
            Next indice
        Next serie

        .PortataMax = .Grafico.curva(.Grafico.curvaAttiva).valori(MAXPUNTICURVAPREDOSATORE - 1)
        .Grafico.curva(.Grafico.curvaAttiva).IdMaterialeLog = 0

        If (.Grafico.curva(.Grafico.curvaAttiva).Nome <> "") Then

            CP240.AdoMaterialiLog.Refresh
            
            Do Until (CP240.AdoMaterialiLog.Recordset.EOF)
                If (CP240.AdoMaterialiLog.Recordset.Fields("Nome").Value = .Grafico.curva(.Grafico.curvaAttiva).Nome) Then
                    Exit Do
                End If
                CP240.AdoMaterialiLog.Recordset.MoveNext
            Loop

            If Not (CP240.AdoMaterialiLog.Recordset.EOF) Then
                If (CP240.AdoMaterialiLog.Recordset.Fields("Nome").Value = .Grafico.curva(.Grafico.curvaAttiva).Nome) Then
                    .Grafico.curva(.Grafico.curvaAttiva).IdMaterialeLog = CP240.AdoMaterialiLog.Recordset.Fields("IdMaterialeLOG").Value
                End If
            End If

        End If
    End With

    Call LeggiConfigurazionePredosatore(Pred)
    Call AssociaSiwarexPredosatori

End Sub

Public Sub PlcGriglieVibranti()

    With CP240.OPCData

        If (Not CP240.OPCData.IsConnected) Then
            Exit Sub
        End If

        .items(PLCTAG_GrigliaVibranteRic1Abilita).Value = (NumeroPredosatoriRicInseriti >= 1 And ListaPredosatoriRic(0).GrigliaVibrantePresente)
        .items(PLCTAG_GrigliaVibranteRic1RitardoStart).Value = RitardoStartGriglieVibranti
        .items(PLCTAG_GrigliaVibranteRic1RitardoStop).Value = RitardoStopGriglieVibranti

        .items(PLCTAG_GrigliaVibranteRic2Abilita).Value = (NumeroPredosatoriRicInseriti >= 2 And ListaPredosatoriRic(1).GrigliaVibrantePresente)
        .items(PLCTAG_GrigliaVibranteRic2RitardoStart).Value = RitardoStartGriglieVibranti
        .items(PLCTAG_GrigliaVibranteRic2RitardoStop).Value = RitardoStopGriglieVibranti

        .items(PLCTAG_GrigliaVibranteRic3Abilita).Value = (NumeroPredosatoriRicInseriti >= 3 And ListaPredosatoriRic(2).GrigliaVibrantePresente)
        .items(PLCTAG_GrigliaVibranteRic3RitardoStart).Value = RitardoStartGriglieVibranti
        .items(PLCTAG_GrigliaVibranteRic3RitardoStop).Value = RitardoStopGriglieVibranti

        .items(PLCTAG_GrigliaVibranteRic4Abilita).Value = (NumeroPredosatoriRicInseriti >= 4 And ListaPredosatoriRic(3).GrigliaVibrantePresente)
        .items(PLCTAG_GrigliaVibranteRic4RitardoStart).Value = RitardoStartGriglieVibranti
        .items(PLCTAG_GrigliaVibranteRic4RitardoStop).Value = RitardoStopGriglieVibranti

    End With

End Sub


Public Sub LeggiUmiditaPredSQL()

    Dim rsMateriali As New adodb.Recordset
    Dim rs As New adodb.Recordset
    Dim Index As Integer
    Dim idMateriale As String


    On Error GoTo Errore

    'CYBERTRONIC_PLUS

    For Index = 0 To NumeroPredosatoriInseriti - 1  '20151106

        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * From MaterialiLog;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With

        idMateriale = PredosatoreOttieniMaterialeLogId(ListaPredosatori(Index))

        rs.Close

        With rsMateriali
            Set .ActiveConnection = DBcon
            .Source = "SELECT [PercUmidita] AS sqlUmidita From MaterialiLog Where [IdMaterialeLog] = '" & idMateriale & "';"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With

        If (Not rsMateriali.EOF) And (Not IsNull(rsMateriali!sqlUmidita)) Then
            ListaPredosatori(Index).Umidita = rsMateriali!sqlUmidita
        Else
            ListaPredosatori(Index).Umidita = 0
        End If

        rsMateriali.Close

    Next Index

    For Index = 0 To NumeroPredosatoriRicInseriti

        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * From MaterialiLog;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With

        idMateriale = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(Index))

        rs.Close

        With rsMateriali
            Set .ActiveConnection = DBcon
            .Source = "SELECT [PercUmidita] AS sqlUmidita From MaterialiLog Where [IdMaterialeLog] = '" & idMateriale & "';"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With

        If (Not rsMateriali.EOF) And (Not IsNull(rsMateriali!sqlUmidita)) Then
            ListaPredosatoriRic(Index).Umidita = rsMateriali!sqlUmidita
        Else
            ListaPredosatoriRic(Index).Umidita = 0
        End If

        rsMateriali.Close

    Next Index

    Exit Sub
Errore:
    LogInserisci True, "PPR-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
