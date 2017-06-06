Attribute VB_Name = "GestioneGrafica"

Option Explicit


Enum IconaPulsAutoManErr
    automatico
    manuale
    triangologiallo
End Enum
'
Public Enum StatoPulsantePlus
    default
    Selected
    pressed
    Disabled
End Enum



Public Sub IconaStatoManAutoErr(ByRef oggetto As Object, stato As IconaPulsAutoManErr)

'carica nell'oggetto pulsante di grandezza standard 32x32 le immagini corrispondenti allo stato:
'automatico = cerchio arancio, manuale = mano, errore = triangolo giallo

    With oggetto
    
        Select Case stato
            Case automatico
                .Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
            Case manuale
                .Picture = LoadResPicture("IDB_MANUALE", vbResBitmap)
            Case Else
                .Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
        End Select

    End With

End Sub


Public Sub ColoreCasellaTemperatura(ByRef oggetto As Object, codicecolori As Integer)

'standardizzazione dei colori: modifica la casella di una temperatura in base allo stato della variabile "codicecolori":
'codicecolori = 0 : sfondo azzurro e numeri rossi in condizione normale
'codicecolori = 1 : sfondo rosso e numeri gialli in condizione di stato di superamento della soglia di allarme
'codicecolori = 2 : sfondo grigio e numeri rossi in condizione di stato sotto la soglia minima
'codicecolori = 3 : sfondo giallo e numeri rossi in condizione di stato sopra la soglia di attenzione
        
On Error GoTo Errore
    
    With oggetto
        
        Select Case codicecolori
            Case 0
                .ForeColor = &HFF&      'rosso
                .BackColor = &HFFFF00   'azzurro chiaro
            Case 1
                .ForeColor = &HFFFF&    'giallo chiaro
                .BackColor = &HFF&      'rosso
            Case 2
                .ForeColor = &HFF&      'rosso
                .BackColor = &HE0E0E0   'grigio '
            Case 3
                .ForeColor = &HFF&      'rosso
                .BackColor = &HFFFF&    'giallo chiaro
        End Select
    
    End With

    Exit Sub
Errore:
    LogInserisci True, "GRF-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub DisponiPulsantiPlusForm(Form As Object, idStart As Integer, idEnd As Integer, PulsTwip As Boolean, FormTwip As Boolean, Optional align As Integer)

Dim indice As Integer
Dim CoordTBB As Long
Dim unitapulsante As Integer
Dim unitaform As Integer

'Routine per la compattazione e l'allineamento dei pulsanti TopBarButton stile Plus

'tutto questo per colpa dell'inventore dei twip...
    If PulsTwip Then
        unitapulsante = 15
    Else
        unitapulsante = 1
    End If

    If FormTwip Then
        unitaform = 15
    Else
        unitaform = 1
    End If
'

    On Error GoTo Errore

    Select Case align
        Case 0 'sinistra
            CoordTBB = 0
            For indice = idStart To idEnd
                Form.imgPulsanteForm(indice).left = CoordTBB
                If Form.imgPulsanteForm(indice).Visible Then
                    CoordTBB = CoordTBB + (Form.imgPulsanteForm(idStart).width / unitapulsante)
                End If
            Next indice

        Case 1 'destra
            CoordTBB = (Form.width / unitaform) - (Form.imgPulsanteForm(idStart).width / unitapulsante)
            For indice = idStart To idEnd
                Form.imgPulsanteForm(indice).left = CoordTBB
                If Form.imgPulsanteForm(indice).Visible Then
                    CoordTBB = CoordTBB - (Form.imgPulsanteForm(idStart).width / unitapulsante)
                End If
            Next indice

    End Select

    Exit Sub
Errore:
    LogInserisci True, "GRF-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function PlusSuffissoFileImgPulsanteForm(stato As StatoPulsantePlus) As String

    Select Case stato
        Case default
            PlusSuffissoFileImgPulsanteForm = ""
        Case pressed
            PlusSuffissoFileImgPulsanteForm = "_PRESS"
        Case Selected
            PlusSuffissoFileImgPulsanteForm = "_SELECTED"
        Case Disabled
            PlusSuffissoFileImgPulsanteForm = "_GRAY"
        Case Else
            Exit Function
    End Select

End Function
