VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "anibtn32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form FrmSchiumatura 
   BackColor       =   &H00808080&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "MARINI - Bitume schiumato"
   ClientHeight    =   4650
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   9720
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4650
   ScaleWidth      =   9720
   ShowInTaskbar   =   0   'False
   Begin VB.Timer TmrScansione 
      Interval        =   500
      Left            =   8160
      Top             =   3960
   End
   Begin VB.CommandButton CmdEsci 
      BackColor       =   &H00C0C0C0&
      Cancel          =   -1  'True
      Height          =   550
      Left            =   9075
      Style           =   1  'Graphical
      TabIndex        =   54
      Top             =   3210
      Width           =   550
   End
   Begin VB.CommandButton CmdHelp 
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   13.5
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   8432
      Style           =   1  'Graphical
      TabIndex        =   53
      Top             =   3210
      Width           =   550
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00008000&
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   1695
      Left            =   4200
      TabIndex        =   32
      Top             =   -360
      Visible         =   0   'False
      Width           =   2535
      Begin VB.Frame FrameAggregati 
         BackColor       =   &H00808080&
         Caption         =   "Aggregati"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   855
         Left            =   120
         TabIndex        =   49
         Top             =   840
         Width           =   1935
         Begin VB.Image ImgScaricoAggregati 
            Height          =   480
            Left            =   1440
            Picture         =   "FrmSchiumatura.frx":0000
            Top             =   240
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image ImgPeso 
            Height          =   480
            Index           =   0
            Left            =   0
            Picture         =   "FrmSchiumatura.frx":08CA
            Top             =   240
            Width           =   480
         End
         Begin VB.Label LblPesoAggregati 
            Alignment       =   1  'Right Justify
            BackColor       =   &H8000000E&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "XXXX"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   480
            TabIndex        =   52
            Top             =   240
            Width           =   660
         End
         Begin VB.Label LblUnitaMisura 
            BackStyle       =   0  'Transparent
            Caption         =   "Kg."
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   255
            Index           =   0
            Left            =   1200
            TabIndex        =   51
            Top             =   240
            Width           =   375
         End
         Begin VB.Label LblPeso 
            Alignment       =   1  'Right Justify
            Caption         =   "XXXX"
            Height          =   180
            Left            =   600
            TabIndex        =   50
            Top             =   630
            Visible         =   0   'False
            Width           =   495
         End
      End
      Begin MSComCtl2.UpDown UpDownPercentoBitume 
         Height          =   255
         Left            =   735
         TabIndex        =   33
         Top             =   510
         Width           =   255
         _ExtentX        =   450
         _ExtentY        =   450
         _Version        =   393216
         OrigLeft        =   6000
         OrigTop         =   1200
         OrigRight       =   6255
         OrigBottom      =   1455
         Max             =   100
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown UpDownPercentoBitumeSoft 
         Height          =   255
         Left            =   1935
         TabIndex        =   38
         Top             =   510
         Width           =   255
         _ExtentX        =   450
         _ExtentY        =   450
         _Version        =   393216
         OrigLeft        =   6000
         OrigTop         =   1200
         OrigRight       =   6255
         OrigBottom      =   1455
         Max             =   100
         Enabled         =   -1  'True
      End
      Begin VB.Label LblPercentoBitumeSoft 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
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
         Height          =   315
         Left            =   1320
         TabIndex        =   42
         Top             =   480
         Width           =   615
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   17
         Left            =   2280
         TabIndex        =   41
         Top             =   510
         Width           =   255
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "sec."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   18
         Left            =   2040
         TabIndex        =   40
         Top             =   150
         Width           =   495
      End
      Begin VB.Label LblRitardoBitumeSoft 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
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
         Height          =   315
         Left            =   1320
         TabIndex        =   39
         Top             =   120
         Width           =   615
      End
      Begin VB.Label LblPercentoBitume 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
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
         Height          =   315
         Left            =   120
         TabIndex        =   37
         Top             =   480
         Width           =   615
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   16
         Left            =   1080
         TabIndex        =   36
         Top             =   510
         Width           =   255
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "sec."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   19
         Left            =   840
         TabIndex        =   35
         Top             =   150
         Width           =   495
      End
      Begin VB.Label LblRitardoBitume 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
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
         Height          =   315
         Left            =   120
         TabIndex        =   34
         Top             =   120
         Width           =   615
      End
   End
   Begin VB.Frame FrameBitumeHard 
      BackColor       =   &H00808080&
      Caption         =   "Bitume ""HARD"""
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   1455
      Left            =   120
      TabIndex        =   18
      Top             =   1560
      Width           =   7095
      Begin VB.TextBox TxtVeloxHard 
         Alignment       =   2  'Center
         BackColor       =   &H00000000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   600
         Locked          =   -1  'True
         TabIndex        =   65
         Text            =   "100"
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton CmdVersoPompaBitume 
         BackColor       =   &H00C0C0C0&
         Height          =   330
         Left            =   580
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   990
         Width           =   525
      End
      Begin AniBtn.AniPushButton ApbPompaBitume 
         Height          =   480
         Left            =   600
         TabIndex        =   20
         Top             =   510
         Width           =   480
         _Version        =   65536
         _ExtentX        =   847
         _ExtentY        =   847
         _StockProps     =   111
         Picture         =   "FrmSchiumatura.frx":1194
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin AniBtn.AniPushButton ApbValvImmissBitume 
         Height          =   435
         Left            =   6720
         TabIndex        =   30
         Top             =   720
         Width           =   300
         _Version        =   65536
         _ExtentX        =   529
         _ExtentY        =   767
         _StockProps     =   111
         ForeColor       =   0
         Picture         =   "FrmSchiumatura.frx":220A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin AniBtn.AniPushButton ApbValvBitume 
         Height          =   405
         Left            =   3600
         TabIndex        =   58
         Top             =   855
         Width           =   435
         _Version        =   65536
         _ExtentX        =   767
         _ExtentY        =   714
         _StockProps     =   111
         ForeColor       =   0
         Picture         =   "FrmSchiumatura.frx":2E68
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin MSComCtl2.UpDown UpDownHard 
         Height          =   330
         Left            =   1080
         TabIndex        =   62
         Top             =   240
         Width           =   255
         _ExtentX        =   450
         _ExtentY        =   582
         _Version        =   393216
         Value           =   40
         BuddyControl    =   "TxtVeloxHard"
         BuddyDispid     =   196624
         OrigLeft        =   960
         OrigTop         =   4680
         OrigRight       =   1200
         OrigBottom      =   5055
         Max             =   100
         Min             =   10
         SyncBuddy       =   -1  'True
         BuddyProperty   =   0
         Enabled         =   0   'False
      End
      Begin VB.Label LblFlussoTeorico 
         Alignment       =   1  'Right Justify
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   4200
         TabIndex        =   69
         Top             =   240
         Width           =   555
      End
      Begin VB.Label LblUnitaMisura 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Kg/min"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000080FF&
         Height          =   255
         Index           =   11
         Left            =   4800
         TabIndex        =   68
         Top             =   285
         Width           =   690
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   1
         Left            =   5677
         Picture         =   "FrmSchiumatura.frx":43E8
         Top             =   420
         Width           =   480
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   0
         Left            =   2077
         Picture         =   "FrmSchiumatura.frx":4A72
         Top             =   780
         Width           =   480
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   5
         Left            =   2077
         Picture         =   "FrmSchiumatura.frx":50FC
         Top             =   180
         Width           =   480
      End
      Begin VB.Label LblTempOlio 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   2040
         TabIndex        =   28
         Top             =   960
         Width           =   555
      End
      Begin VB.Label LblPortataBitumeM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000E&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   4200
         TabIndex        =   27
         Top             =   600
         Width           =   555
      End
      Begin VB.Label LblTempBitumeM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   5640
         TabIndex        =   26
         Top             =   600
         Width           =   555
      End
      Begin VB.Label LblTempBitume 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   2040
         TabIndex        =   25
         Top             =   360
         Width           =   555
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   3
         Left            =   2640
         TabIndex        =   24
         Top             =   405
         Width           =   375
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   4
         Left            =   2640
         TabIndex        =   23
         Top             =   1005
         Width           =   375
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   5
         Left            =   6240
         TabIndex        =   22
         Top             =   645
         Width           =   375
      End
      Begin VB.Label LblUnitaMisura 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Kg/min"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   6
         Left            =   4800
         TabIndex        =   21
         Top             =   645
         Width           =   690
      End
      Begin VB.Shape ShapeBitumeHard 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   0
         Left            =   450
         Top             =   720
         Width           =   3450
      End
      Begin VB.Shape ShapeBitumeHard 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   1
         Left            =   240
         Top             =   1320
         Width           =   3615
      End
      Begin VB.Shape ShapeBitumeHard 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   10
         Left            =   3990
         Top             =   1020
         Width           =   2775
      End
      Begin VB.Shape ShapeBitumeHard 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   470
         Index           =   3
         Left            =   240
         Top             =   930
         Width           =   75
      End
      Begin VB.Image ImgTempOlio 
         Height          =   480
         Index           =   1
         Left            =   1500
         Picture         =   "FrmSchiumatura.frx":5786
         Top             =   810
         Width           =   480
      End
      Begin VB.Image ImgCisternaBitumeHard 
         Height          =   480
         Left            =   30
         Picture         =   "FrmSchiumatura.frx":6050
         Top             =   480
         Width           =   480
      End
      Begin VB.Shape ShapeBitumeHard 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   675
         Index           =   2
         Left            =   3840
         Top             =   720
         Width           =   75
      End
   End
   Begin VB.Frame FrameRampa 
      BackColor       =   &H00808080&
      Caption         =   "Rampa"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   1455
      Left            =   7440
      TabIndex        =   14
      Top             =   0
      Width           =   2175
      Begin VB.Label LblTempoSchiumatura 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0 sec"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1290
         TabIndex        =   67
         Top             =   645
         Width           =   735
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   2
         Left            =   270
         Picture         =   "FrmSchiumatura.frx":6892
         Top             =   240
         Width           =   480
      End
      Begin VB.Label LblTempRampa 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   240
         TabIndex        =   46
         Top             =   420
         Width           =   555
      End
      Begin VB.Label LblPressioneRampa 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000E&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   240
         TabIndex        =   45
         Top             =   900
         Width           =   555
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "Bar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   9
         Left            =   840
         TabIndex        =   44
         Top             =   945
         Width           =   375
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   10
         Left            =   840
         TabIndex        =   43
         Top             =   465
         Width           =   375
      End
      Begin VB.Image ImgRampa 
         Height          =   1125
         Left            =   120
         Picture         =   "FrmSchiumatura.frx":6F1C
         Stretch         =   -1  'True
         Top             =   240
         Width           =   1950
      End
   End
   Begin VB.Frame FrameSolvente 
      BackColor       =   &H00808080&
      Caption         =   "Solvente"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   1455
      Left            =   7440
      TabIndex        =   12
      Top             =   1560
      Width           =   2175
      Begin AniBtn.AniPushButton ApbValvImmissSolvente 
         Height          =   435
         Left            =   1800
         TabIndex        =   13
         Top             =   480
         Width           =   300
         _Version        =   65536
         _ExtentX        =   529
         _ExtentY        =   767
         _StockProps     =   111
         ForeColor       =   0
         Picture         =   "FrmSchiumatura.frx":9686
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Shape ShapeSolvente 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   10
         Left            =   450
         Top             =   780
         Width           =   1425
      End
      Begin VB.Image ImgCisternaSolvente 
         Height          =   480
         Left            =   30
         Picture         =   "FrmSchiumatura.frx":A2E4
         Top             =   540
         Width           =   480
      End
   End
   Begin VB.Frame FrameAcqua 
      BackColor       =   &H00808080&
      Caption         =   "Acqua"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   1455
      Left            =   120
      TabIndex        =   6
      Top             =   0
      Width           =   7095
      Begin VB.TextBox TxtVeloxH2O 
         Alignment       =   2  'Center
         BackColor       =   &H00000000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   600
         Locked          =   -1  'True
         TabIndex        =   64
         Text            =   "100"
         Top             =   240
         Width           =   495
      End
      Begin AniBtn.AniPushButton ApbPompaAcqua 
         Height          =   480
         Left            =   600
         TabIndex        =   7
         Top             =   510
         Width           =   480
         _Version        =   65536
         _ExtentX        =   847
         _ExtentY        =   847
         _StockProps     =   111
         Picture         =   "FrmSchiumatura.frx":AB26
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin AniBtn.AniPushButton ApbValvImmissAcqua 
         Height          =   435
         Left            =   6720
         TabIndex        =   29
         Top             =   720
         Width           =   300
         _Version        =   65536
         _ExtentX        =   529
         _ExtentY        =   767
         _StockProps     =   111
         ForeColor       =   0
         Enabled         =   0   'False
         Picture         =   "FrmSchiumatura.frx":BB9C
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin AniBtn.AniPushButton ApbValvAcqua 
         Height          =   405
         Left            =   3600
         TabIndex        =   57
         Top             =   855
         Width           =   435
         _Version        =   65536
         _ExtentX        =   767
         _ExtentY        =   714
         _StockProps     =   111
         ForeColor       =   0
         Picture         =   "FrmSchiumatura.frx":C7FA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin MSComCtl2.UpDown UpDownH2O 
         Height          =   330
         Left            =   1080
         TabIndex        =   61
         Top             =   240
         Width           =   255
         _ExtentX        =   450
         _ExtentY        =   582
         _Version        =   393216
         Value           =   40
         BuddyControl    =   "TxtVeloxH2O"
         BuddyDispid     =   196644
         OrigLeft        =   960
         OrigTop         =   4680
         OrigRight       =   1200
         OrigBottom      =   5055
         Max             =   100
         Min             =   10
         SyncBuddy       =   -1  'True
         BuddyProperty   =   0
         Enabled         =   0   'False
      End
      Begin VB.Label LblStep1 
         BackStyle       =   0  'Transparent
         Caption         =   "XX"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   6240
         TabIndex        =   56
         Top             =   240
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label LblStep2 
         BackStyle       =   0  'Transparent
         Caption         =   "XX"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   6720
         TabIndex        =   55
         Top             =   240
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Shape ShapeAcqua 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   470
         Index           =   3
         Left            =   240
         Top             =   930
         Width           =   75
      End
      Begin VB.Shape ShapeAcqua 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   10
         Left            =   3960
         Top             =   1020
         Width           =   2775
      End
      Begin VB.Shape ShapeAcqua 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   1
         Left            =   240
         Top             =   1320
         Width           =   3615
      End
      Begin VB.Shape ShapeAcqua 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   0
         Left            =   450
         Top             =   720
         Width           =   3450
      End
      Begin VB.Label LblUnitaMisura 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Kg/sec"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   2
         Left            =   2640
         TabIndex        =   11
         Top             =   1005
         Width           =   690
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "Bar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   1
         Left            =   2640
         TabIndex        =   10
         Top             =   405
         Width           =   375
      End
      Begin VB.Label LblPressioneAcqua 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000E&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2040
         TabIndex        =   9
         Top             =   360
         Width           =   555
      End
      Begin VB.Label LblPortataAcqua 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000E&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2040
         TabIndex        =   8
         Top             =   960
         Width           =   555
      End
      Begin VB.Image ImgCisternaAcqua 
         Height          =   480
         Left            =   30
         Picture         =   "FrmSchiumatura.frx":DD7A
         Top             =   480
         Width           =   480
      End
      Begin VB.Shape ShapeAcqua 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   675
         Index           =   2
         Left            =   3840
         Top             =   720
         Width           =   75
      End
   End
   Begin VB.Frame FrameBitumeSoft 
      BackColor       =   &H00808080&
      Caption         =   "Bitume ""SOFT"""
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   1455
      Left            =   120
      TabIndex        =   0
      Top             =   3120
      Width           =   7095
      Begin VB.TextBox TxtVeloxSoft 
         Alignment       =   2  'Center
         BackColor       =   &H00000000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   600
         Locked          =   -1  'True
         TabIndex        =   66
         Text            =   "100"
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton CmdVersoPompaBitumeSoft 
         BackColor       =   &H00C0C0C0&
         Height          =   330
         Left            =   580
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   990
         Width           =   525
      End
      Begin AniBtn.AniPushButton ApbPompaBitumeSoft 
         Height          =   480
         Left            =   600
         TabIndex        =   1
         Top             =   510
         Width           =   480
         _Version        =   65536
         _ExtentX        =   847
         _ExtentY        =   847
         _StockProps     =   111
         Picture         =   "FrmSchiumatura.frx":E5BC
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin AniBtn.AniPushButton ApbValvImmissBitumeSoft 
         Height          =   435
         Left            =   6720
         TabIndex        =   31
         Top             =   720
         Width           =   300
         _Version        =   65536
         _ExtentX        =   529
         _ExtentY        =   767
         _StockProps     =   111
         ForeColor       =   0
         Picture         =   "FrmSchiumatura.frx":F632
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin AniBtn.AniPushButton ApbValvBitumeSoft 
         Height          =   405
         Left            =   3600
         TabIndex        =   59
         Top             =   855
         Width           =   435
         _Version        =   65536
         _ExtentX        =   767
         _ExtentY        =   714
         _StockProps     =   111
         ForeColor       =   0
         Picture         =   "FrmSchiumatura.frx":10290
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin MSComCtl2.UpDown UpDownSoft 
         Height          =   330
         Left            =   1080
         TabIndex        =   63
         Top             =   240
         Width           =   255
         _ExtentX        =   450
         _ExtentY        =   582
         _Version        =   393216
         Value           =   40
         BuddyControl    =   "TxtVeloxSoft"
         BuddyDispid     =   196652
         OrigLeft        =   960
         OrigTop         =   4680
         OrigRight       =   1200
         OrigBottom      =   5055
         Max             =   100
         Min             =   10
         SyncBuddy       =   -1  'True
         BuddyProperty   =   0
         Enabled         =   0   'False
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   7
         Left            =   2077
         Picture         =   "FrmSchiumatura.frx":11810
         Top             =   180
         Width           =   480
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   2040
         TabIndex        =   48
         Top             =   360
         Width           =   555
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   20
         Left            =   2640
         TabIndex        =   47
         Top             =   345
         Width           =   375
      End
      Begin VB.Image ImgTempOlio 
         Height          =   480
         Index           =   0
         Left            =   1500
         Picture         =   "FrmSchiumatura.frx":11E9A
         Top             =   810
         Width           =   480
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   6
         Left            =   2077
         Picture         =   "FrmSchiumatura.frx":12764
         Top             =   780
         Width           =   480
      End
      Begin VB.Label LblTempOlioBitumeSoft 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   2040
         TabIndex        =   17
         Top             =   960
         Width           =   555
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   15
         Left            =   2640
         TabIndex        =   16
         Top             =   1005
         Width           =   375
      End
      Begin VB.Shape ShapeBitumeSoft 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   465
         Index           =   3
         Left            =   240
         Top             =   930
         Width           =   75
      End
      Begin VB.Shape ShapeBitumeSoft 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   10
         Left            =   3960
         Top             =   1020
         Width           =   2865
      End
      Begin VB.Shape ShapeBitumeSoft 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   1
         Left            =   240
         Top             =   1320
         Width           =   3615
      End
      Begin VB.Shape ShapeBitumeSoft 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   75
         Index           =   0
         Left            =   450
         Top             =   720
         Width           =   3450
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "Kg / h"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   8
         Left            =   4800
         TabIndex        =   5
         Top             =   645
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label LblUnitaMisura 
         BackStyle       =   0  'Transparent
         Caption         =   "C."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Index           =   7
         Left            =   6240
         TabIndex        =   4
         Top             =   645
         Width           =   375
      End
      Begin VB.Image ImgTemp 
         Height          =   240
         Index           =   3
         Left            =   5677
         Picture         =   "FrmSchiumatura.frx":12DEE
         Top             =   420
         Width           =   480
      End
      Begin VB.Label LblPortataBitumeSoftM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000E&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   4200
         TabIndex        =   3
         Top             =   600
         Visible         =   0   'False
         Width           =   555
      End
      Begin VB.Label LblTempBitumeSoftM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "XXX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   330
         Left            =   5640
         TabIndex        =   2
         Top             =   600
         Width           =   555
      End
      Begin VB.Image ImgCisternaBitumeSoft 
         Height          =   480
         Left            =   30
         Picture         =   "FrmSchiumatura.frx":13478
         Top             =   480
         Width           =   480
      End
      Begin VB.Shape ShapeBitumeSoft 
         BackColor       =   &H00C0C0B0&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00400040&
         BorderStyle     =   0  'Transparent
         FillColor       =   &H00400040&
         Height          =   675
         Index           =   2
         Left            =   3840
         Top             =   720
         Width           =   75
      End
   End
   Begin AniBtn.AniPushButton AniP_Automatico 
      Height          =   480
      Left            =   7440
      TabIndex        =   60
      Top             =   3245
      Width           =   480
      _Version        =   65536
      _ExtentX        =   847
      _ExtentY        =   847
      _StockProps     =   111
      BackColor       =   65535
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FrmSchiumatura.frx":13CBA
      Cycle           =   1
      ButtonVersion   =   1024
   End
   Begin VB.Image ImgFrecciaSx 
      Height          =   480
      Left            =   9120
      Picture         =   "FrmSchiumatura.frx":153F8
      Top             =   3840
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Image ImgFrecciaDx 
      Height          =   480
      Left            =   8640
      Picture         =   "FrmSchiumatura.frx":15CC2
      Top             =   3840
      Visible         =   0   'False
      Width           =   480
   End
