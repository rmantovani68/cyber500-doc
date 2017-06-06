VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmStatoPredosatori 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Stato predosatori"
   ClientHeight    =   7515
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   16560
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
   Picture         =   "FrmStatoPredosatore.frx":0000
   ScaleHeight     =   7515
   ScaleWidth      =   16560
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "13"
      Height          =   1280
      Index           =   12
      Left            =   8280
      TabIndex        =   148
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   12
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   151
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   12
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   150
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   12
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   149
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   12
         Left            =   100
         TabIndex        =   153
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   12
         Left            =   960
         TabIndex        =   152
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "14"
      Height          =   1280
      Index           =   13
      Left            =   10320
      TabIndex        =   142
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   13
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   145
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   13
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   144
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   13
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   143
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   13
         Left            =   960
         TabIndex        =   147
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   13
         Left            =   100
         TabIndex        =   146
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "15"
      Height          =   1280
      Index           =   14
      Left            =   12360
      TabIndex        =   136
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   14
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   139
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   14
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   138
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   14
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   137
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   14
         Left            =   100
         TabIndex        =   141
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   14
         Left            =   960
         TabIndex        =   140
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "16"
      Height          =   1280
      Index           =   15
      Left            =   14400
      TabIndex        =   130
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   15
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   133
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   15
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   132
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   15
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   131
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   15
         Left            =   960
         TabIndex        =   135
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   15
         Left            =   100
         TabIndex        =   134
         Top             =   840
         Width           =   795
      End
   End
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   240
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
            Picture         =   "FrmStatoPredosatore.frx":168B
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":1C53
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":2208
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":27C8
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":2D88
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":33E6
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":3A2D
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmStatoPredosatore.frx":4083
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 8"
      Height          =   1280
      Index           =   27
      Left            =   7680
      TabIndex        =   122
      Top             =   5760
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   27
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   126
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   27
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   125
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   27
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   124
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   27
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   123
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   27
         Left            =   220
         TabIndex        =   128
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   27
         Left            =   1420
         TabIndex        =   127
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 7"
      Height          =   1280
      Index           =   26
      Left            =   5160
      TabIndex        =   115
      Top             =   5760
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   26
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   119
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   26
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   118
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   26
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   117
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   26
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   116
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   26
         Left            =   220
         TabIndex        =   121
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   26
         Left            =   1420
         TabIndex        =   120
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 6"
      Height          =   1280
      Index           =   25
      Left            =   2640
      TabIndex        =   108
      Top             =   5760
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   25
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   112
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   25
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   111
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   25
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   110
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   25
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   109
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   25
         Left            =   220
         TabIndex        =   114
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   25
         Left            =   1420
         TabIndex        =   113
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 5"
      Height          =   1280
      Index           =   24
      Left            =   120
      TabIndex        =   101
      Top             =   5760
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   24
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   105
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   24
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   104
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   24
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   103
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   24
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   102
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   24
         Left            =   220
         TabIndex        =   107
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   24
         Left            =   1420
         TabIndex        =   106
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 4"
      Height          =   1280
      Index           =   23
      Left            =   7680
      TabIndex        =   94
      Top             =   4320
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   23
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   98
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   23
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   97
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   23
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   96
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   23
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   95
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   23
         Left            =   220
         TabIndex        =   100
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   23
         Left            =   1420
         TabIndex        =   99
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 3"
      Height          =   1280
      Index           =   22
      Left            =   5160
      TabIndex        =   87
      Top             =   4320
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   22
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   91
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   22
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   90
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   22
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   89
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   22
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   88
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   22
         Left            =   220
         TabIndex        =   93
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   22
         Left            =   1420
         TabIndex        =   92
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 2"
      Height          =   1280
      Index           =   21
      Left            =   2640
      TabIndex        =   80
      Top             =   4320
      Width           =   2440
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   21
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   84
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   21
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   83
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   21
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   82
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   21
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   81
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   21
         Left            =   220
         TabIndex        =   86
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   21
         Left            =   1420
         TabIndex        =   85
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "12"
      Height          =   1280
      Index           =   11
      Left            =   6240
      TabIndex        =   72
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   11
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   75
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   11
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   74
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   11
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   73
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   11
         Left            =   100
         TabIndex        =   77
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   11
         Left            =   960
         TabIndex        =   76
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "11"
      Height          =   1280
      Index           =   10
      Left            =   4200
      TabIndex        =   66
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   10
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   69
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   10
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   68
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   10
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   67
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   10
         Left            =   960
         TabIndex        =   71
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   10
         Left            =   100
         TabIndex        =   70
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "10"
      Height          =   1280
      Index           =   9
      Left            =   2160
      TabIndex        =   60
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   9
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   63
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   9
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   62
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   9
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   61
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   9
         Left            =   100
         TabIndex        =   65
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   9
         Left            =   960
         TabIndex        =   64
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "9"
      Height          =   1280
      Index           =   8
      Left            =   120
      TabIndex        =   54
      Top             =   2520
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   8
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   57
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   8
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   56
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   8
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   55
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   8
         Left            =   960
         TabIndex        =   59
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   8
         Left            =   100
         TabIndex        =   58
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "8"
      Height          =   1280
      Index           =   7
      Left            =   14400
      TabIndex        =   48
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   7
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   51
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   7
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   50
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   7
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   49
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   7
         Left            =   100
         TabIndex        =   53
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   7
         Left            =   960
         TabIndex        =   52
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "7"
      Height          =   1280
      Index           =   6
      Left            =   12360
      TabIndex        =   42
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   6
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   45
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   6
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   44
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   6
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   43
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   6
         Left            =   960
         TabIndex        =   47
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   6
         Left            =   100
         TabIndex        =   46
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "6"
      Height          =   1280
      Index           =   5
      Left            =   10320
      TabIndex        =   36
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   5
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   39
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   5
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   38
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   5
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   37
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   5
         Left            =   960
         TabIndex        =   41
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   5
         Left            =   100
         TabIndex        =   40
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "5"
      Height          =   1280
      Index           =   4
      Left            =   8280
      TabIndex        =   30
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   4
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   33
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   4
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   32
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   4
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   31
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   4
         Left            =   100
         TabIndex        =   35
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   4
         Left            =   960
         TabIndex        =   34
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "4"
      Height          =   1280
      Index           =   3
      Left            =   6240
      TabIndex        =   24
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   3
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   27
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   3
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   26
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   3
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   25
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   3
         Left            =   960
         TabIndex        =   29
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   3
         Left            =   100
         TabIndex        =   28
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "3"
      Height          =   1280
      Index           =   2
      Left            =   4200
      TabIndex        =   18
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   2
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   21
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   2
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   20
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   2
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   2
         Left            =   100
         TabIndex        =   23
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   2
         Left            =   960
         TabIndex        =   22
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "2"
      Height          =   1280
      Index           =   1
      Left            =   2160
      TabIndex        =   12
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   1
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   1
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   14
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   1
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   1
         Left            =   960
         TabIndex        =   17
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   1
         Left            =   100
         TabIndex        =   16
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.CommandButton CmdHelp 
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
      Left            =   7200
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   240
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato 1"
      Height          =   1280
      Index           =   20
      Left            =   120
      TabIndex        =   6
      Top             =   4320
      Width           =   2440
      Begin VB.CommandButton cmdSoffio 
         Height          =   550
         Index           =   20
         Left            =   1830
         Style           =   1  'Graphical
         TabIndex        =   79
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   20
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   78
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   20
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   20
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   20
         Left            =   1420
         TabIndex        =   10
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   20
         Left            =   220
         TabIndex        =   9
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.Frame FramePredosatore 
      BackColor       =   &H00FFFFFF&
      Caption         =   "1"
      Height          =   1280
      Index           =   0
      Left            =   120
      TabIndex        =   1
      Top             =   1080
      Width           =   1850
      Begin VB.CommandButton cmdVibratore 
         Height          =   550
         Index           =   0
         Left            =   1230
         Style           =   1  'Graphical
         TabIndex        =   129
         Top             =   240
         Width           =   550
      End
      Begin VB.CommandButton cmdPonderale 
         Height          =   550
         Index           =   0
         Left            =   630
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   240
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdRitardato 
         Height          =   550
         Index           =   0
         Left            =   40
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   240
         Width           =   550
      End
      Begin VB.Label LblSet 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XX %"
         ForeColor       =   &H8000000E&
         Height          =   345
         Index           =   0
         Left            =   100
         TabIndex        =   5
         Top             =   840
         Width           =   795
      End
      Begin VB.Label LblStato 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX sec"
         ForeColor       =   &H00000000&
         Height          =   345
         Index           =   0
         Left            =   960
         TabIndex        =   4
         Top             =   840
         Width           =   795
      End
   End
   Begin VB.CommandButton CmdEsci 
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
      Left            =   6480
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   240
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.Timer TmrRefresh 
      Enabled         =   0   'False
      Interval        =   250
      Left            =   8160
      Top             =   240
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   1
      Left            =   13800
      Picture         =   "FrmStatoPredosatore.frx":46D9
      Top             =   15
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   15000
      Picture         =   "FrmStatoPredosatore.frx":4D27
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "FrmStatoPredosatori"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private FlashTime As Long
Private FlashColorOn As Boolean

