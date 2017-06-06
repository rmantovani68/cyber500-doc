VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "XmlManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private xmlDoc As New MSXML2.DOMDocument60
Private m_xmlFileName As String

Private Sub Class_Initialize()
    xmlDoc.async = False
End Sub

Private Sub Class_Terminate()
    'Distruttore
End Sub

'******************************************************************************
'*******************             Property VALUE             *******************
'******************************************************************************

Property Get FileName() As String
    FileName = m_xmlFileName
End Property

Property Let FileName(ByVal FileName As String)
    If Dir(FileName) = "" Then Err.Raise 5
    
    m_xmlFileName = FileName
    xmlDoc.preserveWhiteSpace = False
    xmlDoc.Load m_xmlFileName

    If (xmlDoc.parseError.errorCode <> 0) Then
        LogInserisci True, "XmlManager.FileName", xmlDoc.parseError.errorCode & ": " & xmlDoc.parseError.reason
        Set xmlDoc = Nothing
    End If
    
End Property

'20161222
Property Let DocName(ByVal DocName As String)
    
    If (DocName) = "" Then Err.Raise 5

    xmlDoc.loadXML (DocName)

    If (xmlDoc.parseError.errorCode <> 0) Then
        LogInserisci True, "XmlManager.DocName", xmlDoc.parseError.errorCode & ": " & xmlDoc.parseError.reason
        Set xmlDoc = Nothing
    End If

End Property
'

