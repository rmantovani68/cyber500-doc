VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmSiloGenerale 
   Appearance      =   0  'Flat
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MARINI - Silo"
   ClientHeight    =   8145
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12990
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmSiloGenerale.frx":0000
   ScaleHeight     =   543
   ScaleMode       =   0  'User
   ScaleWidth      =   866
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   2880
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   16
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":89D42
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8A30A
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8A8BF
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8AE7F
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8B43F
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8BA9D
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8C0E4
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8C73A
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8CD90
            Key             =   "PLUS_IMG_SAVE"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8D3BA
            Key             =   "PLUS_IMG_SAVE_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8D9FF
            Key             =   "PLUS_IMG_SAVE_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8E05E
            Key             =   "PLUS_IMG_SAVE_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8E6BB
            Key             =   "PLUS_IMG_LOGIN"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8ECF2
            Key             =   "PLUS_IMG_LOGIN_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8F35C
            Key             =   "PLUS_IMG_LOGIN_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmSiloGenerale.frx":8FB96
            Key             =   "PLUS_IMG_LOGIN_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Frame FrameComandiSilo 
      Height          =   840
      Index           =   0
      Left            =   0
      TabIndex        =   182
      Top             =   7260
      Width           =   6015
      Begin VB.CommandButton CmdStop 
         Height          =   550
         Left            =   720
         Style           =   1  'Graphical
         TabIndex        =   193
         Top             =   180
         Width           =   550
      End
      Begin VB.CommandButton CmdStart 
         Height          =   550
         Left            =   1320
         Style           =   1  'Graphical
         TabIndex        =   192
         Top             =   180
         Width           =   550
      End
      Begin VB.CommandButton CmdAutoMan 
         Height          =   550
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   191
         Top             =   180
         Width           =   550
      End
      Begin VB.Frame FrameComandiSilo 
         Height          =   840
         Index           =   1
         Left            =   3420
         TabIndex        =   186
         Top             =   0
         Width           =   2595
         Begin VB.CommandButton CmdSX 
            Height          =   550
            Left            =   120
            Picture         =   "FrmSiloGenerale.frx":901FE
            Style           =   1  'Graphical
            TabIndex        =   190
            Top             =   180
            Width           =   550
         End
         Begin VB.CommandButton CmdChiudiBenna 
            Height          =   550
            Left            =   1920
            Style           =   1  'Graphical
            TabIndex        =   189
            Top             =   180
            Width           =   550
         End
         Begin VB.CommandButton CmdApriBenna 
            Height          =   550
            Left            =   1320
            Style           =   1  'Graphical
            TabIndex        =   188
            Top             =   180
            Width           =   550
         End
         Begin VB.CommandButton CmdDX 
            Height          =   550
            Left            =   720
            Style           =   1  'Graphical
            TabIndex        =   187
            Top             =   180
            Width           =   550
         End
      End
      Begin VB.Frame FrameComandiSilo 
         Height          =   840
         Index           =   2
         Left            =   2040
         TabIndex        =   183
         Top             =   0
         Width           =   1395
         Begin VB.CommandButton CmdGIU 
            Height          =   550
            Left            =   120
            Picture         =   "FrmSiloGenerale.frx":91170
            Style           =   1  'Graphical
            TabIndex        =   185
            Top             =   180
            Width           =   550
         End
         Begin VB.CommandButton CmdSU 
            Height          =   550
            Left            =   720
            Picture         =   "FrmSiloGenerale.frx":9166D
            Style           =   1  'Graphical
            TabIndex        =   184
            Top             =   180
            Width           =   550
         End
      End
   End
   Begin VB.PictureBox PctSilo 
      Height          =   495
      Index           =   0
      Left            =   0
      Picture         =   "FrmSiloGenerale.frx":91BC7
      ScaleHeight     =   435
      ScaleWidth      =   315
      TabIndex        =   59
      Top             =   960
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox PctSilo 
      Height          =   495
      Index           =   1
      Left            =   240
      Picture         =   "FrmSiloGenerale.frx":93309
      ScaleHeight     =   435
      ScaleWidth      =   315
      TabIndex        =   58
      Top             =   960
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox PctSilo 
      Height          =   495
      Index           =   2
      Left            =   480
      Picture         =   "FrmSiloGenerale.frx":942B7
      ScaleHeight     =   435
      ScaleWidth      =   315
      TabIndex        =   57
      Top             =   960
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox PctSilo 
      Height          =   495
      Index           =   3
      Left            =   720
      Picture         =   "FrmSiloGenerale.frx":95186
      ScaleHeight     =   435
      ScaleWidth      =   315
      TabIndex        =   56
      Top             =   960
      Visible         =   0   'False
      Width           =   375
   End
   Begin TabDlg.SSTab TabSilo 
      Height          =   6255
      Left            =   0
      TabIndex        =   0
      Top             =   960
      Width           =   13005
      _ExtentX        =   22939
      _ExtentY        =   11033
      _Version        =   393216
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   520
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   12
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "MAIN"
      TabPicture(0)   =   "FrmSiloGenerale.frx":96041
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "FrameSiloS7(4)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "FrameSiloS7(2)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "FrameSiloS7(3)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "FrameSiloS7(6)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "FrameSiloS7(9)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).ControlCount=   5
      TabCaption(1)   =   "SERVICES"
      TabPicture(1)   =   "FrmSiloGenerale.frx":9605D
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "FrameSiloS7(10)"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "FrameSiloS7(0)"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "FrameSiloS7(8)"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "FrameSiloS7(7)"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).Control(4)=   "FrameSiloS7(1)"
      Tab(1).Control(4).Enabled=   0   'False
      Tab(1).Control(5)=   "FrameSiloS7(5)"
      Tab(1).Control(5).Enabled=   0   'False
      Tab(1).ControlCount=   6
      Begin VB.Frame FrameSiloS7 
         Height          =   3375
         Index           =   10
         Left            =   -69800
         TabIndex        =   169
         Top             =   2760
         Width           =   7695
         Begin VB.Shape shAreaGrPosNav 
            Height          =   3000
            Index           =   1
            Left            =   120
            Top             =   220
            Width           =   7425
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "R"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   112
            Left            =   840
            TabIndex        =   181
            Top             =   1440
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "D"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   111
            Left            =   480
            TabIndex        =   180
            Top             =   1440
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "10"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   110
            Left            =   3720
            TabIndex        =   179
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "9"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   109
            Left            =   3360
            TabIndex        =   178
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "8"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   108
            Left            =   3000
            TabIndex        =   177
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "7"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   107
            Left            =   2640
            TabIndex        =   176
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "6"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   106
            Left            =   2280
            TabIndex        =   175
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "5"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   105
            Left            =   1920
            TabIndex        =   174
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "4"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   104
            Left            =   1560
            TabIndex        =   173
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "3"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   103
            Left            =   1200
            TabIndex        =   172
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   102
            Left            =   840
            TabIndex        =   171
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   101
            Left            =   480
            TabIndex        =   170
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Image imgGrafPos 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Height          =   480
            Index           =   1
            Left            =   120
            Picture         =   "FrmSiloGenerale.frx":96079
            Top             =   225
            Width           =   480
         End
      End
      Begin VB.Frame FrameSiloS7 
         Height          =   2295
         Index           =   9
         Left            =   8280
         TabIndex        =   156
         Top             =   3840
         Width           =   4455
         Begin VB.Shape shAreaGrPosNav 
            Height          =   1980
            Index           =   0
            Left            =   120
            Top             =   200
            Width           =   4200
         End
         Begin VB.Image imgGrafPos 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Height          =   480
            Index           =   0
            Left            =   120
            Picture         =   "FrmSiloGenerale.frx":96440
            Top             =   225
            Width           =   480
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   1
            Left            =   480
            TabIndex        =   168
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   2
            Left            =   840
            TabIndex        =   167
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "3"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   3
            Left            =   1200
            TabIndex        =   166
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "4"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   4
            Left            =   1560
            TabIndex        =   165
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "5"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   5
            Left            =   1920
            TabIndex        =   164
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "6"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   6
            Left            =   2280
            TabIndex        =   163
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "7"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   7
            Left            =   2640
            TabIndex        =   162
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "8"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   8
            Left            =   3000
            TabIndex        =   161
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "9"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   9
            Left            =   3360
            TabIndex        =   160
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "10"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   10
            Left            =   3720
            TabIndex        =   159
            Top             =   960
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "D"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   11
            Left            =   480
            TabIndex        =   158
            Top             =   1440
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label lblPosGraf 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "R"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Index           =   12
            Left            =   840
            TabIndex        =   157
            Top             =   1440
            Visible         =   0   'False
            Width           =   255
         End
      End
      Begin VB.Frame FrameSiloS7 
         Caption         =   "Asse P"
         Height          =   1695
         Index           =   0
         Left            =   -69800
         TabIndex        =   1
         Top             =   320
         Width           =   3855
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   2
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   7
            Text            =   "0"
            Top             =   180
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   7
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   6
            Text            =   "0"
            Top             =   540
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   8
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   5
            Text            =   "0"
            Top             =   900
            Width           =   855
         End
         Begin VB.Label LblSiloS7 
            BackColor       =   &H000000FF&
            Caption         =   "Antiadesivo"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Index           =   40
            Left            =   1080
            TabIndex        =   141
            Top             =   1320
            Width           =   2295
         End
         Begin VB.Label LblSiloS7 
            Caption         =   "Velox Hz reale"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   8
            Left            =   1080
            TabIndex        =   4
            Top             =   923
            Width           =   2295
         End
         Begin VB.Label LblSiloS7 
            Caption         =   "Velox Hz teorica"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   7
            Left            =   1080
            TabIndex        =   3
            Top             =   563
            Width           =   2295
         End
         Begin VB.Label LblSiloS7 
            Caption         =   "Target"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   1080
            TabIndex        =   2
            Top             =   158
            Width           =   2295
         End
      End
      Begin VB.Frame FrameSiloS7 
         Caption         =   "Asse Aux"
         Height          =   1695
         Index           =   8
         Left            =   -65920
         TabIndex        =   109
         Top             =   315
         Width           =   3855
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   13
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   112
            Text            =   "0"
            Top             =   900
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   12
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   111
            Text            =   "0"
            Top             =   540
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Index           =   10
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   110
            Text            =   "0"
            Top             =   180
            Width           =   855
         End
         Begin VB.Label LblSiloS7 
            BackColor       =   &H000000FF&
            Caption         =   "Antiadesivo"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Index           =   50
            Left            =   1080
            TabIndex        =   140
            Top             =   1283
            Width           =   2295
         End
         Begin VB.Label LblSiloS7 
            Caption         =   "Target"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   10
            Left            =   1080
            TabIndex        =   115
            Top             =   158
            Width           =   2295
         End
         Begin VB.Label LblSiloS7 
            Caption         =   "Velox Hz teorica"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   6
            Left            =   1080
            TabIndex        =   114
            Top             =   563
            Width           =   2295
         End
         Begin VB.Label LblSiloS7 
            Caption         =   "Velox Hz reale"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   204
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   5
            Left            =   1080
            TabIndex        =   113
            Top             =   923
            Width           =   2295
         End
      End
      Begin VB.Frame FrameSiloS7 
         Height          =   855
         Index           =   7
         Left            =   -65920
         TabIndex        =   104
         Top             =   1920
         Width           =   3855
         Begin VB.CommandButton CmdJogDX 
            Height          =   550
            Index           =   1
            Left            =   720
            Picture         =   "FrmSiloGenerale.frx":96807
            Style           =   1  'Graphical
            TabIndex        =   108
            Top             =   180
            Width           =   550
         End
         Begin VB.CommandButton CmdJogSX 
            Height          =   550
            Index           =   1
            Left            =   120
            Picture         =   "FrmSiloGenerale.frx":974D1
            Style           =   1  'Graphical
            TabIndex        =   107
            Top             =   180
            Width           =   550
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000F&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Index           =   103
            Left            =   2040
            Locked          =   -1  'True
            TabIndex        =   106
            Text            =   "0"
            Top             =   360
            Width           =   855
         End
         Begin VB.CommandButton CmdEnableJog 
            Height          =   550
            Index           =   1
            Left            =   1320
            Style           =   1  'Graphical
            TabIndex        =   105
            Top             =   180
            Width           =   550
         End
      End
      Begin VB.Frame FrameSiloS7 
         Height          =   1665
         Index           =   6
         Left            =   4200
         TabIndex        =   96
         Top             =   4470
         Width           =   4000
         Begin VB.CommandButton CmdSyncroBennaAsse 
            Height          =   550
            Index           =   1
            Left            =   960
            Picture         =   "FrmSiloGenerale.frx":9819B
            Style           =   1  'Graphical
            TabIndex        =   103
            Top             =   180
            Width           =   550
         End
         Begin MSComctlLib.Slider SliderPosAsse2 
            Height          =   435
            Left            =   120
            TabIndex        =   99
            Top             =   1130
            Width           =   3730
            _ExtentX        =   6588
            _ExtentY        =   767
            _Version        =   393216
            Enabled         =   0   'False
            Max             =   50000
            TickFrequency   =   1000
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000F&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Index           =   100
            Left            =   2160
            Locked          =   -1  'True
            TabIndex        =   98
            Text            =   "0"
            Top             =   840
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000F&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Index           =   101
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   97
            Text            =   "0"
            Top             =   840
            Width           =   855
         End
         Begin VB.Image ImgSpruzzaAntiadesivoAux 
            Height          =   360
            Left            =   2400
            Picture         =   "FrmSiloGenerale.frx":98CDD
            Stretch         =   -1  'True
            Top             =   360
            Visible         =   0   'False
            Width           =   465
         End
         Begin VB.Image imgStatoBennaAsse 
            Height          =   555
            Index           =   1
            Left            =   240
            Top             =   180
            Width           =   555
         End
         Begin VB.Label LblSiloS7 
            AutoSize        =   -1  'True
            Caption         =   "m/sec"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   270
            Index           =   3
            Left            =   3120
            TabIndex        =   101
            Top             =   840
            Width           =   630
         End
         Begin VB.Label LblSiloS7 
            AutoSize        =   -1  'True
            Caption         =   "Quota"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   270
            Index           =   1
            Left            =   1080
            TabIndex        =   100
            Top             =   840
            Width           =   630
         End
      End
      Begin VB.Frame FrameSiloS7 
         BorderStyle     =   0  'None
         Height          =   2775
         Index           =   3
         Left            =   150
         TabIndex        =   75
         Top             =   480
         Width           =   12645
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   1
            Left            =   360
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   2
            Left            =   1320
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   3
            Left            =   2385
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   4
            Left            =   3435
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   5
            Left            =   4515
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   6
            Left            =   5475
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   7
            Left            =   6315
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   8
            Left            =   7635
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   9
            Left            =   8625
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   10
            Left            =   9600
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   11
            Left            =   10755
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image imgLivAlto 
            Height          =   480
            Index           =   12
            Left            =   11835
            Top             =   30
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   9
            Left            =   9840
            TabIndex        =   155
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   10
            Left            =   10800
            TabIndex        =   154
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "10"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   10
            Left            =   9645
            TabIndex        =   143
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "9"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   9
            Left            =   8685
            TabIndex        =   142
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   360
            TabIndex        =   85
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   1365
            TabIndex        =   84
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "3"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   3
            Left            =   2445
            TabIndex        =   83
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "4"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   4
            Left            =   3495
            TabIndex        =   82
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "5"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   5
            Left            =   4575
            TabIndex        =   81
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "6"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   6
            Left            =   5535
            TabIndex        =   80
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "7"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   7
            Left            =   6375
            TabIndex        =   79
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "8"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   8
            Left            =   7695
            TabIndex        =   78
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "D"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   11
            Left            =   10815
            TabIndex        =   77
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblNumeroSilo 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "R"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   14.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   12
            Left            =   11895
            TabIndex        =   76
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   8
            Left            =   6960
            TabIndex        =   95
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   7
            Left            =   6000
            TabIndex        =   94
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   6
            Left            =   5040
            TabIndex        =   93
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   5
            Left            =   4080
            TabIndex        =   92
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   4
            Left            =   3120
            TabIndex        =   91
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   3
            Left            =   2160
            TabIndex        =   90
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   2
            Left            =   1080
            TabIndex        =   89
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   1
            Left            =   30
            TabIndex        =   88
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   11
            Left            =   7920
            TabIndex        =   87
            Top             =   2085
            Width           =   945
         End
         Begin VB.Label LblTipoMaterialeS 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Microsoft Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000000&
            Height          =   645
            Index           =   12
            Left            =   8880
            TabIndex        =   86
            Top             =   2085
            Width           =   945
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   1
            Left            =   0
            Picture         =   "FrmSiloGenerale.frx":995A7
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   2
            Left            =   1050
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   3
            Left            =   2100
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   4
            Left            =   3150
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   5
            Left            =   4200
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   6
            Left            =   5250
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   7
            Left            =   6300
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   8
            Left            =   7350
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   11
            Left            =   10500
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   10
            Left            =   9450
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   9
            Left            =   8400
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
         Begin VB.Image ImageSilo 
            Height          =   1950
            Index           =   12
            Left            =   11550
            Stretch         =   -1  'True
            Top             =   30
            Width           =   930
         End
      End
      Begin VB.Frame FrameSiloS7 
         BorderStyle     =   0  'None
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   60
         Top             =   3240
         Width           =   12615
         Begin VB.PictureBox Picture1 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   240
            Index           =   1
            Left            =   360
            Picture         =   "FrmSiloGenerale.frx":9ACE9
            ScaleHeight     =   240
            ScaleWidth      =   480
            TabIndex        =   61
            Top             =   0
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Label LblUnitaTemp 
            BackStyle       =   0  'Transparent
            Caption         =   "ºC"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   0
            TabIndex        =   74
            Top             =   0
            Width           =   375
         End
         Begin VB.Label LblPirometro 
            Appearance      =   0  'Flat
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Temp 6"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   270
            Index           =   6
            Left            =   10500
            TabIndex        =   73
            Top             =   240
            Visible         =   0   'False
            Width           =   1545
         End
         Begin VB.Label LblPirometro 
            Appearance      =   0  'Flat
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Temp 5"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   270
            Index           =   5
            Left            =   8400
            TabIndex        =   72
            Top             =   240
            Visible         =   0   'False
            Width           =   1545
         End
         Begin VB.Label LblPirometro 
            Appearance      =   0  'Flat
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Temp 4"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   270
            Index           =   4
            Left            =   6300
            TabIndex        =   71
            Top             =   240
            Visible         =   0   'False
            Width           =   1545
         End
         Begin VB.Label LblPirometro 
            Appearance      =   0  'Flat
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Temp 3"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   270
            Index           =   3
            Left            =   4200
            TabIndex        =   70
            Top             =   240
            Visible         =   0   'False
            Width           =   1545
         End
         Begin VB.Label LblPirometro 
            Appearance      =   0  'Flat
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Temp 2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   270
            Index           =   2
            Left            =   2100
            TabIndex        =   69
            Top             =   240
            Visible         =   0   'False
            Width           =   1545
         End
         Begin VB.Label LblPirometro 
            Appearance      =   0  'Flat
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Temp 1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   270
            Index           =   1
            Left            =   0
            TabIndex        =   68
            Top             =   240
            Visible         =   0   'False
            Width           =   1545
         End
         Begin VB.Label LblTempSilo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFC0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   285
            Index           =   6
            Left            =   12030
            TabIndex        =   67
            Top             =   240
            Visible         =   0   'False
            Width           =   495
         End
         Begin VB.Label LblTempSilo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFC0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   285
            Index           =   5
            Left            =   9930
            TabIndex        =   66
            Top             =   240
            Visible         =   0   'False
            Width           =   495
         End
         Begin VB.Label LblTempSilo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFC0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   285
            Index           =   4
            Left            =   7830
            TabIndex        =   65
            Top             =   240
            Visible         =   0   'False
            Width           =   495
         End
         Begin VB.Label LblTempSilo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFC0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   285
            Index           =   3
            Left            =   5730
            TabIndex        =   64
            Top             =   240
            Visible         =   0   'False
            Width           =   495
         End
         Begin VB.Label LblTempSilo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFC0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   285
            Index           =   2
            Left            =   3630
            TabIndex        =   63
            Top             =   240
            Visible         =   0   'False
            Width           =   495
         End
         Begin VB.Label LblTempSilo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00FFFFC0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   285
            Index           =   1
            Left            =   1530
            TabIndex        =   62
            Top             =   240
            Visible         =   0   'False
            Width           =   495
         End
      End
      Begin VB.Frame FrameSiloS7 
         Height          =   5820
         Index           =   1
         Left            =   -74880
         TabIndex        =   17
         Top             =   320
         Width           =   5055
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   9
            Left            =   840
            TabIndex        =   151
            Text            =   "0"
            Top             =   4150
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   10
            Left            =   840
            TabIndex        =   150
            Text            =   "0"
            Top             =   4550
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   9
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   149
            Top             =   4150
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   10
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   148
            Top             =   4550
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   110
            Left            =   3360
            TabIndex        =   147
            Text            =   "0"
            Top             =   4550
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   109
            Left            =   3360
            TabIndex        =   146
            Text            =   "0"
            Top             =   4150
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   210
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   145
            Top             =   4550
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   209
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   144
            Top             =   4150
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosD 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   139
            Top             =   150
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosR 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   138
            Top             =   550
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   201
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   137
            Top             =   950
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   202
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   136
            Top             =   1350
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   203
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   135
            Top             =   1750
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   204
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   134
            Top             =   2150
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   205
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   133
            Top             =   2550
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   206
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   132
            Top             =   2950
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   207
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   131
            Top             =   3350
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   208
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   130
            Top             =   3750
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosAd1 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   129
            Top             =   4950
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosAd2 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   4320
            Style           =   1  'Graphical
            TabIndex        =   128
            Top             =   5350
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.TextBox TxtSiloS7PosD 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   1
            Left            =   3360
            TabIndex        =   127
            Text            =   "0"
            Top             =   150
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7PosR 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   1
            Left            =   3360
            TabIndex        =   126
            Text            =   "0"
            Top             =   550
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   102
            Left            =   3360
            TabIndex        =   125
            Text            =   "0"
            Top             =   1350
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   103
            Left            =   3360
            TabIndex        =   124
            Text            =   "0"
            Top             =   1750
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   104
            Left            =   3360
            TabIndex        =   123
            Text            =   "0"
            Top             =   2150
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   105
            Left            =   3360
            TabIndex        =   122
            Text            =   "0"
            Top             =   2550
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   106
            Left            =   3360
            TabIndex        =   121
            Text            =   "0"
            Top             =   2950
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   107
            Left            =   3360
            TabIndex        =   120
            Text            =   "0"
            Top             =   3350
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   108
            Left            =   3360
            TabIndex        =   119
            Text            =   "0"
            Top             =   3750
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7PosizioneAntiadesivoAux 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   1
            Left            =   3360
            TabIndex        =   118
            Text            =   "0"
            Top             =   5350
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7PosizioneAntiadesivoMain 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   1
            Left            =   3360
            TabIndex        =   117
            Text            =   "0"
            Top             =   4950
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   101
            Left            =   3360
            TabIndex        =   116
            Text            =   "0"
            Top             =   950
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   1
            Left            =   840
            TabIndex        =   41
            Text            =   "0"
            Top             =   950
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosAd2 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   40
            Top             =   5350
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosAd1 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   39
            Top             =   4950
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.TextBox TxtSiloS7PosizioneAntiadesivoMain 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   0
            Left            =   840
            TabIndex        =   38
            Text            =   "0"
            Top             =   4950
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7PosizioneAntiadesivoAux 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   0
            Left            =   840
            TabIndex        =   37
            Text            =   "0"
            Top             =   5350
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   8
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   36
            Top             =   3750
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   7
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   35
            Top             =   3350
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   6
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   34
            Top             =   2950
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   5
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   33
            Top             =   2550
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   4
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   32
            Top             =   2150
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   3
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   31
            Top             =   1750
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   2
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   30
            Top             =   1350
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPos 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   29
            Top             =   950
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosR 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   28
            Top             =   550
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.CommandButton CmdSiloS7SalvaPosD 
            BackColor       =   &H00808080&
            Caption         =   "POS"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   27
            Top             =   150
            Visible         =   0   'False
            Width           =   600
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   8
            Left            =   840
            TabIndex        =   26
            Text            =   "0"
            Top             =   3750
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   7
            Left            =   840
            TabIndex        =   25
            Text            =   "0"
            Top             =   3350
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   6
            Left            =   840
            TabIndex        =   24
            Text            =   "0"
            Top             =   2950
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   5
            Left            =   840
            TabIndex        =   23
            Text            =   "0"
            Top             =   2550
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   4
            Left            =   840
            TabIndex        =   22
            Text            =   "0"
            Top             =   2150
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   3
            Left            =   840
            TabIndex        =   21
            Text            =   "0"
            Top             =   1750
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7Pos 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   2
            Left            =   840
            TabIndex        =   20
            Text            =   "0"
            Top             =   1350
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7PosR 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   0
            Left            =   840
            TabIndex        =   19
            Text            =   "0"
            Top             =   550
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7PosD 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   0
            Left            =   840
            TabIndex        =   18
            Text            =   "0"
            Top             =   150
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""9"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   110
            Left            =   1800
            TabIndex        =   153
            Top             =   4150
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""10"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   111
            Left            =   1800
            TabIndex        =   152
            Top             =   4550
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Antiadesivo 1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   112
            Left            =   1800
            TabIndex        =   53
            Top             =   4950
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Antiadesivo 2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   113
            Left            =   1800
            TabIndex        =   52
            Top             =   5350
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""8"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   109
            Left            =   1800
            TabIndex        =   51
            Top             =   3750
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""7"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   108
            Left            =   1800
            TabIndex        =   50
            Top             =   3350
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""6"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   107
            Left            =   1800
            TabIndex        =   49
            Top             =   2950
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""5"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   106
            Left            =   1800
            TabIndex        =   48
            Top             =   2550
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""4"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   105
            Left            =   1800
            TabIndex        =   47
            Top             =   2150
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""3"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   104
            Left            =   1800
            TabIndex        =   46
            Top             =   1750
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""2"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   103
            Left            =   1800
            TabIndex        =   45
            Top             =   1350
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""D"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   100
            Left            =   1800
            TabIndex        =   44
            Top             =   150
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""R"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   101
            Left            =   1800
            TabIndex        =   43
            Top             =   550
            Visible         =   0   'False
            Width           =   1500
         End
         Begin VB.Label LblSiloS7 
            Alignment       =   2  'Center
            Caption         =   "Silo ""1"""
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   360
            Index           =   102
            Left            =   1800
            TabIndex        =   42
            Top             =   950
            Visible         =   0   'False
            Width           =   1500
         End
      End
      Begin VB.Frame FrameSiloS7 
         Height          =   855
         Index           =   5
         Left            =   -69800
         TabIndex        =   14
         Top             =   1920
         Width           =   3855
         Begin VB.CommandButton CmdEnableJog 
            Height          =   550
            Index           =   0
            Left            =   1320
            Style           =   1  'Graphical
            TabIndex        =   55
            Top             =   180
            Width           =   550
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000F&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Index           =   3
            Left            =   2040
            Locked          =   -1  'True
            TabIndex        =   54
            Text            =   "0"
            Top             =   360
            Width           =   855
         End
         Begin VB.CommandButton CmdJogSX 
            Height          =   550
            Index           =   0
            Left            =   120
            Picture         =   "FrmSiloGenerale.frx":9B373
            Style           =   1  'Graphical
            TabIndex        =   16
            Top             =   180
            Width           =   550
         End
         Begin VB.CommandButton CmdJogDX 
            Height          =   550
            Index           =   0
            Left            =   720
            Picture         =   "FrmSiloGenerale.frx":9C03D
            Style           =   1  'Graphical
            TabIndex        =   15
            Top             =   180
            Width           =   550
         End
      End
      Begin VB.Frame FrameSiloS7 
         Height          =   1695
         Index           =   4
         Left            =   120
         TabIndex        =   8
         Top             =   4470
         Width           =   4000
         Begin VB.CommandButton CmdSyncroBennaAsse 
            Height          =   550
            Index           =   0
            Left            =   960
            Picture         =   "FrmSiloGenerale.frx":9CD07
            Style           =   1  'Graphical
            TabIndex        =   102
            Top             =   180
            Width           =   555
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000F&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Index           =   1
            Left            =   120
            Locked          =   -1  'True
            TabIndex        =   10
            Text            =   "0"
            Top             =   840
            Width           =   855
         End
         Begin VB.TextBox TxtSiloS7 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H8000000F&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Index           =   0
            Left            =   2160
            Locked          =   -1  'True
            TabIndex        =   9
            Text            =   "0"
            Top             =   840
            Width           =   855
         End
         Begin MSComctlLib.Slider SliderPosAsse1 
            Height          =   435
            Left            =   120
            TabIndex        =   11
            Top             =   1130
            Width           =   3730
            _ExtentX        =   6588
            _ExtentY        =   767
            _Version        =   393216
            Enabled         =   0   'False
            Max             =   50000
            TickFrequency   =   1000
         End
         Begin VB.Image ImgSpruzzaAntiadesivoMain 
            Height          =   360
            Left            =   2400
            Picture         =   "FrmSiloGenerale.frx":9D849
            Stretch         =   -1  'True
            Top             =   360
            Visible         =   0   'False
            Width           =   465
         End
         Begin VB.Label LblSiloS7 
            AutoSize        =   -1  'True
            Caption         =   "Quota"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   270
            Index           =   18
            Left            =   1080
            TabIndex        =   13
            Top             =   840
            Width           =   630
         End
         Begin VB.Label LblSiloS7 
            AutoSize        =   -1  'True
            Caption         =   "m/sec"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   270
            Index           =   0
            Left            =   3120
            TabIndex        =   12
            Top             =   840
            Width           =   630
         End
         Begin VB.Image imgStatoBennaAsse 
            Height          =   555
            Index           =   0
            Left            =   240
            Top             =   180
            Width           =   555
         End
      End
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   9750
      Picture         =   "FrmSiloGenerale.frx":9E113
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   3
      Left            =   75
      Picture         =   "FrmSiloGenerale.frx":9E73A
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   10800
      Picture         =   "FrmSiloGenerale.frx":9ED54
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   11925
      Picture         =   "FrmSiloGenerale.frx":9F3A2
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "FrmSiloGenerale"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Enum TopBarButtonEnum
    uscita
    Help
    Login
    Salva
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
Private Const SEZIONE As String = "Sili"
'


