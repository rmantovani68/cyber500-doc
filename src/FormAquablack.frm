VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FormAquablack 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "MARINI"
   ClientHeight    =   7665
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   10695
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FormAquablack.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FormAquablack.frx":000C
   ScaleHeight     =   7665
   ScaleWidth      =   10695
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frmVelocitaPompaH2O 
      BackColor       =   &H00FFFFFF&
      Height          =   1095
      Left            =   7920
      TabIndex        =   14
      Top             =   4680
      Width           =   2775
      Begin VB.Label lblSetSpeedH2OPump 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "100.0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   1850
         TabIndex        =   18
         Top             =   635
         Width           =   855
      End
      Begin VB.Label lblSetSpeedH2OPumpDesc 
         BackStyle       =   0  'Transparent
         Caption         =   "MANUAL %"
         Height          =   375
         Left            =   120
         TabIndex        =   17
         Top             =   720
         Width           =   1695
      End
      Begin VB.Label lblActSpeedH2OPumpDesc 
         BackStyle       =   0  'Transparent
         Caption         =   "ACTUAL %"
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label lblActSpeedH2OPump 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "100.0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   400
         Left            =   1850
         TabIndex        =   15
         Top             =   175
         Width           =   855
      End
   End
   Begin VB.Frame FrameAdd 
      BackColor       =   &H00FFFFFF&
      Height          =   1425
      Index           =   4
      Left            =   8040
      TabIndex        =   10
      Top             =   960
      Width           =   840
      Begin VB.Image ImgAdditivo 
         Appearance      =   0  'Flat
         Height          =   480
         Index           =   1
         Left            =   180
         Picture         =   "FormAquablack.frx":191CE
         Stretch         =   -1  'True
         Top             =   180
         Width           =   480
      End
      Begin VB.Label lblSetPerc 
         Alignment       =   2  'Center
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9.9%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   45
         TabIndex        =   12
         Top             =   660
         Width           =   765
      End
      Begin VB.Label lblNetKg 
         Alignment       =   2  'Center
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "99,9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   45
         TabIndex        =   11
         Top             =   990
         Width           =   765
      End
   End
   Begin VB.Frame frmFlusso 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFF00&
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      ForeColor       =   &H80000008&
      Height          =   975
      Left            =   5040
      TabIndex        =   4
      Top             =   1920
      Width           =   1455
      Begin VB.Label lblFlussoH2OReal 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "99,9"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   360
         TabIndex        =   6
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblFlussoH2ODesc 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "H2O Flusso [Kg/min]"
         Height          =   495
         Left            =   0
         TabIndex        =   5
         Top             =   0
         Width           =   1455
      End
   End
   Begin VB.Frame frmPressione 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFF00&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   975
      Left            =   2800
      TabIndex        =   0
      Top             =   1920
      Width           =   1815
      Begin VB.Label lblPressioneDesc 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "H2O Pressione [bar]"
         Height          =   495
         Left            =   0
         TabIndex        =   3
         Top             =   0
         Width           =   1815
      End
      Begin VB.Label lblPressionePeak 
         Alignment       =   2  'Center
         BackColor       =   &H0000FFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "99,9"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   960
         TabIndex        =   2
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblPressioneReal 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "99,9"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   735
      End
   End
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   5160
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   36
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":19E10
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1A46E
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1AAB5
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1B10B
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1B761
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1BD29
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1C2DE
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1C89E
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1CE5E
            Key             =   "PLUS_IMG_LOGIN"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1D495
            Key             =   "PLUS_IMG_LOGIN_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1DAFF
            Key             =   "PLUS_IMG_LOGIN_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1E339
            Key             =   "PLUS_IMG_LOGIN_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1E9A1
            Key             =   "PLUS_IMG_AUTOMATICO"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1F01C
            Key             =   "PLUS_IMG_AUTOMATICO_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1F689
            Key             =   "PLUS_IMG_AUTOMATICO_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":1FD1F
            Key             =   "PLUS_IMG_AUTOMATICO_SELECTED"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":203B0
            Key             =   "PLUS_IMG_MANUALE"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":20A0D
            Key             =   "PLUS_IMG_MANUALE_GRAY"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2106A
            Key             =   "PLUS_IMG_MANUALE_PRESS"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2175D
            Key             =   "PLUS_IMG_MANUALE_SELECTED"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":21DD3
            Key             =   "PLUS_IMG_MANUTENZMOT"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":22363
            Key             =   "PLUS_IMG_MANUTENZMOT_GRAY"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":228F0
            Key             =   "PLUS_IMG_MANUTENZMOT_PRESS"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":22E80
            Key             =   "PLUS_IMG_MANUTENZMOT_SELECTED"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":23410
            Key             =   "PLUS_IMG_MOTORSTART"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":23AF8
            Key             =   "PLUS_IMG_MOTORSTART_GRAY"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":241A6
            Key             =   "PLUS_IMG_MOTORSTART_PRESS"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2488E
            Key             =   "PLUS_IMG_MOTORSTART_SELECTED"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":24F6F
            Key             =   "PLUS_IMG_MOTORSTOP"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":25663
            Key             =   "PLUS_IMG_MOTORSTOP_GRAY"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":25D27
            Key             =   "PLUS_IMG_MOTORSTOP_PRESS"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2641B
            Key             =   "PLUS_IMG_MOTORSTOP_SELECTED"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":26B0E
            Key             =   "PLUS_IMG_STOP"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2715C
            Key             =   "PLUS_IMG_STOP_GRAY"
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":277C6
            Key             =   "PLUS_IMG_STOP_PRESS"
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":27E43
            Key             =   "PLUS_IMG_STOP_SELECTED"
         EndProperty
      EndProperty
   End
   Begin AniBtn.AniPushButton APButton_cmdH2OValve 
      Height          =   615
      Left            =   1630
      TabIndex        =   21
      Top             =   2760
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1085
      _StockProps     =   111
      BackColor       =   12632256
      Picture         =   "FormAquablack.frx":284AC
      Cycle           =   1
      ButtonVersion   =   1024
   End
   Begin AniBtn.AniPushButton APButton_cmdTrikleValve 
      Height          =   615
      Left            =   3240
      TabIndex        =   22
      Top             =   5200
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1085
      _StockProps     =   111
      BackColor       =   12632256
      Picture         =   "FormAquablack.frx":2A05A
      Cycle           =   1
      ButtonVersion   =   1024
   End
   Begin AniBtn.AniPushButton APButton_cmdPurgeValve 
      Height          =   615
      Left            =   6000
      TabIndex        =   23
      Top             =   5200
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1085
      _StockProps     =   111
      BackColor       =   12632256
      Picture         =   "FormAquablack.frx":2BC08
      Cycle           =   1
      ButtonVersion   =   1024
   End
   Begin AniBtn.AniPushButton APButton_cmdH2OPump 
      Height          =   615
      Left            =   9120
      TabIndex        =   24
      Top             =   2760
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1085
      _StockProps     =   111
      BackColor       =   12632256
      Picture         =   "FormAquablack.frx":2D7B6
      Cycle           =   1
      ButtonVersion   =   1024
   End
   Begin MSComctlLib.ImageList PlusImageList1 
      Left            =   5160
      Top             =   6360
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   108
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2F364
            Key             =   "CONNECTION_OK"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2F889
            Key             =   "CONNECTION_ERR"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":2FDF6
            Key             =   "AUTO_START"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":30648
            Key             =   "MANUAL_START"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":3129A
            Key             =   "SERVICE"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAquablack.frx":31AEC
            Key             =   "AUTO_STOP"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   450
      Left            =   0
      TabIndex        =   26
      Top             =   7215
      Width           =   10695
      _ExtentX        =   18865
      _ExtentY        =   794
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   3704
            MinWidth        =   3704
            Picture         =   "FormAquablack.frx":32121
            Text            =   "PLC AQUAB"
            TextSave        =   "PLC AQUAB"
            Key             =   "CONN"
            Object.Tag             =   "STB_AQUABLACK"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   900
            MinWidth        =   900
            Picture         =   "FormAquablack.frx":32646
            Key             =   "STATUS"
            Object.Tag             =   "STB_STATOPARAM"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   9172
            MinWidth        =   9172
            Key             =   "FREE"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4938
            MinWidth        =   4938
            Text            =   "PLC Version: 1.1.0.0"
            TextSave        =   "PLC Version: 1.1.0.0"
            Key             =   "VERSION"
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblMeasU 
      AutoSize        =   -1  'True
      BackColor       =   &H00FF0000&
      BackStyle       =   0  'Transparent
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   8880
      TabIndex        =   25
      Top             =   1680
      Width           =   240
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   4
      Left            =   8280
      Picture         =   "FormAquablack.frx":32B7F
      Top             =   0
      Visible         =   0   'False
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   1200
      Picture         =   "FormAquablack.frx":331C8
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   2400
      Picture         =   "FormAquablack.frx":338AC
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   9480
      Picture         =   "FormAquablack.frx":33F84
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   3
      Left            =   7080
      Picture         =   "FormAquablack.frx":3453C
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   5
      Left            =   45
      Picture         =   "FormAquablack.frx":34B7A
      Top             =   0
      Width           =   1125
   End
   Begin VB.Label lblTipoBitume 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   600
      TabIndex        =   20
      Top             =   1440
      Width           =   495
   End
   Begin VB.Label lblTipoBitumeDesc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "BITUMEN TYPE:"
      ForeColor       =   &H00FFFFFF&
      Height          =   1215
      Left            =   120
      TabIndex        =   19
      Top             =   960
      Width           =   1695
   End
   Begin VB.Label lblMeasU 
      AutoSize        =   -1  'True
      BackColor       =   &H00FF0000&
      BackStyle       =   0  'Transparent
      Caption         =   "Kg"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   8880
      TabIndex        =   13
      Top             =   1980
      Width           =   330
   End
   Begin VB.Image imgAllarmeLivSerbatoio 
      Height          =   930
      Left            =   8400
      Picture         =   "FormAquablack.frx":351C7
      Top             =   6120
      Visible         =   0   'False
      Width           =   1200
   End
   Begin VB.Label lblPurge 
      BackStyle       =   0  'Transparent
      Caption         =   "PURGE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   4920
      TabIndex        =   9
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Label lblTrickle 
      BackStyle       =   0  'Transparent
      Caption         =   "TRIKLE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2040
      TabIndex        =   8
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Label lblValvH2O 
      BackStyle       =   0  'Transparent
      Caption         =   "H2O"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   1635
      TabIndex        =   7
      Top             =   3000
      Width           =   615
   End
   Begin VB.Image imgSerbatoio 
      Height          =   1155
      Left            =   8040
      Picture         =   "FormAquablack.frx":35A23
      Stretch         =   -1  'True
      Top             =   6000
      Width           =   1920
   End
   Begin VB.Image imgMixer 
      Height          =   1050
      Left            =   360
      Picture         =   "FormAquablack.frx":3A285
      Top             =   6120
      Width           =   1890
   End
   Begin VB.Image imgValvPurge 
      Height          =   765
      Left            =   5040
      Picture         =   "FormAquablack.frx":3C9C7
      Top             =   5160
      Width           =   765
   End
   Begin VB.Image imgValvTrickle 
      Height          =   765
      Left            =   2280
      Picture         =   "FormAquablack.frx":3D865
      Top             =   5160
      Width           =   765
   End
   Begin VB.Image imgValvH2O 
      Height          =   765
      Left            =   1680
      Picture         =   "FormAquablack.frx":3E703
      Top             =   3480
      Width           =   765
   End
   Begin VB.Image imgPompaH2O 
      Height          =   1275
      Left            =   8040
      Picture         =   "FormAquablack.frx":3F5A1
      Stretch         =   -1  'True
      Top             =   3300
      Width           =   2460
   End
   Begin VB.Image imgInjection 
      Height          =   660
      Left            =   615
      Picture         =   "FormAquablack.frx":4440F
      Top             =   3720
      Width           =   645
   End
   Begin VB.Image imgMassico 
      Height          =   1290
      Left            =   5280
      Picture         =   "FormAquablack.frx":44903
      Top             =   3045
      Width           =   930
   End
   Begin VB.Line lnInjToValveH2O 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   1200
      X2              =   1800
      Y1              =   4080
      Y2              =   4080
   End
   Begin VB.Line lnPumpToMass 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   5760
      X2              =   8040
      Y1              =   4080
      Y2              =   4080
   End
   Begin VB.Line lnInjToMixer 
      BorderColor     =   &H00800000&
      BorderWidth     =   15
      X1              =   945
      X2              =   945
      Y1              =   6480
      Y2              =   4200
   End
   Begin VB.Line lnPurgeOrr 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   4440
      X2              =   5040
      Y1              =   5760
      Y2              =   5760
   End
   Begin VB.Line lnSerbOrizz 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   7080
      X2              =   8040
      Y1              =   6600
      Y2              =   6600
   End
   Begin VB.Line lnH2OValveToMass 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   2280
      X2              =   5280
      Y1              =   4080
      Y2              =   4080
   End
   Begin VB.Line lnPurgeVert 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   4440
      X2              =   4440
      Y1              =   4080
      Y2              =   5760
   End
   Begin VB.Line lnSerbVert 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   7080
      X2              =   7080
      Y1              =   4080
      Y2              =   6600
   End
   Begin VB.Line lnBitumeToInj 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   15
      X1              =   960
      X2              =   960
      Y1              =   3840
      Y2              =   2160
   End
   Begin VB.Line lnTrickleVert 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   1440
      X2              =   1440
      Y1              =   4080
      Y2              =   5760
   End
   Begin VB.Line lnTrickleOrr 
      BorderColor     =   &H00C0C0C0&
      BorderWidth     =   10
      X1              =   1440
      X2              =   2280
      Y1              =   5760
      Y2              =   5760
   End
   Begin VB.Image imgPressostato 
      Height          =   900
      Index           =   0
      Left            =   3480
      Picture         =   "FormAquablack.frx":44F5D
      Top             =   3120
      Width           =   495
   End
