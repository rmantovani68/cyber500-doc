Attribute VB_Name = "GestioneMessaggistica"
Option Explicit
  
Private OraStartComunicazioneManut As Long
  
Public Enum Messaggistica
'    ShowManutenzioni = 1
'    HideManutenzioni = 3
'    ExitManutenzioni = 5
'    OreDiLavoro = 7
'    StatoManutenzioni = 9

    PlusSendShowFEEDERRECIPE = 101
    PlusSendShowDOSINGRECIPE = 103
    PlusSendShowSTORICO = 105
    PlusSendShowTOTALI = 107
    PlusSendShowCONSUMOMATERIALI = 109
    PlusSendShowALLARMI = 111
    PlusSendShowTREND = 113
    PlusSendShowENERGIA = 115
    PlusSendShowPARAMETRI = 117
    PlusSendShowPASSWORD = 119
    PlusSendShowABOUT = 121
    PlusSendShowPLCIO = 123
    PlusSendShowCLIENTI = 125
    PlusSendActiveFeederRecipeID = 127
    PlusSendActiveDosingRecipeNextID = 129
    PlusSendActiveDosingRecipeHopperID = 131
    PlusSendActiveDosingRecipeMixerID = 133
    PlusSendTonPerHour = 135
    PlusSendShowFeederCalibration = 137
    PlusSendMotorInstart = 139
    PlusSendFeederInStart = 141
    PlusSendDosingInStart = 143
    PlusSendShowStoricoPredosaggio = 145
    PlusSendWatchDog = 147
    PlusSendActiveCustomerID = 149
    PlusSendShowSCARICHISILI = 151
    PlusSendShowSILODISCHARGEMANAGER = 153
    PlusSendShowSTORICOIMPMANUALI = 155
    PlusSendShowMAINTENANCE = 161
    PlusSendGetPendingMaintenances = 163
    PlusSendWorkingHours = 165
    '20150820
    PlusSendShowDosingMaterial = 169
    '
    '20170220
    PlusSendShowDosingHistoryByDay = 170
    '
        
    '20160512
    PlusSendKeyPressAndMouseMove = 171
    '20160927
    PlusSendShowHelp = 173
    '
    PlusSendParametersFromPlc = 175  '20161024
    
    '20161124
    TrendRunTimeValue = 177
    '
    
    PlusSendShowJOBRECIPE = 179 '20170104

    PlusSendSWVersion = 195
    PlusSendLogoff = 197
    PlusSendClose = 199

    PlusRecvRefreshFeederRecipeList = 201
    PlusRecvRefreshDosingRecipeList = 203
    PlusRecvActivePassword = 205
    PlusRecvParameterModified = 207
    PlusRecvWindowVisible = 209
    PlusRecvWatchDog = 211
    PlusRecvRefreshCustomerList = 213
    PlusRecvPesoScaricatoSilo = 215
    PlusRecvRicettaPredosaggioModificata = 217
    PlusRecvRicettaDosaggioModificata = 219
    PlusRecvRefreshMaterialList = 221
    PlusRecvPendingMaintenances = 225

    HLKeyNotFound = 223
    BeginStopProcedure = 227

    '20160412
    PlusRecv2Monitor = 229
    PlusRecvShowFeederRecipe = 231
    PlusRecvShowDosingRecipe = 233
    PlusRecvSelectFeederRecipeS = 235
    PlusRecvSelectDosingRecipeS = 237
    '

    '20161124
    PlusRecvTrendRunTimeEnable = 239
    PlusRecvTrendRunTimeDisable = 241
    '

    '20161223
    PlusRecvJobMsg = 243
    PlusSendJobMsg = 245
    '
    
End Enum
'

Public CSharpInCommunication As Boolean

'Routine che comunica ogni 60 secondi con il registro dedicato alle manutenzioni
Public Sub ComunicazioneConManutenzioni()
    Dim OraAttuale As Long
    Dim oreLavoroFiltro As Long

    If Not AbilitaManutenzioni Then
        Exit Sub
    End If

    OraAttuale = ConvertiTimer()

    If (OraAttuale - OraStartComunicazioneManut > 60) Then    'leggo e scrivo il registro ogni 60 secondi

        OraStartComunicazioneManut = OraAttuale

        oreLavoroFiltro = ListaMotori(MotoreAspiratoreFiltro).MinutiLavoroTot / 60

        'comunico al software delle manutenzioni le ore di lavoro del filtro
        Call SendMessagetoPlus(PlusSendWorkingHours, CStr(oreLavoroFiltro))
        'invio la richiesta al software delle manutenzioni la richiesta per lo stato delle manutenzioni
        Call SendMessagetoPlus(PlusSendGetPendingMaintenances, 0)

    End If

