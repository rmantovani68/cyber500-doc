VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmSiwarexPara 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "MARINI - Parametri Siwarex"
   ClientHeight    =   8955
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12360
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmSiwarexPara.frx":0000
   ScaleHeight     =   8955
   ScaleWidth      =   12360
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   3360
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   24
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":168B
            Key             =   "PLUS_IMG_LOGIN"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":1CC2
            Key             =   "PLUS_IMG_LOGIN_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":232C
            Key             =   "PLUS_IMG_LOGIN_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":2B66
            Key             =   "PLUS_IMG_LOGIN_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":31CE
            Key             =   "PLUS_IMG_LOGEXPORT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":3849
            Key             =   "PLUS_IMG_LOGEXPORT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":3EB3
            Key             =   "PLUS_IMG_LOGEXPORT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":4546
            Key             =   "PLUS_IMG_LOGEXPORT_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":4BDA
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":51A2
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":5757
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":5D17
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":62D7
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":6935
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":6F7C
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":75D2
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":7C28
            Key             =   "PLUS_IMG_SAVE"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":8252
            Key             =   "PLUS_IMG_SAVE_GRAY"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":8897
            Key             =   "PLUS_IMG_SAVE_PRESS"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":8EF6
            Key             =   "PLUS_IMG_SAVE_SELECTED"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":9553
            Key             =   "PLUS_IMG_STAMPA"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":9B5F
            Key             =   "PLUS_IMG_STAMPA_GRAY"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":A14B
            Key             =   "PLUS_IMG_STAMPA_PRESS"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiwarexPara.frx":A772
            Key             =   "PLUS_IMG_STAMPA_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton CmdSalva 
      Enabled         =   0   'False
      Height          =   550
      Left            =   7800
      Style           =   1  'Graphical
      TabIndex        =   110
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.TextBox TxtStatoTrasferimento 
      Alignment       =   2  'Center
      BackColor       =   &H8000000F&
      Height          =   375
      Left            =   3240
      TabIndex        =   90
      Top             =   8520
      Width           =   1500
   End
   Begin VB.Timer TimerAttesaCambioDR 
      Enabled         =   0   'False
      Interval        =   1200
      Left            =   9120
      Top             =   8520
   End
   Begin VB.Timer TimerProgrssBarLeggi 
      Enabled         =   0   'False
      Interval        =   400
      Left            =   8400
      Top             =   8520
   End
   Begin VB.Timer TimerAttesaRilettura 
      Enabled         =   0   'False
      Interval        =   300
      Left            =   8760
      Top             =   8520
   End
   Begin VB.Timer TimerProgrssBarInvia 
      Enabled         =   0   'False
      Interval        =   300
      Left            =   8040
      Top             =   8520
   End
   Begin MSComctlLib.ProgressBar ProgressBarInvia 
      Height          =   375
      Left            =   4815
      TabIndex        =   88
      Top             =   8520
      Width           =   3225
      _ExtentX        =   5689
      _ExtentY        =   661
      _Version        =   393216
      Appearance      =   1
      Max             =   10
   End
   Begin VB.Frame Frame1 
      Height          =   7215
      Left            =   8280
      TabIndex        =   43
      Top             =   1080
      Width           =   3975
      Begin VB.CommandButton CmdNastro 
         BackColor       =   &H00C0C0C0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Index           =   1
         Left            =   1200
         Style           =   1  'Graphical
         TabIndex        =   55
         Top             =   5760
         Width           =   550
      End
      Begin VB.CommandButton CmdNastro 
         BackColor       =   &H00C0C0C0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Index           =   0
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   5760
         Width           =   550
      End
      Begin VB.CommandButton CmdErrorQuit 
         BackColor       =   &H0000FFFF&
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   120
         Picture         =   "FrmSiwarexPara.frx":AD96
         Style           =   1  'Graphical
         TabIndex        =   53
         Top             =   5040
         Width           =   915
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   7
         Left            =   2400
         TabIndex        =   51
         Text            =   "False"
         Top             =   3360
         Visible         =   0   'False
         Width           =   915
      End
      Begin VB.TextBox TxtDR30 
         Enabled         =   0   'False
         Height          =   360
         Index           =   0
         Left            =   2400
         TabIndex        =   48
         Text            =   "999.99"
         Top             =   2400
         Visible         =   0   'False
         Width           =   915
      End
      Begin VB.TextBox TxtDR30 
         Enabled         =   0   'False
         Height          =   360
         Index           =   4
         Left            =   2400
         TabIndex        =   47
         Text            =   "999.99"
         Top             =   2880
         Visible         =   0   'False
         Width           =   915
      End
      Begin VB.Label LblDescrErr 
         Caption         =   "Error"
         Height          =   255
         Left            =   120
         TabIndex        =   109
         Top             =   3840
         Width           =   3735
      End
      Begin VB.Label LblDR31Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Left            =   120
         TabIndex        =   108
         Top             =   1920
         Width           =   915
      End
      Begin VB.Label LblDR30Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   3
         Left            =   120
         TabIndex        =   107
         Top             =   1560
         Width           =   915
      End
      Begin VB.Label LblDR30Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   2
         Left            =   120
         TabIndex        =   106
         Top             =   1200
         Width           =   915
      End
      Begin VB.Label LblDR30Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   1
         Left            =   120
         TabIndex        =   105
         Top             =   840
         Width           =   915
      End
      Begin VB.Label LblDR31 
         Caption         =   "DR31"
         Height          =   255
         Left            =   1080
         TabIndex        =   91
         Top             =   1980
         Width           =   2775
      End
      Begin VB.Label LblValoriDinSiwa 
         Alignment       =   2  'Center
         Caption         =   "Valori dinamici"
         Height          =   255
         Left            =   120
         TabIndex        =   87
         Top             =   480
         Width           =   3735
      End
      Begin VB.Image ImgMotorTest 
         Height          =   300
         Left            =   120
         Picture         =   "FrmSiwarexPara.frx":B9D8
         Stretch         =   -1  'True
         Top             =   6360
         Width           =   1755
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "ERR_MSG"
         Height          =   255
         Index           =   7
         Left            =   1080
         TabIndex        =   52
         Top             =   3420
         Width           =   2775
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   7
         Left            =   120
         Top             =   3360
         Width           =   915
      End
      Begin VB.Label LblDR30 
         Caption         =   "DR30(0)"
         Height          =   255
         Index           =   0
         Left            =   1080
         TabIndex        =   50
         Top             =   2460
         Width           =   2775
      End
      Begin VB.Shape ShapeDR30 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   0
         Left            =   120
         Top             =   2400
         Width           =   915
      End
      Begin VB.Shape ShapeDR30 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   4
         Left            =   120
         Top             =   2880
         Width           =   915
      End
      Begin VB.Label LblDR30 
         Caption         =   "DR30(4)"
         Height          =   255
         Index           =   4
         Left            =   1080
         TabIndex        =   49
         Top             =   2940
         Width           =   2775
      End
      Begin VB.Label LblDR30 
         Caption         =   "DR30(1)"
         Height          =   255
         Index           =   1
         Left            =   1080
         TabIndex        =   46
         Top             =   900
         Width           =   2775
      End
      Begin VB.Label LblDR30 
         Caption         =   "DR30(2)"
         Height          =   255
         Index           =   2
         Left            =   1080
         TabIndex        =   45
         Top             =   1260
         Width           =   2805
      End
      Begin VB.Label LblDR30 
         Caption         =   "DR30(3)"
         Height          =   255
         Index           =   3
         Left            =   1080
         TabIndex        =   44
         Top             =   1620
         Width           =   2775
      End
   End
   Begin VB.CommandButton CmdLog 
      Caption         =   "LOG"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   5040
      Style           =   1  'Graphical
      TabIndex        =   31
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdHelp 
      Height          =   550
      Left            =   5700
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdParolaChiave 
      Height          =   550
      Left            =   4320
      MouseIcon       =   "FrmSiwarexPara.frx":DA8A
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.Timer TimerDR03 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1080
      Top             =   8640
   End
   Begin VB.Timer TimerDR30 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   720
      Top             =   8640
   End
   Begin VB.Timer TimerTotalizer 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1440
      Top             =   8640
   End
   Begin VB.Timer TimerEsciServiceMode 
      Enabled         =   0   'False
      Interval        =   750
      Left            =   1800
      Top             =   8640
   End
   Begin VB.Timer TimerPesoCampione 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   1800
      Top             =   8280
   End
   Begin VB.Timer TimerScriviDR5 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   1440
      Top             =   8280
   End
   Begin VB.Timer TimerScriviDR3 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   1080
      Top             =   8280
   End
   Begin VB.Timer TimerZero 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   720
      Top             =   8280
   End
   Begin VB.CommandButton CmdEsci 
      Cancel          =   -1  'True
      Default         =   -1  'True
      Height          =   550
      Left            =   7080
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdStampa 
      Height          =   550
      Left            =   6360
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin TabDlg.SSTab SSTabPara 
      CausesValidation=   0   'False
      Height          =   7215
      Left            =   120
      TabIndex        =   4
      Top             =   1080
      Width           =   8115
      _ExtentX        =   14314
      _ExtentY        =   12726
      _Version        =   393216
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   882
      BackColor       =   16777215
      TabCaption(0)   =   "Parametri"
      TabPicture(0)   =   "FrmSiwarexPara.frx":DECC
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "LblDR3(0)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "LblDR3(1)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "LblDR3(2)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "LblDR3(3)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "LblDR3(4)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "LblDR3(5)"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "LblDR3(6)"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "LblDR3(7)"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "LblDR3(8)"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "LblDR3(9)"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "ShapeDR3(6)"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "LblDR5(3)"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "LblDR5(2)"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "LblDR5(1)"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "LblDR5(0)"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "LblFileSiwa"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).Control(16)=   "LblParSiwa"
      Tab(0).Control(16).Enabled=   0   'False
      Tab(0).Control(17)=   "LblDR5Siwa(0)"
      Tab(0).Control(17).Enabled=   0   'False
      Tab(0).Control(18)=   "LblDR5Siwa(1)"
      Tab(0).Control(18).Enabled=   0   'False
      Tab(0).Control(19)=   "LblDR5Siwa(2)"
      Tab(0).Control(19).Enabled=   0   'False
      Tab(0).Control(20)=   "LblDR5Siwa(3)"
      Tab(0).Control(20).Enabled=   0   'False
      Tab(0).Control(21)=   "LblDR3Siwa(0)"
      Tab(0).Control(21).Enabled=   0   'False
      Tab(0).Control(22)=   "LblDR3Siwa(1)"
      Tab(0).Control(22).Enabled=   0   'False
      Tab(0).Control(23)=   "LblDR3Siwa(2)"
      Tab(0).Control(23).Enabled=   0   'False
      Tab(0).Control(24)=   "LblDR3Siwa(3)"
      Tab(0).Control(24).Enabled=   0   'False
      Tab(0).Control(25)=   "LblDR3Siwa(4)"
      Tab(0).Control(25).Enabled=   0   'False
      Tab(0).Control(26)=   "LblDR3Siwa(5)"
      Tab(0).Control(26).Enabled=   0   'False
      Tab(0).Control(27)=   "LblDR3Siwa(7)"
      Tab(0).Control(27).Enabled=   0   'False
      Tab(0).Control(28)=   "LblDR3Siwa(8)"
      Tab(0).Control(28).Enabled=   0   'False
      Tab(0).Control(29)=   "LblDR3Siwa(9)"
      Tab(0).Control(29).Enabled=   0   'False
      Tab(0).Control(30)=   "LblTabPara(0)"
      Tab(0).Control(30).Enabled=   0   'False
      Tab(0).Control(31)=   "LblTabPara(3)"
      Tab(0).Control(31).Enabled=   0   'False
      Tab(0).Control(32)=   "TxtDR3(0)"
      Tab(0).Control(32).Enabled=   0   'False
      Tab(0).Control(33)=   "TxtDR3(1)"
      Tab(0).Control(33).Enabled=   0   'False
      Tab(0).Control(34)=   "TxtDR3(2)"
      Tab(0).Control(34).Enabled=   0   'False
      Tab(0).Control(35)=   "TxtDR3(3)"
      Tab(0).Control(35).Enabled=   0   'False
      Tab(0).Control(36)=   "TxtDR3(4)"
      Tab(0).Control(36).Enabled=   0   'False
      Tab(0).Control(37)=   "TxtDR3(5)"
      Tab(0).Control(37).Enabled=   0   'False
      Tab(0).Control(38)=   "TxtDR3(6)"
      Tab(0).Control(38).Enabled=   0   'False
      Tab(0).Control(39)=   "TxtDR3(7)"
      Tab(0).Control(39).Enabled=   0   'False
      Tab(0).Control(40)=   "TxtDR3(8)"
      Tab(0).Control(40).Enabled=   0   'False
      Tab(0).Control(41)=   "TxtDR3(9)"
      Tab(0).Control(41).Enabled=   0   'False
      Tab(0).Control(42)=   "CmdAutozero"
      Tab(0).Control(42).Enabled=   0   'False
      Tab(0).Control(43)=   "CmbFiltroSiwa"
      Tab(0).Control(43).Enabled=   0   'False
      Tab(0).Control(44)=   "TxtDR5(3)"
      Tab(0).Control(44).Enabled=   0   'False
      Tab(0).Control(45)=   "TxtDR5(2)"
      Tab(0).Control(45).Enabled=   0   'False
      Tab(0).Control(46)=   "TxtDR5(1)"
      Tab(0).Control(46).Enabled=   0   'False
      Tab(0).Control(47)=   "TxtDR5(0)"
      Tab(0).Control(47).Enabled=   0   'False
      Tab(0).Control(48)=   "CmdZero"
      Tab(0).Control(48).Enabled=   0   'False
      Tab(0).Control(49)=   "CmdPesoCampione"
      Tab(0).Control(49).Enabled=   0   'False
      Tab(0).Control(50)=   "CmdInviaSiwa"
      Tab(0).Control(50).Enabled=   0   'False
      Tab(0).Control(51)=   "CmdLeggiSiwa"
      Tab(0).Control(51).Enabled=   0   'False
      Tab(0).Control(52)=   "CmbCellaSiwa"
      Tab(0).Control(52).Enabled=   0   'False
      Tab(0).ControlCount=   53
      TabCaption(1)   =   "Stato Siwarex"
      TabPicture(1)   =   "FrmSiwarexPara.frx":DEE8
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "TxtCmdSiwa(1)"
      Tab(1).Control(1)=   "TxtCmdSiwa(0)"
      Tab(1).Control(2)=   "TxtCmdSiwa(2)"
      Tab(1).Control(3)=   "TxtCmdSiwa(3)"
      Tab(1).Control(4)=   "TxtCmdSiwa(4)"
      Tab(1).Control(5)=   "TxtCmdSiwa(5)"
      Tab(1).Control(6)=   "TxtCmdSiwa(6)"
      Tab(1).Control(7)=   "TxtCmdSiwa(8)"
      Tab(1).Control(8)=   "TxtCmdSiwa(9)"
      Tab(1).Control(9)=   "TxtCmdSiwa(10)"
      Tab(1).Control(10)=   "TxtCmdSiwa(11)"
      Tab(1).Control(11)=   "TxtCmdSiwa(13)"
      Tab(1).Control(12)=   "CmdCommandInput"
      Tab(1).Control(13)=   "TxtCommandInput"
      Tab(1).Control(14)=   "CmdResetTot(5)"
      Tab(1).Control(15)=   "TxtDR33(6)"
      Tab(1).Control(16)=   "TxtDR33(5)"
      Tab(1).Control(17)=   "LblTabPara(2)"
      Tab(1).Control(18)=   "LblTabPara(1)"
      Tab(1).Control(19)=   "LblCmdSiwa(1)"
      Tab(1).Control(20)=   "LblCmdSiwa(0)"
      Tab(1).Control(21)=   "ShapeCMD(1)"
      Tab(1).Control(22)=   "LblCmdSiwa(2)"
      Tab(1).Control(23)=   "LblCmdSiwa(3)"
      Tab(1).Control(24)=   "LblCmdSiwa(4)"
      Tab(1).Control(25)=   "LblCmdSiwa(5)"
      Tab(1).Control(26)=   "LblCmdSiwa(6)"
      Tab(1).Control(27)=   "LblCmdSiwa(8)"
      Tab(1).Control(28)=   "LblCmdSiwa(9)"
      Tab(1).Control(29)=   "LblCmdSiwa(10)"
      Tab(1).Control(30)=   "LblCmdSiwa(11)"
      Tab(1).Control(31)=   "ShapeCMD(2)"
      Tab(1).Control(32)=   "ShapeCMD(3)"
      Tab(1).Control(33)=   "ShapeCMD(4)"
      Tab(1).Control(34)=   "ShapeCMD(10)"
      Tab(1).Control(35)=   "ShapeCMD(13)"
      Tab(1).Control(36)=   "LblCmdSiwa(13)"
      Tab(1).Control(37)=   "LblDR33(6)"
      Tab(1).Control(38)=   "LblDR33(5)"
      Tab(1).ControlCount=   39
      Begin VB.ComboBox CmbCellaSiwa 
         Enabled         =   0   'False
         Height          =   360
         ItemData        =   "FrmSiwarexPara.frx":DF04
         Left            =   4680
         List            =   "FrmSiwarexPara.frx":DF11
         Style           =   2  'Dropdown List
         TabIndex        =   84
         Top             =   2640
         Width           =   1095
      End
      Begin VB.CommandButton CmdLeggiSiwa 
         BackColor       =   &H00C0C0C0&
         Caption         =   "<--"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   5850
         Style           =   1  'Graphical
         TabIndex        =   83
         Top             =   3600
         Width           =   915
      End
      Begin VB.CommandButton CmdInviaSiwa 
         BackColor       =   &H00C0C0C0&
         Caption         =   "-->"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   5850
         Style           =   1  'Graphical
         TabIndex        =   82
         Top             =   2220
         Width           =   915
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   1
         Left            =   -71520
         TabIndex        =   69
         Text            =   "False"
         Top             =   1080
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   0
         Left            =   -74760
         TabIndex        =   68
         Text            =   "230"
         Top             =   720
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   2
         Left            =   -71520
         TabIndex        =   67
         Text            =   "False"
         Top             =   1440
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   3
         Left            =   -71520
         TabIndex        =   66
         Text            =   "False"
         Top             =   1800
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   4
         Left            =   -71520
         TabIndex        =   65
         Text            =   "False"
         Top             =   2160
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   5
         Left            =   -74760
         TabIndex        =   64
         Text            =   "230"
         Top             =   2520
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   6
         Left            =   -74760
         TabIndex        =   63
         Text            =   "230"
         Top             =   3240
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   8
         Left            =   -74760
         TabIndex        =   62
         Text            =   "230"
         Top             =   4320
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   9
         Left            =   -74760
         TabIndex        =   61
         Text            =   "230"
         Top             =   4680
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   10
         Left            =   -71520
         TabIndex        =   60
         Text            =   "False"
         Top             =   5040
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   11
         Left            =   -74760
         TabIndex        =   59
         Text            =   "230"
         Top             =   5400
         Width           =   1095
      End
      Begin VB.TextBox TxtCmdSiwa 
         Enabled         =   0   'False
         Height          =   360
         Index           =   13
         Left            =   -71520
         TabIndex        =   58
         Text            =   "False"
         Top             =   3960
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.CommandButton CmdCommandInput 
         BackColor       =   &H00C0C0C0&
         Caption         =   "CMD"
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   -73920
         Style           =   1  'Graphical
         TabIndex        =   57
         Top             =   5880
         Width           =   915
      End
      Begin VB.TextBox TxtCommandInput 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0C0&
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   -74760
         TabIndex        =   56
         Text            =   "0"
         Top             =   5880
         Width           =   735
      End
      Begin VB.CommandButton CmdPesoCampione 
         BackColor       =   &H00C0C0C0&
         Caption         =   ">Kg<"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   5850
         Style           =   1  'Graphical
         TabIndex        =   42
         Top             =   5880
         Width           =   915
      End
      Begin VB.CommandButton CmdZero 
         BackColor       =   &H00C0C0C0&
         Caption         =   ">0<"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   5850
         Style           =   1  'Graphical
         TabIndex        =   41
         Top             =   5280
         Width           =   915
      End
      Begin VB.TextBox TxtDR5 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   0
         Left            =   4680
         TabIndex        =   36
         Text            =   "999.99"
         Top             =   1200
         Width           =   1095
      End
      Begin VB.TextBox TxtDR5 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   1
         Left            =   4680
         TabIndex        =   35
         Text            =   "999.99"
         Top             =   1560
         Width           =   1095
      End
      Begin VB.TextBox TxtDR5 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   2
         Left            =   4680
         TabIndex        =   34
         Text            =   "999.99"
         Top             =   1920
         Width           =   1095
      End
      Begin VB.TextBox TxtDR5 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   3
         Left            =   4680
         TabIndex        =   33
         Text            =   "999.99"
         Top             =   2280
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.CommandButton CmdResetTot 
         BackColor       =   &H00C0C0C0&
         Caption         =   "R"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   5
         Left            =   -67320
         Style           =   1  'Graphical
         TabIndex        =   32
         Top             =   5895
         Visible         =   0   'False
         Width           =   345
      End
      Begin VB.ComboBox CmbFiltroSiwa 
         Enabled         =   0   'False
         Height          =   360
         ItemData        =   "FrmSiwarexPara.frx":DF1E
         Left            =   4680
         List            =   "FrmSiwarexPara.frx":DF40
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   3000
         Width           =   1095
      End
      Begin VB.TextBox TxtDR33 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   6
         Left            =   -69480
         TabIndex        =   28
         Text            =   "999.99"
         Top             =   6240
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.TextBox TxtDR33 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   5
         Left            =   -69480
         TabIndex        =   26
         Text            =   "999.99"
         Top             =   5880
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.CommandButton CmdAutozero 
         BackColor       =   &H00808080&
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Microsoft Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   550
         Left            =   6020
         Style           =   1  'Graphical
         TabIndex        =   25
         Top             =   6480
         Width           =   550
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   9
         Left            =   4680
         TabIndex        =   23
         Text            =   "999.99"
         Top             =   4440
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   8
         Left            =   4680
         TabIndex        =   21
         Text            =   "999.99"
         Top             =   4080
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   7
         Left            =   4680
         TabIndex        =   19
         Text            =   "999.99"
         Top             =   3720
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Height          =   360
         Index           =   6
         Left            =   840
         TabIndex        =   17
         Text            =   "999.99"
         Top             =   6600
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   5
         Left            =   4680
         TabIndex        =   15
         Text            =   "999.99"
         Top             =   3360
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Height          =   360
         Index           =   4
         Left            =   840
         TabIndex        =   13
         Text            =   "999.99"
         Top             =   3000
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   3
         Left            =   840
         TabIndex        =   11
         Text            =   "999.99"
         Top             =   2640
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   2
         Left            =   4680
         TabIndex        =   9
         Text            =   "999.99"
         Top             =   4800
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   1
         Left            =   4680
         TabIndex        =   7
         Text            =   "999.99"
         Top             =   6000
         Width           =   1095
      End
      Begin VB.TextBox TxtDR3 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   360
         Index           =   0
         Left            =   4680
         TabIndex        =   5
         Text            =   "999.99"
         Top             =   5400
         Width           =   1095
      End
      Begin VB.Label LblTabPara 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Stato Siwarex"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   4200
         TabIndex        =   114
         Top             =   120
         Width           =   3855
      End
      Begin VB.Label LblTabPara 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Parametri"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   -74880
         TabIndex        =   113
         Top             =   120
         Width           =   3855
      End
      Begin VB.Label LblTabPara 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Stato Siwarex"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   -70800
         TabIndex        =   112
         Top             =   120
         Width           =   3855
      End
      Begin VB.Label LblTabPara 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Parametri"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   120
         TabIndex        =   111
         Top             =   120
         Width           =   3855
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   9
         Left            =   6840
         TabIndex        =   104
         Top             =   4440
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   8
         Left            =   6840
         TabIndex        =   103
         Top             =   4080
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   7
         Left            =   6840
         TabIndex        =   102
         Top             =   3720
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   5
         Left            =   6840
         TabIndex        =   101
         Top             =   3360
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   4
         Left            =   6840
         TabIndex        =   100
         Top             =   3000
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   3
         Left            =   6840
         TabIndex        =   99
         Top             =   2640
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   2
         Left            =   6840
         TabIndex        =   98
         Top             =   4800
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   1
         Left            =   6840
         TabIndex        =   97
         Top             =   6000
         Width           =   1095
      End
      Begin VB.Label LblDR3Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   0
         Left            =   6840
         TabIndex        =   96
         Top             =   5400
         Width           =   1095
      End
      Begin VB.Label LblDR5Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   3
         Left            =   6840
         TabIndex        =   95
         Top             =   2280
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label LblDR5Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   2
         Left            =   6840
         TabIndex        =   94
         Top             =   1920
         Width           =   1095
      End
      Begin VB.Label LblDR5Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   1
         Left            =   6840
         TabIndex        =   93
         Top             =   1560
         Width           =   1095
      End
      Begin VB.Label LblDR5Siwa 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Height          =   360
         Index           =   0
         Left            =   6840
         TabIndex        =   92
         Top             =   1200
         Width           =   1095
      End
      Begin VB.Label LblParSiwa 
         Alignment       =   2  'Center
         Caption         =   "Siwarex"
         Height          =   255
         Left            =   6840
         TabIndex        =   86
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label LblFileSiwa 
         Alignment       =   2  'Center
         Caption         =   "File"
         Height          =   255
         Left            =   4680
         TabIndex        =   85
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "CMD_ENABLED"
         Height          =   255
         Index           =   1
         Left            =   -73560
         TabIndex        =   81
         Top             =   1140
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "CMD_INPUT"
         Height          =   255
         Index           =   0
         Left            =   -73560
         TabIndex        =   80
         Top             =   780
         Width           =   3255
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   1
         Left            =   -74760
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "CMD_IN_PROGRESS"
         Height          =   255
         Index           =   2
         Left            =   -73560
         TabIndex        =   79
         Top             =   1500
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "CMD_FINISHED_OK"
         Height          =   255
         Index           =   3
         Left            =   -73560
         TabIndex        =   78
         Top             =   1860
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "CMD_ERR"
         Height          =   255
         Index           =   4
         Left            =   -73560
         TabIndex        =   77
         Top             =   2220
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "CMD_ERR_CODE"
         Height          =   255
         Index           =   5
         Left            =   -73560
         TabIndex        =   76
         Top             =   2580
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "SCALE_STATUS"
         Height          =   255
         Index           =   6
         Left            =   -73560
         TabIndex        =   75
         Top             =   3300
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "ERR_MSG_TYPE"
         Height          =   255
         Index           =   8
         Left            =   -73560
         TabIndex        =   74
         Top             =   4380
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "ERR_MSG_CODE"
         Height          =   255
         Index           =   9
         Left            =   -73560
         TabIndex        =   73
         Top             =   4740
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "FB_ERR"
         Height          =   255
         Index           =   10
         Left            =   -73560
         TabIndex        =   72
         Top             =   5100
         Width           =   3255
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "FB_ERR_CODE"
         Height          =   255
         Index           =   11
         Left            =   -73560
         TabIndex        =   71
         Top             =   5460
         Width           =   3255
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   2
         Left            =   -74760
         Top             =   1440
         Width           =   1095
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   3
         Left            =   -74760
         Top             =   1800
         Width           =   1095
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   4
         Left            =   -74760
         Top             =   2160
         Width           =   1095
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   10
         Left            =   -74760
         Top             =   5040
         Width           =   1095
      End
      Begin VB.Shape ShapeCMD 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   13
         Left            =   -74760
         Top             =   3960
         Width           =   1095
      End
      Begin VB.Label LblCmdSiwa 
         Caption         =   "ERR_MSG_QUIT"
         Height          =   255
         Index           =   13
         Left            =   -73560
         TabIndex        =   70
         Top             =   4020
         Width           =   3255
      End
      Begin VB.Label LblDR5 
         Caption         =   "DR5(0)"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   40
         Top             =   1260
         Width           =   4815
      End
      Begin VB.Label LblDR5 
         Caption         =   "DR5(1)"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   39
         Top             =   1620
         Width           =   4815
      End
      Begin VB.Label LblDR5 
         Caption         =   "DR5(2)"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   38
         Top             =   1980
         Width           =   4815
      End
      Begin VB.Label LblDR5 
         Caption         =   "DR5(3)"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   37
         Top             =   2340
         Visible         =   0   'False
         Width           =   4815
      End
      Begin VB.Label LblDR33 
         Caption         =   "DR33(6)"
         Height          =   255
         Index           =   6
         Left            =   -72120
         TabIndex        =   29
         Top             =   6240
         Visible         =   0   'False
         Width           =   3135
      End
      Begin VB.Label LblDR33 
         Caption         =   "DR33(5)"
         Height          =   255
         Index           =   5
         Left            =   -72120
         TabIndex        =   27
         Top             =   5940
         Visible         =   0   'False
         Width           =   3135
      End
      Begin VB.Shape ShapeDR3 
         BackColor       =   &H00808080&
         BackStyle       =   1  'Opaque
         Height          =   360
         Index           =   6
         Left            =   6840
         Top             =   6600
         Width           =   1095
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(9)"
         Height          =   255
         Index           =   9
         Left            =   120
         TabIndex        =   24
         Top             =   4500
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(8)"
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   22
         Top             =   4140
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(7)"
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   20
         Top             =   3780
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(6)"
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   18
         Top             =   6660
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(5)"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   16
         Top             =   3420
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(4)"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   14
         Top             =   3060
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(3)"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   12
         Top             =   2700
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(2)"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   10
         Top             =   4860
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(1)"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   8
         Top             =   6060
         Width           =   4695
      End
      Begin VB.Label LblDR3 
         Caption         =   "DR3(0)"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   6
         Top             =   5460
         Width           =   4695
      End
   End
   Begin MSComctlLib.ProgressBar ProgressBarLeggi 
      Height          =   375
      Left            =   4815
      TabIndex        =   89
      Top             =   8520
      Visible         =   0   'False
      Width           =   3225
      _ExtentX        =   5689
      _ExtentY        =   661
      _Version        =   393216
      Appearance      =   1
      Max             =   10
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   5
      Left            =   9120
      Picture         =   "FrmSiwarexPara.frx":DF78
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   4
      Left            =   2250
      Picture         =   "FrmSiwarexPara.frx":E59F
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   3
      Left            =   1125
      Picture         =   "FrmSiwarexPara.frx":EC0A
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   0
      Picture         =   "FrmSiwarexPara.frx":F206
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   10200
      Picture         =   "FrmSiwarexPara.frx":F820
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   11325
      Picture         =   "FrmSiwarexPara.frx":FE6E
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "FrmSiwarexPara"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'
'   Gestione dei parametri siwarex
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit

