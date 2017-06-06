VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmComandiCisterne 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   " MARINI - comandi cisterne"
   ClientHeight    =   10065
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9180
   ClipControls    =   0   'False
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
   Icon            =   "FrmComandiCisterne.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmComandiCisterne.frx":030A
   ScaleHeight     =   10065
   ScaleWidth      =   9180
   StartUpPosition =   1  'CenterOwner
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   360
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":1238
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":1800
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":1DB5
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":2375
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":2935
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":2F93
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":35DA
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmComandiCisterne.frx":3C30
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   10
      Left            =   4560
      TabIndex        =   25
      Top             =   4080
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   10
         Left            =   120
         TabIndex        =   51
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":4286
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Risc. linea carico emulsione"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   10
         Left            =   1005
         TabIndex        =   26
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":6BFE
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   0
         Left            =   1000
         TabIndex        =   4
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   1
      Left            =   4560
      TabIndex        =   0
      Top             =   840
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   47
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":9576
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   1
         Left            =   1000
         TabIndex        =   1
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   2
      Left            =   120
      TabIndex        =   15
      Top             =   1560
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   44
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":BEEE
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   2
         Left            =   1005
         TabIndex        =   16
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   5
      Left            =   120
      TabIndex        =   5
      Top             =   2280
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   5
         Left            =   120
         TabIndex        =   45
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":E866
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 6"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   5
         Left            =   1005
         TabIndex        =   6
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Timer TmrCmdOn 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   2280
      Top             =   0
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   9
      Left            =   120
      TabIndex        =   23
      Top             =   4080
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   9
         Left            =   120
         TabIndex        =   50
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":111DE
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Risc. linea circolazione emulsione"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   9
         Left            =   1005
         TabIndex        =   24
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   4
      Left            =   4560
      TabIndex        =   7
      Top             =   1560
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   4
         Left            =   120
         TabIndex        =   48
         Top             =   165
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":13B56
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 5"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   4
         Left            =   1000
         TabIndex        =   8
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   8
      Left            =   120
      TabIndex        =   17
      Top             =   3000
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   8
         Left            =   120
         TabIndex        =   46
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":164CE
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   8
         Left            =   1005
         TabIndex        =   18
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   7
      Left            =   4560
      TabIndex        =   11
      Top             =   2280
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   7
         Left            =   120
         TabIndex        =   49
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":18E46
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 8"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   7
         Left            =   1005
         TabIndex        =   12
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   13
      Left            =   120
      TabIndex        =   31
      Top             =   7680
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonAgitatore 
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   32
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":1B7BE
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdAgitatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Agitatore1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   0
         Left            =   1000
         TabIndex        =   33
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   15
      Left            =   120
      TabIndex        =   36
      Top             =   8400
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonAgitatore 
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   57
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":1E136
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdAgitatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Agitatore3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   2
         Left            =   1000
         TabIndex        =   37
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   17
      Left            =   120
      TabIndex        =   40
      Top             =   9120
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonAgitatore 
         Height          =   615
         Index           =   4
         Left            =   120
         TabIndex        =   59
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":20AAE
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdAgitatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Agitatore5"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   4
         Left            =   1000
         TabIndex        =   41
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   14
      Left            =   4560
      TabIndex        =   34
      Top             =   7680
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonAgitatore 
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   56
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":23426
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdAgitatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Agitatore2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   1
         Left            =   1000
         TabIndex        =   35
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   16
      Left            =   4560
      TabIndex        =   38
      Top             =   8400
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonAgitatore 
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   58
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":25D9E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdAgitatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Agitatore4"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   3
         Left            =   1000
         TabIndex        =   39
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   18
      Left            =   4560
      TabIndex        =   42
      Top             =   9120
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonAgitatore 
         Height          =   615
         Index           =   5
         Left            =   120
         TabIndex        =   60
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":28716
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdAgitatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Agitatore6"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Index           =   5
         Left            =   1000
         TabIndex        =   43
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   11
      Left            =   120
      TabIndex        =   27
      Top             =   5640
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   11
         Left            =   120
         TabIndex        =   52
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":2B08E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Risc. braccio carico emulsione"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   11
         Left            =   1005
         TabIndex        =   28
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   6
      Left            =   120
      TabIndex        =   13
      Top             =   6360
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   6
         Left            =   120
         TabIndex        =   53
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":2DA06
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 7"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   6
         Left            =   1005
         TabIndex        =   14
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   12
      Left            =   4560
      TabIndex        =   29
      Top             =   5640
      Visible         =   0   'False
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   12
         Left            =   120
         TabIndex        =   54
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":3037E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Risc. linea olio combustibile"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   12
         Left            =   1005
         TabIndex        =   30
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   3
      Left            =   4560
      TabIndex        =   9
      Top             =   6360
      Visible         =   0   'False
      Width           =   4500
      Begin VB.TextBox TxtTempMesc 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2640
         TabIndex        =   19
         Text            =   "999"
         Top             =   510
         Width           =   495
      End
      Begin AniBtn.AniPushButton APButtonCmd 
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   55
         Top             =   160
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FrmComandiCisterne.frx":32CF6
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label lblTempAttualeMesc 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF80&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3600
         TabIndex        =   22
         Top             =   510
         Width           =   495
      End
      Begin VB.Label lblSimboli 
         BackColor       =   &H00C0C0C0&
         Caption         =   ">>"
         Height          =   255
         Index           =   0
         Left            =   3240
         TabIndex        =   21
         Top             =   555
         Width           =   255
      End
      Begin VB.Label LblTemp 
         BackStyle       =   0  'Transparent
         Caption         =   "C"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   4200
         TabIndex        =   20
         Top             =   555
         Width           =   255
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Comando 4"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   500
         Index           =   3
         Left            =   1000
         TabIndex        =   10
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   7080
      Picture         =   "FrmComandiCisterne.frx":3566E
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   8205
      Picture         =   "FrmComandiCisterne.frx":35CBC
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "FrmComandiCisterne"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Const NUMCOMANDI As Integer = 13

