Attribute VB_Name = "Stampe"

Option Explicit


Public InclusioneStampaOgniDosaggio As Boolean
'STAMPA CONTINUA
Public StampaOgniDosaggioNomeStampante As String
Public StampanteContinua As Printer
Public StampanteDefault As Printer
'
Public StampaOgniDosaggioNumeroColonne As Integer
Public StampaOgniDosaggioRicetta As String
Public StampaOgniDosaggioGiorno As String
Public separatorPrinterString As String


Public Sub StampaOgniDosaggio(ByRef rstStoricoImpasto As adodb.Recordset)

    Dim totale As Double
    Dim Index As Integer
    Dim giorno As String
    Dim ricetta As String
    Dim Contatore As Integer
    Dim valuePrinterString As String
    Dim captionPrinterString As String
    Dim lReturn  As Long


    'STAMPA CONTINUA
    If (Not InclusioneStampaOgniDosaggio Or Not IsPrinterReady(StampaOgniDosaggioNomeStampante)) Then
        Exit Sub
    End If


    If (StampaOgniDosaggioNumeroColonne = 0) Then
        StampaOgniDosaggioNumeroColonne = 80
    End If


    With rstStoricoImpasto

        ricetta = CP240.AdoDosaggioScarico.Recordset.Fields("Descrizione").Value
        giorno = Format(![DataOra], "dd/MM/YY")

        Contatore = 0
        captionPrinterString = ""
        valuePrinterString = ""

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, " ", valuePrinterString, ![Lotto], 4) 'totale

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, giorno, valuePrinterString, Format(![DataOra], "hh:mm:ss"), 8) 'LoadXLSString(403)

        If (NTramoggeA >= 0) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(0), valuePrinterString, ![Inerte1], 6)
            totale = totale + Null2zero(![Inerte1])
        End If
        If (NTramoggeA >= 1) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(1), valuePrinterString, ![Inerte2], 6)
            totale = totale + Null2zero(![Inerte2])
        End If
        If (NTramoggeA >= 2) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(2), valuePrinterString, ![Inerte3], 6)
            totale = totale + Null2zero(![Inerte3])
        End If
        If (NTramoggeA >= 3) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(3), valuePrinterString, ![Inerte4], 6)
            totale = totale + Null2zero(![Inerte4])
        End If
        If (NTramoggeA >= 4) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(4), valuePrinterString, ![Inerte5], 6)
            totale = totale + Null2zero(![Inerte5])
        End If
        If (NTramoggeA >= 5) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(5), valuePrinterString, ![Inerte6], 6)
            totale = totale + Null2zero(![Inerte6])
        End If
        If (AbilitaRAP) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, NomePortina(6), valuePrinterString, ![Inerte7], 6)
            totale = totale + Null2zero(![Inerte7])
        End If
        'N.V.
        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(465), valuePrinterString, ![Inerte8], 6)
        totale = totale + Null2zero(![Inerte8])

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "F1", valuePrinterString, ![Filler1], 5)
        totale = totale + Null2zero(![Filler1])
        If (InclusioneF2) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "F2", valuePrinterString, ![Filler2], 5)
            totale = totale + Null2zero(![Filler2])
        End If
        If (InclusioneF3) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "F3", valuePrinterString, ![Filler3], 5)
            totale = totale + Null2zero(![Filler3])
        End If

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "B1", valuePrinterString, ![Bitume1], 5)
        totale = totale + Null2zero(![Bitume1])
        If (InclusioneBitume2) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "B2", valuePrinterString, ![bitume2], 5)
            totale = totale + Null2zero(![bitume2])
        End If
        If (False) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "B3", valuePrinterString, ![Bitume3], 5)
            totale = totale + Null2zero(![Bitume3])
        End If

        If (InclusioneAddMescolatore) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(418), valuePrinterString, ![Add1], 5)
            totale = totale + Null2zero(![Add1])
        End If
        If (InclusioneAddBacinella) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(419), valuePrinterString, ![Add2], 5)
            totale = totale + Null2zero(![Add2])
        End If
        If (InclusioneAddSacchi) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(460), valuePrinterString, ![AddSacchi], 5)
            totale = totale + Null2zero(![Add-Sacchi])
        End If
        If (InclusioneViatop) Then
            Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, "V. " + LoadXLSString(365), valuePrinterString, ![NetAddViatop], 5)
            totale = totale + Null2zero(![NetAddViatop])
        End If

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(461), valuePrinterString, ![TInertiDeposito], 3)

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(462), valuePrinterString, ![TInertiLavoro], 3)

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(463), valuePrinterString, ![TBitume], 3)

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(464), valuePrinterString, ![TMix], 3)

        Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(459), valuePrinterString, CStr(totale), 6)

        'STAMPA CONTINUA
        'Call StampaOgniDosaggioComponiRiga(Contatore, captionPrinterString, LoadXLSString(316), valuePrinterString, ricetta, 30, True)
        '

    End With