Private Sub CmdAutoMan_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    
    Call SetStatoSiloS7AutoMan
    
End Sub

Private Function IsModified() As Boolean

    Dim indice As Integer

    IsModified = True

    If (SiloS7PosizioneSiloD <> val(TxtSiloS7PosD(0).text) Or Silo2S7PosizioneSiloD <> val(TxtSiloS7PosD(1).text)) Then
        Exit Function
    End If

    If (SiloS7PosizioneSiloR <> val(TxtSiloS7PosR(0).text) Or Silo2S7PosizioneSiloR <> val(TxtSiloS7PosR(1).text)) Then
        Exit Function
    End If

    For indice = 1 To 8
        If (SiloS7PosizioneSilo(indice) <> val(TxtSiloS7Pos(indice).text) Or Silo2S7PosizioneSilo(indice) <> val(TxtSiloS7Pos(100 + indice).text)) Then
            Exit Function
        End If
    Next indice

    If (SiloS7Posizione1AntiadesivoMain <> val(TxtSiloS7PosizioneAntiadesivoMain(0).text) Or SiloS7Posizione2AntiadesivoMain <> val(TxtSiloS7PosizioneAntiadesivoMain(1).text)) Then
        Exit Function
    End If
    If (SiloS7Posizione1AntiadesivoAux <> val(TxtSiloS7PosizioneAntiadesivoAux(0).text) Or SiloS7Posizione2AntiadesivoAux <> val(TxtSiloS7PosizioneAntiadesivoAux(1).text)) Then
        Exit Function
    End If