End
Attribute VB_Name = "FrmSchiumatura"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'
'   Form di visualizzazione dello stato del circuito del bitume schiumato
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Sub AniP_Automatico_Click()

    If MotoriInAutomatico Then
        UpDownH2O.enabled = (AniP_Automatico.value = 2)
        UpDownHard.enabled = (AniP_Automatico.value = 2)
        UpDownSoft.enabled = (AniP_Automatico.value = 2)
    Else
        AniP_Automatico.value = 2
        Exit Sub
    End If
    TxtVeloxH2O.text = PlcSchiumato.Perc_Velox_H2O
    TxtVeloxHard.text = PlcSchiumato.Perc_Velox_BHard
    TxtVeloxSoft.text = PlcSchiumato.Perc_Velox_BSoft
    CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value = (AniP_Automatico.value = 1)
    If (AniP_Automatico.value = 2) Then
        CP240.OPCDataSchiumato.Items(VelocitaInverterH2O_idx).value = val(TxtVeloxH2O.text) * 27648 / 100
        CP240.OPCDataSchiumato.Items(VelocitaInverterHard_idx).value = val(TxtVeloxHard.text) * 27648 / 100
        CP240.OPCDataSchiumato.Items(VelocitaInverterSoft_idx).value = val(TxtVeloxSoft.text) * 27648 / 100
    End If

