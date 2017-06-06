VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmNetti 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MARINI"
   ClientHeight    =   6105
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   16035
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
   Picture         =   "FrmNetti.frx":0000
   ScaleHeight     =   6105
   ScaleWidth      =   16035
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   15000
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":168B
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":1CE9
            Key             =   "PLUS_IMG_OK_SELECTED"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":2269
            Key             =   "PLUS_OK_HELP"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":27B4
            Key             =   "PLUS_IMG_OK_GRAY"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":2D53
            Key             =   "PLUS_IMG_OK_PRESS"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":32FD
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":3944
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":3F9A
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":45F0
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":4BB8
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":516D
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":572D
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":5CED
            Key             =   "PLUS_IMG_LOGEXPORT"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":6368
            Key             =   "PLUS_IMG_LOGEXPORT_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":69D2
            Key             =   "PLUS_IMG_LOGEXPORT_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":7065
            Key             =   "PLUS_IMG_LOGEXPORT_SELECTED"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":76F9
            Key             =   "PLUS_IMG_STATUS_OK"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmNetti.frx":7C19
            Key             =   "PLUS_IMG_STATUS_WRONG"
         EndProperty
      EndProperty
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   19
      Left            =   11520
      TabIndex        =   138
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   19
         Left            =   360
         Top             =   240
         Visible         =   0   'False
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   19
         Left            =   120
         Picture         =   "FrmNetti.frx":81B4
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   19
         Left            =   720
         Picture         =   "FrmNetti.frx":870B
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   19
         Left            =   120
         Picture         =   "FrmNetti.frx":8C1B
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   19
         Left            =   720
         Picture         =   "FrmNetti.frx":916F
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   19
         Left            =   0
         TabIndex        =   139
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   18
      Left            =   10080
      TabIndex        =   136
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   18
         Left            =   360
         Top             =   240
         Visible         =   0   'False
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   18
         Left            =   120
         Picture         =   "FrmNetti.frx":967F
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   18
         Left            =   720
         Picture         =   "FrmNetti.frx":9BD6
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   18
         Left            =   120
         Picture         =   "FrmNetti.frx":A0E6
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   18
         Left            =   720
         Picture         =   "FrmNetti.frx":A63A
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   18
         Left            =   0
         TabIndex        =   137
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   17
      Left            =   8640
      TabIndex        =   134
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   17
         Left            =   360
         Top             =   240
         Visible         =   0   'False
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   17
         Left            =   120
         Picture         =   "FrmNetti.frx":AB4A
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   17
         Left            =   720
         Picture         =   "FrmNetti.frx":B0A1
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   17
         Left            =   120
         Picture         =   "FrmNetti.frx":B5B1
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   17
         Left            =   720
         Picture         =   "FrmNetti.frx":BB05
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   17
         Left            =   0
         TabIndex        =   135
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   16
      Left            =   7200
      TabIndex        =   132
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   16
         Left            =   360
         Top             =   240
         Visible         =   0   'False
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   16
         Left            =   120
         Picture         =   "FrmNetti.frx":C015
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   16
         Left            =   720
         Picture         =   "FrmNetti.frx":C56C
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   16
         Left            =   120
         Picture         =   "FrmNetti.frx":CA7C
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   16
         Left            =   720
         Picture         =   "FrmNetti.frx":CFD0
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   16
         Left            =   0
         TabIndex        =   133
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   15
      Left            =   5760
      TabIndex        =   130
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   15
         Left            =   360
         Top             =   240
         Visible         =   0   'False
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   15
         Left            =   120
         Picture         =   "FrmNetti.frx":D4E0
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   15
         Left            =   720
         Picture         =   "FrmNetti.frx":DA37
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   15
         Left            =   120
         Picture         =   "FrmNetti.frx":DF47
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   15
         Left            =   720
         Picture         =   "FrmNetti.frx":E49B
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   15
         Left            =   0
         TabIndex        =   131
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   12
      Left            =   2880
      TabIndex        =   128
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   12
         Left            =   360
         Top             =   240
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   12
         Left            =   120
         Picture         =   "FrmNetti.frx":E9AB
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   12
         Left            =   720
         Picture         =   "FrmNetti.frx":EF02
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   12
         Left            =   120
         Picture         =   "FrmNetti.frx":F412
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   12
         Left            =   720
         Picture         =   "FrmNetti.frx":F966
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   12
         Left            =   0
         TabIndex        =   129
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   14
      Left            =   4320
      TabIndex        =   126
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   14
         Left            =   0
         TabIndex        =   127
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   14
         Left            =   720
         Picture         =   "FrmNetti.frx":FE76
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   14
         Left            =   120
         Picture         =   "FrmNetti.frx":10386
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   14
         Left            =   720
         Picture         =   "FrmNetti.frx":108DA
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   14
         Left            =   120
         Picture         =   "FrmNetti.frx":10DEA
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   14
         Left            =   360
         Top             =   240
         Visible         =   0   'False
         Width           =   720
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   13
      Left            =   14520
      TabIndex        =   124
      Top             =   840
      Width           =   1455
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   13
         Left            =   0
         TabIndex        =   125
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   13
         Left            =   720
         Picture         =   "FrmNetti.frx":11341
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   13
         Left            =   120
         Picture         =   "FrmNetti.frx":11851
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   13
         Left            =   720
         Picture         =   "FrmNetti.frx":11DA5
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   13
         Left            =   120
         Picture         =   "FrmNetti.frx":122B5
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image ScaleType 
         Height          =   870
         Index           =   13
         Left            =   360
         Picture         =   "FrmNetti.frx":1280C
         Top             =   240
         Width           =   870
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   11
      Left            =   1440
      TabIndex        =   122
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   11
         Left            =   0
         TabIndex        =   123
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   11
         Left            =   720
         Picture         =   "FrmNetti.frx":12FB6
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   11
         Left            =   120
         Picture         =   "FrmNetti.frx":134C6
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   11
         Left            =   720
         Picture         =   "FrmNetti.frx":13A1A
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   11
         Left            =   120
         Picture         =   "FrmNetti.frx":13F2A
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   11
         Left            =   360
         Top             =   240
         Width           =   720
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   10
      Left            =   0
      TabIndex        =   120
      Top             =   8880
      Visible         =   0   'False
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   10
         Left            =   360
         Top             =   240
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   10
         Left            =   120
         Picture         =   "FrmNetti.frx":14481
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   10
         Left            =   720
         Picture         =   "FrmNetti.frx":149D8
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   10
         Left            =   120
         Picture         =   "FrmNetti.frx":14EE8
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   10
         Left            =   720
         Picture         =   "FrmNetti.frx":1543C
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   10
         Left            =   0
         TabIndex        =   121
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   9
      Left            =   13080
      TabIndex        =   118
      Top             =   840
      Width           =   1455
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   9
         Left            =   0
         TabIndex        =   119
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   9
         Left            =   720
         Picture         =   "FrmNetti.frx":1594C
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   9
         Left            =   120
         Picture         =   "FrmNetti.frx":15E5C
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   9
         Left            =   720
         Picture         =   "FrmNetti.frx":163B0
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   9
         Left            =   120
         Picture         =   "FrmNetti.frx":168C0
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   9
         Left            =   240
         Picture         =   "FrmNetti.frx":16E17
         Top             =   360
         Width           =   870
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   8
      Left            =   11640
      TabIndex        =   116
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   855
         Index           =   8
         Left            =   360
         Picture         =   "FrmNetti.frx":17320
         Top             =   240
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   8
         Left            =   120
         Picture         =   "FrmNetti.frx":17C30
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   8
         Left            =   720
         Picture         =   "FrmNetti.frx":18187
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   8
         Left            =   120
         Picture         =   "FrmNetti.frx":18697
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   8
         Left            =   720
         Picture         =   "FrmNetti.frx":18BEB
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   8
         Left            =   0
         TabIndex        =   117
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   7
      Left            =   10200
      TabIndex        =   114
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   870
         Index           =   7
         Left            =   240
         Picture         =   "FrmNetti.frx":190FB
         Top             =   240
         Width           =   870
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   7
         Left            =   0
         TabIndex        =   115
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   7
         Left            =   720
         Picture         =   "FrmNetti.frx":198A5
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   7
         Left            =   120
         Picture         =   "FrmNetti.frx":19DB5
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   7
         Left            =   720
         Picture         =   "FrmNetti.frx":1A309
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   7
         Left            =   120
         Picture         =   "FrmNetti.frx":1A819
         Top             =   2160
         Width           =   480
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   6
      Left            =   8760
      TabIndex        =   112
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   6
         Left            =   360
         Picture         =   "FrmNetti.frx":1AD70
         Top             =   240
         Width           =   720
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   6
         Left            =   120
         Picture         =   "FrmNetti.frx":1B251
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   6
         Left            =   720
         Picture         =   "FrmNetti.frx":1B7A8
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   6
         Left            =   120
         Picture         =   "FrmNetti.frx":1BCB8
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   6
         Left            =   720
         Picture         =   "FrmNetti.frx":1C20C
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   6
         Left            =   0
         TabIndex        =   113
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   5
      Left            =   7320
      TabIndex        =   110
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   5
         Left            =   360
         Picture         =   "FrmNetti.frx":1C71C
         Top             =   240
         Width           =   720
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   5
         Left            =   0
         TabIndex        =   111
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   5
         Left            =   720
         Picture         =   "FrmNetti.frx":1CDF5
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   5
         Left            =   120
         Picture         =   "FrmNetti.frx":1D305
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   5
         Left            =   720
         Picture         =   "FrmNetti.frx":1D859
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   5
         Left            =   120
         Picture         =   "FrmNetti.frx":1DD69
         Top             =   2160
         Width           =   480
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   4
      Left            =   5880
      TabIndex        =   108
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   4
         Left            =   240
         Picture         =   "FrmNetti.frx":1E2C0
         Top             =   360
         Width           =   1035
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   4
         Left            =   120
         Picture         =   "FrmNetti.frx":1E781
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   4
         Left            =   720
         Picture         =   "FrmNetti.frx":1ECD8
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   4
         Left            =   120
         Picture         =   "FrmNetti.frx":1F1E8
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   4
         Left            =   720
         Picture         =   "FrmNetti.frx":1F73C
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   4
         Left            =   0
         TabIndex        =   109
         Top             =   1200
         Width           =   1455
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   3
      Left            =   4440
      TabIndex        =   106
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   720
         Index           =   3
         Left            =   120
         Picture         =   "FrmNetti.frx":1FC4C
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   3
         Left            =   0
         TabIndex        =   107
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   3
         Left            =   720
         Picture         =   "FrmNetti.frx":20195
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   3
         Left            =   120
         Picture         =   "FrmNetti.frx":206A5
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   3
         Left            =   720
         Picture         =   "FrmNetti.frx":20BF9
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   3
         Left            =   120
         Picture         =   "FrmNetti.frx":21109
         Top             =   2160
         Width           =   480
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   2
      Left            =   3000
      TabIndex        =   104
      Top             =   840
      Width           =   1455
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   2
         Left            =   120
         Picture         =   "FrmNetti.frx":21660
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   2
         Left            =   720
         Picture         =   "FrmNetti.frx":21BB7
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   2
         Left            =   120
         Picture         =   "FrmNetti.frx":220C7
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   2
         Left            =   720
         Picture         =   "FrmNetti.frx":2261B
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   2
         Left            =   0
         TabIndex        =   105
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image ScaleType 
         Height          =   855
         Index           =   2
         Left            =   360
         Picture         =   "FrmNetti.frx":22B2B
         Top             =   240
         Width           =   720
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   1
      Left            =   1560
      TabIndex        =   102
      Top             =   840
      Width           =   1455
      Begin VB.Image ScaleType 
         Height          =   765
         Index           =   1
         Left            =   360
         Picture         =   "FrmNetti.frx":232CB
         Top             =   240
         Width           =   765
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   1
         Left            =   0
         TabIndex        =   103
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   1
         Left            =   720
         Picture         =   "FrmNetti.frx":2392E
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   1
         Left            =   120
         Picture         =   "FrmNetti.frx":23E3E
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   1
         Left            =   720
         Picture         =   "FrmNetti.frx":24392
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   1
         Left            =   120
         Picture         =   "FrmNetti.frx":248A2
         Top             =   2160
         Width           =   480
      End
   End
   Begin VB.Frame fraScaleStatus 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2855
      Index           =   0
      Left            =   120
      TabIndex        =   100
      Top             =   840
      Width           =   1455
      Begin VB.Image imgScaleStatusDisch 
         Height          =   480
         Index           =   0
         Left            =   120
         Picture         =   "FrmNetti.frx":24DF9
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusDischStatus 
         Height          =   480
         Index           =   0
         Left            =   720
         Picture         =   "FrmNetti.frx":25350
         Top             =   2160
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeight 
         Height          =   480
         Index           =   0
         Left            =   120
         Picture         =   "FrmNetti.frx":25860
         Top             =   1560
         Width           =   480
      End
      Begin VB.Image imgScaleStatusWeighStatus 
         Height          =   480
         Index           =   0
         Left            =   720
         Picture         =   "FrmNetti.frx":25DB4
         Top             =   1560
         Width           =   480
      End
      Begin VB.Label lblScaleStatusStep 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "STEP: 0"
         Height          =   375
         Index           =   0
         Left            =   0
         TabIndex        =   101
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Image ScaleType 
         Height          =   870
         Index           =   0
         Left            =   360
         Picture         =   "FrmNetti.frx":262C4
         Top             =   240
         Width           =   870
      End
   End
   Begin VB.Frame FrameSchiumato 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Schiumato"
      Height          =   2175
      Left            =   13320
      TabIndex        =   84
      Top             =   3840
      Width           =   1575
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "Hard"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   15
         Left            =   820
         TabIndex        =   94
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "Soft"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   14
         Left            =   120
         TabIndex        =   93
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LblNettiStampaB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   840
         TabIndex        =   92
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettoB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   840
         TabIndex        =   91
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblSetB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   840
         TabIndex        =   90
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   89
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblResBit 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   840
         TabIndex        =   88
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettoB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   87
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettiStampaB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   86
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblResBit 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   85
         Top             =   1680
         Width           =   675
      End
   End
   Begin VB.CommandButton CmdResetContalitri 
      Caption         =   "Reset"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   400
      Left            =   2880
      TabIndex        =   83
      Top             =   240
      Visible         =   0   'False
      Width           =   1035
   End
   Begin VB.Frame FrameRiciclato 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Riciclato"
      Height          =   2175
      Left            =   11760
      TabIndex        =   67
      Top             =   3840
      Width           =   1575
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "RAP"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   17
         Left            =   820
         TabIndex        =   99
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LblResRic 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   840
         TabIndex        =   98
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettiStampaR 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   840
         TabIndex        =   97
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettoRic 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   840
         TabIndex        =   96
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblSetR 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   840
         TabIndex        =   95
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetR 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999,9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   73
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblNettoRic 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   72
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblResRic 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   71
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettiStampaR 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   70
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "RAPS"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   12
         Left            =   120
         TabIndex        =   68
         Top             =   285
         Width           =   675
      End
   End
   Begin VB.Frame FrameLegante 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Bitume"
      Height          =   2175
      Left            =   9480
      TabIndex        =   57
      Top             =   3840
      Width           =   2295
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "B3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   13
         Left            =   1520
         TabIndex        =   82
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblSetB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   81
         Top             =   600
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblNettoB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   80
         Top             =   960
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblNettiStampaB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   79
         Top             =   1320
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblResBit 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   78
         Top             =   1680
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblResBit 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   74
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettiStampaB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   66
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettoB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   65
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblResBit 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   64
         Top             =   1680
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblSetB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999,9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   63
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   62
         Top             =   600
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblNettoB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   61
         Top             =   960
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblNettiStampaB12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   60
         Top             =   1320
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "B1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   10
         Left            =   120
         TabIndex        =   59
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "B2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   11
         Left            =   820
         TabIndex        =   58
         Top             =   285
         Width           =   675
      End
   End
   Begin VB.Frame FrameFiller 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Filler"
      Height          =   2175
      Left            =   7200
      TabIndex        =   41
      Top             =   3840
      Width           =   2295
      Begin VB.Label LblNettiStampaf 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   56
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaf 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   55
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblResFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   54
         Top             =   1680
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblResFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   53
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettoFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   52
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   51
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblSetFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999,9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   50
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   49
         Top             =   600
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "F1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   8
         Left            =   120
         TabIndex        =   48
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "F2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   9
         Left            =   820
         TabIndex        =   47
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LblSetFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   46
         Top             =   600
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblNettoFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   45
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettiStampaf 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   44
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblResFiller 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   43
         Top             =   1680
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "F3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   28
         Left            =   1520
         TabIndex        =   42
         Top             =   285
         Width           =   675
      End
   End
   Begin VB.Timer TimerManualeFiller2 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   2280
      Top             =   120
   End
   Begin VB.Timer TimerManualeFiller1 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   1320
      Top             =   120
   End
   Begin VB.Timer TimerManualeFiller3 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   1800
      Top             =   120
   End
   Begin VB.Frame FrameAgg 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Aggregati"
      Height          =   2175
      Left            =   1320
      TabIndex        =   0
      Top             =   3840
      Width           =   5895
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   7
         Left            =   5020
         TabIndex        =   40
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   7
         Left            =   5020
         TabIndex        =   39
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   7
         Left            =   5020
         TabIndex        =   38
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999.9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   7
         Left            =   5020
         TabIndex        =   37
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   6
         Left            =   4320
         TabIndex        =   36
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   5
         Left            =   3620
         TabIndex        =   35
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   2920
         TabIndex        =   34
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   2220
         TabIndex        =   33
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   32
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   31
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblNettiStampaA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   30
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   6
         Left            =   4320
         TabIndex        =   29
         Top             =   1680
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   5
         Left            =   3620
         TabIndex        =   28
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   2920
         TabIndex        =   27
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   2220
         TabIndex        =   26
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   25
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   24
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblResAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   23
         Top             =   1680
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   22
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   21
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   20
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   2220
         TabIndex        =   19
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   2920
         TabIndex        =   18
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   5
         Left            =   3620
         TabIndex        =   17
         Top             =   960
         Width           =   675
      End
      Begin VB.Label LblNettoAgg 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   6
         Left            =   4320
         TabIndex        =   16
         Top             =   960
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999,9"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   15
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   820
         TabIndex        =   14
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1520
         TabIndex        =   13
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   2220
         TabIndex        =   12
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   2920
         TabIndex        =   11
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   5
         Left            =   3620
         TabIndex        =   10
         Top             =   600
         Width           =   675
      End
      Begin VB.Label LblSetA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   6
         Left            =   4320
         TabIndex        =   9
         Top             =   600
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A7"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   6
         Left            =   4320
         TabIndex        =   8
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A6"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   5
         Left            =   3620
         TabIndex        =   7
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A5"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   4
         Left            =   2920
         TabIndex        =   6
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A4"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   3
         Left            =   2220
         TabIndex        =   5
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   2
         Left            =   1520
         TabIndex        =   4
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   1
         Left            =   820
         TabIndex        =   3
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "A1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
      Begin VB.Label LblEtichetta 
         Alignment       =   2  'Center
         BackColor       =   &H00E8C493&
         BackStyle       =   0  'Transparent
         Caption         =   "NV"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   7
         Left            =   5020
         TabIndex        =   1
         Top             =   285
         Visible         =   0   'False
         Width           =   675
      End
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   8085
      Picture         =   "FrmNetti.frx":26A68
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   6960
      Picture         =   "FrmNetti.frx":27020
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   0
      Picture         =   "FrmNetti.frx":2766E
      Top             =   0
      Width           =   1125
   End
   Begin VB.Label LabelSX 
      BackColor       =   &H00FFFFC0&
      BackStyle       =   0  'Transparent
      Caption         =   "KG VOLO"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   3
      Left            =   30
      TabIndex        =   77
      Top             =   5535
      Width           =   1455
   End
   Begin VB.Label LabelSX 
      BackColor       =   &H00FFFFC0&
      BackStyle       =   0  'Transparent
      Caption         =   "KG OLD"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   2
      Left            =   30
      TabIndex        =   76
      Top             =   5175
      Width           =   1455
   End
   Begin VB.Label LabelSX 
      BackColor       =   &H00FFFFC0&
      BackStyle       =   0  'Transparent
      Caption         =   "KG NET"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   30
      TabIndex        =   75
      Top             =   4815
      Width           =   1455
   End
   Begin VB.Label LabelSX 
      BackColor       =   &H00FFFFC0&
      BackStyle       =   0  'Transparent
      Caption         =   "KG SET"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   0
      Left            =   30
      TabIndex        =   69
      Top             =   4455
      Width           =   1455
   End