'    For Index = 0 To StampaOgniDosaggioNumeroColonne - 1
'        separatorPrinterString = separatorPrinterString + "-"
'    Next Index

        
'20150706
'        lReturn = ClosePrinter(lhPrinter)
'
            

'    If (DEBUGGING) Then
'        Debug.Print captionPrinterString
'        Debug.Print valuePrinterString
'    End If

    'STAMPA CONTINUA
    'If (StampaOgniDosaggioSeriale) Then
    '    If (Not CP240.SerialPrinter.IsPortOpen) Then
    '        CP240.SerialPrinter.CommPort = StampaOgniDosaggioComPort
    '        Call CP240.SerialPrinter.OpenPort
    '    End If
    'Else
    '    Open "LPT1" For Output Access Write As #1
    'End If
    '


On Error GoTo ErroreLPT1

    Call StampaOgniDosaggioStampa(ricetta, giorno, captionPrinterString, separatorPrinterString, valuePrinterString)

    'STAMPA CONTINUA
    'If (StampaOgniDosaggioSeriale) Then
    '    Call CP240.SerialPrinter.ClosePort
    'Else
    '    Close #1
    'End If
    '

On Error GoTo Errore

    Exit Sub
ErroreLPT1:
    LogInserisci True, "DOS-072", CStr(Err.Number) + " [" + Err.description + "]"

    'STAMPA CONTINUA
    'If (StampaOgniDosaggioSeriale) Then
    '    Call CP240.SerialPrinter.ClosePort
    'Else
    '    Close #1
    'End If
    '
    Exit Sub
Errore:
    LogInserisci True, "DOS-040", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20150707
Public Sub StampaOgniDosaggioEnd()

    Dim lReturn  As Long
            
            
    If (Not InclusioneStampaOgniDosaggio) Or (Not IsPrinterReady(StampaOgniDosaggioNomeStampante)) Or (lhPrinter = 0) Then Exit Sub
                
'    lReturn = EndDocPrinter(lhPrinter)
    
'    lReturn = ClosePrinter(lhPrinter)

    UltimoBatchPrinter = False

End Sub
'

'20150707

Public Sub StampaOgniDosaggioInviaStampa(nomedoc As String, stingastampa As String)
    
    Dim lReturn As Long
    Dim lpcWritten As Long
    Dim MyDocInfo As DOCINFO ' 20150707
    
    On Error GoTo Errore
    
        
    If (Not InclusioneStampaOgniDosaggio Or Not IsPrinterReady(StampaOgniDosaggioNomeStampante)) Then
        Exit Sub
    End If

    'x debug
    'Debug.Print stingastampa
    '

    MyDocInfo.pDocName = nomedoc
    MyDocInfo.pOutputFile = vbNullString
    MyDocInfo.pDatatype = vbNullString
    
    lReturn = StartDocPrinter(lhPrinter, 1, MyDocInfo)
    lReturn = StartPagePrinter(lhPrinter)

    lReturn = WritePrinter(lhPrinter, ByVal stingastampa, Len(stingastampa), lpcWritten)
    
    lReturn = EndPagePrinter(lhPrinter)
    lReturn = EndDocPrinter(lhPrinter)

'    If Not DosaggioInCorso Then
        UltimoBatchPrinter = False '20150707
'    End If


    Exit Sub

Errore:

    LogInserisci True, "PRN-001", CStr(Err.Number) + " [" + Err.description + "]"
    
End Sub
'


'STAMPA CONTINUA
Private Sub StampaOgniDosaggioNuovo(ByRef rstStoricoImpasto As adodb.Recordset)

    Dim lReturn As Long
    Dim lpcWritten As Long
    Dim sWrittenData As String
    Dim Intestazione As String
    Dim ricetta As String
    Dim Index As Integer


'EPSON ESC/P2 CODES
    Dim EscCode As String
    Dim Font10to12CPI As String
    Dim CondensedFont As String
    Dim CancelCondensedFont As String
    Dim BoldFont As String
    Dim CancelBoldFont As String
    Dim DoubleWidthFont1Line As String
    Dim CancelDoubleWidthFont1Line As String


