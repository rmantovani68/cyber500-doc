Attribute VB_Name = "GestioneJob"
Option Explicit

Public Enum EnumComandoJobCS
    JobStart = 0
    JobStop
    JobPause
    JobModify
End Enum

Public Enum EnumSpecJobCS
    SpecDosaggio = 0
    SpecPredosaggio
    SpecSilo
End Enum

Public Enum EnumComandoJobVB
    Emergenza = 0
    QtaDosaggio
    QtaPredosaggio
    ShowFormJob
    HideFormJob
    Fineprocesso
End Enum

Public Enum EnumStatoJobCS
    Todo = 1
    Done
    Running
    Paused
End Enum


Public Enum EnumStatoJobVB
    Idle = 0
    Prestart
    Running
    Stopping
    PreDosStarted
    Pausing
End Enum

Public Type TipoJob
    IdJob As Long
    IdCliente As Long
    JobDescr As String
    Priority As String
    SiloDest As Integer
    StatusId As EnumStatoJobCS
    StatusVB As EnumStatoJobVB
    MemStatusVB As EnumStatoJobVB
    IdDosaggio As Long
    IdPredosaggio As Long
    QuantitaDosaggio As Double
    QuantitaPredosaggio As Double
    RiduzioneImpasto As Integer
    'UltimoJob As Boolean
    MemQtaPredosProdotta As Double
    DosaggioPreset As Double
    PredosaggioPreset As Double
    CicliDosaggio As Integer
End Type

Public ComandoJobVB As EnumComandoJobVB
Public ComandoJobCS As EnumComandoJobCS

Public JobAttivo As TipoJob
Public JobProssimo As TipoJob

Public PacchettoDatixml As XmlJobs '20170104

Public Const ComandoJobShowForm = "<Message Comando=""3""></Message>"
Public Const ComandoJobEmergenza = "<Message Comando=""0""></Message>"
'Public Const ComandoJobQtaProd = "<Message Comando=""1"" Spec=""0""></Message>"

Public tmrAvvioJob As TemporizzatoreStandardType
Public StepJob As Integer
Public MemStepJob As Integer
Public MemSelSiloJobMan As Boolean
Public StatorRichiestaCambioSiloJob As Integer
Public CicloScaricoSiloCompleto As Boolean


Public Sub ApplicaJob()

    JobAttivo = JobProssimo
    
    'selezione ricetta dosaggio
    Call SelectDosingRecipeByCS(JobAttivo.IdDosaggio)
    
    If JobAttivo.IdPredosaggio > 0 Then
        'selezione ricetta predosaggio
        Call SelectFeederRecipeByCS(JobAttivo.IdPredosaggio)
        'Azzera lo stop predosatori anticipato
        CP240.TxtStopPredosatori = 0
        CicliStopPred = 0
    End If

    If JobAttivo.IdCliente > 0 Then
        'selezione cliente
        Call SelectClienteByCS(JobAttivo.IdCliente)
    End If
                                                                                                                                
    'quantita da produrre
    CambioPercentualeDosaggio = True
    
    Call SetRiduzioneImpasto(JobAttivo.RiduzioneImpasto)
                
'    Dim dimensioneimpastoT As Double
'
'    dimensioneimpastoT = CDbl(ImpastoPeso) / CDbl(1000) * (JobAttivo.RiduzioneImpasto / CDbl(100))
'
'    Call SetCicliDosaggioDaEseguire(CDbl(FormatNumber((JobProssimo.QuantitaDosaggio - (JobProssimo.DosaggioPreset)) / dimensioneimpastoT, 0)))
        
    Call SetCicliDosaggioDaEseguire(JobAttivo.CicliDosaggio)
        
    'selezione ricetta dosaggio
    Call SelectDosingRecipeByCS(JobAttivo.IdDosaggio)
                                
    'cambio silo
    If (DestinazioneSilo <> JobAttivo.SiloDest) And (JobAttivo.SiloDest > 0) Then
'        If ShowConfermaCambioSilo Then
            DestinazioneSiloPrenotata = JobAttivo.SiloDest
            VisualizzaSiloAttivo FrmSiloGeneraleVisibile