End
Attribute VB_Name = "FormAquablack"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'20160512
Option Explicit

Public Enum AqTopBarButtonEnum
    TB_AQ_ESCI
    TB_AQ_START
    TB_AQ_STOP
    TB_AQ_EMERGENZA
    TB_AQ_ABOUT
    TB_AQ_MANUAL
    TBB_LAST
End Enum

Public Enum AqStatusBar
'    PlcVersion = 1
    AQPlcConnection = 1
    AQStatus
    AQFree
    AQPLCVersion
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer


Private Sub APButton_cmdH2OPump_Click()
    
    Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump = Not Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump
    
    CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_H2O_Pump).Value = Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump '20161027

End Sub

Private Sub APButton_cmdH2OValve_Click()
    
    Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv = Not Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv
        
    CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_H2O_Valv).Value = Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv '20161027

End Sub

Private Sub APButton_cmdPurgeValve_Click()

    Aquablack_HMI_PLC.FROM_HMI_Start_Purge = Not Aquablack_HMI_PLC.FROM_HMI_Start_Purge
        
    CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_Purge).Value = Aquablack_HMI_PLC.FROM_HMI_Start_Purge '20161027
                
End Sub

Private Sub APButton_cmdTrikleValve_Click()
        
    Aquablack_HMI_PLC.FROM_HMI_Start_Trickle = Not Aquablack_HMI_PLC.FROM_HMI_Start_Trickle
        
    CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_Trickle).Value = Aquablack_HMI_PLC.FROM_HMI_Start_Trickle '20161027
                