Private Enum TopBarButtonEnum
    uscita
    Help
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer


Private Sub VisualizzaRitardato(ByRef Pred As PredosatoreType)

    Dim controllo As Integer

    With Pred

        controllo = .progressivo
        If (.riciclato) Then
            controllo = controllo + 20
        End If

        CmdRitardato(controllo).Picture = LoadResPicture(IIf(.immediato, "IDI_IMMEDIATO", "IDI_RITARDATO"), vbResIcon)

    End With

End Sub


Private Sub RitardatoOnOff(ByRef Pred As PredosatoreType)

    With Pred

        .immediato = (Not .immediato)

        Call VisualizzaRitardato(Pred)

    End With

End Sub


Private Sub CmdRitardato_Click(Index As Integer)

    If (Index < 20) Then
        RitardatoOnOff ListaPredosatori(Index)
    Else
        RitardatoOnOff ListaPredosatoriRic(Index - 20)
    End If

End Sub


Private Sub VisualizzaPonderale(ByRef Pred As PredosatoreType)

    Dim controllo As Integer

    With Pred

        controllo = .progressivo
        If (.riciclato) Then
            controllo = controllo + 20
        End If

        If (Not .ponderaleAttivo) Then '.motore.uscita And
            cmdPonderale(controllo).Picture = LoadResPicture("IDI_PONDERALEOFF", vbResIcon)
        Else
            cmdPonderale(controllo).Picture = LoadResPicture("IDI_PONDERALEON", vbResIcon)
        End If

    End With