Private StepZero As Integer
Private StepPesoCampione As Integer
Private StepEsciSiwa As Integer

Private StepDR33 As Integer
Private StepDR30 As Integer
Private StepDR03 As Integer

Private ConteggioAttesa As Long
Private Const TempoAttesaRilettura As Integer = 3
Private indiceDR As Integer
Private appoggio As Integer
Private Calibrazione As Boolean

Private OraAttuale As Long

Private m_bilancia As SiwarexEnum

Private Enum TopBarButtonEnum
    uscita
    Help
    Salva
    Stampa
    LogExport
    Login
    TBB_LAST
End Enum


Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


Public Function BilanciaAttiva() As Integer
    BilanciaAttiva = m_bilancia
End Function

Private Sub CmbFiltroSiwa_Click()

    TxtDR3(4).text = CmbFiltroSiwa.ListIndex
    
End Sub


Private Sub CmbCellaSiwa_click()

    TxtDR3(3).text = CInt(CmbCellaSiwa.ItemData(CInt(CmbCellaSiwa.ListIndex)))
    
End Sub


Private Sub CmdAutozero_Click()
    TxtDR3(6).text = CStr(Not CBool(TxtDR3(6).text))
    If CBool(TxtDR3(6).text) Then
        ShapeDR3(6).BackColor = vbGreen
        CmdAutozero.Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
        CmdAutozero.ToolTipText = LoadXLSString(708)
    Else
        ShapeDR3(6).BackColor = &H808080
        CmdAutozero.Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
        CmdAutozero.ToolTipText = LoadXLSString(707)
    End If