End
Attribute VB_Name = "FrmNetti"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


Private Enum TopBarButtonEnum
    uscita
    Help
    LogExport
    TBB_LAST
End Enum


Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
Private NumFrameStatusBilAttivi As Integer
'



Private Sub CmdResetContalitri_LostFocus()
    CP240.OPCData.items(PLCTAG_DI_ContalitriReset).Value = False
End Sub

Private Sub CmdResetContalitri_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    CP240.OPCData.items(PLCTAG_DI_ContalitriReset).Value = True
End Sub

Private Sub CmdResetContalitri_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    CP240.OPCData.items(PLCTAG_DI_ContalitriReset).Value = False
End Sub


Private Sub Form_Activate()
    If (Me.Visible) Then
        Call VisualizzaBarraPulsantiCP240(False)
    End If
End Sub

Private Sub Form_Load()
    Dim indice As Integer

    On Error GoTo Errore

    Call CarattereOccidentale(Me)

    Me.left = 0
    Me.top = 600
    Me.caption = CAPTIONSTARTSIMPLE

    For indice = 0 To MaxScaleID - 1
        'Forza il refresh grafico
        BilanciaStatus(indice).FinePesataOld = Not BilanciaStatus(indice).FinePesata
        BilanciaStatus(indice).FineScarico = Not BilanciaStatus(indice).FineScarico
    Next indice

    Call RefreshTagDatiStatusBil
    Call DatiStatusBil_Change

    Call DisponiFrameStatus
    If (Me.fraScaleStatus(0).width * NumFrameStatusBilAttivi) > 9300 Then
        'allarga il frame se necessario
        '20151123
        'Me.width = Me.fraScaleStatus(0).width * NumFrameStatusBilAttivi
        Me.width = (Me.fraScaleStatus(0).width * NumFrameStatusBilAttivi) + 80
    End If

    Call DisponiPulsantiPlusForm(FrmNetti, 0, 1, False, False, 1)
