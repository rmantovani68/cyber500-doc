VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmTaraBilancePN 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Taratura bilance PN"
   ClientHeight    =   5040
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6465
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmTaraBilancePN.frx":0000
   ScaleHeight     =   5040
   ScaleWidth      =   6465
   Begin VB.ComboBox cmbListaBilance 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      ItemData        =   "FrmTaraBilancePN.frx":191C2
      Left            =   2400
      List            =   "FrmTaraBilancePN.frx":191CF
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   960
      Width           =   3855
   End
   Begin VB.CommandButton BtnReset 
      Caption         =   "Reset"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   12
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   120
      Visible         =   0   'False
      Width           =   795
   End
   Begin VB.Timer TmrCmdRunning 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   3600
      Top             =   120
   End
   Begin VB.CommandButton CmdTare 
      Caption         =   ">0<"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   5520
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1800
      Width           =   735
   End
   Begin VB.CommandButton CmdCalibrate 
      Caption         =   ">Kg<"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   5520
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   2640
      Width           =   735
   End
   Begin VB.TextBox TxtSampleWeight 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   18
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2760
      TabIndex        =   2
      Text            =   "1999.9"
      Top             =   2700
      Width           =   1575
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
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":191EE
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":197B6
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":19D6B
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":1A32B
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":1A8EB
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":1AF49
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":1B590
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmTaraBilancePN.frx":1BBE6
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblKg 
      Alignment       =   2  'Center
      BackColor       =   &H00000080&
      Caption         =   "Kg"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   18
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0FF&
      Height          =   495
      Index           =   0
      Left            =   3000
      TabIndex        =   10
      Top             =   3780
      Width           =   735
   End
   Begin VB.Label lblValore 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000080&
      Caption         =   "----.-"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   27.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0FF&
      Height          =   615
      Left            =   840
      TabIndex        =   9
      Top             =   3585
      Width           =   2295
   End
   Begin VB.Label lblKg 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "Kg"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   18
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Index           =   1
      Left            =   4320
      TabIndex        =   11
      Top             =   2685
      Width           =   735
   End
   Begin VB.Label lblSelBilancia 
      BackColor       =   &H00FFFFFF&
      Caption         =   "BILANCIA"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   8
      Top             =   960
      Width           =   2055
   End
   Begin VB.Label LblWorking 
      Alignment       =   2  'Center
      BackColor       =   &H0000FF00&
      Caption         =   "CALIBRAZIONE IN CORSO"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   9
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   4680
      Visible         =   0   'False
      Width           =   6015
   End
   Begin VB.Label LblCalibration 
      BackColor       =   &H00FFFFFF&
      Caption         =   "CALIBRAZIONE"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   2760
      Width           =   2295
   End
   Begin VB.Label LblTare 
      BackColor       =   &H00FFFFFF&
      Caption         =   "TARA"
      BeginProperty Font 
         Name            =   "Segoe UI Semibold"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   1920
      Width           =   2415
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   5280
      Picture         =   "FrmTaraBilancePN.frx":1C23C
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image Image1 
      Height          =   1080
      Left            =   240
      Picture         =   "FrmTaraBilancePN.frx":1C7F4
      Top             =   3480
      Width           =   6000
   End
End
Attribute VB_Name = "FrmTaraBilancePN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


Private Enum TopBarButtonEnum
    uscita
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


' Public FrmTaraBilancePmVisibile As Boolean 'Ha senso in un modulo (non questo!) nel caso diventi Modeless


Public Sub PasswordLevel()

    CmdTare.enabled = (ActiveUser <> UsersEnum.NONE)
    CmdCalibrate.enabled = (ActiveUser <> UsersEnum.NONE)

End Sub

Private Sub Command1_Click()
    BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET
End Sub

Private Sub BtnReset_Click()
    BtnReset.enabled = False
    LblWorking.Visible = True
    TmrCmdRunning.enabled = True
    BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_RESET
End Sub

Private Sub cmbListaBilance_Click()