End Sub

Private Sub CmdCommandInput_Click()

    CodiceComandoSiwarex = val(TxtCommandInput.text)
    Call AttivaComandoSiwarex(m_bilancia)
    
End Sub

Private Sub CmdErrorQuit_Click()
    
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    Siwarex(m_bilancia).SIWA_ERR_MSG_QUIT = True

    'Metto il timer nella pagina dei timer globali
    FrmGestioneTimer.TimerErrMsgQuit.enabled = False
    FrmGestioneTimer.TimerErrMsgQuit.Interval = 500
    FrmGestioneTimer.TimerErrMsgQuit.enabled = True

End Sub



Public Sub ShowMe(Modo As Integer, ByRef parent As Form, bilancia As Integer)

    m_bilancia = bilancia

    FrmSiwarexParaVisibile = True
    
    Call PasswordLevel
    
    Call VisualizzaBarraPulsantiCP240(False)

    Me.Show Modo, parent

End Sub


Private Sub CmdInviaSiwa_Click()
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    Dim buttonPressed As Integer
    
    If IsModified Then  'Caso in cui sono stati modificati alcuni valori nella colonna del file
        buttonPressed = ShowMsgBox(LoadXLSString(1418), vbYesNoCancel, vbQuestion, -1, -1, True)
        
        Select Case buttonPressed

            Case vbYes
                
                Call FormToStruct   'salvo i parametri cambiati nel file di testo
                
                Call FileToSiwa(m_bilancia) 'trasferisco i parametri del file alla siwarex
                
                'Visualizza una progressbar di attesa X secondi
                TimerProgrssBarInvia.enabled = True
                ConteggioAttesa = 0
                TimerProgrssBarInvia.Interval = 12 * 100
                
                Exit Sub

            Case vbCancel
            
                Exit Sub

        End Select
        
    Else
        buttonPressed = ShowMsgBox(LoadXLSString(1419), vbYesNoCancel, vbQuestion, -1, -1, True)
        
        Select Case buttonPressed

            Case vbYes
                
                Call FileToSiwa(m_bilancia) 'trasferisco i parametri del file alla siwarex
                
                'Visualizza una progressbar di attesa X secondi
                TimerProgrssBarInvia.enabled = True
                ConteggioAttesa = 0
                TimerProgrssBarInvia.Interval = 12 * 100

                Exit Sub

            Case vbCancel
            
                Exit Sub

        End Select
    End If
    
