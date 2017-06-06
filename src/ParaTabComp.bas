Attribute VB_Name = "ParaTabDos"
'
'   Gestione dei parametri del dosaggio
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE As String = "Dosaggio"
Private Const FileParametriVari = "VarParameters.ini" '20150708
Private Const FileParametriBilCamion = "PesaCamion.ini" '20151201


'   Lettura del file
Public Function ParaTabDos_ReadFile() As Boolean

    Dim tmp As Integer
    Dim Index As Integer
    Dim appoggio As String


    ParaTabDos_ReadFile = False

    'CYBERTRONIC_PLUS

    ImpastoVagliato = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ImpastoVagliato"))
    ImpastoNonVagliato = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ImpastoNonVagliato"))
    TonOrarieImpianto = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TonOrarieImpianto"))
    RiduzioneImpastoDefault = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RiduzioneImpasto"))
    AbilitaTemperaturaMixer = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaTemperaturaMixer"))
    AbilitaAspirazFumiRAP = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaAspirazFumiRAP"))
    AspFumiRAP_PARA_TempoApertura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AspFumiRAP_PARA_TempoApertura"))
    'AbilitaMemorizzazioneManuali = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaMemorizzazioneManuali"))
    InclusioneDeflettoreNonPassa = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneDeflettoreNonPassa"))
    InclusioneLegante100 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneLegante100"))
    TimeOutTroppoPienoNV = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TimeOutTroppoPienoNV"))
    InclusioneStampaOgniDosaggio = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneStampaOgniDosaggio"))
    TimeOutTroppoPienoRifiuti = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TimeOutTroppoPienoRifiuti"))    '20161129
    'STAMPA CONTINUA
    StampaOgniDosaggioNomeStampante = ParameterPlus.GetParameterValue(SEZIONE, "", "", "StampaOgniDosaggioNomeStampante")
    'StampaOgniDosaggioSeriale = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "StampaOgniDosaggioSeriale"))
    'StampaOgniDosaggioNumeroRighe = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "StampaOgniDosaggioNumeroRighe"))
    StampaOgniDosaggioNumeroColonne = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "StampaOgniDosaggioNumeroColonne"))
    'StampaOgniDosaggioComPort = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "StampaOgniDosaggioComPort"))
    InclusioneTemperaturaTramogge = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneTemperaturaTramogge"))

    '<Paragraph Code="GestioneBilance">

    BilanciaAggregati.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TaraAgg"))
    BilanciaAggregati.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SicurezzaAgg"))
    BilanciaAggregati.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "PresenzaBilPNetAgg")) '20161024
    BilanciaAggregati.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "NumDecBilPNetAgg")) '20161024
    BilanciaAggregati.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "GSetA"))

    BilanciaFiller.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TaraFiller"))
    BilanciaFiller.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SicurezzaFiller"))
    BilanciaFiller.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "PresenzaBilPNetFil")) '20161024
    BilanciaFiller.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "NumDecBilPNetFil")) '20161024
    BilanciaFiller.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "GSetF"))

    BilanciaLegante.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TaraBitume"))
    BilanciaLegante.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SicurezzaBitume"))
    BilanciaLegante.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "PresenzaBilPNetBit")) '20161024
    BilanciaLegante.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "NumDecBilPNetBit")) '20161024
    BilanciaLegante.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "GSetB"))

    BilanciaRAP.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "GSetR"))
    BilanciaRAP.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "PresenzaBilPNetRic")) '20161024
    BilanciaRAP.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "NumDecBilPNetRic")) '20161024
    GSetBSoft = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "GSetBSoft"))
    TaraBitumeSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TaraBitumeSoft"))
    SicurezzaBitumeSoft = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SicurezzaBitumeSoft"))

    BilanciaRAP.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TaraBil4"))
    BilanciaRAP.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SicurezzaBil4"))

    AbilitaRAP = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "InclusioneBilanciaRic"))
    AbilitaRAPSiwa = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "AbilitaRAPSiwa"))

    TempoAllarmeScaricoAggregati = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoAggregati"))
    TempoAllarmeScaricoFiller = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoFiller"))
    TempoAllarmeScaricoLegante = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoLegante"))
    TempoAllarmeScaricoLeganteGR = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoLeganteGR"))
    TempoAllarmeScaricoContalitri = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoContalitri"))
    TempoAllarmeScaricoRiciclato = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoRiciclato"))
    TempoAllarmeScaricoViatop = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoViatop"))
    TempoAllarmeScaricoMixer = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoAllarmeScaricoMixer"))
    TempoPermanenzaScaricoAggregati = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoPermanenzaScaricoAggregati"))
    TempoPermanenzaScaricoFiller = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoPermanenzaScaricoFiller"))
    TempoPermanenzaScaricoRiciclato = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoPermanenzaScaricoRiciclato"))
    TempoPermanenzaScaricoLeganteGR = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoPermanenzaScaricoLeganteGR"))
    TempoRitardoAllarmeScaricoMixer = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoRitardoAllarmeScaricoMixer")) '20170221

    SiwarexPESA_Velox_MAX_AO = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SiwarexPESA_Velox_MAX_AO"))
    SiwarexPESA_Velox_MIN_AO = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SiwarexPESA_Velox_MIN_AO"))
    SiwarexPESA_Kg_Velox_MIN = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SiwarexPESA_Kg_Velox_MIN"))
    TempoPermApertFlapScivoloScarBilRAP = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "TempoPermApertFlapScivoloScarBilRAP"))
    PesaturaRiciclatoAggregato7 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneBilance", "", "SelezionePesaturaRiciclatoAggregato7"))

    '<Paragraph Code="GestionePortine">

    NTramoggeA = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "NTramoggeA")) - 1
    If (NTramoggeA < 0) Then
        NTramoggeA = 0
    End If
    NLivelliA = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "NLivelliA"))
    TramoggeLivelliDigitaliMinimo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "TramoggeLivelliDigitaliMinimo"))
    TramoggeVisualizzaLivelloMinimo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "TramoggeVisualizzaLivelloMinimo"))
    TramoggeLivelloMinimo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "TramoggeLivelloMinimo"))
    TramoggeLivelloMassimo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "TramoggeLivelloMassimo"))

    appoggio = ""
    For Index = 0 To 7
        NomePortina(Index) = ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "NomePortina" + CStr(Index))
        tmp = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestionePortine", "", "TipoLivelloPortina" + CStr(Index)))
        If (tmp) Then
            appoggio = 1 & appoggio
        Else
            appoggio = 0 & appoggio
        End If
    Next Index
    TipoLivelliA = Binary2Integer(appoggio)

    '<Paragraph Code="GestioneFiller">

    GestioneFiller2 = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "Filler2Inserito"))
    GestioneScambioTuboTroppoPieno = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "GestioneScambioTuboTroppoPieno"))
