VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmCalibBilCamion 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "MARINI"
   ClientHeight    =   5550
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6720
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   FillStyle       =   0  'Solid
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmCalibBilCamion.frx":0000
   ScaleHeight     =   5550
   ScaleWidth      =   6720
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.OptionButton optEnable 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Normalization"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   3720
      TabIndex        =   29
      Top             =   1920
      Width           =   2295
   End
   Begin VB.OptionButton optEnable 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Linearization"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   0
      Left            =   3720
      TabIndex        =   28
      Top             =   1560
      Width           =   2295
   End
   Begin VB.Frame frmLinearizza 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Linearization"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3135
      Left            =   0
      TabIndex        =   7
      Top             =   2400
      Width           =   3375
      Begin VB.CommandButton cmdCalibrazione 
         Caption         =   "5"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   120
         TabIndex        =   26
         Top             =   2640
         Width           =   375
      End
      Begin VB.CommandButton cmdCalibrazione 
         Caption         =   "4"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   120
         TabIndex        =   25
         Top             =   2160
         Width           =   375
      End
      Begin VB.CommandButton cmdCalibrazione 
         Caption         =   "3"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   120
         TabIndex        =   24
         Top             =   1680
         Width           =   375
      End
      Begin VB.CommandButton cmdCalibrazione 
         Caption         =   "2"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   120
         TabIndex        =   23
         Top             =   1200
         Width           =   375
      End
      Begin VB.CommandButton cmdCalibrazione 
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   120
         TabIndex        =   22
         Top             =   720
         Width           =   375
      End
      Begin VB.TextBox txtValueX 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   600
         TabIndex        =   17
         Text            =   "0"
         Top             =   2640
         Width           =   1215
      End
      Begin VB.TextBox txtValueY 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   2040
         TabIndex        =   16
         Text            =   "0"
         Top             =   2640
         Width           =   1215
      End
      Begin VB.TextBox txtValueX 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   600
         TabIndex        =   15
         Text            =   "0"
         Top             =   2160
         Width           =   1215
      End
      Begin VB.TextBox txtValueX 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   600
         TabIndex        =   14
         Text            =   "0"
         Top             =   1680
         Width           =   1215
      End
      Begin VB.TextBox txtValueX 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   600
         TabIndex        =   13
         Text            =   "0"
         Top             =   1200
         Width           =   1215
      End
      Begin VB.TextBox txtValueX 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   600
         TabIndex        =   12
         Text            =   "0"
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox txtValueY 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   2040
         TabIndex        =   11
         Text            =   "0"
         Top             =   2160
         Width           =   1215
      End
      Begin VB.TextBox txtValueY 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   2040
         TabIndex        =   10
         Text            =   "0"
         Top             =   1680
         Width           =   1215
      End
      Begin VB.TextBox txtValueY 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   2040
         TabIndex        =   9
         Text            =   "0"
         Top             =   1200
         Width           =   1215
      End
      Begin VB.TextBox txtValueY 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   2040
         TabIndex        =   8
         Text            =   "0"
         Top             =   720
         Width           =   1215
      End
      Begin VB.Label lbColonnaY 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "Kg OUT"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2040
         TabIndex        =   19
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label lbColonnaX 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "Unit IN"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   600
         TabIndex        =   18
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.Frame frmNormalizzazione 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Scaling parameters"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3135
      Left            =   3480
      TabIndex        =   0
      Top             =   2400
      Width           =   3135
      Begin VB.CheckBox chk420ma 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Caption         =   "4-20 mA"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   120
         TabIndex        =   20
         Top             =   2520
         Width           =   2900
      End
      Begin VB.TextBox txtKgMin 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2160
         TabIndex        =   5
         Text            =   "0"
         Top             =   1560
         Width           =   855
      End
      Begin VB.TextBox txtAnalogMin 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2160
         TabIndex        =   2
         Text            =   "0"
         Top             =   600
         Width           =   855
      End
      Begin VB.TextBox txtAnalogMax 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2160
         TabIndex        =   1
         Text            =   "27648"
         Top             =   1080
         Width           =   855
      End
      Begin VB.Label txtKgMax 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   2160
         TabIndex        =   32
         Top             =   2040
         Width           =   855
      End
      Begin VB.Label lblKgMax 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Kg max"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   31
         Top             =   2040
         Width           =   1815
      End
      Begin VB.Label lblKgMin 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Kg min"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   1560
         Width           =   1815
      End
      Begin VB.Label lblAnalogMin 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Analog min"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   600
         Width           =   1815
      End
      Begin VB.Label lblAnalogMax 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Analog max"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1080
         Width           =   1815
      End
   End
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   2760
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   12
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":362F2
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":368BA
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":36E6F
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":3742F
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":379EF
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":3804D
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":38694
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":38CEA
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":39340
            Key             =   "PLUS_IMG_SAVE"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":3996A
            Key             =   "PLUS_IMG_SAVE_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":39FAF
            Key             =   "PLUS_IMG_SAVE_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalibBilCamion.frx":3A60E
            Key             =   "PLUS_IMG_SAVE_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Shape Shape1 
      Height          =   375
      Left            =   3360
      Top             =   1680
      Width           =   975
   End
   Begin VB.Line Line2 
      X1              =   3360
      X2              =   2520
      Y1              =   1850
      Y2              =   1850
   End
   Begin VB.Label lblScalingSelect 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Scaling method"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   30
      Top             =   1660
      Width           =   2295
   End
   Begin VB.Label lblUnitValue 
      Caption         =   "Unit current value:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   0
      TabIndex        =   27
      Top             =   840
      Width           =   4095
   End
   Begin VB.Label lblUnitaAnalogiche 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "00000"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   4560
      TabIndex        =   21
      Top             =   840
      Width           =   1455
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   5520
      Picture         =   "FrmCalibBilCamion.frx":3AC6B
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   0
      Picture         =   "FrmCalibBilCamion.frx":3B223
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "FrmCalibBilCamion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'20151110
Option Explicit

