Attribute VB_Name = "GestioneHelp"
'
'   Gestione dell'help
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


' HTML Help Constants
Public Const HH_DISPLAY_TOPIC = &H0            '  WinHelp equivalent
Public Const HH_DISPLAY_TOC = &H1              '  WinHelp equivalent
Public Const HH_DISPLAY_INDEX = &H2            '  WinHelp equivalent
Public Const HH_DISPLAY_SEARCH = &H3           '  WinHelp equivalent
Public Const HH_SET_WIN_TYPE = &H4
Public Const HH_GET_WIN_TYPE = &H5
Public Const HH_GET_WIN_HANDLE = &H6
Public Const HH_SYNC = &H9
Public Const HH_ADD_NAV_UI = &HA               ' not currently implemented
Public Const HH_ADD_BUTTON = &HB               ' not currently implemented
Public Const HH_GETBROWSER_APP = &HC           ' not currently implemented
Public Const HH_KEYWORD_LOOKUP = &HD           '  WinHelp equivalent
Public Const HH_DISPLAY_TEXT_POPUP = &HE       ' display string resource id
                                                ' or text in a popup window
                                                ' value in dwData
Public Const HH_HELP_CONTEXT = &HF             '  display mapped numeric
Public Const HH_CLOSE_ALL = &H12               '  WinHelp equivalent
Public Const HH_ALINK_LOOKUP = &H13            '  ALink version of
                                                '  HH_KEYWORD_LOOKUP
Public Const HH_SET_GUID = &H1A                ' For Microsoft Installer -- dwData is a pointer to the GUID string

' HTML Help window constants. These are also used
' in the window definitions in HHP files
Public Const HHWIN_PROP_ONTOP = &H2              ' Top-most window (not currently implemented)
Public Const HHWIN_PROP_NOTITLEBAR = &H4         ' no title bar
Public Const HHWIN_PROP_NODEF_STYLES = &H8       ' no default window styles (only HH_WINTYPE.dwStyles)
Public Const HHWIN_PROP_NODEF_EXSTYLES = &H10    ' no default extended window styles (only HH_WINTYPE.dwExStyles)
Public Const HHWIN_PROP_TRI_PANE = &H20          ' use a tri-pane window
Public Const HHWIN_PROP_NOTB_TEXT = &H40         ' no text on toolbar buttons
Public Const HHWIN_PROP_POST_QUIT = &H80         ' post WM_QUIT message when window closes
Public Const HHWIN_PROP_AUTO_SYNC = &H100        ' automatically ssync contents and index
Public Const HHWIN_PROP_TRACKING = &H200         ' send tracking notification messages
Public Const HHWIN_PROP_TAB_SEARCH = &H400       ' include search tab in navigation pane
Public Const HHWIN_PROP_TAB_HISTORY = &H800      ' include history tab in navigation pane
Public Const HHWIN_PROP_TAB_BOOKMARKS = &H1000   ' include bookmark tab in navigation pane
Public Const HHWIN_PROP_CHANGE_TITLE = &H2000    ' Put current HTML title in title bar
Public Const HHWIN_PROP_NAV_ONLY_WIN = &H4000    ' Only display the navigation window
Public Const HHWIN_PROP_NO_TOOLBAR = &H8000      ' Don't display a toolbar
Public Const HHWIN_PROP_MENU = &H10000           ' Menu
Public Const HHWIN_PROP_TAB_ADVSEARCH = &H20000  ' Advanced FTS UI.
Public Const HHWIN_PROP_USER_POS = &H40000       ' After initial creation, user controls window size/position