'20151030
'    InclusioneF3 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "InclusioneF3"))
    GestioneFiller3 = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "Filler3Inserito"))
'
    F2SuElevatoreF2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "F2SuElevatoreF2"))
    F3SuElevatoreF2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "F3SuElevatoreF2"))

    LivelliFillerContinui = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "LivFillerContinui"))
    LivelloMinSiloFillerAn = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "LivelloMinSiloFillerAn"))
    LivelloMaxSiloFillerAn = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "LivelloMaxSiloFillerAn"))

    LivelloMaxF1 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "LivelloMaxF1"))
    LivelloMaxF2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "LivelloMaxF2"))
    PresenzaRompiSacchiF2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "PresenzaRompiSacchiF2")) '20161109
    '20150818
    'CameraEspansioneFillerRecupero = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "CameraEspansioneFillerRecupero"))
    '
    InclusioneEvacuazioneFillerRecuperoDMR = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "InclusioneEvacuazioneFillerRecuperoDMR"))
    InclusioneEvacuazioneSiloFiller = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "InclusioneEvacuazioneSiloFiller"))
    EvacuazioneForzataFiltroDMR = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "EvacuazioneForzataFiltroDMR"))
    TimeoutEvacuazioneFiller = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "TimeoutEvacuazioneFiller"))
    InclusioneTramoggiaTamponeF2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "TramoggiaFillerApporto"))

    AbilitaBindicatorFillerEsterni = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "AbilitaBindicatorFillerEsterni"))
    AbilitaTuboTroppoPienoF1 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "AbilitaTuboTroppoPienoF1"))
    AbilitaValvolaTroppoPienoF1 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "AbilitaValvolaTroppoPienoF1"))
'20150729
'    GestioneArrestoLivelliTSF = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "GestioneArrestoLivelliTSF"))
'    TimeoutArrestoLivelliTSF = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "TimeoutArrestoLivelliTSF"))
'