End Sub

'Gestione Comunicazione Cybertronic Plus con Socket
Public Sub InitConnection()
    'server
    CP240.Server.Listen

    'Client
    CP240.Client.Connect
    If (CP240.Client.State <> sckConnected) Then
        FrmGestioneTimer.TimerComunicazionePLUS.enabled = True
    End If
End Sub
   
Public Sub SendMessagetoPlus(item As String, Value As String)

On Error GoTo Errore

    If (CSharpInCommunication Or item = PlusSendWatchDog) Then '20160406
        Call CP240.Client.SendData(item + "$" + Value + "&")
    End If  '20160406
    'CP240.Client.SendData ("")
Errore:
'fare qualcosa?
End Sub

'20151030
'Public Sub GetMessage()
Public Sub GetMessage(messageReceived As String)
'
'20151030
'    Dim errOn As Boolean
'    Dim indice As Integer
'    Dim messageReceived As String
'    Dim message As String
'    Dim messagessplitted() As String
'    Dim msgcode As Integer
''
''20150610
'    Dim BookDos As Integer
'    Dim BookDosNext As Integer
''
'

    '20151030
    'CP240.Server.GetData messageReceived, vbString
    '
    
'20151008
'    messageReceived = Replace(messageReceived, "&", "")
'
'    messagessplitted = Split(messageReceived, "$")
'    msgcode = CInt(messagessplitted(0))
'    message = messagessplitted(1)
    
    Call SplitMessage(messageReceived)
'fine 20151008
        
End Sub
    
'20151008
Private Sub SplitMessage(message As String)

    Dim Index As Integer
    Dim appoggio As String
    Dim messagessplitted() As String

    appoggio = ""
            
    For Index = 1 To Len(message)
                                
        If Mid(message, Index, 1) = "&" Then
            messagessplitted = Split(appoggio, "$")
            Call GetSingleMessage(CInt(messagessplitted(0)), messagessplitted(1))
            appoggio = ""
        Else
            appoggio = appoggio + Mid(message, Index, 1)
        End If
    
    
    Next Index
    
End Sub
             
'20151008
Sub GetSingleMessage(msgcode As Integer, message As String)
    
    Dim errOn As Boolean
    Dim indice As Integer
      
    Select Case msgcode

        Case PlusRecvPendingMaintenances
            For indice = 0 To 12
                'ricevo un numero intero che trasformato in binario contiene le info sullo stato delle manutenzioni (13 bit utili)
                errOn = ((message And 2 ^ indice) <> 0)
                Call IngressoAllarmePresente(DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "MA" + Format(indice + 1, "000"), "IdDescrizione"), errOn)
            Next indice

        Case PlusRecvRefreshFeederRecipeList
            Call RinfrescaOrigineDatiPredosaggio(CP240.adoComboPredosaggio.text, True)
            Call VisualizzaBarraPulsantiCP240(True)

        Case PlusRecvRefreshDosingRecipeList
'20160229
            Call RinfrescaNomeRicDosaggio
'
            Call RinfrescaOrigineDatiDosaggio(CP240.LblNomeRicDos(0).caption)

        Case PlusRecvActivePassword
            '20150409
            'CP240.StatusBar1.Panels(STB_UTENTE).text = IIf( _
            '    message = UsersEnum.OPERATOR, _
            '    "OPERATOR", _
            '    IIf( _
            '        message = UsersEnum.MANAGER, _
            '        "MANAGER", _
            '        IIf(message = UsersEnum.ADMINISTRATOR, "ADMINISTRATOR", IIf(message = UsersEnum.SUPERUSER, "SUPERUSER", "")) _
            '        ) _
            '    )
            'ActiveUser = message
            '
            'CP240.imgPulsanteForm(TBB_LOGIN).Picture = CP240.PlusImageList.ListImages(IIf((ActiveUser = NONE), "PLUS_IMG_LOGIN", "PLUS_IMG_LOGOFF")).Picture
            '
            'If (FrmSiwarexParaVisibile) Then
            '    Call FrmSiwarexPara.PasswordLevel
            '    Call FrmSiwarexPara.UpdatePulsantiForm
            'ElseIf (FrmMotoriVisibile) Then
            '    Call AvvMotori.UpdatePulsantiForm
            'ElseIf (FrmSiloGeneraleVisibile) Then
            '    Call FrmSiloGenerale.PasswordLevel
            '    Call FrmSiloGenerale.UpdatePulsantiForm
            'End If
                        
            Call SetActiveUser(message)
            '

        Case PlusRecvParameterModified
            Call ParameterPlus.FileReload
            Call ParametriReadFile
            Call ParametriApply

        Case PlusRecvWindowVisible
            Call VisualizzaBarraPulsantiCP240((Null2String(message) = "False"))
