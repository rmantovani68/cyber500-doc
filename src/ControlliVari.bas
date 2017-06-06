Attribute VB_Name = "ControlliVari"
Option Explicit

Private Type SYSTEMTIME

    wYear As Integer
    wMonth As Integer
    wDayOfWeek As Integer
    wDay As Integer
    wHour As Integer
    wMinute As Integer
    wSecond As Integer
    wMilliseconds As Integer

End Type


Private Declare Sub GetSystemTime Lib "Kernel32" (lpSystemTime As SYSTEMTIME)

Public Declare Function RecupHandleBureau Lib "User32" Alias "GetDesktopWindow" () As Long
Public Declare Function NextWindow Lib "User32" Alias "GetWindow" (ByVal hWnd As Long, ByVal wCmd As Long) As Long
Public Declare Function GetWindowText Lib "User32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Declare Function GetUserName Lib "ADVAPI32.dll" Alias "GetUserNameA" (ByVal lpbuffer As String, nSize As Long) As Long


'   Ultim'ora
Private LastDateTime As Date

'   Stato di errore della funzione "DatoCorretto"
Public ErroreDatoParametri As Boolean

Public GrandezzaImpasto(2) As Long

Type TemperaturaType
    Correzione As Long
    FondoScalaMin As Long
    FondoScalaMax As Long
    MilliAmpere420 As Boolean

    valore As Long
End Type

'20151228
Type TipoTemporizzatoreStandard
    AppTempo As Single
    TempoExec As Boolean 'fronte attivazione timer
    ErrTimer As Boolean
End Type
'

Public Enum TemperatureEnum
    TempLegante1Pompa
    TempLegante1Tubo
    TempLegante2Pompa
    TempLegante2Tubo
    TempLegante3Pompa
    TempLegante3Tubo
    TempLeganteBacinella
    TempTamburoIngresso
    TempScivolo
    TempTamburoUscita
    TempEntrataFiltro
    TempUscitaFiltro
    TempTorre1
    TempTorre0
    TempTorre2
    TempSottoMescolatore
    TempSilo0
    TempSilo1
    TempLegante4Pompa
    TempLegante4Tubo
    TempFumiTamburo1
    TempFumiTamburo2
    TempTorre3
    TempTorre4
    TempTorre5
    TempTorre6
    TempSilo2
    TempSilo3
    TempSilo4
    TempScivolo2
    TempScambComb
    
    TempMax
End Enum
Public ListaTemperature(0 To TempMax - 1) As TemperaturaType

Public NumTraduzioni As Long
Public Traduzioni() As String

Type RecordAllarmi
    tipo As Integer
    Descrizione As String
    Codice As String
End Type
Public Allarmi() As RecordAllarmi
Public TipoAllarmi() As RecordAllarmi

Public Const cstIndiceImmagineValvola3VieBitumeEsterno = 21

Public InclusioneBitumeEsterno As Boolean
Public StatoValvolaManCircuitoBitume As enumStatoValvolaBitumeEsterno 'var di stato della valvola manuale

'20160312
Public Type TemporizzatoreStandardType
    ScalaTempo As Integer
    Tempo As Long
    AppTempo As Single
    TempoExec As Boolean
    uscita As Boolean
    Abilitazione As Boolean
    ErrTimer As Boolean
End Type
'

'   Valvola preseparatore
Public Type ValvolaAutoManRitardata
    abilitato As Boolean
    ModoAutomatico As Boolean '=1 attiva la gestione automatica
    ErroreTimer As Boolean 'si e' verificato un errore nel timer che lo gestisce
    uscita As Boolean 'uscita digitale di comando della valvola
    ritorno As Boolean 'ingresso digitale stato valvola
    EsecuzioneRitardoInCorso As Boolean 'e' in corso il tempo di ritardo all'apertura
    RitardoApertura As Long 'parametro in secondi di ritardo all'apertura
    RitardoChiusura As Long 'parametro in secondi di ritardo alla chiusura
    TemporizzatoreApertura As TemporizzatoreStandardType '20160312
    TemporizzatoreChiusura As TemporizzatoreStandardType '20160312
End Type

Public ValvolaPreseparatore As ValvolaAutoManRitardata
Public AppoggioTempoValvolaPresep As Single
'20160105
'Public MemoriaStatoAccensioneBruciatore As Boolean
Public MemoriaGestioneValvolaPreseparatore As Boolean
Public MemoriaGestioneValvolaPreseparatoreAnello As Boolean
'
'20150805
'20160105 Public MemoriaStatoAccensionePredosatori As Boolean
Public ValvolaPreseparatoreAnello As ValvolaAutoManRitardata
Public AppoggioTempoValvolaPreseparatoreAnello As Single
'

'   Rilevazione della temperatura legante in bacinella
Public AbilitaTemperaturaLeganteBacinella As Boolean

'   Visualizzazione della pressione dell'aria dell'impianto
Public AbilitaPressioneAriaImpianto As Boolean
Public MinScalaPressioneAriaImpianto As Long
Public MaxScalaPressioneAriaImpianto As Long
Public PressioneAriaImpianto As Double

Public MescolatoreAperto As Boolean
Public MescolatoreChiuso As Boolean

Public BitumeDaCircuitoMarini As Boolean
Public BitumeDaCircuitoEsterno As Boolean

Public ContalitriErroreTimeOutAvvio As Boolean
Public ContalitriErroreTimeOutArresto As Boolean

Public BassaTemperaturaBitume(0 To 3) As Boolean

Public DataStartCyb500 As Date

Public FrmInversionePCLVisibile As Boolean

Public FrmTestPredosatoriVisible As Boolean
Public MemWatchdogCS As Boolean '20161021
'



' Conversione pixel -> Twips: 1 Pixel = 15 Twips
Public Function Pixel2Twips(pixel As Integer) As Integer
    Pixel2Twips = pixel * 15
End Function

Public Sub ScriviOra()

    On Error GoTo Errore

    If (CDbl(LastDateTime) > 0) Then

        Dim secondi As Long

        secondi = DateDiff("s", LastDateTime, DateTime.Now)

        If (secondi < -1) Then
            '   La data è stata spostata indietro
            TrendVerificaData
        '20161123
        'Aggiorna la status bar solo ogni secondo per ridurre al minimo lo sfarfallio del refresh
        ElseIf (secondi >= 1) Then
            CP240.StatusBar1.Panels(STB_ORA).text = time
        '
        End If

        '   Considera solo le modifiche per più di 15 minuti (900 secondi)
        If (secondi > 900 Or secondi < -900) Then
            '   Aggiorno il file delle modifiche agli orari
            Open LogPath + "TimeChange.log" For Append As #99
            Write #99, "OLD = " + CStr(LastDateTime), "NEW = " + CStr(DateTime.Now)
            Close #99
        End If

    End If
    LastDateTime = DateTime.Now

'20161123
'    CP240.StatusBar1.Panels(STB_ORA).text = time
    
    Exit Sub
Errore:
    LogInserisci True, "CTL-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function Binary2Integer(s As String) As Integer
Dim i As Integer
    
    For i = 1 To Len(s)
        If Mid(s, (Len(s) - i + 1), 1) = 1 Then
            Binary2Integer = Binary2Integer + (2 ^ (i - 1))
        End If
    Next i

End Function

Public Function Integer2Binary(n As Integer) As String
'Dim i As Integer
Dim Cont As Integer
    
    Cont = 0
    Do While Not (n \ (2 ^ Cont) < 1)
        Integer2Binary = (1 And ((n And (2 ^ Cont)) > 0)) & Integer2Binary
        Cont = Cont + 1
    Loop

End Function

