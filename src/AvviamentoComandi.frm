VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form AvvComandi 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PLCTAG_DO_VibratoreP1"
   ClientHeight    =   9420
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   13800
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "AvviamentoComandi .frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "AvviamentoComandi .frx":030A
   ScaleHeight     =   9420
   ScaleWidth      =   13800
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   360
      Top             =   240
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
            Picture         =   "AvviamentoComandi .frx":8A04C
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8A614
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8ABC9
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8B189
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8B749
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8BDA7
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8C3EE
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoComandi .frx":8CA44
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   29
      Left            =   9240
      TabIndex        =   64
      Top             =   8520
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   29
         Left            =   120
         TabIndex        =   93
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":8D09A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   29
         Left            =   1005
         TabIndex        =   65
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   28
      Left            =   9240
      TabIndex        =   62
      Top             =   7680
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   28
         Left            =   120
         TabIndex        =   92
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":8FA12
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   28
         Left            =   1005
         TabIndex        =   63
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   27
      Left            =   9240
      TabIndex        =   60
      Top             =   6840
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   27
         Left            =   120
         TabIndex        =   91
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":9238A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   27
         Left            =   1005
         TabIndex        =   61
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   26
      Left            =   9240
      TabIndex        =   58
      Top             =   6000
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   26
         Left            =   120
         TabIndex        =   90
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":94D02
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   26
         Left            =   1005
         TabIndex        =   59
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   25
      Left            =   9240
      TabIndex        =   56
      Top             =   5160
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   25
         Left            =   120
         TabIndex        =   89
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":9767A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   25
         Left            =   1005
         TabIndex        =   57
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   24
      Left            =   9240
      TabIndex        =   54
      Top             =   4320
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   24
         Left            =   120
         TabIndex        =   88
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":99FF2
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   24
         Left            =   1005
         TabIndex        =   55
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   23
      Left            =   9240
      TabIndex        =   52
      Top             =   3480
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   23
         Left            =   120
         TabIndex        =   87
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":9C96A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   23
         Left            =   1005
         TabIndex        =   53
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   22
      Left            =   9240
      TabIndex        =   50
      Top             =   2640
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   22
         Left            =   120
         TabIndex        =   86
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":9F2E2
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   22
         Left            =   1005
         TabIndex        =   51
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   21
      Left            =   9240
      TabIndex        =   48
      Top             =   1800
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   21
         Left            =   120
         TabIndex        =   85
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":A1C5A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   21
         Left            =   1005
         TabIndex        =   49
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   20
      Left            =   9240
      TabIndex        =   46
      Top             =   960
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   20
         Left            =   120
         TabIndex        =   84
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":A45D2
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   20
         Left            =   1005
         TabIndex        =   47
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   19
      Left            =   4680
      TabIndex        =   44
      Top             =   8520
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   19
         Left            =   120
         TabIndex        =   83
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":A6F4A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   19
         Left            =   1005
         TabIndex        =   45
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   18
      Left            =   4680
      TabIndex        =   42
      Top             =   7680
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   18
         Left            =   120
         TabIndex        =   82
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":A98C2
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   18
         Left            =   1005
         TabIndex        =   43
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   17
      Left            =   4680
      TabIndex        =   40
      Top             =   6840
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   17
         Left            =   120
         TabIndex        =   81
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":AC23A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   17
         Left            =   1005
         TabIndex        =   41
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   16
      Left            =   4680
      TabIndex        =   38
      Top             =   6000
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   16
         Left            =   120
         TabIndex        =   80
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":AEBB2
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   16
         Left            =   1005
         TabIndex        =   39
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   15
      Left            =   4680
      TabIndex        =   36
      Top             =   5160
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   15
         Left            =   120
         TabIndex        =   79
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":B152A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   15
         Left            =   1005
         TabIndex        =   37
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   14
      Left            =   4680
      TabIndex        =   34
      Top             =   4320
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   14
         Left            =   120
         TabIndex        =   78
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":B3EA2
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   14
         Left            =   1005
         TabIndex        =   35
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   13
      Left            =   4680
      TabIndex        =   32
      Top             =   3480
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   13
         Left            =   120
         TabIndex        =   77
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":B681A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   13
         Left            =   1005
         TabIndex        =   33
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   12
      Left            =   4680
      TabIndex        =   30
      Top             =   2640
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   12
         Left            =   120
         TabIndex        =   76
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":B9192
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   12
         Left            =   1005
         TabIndex        =   31
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   11
      Left            =   4680
      TabIndex        =   28
      Top             =   1800
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   11
         Left            =   120
         TabIndex        =   75
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":BBB0A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   11
         Left            =   1005
         TabIndex        =   29
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   10
      Left            =   4680
      TabIndex        =   26
      Top             =   960
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   10
         Left            =   120
         TabIndex        =   74
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":BE482
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "DISPONIBILE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   10
         Left            =   1005
         TabIndex        =   27
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   1
      Left            =   120
      TabIndex        =   2
      Top             =   1800
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   3
         Top             =   140
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":C0DFA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Spruzzatura Antiadesivo Navetta"
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
         TabIndex        =   4
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   3
      Left            =   120
      TabIndex        =   10
      Top             =   3480
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   67
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":C3772
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Soffio Aria Silo Filler Apporto"
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
         TabIndex        =   11
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   4
      Left            =   120
      TabIndex        =   8
      Top             =   4320
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   4
         Left            =   120
         TabIndex        =   68
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":C60EA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Soffio Aria Silo Filler Apporto 2"
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
         TabIndex        =   9
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   8
      Left            =   120
      TabIndex        =   14
      Top             =   7680
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   8
         Left            =   120
         TabIndex        =   72
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":C8A62
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Deumidificatore 2 APP."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   8
         Left            =   1005
         TabIndex        =   15
         Top             =   180
         Width           =   2400
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   9
      Left            =   120
      TabIndex        =   18
      Top             =   8520
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   9
         Left            =   120
         TabIndex        =   73
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":CB3DA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Deumidificatore 3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   525
         Index           =   9
         Left            =   1005
         TabIndex        =   19
         Top             =   180
         Width           =   3375
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   5
      Left            =   120
      TabIndex        =   0
      Top             =   5160
      Width           =   4500
      Begin VB.TextBox TxtTempoVibrCaricoFApp 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   3360
         TabIndex        =   24
         Text            =   "30"
         Top             =   480
         Width           =   495
      End
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   5
         Left            =   120
         TabIndex        =   69
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":CDD52
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblTempoRimastoVibrCaricoFApp 
         BackColor       =   &H0080FF80&
         Caption         =   "-59"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3900
         TabIndex        =   25
         Top             =   525
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Vibratore Carico Filler Apporto"
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
         TabIndex        =   1
         Top             =   180
         Width           =   3345
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   6
      Left            =   120
      TabIndex        =   20
      Top             =   6000
      Width           =   4500
      Begin VB.TextBox TxtTempoVibrCaricoFApp2 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   3360
         TabIndex        =   22
         Text            =   "30"
         Top             =   480
         Width           =   495
      End
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   6
         Left            =   120
         TabIndex        =   70
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":D06CA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblTempoRimastoVibrCaricoFApp2 
         BackColor       =   &H0080FF80&
         Caption         =   "-59"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3900
         TabIndex        =   23
         Top             =   525
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Vibratore Carico Filler Apporto 2"
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
         Index           =   6
         Left            =   1005
         TabIndex        =   21
         Top             =   180
         Width           =   3345
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   0
      Left            =   120
      TabIndex        =   5
      Top             =   960
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   6
         Top             =   140
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":D3042
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Spruzzatura Antiadesivo Benna"
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
         TabIndex        =   7
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   2
      Left            =   120
      TabIndex        =   12
      Top             =   2640
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   66
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":D59BA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         BackStyle       =   0  'Transparent
         Caption         =   "Soffio Aria Silo Filler Recupero"
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
         Left            =   1000
         TabIndex        =   13
         Top             =   180
         Width           =   3350
      End
   End
   Begin VB.Frame FrameSupp 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   7
      Left            =   120
      TabIndex        =   16
      Top             =   6840
      Width           =   4500
      Begin AniBtn.AniPushButton APButtonCmdVari 
         Height          =   615
         Index           =   7
         Left            =   120
         TabIndex        =   71
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   -2147483633
         Picture         =   "AvviamentoComandi .frx":D8332
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCmdVari 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Deumidificatore 1 REC."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   7
         Left            =   1005
         TabIndex        =   17
         Top             =   180
         Width           =   2415
      End
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   12645
      Picture         =   "AvviamentoComandi .frx":DACAA
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   11520
      Picture         =   "AvviamentoComandi .frx":DB262
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "AvvComandi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private NumeroFrameVisibili As Integer