End Sub

Private Sub CmdHelp_Click()
    VisualizzaHelp Me, HELP_INIZIO
End Sub


Private Sub CmdEsci_Click()

    TmrScansione.enabled = False

    FrmSchiumaturaVisibile = False
    
    CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value = (MotoriInAutomatico)
    CP240.OPCDataSchiumato.Items(VelocitaInverterH2O_idx).value = PlcSchiumato.Perc_Velox_H2O * 27648 / 100
    CP240.OPCDataSchiumato.Items(VelocitaInverterHard_idx).value = (PlcSchiumato.Perc_Velox_BHard * 27648 / 100) * (PlcSchiumato.Perc_Velox_BHard_Ottimale / 100)
    CP240.OPCDataSchiumato.Items(VelocitaInverterSoft_idx).value = PlcSchiumato.Perc_Velox_BSoft * 27648 / 100
    
    Call VisualizzaBarraPulsantiCP240(True)

    Me.Hide
    Unload Me

End Sub

Public Sub ShowMe(ByVal Modo As Integer, ByRef parente As Form)

    FrmSchiumaturaVisibile = True
    FrmSchiumatura.Show Modo, parente

End Sub

Private Sub Form_Load()

    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)
    
    Call CarattereOccidentale(Me)

    CmdEsci.Picture = LoadResPicture("IDI_USCITA", vbResIcon)
    CmdEsci.ToolTipText = LoadXLSString(568)
    CmdHelp.Picture = LoadResPicture("IDI_HELP", vbResIcon)
    CmdHelp.ToolTipText = LoadXLSString(110)
    
    LblUnitaMisura(1).caption = LoadXLSString(665)
    LblUnitaMisura(9).caption = LoadXLSString(665)
    LblUnitaMisura(3).caption = LoadXLSString(725)
    LblUnitaMisura(4).caption = LoadXLSString(725)
    LblUnitaMisura(5).caption = LoadXLSString(725)
    LblUnitaMisura(7).caption = LoadXLSString(725)
    LblUnitaMisura(10).caption = LoadXLSString(725)
    LblUnitaMisura(15).caption = LoadXLSString(725)
    LblUnitaMisura(20).caption = LoadXLSString(725)
    
    'TODO
    LblUnitaMisura(2).caption = "Kg/min"
    LblUnitaMisura(2).AutoSize = True
    LblUnitaMisura(6).caption = "Kg/min"
    LblUnitaMisura(6).AutoSize = True
    LblUnitaMisura(8).caption = "Kg/h"
    LblUnitaMisura(8).AutoSize = True
    '

    FrameBitumeSoft.Visible = PlcSchiumato.abilitazioneSoft
    If PlcSchiumato.abilitazioneSoft Then
        FrameRampa.top = 840
        FrameSolvente.top = 2400
        CmdHelp.top = 4050
        CmdEsci.top = 4050
        AniP_Automatico.top = 4095

        Me.Height = 5040
    Else
        FrameRampa.top = 0
        FrameSolvente.top = 1560
        CmdHelp.top = 3090
        CmdEsci.top = 3090
        AniP_Automatico.top = 3135

        Me.Height = 4080
    End If
    
    If (DEBUGGING) Then
        'DEBUG
        LblPeso.Visible = True
        LblStep1.Visible = True
        LblStep2.Visible = True
    End If

    Call AggiornaStatoSchiumato

    TmrScansione.enabled = True
    
    UpDownH2O.enabled = Not MotoriInAutomatico
    UpDownHard.enabled = Not MotoriInAutomatico
    UpDownSoft.enabled = Not MotoriInAutomatico
    If MotoriInAutomatico Then
        AniP_Automatico.value = 1
    Else
        AniP_Automatico.value = 2
    End If
    TxtVeloxH2O.text = PlcSchiumato.Perc_Velox_H2O
    TxtVeloxHard.text = PlcSchiumato.Perc_Velox_BHard

    'Solo per prove in cantiere
    FrmSchiumatura.LblFlussoTeorico.caption = PlcSchiumato.FlussoTeoricoB_Hard