Public Function DatoCorretto(Dato As String, decimali As Integer, min As Double, max As Double, predefinito As Double, Optional lost As Integer) As Variant
	'Si usa così sull'evento change della txt, serve il sendkeys.
	'PercAgg(Index).Text = DatoCorretto(PercAgg(Index), 1, 0, 100,0)
	'SendKeys "{END}": On Error Resume Next

    Dim appoggio As Double
    Dim datoApp As String
    Dim i As Integer

    If Abs(lost) = 1 Then
        Dato = Null2zero(Dato)
    End If
    
    If Dato = "" Then
        GoTo Errore '20151112
        Exit Function
    End If

    If Dato = "-" And min < 0 Then
        DatoCorretto = Dato
        Exit Function
    End If

    DatoCorretto = min - 1
    'Sostituisco il "." con la "," se presente
    For i = 1 To Len(Dato)
        If Mid(Dato, i, 1) = "." Or Mid(Dato, i, 1) = "," Then
            datoApp = datoApp & ","
            If Len(Dato) - i > decimali Then
                'Ci sono troppe cifre decimali dopo la virgola
                GoTo Errore
            End If
        Else
            datoApp = datoApp & Mid(Dato, i, 1)
        End If
    Next i
    On Error GoTo Errore
    If decimali = 0 Then    'Intero
        appoggio = CLng(datoApp)
        If appoggio >= min And appoggio <= max Then
            DatoCorretto = appoggio
        End If
    Else                'Decimale
        appoggio = RoundNumber(datoApp, decimali)
        If appoggio >= min And appoggio <= max Then
            DatoCorretto = datoApp
        End If
    End If
    If DatoCorretto = min - 1 Then
        GoTo Errore
    End If
    Exit Function

Errore:

    If (Not ErroreDatoParametri) Then
        ErroreDatoParametri = True

        ShowMsgBox _
            LoadXLSString(699) + " = " & min & " " + LoadXLSString(700) + " = " & max, _
            vbOKOnly, _
            vbExclamation, _
            -1, _
            -1, _
            True

        On Error GoTo 0
        DatoCorretto = predefinito
    Else
        '   Non ritorno il dato corretto
        '   In questo caso è già visualizzato: il change genera l'errore che genera
        '   il lostFocus che genera di nuovo l'errore
        DatoCorretto = Dato
    End If

End Function


Public Function VerificaTextEdit( _
    txtControl As TextBox, _
    decimali As Integer, _
    min As Double, _
    max As Double, _
    predefinito As Double, _
    lost As Boolean _
    ) As Boolean

    Dim Dato As String
    Dim appoggio As Double
    Dim datoApp As String
    Dim DatoCorretto As String
    Dim i As Integer


    'Tutto a posto
    VerificaTextEdit = True
    
    Dato = txtControl.text

    If Abs(lost) = 1 Then
        Dato = Null2zero(Dato)
    End If

    If Dato = "" Then
        Exit Function
    End If

    If Dato = "-" And min < 0 Then
        Exit Function
    End If

    DatoCorretto = min - 1
    'Sostituisco il "." con la "," se presente
    For i = 1 To Len(Dato)
        If Mid(Dato, i, 1) = "." Or Mid(Dato, i, 1) = "," Then
            datoApp = datoApp & ","
            If Len(Dato) - i > decimali Then
                'Ci sono troppe cifre decimali dopo la virgola
                GoTo Errore
            End If
        Else
            datoApp = datoApp & Mid(Dato, i, 1)
        End If
    Next i
    On Error GoTo Errore
    If decimali = 0 Then
        'Intero
        appoggio = CLng(datoApp)
        If appoggio >= min And appoggio <= max Then
            DatoCorretto = appoggio
        End If
    Else
        'Decimale
        appoggio = RoundNumber(datoApp, decimali)
        If appoggio >= min And appoggio <= max Then
            DatoCorretto = datoApp
        End If
    End If
    If DatoCorretto = min - 1 Then
        GoTo Errore
    End If

    If (txtControl.text <> DatoCorretto) Then
        txtControl.text = DatoCorretto

        VerificaTextEdit = False
    End If

    Exit Function

Errore:

    'Prima assegno il nuovo valore, dopo visualizzo il messaggio d'errore
    'In questo modo evito che il change generi l'errore che a sua volta generi il lostFocus che genererebbe di nuovo l'errore

    txtControl.text = predefinito 'Quest'assegnamento NON deve dare MAI errore!

    ShowMsgBox _
        LoadXLSString(699) + " = " & min & " " + LoadXLSString(700) + " = " & max, _
        vbOKOnly, _
        vbExclamation, _
        -1, _
        -1, _
        True

    'Trovato un errore
    VerificaTextEdit = False

    Call txtControl.SetFocus

End Function

Public Function Long2Bit(numero As Long) As String
    Do While numero > 0
        Long2Bit = CStr(numero Mod 2) & Long2Bit
        numero = numero \ 2
    Loop
End Function

Function DlookUp(ByVal NomeCampo As String, ByVal Tabella As String, ByVal CriterioConfronto As String, Optional NomeCampo2 As String, Optional CriterioConfronto2 As String) As Variant
	'Restituisce il valore del Campo indicato da NomeCampo, della Tabella indicata che soddisfa i criteri passati
	'Serve per vedere se c'è un valore nel campo selezionato
    
    Dim rs As New adodb.Recordset


    With rs
        Set .ActiveConnection = DBcon
        If NomeCampo2 = "" Then
            .Source = "Select * From " & Tabella & " Where " & NomeCampo & "=" & CriterioConfronto & ";"
        Else
            .Source = "Select * From " & Tabella & " Where " & NomeCampo & "=" & CriterioConfronto & " AND " & NomeCampo2 & "= CONVERT(DATETIME, '" & Format(CriterioConfronto2, "yyyy-mm-dd hh:nn:ss") & "', 102)" & ";"
        End If
        '.Source = "Select * From " & Tabella & ";"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With

    On Error GoTo Error_DLookup:

    'Controlla se lo trova
    If Not rs.EOF Then
    'If Not rs.NoMatch Then
       'Restituisce il valore del campo
       DlookUp = rs(NomeCampo).Value
    Else
        DlookUp = Null
    End If

DLookup_Exit:
   Exit Function

Error_DLookup:
    'Display the error and get out
    ShowMsgBox _
        LoadXLSString(805) + " " + Err + " " + Error(Err), _
        vbOKOnly, _
        vbExclamation, _
        -1, _
        -1, _
        True
    Resume DLookup_Exit:

End Function

Public Function Null2Qualcosa(valore)
    Null2Qualcosa = IIf((Not IsNull(valore) And valore <> ""), valore, 0)
End Function

Public Function Null2zero(valore As String) As Double
    Null2zero = String2Double(valore)
End Function

Public Function String2Double(valore As String) As Double

    Dim indice As Integer
    Dim StringaControllo As String
    Dim StringaPulita As String
    
    String2Double = 0

    On Error GoTo Errore

    StringaControllo = Null2Qualcosa(valore)

'Promemoria caratteri ascii
'44 = ,
'45 = -
'46 = .
'48 a 57 = numeri 0..9

    For indice = 1 To Len(StringaControllo)
        If (Asc(Mid(StringaControllo, indice, 1)) >= 48 And Asc(Mid(StringaControllo, indice, 1)) <= 57) _
            Or Asc(Mid(StringaControllo, indice, 1)) >= 44 Or Asc(Mid(StringaControllo, indice, 1)) <= 46 Then
            StringaPulita = StringaPulita & Mid(StringaControllo, indice, 1)
        End If
    Next indice
'
    StringaPulita = SostituisciCaratteri(StringaPulita, ".", ",")

    If (Not IsNull(StringaPulita) And StringaPulita <> "") Then
        String2Double = CDbl(StringaPulita)
    End If

Errore:

End Function


Public Function ControlloChiaveHL() As Boolean
	'restituisce true se bisogna controllare la chiave HL

    Dim hWnd As Long
    Dim TitreFenetre As String * 255
    Dim Titre As String
    Dim r
    Dim p1 As Integer
    Dim p2 As Integer

    ControlloChiaveHL = True
    
    'recupera il nome di tutte le sessioni aperte
    hWnd = NextWindow(RecupHandleBureau(), 5)
    Do While hWnd <> 0
        TitreFenetre = String(255, 0)
        r = GetWindowText(hWnd, TitreFenetre, 255)
        If TitreFenetre <> String(255, 0) Then
            Titre = TitreFenetre
            Titre = left(Titre, r)
            If UCase(left(Titre, 8)) = "COMCP240" Then
                'cerco il nome dell'applicazione
                p1 = p1 + 1
            End If
            If UCase(Titre) = UCase("MAP - Microsoft Visual Basic [esecuzione]") Then
                'deve essere aperto VB6 con progetto map
                p2 = p2 + 100
            End If
        End If
        hWnd = NextWindow(hWnd, 2)
    Loop
    
    If (p1 + p2) = 101 Then
        ControlloChiaveHL = False
    End If