Public Const HHWIN_PARAM_PROPERTIES = &H2        ' valid fsWinProperties
Public Const HHWIN_PARAM_STYLES = &H4            ' valid dwStyles
Public Const HHWIN_PARAM_EXSTYLES = &H8          ' valid dwExStyles
Public Const HHWIN_PARAM_RECT = &H10             ' valid rcWindowPos
Public Const HHWIN_PARAM_NAV_WIDTH = &H20        ' valid iNavWidth
Public Const HHWIN_PARAM_SHOWSTATE = &H40        ' valid nShowState
Public Const HHWIN_PARAM_INFOTYPES = &H80        ' valid apInfoTypes
Public Const HHWIN_PARAM_TB_FLAGS = &H100        ' valid fsToolBarFlags
Public Const HHWIN_PARAM_EXPANSION = &H200       ' valid fNotExpanded
Public Const HHWIN_PARAM_TABPOS = &H400          ' valid tabpos
Public Const HHWIN_PARAM_TABORDER = &H800        ' valid taborder
Public Const HHWIN_PARAM_HISTORY_COUNT = &H1000  ' valid cHistory
Public Const HHWIN_PARAM_CUR_TAB = &H2000        ' valid curNavType

Public Const HHWIN_BUTTON_EXPAND = &H2           ' Expand/contract button
Public Const HHWIN_BUTTON_BACK = &H4             ' Back button
Public Const HHWIN_BUTTON_FORWARD = &H8          ' Forward button
Public Const HHWIN_BUTTON_STOP = &H10            ' Stop button
Public Const HHWIN_BUTTON_REFRESH = &H20         ' Refresh button
Public Const HHWIN_BUTTON_HOME = &H40            ' Home button
Public Const HHWIN_BUTTON_BROWSE_FWD = &H80      ' not implemented
Public Const HHWIN_BUTTON_BROWSE_BCK = &H100     ' not implemented
Public Const HHWIN_BUTTON_NOTES = &H200          ' not implemented
Public Const HHWIN_BUTTON_CONTENTS = &H400       ' not implemented
Public Const HHWIN_BUTTON_SYNC = &H800           ' Locate button
Public Const HHWIN_BUTTON_OPTIONS = &H1000       ' Options button
Public Const HHWIN_BUTTON_PRINT = &H2000         ' Print button
Public Const HHWIN_BUTTON_INDEX = &H4000         ' not implemented
Public Const HHWIN_BUTTON_SEARCH = &H8000        ' not implemented
Public Const HHWIN_BUTTON_HISTORY = &H10000      ' not implemented
Public Const HHWIN_BUTTON_BOOKMARKS = &H20000    ' not implemented
Public Const HHWIN_BUTTON_JUMP1 = &H40000        ' Jump1 button
Public Const HHWIN_BUTTON_JUMP2 = &H80000        ' Jump2 button
Public Const HHWIN_BUTTON_ZOOM = &H100000        ' Font sizing button
Public Const HHWIN_BUTTON_TOC_NEXT = &H200000    ' Browse next TOC topic button
Public Const HHWIN_BUTTON_TOC_PREV = &H400000    ' Browse previous TOC topic button

' Default button set
Public Const HHWIN_DEF_BUTTONS = (HHWIN_BUTTON_EXPAND Or HHWIN_BUTTON_BACK Or HHWIN_BUTTON_OPTIONS Or HHWIN_BUTTON_PRINT)

' Button IDs
Public Const IDTB_EXPAND = 200
Public Const IDTB_CONTRACT = 201
Public Const IDTB_STOP = 202
Public Const IDTB_REFRESH = 203
Public Const IDTB_BACK = 204
Public Const IDTB_HOME = 205
Public Const IDTB_SYNC = 206
Public Const IDTB_PRINT = 207
Public Const IDTB_OPTIONS = 208
Public Const IDTB_FORWARD = 209
Public Const IDTB_NOTES = 210             ' not implemented
Public Const IDTB_BROWSE_FWD = 211
Public Const IDTB_BROWSE_BACK = 212
Public Const IDTB_CONTENTS = 213          ' not implemented
Public Const IDTB_INDEX = 214             ' not implemented
Public Const IDTB_SEARCH = 215            ' not implemented
Public Const IDTB_HISTORY = 216           ' not implemented
Public Const IDTB_BOOKMARKS = 217         ' not implemented
Public Const IDTB_JUMP1 = 218
Public Const IDTB_JUMP2 = 219
Public Const IDTB_CUSTOMIZE = 221
Public Const IDTB_ZOOM = 222
Public Const IDTB_TOC_NEXT = 223
Public Const IDTB_TOC_PREV = 224

