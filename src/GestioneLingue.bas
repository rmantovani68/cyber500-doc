Attribute VB_Name = "GestioneLingue"

Option Explicit


Public Const TranslationFileName As String = "Translations"

Public Const TranslationsSheet As String = "Translations"
Public Const AlarmTypesSheet As String = "AlarmTypes"
Public Const AlarmsSheet As String = "Alarms"
Public Const MaintenanceSheet As String = "Maintenance"

Public TranslationsLoaded As Boolean


'   Indici delle lingue (o tastiere)
Public Enum Languages
    LangITA = 0
    LangING = 1
    LangFRA = 2
    LangSPA = 3
    LangPOR = 4
    LangCIN = 5
    LangPOL = 6
    LangRUS = 7
    LangRUM = 8
    LangGRE = 9
    LangSER = 10
    LangBUL = 11
    LangTUR = 12
    LangEXTRA = 13

    'Numero massimo di lingue gestite
    MaxLang = 14

End Enum
'   Vale il numero specificato nell'enum Languages
'Public TastieraSelezionata As Languages
'   0=italiano 1=inglese ecc. come l'enum Languages
Public LinguaSelezionata As Languages

'20150408
'Indici delle lingue C#
Public Enum PlusLanguages
    PlusITALIANO = 0
    PlusINGLESE = 1
    PlusFRANCESE = 2
    PlusTEDESCO = 3
    PlusSPAGNOLO = 4
    PlusRUSSO = 5
    PlusCINESE = 6
    PlusRUMENO = 7
    PlusPORTOGHESE = 8
    PlusPOLACCO = 9
    PlusBULGARO = 10
    PlusTURCO = 11
    PlusGRECO = 12
End Enum


'TRADUZIONI FISSE CARICATE UNA VOLTA PER TUTTE
Public InsRicettaDos As String
Public InsNumeroCicli As String
Public NoAria As String
Public DatoNonValido As String
Public strSiNo As String
Public NomePortinaErrato As String
Public NoOperazione As String
Public Avvisopred As String
Public msgConnessoNo As String
Public msgConnessoSi As String
Public MotPCLNoOk As String
Public ControllareRiprovare As String
Public VerificatoErrore As String

Public Type SiwarexErrorCode
    Code As Integer
    description As String
    explanation As String
End Type

Public Type SiwarexErrorType
    Type As Integer
    itemCount As Integer
    items() As SiwarexErrorCode
End Type

Public SiwarexError(0 To 2) As SiwarexErrorType

Public Function GetUserTranslationsFileName() As String
    GetUserTranslationsFileName = UserDataPath + TranslationFileName + "_" + Commessa + ".xls"
End Function

Public Function GetInstallTranslationsFileName() As String
    GetInstallTranslationsFileName = InstallDataPath + TranslationFileName + ".xls"
End Function

Public Function GetColumnTranslation() As Integer

    'L'italiano parte dalla colonna C del file excel
    GetColumnTranslation = LinguaSelezionata + 2

End Function