End Function

Function DlookUpExt(ByVal NomeCampo As String, ByVal Tabella As String, ByVal CriterioConfronto As String, ByVal NomeCampo2 As String) As Variant
	'Restituisce il valore del Campo indicato da NomeCampo2, della Tabella indicata che soddisfa i criteri passati per il Campo NomeCampo

    Dim rs As New adodb.Recordset

    On Error GoTo Error_DLookupExt

    With rs
        Set .ActiveConnection = DBcon
        '.Source = "Select * From " & Tabella & ";"
        .Source = "Select * From " & Tabella & " WHERE " & NomeCampo & "='" & CriterioConfronto & "' ;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With

    If Not rs.EOF Then
        DlookUpExt = rs(NomeCampo2).Value
    Else
        If (Tabella = "CodificaAllarmi") Then   'N.B. Per gli allarmi si cerca sull'indice restituito: con -1 segnaliamo l'assenza
            DlookUpExt = -1
            ShowMsgBox CriterioConfronto + " not found", vbOKOnly, vbExclamation, -1, -1, True
        Else
            DlookUpExt = 0
        End If
    End If

    If (rs.State <> adStateClosed) Then
        rs.Close
    End If

DLookupExt_Exit:
   Exit Function

Error_DLookupExt:
    'Display the error and get out
     ShowMsgBox _
         LoadXLSString(805) + " " + Err + " " + Error(Err), _
         vbOKOnly, _
         vbExclamation, _
         -1, _
         -1, _
         True
    Resume DLookupExt_Exit:

End Function

Public Sub Lampeggio(ByRef oggetto As Object, ColoreOff, ColoreOn, enable As Boolean)
    
'    If enable And oggetto.BackColor = ColoreOff And (CLng(Timer) Mod 2 <> 0) Then
    If enable And (CLng(Timer) Mod 2 <> 0) Then 'lampeggio 1 secondo
        
        oggetto.BackColor = ColoreOn
    Else
        oggetto.BackColor = ColoreOff
    End If
End Sub
'

Public Function RicavaWhere(s As String) As String
    Dim i As Long
    Dim Inizio As Long
    Dim Fine As Long

    For i = 1 To Len(s)
        If UCase(Mid(s, i, 5)) = "WHERE" Then
            Inizio = i + 5
        End If
        If UCase(Mid(s, i, 5)) = "ORDER" Then
            Fine = i
        End If
    Next i
    If Inizio <> 0 And Fine <> 0 Then
        RicavaWhere = Mid(s, Inizio, Fine - Inizio)
    End If

End Function


Public Function ScalaturaUnitaAnalogIN(Unita As Long, LimiteScalaMax As Long, LimiteScalaMin As Long) As Long
        
    Select Case Unita
        Case 27649 To 32511
'il segnale e' oltre il range impostato, ma ancora leggibile dalla scheda
            Unita = 27648

        Case 32512 To 32767
'siamo di fronte ad un segnale nella terra di nessuno (oltre la scala massima impostata nell'hw della scheda, ma entro la zona dei negativi), quindi lo limito al massimo ammesso.
            Unita = 27648

        Case 32768 To 37632
'siamo di fronte ad un segnale negativo, ma ancora leggibile dalla scheda
            Unita = 0

        Case 37633 To 65535
'siamo di fronte ad un segnale nella terra di nessuno (oltre la scala minima impostata nell'hw della scheda, quindi lo limito al minimo ammesso.
            Unita = 0

        Case Is < 0
'le unita vanno da 0 a 65535. Unita' negative non sono valide.
            Unita = 0
    End Select

    
    If LimiteScalaMin = 0 Then
        ScalaturaUnitaAnalogIN = (LimiteScalaMax * Unita) / 27648
    Else
        ScalaturaUnitaAnalogIN = ((LimiteScalaMax - LimiteScalaMin) * Unita / 27648) + LimiteScalaMin
    End If

End Function

Public Function ScalaturaUnitaAnalogINConNegativi(Unita As Long, LimiteScalaMax As Long, LimiteScalaMin As Long) As Long
'TODO si potrebbe unificare in un'unica funzione specificando con parametro della funzione se i negativi sono ammessi. Ci vuole tempo e pazienza per sostituire tutte le chiamate!
    
    
    Select Case Unita
        Case 27649 To 32768
'siamo di fronte ad un segnale nella terra di nessuno (oltre la scala massima impostata nell'hw della scheda, ma entro la zona dei negativi), quindi lo limito al massimo ammesso.
            Unita = 27648
        Case Is < 0
'le unita vanno da 0 a 65535, da 0 a 27648 sono valori positivi, da 27649 a 65535 sono negativi. Unita' negative non sono valide.
            Unita = 0
    End Select
    
        
    If Unita > 32768 Then
'segnale negativo
        ScalaturaUnitaAnalogINConNegativi = (((LimiteScalaMax - LimiteScalaMin) * Unita / 65535) + LimiteScalaMin) * (-1)
    Else
'segnale positivo
        If LimiteScalaMin = 0 Then
            ScalaturaUnitaAnalogINConNegativi = (LimiteScalaMax * Unita) / 27648
        Else
            ScalaturaUnitaAnalogINConNegativi = ((LimiteScalaMax - LimiteScalaMin) * Unita / 27648) + LimiteScalaMin
        End If
    End If

End Function

Public Function ScalaturaUnitaAnalogIN_Double(Unita As Long, LimiteScalaMax As Long, LimiteScalaMin As Long) As Double

    If LimiteScalaMin = 0 Then
        ScalaturaUnitaAnalogIN_Double = (LimiteScalaMax * Unita) / 27648
    Else
        ScalaturaUnitaAnalogIN_Double = ((LimiteScalaMax - LimiteScalaMin) * Unita / 27648) + LimiteScalaMin
    End If

End Function


Public Sub VerificaEvacuazioneFiltroDMR()

End Sub


Public Sub VerificaEvacuazioneSiloFiller()

    If (Not InclusioneEvacuazioneSiloFiller) Then
        OraStartEvacuazioneSiloFiller = 0
        Exit Sub
    End If
    
    '20161010
    'If (OraStartEvacuazioneSiloFiller > 0) Then
    '    If (ConvertiTimer() >= OraStartEvacuazioneSiloFiller + TimeoutEvacuazioneFiller) Then
    '        If (ComandoEvacuazioneSiloFiller And Not RitornoEvacuazioneSiloFiller) Then
    '            CP240.AniPushButtonDeflettore(14).Value = 1
    '            ComandoEvacuazioneSiloFiller = False
    '        End If
    '        OraStartEvacuazioneSiloFiller = 0
    '    End If
    'End If
    If (ComandoEvacuazioneSiloFiller And Not RitornoEvacuazioneSiloFiller) Then
        If (OraStartEvacuazioneSiloFiller > 0) Then
            If (ConvertiTimer() >= OraStartEvacuazioneSiloFiller + TimeoutEvacuazioneFiller) Then
                CP240.AniPushButtonDeflettore(14).Value = 1
                ComandoEvacuazioneSiloFiller = False
                OraStartEvacuazioneSiloFiller = 0
            End If
        End If
    End If
    '
    
    If ComandoEvacuazioneSiloFiller And RitornoEvacuazioneSiloFiller Then
        CP240.AniPushButtonDeflettore(14).Value = 3
    End If
    
End Sub

Public Sub EvacuazioneFiltroDMR_change()

    On Error GoTo Errore

    If (Not InclusioneDMR) Then
        Exit Sub
    End If
    
    If EvacuazFiltroErrore Then
        CP240.AniPushButtonDeflettore(7).Value = 1
    ElseIf (EvacuazioneFiltroDMR And RitornoEvacuazioneFiltroDMR) Then
        CP240.AniPushButtonDeflettore(7).Value = 3
    ElseIf (EvacuazioneFiltroDMR And Not RitornoEvacuazioneFiltroDMR) Then
        CP240.AniPushButtonDeflettore(7).Value = 2
    Else
        CP240.AniPushButtonDeflettore(7).Value = 4
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "CTL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'   Testa l'esistenza del file
Public Function FileExist(FileName As String) As Boolean

    On Error GoTo Errore
    FileExist = (FileLen(FileName) > 0)

    Exit Function
