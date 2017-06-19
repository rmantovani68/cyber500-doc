Attribute VB_Name = "ParaTabBruc"
'
'   Gestione dei parametri del bruciatore
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const FileBruciatore As String = "Bruciatore.ini"
Private Const SEZIONE As String = "Bruciatore"
Private Const SEZIONE2 As String = "Bruciatore2"
Private Const SEZIONE_FILTRO As String = "Filtro"

Public AumentoAspirazioneFiltro As Integer
Public PermanenzaAggiuntivaAumentoAspirazione As Integer
Public FaseSpegnimentoBruciatore As Boolean
Public OraStopBruciatore As Long
'
Public ModoRegolazAspirazFiltroConDeprimometroFiltroIN As Boolean 'nome lughissimo, ma almeno si capisce qualcosa
Public ModoRegolazAspirazFiltroConDeprimometroTamburo As Boolean
Public SicurezzaTemperaturaFiltroSw As Boolean 'va a true se la temperatura filtro supera per il tempo impostato la soglia di sicurezza
Public OraSicurezzaTemperaturaFiltroSw As Long
Public SuperamentoSogliaAllarmeTemperaturaFiltro As Boolean


'


'   Lettura del file
Public Function ParaTabBruc_ReadFile() As Boolean

    Dim indice As Integer
    Dim combustibile As Integer
    
    ParaTabBruc_ReadFile = False

    'CYBERTRONIC_PLUS

    NumeroCamereFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "NumeroCamereFiltro"))
'        AbilitaPuliziaFiltro = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "AbilitaPuliziaFiltro"))
    ManualeModulFiltro = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ManualeModulFiltro"))
    ManualeModulAriaFredda = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ManualeModulAriaFredda"))
    TempoPausaFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TempoPausaFiltro"))
    TempoLavoro1Filtro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TempoLavoro1Filtro"))
    TempoLavoro2Filtro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TempoLavoro2Filtro"))
    MinDepressFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "MinDepressFiltro"))
    ModoFunzFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ModoFunzFiltro"))
    PosizioneModulatoreAriaFreddaDigitale = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "PosizioneModulatoreAriaFreddaDigitale"))
    ValoreMinAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ValoreMinAriaFredda"))
    ValoreMaxAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ValoreMaxAriaFredda"))
    ValoreTempLavoroFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ValoreTempLavoroFiltro"))
    ValoreTempMaxFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ValoreTempMaxFiltro"))
    AllarmeDepressioneFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "AllarmeDepressioneFiltro"))
    FondoscalaDeltaDepressione = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "FondoscalaDeltaDepressione"))
    AbilitaControlloPressostatoFiltro = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "AbilitaControlloPressostatoFiltro"))
    InclusioneAriaFredda = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "InclusioneAriaFredda"))
    InclusioneDMR = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "InclusioneDMR"))
    InclusioneSiloFillerRecuperoDMR = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "InclusioneSiloFillerRecuperoDMR"))
    DeltaAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "DeltaAriaFredda"))
    TempoCampAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TempoCampAriaFredda"))
    TempoCorrAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TempoCorrAriaFredda"))
