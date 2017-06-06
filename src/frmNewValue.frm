VERSION 5.00
Begin VB.Form FrmNewValue 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   " MARINI"
   ClientHeight    =   1380
   ClientLeft      =   60
   ClientTop       =   330
   ClientWidth     =   2910
   ControlBox      =   0   'False
   Icon            =   "frmNewValue.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1380
   ScaleWidth      =   2910
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton CmdEsci 
      BackColor       =   &H00C0C0C0&
      Cancel          =   -1  'True
      Height          =   550
      Left            =   1605
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   735
      Width           =   550
   End
   Begin VB.CommandButton CmdOk 
      BackColor       =   &H00C0C0C0&
      Default         =   -1  'True
      Height          =   550
      Left            =   840
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   720
      Width           =   550
   End
   Begin VB.TextBox TxtOldValue 
      Alignment       =   1  'Right Justify
      BackColor       =   &H000080FF&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   13.5
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   1
      Text            =   "0"
      Top             =   120
      Width           =   855
   End
   Begin VB.TextBox TxtNewValue 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0000FFFF&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   13.5
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   1920
      TabIndex        =   0
      Text            =   "0"
      Top             =   120
      Width           =   855
   End
   Begin VB.Image Image1 
      Height          =   510
      Left            =   1095
      Picture         =   "frmNewValue.frx":030A
      Stretch         =   -1  'True
      Top             =   105
      Width           =   705
   End
End
Attribute VB_Name = "FrmNewValue"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


Private Enum EditEnum
    EditString
    EditLong
    EditDouble
End Enum

Private EditType As EditEnum


Private Sub CmdEsci_Click()
    TxtNewValue.text = TxtOldValue.text
    Me.Hide
End Sub

Private Sub CmdOK_Click()
    Me.Hide
End Sub

Private Sub TxtNewValue_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        'Case 43         '+
        'Case 45         '-
 
        Case 46         '.
            If (EditType <> EditDouble) Then
                KeyAscii = 0
            End If

        Case vbKeyBack
        Case vbKeyDelete
        Case vbKeyCancel
            'OK

        Case 48 To 57   'Introduce solo valori numerici.
            'OK

        Case Else       'Scarta tutti gli altri valori.
            If (EditType <> EditString) Then
                KeyAscii = 0
            End If
    End Select
End Sub

Private Function ControlloOK(newValue As Variant, minValue As Variant, maxValue As Variant) As Boolean
On Error GoTo Errore

    ControlloOK = (newValue >= minValue And newValue <= maxValue)

    Exit Function
Errore:
    ControlloOK = False
End Function

Private Sub Form_Load()

    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)
    
    Call CarattereOccidentale(Me)

    Me.caption = CAPTIONSTARTSIMPLE

    CmdEsci.Picture = LoadResPicture("IDI_ANNULLA", vbResIcon)
    CmdEsci.ToolTipText = LoadXLSString(1116)
    CmdOk.Picture = LoadResPicture("IDI_CONFERMA", vbResIcon)
    CmdOk.ToolTipText = LoadXLSString(42)

End Sub


Public Function InputDoubleValue(ByRef parent As Form, oldValue As Double, minValue As Double, maxValue As Double) As Double

    Dim newValue As Double

    EditType = EditEnum.EditDouble
    InputDoubleValue = oldValue

    On Error GoTo Errore

    TxtOldValue.text = CStr(oldValue)
    TxtNewValue.text = ""

    Call Me.Show(vbModal, parent)

    newValue = String2Double(TxtNewValue.text)

    If ControlloOK(newValue, minValue, maxValue) Then
        InputDoubleValue = newValue
    End If

    'NO! Exit Function
Errore:
    Unload Me
End Function

Public Function InputLongValue(ByRef parent As Form, oldValue As Long, minValue As Long, maxValue As Long) As Long

    Dim newValue As Long

    EditType = EditEnum.EditLong
    InputLongValue = oldValue

    On Error GoTo Errore

    TxtOldValue.text = CStr(oldValue)
    TxtNewValue.text = ""

    Call Me.Show(vbModal, parent)

    newValue = CLng(TxtNewValue.text)

    If ControlloOK(newValue, minValue, maxValue) Then
        InputLongValue = newValue
    End If

    'NO! Exit Function
Errore:
    Unload Me
End Function

Public Function InputStringValue(ByRef parent As Form, oldValue As String) As String

    Dim newValue As String

    EditType = EditString
    InputStringValue = oldValue

    On Error GoTo Errore

    TxtOldValue.text = oldValue
    TxtNewValue.text = ""

    Call Me.Show(vbModal, parent)

    newValue = TxtNewValue.text
    InputStringValue = newValue

    'NO! Exit Function
Errore:
    Unload Me
End Function