Errore:
    FileExist = False
End Function


'   Verifica l'esistenza di un direttorio
Public Function PathExist(path As String) As Boolean

    On Error GoTo Errore

    If Dir(path, vbDirectory) <> "" Then
        PathExist = True
        Exit Function
    End If

Errore:
    PathExist = False
End Function

    
'   Crea un direttorio
Public Sub CreatePath(ByVal path As String)

    On Error GoTo Errore

    If Mid(path, Len(path), 1) = "/" Or Mid(path, Len(path), 1) = "\" Then
        path = Mid(path, 1, Len(path) - 1)
    End If

    If (Not PathExist(path)) Then
        Call MkDir(path)
    End If

    Exit Sub

Errore:

    Dim indice As Integer

    For indice = Len(path) To 1 Step -1
        If Mid(path, indice, 1) = "/" Or Mid(path, indice, 1) = "\" Then
            Call CreatePath(Mid(path, 1, indice - 1))
            Call CreatePath(path)
            Exit Sub
        End If
    Next indice
            
End Sub


'   Converte un valore booleano nel valore da assegnare ad un checkbox
Public Function BoolToCheck(Value As Boolean) As Integer

    BoolToCheck = IIf(Value, 1, 0)

End Function


Public Sub PressioneAriaImpianto_change()

    On Error GoTo Errore

    With CP240

        .LblEtichetta(196).caption = Format(PressioneAriaImpianto, "0.0")

    End With

    Exit Sub
Errore:
    LogInserisci True, "CTL-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Verifica se la temperatura del bitume è bassa
Public Function BassaTempBitume(runTimeStop As Boolean) As Boolean

    BassaTempBitume = False
    
'20150704
'    If (ForzaturaPCL) Then
'        '   Francamente della temperatura me ne infischio...
'        BassaTemperaturaBitume(0) = False
'        BassaTemperaturaBitume(1) = False
'        BassaTemperaturaBitume(2) = False
'        BassaTemperaturaBitume(3) = False
'
'        Exit Function
'    End If
'

    If (Not AbilitaTemperaturaLeganteBacinella) Then
        ListaTemperature(TempLeganteBacinella).valore = TempMinimaBitume
    End If
    '
    
    If (Not ListaMotori(MotorePCL2).presente) Then
        ListaTemperature(TempLegante2Pompa).valore = TempMinimaBitume
        ListaTemperature(TempLegante2Tubo).valore = TempMinimaBitume
    End If

    If (Not ListaMotori(MotorePCL3).presente) Then
        ListaTemperature(TempLegante3Pompa).valore = TempMinimaBitume
        ListaTemperature(TempLegante3Tubo).valore = TempMinimaBitume
    End If

    If (Not ListaMotori(MotorePompaEmulsione).presente) Then
        ListaTemperature(TempLegante4Pompa).valore = TempMinimaBitume
        ListaTemperature(TempLegante4Tubo).valore = TempMinimaBitume
    End If

    If Not InclusioneTemperaturaLineaCaricoBitume Then
        ListaTemperature(TempLegante1Tubo).valore = TempMinimaBitume
        ListaTemperature(TempLegante2Tubo).valore = TempMinimaBitume
        ListaTemperature(TempLegante3Tubo).valore = TempMinimaBitume
        ListaTemperature(TempLegante4Tubo).valore = TempMinimaBitume
    End If

    BassaTemperaturaBitume(0) = (ListaTemperature(TempLegante1Pompa).valore < TempMinimaBitume)
    BassaTemperaturaBitume(1) = (ListaTemperature(TempLegante2Pompa).valore < TempMinimaBitume)
    BassaTemperaturaBitume(2) = (ListaTemperature(TempLegante3Pompa).valore < TempMinimaBitume)
    BassaTemperaturaBitume(3) = (ListaTemperature(TempLegante4Pompa).valore < TempMinimaEmulsione) And ListaMotori(MotorePompaEmulsione).presente  '20151218
'

    BassaTempBitume = (BassaTemperaturaBitume(0) Or BassaTemperaturaBitume(1) Or BassaTemperaturaBitume(2) Or BassaTemperaturaBitume(3))

End Function

        
Public Sub Temporizzatore2Tempi(TempoLavoro As Long, TempoSosta As Long, AppTempo As Single, LavoroExec As Boolean, SostaExec As Boolean, uscita As Boolean, Abilitazione As Boolean, ErrTimer As Boolean)
	'Gestione uscita temporizzata con tempo di sosta e tempo di lavoro impostabile utilizzando il timer di sistema

    On Error GoTo Errore
            
	'Allo scadere della mezzanotte il timer viene azzerato, quindi bisogna adattare la variabile AppTempo
    If (AppTempo > Timer) Then
        AppTempo = AppTempo - 86400 'nota: 86400 e' il numero di secondi in un giorno
    End If
            
	'avvia il processo partendo dallo stato di quiete
    If uscita = False And SostaExec = False And LavoroExec = False And Abilitazione = True Then
        uscita = True
        LavoroExec = True
        AppTempo = Timer
        Exit Sub
    End If
    
	'verifica se ha finito il tempo di lavoro e nel caso inizia quello di sosta
    If uscita = True And LavoroExec = True Then
        If Timer >= AppTempo + CSng(TempoLavoro) Then
            uscita = False
            LavoroExec = False
            If Abilitazione = False Then
                SostaExec = False
                Exit Sub
            End If
            SostaExec = True
            AppTempo = Timer
            Exit Sub
        End If
    End If
        
'verifica se ha finito il tempo di sosta e nel caso inizia quello di lavoro
    If uscita = False And SostaExec = True And Abilitazione = True Then
        If Timer >= AppTempo + CSng(TempoSosta) Then
            uscita = True
            AppTempo = Timer
            LavoroExec = True
            SostaExec = False
            Exit Sub
        End If
    End If

    Exit Sub

Errore:

    ErrTimer = True

End Sub


Public Sub AttivazioneSirena(attiva As Boolean)

    If (SirenaSiloAttiva <> attiva) Then
        SirenaSiloAttiva = attiva

        'Sirena livello alto silo
        CP240.OPCData.items(PLCTAG_DO_AllarmeSirenaSilo).Value = SirenaSiloAttiva
    End If

End Sub


Public Function BooleanModificato( _
    ByRef valore As Boolean, _
    ByVal nuovoValore As Boolean, _
    ByVal fatto As Boolean _
    ) As Boolean

    BooleanModificato = (valore <> nuovoValore Or Not fatto)
    valore = nuovoValore

End Function

Public Function ByteModificato( _
    ByRef valore As Byte, _
    ByVal nuovoValore As Byte, _
    ByVal fatto As Boolean _
    ) As Boolean

    ByteModificato = (valore <> nuovoValore Or Not fatto)
    valore = nuovoValore

End Function

Public Function IntegerModificato( _
    ByRef valore As Integer, _
    ByVal nuovoValore As Integer, _
    ByVal fatto As Boolean _
    ) As Boolean

    IntegerModificato = (valore <> nuovoValore Or Not fatto)
    valore = nuovoValore

End Function

Public Function LongModificato( _
    ByRef valore As Long, _
    ByVal nuovoValore As Long, _
    ByVal fatto As Boolean _
    ) As Boolean

    LongModificato = (valore <> nuovoValore Or Not fatto)
    valore = nuovoValore

End Function

Public Function DoubleModificato( _
    ByRef valore As Double, _
    ByVal nuovoValore As Double, _
    ByVal fatto As Boolean _
    ) As Boolean

    DoubleModificato = (valore <> nuovoValore Or Not fatto)
    valore = nuovoValore

End Function


Public Sub TemporizzatoreStandard(ScalaTempo As Integer, Tempo As Long, AppTempo As Single, _
TempoExec As Boolean, uscita As Boolean, Abilitazione As Boolean, ErrTimer As Boolean)