'        End If
    End If

    
    Call InitJob(JobProssimo)

    MemSelSiloJobMan = False

    Exit Sub
    
Errore:

    LogInserisci True, "JOB-001", "ApplicaJob : " + CStr(Err.Number) + " [" + Err.description + "]"

End Sub

Public Sub PreStartJob()

    Dim buttonPressed As Integer
    Dim errormessage As String
    Dim errorjob As Boolean
    
            
    errormessage = LoadXLSString(1541)
            
    'Controlli preliminari stato impianto
    If DosaggioInCorso Then
        errormessage = errormessage + LoadXLSString(1542)
        errorjob = True
    ElseIf Not MotorManagementPlcAutomatic Then
        errormessage = errormessage + LoadXLSString(1543)
        errorjob = True
    ElseIf (CP240.OPCData.IsConnected And InclusioneBennaApribile And ListaSili(11).RitornoSelezionato) And (CP240.OPCData.items(PLCTAG_DI_AsseP_NavettaAperta).Value) Then
        'Benna/Navetta apribile a scarico diretto
        'Benna/Navetta apribile APERTA
        'In questo caso non permette la selezione di un'altra destinazione silo
        
        'TODO verificare se questa roba serve!
    ElseIf JobProssimo.IdJob = 0 Then
        errormessage = errormessage + LoadXLSString(1544)
        errorjob = True
    End If

    If errorjob Then
        Call StopEmergenzaJob
        buttonPressed = ShowMsgBox(errormessage, vbOKOnly, vbError, -1, -1, True)
        Exit Sub
    End If
        
    'caricamento dati job
    Call ApplicaJob
        
    JobAttivo.StatusVB = EnumStatoJobVB.Prestart
    'JobProssimo.StatusVB = EnumStatoJobVB.Running
'    tmrAvvioJob.Abilitazione = True
    
    If JobAttivo.IdPredosaggio > 0 Then
        Call ResetTotalizzatoriNastri(3)
    End If
    
    JobAttivo.MemQtaPredosProdotta = 0
    CicloScaricoSiloCompleto = True
    
End Sub

Public Sub CambioPredosJob()

    'caricamento dati job
    JobAttivo.IdPredosaggio = JobProssimo.IdPredosaggio
    
    'selezione ricetta predosaggio
    Call SelectFeederRecipeByCS(JobAttivo.IdPredosaggio)

    Call ResetTotalizzatoriNastri(3)

    JobAttivo.MemQtaPredosProdotta = 0

    Call StartPreDosaggio

    JobProssimo.StatusVB = EnumStatoJobVB.PreDosStarted

    Exit Sub

Errore:

    LogInserisci True, "JOB-002", "CambioPredosJob : " + CStr(Err.Number) + " [" + Err.description + "]"

End Sub

Public Sub CambioDosJob()

    On Error GoTo Errore


    'caricamento dati job
    JobAttivo.IdCliente = JobProssimo.IdCliente
    JobAttivo.IdJob = JobProssimo.IdJob
    JobAttivo.JobDescr = JobProssimo.JobDescr
    JobAttivo.Priority = JobProssimo.Priority
    JobAttivo.QuantitaDosaggio = JobProssimo.QuantitaDosaggio
    JobAttivo.RiduzioneImpasto = JobProssimo.RiduzioneImpasto
    JobAttivo.SiloDest = JobProssimo.SiloDest
        
    If JobAttivo.IdCliente > 0 Then
        'selezione cliente
        Call SelectClienteByCS(JobAttivo.IdCliente)
    End If
                
                
    'quantita da produrre
    
    CambioPercentualeDosaggio = True

    Call SetRiduzioneImpasto(JobProssimo.RiduzioneImpasto)
                
'    Dim dimensioneimpastoT As Double
'
'    dimensioneimpastoT = CDbl(ImpastoPeso) / CDbl(1000) * (JobProssimo.RiduzioneImpasto / CDbl(100))
        
