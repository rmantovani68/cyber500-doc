Attribute VB_Name = "BusSytem"
'
'   Gestione RACK[S]
'

Option Explicit

Public Enum PlcRackEnum
    R0
    R1
    R2
    R3
    R4
    R5
    R6
    R7
    R8
    R9
    R10
    R11
    R12
    R13
End Enum

Public Type PlcRack
    Configurato As Boolean
    OffLine As Boolean
    Fault As Boolean
End Type

Public ListaPlcRack(PlcRackEnum.R1 To PlcRackEnum.R6) As PlcRack

Public ListaPlcRackLetta As Boolean

'
'

Private Sub RackModificato( _
    ByRef Rack As PlcRack, _
    configuratoTag As Integer, _
    offlineTag As Integer, _
    faultTag As Integer, _
    ByRef daAggiornare As Boolean _
    )

On Error GoTo Errore

    With CP240.OPCData

        If (BooleanModificato(Rack.Configurato, .items(configuratoTag).Value, ListaPlcRackLetta)) Then
            daAggiornare = True
        End If
        If (BooleanModificato(Rack.OffLine, .items(offlineTag).Value, ListaPlcRackLetta)) Then
            daAggiornare = True
        End If
        If (BooleanModificato(Rack.Fault, .items(faultTag).Value, ListaPlcRackLetta)) Then
            daAggiornare = True
        End If

        If (Not Rack.Configurato) Then
            If (Not Rack.OffLine Or Rack.Fault) Then
                Rack.OffLine = True
                Rack.Fault = False
                daAggiornare = True
                Exit Sub
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "RCK-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