End Sub


Public Sub AggiornaVolumetricoPonderale()

    Dim predosatore As Integer

    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        VisualizzaPonderale ListaPredosatori(predosatore)
    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        VisualizzaPonderale ListaPredosatoriRic(predosatore)
    Next predosatore

End Sub


Private Sub PonderaleOnOff(ByRef Pred As PredosatoreType)

    With Pred

        Call PredosatoreInVolumetrico(.riciclato, .progressivo, Not .ponderaleAttivo)

    End With

End Sub


Private Sub CmdPonderale_Click(Index As Integer)

    If (Index < 20) Then
        PonderaleOnOff ListaPredosatori(Index)
    Else
        PonderaleOnOff ListaPredosatoriRic(Index - 20)
    End If

End Sub


Public Sub ShowMe(Modo As Integer, ByRef parent As Form)

    FrmStatoPredosatoriVisibile = True
    Me.Show Modo, parent

End Sub


Private Sub cmdSoffio_Click(Index As Integer)
    If ListaPredosatoriRic(Index - 20).abilitazioneSoffio = False Then
        ListaPredosatoriRic(Index - 20).abilitazioneSoffio = True
        GestioneVibratoriESoffi Index - 20, True
    Else
        ListaPredosatoriRic(Index - 20).abilitazioneSoffio = False
        ListaPredosatoriRic(Index - 20).soffioAbilitato = False
    End If
    Call VisualizzaSoffio(ListaPredosatoriRic(Index - 20))
End Sub