''    Call SetCicliDosaggioDaEseguire(CDbl(FormatNumber((JobProssimo.QuantitaDosaggio - JobProssimo.DosaggioPreset) / dimensioneimpastoT, 0)))
'    Call SetCicliDosaggioDaEseguire(CDbl(FormatNumber(JobProssimo.QuantitaDosaggio / dimensioneimpastoT, 0)))
    Call SetCicliDosaggioDaEseguire(JobProssimo.CicliDosaggio)


    'selezione ricetta dosaggio
    Call SelectDosingRecipeByCS(JobProssimo.IdDosaggio)

'    'cambio silo
'    If (DestinazioneSilo <> JobAttivo.SiloDest) Then
'        If ShowConfermaCambioSilo Then
'            DestinazioneSiloPrenotata = JobAttivo.SiloDest
'            VisualizzaSiloAttivo FrmSiloGeneraleVisibile
'        End If
'    End If

    JobAttivo.StatusVB = EnumStatoJobVB.Prestart
    
    Call InitJob(JobProssimo)
    
    'tmrAvvioJob.Abilitazione = True

    MemSelSiloJobMan = False

    QuantitaImpastoProdotto = JobProssimo.DosaggioPreset * CDbl(1000)
    CP240.LblKgDosaggio(0).caption = FormatNumber(QuantitaImpastoProdotto, 0, vbTrue, vbFalse, vbFalse)

    Exit Sub

Errore:

    LogInserisci True, "JOB-003", "CambioDosJob : " + CStr(Err.Number) + " [" + Err.description + "]"

End Sub

Public Sub CicloJob()
' routine ciclica
        
    Dim idricettascarico As Long
    
    On Error GoTo Errore
                                                                                                                                                                                                                                                   
    Dim condokstartdos As Boolean
                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                   
    'dosaggioincorsoplc = CP240.OPCData.items(PLCTAG_DosaggioAttivo).Value Or Not UltimoImpastoCompletato
                                                                                                                                                                                                                                                   
'20170210
    condokstartdos = Not CmdStartDosaggioLock And _
                    Not (DosaggioInCorso Or UltimaBennata) And _
                    Not (FrmGestioneTimer.TimerTagCambioVolo.enabled Or CambioRicettaPrenotato) And _
                    Not HardKeyRemoved And _
                    Not PlusCommunicationBroken
        
                                                                                                                                                                                                                                                   
    Call TemporizzatoreStandard(1, 15, tmrAvvioJob.AppTempo, _
                            tmrAvvioJob.TempoExec, tmrAvvioJob.uscita, _
                            tmrAvvioJob.Abilitazione, tmrAvvioJob.ErrTimer)