On Error GoTo Errore


    'EPSON ESC/P2 CODES
    EscCode = Chr$(27)
    Font10to12CPI = EscCode + "M" 'Commuta fra 10 e 12 CPI
    CondensedFont = Chr$(15) 'SI
    CancelCondensedFont = Chr$(18) 'DC2
    BoldFont = EscCode + "E"
    CancelBoldFont = EscCode + "F"
    DoubleWidthFont1Line = EscCode + "W1"
    CancelDoubleWidthFont1Line = EscCode + "W0"
    

''--------------------------------------------------------------------------*
'' LX300 : Imposta 12 cpi
''--------------------------------------------------------------------------*
    sWrittenData = Font10to12CPI
''--------------------------------------------------------------------------*
'' LX300 : Seleziona la stampa compressa
''--------------------------------------------------------------------------*
    sWrittenData = sWrittenData + CondensedFont
''--------------------------------------------------------------------------*
'' LX300 : Seleziona stampa a doppia larghezza (1 riga)
''--------------------------------------------------------------------------*
    sWrittenData = sWrittenData + DoubleWidthFont1Line
'
    Call StampaOgniDosaggioInviaStampa("CYB500N_init_printer", sWrittenData)
'
''Stampa intestazione
'
''    sWrittenData = Chr$(15) + "MARINI Fayat Group. " + Chr$(18) + Chr$(27) + "E" + "* DOSING REPORT *" + Chr$(15) + Chr$(27) + "F" + " Date:" + Date$ & vbCrLf & vbCrLf
    
'    If LinguaSelezionata <> LangCIN Then
'        sWrittenData = CondensedFont + "MARINI Fayat Group. " + " " + LoadXLSString(56) + " " + LoadXLSString(403) + ": " + Date$ + vbCrLf
        sWrittenData = CondensedFont + "MARINI Fayat Group. " + CancelCondensedFont + BoldFont + LoadXLSString(55) + vbCrLf + vbCrLf
        sWrittenData = sWrittenData + CondensedFont + CancelBoldFont + " " + LoadXLSString(403) + ": " + Date$ + vbCrLf + vbCrLf
'    Else
'        sWrittenData = CondensedFont + "MARINI Fayat Group. " + "* DOSING REPORT *" + " Date: " + Date$ + vbCrLf
'        sWrittenData = CondensedFont + "MARINI Fayat Group. " + CancelCondensedFont + BoldFont + "* DOSING REPORT *" + CondensedFont + CancelBoldFont + " Date: " + Date$ + vbCrLf
'    End If
                
                
'    Call StampaOgniDosaggioInviaStampa("CYB500N_headerL1_printer", sWrittenData)
'    sWrittenData = ""
                
    With rstStoricoImpasto

        ricetta = CP240.AdoDosaggioScarico.Recordset.Fields("Descrizione").Value
'        giorno = Format(![DataOra], "dd/MM/YY")
         
'        sWrittenData = sWrittenData + "Recipe :" + Chr$(18) + ricetta + Chr$(15) + vbCrLf
        
        If LinguaSelezionata <> LangCIN Then
            sWrittenData = sWrittenData + " " + LoadXLSString(402) + ": " + ricetta + vbCrLf
        Else
            sWrittenData = sWrittenData + " " + "Recipe : " + ricetta + vbCrLf
        End If

'        Print #5, "Riduzione impasto......:" + Str$(VetDosa(3)) + "%"
'        Print #5, "Peso impasto...........:";
    
'    sWrittenData = sWrittenData + Chr$(15) & vbCrLf
        
    End With
        
    Call StampaOgniDosaggioInviaStampa("CYB500N_headerL1_printer", sWrittenData)
        
''--------------------------------------------------------------------------*
'' LX300 : Deseleziona stampa a doppia larghezza
''--------------------------------------------------------------------------*
    sWrittenData = CancelDoubleWidthFont1Line
''--------------------------------------------------------------------------*
'' LX300 : Imposta 10 cpi
''--------------------------------------------------------------------------*
    sWrittenData = sWrittenData + Font10to12CPI
''--------------------------------------------------------------------------*
'' LX300 : Seleziona la stampa compressa
''--------------------------------------------------------------------------*
    sWrittenData = sWrittenData + CondensedFont
    
    Call StampaOgniDosaggioInviaStampa("CYB500_format2_printer", sWrittenData)
        
    'captionPrinterString = ""
    'valuePrinterString = ""