Public Enum HHACT_
  HHACT_TAB_CONTENTS
  HHACT_TAB_INDEX
  HHACT_TAB_SEARCH
  HHACT_TAB_HISTORY
  HHACT_TAB_FAVORITES
    
  HHACT_EXPAND
  HHACT_CONTRACT
  HHACT_BACK
  HHACT_FORWARD
  HHACT_STOP
  HHACT_REFRESH
  HHACT_HOME
  HHACT_SYNC
  HHACT_OPTIONS
  HHACT_PRINT
  HHACT_HIGHLIGHT
  HHACT_CUSTOMIZE
  HHACT_JUMP1
  HHACT_JUMP2
  HHACT_ZOOM
  HHACT_TOC_NEXT
  HHACT_TOC_PREV
  HHACT_NOTES

  HHACT_LAST_ENUM
End Enum

Public Enum HHWIN_NAVTYPE_
  HHWIN_NAVTYPE_TOC
  HHWIN_NAVTYPE_INDEX
  HHWIN_NAVTYPE_SEARCH
  HHWIN_NAVTYPE_HISTORY       ' not implemented
  HHWIN_NAVTYPE_FAVORITES     ' not implemented
End Enum

Enum HHWIN_NAVTAB_
  HHWIN_NAVTAB_TOP
  HHWIN_NAVTAB_LEFT
  HHWIN_NAVTAB_BOTTOM
End Enum

Public Const HH_MAX_TABS = 19               ' maximum number of tabs

Public Enum HH_TAB_
  HH_TAB_CONTENTS
  HH_TAB_INDEX
  HH_TAB_SEARCH
  HH_TAB_HISTORY
  HH_TAB_FAVORITES
End Enum


' UDT for keyword and ALink searches
Public Type HH_AKLINK
  cbStruct          As Long
  fReserved         As Boolean
  pszKeywords       As String
  pszUrl            As String
  pszMsgText        As String
  pszMsgTitle       As String
  pszWindow         As String
  fIndexOnFail      As Boolean
End Type

' UDT for accessing the Search tab
Public Type HH_FTS_QUERY
  cbStruct          As Long
  fUniCodeStrings   As Long
  pszSearchQuery    As String
  iProximity        As Long
  fStemmedSearch    As Long
  fTitleOnly        As Long
  fExecute          As Long
  pszWindow         As String
End Type

Public Declare Function HTMLHelp Lib "hhctrl.ocx" Alias "HtmlHelpA" (ByVal hWnd As Long, ByVal lpHelpFile As String, ByVal wCommand As Long, dwData As Any) As Long


