Attribute VB_Name = "GestioneBit"
 Option Explicit


Private m_lPower2(0 To 31) As Long

Public Function SetBit(InByte As Byte, Bit As Byte) As Byte
'Set het n'de bit of van InByte

SetBit = InByte Or (2 ^ Bit)  'Set het n'de Bit

End Function
Public Function ClearBit(InByte As Byte, Bit As Byte) As Byte
'Clear het n'de bit of van InByte
   
ClearBit = InByte And Not (2 ^ Bit) 'Clear het n'de Bit

End Function

Public Function IsBitSet(InByte As Byte, Bit As Byte) As Boolean
'Is het n'de bit van InByte gezet of niet?

IsBitSet = ((InByte And (2 ^ Bit)) > 0)

End Function
Public Function ToggleBit(InByte As Byte, Bit As Byte) As Byte
'Toggle'ed het n'de van InByte

ToggleBit = InByte Xor (2 ^ Bit)

End Function


Public Function RShift(ByVal lThis As Long, ByVal lBits As Long) As Long
   If (lBits <= 0) Then
      RShift = lThis
   ElseIf (lBits > 63) Then
      ' .. error ...
   ElseIf (lBits > 31) Then
      RShift = 0
   Else
      If (lThis And m_lPower2(31 - lBits)) = m_lPower2(31 - lBits) Then
         RShift = (lThis And (m_lPower2(31 - lBits) - 1)) * m_lPower2(lBits) Or m_lPower2(31)
      Else
         RShift = (lThis And (m_lPower2(31 - lBits) - 1)) * m_lPower2(lBits)
      End If
   End If
End Function

Public Function LShift(ByVal lThis As Long, ByVal lBits As Long) As Long
   If (lBits <= 0) Then
      LShift = lThis
   ElseIf (lBits > 63) Then
      ' ... error ...
   ElseIf (lBits > 31) Then
      LShift = 0
   Else
      If (lThis And m_lPower2(31)) = m_lPower2(31) Then
         LShift = (lThis And &H7FFFFFFF) \ m_lPower2(lBits) Or m_lPower2(31 - lBits)
      Else
         LShift = lThis \ m_lPower2(lBits)
      End If
   End If
End Function

Public Sub Init()
   m_lPower2(0) = &H1&
   m_lPower2(1) = &H2&
   m_lPower2(2) = &H4&
   m_lPower2(3) = &H8&
   m_lPower2(4) = &H10&
   m_lPower2(5) = &H20&
   m_lPower2(6) = &H40&
   m_lPower2(7) = &H80&
   m_lPower2(8) = &H100&
   m_lPower2(9) = &H200&
   m_lPower2(10) = &H400&
   m_lPower2(11) = &H800&
   m_lPower2(12) = &H1000&
   m_lPower2(13) = &H2000&
   m_lPower2(14) = &H4000&
   m_lPower2(15) = &H8000&
   m_lPower2(16) = &H10000
   m_lPower2(17) = &H20000
   m_lPower2(18) = &H40000
   m_lPower2(19) = &H80000
   m_lPower2(20) = &H100000
   m_lPower2(21) = &H200000
   m_lPower2(22) = &H400000
   m_lPower2(23) = &H800000
   m_lPower2(24) = &H1000000
   m_lPower2(25) = &H2000000
   m_lPower2(26) = &H4000000
   m_lPower2(27) = &H8000000
   m_lPower2(28) = &H10000000
   m_lPower2(29) = &H20000000
   m_lPower2(30) = &H40000000
   m_lPower2(31) = &H80000000
End Sub