'

    IsModified = False

End Function

Private Sub CopyValues()

    Dim indice As Integer

    SiloS7PosizioneSiloD = val(TxtSiloS7PosD(0).text)
    Silo2S7PosizioneSiloD = val(TxtSiloS7PosD(1).text)

    SiloS7PosizioneSiloR = val(TxtSiloS7PosR(0).text)
    Silo2S7PosizioneSiloR = val(TxtSiloS7PosR(1).text)

    For indice = 1 To 10
        SiloS7PosizioneSilo(indice) = val(TxtSiloS7Pos(indice).text)
        Silo2S7PosizioneSilo(indice) = val(TxtSiloS7Pos(100 + indice).text)
    Next indice

    SiloS7Posizione1AntiadesivoMain = val(TxtSiloS7PosizioneAntiadesivoMain(0).text)
    SiloS7Posizione2AntiadesivoMain = val(TxtSiloS7PosizioneAntiadesivoMain(1).text)
    SiloS7Posizione1AntiadesivoAux = val(TxtSiloS7PosizioneAntiadesivoAux(0).text)
    SiloS7Posizione2AntiadesivoAux = val(TxtSiloS7PosizioneAntiadesivoAux(1).text)
    '

End Sub


Public Sub CmdStart_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_MEMSALITABENNA).Value = True
    End If