'
    
    'Aggiorno il CS sulla quantita' di predosaggio prodotta
    If ((JobAttivo.StatusVB > EnumStatoJobVB.Idle) Or (JobProssimo.StatusVB > EnumStatoJobVB.Idle)) And (TotalizzazioneNastroAggr >= JobAttivo.MemQtaPredosProdotta + 1) And (JobAttivo.IdPredosaggio > 0 Or JobProssimo.IdPredosaggio > 0) Then
        Call InviaMessaggioQuantitaJobXml(RoundNumber(TotalizzazioneNastroAggr, 1), QtaPredosaggio)
        JobAttivo.MemQtaPredosProdotta = Round(TotalizzazioneNastroAggr, 0)
    End If
    
    
    'Avvio della produzione al raggiungimento delle condizioni di start richieste al job
    'If condokstartdos And BennaFineCorsaInf And (JobAttivo.StatusVB = EnumStatoJobVB.Prestart) And ((JobAttivo.SiloDest > 0) Or MemSelSiloJobMan Or (DestinazioneSilo = JobAttivo.SiloDest)) And (CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value = CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value) Then
    If condokstartdos And (JobAttivo.StatusVB = EnumStatoJobVB.Prestart) And ((JobAttivo.SiloDest < 1) Or MemSelSiloJobMan Or (DestinazioneSilo = JobAttivo.SiloDest)) And (CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value = CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value) Then
        Call StartJob
    End If
                                        
    '20170227
    If (JobAttivo.StatusVB = EnumStatoJobVB.Running) And Not DosaggioInCorso And (condokstartdos And (JobAttivo.StatusVB = EnumStatoJobVB.Prestart) And ((JobAttivo.SiloDest < 1) Or MemSelSiloJobMan Or (DestinazioneSilo = JobAttivo.SiloDest)) And (CP240.AdoDosaggioNext.Recordset.Fields("IdDosaggio").Value = CP240.AdoDosaggio.Recordset.Fields("IdDosaggio").Value)) Then
        Call InviaMessaggioJobEmergenzaXml
    End If
    '
                
    
    If (JobAttivo.StatusVB = EnumStatoJobVB.Prestart) Then
    'Esecuzione solo durante l'esecuzione di un job
    
        If (BennaSu Or NavettaInScarico) Then
            CicloScaricoSiloCompleto = True
        End If
    
        'cambio silo nel passaggio da un job a quello successivo
        If Not (CP240.AdoDosaggioScarico.Recordset.BOF Or CP240.AdoDosaggioScarico.Recordset.EOF) Then
        
            idricettascarico = CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value
                                                                                    
            If CicloScaricoSiloCompleto And (JobAttivo.IdDosaggio <> idricettascarico) And (DestinazioneSiloPrenotata <> JobAttivo.SiloDest) And (JobProssimo.StatusVB = EnumStatoJobVB.Idle) And Not MemSelSiloJobMan And (JobAttivo.SiloDest > 0) Then
				DestinazioneSiloPrenotata = JobAttivo.SiloDest
				VisualizzaSiloAttivo FrmSiloGeneraleVisibile
				tmrAvvioJob.Abilitazione = False
            End If
        End If
    
                                                                                                                                                         
        If (JobProssimo.IdPredosaggio = 0) And (TotalizzazioneNastroAggr >= JobAttivo.QuantitaPredosaggio) And PredosatoriAutomaticoOn And (JobAttivo.IdPredosaggio > 0) Then
        'Arresto del predosaggio al raggiungimento della quantita' impostata durante l'ultimo job
            Call PassaInManualePredosatori
        End If
                                                                                                                      
    End If

    
    If DosaggioInCorso Then
        If CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value Then
            'ultimo ciclo di dosaggio in corso
            If (JobAttivo.StatusVB = EnumStatoJobVB.Running) Then
                JobAttivo.StatusVB = EnumStatoJobVB.Stopping
                Call CP240StatusBar_Change(STB_JOB, EnumStatoJobVB.Stopping)
            End If
        End If
    Else
        If JobAttivo.StatusVB = EnumStatoJobVB.Pausing Then
            Call InviaMessaggioJobEmergenzaXml
            Call InitJob(JobAttivo)
        ElseIf JobAttivo.StatusVB = EnumStatoJobVB.Stopping Then
        'Finito il dosaggio in corso, informo il CS
            Call InviaMessaggioFineJobXml
            JobAttivo.StatusVB = EnumStatoJobVB.Idle
                        
            If JobProssimo.StatusVB = EnumStatoJobVB.Idle Then
                'Reset job attivo se non ci sono altri job da fare
                Call InitJob(JobAttivo)
'            ElseIf JobProssimo.StatusVB = EnumStatoJobVB.PreDosStarted Then
'                Call CambioDosJob
            End If
        End If
    End If
    
    'Aggiornamento oggetti formCP240
    If JobAttivo.MemStatusVB <> JobAttivo.StatusVB Then
        'Call StatusBarJob_Change
        If JobProssimo.StatusVB <> EnumStatoJobVB.Idle Then
            Call CP240StatusBar_Change(STB_JOB, JobProssimo.StatusVB)
        Else
            Call CP240StatusBar_Change(STB_JOB, JobAttivo.StatusVB)
        End If
        
        Call UpdateCtrlDosPredosCP240(JobAttivo.StatusVB)
        JobAttivo.MemStatusVB = JobAttivo.StatusVB
    End If


    CP240.LblDebug1(0).caption = "JobAttivoID : " & CStr(JobAttivo.IdJob) & " JobStatusVB : " & EnumStatoJobVB_ToString(JobAttivo.StatusVB)
    CP240.LblDebug1(1).caption = "JobProssimo: " & CStr(JobProssimo.IdJob) & " JobStatusVB : " & EnumStatoJobVB_ToString(JobProssimo.StatusVB)
    
    
    If CP240.LblNomeRicDos(3).caption <> JobAttivo.JobDescr Then
        CP240.LblNomeRicDos(3).caption = JobAttivo.JobDescr
    End If
    
    
    'Gestione modifiche job attivo<>Prossimo
