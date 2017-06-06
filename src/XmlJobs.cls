VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "XmlJobs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'20170104
Option Explicit

Private xmlDoc As New MSXML2.DOMDocument60
Private m_xmlDocName As String

Private Sub Class_Initialize()
    xmlDoc.async = False
End Sub

Private Sub Class_Terminate()
    'Distruttore
End Sub

'******************************************************************************
'*******************             Property VALUE             *******************
'******************************************************************************

'20161222
Property Let DocName(ByVal DocName As String)
    
    If (DocName) = "" Then Err.Raise 5

    m_xmlDocName = DocName
    xmlDoc.preserveWhiteSpace = False
    xmlDoc.loadXML (DocName)

    If (xmlDoc.parseError.errorCode <> 0) Then
        LogInserisci True, "XmlJobs.DocName", xmlDoc.parseError.errorCode & ": " & xmlDoc.parseError.reason
        Set xmlDoc = Nothing
    End If

End Property
'

'******************************************************************************
' SelectParameterSection(ByVal paramSection As String, ByVal paramCode As String) As IXMLDOMNode
' Restituisce il nodo XML relativo al parametro 'paramCode' della sezione 'paramSection'
' PARAMETRI:
' - paramSection: sezione di appartenenza del parametro
' - paramCode: codice del parametro
' VALORE DI RITORNO
' - IXMLDOMNode se trovato, Nothing altrimenti
'******************************************************************************
Private Function SelectParameterSection(ByVal paramSection As String) As IXMLDOMNode
    Set SelectParameterSection = xmlDoc.selectSingleNode("//" & paramSection)
End Function

'Private Function SelectParameterSection(ByVal paramSection As String, ByVal paramCode As String) As IXMLDOMNode
'    Set SelectParameterSection = xmlDoc.selectSingleNode("//Section[@Code='" & paramSection & "']/" & paramCode)
'End Function

Public Function ParameterExists(ByVal Section As String, ByVal paramCode As String) As Boolean
    ParameterExists = (Not GetValue(Section, paramCode) Is Nothing)
    If (DEBUGGING) Then
        If (Not ParameterExists) Then
            Call LogInserisci(True, "ParameterExists ", Section + "," + paramCode + ": NOT FOUND!")
        End If
    End If
End Function

Public Function SectionExists(ByVal Section As String) As Boolean
    SectionExists = Not (xmlDoc.selectSingleNode("//Data[@Code='" & Section & "']") Is Nothing)
End Function

Public Function GetValue(ByVal Section As String, ByVal paramCode As String) As Variant
       
    Dim nodeElement As IXMLDOMElement
              
    Set nodeElement = xmlDoc.selectSingleNode("//" & Section & "/" & paramCode)
    
    If (nodeElement Is Nothing) Then
        LogInserisci True, "XmlJobs.GetValue", "nodeElement is Nothing"
        Exit Function
    End If
        
    GetValue = nodeElement.text
        
End Function

Public Function Reload()
    xmlDoc.loadXML (m_xmlDocName)
End Function

'******************************************************************************
' GetAttribute(ByRef parameterNode As IXMLDOMNode, ByVal code As String) As IXMLDOMAttribute
' Restituisce l'attributo XML del parametro 'parameterNode' avente codice 'code'
' PARAMETRI:
' - parameterNode: IXMLDOMNode relativo al parametro
' - code: codice dell'attributo
' VALORE DI RITORNO
' - IXMLDOMAttribute se trovato, Nothing altrimenti
'******************************************************************************
Private Function GetAttribute(ByRef parameterNode As IXMLDOMNode, ByVal Code As String) As IXMLDOMAttribute
    'Verifico consistenza del nodo XML
    If (parameterNode Is Nothing) Then
        LogInserisci True, "XmlJobs.GetAttribute", "parameterNode is Nothing"
        Exit Function
    End If
      
    Set GetAttribute = parameterNode.Attributes.getNamedItem(Code)
    
End Function

'Public Function SetAttribute(ByVal Section As String, ByVal Code As String, ByVal Value As Variant) As String
'    Dim xmlNode As IXMLDOMNode
'    Dim xmlAttrib As IXMLDOMAttribute
'
'    Set xmlNode = SelectParameterSection(Section, Code)
'
'    ' per XML strutturato ad 'attributi'
'    Set xmlAttrib = GetAttribute(xmlNode, "Value")
'    If (xmlAttrib Is Nothing) Then
'        LogInserisci True, "XmlManager.ParameterSetValue", "xmlAttrib is Nothing"
'        Exit Function
'    End If
'
'    xmlAttrib.text = Value
'
'    ' Riscrive il file XML: TODO si puó pensare di ignorare la invocare un metodo Save
'    xmlDoc.Save (m_xmlFileName)
'End Function


Public Function ParameterGetValue(ByVal paramCode As String, ByVal attribCode) As Variant
    Dim xmlNode As IXMLDOMNode
    Dim xmlAttrib As IXMLDOMAttribute

    Set xmlNode = SelectParameterSection(paramCode)

    ' per XML strutturato ad 'attributi'
    Set xmlAttrib = GetAttribute(xmlNode, attribCode)
    If (xmlAttrib Is Nothing) Then
        LogInserisci True, "XmlManager.ParameterGetValue", "xmlAttrib is Nothing"
        Exit Function
    End If

    ParameterGetValue = xmlAttrib.text

End Function
