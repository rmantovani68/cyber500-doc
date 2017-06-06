VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{1AE48573-2A39-493C-824B-929C2A9BEA27}#1.0#0"; "XYChart4_3.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FormPIDBruc 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MARINI"
   ClientHeight    =   3015
   ClientLeft      =   45
   ClientTop       =   525
   ClientWidth     =   9750
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FormPIDBruc.frx":0000
   ScaleHeight     =   3015
   ScaleWidth      =   9750
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frameTrend 
      BackColor       =   &H00FFFFFF&
      Height          =   9615
      Left            =   0
      TabIndex        =   34
      Top             =   3000
      Width           =   9735
      Begin AniBtn.AniPushButton apbStartStopTrend 
         Height          =   480
         Left            =   8640
         TabIndex        =   37
         Top             =   2160
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
         Picture         =   "FormPIDBruc.frx":0F2E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin XYChart4_3.XYChart4Ctl xychartCalibraz 
         Height          =   4695
         Left            =   120
         TabIndex        =   35
         Top             =   120
         Width           =   9615
         _ExtentX        =   16960
         _ExtentY        =   8281
         BackColor       =   16777215
         X0FormatStyle   =   1
         Profile0Label   =   "Profile1"
      End
      Begin XYChart4_3.XYChart4Ctl xychartParam 
         Height          =   4695
         Left            =   120
         TabIndex        =   36
         Top             =   4920
         Width           =   9615
         _ExtentX        =   16960
         _ExtentY        =   8281
         BackColor       =   16777215
         X0FormatStyle   =   1
         Profile0Label   =   "Profile1"
      End
   End
   Begin VB.Frame frameParametri 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Parametri"
      Height          =   2175
      Left            =   0
      TabIndex        =   31
      Top             =   840
      Width           =   4575
      Begin VB.TextBox txtCorrManSetPosMod 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   3600
         TabIndex        =   32
         Text            =   "100"
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblCorrManSetPosMod 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Correzione manuale posizione modulatore"
         BeginProperty Font 
            Name            =   "Arial Narrow"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   33
         Top             =   285
         Width           =   3375
      End
   End
   Begin VB.Frame FrameDebug 
      BackColor       =   &H00FFFFFF&
      Height          =   2175
      Left            =   4680
      TabIndex        =   19
      Top             =   840
      Visible         =   0   'False
      Width           =   5055
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Valori debug regolazione bruciatore"
         ForeColor       =   &H80000008&
         Height          =   2055
         Index           =   10
         Left            =   2280
         TabIndex        =   30
         Top             =   120
         Width           =   2655
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   8
         Left            =   1560
         TabIndex        =   29
         ToolTipText     =   "SET MODULATORE"
         Top             =   240
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   9
         Left            =   1560
         TabIndex        =   28
         ToolTipText     =   "SET MODULATORE TOT"
         Top             =   600
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   0
         Left            =   120
         TabIndex        =   27
         ToolTipText     =   "ALLARME 141"
         Top             =   240
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   1
         Left            =   120
         TabIndex        =   26
         ToolTipText     =   "Durata Impulso Uscita Regolaz Modulatore"
         Top             =   600
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   2
         Left            =   120
         TabIndex        =   25
         ToolTipText     =   "Timer Out Incremento Bruciatore"
         Top             =   960
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   3
         Left            =   120
         TabIndex        =   24
         ToolTipText     =   "Timer Out Decremento Bruciatore"
         Top             =   1320
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   4
         Left            =   840
         TabIndex        =   23
         ToolTipText     =   "Differenza Percentuale Di Temperatura Set E Reale"
         Top             =   240
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   5
         Left            =   840
         TabIndex        =   22
         ToolTipText     =   "Portata Totale Set Pred. Vergini E Riciclati"
         Top             =   600
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   6
         Left            =   840
         TabIndex        =   21
         ToolTipText     =   "Differenza Umidita Tra Test e Set (%)"
         Top             =   960
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.Label LblDebug 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         ForeColor       =   &H80000008&
         Height          =   210
         Index           =   7
         Left            =   840
         TabIndex        =   20
         ToolTipText     =   "Umidita Istantanea Tot Vergini e Riciclati (%)"
         Top             =   1320
         Visible         =   0   'False
         Width           =   495
      End
   End
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   4320
      Top             =   0
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
            Picture         =   "FormPIDBruc.frx":27A4
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":2D6C
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":3321
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":38E1
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":3EA1
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":44FF
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":4B46
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":519C
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":57F2
            Key             =   "PLUS_IMG_SAVE"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":5E1C
            Key             =   "PLUS_IMG_SAVE_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":6461
            Key             =   "PLUS_IMG_SAVE_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":6AC0
            Key             =   "PLUS_IMG_SAVE_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":711D
            Key             =   "PLUS_IMG_GRAPH"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":7607
            Key             =   "PLUS_IMG_GRAPH_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":7B53
            Key             =   "PLUS_IMG_GRAPH_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormPIDBruc.frx":809B
            Key             =   "PLUS_IMG_GRAPH_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Timer TimerGraficoBruciatore 
      Interval        =   3000
      Left            =   6840
      Top             =   0
   End
   Begin VB.Frame FrameModPID 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Modulatore"
      Height          =   3255
      Left            =   240
      TabIndex        =   14
      Top             =   6240
      Width           =   9255
      Begin VB.PictureBox GraficoMod 
         BackColor       =   &H80000007&
         Height          =   2055
         Left            =   360
         ScaleHeight     =   1995
         ScaleWidth      =   7755
         TabIndex        =   15
         Top             =   960
         Width           =   7815
      End
      Begin VB.Label LblModulatore 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00000000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "100"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   405
         Left            =   8400
         TabIndex        =   17
         Top             =   960
         Width           =   615
      End
      Begin VB.Label LblPID 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Andamento apertura modulatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   360
         TabIndex        =   16
         Top             =   480
         Width           =   3975
      End
   End
   Begin VB.Frame FrameTempPID 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Temperatura"
      Height          =   3255
      Left            =   240
      TabIndex        =   9
      Top             =   3000
      Width           =   9255
      Begin VB.TextBox TextTempBrucSet 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   8400
         Locked          =   -1  'True
         TabIndex        =   12
         Text            =   "170"
         Top             =   1560
         Width           =   615
      End
      Begin VB.PictureBox GraficoTemp 
         BackColor       =   &H80000007&
         Height          =   2055
         Left            =   360
         ScaleHeight     =   1995
         ScaleWidth      =   7755
         TabIndex        =   10
         Top             =   960
         Width           =   7815
      End
      Begin VB.Label LblPID 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Andamento temperatura bruciatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   360
         TabIndex        =   13
         Top             =   480
         Width           =   3975
      End
      Begin VB.Label LblTempBruc 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFF00&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   390
         Left            =   8400
         TabIndex        =   11
         Top             =   960
         Width           =   615
      End
   End
   Begin VB.Frame FrameParPID 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Parametri PID"
      Height          =   615
      Left            =   4800
      TabIndex        =   0
      Top             =   1200
      Visible         =   0   'False
      Width           =   1215
      Begin VB.TextBox TextParPID 
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
         Height          =   345
         Index           =   3
         Left            =   2880
         TabIndex        =   8
         Text            =   "0"
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox TextParPID 
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
         Height          =   345
         Index           =   2
         Left            =   2880
         TabIndex        =   3
         Text            =   "0"
         Top             =   360
         Width           =   615
      End
      Begin VB.TextBox TextParPID 
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
         Height          =   345
         Index           =   1
         Left            =   960
         TabIndex        =   2
         Text            =   "0"
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox TextParPID 
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
         Height          =   345
         Index           =   0
         Left            =   960
         TabIndex        =   1
         Text            =   "0"
         Top             =   360
         Width           =   615
      End
      Begin VB.CommandButton CmdModParPID 
         Appearance      =   0  'Flat
         BackColor       =   &H00E0E0E0&
         Height          =   750
         Left            =   1320
         Picture         =   "FormPIDBruc.frx":85E6
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   1320
         Width           =   1125
      End
      Begin VB.Label LblParPID 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Tc"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   2160
         TabIndex        =   7
         Top             =   840
         Width           =   495
      End
      Begin VB.Label LblParPID 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Kd"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   2160
         TabIndex        =   6
         Top             =   360
         Width           =   495
      End
      Begin VB.Label LblParPID 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Ki"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   5
         Top             =   840
         Width           =   495
      End
      Begin VB.Label LblParPID 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Kp"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   4
         Top             =   360
         Width           =   495
      End
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   3
      Left            =   0
      Picture         =   "FormPIDBruc.frx":8B21
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Enabled         =   0   'False
      Height          =   750
      Index           =   2
      Left            =   1200
      Picture         =   "FormPIDBruc.frx":8FFB
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   7560
      Picture         =   "FormPIDBruc.frx":9615
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   8685
      Picture         =   "FormPIDBruc.frx":9C63
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image ImgFiammaBrucPID 
      Height          =   630
      Left            =   6840
      Picture         =   "FormPIDBruc.frx":A21B
      Stretch         =   -1  'True
      Top             =   1605
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Image ImgBrucPID 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   2055
      Left            =   5400
      Stretch         =   -1  'True
      Top             =   840
      Width           =   4080
   End
