Attribute VB_Name = "ParaTabGeneral"
'
'   Gestione dei parametri generali
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit



Private oldLangSelected As Integer

'   File di memorizzazione dei dati generali
Private Const SEZIONE As String = "Generali"



'   Lettura del file
Public Function ParaTabGeneral_ReadFile() As Boolean

    'Dim nomeFile As String


    ParaTabGeneral_ReadFile = False

    'CYBERTRONIC_PLUS

    oldLangSelected = LinguaSelezionata

    '20150408
    'LinguaSelezionata = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Lingua"))
    LinguaSelezionata = ConvertPlusLanguages(String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Lingua")))
    '
'        TastieraSelezionata = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Tastiera"))
'        TipoImpianto = ParameterPlus.GetParameterValue(SEZIONE, "", "", "TipoImpianto")
    Commessa = ParameterPlus.GetParameterValue(SEZIONE, "", "", "Commessa")
    PortaComLCPC = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "PortaComLCPC"))
    InclusioneLCPC = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneLCPC"))
    InclusioneWindQual = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneWindQual"))
    'AbilitaConsumiMateriali = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaConsumiMateriali"))
    AbilitaAllarmeCicalino = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaAllarmeCicalino"))
    AbilitaSirenaAvvioImpianto = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaSirenaAvvioImpianto"))
'20150112
    TempoOnSirena = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoOnSirena"))
    TempoOffSirena = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoOffSirena"))
    TempoAttesaRiavvioSirena = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoAttesaRiavvioSirena"))
'
    AbilitaPressioneAriaImpianto = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "PressioneAriaImpianto"))
    MinScalaPressioneAriaImpianto = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinScalaPressioneAriaImpianto"))
    MaxScalaPressioneAriaImpianto = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxScalaPressioneAriaImpianto"))
    'AbilitaLogoMarini = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaLogoMarini"))
    AbilitaManutenzioni = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaManutenzioni"))
    AbilitaConsumoEnergia = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaEnergy"))
    EsclusioneGestioneBruciatore = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "EsclusioneGestioneBruciatore"))
    EsclusioneGestioneFiltro = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "EsclusioneGestioneFiltro"))
'        AbilitaPasswordRicette = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaPasswordRicette"))
'        PasswordRicette = ParameterPlus.GetParameterValue(SEZIONE, "", "", "PasswordRicette")

    ParaTabGeneral_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabGeneral_Apply()

    Dim Errore As Boolean


    If (oldLangSelected <> LinguaSelezionata) Then
        TranslationsLoaded = False
    End If

    Call CaricaTraduzioni

    oldLangSelected = LinguaSelezionata

    With CP240

        'Abilitazione della pressione dell'aria dell'impianto
        .lblEtichetta(196).Visible = AbilitaPressioneAriaImpianto
        .lblEtichetta(82).Visible = AbilitaPressioneAriaImpianto

        CAPTIONSTARTSIMPLE = "MARINI"
        CaptionStart = CAPTIONSTARTSIMPLE + " - "

'        If (InclusioneLCPC) Then
'
'            'Controllo se la porta COM scelta è corretta
'            Errore = False
'
'            .LCPC.CommPort = PortaComLCPC
'            If Not .LCPC.ClosePort Then
'                Errore = True
'            End If
'            If .LCPC.IsPortOpen Then
'                Errore = True
'            End If
'            If Not .LCPC.OpenPort Then
'                Errore = True
'            End If
'            If Not .LCPC.WritePort("TEST MARINI") Then
'                Errore = True
'            End If
'            .LCPC.ClearBuffer
'            .LCPC.ClosePort
'            If Errore Then
'                ShowMsgBox LCPCmsg + " " + LoadXLSString(805) + " ", vbOKOnly, vbExclamation, -1, -1, True
'            Else
'                .LCPC.CommPort = PortaComLCPC
'            End If
'            '
'        End If

        .Frame1(28).Visible = Not EsclusioneGestioneFiltro
        .Frame1(30).Visible = Not EsclusioneGestioneBruciatore
        .CmdStartBruc(0).Visible = Not EsclusioneGestioneBruciatore
        .CmdStopBruc(0).Visible = Not EsclusioneGestioneBruciatore
        .LblDepressioneBruc(0).Visible = Not EsclusioneGestioneBruciatore
        .lblEtichetta(112).Visible = Not EsclusioneGestioneBruciatore
        .Frame1(50).Visible = Not EsclusioneGestioneBruciatore
        .CmdStopBruc(1).Visible = Not EsclusioneGestioneBruciatore
        .LblDepressioneBruc(1).Visible = Not EsclusioneGestioneBruciatore

        '20160412
        '.imgPulsanteForm(TBB_MANUTENZIONI).Visible = AbilitaManutenzioni
        .imgPulsanteForm(TBB_MANUTENZIONI).Visible = (AbilitaManutenzioni And Not Plus2Monitor)
        '

        Call SetPlantInfoString("MaintenanceEnable", CStr(AbilitaManutenzioni))

'20161020
        .StatusBar1.Panels(STB_DATA).Picture = CP240.PlusImageList(1).ListImages("CALENDAR").Picture
        .StatusBar1.Panels(STB_ORA).Picture = CP240.PlusImageList(1).ListImages("CLOCK").Picture
        
        If Not InclusioneLCPC Then
            Call CP240StatusBar_Change(STB_LCPC, 99)
        End If
'



    End With

End Sub

