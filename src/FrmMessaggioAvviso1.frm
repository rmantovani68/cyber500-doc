VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmTestPredosatori 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MARINI - Taratura"
   ClientHeight    =   5160
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7215
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
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmMessaggioAvviso1.frx":0000
   ScaleHeight     =   5160
   ScaleWidth      =   7215
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
         NumListImages   =   20
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":89D42
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8A3A0
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8A9E7
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8B03D
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8B693
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8BC5B
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8C210
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8C7D0
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8CD90
            Key             =   "PLUS_IMG_MOTORSTOP"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8D484
            Key             =   "PLUS_IMG_MOTORSTOP_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8DB48
            Key             =   "PLUS_IMG_MOTORSTOP_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8E23C
            Key             =   "PLUS_IMG_MOTORSTOP_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8E92F
            Key             =   "PLUS_IMG_MOTORSTART"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8F017
            Key             =   "PLUS_IMG_MOTORSTART_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8F6C5
            Key             =   "PLUS_IMG_MOTORSTART_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":8FDAD
            Key             =   "PLUS_IMG_MOTORSTART_SELECTED"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":9048E
            Key             =   "PLUS_IMG_LINECHART"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":90978
            Key             =   "PLUS_IMG_LINECHART_GRAY"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":90EC4
            Key             =   "PLUS_IMG_LINECHART_PRESS"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMessaggioAvviso1.frx":9140C
            Key             =   "PLUS_IMG_LINECHART_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
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
      Index           =   0
      Left            =   240
      TabIndex        =   44
      Text            =   "1500"
      Top             =   1080
      Width           =   735
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
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
      Index           =   1
      Left            =   1680
      TabIndex        =   43
      Text            =   "90"
      Top             =   1080
      Width           =   735
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
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
      Left            =   3120
      TabIndex        =   42
      Text            =   "50"
      Top             =   1080
      Width           =   735
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
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
      Index           =   3
      Left            =   5400
      Locked          =   -1  'True
      TabIndex        =   41
      Text            =   "50"
      Top             =   1080
      Width           =   735
   End
   Begin VB.Timer TimerControlloMotori 
      Interval        =   300
      Left            =   4800
      Top             =   240
   End
   Begin VB.Timer TimerProvaPredosatori 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   4440
      Top             =   240
   End
   Begin TabDlg.SSTab SSTabTara 
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   1680
      Width           =   6975
      _ExtentX        =   12303
      _ExtentY        =   5953
      _Version        =   393216
      Tab             =   1
      TabHeight       =   520
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Predosatori"
      TabPicture(0)   =   "FrmMessaggioAvviso1.frx":91957
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "CmbNumPredosatore"
      Tab(0).Control(1)=   "FrameCheckNEF"
      Tab(0).Control(2)=   "TxtNumSecondi"
      Tab(0).Control(3)=   "TxtSet"
      Tab(0).Control(4)=   "lblTempoRimastoPredSec"
      Tab(0).Control(5)=   "ImgMotorTest(0)"
      Tab(0).Control(6)=   "LblNumPredosatore"
      Tab(0).Control(7)=   "LblSec"
      Tab(0).Control(8)=   "LblSet"
      Tab(0).Control(9)=   "Label2(0)"
      Tab(0).Control(10)=   "Label2(2)"
      Tab(0).Control(11)=   "Label2(1)"
      Tab(0).Control(12)=   "Label2(3)"
      Tab(0).Control(13)=   "LblTempoRimastoPred"
      Tab(0).Control(14)=   "ImgMotorTest(1)"
      Tab(0).ControlCount=   15
      TabCaption(1)   =   "Pred. riciclato"
      TabPicture(1)   =   "FrmMessaggioAvviso1.frx":91973
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "ImgMotorTest(3)"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "Label2(7)"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "Label2(5)"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "Label2(6)"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).Control(4)=   "Label2(4)"
      Tab(1).Control(4).Enabled=   0   'False
      Tab(1).Control(5)=   "LblSetRic"
      Tab(1).Control(5).Enabled=   0   'False
      Tab(1).Control(6)=   "LblNumPredRic"
      Tab(1).Control(6).Enabled=   0   'False
      Tab(1).Control(7)=   "LblSecRic"
      Tab(1).Control(7).Enabled=   0   'False
      Tab(1).Control(8)=   "LblTempoRimastoPredRic"
      Tab(1).Control(8).Enabled=   0   'False
      Tab(1).Control(9)=   "ImgMotorTest(2)"
      Tab(1).Control(9).Enabled=   0   'False
      Tab(1).Control(10)=   "LblTempoRimastoPredRicSec"
      Tab(1).Control(10).Enabled=   0   'False
      Tab(1).Control(11)=   "TxtSetRic"
      Tab(1).Control(11).Enabled=   0   'False
      Tab(1).Control(12)=   "TxtSecRic"
      Tab(1).Control(12).Enabled=   0   'False
      Tab(1).Control(13)=   "FrameInversioneRic"
      Tab(1).Control(13).Enabled=   0   'False
      Tab(1).Control(14)=   "CmbNumPredRic"
      Tab(1).Control(14).Enabled=   0   'False
      Tab(1).ControlCount=   15
      TabCaption(2)   =   "Bilance"
      TabPicture(2)   =   "FrmMessaggioAvviso1.frx":9198F
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "LblSiwarex(0)"
      Tab(2).Control(1)=   "LblSiwarex(1)"
      Tab(2).Control(2)=   "LblSiwarex(2)"
      Tab(2).Control(3)=   "LblSiwarex(3)"
      Tab(2).Control(4)=   "LblSiwarex(4)"
      Tab(2).Control(5)=   "LblSiwarex(5)"
      Tab(2).Control(6)=   "LblSiwarex(6)"
      Tab(2).Control(7)=   "CmdSiwarex(0)"
      Tab(2).Control(8)=   "CmdSiwarex(1)"
      Tab(2).Control(9)=   "CmdSiwarex(2)"
      Tab(2).Control(10)=   "CmdSiwarex(3)"
      Tab(2).Control(11)=   "CmdSiwarex(4)"
      Tab(2).Control(12)=   "CmdSiwarex(5)"
      Tab(2).Control(13)=   "CmdSiwarex(6)"
      Tab(2).ControlCount=   14
      Begin VB.ComboBox CmbNumPredRic 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   2040
         Style           =   2  'Dropdown List
         TabIndex        =   40
         Top             =   1000
         Width           =   735
      End
      Begin VB.ComboBox CmbNumPredosatore 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   -72960
         Style           =   2  'Dropdown List
         TabIndex        =   39
         Top             =   1000
         Width           =   735
      End
      Begin VB.Frame FrameInversioneRic 
         Height          =   520
         Left            =   240
         TabIndex        =   37
         Top             =   1880
         Width           =   3360
         Begin VB.CheckBox ChkInversioneRic 
            Appearance      =   0  'Flat
            BackColor       =   &H0000FFFF&
            Caption         =   "Belt Reverse"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Left            =   50
            TabIndex        =   38
            Top             =   170
            Width           =   3255
         End
      End
      Begin VB.Frame FrameCheckNEF 
         Height          =   520
         Left            =   -74760
         TabIndex        =   35
         Top             =   1880
         Width           =   3360
         Begin VB.CheckBox CheckNEF 
            Appearance      =   0  'Flat
            BackColor       =   &H0000FFFF&
            Caption         =   "Belt Reverse"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   300
            Left            =   50
            TabIndex        =   36
            Top             =   170
            Width           =   3255
         End
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   6
         Left            =   -71400
         Style           =   1  'Graphical
         TabIndex        =   33
         Top             =   2760
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   5
         Left            =   -74880
         Style           =   1  'Graphical
         TabIndex        =   31
         Top             =   2760
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   4
         Left            =   -70320
         Picture         =   "FrmMessaggioAvviso1.frx":919AB
         Style           =   1  'Graphical
         TabIndex        =   29
         Top             =   1560
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.TextBox TxtNumSecondi 
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
         Height          =   360
         Left            =   -71400
         TabIndex        =   8
         Text            =   "120"
         Top             =   1000
         Width           =   495
      End
      Begin VB.TextBox TxtSet 
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
         Height          =   360
         Left            =   -69960
         TabIndex        =   7
         Text            =   "50"
         Top             =   1000
         Width           =   495
      End
      Begin VB.TextBox TxtSecRic 
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
         Height          =   360
         Left            =   3600
         TabIndex        =   6
         Text            =   "120"
         Top             =   1000
         Width           =   495
      End
      Begin VB.TextBox TxtSetRic 
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
         Height          =   360
         Left            =   5040
         TabIndex        =   5
         Text            =   "50"
         Top             =   1000
         Width           =   495
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   3
         Left            =   -71400
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   2160
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   2
         Left            =   -74880
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   2160
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   1
         Left            =   -70320
         Picture         =   "FrmMessaggioAvviso1.frx":92275
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   1020
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.CommandButton CmdSiwarex 
         Height          =   550
         Index           =   0
         Left            =   -70320
         Picture         =   "FrmMessaggioAvviso1.frx":92B3F
         Style           =   1  'Graphical
         TabIndex        =   1
         Top             =   480
         Visible         =   0   'False
         Width           =   550
      End
      Begin VB.Label LblTempoRimastoPredRicSec 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "000"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3600
         TabIndex        =   51
         Top             =   1440
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label lblTempoRimastoPredSec 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "000"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   -71400
         TabIndex        =   50
         Top             =   1440
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblSiwarex 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Predosatore 4"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   6
         Left            =   -70740
         TabIndex        =   34
         Top             =   2880
         Visible         =   0   'False
         Width           =   1605
      End
      Begin VB.Label LblSiwarex 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Predosatore 3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   5
         Left            =   -74220
         TabIndex        =   32
         Top             =   2880
         Visible         =   0   'False
         Width           =   1605
      End
      Begin VB.Label LblSiwarex 
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro pesatura RAP"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Index           =   4
         Left            =   -73680
         TabIndex        =   30
         Top             =   1695
         Visible         =   0   'False
         Width           =   3225
      End
      Begin VB.Label LblSiwarex 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Predosatore 2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   3
         Left            =   -70740
         TabIndex        =   28
         Top             =   2280
         Visible         =   0   'False
         Width           =   1605
      End
      Begin VB.Label LblSiwarex 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Predosatore 1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   2
         Left            =   -74220
         TabIndex        =   27
         Top             =   2280
         Visible         =   0   'False
         Width           =   1605
      End
      Begin VB.Label LblSiwarex 
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro collettore riciclato"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Index           =   1
         Left            =   -73680
         TabIndex        =   26
         Top             =   1155
         Visible         =   0   'False
         Width           =   3225
      End
      Begin VB.Label LblSiwarex 
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro elevatore freddo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Index           =   0
         Left            =   -73680
         TabIndex        =   25
         Top             =   600
         Visible         =   0   'False
         Width           =   3225
      End
      Begin VB.Image ImgMotorTest 
         Height          =   240
         Index           =   2
         Left            =   3600
         Picture         =   "FrmMessaggioAvviso1.frx":93409
         Top             =   2100
         Width           =   240
      End
      Begin VB.Image ImgMotorTest 
         Height          =   240
         Index           =   0
         Left            =   -71400
         Picture         =   "FrmMessaggioAvviso1.frx":9394B
         Top             =   2100
         Width           =   240
      End
      Begin VB.Label LblNumPredosatore 
         BackStyle       =   0  'Transparent
         Caption         =   "Cold Feeder"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   -74760
         TabIndex        =   24
         Top             =   1000
         Width           =   1785
      End
      Begin VB.Label LblSec 
         BackStyle       =   0  'Transparent
         Caption         =   "sec."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   -72120
         TabIndex        =   23
         Top             =   1000
         Width           =   705
      End
      Begin VB.Label LblSet 
         BackStyle       =   0  'Transparent
         Caption         =   "set"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   -70560
         TabIndex        =   22
         Top             =   1000
         Width           =   555
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Min  60   sec"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   -71760
         TabIndex        =   21
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Max 900 sec"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   -71760
         TabIndex        =   20
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Min  10  %"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   -70320
         TabIndex        =   19
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Max 100 %"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   -70320
         TabIndex        =   18
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label LblTempoRimastoPredRic 
         BackStyle       =   0  'Transparent
         Caption         =   "Time Stop C. Feed. (sec)"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   240
         TabIndex        =   17
         Top             =   1440
         Visible         =   0   'False
         Width           =   3225
      End
      Begin VB.Label LblSecRic 
         Caption         =   "sec."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   2880
         TabIndex        =   16
         Top             =   1000
         Width           =   705
      End
      Begin VB.Label LblNumPredRic 
         Caption         =   "Cold Feeder"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   240
         TabIndex        =   15
         Top             =   1000
         Width           =   1785
      End
      Begin VB.Label LblSetRic 
         Caption         =   "set"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   4440
         TabIndex        =   14
         Top             =   1000
         Width           =   435
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Min  60   sec"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   4
         Left            =   3240
         TabIndex        =   13
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Max 900 sec"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   3240
         TabIndex        =   12
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Min  10  %"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   4680
         TabIndex        =   11
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Max 100 %"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   7
         Left            =   4680
         TabIndex        =   10
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label LblTempoRimastoPred 
         BackStyle       =   0  'Transparent
         Caption         =   "Time Stop C. Feed. (sec)"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   -74760
         TabIndex        =   9
         Top             =   1440
         Visible         =   0   'False
         Width           =   3225
      End
      Begin VB.Image ImgMotorTest 
         Height          =   300
         Index           =   1
         Left            =   -71400
         Picture         =   "FrmMessaggioAvviso1.frx":93E8D
         Stretch         =   -1  'True
         Top             =   2040
         Width           =   1965
      End
      Begin VB.Image ImgMotorTest 
         Height          =   300
         Index           =   3
         Left            =   3600
         Picture         =   "FrmMessaggioAvviso1.frx":95F3F
         Stretch         =   -1  'True
         Top             =   2040
         Width           =   1965
      End
   End
   Begin VB.Label LblCalcola 
      BackStyle       =   0  'Transparent
      Caption         =   "="
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Index           =   4
      Left            =   4680
      TabIndex        =   49
      Top             =   1125
      Width           =   240
   End
   Begin VB.Label LblCalcola 
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
      Height          =   300
      Index           =   0
      Left            =   1080
      TabIndex        =   48
      Top             =   1110
      Width           =   720
   End
   Begin VB.Label LblCalcola 
      BackStyle       =   0  'Transparent
      Caption         =   "sec"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Index           =   1
      Left            =   2520
      TabIndex        =   47
      Top             =   1110
      Width           =   720
   End
   Begin VB.Label LblCalcola 
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
      Height          =   300
      Index           =   2
      Left            =   3960
      TabIndex        =   46
      Top             =   1125
      Width           =   720
   End
   Begin VB.Label LblCalcola 
      BackStyle       =   0  'Transparent
      Caption         =   "Ton/h"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Index           =   3
      Left            =   6240
      TabIndex        =   45
      Top             =   1110
      Width           =   720
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   2
      Left            =   0
      Picture         =   "FrmMessaggioAvviso1.frx":97FF1
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   4
      Left            =   2250
      Picture         =   "FrmMessaggioAvviso1.frx":986C9
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   3
      Left            =   1125
      Picture         =   "FrmMessaggioAvviso1.frx":98BA3
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   6180
      Picture         =   "FrmMessaggioAvviso1.frx":99287
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   1
      Left            =   5280
      Picture         =   "FrmMessaggioAvviso1.frx":9983F
      Top             =   15
      Width           =   1125
   End