End
Attribute VB_Name = "FormPIDBruc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private primaVolta As Boolean
Private x As Integer
Private PixTemp As Double
Private GraphTemp(100) As Integer
Private PixMod As Double
Private GraphMod(100) As Integer
'20161230
'Dim KpPrec, KiPrec, KdPrec, TcPrec As Double
'Dim SetPointPID As Integer
'Private Const FileTabBruciatore As String = "ParaBruciatore.ini"
'Private Const SEZIONE As String = "Bruciatore"
Private TmrLblDebug(0 To 9) As Long
'

Private Enum TopBarButtonEnum
    uscita
    Help
    Salva
    TBB_Grafico
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'
Private TrendSample As Integer '20170324
Private FormHeightMin As Long

Private Sub apbStartStopTrend_Click()
    
    With xychartCalibraz
        .trend.enable = (apbStartStopTrend.Value = 1)
        .Toolbar.Visible = (apbStartStopTrend.Value = 2)
        .Refresh
    End With
           
End Sub

'20161230
'Private Sub CmdModParPID_Click()
'    VarizioneParametriMomentanea
'End Sub
'

Private Sub Form_Load()

    On Error GoTo Errore

    '20160218
    Call CarattereOccidentale(Me)
    '

    primaVolta = True

    imgPulsanteForm(0).ToolTipText = LoadXLSString(568)

    '20161230
    'FrameParPID.caption = LoadXLSString(1399)
    '
    'FrameTempPID.caption = LoadXLSString(698)
    'FrameModPID.caption = LoadXLSString(1401)
    'LblPID(0).caption = LoadXLSString(1402)
    'LblPID(1).caption = LoadXLSString(1403)
    '

    'pulisco le immagini all'avvio