Private Const TimeOut As Integer = 3

Private TempoComando(0 To NUMCOMANDI - 1) As Long

Private Enum TopBarButtonEnum
    uscita
    Help
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


Private Sub APButtonAgitatore_Click(Index As Integer)

Select Case APButtonAgitatore(Index).Value

    Case 1, 3
        APButtonAgitatore(Index).Value = 1
        Call InviaComandiAgitatori(Index, False)
    Case 2
        Call InviaComandiAgitatori(Index, True)
End Select

End Sub

Private Sub Form_Activate()

    If (Me.Visible) Then
        Call VisualizzaBarraPulsantiCP240(False)
    End If

End Sub


Private Sub Form_Load()

    Dim indice As Integer
    Dim stato As Boolean
    
    
    Call CarattereOccidentale(Me)

    Me.caption = CaptionStart + LoadXLSString(469)

    For indice = 0 To 10
        LblCmdVari(indice).caption = LoadXLSString(470 + indice)
    Next indice

    For indice = 0 To 7
        FrameSupp(indice).Visible = CP240.OPCDataCisterne.items(CistTAG_Pannello_ComandoAuxIncluso_1 + indice).Value
        FrameSupp(indice).enabled = CP240.OPCDataCisterne.items(CistTAG_Pannello_ComandoAuxIncluso_1 + indice).Value
    Next indice
    
   
    LblTemp.caption = LoadXLSString(725)


    For indice = 0 To NUMCOMANDI - 1

        APButtonCmd(indice).Frame = 1
        APButtonCmd(indice).Picture = LoadResPicture("IDB_MOT_SWITCH_OFF", vbResBitmap)
        APButtonCmd(indice).Frame = 2
        APButtonCmd(indice).Picture = LoadResPicture("IDB_MOT_SWITCH_ON", vbResBitmap)
        APButtonCmd(indice).Frame = 3
        APButtonCmd(indice).Picture = LoadResPicture("IDB_MOT_SWITCH_ERR", vbResBitmap)

        CmdRefresh indice

    Next indice
    
    For indice = 0 To 5
        APButtonAgitatore(indice).Frame = 1
        APButtonAgitatore(indice).Picture = LoadResPicture("IDB_MOT_SWITCH_OFF", vbResBitmap)
        APButtonAgitatore(indice).Frame = 2
        APButtonAgitatore(indice).Picture = LoadResPicture("IDB_MOT_SWITCH_ON", vbResBitmap)
        APButtonAgitatore(indice).Frame = 3
        APButtonAgitatore(indice).Picture = LoadResPicture("IDB_MOT_SWITCH_ERR", vbResBitmap)

        CmdRefresh indice
        
    Next indice
    
    For indice = 0 To 5
        FrameSupp(indice + 13).Visible = CisternaLegante(indice + 1).Agitatore
        FrameSupp(indice + 13).enabled = CisternaLegante(indice + 1).Agitatore
    Next
    
    'Aggiornamento dei valori degli interruttori
    For indice = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
        stato = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_Agitatore_Ritorno + (indice - 1) * 2).Value
        If stato = True Then
            APButtonAgitatore(indice - 1).Value = 2
        Else
            APButtonAgitatore(indice - 1).Value = 1
        End If
        LblCmdAgitatore(indice - 1).caption = LoadXLSString(1091) + " " + CStr(indice)
    Next
    TmrCmdOn.enabled = True
    
    Call PosizionaFrameSupp
    
    Call UpdatePulsantiForm
        