'    BilanciaPnAttiva = cmbListaBilance.ListIndex
    
    Select Case cmbListaBilance.ListIndex
        Case BilanciaPnCombo.BILANCIA_PN_AGGREGATI
            BilanciaPnAttiva = BILANCIA_PN_AGGREGATI
            Call BilAgg_change
        Case BilanciaPnCombo.BILANCIA_PN_FILLER
            BilanciaPnAttiva = BILANCIA_PN_FILLER
            Call BilFiller_change
        Case BilanciaPnCombo.BILANCIA_PN_BITUME
            BilanciaPnAttiva = BILANCIA_PN_BITUME
            Call BilBit_change
        Case BilanciaPnCombo.BILANCIA_PN_RICICLATO
            BilanciaPnAttiva = BILANCIA_PN_RICICLATO
            Call BilRAP_Change
        Case BilanciaPnCombo.BILANCIA_PN_VIATOP
            BilanciaPnAttiva = BILANCIA_PN_VIATOP
            If BilanciaViatopScarMixer1.Presenza Then
                Call BilanciaViatopScarMixerPeso_change(0)
            Else
                Call BilanciaViatopPeso_change
            End If
        Case BilanciaPnCombo.BILANCIA_PN_VIATOP2
            BilanciaPnAttiva = BILANCIA_PN_VIATOP2
            Call BilanciaViatopScarMixerPeso_change(1)
        Case Else
            BilanciaPnAttiva = BILANCIA_PN_NONE
    End Select
        
End Sub

Private Sub Form_Load()

    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)

    Call PasswordLevel
    Call UpdatePulsantiForm
    Call SetVisibleReset(ActiveUser)
    Call ConfigurazioneComboBil
    Call CaricaTraduzioniForm '20161104

End Sub

Public Sub ShowMe(Modo As Integer, ByRef parent As Form)

'    BilanciaPnAttiva = bilancia

    'FrmTaraBilancePmVisibile = True

    Call PasswordLevel

    Call VisualizzaBarraPulsantiCP240(False)

    Call Me.Show(Modo, parent)
                                                                                                
'    Select Case bilancia
'        Case BilancePnTypeEnum.BILANCIA_PN_AGGREGATI
'            Me.caption = CaptionStart + "Aggregate"
'        Case BilancePnTypeEnum.BILANCIA_PN_FILLER
'            Me.caption = CaptionStart + "Filler"
'        Case BilancePnTypeEnum.BILANCIA_PN_BITUME
'            Me.caption = CaptionStart + "Bitumen"
'        Case BilancePnTypeEnum.BILANCIA_PN_RICICLATO
'            Me.caption = CaptionStart + "Recycle"
'        Case BilancePnTypeEnum.BILANCIA_PN_VIATOP
'            Me.caption = CaptionStart + "Viatop"
'        Case BilancePnTypeEnum.BILANCIA_PN_VIATOP2
'            Me.caption = CaptionStart + "Viatop2"
'    End Select

End Sub


Private Sub CmdCalibrate_Click()

    CmdCalibrate.enabled = False
    LblWorking.Visible = True
    TmrCmdRunning.enabled = True

    BilanciaPnSampleWeight = String2Double(TxtSampleWeight.text)
    BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_CALIBRATE

End Sub

Private Sub CmdTare_Click()

    CmdTare.enabled = False
    LblWorking.Visible = True
    TmrCmdRunning.enabled = True

    BilanciaPnSampleWeight = 0
    BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_TARE

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

Private Sub TmrCmdRunning_Timer()

    BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_NONE
    
    LblWorking.Visible = BilanciaPnCmdRun
'    LblWorking.BackColor = IIf(LblWorking.BackColor, vbYellow, &H8000000F)

    CmdTare.enabled = (Not BilanciaPnCmdRun)
    CmdCalibrate.enabled = (Not BilanciaPnCmdRun)
    BtnReset.enabled = (Not BilanciaPnCmdRun)

    TmrCmdRunning.enabled = BilanciaPnCmdRun

End Sub