'20150729
    GestioneArrestoLivelliTSF = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "GestioneArrestoLivelliTSF"))
    TimeoutArrestoLivelliTSF = String2Long(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TimeoutArrestoLivelliTSF"))
'
    TemperaturaFiltroFreddo = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TemperaturaFiltroFreddo"))
    TimeoutAllarmeFiltroAltaTempIN = String2Long(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "TimeoutAllarmeFiltroAltaTempIN"))
    ValvolaPreseparatore.abilitato = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "AbilitazioneValvolaPreseparatore"))
    ValvolaPreseparatore.RitardoApertura = String2Long(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "RitardoAperturaValvolaPreseparatore"))
    ValvolaPreseparatore.RitardoChiusura = String2Long(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "RitardoChiusuraValvolaPreseparatore"))
    '20150805
    ValvolaPreseparatoreAnello.abilitato = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "AbilitazioneValvolaPreseparatoreAnello"))
    ValvolaPreseparatoreAnello.RitardoApertura = String2Long(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "RitardoAperturaValvolaPreseparatoreAnello"))
    ValvolaPreseparatoreAnello.RitardoChiusura = String2Long(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "RitardoChiusuraValvolaPreseparatoreAnello"))
    '
    ModoRegolazAspirazFiltroConDeprimometroFiltroIN = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ModoRegolazAspirazFiltroConDeprimometroFiltroIN"))
    ModoRegolazAspirazFiltroConDeprimometroTamburo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "ModoRegolazAspirazFiltroConDeprimometroTamburo"))
    DepressioneFiltroRegolazione.min = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "DepressioneFiltroRegolazioneMin"))
    DepressioneFiltroRegolazione.max = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "DepressioneFiltroRegolazioneMax"))
    SogliaPartenzaFillerizzazione = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "SogliaPartenzaFillerizzazione"))
    SogliaDepMinFillerizzazione = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "SogliaDepMinFillerizzazione"))
    IsteresiDepMinFillerizzazione = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "IsteresiDepMinFillerizzazione"))
    RitardoSpegnimentoCompressoreF1F2 = String2Int(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "RitardoSpegnimentoCompressoreF1F2"))
    '20150818
    CameraEspansioneFillerRecupero = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "CameraEspansioneFillerRecupero"))
    '
    '20151120
    LivelliContinuiCameraEspansioneFillerRecupero = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "LivelliContinuiFillerRecupero"))
    LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme = CInt(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "LivelliContinuiFillerRecuperoMaxPerc", "100"))
    '
    '20151228
    Inclusione3LivDMR = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_FILTRO, "", "", "Inclusione3LivDMR"))
    '
    '<Section Code="Bruciatore">

    ListaTamburi(0).TempoStopBruciatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ValoreTempoStopBruciatore"))

    '
    'ListaTamburi(0).SelezioneCombustibile(0) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SelezioneComb0"))
    'ListaTamburi(0).SelezioneCombustibile(1) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SelezioneComb1"))
    'ListaTamburi(1).SelezioneCombustibile(0) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SelezioneComb0"))
    'ListaTamburi(1).SelezioneCombustibile(1) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SelezioneComb1"))
    ListaTamburi(0).SelezioneCombustibile = String2Fuel(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AlimentazioneSelezionata"))
    ListaTamburi(0).SelezioneCombustibileName = ParameterPlus.GetParameterValue(SEZIONE, "", "", "AlimentazioneSelezionata") '20170327
    '
    '
    'SelezioneStopFiamma(0) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SelezioneStopFiamma0"))
    'SelezioneStopFiamma(1) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SelezioneStopFiamma1"))
    StopFiammaDopoNastri = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TipoStopFiamma"))
    '
    ListaTamburi(0).setTemperaturaScivolo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ValoreSetTempScivolo"))
    ListaTamburi(0).MinDepressioneBruciatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ValoreMinDeprimometro"))
    ListaTamburi(0).ModulatoreFumiTamburo.min = ListaTamburi(0).MinDepressioneBruciatore
    ListaTamburi(0).MaxDepressioneBruciatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ValoreMaxDeprimometro"))
    ListaTamburi(0).ModulatoreFumiTamburo.max = ListaTamburi(0).MaxDepressioneBruciatore
    NumeroLettureDepressione = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumeroLettureDepressione"))
    AumentoAspirazioneFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AumentoAspirazioneFiltro"))
    PermanenzaAggiuntivaAumentoAspirazione = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "PermanenzaAggiuntivaAumentoAspirazione"))
    AbilitaSondaAggiuntivaUscitaTamburo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SondaAggiuntivaUscitaTamburo"))
    MinTempEssicatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinTempEssicatore"))
    MaxTempEssicatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxTempEssicatore"))

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)
    'FattoreDiCorrezioneKp = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FattoreDiCorrezioneKp"))
    'TInterventoCampionamento = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TInterventoCampionamento"))
    'FattoreDiCorrezioneKd = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FattoreDiCorrezioneKd"))
    'FattoreDiCorrezioneKi = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FattoreDiCorrezioneKi"))

    ListaTamburi(0).AbilitazioneConsumoCombustibile = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitazioneConsumoCombustibile"))
    ListaTamburi(0).ImpulsiPerLitroCombustibile = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ParametroImpulsiLitroComb"))

    NumeroLettureScivolo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumeroLettureScivolo"))

    MaxTempSpruzzatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxTempSpruzzatura"))
    TempoPermanenza_AllarmeTemperaturaScivolo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoPermanenza_AllarmeTemperaturaScivolo"))

    AbilitaTemperaturaIngressoTamburo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaTemperaturaIngressoTamburo"))

    ValoreTempoOnRegolazioneAspirazioneFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ValoreTempoOnRegolazioneAspirazioneFiltro"))
    ValoreTempoOffRegolazioneAspirazioneFiltro = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ValoreTempoOffRegolazioneAspirazioneFiltro"))

    VisualizzaTempScambComb = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "VisualizzaTempScambComb"))
    
    ListaTamburi(0).EsclusioneAvviamentoCaldo = Not String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneAvvCaldo"))

    '<Paragraph Code="Bruciatore2">
    '<Presente />

    '
    ListaTamburi(1).SelezioneCombustibile = String2Fuel(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "AlimentazioneSelezionata"))
    '
    ListaTamburi(1).SelezioneCombustibileName = ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "AlimentazioneSelezionata") '20170327

    ListaTamburi(1).EsclusioneAvviamentoCaldo = Not String2Bool(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "InclusioneAvvCaldoParDrum"))
    ListaTamburi(1).TempoStopBruciatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "ValoreTempoStopBruciatore2"))
    ListaTamburi(1).MinDepressioneBruciatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "ValoreMinDeprimometro"))
    ListaTamburi(1).ModulatoreFumiTamburo.min = ListaTamburi(1).MinDepressioneBruciatore
    ListaTamburi(1).MaxDepressioneBruciatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "ValoreMaxDeprimometro"))
    ListaTamburi(1).ModulatoreFumiTamburo.max = ListaTamburi(1).MaxDepressioneBruciatore
    ListaTamburi(1).TemperatCriticaFumiTamburoOUT = String2Long(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "TemperatCriticaFumiRiciclato"))
    ListaTamburi(1).TempoAllTemperatCriticaFumiTamburoOUT = String2Long(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "TempoAllTemperatCriticaFumiRiciclato"))

    MinTempEssicatore2 = String2Long(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "MinTempEssicatore2"))
    MaxTempEssicatore2 = String2Long(ParameterPlus.GetParameterValue(SEZIONE, SEZIONE2, "", "MaxTempEssicatore2"))

    '20170202
    GestioneVelocitaTamburo.Inclusione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneGestioneVelTamburo"))
    GestioneVelocitaTamburo.MaxVelocita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxVelTamburo"))
    GestioneVelocitaTamburo.DefaultVelocita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "DefVelTamburo"))
    '20170202
    
    '20161128
    GestioneFumiTamburo.Inclusione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneGestioneFumi"))
    GestioneFumiTamburo.Fondoscala_depr_vaglio = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FondoScalaDeprVaglio"))
    GestioneFumiTamburo.Riscalatura_mod_fumi_tamb = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RiscalaturaModTamburo"))
    '20161128

    '20170215
    ''20161130
    'GestioneVelocitaTamburo.Inclusione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneGestioneVelTamburo"))
    'GestioneVelocitaTamburo.MaxVelocita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxVelTamburo"))
    ''20161130
    '

    '20161230
    'Call LeggiParametriBruciatorePID
    ListaTamburi(0).BAP_GuadDiffTemp = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "GuadDiffTemp"))
    ListaTamburi(0).BAP_GuadAmplMod = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "GuadAmplMod"))
    ListaTamburi(0).BAP_GuadDiffUmidita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "GuadDiffUmidita"))
    ListaTamburi(0).BAP_RitRegModVerg = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "RitRegModVerg"))
    ListaTamburi(0).BAP_AntRegModRicicl = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "AntRegModRicicl"))
    ListaTamburi(0).BAP_AttesaSuRegolSucc = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "AttesaSuRegolSucc"))
    ListaTamburi(0).BAP_LimiteMinDiTempPerCorr = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "LimiteMinDiTempPerCorr"))
    ListaTamburi(0).BAP_UMediaAlTest = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "UMediaAlTest"))
    ListaTamburi(0).BAP_TempEssAlTest = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "TempEssAlTest"))
    ListaTamburi(0).BAP_TempStartUscEssic = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "TempStartUscEssic"))
    ListaTamburi(0).BAP_PercIncrPrimaAccens = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "PercIncrPrimaAccens"))
    ListaTamburi(0).BAP_CorrManSetPosMod = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico", "", "CorrManSetPosMod"))

    For combustibile = 0 To 2
        For indice = 0 To 10
            ListaTamburi(0).BAP_RapportoPortataModulatore(combustibile, indice) = String2Double( _
                ParameterPlus.GetParameterValue( _
                    SEZIONE, _
                    "BruciatoreAutomatico", _
                    "RapportoPortataModulatore" + CStr(combustibile), _
                    "Percentuale" + CStr(indice) _
                    ) _
                )
        Next indice
    Next combustibile
    '
    '20161230
    ListaTamburi(1).BAP_GuadDiffTemp = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "GuadDiffTemp"))
    ListaTamburi(1).BAP_GuadAmplMod = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "GuadAmplMod"))
    ListaTamburi(1).BAP_GuadDiffUmidita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "GuadDiffUmidita"))
    ListaTamburi(1).BAP_RitRegModVerg = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "RitRegModVerg"))
    ListaTamburi(1).BAP_AntRegModRicicl = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "AntRegModRicicl"))
    ListaTamburi(1).BAP_AttesaSuRegolSucc = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "AttesaSuRegolSucc"))
    ListaTamburi(1).BAP_LimiteMinDiTempPerCorr = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "LimiteMinDiTempPerCorr"))
    ListaTamburi(1).BAP_UMediaAlTest = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "UMediaAlTest"))
    ListaTamburi(1).BAP_TempEssAlTest = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "TempEssAlTest"))
    ListaTamburi(1).BAP_TempStartUscEssic = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "TempStartUscEssic"))
    ListaTamburi(1).BAP_PercIncrPrimaAccens = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "PercIncrPrimaAccens"))
    ListaTamburi(1).BAP_CorrManSetPosMod = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "BruciatoreAutomatico2", "", "CorrManSetPosMod"))

    For combustibile = 0 To 2
        For indice = 0 To 10
            ListaTamburi(1).BAP_RapportoPortataModulatore(combustibile, indice) = String2Double( _
                ParameterPlus.GetParameterValue( _
                    SEZIONE, _
                    "BruciatoreAutomatico2", _
                    "RapportoPortataModulatore" + CStr(combustibile), _
                    "Percentuale" + CStr(indice) _
                    ) _
                )
        Next indice
    Next combustibile
    '

    ParaTabBruc_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabBruc_Apply()

    With CP240

        .GaugeLivelloFiller(0).Visible = InclusioneDMR
        .GaugeLivelloFiller(1).Visible = InclusioneDMR
        .GaugeLivelloFiller(2).Visible = InclusioneDMR And Inclusione3LivDMR '20151228

        .GaugeLivelloFiller(0).top = 162
        .GaugeLivelloFiller(1).top = 162