Private Enum TopBarButtonEnum
    uscita
    Help
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


Private Sub CmdEsci_Click()

    Me.Hide
    Unload Me

    Call VisualizzaBarraPulsantiCP240(True)
    
End Sub

Private Sub CmdHelp_Click()

    VisualizzaHelp Me, HELP_MOTORI_COMANDI
    
End Sub

Private Sub Form_Activate()

    If (Me.Visible) Then
        Call VisualizzaBarraPulsantiCP240(False)
    End If
    
End Sub

Private Sub Form_Load()
    'Dim pp As Integer
    Dim comando As ComandiVariEnum
    
    Call CarattereOccidentale(Me)
    
    Me.caption = CaptionStart + LoadXLSString(41)
    
    NumeroFrameVisibili = 0
    
    imgPulsanteForm(0).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(1).ToolTipText = LoadXLSString(110)

    'Preparazione form
    For comando = 0 To NumComandiVari - 1
        FrameSupp(comando).Visible = ListaComandi(comando).presente
        LblCmdVari(comando).caption = ListaComandi(comando).Descrizione
        If ListaComandi(comando).presente Then
            NumeroFrameVisibili = NumeroFrameVisibili + 1
        End If
    
    Next comando
    
    'Assegnazione dei valori ai comandi
    For comando = 0 To NumComandiVari - 1
        If ListaComandi(comando).presente Then
            If (ListaComandi(comando).uscita) Then
                If (ListaComandi(comando).ritornoComAux) Then
                    APButtonCmdVari(comando).Value = 2
                End If
            Else
                If (ListaComandi(comando).ritornoComAux) Then
                    APButtonCmdVari(comando).Value = 3
                End If
            End If
        End If
    Next comando

    TxtTempoVibrCaricoFApp.Visible = (ListaComandi(ComandoVibratoreSiloFillerApporto).presente And AbilitaTempoVibrCaricoFApp)
    TxtTempoVibrCaricoFApp.text = CStr(SetVibrCaricoFApp)
    TxtTempoVibrCaricoFApp2.Visible = (ListaComandi(ComandoVibratoreSiloFillerApporto2).presente And AbilitaTempoVibrCaricoFApp2)
    TxtTempoVibrCaricoFApp2.text = CStr(SetVibrCaricoFApp2)

    Call PosizionaFrameSupp
    
    Call UpdatePulsantiForm

    AvvComandi.TxtTempoVibrCaricoFApp.enabled = Not FrmGestioneTimer.TimerVibrCaricoFApp.enabled
    AvvComandi.TxtTempoVibrCaricoFApp2.enabled = Not FrmGestioneTimer.TimerVibrCaricoFApp2.enabled
    AvvComandi.TxtTempoVibrCaricoFApp.enabled = Not FrmGestioneTimer.TimerVibrCaricoFApp.enabled
    AvvComandi.TxtTempoVibrCaricoFApp2.enabled = Not FrmGestioneTimer.TimerVibrCaricoFApp2.enabled

    SetStartUpPosition Me, 0