'    GraficoTemp.Cls    'grafico dell'andamento dell'apertura del modulatore
'    GraficoMod.Cls    'grafico dell'andamento della temperatura del bruciatore
    
    imgPulsanteForm(1).ToolTipText = LoadXLSString(110)
    imgPulsanteForm(2).ToolTipText = LoadXLSString(94)

    '20170324
    imgPulsanteForm(3).ToolTipText = LoadXLSString(936)
    
    lblCorrManSetPosMod.caption = LoadXLSString(1548)
    txtCorrManSetPosMod.text = ListaTamburi(TamburoAssociatoAlPID).BAP_CorrManSetPosMod
    txtCorrManSetPosMod.locked = (ActiveUser = UsersEnum.NONE)
    frameParametri.caption = LoadXLSString(691)
    '

    LblModulatore.caption = ListaTamburi(TamburoAssociatoAlPID).posizioneModulatoreBruciatore
    LblTempBruc.caption = ListaTamburi(TamburoAssociatoAlPID).temperaturaScivolo
    TextTempBrucSet.text = ListaTamburi(TamburoAssociatoAlPID).setTemperaturaScivolo

    '20161230
    'SetPointPID = TextTempBrucSet.text
    'TextParPID(0).text = FattoreDiCorrezioneKp
    'TextParPID(1).text = FattoreDiCorrezioneKi
    'TextParPID(2).text = FattoreDiCorrezioneKd
    'TextParPID(3).text = TInterventoCampionamento / 1000
    'KpPrec = FattoreDiCorrezioneKp
    'KiPrec = FattoreDiCorrezioneKi
    'KdPrec = FattoreDiCorrezioneKd
    'TcPrec = TInterventoCampionamento
    imgPulsanteForm(TopBarButtonEnum.Salva).Visible = False
    '

