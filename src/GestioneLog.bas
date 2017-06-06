Attribute VB_Name = "GestioneLog"
'
'   Gestione del log
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const NomeFileLog As String = "Cyb500N"
Private Const LogExt As String = ".log"

Private TimerInizio As Long


'   Aggiunge una stringa al log degli eventi
Public Sub LogInserisci(Errore As Boolean, funzione As String, ByVal Descrizione As String)

    Dim buffer As String


    On Error GoTo Errore

    buffer = ""

    If (Errore) Then
        buffer = buffer + "## ERROR ## "
    End If

    buffer = buffer + CStr(DateTime.Now) + " : "
    buffer = buffer + funzione + " = " + Descrizione

    Open LogPath + NomeFileLog + Format$(Now, "yyyymmdd") + LogExt For Append As #2

    Write #2, buffer

    Close #2

    If (Errore And DEBUGGING) Then
        Call MsgBox(funzione + " = " + Descrizione, vbOKOnly + vbCritical, CAPTIONSTARTSIMPLE)
        Debug.Assert False
    End If

    Exit Sub
Errore:
    Dim ErrorString As String
    ErrorString = CStr(Err.Number) + " [" + Err.description + "]"
    Call MsgBox("LOG = " + ErrorString, vbOKOnly + vbCritical, CAPTIONSTARTSIMPLE)
    Debug.Assert False

End Sub


Public Function LogFunction(nomeFunzione As String, Inizio As Boolean, Optional timerInizioEsterno As Long) As Long
    Dim adesso As Long
    
    adesso = ConvertiTimer()
    
    If (Inizio) Then
        TimerInizio = adesso
    Else
        Dim timerDiff As Long

        If (timerInizioEsterno <> 0) Then
            timerDiff = adesso - timerInizioEsterno
        Else
            timerDiff = adesso - TimerInizio
        End If
        If (timerDiff > 1) Then
            If (DEBUGGING) Then
                Debug.Print nomeFunzione + " - " + "Time too long: " + CStr(timerDiff)
            Else
                Call LogInserisci(True, nomeFunzione, "Time too long: " + CStr(timerDiff))
            End If
        End If
        TimerInizio = 0
    End If
    'Ribadisco nel caso ci metta tempo a fare LogInserisci...soprattutto in debug
    LogFunction = ConvertiTimer()
End Function