End Sub


Private Sub Form_Activate()

    Call AQ_Valvola_H2O_Change
    Call AQ_Valvola_Purge_Change
    Call AQ_Valvola_Trickle_Change
    Call AQ_Pompa_H2O_Change
    Call AQ_Auto_Mode_Change
    Call AQ_Manual_Mode_Change
    Call AQ_PLCConnection_Change
       
End Sub

Private Sub Form_Load()

'    'carica risorse
'    imgPulsanteForm(TB_AQ_ESCI).Picture = LoadResPicture("IDI_USCITA", vbResIcon)
'    imgPulsanteForm(TB_AQ_START).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
'    imgPulsanteForm(TB_AQ_STOP).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
'    imgPulsanteForm(TB_AQ_EMERGENZA).Picture = LoadResPicture("IDI_STOP", vbResIcon)
'    imgPulsanteForm(TB_AQ_ABOUT).Picture = LoadResPicture("IDI_ABOUT", vbResIcon)
'    imgPulsanteForm(TB_AQ_MANUAL).Picture = LoadResPicture("IDI_MANUALE", vbResIcon)
                      
'    cmdH2OPump(0).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
'    cmdH2OPump(1).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
'
'    cmdH2OValve(0).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
'    cmdH2OValve(1).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
'
'    cmdPurgeValve(0).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
'    cmdPurgeValve(1).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
'
'    cmdTrikleValve(0).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
'    cmdTrikleValve(1).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
    
    'Etichette
    lblFlussoH2ODesc.caption = LoadXLSString(1530)
    lblPressioneDesc.caption = LoadXLSString(1529)
    lblActSpeedH2OPumpDesc.caption = LoadXLSString(1531)
    lblSetSpeedH2OPumpDesc.caption = LoadXLSString(1532)
    lblTipoBitumeDesc = LoadXLSString(1526)
    
    'Tooltip
    imgPulsanteForm(TB_AQ_ESCI).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(TB_AQ_EMERGENZA).ToolTipText = LoadXLSString(144)
    
    lblSetPerc.ToolTipText = LoadXLSString(1525)
    lblNetKg.ToolTipText = LoadXLSString(1524)
    lblPressioneReal.ToolTipText = LoadXLSString(1529)
    lblPressionePeak.ToolTipText = LoadXLSString(1528)
    lblFlussoH2OReal.ToolTipText = LoadXLSString(1530)
    lblActSpeedH2OPump.ToolTipText = LoadXLSString(1531)
    lblSetSpeedH2OPump.ToolTipText = LoadXLSString(1532)
    lblTipoBitume.ToolTipText = LoadXLSString(1526)
                                                        
    lblMeasU(0).caption = LoadXLSString(349)
    'lblMeasU(1).caption = LoadXLSString(000)
                                                        
    'aggiornamento valori numerici
    lblPressioneReal.caption = Format(Aquablack_HMI_PLC.FromPLC_H2O_Pressure, "0.0")
    lblPressionePeak.caption = Format(Aquablack_HMI_PLC.H2O_Press_Peak, "0.0")
    lblFlussoH2OReal.caption = Format(Aquablack_HMI_PLC.FromPLC_H2O_Flow, "0.0")
    lblActSpeedH2OPump.caption = Format(Aquablack_HMI_PLC.H2OActualPumpSpeed, "0.0")
    lblSetSpeedH2OPump.caption = Format(Aquablack_HMI_PLC.FROM_HMI_ManualSpeedH2OPump, "0.0")
    lblTipoBitume.caption = Format(AquablackRecipeActual.BitumenSelection, "0")
    
    'aggiornamento grafica