'

    FrameSchiumato.Visible = PlcSchiumato.Abilitazione

    'CmdResetContalitri.Visible = InclusioneAddContalitri   '20161128
    'CmdResetContalitri.enabled = False '20161128
    
    FrameAgg.caption = LoadXLSString(455)
    FrameFiller.caption = LoadXLSString(388)
    FrameLegante.caption = LoadXLSString(389)
    FrameRiciclato.caption = LoadXLSString(686)
    
    LabelSX(0).caption = UCase(LoadXLSString(692) + " (" + LoadXLSString(349) + ")")
    LabelSX(1).caption = UCase(LoadXLSString(366) + " (" + LoadXLSString(349) + ")")
    LabelSX(2).caption = UCase(LoadXLSString(361))
    LabelSX(3).caption = UCase(LoadXLSString(936) + " (" + LoadXLSString(349) + ")")
        
    imgPulsanteForm(0).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(1).ToolTipText = LoadXLSString(110)

    '--------------------------------------------------------------------------
    'CONTROLLO INSERIMENTO FILLER 2.
    LblSetFiller(1).Visible = InclusioneF2
    LblNettoFiller(1).Visible = InclusioneF2
    LblNettiStampaf(1).Visible = InclusioneF2
    LblResFiller(1).Visible = InclusioneF2
    LblEtichetta(9).Visible = InclusioneF2
    
    LblSetFiller(2).Visible = InclusioneF3
    LblNettoFiller(2).Visible = InclusioneF3
    LblNettiStampaf(2).Visible = InclusioneF3
    LblResFiller(2).Visible = InclusioneF3
    LblEtichetta(28).Visible = InclusioneF3

    If Not InclusioneBitume2 Then
        LblNettoB12(1).Visible = False
        LblSetB12(1).Visible = False
        LblNettiStampaB12(1).Visible = False
        LblEtichetta(11).Visible = False
        LblResBit(1).Visible = False
    End If
    
    If InclusioneBacinella2 Or InclusioneBitume2 Then
        LblNettoB12(1).Visible = True
        LblSetB12(1).Visible = True
        LblNettiStampaB12(1).Visible = True
        LblResBit(1).Visible = True
        LblEtichetta(11).Visible = True
    End If
    
    LblSetB12(2).Visible = InclusioneAddContalitri
    LblNettoB12(2).Visible = InclusioneAddContalitri
    LblNettiStampaB12(2).Visible = InclusioneAddContalitri
    LblResBit(2).Visible = InclusioneAddContalitri
    LblEtichetta(13).Visible = InclusioneAddContalitri
    
    '-------------------------------------------------------------------------
    'CONFIGURAZIONE NUMERO TRAMOGGE.
    For indice = 0 To 6
        'Nomi Tramogge
        LblEtichetta(indice).caption = NomePortina(indice)
        LblEtichetta(indice).Visible = (indice <= NTramoggeA)
        LblNettoAgg(indice).Visible = (indice <= NTramoggeA)
        LblSetA(indice).Visible = (indice <= NTramoggeA)
        LblResAgg(indice).Visible = (indice <= NTramoggeA)
        LblNettiStampaA(indice).Visible = (indice <= NTramoggeA)
    Next indice
    LblEtichetta(7).Visible = True
    LblEtichetta(7).caption = NomePortina(7)
    
    FrameRiciclato.Visible = AbilitaRAPSiwa Or AbilitaRAP
    LblSetR(0).Visible = AbilitaRAPSiwa
    LblNettoRic(0).Visible = AbilitaRAPSiwa
    LblNettiStampaR(0).Visible = AbilitaRAPSiwa
    LblResRic(0).Visible = AbilitaRAPSiwa
    LblSetR(1).Visible = AbilitaRAP
    LblNettoRic(1).Visible = AbilitaRAP
    LblNettiStampaR(1).Visible = AbilitaRAP
    LblResRic(1).Visible = AbilitaRAP
    
    LblEtichetta(6).Visible = PesaturaRiciclatoAggregato7
    LblSetA(6).Visible = PesaturaRiciclatoAggregato7
    LblResAgg(6).Visible = PesaturaRiciclatoAggregato7
    LblNettoAgg(6).Visible = PesaturaRiciclatoAggregato7
    LblNettiStampaA(6).Visible = PesaturaRiciclatoAggregato7
    '
    If (AbilitaSelettoreBitume1 And Not InclusioneBacinella2) Then
        LblEtichetta(11).left = LblEtichetta(10).left
    End If
    
    LblEtichetta(7).Visible = True
    LblSetA(7).Visible = True
    LblNettoAgg(7).Visible = True
    LblNettiStampaA(7).Visible = True
    LblResAgg(7).Visible = True

    SetStartUpPosition Me, 0

    If Not CP240.AdoDosaggio.Recordset.EOF Then
        Call RefreshDatiFormNetti
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "FNT-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub TimerManualeFiller1_Timer()
    FineRitardoConteggioF(0) = False
    TimerManualeFiller1.enabled = False