Private Enum TopBarButtonEnum
    uscita
    Help
    Salva
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'

Private Sub chk420ma_Click()

    If chk420ma.Value = 0 Then
        txtAnalogMin.text = 0
    Else
        txtAnalogMin.text = 5530
    End If
    
End Sub

Private Sub cmdCalibrazione_Click(Index As Integer)

    BilanciaPesaCamion.PesaCamionLinX(Index) = BilanciaPesaCamion.ValoreAnalogico
    txtValueX(Index).text = BilanciaPesaCamion.ValoreAnalogico
    
End Sub

Private Sub Form_Load()
    
    Call AggiornaDatiForm
    
End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            Me.Hide
            Unload Me
            Call VisualizzaBarraPulsantiCP240(True)
        Case TopBarButtonEnum.Salva
            Call SalvaParametri
            'imgPulsanteForm(Index).enabled = False
    End Select

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
    
    On Error GoTo Errore
                                                                   
'selezione prefisso nome immagine
                                                                                                                                                                                                     
    Select Case Index
        Case TopBarButtonEnum.uscita
            prefisso = "PLUS_IMG_EXIT"
        Case TopBarButtonEnum.Salva
            prefisso = "PLUS_IMG_SAVE"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FPB-002", CStr(Err.Number) + " [" + Err.description + "]"
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