End
Attribute VB_Name = "FrmTestPredosatori"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'
'   Gestione della taratura dei predosatori e delle bilance
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private ConteggioSecondiPredosatori As Long

Private ValPred(0 To MAXPREDOSATORI + MAXPREDOSATORIRICICLATO - 1) As Integer

Private OraStartTestPredosatore As Long


Private Enum TopBarButtonEnum
    uscita
    Help
    StartTest
    StopTest
    GraficoCalibrazione
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer

Private almenounostart As Boolean '20150619
'


Private Sub ChkInversioneRic_Click()
    If (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) Then
        ChkInversioneRic.Value = 0
    End If

    UscitaInversioneRiciclato = (ChkInversioneRic.Value = 1)
End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Dim predosatore As Integer

    Select Case Index

        Case TopBarButtonEnum.uscita
        
            Stop_Test
            
'20150729
            If AbilitaInversioneLanciatore Then
                Call NMSetMotoreUscitaInv(MotoreNastroElevatoreFreddo, False)
                Call NMSetMotoreUscitaInv(MotoreVaglioInerti, False)
                Call NMSetMotoreUscitaInv(MotoreNastroLanciatore, False)
            End If

            If AbilitaInversioneCollettore Then
                Call NMSetMotoreUscitaInv(MotoreNastroCollettore1, False)
                Call NMSetMotoreUscitaInv(MotoreNastroCollettore2, False)
                Call NMSetMotoreUscitaInv(MotoreNastroCollettore3, False)
            End If
                        
            If (TimerProvaPredosatori.enabled) And ((PredosatoriVerginiAccesi And SSTabTara.Tab = 0) Or (PredosatoriRiciclatiAccesi And SSTabTara.Tab = 1)) Then
                Call NMSetMotoreUscita(MotoreNastroCollettore1, False)
                Call NMSetMotoreUscita(MotoreNastroCollettore2, False)
                Call NMSetMotoreUscita(MotoreNastroCollettore3, False)
                                
                UscitaInversione = False
                CheckNEF.Value = 0
                almenounostart = False
            End If
            
            If UscitaInversioneRiciclato Then
                UscitaInversioneRiciclato = False
                ChkInversioneRic.Value = 0
            End If
        
            If AutomaticoPredosatori Then
                CP240.CmdStartPred.enabled = (Not TermicaPredosatori)
            End If

            Call RiportaValoriPredosatori
            CP240.CmdStopPred.enabled = True

            For predosatore = 0 To NumeroPredosatoriInseriti - 1
                CP240.ImgPred(predosatore).enabled = True
            Next predosatore
            For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                CP240.ImgPredRic(predosatore).enabled = True
            Next predosatore

            FrmTestPredosatoriVisible = False

            CP240.OPCData.items(PLCTAG_NM_TestPredosatori).Value = False

            Call CP240.AbilitaCalibrazione

            Me.Hide
            Unload Me
        
            '20160512
            Call VisualizzaBarraPulsantiCP240(True)
            '
        
        Case TopBarButtonEnum.Help
            
            VisualizzaHelp Me, HELP_PREDOSAGGIO_TARATURA_PRED
                
        Case TopBarButtonEnum.StopTest
        
            Call Stop_Test
        
        Case TopBarButtonEnum.GraficoCalibrazione
            Select Case SSTabTara.Tab
                Case 0
                    If CmbNumPredosatore.ListIndex = -1 Then
                        Exit Sub
                    End If
                    predosatore = CmbNumPredosatore.ListIndex + 1
                Case 1
                    If CmbNumPredRic.ListIndex = -1 Then
                        Exit Sub
                    End If
                    predosatore = 100 + CmbNumPredRic.ListIndex + 1
            End Select

            Call SendMessagetoPlus(PlusSendShowFeederCalibration, CLng(predosatore))

        Case TopBarButtonEnum.StartTest
            Select Case SSTabTara.Tab
        
                Case 0, 1
                    '   Taratura predosatori
                    '   Taratura predosatori riciclato
        
                    Dim Errore As Long
                    '20160512
                    'Errore = ControlliOK
                    Errore = ControlliOK(False)
                    '
                    If Errore <> 0 Then
                        AllarmeCicalino = True
                        ShowMsgBox LoadXLSString(Errore), vbOKOnly, vbExclamation, -1, -1, True
                        AllarmeCicalino = False
                        Exit Sub
                    End If

                    CP240.OPCData.items(PLCTAG_NM_TestPredosatori).Value = True
                    ConteggioSecondiPredosatori = 0
                    OraStartTestPredosatore = ConvertiTimer()
                    TimerProvaPredosatori.Interval = 1000
                    TimerProvaPredosatori.enabled = True
                    almenounostart = True '20150619
                    If SSTabTara.Tab = 0 Then
                        
                        lblTempoRimastoPredSec.caption = TxtNumSecondi.text
                        ImgMotorTest(0).enabled = False
                    Else
                        LblTempoRimastoPredRicSec.caption = TxtSecRic.text
                        ImgMotorTest(2).enabled = False
                    End If
        
                    Call AbilitaTest(False)
        
                    '20161010
                    'Call ControlloPredosatore
                    Call ControlloPredosatore(True)
                    '
        
                Case 2
                    '   Taratura bilance
        
            End Select
    End Select

