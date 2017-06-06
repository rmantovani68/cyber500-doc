Attribute VB_Name = "GestioneDataBase"
'
'   Gestione del database SqlServer
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit

'*****************************  NOTA BENE *****************************
'Nelle query per specificare una data si deve fare nel seguente modo:
'CONVERT(DateTime, '" & Data1 & "', 102)
'Dove Data1 = 2007-02-07 12:00:00
'102 significa data in formato ANSI yy.mm.dd
'**********************************************************************

'   Connessione con il database
Public DBcon As New adodb.Connection

'   Recordset per l'inserimento dei campionamenti del trend
Public Rs_Registrazioni_AddNew As New adodb.Recordset



'   Crea la connessione a SqlServer se non esiste già

'   In più crea tutti i recordset necessari alla gestione dei dati
Public Sub SqlServerApri()

    On Error GoTo SaltaStringaConn
'20150901
    'Tarroni S. 2013/05/29. Nuova modalità di connessione a SQL Server: PC locale (.) e identificazione mediante utente windows
'    DBcon.ConnectionString = "Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=CYB500;Data Source=."
    DBcon.ConnectionString = "Provider=SQLNCLI10.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=CYB500;Data Source=."
    'DBcon.ConnectionString = "Provider=sqloledb;server=" & SqlServerNome & ";uid=" & SqlServerUtente & ";pwd=" & SqlServerParolaChiave & ";database=" & SqlServerNomeDatabase
    '
SaltaStringaConn:

    On Error GoTo Errore

    If DBcon.State = adStateClosed Then
        DBcon.CursorLocation = adUseClient
        DBcon.Open
        With Rs_Registrazioni_AddNew
            Set .ActiveConnection = DBcon
            .Source = "SELECT TOP 10 Registrazioni.* FROM Registrazioni;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenForwardOnly
            .Open , DBcon
        End With
    End If

Errore:

    If Err.Number <> 0 Then
        ShowMsgBox Err.Number & " - " & Err.description, vbOKOnly, vbExclamation, -1, -1, True
    End If

End Sub


'   Chiude la connessione a SqlServer
Public Sub SqlServerChiudi()

    If DBcon.State <> adStateClosed Then
        DBcon.Close
    End If

End Sub


'   Esegue un comando
Private Function SqlServerComando( _
    comando As String, _
    Optional parametri As Boolean, _
    Optional dataInizio As Date _
) As Boolean

    Dim objCmd As New adodb.Command
    Dim objRs As New adodb.Recordset

    On Error GoTo Errore

    SqlServerComando = False

    objCmd.ActiveConnection = DBcon
    objCmd.CommandType = adCmdStoredProc
    objCmd.CommandText = comando
    If (parametri) Then
        '20150320
        'Set objRs = objCmd.Execute(, Format(dataInizio, "yyyy-dd-mm hh:nn:ss"))
        Set objRs = objCmd.Execute(, dataInizio)
        '
    Else
        Set objRs = objCmd.Execute
    End If

Errore:

    SqlServerComando = (Err.Number = 0)
    If Err.Number <> 0 Then
        ShowMsgBox Err.Number & " - " & Err.description, vbOKOnly, vbExclamation, -1, -1, True
    End If
    Set objCmd = Nothing

End Function


'   Effettua la compattazione
Public Function SqlServerCompatta() As Boolean

    SqlServerCompatta = SqlServerComando("sp_Compatta")

End Function


'   Effettua la cancellazione a partire da una certa data
Public Function SqlServerCancellaTrendData(dataInizio As Date) As Boolean

    SqlServerCancellaTrendData = SqlServerComando("sp_CancellaRegistrazioniDallaDataX", True, dataInizio)

End Function


Public Sub EseguiSQL(Stringa As String)
Dim objCmd As New adodb.Command
Dim objRs As New adodb.Recordset

On Error GoTo Errore

    objCmd.ActiveConnection = DBcon
    objCmd.CommandType = adCmdText
    objCmd.CommandText = Stringa
    Set objRs = objCmd.Execute
    
Errore:

    If Err.Number <> 0 Then
        LogInserisci True, "SQL-001", CStr(Err.Number) + " [" + Err.description + "]"
        ShowMsgBox Err.Number & " - " & Err.description, vbOKOnly, vbExclamation, -1, -1, True
    End If
    Set objCmd = Nothing
    
End Sub