End Sub

Private Sub TimerManualeFiller2_Timer()
    FineRitardoConteggioF(1) = False
    TimerManualeFiller2.enabled = False
End Sub

Private Sub TimerManualeFiller3_Timer()
    FineRitardoConteggioF(2) = False
    TimerManualeFiller3.enabled = False
End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            Call VisualizzaBarraPulsantiCP240(True)
            Unload Me
            Me.Hide
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_DETTAGLI_DOSAGGIO_NETTI
        Case TopBarButtonEnum.LogExport
            Call ExportScaleStatus
    End Select

End Sub
'


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
        Case TopBarButtonEnum.LogExport
            prefisso = "PLUS_IMG_LOGEXPORT"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FNT-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub DatiStatusBil_Change()

    Dim indice As Integer
    
    On Error GoTo Errore
        
    For indice = 0 To MaxScaleID - 1
        If BilanciaStatus(indice).FinePesataOld <> BilanciaStatus(indice).FinePesata Then
            FrmNetti.imgScaleStatusWeighStatus(indice).Picture = IIf(BilanciaStatus(indice).FinePesata, PlusImageList.ListImages("PLUS_IMG_STATUS_OK").Picture, PlusImageList.ListImages("PLUS_IMG_STATUS_WRONG").Picture)
            BilanciaStatus(indice).FinePesataOld = BilanciaStatus(indice).FinePesata
        End If
        
        If BilanciaStatus(indice).FineScaricoOld <> BilanciaStatus(indice).FineScarico Then
            FrmNetti.imgScaleStatusWeighStatus(indice).Picture = IIf(BilanciaStatus(indice).FineScarico, PlusImageList.ListImages("PLUS_IMG_STATUS_OK").Picture, PlusImageList.ListImages("PLUS_IMG_STATUS_WRONG").Picture)
            BilanciaStatus(indice).FineScaricoOld = BilanciaStatus(indice).FineScarico
        End If
        
        FrmNetti.lblScaleStatusStep(indice).caption = "STEP: " + CStr(BilanciaStatus(indice).step)
        
        FrmNetti.imgScaleStatusWeighStatus(indice).Visible = BilanciaStatus(indice).Abilitata
        FrmNetti.imgScaleStatusDischStatus(indice).Visible = BilanciaStatus(indice).Abilitata
        