'    TopBarButton(AqTopBarButtonEnum.TB_AQ_MANUAL).BackColor = IIf(AquablackStatoManuale, &HFF00&, &HC0C0C0)
    
    StatusBar1.Panels(AQPLCVersion).text = "PLC Version: " _
                                & Str(Aquablack_HMI_PLC.SW_VERSION_PLC_Major) & "." _
                                & Str(Aquablack_HMI_PLC.SW_VERSION_PLC_Minor) & "." _
                                & Str(Aquablack_HMI_PLC.SW_VERSION_PLC_Revision) & "." _
                                & Str(Aquablack_HMI_PLC.SW_VERSION_PLC_Fix)
'    sbStatusBar.Panels(PlcConnection).Picture = LoadResPicture(IIf(CP240.OPCDataAquablack.IsConnected, "IDB_PLC_CONN_OK", "IDB_PLC_CONN_ERR"))
                                                                    
End Sub

Private Sub Form_Terminate()
    Call VisualizzaBarraPulsantiCP240(True)
End Sub

Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        
        Case AqTopBarButtonEnum.TB_AQ_ESCI
            Me.Hide
            Unload Me
            Call VisualizzaBarraPulsantiCP240(True)
        Case AqTopBarButtonEnum.TB_AQ_ABOUT
            
        Case AqTopBarButtonEnum.TB_AQ_START
            Aquablack_HMI_PLC.FROM_HMI_Start = True
        Case AqTopBarButtonEnum.TB_AQ_STOP
            Aquablack_HMI_PLC.FROM_HMI_Stop = True
        Case AqTopBarButtonEnum.TB_AQ_EMERGENZA
            Aquablack_HMI_PLC.FROM_HMI_Abort = True
        Case AqTopBarButtonEnum.TB_AQ_MANUAL
            Aquablack_HMI_PLC.FROM_HMI_Manual = True
    End Select