End Sub

Private Sub SSTabTara_Click(PreviousTab As Integer)

    Dim enabled As Boolean

    Select Case SSTabTara.Tab
        '20170214
        'Case 0, 1
        Case 0
            Call UpdateCalcolo
            enabled = True
        Case 1
            Call UpdateCalcolo
        '
            enabled = True
        Case Else
            enabled = False
    End Select
    
    imgPulsanteForm(TopBarButtonEnum.StartTest).enabled = enabled
    imgPulsanteForm(TopBarButtonEnum.StopTest).enabled = enabled
    imgPulsanteForm(TopBarButtonEnum.GraficoCalibrazione).enabled = enabled

End Sub

Public Sub AbilitaTest(abilita As Boolean)

    Select Case SSTabTara.Tab
    
        Case 0
            'Caso Predosatore Normale

            CmbNumPredosatore.enabled = abilita
            TxtNumSecondi.enabled = abilita
            TxtSet.enabled = abilita
            lblTempoRimastoPredSec.Visible = Not abilita

            LblTempoRimastoPred.Visible = Not abilita

            SSTabTara.TabEnabled(1) = abilita
            SSTabTara.TabEnabled(2) = abilita

        Case 1
            'Caso Predosatore Riciclato

            CmbNumPredRic.enabled = abilita
            TxtSecRic.enabled = abilita
            TxtSetRic.enabled = abilita
            LblTempoRimastoPredRicSec.Visible = Not abilita
            LblTempoRimastoPredRic.Visible = Not abilita

            SSTabTara.TabEnabled(0) = abilita
            SSTabTara.TabEnabled(2) = abilita

        Case 2
            'Caso bilance

            SSTabTara.TabEnabled(0) = abilita
            SSTabTara.TabEnabled(1) = abilita

    End Select

    imgPulsanteForm(TopBarButtonEnum.StartTest).enabled = abilita
    imgPulsanteForm(TopBarButtonEnum.StopTest).enabled = Not abilita
    imgPulsanteForm(TopBarButtonEnum.GraficoCalibrazione).enabled = abilita
    imgPulsanteForm(TopBarButtonEnum.uscita).enabled = True
'

    '20170215
    Call UpdatePulsantiForm
    '

End Sub

Private Sub CheckNEF_Click()

    If (AbilitaInversioneLanciatore And (ListaMotori(MotoreNastroElevatoreFreddo).ritorno Or ListaMotori(MotoreNastroLanciatore).ritorno)) Then
        CheckNEF.Value = 0
    End If
    If (AbilitaInversioneCollettore And (ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore2).ritorno)) Then
        CheckNEF.Value = 0
    End If
    '

    UscitaInversione = (CheckNEF.Value = 1)
End Sub

Public Sub ShowMe(Modo As Integer, ByRef parent As Form)

    Me.Show Modo, parent

End Sub

'20160920
Private Sub Form_Activate()
    If (Me.Visible) Then
        Call VisualizzaBarraPulsantiCP240(False)
    End If
End Sub
'

