VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Parameter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Enum ParamTypeEnum
    TypeBool = 0
    TypeInt = 1
    TypeSingle = 2
    TypeDouble = 3
    TypeString = 4
    TypeDate = 5
End Enum

Private m_code As String
Private m_Type As ParamTypeEnum
Private m_value As Variant
Private m_Default As Variant    'Default value
Private m_MinValue As Variant
Private m_MaxValue As Variant
Private m_Description As String
Private m_ToolTipDescription As String


'******************************************************************************
'******************* Event OnValueChanged                  ********************
'******************************************************************************
Public Event OnValueChanged(ByVal Value As Variant)

'******************************************************************************
'*******************       COSTRUTTORE E DISTRUTTORE       ********************
'******************************************************************************
Private Sub Class_Initialize()
    Debug.Print "Parameter_Initialize()"
End Sub

Private Sub Class_Terminate()
    Debug.Print "Parameter_Terminate()"
End Sub

'******************************************************************************
'******************* Property    CODE                      ********************
'******************************************************************************
Property Get Code() As String
    Code = m_code
End Property

Property Let Code(ByVal val As String)
    If IsEmpty(val) Then Err.Raise 5
    
    m_code = val
End Property

'******************************************************************************
'******************* Property    VALUE                     ********************
'******************************************************************************
Property Get Value() As Variant
    Value = m_value
End Property

Property Let Value(ByVal val As Variant)
    If IsEmpty(val) Then Err.Raise 5
    
   'TODO Controllo minvalue e maxvalue
    If (m_value <> val) Then Call ValueChanged(val)
   
    m_value = val
End Property

Private Sub ValueChanged(ByVal val As Variant)
    RaiseEvent OnValueChanged(val)
End Sub
