Attribute VB_Name = "ParaTabVarie"
'
'   Gestione dei parametri della varie
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE_PLUS As String = "RiscalaturaValori"
Private Const SEZIONE_PLUS1 As String = "CorrezioneMisure"


'   Lettura del file
Public Function ParaTabVarie_ReadFile() As Boolean

    Dim Index As Integer


    ParaTabVarie_ReadFile = False

    'CYBERTRONIC_PLUS

    MassimoPosModulatorePLC = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura0", "", "MassimoPosModulatorePLC"))
    MinimoPosModulatorePLC = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura0", "", "MinimoPosModulatorePLC"))
    MassimoPosAspPLC = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura1", "", "MassimoPosAspPLC"))
    MinimoPosAspPLC = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura1", "", "MinimoPosAspPLC"))
    MassimoAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura2", "", "MassimoAriaFredda"))
    MinimoAriaFredda = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura2", "", "MinimoAriaFredda"))

    ListaTamburi(0).MassimoModulatoreTamburo = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura4", "", "MassimoModulatoreTamburo1"))
    ListaTamburi(0).MinimoModulatoreTamburo = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura4", "", "MinimoModulatoreTamburo1"))
    ListaTamburi(1).MassimoModulatoreTamburo = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura5", "", "MassimoModulatoreTamburo2"))
    ListaTamburi(1).MinimoModulatoreTamburo = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura5", "", "MinimoModulatoreTamburo2"))
    MassimoModulatoreBruciatoreTamburo2 = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura6", "", "MassimoModulatoreBruciatoreTamburo2"))
    MinimoModulatoreBruciatoreTamburo2 = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura6", "", "MinimoModulatoreBruciatoreTamburo2"))

    MassimoFSDeprimometroFiltroIN = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura7", "", "MassimoFSDeprimometroFiltroIN"))
    ListaTamburi(0).MassimoFSDeprimometroTamburo = String2Long(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura8", "", "MassimoFSDeprimometroTamburo0"))
    ListaTamburi(1).MassimoFSDeprimometroTamburo = String2Long(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura9", "", "MassimoFSDeprimometroTamburo1"))

    For Index = 0 To TempMax - 1
        ListaTemperature(Index).Correzione = String2Long(ParameterPlus.GetParameterValue(SEZIONE_PLUS1, "Correzione" + CStr(Index), "", "CorrezioneTemperatura"))
        ListaTemperature(Index).FondoScalaMin = String2Long(ParameterPlus.GetParameterValue(SEZIONE_PLUS1, "Correzione" + CStr(Index), "", "FondoScalaMinTemperatura"))
        ListaTemperature(Index).FondoScalaMax = String2Long(ParameterPlus.GetParameterValue(SEZIONE_PLUS1, "Correzione" + CStr(Index), "", "FondoScalaMaxTemperatura"))
        ListaTemperature(Index).MilliAmpere420 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS1, "Correzione" + CStr(Index), "", "MilliAmpere420"))
    Next Index

    MassimoModulatoreRAP = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura3", "", "MassimoModulatoreRAP"))
    MinimoModulatoreRAP = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura3", "", "MinimoModulatoreRAP"))

    For Index = 0 To 7
        LivelloRiscalaMinTramoggia(Index) = ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura" + CStr(Index + 10), "", "LivelloRiscalaMinTramoggia" + CStr(Index))
        LivelloRiscalaMaxTramoggia(Index) = ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura" + CStr(Index + 10), "", "LivelloRiscalaMaxTramoggia" + CStr(Index))
    Next Index

    Index = 18
    LivelloRiscalaMinTramoggia(Index) = ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura" + CStr(Index), "", "LivelloRiscalaMinTramoggia" + CStr(Index))
    LivelloRiscalaMaxTramoggia(Index) = ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura" + CStr(Index), "", "LivelloRiscalaMaxTramoggia" + CStr(Index))

    For Index = 0 To 3
        LivelloRiscalaMinFiller(Index) = ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura" + CStr(Index + 19), "", "LivelloRiscalaMinFiller" + CStr(Index))
        LivelloRiscalaMaxFiller(Index) = ParameterPlus.GetParameterValue(SEZIONE_PLUS, "Riscalatura" + CStr(Index + 19), "", "LivelloRiscalaMaxFiller" + CStr(Index))
    Next Index

    ParaTabVarie_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabVarie_Apply()

    Call ModulatoreBruciatore_change(0)
    Call ModulatoreBruciatore_change(1)
    Call ModulatoreAspFiltro_change

End Sub