'    If JobAttivo.IdJob <> JobProssimo.IdJob Then
'        If (TotalizzazioneNastroAggr >= JobAttivo.QuantitaPredosaggio) And PredosatoriAutomaticoOn Then
'            StepJob = 120
'        End If
'    End If
    
    Exit Sub

Errore:

    LogInserisci True, "JOB-005", "CicloJob : " + CStr(Err.Number) + " [" + Err.description + "]"
    
End Sub

Public Function EnumStatoJobVB_ToString(varenum As EnumStatoJobVB) As String

    Select Case varenum
        Case EnumStatoJobVB.Idle
            EnumStatoJobVB_ToString = "Idle"
        Case EnumStatoJobVB.PreDosStarted
            EnumStatoJobVB_ToString = "PreDosStarted"
        Case EnumStatoJobVB.Prestart
            EnumStatoJobVB_ToString = "Prestart"
        Case EnumStatoJobVB.Running
            EnumStatoJobVB_ToString = "Running"
        Case EnumStatoJobVB.Stopping
            EnumStatoJobVB_ToString = "Stopping"
        Case EnumStatoJobVB.Pausing
            EnumStatoJobVB_ToString = "Pausing"
            
    End Select

End Function

Public Function EnumSpecJobCS_ToString(varenum As EnumSpecJobCS) As String

    Select Case varenum
        Case EnumSpecJobCS.SpecDosaggio
            EnumSpecJobCS_ToString = "SpecDosaggio"
        Case EnumSpecJobCS.SpecPredosaggio
            EnumSpecJobCS_ToString = "SpecPredosaggio"
        Case EnumSpecJobCS.SpecSilo
            EnumSpecJobCS_ToString = "SpecSilo"
    End Select

End Function

Public Function EnumComandoJobCS_ToString(varenum As EnumComandoJobCS) As String

    Select Case varenum
        Case EnumComandoJobCS.JobModify
            EnumComandoJobCS_ToString = "JobModify"
        Case EnumComandoJobCS.JobPause
            EnumComandoJobCS_ToString = "JobPause"
        Case EnumComandoJobCS.JobStart
            EnumComandoJobCS_ToString = "JobStart"
        Case EnumComandoJobCS.JobStop
            EnumComandoJobCS_ToString = "JobStop"
    End Select

End Function



'Public Sub StatusBarJob_Change()
'
'    Call CP240StatusBar_Change(STB_JOB, JobAttivo.StatusVB)
'
'End Sub