End Sub


'20150420
'Private Sub CmdEnableJog_Click(Index As Integer)
Private Sub CmdEnableJog_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Call SetStatoSiloS7Jog
            
    
End Sub

Private Sub CmdJogDX_LostFocus(Index As Integer)

    Select Case Index
        Case 0:
            CP240.OPCData.items(PLCTAG_DB322_Jog_DX).Value = False
        Case 1:
            CP240.OPCData.items(PLCTAG_SILO2_Jog_DX).Value = False
    End Select

End Sub

Private Sub CmdJogDX_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Select Case Index
        Case 0:
            CP240.OPCData.items(PLCTAG_DB322_Jog_DX).Value = True
        Case 1:
            CP240.OPCData.items(PLCTAG_SILO2_Jog_DX).Value = True
    End Select

End Sub

Private Sub CmdJogDX_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    
    Select Case Index
        Case 0:
            CP240.OPCData.items(PLCTAG_DB322_Jog_DX).Value = False
        Case 1:
            CP240.OPCData.items(PLCTAG_SILO2_Jog_DX).Value = False
    End Select

End Sub

Private Sub CmdJogSX_LostFocus(Index As Integer)

    Select Case Index
        Case 0:
            CP240.OPCData.items(PLCTAG_DB322_Jog_SX).Value = False
        Case 1:
            CP240.OPCData.items(PLCTAG_SILO2_Jog_SX).Value = False
    End Select

