VERSION 5.00
Begin VB.Form MessageBox 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "MARINI"
   ClientHeight    =   1620
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   6990
   ControlBox      =   0   'False
   Icon            =   "MessageBox.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1620
   ScaleWidth      =   6990
   ShowInTaskbar   =   0   'False
   Begin VB.Timer TmrWaiting 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   6600
      Top             =   1200
   End
   Begin VB.CommandButton CmdClose 
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
      Index           =   5
      Left            =   3360
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   960
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdClose 
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
      Index           =   4
      Left            =   4080
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   960
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdClose 
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
      Index           =   3
      Left            =   2640
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   960
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdClose 
      Cancel          =   -1  'True
      Caption         =   "cancel"
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
      Index           =   2
      Left            =   4560
      TabIndex        =   2
      Top             =   960
      Visible         =   0   'False
      Width           =   1100
   End
   Begin VB.CommandButton CmdClose 
      Caption         =   "no"
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
      Index           =   1
      Left            =   3240
      TabIndex        =   1
      Top             =   960
      Visible         =   0   'False
      Width           =   1100
   End
   Begin VB.CommandButton CmdClose 
      Caption         =   "yes"
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
      Index           =   0
      Left            =   1920
      TabIndex        =   0
      Top             =   960
      Visible         =   0   'False
      Width           =   1100
   End
   Begin VB.Label LblMessageShort 
      Alignment       =   2  'Center
      Caption         =   "MsgBox...MsgBox...MsgBox...MsgBox..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   7
      Top             =   180
      Width           =   5655
   End
   Begin VB.Image ImgInformation 
      Height          =   480
      Left            =   240
      Top             =   480
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Image ImgExclamation 
      Height          =   480
      Left            =   240
      Top             =   480
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Image ImgQuestion 
      Height          =   480
      Left            =   240
      Top             =   480
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Label LblMessageLong 
      Alignment       =   2  'Center
      Caption         =   "MsgBox...MsgBox...MsgBox...MsgBox..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   1080
      TabIndex        =   5
      Top             =   100
      Width           =   5655
   End
End
Attribute VB_Name = "MessageBox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Public buttonPressed As Integer


Private Sub Form_Load()

    Call CarattereOccidentale(Me)

    Me.caption = CAPTIONSTARTSIMPLE

    LblMessageLong.Font.Charset = CharSetSelezionato
    LblMessageShort.Font.Charset = CharSetSelezionato

    CmdClose(0).caption = LoadXLSString(1114)
    CmdClose(1).caption = LoadXLSString(1115)
    CmdClose(2).caption = LoadXLSString(1116)

    CmdClose(3).Picture = LoadResPicture("IDI_CONFERMA", vbResIcon)
    CmdClose(3).ToolTipText = LoadXLSString(42)
    CmdClose(4).Picture = LoadResPicture("IDI_ANNULLA", vbResIcon)
    CmdClose(4).ToolTipText = LoadXLSString(1116)
    CmdClose(5).Picture = LoadResPicture("IDI_CONFERMA", vbResIcon)
    CmdClose(5).ToolTipText = LoadXLSString(42)

    ImgInformation.Picture = LoadResPicture("IDI_INFORMA", vbResIcon)
    ImgExclamation.Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
    ImgQuestion.Picture = LoadResPicture("IDI_DOMANDA", vbResIcon)

End Sub


Public Sub ShowMe( _
    prompt As String, _
    buttons As Integer, _
    icons As Integer, _
    left As Integer, _
    top As Integer, _
    modal As Boolean _
)
    Dim isShort As Boolean
    Dim colore As Long


    WaitingBox False

    buttonPressed = -1

    isShort = (Len(prompt) <= 40)

    LblMessageShort = prompt
    LblMessageLong = prompt
    LblMessageShort.Visible = isShort
    LblMessageLong.Visible = (Not isShort)

    Select Case buttons

        Case vbOKOnly
            CmdClose(5).Visible = True
            CmdClose(0).Visible = False
            CmdClose(1).Visible = False
            CmdClose(2).Visible = False
            CmdClose(3).Visible = False
            CmdClose(4).Visible = False
            CmdClose(4).default = False

        Case vbOKCancel, vbYesNo
            CmdClose(3).Visible = True
            CmdClose(4).Visible = True
            CmdClose(4).default = True
            CmdClose(0).Visible = False
            CmdClose(1).Visible = False
            CmdClose(2).Visible = False
            CmdClose(5).Visible = False

        Case vbYesNoCancel
            CmdClose(0).Visible = True
            CmdClose(1).Visible = True
            CmdClose(2).Visible = True
            CmdClose(2).default = True
            CmdClose(3).Visible = False
            CmdClose(4).Visible = False
            CmdClose(5).Visible = False

    End Select
    
    Select Case icons

'20170113
'        Case vbCritical, vbExclamation
        Case vbCritical, vbExclamation, vbError
'
            ImgExclamation.Visible = True

            ImgQuestion.Visible = False
            ImgInformation.Visible = False

            'Non critico viene visualizzato rosso
            colore = vbRed

        Case vbQuestion
            ImgQuestion.Visible = True

            ImgExclamation.Visible = False
            ImgInformation.Visible = False

            'Essendo una domandina viene visualizzato normalmente
            colore = vbButtonFace

        Case vbInformation
            ImgInformation.Visible = True

            ImgQuestion.Visible = False
            ImgExclamation.Visible = False

            'Essendo un'informazione viene visualizzato normalmente
            colore = vbButtonFace

    End Select
    
    Me.BackColor = colore
    LblMessageLong.BackColor = colore
    LblMessageShort.BackColor = colore

    If (left < 0 Or top < 0) Then
        'Posizionamento al centro del 1 monitor
        Call SetStartUpPosition(Me)
    Else
        Me.left = left
        Me.top = top
    End If
    
    If (modal) Then
        On Error GoTo ModalError
        Me.Show vbModal
    Else
        On Error GoTo ModelessError
        Me.Show vbModeless, CP240
    End If

    Exit Sub

ModalError:
    'Ha dato errore la visualizzazione modal per cui provo con quella modeless
    Me.Show vbModeless, CP240
    Exit Sub

ModelessError:
    'Ha dato errore la visualizzazione modeless per cui provo con quella modal
    Me.Show vbModal

End Sub

Public Sub WaitingBox(inAttesa As Boolean)

    TmrWaiting.enabled = inAttesa

End Sub

Private Sub CmdClose_Click(Index As Integer)

    Select Case Index

        Case 3, 5
            buttonPressed = vbOK

        Case 2, 4
            buttonPressed = vbCancel

        Case 0
            buttonPressed = vbYes

        Case 1
            buttonPressed = vbNo

    End Select

    Me.Hide

End Sub

Private Sub TmrWaiting_Timer()

    Dim colore As Long

    If (Me.BackColor = vbRed) Then
        'colore = vbButtonFace
        colore = vbYellow
    Else
        colore = vbRed
    End If

    Me.BackColor = colore
    LblMessageLong.BackColor = colore
    LblMessageShort.BackColor = colore

End Sub