Private Sub Form_Load()

    Dim indice As Integer
    Dim predosatore As Integer
    Dim predosatoriON As Integer


    FrmTestPredosatoriVisible = True
    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)

    Call CarattereOccidentale(Me)
    
    Call MemorizzaValoriPredosatori

    Me.caption = CaptionStart + LoadXLSString(276)

    imgPulsanteForm(TopBarButtonEnum.Help).ToolTipText = LoadXLSString(110)
 
    SSTabTara.TabCaption(0) = LoadXLSString(231)
    SSTabTara.TabCaption(1) = LoadXLSString(230)
    SSTabTara.TabCaption(2) = LoadXLSString(687)

    LblSec.caption = LoadXLSString(723)
    LblSet.caption = LoadXLSString(692)
    LblSecRic.caption = LoadXLSString(723)
    LblSetRic.caption = LoadXLSString(692)

    imgPulsanteForm(TopBarButtonEnum.uscita).ToolTipText = LoadXLSString(568)

    LblNumPredosatore.caption = LoadXLSString(231)
    LblTempoRimastoPred.caption = LoadXLSString(373)
    LblTempoRimastoPredRic.caption = LoadXLSString(373)

    CheckNEF.caption = LoadXLSString(441)

    Dim abilita As Boolean
    abilita = True
    If AbilitaInversioneLanciatore Then
        abilita = abilita And Not (ListaMotori(MotoreNastroElevatoreFreddo).ritorno Or ListaMotori(MotoreNastroLanciatore).ritorno)
    End If
    If AbilitaInversioneCollettore Then
        abilita = abilita And Not (ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore2).ritorno)
    End If
    CheckNEF.enabled = abilita
    '
    UscitaInversione = False
    FrameCheckNEF.Visible = (AbilitaInversioneCollettore Or AbilitaInversioneLanciatore)
    CheckNEF.Value = 0

    ChkInversioneRic.caption = LoadXLSString(441)
    ChkInversioneRic.enabled = (AbilitaInversioneRiciclato And Not ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno And Not ListaMotori(MotoreNastroCollettoreRiciclato).ritorno)
    FrameInversioneRic.Visible = AbilitaInversioneRiciclato
    UscitaInversioneRiciclato = False
    ChkInversioneRic.Value = 0


    LblNumPredRic.caption = LoadXLSString(230)
    SSTabTara.TabVisible(1) = (NumeroPredosatoriRicInseriti > 0)


    'TARATURA BILANCE

    LblSiwarex(0).caption = LoadXLSString(659)
    LblSiwarex(1).caption = LoadXLSString(26)

    LblSiwarex(0).Visible = (ConfigPortataNastroInerti = schedaSiwarex)
    CmdSiwarex(0).Visible = (ConfigPortataNastroInerti = schedaSiwarex)
    
    LblSiwarex(1).Visible = (ConfigPortataNastroRiciclato = schedaSiwarex)
    CmdSiwarex(1).Visible = (ConfigPortataNastroRiciclato = schedaSiwarex)
'

    CmdSiwarex(2).Picture = LoadResPicture("IDI_PREDOSATORE", vbResIcon)
    CmdSiwarex(3).Picture = LoadResPicture("IDI_PREDOSATORE", vbResIcon)
    CmdSiwarex(5).Picture = LoadResPicture("IDI_PREDOSATORE", vbResIcon)
    CmdSiwarex(6).Picture = LoadResPicture("IDI_PREDOSATORE", vbResIcon)

    LblSiwarex(4).caption = LoadXLSString(592)
    LblSiwarex(4).Visible = AbilitaRAPSiwa
    CmdSiwarex(4).Visible = AbilitaRAPSiwa

    Call CmbNumPredosatore.Clear
    Call CmbNumPredRic.Clear

    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        CP240.ImgPred(predosatore).enabled = False
        Call CmbNumPredosatore.AddItem(CStr(predosatore + 1))

        If (ListaPredosatori(predosatore).bilanciaSiwarex) Then
            indice = ListaPredosatori(predosatore).bilanciaSiwarexIndice
            LblSiwarex(indice).Visible = True
            LblSiwarex(indice).caption = PredosatoreOttieniNome(ListaPredosatori(predosatore))
            CmdSiwarex(indice).Visible = True
        End If
        predosatoriON = predosatoriON + IIf(ListaPredosatori(predosatore).start, 1, 0)
    
    Next predosatore
    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        CP240.ImgPredRic(predosatore).enabled = False
        Call CmbNumPredRic.AddItem(CStr(predosatore + 1))

        If (ListaPredosatoriRic(predosatore).bilanciaSiwarex) Then
            indice = ListaPredosatoriRic(predosatore).bilanciaSiwarexIndice
            LblSiwarex(indice).Visible = True
            LblSiwarex(indice).caption = PredosatoreOttieniNome(ListaPredosatoriRic(predosatore))
            CmdSiwarex(indice).Visible = True
        End If
        predosatoriON = predosatoriON + IIf(ListaPredosatoriRic(predosatore).start, 1, 0)
    Next predosatore

    imgPulsanteForm(TopBarButtonEnum.StopTest).enabled = (predosatoriON > 0)
    imgPulsanteForm(TopBarButtonEnum.StartTest).enabled = (predosatoriON = 0)

    Call UpdatePulsantiForm

    SSTabTara.TabVisible(2) = _
        (NumeroPredosatoriRicInseriti > 0 And _
        (((ConfigPortataNastroInerti = schedaSiwarex)) Or ((ConfigPortataNastroRiciclato = schedaSiwarex)) Or PredosatoriSiwarex) _
        )
'

End Sub

'Spegnimento Motori in caso di Motore in Allarme
Public Sub ControllaNastri(motore As Integer)
   If (AbilitaInversioneLanciatore) Then
        If (motore = MotoreNastroElevatoreFreddo Or motore = MotoreNastroLanciatore Or motore = MotoreVaglioInerti Or motore = MotoreNastroCollettore1 Or motore = MotoreNastroCollettore2 Or motore = MotoreNastroCollettore3) Then
            Call NMSetMotoreUscitaInv(motore, False)
            Call NMSetMotoreUscita(motore, False)
        End If
   Else
         If (motore = MotoreNastroCollettore1 Or motore = MotoreNastroCollettore2 Or motore = MotoreNastroCollettore3) Then
            Call NMSetMotoreUscitaInv(motore, False)
            Call NMSetMotoreUscita(motore, False)
        End If
   End If
End Sub

'20160512
''Controllo Accensione Vaglio,ElevCaldo,Tamburo
'Function Controllomotori() As Long
'    Controllomotori = 0
''20150309
''    If (Not ListaMotori(MotoreVaglio).ritorno And (PLCTAG_DI_TorVagliato And Not PLCTAG_DI_TorNonVagliato)) Then
'    If (Not ListaMotori(MotoreVaglio).ritorno And (CP240.OPCData.items(PLCTAG_DI_TorVagliato).Value And Not CP240.OPCData.items(PLCTAG_DI_TorNonVagliato).Value)) Then
''
'        Controllomotori = 3
'        Exit Function
'    End If
'    If (Not ListaMotori(MotoreElevatoreCaldo).ritorno) Then
'        Controllomotori = 4
'        Exit Function
'    End If
'    If (Not ListaMotori(MotoreRotazioneEssiccatore).ritorno) Then
'        Controllomotori = 5
'        Exit Function
'    End If
'
'    '20160107
'    'If (Not ListaMotori(MotoreNastroElevatoreFreddo).ritorno) Then
'    'Può essere acceso se non ho l'inversione del lanciatore/freddo
'    If (AbilitaInversioneLanciatore And ListaMotori(MotoreNastroElevatoreFreddo).ritorno) Then
'    '
'        Controllomotori = 6
'        Exit Function
'    End If
'End Function
'