Private Sub SalvaParametri()

    Dim indice As Integer
    
    BilanciaPesaCamion.PesaCamionEnLin = optEnable(0).Value
    
    For indice = 0 To 4
        BilanciaPesaCamion.PesaCamionLinX(indice) = DatoCorretto(txtValueX(indice).text, 0, 0, 100000, 0)
        BilanciaPesaCamion.PesaCamionLinY(indice) = DatoCorretto(txtValueY(indice).text, 0, 0, 100000, 0)
        If (BilanciaPesaCamion.PesaCamionLinX(indice) > 0) And (BilanciaPesaCamion.PesaCamionLinX(indice) > 0) Then
            BilanciaPesaCamion.PesaCamionNumLin = indice + 1
        End If
    Next indice
    
    'BilanciaPesaCamion.PesaCamionEnFiltro = chkFiltro.Value
    'BilanciaPesaCamion.PesaCamionSampleNr = DatoCorretto(txtSampleNr.text, 0, 1, 10, 5)
    'BilanciaPesaCamion.PesaCamionSampleTime = DatoCorretto(txtSampleTime.text, 0, 100, 500, 500)
    BilanciaPesaCamion.PesaCamionEnScaling = optEnable(1).Value
    BilanciaPesaCamion.PesaCamionScalingAnalogMin = DatoCorretto(txtAnalogMin.text, 0, 0, 15000, 0)
    BilanciaPesaCamion.PesaCamionScalingAnalogMax = DatoCorretto(txtAnalogMax.text, 0, 15000, 27648, 27648)
    BilanciaPesaCamion.PesaCamionScalingKgMin = DatoCorretto(txtKgMin.text, 0, 0, 0, 0)
    BilanciaPesaCamion.PesaCamionScalingKgMax = DatoCorretto(txtKgMax.caption, 0, 0, 100000, 50000)
    
    Call AggiornaDatiForm
    Call ScriveFileParBilCamion

End Sub


Private Sub AggiornaDatiForm()

    Dim indice As Integer
    
    optEnable(0).Value = BilanciaPesaCamion.PesaCamionEnLin
    
    For indice = 0 To 4
        txtValueX(indice).text = CStr(BilanciaPesaCamion.PesaCamionLinX(indice))
        txtValueY(indice).text = CStr(BilanciaPesaCamion.PesaCamionLinY(indice))
    Next indice
    
    'chkFiltro.Value = BoolToCheck(BilanciaPesaCamion.PesaCamionEnFiltro)
    'txtSampleNr.text = CStr(BilanciaPesaCamion.PesaCamionSampleNr)
    'txtSampleTime.text = CStr(BilanciaPesaCamion.PesaCamionSampleTime)
    optEnable(1).Value = BilanciaPesaCamion.PesaCamionEnScaling
    txtAnalogMin.text = CStr(BilanciaPesaCamion.PesaCamionScalingAnalogMin)
    txtAnalogMax.text = CStr(BilanciaPesaCamion.PesaCamionScalingAnalogMax)
    txtKgMin.text = CStr(BilanciaPesaCamion.PesaCamionScalingKgMin)
    txtKgMax.caption = CStr(BilanciaPesaCamion.PesaCamionScalingKgMax)

End Sub

'20160512
Private Sub txtAnalogMax_Change()
    txtAnalogMax.text = DatoCorretto(txtAnalogMax.text, 0, 15000, 27648, 27648)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtAnalogMax_LostFocus()
    txtAnalogMax.text = DatoCorretto(txtAnalogMax.text, 0, 15000, 27648, 27648, 1)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtAnalogMin_Change()
    txtAnalogMin.text = DatoCorretto(txtAnalogMin.text, 0, 0, 15000, 0)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtAnalogMin_LostFocus()
    txtAnalogMin.text = DatoCorretto(txtAnalogMin.text, 0, 0, 15000, 0, 1)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtKgMin_Change()
    txtKgMin.text = DatoCorretto(txtKgMin.text, 0, 0, 0, 0)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtKgMin_LostFocus()
    txtKgMin.text = DatoCorretto(txtKgMin.text, 0, 0, 0, 0, 1)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtValueX_Change(Index As Integer)
    txtValueX(Index).text = DatoCorretto(txtValueX(Index).text, 0, 0, 100000, 0)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtValueX_LostFocus(Index As Integer)
    txtValueX(Index).text = DatoCorretto(txtValueX(Index).text, 0, 0, 100000, 0, 1)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtValueY_Change(Index As Integer)
    txtValueY(Index).text = DatoCorretto(txtValueY(Index).text, 0, 0, 100000, 0)
    ErroreDatoParametri = False
End Sub

'20160512
Private Sub txtValueY_LostFocus(Index As Integer)
    txtValueY(Index).text = DatoCorretto(txtValueY(Index).text, 0, 0, 100000, 0, 1)
    ErroreDatoParametri = False
End Sub
