VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FormAvvRidotto 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MARINI"
   ClientHeight    =   3000
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6750
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FormAvvRidotto.frx":0000
   ScaleHeight     =   3000
   ScaleWidth      =   6750
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   960
      Top             =   120
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
            Picture         =   "FormAvvRidotto.frx":0F2E
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":14F6
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":1AAB
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":206B
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":262B
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":2C89
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":32D0
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":3926
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":3F7C
            Key             =   "PLUS_IMG_MOTORSTART"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":4664
            Key             =   "PLUS_IMG_MOTORSTART_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":4D12
            Key             =   "PLUS_IMG_MOTORSTART_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormAvvRidotto.frx":53FA
            Key             =   "PLUS_IMG_MOTORSTART_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.CheckBox ChkRidotto 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Esclusione 3 - riciclato freddo"
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
      Left            =   360
      TabIndex        =   3
      Tag             =   "2"
      Top             =   2520
      Width           =   6135
   End
   Begin VB.CheckBox ChkRidotto 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Esclusione 2 - tamburo parallelo"
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
      TabIndex        =   2
      Tag             =   "1"
      Top             =   2040
      Width           =   6135
   End
   Begin VB.CheckBox ChkRidotto 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Esclusione 1 - tamburo principale"
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
      TabIndex        =   1
      Tag             =   "0"
      Top             =   1560
      Width           =   6135
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   4560
      Picture         =   "FormAvvRidotto.frx":5ADB
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   5685
      Picture         =   "FormAvvRidotto.frx":6129
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   2
      Left            =   0
      Picture         =   "FormAvvRidotto.frx":66E1
      Top             =   0
      Width           =   1125
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Seleziona i gruppi da escludere dall'avviamento automatico"
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
      Left            =   360
      TabIndex        =   0
      Top             =   1080
      Width           =   6135
   End
End
Attribute VB_Name = "FormAvvRidotto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Enum TopBarButtonEnum
    uscita
    Help
    start
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


Private Sub Form_Load()

    Dim checkutilizzato As Integer


    Me.caption = CAPTIONSTARTSIMPLE
    FormAvvRidotto.Label1.caption = LoadXLSString(1328)

    Me.left = 9150
    Me.top = 6200
    
    imgPulsanteForm(0).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(1).ToolTipText = LoadXLSString(110)

    ChkRidotto(0).Visible = False
    ChkRidotto(1).Visible = False
    ChkRidotto(2).Visible = False
    checkutilizzato = 0
    If GruppoAvviamentoSelezionato(0) Then
        ChkRidotto(checkutilizzato).Visible = True
        ChkRidotto(checkutilizzato).caption = LoadXLSString(1315)
        ChkRidotto(checkutilizzato).Tag = checkutilizzato
        checkutilizzato = checkutilizzato + 1
    End If
    If GruppoAvviamentoSelezionato(1) Then
        ChkRidotto(checkutilizzato).Visible = True
        ChkRidotto(checkutilizzato).caption = LoadXLSString(1316)
        ChkRidotto(checkutilizzato).Tag = checkutilizzato
        checkutilizzato = checkutilizzato + 1
    End If
    If GruppoAvviamentoSelezionato(2) Then
        ChkRidotto(checkutilizzato).Visible = True
        ChkRidotto(checkutilizzato).caption = LoadXLSString(1317)
        ChkRidotto(checkutilizzato).Tag = checkutilizzato
        checkutilizzato = checkutilizzato + 1
    End If

    Call UpdatePulsantiForm
    
End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            ProcediRidotto = False
            SelezioneFormTipoAvvMotori = vbAbort
            Me.Hide
            Unload Me
            Call VisualizzaBarraPulsantiCP240(True)
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_MOTORI_AVVIO_AUTOMATICO
        Case TopBarButtonEnum.start
            ProcediRidotto = True
            SelezioneFormTipoAvvMotori = vbOK
            If (ChkRidotto(0).Value = 1) Then
                'Call SelezioneStartAutomaticoRidotto(CInt(ChkRidotto(0).Tag))
            ElseIf (ChkRidotto(1).Value = 1) Then
                'Call SelezioneStartAutomaticoRidotto(CInt(ChkRidotto(1).Tag))
            ElseIf (ChkRidotto(2).Value = 1) Then
                'Call SelezioneStartAutomaticoRidotto(CInt(ChkRidotto(2).Tag))
            Else
                ProcediRidotto = False
                'Call SelezioneStartAutomaticoRidotto(AvviamentoMotoriCompleto)
            End If

            Unload Me
    End Select

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
        Case TopBarButtonEnum.start
            prefisso = "PLUS_IMG_MOTORSTART"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FAR-001", CStr(Err.Number) + " [" + Err.description + "]"
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