'        FrmNetti.fraScaleStatus(indice).Visible = BilanciaStatus(indice).Abilitata
        FrmNetti.fraScaleStatus(indice).Visible = BilanciaStatus(indice).visibile
    
    Next indice

'    FrmNetti.fraScaleStatus(ScaleID.IDRiciclatoSiwa).Visible = AbilitaRAPSiwa
'    FrmNetti.fraScaleStatus(ScaleID.IDriciclato).Visible = AbilitaRAP


    Exit Sub
Errore:
    LogInserisci True, "FNT-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub RefreshTagDatiStatusBil()

    Dim indice As Integer
    Dim spread As Integer

    On Error GoTo Errore

    If (MancanzaComunicazione) Then
        Exit Sub
    End If

    spread = PLCTAG_Comp2_Abilitazione - PLCTAG_Comp1_Abilitazione
    
    With CP240.OPCData
    
        For indice = 0 To MaxScaleID - 1
            BilanciaStatus(indice).Abilitata = .items(PLCTAG_Comp1_Abilitazione + (indice * spread)).Value
            BilanciaStatus(indice).FinePesata = .items(PLCTAG_Comp1_Abilitazione + 1 + (indice * spread)).Value
            BilanciaStatus(indice).FineScarico = .items(PLCTAG_Comp1_Abilitazione + 2 + (indice * spread)).Value
        Next

        BilanciaStatus(ScaleID.IDaggregati).step = .items(PLCTAG_Step_Bil_AGGREGATI).Value
        BilanciaStatus(ScaleID.IDfiller).step = .items(PLCTAG_Step_Bil_FILLER).Value
        BilanciaStatus(ScaleID.IDBitume).step = .items(PLCTAG_Step_Bil_BITUME).Value
        BilanciaStatus(ScaleID.IDAdditivoViatop).step = .items(PLCTAG_Step_Bil_VIATOP).Value
        BilanciaStatus(ScaleID.IDriciclato).step = .items(PLCTAG_Step_Bil_RICICLATO).Value
        BilanciaStatus(ScaleID.IDAdditivoSacchi).step = .items(PLCTAG_Step_Bil_SACCHI).Value
        BilanciaStatus(ScaleID.IDBitumeGravita).step = .items(PLCTAG_Step_Bil_BITUMEGRAV).Value
        BilanciaStatus(ScaleID.IDAdditivoBacinella).step = .items(PLCTAG_Step_Bil_ADDBACLEGCNT).Value