Public Sub ReadTranslations()

    Dim row As Integer
    Dim column As Integer
    Dim motor As Integer
    Dim Index As Integer
    Dim text As String
    Dim rs As Recordset
    Dim DB As Database
    Dim nomeFile As String
    Dim typeNum As Integer


    On Error GoTo Errore

    nomeFile = GetUserTranslationsFileName
    If (Not FileExist(nomeFile)) Then
        nomeFile = GetInstallTranslationsFileName
    End If

    If (Not FileExist(nomeFile)) Then
        LogInserisci True, "ReadTranslations", "FILE NOT FOUND!"
        Exit Sub
    End If

    Set DB = OpenDatabase(nomeFile, False, True, "Excel 8.0;HDR=NO;")

    'TRANSLATIONS

    Set rs = DB.OpenRecordset(TranslationsSheet + "$")
    rs.MoveFirst
    rs.MoveLast

    NumTraduzioni = rs.RecordCount
    ReDim Traduzioni(NumTraduzioni)
    rs.MoveFirst

    'La prima riga contiene l'intestazione
    rs.MoveNext

    row = 0
    column = LinguaSelezionata + 2

    Do While (Not rs.EOF)
        If rs.Fields(column).Value <> vbNullString Then
            text = rs.Fields(column).Value
        Else
            text = "XLS " + CStr(row)
            '20161012
            'LogInserisci False, "ReadTranslations", CStr(row) + CStr(column) + ") = empty"
            LogInserisci False, "ReadTranslations", "Riga:" + CStr(row) + " Colonna:" + CStr(column) + ") = empty"
            '
        End If
        Traduzioni(row) = text

        row = row + 1
        rs.MoveNext
    Loop

    rs.Close

    'ALARM TYPES
    '###############################################################################################
    Set rs = DB.OpenRecordset(AlarmTypesSheet + "$")

    ReDim TipoAllarmi(rs.RecordCount - 1)
    rs.Move (1) 'La prima riga contiene l'intestazione
    
    Index = 0
    column = GetColumnTranslation()

    Do While (Not rs.EOF)
        If (rs.Fields(1).Value <> vbNullString And rs.Fields(column).Value <> vbNullString) Then
            TipoAllarmi(Index).tipo = rs.Fields(1).Value
            TipoAllarmi(Index).Descrizione = rs.Fields(column).Value
            
            Index = Index + 1
        End If
        rs.MoveNext
    Loop
    rs.Close
    
    'Non è detto che le dimensioni del RecordCount coincidano con le righe implementate,
    ' capita infatti che la fine del file excel sia ben oltre le righe implementate.
    ' Redimensiono l'array in base alle righe 'valide' che ho incontrato nel ciclo while
    ' N.B. il preserve mi mantiene il contenuto dell'array
    ReDim Preserve TipoAllarmi(Index)
    
    Call AlarmTypeToSql

    'ALARMS
    '###############################################################################################
    Set rs = DB.OpenRecordset(AlarmsSheet + "$")

    ReDim Allarmi(rs.RecordCount - 1)
    rs.Move (1) 'La prima riga contiene l'intestazione

    Index = 0
    column = GetColumnTranslation()

    Do While (Not rs.EOF)
        If (rs.Fields(0).Value <> vbNullString And rs.Fields(1).Value <> vbNullString) Then
            Allarmi(Index).tipo = rs.Fields(0).Value
            Allarmi(Index).Codice = rs.Fields(1).Value
    
            If rs.Fields(column).Value <> vbNullString Then
                text = rs.Fields(column).Value
            Else
                text = "ALM " + CStr(Index)
                LogInserisci False, "ReadTranslations", CStr(Index) + CStr(column) + ") = empty"
            End If
            Allarmi(Index).Descrizione = text
    
            Index = Index + 1
        End If
        rs.MoveNext
    Loop
    rs.Close

    ReDim Preserve Allarmi(Index)
    
    Call AlarmToSql

    'MAINTENANCE

    Set rs = DB.OpenRecordset(MaintenanceSheet + "$")
    rs.MoveFirst

    'La prima riga contiene l'intestazione
    rs.MoveNext

    row = 0
    column = GetColumnTranslation()

    Do While (Not rs.EOF)
        motor = rs.Fields(0).Value
        Index = rs.Fields(1).Value

        rs.MoveNext
    Loop

    rs.Close


    'Codici errore SIWAREX
    nomeFile = InstallDataPath + "siwarex.xls"
    If (FileExist(nomeFile)) Then

        Set DB = OpenDatabase(InstallDataPath + "siwarex.xls", False, True, "Excel 8.0;HDR=NO;")
    
        'SIWAREX
        
        For typeNum = 0 To 2
    
            Set rs = DB.OpenRecordset("Type" + CStr(2 ^ typeNum) + "$")
            rs.MoveFirst
            rs.MoveLast

            SiwarexError(typeNum).itemCount = rs.RecordCount
            ReDim SiwarexError(typeNum).items(SiwarexError(typeNum).itemCount)
            rs.MoveFirst

            SiwarexError(typeNum).Type = (2 ^ typeNum)

            'La prima riga contiene l'intestazione
            rs.MoveNext

            row = 0

            Do While (Not rs.EOF)
                If rs.Fields(0).Value <> vbNullString Then
                    SiwarexError(typeNum).items(row).Code = CInt(rs.Fields(0).Value)
'                Else
'                    LogInserisci False, "ReadTranslations", CStr(row) + CStr(0) + ") = empty"
                End If
                If rs.Fields(1).Value <> vbNullString Then
                    SiwarexError(typeNum).items(row).description = rs.Fields(1).Value
'                Else
'                    LogInserisci False, "ReadTranslations", CStr(row) + CStr(1) + ") = empty"
                End If
                If rs.Fields(2).Value <> vbNullString Then
                    SiwarexError(typeNum).items(row).explanation = rs.Fields(2).Value