End Sub


Private Sub TmrScansione_Timer()

    AbilitaInterfaccia

End Sub

Private Sub AbilitaInterfaccia()

Dim abilita As Boolean
Dim MotoriSchiumatoAutomatico As Boolean

    abilita = PlcSchiumatoConnesso
    If (abilita And CP240.OPCDataSchiumato.Items.count > 0) Then
        abilita = (Not CP240.OPCDataSchiumato.Items(AutomaticoCiclo_idx).value)
    End If
    
    MotoriSchiumatoAutomatico = CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value
    If MotoriSchiumatoAutomatico Then
        AniP_Automatico.value = 1
    Else
        AniP_Automatico.value = 2
    End If

    ApbPompaAcqua.enabled = (PlcSchiumatoConnesso And Not MotoriSchiumatoAutomatico)
    ApbValvAcqua.enabled = abilita
    'ApbValvImmissAcqua.enabled = Non si comanda manualmente

    ApbPompaBitume.enabled = (PlcSchiumatoConnesso And Not MotoriSchiumatoAutomatico)
    ApbValvBitume.enabled = abilita
    ApbValvImmissBitume.enabled = abilita

    ApbValvImmissSolvente.enabled = (PlcSchiumatoConnesso And True) 'Sempre abilitato

    ApbPompaBitumeSoft.enabled = (PlcSchiumatoConnesso And Not MotoriSchiumatoAutomatico)
    ApbValvBitumeSoft.enabled = abilita
    ApbValvImmissBitumeSoft.enabled = abilita