'20150605
    'ListaComandi(ComandoSiloFillerSoffioAriaRecupero).tempoStart = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "TempoLavoroSoffio"))
   'ListaComandi(ComandoSiloFillerSoffioAriaRecupero).tempoStop = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneFiller", "", "TempoPausaSoffio"))
'

    '<Paragraph Code="GestioneTamburoParallelo">
    
    TamburoParallelo_TempoCoda = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_TempoCoda"))
    TamburoParallelo_TramoggiaTamponeCapacita = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_TramoggiaTamponeCapacita "))
    TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaAllarmePercentuale = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaAllarmePercentuale"))
    TamburoParallelo_PredosasatoriCorrezionePercentuale = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_PredosasatoriCorrezionePercentuale"))
    TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaCriticaPercentuale = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaCriticaPercentuale"))
    BilanciaTamponeRiciclato.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_TramoggiaTamponeFondoScala"))
    BilanciaTamponeRiciclato.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "TamburoParallelo_TramoggiaTamponeSicurezza"))

    AntiadesivoScivoloScarBilRAP.presente = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "AntiadesivoScivoloScarBilRAPpresente"))
    AntiadesivoScivoloScarBilRAP.nr_eventi_attesa = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "AntiadesivoScivoloScarBilRAP_nr_eventi_attesa"))
    AntiadesivoScivoloScarBilRAP.tempo_spruzzatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "AntiadesivoScivoloScarBilRAP_tempo_spruzzatura"))

    NrImpastiGestLivTramTamponeRAP = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "GestioneTamburoParallelo", "", "NrImpastiGestLivTramTamponeRAP"))


    '<Paragraph Code="PesateFini">
    
    InclusioneDoppiaPesataAgg = String2Bool(ParameterPlus.GetParameterValue("PesateFini", "", "", "Presente"))
    PortataMassimaFiller1 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "PortataMassimaFiller1"))
    PortataMassimaFiller2 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "PortataMassimaFiller2"))
    PortataMassimaFiller3 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "PortataMassimaFiller3"))
    TempoMassimoPesataFiller = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "TempoMassimoPesataFiller"))
    RiduzioneVelocitaPesataFineFiller1 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "RiduzioneVelocitaPesataFineFiller1"))
    RiduzioneVelocitaPesataFineFiller2 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "RiduzioneVelocitaPesataFineFiller2"))
    RiduzioneVelocitaPesataFineFiller3 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "RiduzioneVelocitaPesataFineFiller3"))
    AnticipoPesataFineFiller1 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "AnticipoPesataFineFiller1"))
    AnticipoPesataFineFiller2 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "AnticipoPesataFineFiller2"))
    AnticipoPesataFineFiller3 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "AnticipoPesataFineFiller3"))
    VelocitaMinimaInverterCocleaFiltro = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "VelocitaMinimaInverterCocleaFiltro"))
    VelocitaMinimaInverterCocleaFiller1 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "VelocitaMinimaInverterCocleaFiller1"))
    VelocitaMinimaInverterCocleaFiller2 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "VelocitaMinimaInverterCocleaFiller2"))
    VelocitaMinimaInverterCocleaFiller3 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "VelocitaMinimaInverterCocleaFiller3"))
    RapportoFlussoCocleaPesataF1_CocleaFiltro = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "RapportoFlussoCocleaPesataF1_CocleaFiltro"))
    RapportoFlussoCocleaPesataF3_CocleaPesataF2 = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "RapportoFlussoCocleaPesataF3_CocleaPesataF2"))
    NumeroCampionamentiCalcoloFlusso = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "NumeroCampionamentiCalcoloFlusso"))
    AbilitaFineCorsaIntermedioAggregati = String2Bool(ParameterPlus.GetParameterValue("PesateFini", "", "", "AbilitaFineCorsaIntermedioAggregati"))
    AbilitaVoloDinamicoFlusso = String2Bool(ParameterPlus.GetParameterValue("PesateFini", "", "", "AbilitaVoloDinamicoFlusso"))
    PesoMinimoPesataVeloce = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "PesoMinimoPesataVeloce"))
    For Index = 1 To 8
        PesataFineAggregatiKg(Index) = String2Int(ParameterPlus.GetParameterValue("PesateFini", "", "", "PesataFineAggregatiKg" + CStr(Index)))
        CoeffCommutaPesataFineAggregati(Index) = String2Double(ParameterPlus.GetParameterValue("PesateFini", "", "", "CoeffCommutaPesataFineAggregati" + CStr(Index)))
        CoeffVoloPesataFineAggregati(Index) = String2Double(ParameterPlus.GetParameterValue("PesateFini", "", "", "CoeffVoloPesataFineAggregati" + CStr(Index)))
        CoeffVoloPesataUnicaAggregati(Index) = String2Double(ParameterPlus.GetParameterValue("PesateFini", "", "", "CoeffVoloPesataUnicaAggregati" + CStr(Index)))
    Next Index