'    GraficoTemp.ScaleMode = 3
'    GraficoTemp.ScaleHeight = 300   'mi permette di graficare andamenti fino a 300 gradi
'    GraficoTemp.ScaleWidth = 100
'    GraficoTemp.AutoRedraw = True
'    GraficoTemp.ForeColor = vbCyan
'    GraficoTemp.DrawStyle = 0
'    GraficoTemp.DrawWidth = 2
'
'    GraficoMod.ScaleMode = 3
'    GraficoMod.ScaleHeight = 100    'mi permette di graficare valori fino a 100
'    GraficoMod.ScaleWidth = 100
'    GraficoMod.AutoRedraw = True
'    GraficoMod.ForeColor = vbRed
'    GraficoMod.DrawStyle = 0
'    GraficoMod.DrawWidth = 2
'
'    Call TimerGraficoBruciatore_Timer
'
'    TimerGraficoBruciatore.enabled = True
    primaVolta = False
    
    If TamburoAssociatoAlPID = 0 Then
        SetStartUpPosition Me, 0
    ElseIf TamburoAssociatoAlPID = 1 Then
        SetStartUpPosition Me, 1
    End If

    Call UpdatePulsantiForm

    '20161230
    Call PasswordLevel
    '

    '20170324
    FormHeightMin = Me.Height
    Call InitParamGraf
    Call InitTrend
    CP240.CmdPID(TamburoAssociatoAlPID).enabled = False
    Call RefreshGraphParam
    '
    Exit Sub

Errore:
    LogInserisci True, "FPB-001", CStr(Err.Number) + " [" + Err.description + "]"
    
End Sub


Private Sub TextTempBrucSet_Dblclick()

    Dim result As Boolean
    
    On Error GoTo Errore
    
    If (Not primaVolta) Then
        With ListaTamburi(TamburoAssociatoAlPID)
    
            CP240.TxtTemperaturaBruciatoreAutomatico(TamburoAssociatoAlPID).text = CStr(FrmNewValue.InputLongValue(Me, .setTemperaturaScivolo, 50, 250))
            TextTempBrucSet.text = CP240.TxtTemperaturaBruciatoreAutomatico(TamburoAssociatoAlPID).text

            '20161230
            'SetPointPID = TextTempBrucSet.text
            '
            If (.setTemperaturaScivolo <> CInt(CP240.TxtTemperaturaBruciatoreAutomatico(TamburoAssociatoAlPID).text)) Then
                .setTemperaturaScivolo = CInt(CP240.TxtTemperaturaBruciatoreAutomatico(TamburoAssociatoAlPID).text)

                '20161230
                ''Nessun salvataggio di questi dati
                ''result = ParameterPlus.SetParameterValue("Bruciatore", "", "", "ValoreSetTempScivolo", CStr(.setTemperaturaScivolo))
                'ResetPID = True
                '
            End If

        End With
    End If

    Exit Sub
Errore:
    LogInserisci True, "FPB-002", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

Private Sub TimerGraficoBruciatore_Timer()

On Error GoTo Errore
'
''Grafico l'andamento della temperatura
'
'    GraficoTemp.Cls
'    PixTemp = ListaTamburi(TamburoAssociatoAlPID).temperaturaScivolo
'    GraphTemp(100) = PixTemp
'    For x = 0 To 99
'        GraphTemp(x) = GraphTemp(x + 1)
'        GraficoTemp.PSet (x, 300 - GraphTemp(x))
'    Next x
'
''Grafico l'andamento dell'apertura del modulatore
'
'    GraficoMod.Cls
'    PixMod = ListaTamburi(TamburoAssociatoAlPID).posizioneModulatoreBruciatore
'    GraphMod(100) = PixMod
'    For x = 0 To 99
'        GraphMod(x) = GraphMod(x + 1)
'        GraficoMod.PSet (x, 100 - GraphMod(x))
'    Next x
'
'    '20161230
'    ''Grafico la linea gialla
'    '
'    'GraficoTemp.Line (0, 300 - SetPointPID)-(100, 300 - SetPointPID), vbYellow
'    '
'
    '20170324
    If xychartCalibraz.trend.enable Then
        Call RefreshGraph
    End If
    '
    AggiornaGraficaBruciatore

    Exit Sub
