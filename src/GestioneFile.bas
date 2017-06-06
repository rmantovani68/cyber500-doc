Attribute VB_Name = "GestioneFile"
'
'   Gestione dei file
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


'   Lista degli identificativi per i path delle cartelle di sistema
Public Enum mceIDLPaths
    CSIDL_ALTSTARTUP = &H1D ' * CSIDL_ALTSTARTUP - File system directory that corresponds to the user's nonlocalized Startup program group. (All Users\Startup?)
    CSIDL_APPDATA = &H1A ' * CSIDL_APPDATA - File system directory that serves as a common repository for application-specific data. A common path is C:\WINNT\Profiles\username\Application Data.
    CSIDL_BITBUCKET = &HA ' * CSIDL_BITBUCKET - Virtual folder containing the objects in the user's Recycle Bin.
    CSIDL_COMMON_ALTSTARTUP = &H1E ' * CSIDL_COMMON_ALTSTARTUP - File system directory that corresponds to the nonlocalized Startup program group for all users. Valid only for Windows NT systems.
    CSIDL_COMMON_APPDATA = &H23 ' * CSIDL_COMMON_APPDATA - Version 5.0. Application data for all users. A common path is C:\WINNT\Profiles\All Users\Application Data.
    CSIDL_COMMON_DESKTOPDIRECTORY = &H19 ' * CSIDL_DESKTOPDIRECTORY - File system directory used to physically store file objects on the desktop (not to be confused with the desktop folder itself). A common path is C:\WINNT\Profiles\username\Desktop
    CSIDL_COMMON_DOCUMENTS = &H2E ' * CSIDL_COMMON_DOCUMENTS - File system directory that contains documents that are common to all users. A common path is C:\WINNT\Profiles\All Users\Documents. Valid only for Windows NT systems.
    CSIDL_COMMON_FAVORITES = &H1F ' * CSIDL_COMMON_FAVORITES - File system directory that serves as a common repository for all users' favorite items. Valid only for Windows NT systems.
    CSIDL_COMMON_PROGRAMS = &H17 ' * CSIDL_COMMON_PROGRAMS - File system directory that contains the directories for the common program groups that appear on the Start menu for all users. A common path is c:\WINNT\Profiles\All Users\Start Menu\Programs. Valid only for Windows NT systems.
    CSIDL_COMMON_STARTMENU = &H16 ' * CSIDL_COMMON_STARTMENU - File system directory that contains the programs and folders that appear on the Start menu for all users. A common path is C:\WINNT\Profiles\All Users\Start Menu. Valid only for Windows NT systems.
    CSIDL_COMMON_STARTUP = &H18 ' * CSIDL_COMMON_STARTUP - File system directory that contains the programs that appear in the Startup folder for all users. A common path is C:\WINNT\Profiles\All Users\Start Menu\Programs\Startup. Valid only for Windows NT systems.
    CSIDL_COMMON_TEMPLATES = &H2D ' * CSIDL_COMMON_TEMPLATES - File system directory that contains the templates that are available to all users. A common path is C:\WINNT\Profiles\All Users\Templates. Valid only for Windows NT systems.
    CSIDL_COOKIES = &H21 ' * CSIDL_COOKIES - File system directory that serves as a common repository for Internet cookies. A common path is C:\WINNT\Profiles\username\Cookies.
    CSIDL_DESKTOPDIRECTORY = &H10 ' * CSIDL_COMMON_DESKTOPDIRECTORY - File system directory that contains files and folders that appear on the desktop for all users. A common path is C:\WINNT\Profiles\All Users\Desktop. Valid only for Windows NT systems.
    CSIDL_FAVORITES = &H6 ' * CSIDL_FAVORITES - File system directory that serves as a common repository for the user's favorite items. A common path is C:\WINNT\Profiles\username\Favorites.
    CSIDL_FONTS = &H14 ' * CSIDL_FONTS - Virtual folder containing fonts. A common path is C:\WINNT\Fonts.
    CSIDL_HISTORY = &H22 ' * CSIDL_HISTORY - File system directory that serves as a common repository for Internet history items.
    CSIDL_INTERNET_CACHE = &H20 ' * CSIDL_INTERNET_CACHE - File system directory that serves as a common repository for temporary Internet files. A common path is C:\WINNT\Profiles\username\Temporary Internet Files.
    CSIDL_LOCAL_APPDATA = &H1C ' * CSIDL_LOCAL_APPDATA - Version 5.0. File system directory that serves as a data repository for local (non-roaming) applications. A common path is C:\WINNT\Profiles\username\Local Settings\Application Data.
    CSIDL_PROGRAMS = &H2 ' * CSIDL_PROGRAMS - File system directory that contains the user's program groups (which are also file system directories). A common path is C:\WINNT\Profiles\username\Start Menu\Programs.
    CSIDL_PROGRAM_FILES = &H26 ' * CSIDL_PROGRAM_FILES - Version 5.0. Program Files folder. A common path is C:\Program Files.
    CSIDL_PROGRAM_FILES_COMMON = &H2B ' * CSIDL_PROGRAM_FILES_COMMON - Version 5.0. A folder for components that are shared across applications. A common path is C:\Program Files\Common. Valid only for Windows NT and Windows® 2000 systems.
    CSIDL_PERSONAL = &H5 ' * CSIDL_PERSONAL - File system directory that serves as a common repository for documents. A common path is C:\WINNT\Profiles\username\My Documents.
    CSIDL_RECENT = &H8 ' * CSIDL_RECENT - File system directory that contains the user's most recently used documents. A common path is C:\WINNT\Profiles\username\Recent. To create a shortcut in this folder, use SHAddToRecentDocs. In addition to creating the shortcut, this function updates the shell's list of recent documents and adds the shortcut to the Documents submenu of the Start menu.
    CSIDL_SENDTO = &H9 ' * CSIDL_SENDTO - File system directory that contains Send To menu items. A common path is c:\WINNT\Profiles\username\SendTo.
    CSIDL_STARTUP = &H7 ' * CSIDL_STARTUP - File system directory that corresponds to the user's Startup program group. The system starts these programs whenever any user logs onto Windows NT or starts Windows® 95. A common path is C:\WINNT\Profiles\username\Start Menu\Programs\Startup.
    CSIDL_STARTMENU = &HB ' * CSIDL_STARTMENU - File system directory containing Start menu items. A common path is c:\WINNT\Profiles\username\Start Menu.
    CSIDL_SYSTEM = &H25 ' * CSIDL_SYSTEM - Version 5.0. System folder. A common path is C:\WINNT\SYSTEM32.
    CSIDL_TEMPLATES = &H15 ' * CSIDL_TEMPLATES - File system directory that serves as a common repository for document templates.
    CSIDL_WINDOWS = &H24 ' * CSIDL_WINDOWS - Version 5.0. Windows directory or SYSROOT. This corresponds to the %windir% or %SYSTEMROOT% environment variables. A common path is C:\WINNT.