'    AQUABTAG_FROM_HMI_Start_Purge
'    AQUABTAG_FROM_HMI_Start_Trickle
'    AQUABTAG_FROM_HMI_Start_H2O_Valv
'    AQUABTAG_FROM_HMI_Start_H2O_Pump
'    AQUABTAG_FROM_HMI_Manual
'    AQUABTAG_FROM_HMI_Start
'    AQUABTAG_FROM_HMI_Stop
'    AQUABTAG_FROM_HMI_Abort


End Sub

Private Sub lblSetSpeedH2OPump_DblClick()
    
'    Aquablack_HMI_PLC.FROM_HMI_ManualSpeedH2OPump = Format(FrmNewValue.InputDoubleValue(Me, Val(lblSetSpeedH2OPump.caption), 0, 100), "0.0")
    Aquablack_HMI_PLC.FROM_HMI_ManualSpeedH2OPump = FrmNewValue.InputDoubleValue(Me, val(lblSetSpeedH2OPump.caption), 0, 100)
    lblSetSpeedH2OPump.caption = Format(Aquablack_HMI_PLC.FROM_HMI_ManualSpeedH2OPump, "0.0")
    
End Sub


Private Sub imgPulsanteForm_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
        
    If selectedButtonIndex <> Index Then
        Call Form_MouseMove(Button, Shift, X, Y)
    End If
    
    If Not PulsanteUpd(Index) Then
        If imgPulsanteForm(Index).enabled Then
            Call LoadImmaginiPulsantePlus(Index, StatoPulsantePlus.Selected)
        Else
            Call LoadImmaginiPulsantePlus(Index, StatoPulsantePlus.disabled)
        End If
        PulsanteUpd(Index) = True
        selectedButtonIndex = Index
    End If
    
    PulsanteUpdForm = False
    