Errore:
    LogInserisci True, "FPB-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub AggiornaGraficaBruciatore()
    
    Dim risorsa As String
    Dim motore As String

    On Error GoTo Errore

    If TamburoAssociatoAlPID = 0 Then
        motore = MotoreRotazioneEssiccatore
    ElseIf TamburoAssociatoAlPID = 1 Then
        motore = MotoreRotazioneEssiccatore2
    End If

    With ListaMotori(motore)
        If (.AllarmeTermica Or .AllarmeSicurezza) Then
            risorsa = "IDB_TAMBUROERRORE"
        ElseIf (.ritorno) Then
            If (ListaTamburi(TamburoAssociatoAlPID).BloccoFiammaBruciatore) Then
                risorsa = "IDB_TAMBUROONFIAMMACHIARO"
            ElseIf (ListaTamburi(TamburoAssociatoAlPID).FiammaBruciatorePresente) Then
                risorsa = "IDB_TAMBUROONCHIARO"   'uso solo l'immagine del tamburo on...la fiamma la faccio a parte
                ImgFiammaBrucPID.Visible = True
                '20170328
                'ImgFiammaBrucPID.width = (1500 * (PixMod / 100)) + 1000
                ImgFiammaBrucPID.width = (1500 * (ListaTamburi(TamburoAssociatoAlPID).posizioneModulatoreBruciatore / 100)) + 1000
                '
                ImgFiammaBrucPID.left = 8800 - ImgFiammaBrucPID.width
            ElseIf (ListaTamburi(TamburoAssociatoAlPID).BruciatoreInAccensione And Not ListaTamburi(TamburoAssociatoAlPID).FiammaBruciatorePresente) Then
                risorsa = "IDB_TAMBUROONPREVENTILAZIONECHIARO"
            Else
                risorsa = "IDB_TAMBUROONCHIARO"     'OK
                ImgFiammaBrucPID.Visible = False
            End If
        Else
            If (ListaTamburi(TamburoAssociatoAlPID).BloccoFiammaBruciatore) Then
                risorsa = "IDB_TAMBUROFIAMMACHIARO"   'ok
            ElseIf (ListaTamburi(TamburoAssociatoAlPID).FiammaBruciatorePresente) Then
                risorsa = "IDB_TAMBUROERRORE"
            ElseIf (ListaTamburi(TamburoAssociatoAlPID).BruciatoreInAccensione And Not ListaTamburi(TamburoAssociatoAlPID).FiammaBruciatorePresente) Then
                risorsa = "IDB_TAMBUROPREVENTILAZIONE"
            Else
                risorsa = "IDB_TAMBUROCHIARO"
            End If
        End If
    End With

    ImgBrucPID = LoadResPicture(risorsa, vbResBitmap)

    txtCorrManSetPosMod.text = FormatNumber(ListaTamburi(TamburoAssociatoAlPID).BAP_CorrManSetPosMod, 0) '20170324
    
    Exit Sub
    
Errore:
    LogInserisci True, "FPB-004", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20161230
'Private Function FormPIDBruc_IsModified()
'
'    FormPIDBruc_IsModified = True
'    imgPulsanteForm(TopBarButtonEnum.Salva).enabled = False
'
'    If ( _
'        KpPrec <> FattoreDiCorrezioneKp Or _
'        KiPrec <> FattoreDiCorrezioneKi Or _
'        KdPrec <> FattoreDiCorrezioneKd Or _
'        TcPrec <> TInterventoCampionamento _
'    ) Then
'        imgPulsanteForm(TopBarButtonEnum.Salva).enabled = True
'        Call UpdatePulsantiForm
'        Exit Function
'    End If
'
'    Call UpdatePulsantiForm
'
'
'    FormPIDBruc_IsModified = False
'
'End Function
'

'20161230
'Private Sub VarizioneParametriMomentanea()
''salvo i parametri momentaneamente per vedere le differenze di comportamento del PID. Per salvarlidefinitivamente devo spingere
''il pulsante salva
'
'    FattoreDiCorrezioneKp = String2Long(TextParPID(0).text)
'    FattoreDiCorrezioneKi = String2Double(TextParPID(1).text)
'    FattoreDiCorrezioneKd = String2Double(TextParPID(2).text)
'    TInterventoCampionamento = String2Long(TextParPID(3).text) * 1000
'
'    TextParPID(0).text = FattoreDiCorrezioneKp
'    TextParPID(1).text = FattoreDiCorrezioneKi
'    TextParPID(2).text = FattoreDiCorrezioneKd
'    TextParPID(3).text = CStr(TInterventoCampionamento / 1000)
'
'    Call FormPIDBruc_IsModified
'
'End Sub
'
'Private Sub RipristinaParIniz()
'
'    FattoreDiCorrezioneKp = KpPrec
'    FattoreDiCorrezioneKi = KiPrec
'    FattoreDiCorrezioneKd = KdPrec
'    TInterventoCampionamento = TcPrec
'
'End Sub
'