'Attivare alla bisogna, per ora non e' usata
'    Call LeggeFileParDosVar '20150708
    
    Call LeggeFileParBilCamion '20151201
    
    ParaTabDos_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabDos_Apply()

    Dim Index As Integer '20150707


    With CP240
'20150624
'        InclusioneF2 = (GestioneFiller2 = 1)
        InclusioneF2 = (GestioneFiller2 = FillerIncluso)
'
'20151030
        InclusioneF3 = (GestioneFiller3 = FillerIncluso)
'

        If (ImpastoNonVagliato <= 0) Then
            ImpastoNonVagliato = ImpastoVagliato
        End If

        'Fondo Scala bilance Aggregati
        If BilanciaAggregati.FondoScala = 0 Then
            BilanciaAggregati.FondoScala = 3000
        End If
        'Fondo Scala bilance Filler
        If BilanciaFiller.FondoScala = 0 Then
            BilanciaFiller.FondoScala = 300
        End If
        'Fondo Scala bilance Bitume
        If BilanciaLegante.FondoScala = 0 Then
            BilanciaLegante.FondoScala = 300
        End If
        'Fondo Scala Riciclato
        If BilanciaRAP.FondoScala = 0 Then
            BilanciaRAP.FondoScala = 1000
        End If

        'Fondo Scala bilance Bitume Soft
        If GSetBSoft = 0 Then
            GSetBSoft = 200
        End If

        .ProgressBil(0).max = val(BilanciaAggregati.FondoScala)
        .ProgressBil(1).max = val(BilanciaFiller.FondoScala)
        .ProgressBil(2).max = val(BilanciaLegante.FondoScala)

'20151103
        'Fondo Scala bilancia Pesa Camion
'        .ProgressBil(3).max = val(BilanciaPesaCamion.FondoScala)
        .ProgressBil(3).max = val(BilanciaPesaCamion.PesaCamionScalingKgMax)
        .ProgressBil(9).max = val(BilanciaPesaCamion.PesaCamionScalingKgMax) '20170221
        BilanciaPesaCamion.Sicurezza = val(BilanciaPesaCamion.PesaCamionScalingKgMax) '20170224
        .LblEtichetta(21).caption = CStr(BilanciaPesaCamion.PesaCamionScalingKgMax) & "T" '20170221
'

        '20160312
        .UpDownProdDos.min = Round(CSng(1000) / CSng(ImpastoVagliato) * CSng(100))


        If AbilitaRAP Then
            .ProgressBil(7).max = val(BilanciaRAP.FondoScala)
        End If
        If AbilitaRAPSiwa Then
            BilanciaRAPSiwa.FondoScala = ImpastoNonVagliato
            BilanciaRAPSiwa.Sicurezza = ImpastoNonVagliato

            .ProgressBil(8).max = val(BilanciaRAPSiwa.FondoScala)
        End If

        .ProgressBil(6).max = val(BilanciaTamponeRiciclato.FondoScala)

        .ImgDeflettore(0).Visible = InclusioneDeflettoreNonPassa

        .Image10(1).Visible = AbilitaTemperaturaMixer
        .LblTempMateriale(0).Visible = AbilitaTemperaturaMixer
        .LblTempMateriale(2).Visible = AbilitaTemperaturaMixer
        .LblEtichetta(37).Visible = AbilitaTemperaturaMixer
        .LblEtichetta(87).Visible = AbilitaTemperaturaMixer '20150706

        .AniPushButtonDeflettore(15).Visible = (InclusioneF2 And InclusioneTramoggiaTamponeF2 And Not AbilitaBindicatorFillerEsterni)
        .AniPushButtonDeflettore(28).Visible = (InclusioneF3 And ListaMotori(MotoreElevatoreF2).presente And Not AbilitaBindicatorFillerEsterni)

        If Not DosaggioInCorso Then
            Call SetRiduzioneImpasto(RiduzioneImpastoDefault)
        End If
        