'**********************************************************************
'Gestione di un timer standard per creare un ritardo all'inserzione
'Servono 2 variabili di appoggio non volatili: AppTempo e TempoExec
'La scala passata in ingresso e' selezionabile (secondi, minuti, ore)
'I valori della ScalaTempo corrispondono a: 1=secondi, 2=minuti, 3=ore (max 23 ore 59 min 59 sec)
'**********************************************************************

Dim AppoggioTempo As Single

    On Error GoTo Errore
                        
    Select Case ScalaTempo
        Case 1
'caso secondi
            AppoggioTempo = CSng(DatoCorretto(CStr(Tempo), 0, 0, 86400, 60))
        Case 2
'caso minuti
            AppoggioTempo = CSng(DatoCorretto(CStr(Tempo), 0, 0, 1440, 1))
            AppoggioTempo = AppoggioTempo * 60
        Case 3
'caso ore
            AppoggioTempo = CSng(DatoCorretto(CStr(Tempo), 0, 0, 24, 1))
            AppoggioTempo = AppoggioTempo * 3600
        Case Else
     
    End Select
                                
    ErrTimer = False
                
    If Abilitazione = False Then
        uscita = False
        TempoExec = False
        AppTempo = 0 '20151108
        Exit Sub
    End If
        
    If TempoExec = False Then
        TempoExec = True
        AppTempo = Timer
    End If
        
'Allo scadere della mezzanotte il timer viene azzerato, quindi bisogna adattare la variabile AppTempo
    If (AppTempo > Timer) Then
        AppTempo = AppTempo - 86400 'nota: 86400 e' il numero di secondi in un giorno
    End If
                
    If Timer >= AppTempo + CSng(AppoggioTempo) Then
        uscita = True
        TempoExec = False
    End If
        
    Exit Sub

Errore:

    ErrTimer = True

End Sub

'20160312
Public Sub GestioneValvolaPreseparatoreAnello()

    Dim i As Integer
    Dim Criterio As String
    Dim nuovoStato As Boolean
    Dim posizione As Integer
    Dim AppoggioTempoPreseparatore As Long
    Dim AppoggioFineTempo As Boolean
    Dim AppoggioEsecuzioneTempo As Boolean
    Dim AppoggioStatoFinaleValvola As Boolean


    On Error GoTo Errore

    If (Not ValvolaPreseparatoreAnello.abilitato Or Not ValvolaPreseparatoreAnello.ModoAutomatico) Then
        '20151109
        'ValvolaPreseparatoreAnello.EsecuzioneRitardoInCorso = False
        GoTo SaltaTimer
    End If

    'se lo stato bruciatore e' variato esegue il ritardo appropriato
    If ListaTamburi(0).FiammaBruciatorePresente <> MemoriaGestioneValvolaPreseparatoreAnello Then
    'TRANSITORIO CAMBIO STATO BRUCIATORE
        
        If ListaTamburi(0).FiammaBruciatorePresente Then
            'se il bruciatore era spento e viene acceso
            'AppoggioTempoPreseparatore = CLng(ValvolaPreseparatoreAnello.RitardoApertura)

            'Se c'è il riciclato caldo devo aprire la valvola in modo che il filler entri nell'anello
            'Se non c'è, la valvola deve stare chiusa per mandare il filler ad elevatore
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.Abilitazione = True
            AppoggioStatoFinaleValvola = AlmenoUnoAccesoPredRiciclatoCaldo
        Else
            'se il bruciatore era acceso e viene spento
            'AppoggioTempoPreseparatore = CLng(ValvolaPreseparatoreAnello.RitardoChiusura)
                
            'La valvola deve stare aperta per mantenere il filler in movimento e non farlo depositare nel preseparatore
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.Abilitazione = True
            AppoggioStatoFinaleValvola = True
        End If

'        Call TemporizzatoreStandard( _
'            1, _
'            AppoggioTempoPreseparatore, _
'            AppoggioTempoValvolaPreseparatoreAnello, _
'            ValvolaPreseparatoreAnello.EsecuzioneRitardoInCorso, _
'            AppoggioFineTempo, _
'            ValvolaPreseparatoreAnello.abilitato, _
'            ValvolaPreseparatoreAnello.ErroreTimer _
'            )

        Call TemporizzatoreStandard( _
            1, _
            CLng(ValvolaPreseparatoreAnello.RitardoApertura), _
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.AppTempo, _
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.TempoExec, _
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.uscita, _
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.Abilitazione, _
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.ErrTimer _
            )

        Call TemporizzatoreStandard( _
            1, _
            CLng(ValvolaPreseparatoreAnello.RitardoChiusura), _
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.AppTempo, _
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.TempoExec, _
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.uscita, _
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.Abilitazione, _
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.ErrTimer _
            )

        If ValvolaPreseparatoreAnello.TemporizzatoreApertura.uscita Or ValvolaPreseparatoreAnello.TemporizzatoreChiusura.uscita Then
            MemoriaGestioneValvolaPreseparatoreAnello = ListaTamburi(0).ComandoAccensioneBruciatore
            ValvolaPreseparatoreAnello.TemporizzatoreApertura.Abilitazione = False
            ValvolaPreseparatoreAnello.TemporizzatoreChiusura.Abilitazione = False
        End If

    Else
'A REGIME

        ValvolaPreseparatoreAnello.TemporizzatoreApertura.Abilitazione = False
        ValvolaPreseparatoreAnello.TemporizzatoreChiusura.Abilitazione = False

        Dim attuale As Boolean

        attuale = ValvolaPreseparatoreAnello.uscita

        If (Not ListaMotori(MotoreCocleaPreseparatrice).ritorno) Then
            'Coclea spenta --> valvola chiusa
            ValvolaPreseparatoreAnello.uscita = False
        Else
            If (ListaTamburi(0).FiammaBruciatorePresente) Then
                'If (AlmenoUnoAccesoPredRiciclatoCaldo And Not ValvolaPreseparatoreAnello.uscita) Then
                If ((ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) And Not ValvolaPreseparatoreAnello.uscita) Then

                    'Bruciatore acceso con riciclato caldo --> valvola aperta
                    ValvolaPreseparatoreAnello.uscita = True
                'ElseIf (Not AlmenoUnoAccesoPredRiciclatoCaldo And ValvolaPreseparatoreAnello.uscita) Then
                ElseIf (Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) And ValvolaPreseparatoreAnello.uscita) Then
                    'Bruciatore acceso SENZA riciclato caldo --> valvola chiusa
                    ValvolaPreseparatoreAnello.uscita = False
                End If
            Else
                'Bruciatore spento --> valvola aperta
                If (Not ValvolaPreseparatoreAnello.uscita) Then
                    ValvolaPreseparatoreAnello.uscita = True
                End If
            End If
        End If

    End If

    If (ValvolaPreseparatoreAnello.ErroreTimer And ValvolaPreseparatoreAnello.ModoAutomatico) Then
        ValvolaPreseparatoreAnello.uscita = False
    End If
    
    Call CheckDeflettoreRiciclato '20160303
        
SaltaTimer:
    
    Exit Sub