Private Sub imgPulsanteForm_Click(Index As Integer)

    On Error GoTo Errore

    Select Case Index
        Case TopBarButtonEnum.uscita
            '20161230
            FormPIDBruc_Visible = False
            '
            TimerGraficoBruciatore.enabled = False
            '20170324
            CP240.CmdPID(TamburoAssociatoAlPID).enabled = True
            xychartCalibraz.trend.enable = False
            '
            Me.Hide
            Unload Me
            Call VisualizzaBarraPulsantiCP240(True)
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_ESSICCATORE_AUTOMATICO
        Case TopBarButtonEnum.Salva
            '20161230 ScriviParametriPID
            imgPulsanteForm(Index).enabled = False
        Case TopBarButtonEnum.TBB_Grafico
            If Me.Height = FormHeightMin Then
                Me.Height = 13140
            Else
                Me.Height = FormHeightMin
            End If
    End Select

    Exit Sub

Errore:
    LogInserisci True, "FPB-005", CStr(Err.Number) + " [" + Err.description + "]"

End Sub


Private Sub imgPulsanteForm_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
        
    If selectedButtonIndex <> Index Then
        Call Form_MouseMove(Button, Shift, x, Y)
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
        Case TopBarButtonEnum.uscita
            prefisso = "PLUS_IMG_EXIT"
        Case TopBarButtonEnum.Help
            prefisso = "PLUS_IMG_HELP"
        Case TopBarButtonEnum.Salva
            prefisso = "PLUS_IMG_SAVE"
        Case TopBarButtonEnum.TBB_Grafico
            prefisso = "PLUS_IMG_GRAPH"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(Stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FPB-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub UpdatePulsantiForm()
        
Dim indice As Integer
        
    For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
        If imgPulsanteForm(indice).enabled Then
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
        Else
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.disabled)
        End If
    Next indice

End Sub

'20161230
'Private Sub ScriviParametriPID()
'
'    Call ScriviParametriBruciatorePID
'
'    KpPrec = FattoreDiCorrezioneKp
'    KiPrec = FattoreDiCorrezioneKi
'    KdPrec = FattoreDiCorrezioneKd
'    TcPrec = TInterventoCampionamento
'
'End Sub
'

'20161230
Private Sub PasswordLevel()

    Select Case ActiveUser
        Case UsersEnum.ADMINISTRATOR To UsersEnum.SUPERUSER
            FrameDebug.Visible = True
        Case Else
            FrameDebug.Visible = False
    End Select

End Sub

Public Sub SetLblDebug(Index As Integer, str As String)

    On Error GoTo Errore
    
    If (LblDebug(Index).caption <> str) Then
        TmrLblDebug(Index) = ConvertiTimer()
        LblDebug(Index).BackColor = vbYellow
    ElseIf (TmrLblDebug(Index) > 0 And (ConvertiTimer() - TmrLblDebug(Index) >= 3)) Then
        TmrLblDebug(Index) = 0
        LblDebug(Index).BackColor = FormPIDBruc.BackColor
    End If

    FormPIDBruc.LblDebug(Index).caption = str
    
    Exit Sub

Errore:
    LogInserisci True, "FPB-007", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20170324
Private Sub txtCorrManSetPosMod_DblClick()
    txtCorrManSetPosMod.text = CStr(FrmNewValue.InputLongValue(Me, CLng(ListaTamburi(TamburoAssociatoAlPID).BAP_CorrManSetPosMod), 0, 100))
    ListaTamburi(TamburoAssociatoAlPID).BAP_CorrManSetPosMod = CInt(txtCorrManSetPosMod.text)
End Sub
'

