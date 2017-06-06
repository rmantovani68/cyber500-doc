Attribute VB_Name = "GestioneCaratteri"
Option Explicit

Public Sub ImpostaCharSet()

    Select Case LinguaSelezionata
        Case LangITA, LangSPA, LangING, LangPOL, LangFRA Or LangPOR
            CharSetSelezionato = 0
    End Select
End Sub

Public Sub CarattereOccidentale(ByRef NomeForm As Object)

    '20170203
    'If LinguaSelezionata = LangRUS Then
    If (LinguaSelezionata = LangRUS Or LinguaSelezionata = LangBUL) Then
    '
        Call ImpostaCarattereRusso(NomeForm)
    Else
        Call ImpostaCarattereOccidentale(NomeForm)
    End If
    
End Sub

Public Sub ImpostaCarattereOccidentaleControl(ByRef controllo As Control)

    On Error GoTo Errore

    controllo.Font.Charset = 0
    controllo.HeadFont.Charset = 0

Errore:
    'Nessuna segnalazione
End Sub

Public Sub ImpostaCarattereOccidentale(ByRef Nome As Object)

    Dim i As Integer

    For i = 0 To Nome.Controls.count - 1
        ImpostaCarattereOccidentaleControl Nome.Controls(i)
    Next i

End Sub

Public Sub ImpostaCarattereRussoControl(ByRef controllo As Control)

    On Error GoTo Errore

    controllo.FontName = "MS Sans Serif"
    controllo.Font.Charset = 1
    controllo.HeadFont.Charset = 1

Errore:
    'Nessuna segnalazione
End Sub


Public Sub ImpostaCarattereRusso(ByRef Nome As Object)

    Dim i As Integer

    For i = 0 To Nome.Controls.count - 1
        ImpostaCarattereRussoControl Nome.Controls(i)
    Next i

End Sub


Public Function DataInglese(data As String) As String
    DataInglese = Mid(data, 4, 2) + "/" + left(data, 2) + "/" + Mid(data, 7, 4)
End Function


Public Function SostituisciCaratteri(S As String, Char1 As String, Char2 As String) As String

    Dim i As Integer

    For i = 1 To Len(S)
        If Mid(S, i, 1) = Char1 Then
            SostituisciCaratteri = SostituisciCaratteri & Char2
        Else
            SostituisciCaratteri = SostituisciCaratteri & Mid(S, i, 1)
        End If
    Next i
    
End Function