'
        Case PlusRecvWatchDog
            '20150409
            PlusWatchDogTimeoutTimer = 0
            If (PlusCommunicationBroken) Then
                '20160318
                'PlusCommunicationBroken = False
                'Call SetAllarmePresente("VA006", False)
                'Call VisualizzaBarraPulsantiCP240(True)
                Call SetPlusCommunicationBroken(False)
                '
            End If
            
        '20161014
            Call CP240StatusBar_Change(STB_WATCHDOGCS, True)
            
'            '
'            '20151119
''            CP240.StatusBar1.Panels(STB_WATCHDOGCS).Picture = LoadResPicture("IDI_LEDVERDE", vbResIcon)
'            CP240.StatusBar1.Panels(STB_WATCHDOGCS).Picture = LoadResPicture("IDB_MSDN", vbResBitmap) '20151214
'            '20160502
'            'CSharpInCommunication = True '20160406
'            '
'            '20151119

        Case PlusRecvRefreshCustomerList
            Call RinfrescaOrigineDatiClienti(CP240.AdoComboClienti.text)
            Call RinfrescaOrigineDatiClientiCamion(CP240.AdoComboClientiCamion.text) '20151201
        Case PlusRecvRefreshMaterialList
            CP240.AdoMaterialiLog.Refresh
'20150512
            CP240.adoMatBitume.Refresh
            For indice = 0 To (CistGestione.NumCisterneBitume - 1)
                CP240.adoDBMatCist(indice).ReFill
            Next indice
'
'20151204
            If ListaTamburi(0).AbilitazioneConsumoCombustibile Then
                CP240.adoMatCombust.Refresh
                CP240.adoDBMatCombust.ReFill
            End If
'
        
        Case PlusRecvPesoScaricatoSilo
            Call ScaricoSiloSenzaCelleCarico(message)

        Case PlusRecvRicettaPredosaggioModificata
            