Errore:
    LogInserisci True, "F183", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub GestioneValvolaPreseparatore()

	Dim AppoggioTempoPreseparatore As Long
	Dim AppoggioFineTempo As Boolean
	Dim AppoggioStatoFinaleValvola As Boolean
	Dim condizione As Boolean '20160105

	'valori di TEST. COMMENTARE!
	'ValvolaPreseparatore.RitardoApertura = 20
	'ValvolaPreseparatore.RitardoChiusura = 10
	'ValvolaPreseparatore.abilitato = True

    On Error GoTo Errore

    If Not ValvolaPreseparatore.abilitato Or Not ValvolaPreseparatore.ModoAutomatico Then
        ValvolaPreseparatore.EsecuzioneRitardoInCorso = False
        GoTo SaltaTimer
    End If

    '20160105
    ''se lo stato bruciatore e' variato esegue il ritardo appropriato
    'If ListaTamburi(0).FiammaBruciatorePresente <> MemoriaStatoAccensioneBruciatore Then
    If (ValvolaPreseparatoreAnello.abilitato) Then
        condizione = (ListaMotori(MotoreAspiratoreFiltro).ritorno And ListaMotori(MotoreCocleaPreseparatrice).ritorno)
    Else
        condizione = ListaTamburi(0).FiammaBruciatorePresente
    End If
    If (MemoriaGestioneValvolaPreseparatore <> condizione) Then
    '

        '20160105
        'If MemoriaStatoAccensioneBruciatore = False Then
        If (Not MemoriaGestioneValvolaPreseparatore) Then
        '
            'se il bruciatore era spento e viene acceso
            AppoggioTempoPreseparatore = CLng(ValvolaPreseparatore.RitardoApertura)
            AppoggioStatoFinaleValvola = True
        Else
            'se il bruciatore era acceso e viene spento
            '20160105
            'AppoggioTempoPreseparatore = CLng(ValvolaPreseparatore.RitardoChiusura)
            If (ValvolaPreseparatoreAnello.abilitato) Then
                AppoggioTempoPreseparatore = IIf(ListaMotori(MotoreCocleaPreseparatrice).ritorno, CLng(ValvolaPreseparatore.RitardoChiusura), 0)
            Else
                AppoggioTempoPreseparatore = CLng(ValvolaPreseparatore.RitardoChiusura)
            End If
            '
            AppoggioStatoFinaleValvola = False
        End If
                
        Call TemporizzatoreStandard( _
            1, _
            AppoggioTempoPreseparatore, _
            AppoggioTempoValvolaPresep, _
            ValvolaPreseparatore.EsecuzioneRitardoInCorso, _
            AppoggioFineTempo, _
            ValvolaPreseparatore.abilitato, _
            ValvolaPreseparatore.ErroreTimer _
        )
                            
        If AppoggioFineTempo Then
            If AppoggioStatoFinaleValvola Then
                ValvolaPreseparatore.uscita = AppoggioFineTempo
            Else
                ValvolaPreseparatore.uscita = Not (AppoggioFineTempo)
            End If
            '20160105
            'MemoriaStatoAccensioneBruciatore = ListaTamburi(0).ComandoAccensioneBruciatore
            MemoriaGestioneValvolaPreseparatore = condizione
            '
            ValvolaPreseparatore.EsecuzioneRitardoInCorso = False
        End If

    End If
    
    If ValvolaPreseparatore.ErroreTimer And ValvolaPreseparatore.ModoAutomatico Then
        ValvolaPreseparatore.uscita = False
        ValvolaPreseparatore.EsecuzioneRitardoInCorso = False
    End If
    
SaltaTimer:
    
'aggiorna grafica

    Exit Sub
Errore:
    LogInserisci True, "CTL-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function LimitaValore(valore As Long, min As Long, max As Long) As Long

    LimitaValore = valore
    If valore < min Then
        LimitaValore = min
    End If
    If valore > max Then
        LimitaValore = max
    End If

End Function


Public Function LimitaValoreSng(valore As Single, min As Single, max As Single) As Single

    LimitaValoreSng = valore
    If valore < min Then
        LimitaValoreSng = min
    End If
    If valore > max Then
        LimitaValoreSng = max
    End If

End Function

'20170323
Public Function LimitaValoreDbl(valore As Double, min As Double, max As Double) As Double

    LimitaValoreDbl = valore
    If valore < min Then
        LimitaValoreDbl = min
    End If
    If valore > max Then
        LimitaValoreDbl = max
    End If

End Function
'

Public Function TimeToMillisecond() As String
    
    Dim typTime As SYSTEMTIME

    On Error GoTo Errore
    GetSystemTime typTime
    TimeToMillisecond = Hour(Now) & ":" & Minute(Now) & ":" & Second(Now) & ":" & typTime.wMilliseconds

    Exit Function
Errore:
    LogInserisci True, "CTL-007", CStr(Err.Number) + " [" + Err.description + "]"
    TimeToMillisecond = ""
End Function

Public Function ConvertiTempoS7toSEC(valore As String) As Long
'Converte il tempo passato dai timer S7 in secondi
'Formato S7: 8D3H18M28S730MS = 8 days 3 hours 18 minutes 28 seconds 730 milliseconds
Dim i As Integer
Dim appoggio As Integer

    On Error GoTo Errore

    appoggio = 0
    ConvertiTempoS7toSEC = 0
    i = 0
    Do While i < Len(valore)
        If IsNumeric(Mid(valore, i + 1, 1)) Then
            appoggio = appoggio & Mid(valore, i + 1, 1)
        Else
            If appoggio <> 0 Then
                Select Case UCase(Mid(valore, i + 1, 1))
                    Case "D"
                        ConvertiTempoS7toSEC = ConvertiTempoS7toSEC + appoggio * 86400
                        appoggio = 0
                    Case "H"
                        ConvertiTempoS7toSEC = ConvertiTempoS7toSEC + appoggio * 3600
                        appoggio = 0
                    Case "M"
                        'Nel caso particolare di 60 secondi, il formato S7 scrive "1m", quindi lo devo convertire e non scartare come invece prima succedeva
                        If IsNumeric(Mid(valore, i + 2, 1)) Or (Mid(valore, i + 2, 1)) = "" Then
                            ConvertiTempoS7toSEC = ConvertiTempoS7toSEC + appoggio * 60
                            appoggio = 0
                        Else
                            'Sarebbe il caso dei MS (milli secondi) che scarto
                            i = i + 1
                        End If
                    Case "S"
                        ConvertiTempoS7toSEC = ConvertiTempoS7toSEC + appoggio
                        appoggio = 0
                End Select
            End If
        End If
        i = i + 1
    Loop

    Exit Function
Errore:
    ConvertiTempoS7toSEC = 0
End Function


Public Function ConvertiTempoSECtoS7(ByVal valore As Long, Optional MilliSec As Long) As String
'
'Converte il tempo passato dai secondi ai timer S7
'Formato S7: 8D3H18M28S730MS = 8 days 3 hours 18 minutes 28 seconds 730 milliseconds
Dim secondi As Long
Dim minuti As Long
Dim ore As Long
Dim giorni As Long

    On Error GoTo Errore
    
    minuti = Int(valore / 60)
    valore = valore - (minuti * 60)
    ore = Int(valore / (60 * 60))
    valore = valore - (ore * 60 * 60)
    'giorni = Val(Val(Val(valore / 24) / 60) / 60)
    secondi = valore
    If (secondi < 0) Then
        'Qualcosa è andato storto
        ConvertiTempoSECtoS7 = "0s"
        Exit Function
    End If

    If (giorni > 0) Then
        ConvertiTempoSECtoS7 ConvertiTempoSECtoS7 + CStr(giorni) + "D"
    End If
    If (ore > 0) Then
        ConvertiTempoSECtoS7 = ConvertiTempoSECtoS7 + CStr(ore) + "H"
    End If
    If (minuti > 0) Then
        ConvertiTempoSECtoS7 = ConvertiTempoSECtoS7 + CStr(minuti) + "M"
    End If
    If (secondi >= 0) Then
        ConvertiTempoSECtoS7 = ConvertiTempoSECtoS7 + CStr(secondi) + "S"
    End If
    ConvertiTempoSECtoS7 = ConvertiTempoSECtoS7 + CStr(MilliSec) + "MS"

    Exit Function
Errore:
    ConvertiTempoSECtoS7 = "0s"
End Function


Public Function ConvertiTempoMilliSECtoS7(MilliSec As Long) As String
    ConvertiTempoMilliSECtoS7 = CStr(MilliSec) + "MS"
End Function

Public Function Null2String(valore) As String
    On Error GoTo Errore
    
    If IsNull(valore) Then
        Null2String = ""
    Else
        Null2String = CStr(valore)
    End If

    GoTo OK
Errore:
        Null2String = ""
OK:
End Function


Public Function String2Bool(Value As String) As Boolean
    String2Bool = CBool(Null2Qualcosa(Value))
End Function

Public Function String2Long(Value As String) As Long
    
    Dim indice As Integer
    Dim StringaControllo As String
    Dim StringaPulita As String
    
    StringaControllo = Null2Qualcosa(Value)