'Prevista l'inversione solo per gli inerti
'CASO1= AbilitaInversioneLanciatore=true  --> Si accendono MotoreNastroLanciatore,MotoreVaglioInerti e MotoreNastroElevatoreFreddo=invertito
'CASO2= AbilitaInversioneLanciatore=true  --> Si accendono i giusti Nastri Collettori=invertiti
Private Sub ImgMotorTest_Click(Index As Integer)

    Dim laccendiamo As Boolean

    Select Case Index
        Case 0
            'controllo accensione vaglio,elevcaldo e tamburo prima del test

            '20160512
            'Dim codiceerrore As Integer
            'codiceerrore = Controllomotori()
            'If (codiceerrore > 0) Then
            '    If (codiceerrore < 6) Then
            '        AllarmeCicalino = True
            '        ShowMsgBox LoadXLSString(1500 + codiceerrore), vbOKOnly, vbExclamation, -1, -1, True
            '        AllarmeCicalino = False
            '        Exit Sub
            '    Else
            '        AllarmeCicalino = True
            '        ShowMsgBox LoadXLSString(1507), vbOKOnly, vbExclamation, -1, -1, True
            '        AllarmeCicalino = False
            '        Exit Sub
            '    End If
            'End If
            Dim Errore As Long
            Errore = ControlliOK(True)
            If Errore <> 0 Then
                AllarmeCicalino = True
                ShowMsgBox LoadXLSString(Errore), vbOKOnly, vbExclamation, -1, -1, True
                AllarmeCicalino = False
                Exit Sub
            End If
            '

            If (AbilitaInversioneLanciatore) Then
                '20160706
                'If (ListaMotori(MotoreNastroElevatoreFreddo).ritorno Or ListaMotori(MotoreNastroElevatoreFreddo).RitornoIndietro) Then
                If ( _
                    ListaMotori(MotoreNastroLanciatore).ritorno Or ListaMotori(MotoreNastroLanciatore).RitornoIndietro Or _
                    ListaMotori(MotoreNastroElevatoreFreddo).ritorno Or ListaMotori(MotoreNastroElevatoreFreddo).RitornoIndietro _
                ) Then
                '
                    'Motore da spegnere
                    laccendiamo = False
                Else
                    'Motore da accendere
                    laccendiamo = True
                End If
'20150729
            ElseIf (AbilitaInversioneCollettore) And (CheckNEF = 1) Then
                laccendiamo = True
'
            Else
                If (ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore1).RitornoIndietro Or ListaMotori(MotoreNastroCollettore2).ritorno Or ListaMotori(MotoreNastroCollettore2).RitornoIndietro Or ListaMotori(MotoreNastroCollettore3).ritorno Or ListaMotori(MotoreNastroCollettore3).RitornoIndietro) Then
                    'Motore da spegnere
                    laccendiamo = False
                Else
                    'Motore da accendere
                    laccendiamo = True
                End If
            End If

            If (AbilitaInversioneLanciatore) Then
                 '20160706
                'Call NMSetMotoreUscita(MotoreNastroLanciatore, laccendiamo)
                '
                 Call NMSetMotoreUscita(MotoreVaglioInerti, laccendiamo)
                 '20160706
                If (ListaMotori(MotoreNastroLanciatore).presente) Then
                    Call NMSetMotoreUscita(MotoreNastroLanciatore, laccendiamo And Not UscitaInversione)
                    Call NMSetMotoreUscitaInv(MotoreNastroLanciatore, laccendiamo And UscitaInversione)
                    Call NMSetMotoreUscita(MotoreNastroElevatoreFreddo, laccendiamo)
                Else
                '
                    Call NMSetMotoreUscita(MotoreNastroElevatoreFreddo, laccendiamo And Not UscitaInversione)
                    Call NMSetMotoreUscitaInv(MotoreNastroElevatoreFreddo, laccendiamo And UscitaInversione)
                End If
            End If

            If (CmbNumPredosatore.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.Collettore1)) Then
                '20160107
                'Call NMSetMotoreUscita(MotoreNastroCollettore1, laccendiamo)
                If (AbilitaInversioneCollettore) Then
                    Call NMSetMotoreUscita(MotoreNastroCollettore1, laccendiamo And Not UscitaInversione)
                    Call NMSetMotoreUscitaInv(MotoreNastroCollettore1, laccendiamo And UscitaInversione)
                Else
                    Call NMSetMotoreUscita(MotoreNastroCollettore1, laccendiamo)
                End If
                '
            Else
                If (CmbNumPredosatore.ListIndex < (NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2))) Then
                    '20160107
                    'Call NMSetMotoreUscita(MotoreNastroCollettore2, laccendiamo)
                    If (AbilitaInversioneCollettore) Then
                        Call NMSetMotoreUscita(MotoreNastroCollettore2, laccendiamo And Not UscitaInversione)
                        Call NMSetMotoreUscitaInv(MotoreNastroCollettore2, laccendiamo And UscitaInversione)
                    Else
                        Call NMSetMotoreUscita(MotoreNastroCollettore2, laccendiamo)
                    End If
                    '
                Else
                    '20160107
                    'Call NMSetMotoreUscita(MotoreNastroCollettore1, laccendiamo)
                    If (AbilitaInversioneCollettore) Then
                        Call NMSetMotoreUscita(MotoreNastroCollettore1, laccendiamo And Not UscitaInversione)
                        Call NMSetMotoreUscitaInv(MotoreNastroCollettore1, laccendiamo And UscitaInversione)
                    Else
                        Call NMSetMotoreUscita(MotoreNastroCollettore1, laccendiamo)
                    End If
                    '
                End If
            End If

            CheckNEF.enabled = (Not laccendiamo)
            SSTabTara.TabEnabled(1) = (Not laccendiamo)
            SSTabTara.TabEnabled(2) = (Not laccendiamo)
            
        Case 2
            '20170302
            Errore = ControlliOK(True)
            If Errore <> 0 Then
                AllarmeCicalino = True
                ShowMsgBox LoadXLSString(Errore), vbOKOnly, vbExclamation, -1, -1, True
                AllarmeCicalino = False
                Exit Sub
            End If
            If (CmbNumPredRic.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)) Then
                'Riciclato freddo
                laccendiamo = Not ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno
                If (laccendiamo) Then
                    If (ListaMotori(MotoreRotazioneEssiccatore).ritorno) Then
                        Call NMSetMotoreUscita(MotoreNastroTrasportatoreRiciclato, laccendiamo)
                        If (ListaMotori(MotoreNastroCollettoreRiciclato).presente) Then
                            Call NMSetMotoreUscita(MotoreNastroCollettoreRiciclato, laccendiamo)
                        End If
                    End If
                Else
                    Call NMSetMotoreUscita(MotoreNastroTrasportatoreRiciclato, laccendiamo)
                    If (ListaMotori(MotoreNastroCollettoreRiciclato).presente) Then
                        Call NMSetMotoreUscita(MotoreNastroCollettoreRiciclato, laccendiamo)
                    End If
                End If
            Else
                'Riciclato freddo
                laccendiamo = Not ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno
                If (laccendiamo) Then
                    If (ListaMotori(MotoreElevatoreRiciclato).ritorno) Then
                        Call NMSetMotoreUscita(MotoreNastroTrasportatoreRiciclatoFreddo, laccendiamo)
                        If (ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente) Then
                            Call NMSetMotoreUscita(MotoreNastroCollettoreRiciclatoFreddo, laccendiamo)
                        End If
                    End If
                Else
                    Call NMSetMotoreUscita(MotoreNastroTrasportatoreRiciclatoFreddo, laccendiamo)
                    If (ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente) Then
                        Call NMSetMotoreUscita(MotoreNastroCollettoreRiciclatoFreddo, laccendiamo)
                    End If
                End If
            End If
            '20170302
            ChkInversioneRic.enabled = (Not laccendiamo)
            SSTabTara.TabEnabled(0) = (Not laccendiamo)
            SSTabTara.TabEnabled(2) = (Not laccendiamo)

    End Select
    
End Sub


