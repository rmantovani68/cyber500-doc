Attribute VB_Name = "Registro"
'
'   Utilità per la gestione dei registri
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const REG_SZ As Long = 1
Private Const REG_DWORD As Long = 4

'Private Const HKEY_CLASSES_ROOT = &H80000000
'Public Const HKEY_CURRENT_USER As Long = &H80000001
Public Const HKEY_LOCAL_MACHINE As Long = &H80000002
Private Const REG_OPTION_NON_VOLATILE As Long = 0       ' Key is preserved when system is rebooted
'Private Const REG_OPTION_VOLATILE As Long = 1           ' Key is not preserved when system is rebooted
Private Const STANDARD_RIGHTS_ALL As Long = &H1F0000
Private Const SYNCHRONIZE As Long = &H100000
'Private Const READ_CONTROL As Long = &H20000
'Private Const STANDARD_RIGHTS_READ As Long = (READ_CONTROL)
'Private Const STANDARD_RIGHTS_WRITE As Long = (READ_CONTROL)
Private Const KEY_CREATE_LINK As Long = &H20
Private Const KEY_CREATE_SUB_KEY As Long = &H4
Private Const KEY_ENUMERATE_SUB_KEYS As Long = &H8
Private Const KEY_NOTIFY As Long = &H10
Private Const KEY_QUERY_VALUE As Long = &H1
Private Const KEY_SET_VALUE As Long = &H2
'Private Const KEY_READ As Long = ((STANDARD_RIGHTS_READ Or KEY_QUERY_VALUE Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY) And (Not SYNCHRONIZE))
'Private Const KEY_WRITE As Long = ((STANDARD_RIGHTS_WRITE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY) And (Not SYNCHRONIZE))
'Private Const KEY_EXECUTE As Long = (KEY_READ)
Private Const KEY_ALL_ACCESS As Long = ((STANDARD_RIGHTS_ALL Or KEY_QUERY_VALUE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY Or KEY_CREATE_LINK) And (Not SYNCHRONIZE))

Private Const REG_CREATED_NEW_KEY = &H1
'Private Const RRF_RT_REG_SZ As Long = &H2


Private Declare Function RegCreateKeyEx Lib "ADVAPI32.dll" Alias "RegCreateKeyExA" ( _
    ByVal hKey As Long, _
    ByVal lpSubKey As String, _
    ByVal Reserved As Long, _
    ByVal lpClass As String, _
    ByVal dwOptions As Long, _
    ByVal SamDesired As Long, _
    lpSecurityAttributes As Any, _
    phkResult As Long, _
    lpdwDisposition As Long _
    ) As Long

'~~> The RegOpenKeyEx function opens the specified key.
Private Declare Function RegOpenKeyEx Lib "ADVAPI32.dll" Alias "RegOpenKeyExA" ( _
    ByVal hKey As Long, _
    ByVal lpSubKey As String, _
    ByVal Reserved As Long, _
    ByVal SamDesired As Long, _
    phkResult As Long _
    ) As Long

Private Declare Function RegSetValueEx Lib "ADVAPI32.dll" Alias "RegSetValueExA" ( _
    ByVal hKey As Long, _
    ByVal lpValueName As String, _
    ByVal Reserved As Long, _
    ByVal dwType As Long, _
    ByVal lpData As String, _
    ByVal cbData As Long _
    ) As Long
Private Declare Function RegQueryValueEx Lib "ADVAPI32.dll" Alias "RegQueryValueExA" ( _
    ByVal hKey As Long, _
    ByVal lpValueName As String, _
    ByVal lpReserved As Long, _
    lpType As Long, _
    ByVal lpData As String, _
    lpcbData As Long _
    ) As Long

Private Declare Function RegSetValueExNum Lib "ADVAPI32.dll" Alias "RegSetValueExA" ( _
    ByVal hKey As Long, _
    ByVal lpValueName As String, _
    ByVal Reserved As Long, _
    ByVal dwType As Long, _
    lpData As Any, _
    ByVal cbData As Long _
    ) As Long
Private Declare Function RegQueryValueExNum Lib "ADVAPI32.dll" Alias "RegQueryValueExA" ( _
    ByVal hKey As Long, _
    ByVal lpValueName As String, _
    ByVal lpReserved As Long, _
    lpType As Long, _
    lpData As Any, _
    lpcbData As Long _
    ) As Long

Private Declare Function RegCloseKey Lib "ADVAPI32.dll" (ByVal hKey As Long) As Long


Public Function RegistroCrea(path As String) As Long

    Dim hKey As Long
    Dim Errore As Long

    Errore = RegCreateKeyEx(HKEY_LOCAL_MACHINE, path, 0, "REG_DWORD", REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, ByVal 0&, hKey, REG_CREATED_NEW_KEY)
    If (Errore = 0) Then
        RegistroCrea = hKey
    Else
        RegistroCrea = 0
    End If

End Function

Public Function RegistroApri(path As String) As Long

    Call RegOpenKeyEx(HKEY_LOCAL_MACHINE, path, 0, KEY_ALL_ACCESS, RegistroApri)

End Function

Public Function RegistroLeggiStringa(hKey As Long, chiave As String) As String

    Dim Errore As Long
    Dim buffer As String
    Dim tipo As Long
    Dim Lunghezza As Long

    '   Legge al massimo 256 caratteri, basta?
    Lunghezza = 256
    buffer = String(Lunghezza, 0)

    Errore = RegQueryValueEx(hKey, chiave, 0, tipo, buffer, Lunghezza)
    If (Errore = 0) Then
        RegistroLeggiStringa = Left(buffer, Lunghezza - 1)
    Else
        RegistroLeggiStringa = ""
    End If
    
End Function

Public Function RegistroScriviStringa(hKey As Long, chiave As String, valore As String) As Boolean

    Dim Errore As Long

    Errore = RegSetValueEx(hKey, chiave, 0, REG_SZ, valore, Len(valore) + 1)
    RegistroScriviStringa = (Errore = 0)

End Function

Public Function RegistroLeggiNumero(hKey As Long, chiave As String) As Long

    Dim Errore As Long
    Dim buffer As Long
    Dim tipo As Long
    Dim Lunghezza As Long

    Lunghezza = Len(buffer)

    Errore = RegQueryValueExNum(hKey, chiave, 0, tipo, buffer, Lunghezza)
    If (Errore = 0) Then
        RegistroLeggiNumero = buffer
    Else
        RegistroLeggiNumero = 0
    End If

End Function

Public Function RegistroScriviNumero(hKey As Long, chiave As String, valore As Long) As Boolean

    Dim Errore As Long

    Errore = RegSetValueExNum(hKey, chiave, 0, REG_DWORD, valore, Len(valore))
    RegistroScriviNumero = (Errore = 0)

End Function

Public Function RegistroChiudi(hKey As Long) As Boolean

    RegCloseKey hKey

End Function