Public Sub StartJob()
                
    Call StartDosaggio
    
    QuantitaImpastoProdotto = JobAttivo.DosaggioPreset * CDbl(1000)
    CP240.LblKgDosaggio(0).caption = FormatNumber(QuantitaImpastoProdotto, 0, vbTrue, vbFalse, vbFalse)
                
                
    If JobAttivo.IdPredosaggio > 0 Then
        Call StartPreDosaggio
        TotalizzazioneNastroAggr = JobAttivo.PredosaggioPreset
        If (ConfigPortataNastroInerti = schedaSiwarex) Or (ConfigPortataNastroInerti = analogica) Then
            'Gestione totalizzatore su PLC (+ preciso)
            CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Agg).Value = TotalizzazioneNastroAggr
        End If
    End If
                           
    If JobAttivo.StatusVB <> EnumStatoJobVB.Idle Then
    'controllo se per qualche motivo lo status da prestart e' cambiato in idle (e' fallito qualche controllo delle condizioni di start dosaggio o predosaggio)
        JobAttivo.StatusVB = EnumStatoJobVB.Running
'        If Not PredosatoriAutomaticoOn Then
'            Call InviaMessaggioJobEmergenzaXml
'        End If
    
    End If
    
    
    Call InitJob(JobProssimo)
                        
'    tmrAvvioJob.Abilitazione = True
                        
                        
End Sub

Public Sub StopJob()

'    tmrAvvioJob.Abilitazione = False

    Call PulsanteStopCicliDosaggio
    
    If JobAttivo.IdPredosaggio > 0 Then
        Call PassaInManualePredosatori
    End If
    
    Call InviaMessaggioQuantitaJobXml(RoundNumber(TotalizzazioneNastroAggr, 1), QtaPredosaggio)
    JobAttivo.MemQtaPredosProdotta = Round(TotalizzazioneNastroAggr, 0)
                        
    JobAttivo.StatusVB = EnumStatoJobVB.Pausing
                        
    Call InitJob(JobProssimo)
'    Call InitJob(JobAttivo)
                                                
End Sub

Public Sub StopEmergenzaJob()

    tmrAvvioJob.Abilitazione = False
    
    'Call PulsanteStopCicliDosaggio
    Call ArrestoEmergenzaDosaggio
    
    If JobAttivo.IdPredosaggio > 0 Then
        Call PulsanteStopPred
    End If
    
    Call InitJob(JobProssimo)
    Call InitJob(JobAttivo)
    
    Call InviaMessaggioQuantitaJobXml(RoundNumber(TotalizzazioneNastroAggr, 1), QtaPredosaggio)
    JobAttivo.MemQtaPredosProdotta = Round(TotalizzazioneNastroAggr, 0)
                                                
    Call InviaMessaggioJobEmergenzaXml
                                                                                                
End Sub

Public Sub StopPredJob()

'    tmrAvvioJob.Abilitazione = False
    
    If JobAttivo.IdPredosaggio > 0 Then
        Call PassaInManualePredosatori
    End If
    
    Call InviaMessaggioQuantitaJobXml(RoundNumber(TotalizzazioneNastroAggr, 1), QtaPredosaggio)
    JobAttivo.MemQtaPredosProdotta = Round(TotalizzazioneNastroAggr, 0)
                                                                                                
End Sub


Public Sub InitJob(job As TipoJob)
    
    With job
        .IdJob = 0
        .IdCliente = 0
        .JobDescr = ""
        .Priority = ""
        .SiloDest = 0
        .StatusId = EnumStatoJobCS.Paused
        .StatusVB = EnumStatoJobVB.Idle
        .IdDosaggio = 0
        .IdPredosaggio = 0
        .QuantitaDosaggio = 0
        .QuantitaPredosaggio = 0
        .RiduzioneImpasto = 0
        .MemQtaPredosProdotta = 0
        .DosaggioPreset = 0
        .PredosaggioPreset = 0
    End With

End Sub
        
Public Sub UpdateCtrlDosPredosCP240(statojob As EnumStatoJobVB)
' Nasconde/mostra contolli nei frame di dosaggio e predosaggio
    
Dim enabled As Boolean
Dim locked As Boolean
    
    With CP240
        Select Case statojob
            Case EnumStatoJobVB.Idle
                enabled = True
            Case Else
                enabled = False Or (ActiveUser = SUPERUSER)
        End Select
    
        locked = Not enabled
        
        'dosaggio
        .adoComboDosaggio.locked = locked
        '.UpDownProdDos.enabled = visibile
        .AdoComboClienti.locked = locked And (JobAttivo.IdCliente > 0)
        .CmdNettiSiloStoricoSommaSalva(7).enabled = enabled
        '.TxtCicloDos.Locked = visibile
        '.UpDownCicli.Visible = visibile
        '.LblProdDos.Visible = visibile
        '.CmdStartDosaggio.Visible = visibile
        'predosaggio
        .adoComboPredosaggio.locked = locked And (JobAttivo.IdPredosaggio > 0)
        .TxtStopPredosatori.enabled = enabled Or (JobAttivo.IdPredosaggio = 0)
        
    End With

End Sub
        