Private Sub cmdVibratore_Click(Index As Integer)

    If Index < 20 Then
        If ListaPredosatori(Index).abilitazioneVibratore = False Then
            ListaPredosatori(Index).abilitazioneVibratore = True
            GestioneVibratoriESoffi Index, False
        Else
            ListaPredosatori(Index).abilitazioneVibratore = False
            ListaPredosatori(Index).vibratoreAbilitato = False
        End If
        Call VisualizzaVibratore(ListaPredosatori(Index))
    Else
        If ListaPredosatoriRic(Index - 20).abilitazioneVibratore = False Then
            ListaPredosatoriRic(Index - 20).abilitazioneVibratore = True
            GestioneVibratoriESoffi Index - 20, True
        Else
            ListaPredosatoriRic(Index - 20).abilitazioneVibratore = False
            ListaPredosatoriRic(Index - 20).vibratoreAbilitato = False
        End If
        Call VisualizzaVibratore(ListaPredosatoriRic(Index - 20))
    End If
End Sub

'
Private Sub Form_Load()

    Dim predosatore As Integer

    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)
    
    Me.caption = CaptionStart + LoadXLSString(923)

    CmdEsci.Picture = LoadResPicture("IDI_USCITA", vbResIcon)
    CmdEsci.ToolTipText = LoadXLSString(568)
    CmdHelp.Picture = LoadResPicture("IDI_HELP", vbResIcon)
    CmdHelp.ToolTipText = LoadXLSString(110)

    For predosatore = 0 To MAXPREDOSATORI - 1
        
        FramePredosatore(predosatore).caption = PredosatoreOttieniNome(ListaPredosatori(predosatore))
        FramePredosatore(predosatore).Visible = (predosatore < NumeroPredosatoriInseriti)
        cmdVibratore(predosatore).Visible = ListaPredosatori(predosatore).vibratorePresente
        cmdPonderale(predosatore).Visible = ListaPredosatori(predosatore).bilanciaPresente
        Call VisualizzaRitardato(ListaPredosatori(predosatore))
        Call VisualizzaPonderale(ListaPredosatori(predosatore))
        Call VisualizzaVibratore(ListaPredosatori(predosatore))

    Next predosatore

    For predosatore = 0 To MAXPREDOSATORIRICICLATO - 1
        
        FramePredosatore(20 + predosatore).caption = PredosatoreOttieniNome(ListaPredosatoriRic(predosatore))
        FramePredosatore(20 + predosatore).Visible = (predosatore < NumeroPredosatoriRicInseriti)
        cmdPonderale(20 + predosatore).Visible = ListaPredosatoriRic(predosatore).bilanciaPresente
        cmdVibratore(20 + predosatore).Visible = ListaPredosatoriRic(predosatore).vibratorePresente
        cmdSoffio(20 + predosatore).Visible = ListaPredosatoriRic(predosatore).soffioPresente
        Call VisualizzaVibratore(ListaPredosatoriRic(predosatore))
        Call VisualizzaSoffio(ListaPredosatoriRic(predosatore))
        Call VisualizzaRitardato(ListaPredosatoriRic(predosatore))
        Call VisualizzaPonderale(ListaPredosatoriRic(predosatore))

    Next predosatore

    Rinfresca
    
    Call SistemaFramePredosatori

    TmrRefresh.enabled = True

End Sub


Private Sub VisualizzaVibratore(ByRef Pred As PredosatoreType)

    Dim controllo As Integer

    With Pred

        controllo = .progressivo
        If (.riciclato) Then
            controllo = controllo + 20
        End If

        cmdVibratore(controllo).Picture = LoadResPicture(IIf(.abilitazioneVibratore, "IDB_VIBRATOREON", "IDB_VIBRATORE"), vbResBitmap)

    End With

End Sub


Private Sub VisualizzaSoffio(ByRef Pred As PredosatoreType)

    Dim controllo As Integer

    With Pred

        controllo = .progressivo
        If (.riciclato) Then
            controllo = controllo + 20
        End If

        cmdSoffio(controllo).Picture = LoadResPicture(IIf(.abilitazioneSoffio, "IDB_ARIAON", "IDB_ARIA"), vbResBitmap)

    End With

End Sub