'                Else
'                    LogInserisci False, "ReadTranslations", CStr(row) + CStr(2) + ") = empty"
                End If

                row = row + 1
                rs.MoveNext
            Loop

            rs.Close

        Next typeNum
    End If


    'Appena caricata la lingua è quella giusta!
    TranslationsLoaded = True

    Exit Sub
Errore:
    LogInserisci True, "LNG-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Private Sub AlarmTypeToSql()
    Dim Index As Integer
    Dim rs As New adodb.Recordset

    On Error GoTo Errore

    For Index = 0 To UBound(TipoAllarmi) - 1
        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * From TipoAllarmi Where IdTipoAllarme = " & TipoAllarmi(Index).tipo & " ;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With
        
        If rs.EOF Then
            rs.AddNew
            rs!IdTipoAllarme = TipoAllarmi(Index).tipo
        End If

        If TipoAllarmi(Index).Descrizione <> "" Then
            rs!Descrizione = TipoAllarmi(Index).Descrizione
            rs.Update
        End If

        rs.Close
    Next Index

    Exit Sub
Errore:
    LogInserisci True, "LNG-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub AlarmToSql()

    Dim Index As Integer
    Dim rs As New adodb.Recordset
    Dim MaxIdDescrizione As Long
    Dim rsAllarmiSQL As New adodb.Recordset

    On Error GoTo Errore

    With rsAllarmiSQL
        Set .ActiveConnection = DBcon
        .Source = "SELECT MAX(IdDescrizione) AS maxId From CodificaAllarmi ;"
        .LockType = adLockReadOnly
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With
    If IsNull(rsAllarmiSQL!maxid) Then
        MaxIdDescrizione = 0
    Else
        MaxIdDescrizione = rsAllarmiSQL!maxid   'Questo valore mi serve per non duplicare la PrimaryKey della tabella CodificaAllarmi
    End If
    rsAllarmiSQL.Close

    For Index = 0 To UBound(Allarmi) - 1
        '1.  Cerco nella tabella CodificaAllarmi se il codice esiste
        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * From CodificaAllarmi Where IndirizzoPLC = '" & Allarmi(Index).Codice & "' ;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With

        If Not rs.EOF Then
            '2A. Se esiste gli aggiorno solo la descrizione
        Else
            '2B. Se non esiste lo aggiungo
            rs.AddNew
            rs!IdDescrizione = MaxIdDescrizione + 1
            MaxIdDescrizione = MaxIdDescrizione + 1
        End If

       If Allarmi(Index).Descrizione = "" Then
            'Se per errore la descrizione dell'allarme non c'è nel file XLS scrivo un testo comunque
            Allarmi(Index).Descrizione = "ERRORE TRADUZIONE " & Allarmi(Index).Codice
        End If

        rs!Descrizione = Allarmi(Index).Descrizione
        rs!IdTipoAllarme = Allarmi(Index).tipo
        rs!IndirizzoPLC = Allarmi(Index).Codice
        rs.Update
        rs.Close
    Next Index

    Exit Sub
Errore:
    LogInserisci True, "LNG-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function WriteTranslations(NomeFoglio As String, row As Long, newText As String) As Boolean
    Dim column As Integer
    Dim FileName As String
    Dim connxx As adodb.Connection
    Dim rsxx As New adodb.Recordset

    On Error GoTo Errore

    WriteTranslations = False

    FileName = GetUserTranslationsFileName
    If (Not FileExist(FileName)) Then
        Call FileCopy(GetInstallTranslationsFileName, FileName)
    End If

    Set connxx = New adodb.Connection
    With connxx
        .ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;"
        .Properties("Data Source") = FileName
        .Properties("Extended Properties") = "Excel 8.0;HDR=NO;"
        .Mode = adModeReadWrite
        .Open
    End With

    With rsxx
        Set .ActiveConnection = connxx
        .Source = "Select * From [" + NomeFoglio + "$]"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , connxx
        .MoveFirst
    End With

    'La prima riga contiene l'intestazione
    row = row + 1

    column = GetColumnTranslation()

    rsxx.Move (row)
    rsxx.Fields(column).Value = newText
    rsxx.Update

    WriteTranslations = True

Exit Function
Errore:
    LogInserisci True, "LNG-004", CStr(Err.Number) + " [" + Err.description + "]"
End Function


