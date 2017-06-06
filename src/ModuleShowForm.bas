Attribute VB_Name = "ModuleShowForm"
Option Explicit


'Costanti.
Private Const SW_HIDE = 0
Private Const SW_SHOW = 5

'Dichiarazione Funzioni API.
Public Declare Function IsWindowVisible Lib "User32" (ByVal hWnd As Long) As Boolean
Public Declare Function ShowWindow Lib "User32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long


'   Visualizza un message box ed attende il risultato
Public Function ShowMsgBox( _
    prompt As String, _
    buttons As Integer, _
    icons As Integer, _
    left As Integer, _
    top As Integer, _
    modal As Boolean _
) As Integer

    MessageBox.WaitingBox MessageBox.Visible

    While (MessageBox.Visible)
        DoEvents
    Wend

    MessageBox.ShowMe prompt, buttons, icons, left, top, modal

    ShowMsgBox = MessageBox.buttonPressed
    
End Function


''Disabilita la visualizzazione della Task-Bar.
'Public Sub ShowTaskBar(Visible As Boolean)
'    Dim tbarhWnd As Long
'    tbarhWnd = FindWindow("Shell_TrayWnd", "")
'    If Visible Then
'        ShowWindow tbarhWnd, SW_SHOW
'    Else
'        ShowWindow tbarhWnd, SW_HIDE
'    End If
'End Sub
'

''Verifica la visualizzazione della Task-Bar.
'Public Function TaskBarVisible() As Boolean
'    Dim tbarhWnd As Long
'    tbarhWnd = FindWindow("Shell_TrayWnd", "")
'    TaskBarVisible = IsWindowVisible(tbarhWnd)
'End Function
'

