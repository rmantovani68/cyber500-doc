Attribute VB_Name = "Stampante"

'Acknowledgements : This program has been written making extensive use of the
'Merrion article http://www.merrioncomputing.com/Programming/PrintStatus.htm
'It has also benefited from the contributors to VBForums thread # 733849
'http://www.vbforums.com/showthread.php?t=733849&goto=newpost - especially the code
'suggested by "Bonnie West"

'Program written 14 Sept. 2013 by C.A. Moore

Option Explicit

Dim PRINTERFOUND As Long
Dim GETPRINTER As Long
Dim buffer() As Long
Dim pbSizeNeeded As Long
Dim PRINTERINFO As PRINTER_INFO_2
Dim n As Integer
Dim M As Integer
Dim CHAR As String
Dim prnPrinter As Printer
Dim BUF13BINARY As String


' Note :
Public PRINTERREADY As Integer

Private Type PRINTER_INFO_2

   pServerName As String
   pPrinterName As String
   pShareName As String
   pPortName As String
   pDriverName As String
   pComment As String
   pLocation As String
   pDevMode As Long
   pSepFile As String
   pPrintProcessor As String
   pDatatype As String
   pParameters As String
   pSecurityDescriptor As Long
   Attributes As Long
   Priority As Long
   DefaultPriority As Long
   StartTime As Long
   UntilTime As Long
   Status As Long
   JobsCount As Long
   AveragePPM As Long
   
End Type

'MS Windows API Function Prototypes
Public Declare Function GetProfileString Lib "kernel32.dll" Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long) As Long
Public Declare Function GetPrinterApi Lib "winspool.drv" Alias "GetPrinterA" (ByVal hPrinter As Long, ByVal Level As Long, buffer As Long, ByVal pbSize As Long, pbSizeNeeded As Long) As Long
Public Declare Function OpenPrinter Lib "winspool.drv" Alias "OpenPrinterW" (ByVal pPrinterName As Long, ByRef phPrinter As Long, Optional ByVal pDefault As Long) As Long
Public Declare Function ClosePrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Public Declare Sub CopyMemory Lib "Kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)

'Private Const HWND_BROADCAST = &HFFFF&
'Private Const WM_WININICHANGE = &H1A

'public Declare Function WriteProfileString Lib "Kernel32" Alias "WriteProfileStringA" (ByVal lpszSection As String, ByVal lpszKeyName As String, ByVal lpszString As String) As Long
'public Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long

'STAMPA CONTINUA
Public Type DOCINFO
    pDocName As String
    pOutputFile As String
    pDatatype As String
End Type

Public Declare Function EndDocPrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long '20150708
Public Declare Function EndPagePrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Public Declare Function StartDocPrinter Lib "winspool.drv" Alias "StartDocPrinterA" (ByVal hPrinter As Long, ByVal Level As Long, pDocInfo As DOCINFO) As Long
Public Declare Function StartPagePrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Public Declare Function WritePrinter Lib "winspool.drv" (ByVal hPrinter As Long, pBuf As Any, ByVal cdBuf As Long, pcWritten As Long) As Long

Public lhPrinter As Long
Public UltimoBatchPrinter As Boolean '20150708
'


Public Function StringFromPointer(lpString As Long, lMaxLength As Long) As String

'this service function extracts a string (sRet) when fed with a pointer (lpstring)
'from a buffer

    Dim sRet As String
    Dim lret As Long
    
    If lpString = 0 Then
        StringFromPointer = ""
        Exit Function
    End If
    
    '\\ Pre-initialise the return string...
    sRet = Space$(lMaxLength)
      
    CopyMemory ByVal sRet, ByVal lpString, ByVal Len(sRet)
  
    If Err.LastDllError = 0 Then
        If InStr(sRet, Chr$(0)) > 0 Then
            sRet = left$(sRet, InStr(sRet, Chr$(0)) - 1)
        End If
    End If

    StringFromPointer = sRet

End Function

Public Function IsPrinterReady(ByRef PrinterName As String) As Boolean

'Dim prnPrinter As Printer

    'azzera lo stato
    PRINTERREADY = False
    IsPrinterReady = PRINTERREADY