End Sub

Public Sub AggiornaStatoSchiumato()

    If (Not PlcSchiumatoConnesso) Then
        Exit Sub
    End If

    With CP240.OPCDataSchiumato

        If (.Items.count <= 0) Then
            Exit Sub
        End If

        PLCSchiumatoAutomatico
        PLCSchiumatoAbilitaCiclo

        LblPeso.caption = Format(.Items(PesoAggregati_idx).value, "0")
        LblStep1.caption = CStr(.Items(StepBitume_idx).value)
        LblStep2.caption = CStr(.Items(StepBSoft_idx).value)


        PLCSchiumatoPompaBitume
        PLCSchiumatoValvBitume
        PLCSchiumatoValvImmissBitume
        
        LblTempOlio.caption = Format(.Items(TemperaturaOlio_idx).value, "0")
        LblTempBitume.caption = Format(.Items(TemperaturaBitume_idx).value, "0")
        
        If .Items(TemperaturaBitume_idx).value < PlcSchiumato.MinTemperaturaBitume Then
            LblTempBitume.BackColor = &HE0E0E0 'grigio
        Else
            LblTempBitume.BackColor = &HFFFF00 'azzurro
        End If
        If .Items(TemperaturaOlio_idx).value < PlcSchiumato.MinTemperaturaBitume Then
            LblTempOlio.BackColor = &HE0E0E0 'grigio
        Else
            LblTempOlio.BackColor = &HFFFF00 'azzurro
        End If
        If .Items(TemperaturaBitumeM_idx).value < PlcSchiumato.MinTemperaturaBitume Then
            LblTempBitumeM.BackColor = &HE0E0E0 'grigio
        Else
            LblTempBitumeM.BackColor = &HFFFF00 'azzurro
        End If

        If .Items(TemperaturaRampa_idx).value < PlcSchiumato.MinTemperaturaRampa Then
            LblTempRampa.BackColor = &HE0E0E0 'grigio
        Else
            LblTempRampa.BackColor = &HFFFF00 'azzurro
        End If


        LblTempBitumeM.caption = Format(.Items(TemperaturaBitumeM_idx).value, "0")
        LblPortataBitumeM.caption = RoundNumber(.Items(PortataBitume_idx).value / 60, 0)


        PLCSchiumatoPompaAcqua
        PLCSchiumatoValvAcqua
        PLCSchiumatoValvImmissAcqua

        LblPressioneAcqua.caption = Format(.Items(PressioneH2O_idx).value, "0.0")
        LblPortataAcqua.caption = Format(.Items(PortataH2O_idx).value / 60, "0.0")

        PLCSchiumatoValvImmissSolvente

        PLCSchiumatoPompaBitumeSoft
        PLCSchiumatoValvBitumeSoft
        PLCSchiumatoValvImmissBitumeSoft

        LblTempOlioBitumeSoft.caption = Format(.Items(TemperaturaOlioBSoft_idx).value, "0")
        LblTempBitumeSoftM.caption = Format(.Items(TemperaturaBSoftM_idx).value, "0")
        'LblPortataBitumeSoftM.Caption = Format(.Items(PortataBSoft_idx).value, "0")

        LblPressioneRampa.caption = Format(.Items(PressioneRampa_idx).value, "0.0")
        LblTempRampa.caption = Format(.Items(TemperaturaRampa_idx).value, "0")
    
    
    End With