End Sub

Private Sub CmdJogSX_Mousedown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Select Case Index
        Case 0:
            CP240.OPCData.items(PLCTAG_DB322_Jog_SX).Value = True
        Case 1:
            CP240.OPCData.items(PLCTAG_SILO2_Jog_SX).Value = True
    End Select

End Sub

Private Sub CmdJogSX_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Select Case Index
        Case 0:
            CP240.OPCData.items(PLCTAG_DB322_Jog_SX).Value = False
        Case 1:
            CP240.OPCData.items(PLCTAG_SILO2_Jog_SX).Value = False
    End Select

End Sub

Public Sub PasswordLevel()

    Select Case ActiveUser
        Case UsersEnum.OPERATOR To UsersEnum.SUPERUSER
            TabSilo.TabVisible(1) = InclusioneSiloS7
            imgPulsanteForm(TopBarButtonEnum.Salva).Visible = InclusioneSiloS7
            imgPulsanteForm(TopBarButtonEnum.Salva).enabled = True

        Case Else
            imgPulsanteForm(TopBarButtonEnum.Salva).enabled = False
    End Select

End Sub

Private Sub CmdSiloS7SalvaPosD_Click(Index As Integer)

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) <> vbOK) Then
        Exit Sub
    End If

    Select Case Index
        Case 0:
            TxtSiloS7PosD(0).text = SiloS7Posizione
            SiloS7PosizioneSiloD = SiloS7Posizione
        Case 1:
            SiloS7PosizioneSiloD = val(TxtSiloS7PosD(0).text)
        Case 2:
            Silo2S7PosizioneSiloD = Silo2S7Posizione
        Case 3:
            Silo2S7PosizioneSiloD = val(TxtSiloS7PosD(1).text)
    End Select

End Sub

Private Sub CmdSiloS7SalvaPosR_Click(Index As Integer)

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) <> vbOK) Then
        Exit Sub
    End If
    
    Select Case Index
        Case 0:
            SiloS7PosizioneSiloR = SiloS7Posizione
        Case 1:
            SiloS7PosizioneSiloR = val(TxtSiloS7PosR(0).text)
        Case 2:
            Silo2S7PosizioneSiloR = Silo2S7Posizione
        Case 3:
            Silo2S7PosizioneSiloR = val(TxtSiloS7PosR(1).text)
    End Select

End Sub

Private Sub CmdSiloS7SalvaPos_Click(Index As Integer)

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) <> vbOK) Then
        Exit Sub
    End If
    
    If (Index > 0 And Index <= 10) Then
        SiloS7PosizioneSilo(Index) = SiloS7Posizione
        TxtSiloS7Pos(Index).text = SiloS7Posizione
    ElseIf (Index > 100 And Index <= 110) Then
        SiloS7PosizioneSilo(Index - 100) = val(TxtSiloS7Pos(Index - 100).text)
        TxtSiloS7Pos(Index).text = SiloS7Posizione
    ElseIf (Index > 200 And Index <= 210) Then
        Silo2S7PosizioneSilo(Index - 200) = Silo2S7Posizione
        TxtSiloS7Pos(Index - 100).text = Silo2S7Posizione
    End If

End Sub

Private Sub CmdSiloS7SalvaPosAd1_Click(Index As Integer)

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) <> vbOK) Then
        Exit Sub
    End If
    
    Select Case Index
        Case 0:
            SiloS7Posizione1AntiadesivoMain = SiloS7Posizione
        Case 1:
            SiloS7Posizione1AntiadesivoMain = Silo2S7Posizione
    End Select
    
    TxtSiloS7PosizioneAntiadesivoMain(Index).text = SiloS7Posizione1AntiadesivoMain

End Sub

Private Sub CmdSiloS7SalvaPosAd2_Click(Index As Integer)

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) <> vbOK) Then
        Exit Sub
    End If

    Select Case Index
        Case 0:
            SiloS7Posizione1AntiadesivoAux = SiloS7Posizione
        Case 1:
            SiloS7Posizione1AntiadesivoAux = Silo2S7Posizione
    End Select
    
    TxtSiloS7PosizioneAntiadesivoAux(Index).text = SiloS7Posizione1AntiadesivoAux

End Sub

'20150420
Public Sub CmdStop_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
               
    Call SetStatoSiloS7Stop
              		  
End Sub

Private Sub CmdSU_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE2).Value = True
        CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE2).Value = False
        CP240.TimerResetCmdSilo.enabled = True
    End If

End Sub

Private Sub CmdGIU_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE2).Value = False
        CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE2).Value = True
        CP240.TimerResetCmdSilo.enabled = True
    End If

End Sub

Private Sub CmdSX_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = True
        CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
        CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = False
        CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = False
        CP240.TimerResetCmdSilo.enabled = True
    End If

End Sub

Private Sub CmdDX_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
        CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = True
        CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = False
        CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = False
        CP240.TimerResetCmdSilo.enabled = True
    End If

End Sub

Public Sub CmdSyncroBennaAsse_Click(Index As Integer)

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then

        Select Case Index
            Case 0
                CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
                CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
                CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = False
                CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = False
                CP240.OPCData.items(PLCTAG_DB307_StartSyncro).Value = True
                CP240.TimerResetCmdSilo.enabled = True

            Case 1
                CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE2).Value = False
                CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE2).Value = False
                CP240.OPCData.items(PLCTAG_SILO2_ManuApre).Value = False
                CP240.OPCData.items(PLCTAG_SILO2_ManuChiude).Value = False
                CP240.OPCData.items(PLCTAG_SILO2_StartSyncro).Value = True
                CP240.TimerResetCmdSilo.enabled = True
        End Select

    End If

End Sub

Private Sub CmdApriBenna_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
        CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
        CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = True
        CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = False
        CP240.TimerResetCmdSilo.enabled = True
    End If
    
End Sub


Private Sub CmdChiudiBenna_Click()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
        CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
        CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = False
        CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = True
        CP240.TimerResetCmdSilo.enabled = True
    End If
    
End Sub

Public Sub PosizionaSili()
	'Posizionamento oggetti dei sili in FrmSiloGenerale
	'1. Botte silo              --> ImageSilo(1..12)
	'2. Numero silo             --> LblNumeroSilo(1..12)
	'3. Livello alto            --> imgLivAlto(1..12)
	'4. Scarico silo            --> imageScaricoSilo(1..12)

	Dim i As Integer
	Dim numerosilo As Integer
	Dim Postop As Integer
	Dim PosLeft As Integer
	Dim Spaziatura As Integer

    'Nascondo tutti gli oggetti grafici utilizzati per la rappresentazione dei sili
    For i = 1 To MAXNUMSILI
        ImageSilo(i).Visible = False
        LblNumeroSilo(i).Visible = False
        imgLivAlto(i).Visible = False