End Sub

Private Sub PosizionaFrameSupp()
Dim posizione As Integer
Dim indice As Integer

    FrameSupp(indice).left = 0
    
    For indice = 0 To 18

        If FrameSupp(indice).enabled = True Then

            FrameSupp(indice).top = 720 + 720 * Int(posizione / 2)
            
            If posizione And 1 Then
                FrameSupp(indice).left = 120 + 4560       'dispari
            Else
                FrameSupp(indice).left = 120              'pari
            End If
            posizione = posizione + 1
        End If
           
    Next
    
    Me.Height = 1500 + 720 * Int(posizione / 2)

End Sub

Private Sub CmdRefresh(indice As Integer)

    Dim uscita As Boolean
    Dim termica As Boolean

    LeggiDatiComandiAuxCisterneOnOff indice, uscita, termica

    If (termica) Then
        If (APButtonCmd(indice).Value <> 3) Then
            APButtonCmd(indice).Value = 3
            '   Per sicurezza tolgo il comando
            ScriviDatiComandiAuxCisterneOnOff indice, False
        End If
    ElseIf (uscita) Then
        If (APButtonCmd(indice).Value <> 2) Then
            APButtonCmd(indice).Value = 2
        End If
    Else
        If (APButtonCmd(indice).Value <> 1) Then
            APButtonCmd(indice).Value = 1
        End If
    End If

End Sub

Private Sub APButtonCmd_Click(indice As Integer)

    Select Case APButtonCmd(indice).Value

        Case 1, 3
            APButtonCmd(indice).Value = 1
            ScriviDatiComandiAuxCisterneOnOff indice, False

        Case 2
            ScriviDatiComandiAuxCisterneOnOff indice, True

    End Select

    TempoComando(indice) = ConvertiTimer()

End Sub

Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            TmrCmdOn.enabled = False
        
            FrmComandiCisterneVisibile = False
        
            Me.Hide
            Unload Me
        
            Call VisualizzaBarraPulsantiCP240(True)
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_CISTERNE_COMANDI
    End Select

End Sub

Private Sub TmrCmdOn_Timer()

    Dim indice As Integer

    For indice = 0 To NUMCOMANDI - 1

        If (TempoComando(indice) <> 0) Then
            If (ConvertiTimer() - TempoComando(indice) >= TimeOut) Then
                '   Scattato il timeout rientro nel giro standard di refresh
                TempoComando(indice) = 0
                CmdRefresh indice
            End If
        Else
            '   Nessun comando, rinfresco sempre
            CmdRefresh indice
        End If

    Next indice

End Sub

Private Sub TxtTempMesc_GotFocus()

    ComandiCisternaPid(0).lckset = True

End Sub

Private Sub TxtTempMesc_LostFocus()

    ComandiCisternaPid(0).setpoint = DatoCorretto(TxtTempMesc.text, 0, 0, 250, 150, 1)
    ComandiCisternaPid(0).lckset = False
    Call ScriviDatiPidComandiCisterne(0)

End Sub

Private Sub imgPulsanteForm_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    'Colora pulsante
        
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
    'Colora pulsante

    Call LoadImmaginiPulsantePlus(Index, pressed)

End Sub

Private Sub imgPulsanteForm_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    'Colora pulsante
    
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
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FCC-001", CStr(Err.Number) + " [" + Err.description + "]"
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

End Sub