Public Function LoadXLSString(numero As Long) As String

    Dim Riga As Integer

    On Error GoTo Errore

    Riga = numero - 1
    LoadXLSString = "XLS" + CStr(Riga)

    If (Riga >= 0 And Riga < NumTraduzioni) Then
        LoadXLSString = Traduzioni(Riga)
    End If

    
    'SCommentare per debug
    'If (DEBUGGING) Then
    '    '   Controlli per debug delle lingue
    '    If (Len(LoadXLSString) > 3) Then
    '        If ( _
    '            Mid(LoadXLSString, 1, 3) = "XLS" Or _
    '            Mid(LoadXLSString, 1, 3) = "XXX" _
    '        ) Then
    '            ShowMsgBox "Traduzione " + CStr(Numero) + " non ok!", vbOKOnly, vbExclamation, -1, -1, True
    '        End If
    '    End If
    '    If (Len(LoadXLSString) > 11) Then
    '        If (Mid(LoadXLSString, 1, 11) = "*non usato*") Then
    '            ShowMsgBox "Traduzione " + CStr(Numero) + " non ok!", vbOKOnly, vbExclamation, -1, -1, True
    '        End If
    '    End If
    'End If

    Exit Function
Errore:
    LogInserisci True, "LNG-005", CStr(Err.Number) + " [" + Err.description + "]"
End Function


Public Sub CaricaTraduzioni()

    If (Not TranslationsLoaded) Then

        Call ReadTranslations

    End If


    CAPTIONSTARTSIMPLE = "FAYAT"
    CaptionStart = CAPTIONSTARTSIMPLE + " - "

    InsRicettaDos = LoadXLSString(128)
    InsNumeroCicli = LoadXLSString(129)
    NoAria = LoadXLSString(163)

    NoOperazione = LoadXLSString(160)
    
    Avvisopred = LoadXLSString(1502)
    
    DatoNonValido = LoadXLSString(335)

    strSiNo = LoadXLSString(93)
    
    MotPCLNoOk = LoadXLSString(183)
    
    msgConnessoNo = LoadXLSString(225) 'offline
    msgConnessoSi = LoadXLSString(226) 'online
    
    '20150706
    ControllareRiprovare = LoadXLSString(305) 'Controllare e riprovare

End Sub


Public Function SiwarexGetError(typeNum As Integer, Code As Integer, ByRef errorCode As SiwarexErrorCode) As Boolean

    Dim Index As Integer
    Dim typeIndex As Integer
    Dim typeIndexFound As Integer

    SiwarexGetError = False

    typeIndexFound = -1
    
    For typeIndex = 0 To 2
        If (SiwarexError(typeIndex).Type = typeNum) Then
            typeIndexFound = typeIndex
            Exit For
        End If
    Next typeIndex

    If (typeIndexFound < 0) Then
        'Type non trovato
        Exit Function
    End If

    For Index = 0 To SiwarexError(typeIndexFound).itemCount
   
        If (SiwarexError(typeIndexFound).items(Index).Code = Code) Then
            errorCode = SiwarexError(typeIndexFound).items(Index)
            SiwarexGetError = True
            Exit Function
        End If
    
    Next Index

End Function

'20150408
Public Function ConvertPlusLanguages(plusSelectedLanguage As PlusLanguages)

    ConvertPlusLanguages = LangING
    
    Select Case plusSelectedLanguage
        Case PlusITALIANO
            ConvertPlusLanguages = LangITA
        Case PlusINGLESE
            ConvertPlusLanguages = LangING
        Case PlusFRANCESE
            ConvertPlusLanguages = LangFRA
        Case PlusTEDESCO
            'Manca...
        Case PlusSPAGNOLO
            ConvertPlusLanguages = LangSPA
        Case PlusRUSSO
            ConvertPlusLanguages = LangRUS
        Case PlusCINESE
            ConvertPlusLanguages = LangCIN
        Case PlusRUMENO
            ConvertPlusLanguages = LangRUM
        Case PlusPORTOGHESE
            ConvertPlusLanguages = LangPOR
        Case PlusPOLACCO
            ConvertPlusLanguages = LangPOL
        Case PlusBULGARO
            ConvertPlusLanguages = LangBUL
        Case PlusTURCO
            ConvertPlusLanguages = LangTUR
        Case PlusGRECO
            ConvertPlusLanguages = LangGRE
    End Select

    'Manca...
    'ConvertPlusLanguages = LangSER
    '
End Function