'''******************************************************************************
''' SelectParameterSection(ByVal paramSection As String, ByVal paramCode As String) As IXMLDOMNode
''' Restituisce il nodo XML relativo al parametro 'paramCode' della sezione 'paramSection'
''' PARAMETRI:
''' - paramSection: sezione di appartenenza del parametro
''' - paramCode: codice del parametro
''' VALORE DI RITORNO
''' - IXMLDOMNode se trovato, Nothing altrimenti
'''******************************************************************************
''Private Function SelectParameterSection(ByVal paramSection As String, ByVal paramCode As String) As IXMLDOMNode
''    Set SelectParameterSection = xmlDoc.SelectSingleNode("//Section[@Code='" & paramSection & "']/" & paramCode)
''End Function

'******************************************************************************
' SelectParameterParagraph(ByVal paramSection As String, ByVal paramCode As String) As IXMLDOMNode
' Restituisce il nodo XML relativo al parametro 'paramCode' della sezione 'paramSection'
' PARAMETRI:
' - paramSection: sezione di appartenenza del parametro
' - paramCode: codice del parametro
' VALORE DI RITORNO
' - IXMLDOMNode se trovato, Nothing altrimenti
'******************************************************************************
Private Function SelectParameterParagraph(ByVal paramSection As String, ByVal paramParagraph As String, ByVal paramSubParagraph As String, ByVal paramCode As String) As IXMLDOMNode
    Dim path As String
    
    path = "//Section[@Code='" & paramSection & "']/"
    
    If (paramParagraph <> "") Then
        path = path & "Paragraph[@Code='" & paramParagraph & "']/"
    End If
    If (paramSubParagraph <> "") Then
        path = path & "Paragraph[@Code='" & paramSubParagraph & "']/"
    End If

    Set SelectParameterParagraph = xmlDoc.SelectSingleNode(path & paramCode)
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
        LogInserisci True, "XmlManager.GetAttribute", "parameterNode is Nothing"
        Exit Function
    End If
      
    Set GetAttribute = parameterNode.Attributes.getNamedItem(Code)
End Function

''Public Function ParameterExists(ByVal Section As String, ByVal paramCode As String) As Boolean
''    ParameterExists = (Not SelectParameterSection(Section, paramCode) Is Nothing)
''End Function

Public Function ParameterExists(ByVal Section As String, ByVal Paragraph As String, ByVal SubParagraph As String, ByVal Param As String) As Boolean
    ParameterExists = (Not SelectParameterParagraph(Section, Paragraph, SubParagraph, Param) Is Nothing)

    If (DEBUGGING) Then
        If (Not ParameterExists) Then
            Call LogInserisci(True, "ParameterExists", Section + ", " + Paragraph + ", " + SubParagraph + ", " + Param + ": NOT FOUND!")
        End If
    End If
End Function


''Public Function SectionExists(ByVal Section As String) As Boolean
''    SectionExists = Not (xmlDoc.SelectSingleNode("//Section[@Code='" & Section & "']") Is Nothing)
''End Function
''
''
''Public Function ParameterGetValue(ByVal Section As String, ByVal paramCode As String, ByVal attribCode) As Variant
''    Dim xmlNode As IXMLDOMNode
''    Dim xmlAttrib As IXMLDOMAttribute
''
''    Set xmlNode = SelectParameterSection(Section, paramCode)
''
''    ' per XML strutturato ad 'attributi'
''    Set xmlAttrib = GetAttribute(xmlNode, attribCode)
''    If (xmlAttrib Is Nothing) Then
''        LogInserisci True, "XmlManager.ParameterGetValue", "xmlAttrib is Nothing"
''        Exit Function
''    End If
''
''    ParameterGetValue = xmlAttrib.text
''
''End Function
''
''Public Function ParameterSetValue(ByVal Section As String, ByVal Code As String, ByVal Value As Variant)
''    Dim xmlNode As IXMLDOMNode
''    Dim xmlAttrib As IXMLDOMAttribute
''
''    Set xmlNode = SelectParameterSection(Section, Code)
''
''    ' per XML strutturato ad 'attributi'
''    Set xmlAttrib = GetAttribute(xmlNode, "Value")
''    If (xmlAttrib Is Nothing) Then
''        LogInserisci True, "XmlManager.ParameterSetValue", "xmlAttrib is Nothing"
''        Exit Function
''    End If
''
''    xmlAttrib.text = Value
''
''    ' Riscrive il file XML: TODO si puó pensare di ignorare la invocare un metodo Save
''    xmlDoc.Save (m_xmlFileName)
''End Function

Public Function GetValue(ByVal Section As String, ByVal Paragraph As String, ByVal SubParagraph As String, ByVal paramCode As String) As String
    Dim xmlNode As IXMLDOMNode

    Set xmlNode = SelectParameterParagraph(Section, Paragraph, SubParagraph, paramCode)
    If (xmlNode Is Nothing) Then
        GetValue = ""
        Exit Function
    End If
    
    GetValue = xmlNode.Attributes.getNamedItem("Value").text        'xmlNode.text ??

    'Call LogInserisci(False, "GetValue", Section + ", " + Paragraph + ", " + SubParagraph + ", " + paramCode + " = " + xmlNode.text)
End Function

Public Function SetValue(ByVal Section As String, ByVal Paragraph As String, ByVal SubParagraph As String, ByVal paramCode As String, ByVal Value As Variant) As Boolean
    Dim xmlNode As IXMLDOMNode

    Set xmlNode = SelectParameterParagraph(Section, Paragraph, SubParagraph, paramCode)
    If (xmlNode Is Nothing) Then
        SetValue = False
        Exit Function
    End If

    xmlNode.Attributes.getNamedItem("Value").text = Value       'xmlNode.text = Value ??

    ' Riscrive il file XML: TODO si puó pensare di ignorare la invocare un metodo Save
    xmlDoc.Save (m_xmlFileName)

    SetValue = True
End Function


Public Function Reload()
    xmlDoc.Load (m_xmlFileName)
End Function


''Public Function Save()
''    FormatXmlDocument xmlDoc
''    xmlDoc.Save (m_xmlFileName)
''    xmlDoc.Load m_xmlFileName
''End Function



''' Definisce un nuovo parametro
''Public Function NewParameter(ByVal Section As String, ByVal Code As String, ByVal val As Variant)
''    Dim xmlSectionNode As IXMLDOMNode
''    Dim xmlNode As IXMLDOMNode
''    Dim xmlAttr As IXMLDOMAttribute
''
''    'TODO: verificare se parametro già presente
''
''    If (Not SectionExists(Section)) Then
''        Set xmlSectionNode = NewSection(Section)
''    Else
''        Set xmlSectionNode = xmlDoc.SelectSingleNode("//Section[@Code='" & Section & "']")
''    End If
''
''    Set xmlNode = xmlDoc.createNode(1, "Parameter", "")
''    Set xmlAttr = xmlDoc.createAttribute("Code")
''    xmlAttr.Value = Code
''    Call xmlNode.Attributes.setNamedItem(xmlAttr)
''    Set xmlAttr = xmlDoc.createAttribute("Value")
''    xmlAttr.Value = val
''    Call xmlNode.Attributes.setNamedItem(xmlAttr)
''
''    Call xmlSectionNode.appendChild(xmlNode)
''    'Call xmlNode.appendChild(xmlDoc.createTextNode(vbNewLine + vbTab))
''
''    Call Save
''
''End Function