'20150624
'        .FrameSiloFiller(1).Visible = (GestioneFiller2 = 1 Or GestioneFiller2 = 2)
        .FrameSiloFiller(1).Visible = (GestioneFiller2 = FillerIncluso) Or (GestioneFiller2 = FillerSoloVisSilo)
'
'20151030
''20150708
''        .FrameSiloFiller(2).Visible = InclusioneF3
'        .FrameSiloFiller(2).Visible = InclusioneF3 Or (GestioneFiller3 = FillerSoloVisSilo) 'TODO gestione completa come per filler 2
        .FrameSiloFiller(2).Visible = (GestioneFiller3 = FillerIncluso) Or (GestioneFiller3 = FillerSoloVisSilo)
''
'
        .TextTempiRitardoSc(19).Visible = AbilitaRAP Or AbilitaRAPSiwa  '20161201

        .TextTempiRitardoSc(4).Visible = InclusioneAddMescolatore
       
        .TextTempiRitardoSc(5).Visible = InclusioneViatop

        .Image1(56).Visible = ValvolaPreseparatore.abilitato
        .AniPushButtonDeflettore(18).Visible = ValvolaPreseparatore.abilitato
'20150805
        .Image1(86).Visible = ValvolaPreseparatoreAnello.abilitato
        .AniPushButtonDeflettore(48).Visible = ValvolaPreseparatoreAnello.abilitato
'

        .AniPushButtonDeflettore(23).Visible = AbilitaValvolaTroppoPienoF1
        .AniPushButtonDeflettore(23).enabled = AbilitaValvolaTroppoPienoF1
        .AniPushButtonDeflettore(7).Visible = InclusioneEvacuazioneFillerRecuperoDMR
        
        .AniPushButtonDeflettore(7).top = 260
        .AniPushButtonDeflettore(7).left = 580
        
        .AniPushButtonDeflettore(14).Visible = InclusioneEvacuazioneSiloFiller
        .AniPButtonAspFresato.Visible = AbilitaAspirazFumiRAP And (AspFumiRAP_PARA_TempoApertura > 0)
        .Image1(67).Visible = AbilitaAspirazFumiRAP And (AspFumiRAP_PARA_TempoApertura > 0)
        .Image1(68).Visible = AbilitaAspirazFumiRAP And (AspFumiRAP_PARA_TempoApertura > 0)
        
        .Image1(48).Visible = AbilitaTuboTroppoPienoF1
        .Image1(12).Visible = AbilitaTuboTroppoPienoF1
        .AniPushButtonDeflettore(35).Visible = (AbilitaTuboTroppoPienoF1 And (GestioneScambioTuboTroppoPieno = ScambioF1F2 Or GestioneScambioTuboTroppoPieno = ScambioF2F3))
        If GestioneScambioTuboTroppoPieno = ScambioF1F2 Then
            .Image1(48).left = .FrameSiloFiller(0).left + 56
            .Image1(48).width = 50
            
            .Image1(12).left = .FrameSiloFiller(0).left + 48
            
            .AniPushButtonDeflettore(35).left = .FrameSiloFiller(0).left + 38
            .AniPushButtonDeflettore(35).Value = 1
            
            .AniPushButtonDeflettore(23).left = .FrameSiloFiller(0).left + 106
            
            If ListaMotori(MotoreCocleaRitorno).presente Then
                .Image1(48).top = .FrameSiloFiller(0).top - 80
                .Image1(12).top = .FrameSiloFiller(0).top - 80
                .AniPushButtonDeflettore(35).top = .FrameSiloFiller(0).top - 60
                .AniPushButtonDeflettore(23).top = .FrameSiloFiller(0).top - 97
            Else
                .Image1(48).top = .FrameSiloFiller(0).top - 60
                .Image1(12).top = .FrameSiloFiller(0).top - 60
                .AniPushButtonDeflettore(35).top = .FrameSiloFiller(0).top - 40
                .AniPushButtonDeflettore(23).top = .FrameSiloFiller(0).top - 77
            End If
        ElseIf GestioneScambioTuboTroppoPieno = DirettoSuF2 Then
            .Image1(48).left = .FrameSiloFiller(1).left + 26
            .Image1(48).width = 24
            .Image1(48).top = .FrameSiloFiller(1).top - 25
            .Image1(12).left = .FrameSiloFiller(1).left + 20
            .Image1(12).top = .FrameSiloFiller(1).top - 25
            .AniPushButtonDeflettore(23).top = .FrameSiloFiller(0).top - 42
            .AniPushButtonDeflettore(23).left = .FrameSiloFiller(1).left + 50
        Else
            .Image1(48).left = .FrameSiloFiller(1).left + 63
            .Image1(48).width = 24
            .Image1(48).top = .FrameSiloFiller(0).top - 60
            .Image1(12).left = .FrameSiloFiller(1).left + 46
            .Image1(12).top = .FrameSiloFiller(0).top - 60
            .AniPushButtonDeflettore(23).left = .FrameSiloFiller(1).left + 80
            .AniPushButtonDeflettore(23).top = .FrameSiloFiller(0).top - 77
            .AniPushButtonDeflettore(35).left = .FrameSiloFiller(1).left + 36
            .AniPushButtonDeflettore(35).Value = 2
            .AniPushButtonDeflettore(35).top = .FrameSiloFiller(0).top - 40
        End If

        '20170331
        .CmdNettiSiloStoricoSommaSalva(0).Visible = ( _
            BilanciaAggregati.ProfiNet Or _
            BilanciaFiller.ProfiNet Or _
            BilanciaLegante.ProfiNet Or _
            BilanciaRAP.ProfiNet Or _
            BilanciaViatop.ProfiNet Or _
            BilanciaViatopScarMixer1.ProfiNet Or _
            BilanciaViatopScarMixer2.ProfiNet _
            )
        '

    End With

