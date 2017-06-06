VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Configuration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_xmlManager As XmlManager

Private Sub Class_Initialize()
    Set m_xmlManager = New XmlManager
    m_xmlManager.FileName = UserDataPath & "\ParameterValues.xml"
End Sub

Public Sub FileReload()
    m_xmlManager.Reload
End Sub

'20151119
'Public Function GetParameterValue(Section As String, Paragraph As String, SubParagraph As String, Param As String) As String
Public Function GetParameterValue(Section As String, Paragraph As String, SubParagraph As String, Param As String, Optional defaultValue As String) As String
    If (Not m_xmlManager.ParameterExists(Section, Paragraph, SubParagraph, Param)) Then
        '20151119
        'GetParameterValue = ""
        GetParameterValue = defaultValue
        '
        Exit Function
    End If

    GetParameterValue = m_xmlManager.GetValue(Section, Paragraph, SubParagraph, Param)

End Function

Public Function SetParameterValue(Section As String, Paragraph As String, SubParagraph As String, Param As String, Value As Variant) As Boolean

Debug.Print "CYBERTRONIC_PLUS SetParameterValue? VERIFICARE comunicazione con C# (" + Param + ")"

    If (Not m_xmlManager.ParameterExists(Section, Paragraph, SubParagraph, Param)) Then
        SetParameterValue = False
        Exit Function
    End If

    Call m_xmlManager.SetValue(Section, Paragraph, SubParagraph, Param, Value)
    SetParameterValue = True
End Function