'        BilanciaStatus(ScaleID.id).STEP = .Items(PLCTAG_Step_Bil_BITUMECNT).Value
        BilanciaStatus(ScaleID.IDRiciclatoSiwa).step = .items(PLCTAG_Step_Bil_RICICLATOSIWA).Value
        BilanciaStatus(ScaleID.IDCicloRiciclatoFreddo).step = .items(PLCTAG_Step_Bil_CICLRICICLATOFREDDO).Value

    End With

    Exit Sub
Errore:
    LogInserisci True, "FNT-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Private Sub DisponiFrameStatus()
    
    Dim indice As Integer
    Dim CoordTBB As Long
    
    On Error GoTo Errore

    CoordTBB = 0
    NumFrameStatusBilAttivi = 0
    
    BilanciaStatus(ScaleID.IDaggregati).visibile = True
    BilanciaStatus(ScaleID.IDfiller).visibile = True
    BilanciaStatus(ScaleID.IDBitume).visibile = True
    BilanciaStatus(ScaleID.IDAdditivoMescolatore).visibile = True
    BilanciaStatus(ScaleID.IDAdditivoBacinella).visibile = True
    BilanciaStatus(ScaleID.IDAdditivoSacchi).visibile = True
    BilanciaStatus(ScaleID.IDAdditivoViatop).visibile = True
    BilanciaStatus(ScaleID.IDriciclato).visibile = AbilitaRAP
    BilanciaStatus(ScaleID.IDBitumeGravita).visibile = True
    BilanciaStatus(ScaleID.IDAdditivoBacinellaCnt).visibile = True
    BilanciaStatus(ScaleID.IDAdditivoFlomac).visibile = False
    BilanciaStatus(ScaleID.IDBitumeWamFoam).visibile = False
    BilanciaStatus(ScaleID.IDAdditivoAux2).visibile = False
    BilanciaStatus(ScaleID.IDRiciclatoSiwa).visibile = AbilitaRAPSiwa
    BilanciaStatus(ScaleID.IDDisponibile1).visibile = False
    BilanciaStatus(ScaleID.IDDisponibile2).visibile = False
    BilanciaStatus(ScaleID.IDDisponibile3).visibile = False
    BilanciaStatus(ScaleID.IDDisponibile4).visibile = False
    BilanciaStatus(ScaleID.IDDisponibile5).visibile = False
    BilanciaStatus(ScaleID.IDCicloRiciclatoFreddo).visibile = False

    For indice = 0 To MaxScaleID - 1
        fraScaleStatus(indice).left = CoordTBB