'20150610
'            CP240.AdoPredosaggio.Refresh '20150514
            
            Call RinfrescaNomeRicPreDosaggio    '20160301
            
            '20160907
            'If (val(CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio").Value) = Null2Qualcosa(message)) Then
            If (val(CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio").Value) = Null2Qualcosa(message)) And CP240.adoComboPredosaggio.text <> "" Then
                If (ShowMsgBox(LoadXLSString(31), vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
                    RichiamoRicettaPredos
                End If
            End If
'
        Case PlusRecvRicettaDosaggioModificata
'20150610
'            CP240.AdoDosaggio.Refresh '20150514
'            CP240.AdoDosaggioNext.Refresh '20150514
'
'            If (val(CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value) = Null2Qualcosa(message)) Then
'                RicettaInUsoModificata = True
'            End If

            If (val(CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value) = Null2Qualcosa(message)) Then
                RicettaInUsoModificata = True
'20160229
                Call RinfrescaNomeRicDosaggio
                Call SelezionaRicettaDosaggio
                Call CheckContenutoSili
'
            Else
                '20150703
                'BookDos = CP240.AdoDosaggio.Recordset.Bookmark
                'BookDosNext = CP240.AdoDosaggioNext.Recordset.Bookmark
                '
                'CP240.AdoDosaggio.Refresh
                'CP240.AdoDosaggioNext.Refresh
                '
                'CP240.AdoDosaggio.Recordset.MoveFirst
                'Do Until ((val(CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value) = BookDos) Or CP240.AdoDosaggio.Recordset.EOF)
                '    CP240.AdoDosaggio.Recordset.MoveNext
                'Loop
                '
                'CP240.AdoDosaggioNext.Recordset.MoveFirst
                'Do Until ((val(CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value) = BookDosNext) Or CP240.AdoDosaggioNext.Recordset.EOF)
                '    CP240.AdoDosaggioNext.Recordset.MoveNext
                'Loop
'20160229
                Call RinfrescaNomeRicDosaggio
'
                If CP240.adoComboDosaggio.text <> "" Then
                    Call RinfrescaOrigineDatiDosaggio(CP240.AdoDosaggio.Recordset.Fields("Descrizione").Value)
                End If
                '
            End If
'

        Case BeginStopProcedure
            HardKeyRemoved = True
            Call PlusForceStop

        Case HLKeyNotFound
            If (message = "True") Then
                Call VisualizzaBarraPulsantiCP240(False)
            Else
                Call VisualizzaBarraPulsantiCP240(True)
            End If

        '20160412
        Case PlusRecv2Monitor
            '20160512
            If (Plus2Monitor <> (message = "1" Or message = "True")) Then
            '
                Plus2Monitor = (message = "1" Or message = "True")
                Call CP240.AggiustaMonitor
            End If

        Case PlusRecvShowFeederRecipe
            '20160422
            Call CP240.ManageTopBarButton(TBB_PREDOSAGGIO)
            '
        Case PlusRecvShowDosingRecipe
            '20160422
            Call CP240.ManageTopBarButton(TBB_DOSAGGIO)
            '
        '
        '20160422
        Case PlusRecvSelectFeederRecipeS
            '20160512
            Call SelectFeederRecipeByCS(String2Int(message))
            '

        Case PlusRecvSelectDosingRecipeS
            Call SelectDosingRecipeByCS(String2Int(message))
        '
        '20160901
        Case PlusSendWorkingHours
            Call ComunicazioneConManutenzioni
        '
        
        '20161124
        Case PlusRecvTrendRunTimeEnable
            Call TrendSetRunTimeCs(String2Int(message), True)

        Case PlusRecvTrendRunTimeDisable
            Call TrendSetRunTimeCs(String2Int(message), False)
        '
        '20170103
        Case PlusRecvJobMsg
            Call LeggiMessaggioJobXML(message)
        '
        
        '20151008
        Case Else
            LogInserisci True, "MSG-001", "Codice messaggio da C# non riconosciuto: " + CStr(msgcode)
        '
    End Select
    
'    Debug.Print ("item " + CStr(messagessplitted(0)) + "value" + CStr(messagessplitted(1)))
End Sub
     

Public Sub StopMessaging()
    CP240.Client.Close
    
    CP240.Server.Close
End Sub

'Richiamata sull'evento di accettazione problema rilevamento Hardlock
Private Sub PlusForceStop()
    'stop soft del dosaggio
    Call PulsanteStopCicliDosaggio
    'disabilito start dosaggio
    Call VisualizzaBarraPulsantiCP240(True)
    'stop del predosaggio
    Call PassaInManualePredosatori
    CP240.OPCData.items(PLCTAG_NM_PRED_Stop_Auto).Value = True
    'disabilito start predosaggio
'    CP240.CmdStartPred.enabled = False '20151125
    'arresto del bruciatore
    Call StopBruciatore(0)
    Call StopBruciatore(1)
    
    '20170224
    'torre forzatamente in automatico
'    CP240.AniPushButtonDeflettore(10).Value = 1
'    CP240.AniPushButtonDeflettore(10).enabled = False
    Call PulsanteControlloPortineManuale(True)
    '

    FrmGestioneTimer.PlusForcingStop.enabled = True
End Sub

Public Function PlusForceStopFinish() As Boolean
    PlusForceStopFinish = False
    GestioneStatoDosaggio
    If (Not DosaggioInCorso And (Not AutomaticoPredosatori And Not AlmenoUnoAccesoPredVergini And Not AlmenoUnoAccesoPredRiciclatoCaldo And Not AlmenoUnoAccesoPredRiciclatoFreddo) And (Not CP240.OPCData.items(PLCTAG_DI_BrucAcceso).Value And Not CP240.OPCData.items(PLCTAG_DI_Bruciatore2Acceso).Value)) Then
        PlusForceStopFinish = True
    End If
    HardKeyRemoved = False
End Function

'20150409
Public Sub SetActiveUser(ByVal newActiveUser As UsersEnum)

    If (ActiveUser <> newActiveUser) Then

        ActiveUser = newActiveUser

'        CP240.StatusBar1.Panels(STB_UTENTE).text = IIf( _
'            ActiveUser = UsersEnum.OPERATOR, _
'            "OPERATOR", _
'            IIf( _
'                ActiveUser = UsersEnum.MANAGER, _
'                "MANAGER", _
'                IIf(ActiveUser = UsersEnum.ADMINISTRATOR, "ADMINISTRATOR", IIf(ActiveUser = UsersEnum.SUPERUSER, "SUPERUSER", "")) _
'                ) _
'            )

        Call CP240StatusBar_Change(STB_UTENTE, ActiveUser) '20161018

        CP240.imgPulsanteForm(TBB_LOGIN).Picture = CP240.PlusImageList(0).ListImages(IIf((ActiveUser = NONE), "PLUS_IMG_LOGIN", "PLUS_IMG_LOGOFF")).Picture

        If (FrmSiwarexParaVisibile) Then
            Call FrmSiwarexPara.PasswordLevel
            Call FrmSiwarexPara.UpdatePulsantiForm
        ElseIf (FrmMotoriVisibile) Then
            Call AvvMotori.UpdatePulsantiForm
        ElseIf (FrmSiloGeneraleVisibile) Then
            Call FrmSiloGenerale.PasswordLevel
            Call FrmSiloGenerale.UpdatePulsantiForm
        End If
'20150514
        Call EnableComboMatCP240(ActiveUser >= UsersEnum.OPERATOR)
'
        Call CP240.EnableCliente(ActiveUser >= UsersEnum.OPERATOR)    '20150929
        
'        CP240.CmdNettiSiloStoricoSommaSalva(0).enabled = ( _
'                                                        (ActiveUser >= UsersEnum.OPERATOR) And _
'                                                        ( _
'                                                            BilanciaAggregati.ProfiNet Or _
'                                                            BilanciaFiller.ProfiNet Or _
'                                                            BilanciaLegante.ProfiNet Or _
'                                                            BilanciaRAP.ProfiNet Or _
'                                                            BilanciaViatop.ProfiNet Or _
'                                                            BilanciaViatopScarMixer1.ProfiNet Or _
'                                                            BilanciaViatopScarMixer2.ProfiNet _
'                                                        ) _
'                                                        )
        
        '20161026
        If (FrmTaraBilancePN.Visible) Then
            ActiveUser = UsersEnum.SUPERUSER
            Call FrmTaraBilancePN.SetVisibleReset(ActiveUser)
        Else
            Unload FrmTaraBilancePN
        End If
        
        '20170203
        Call UpdateCtrlDosPredosCP240(JobAttivo.StatusVB)

        
        '20161026
    End If

End Sub

'20170116
Public Sub LeggiMessaggioJobXML(messaggio As String)

    On Error GoTo Errore

'<Message xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Comando="0" Spec="0">
'  <Data>
'    <Id>1</Id>
'    <IdCliente>1</IdCliente>
'    <JobDescr>1</JobDescr>
'    <Priority>0</Priority>
'    <SiloDest>1</SiloDest>
'    <StatusId>1</StatusId>
'    <IdDosaggio>1</IdDosaggio>
'    <IdPredosaggio>1</IdPredosaggio>
'  </Data>
'</Message>

'Test
'    Set PacchettoDatixml = New XmlJobs
'    messaggio = "<Message xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" Comando=""0"" Spec=""0""><Data><Id>2</Id><IdCliente>1</IdCliente><JobDescr>2</JobDescr><Priority>1</Priority><SiloDest>1</SiloDest><StatusId>1</StatusId><IdDosaggio>2</IdDosaggio><IdPredosaggio>2</IdPredosaggio></Data></Message>"

'
                       
    PacchettoDatixml.DocName = messaggio

'    Debug.Print messaggio

    If Not PacchettoDatixml Is Nothing Then

        Debug.Print CStr(Now) & " Ricevuto da CS: "
        Debug.Print "Comando = " & EnumComandoJobCS_ToString(CInt(PacchettoDatixml.ParameterGetValue("Message", "Comando"))) & " Spec = " & EnumSpecJobCS_ToString(CInt(PacchettoDatixml.ParameterGetValue("Message", "Spec")))
        Debug.Print messaggio
        
        With PacchettoDatixml
            
            
'            Debug.Print "Comando=" + .ParameterGetValue("Message", "Comando")
'            Debug.Print "Spec=" + .ParameterGetValue("Message", "Spec")
            
            ComandoJobCS = CInt(.ParameterGetValue("Message", "Comando"))
            
            If ComandoJobCS <> EnumComandoJobCS.JobPause Then
            
                JobProssimo.IdJob = CLng(.GetValue("Data", "IdJob"))
                JobProssimo.IdCliente = CLng(.GetValue("Data", "IdCliente"))
                JobProssimo.JobDescr = .GetValue("Data", "JobDescr")
                'JobProssimo.Priority = .GetValue("Data", "Priority")
                JobProssimo.SiloDest = CInt(.GetValue("Data", "SiloDest"))
                JobProssimo.StatusId = CInt(.GetValue("Data", "StatusId"))
                JobProssimo.IdDosaggio = CLng(.GetValue("Data", "IdDosaggio"))
                JobProssimo.IdPredosaggio = CLng(.GetValue("Data", "IdPredosaggio"))
                JobProssimo.QuantitaDosaggio = CDbl(.GetValue("Data", "QuantDosaggio"))
                JobProssimo.QuantitaPredosaggio = CDbl(.GetValue("Data", "QuantPredosaggio"))
                JobProssimo.RiduzioneImpasto = Round(.GetValue("Data", "RiduzioneImpasto"), 0)
                JobProssimo.DosaggioPreset = CDbl(SostituisciCaratteri(CStr(.GetValue("Data", "Dosaggio")), ".", ","))
                JobProssimo.PredosaggioPreset = CDbl(SostituisciCaratteri(CStr(.GetValue("Data", "Predosaggio")), ".", ","))
                JobProssimo.CicliDosaggio = CDbl(SostituisciCaratteri(CStr(.GetValue("Data", "CicliDosaggio")), ".", ","))
            
            
                'Effettua un controllo su quanto ricevuto
'                If (JobProssimo.IdJob = 0) Or _
'                    (JobProssimo.IdPredosaggio = 0) Or _
'                    (JobProssimo.RiduzioneImpasto = 0) Or _
'                    (JobProssimo.SiloDest = 0) Or _
'                    (JobProssimo.IdDosaggio = 0) Or _
'                    (JobProssimo.CicliDosaggio = 0) _
'                Then GoTo Errore
            
                If (JobProssimo.IdJob = 0) Or _
                    (JobProssimo.RiduzioneImpasto = 0) Or _
                    (JobProssimo.IdDosaggio = 0) Or _
                    (JobProssimo.CicliDosaggio = 0) _
                Then GoTo Errore
                        
            End If
                        
                                                
            'ComandoJobCS = CInt(.ParameterGetValue("Message", "Comando"))
            
            Select Case ComandoJobCS
            
                Case EnumComandoJobCS.JobStart
                                                            
                    Select Case CInt(.ParameterGetValue("Message", "Spec"))
                        'decodifica dell'attributo "Spec"
                        Case EnumSpecJobCS.SpecPredosaggio
                                                        
                            If (JobAttivo.StatusVB <> EnumStatoJobVB.Idle) And (JobProssimo.IdPredosaggio > 0) Then
                                'Caso cambio di job parziale (solo predosaggio)
                                Call CambioPredosJob
                            ElseIf (JobAttivo.StatusVB <> EnumStatoJobVB.Idle) Then
                                JobProssimo.StatusVB = EnumStatoJobVB.PreDosStarted
                                'Call CambioDosJob
                            Else
                                'Caso di avvio job da impianto fermo
                                Call PreStartJob
                            End If
                            
                        Case EnumSpecJobCS.SpecDosaggio
                                Call CambioDosJob
                        Case Else
                            LogInserisci True, "MSG-002", "Codice comando job da C# non riconosciuto: " + CStr(ComandoJobCS)
                            Exit Sub
                    End Select
                                                                                                                        
                    
                Case EnumComandoJobCS.JobPause
                    
                    Call StopJob
                    
                Case EnumComandoJobCS.JobStop
                    
                    Select Case CInt(.ParameterGetValue("Message", "Spec"))
                        'decodifica dell'attributo "Spec"
                        
                        Case EnumSpecJobCS.SpecPredosaggio
                            
                            Call StopPredJob
                
                        Case EnumSpecJobCS.SpecDosaggio
                        
                            Call StopJob
                        Case Else
                            LogInserisci True, "MSG-002", "Codice comando job da C# non riconosciuto: " + CStr(ComandoJobCS)
                            Exit Sub
                                                                                                                
                    End Select
                
                Case EnumComandoJobCS.JobModify
                    If (JobAttivo.StatusVB <> EnumStatoJobVB.Idle) And (JobProssimo.IdJob = JobAttivo.IdJob) Then
                        Call ApplicaJob
                    End If
                Case Else
                    LogInserisci True, "MSG-002", "Codice comando job da C# non riconosciuto: " + CStr(ComandoJobCS)
                    Exit Sub
            End Select
            
                    
        End With
    End If

    Exit Sub
    
Errore:

    LogInserisci True, "MSG-002", "Errore ricezione messaggio job da C# : " + CStr(messaggio) + CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20170116
Public Sub InviaMessaggioQuantitaJobXml(Quantita As Double, tipo As EnumComandoJobVB)

    Dim messaggioxml As String
    Dim msgquantita As String
    Dim msgidjob As String
    
    
    On Error GoTo Errore

    If JobAttivo.IdJob = 0 Then Exit Sub

    If tipo <> EnumComandoJobVB.QtaDosaggio And tipo <> EnumComandoJobVB.QtaPredosaggio Then Exit Sub
    
    msgidjob = CStr(JobAttivo.IdJob)
    msgquantita = "QtaProdotta"

    If (tipo = EnumComandoJobVB.QtaPredosaggio) And (JobProssimo.StatusVB = EnumStatoJobVB.PreDosStarted) Then
        'situazione di cambio fra un job e il successivo: invio la quantita' riferita al nuovo job
        msgidjob = CStr(JobProssimo.IdJob)
    End If
    
    If msgidjob = 0 Then Exit Sub
        
'    messaggioxml = "<Message Comando=" "1" " Spec=""0""><Data><IdJob>" & CStr(JobAttivo.IdJob) & "</IdJob><QtaProdotta>" & CStr(Quantita) & "</QtaProdotta></Data></Message>"
'    messaggioxml = "<Message Comando=""" & CStr(EnumComandoJobVB.QtaProdotta) & """ Spec=""0""><Data><IdJob>" & CStr(JobAttivo.IdJob) & "</IdJob><QtaProdotta>" & CStr(Quantita) & "</QtaProdotta></Data></Message>"
'    messaggioxml = "<Message Comando=""" & CStr(tipo) & """><Data><IdJob>" & CStr(JobAttivo.IdJob) & "</IdJob><QtaProdotta>" & SostituisciCaratteri(CStr(Quantita), ",", ".") & "</QtaProdotta></Data></Message>"
        
    messaggioxml = "<Message Comando=""" & CStr(tipo) & """><Data>"
    messaggioxml = messaggioxml & "<IdJob>" & msgidjob & "</IdJob>"
    messaggioxml = messaggioxml & "<" & msgquantita & ">" & SostituisciCaratteri(CStr(Quantita), ",", ".") & "</" & msgquantita & ">"
    messaggioxml = messaggioxml & "</Data></Message>"
                
    Call SendMessagetoPlus(PlusSendJobMsg, messaggioxml)
    
    Debug.Print CStr(Now) & "InviaMessaggioQuantitaJobXml : " & messaggioxml

    Exit Sub
    
Errore:

    LogInserisci True, "MSG-003", "InviaMessaggioQuantitaJobXml : " + CStr(messaggioxml) + CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'

'20170116
Public Sub InviaMessaggioFineJobXml()

    Dim messaggioxml As String
    
    On Error GoTo Errore

    If JobAttivo.IdJob = 0 Then Exit Sub

    messaggioxml = "<Message Comando=""" & CStr(EnumComandoJobVB.Fineprocesso) & """><Data><IdJob>" & CStr(JobAttivo.IdJob) & "</IdJob></Data></Message>"
        
    Call SendMessagetoPlus(PlusSendJobMsg, messaggioxml)
    
    Debug.Print CStr(Now) & "InviaMessaggioFineJobXml = " & messaggioxml

    Exit Sub

Errore:

    LogInserisci True, "MSG-004", "InviaMessaggioFineJobXml : " + CStr(messaggioxml) + CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'

'20170116
Public Sub InviaMessaggioJobEmergenzaXml()

    Call SendMessagetoPlus(PlusSendJobMsg, ComandoJobEmergenza)

    JobAttivo.StatusVB = EnumStatoJobVB.Idle

'    Debug.Print CStr(Now) & " InviaMessaggioJobEmergenzaXml : " & ComandoJobEmergenza
    
End Sub