'        imageScaricoSilo(i).Visible = False    '20160216
        LblTipoMaterialeS(i).Visible = False
    Next i
    
    'Posiziono le parti
    Postop = 30 'Twips
    PosLeft = 0 'Twips
    Spaziatura = Pixel2Twips(70)
    For i = 1 To Len(ConfigSilo)
        numerosilo = GetSiloIndex(GetSiloFromConfigSilo(i))
        ImageSilo(numerosilo).Visible = True
        ImageSilo(numerosilo).top = Postop
        ImageSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura)
        LblNumeroSilo(numerosilo).Visible = True
        LblNumeroSilo(numerosilo).top = Postop + Pixel2Twips(53)
        LblNumeroSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + Pixel2Twips(19)
        imgLivAlto(numerosilo).top = Postop
        imgLivAlto(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + Pixel2Twips(15)
        imgLivAlto(numerosilo).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
        
'20160218
'        imageScaricoSilo(numerosilo).top = Postop + Pixel2Twips(98)
'        imageScaricoSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + Pixel2Twips(15)
'        imageScaricoSilo(numerosilo).Picture = LoadResPicture("IDI_DITOGIU", vbResIcon)
'
       
        LblTipoMaterialeS(numerosilo).Visible = True
        LblTipoMaterialeS(numerosilo).top = Postop + ImageSilo(numerosilo).Height + Pixel2Twips(5)
        LblTipoMaterialeS(numerosilo).left = PosLeft + ((i - 1) * Spaziatura)
        LblTipoMaterialeS(numerosilo).width = ImageSilo(numerosilo).width + ((Spaziatura - ImageSilo(numerosilo).width) / 2)
    Next i

'20130610
'    Width = IIf((Len(ConfigSilo) < 9), 9910, 13010)
    width = IIf((Len(ConfigSilo) < 9) And Not InclusioneSilo2S7, 9910, 13080)
    
    FrameSiloS7(9).left = IIf((Len(ConfigSilo) < 9) And Not InclusioneSilo2S7, 4800, 8280)
'20130930
    FrameSiloS7(9).Visible = InclusioneSiloS7
'
    FrameSiloS7(10).width = IIf((Len(ConfigSilo) < 9) And Not InclusioneSilo2S7, 4560, 7695)
    shAreaGrPosNav(1).width = IIf((Len(ConfigSilo) < 9) And Not InclusioneSilo2S7, 4300, 7425)
    MemWidthshAreaGrPosNav = IIf((Len(ConfigSilo) < 9) And Not InclusioneSilo2S7, 4300, 7425)
'
    '
    TabSilo.width = (width - 100) / 15

    PosLeft = width - 700

'    CmdEsci.Left = PosLeft / 15
'    PosLeft = PosLeft - 660
'
'    If (AbilitaTemperaturaSilo) Then
'        CmdRicerca.Left = PosLeft / 15
'        PosLeft = PosLeft - 660
'    End If
'
'    CmdSalva.Left = PosLeft / 15
'    PosLeft = PosLeft - 660
'
'    CmdHelp.Left = PosLeft / 15
'    PosLeft = PosLeft - 660


End Sub

Private Sub Form_Activate()
    If (Me.Visible) Then
        Call VisualizzaBarraPulsantiCP240(False)
    End If
End Sub

Public Sub ShowMe(ByRef parente As Form)

    If (FrmSiloGeneraleVisibile) Then
        Exit Sub
    End If
        
    On Error GoTo ModelessError
    
    FrmSiloGeneraleVisibile = True
    
    Call PasswordLevel
    Call UpdatePulsantiForm
    
    Me.Show vbModeless, parente

    Exit Sub

ModelessError:
    '   Ha dato errore la visualizzazione modeless per cui provo con quella modal
    Me.Show vbModal

End Sub

Private Sub Form_Load()

    Dim indice As Integer
    Dim silo As String
    Dim siloNum As Integer
    Dim etichettaTemperatura As String

    Call CarattereOccidentale(Me)

    Me.caption = CaptionStart + LoadXLSString(797)

    etichettaTemperatura = LoadXLSString(698)
    LblPirometro(1).caption = etichettaTemperatura + " 1"
    LblPirometro(2).caption = etichettaTemperatura + " 2"
    LblPirometro(3).caption = etichettaTemperatura + " 3"
    LblPirometro(4).caption = etichettaTemperatura + " 4"
    LblPirometro(5).caption = etichettaTemperatura + " 5"
    LblPirometro(6).caption = etichettaTemperatura + " 6"
    LblUnitaTemp.caption = LoadXLSString(725)

    '20160218
    LblSiloS7(100).caption = LoadXLSString(332) + " 'D'"
    LblSiloS7(101).caption = LoadXLSString(332) + " 'R'"
    LblSiloS7(102).caption = LoadXLSString(332) + " 1"
    LblSiloS7(103).caption = LoadXLSString(332) + " 2"
    LblSiloS7(104).caption = LoadXLSString(332) + " 3"
    LblSiloS7(105).caption = LoadXLSString(332) + " 4"
    LblSiloS7(106).caption = LoadXLSString(332) + " 5"
    LblSiloS7(107).caption = LoadXLSString(332) + " 6"
    LblSiloS7(108).caption = LoadXLSString(332) + " 7"
    LblSiloS7(109).caption = LoadXLSString(332) + " 8"
    LblSiloS7(110).caption = LoadXLSString(332) + " 9"
    LblSiloS7(111).caption = LoadXLSString(332) + " 10"
    CmdSiloS7SalvaPosD(0).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosD(2).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosR(0).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosR(2).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(1).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(2).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(3).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(4).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(5).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(6).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(7).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(8).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(9).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(10).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(201).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(202).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(203).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(204).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(205).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(206).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(207).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(208).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(209).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPos(210).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosAd1(0).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosAd1(1).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosAd2(0).caption = LoadXLSString(1516)
    CmdSiloS7SalvaPosAd2(1).caption = LoadXLSString(1516)

    LblSiloS7(112).caption = LoadXLSString(1517) + IIf(InclusioneSilo2S7, " 1", "")
    LblSiloS7(113).caption = LoadXLSString(1517) + " 2"
    LblSiloS7(40).caption = LoadXLSString(1517) + IIf(InclusioneSilo2S7, " 1", "")
    LblSiloS7(50).caption = LoadXLSString(1517) + " 2"

    LblSiloS7(2).caption = LoadXLSString(1518)
    LblSiloS7(10).caption = LoadXLSString(1518)
    LblSiloS7(7).caption = LoadXLSString(1519)
    LblSiloS7(6).caption = LoadXLSString(1519)
    LblSiloS7(8).caption = LoadXLSString(1520)
    LblSiloS7(5).caption = LoadXLSString(1520)

    FrameSiloS7(0).caption = IIf(InclusioneSilo2S7, LoadXLSString(584), "")
    FrameSiloS7(8).caption = LoadXLSString(585)
    '

    imgPulsanteForm(TopBarButtonEnum.uscita).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(TopBarButtonEnum.Salva).ToolTipText = LoadXLSString(94)
    imgPulsanteForm(TopBarButtonEnum.Login).ToolTipText = LoadXLSString(1100)
    imgPulsanteForm(TopBarButtonEnum.Login).Visible = InclusioneSiloS7
    imgPulsanteForm(TopBarButtonEnum.Help).ToolTipText = LoadXLSString(110)

    CmdAutoMan.Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap) 'IDB_MANUALE
    CP240.CmdAutoManSiloS7.Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
    CmdEnableJog(0).Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
    CmdEnableJog(1).Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
    CmdStop.Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
    CmdStart.Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
    CP240.CmdStopSiloS7.Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
    CP240.CmdStartSiloS7.Picture = LoadResPicture("IDI_MARCIA", vbResIcon)

    CmdChiudiBenna.Picture = LoadResPicture("IDI_NAVETTACHIUSA", vbResIcon)
    CmdApriBenna.Picture = LoadResPicture("IDI_NAVETTAAPERTA", vbResIcon)
    CmdDX.Picture = LoadResPicture("IDI_TOSILO", vbResIcon)
    CmdSX.Picture = LoadResPicture("IDI_FROMSILO", vbResIcon)

    TabSilo.TabVisible(1) = InclusioneSiloS7 And (ActiveUser <> NONE)
    imgPulsanteForm(TopBarButtonEnum.Salva).Visible = InclusioneSiloS7
    imgPulsanteForm(TopBarButtonEnum.Salva).enabled = True

    SiloS7VisualizzaPosSili
    
    VisualizzaSiloAttivo True
    
    Picture1(1).Visible = AbilitaTemperaturaSilo
    LblUnitaTemp.Visible = AbilitaTemperaturaSilo
    For indice = 1 To NumeroPirometriSilo
        LblPirometro(indice).Visible = AbilitaTemperaturaSilo
        LblTempSilo(indice).Visible = AbilitaTemperaturaSilo
    Next indice


    FrameSiloS7(6).Visible = InclusioneSilo2S7
    FrameSiloS7(7).Visible = InclusioneSilo2S7
    FrameSiloS7(8).Visible = InclusioneSilo2S7

    TxtSiloS7PosizioneAntiadesivoMain(0).Visible = True
    CmdSiloS7SalvaPosAd1(0).Visible = True

    TxtSiloS7PosizioneAntiadesivoMain(1).Visible = True
    CmdSiloS7SalvaPosAd1(1).Visible = True
    LblSiloS7(112).Visible = True
    LblSiloS7(113).Visible = InclusioneSilo2S7 '20160218 True

    TxtSiloS7PosizioneAntiadesivoAux(0).Visible = InclusioneSilo2S7
    CmdSiloS7SalvaPosAd2(0).Visible = InclusioneSilo2S7
    TxtSiloS7PosizioneAntiadesivoAux(1).Visible = InclusioneSilo2S7
    CmdSiloS7SalvaPosAd2(1).Visible = InclusioneSilo2S7

    For indice = 1 To Len(ConfigSilo)
        silo = GetSiloFromConfigSilo(indice)
        Select Case silo
            Case "D"
                TxtSiloS7PosD(0).Visible = True
                CmdSiloS7SalvaPosD(0).Visible = True

                LblSiloS7(100).Visible = True

                TxtSiloS7PosD(1).Visible = InclusioneSilo2S7
                CmdSiloS7SalvaPosD(2).Visible = InclusioneSilo2S7
            Case "R"
                TxtSiloS7PosR(0).Visible = True
                CmdSiloS7SalvaPosR(0).Visible = True

                LblSiloS7(101).Visible = True

                TxtSiloS7PosR(1).Visible = InclusioneSilo2S7
                CmdSiloS7SalvaPosR(2).Visible = InclusioneSilo2S7
            Case Else
                siloNum = CInt(GetSiloIndex(silo))

                TxtSiloS7Pos(siloNum).Visible = True
                CmdSiloS7SalvaPos(siloNum).Visible = True

                LblSiloS7(101 + siloNum).Visible = True

                TxtSiloS7Pos(100 + siloNum).Visible = InclusioneSilo2S7
                CmdSiloS7SalvaPos(200 + siloNum).Visible = InclusioneSilo2S7
        End Select
    Next indice
    
    FrameComandiSilo(0).Visible = InclusioneSiloS7
    FrameComandiSilo(2).Visible = InclusioneSilo2S7
    FrameSiloS7(4).Visible = InclusioneSiloS7
        
    Call AbilitaOggettiSiloS7(True) '20150422
    
    If CP240.OPCData.IsConnected Then
        Call SiloS7Leggi(True)
    End If

    For indice = 1 To MAXNUMSILI
        FrmSiloGenerale.LblTipoMaterialeS(indice).caption = ListaSili(indice).materiale
    Next indice

    Me.left = 3000
    Me.top = 4500

    Me.Height = IIf(InclusioneSiloS7, 8625, 7695)

    Call PosizionaSili


    Call DisponiPulsantiPlusForm(Me, 0, TopBarButtonEnum.Login, False, True, 1)