End Sub

Private Sub PosizionaFrameSupp()

    Dim indice As Integer
    Dim posizioneAlto As Integer

    posizioneAlto = 960

    For indice = 0 To NumComandiVari - 1
        If ListaComandi(indice).presente Then
            FrameSupp(indice).top = posizioneAlto
            posizioneAlto = posizioneAlto + 840
            If (indice < 11) Then   '20150616 Filler2 Sacchi
                FrameSupp(indice).left = 120   '20150616 Filler2 Sacchi
            End If   '20150616 Filler2 Sacchi
        End If
    Next indice
    

    If NumeroFrameVisibili < 11 Then
        Me.width = 4800

    ElseIf NumeroFrameVisibili < 21 Then
        Me.width = 9300

    Else
        Me.width = 13900

    End If

    Me.Height = posizioneAlto + (FrameSupp(0).Height / 2) + 150
    
    For indice = (TopBarButtonEnum.TBB_LAST - 1) To 0 Step -1
        Select Case indice
            Case TopBarButtonEnum.Help, TopBarButtonEnum.uscita
            'qui i pulsanti da allineare a destra
                imgPulsanteForm(indice).left = Me.width - (imgPulsanteForm(indice).width * (indice + 1))
        End Select
    Next indice
    
End Sub

Private Sub APButtonCmdVari_Click(Index As Integer)

    Call GestioneBottoniCmdVari(Index, True)

End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            Me.Hide
            Unload Me
            Call VisualizzaBarraPulsantiCP240(True)
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_MOTORI_COMANDI
    End Select

End Sub
'

Private Sub TxtTempoVibrCaricoFApp_Change()

    TxtTempoVibrCaricoFApp.text = DatoCorretto(TxtTempoVibrCaricoFApp, 0, 0, 999, 30)
    ErroreDatoParametri = False

    SetVibrCaricoFApp = TxtTempoVibrCaricoFApp.text

End Sub

Private Sub TxtTempoVibrCaricoFApp2_Change()

    TxtTempoVibrCaricoFApp2.text = DatoCorretto(TxtTempoVibrCaricoFApp2, 0, 0, 999, 30)
    ErroreDatoParametri = False

    SetVibrCaricoFApp2 = TxtTempoVibrCaricoFApp2.text

End Sub


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
    
    On Error GoTo ERRORE
                                                                   
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
ERRORE:
    LogInserisci True, "FAC-001", CStr(Err.Number) + " [" + Err.description + "]"
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