Private Sub TimerControlloMotori_Timer()

    Dim acceso As Boolean
    
    If (CmbNumPredosatore.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.Collettore1)) Then
        acceso = ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore1).RitornoIndietro
    Else
        acceso = ListaMotori(MotoreNastroCollettore2).ritorno Or ListaMotori(MotoreNastroCollettore2).RitornoIndietro
    End If
    If (acceso) Then
        ImgMotorTest(1).Picture = LoadResPicture("IDB_NASTROON", vbResBitmap)
    Else
        ImgMotorTest(1).Picture = LoadResPicture("IDB_NASTRO", vbResBitmap)
    End If

    If (CmbNumPredRic.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)) Then
        acceso = (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclato).RitornoIndietro Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) Or ListaMotori(MotoreNastroCollettoreRiciclato).RitornoIndietro
    Else
        acceso = (ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro)
    End If
    
    If (acceso) Then
        ImgMotorTest(3).Picture = LoadResPicture("IDB_NASTROON", vbResBitmap)
    Else
        ImgMotorTest(3).Picture = LoadResPicture("IDB_NASTRO", vbResBitmap)
    End If

End Sub

Private Sub TimerProvaPredosatori_Timer()

    Dim secondi As Integer

    Call ControlloMotoriDuranteTestPredosatori

    ConteggioSecondiPredosatori = ConvertiTimer() - OraStartTestPredosatore

    If SSTabTara.Tab = 0 Then 'Predosatori Normali
        secondi = TxtNumSecondi.text
        lblTempoRimastoPredSec.caption = secondi - ConteggioSecondiPredosatori
    Else
        secondi = TxtSecRic.text
        LblTempoRimastoPredRicSec.caption = secondi - ConteggioSecondiPredosatori
    End If

    If ConteggioSecondiPredosatori >= secondi Then
        Call Stop_Test
    End If

    '20160718
    Call CheckCollector
    '20160718
End Sub

'20160718 se il nastro collettore si spegne viene interrotto il test
Private Sub CheckCollector()

On Error GoTo Errore

    '20170215
    'If (CmbNumPredosatore.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.Collettore1)) Then
    '    If (Not (ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore1).RitornoIndietro)) Then
    '        Call Stop_Test
    '        Call PredosatoriArrestoImmediato(False, -1)
    '    End If
    'Else
    '    If (CmbNumPredosatore.ListIndex < (NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2))) Then
    '        If Not (ListaMotori(MotoreNastroCollettore2).ritorno Or ListaMotori(MotoreNastroCollettore2).RitornoIndietro) Then
    '            Call Stop_Test
    '            Call PredosatoriArrestoImmediato(False, -1)
    '        End If
    '    Else
    '        If Not (ListaMotori(MotoreNastroCollettore3).ritorno Or ListaMotori(MotoreNastroCollettore3).RitornoIndietro) Then
    '            Call Stop_Test
    '            Call PredosatoriArrestoImmediato(False, -1)
    '        End If
    '    End If
    'End If
    If (ControlliOK(False) <> 0) Then
        Call Stop_Test
        If (SSTabTara.Tab = 0) Then 'Predosatori Normali
            Call PredosatoriArrestoImmediato(False, -1)
        Else
            Call PredosatoriArrestoImmediato(True, -1)
        End If
    End If
    '

    Exit Sub
Errore:
    LogInserisci True, "CheckCollector", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'20160718 se il nastro collettore si spegne viene interrotto il test

Private Sub TxtNumSecondi_LostFocus()
     Call CheckLabelDato(TxtNumSecondi, 60, 900, 120)

    '20170215
    Call UpdateCalcolo
    '
End Sub

Private Sub TxtSecRic_LostFocus()
     Call CheckLabelDato(TxtSecRic, 60, 900, 120)

    '20170215
    Call UpdateCalcolo
    '
End Sub

Private Sub TxtSet_LostFocus()
     Call CheckLabelDato(TxtSet, 10, 100, 50)

    '20170215
    Call UpdateCalcolo
    '
End Sub

Private Sub TxtSetRic_LostFocus()
     Call CheckLabelDato(TxtSetRic, 10, 100, 50)

    '20170215
    Call UpdateCalcolo
    '
End Sub


'Ritorna il codice dell'errore da utilizzare con la LoadXlsString
'20160512
'Function ControlliOK() As Long
Private Function ControlliOK(startMotor As Boolean) As Long
'

    ControlliOK = 0

    If AutomaticoPredosatori Then
        Exit Function
    End If

    If (SSTabTara.Tab = 0) Then 'Predosatori Normali

        '20160512
        If (Not startMotor) Then
        '
            '20150309
            'If CInt(TxtNumSecondi.text) < 60 Then
            If Null2Qualcosa(TxtNumSecondi.text) < 60 Then
                ControlliOK = 190
            '
                Exit Function
            End If
            
            '20150309
            'If CInt(TxtSet.text) < 10 Then
            If Null2Qualcosa(TxtSet.text) < 10 Then
                ControlliOK = 190
            '
                Exit Function
            End If
            If CmbNumPredosatore.text = "" Then
                '20150309
                ControlliOK = 190
                '
                Exit Function
            End If
        End If

        '20160512
        If (Not startMotor) Then
        '
            If Not ListaMotori(MotoreNastroCollettore2).presente Then
                If (Not (ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore1).RitornoIndietro)) Then
                    ControlliOK = 161
                    Exit Function
                End If
            Else
                If (CmbNumPredosatore.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.Collettore1)) Then
                    If (Not ListaMotori(MotoreNastroCollettore1).ritorno) Then
                        ControlliOK = 161
                        Exit Function
                    End If
                Else
                    If (CmbNumPredosatore.ListIndex < (NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2))) Then
                        If Not (ListaMotori(MotoreNastroCollettore2).ritorno Or ListaMotori(MotoreNastroCollettore2).RitornoIndietro) Then
                            ControlliOK = 161
                            Exit Function
                        End If
                    Else
                        If Not (ListaMotori(MotoreNastroCollettore3).ritorno Or ListaMotori(MotoreNastroCollettore3).RitornoIndietro) Then
                            ControlliOK = 161
                            Exit Function
                        End If
                    End If
                    '
                End If
            End If

            If (AbilitaInversioneLanciatore) Then
                '20160706
                If (ListaMotori(MotoreNastroLanciatore).presente) Then
                    If (Not ListaMotori(MotoreNastroLanciatore).RitornoIndietro) Then
                        Exit Function
                    End If
                Else
                '
                    If Not ListaMotori(MotoreNastroElevatoreFreddo).RitornoIndietro Then
                        Exit Function
                    End If
                End If
            End If
        End If

        If CheckNEF = 0 Then
            If ( _
                (ListaMotori(MotoreNastroElevatoreFreddo).presente And Not (ListaMotori(MotoreNastroElevatoreFreddo).ritorno Or ListaMotori(MotoreNastroElevatoreFreddo).RitornoIndietro)) Or _
                (ListaMotori(MotoreNastroLanciatore).presente And Not (ListaMotori(MotoreNastroLanciatore).ritorno Or ListaMotori(MotoreNastroLanciatore).RitornoIndietro)) _
            ) Then
                Exit Function
            End If
            If Not ListaMotori(MotoreRotazioneEssiccatore).ritorno Then
                Exit Function
            End If
            If Not ListaMotori(MotoreElevatoreCaldo).ritorno Then
                Exit Function
            End If
            If DeflettoreSuVagliato Then
                If Not ListaMotori(MotoreVaglio).ritorno Then
                    Exit Function
                End If
            End If
        End If

    Else    'Predosatori Riciclato

        '20160512
        If (Not startMotor) Then
        '
            '20150309
            'If CInt(TxtSecRic.text) < 60 Then
            If Null2Qualcosa(TxtSecRic.text) < 60 Then
                ControlliOK = 190
            '
                Exit Function
            End If
            '20150309
            'If CInt(TxtSetRic.text) < 10 Then
            If Null2Qualcosa(TxtSetRic.text) < 10 Then
                ControlliOK = 190
            '
                Exit Function
            End If
            '20170303