'   Identificativi dell'help
Public Enum HelpContextID

    HELP_INTRODUZIONE = 0

    HELP_INIZIO = 100

    HELP_PRINCIPALE = 200

    HELP_PARAMETRI = 300
        HELP_PARAGENERALI = 301
        HELP_PARAVARIE = 302
        HELP_PARAPREDOSATORI = 303
        HELP_PARABRUCIATORE = 304
        HELP_PARADOSAGGIO = 305
        HELP_PARAADDITIVI = 306
        HELP_PARASILI = 307
        HELP_PARALEGANTE = 308
        HELP_PARAMOTORI = 309
        HELP_PARACOMANDI = 310
        HELP_PARAAMPEROMETRI = 311
        HELP_PARACISTERNE = 312
        HELP_PARAGRAFICI = 313
        HELP_PARAORDINEMOTORI = 314
        HELP_PARADOSAGGIO2 = 315

    HELP_MOTORI_FRAME = 400
        HELP_MOTORI_AVVIO_AUTOMATICO = 401
        HELP_MOTORI_GESTIONE_MANUALE = 403
        HELP_MOTORI_COMANDI = 404
        HELP_MOTORI_COCLEE_MANUALI = 405

    HELP_PREDOSAGGIO_FRAME = 500
        HELP_PREDOSAGGIO_GESTIONE_RICETTE = 501
        HELP_PREDOSAGGIO_INS_RICETTA = 502
        HELP_PREDOSAGGIO_UMIDITA = 503
        HELP_PREDOSAGGIO_STATO_PREDOSATORI = 505
        HELP_PREDOSAGGIO_TARATURA_PRED = 520
        HELP_PREDOSAGGIO_TARATURA_NASTRI = 550
        
    HELP_DOSAGGIO_FRAME = 600
        HELP_DOSAGGIO_GESTIONE_RICETTA = 601
        HELP_DOSAGGIO_INSERIMENTO_RICETTA = 602
        HELP_DOSAGGIO_DESCRIZIONE_RICETTA = 603
        HELP_DOSAGGIO_DESCRITTIVO_CLIENTI = 604
        HELP_DOSAGGIO_CALCOLO_PRODUZIONE = 605
        
    HELP_CISTERNE_FRAME = 800
        HELP_CISTERNE_COMANDI = 803

    HELP_DETTAGLI_DOSAGGIO = 900
        HELP_DETTAGLI_DOSAGGIO_NETTI = 904
        
    HELP_SILI_FORM = 1000
        HELP_SILI_DETTAGLIO = 1002
        HELP_SILI_RICERCA_TEMPERATURE = 1003

    HELP_STORICOIMPASTO = 1100
        HELP_STORICOIMPASTO_DATI = 1101
        HELP_STORICOIMPASTO_IMPASTIMANUALI = 1102

    HELP_TOTALI = 1200

    HELP_CONSUMI = 1300

    HELP_STORICOALLARMI = 1400

    HELP_PREDOSATORI_CP240 = 1500

    HELP_PARCOLEGANTE_CP240 = 1600

    HELP_ESSICATORE_CP240 = 1700
        HELP_ESSICCATORE_AUTOMATICO = 1703

    HELP_FILTRO_CP240 = 1800

    HELP_SILIFILLER_CP240 = 1900

    HELP_TORREDOSAGGIO = 2000

    HELP_TORREMIXER = 2100

    HELP_SILI_CP240 = 2200

    HELP_TREND = 2300

    HELP_PLCANA = 2400

    HELP_PLCDIG = 2500

    HELP_ABOUT = 2600
    
    HELP_APPENDICE_RETROAZ_TRAMOGGE = 2700

End Enum


'   Visualizzazione
Public Function VisualizzaHelp(ByRef parent As Form, ByVal contextID As Long) As Boolean

    '20160927 ~> FB
    Call SendMessagetoPlus(PlusSendShowHelp, CStr(contextID))
    VisualizzaHelp = True
    Exit Function
    '20160927 <~ FB
    
    'vecchia gestione
    Dim result As Long
    Dim nomeFile As String

    nomeFile = InstallationPath + "CYB500N_"

    Select Case LinguaSelezionata
        Case LangITA
            nomeFile = nomeFile + "ITA"
        Case LangING
            nomeFile = nomeFile + "ENG"
        Case LangCIN
            nomeFile = nomeFile + "CIN"
        Case LangPOL
            nomeFile = nomeFile + "POL"
        Case LangRUS
            nomeFile = nomeFile + "RUS"
        Case LangSPA
            nomeFile = nomeFile + "SPA"
        Case LangPOR
            nomeFile = nomeFile + "POR"
        Case LangRUM
            nomeFile = nomeFile + "RUM"
        Case LangFRA
            nomeFile = nomeFile + "FRA"
        Case LangGRE
            nomeFile = nomeFile + "GRE"
        Case LangSER
            nomeFile = nomeFile + "SERBO"
        Case LangBUL
            nomeFile = nomeFile + "BUL"
        Case LangTUR
            nomeFile = nomeFile + "TUR"
        Case LangEXTRA
            nomeFile = nomeFile + "EXTRA"
        Case Else
            nomeFile = nomeFile + "ENG"
    End Select

    nomeFile = nomeFile + ".chm"

    If (Not FileExist(nomeFile)) Then
        nomeFile = InstallationPath + "CYB500N_ENG.chm"
    End If

    'HH_HELP_CONTEXT
    'HH_DISPLAY_TOPIC
    result = HTMLHelp(parent.hWnd, nomeFile, HH_HELP_CONTEXT, ByVal contextID)
    If (result = 0) Then
        result = HTMLHelp(parent.hWnd, nomeFile, HH_HELP_CONTEXT, ByVal HELP_INIZIO)
    End If

    VisualizzaHelp = (result <> 0)

End Function