'Promemoria caratteri ascii
'44 = ,
'45 = -
'46 = .
'48 a 57 = numeri 0..9

    For indice = 1 To Len(StringaControllo)
        If (Asc(Mid(StringaControllo, indice, 1)) >= 48 And Asc(Mid(StringaControllo, indice, 1)) <= 57) _
            Or Asc(Mid(StringaControllo, indice, 1)) >= 44 Or Asc(Mid(StringaControllo, indice, 1)) <= 46 Then
            StringaPulita = StringaPulita & Mid(StringaControllo, indice, 1)
        End If
    Next indice

    StringaPulita = SostituisciCaratteri(StringaPulita, ".", ",")
    
    String2Long = Round(StringaPulita, 0)
'    String2Long = CLng(Null2Qualcosa(Value))
'
End Function


Public Function String2Int(Value As String) As Integer
    Dim indice As Integer
    Dim StringaControllo As String
    Dim StringaPulita As String


    StringaControllo = Null2Qualcosa(Value)

'Promemoria caratteri ascii
'44 = ,
'45 = -
'46 = .
'48 a 57 = numeri 0..9

    For indice = 1 To Len(StringaControllo)
        If (Asc(Mid(StringaControllo, indice, 1)) >= 48 And Asc(Mid(StringaControllo, indice, 1)) <= 57) _
            Or Asc(Mid(StringaControllo, indice, 1)) >= 44 Or Asc(Mid(StringaControllo, indice, 1)) <= 46 Then
            StringaPulita = StringaPulita & Mid(StringaControllo, indice, 1)
        End If
    Next indice

    StringaPulita = SostituisciCaratteri(StringaPulita, ".", ",")
    
    '20161024
    'String2Int = CInt(LimitaValore(Round(StringaPulita, 0), -32768, 32768))
    String2Int = CInt(LimitaValore(Round(StringaPulita, 0), -32768, 32767))
    '
'    String2Int = CInt(Null2Qualcosa(Value))
'

End Function
'

Public Function Long2BitChar(numero As Long, Caratteri As Integer) As String
Dim i As Integer

    Do While numero > 0
        Long2BitChar = CStr(numero Mod 2) & Long2BitChar
        numero = numero \ 2
    Loop
    For i = Len(Long2BitChar) To Caratteri - 1
        Long2BitChar = "0" & Long2BitChar
    Next i

End Function

Public Function Bit2Long(valore As String) As Long
Dim i As Integer
Dim appoggio As Long
    
    For i = Len(valore) To 1 Step -1
        appoggio = appoggio + 2 ^ (i - 1) * Mid(valore, Len(valore) - i + 1, 1)
    Next i
    Bit2Long = appoggio
    
End Function