'            If CmbNumPredRic.text = "" Then
'            '20150309
'                ControlliOK = 190
'            '
'                Exit Function
'            End If
            '20170303
        End If
        '20170303
        If CmbNumPredRic.text = "" Then
            ControlliOK = 190
            Exit Function
        End If
        '20170303
        
        '20160512
        If (Not startMotor) Then
        '
            If (CmbNumPredRic.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)) Then
                If ListaMotori(MotoreNastroCollettoreRiciclato).presente And Not (ListaMotori(MotoreNastroCollettoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).RitornoIndietro) Then
                    ControlliOK = 290
                    Exit Function
                End If
                '20160422
                'If ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclato).RitornoIndietro Then
                If ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclato).RitornoIndietro) Then
                '
                    ControlliOK = 290
                    Exit Function
                End If
            Else
                If ListaMotori(MotoreNastroRapJolly).presente Then
                    If (CmbNumPredRic.ListIndex >= PrimoPredosatoreDelNastro(RiciclatoJolly)) Then
                        If NastroRapJollyVersoFreddo Then
                            'Nel caso verso freddo occorre dare INVERSIONE

                            '20170215
                            'If ListaMotori(MotoreElevatoreRiciclato).presente And Not ListaMotori(MotoreElevatoreRiciclato).RitornoIndietro Then
                            If ListaMotori(MotoreElevatoreRiciclato).presente And Not ListaMotori(MotoreElevatoreRiciclato).ritorno Then
                            '
                                ControlliOK = 290
                                Exit Function
                            End If
                            '20170215
                            'If ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro Then
                            If ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not (ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro) Then
                            '
                                ControlliOK = 290
                                Exit Function
                            End If
                            '20170215
                            'If ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro Then
                            If ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not (ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro) Then
                            '
                                ControlliOK = 290
                                Exit Function
                            End If
                            If ListaMotori(MotoreNastroRapJolly).presente And Not ListaMotori(MotoreNastroRapJolly).RitornoIndietro Then
                                ControlliOK = 290
                                Exit Function
                            End If
                        Else
                            '20170215
                            'If ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclato).RitornoIndietro Then
                            If ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclato).RitornoIndietro) Then
                            '
                                ControlliOK = 290
                                Exit Function
                            End If
                            '20170215
                            'If ListaMotori(MotoreNastroCollettoreRiciclato).presente And Not ListaMotori(MotoreNastroCollettoreRiciclato).RitornoIndietro Then
                            If ListaMotori(MotoreNastroCollettoreRiciclato).presente And Not (ListaMotori(MotoreNastroCollettoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).RitornoIndietro) Then
                            '
                                ControlliOK = 290
                                Exit Function
                            End If
                            '20170215
                            'If ListaMotori(MotoreNastroRapJolly).presente And Not ListaMotori(MotoreNastroRapJolly).RitornoIndietro Then
                            If ListaMotori(MotoreNastroRapJolly).presente And Not ListaMotori(MotoreNastroRapJolly).ritorno Then
                            '
                                ControlliOK = 290
                                Exit Function
                            End If
                        End If
                    Else
                        '20170215
                        'If ListaMotori(MotoreElevatoreRiciclato).presente And Not ListaMotori(MotoreElevatoreRiciclato).RitornoIndietro Then
                        If ListaMotori(MotoreElevatoreRiciclato).presente And Not ListaMotori(MotoreElevatoreRiciclato).ritorno Then
                        '
                            ControlliOK = 290
                            Exit Function
                        End If
                        '20170215
                        'If ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro Then
                        If ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not (ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro) Then
                        '
                            ControlliOK = 290
                            Exit Function
                        End If
                        '20170215
                        'If ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro Then
                        If ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not (ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro) Then
                        '
                            ControlliOK = 290
                            Exit Function
                        End If
                    End If
                Else
                    '20170215
                    'If ListaMotori(MotoreElevatoreRiciclato).presente And Not ListaMotori(MotoreElevatoreRiciclato).RitornoIndietro Then
                    If ListaMotori(MotoreElevatoreRiciclato).presente And Not ListaMotori(MotoreElevatoreRiciclato).ritorno Then
                    '
                        ControlliOK = 290
                        Exit Function
                    End If
                    '20170215
                    'If ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro Then
                    If ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not (ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).RitornoIndietro) Then
                    '
                        ControlliOK = 290
                        Exit Function
                    End If
                    '20170215
                    'If ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro Then
                    If ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not (ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).RitornoIndietro) Then
                    '
                        ControlliOK = 290
                        Exit Function
                    End If
                End If
            End If
            '
        End If

        If ParallelDrum Then
            If Not (UscitaInversioneRiciclato) Then
                If Not ListaMotori(MotoreRotazioneEssiccatore).ritorno And (CmbNumPredRic.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)) Or Not ListaMotori(MotoreRotazioneEssiccatore2).ritorno And (CmbNumPredRic.ListIndex >= NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)) Then
                    ControlliOK = 214
                    Exit Function
                End If
                '20170215
                'If Not ListaMotori(MotoreElevatoreRiciclato).RitornoIndietro Then
                If Not ListaMotori(MotoreElevatoreRiciclato).ritorno Then
                '
                    ControlliOK = 205
                    Exit Function
                End If
            End If
        Else
            If Not (UscitaInversioneRiciclato) Then
                If Not ListaMotori(MotoreRotazioneEssiccatore).ritorno Then
                    ControlliOK = 214
                    Exit Function
                End If
                '20160826
                'If Not ListaMotori(MotoreElevatoreCaldo).RitornoIndietro Then
                If Not ListaMotori(MotoreElevatoreCaldo).ritorno Then
                    ControlliOK = 205
                    Exit Function
                End If
                If VaglioIncluso Then
                    ControlliOK = 189
                    Exit Function
                End If
            End If
    
        End If
'
    
    End If

    ControlliOK = 0
End Function

'20161010
'Public Sub ControlloPredosatore()
Public Sub ControlloPredosatore(start As Boolean)
'
Dim NumPred As Integer

    Select Case SSTabTara.Tab

        Case 0
            'Predosatori Normali

            NumPred = CmbNumPredosatore.ListIndex
            'Imposto il set del predosatore in CP240
            PredosatoreCambiaSet False, NumPred, val(TxtSet.text), False

            '20161010
            'PredosatoreManuale False, NumPred, Not ListaPredosatori(NumPred).motore.uscita, False
            Call PredosatoreManuale(False, NumPred, start, False)
            '

        Case 1
            'Predosatori Riciclato

            NumPred = CmbNumPredRic.ListIndex
            'Imposto il set del predosatore in CP240
            PredosatoreCambiaSet True, NumPred, val(TxtSetRic.text), False

            '20161010
            'PredosatoreManuale True, NumPred, Not ListaPredosatoriRic(NumPred).motore.uscita, False
            Call PredosatoreManuale(True, NumPred, start, False)
            '

    End Select

End Sub

Public Sub MemorizzaValoriPredosatori()
Dim i As Integer
    For i = 0 To MAXPREDOSATORI - 1
        ValPred(i) = PredosatoreOttieniSet(False, i)
    Next i
    For i = 0 To MAXPREDOSATORIRICICLATO - 1
        ValPred(i + 12) = PredosatoreOttieniSet(True, i)
    Next i
End Sub

Public Sub RiportaValoriPredosatori()
Dim i As Integer
    For i = 0 To MAXPREDOSATORI - 1
        CP240.TxtPredSet(i).text = ValPred(i)
    Next i
    For i = 0 To MAXPREDOSATORIRICICLATO - 1
        CP240.TxtPredRicSet(i).text = ValPred(i + 12)
    Next i
End Sub