End Sub


Private Sub CmdLeggiSiwa_Click()
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    Dim buttonPressed As Integer

    buttonPressed = ShowMsgBox(LoadXLSString(1423), vbYesNoCancel, vbQuestion, -1, -1, True)
    
    Select Case buttonPressed

        Case vbYes

            Call SiwaToFile(m_bilancia)

            'Gestione progressBar
            ProgressBarInvia.Visible = False
            ProgressBarLeggi.Visible = True
            ConteggioAttesa = 10
            ProgressBarLeggi.Value = ConteggioAttesa
            TxtStatoTrasferimento.text = "SAVING"
            TxtStatoTrasferimento.BackColor = &HFF00&
            TimerProgrssBarLeggi.enabled = True
            TimerProgrssBarLeggi.Interval = 100
            'disabilito tutti i pulsanti mentre ci sono operazioni in atto
            CmdSalva.enabled = False
            CmdInviaSiwa.enabled = False
            CmdLeggiSiwa.enabled = False
            CmdZero.enabled = False
            CmdPesoCampione.enabled = False
            CmdEsci.enabled = False
            CmdLog.enabled = False
            CmdHelp.enabled = False
            CmdStampa.enabled = False
            CmdAutozero.enabled = False
            CmdCommandInput.enabled = False
            '
            Exit Sub

        Case vbCancel
            Exit Sub

    End Select
End Sub
'

Private Sub CmdNastro_Click(Index As Integer)

    If (DEMO_VERSION) Then
        Exit Sub
    End If

    Select Case Index
        Case 0  'Start
            CP240.OPCData.items(PLCTAG_DO_SIWA_Batch_ModalitaTaratura).Value = True
            CP240.OPCData.items(PLCTAG_DB80_ComandoDirettoPortina).Value = True

            FrmGestioneTimer.TimerTaraturaSIWA.enabled = False
            FrmGestioneTimer.TimerTaraturaSIWA.Interval = 3000
            FrmGestioneTimer.TimerTaraturaSIWA.enabled = True

            CP240.CmdTrPesa(19).enabled = False

        Case 1  'Stop
            CodiceComandoSiwarex = 101
            Call AttivaComandoSiwarex(SiwarexRiciclatoFreddo)

            FrmGestioneTimer.TimerRitardoChiusuraPortinaSIWA.enabled = False
            FrmGestioneTimer.TimerRitardoChiusuraPortinaSIWA.Interval = 3000
            FrmGestioneTimer.TimerRitardoChiusuraPortinaSIWA.enabled = True
            FrmGestioneTimer.TimerTaraturaSIWA.enabled = False

            CP240.CmdTrPesa(19).enabled = PesaturaManuale

    End Select

End Sub