'first select the named printer and check if it is installed


    For Each prnPrinter In Printers
        CHAR = prnPrinter.DeviceName
        If CHAR = PrinterName Then
            Set Printer = prnPrinter   'sets this as printer
'setta pronta la stampante di default
            PRINTERREADY = True
            IsPrinterReady = PRINTERREADY
        End If
    Next
        
' se non trovata vai a nessuna stampante
    If PRINTERREADY = False Then GoTo Line1000     'exit. printer not installed
        
    
    Dim hPrinter As Long
    
    Dim PI6 As PRINTER_INFO_2
    
    PRINTERFOUND = 0
    
'
    PRINTERREADY = False
    IsPrinterReady = PRINTERREADY

    PRINTERFOUND = OpenPrinter(StrPtr(PrinterName), hPrinter)

    If PRINTERFOUND = 0 Then                'ie. printer not found
        PRINTERREADY = False
        IsPrinterReady = PRINTERREADY
        Debug.Assert ClosePrinter(hPrinter)
        GoTo Line100
    End If
    
    
    'If we get here named printer was found and accessed and its hPrinter handle is
    'known
     
     ReDim Preserve buffer(0 To 1) As Long
     GETPRINTER = GetPrinterApi(hPrinter, 2&, buffer(0), UBound(buffer), pbSizeNeeded)
     ReDim Preserve buffer(0 To (pbSizeNeeded / 4) + 3) As Long
     GETPRINTER = GetPrinterApi(hPrinter, 2&, buffer(0), UBound(buffer) * 4, pbSizeNeeded)
        
        If GETPRINTER = 0 Then              'ie. some problem with printer access
'            Form1.PRINTERREADY = 0
            PRINTERREADY = False
            IsPrinterReady = PRINTERREADY

            GoTo Line100
        
        End If
    
        'If we get here then GETPRINTER = 1, ie. printer found and accessed OK
        
            With PRINTERINFO '\\ This variable is of type PRINTER_INFO_2
            'These quantities are defined here because the Merrion article
            'so specifies. However they are not used by this program, and most
            'have been found to be void
            
                .pServerName = StringFromPointer(buffer(0), 1024)
                .pPrinterName = StringFromPointer(buffer(1), 1024)
                .pShareName = StringFromPointer(buffer(2), 1024)
                .pPortName = StringFromPointer(buffer(3), 1024)
                .pDriverName = StringFromPointer(buffer(4), 1024)
                .pComment = StringFromPointer(buffer(5), 1024)
                .pLocation = StringFromPointer(buffer(6), 1024)
                .pDevMode = buffer(7)
                .pSepFile = StringFromPointer(buffer(8), 1024)
                .pPrintProcessor = StringFromPointer(buffer(9), 1024)
                .pDatatype = StringFromPointer(buffer(10), 1024)
                .pParameters = StringFromPointer(buffer(11), 1024)
                .pSecurityDescriptor = buffer(12)
                .Attributes = buffer(13)
                .Priority = buffer(14)
                .DefaultPriority = buffer(15)
                .StartTime = buffer(16)
                .UntilTime = buffer(17)
                .Status = buffer(18)
                .JobsCount = buffer(19)
                .AveragePPM = buffer(20)
  
            End With


            'This next code is for interest and program development only.
            
            'It writes into List1 the value of each buffer 1 - 20
        
            'To by-pass it, add a "Go To Line15" statement at this point.
        
'                    Form1.List1.Clear
            
            n = 0
        
Line5:
            On Error GoTo Line15
            
'                  Form1.List1.AddItem "Buffer No. " & n & "  Buffer Value " & buffer(n)
        
            n = (n + 1)
            
            If n = 21 Then GoTo Line15
        
            GoTo Line5
           
           
           
           'Now to convert the decimal value of Buffer(13) into a binary
           'bit pattern and store this in BUF13BINARY
Line15:            'and to show Buffer(13) as a binary bit pattern at Form1.Label1
            
            n = buffer(13)
            
            BUF13BINARY = ""
            
            M = 4196
            