Private Sub InitTrend()

    On Error GoTo Errore

     ' Configure XYChart control
     With xychartCalibraz
        .NumProfiles = 3

        .trend.enable = True
        .trend.DisplayLength = 60

        .NumYScales = 3

        .Legend.Visible = True
        .Legend.BorderVisible = False
        .Legend.YScaleVisible = False

        .Toolbar.Visible = False

        'Temperatura
        .YGrid(1).LineOption = loCustom
        .YGrid(1).LineStyle = soSolid
        .YGrid(1).LineColor = RGB(0, 40, 80)
        .XGrid(1).LineOption = loCustom
        .XGrid(1).LineStyle = soSolid
        .XGrid(1).LineColor = .YGrid(1).LineColor

        '%
        .YGrid(2).LineOption = loCustom
        .YGrid(2).LineStyle = soSolid
        .YGrid(2).LineColor = RGB(0, 40, 80)
        .XGrid(2).LineOption = loCustom
        .XGrid(2).LineStyle = soSolid
        .XGrid(2).LineColor = .YGrid(2).LineColor

        'Portata
        .YGrid(3).LineOption = loCustom
        .YGrid(3).LineStyle = soSolid
        .YGrid(3).LineColor = RGB(0, 40, 80)
        .XGrid(3).LineOption = loCustom
        .XGrid(3).LineStyle = soSolid
        .XGrid(3).LineColor = .YGrid(3).LineColor


        ' Y Scale temperature
        .YScale(1).Visible = True
        .YScale(1).ScaleMode = smManual
        .YScale(1).max = 300
        .YScale(1).min = 0
        .YScale(1).label = "*C"
        .YScale(1).LabelFont.Color = RGB(255, 0, 0)
        .YScale(1).TicksFont.Color = RGB(255, 0, 0)

        ' Y Scale %
        .YScale(2).Visible = True
        .YScale(2).ScaleMode = smManual
        .YScale(2).max = 100
        .YScale(2).min = 0
        .YScale(2).label = "%"
        .YScale(2).LabelFont.Color = RGB(0, 255, 255)
        .YScale(2).TicksFont.Color = RGB(0, 255, 255)

        ' Y Scale portata
        .YScale(3).Visible = True
        .YScale(3).ScaleMode = smManual
        .YScale(3).max = 300 'Round(TonOrarieImpianto, 0)
        .YScale(3).min = 0
        .YScale(3).label = "T/h"
        .YScale(3).LabelFont.Color = RGB(255, 255, 0) 'giallo
        .YScale(3).TicksFont.Color = RGB(255, 255, 0)

        ' X Scale
        .XScale(1).FormatStyle = fsNumeric
        .XScale(1).ScaleMode = smAuto
        .XScale(1).label = ""
        .XScale(1).TicksFont.Color = vbWhite

        .BackColor = RGB(0, 40, 80)
        '.BackColor = RGB(255, 255, 255)
        '.BackColor = vbGreen

        .Plot.BackColor = RGB(203, 203, 228)
        .Plot.Border.LineOption = loNone
        .Plot.Border.LineWidth = woOnePoint
        .Plot.Border.LineColor = RGB(0, 128, 0)

        ' Temperatura
        .Profile(1).YScale = 1
        .Profile(1).label = "Temperatura"
        .Profile(1).LineOption = loCustom
        .Profile(1).LineWidth = woOnePoint
        .Profile(1).LineStyle = soSolid
        .Profile(1).MarkerOption = loNone
        .Profile(1).LineColor = RGB(255, 0, 0)
        .Profile(1).NumSamples = 3600

        '%
        .Profile(2).YScale = 2
        .Profile(2).label = "Pos. Modulatore"
        .Profile(2).LineOption = loCustom
        .Profile(2).LineWidth = woOnePoint
        .Profile(2).LineStyle = soSolid
        .Profile(2).MarkerOption = loNone
        .Profile(2).LineColor = RGB(0, 255, 255)
        .Profile(2).NumSamples = 3600

        'Portata
        .Profile(3).YScale = 3
        .Profile(3).label = "Portata"
        .Profile(3).LineOption = loCustom
        .Profile(3).LineWidth = woOnePoint
        .Profile(3).LineStyle = soSolid
        .Profile(3).MarkerOption = loNone
        .Profile(3).LineColor = RGB(255, 255, 0)
        .Profile(3).NumSamples = 3600

        .ClearChartData

        ' Format Crosshairs
        .CrossHairs.Color = RGB(0, 128, 0)
        .CrossHairs.width = woThreePoint
        .CrossHairs.HorizontalVisible = False
        .CrossHairs.YCoordInLegend = True
        .CrossHairs.CoordsBackcolor = RGB(0, 128, 0)

        .Refresh
          
         TrendSample = 0
    
     End With

    Exit Sub
Errore:
    LogInserisci True, "FPB-008", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

Private Sub RefreshGraph()

    Dim NewData(1 To 1, 1 To 6) As Variant
    
    On Error GoTo Errore
    
    NewData(1, 1) = TrendSample
    NewData(1, 2) = ListaTamburi(TamburoAssociatoAlPID).temperaturaScivolo
    NewData(1, 3) = TrendSample
    NewData(1, 4) = ListaTamburi(TamburoAssociatoAlPID).posizioneModulatoreBruciatore
    NewData(1, 5) = TrendSample
    NewData(1, 6) = PesoBilanciaInertiSecco

    ' Add new trend data to chart array
    With xychartCalibraz
         .trend.AddData 1, NewData, aoAppendToEnd
         .Refresh
    End With
    
    'xychartParam.Refresh
            
    If TrendSample > 60000 Then TrendSample = 0
         
    TrendSample = TrendSample + TimerGraficoBruciatore.Interval / 1000
    
    Exit Sub