End Sub

Private Sub imgPulsanteForm_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

    Call LoadImmaginiPulsantePlus(Index, pressed)

End Sub

Private Sub imgPulsanteForm_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    Call LoadImmaginiPulsantePlus(Index, Selected)

End Sub


Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    
Dim indice As Integer

    If Not PulsanteUpdForm Then

        For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
            If PulsanteUpd(indice) Then
                If imgPulsanteForm(indice).enabled Then
                    Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
                Else
                    Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.disabled)
                End If
                PulsanteUpd(indice) = False
            End If
        Next indice
    
        PulsanteUpdForm = True
    
    End If

End Sub


Private Sub LoadImmaginiPulsantePlus(Index As Integer, Stato As StatoPulsantePlus)
Dim prefisso As String
        
    On Error GoTo Errore
                                                                   
'selezione prefisso nome immagine
                                                                                                                                                                                                     
    Select Case Index
        
        Case AqTopBarButtonEnum.TB_AQ_ESCI
            prefisso = "PLUS_IMG_EXIT"
        
        Case AqTopBarButtonEnum.TB_AQ_START
            prefisso = "PLUS_IMG_MOTORSTART"
        
        Case AqTopBarButtonEnum.TB_AQ_STOP
            prefisso = "PLUS_IMG_MOTORSTOP"
        
        Case AqTopBarButtonEnum.TB_AQ_EMERGENZA
            prefisso = "PLUS_IMG_STOP"
        
        Case AqTopBarButtonEnum.TB_AQ_MANUAL
            prefisso = "PLUS_IMG_MANUALE"
        
        Case Else
            Exit Sub
    
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(Stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FAM-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub UpdatePulsantiForm()
        
Dim indice As Integer
        
    For indice = 0 To (AqTopBarButtonEnum.TBB_LAST - 1)
        If imgPulsanteForm(indice).enabled Then
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
        Else
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.disabled)
        End If
    Next indice

End Sub