Public Function LogaritmoBASE(numero As Double, Base As Double)
   
   LogaritmoBASE = Log(numero) / Log(Base#)

End Function


Public Function ParteDecimale(numero As Double, NumeroCifre As Integer)

    ParteDecimale = CLng((numero - Fix(numero)) * (10 ^ NumeroCifre))
    
End Function


Public Function ConvertiTimer() As Long

    Dim giorniTrascorsi As Integer

    giorniTrascorsi = DateDiff("d", DataStartCyb500, Now)

    If (giorniTrascorsi < 0) Then
        'In fase di startup si memorizza la data-ora di partenza
        'Se si è svelti a spostarla indietro, si riesce a bypassare il controllo della chiave HL e tutti i controlli basati su questa info
        DataStartCyb500 = CLng(Timer)
        giorniTrascorsi = DateDiff("d", DataStartCyb500, Now)
    End If

    ConvertiTimer = CLng(Timer) + 86400 * giorniTrascorsi

End Function

' Le versioni con tamburo parallelo utilizzano 2 monitor le form continuano peró ad essere
' posizionate al centro nel primo monitor; il parametro opzionale monitor (default 0) permette
' di poszionare la form al centro del secondo monitor (indice 1))
Public Sub SetStartUpPosition(ByRef Form As Form, Optional monitor As Integer)

    Dim Height As Long
    Dim width As Long
    
    If (ProgrammaAvviato) Then
        Height = CP240.Height
        width = CP240.width
    Else
        Height = 1080 * 15
        width = 1920 * 15
    End If
    
    Form.top = (Height - Form.Height) / 2
    Form.left = ((width / (1 - CInt(ParallelDrum)) - Form.width) / 2) + (width / (1 - CInt(ParallelDrum)) * monitor)
    'se non tornano i conti posizioni al centro 'assoluto'
    If ((Form.left + Form.width) > width) Then
        Form.left = (width - Form.width) / 2
    End If
End Sub
    

' Verifica divisione per zero
'Private Function DivByZeroCheck(ByRef dividend As Double, ByRef divisor As Double) As Double
'
'    DivByZeroCheck = 0
'
'    If divisor = 0 Then
'        LogInserisci True, "DivByZeroCheck()", "divisore = 0 !"
'        Exit Function
'    End If
'
'    DivByZeroCheck = dividend / divisor
'
'End Function


Public Function CheckLabelDato(oggetto As Object, minimo As Variant, massimo As Variant, default As Variant) As Boolean

    oggetto.text = DatoCorretto(oggetto.text, 0, CDbl(minimo), CDbl(massimo), CDbl(default), 1)
    CheckLabelDato = Not ErroreDatoParametri
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
'
End Function

'20161014
Public Sub CP240StatusBar_Change(Panel As StatusBarPanel, statologico As Variant)

    'note: lo statologico varia di significato e di tipo variabile in base al pannello da aggiornare
    
    Dim key As String
    Dim keytext As String
    Dim keytooltip As String
    Dim validato As Boolean
    Dim nonabilitato As Boolean
    Dim indice As Integer

    On Error GoTo Errore

    validato = True

    With CP240

        If statologico = 99 Then
            .StatusBar1.Panels(Panel).Picture = Nothing
            .StatusBar1.Panels(Panel).text = ""
            .StatusBar1.Panels(Panel).ToolTipText = ""
            Exit Sub
        End If


        Select Case Panel
                        
            Case StatusBarPanel.STB_DOSAGGIO
                Select Case statologico
'                    Case StatusDosaggio.DOSAGGIO_STATUS_AUTO_STOP
'                        key = "DOSAGGIO_STATUS_AUTO_STOP"
                    Case StatusDosaggio.DOSAGGIO_STATUS_AUTO_RUN
                        key = "DOSAGGIO_STATUS_AUTO_RUN"
                    Case StatusDosaggio.DOSAGGIO_STATUS_AUTO_LAST
                        key = "DOSAGGIO_STATUS_AUTO_LAST"
                    Case Else
                        key = "DOSAGGIO_STATUS_MAN"
                End Select
                .StatusBar1.Panels(Panel).text = ""
            '20170124
            Case StatusBarPanel.STB_JOB
                Select Case statologico
                    Case EnumStatoJobVB.Running
                        key = "JOB_STATUS_AUTO_RUN"
                    Case EnumStatoJobVB.Stopping, EnumStatoJobVB.Pausing
                        key = "JOB_STATUS_AUTO_LAST"
                    Case Else
                        key = "JOB_STATUS_IDLE"
                End Select
                .StatusBar1.Panels(Panel).text = ""
            '
            Case StatusBarPanel.STB_PREDOSAGGIO
                
                 key = IIf(statologico = True, "PREDOSAGGIO_STATUS_AUTO_RUN", "PREDOSAGGIO_STATUS_MAN")
                                
            Case StatusBarPanel.STB_PLC
            
                key = IIf(statologico = True, "CONNECTION_OK", "CONNECTION_ERR")
                keytext = "PLC MAIN"
                keytooltip = IIf(statologico, "PLC" + msgConnessoSi, "PLC" + msgConnessoNo)
                                   
            Case StatusBarPanel.STB_PLCCISTERNE
            
                key = IIf(statologico = True, "CONNECTION_OK", "CONNECTION_ERR")
                keytext = "PLC TANK"
                keytooltip = IIf(statologico, LoadXLSString(516) + " " + msgConnessoSi, LoadXLSString(516) + " " + msgConnessoNo)
            
            Case StatusBarPanel.STB_PLCSCHIUMATO
                        
                key = IIf(statologico = True, "CONNECTION_OK", "CONNECTION_ERR")
                keytext = "PLC FOAM"
                keytooltip = IIf(statologico, LoadXLSString(1274) + " " + msgConnessoSi, LoadXLSString(1274) + " " + msgConnessoNo)
            
            Case StatusBarPanel.STB_AQUABLACK
                        
                key = IIf(statologico = True, "CONNECTION_OK", "CONNECTION_ERR")
                keytext = "PLC AQUAB"
                keytooltip = IIf(statologico, LoadXLSString(1478) + " " + msgConnessoSi, LoadXLSString(1478) + " " + msgConnessoNo)
            
            Case StatusBarPanel.STB_LCPC
            
                key = IIf(statologico = True, "CONNECTION_OK", "CONNECTION_ERR")
                keytext = "LCPC"
                keytooltip = IIf(statologico, "LCPC " + msgConnessoSi, "LCPC" + msgConnessoNo)

            Case StatusBarPanel.STB_STATOMOTORI
                Select Case statologico
                    Case MotorManagementEnum.AutomaticMotor
                        key = "MOTOR_STATUS_AUTO_RUN"
'                    Case MotorManagementEnum.AutomaticStop
'                        key = "MOTOR_STATUS_AUTO_STOP"
                    Case MotorManagementEnum.SemiAutomaticMotor
                        
                        key = "MOTOR_STATUS_MAN"
                        
                        For indice = 1 To MAXMOTORI
                            If ListaMotori(indice).ritorno And ListaMotori(indice).presente Then
                                key = "MOTOR_STATUS_MAN_ON"
                                Exit For
                            End If
                        Next indice
                        
                    Case MotorManagementEnum.ForcingMotor
                        For indice = 1 To MAXMOTORI
                            If ListaMotori(indice).ritorno And ListaMotori(indice).presente Then
                                key = "MOTOR_STATUS_SERVICE_ON"
                                Exit For
                            End If
                        Next indice
                        key = "MOTOR_STATUS_SERVICE"
                    Case MotorManagementEnum.CoolingTime
                        key = "MOTOR_STATUS_AUTO_COOLING"
                    Case Else
                        key = "MOTOR_STATUS_MAN"
                End Select
            
            Case StatusBarPanel.STB_STAMPANTE
        
                key = IIf(statologico = True, "PRINTER_OK", "PRINTER_ERR")
                        
            '20170222
            Case StatusBarPanel.STB_STATOPARAM
        
                key = IIf(statologico = True, "PARAM_OK", "PARAM_ERR")
            '
            Case StatusBarPanel.STB_UTENTE
                            
                Select Case statologico
                    Case UsersEnum.ADMINISTRATOR
                        key = "LOGIN_ADMIN"
                        keytext = "ADMINISTRATOR"
                    Case UsersEnum.MANAGER
                        key = "LOGIN_MANAGER"
                        keytext = "MANAGER"
                    Case UsersEnum.OPERATOR
                        key = "LOGIN_OPERATOR"
                        keytext = "OPERATOR"
                    Case UsersEnum.SUPERUSER
                        key = "LOGIN_SUPER"
                        keytext = "SUPERUSER"
'                    Case UsersEnum.NONE
'                        key = "LOGIN_OFF"
'                        keytext = ""
                    Case Else
                        key = "LOGIN_OFF"
                        keytext = ""
                    End Select
                                
                keytooltip = LoadXLSString(918)
                                        
            Case StatusBarPanel.STB_WATCHDOGCS
                If MemWatchdogCS = statologico Then Exit Sub
                    
                key = IIf(statologico = True, "WDCS_OK", "WDCS_ERR")
                
                MemWatchdogCS = statologico
            
            Case Else
                validato = False
        End Select
    
        If nonabilitato Then
            .StatusBar1.Panels(Panel).Picture = Nothing
        ElseIf validato Then
            .StatusBar1.Panels(Panel).Picture = CP240.PlusImageList(1).ListImages(key).Picture
        End If
        
        .StatusBar1.Panels(Panel).text = keytext
        .StatusBar1.Panels(Panel).ToolTipText = keytooltip
    
    End With
        
        
    Exit Sub


'                CP240.StatusBar1.Panels(panel).Picture = CP240.PlusImageList(1).ListImages(key).Picture

Errore:

    LogInserisci True, "CTL-010", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20170222
Public Sub PbarNettoPesata(ByRef componente As ComponenteType, valorebilancia As Double, Optional valorediretto As Double, Optional manuale As Boolean)

    Dim indicepbar As Integer

    On Error GoTo Errore

    indicepbar = componente.progressivo + 100

    With CP240
        
        If manuale And (componente.setCalcolato > 0) Then
            .ProgressBil(indicepbar).max = Round(componente.setCalcolato, 0)
            .ProgressBil(indicepbar).Value = Round(valorediretto, 0)
            '.ProgressBil(indicepbar).caption = Format(valorediretto, "##0.0")
            .ProgressBil(indicepbar).caption = FormatNumber(valorediretto, 1, vbTrue, vbFalse, vbFalse)
        ElseIf manuale Then
            .ProgressBil(indicepbar).max = Round(valorediretto, 0)
            .ProgressBil(indicepbar).Value = Round(valorediretto, 0)
            '.ProgressBil(indicepbar).caption = Format(valorediretto, "##0.0")
            .ProgressBil(indicepbar).caption = FormatNumber(valorediretto, 1, vbTrue, vbFalse, vbFalse)
'            componente.memTaraPesoNetto = valorebilancia - valorediretto
        ElseIf (componente.setCalcolato > 0) Then
            .ProgressBil(indicepbar).max = Round(componente.setCalcolato, 0)
            .ProgressBil(indicepbar).Value = Round((valorebilancia - componente.memTaraPesoNetto), 0)
'            .ProgressBil(indicepbar).caption = FormatNumber((valorebilancia - componente.memTaraPesoNetto), 1, vbTrue, vbFalse, vbFalse)
'        ElseIf (componente.pesoOut > 0) Then
'            .ProgressBil(indicepbar).max = Round(componente.pesoOut, 0)
'            .ProgressBil(indicepbar).Value = Round((valorebilancia - componente.memTaraPesoNetto), 0)
        Else
            .ProgressBil(indicepbar).max = 100
            .ProgressBil(indicepbar).Value = 0
'            .ProgressBil(indicepbar).caption = "0,0"
            componente.memTaraPesoNetto = 0
        End If
           
    End With

    Exit Sub

Errore:

    LogInserisci True, "CTL-011", CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'

'20170223
Public Sub InitPbarNettoPesata(componentestart As ComponenteGraficaEnum, componentelast As ComponenteGraficaEnum)

    Dim indice As Integer

    On Error GoTo Errore

    For indice = componentestart + 100 To componentelast + 100
        CP240.ProgressBil(indice).Value = 0
    Next indice

    Exit Sub

Errore:

    LogInserisci True, "CTL-012", CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'

'20170302
Public Sub RefreshPbarNettoPesate()

    Dim indice As Integer
    Dim indicepbar As Integer

    On Error GoTo Errore
    
    For indice = CompGrafAggregato1 To CompGrafMax - 1
        
        indicepbar = indice + 100
        
        Select Case indice
            Case CompGrafAggregato1 To CompGrafNonVagliato
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeAggregati(indice).Peso, 1, vbTrue, vbFalse, vbFalse)
            Case CompGrafFiller1 To CompGrafFiller3
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeFiller(indice).Peso, 1, vbTrue, vbFalse, vbFalse)
            Case CompGrafLegante1 To CompGrafLegante3
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeBitume(indice).Peso, 1, vbTrue, vbFalse, vbFalse)
            Case CompGrafRAP
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeRiciclato(indice).Peso, 1, vbTrue, vbFalse, vbFalse)
'            Case CompGrafRAPSiwa
'                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeAggregati(indice).Peso, 1, vbTrue, vbFalse, vbFalse)
            Case CompGrafViatop
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeViatop.Peso, 1, vbTrue, vbFalse, vbFalse)
            Case CompGrafViatopScarMixer1
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeViatopScarMixer1.Peso, 1, vbTrue, vbFalse, vbFalse)
            Case CompGrafViatopScarMixer2
                CP240.ProgressBil(indicepbar).caption = FormatNumber(ScManualeViatopScarMixer2.Peso, 1, vbTrue, vbFalse, vbFalse)
        End Select
    Next indice

    Exit Sub

Errore:

    LogInserisci True, "CTL-013", CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'