'20151228
        .GaugeLivelloFiller(2).top = 162

'20161124
'        .GaugeLivelloFiller(0).left = 504
        .GaugeLivelloFiller(0).left = 520
'
        .GaugeLivelloFiller(2).left = .GaugeLivelloFiller(0).left + 40
        .GaugeLivelloFiller(1).left = .GaugeLivelloFiller(2).left + 40

        .Frame1(31).top = 178
        .Frame1(64).top = 178
        .Frame1(32).top = 178
        
'20161124
'        .Frame1(31).left = 496
        .Frame1(31).left = 513
'
        .Frame1(64).left = .Frame1(31).left + 40
        .Frame1(32).left = .Frame1(64).left + 40
'

        .Frame1(60).Visible = InclusioneAriaFredda

        .Image1(31).Visible = AbilitaSondaAggiuntivaUscitaTamburo
        .LblTempMateriale(3).Visible = AbilitaSondaAggiuntivaUscitaTamburo

        .LblDepressioneBruc(1).Visible = AbilitaControlloPressostatoFiltro
        .LblEtichetta(190).Visible = AbilitaControlloPressostatoFiltro


        .CmdNettiSiloStoricoSommaSalva(15).Visible = ListaTamburi(0).AbilitazioneConsumoCombustibile
        .CmdNettiSiloStoricoSommaSalva(14).Visible = ListaTamburi(1).AbilitazioneConsumoCombustibile

        .LblEtichetta(29).Visible = AbilitaPuliziaFiltro
        .LblEtichetta(29).caption = ""

        .LblEtichetta(50).Visible = AbilitaTemperaturaIngressoTamburo
        .Image10(13).Visible = AbilitaTemperaturaIngressoTamburo
        .LblTempMateriale(4).Visible = AbilitaTemperaturaIngressoTamburo

        ControlloPuliziaFiltro

        'Se è cambiato il combustibile occorre ri-verificare gli allarmi
        Call AllarmeCombustibile(0, True)
        Call AllarmeCombustibile(1, True)

        If (ListaTamburi(0).ImpulsiPerLitroCombustibile <= 0) Then
            .lblLitriCombUtilizzati(0).caption = "0"
        End If
        If (ListaTamburi(1).ImpulsiPerLitroCombustibile <= 0) Then
            .lblLitriCombUtilizzati(1).caption = "0"
        End If
        
        'Visualizzazione Temperatura scambiatore Combustibile

        CP240.LblTempScambComb.Visible = (VisualizzaTempScambComb And ListaTamburi(0).SelezioneCombustibile <> CombustibileGas)
        CP240.ImageTempScambComb.Visible = (VisualizzaTempScambComb And ListaTamburi(0).SelezioneCombustibile <> CombustibileGas)
        CP240.lblEtichettaTempScambComb.Visible = (VisualizzaTempScambComb And ListaTamburi(0).SelezioneCombustibile <> CombustibileGas)
        
        AbilitaPuliziaFiltro = (ModoFunzFiltro > 0)

        '20151209
        If ListaTamburi(0).AbilitazioneConsumoCombustibile Then
            .FrameBruciatore(0).Height = 82
        Else
            .FrameBruciatore(0).Height = 45
        End If
        
        .adoDBMatCombust.Visible = ListaTamburi(0).AbilitazioneConsumoCombustibile
        '

        '20170331
        Call AggiornaGraficaValvolaCombustibile_Change
        '

    End With

End Sub


Private Function String2Fuel(fuel As String) As FuelType

    Select Case Null2Qualcosa(fuel)
        Case "Gas"
            String2Fuel = CombustibileGas
            Exit Function

        Case "Gasolio"
            String2Fuel = CombustibileGasolio
            Exit Function

        Case "OlioComb"
            String2Fuel = CombustibileOlioCombustibile
            Exit Function
    End Select
    
    String2Fuel = CombustibileGas
End Function