'        If BilanciaStatus(indice).Abilitata Then
        If BilanciaStatus(indice).visibile Then
            CoordTBB = CoordTBB + (fraScaleStatus(indice).width)
            NumFrameStatusBilAttivi = NumFrameStatusBilAttivi + 1
        End If
    Next indice

    Exit Sub
Errore:
    LogInserisci True, "FNT-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Private Sub ExportScaleStatus()

    Dim indice As Integer
    Dim nomeFile As String

    On Error GoTo Errore

    nomeFile = LogPath + "LOG_BILANCE_" & Year(Date) & Format(Month(Date), "00") & Format(Day(Date), "00") & " " & Format(Hour(time), "00") & Format(Minute(time), "00") & Format(Second(time), "00") & ".txt"

    For indice = 0 To MaxScaleID - 1
        FileSetValue nomeFile, "IdBilancia" & CStr(indice), "Abilitata ", CStr(BilanciaStatus(indice).Abilitata)
        FileSetValue nomeFile, "IdBilancia" & CStr(indice), "FinePesata ", CStr(BilanciaStatus(indice).FinePesata)
        FileSetValue nomeFile, "IdBilancia" & CStr(indice), "FineScarico ", CStr(BilanciaStatus(indice).FineScarico)
        FileSetValue nomeFile, "IdBilancia" & CStr(indice), "Step ", CStr(BilanciaStatus(indice).step)
    Next indice
'20150309
'    MsgBox LoadXLSString(1484), vbOKOnly + vbInformation, "MARINI"
    MsgBox nomeFile + " " + LoadXLSString(1484), vbOKOnly + vbInformation, "MARINI"
'
    Exit Sub
Errore:
    LogInserisci True, "FNT-005", CStr(Err.Number) + " [" + Err.description + "]"
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