'20150707
    If StampaOgniDosaggioNumeroColonne = 0 Then StampaOgniDosaggioNumeroColonne = 80

    separatorPrinterString = ""
    For Index = 0 To StampaOgniDosaggioNumeroColonne - 1
        separatorPrinterString = separatorPrinterString + "-"
    Next Index
'

    CqInit CodaTamburoParallelo, TamburoParallelo_TempoCoda

    'STAMPA CONTINUA
    Dim OldPrinter As Printer
    Set OldPrinter = Printer

    'stampante di default
    Set StampanteDefault = GetDefaultPrinter

    If (InclusioneStampaOgniDosaggio) Then
        Dim NewPrinter As Printer
        For Each NewPrinter In Printers
            If (NewPrinter.DeviceName = StampaOgniDosaggioNomeStampante) Then
                Set StampanteContinua = NewPrinter
                Exit For
            End If
        Next
'20161018
'        '20151119
'        CP240.StatusBar1.Panels(STB_STAMPANTE).Picture = LoadResPicture("IDI_STAMPA", vbResIcon)
'        '
    Else
        StampaOgniDosaggioNomeStampante = ""
    End If
    '

End Sub

'20150708
Public Sub LeggeFileParDosVar()

    Dim nomeFile As String
    Dim nomeSezione As String

    'Legge i dati dal file

    nomeFile = UserDataPath + FileParametriVari

    'Per ora continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    nomeSezione = SEZIONE
    
    GestioneFiller3 = CInt(FileGetValue(nomeFile, nomeSezione, "Filler3SoloSilo", "0"))

End Sub
'

'20150708
Private Sub ScriveFileParDosVar()
    
    Dim nomeFile As String
    Dim nomeSezione As String

'per il momento non viene chiamata da nessuno, i valori vengono solo letti e non scritti

    'Scrive i dati sul file
    
    nomeFile = UserDataPath + FileParametriVari

    'Per ora continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    nomeSezione = SEZIONE
    
    FileSetValue nomeFile, nomeSezione, "Filler3SoloSilo", CStr(GestioneFiller3)

End Sub
'

'20151201
Public Sub LeggeFileParBilCamion()

    Dim nomeFile As String
    Dim nomeSezione As String
    Dim valoreparametro As Variant '20151103
    Dim indice As Integer
    
    'Legge i dati dal file

    nomeFile = UserDataPath + FileParametriBilCamion

    'Per ora continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    nomeSezione = SEZIONE

    'BILANCIA CAMION FULL
    BilanciaPesaCamion.PesaCamionEnLin = (CInt(FileGetValue(nomeFile, nomeSezione, "PesaCamionEnLin", 0)) = 1)

    For indice = 0 To 4
        BilanciaPesaCamion.PesaCamionLinX(indice) = CDbl(FileGetValue(nomeFile, nomeSezione, "PesaCamionLinX" + CStr(indice), 0))
        BilanciaPesaCamion.PesaCamionLinY(indice) = CDbl(FileGetValue(nomeFile, nomeSezione, "PesaCamionLinY" + CStr(indice), 0))
    Next indice

    BilanciaPesaCamion.PesaCamionNumLin = CInt(FileGetValue(nomeFile, nomeSezione, "PesaCamionNumLin", 1))