Line16:
            
            If n < M Then
            
                BUF13BINARY = BUF13BINARY & "0"
                
                GoTo Line20
                
            End If
            
            BUF13BINARY = BUF13BINARY & "1"
                
            n = (n - M)
                
Line20:
            If M = 1 Then GoTo Line10
            
            M = M / 2
            
            GoTo Line16
                

Line10: 'BUF13BINARY is now the 13 bit binary value of Buffer(13)
        'eg. 0011000100010

'        Form1.Label1.caption = BUF13BINARY  'display this binary value at form 1
        
        'we now examine the value of the third binary bit in BUF13BINARY


        If Mid$(BUF13BINARY, 3, 1) = "0" Then PRINTERREADY = True
        If Mid$(BUF13BINARY, 3, 1) = "1" Then PRINTERREADY = False
        IsPrinterReady = PRINTERREADY

Line100:

        ClosePrinter (hPrinter)
        
Line1000:
    
End Function

'---------------------------------------------------------------
' Retreive the vb object "printer" corresponding to the window's
' default printer.
'---------------------------------------------------------------
Public Function GetDefaultPrinter() As Printer
    Dim strBuffer As String * 254
    Dim iRetValue As Long
    Dim strDefaultPrinterInfo As String
    Dim tblDefaultPrinterInfo() As String
    Dim objPrinter As Printer

    ' Retreive current default printer information
    iRetValue = GetProfileString("windows", "device", ",,,", strBuffer, 254)
    strDefaultPrinterInfo = left(strBuffer, InStr(strBuffer, Chr(0)) - 1)
    tblDefaultPrinterInfo = Split(strDefaultPrinterInfo, ",")
    For Each objPrinter In Printers
        If objPrinter.DeviceName = tblDefaultPrinterInfo(0) Then
            ' Default printer found !
            Set GetDefaultPrinter = objPrinter
            Exit Function
        End If
    Next
    ' If not found, return nothing
    'If objPrinter.DeviceName <> tblDefaultPrinterInfo(0) Then
        Set objPrinter = Nothing
    'End If
    
End Function

' SetDefaultPrinter
'
' Descrizione:
' Imposta la stampante predefinita.
'
' Sintassi:
' BOOL = SetDefaultPrinter(object)
'
' Esempio:
' Dim objNewPrinter As Printer
' Set objNewPrinter = Printers(2)
' SetDefaultPrinter objNewPrinter
'

'Public Function SetDefaultPrinter(objPrn As Printer) As Boolean
'
'    Dim x As Long, szTmp As String
'
'    szTmp = objPrn.DeviceName & "," & objPrn.DriverName & "," & objPrn.Port
'    x = WriteProfileString("windows", "device", szTmp)
'    x = SendMessageByString(HWND_BROADCAST, WM_WININICHANGE, 0&, "windows")
'
'End Function

'
' GetDefaultPrinter
'
' Descrizione:
' Ritorna il nome della stampante predefinita
'
' Syntassi:
' StrVar = GetDefaultPrinter()
'
' Esempio:
' szDefPrinter = GetDefaultPrinter
'

'Public Function GetDefaultPrinter() As String
'
'    Dim x As Long, szTmp As String, dwBuf As Long
'
'    dwBuf = 1024
'    szTmp = Space(dwBuf + 1)
'    x = GetProfileString("windows", "device", "", szTmp, dwBuf)
'    GetDefaultPrinter = Trim(left(szTmp, x))
'
'End Function

'
' ResetDefaultPrinter
'
' Descrizione:
' Resetta la stampante predefinita
'
' Syntassi:
' BOOL = ResetDefaultPrinter(StrVar)
'
' Esempio:
' szDefPrinter = GetDefaultPrinter()
' If Not ResetDefaultPrinter(szDefPrinter) Then
'     MsgBox "Non posso resettare la stampante predefinita.", vbExclamation
' End If
'

'Public Function ResetDefaultPrinter(szBuf As String) As Boolean
'
'    Dim x As Long
'
'    x = WriteProfileString("windows", "device", szBuf)
'    x = SendMessageByString(HWND_BROADCAST, WM_WININICHANGE, 0&, "windows")
'
'End Function