Public Sub PasswordLevel()
        
    Select Case ActiveUser
        Case UsersEnum.OPERATOR

             TxtDR5(2).enabled = True
             TxtDR5(3).enabled = True
             TxtDR3(4).enabled = True
             TxtDR3(5).enabled = True
             TxtDR3(9).enabled = True
             TxtDR3(2).enabled = True
             CmbFiltroSiwa.enabled = True
             CmdLeggiSiwa.enabled = True
             CmdInviaSiwa.enabled = True
             CmdZero.enabled = True
             CmdPesoCampione.enabled = True
             CmdAutozero.enabled = True
             CmdSalva.enabled = True
             CmdErrorQuit.enabled = True
             imgPulsanteForm(TopBarButtonEnum.Salva).enabled = True

        Case UsersEnum.ADMINISTRATOR To UsersEnum.SUPERUSER

            SSTabPara.TabVisible(1) = True
            '20160218
            LblTabPara(1).Visible = True
            LblTabPara(1 + 2).Visible = True
            '
            TxtDR5(0).enabled = True
            TxtDR5(1).enabled = True
            TxtDR5(2).enabled = True
            TxtDR5(3).enabled = True
            TxtDR3(3).enabled = True
            TxtDR3(4).enabled = True
            TxtDR3(5).enabled = True
            TxtDR3(7).enabled = True
            TxtDR3(8).enabled = True
            TxtDR3(9).enabled = True
            TxtDR3(2).enabled = True
            TxtDR3(0).enabled = True
            TxtDR3(1).enabled = True
            CmbFiltroSiwa.enabled = True
            CmbCellaSiwa.enabled = True
            CmdLeggiSiwa.enabled = True
            CmdInviaSiwa.enabled = True
            CmdZero.enabled = True
            CmdPesoCampione.enabled = True
            CmdAutozero.enabled = True
            CmdSalva.enabled = True
            CmdErrorQuit.enabled = True
            imgPulsanteForm(TopBarButtonEnum.Salva).enabled = True

        Case Else
            SSTabPara.TabVisible(1) = False
            '20160218
            LblTabPara(1).Visible = False
            LblTabPara(1 + 2).Visible = False
            '
            TxtDR5(0).enabled = False
            TxtDR5(1).enabled = False
            TxtDR5(2).enabled = False
            TxtDR5(3).enabled = False
            TxtDR3(3).enabled = False
            TxtDR3(4).enabled = False
            TxtDR3(5).enabled = False
            TxtDR3(7).enabled = False
            TxtDR3(8).enabled = False
            TxtDR3(9).enabled = False
            TxtDR3(2).enabled = False
            TxtDR3(0).enabled = False
            TxtDR3(1).enabled = False
            CmbFiltroSiwa.enabled = False
            CmbCellaSiwa.enabled = False
            CmdLeggiSiwa.enabled = False
            CmdInviaSiwa.enabled = False
            CmdZero.enabled = False
            CmdPesoCampione.enabled = False
            CmdAutozero.enabled = False
            CmdSalva.enabled = False
            CmdErrorQuit.enabled = False
            imgPulsanteForm(TopBarButtonEnum.Salva).enabled = False
    End Select

End Sub


Private Sub CmdPesoCampione_Click()
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    'Devo disabilitare la totalizzazione per poter eseguire le tarature
    CodiceComandoSiwarex = 103
    Calibrazione = True
    Call AttivaComandoSiwarex(m_bilancia)
    
    StepPesoCampione = 0
    TimerPesoCampione.enabled = False
    TimerPesoCampione.Interval = 1000
    TimerPesoCampione.enabled = True
    
    'Visualizza una progressbar di attesa X secondi
    TimerProgrssBarInvia.enabled = True
    ConteggioAttesa = 0
    TimerProgrssBarInvia.Interval = (7 + Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE) * 100

End Sub


'Totalizzazione noscosta per il momento
Private Sub CmdResetTot_Click(Index As Integer)
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    CodiceComandoSiwarex = 120
    Call AttivaComandoSiwarex(m_bilancia)
End Sub


Private Sub CmdSalva_Click()
    If IsModified Then
        Call FormToStruct
    End If
End Sub


Private Sub CmdStampa_Click()

    CmdEsci.Visible = False
    CmdStampa.Visible = False
    CmdSalva.Visible = False
    CmdHelp.Visible = False
    CmdParolaChiave.Visible = False

    'Set stampante di sefault
    Set Printer = StampanteDefault

    Me.PrintForm

    CmdEsci.Visible = True
    CmdStampa.Visible = True
    CmdSalva.Visible = True
   
    CmdHelp.Visible = True
    CmdParolaChiave.Visible = True

End Sub

Private Sub CmdZero_Click()
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    'Devo disabilitare la totalizzazione per poter eseguire le tarature
    CodiceComandoSiwarex = 103
    Calibrazione = True
    Call AttivaComandoSiwarex(m_bilancia)
        
    StepZero = 0
    TimerZero.enabled = False
    TimerZero.Interval = 1000
    TimerZero.enabled = True
    'Visualizza una progressbar di attesa X secondi
    TimerProgrssBarInvia.enabled = True
    ConteggioAttesa = 0
    TimerProgrssBarInvia.Interval = (7 + Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE) * 100

End Sub

Private Sub Form_Load()

    Dim i As Integer

    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)
    
    Call CarattereOccidentale(Me)
    
    
    Me.caption = CaptionStart + "SIWAREX FTC " + CStr(m_bilancia)
    
    CmdEsci.Picture = LoadResPicture("IDI_USCITA", vbResIcon)
    CmdEsci.ToolTipText = LoadXLSString(568)
    CmdStampa.Picture = LoadResPicture("IDI_STAMPA", vbResIcon)
    CmdStampa.ToolTipText = LoadXLSString(45)
    CmdSalva.Picture = LoadResPicture("IDI_SALVA", vbResIcon)
    CmdSalva.ToolTipText = LoadXLSString(94)
    CmdParolaChiave.Picture = LoadResPicture("IDI_PAROLACHIAVE", vbResIcon)
    CmdParolaChiave.ToolTipText = LoadXLSString(1100)
    CmdHelp.Picture = LoadResPicture("IDI_HELP", vbResIcon)
    CmdHelp.ToolTipText = LoadXLSString(110)
    CmdNastro(0).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
    CmdNastro(0).ToolTipText = LoadXLSString(707)
    CmdNastro(1).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
    CmdNastro(1).ToolTipText = LoadXLSString(708)
    CmdErrorQuit.ToolTipText = LoadXLSString(73)
    CmdZero.ToolTipText = LoadXLSString(1286)
    CmdPesoCampione.ToolTipText = LoadXLSString(1287)
    LblValoriDinSiwa.caption = LoadXLSString(1420)
    CmdInviaSiwa.ToolTipText = LoadXLSString(1425)
    CmdLeggiSiwa.ToolTipText = LoadXLSString(1426)

    For i = 0 To 1
        '20160218
        'SSTabPara.TabCaption(i) = LoadXLSString(1122 + i)
        SSTabPara.TabCaption(i) = ""
        LblTabPara(i).caption = LoadXLSString(1122 + i)
        LblTabPara(i + 2).caption = LoadXLSString(1122 + i)
        '
    Next i
    'DR3
    For i = 0 To 9
        LblDR3(i).caption = LoadXLSString(1126 + i)
    Next i

    'DR5
    For i = 0 To 3
        LblDR5(i).caption = LoadXLSString(1136 + i)
    Next i

    'DR30
    For i = 0 To 4
        LblDR30(i).caption = LoadXLSString(1142 + i)
    Next i
    
    'DR31
    LblDR31.caption = LoadXLSString(1444)
    
    'DR33
    For i = 5 To 6
        LblDR33(i).caption = LoadXLSString(1135 + i)
    Next i
    
    'CMD
    For i = 0 To 5
        LblCmdSiwa(i).caption = LoadXLSString(1147 + i)
    Next i
    For i = 6 To 7
        LblCmdSiwa(i).caption = LoadXLSString(1147 + i + 1)
    Next i
    For i = 8 To 11
        LblCmdSiwa(i).caption = LoadXLSString(1147 + i + 2)
    Next i

    SSTabPara.TabVisible(1) = False
    '20160218
    LblTabPara(1).Visible = False
    LblTabPara(1 + 2).Visible = False
    '
    Call LeggiDatiDaSiwarex(0, m_bilancia)
    FrmSiwarexPara.TimerAttesaCambioDR.enabled = True
    
    If m_bilancia = SiwarexRiciclatoFreddo Then
        FrmSiwarexPara.CmdNastro(0).enabled = PesaturaManuale And Not RAPSiwaInPesata
        FrmSiwarexPara.CmdNastro(1).enabled = PesaturaManuale And Not RAPSiwaInPesata
        FrmSiwarexPara.CmdZero.enabled = PesaturaManuale And Not RAPSiwaInPesata
        FrmSiwarexPara.CmdPesoCampione.enabled = PesaturaManuale And Not RAPSiwaInPesata
        CP240.CmdTrPesa(19).enabled = Not Me.Visible
    End If

    Call StructToForm

    Call PasswordLevel
    Call UpdatePulsantiForm

End Sub


Private Sub FormToStruct()

    With Siwarex(m_bilancia)

        'DR3
        .SIWA_DIGIT_ZERO_FILE = Null2zero(TxtDR3(0).text)
        .SIWA_DIGIT_TARATURA_FILE = Null2zero(TxtDR3(1).text)
        .SIWA_PESO_TARATURA_FILE = Null2zero(TxtDR3(2).text)
        .SIWA_MILLIVOLT_FILE = CInt(Null2zero(TxtDR3(3).text))
        .SIWA_FILTRO_FREQ_FILE = CInt(Null2zero(TxtDR3(4).text))
        .SIWA_AUTOZERO_FILE = CBool(TxtDR3(6).text)
        .SIWA_FILTRO_MEDIA_FILE = CInt(Null2zero(TxtDR3(5).text))
        .SIWA_PERC_SOTTO_ZERO_FILE = CInt(Null2zero(TxtDR3(7).text))
        .SIWA_PERC_SOPRA_ZERO_FILE = CInt(Null2zero(TxtDR3(8).text))
        .SIWA_TEMPO_CALIBRAZIONE_FILE = Null2zero(TxtDR3(9).text)

        'DR5
        .SIWA_IMPULSI_METRO_FILE = Null2zero(TxtDR5(0).text)
        .SIWA_LUNGHEZZA_FILE = Null2zero(TxtDR5(1).text)
        .SIWA_CORREZIONE_FILE = Null2zero(TxtDR5(2).text)
        .SIWA_MIN_TOTALIZING_FILE = CInt(Null2zero(TxtDR5(3).text))

    End With

    Call SiwarexScriviSuFile(m_bilancia)
    
End Sub