''Private Function NewSection(ByVal Section As String) As IXMLDOMNode
''    Dim xmlConfigNode As IXMLDOMNode
''    Dim xmlSectionNode As IXMLDOMNode
''    Dim xmlSectionAttr As IXMLDOMAttribute
''
''
''    Set xmlConfigNode = xmlDoc.SelectSingleNode("/Config")
''    Set xmlSectionNode = xmlDoc.createNode(1, "Section", "")
''    Set xmlSectionAttr = xmlDoc.createAttribute("Code")
''    xmlSectionAttr.Value = Section
''
''    Call xmlSectionNode.Attributes.setNamedItem(xmlSectionAttr)
''
''    Call xmlConfigNode.appendChild(xmlSectionNode)
''
''    Set NewSection = xmlSectionNode
''
''End Function


'''******************************************************************************
''' Formattazione/indentazione per migliore leggibilità
'''******************************************************************************
''Private Sub FormatXmlDocument(ByVal xml_doc As DOMDocument)
''    FormatXmlNode xml_doc.DocumentElement, 0
''End Sub

''' Add formatting to this element. Indent it and add a
''' carriage return before its children. Then recursively
''' format the children with increased indentation.
''Private Sub FormatXmlNode(ByVal node As IXMLDOMNode, ByVal indent As Integer)
''    Dim child As IXMLDOMNode
''    Dim text_only As Boolean
''
''    ' Do nothing if this is a text node.
''    If TypeOf node Is IXMLDOMText Then Exit Sub
''
''    ' See if this node contains only text.
''    text_only = True
''    If node.HasChildNodes Then
''        For Each child In node.ChildNodes
''            If Not (TypeOf child Is IXMLDOMText) Then
''                text_only = False
''                Exit For
''            End If
''        Next child
''    End If
''
''    ' Process child nodes.
''    If node.HasChildNodes Then
''        ' Add a carriage return before the children.
''        If Not text_only Then
''            node.InsertBefore node.OwnerDocument.createTextNode(vbCrLf), node.FirstChild
''        End If
''
''        ' Format the children.
''        For Each child In node.ChildNodes
''            FormatXmlNode child, indent + 2
''        Next child
''    End If
''
''    ' Format this element.
''    If indent > 0 Then
''        ' Indent before this element.
''        node.ParentNode.InsertBefore node.OwnerDocument.createTextNode(Space$(indent)), node
''
''        ' Indent after the last child node.
''        If Not text_only Then _
''            node.appendChild _
''                node.OwnerDocument.createTextNode(Space$(indent))
''
''        ' Add a carriage return after this node.
''        If node.NextSibling Is Nothing Then
''            node.ParentNode.appendChild node.OwnerDocument.createTextNode(vbCrLf)
''        Else
''            node.ParentNode.InsertBefore node.OwnerDocument.createTextNode(vbCrLf), node.NextSibling
''        End If
''    End If
''End Sub