End Enum


Private Declare Function SHGetSpecialFolderPath Lib "SHELL32.DLL" Alias "SHGetSpecialFolderPathA" (ByVal hWnd As Long, ByVal lpszPath As String, ByVal nFolder As Integer, ByVal fCreate As Boolean) As Boolean
Private Declare Function GetPrivateProfileStringA Lib "kernel32" (ByVal sectionName As String, ByVal keyName As String, ByVal defaultValue As String, ByVal Value As String, ByVal valueSize As Long, ByVal FileName As String) As Long
Private Declare Function WritePrivateProfileStringA Lib "kernel32" (ByVal sectionName As String, ByVal keyName As String, ByVal Value As String, ByVal FileName As String) As Long
    

'   Nome file di configurazione
Private Const PLANTINFOFILE As String = "CYB500N.ini"
'   Sezione sul file di configurazione
Private Const PLANTINFOSEZIONE As String = "CYB500N"


Public Const PI_PARAMETERTOSAVE As String = "ParameterToSave"
Public Const PI_USERDATAPATH As String = "UserDataPath"
Public Const PI_INSTALLDATAPATH As String = "InstallDataPath"
Public Const PI_GRAPHICPATH As String = "GraphicPath"
Public Const PI_LOGPATH As String = "LogPath"


Public Function FileGetValue( _
    FileName As String, _
    sectionName As String, _
    keyName As String, _
    defaultValue As String _
    ) As String

    Dim result As Long
    Dim reader As String


    reader = String(256, 0)

    result = GetPrivateProfileStringA(sectionName, keyName, defaultValue, reader, 255, FileName)

    If (result > 0) Then
        FileGetValue = Left(reader, result)
        If (FileGetValue = "Falso" Or FileGetValue = "False") Then
            FileGetValue = "0"
        ElseIf (FileGetValue = "Vero" Or FileGetValue = "True") Then
            FileGetValue = "1"
        End If
    Else
        FileGetValue = defaultValue
    End If

End Function


Public Sub FileSetValue( _
    FileName As String, _
    sectionName As String, _
    keyName As String, _
    ByVal Value As String _
    )

    Dim result As Long


    If (Value = "Falso" Or Value = "False") Then
        Value = "0"
    ElseIf (Value = "Vero" Or Value = "True") Then
        Value = "1"
    End If

    result = WritePrivateProfileStringA(sectionName, keyName, Value, FileName)

End Sub


Public Function GetSystemFolder(ByVal systemFolder As mceIDLPaths) As String

    Dim path As String: path = Space$(260)


    GetSystemFolder = ""

    On Error GoTo Errore

    If (SHGetSpecialFolderPath(0, path, systemFolder, False)) Then
        If (Trim$(path) <> Chr(0)) Then
            path = Left$(path, InStr(path, Chr(0)) - 1) & "\"
        End If
    End If

    GetSystemFolder = path

Errore:

End Function


Public Function GetPlantInfoString(info As String, default As String) As String

    GetPlantInfoString = FileGetValue(InstallationPath + PLANTINFOFILE, PLANTINFOSEZIONE, info, default)

End Function


Public Sub SetPlantInfoString(info As String, Value As String)

    Call FileSetValue(InstallationPath + PLANTINFOFILE, PLANTINFOSEZIONE, info, Value)

End Sub


Public Function GetPlantInfoNumber(info As String, default As Long) As Long

    GetPlantInfoNumber = CInt(GetPlantInfoString(info, CStr(default)))

End Function


Public Sub SetPlantInfoNumber(info As String, Value As Long)

    SetPlantInfoString info, CStr(Value)

End Sub