'    BilanciaPesaCamion.PesaCamionEnFiltro = (CInt(FileGetValue(nomeFile, nomeSezione, "PesaCamionEnFiltro", 0)) = 1)
'    BilanciaPesaCamion.PesaCamionSampleNr = CDbl(FileGetValue(nomeFile, nomeSezione, "PesaCamionSampleNr", 5))
'    BilanciaPesaCamion.PesaCamionSampleTime = CDbl(FileGetValue(nomeFile, nomeSezione, "PesaCamionSampleTime", 500))
    BilanciaPesaCamion.PesaCamionEnScaling = (CInt(FileGetValue(nomeFile, nomeSezione, "PesaCamionEnScaling", 0)) = 1)
        
    BilanciaPesaCamion.PesaCamionScalingAnalogMin = CInt(FileGetValue(nomeFile, nomeSezione, "PesaCamionScalingAnalogMin", 0))
    BilanciaPesaCamion.PesaCamionScalingAnalogMax = CInt(FileGetValue(nomeFile, nomeSezione, "PesaCamionScalingAnalogMax", 27648))
    BilanciaPesaCamion.PesaCamionScalingKgMin = CDbl(FileGetValue(nomeFile, nomeSezione, "PesaCamionScalingKgMin", 0))
'    BilanciaPesaCamion.PesaCamionScalingKgMax = CDbl(FileGetValue(nomeFile, nomeSezione, "PesaCamionScalingKgMax", 50000))
    
'
End Sub

'20151201
Public Sub ScriveFileParBilCamion()

    Dim nomeFile As String
    Dim nomeSezione As String
    Dim indice As Integer
    'Scrive i dati sul file

    nomeFile = UserDataPath + FileParametriBilCamion

    'Per ora continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    nomeSezione = SEZIONE
    
    FileSetValue nomeFile, nomeSezione, "PesaCamionEnLin", CStr(BilanciaPesaCamion.PesaCamionEnLin)
    
    For indice = 0 To 4
        FileSetValue nomeFile, nomeSezione, "PesaCamionLinX" + CStr(indice), CStr(BilanciaPesaCamion.PesaCamionLinX(indice))
        FileSetValue nomeFile, nomeSezione, "PesaCamionLinY" + CStr(indice), CStr(BilanciaPesaCamion.PesaCamionLinY(indice))
    Next indice
        
    FileSetValue nomeFile, nomeSezione, "PesaCamionNumLin", CStr(BilanciaPesaCamion.PesaCamionNumLin)
                
'    FileSetValue nomeFile, nomeSezione, "PesaCamionEnFiltro", CStr(BilanciaPesaCamion.PesaCamionEnFiltro)
'    FileSetValue nomeFile, nomeSezione, "PesaCamionSampleNr", CStr(BilanciaPesaCamion.PesaCamionSampleNr)
'    FileSetValue nomeFile, nomeSezione, "PesaCamionSampleTime", CStr(BilanciaPesaCamion.PesaCamionSampleTime)
    FileSetValue nomeFile, nomeSezione, "PesaCamionEnScaling", CStr(BilanciaPesaCamion.PesaCamionEnScaling)
    FileSetValue nomeFile, nomeSezione, "PesaCamionScalingAnalogMin", CStr(BilanciaPesaCamion.PesaCamionScalingAnalogMin)
    FileSetValue nomeFile, nomeSezione, "PesaCamionScalingAnalogMax", CStr(BilanciaPesaCamion.PesaCamionScalingAnalogMax)
    FileSetValue nomeFile, nomeSezione, "PesaCamionScalingKgMin", CStr(BilanciaPesaCamion.PesaCamionScalingKgMin)
'    FileSetValue nomeFile, nomeSezione, "PesaCamionScalingKgMax", CStr(BilanciaPesaCamion.PesaCamionScalingKgMax)

End Sub
'