'Stampa separatore linea
    sWrittenData = ""
    sWrittenData = separatorPrinterString & vbCrLf

    Intestazione = "N.  "

    Intestazione = Intestazione + "|Time    "

    If (NTramoggeA >= 0) Then
        Intestazione = Intestazione + "| A1   "
    End If
    If (NTramoggeA >= 1) Then
        Intestazione = Intestazione + "| A2   "
    End If
    If (NTramoggeA >= 2) Then
        Intestazione = Intestazione + "| A3   "
    End If
    If (NTramoggeA >= 3) Then
        Intestazione = Intestazione + "| A4   "
    End If
    If (NTramoggeA >= 4) Then
        Intestazione = Intestazione + "| A5   "
    End If
    If (NTramoggeA >= 5) Then
        Intestazione = Intestazione + "| A6   "
    End If
    If (AbilitaRAP) Then
        Intestazione = Intestazione + "| A7   "
    End If
    'N.V.
        Intestazione = Intestazione + "| A8   "

        Intestazione = Intestazione + "| F1  "
    If (InclusioneF2) Then
        Intestazione = Intestazione + "| F2  "
    End If
    If (InclusioneF3) Then
        Intestazione = Intestazione + "| F3  "
    End If

    Intestazione = Intestazione + "| B1  "
    If (InclusioneBitume2) Then
        Intestazione = Intestazione + "| B2  "
    End If
    If (False) Then
        Intestazione = Intestazione + "| B3  "
    End If

    If (InclusioneAddMescolatore) Then
        Intestazione = Intestazione + "|AddM "
    End If
    If (InclusioneAddBacinella) Then
        Intestazione = Intestazione + "|AddB "
    End If
    If (InclusioneAddSacchi) Then
        Intestazione = Intestazione + "|Bags "
    End If
    If (InclusioneViatop) Then
        Intestazione = Intestazione + "|Viat "
    End If

    Intestazione = Intestazione + "|TS "
    Intestazione = Intestazione + "|TC "
    Intestazione = Intestazione + "|TB "
    Intestazione = Intestazione + "|TM "

    Intestazione = Intestazione + "|total |"
    'Intestazione = Intestazione + "|recipe name                  |"


    sWrittenData = sWrittenData + Intestazione & vbCrLf
        
'20150707
'    'Init processo di stampa
'    MyDocInfo.pDocName = "new_prod_batch_record"
'    MyDocInfo.pOutputFile = vbNullString
'    MyDocInfo.pDatatype = vbNullString
'    lReturn = StartDocPrinter(lhPrinter, 1, MyDocInfo)
'    lReturn = StartPagePrinter(lhPrinter)
''
'    'Corpo stampa
'    lReturn = WritePrinter(lhPrinter, ByVal sWrittenData, Len(sWrittenData), lpcWritten)
                        
'    'Chiusura stampa
'    lReturn = EndPagePrinter(lhPrinter)
'
'    lReturn = EndDocPrinter(lhPrinter)
'
    Call StampaOgniDosaggioInviaStampa("CYB500_header_L3_printer", sWrittenData)
    sWrittenData = ""
'

    Exit Sub
Errore:
    LogInserisci True, "DOS-041", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Private Sub StampaOgniDosaggioStampa(ricetta As String, giorno As String, caption As String, ByVal separator As String, Riga As String)

    Dim Length As Integer
    Dim position As Integer
    Dim rowLength As Integer
    Dim rowToBePrinted As Integer
    Dim cambioGiorno As Boolean
    Dim cambioRicetta As Boolean
    Dim separatoreStampato As Boolean

    Dim lReturn As Long
    Dim lpcWritten As Long
    Dim sWrittenData As String
    Dim rstStoricoImpasto As New adodb.Recordset