'Private Sub TxtSampleWeight_Change()
'    Call VerificaTextEdit(TxtSampleWeight, 1, 10, 2000, 100, False)
'End Sub

Private Sub TxtSampleWeight_LostFocus()
    Call VerificaTextEdit(TxtSampleWeight, 1, 10, 5000, 100, True)
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

        Case AqTopBarButtonEnum.TB_AQ_ESCI
            prefisso = "PLUS_IMG_EXIT"

        Case AqTopBarButtonEnum.TB_AQ_START
            prefisso = "PLUS_IMG_MOTORSTART"

        Case AqTopBarButtonEnum.TB_AQ_STOP
            prefisso = "PLUS_IMG_MOTORSTOP"

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

    For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
        If imgPulsanteForm(indice).enabled Then
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
        Else
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.disabled)
        End If
    Next indice

End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            BilanciaPnAttiva = BILANCIA_PN_NONE
            BilanciaPnCommand = BilancePnCommandEnum.BILANCIA_PN_CMD_NONE
            'FrmTaraBilancePmVisibile = false

            Me.Hide
            Unload Me
            Call VisualizzaBarraPulsantiCP240(True)

        'Case TopBarButtonEnum.Help
        '    VisualizzaHelp Me, HELP_...

    End Select

End Sub

Public Sub SetVisibleReset(ByVal newActiveUser As UsersEnum)
    BtnReset.Visible = IIf(ActiveUser = UsersEnum.SUPERUSER, True, False)
End Sub

'20161104
Private Sub ConfigurazioneComboBil()

'Corrispondenza di indici indipendente fra la selezione nella combo e l'enum BilanciaPnAttiva per lasciare a quest'ultima la liberta' di riassegnare la numerazione.
'Questo risolve anche il limite della combobox che non puo' mai avere buchi vuoti nella lista elementi, mentre potrei avere bilance attive/disattive in qualunque combinazione.

    Dim indexelementi As Integer

    cmbListaBilance.Clear
                                   
    indexelementi = 0

    cmbListaBilance.AddItem (LoadXLSString(1214)), 0
    BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_NONE
    BilanciaPnCombo.BILANCIA_PN_NONE = indexelementi
    indexelementi = indexelementi + 1
                
    If BilanciaAggregati.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(387))
        BilanciaPnCombo.BILANCIA_PN_AGGREGATI = indexelementi
        indexelementi = indexelementi + 1
    End If
    
    If BilanciaFiller.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(388))
        BilanciaPnCombo.BILANCIA_PN_FILLER = indexelementi
        indexelementi = indexelementi + 1
    End If
    
    If BilanciaLegante.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(389))
        BilanciaPnCombo.BILANCIA_PN_BITUME = indexelementi
        indexelementi = indexelementi + 1
    End If
    
    If BilanciaRAP.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(686))
        BilanciaPnCombo.BILANCIA_PN_RICICLATO = indexelementi
        indexelementi = indexelementi + 1
    End If
    
    If BilanciaViatop.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(491))
        BilanciaPnCombo.BILANCIA_PN_VIATOP = indexelementi
        indexelementi = indexelementi + 1
    ElseIf BilanciaViatopScarMixer1.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(491) + " 1")
        BilanciaPnCombo.BILANCIA_PN_VIATOP = indexelementi
        indexelementi = indexelementi + 1
    End If
    
    If BilanciaViatopScarMixer2.ProfiNet Then
        cmbListaBilance.AddItem (LoadXLSString(491) + " 2")
        BilanciaPnCombo.BILANCIA_PN_VIATOP2 = indexelementi
        indexelementi = indexelementi + 1
    End If
                

End Sub
'

Private Sub CaricaTraduzioniForm()

    lblSelBilancia.caption = UCase(LoadXLSString(687))
    LblTare.caption = UCase(LoadXLSString(1534))
    LblCalibration.caption = UCase(LoadXLSString(1424))
    LblWorking.caption = UCase(LoadXLSString(1142))
    lblKg(0).caption = LoadXLSString(349)
    lblKg(1).caption = LoadXLSString(349)
    
End Sub