Public Sub ControlloMotoriDuranteTestPredosatori()
    If UscitaInversione Then
        If AbilitaInversioneLanciatore Then
            '20160706
            'If ( _
            '    (ListaMotori(MotoreNastroElevatoreFreddo).presente And Not ListaMotori(MotoreNastroElevatoreFreddo).RitornoIndietro) Or _
            '    (ListaMotori(MotoreNastroLanciatore).presente And Not ListaMotori(MotoreNastroLanciatore).ritorno) _
            ') Then
            If ( _
                (ListaMotori(MotoreNastroElevatoreFreddo).presente And Not ListaMotori(MotoreNastroElevatoreFreddo).ritorno And Not ListaMotori(MotoreNastroElevatoreFreddo).RitornoIndietro) Or _
                (ListaMotori(MotoreNastroLanciatore).presente And Not ListaMotori(MotoreNastroLanciatore).ritorno And Not ListaMotori(MotoreNastroLanciatore).RitornoIndietro) _
            ) Then
            '
                Call Stop_Test
            End If
        End If
        If Not (ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore2).ritorno) Then
            Call Stop_Test
        End If
    Else
        If Not UscitaInversioneRiciclato Then
            If ParallelDrum Then
            
                'And riguardante il TAB altrimenti con i pred normali nn partiva col tamburo riciclato spento
                If SSTabTara.Tab = 1 And (Not ListaMotori(MotoreRotazioneEssiccatore).ritorno And (CmbNumPredRic.ListIndex < NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)) Or Not ListaMotori(MotoreRotazioneEssiccatore2).ritorno And (CmbNumPredRic.ListIndex >= NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo))) Then
                   Call Stop_Test
                End If
                If SSTabTara.Tab = 1 And (Not ListaMotori(MotoreElevatoreRiciclato).ritorno And (CmbNumPredRic.ListIndex > NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo))) Then
                   Call Stop_Test
                End If
            
            Else
                If (Not (SSTabTara.Tab = 1 And ((CmbNumPredRic.ListIndex + 1) > NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)))) Then '20170303
                    'Vergini o Ric Caldo
                    If Not ListaMotori(MotoreRotazioneEssiccatore).ritorno Then
                       Call Stop_Test
                    End If
                    If Not ListaMotori(MotoreElevatoreCaldo).ritorno Then
                       Call Stop_Test
                    End If
                    If DeflettoreSuVagliato Then
                        If Not ListaMotori(MotoreVaglio).ritorno Then
                       Call Stop_Test
                        End If
                    End If
                '20170303
                Else
                    'Ric Freddo
                    If Not ListaMotori(MotoreElevatoreRiciclato).ritorno Then
                       Call Stop_Test
                    End If
                    If (Not ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno) Then
                       Call Stop_Test
                    End If
                End If
                '20170303
            End If

        Else
            If (ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno) Or (ListaMotori(MotoreNastroCollettoreRiciclato).presente And Not ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) Then
                Call Stop_Test
            End If
        End If
    End If
End Sub

'TARATURA BILANCE
Private Sub CmdSiwarex_Click(Index As Integer)
    FrmSiwarexPara.ShowMe vbModal, Me, Index
End Sub

Private Sub Stop_Test()

    Select Case SSTabTara.Tab

        Case 0, 1
            '   Taratura predosatori
            '   Taratura predosatori riciclato

            CheckNEF.enabled = (((ListaMotori(MotoreNastroElevatoreFreddo).presente And Not Not ListaMotori(MotoreNastroElevatoreFreddo).ritorno) Or (ListaMotori(MotoreNastroLanciatore).presente And Not ListaMotori(MotoreNastroLanciatore).ritorno)) And Not ListaMotori(MotoreNastroCollettore1).ritorno And Not ListaMotori(MotoreNastroCollettore2).ritorno)

            If Not TimerProvaPredosatori.enabled Then
                AllarmeCicalino = True
'                ShowMsgBox Avvisopred, vbOKOnly, vbExclamation, -1, -1, True
                AllarmeCicalino = False
                Exit Sub
            End If

            If TimerProvaPredosatori.enabled And Not PredosatoriVerginiAccesi And SSTabTara.Tab = 0 Then
                If ListaMotori(MotoreNastroCollettore1).ritorno Or ListaMotori(MotoreNastroCollettore2).ritorno Or ListaMotori(MotoreNastroCollettore3).ritorno Then
                    Call ImgMotorTest_Click(0)
                End If
            End If
            If TimerProvaPredosatori.enabled And Not PredosatoriRiciclatiAccesi And SSTabTara.Tab = 1 Then
                If ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno Or ListaMotori(MotoreElevatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno Or ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno Then
                    Call ImgMotorTest_Click(2)
                End If
            End If

            '20161010
            'Call ControlloPredosatore
            Call ControlloPredosatore(False)
            '
            ConteggioSecondiPredosatori = 0
            OraStartTestPredosatore = 0
            TimerProvaPredosatori.enabled = False
            ImgMotorTest(0).enabled = True
            ImgMotorTest(2).enabled = True
            
            Call AbilitaTest(True)
            
            CP240.OPCData.items(PLCTAG_NM_TestPredosatori).Value = False
'20150309
            Call UpdatePulsantiForm
'
        Case 2
            '   Taratura bilance

    End Select

End Sub

'20170215
Private Sub UpdateCalcolo()

    Select Case SSTabTara.Tab

        Case 0
            TxtCalcolo(1).text = TxtNumSecondi.text
            TxtCalcolo(2).text = TxtSet.text

        Case 1
            TxtCalcolo(1).text = TxtSecRic.text
            TxtCalcolo(2).text = TxtSetRic.text

    End Select

    Call UpdateCalcoloTonH

End Sub

'20170215
Private Sub UpdateCalcoloTonH()
    TxtCalcolo(3).text = CLng((360 * val(TxtCalcolo(0).text)) / (val(TxtCalcolo(1).text) * val(TxtCalcolo(2).text)))
End Sub

Private Sub TxtCalcolo_LostFocus(Index As Integer)
Dim min As Double
Dim max As Double
Dim default As Double

    If Index = 3 Then
        Exit Sub
    End If
           
    Select Case Index
        Case 0
            min = 50
            max = 9999
            default = 2000
        Case 1
            min = 10
            max = 999
            default = 90
        Case 2
            min = 10
            max = 100
            default = 50
    End Select

    If CheckLabelDato(TxtCalcolo(Index), min, max, default) Then
        '20170215
        'TxtCalcolo(3).text = CLng((360 * val(TxtCalcolo(0).text)) / (val(TxtCalcolo(1).text) * val(TxtCalcolo(2).text)))
        Call UpdateCalcoloTonH
        '
        TxtCalcolo(3).BackColor = vbGreen
    Else
        TxtCalcolo(3).BackColor = vbRed
    End If
'
    
End Sub


Private Sub TxtCalcolo_KeyPress(Index As Integer, KeyAscii As Integer)
Dim min As Double
Dim max As Double
Dim default As Double

    If Index = 3 Or KeyAscii <> 13 Then
        Exit Sub
    End If
           
    Select Case Index
        Case 0
            min = 50
            max = 9999
            default = 2000
        Case 1
            min = 10
            max = 999
            default = 90
        Case 2
            min = 10
            max = 100
            default = 50
    End Select

    If CheckLabelDato(TxtCalcolo(Index), min, max, default) Then
        '20170215
        'TxtCalcolo(3).text = CLng((360 * val(TxtCalcolo(0).text)) / (val(TxtCalcolo(1).text) * val(TxtCalcolo(2).text)))
        Call UpdateCalcoloTonH
        '
        TxtCalcolo(3).BackColor = vbGreen
    Else
        TxtCalcolo(3).BackColor = vbRed
    End If
'
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


Private Sub LoadImmaginiPulsantePlus(Index As Integer, Stato As StatoPulsantePlus)
Dim prefisso As String
    
    On Error GoTo Errore
                                                                 
'selezione prefisso nome immagine
                                                                                                                                                                                                     
    Select Case Index
        Case TopBarButtonEnum.uscita
            prefisso = "PLUS_IMG_EXIT"
        Case TopBarButtonEnum.Help
            prefisso = "PLUS_IMG_HELP"
        Case TopBarButtonEnum.StopTest
            prefisso = "PLUS_IMG_MOTORSTOP"
        Case TopBarButtonEnum.GraficoCalibrazione
            prefisso = "PLUS_IMG_LINECHART"
        Case TopBarButtonEnum.StartTest
            prefisso = "PLUS_IMG_MOTORSTART"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(Stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FTP-001", CStr(Err.Number) + " [" + Err.description + "]"
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