Private Sub RinfrescaPredosatore(Pred As PredosatoreType)

    Dim secondi As Integer
    Dim controllo As Integer

    With Pred

        If (FlashTime = 0 Or ConvertiTimer() - FlashTime >= 1) Then
            FlashColorOn = (Not FlashColorOn)
            FlashTime = ConvertiTimer()
        End If

        controllo = .progressivo
        If (.riciclato) Then
            controllo = .progressivo + 20
        End If

        LblSet(controllo).caption = ""
        'If (.codaSetLivello > 0) Then
        '    LblSet(controllo).Caption = CStr(.codaSet(0).set) + " %"
        'End If
        If (.setAttuale.set > 0) Then
            LblSet(controllo).caption = CStr(.setAttuale.set) + " %"
        End If

        secondi = 0
        Select Case .stato

            Case StatoPredosatoreType.predosatoreInStop
                LblStato(controllo).caption = ""
                LblStato(controllo).BackColor = vbRed

            Case StatoPredosatoreType.predosatoreStopping
                secondi = .setAttuale.tempoStop - (ConvertiTimer() - .setOra)
                If (secondi > 0) Then
                    LblStato(controllo).caption = CStr(secondi) + " sec."
                Else
                    LblStato(controllo).caption = ""
                End If
                LblStato(controllo).BackColor = IIf(FlashColorOn, vbRed, Me.BackColor)

            Case StatoPredosatoreType.predosatoreInStart
                LblStato(controllo).caption = ""
                LblStato(controllo).BackColor = vbGreen

            Case StatoPredosatoreType.predosatoreStarting
                secondi = .setAttuale.tempoStart - (ConvertiTimer() - .setOra)
                If (secondi > 0) Then
                    LblStato(controllo).caption = CStr(secondi) + " sec."
                Else
                    LblStato(controllo).caption = ""
                End If
                LblStato(controllo).BackColor = IIf(FlashColorOn, vbGreen, Me.BackColor)

        End Select

    End With

End Sub


Private Sub Rinfresca()

    Dim predosatore As Integer

    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        RinfrescaPredosatore ListaPredosatori(predosatore)
    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        RinfrescaPredosatore ListaPredosatoriRic(predosatore)
    Next predosatore

End Sub


Private Sub TmrRefresh_Timer()

    Rinfresca

End Sub


Private Sub SistemaFramePredosatori()
Dim Righe As Integer
Dim i As Integer

    If NumeroPredosatoriInseriti > 8 Then               '20151118 (espansione vergini)
        If NumeroPredosatoriRicInseriti > 4 Then
            For i = 0 To 3
                FramePredosatore(i + 20).top = FramePredosatore(8).top + 1440 'FramePredosatore(6).Height + 60 '20151118 (espansione vergini)
            Next i
            For i = 4 To NumeroPredosatoriRicInseriti - 1
                FramePredosatore(i + 20).top = FramePredosatore(20).top + 1440 'FramePredosatore(20).Height + 60
            Next i
            Righe = 4
        Else
            For i = 0 To NumeroPredosatoriRicInseriti - 1
                FramePredosatore(i + 20).top = FramePredosatore(8).top + FramePredosatore(6).Height + 20    '20151118 (espansione vergini)
            Next i
            Righe = 3
        End If
    Else
        If NumeroPredosatoriRicInseriti > 4 Then
            For i = 0 To 3
                FramePredosatore(i + 20).top = FramePredosatore(1).top + FramePredosatore(1).Height + 20
            Next i
            
            For i = 4 To NumeroPredosatoriRicInseriti - 1
                FramePredosatore(i + 20).top = FramePredosatore(20).top + FramePredosatore(1).Height + 20
            Next i
            Righe = 3
        Else
            For i = 0 To NumeroPredosatoriRicInseriti - 1
                FramePredosatore(i + 20).top = FramePredosatore(1).top + FramePredosatore(1).Height + 20
            Next i
            Righe = 2
        End If
    End If

    Me.Height = 1800 + 1400 * Righe '1300  20151118

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

Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index

        Case TopBarButtonEnum.uscita
        
            FrmStatoPredosatoriVisibile = False
        
            TmrRefresh.enabled = False
        
            Me.Hide
            Unload Me
        
        Case TopBarButtonEnum.Help
            
            VisualizzaHelp Me, HELP_PREDOSAGGIO_STATO_PREDOSATORI
    
    End Select

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
    LogInserisci True, "FPR-001", CStr(Err.Number) + " [" + Err.description + "]"
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