End Sub

'ACQUA

Private Sub ApbPompaAcqua_Click()
'Non uso lo standard dei motori come in CP240 perchè ho poco tempo, ho fatto le immagini dentro l'anipushbutton già con il motore bianco

    PLCSchiumatoManualePompaAcqua (ApbPompaAcqua.value = 2)

End Sub

Private Sub ApbValvAcqua_Click()

    PLCSchiumatoManualeValvAcqua (ApbValvAcqua.value = 3)

End Sub

Private Sub ApbValvImmissAcqua_Click()

    PLCSchiumatoManualeValvImmissH20 (ApbValvImmissAcqua.value = 2)

End Sub

'BITUME HARD

Private Sub ApbPompaBitume_Click()
'Non uso lo standard dei motori come in CP240 perchè ho poco tempo, ho fatto le immagini dentro l'anipushbutton già con il motore bianco

    PLCSchiumatoManualePompaBitume (ApbPompaBitume.value = 2)

End Sub

Private Sub CmdVersoPompaBitume_Click()

    PLCSchiumatoInversionePompaBitume

End Sub

Private Sub ApbValvBitume_Click()

    PLCSchiumatoManualeValvBitume (ApbValvBitume.value = 3)

End Sub

Private Sub ApbValvImmissBitume_Click()

    PLCSchiumatoManualeValvImmissBitume (ApbValvImmissBitume.value = 2)