'    For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
'
'        imgPulsanteForm(indice).Left = Me.width - imgPulsanteForm(0).width
'
'    Next indice
    
    
    FrameSiloS7(3).width = Me.width - 200

    For indice = 1 To MAXNUMSILI
        FrmSiloGenerale.imgLivAlto(indice).Visible = ListaSili(indice).LivelloAlto
    Next indice

    LblTempSilo(1).caption = ListaTemperature(TempSilo0).valore
    LblTempSilo(2).caption = ListaTemperature(TempSilo1).valore
    LblTempSilo(3).caption = ListaTemperature(TempSilo2).valore
    LblTempSilo(4).caption = ListaTemperature(TempSilo3).valore
    LblTempSilo(5).caption = ListaTemperature(TempSilo4).valore

    Call PosizionaElementiPosSiloS7
    
    Call UpdatePulsantiForm

    SetStartUpPosition Me, 0 '

End Sub

Public Sub ColoraSilo(silo As Integer, siloAttivo As Boolean, ritornoSilo As Boolean)

    If (ritornoSilo) Then
        ''VERDE
        'ImageSilo(silo).Picture = CP240.PctSilo(1).Picture
        If DestinazioneSilo = silo Then
            'VERDE
            ImageSilo(silo).Picture = PctSilo(1).Picture

            lblPosGraf(silo).BackColor = &HC000&        'verde
            lblPosGraf(silo + 100).BackColor = &HC000&  'verde
        Else
            'ROSSO
            ImageSilo(silo).Picture = PctSilo(3).Picture
        
            lblPosGraf(silo).BackColor = &HFF&          'rosso
            lblPosGraf(silo + 100).BackColor = &HFF&    'rosso
        End If
        '
    ElseIf (siloAttivo) Then
        'GIALLO
        ImageSilo(silo).Picture = PctSilo(2).Picture

        lblPosGraf(silo).BackColor = &HFFFF&            'giallo
        lblPosGraf(silo + 100).BackColor = &HFFFF&      'giallo
    Else
        'BLU
        ImageSilo(silo).Picture = PctSilo(0).Picture

        lblPosGraf(silo).BackColor = &HFFFFFF           'bianco
        lblPosGraf(silo + 100).BackColor = &HFFFFFF     'bianco
    End If

End Sub


Public Sub SiloS7VisualizzaPosSili()

    Dim indice As Integer
    Dim min1 As Double
    Dim max1 As Double
    Dim min2 As Double
    Dim max2 As Double
    Dim posSilo As Double


    TxtSiloS7PosD(0).text = RoundNumber(SiloS7PosizioneSiloD, 2)
    TxtSiloS7PosR(0).text = RoundNumber(SiloS7PosizioneSiloR, 2)
    For indice = 1 To 10
        TxtSiloS7Pos(indice).text = RoundNumber(SiloS7PosizioneSilo(indice), 2)
    Next indice
    TxtSiloS7PosizioneAntiadesivoMain(0).text = RoundNumber(SiloS7Posizione1AntiadesivoMain, 2)
    TxtSiloS7PosizioneAntiadesivoMain(1).text = RoundNumber(SiloS7Posizione2AntiadesivoMain, 2)

    If (InclusioneSilo2S7) Then
        TxtSiloS7PosD(1).text = RoundNumber(Silo2S7PosizioneSiloD, 2)
        TxtSiloS7PosR(1).text = RoundNumber(Silo2S7PosizioneSiloR, 2)
        For indice = 1 To 10
            TxtSiloS7Pos(100 + indice).text = RoundNumber(Silo2S7PosizioneSilo(indice), 2)
        Next indice
        TxtSiloS7PosizioneAntiadesivoAux(0).text = RoundNumber(SiloS7Posizione1AntiadesivoAux, 2)
        TxtSiloS7PosizioneAntiadesivoAux(1).text = RoundNumber(SiloS7Posizione2AntiadesivoAux, 2)
    End If


    'Dimensiono lo slider della posizione benna
    For indice = 1 To Len(ConfigSilo)
        posSilo = SiloS7GetPosizioneSilo(1, GetSiloFromConfigSilo(indice))
        If (posSilo < min1) Then
            min1 = posSilo
        ElseIf (posSilo > max1) Then
            max1 = posSilo
        End If

        If (InclusioneSilo2S7) Then
            posSilo = SiloS7GetPosizioneSilo(2, GetSiloFromConfigSilo(indice))
            If (posSilo < min2) Then
                min2 = posSilo
            ElseIf (posSilo > max2) Then
                max2 = posSilo
            End If
        End If
    Next indice

    If (max1 - min1 = 0) Then
        min1 = -1000
        max1 = 1000
    End If

    'Si genera il runtime 380 quando il minimo (scritto prima del massimo) e' maggiore o uguale al massimo

    If (min1 >= SliderPosAsse1.max) Then
        'caso in cui il minimo risulta maggiore o uguale al massimo dello Slider scrivo prima il massimo
        SliderPosAsse1.max = max1
        SliderPosAsse1.min = min1
        ElseIf (max1 <= SliderPosAsse1.min) Then
            'caso in cui il massimo risulta minore o uguale al minimo dello Slider scrivo prima il minimo
            SliderPosAsse1.min = min1
            SliderPosAsse1.max = max1
            Else
                'caso normale
                SliderPosAsse1.min = min1
                SliderPosAsse1.max = max1
    End If
    'SliderPosAsse1.min = min1
    'SliderPosAsse1.max = max1

    If (InclusioneSilo2S7) Then
        If (max2 - min2 = 0) Then
            min2 = -1000
            max2 = 1000
        End If
        SliderPosAsse2.min = min2
        SliderPosAsse2.max = max2
    End If

