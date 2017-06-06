Attribute VB_Name = "ControlloDatiInseriti"
Option Explicit

Public Function RoundNumber(numero As Variant, NumeroDecimali As Integer) As Variant
Dim tmp As Double
Dim DecShift As Long
Dim Segno As Integer
   
    tmp = CDbl(numero)
    DecShift = 10 ^ NumeroDecimali
    If numero < 0 Then
        Segno = -1
    Else
        Segno = 1
    End If
    RoundNumber = (Fix((tmp + (Segno * 0.5) / DecShift) * DecShift)) / DecShift
    If RoundNumber = "-1,#IND" Then
         RoundNumber = 0
    End If
   
End Function

Public Sub DatoInteger(ByRef Dato As Object, ByVal numeroCaratteri As Integer, ByVal negativo As Boolean)

'   Controllo come KeyPress
'   Va da 0 a 9*numeroCaratteri

    Dim i As Integer
    Dim Lunghezza As Integer

    Lunghezza = Len(Dato.text)

    If (Lunghezza < 1 Or Lunghezza > numeroCaratteri) Then
        Dato.text = "0"
        Exit Sub
    End If

    For i = 1 To Lunghezza

        Select Case Asc(Mid(Dato.text, i, 1))
            Case 45
                ' -
                If (Not negativo) Then
                    Exit Sub
                End If
            Case 48 To 57
                ' 0...9
            Case Else
                Dato.text = "0"
                Exit Sub
        End Select

    Next i

End Sub

Public Sub DatoVirgola(ByRef Dato As Object, ByVal numeroCaratteri As Integer, ByVal NumeroDecimali As Integer, ByVal negativo As Boolean)

'   Controllo come KeyPress
'   Va da 0 a 99,99

    Dim i As Integer
    Dim nuova As String
    Dim Lunghezza As Integer
    Dim separatoreDecimali As Integer

    Lunghezza = Len(Dato.text)

    If (Lunghezza < 1 Or Lunghezza > numeroCaratteri) Then

        nuova = Mid(Dato.text, 1, numeroCaratteri)

    Else

        For i = 1 To Lunghezza

            Select Case Asc(Mid(Dato.text, i, 1))
                Case 44, 46
                    '   , .
                    If (NumeroDecimali > 0 And separatoreDecimali = 0) Then
                        nuova = nuova + "."
                        separatoreDecimali = i
                    End If
                Case 45
                    '   -
                    If (negativo And i = 1) Then
                        nuova = nuova + "-"
                    End If
                Case 48 To 57
                    '   0...9
                    nuova = nuova + Mid(Dato.text, i, 1)
                Case Else
                    '   scarto
            End Select

        Next i

    End If

    If (separatoreDecimali > 0 And Lunghezza - separatoreDecimali > NumeroDecimali) Then
        nuova = Mid(nuova, 1, separatoreDecimali + NumeroDecimali)
    End If

    If (Dato.text <> nuova) Then
        Dato.text = nuova
    End If

End Sub


Public Sub DatoNomeRicetta(ByRef Dato As Object)

'controllo come KeyPress
'Nei caratteri ammessi ne ho aggiunti + quelli accentati strani delle varie lingue

    Dim i As Integer
    Dim NomeRicetta As String

    NomeRicetta = Dato.text

    '   N.B.
    '       Utilizzare il while invece del for che altrimenti non gira correttamente
    i = 1
    While (i <= Len(NomeRicetta))
        Select Case Asc(Mid(NomeRicetta, i, 1))
            Case 32         'carattere spazio
            Case 37         '%
            Case 40 To 47   '( ) * + , - . /
            Case 48 To 57   'cifra da 0 da 9
            Case 58 To 63   ': ; < = > ?
            Case 65 To 90   'lettere maiuscole
            Case 91 To 95   '[ \ ] ^ "_"
            Case 97 To 122  'lettere minuscole
            Case 128, 138, 142, 154        '€
            Case 158, 159   'ž


            Case 192 To 255 'lettere accentate varie
            Case Is < 0     'lettere cinesi
            Case Else
                NomeRicetta = Mid(NomeRicetta, 1, i - 1) + Mid(NomeRicetta, i + 1, Len(NomeRicetta) - i)
        End Select
        i = i + 1
    Wend

    Dato.text = NomeRicetta

End Sub