On Error GoTo Errore

    rowLength = Len(Riga)
    rowToBePrinted = rowLength / StampaOgniDosaggioNumeroColonne

    If (ricetta <> "") Then
        cambioRicetta = (StampaOgniDosaggioRicetta <> ricetta)
        StampaOgniDosaggioRicetta = ricetta
    End If
    If (giorno <> "") Then
        cambioGiorno = (StampaOgniDosaggioGiorno <> giorno)
        StampaOgniDosaggioGiorno = giorno
    End If

    If (cambioRicetta Or cambioGiorno) Then
        'Al cambio ricetta o giorno devo ristampare l'intestazione
        Call StampaOgniDosaggioStampa("", "", "", "", separator)
        separatoreStampato = True
    End If

    'STAMPA CONTINUA
    If (cambioRicetta) Then
        'Al cambio ricetta o giorno devo ristampare l'intestazione
        Call StampaOgniDosaggioNuovo(rstStoricoImpasto)
        separatoreStampato = True
    End If
    '

    'STAMPA CONTINUA
    'If (StampaOgniDosaggioNumeroRighe > 0) Then
    '    If (StampaOgniDosaggioRigheStampate + rowToBePrinted > StampaOgniDosaggioNumeroRighe) Then
    '        'Stamperei a metà una ricetta --> salto pagina
    '        Call StampaOgniDosaggioNuovo
    '        separatoreStampato = False 'Anche se l'avevo stampato adesso non importa più

    '    End If
    'End If
    '

    If (rowLength > StampaOgniDosaggioNumeroColonne) Then
        position = 0
        Do
            Length = rowLength - position
            If (Length > StampaOgniDosaggioNumeroColonne) Then
                Length = StampaOgniDosaggioNumeroColonne
            End If
            Call StampaOgniDosaggioStampa(ricetta, giorno, caption, separator, Mid(Riga, position + 1, Length))
            position = position + Length
        Loop While (position < rowLength)

        Exit Sub
    End If

    'STAMPA CONTINUA
    
'20150707
'    MyDocInfo.pDocName = "batch_record"
'    MyDocInfo.pOutputFile = vbNullString
'    MyDocInfo.pDatatype = vbNullString
'    lReturn = StartDocPrinter(lhPrinter, 1, MyDocInfo)
'    lReturn = StartPagePrinter(lhPrinter)
'

'    sWrittenData = Chr$(27) + "M" + Chr$(15)
'    lReturn = WritePrinter(lhPrinter, ByVal sWrittenData, Len(sWrittenData), lpcWritten)
'
'    sWrittenData = Riga & vbCrLf
'    lReturn = WritePrinter(lhPrinter, ByVal sWrittenData, Len(sWrittenData), lpcWritten)

    sWrittenData = Chr$(27) + "M" + Chr$(15)
    sWrittenData = sWrittenData + Riga & vbCrLf

    Call StampaOgniDosaggioInviaStampa("batch_record", sWrittenData)

'    lReturn = EndPagePrinter(lhPrinter)
'
'    lReturn = EndDocPrinter(lhPrinter) '20150707
    
    '
    
    Exit Sub
Errore:
    LogInserisci True, "DOS-039", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Private Function StampaOgniDosaggioFormatta(Contatore As Integer, valore As String, Caratteri As Integer, last As Boolean) As String
        
    StampaOgniDosaggioFormatta = ""

    If (Len(valore) > Caratteri) Then
        StampaOgniDosaggioFormatta = StampaOgniDosaggioFormatta + left(valore, Caratteri)
    Else
            Dim indice As Integer
            Dim formattazione As String

            For indice = 0 To Caratteri - 1
                formattazione = formattazione + "@"
            Next indice
            If (last) Then
                StampaOgniDosaggioFormatta = Format(valore, "")
            Else
                StampaOgniDosaggioFormatta = Format(valore, "!" + formattazione)
            End If
    End If
    If (Not last) Then
            StampaOgniDosaggioFormatta = StampaOgniDosaggioFormatta + "|"
    End If

End Function


Private Sub StampaOgniDosaggioComponiRiga( _
    ByRef Contatore As Integer, _
    ByRef caption As String, _
    captionValue As String, _
    ByRef body As String, _
    bodyValue As String, _
    Caratteri As Integer, _
    Optional last As Boolean _
    )

        Dim Index As Integer
        Dim carPlus As Integer
        Dim captionLength As Integer

        If (last) Then
            Dim maxCaratteri As Integer
            
            maxCaratteri = Len(captionValue)
            If (Len(bodyValue) > maxCaratteri) Then
                maxCaratteri = Len(bodyValue)
            End If
            If (Caratteri > maxCaratteri) Then
                Caratteri = maxCaratteri
            End If
        Else
            carPlus = 1
        End If

        captionLength = Len(caption) Mod StampaOgniDosaggioNumeroColonne
        If (captionLength + Caratteri + carPlus > StampaOgniDosaggioNumeroColonne) Then
            For Index = 0 To StampaOgniDosaggioNumeroColonne - captionLength - 1
                caption = caption + " "
                body = body + " "
            Next Index
        End If

    caption = caption + StampaOgniDosaggioFormatta(Contatore, captionValue, Caratteri, last)
    body = body + StampaOgniDosaggioFormatta(Contatore, bodyValue, Caratteri, last)

    Contatore = Contatore + 1

End Sub