End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
    
        Case TopBarButtonEnum.uscita
            If InclusioneSiloS7 Then
                If (IsModified) Then
                    If (ShowMsgBox(LoadXLSString(788), vbYesNo, vbQuestion, -1, -1, True) <> vbOK) Then
                        Exit Sub
                    End If
        
                    Call Salva_Dati
                End If

                If (Not DEMO_VERSION) Then
                    CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
                    CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
                    CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = False
                    CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = False
            
                    CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE2).Value = False
                    CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE2).Value = False
                    CP240.OPCData.items(PLCTAG_SILO2_ManuApre).Value = False
                    CP240.OPCData.items(PLCTAG_SILO2_ManuChiude).Value = False
                End If
            End If

            FrmSiloGeneraleVisibile = False
            Me.Hide
            Unload Me

            CP240.imgPulsanteForm(TBB_DOSAGGIO).enabled = True
            CP240.imgPulsanteForm(TBB_PREDOSAGGIO).enabled = True

            Call VisualizzaBarraPulsantiCP240(True)

        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_SILI_DETTAGLIO

        Case TopBarButtonEnum.Salva
            Call Salva_Dati

        Case TopBarButtonEnum.Login
            Call SendMessagetoPlus(PlusSendShowPASSWORD, 0)
    End Select

End Sub


Private Sub Salva_Dati()

    Call CopyValues
    Call WritePositioneSiloToXml
    Call SiloS7ScriviPosizioni
    Call CalcoloQuotePosGraficaSiloS7
    Call PosizionaElementiPosSiloS7

End Sub


Private Sub TabSilo_Click(PreviousTab As Integer)

    Select Case PreviousTab
        Case 0
            FrameSiloS7(9).Visible = False
            FrameSiloS7(10).Visible = True
        Case 1
            FrameSiloS7(9).Visible = InclusioneSiloS7
            FrameSiloS7(10).Visible = False
    End Select

End Sub

Private Sub TxtSiloS7Pos_Change(Index As Integer)
'20150423
'    TxtSiloS7Pos(Index).text = DatoCorretto(TxtSiloS7Pos(Index).text, 0, -999999, 999999, 1000)
'    If ErroreDatoParametri Then
'        ErroreDatoParametri = False
'    End If
End Sub

'20150423
Private Sub TxtSiloS7Pos_LostFocus(Index As Integer)

    If ((Null2zero(TxtSiloS7Pos(Index).text)) < 0) Then
        TxtSiloS7Pos(Index).text = DatoCorretto(TxtSiloS7Pos(Index).text, 0, -999999, -SiloS7QuotaMinima, 0)
    Else
        TxtSiloS7Pos(Index).text = DatoCorretto(TxtSiloS7Pos(Index).text, 0, SiloS7QuotaMinima, 999999, 0)
    End If
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub
'

'20150423
Private Sub TxtSiloS7PosD_LostFocus(Index As Integer)

    If ((Null2zero(TxtSiloS7PosD(Index).text)) < 0) Then
        TxtSiloS7PosD(Index).text = DatoCorretto(TxtSiloS7PosD(Index).text, 0, -999999, -SiloS7QuotaMinima, 0)
    Else
        TxtSiloS7PosD(Index).text = DatoCorretto(TxtSiloS7PosD(Index).text, 0, SiloS7QuotaMinima, 999999, 0)
    End If
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub
'
'20150423
Private Sub TxtSiloS7PosR_LostFocus(Index As Integer)

    If ((Null2zero(TxtSiloS7PosR(Index).text)) < 0) Then
        TxtSiloS7PosR(Index).text = DatoCorretto(TxtSiloS7PosR(Index).text, 0, -999999, -SiloS7QuotaMinima, 0)
    Else
        TxtSiloS7PosR(Index).text = DatoCorretto(TxtSiloS7PosR(Index).text, 0, SiloS7QuotaMinima, 999999, 0)
    End If
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub
'

Private Sub TxtSiloS7PosizioneAntiadesivoMain_Change(Index As Integer)
    TxtSiloS7PosizioneAntiadesivoMain(Index).text = DatoCorretto(TxtSiloS7PosizioneAntiadesivoMain(Index).text, 0, -999999, 999999, 1000)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub

Private Sub TxtSiloS7PosizioneAntiadesivoAux_Change(Index As Integer)
    TxtSiloS7PosizioneAntiadesivoAux(Index).text = DatoCorretto(TxtSiloS7PosizioneAntiadesivoAux(Index).text, 0, -999999, 999999, 1000)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If
End Sub

Private Sub TxtSiloS7PosD_Change(Index As Integer)
'20150423
'    TxtSiloS7PosD(Index).text = DatoCorretto(TxtSiloS7PosD(Index).text, 0, -999999, 999999, 1000)
'    If ErroreDatoParametri Then
'        ErroreDatoParametri = False
'    End If
End Sub

Private Sub TxtSiloS7PosR_Change(Index As Integer)
'20150423
'    TxtSiloS7PosR(Index).text = DatoCorretto(TxtSiloS7PosR(Index).text, 0, -999999, 999999, 1000)
'    If ErroreDatoParametri Then
'        ErroreDatoParametri = False
'    End If
End Sub

Private Sub PosizionaElementiPosSiloS7()

    Dim i As Integer
    Dim SoloAsseX As Boolean
    Dim PosTemp As Double
    Dim PosTemp2 As Double
                      
    SoloAsseX = (QuotaMinGraficoSiloS7AsseY = 0 And QuotaMaxGraficoSiloS7AsseY = 0)
                      
    If SoloAsseX Then
        For i = 1 To 12
            
            lblPosGraf(i).Visible = VerificaEsistenzaSilo(i)
            lblPosGraf(i + 100).Visible = VerificaEsistenzaSilo(i)
            
            Select Case i
                Case 1 To 10
                    PosTemp = SiloS7PosizioneSilo(i)
                Case 11
                    PosTemp = SiloS7PosizioneSiloD
                Case 12
                    PosTemp = SiloS7PosizioneSiloR
            End Select
           
            lblPosGraf(i).left = Abs(Round(Linearizza(PosTemp, QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, 0, shAreaGrPosNav(0).width - lblPosGraf(i).width), 0)) + shAreaGrPosNav(0).left
            lblPosGraf(i).top = Abs(Round((shAreaGrPosNav(0).Height / 2), 0)) - Round(lblPosGraf(i).Height / 2, 0) + shAreaGrPosNav(0).top
            
            lblPosGraf(i + 100).left = Abs(Round(Linearizza(PosTemp, QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, 0, shAreaGrPosNav(1).width - lblPosGraf(i + 100).width), 0)) + shAreaGrPosNav(1).left
            lblPosGraf(i + 100).top = Abs(Round((shAreaGrPosNav(1).Height / 2), 0)) - Round(lblPosGraf(i + 100).Height / 2, 0) + shAreaGrPosNav(1).top
        
        Next i
    Else
        For i = 1 To 12
            
            lblPosGraf(i).Visible = VerificaEsistenzaSilo(i)
            lblPosGraf(i + 100).Visible = VerificaEsistenzaSilo(i)
            
            Select Case i
                Case 1 To 10
                    PosTemp = SiloS7PosizioneSilo(i)
                    PosTemp2 = Silo2S7PosizioneSilo(i)
                Case 11
                    PosTemp = SiloS7PosizioneSiloD
                    PosTemp2 = Silo2S7PosizioneSiloD
                Case 12
                    PosTemp = SiloS7PosizioneSiloR
                    PosTemp2 = Silo2S7PosizioneSiloR
            End Select
           
            lblPosGraf(i).left = Abs(Round(Linearizza(PosTemp2, QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, 0, shAreaGrPosNav(0).width - lblPosGraf(i).width), 0)) + shAreaGrPosNav(0).left
            lblPosGraf(i).top = Abs(Round(Linearizza(PosTemp, QuotaMinGraficoSiloS7AsseY, QuotaMaxGraficoSiloS7AsseY, 0, shAreaGrPosNav(0).Height - lblPosGraf(i).Height), 0)) + shAreaGrPosNav(0).top
            
            lblPosGraf(i + 100).left = Abs(Round(Linearizza(PosTemp2, QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, 0, shAreaGrPosNav(1).width - lblPosGraf(i + 100).width), 0)) + shAreaGrPosNav(1).left
            lblPosGraf(i + 100).top = Abs(Round(Linearizza(PosTemp, QuotaMinGraficoSiloS7AsseY, QuotaMaxGraficoSiloS7AsseY, 0, shAreaGrPosNav(1).Height - lblPosGraf(i + 100).Height), 0)) + shAreaGrPosNav(1).top

        Next i
    End If
                                                         
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
        Case TopBarButtonEnum.Salva
            prefisso = "PLUS_IMG_SAVE"
        Case TopBarButtonEnum.Login
            prefisso = "PLUS_IMG_LOGIN"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FSG-001", CStr(Err.Number) + " [" + Err.description + "]"
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