Errore:
    LogInserisci True, "FPB-009", CStr(Err.Number) + " [" + Err.description + "]"
     
End Sub

Private Sub InitParamGraf()

    On Error GoTo Errore

    ' Configure XYChart control
    With xychartParam
        .NumProfiles = 1

        .trend.enable = True
        .trend.DisplayLength = 60

        .NumYScales = 1

        .Legend.Visible = True
        .Legend.BorderVisible = False
        .Legend.YScaleVisible = False

        .Toolbar.Visible = False

        '
        .YGrid(1).LineOption = loCustom
        .YGrid(1).LineStyle = soSolid
        .YGrid(1).LineColor = RGB(0, 40, 80)
        .XGrid(1).LineOption = loCustom
        .XGrid(1).LineStyle = soSolid
        .XGrid(1).LineColor = .YGrid(1).LineColor

        '
        .YScale(1).Visible = True
        .YScale(1).ScaleMode = smManual
        .YScale(1).max = ListaTamburi(TamburoAssociatoAlPID).BAP_RapportoPortataModulatore(ListaTamburi(TamburoAssociatoAlPID).SelezioneCombustibile, 10)
        .YScale(1).min = 0
        .YScale(1).label = "T/h"
        .YScale(1).LabelFont.Color = RGB(255, 106, 0)
        .YScale(1).TicksFont.Color = RGB(255, 106, 0)


        '% Modulatore X Scale
        .XScale(1).FormatStyle = fsNumeric
        .XScale(1).ScaleMode = smAuto
        .XScale(1).label = "Modulatore(%)"
        .XScale(1).LabelFont.Color = vbWhite
        .XScale(1).TicksFont.Color = vbWhite

        .BackColor = RGB(0, 40, 80)
        '.BackColor = RGB(255, 255, 255)
        '.BackColor = vbGreen

        .Plot.BackColor = RGB(203, 203, 228)
        .Plot.Border.LineOption = loNone
        .Plot.Border.LineWidth = woOnePoint
        .Plot.Border.LineColor = RGB(0, 128, 0)

        'Portata
        .Profile(1).YScale = 1
        .Profile(1).label = ListaTamburi(0).SelezioneCombustibileName
        .Profile(1).LineOption = loCustom
        .Profile(1).LineWidth = woOnePoint
        .Profile(1).LineStyle = soSolid
        .Profile(1).MarkerOption = loCustom
        .Profile(1).MarkerStyle = msCircle
        .Profile(1).MarkerSize = 4
        .Profile(1).MarkerFillcolor = .Profile(1).LineColor
        .Profile(1).MarkerBordercolor = .Profile(1).LineColor
                   
        .Profile(1).LineColor = RGB(255, 106, 0)
        .Profile(1).NumSamples = 11

        .ClearChartData

        ' Format Crosshairs
        .CrossHairs.Color = RGB(0, 128, 0)
        .CrossHairs.width = woThreePoint
        .CrossHairs.HorizontalVisible = False
        .CrossHairs.YCoordInLegend = True
        .CrossHairs.CoordsBackcolor = RGB(0, 128, 0)

        .Refresh

    End With

    Exit Sub
Errore:
    LogInserisci True, "FPB-010", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

Private Sub RefreshGraphParam()

    On Error GoTo Errore

    With xychartParam

        Dim DataArray() As Variant
        ReDim DataArray(1 To .Profile(1).NumSamples, 1 To 2 * .NumProfiles) As Variant
        Dim row As Integer
        
        'ReDim DataArray(1 To .Profile(1).NumSamples, 1 To 2 * .NumProfiles)
        For row = 1 To .Profile(1).NumSamples

            DataArray(row, 1) = (row - 1) * 10 'asse x
            DataArray(row, 2) = ListaTamburi(TamburoAssociatoAlPID).BAP_RapportoPortataModulatore(ListaTamburi(TamburoAssociatoAlPID).SelezioneCombustibile, row - 1) 'asse y
            
        Next row
    
        .ChartData = DataArray
        .Refresh
                
        '.Redraw
    End With

    Exit Sub
Errore:
    LogInserisci True, "FPB-011", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