Private Function IsModified() As Boolean

    IsModified = True

    With Siwarex(m_bilancia)

        'DR3
        If (.SIWA_DIGIT_ZERO_FILE <> Null2zero(TxtDR3(0).text)) Then
            Exit Function
        End If
        If (.SIWA_DIGIT_TARATURA_FILE <> Null2zero(TxtDR3(1).text)) Then
            Exit Function
        End If
        If (.SIWA_PESO_TARATURA_FILE <> Null2zero(TxtDR3(2).text)) Then
            Exit Function
        End If
        If (.SIWA_MILLIVOLT_FILE <> CInt(Null2zero(TxtDR3(3).text))) Then
            Exit Function
        End If
        If (.SIWA_FILTRO_FREQ_FILE <> CInt(Null2zero(TxtDR3(4).text))) Then
            Exit Function
        End If
        If (.SIWA_FILTRO_MEDIA_FILE <> CInt(Null2zero(TxtDR3(5).text))) Then
            Exit Function
        End If
        If (.SIWA_AUTOZERO_FILE <> CBool(Null2zero(TxtDR3(6).text))) Then
            Exit Function
        End If
        If (.SIWA_PERC_SOTTO_ZERO_FILE <> CInt(Null2zero(TxtDR3(7).text))) Then
            Exit Function
        End If
        If (.SIWA_PERC_SOPRA_ZERO_FILE <> CInt(Null2zero(TxtDR3(8).text))) Then
            Exit Function
        End If
        If (.SIWA_TEMPO_CALIBRAZIONE_FILE <> Null2zero(TxtDR3(9).text)) Then
            Exit Function
        End If

        'DR5
        If (.SIWA_IMPULSI_METRO_FILE <> Null2zero(TxtDR5(0).text)) Then
            Exit Function
        End If
        If (.SIWA_LUNGHEZZA_FILE <> Null2zero(TxtDR5(1).text)) Then
            Exit Function
        End If
        If (.SIWA_CORREZIONE_FILE <> Null2zero(TxtDR5(2).text)) Then
            Exit Function
        End If
        If (.SIWA_MIN_TOTALIZING_FILE <> CInt(Null2zero(TxtDR5(3).text))) Then
            Exit Function
        End If

        'DR30
        If (.SIWA_CALIBRAZIONE_ON <> CBool(Null2zero(TxtDR30(0).text))) Then
            Exit Function
        End If
        If (.SIWA_PESO_NASTRO <> Null2zero(LblDR30Siwa(1).caption)) Then
            Exit Function
        End If
        If (.SIWA_VELOX_NASTRO <> Null2zero(LblDR30Siwa(2).caption)) Then
            Exit Function
        End If
        If (.SIWA_PORTATA_NASTRO <> Null2zero(LblDR30Siwa(3).caption)) Then
            Exit Function
        End If

    End With

    IsModified = False

End Function


Private Sub StructToForm()
    
    Dim appoggio As Double
    
    With Siwarex(m_bilancia)

        'DR3
        LblDR3Siwa(0).caption = CStr(.SIWA_DIGIT_ZERO)
        LblDR3Siwa(1).caption = CStr(.SIWA_DIGIT_TARATURA)
        LblDR3Siwa(2).caption = CStr(.SIWA_PESO_TARATURA)
        LblDR3Siwa(3).caption = CStr(.SIWA_MILLIVOLT)
        appoggio = CInt(.SIWA_FILTRO_FREQ)
        LblDR3Siwa(4).caption = CmbFiltroSiwa.list(appoggio)
        LblDR3Siwa(5).caption = CStr(.SIWA_FILTRO_MEDIA)
        
        TxtDR3(0).text = CStr(.SIWA_DIGIT_ZERO_FILE)
        TxtDR3(1).text = CStr(.SIWA_DIGIT_TARATURA_FILE)
        TxtDR3(2).text = CStr(.SIWA_PESO_TARATURA_FILE)
        TxtDR3(3).text = CStr(.SIWA_MILLIVOLT_FILE)
        TxtDR3(4).text = CStr(.SIWA_FILTRO_FREQ_FILE)
        TxtDR3(5).text = CStr(.SIWA_FILTRO_MEDIA_FILE)
        If .SIWA_AUTOZERO Then
            ShapeDR3(6).BackColor = vbGreen
            CmdAutozero.Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
            CmdAutozero.ToolTipText = LoadXLSString(708)
        Else
            ShapeDR3(6).BackColor = &H808080
            CmdAutozero.Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
            CmdAutozero.ToolTipText = LoadXLSString(707)
        End If
        TxtDR3(6).text = CStr(.SIWA_AUTOZERO_FILE)

        LblDR3Siwa(7).caption = CStr(.SIWA_PERC_SOTTO_ZERO)
        LblDR3Siwa(8).caption = CStr(.SIWA_PERC_SOPRA_ZERO)
        LblDR3Siwa(9).caption = CStr(.SIWA_TEMPO_CALIBRAZIONE)
        
        TxtDR3(7).text = CStr(.SIWA_PERC_SOTTO_ZERO_FILE)
        TxtDR3(8).text = CStr(.SIWA_PERC_SOPRA_ZERO_FILE)
        TxtDR3(9).text = CStr(.SIWA_TEMPO_CALIBRAZIONE_FILE)

        'DR5
         LblDR5Siwa(0).caption = CStr(.SIWA_IMPULSI_METRO)
         LblDR5Siwa(1).caption = CStr(.SIWA_LUNGHEZZA)
         LblDR5Siwa(2).caption = CStr(.SIWA_CORREZIONE)
         LblDR5Siwa(3).caption = CStr(.SIWA_MIN_TOTALIZING)
         
        TxtDR5(0).text = CStr(.SIWA_IMPULSI_METRO_FILE)
        TxtDR5(1).text = CStr(.SIWA_LUNGHEZZA_FILE)
        TxtDR5(2).text = CStr(.SIWA_CORREZIONE_FILE)
        TxtDR5(3).text = CStr(.SIWA_MIN_TOTALIZING_FILE)

        'DR30
        ShapeDR30(0).BackColor = IIf(.SIWA_CALIBRAZIONE_ON, vbGreen, &H808080)
        TxtDR30(0).text = CStr(.SIWA_CALIBRAZIONE_ON)
        LblDR30Siwa(1).caption = CStr(.SIWA_PESO_NASTRO)
        LblDR30Siwa(2).caption = CStr(.SIWA_VELOX_NASTRO)
        LblDR30Siwa(3).caption = CStr(.SIWA_PORTATA_NASTRO)
        'DR31
        appoggio = RoundNumber((CStr(.SIWA_AD_DIGIT_FILTERED) * 1.43 / 1000000) - 2, 2)
        If appoggio < 0 Then
            appoggio = 0
        End If
        FrmSiwarexPara.LblDR31Siwa.caption = appoggio
        
    End With
    
    CmdNastro(0).Visible = (m_bilancia = SiwarexRiciclatoFreddo)
    CmdNastro(1).Visible = (m_bilancia = SiwarexRiciclatoFreddo)
    ImgMotorTest.Visible = (m_bilancia = SiwarexRiciclatoFreddo)

End Sub

'20160218
Private Sub LblTabPara_Click(Index As Integer)
    Select Case Index
        Case 0, 2
            SSTabPara.Tab = 0
        Case 1, 3
            SSTabPara.Tab = 1
    End Select
End Sub

Private Sub TimerAttesaCambioDR_Timer()
    indiceDR = indiceDR + 1
    If indiceDR < 3 Then
        Call LeggiDatiDaSiwarex(indiceDR, m_bilancia)
    Else
        TimerAttesaCambioDR.enabled = False
    End If
End Sub


Private Sub TimerAttesaRilettura_Timer()
    If ConvertiTimer() - OraAttuale > TempoAttesaRilettura Then
        Call LeggiDatiDaSiwarex(0, m_bilancia)
        Call LeggiDatiDaSiwarex(1, m_bilancia)
        TimerAttesaRilettura.enabled = False
    End If
End Sub


Private Sub TimerDR03_Timer()
    StepDR03 = StepDR03 + 1
    CodiceComandoSiwarex = 203
    Call AttivaComandoSiwarex(m_bilancia)
    
    If StepDR03 > 2 Then
        TimerDR03.enabled = False
    End If
End Sub

Private Sub TimerDR30_Timer()
    StepDR30 = StepDR30 + 1
    CodiceComandoSiwarex = 230
    Call AttivaComandoSiwarex(m_bilancia)
    
    If StepDR30 > 2 Then
        TimerDR30.enabled = False
    End If
End Sub