End Sub

Private Sub UpDownH2O_Change()
    CP240.OPCDataSchiumato.Items(VelocitaInverterH2O_idx).value = val(TxtVeloxH2O.text) * 27648 / 100
End Sub

Private Sub UpDownHard_Change()
    CP240.OPCDataSchiumato.Items(VelocitaInverterHard_idx).value = val(TxtVeloxHard.text) * 27648 / 100
End Sub

Private Sub UpDownPercentoBitume_Change()

    PLCSchiumatoSetPercentoBitumeHard CDbl(LblPercentoBitume.caption)

End Sub

'SOLVENTE

Private Sub ApbValvImmissSolvente_Click()
    'PLCSchiumatoManualeValvImmissSolvente (ApbValvImmissSolvente.value = 2)
End Sub

Private Sub ApbValvImmissSolvente_LostFocus()
    PLCSchiumatoManualeValvImmissSolvente False
End Sub

Private Sub ApbValvImmissSolvente_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    PLCSchiumatoManualeValvImmissSolvente True
End Sub

Private Sub ApbValvImmissSolvente_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    PLCSchiumatoManualeValvImmissSolvente False
End Sub


'BITUME SOFT

Private Sub ApbPompaBitumeSoft_Click()
'Non uso lo standard dei motori come in CP240 perchè ho poco tempo, ho fatto le immagini dentro l'anipushbutton già con il motore bianco

    PLCSchiumatoManualePompaBitumeSoft (ApbPompaBitumeSoft.value = 2)

End Sub

Private Sub CmdVersoPompaBitumeSoft_Click()

    PLCSchiumatoInversionePompaBitumeSoft

End Sub

Private Sub ApbValvBitumeSoft_Click()

    PLCSchiumatoManualeValvBitumeSoft (ApbValvBitumeSoft.value = 2)

End Sub

Private Sub ApbValvImmissBitumeSoft_Click()

    PLCSchiumatoManualeValvImmissBitumeSoft (ApbValvImmissBitumeSoft.value = 2)

End Sub

Private Sub UpDownPercentoBitumeSoft_Change()

    PLCSchiumatoSetPercentoBitumeSoft CDbl(LblPercentoBitumeSoft.caption)

End Sub

Private Sub UpDownSoft_Change()

    CP240.OPCDataSchiumato.Items(VelocitaInverterSoft_idx).value = val(TxtVeloxSoft.text) * 27648 / 100

End Sub