Private Sub TimerEsciServiceMode_Timer()
    
    FrmGestioneTimer.TimerTaraturaSIWA.enabled = False
    If CP240.OPCData.items(PLCTAG_DO_SIWA_Batch_ModalitaTaratura).Value Then
        CP240.OPCData.items(PLCTAG_DB80_ComandoDirettoPortina).Value = False
        CP240.OPCData.items(PLCTAG_DO_SIWA_Batch_ModalitaTaratura).Value = False
    End If

    StepEsciSiwa = StepEsciSiwa + 1
    CodiceComandoSiwarex = 230
    Call AttivaComandoSiwarex(m_bilancia)
    
    If StepEsciSiwa > 2 Then
        Select Case m_bilancia
            Case 0
                If ( _
                    (ListaMotori(MotoreNastroElevatoreFreddo).presente And ListaMotori(MotoreNastroElevatoreFreddo).ritorno) Or _
                    (ListaMotori(MotoreNastroLanciatore).presente And ListaMotori(MotoreNastroLanciatore).ritorno) _
                ) Then
                    CodiceComandoSiwarex = 106
                    Call AttivaComandoSiwarex(m_bilancia)
                End If

            Case 1
                If (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) Then
                    CodiceComandoSiwarex = 106
                    Call AttivaComandoSiwarex(m_bilancia)
                End If

            Case 2
                If NumeroPredSiwarex1 > 0 Then
                    If ListaPredosatori(NumeroPredSiwarex1).motore.uscita Then
                        CodiceComandoSiwarex = 106
                        Call AttivaComandoSiwarex(m_bilancia)
                    End If
                Else
                    If ListaPredosatoriRic(0).motore.uscita Then
                        CodiceComandoSiwarex = 106
                        Call AttivaComandoSiwarex(m_bilancia)
                    End If
                End If

            Case 3
                If NumeroPredSiwarex2 > 0 Then
                    If ListaPredosatori(NumeroPredSiwarex2).motore.uscita Then
                        CodiceComandoSiwarex = 106
                        Call AttivaComandoSiwarex(m_bilancia)
                    End If
                Else
                    If ListaPredosatoriRic(1).motore.uscita Then
                        CodiceComandoSiwarex = 106
                        Call AttivaComandoSiwarex(m_bilancia)
                    End If
                End If

            Case 5
                If ListaPredosatoriRic(2).motore.uscita Then
                    CodiceComandoSiwarex = 106
                    Call AttivaComandoSiwarex(m_bilancia)
                End If
            Case 6

                If ListaPredosatoriRic(3).motore.uscita Then
                    CodiceComandoSiwarex = 106
                    Call AttivaComandoSiwarex(m_bilancia)
                End If

        End Select
        
        If StepEsciSiwa > 3 Then
            TimerEsciServiceMode.enabled = False
        
            'Comando di uscita dal servizio SIWA
            If Siwarex(m_bilancia).SIWA_STATUS_SERVICE_ON Then
                CodiceComandoSiwarex = 2
                Call AttivaComandoSiwarex(m_bilancia)
            End If
        
            MousePointer = vbNormal
        
            'Me.Hide --> R.T. se nel frattempo é stata aperta una form modale (ad es: "Conferma cambio silo di dest.")
            Unload Me
            FrmSiwarexParaVisibile = False
            Call VisualizzaBarraPulsantiCP240(True)
        End If
        
    End If
End Sub

Private Sub TimerPesoCampione_Timer()
    If CodiceComandoSiwarex = 999 Then
        Select Case StepPesoCampione
            Case 0
                CodiceComandoSiwarex = 1        'Modalità Servizio On
                StepPesoCampione = StepPesoCampione + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 1
                CodiceComandoSiwarex = 4        'Attivo l'acquisizione del peso campione
                StepPesoCampione = StepPesoCampione + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case Is <= (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 2)
                StepPesoCampione = StepPesoCampione + 1         'Attendo il tempo di calibrazione
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 3)
                CodiceComandoSiwarex = 2    'Modalità Servizio Off
                StepPesoCampione = StepPesoCampione + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 4)
                CodiceComandoSiwarex = 203      'Leggo i parametri dalla DR3
                StepPesoCampione = StepPesoCampione + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 5)
                'Mando il comando di attiva totalizzazione
                CodiceComandoSiwarex = 999
                StepZero = StepZero + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 6)
                ''Devo farlo 2 volte, 1 invia la richiesta, 2 legge i dati
                CodiceComandoSiwarex = 203      'Leggo i parametri dalla DR3
                StepZero = StepZero + 1
                TimerPesoCampione.enabled = False
                Call AttivaComandoSiwarex(m_bilancia)
        End Select
    End If
End Sub


Private Sub TimerProgrssBarLeggi_Timer()
    ConteggioAttesa = ConteggioAttesa - 1
    If ConteggioAttesa = 0 Then
        TimerProgrssBarLeggi.enabled = False
        ProgressBarInvia.Visible = True
        ProgressBarLeggi.Visible = False
        TxtStatoTrasferimento.text = ""
        TxtStatoTrasferimento.BackColor = &H8000000F
        'riabilito tutti i pulsanti del Form
        CmdSalva.enabled = True
        CmdInviaSiwa.enabled = True
        CmdLeggiSiwa.enabled = True
        CmdZero.enabled = True
        CmdPesoCampione.enabled = True
        CmdEsci.enabled = True
        CmdLog.enabled = True
        CmdHelp.enabled = True
        CmdStampa.enabled = True
        CmdAutozero.enabled = True
        CmdCommandInput.enabled = True
    Else
        ProgressBarLeggi.Value = ConteggioAttesa
    End If
End Sub


Private Sub TimerProgrssBarInvia_Timer()
    'disabilito tutti i pulsanti mentre ci sono operazioni in atto
    CmdSalva.enabled = False
    CmdInviaSiwa.enabled = False
    CmdLeggiSiwa.enabled = False
    CmdZero.enabled = False
    CmdPesoCampione.enabled = False
    CmdEsci.enabled = False
    CmdLog.enabled = False
    CmdHelp.enabled = False
    CmdStampa.enabled = False
    CmdAutozero.enabled = False
    CmdCommandInput.enabled = False

    If Calibrazione Then
        TxtStatoTrasferimento.text = LoadXLSString(1424)
    Else
        TxtStatoTrasferimento.text = LoadXLSString(1421)
    End If
    TxtStatoTrasferimento.BackColor = &HFF00&
    ConteggioAttesa = ConteggioAttesa + 1
    If ConteggioAttesa > 10 Then
        TimerProgrssBarInvia.enabled = False
        TimerAttesaRilettura.enabled = True
        TimerProgrssBarLeggi.enabled = True
        TimerProgrssBarLeggi.Interval = 400
        ProgressBarInvia.Visible = False
        ProgressBarLeggi.Visible = True
        ProgressBarLeggi.Value = 10
        OraAttuale = ConvertiTimer()
        ProgressBarInvia.Value = 0
        TxtStatoTrasferimento.text = LoadXLSString(1422)
        Calibrazione = False
    Else
        ProgressBarInvia.Value = ConteggioAttesa
    End If
End Sub


Private Sub TimerScriviDR3_Timer()
    If CodiceComandoSiwarex = 999 Then
        Select Case StepScriviDR3
            Case 0
                CodiceComandoSiwarex = 1        'Modalità Servizio On
                StepScriviDR3 = StepScriviDR3 + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 1
                CodiceComandoSiwarex = 403      'Scrivo i parametri nella DR3
                StepScriviDR3 = StepScriviDR3 + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 2
                CodiceComandoSiwarex = 2        'Modalità Servizio Off
                StepScriviDR3 = StepScriviDR3 + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 3
                CodiceComandoSiwarex = 203      'Leggo i parametri della DR3
                Call AttivaComandoSiwarex(m_bilancia)
                StepScriviDR3 = StepScriviDR3 + 1
            Case 4
                CodiceComandoSiwarex = 0
                Call AttivaComandoSiwarex(m_bilancia)
                TimerScriviDR3.enabled = False
        End Select
    End If
End Sub

Private Sub TimerScriviDR5_Timer()
    If CodiceComandoSiwarex = 999 Then
        Select Case StepScriviDR5
            Case 0
                CodiceComandoSiwarex = 1        'Modalità Servizio On
                StepScriviDR5 = StepScriviDR5 + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 1
                CodiceComandoSiwarex = 405      'Scrivo i parametri nella DR5
                StepScriviDR5 = StepScriviDR5 + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 2
                CodiceComandoSiwarex = 2        'Modalità Servizio Off
                StepScriviDR5 = StepScriviDR5 + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 3
                CodiceComandoSiwarex = 205      'Leggo i parametri della DR5
                Call AttivaComandoSiwarex(m_bilancia)
                StepScriviDR5 = StepScriviDR5 + 1
            Case 4
                CodiceComandoSiwarex = 407      'Scrivo i parametri nella DR7
                Call AttivaComandoSiwarex(m_bilancia)
                StepScriviDR5 = StepScriviDR5 + 1
            Case 5
                CodiceComandoSiwarex = 0        'Nessun comando
                Call AttivaComandoSiwarex(m_bilancia)
                TimerScriviDR5.enabled = False
            '
        End Select
    End If
End Sub

Private Sub TimerTotalizer_Timer()
    
    CodiceComandoSiwarex = 233
    Call AttivaComandoSiwarex(m_bilancia)
    StepDR33 = StepDR33 + 1
    If StepDR33 > 2 Then
        TimerTotalizer.enabled = False
    End If
    
End Sub

Private Sub TimerZero_Timer()
    
    If CodiceComandoSiwarex = 999 Then
        Select Case StepZero
            Case 0
                CodiceComandoSiwarex = 1        'Modalità Servizio On
                StepZero = StepZero + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case 1
                CodiceComandoSiwarex = 3        'Attivo lo ZERO
                StepZero = StepZero + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case Is <= (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 2)
                StepZero = StepZero + 1         'Attendo il tempo di calibrazione
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 3)
                CodiceComandoSiwarex = 2    'Modalità Servizio Off
                StepZero = StepZero + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 4)
                CodiceComandoSiwarex = 203      'Leggo i parametri dalla DR3
                StepZero = StepZero + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 5)
                'Mando il comando di attiva totalizzazione
                CodiceComandoSiwarex = 999
                StepZero = StepZero + 1
                Call AttivaComandoSiwarex(m_bilancia)
            Case (Siwarex(m_bilancia).SIWA_TEMPO_CALIBRAZIONE + 6)
                ''Devo farlo 2 volte, 1 invia la richiesta, 2 legge i dati
                CodiceComandoSiwarex = 203      'Leggo i parametri dalla DR3
                StepZero = StepZero + 1
                TimerZero.enabled = False
                Call AttivaComandoSiwarex(m_bilancia)
        End Select
    End If
    
End Sub

Private Sub TxtCommandInput_Change()
    TxtCommandInput.text = DatoCorretto(TxtCommandInput.text, 0, 0, 599, 0, 0)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub

Private Sub TxtCommandInput_LostFocus()
    TxtCommandInput.text = DatoCorretto(TxtCommandInput.text, 0, 0, 599, 0, 1)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub

Public Sub TxtDR3_Change(Index As Integer)

    Dim min As Double
    Dim max As Double
    Dim decimali As Integer
    Dim default As Double

    Select Case Index
        Case 2
            min = 0
            max = 100
            decimali = 2
            default = 10
            
        Case 3 'Combo cella
            Select Case TxtDR3(Index).text
                
                Case 1
                    CmbCellaSiwa.ListIndex = 0
                Case 2
                    CmbCellaSiwa.ListIndex = 1
                Case 4
                    CmbCellaSiwa.ListIndex = 2
                    
            End Select
            Exit Sub

        Case 4 'Combo
            CmbFiltroSiwa.ListIndex = (val(TxtDR3(Index).text))
            Exit Sub
        
        Case 5
            min = 0
            max = 250
            decimali = 0
            default = 10
        
        Case 7, 8
            min = 0
            max = 25
            decimali = 0
            default = 2
        
        Case 9
            min = 0
            max = 360
            decimali = 0
            default = 45
            
        Case Else
            Exit Sub
    End Select

    TxtDR3(Index).text = DatoCorretto(TxtDR3(Index).text, decimali, min, max, default, 0)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
    
End Sub

Public Sub TxtDR3_LostFocus(Index As Integer)

    Dim min As Double
    Dim max As Double
    Dim decimali As Integer
    Dim default As Double

    Select Case Index
        Case 2
            min = 1
            max = 100
            decimali = 2
            default = 10

        Case 3
            min = 1
            max = 4
            decimali = 2
            default = 2

        Case 5
            min = 0
            max = 250
            decimali = 0
            default = 10
        
        Case 7, 8
            min = 0
            max = 25
            decimali = 0
            default = 2
        
        Case 9
            min = 5
            max = 360
            decimali = 0
            default = 45
            
        Case Else
            Exit Sub
    End Select

    TxtDR3(Index).text = DatoCorretto(TxtDR3(Index).text, decimali, min, max, default, 1)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
    
End Sub

Public Sub TxtDR5_Change(Index As Integer)

    Dim min As Double
    Dim max As Double
    Dim decimali As Integer
    Dim default As Double

    Select Case Index
        Case 0
            min = 0
            max = 5000
            decimali = 2
            default = 5
            
        Case 1
            min = 0
            max = 50
            decimali = 2
            default = 1
            
        Case 2
            min = 0
            max = 2
            decimali = 2
            default = 1
        
        Case 3
            min = 0
            max = 500
            decimali = 0
            default = 50
            
        Case Else
            Exit Sub
            
    End Select

    TxtDR5(Index).text = DatoCorretto(TxtDR5(Index).text, decimali, min, max, default, 0)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
    
End Sub

Public Sub TxtDR5_LostFocus(Index As Integer)

    Dim min As Double
    Dim max As Double
    Dim decimali As Integer
    Dim default As Double

    Select Case Index
        Case 0
            min = 1
            max = 5000
            decimali = 2
            default = 5
            
        Case 1
            min = 0
            max = 50
            decimali = 2
            default = 1
            
        Case 2
            min = 0
            max = 2
            decimali = 2
            default = 1
        
        Case 3
            min = 0
            max = 500
            decimali = 0
            default = 50
            
        Case Else
            Exit Sub
            
    End Select

    TxtDR5(Index).text = DatoCorretto(TxtDR5(Index).text, decimali, min, max, default, 1)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
    
End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Dim buttonPressed As Integer
    
    Select Case Index
        Case TopBarButtonEnum.uscita
            
            If (IsModified) Then
                buttonPressed = ShowMsgBox(LoadXLSString(788), vbYesNoCancel, vbQuestion, -1, -1, True)
                Select Case buttonPressed
                    Case vbYes
                        Call FormToStruct
                    Case vbCancel
                        Exit Sub
                End Select
            End If
        
            'Controllo se sono in Modalità di Servizio
            CodiceComandoSiwarex = 230
            Call AttivaComandoSiwarex(m_bilancia)
            
            StepEsciSiwa = 0
            TimerEsciServiceMode.enabled = False
            TimerEsciServiceMode.Interval = 500
            TimerEsciServiceMode.enabled = True
            
            MousePointer = vbHourglass
            
            If m_bilancia = SiwarexRiciclatoFreddo Then
                CP240.CmdTrPesa(19).enabled = PesaturaManuale
            End If
        
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_PREDOSAGGIO_TARATURA_NASTRI
            
        Case TopBarButtonEnum.Salva
            If IsModified Then
                Call FormToStruct
            End If
            
        Case TopBarButtonEnum.LogExport
            Call LogExportFile
            
        Case TopBarButtonEnum.Login
            Call SendMessagetoPlus(PlusSendShowPASSWORD, 0)
            
        Case TopBarButtonEnum.Stampa
            imgPulsanteForm(TopBarButtonEnum.uscita).Visible = False
            imgPulsanteForm(TopBarButtonEnum.Help).Visible = False
            imgPulsanteForm(TopBarButtonEnum.Salva).Visible = False
            imgPulsanteForm(TopBarButtonEnum.LogExport).Visible = False
            imgPulsanteForm(TopBarButtonEnum.Login).Visible = False
            imgPulsanteForm(TopBarButtonEnum.Stampa).Visible = False

            'Set stampante di sefault
            Set Printer = StampanteDefault

            Me.PrintForm

            imgPulsanteForm(TopBarButtonEnum.uscita).Visible = True
            imgPulsanteForm(TopBarButtonEnum.Help).Visible = True
            imgPulsanteForm(TopBarButtonEnum.Salva).Visible = True
            imgPulsanteForm(TopBarButtonEnum.LogExport).Visible = True
            imgPulsanteForm(TopBarButtonEnum.Login).Visible = True
            imgPulsanteForm(TopBarButtonEnum.Stampa).Visible = True
                        
    End Select

End Sub
'


Private Sub imgPulsanteForm_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
        
    If selectedButtonIndex <> Index Then
        Call Form_MouseMove(Button, Shift, x, Y)
    End If
    
    If Not PulsanteUpd(Index) Then
        If imgPulsanteForm(Index).enabled Then
            Call LoadImmaginiPulsantePlus(Index, StatoPulsantePlus.Selected)
        Else
            Call LoadImmaginiPulsantePlus(Index, StatoPulsantePlus.Disabled)
        End If
        PulsanteUpd(Index) = True
        selectedButtonIndex = Index
    End If
    
    PulsanteUpdForm = False
    
End Sub

Private Sub imgPulsanteForm_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Call LoadImmaginiPulsantePlus(Index, pressed)

End Sub

Private Sub imgPulsanteForm_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Call LoadImmaginiPulsantePlus(Index, Selected)

End Sub


Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    
Dim indice As Integer
    
    If Not PulsanteUpdForm Then

        For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
            If PulsanteUpd(indice) Then
                If imgPulsanteForm(indice).enabled Then
                    Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
                Else
                    Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.Disabled)
                End If
                PulsanteUpd(indice) = False
            End If
        Next indice
    
        PulsanteUpdForm = True
    
    End If

End Sub


Private Sub LoadImmaginiPulsantePlus(Index As Integer, stato As StatoPulsantePlus)
Dim prefisso As String

    On Error GoTo Errore
    
'selezione prefisso nome immagine
                                                                                                                                                                                                     
    Select Case Index
        Case TopBarButtonEnum.uscita
            prefisso = "PLUS_IMG_EXIT"
        Case TopBarButtonEnum.Help
            prefisso = "PLUS_IMG_HELP"
        Case TopBarButtonEnum.Salva
            prefisso = "PLUS_IMG_SAVE"
        Case TopBarButtonEnum.Stampa
            prefisso = "PLUS_IMG_STAMPA"
        Case TopBarButtonEnum.LogExport
            prefisso = "PLUS_IMG_LOGEXPORT"
        Case TopBarButtonEnum.Login
            prefisso = "PLUS_IMG_LOGIN"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FSP-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub LogExportFile()
Dim Index As Integer
Dim nomeFile As String
Dim DataComposta As String
Dim valore As String

    If (DEMO_VERSION) Then
        Exit Sub
    End If

    nomeFile = LogPath + "LOG_COMANDI_" & Year(Date) & Format(Month(Date), "00") & Format(Day(Date), "00") & " " & Format(Hour(time), "00") & Format(Minute(time), "00") & Format(Second(time), "00") & ".txt"

    FileSetValue nomeFile, "COMANDI", "Ultimo ", CStr(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_UltimoInserito).Value)
    For Index = 0 To 99
        DataComposta = " 20" & Format(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Anno1 + Index * 7).Value, "00") & _
                        "/" & Format(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Mese1 + Index * 7).Value, "00") & _
                        "/" & Format(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Giorno1 + Index * 7).Value, "00") & _
                        " " & Format(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Ora1 + Index * 7).Value, "00") & _
                        ":" & Format(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Minuto1 + Index * 7).Value, "00") & _
                        ":" & Format(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Secondo1 + Index * 7).Value, "00")
        valore = CStr(CP240.OPCData.items(PLCTAG_SIWA_CMD_LIST_Valore1 + Index * 7).Value)
        FileSetValue nomeFile, "COMANDI", "Numero " + Format(Index + 1, "000"), DataComposta & " - COD = " & valore
    Next Index
    
    Call MsgBox(nomeFile, vbOKOnly + vbInformation, "MARINI")

End Sub


Public Sub UpdatePulsantiForm()
        
Dim indice As Integer
        
    For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
        If imgPulsanteForm(indice).enabled Then
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
        Else
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.Disabled)
        End If
    Next indice

    '20160218
    imgPulsanteForm(TopBarButtonEnum.Login).Visible = False
    '
End Sub

