Attribute VB_Name = "GestioneSiloS7"
Option Explicit

'20150420
Public Enum SiloStateType
    Warning = 0
    Auto
    Man
    Jog
End Enum
'

Private SiloS7Leggi_Fatta As Boolean
Public InclusioneSiloS7 As Boolean
Public InclusioneSilo2S7 As Boolean
Public SiloS7AckAllarmi As Boolean
'20150420
'Public SiloS7Automatico As Boolean
'Public SiloS7Manuale As Boolean
'Public SiloS7JogAbilitati As Boolean
Public SiloStatus As SiloStateType
Public SiloStatusWarningMem As Boolean
Public SiloStatusMem As Integer
Public SiloStatusLock As Boolean
'

'Dati SILOS7
Public SiloS7VelocitaCalc As Double
Public SiloS7Posizione As Double
Public SiloS7Target As Double
Public SiloS7SyncroOn As Boolean
Public SiloS7BennaPiena As Boolean
Public SiloS7FcAperto As Boolean
Public SiloS7InPosition As Boolean
Public SiloS7VelInverterTeo As Double
Public SiloS7VelInverterReale As Double

'ASSE 1
'Posizioni SILOS7
Public SiloS7PosizioneSiloD As Double
Public SiloS7PosizioneSiloR As Double
Public SiloS7PosizioneSilo(0 To 18) As Double
Public SiloS7Posizione1AntiadesivoMain As Double
Public SiloS7Posizione2AntiadesivoMain As Double

'Parametri SILOS7
Public SiloS7ZerosetMoveSpeed As Double
Public SiloS7ZerosetSearchSpeed As Double
Public SiloS7ZerosetZeroSpeed As Double
Public SiloS7RapportoImpulsiUnitaMisura As Double
Public SiloS7PosisetVeloxMax As Double
Public SiloS7PosisetVeloxMin As Double
Public SiloS7PosisetRampaUP As Double
Public SiloS7PosisetRampaDOWN As Double
Public SiloS7PosisetTolleranza As Double
Public SiloS7QuotaMinima As Double '20150423
Public SiloS7RitPosiPT As Long
Public SiloS7TempoSpruzzaAntiadesivo As Long
Public SiloS7TempoScaricoPT As Long
Public SiloS7VelManualeJog As Double
Public SiloS7FwLocked As Boolean
Public SiloS7BwLocked As Boolean
Public SiloS7RitardoPosizionaSottoMixer As Integer

'ASSE 2
'Dati SILO2S7
Public Silo2S7VelocitaCalc As Double
Public Silo2S7Posizione As Double
Public Silo2S7Target As Double
Public Silo2S7SyncroOn As Boolean
Public Silo2S7BennaPiena As Boolean
Public Silo2S7FcAperto As Boolean
Public Silo2S7InPosition As Boolean
Public Silo2S7VelInverterTeo As Double
Public Silo2S7VelInverterReale As Double

'Posizioni SILO2S7
Public Silo2S7PosizioneSiloD As Double
Public Silo2S7PosizioneSiloR As Double
Public Silo2S7PosizioneSilo(0 To 18) As Double
Public SiloS7Posizione1AntiadesivoAux As Double
Public SiloS7Posizione2AntiadesivoAux As Double

'Parametri SILOS7
Public Silo2S7ZerosetMoveSpeed As Double
Public Silo2S7ZerosetSearchSpeed As Double
Public Silo2S7ZerosetZeroSpeed As Double
Public Silo2S7RapportoImpulsiUnitaMisura As Double
Public Silo2S7PosisetVeloxMax As Double
Public Silo2S7PosisetVeloxMin As Double
Public Silo2S7PosisetRampaUP As Double
Public Silo2S7PosisetRampaDOWN As Double
Public Silo2S7PosisetTolleranza As Double
Public Silo2S7RitPosiPT As Long
Public Silo2S7TempoSpruzzaAntiadesivo As Long
Public Silo2S7TempoScaricoPT As Long
Public Silo2S7VelManualeJog As Double
Public Silo2S7FwLocked As Boolean
Public Silo2S7BwLocked As Boolean

Public QuotaMaxGraficoSiloS7AsseX As Double
Public QuotaMinGraficoSiloS7AsseX As Double
Public QuotaMaxGraficoSiloS7AsseY As Double
Public QuotaMinGraficoSiloS7AsseY As Double
Public MemWidthshAreaGrPosNav As Double

'
            

Public Function DefinisciTAG_Silo() As Integer
	Dim i As Integer
	Dim DBNumber As String
    
    'Formato OPC server Softing
    'db<n>.dbx1.2:bool
    'db<n>.dbw2:int
    'db<n>.dbd4:real
    'db<n>.dbd8:dint
    'db<n>.dbd10:time
    'db<n>.dbb14:byte


    DefinisciTAG_Silo = 0

    DBNumber = "plc4/DB307.db"

    With CP240.OPCData.items

        For i = 0 To 7
            .AddItem (DBNumber & "x4." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 6 To 22 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 3
            .AddItem (DBNumber & "x26." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 7
            .AddItem (DBNumber & "x48." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 4
            .AddItem (DBNumber & "x49." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 152 To 164 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 208 To 240 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        .AddItem (DBNumber & "d286:time")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        
        DBNumber = "plc4/DB301.db"
    
        'PLCTAG_DB301_TempoSpruzzaAntiadesivo
    
        .AddItem (DBNumber & "d2:time")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x6.0:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1


        DBNumber = "plc4/DB310.db"

        'PLCTAG_DB310_PienoDaMescolatore
    
        For i = 0 To 7
            .AddItem (DBNumber & "x0." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 4
            .AddItem (DBNumber & "x1." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 5
            .AddItem (DBNumber & "x4." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 4
            .AddItem (DBNumber & "x6." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 10 To 54 Step 22
            .AddItem (DBNumber & "d" & i & ":time")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 86 To 92 Step 6
            .AddItem (DBNumber & "w" & i & ":int")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
            .AddItem (DBNumber & "d" & i + 2 & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        
        
        DBNumber = "plc4/DB309.db"
    
        'PLCTAG_POSIZIONI_SILI
    
        For i = 0 To 80 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i


        DBNumber = "plc4/DB312.db"

        .AddItem (DBNumber & "d12:real")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1


        DBNumber = "plc4/DB302.db"
        
        .AddItem (DBNumber & "d2:real")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "d22:real")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x26.0:bool")   'Errore comunicazione
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x26.1:bool")   'Errore Inverter
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x26.2:bool")   'Inverter non pronto
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        
        DBNumber = "plc4/DB322.db"
        
        .AddItem (DBNumber & "x6.4:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x5.7:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x6.0:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x6.1:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x6.2:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
    
        'PLCTAG_DB518
        DBNumber = "plc4/DB5.db"
    
        .AddItem (DBNumber & "x518.4:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x518.5:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
        'PLCTAG_SILOGEN
        DBNumber = "plc4/DB322.db"
    
        .AddItem (DBNumber & "x7.2:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x7.3:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
        .AddItem (DBNumber & "x74.7:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x75.0:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x75.1:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x75.2:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x7.4:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1

        'SILO 2

        DBNumber = "plc4/DB5.db"
    
        'PLCTAG_SILO2_Presenza
    
        .AddItem (DBNumber & "x518.3:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x518.6:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x518.7:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
        DBNumber = "plc4/DB332.db"
    
        'PLCTAG_SILO2_ZeroEnable
    
        For i = 0 To 7
            .AddItem (DBNumber & "x4." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 6 To 22 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 3
            .AddItem (DBNumber & "x26." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 7
            .AddItem (DBNumber & "x48." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 4
            .AddItem (DBNumber & "x49." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 152 To 164 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 208 To 240 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        .AddItem (DBNumber & "d286:time")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
    
        DBNumber = "plc4/DB331.db"
    
        'PLCTAG_SILO2_TempoSpruzzaAntiadesivo
    
        .AddItem (DBNumber & "d2:time")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x6.0:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
    
        DBNumber = "plc4/DB330.db"
    
        'PLCTAG_SILO2_PienoDaMescolatore
    
        For i = 0 To 7
            .AddItem (DBNumber & "x0." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 4
            .AddItem (DBNumber & "x1." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 5
            .AddItem (DBNumber & "x4." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 0 To 4
            .AddItem (DBNumber & "x6." & i & ":bool")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 10 To 54 Step 22
            .AddItem (DBNumber & "d" & i & ":time")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
        For i = 86 To 92 Step 6
            .AddItem (DBNumber & "w" & i & ":int")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
            .AddItem (DBNumber & "d" & i + 2 & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
    
    
        DBNumber = "plc4/DB309.db"
    
        'PLCTAG_SILO2_Posizione1
    
        For i = 84 To 164 Step 4
            .AddItem (DBNumber & "d" & i & ":real")
            DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        Next i
    
    
        DBNumber = "plc4/DB334.db"
    
        'PLCTAG_SILO2_VelocitaCalc
    
        .AddItem (DBNumber & "d12:real")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
    
        DBNumber = "plc4/DB303.db"
    
        'PLCTAG_SILO2_VelocitaInverterTeo
    
        .AddItem (DBNumber & "d2:real")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "d22:real")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
    
    
        DBNumber = "plc4/DB322.db"
    
        'PLCTAG_SILO2_AbilitaJog
    
        .AddItem (DBNumber & "x74.2:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x74.3:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1
        .AddItem (DBNumber & "x74.4:bool")
        DefinisciTAG_Silo = DefinisciTAG_Silo + 1

    End With

End Function

Public Sub SiloS7Leggi(forza As Boolean)

    On Error GoTo ERRORE

    If (Not InclusioneSiloS7 Or CP240.OPCData.items.Count = 0) Then
        Exit Sub
    End If
    
    If (forza) Then
        SiloS7Leggi_Fatta = False
    End If
    
    If (DoubleModificato(SiloS7VelocitaCalc, CP240.OPCData.items(PLCTAG_DB312_VelocitaCalc).Value, SiloS7Leggi_Fatta)) Then
        Call SiloS7Speed_changed
    End If

    If (DoubleModificato(SiloS7Posizione, CP240.OPCData.items(PLCTAG_DB307_Value).Value, SiloS7Leggi_Fatta)) Then
        Call SiloS7Position_changed
    End If

    If (DoubleModificato(SiloS7Target, CP240.OPCData.items(PLCTAG_DB307_Target).Value, SiloS7Leggi_Fatta)) Then
        FrmSiloGenerale.TxtSiloS7(2).text = CStr(RoundNumber(SiloS7Target, 2))
    End If

    If (BooleanModificato(SiloS7SyncroOn, CP240.OPCData.items(PLCTAG_DB307_SyncroOn).Value, SiloS7Leggi_Fatta)) Then
        Call SiloS7Stato_changed
    End If

    If (BooleanModificato(SiloS7BennaPiena, CP240.OPCData.items(PLCTAG_DB310_BennaPiena).Value, SiloS7Leggi_Fatta)) Then
        Call SiloS7Stato_changed
    End If

    If (BooleanModificato(SiloS7FcAperto, CP240.OPCData.items(PLCTAG_DB310_FC_Aperto).Value, SiloS7Leggi_Fatta)) Then
        Call SiloS7Stato_changed
    End If

    If (BooleanModificato(SiloS7InPosition, CP240.OPCData.items(PLCTAG_DB307_InPosition).Value, SiloS7Leggi_Fatta)) Then
'20150420
'        FrmSiloGenerale.CmdApriBenna.enabled = (SiloS7InPosition And SiloS7Manuale)
'        FrmSiloGenerale.CmdChiudiBenna.enabled = (SiloS7InPosition And SiloS7Manuale)
        FrmSiloGenerale.CmdApriBenna.enabled = (SiloS7InPosition And (SiloStatus = Man))
        FrmSiloGenerale.CmdChiudiBenna.enabled = (SiloS7InPosition And (SiloStatus = Man))
    End If

    If (DoubleModificato(SiloS7VelInverterTeo, CP240.OPCData.items(PLCTAG_DB302_VelocitaInverterTeo).Value, SiloS7Leggi_Fatta)) Then
        FrmSiloGenerale.TxtSiloS7(7).text = RoundNumber(SiloS7VelInverterTeo, 2)
    End If

    If (DoubleModificato(SiloS7VelInverterReale, CP240.OPCData.items(PLCTAG_DB302_VelocitaInverterReale).Value, SiloS7Leggi_Fatta)) Then
        FrmSiloGenerale.TxtSiloS7(8).text = RoundNumber(SiloS7VelInverterReale, 2)
    End If
    
    If (CP240.OPCData.items(PLCTAG_DO_AsseP_SpruzzAntiad).Value) Then
        FrmSiloGenerale.LblSiloS7(40).BackColor = vbGreen
        FrmSiloGenerale.ImgSpruzzaAntiadesivoMain.Visible = True
    Else
        FrmSiloGenerale.LblSiloS7(40).BackColor = FrmSiloGenerale.FrameSiloS7(0).BackColor
        FrmSiloGenerale.ImgSpruzzaAntiadesivoMain.Visible = False
    End If

    If (InclusioneSilo2S7) Then
        If (DoubleModificato(Silo2S7VelocitaCalc, CP240.OPCData.items(PLCTAG_SILO2_VelocitaCalc).Value, SiloS7Leggi_Fatta)) Then
            Call SiloS7Speed_changed
        End If

        If (DoubleModificato(Silo2S7Posizione, CP240.OPCData.items(PLCTAG_SILO2_Value).Value, SiloS7Leggi_Fatta)) Then
            Call SiloS7Position_changed
        End If

        If (DoubleModificato(Silo2S7Target, CP240.OPCData.items(PLCTAG_SILO2_Target).Value, SiloS7Leggi_Fatta)) Then
            FrmSiloGenerale.TxtSiloS7(10).text = CStr(RoundNumber(Silo2S7Target, 2))
        End If

        If (BooleanModificato(Silo2S7SyncroOn, CP240.OPCData.items(PLCTAG_SILO2_SyncroOn).Value, SiloS7Leggi_Fatta)) Then
            Call SiloS7Stato_changed
        End If

        If (BooleanModificato(Silo2S7BennaPiena, CP240.OPCData.items(PLCTAG_SILO2_BennaPiena).Value, SiloS7Leggi_Fatta)) Then
            Call SiloS7Stato_changed
        End If

        If (BooleanModificato(Silo2S7FcAperto, CP240.OPCData.items(PLCTAG_SILO2_FC_Aperto).Value, SiloS7Leggi_Fatta)) Then
            Call SiloS7Stato_changed
        End If

        'TODO
        'If (BooleanModificato(Silo2S7InPosition, CP240.OPCData.Items(PLCTAG_SILO2_InPosition).value, SiloS7Leggi_Fatta)) Then
        '    FrmSiloGenerale.CmdApriBenna.enabled = (Silo2S7InPosition And SiloS7Manuale)
        '    FrmSiloGenerale.CmdChiudiBenna.enabled = (Silo2S7InPosition And SiloS7Manuale)
        'End If

        If (DoubleModificato(Silo2S7VelInverterTeo, CP240.OPCData.items(PLCTAG_SILO2_VelocitaInverterTeo).Value, SiloS7Leggi_Fatta)) Then
            FrmSiloGenerale.TxtSiloS7(12).text = RoundNumber(Silo2S7VelInverterTeo, 2)
        End If

        If (DoubleModificato(Silo2S7VelInverterReale, CP240.OPCData.items(PLCTAG_SILO2_VelocitaInverterReale).Value, SiloS7Leggi_Fatta)) Then
            FrmSiloGenerale.TxtSiloS7(13).text = RoundNumber(Silo2S7VelInverterReale, 2)
        End If
        
        If (CP240.OPCData.items(PLCTAG_DO_AsseA_SpruzzAntiad).Value) Then
            FrmSiloGenerale.LblSiloS7(50).BackColor = vbGreen
            FrmSiloGenerale.ImgSpruzzaAntiadesivoAux.Visible = True
        Else
            FrmSiloGenerale.LblSiloS7(50).BackColor = FrmSiloGenerale.FrameSiloS7(8).BackColor
            FrmSiloGenerale.ImgSpruzzaAntiadesivoAux.Visible = False
        End If
    End If

    SiloS7QuotaMinima = CP240.OPCData.items(PLCTAG_DB307_Finestra).Value + SiloS7PosisetTolleranza '20150423

    SiloS7Leggi_Fatta = True

    Exit Sub
	ERRORE:
    LogInserisci True, "SS7-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SiloS7Scrivi()
	'Dim i As Integer
	'Dim indice As Integer

    On Error GoTo ERRORE
    
    If (CP240.OPCData.items.Count = 0) Then
        Exit Sub
    End If

    Call ScriviDestinazioneSilo(DestinazioneSilo)

    CP240.OPCData.SOUpdate

    Exit Sub
	ERRORE:
    LogInserisci True, "SS7-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

    
Public Sub ScriviDestinazioneSilo(destinazione As Integer)
	'PLCTAG_DB310_WORK_Destinazione =  1 --> silo 1
	'                                   2 --> silo 2
	'                                   3 --> silo 3
	'                                   4 --> silo 4
	'                                   5 --> silo 5
	'                                   6 --> silo 6
	'                                   7 --> silo 7
	'                                   8 --> silo 8
	'                                   11--> silo D
	'                                   12--> silo R
	'                                   19--> Limite1 spruzzatura antiadesivo
	'                                   20--> Limite2 spruzzatura antiadesivo

    Dim posizione As Double
    Dim posizione2 As Double
    
    If Not InclusioneSiloS7 Then
        Exit Sub
    End If
    
    With CP240.OPCData

        If (destinazione = 11) Then
            posizione = SiloS7PosizioneSiloD
            posizione2 = Silo2S7PosizioneSiloD
        ElseIf (destinazione = 12) Then
            posizione = SiloS7PosizioneSiloR
            posizione2 = Silo2S7PosizioneSiloR
        ElseIf (destinazione > 0) Then
            posizione = SiloS7PosizioneSilo(destinazione)
            posizione2 = Silo2S7PosizioneSilo(destinazione)
        End If

        'il controllo anti impazzimento navetta e' incluso nel plc dalla versione 9.5.15.0 (blocco FB113)
        If Not .items(PLCTAG_DB307_PosiOn).Value And (.items(PLCTAG_DB310_WORK_Destinazione).Value <> destinazione) Then
            .items(PLCTAG_DB310_WORK_Destinazione).Value = destinazione
        End If

        If Not .items(PLCTAG_SILO2_PosiOn).Value And (InclusioneSilo2S7) And (.items(PLCTAG_SILO2_WORK_Destinazione).Value <> destinazione) Then
            .items(PLCTAG_SILO2_WORK_Destinazione).Value = destinazione
        End If

    End With

End Sub



Public Function SiloS7GetPosizioneSilo(asse As Integer, silo As String) As Double

    Dim numSilo As Integer

    If (asse = 1) Then
        If (silo = "D") Then
            SiloS7GetPosizioneSilo = SiloS7PosizioneSiloD
        ElseIf (silo = "R") Then
            SiloS7GetPosizioneSilo = SiloS7PosizioneSiloR
        Else
            numSilo = val(GetSiloIndex(silo))
            SiloS7GetPosizioneSilo = SiloS7PosizioneSilo(numSilo)
        End If
    ElseIf (asse = 2) Then
        If (silo = "D") Then
            SiloS7GetPosizioneSilo = Silo2S7PosizioneSiloD
        ElseIf (silo = "R") Then
            SiloS7GetPosizioneSilo = Silo2S7PosizioneSiloR
        Else
            numSilo = val(GetSiloIndex(silo))
            SiloS7GetPosizioneSilo = Silo2S7PosizioneSilo(numSilo)
        End If
    End If

End Function

Public Sub SiloS7ShowPosition()
    Call SiloS7Position_changed
End Sub

Private Sub SiloS7Position_changed()

    Dim PosNavettaAsseX As Integer
    Dim PosNavettaAsseY As Integer
    Dim CentroNavettaX As Integer
    Dim CentroNavettaY As Integer
    Dim SoloAsseX As Boolean
                      
	On Error GoTo ERRORE

    SoloAsseX = (QuotaMinGraficoSiloS7AsseY = 0 And QuotaMaxGraficoSiloS7AsseY = 0)

    With FrmSiloGenerale

        .TxtSiloS7(1).text = CStr(RoundNumber(SiloS7Posizione, 1))
        .TxtSiloS7(3).text = CStr(RoundNumber(SiloS7Posizione, 1))

        If (InclusioneSilo2S7) Then
            .TxtSiloS7(101).text = CStr(RoundNumber(Silo2S7Posizione, 1))
            .TxtSiloS7(103).text = CStr(RoundNumber(Silo2S7Posizione, 1))
        End If

        .SliderPosAsse1.Value = SiloS7Posizione

        If (InclusioneSilo2S7) Then
            .SliderPosAsse2.Value = Silo2S7Posizione
        End If

        If SoloAsseX Then
        
            'posiziona la navetta nel riquadro nella pagina principale del silo
            CentroNavettaX = .imgGrafPos(0).width / 2
            CentroNavettaY = .imgGrafPos(0).Height / 2
    
            PosNavettaAsseX = Abs(Round(Linearizza(RoundNumber(SiloS7Posizione, 1), QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, .lblPosGraf(1).width / 2, .shAreaGrPosNav(0).width - .lblPosGraf(1).width / 2), 0))
            PosNavettaAsseY = Abs(Round((.shAreaGrPosNav(0).Height / 2), 0))
    
            .imgGrafPos(0).left = PosNavettaAsseX - CentroNavettaX + .shAreaGrPosNav(0).left
            .imgGrafPos(0).top = PosNavettaAsseY - CentroNavettaY + .shAreaGrPosNav(0).top
                
            'posiziona la navetta nel riquadro nella pagina di servizio del silo
            CentroNavettaX = .imgGrafPos(1).width / 2
            CentroNavettaY = .imgGrafPos(1).Height / 2
    
            PosNavettaAsseX = Abs(Round(Linearizza(RoundNumber(SiloS7Posizione, 1), QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, .lblPosGraf(101).width / 2, MemWidthshAreaGrPosNav - .lblPosGraf(101).width / 2), 0))
            PosNavettaAsseY = Abs(Round((.shAreaGrPosNav(1).Height / 2), 0))
    
            .imgGrafPos(1).left = PosNavettaAsseX - CentroNavettaX + .shAreaGrPosNav(1).left
            .imgGrafPos(1).top = PosNavettaAsseY - CentroNavettaY + .shAreaGrPosNav(1).top
        
        Else
            'posiziona la navetta nel riquadro nella pagina principale del silo
            CentroNavettaX = .imgGrafPos(0).width / 2
            CentroNavettaY = .imgGrafPos(0).Height / 2
    
            PosNavettaAsseX = Abs(Round(Linearizza(RoundNumber(Silo2S7Posizione, 1), QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, .lblPosGraf(1).width / 2, .shAreaGrPosNav(0).width - .lblPosGraf(1).width / 2), 0))
            PosNavettaAsseY = Abs(Round(Linearizza(RoundNumber(SiloS7Posizione, 1), QuotaMinGraficoSiloS7AsseY, QuotaMaxGraficoSiloS7AsseY, .lblPosGraf(1).Height / 2, .shAreaGrPosNav(0).Height - .lblPosGraf(1).Height / 2), 0))
    
            .imgGrafPos(0).left = PosNavettaAsseX - CentroNavettaX + .shAreaGrPosNav(0).left
            .imgGrafPos(0).top = PosNavettaAsseY - CentroNavettaY + .shAreaGrPosNav(0).top
    
            'posiziona la navetta nel riquadro nella pagina di servizio del silo
            CentroNavettaX = .imgGrafPos(1).width / 2
            CentroNavettaY = .imgGrafPos(1).Height / 2
    
            PosNavettaAsseX = Abs(Round(Linearizza(RoundNumber(Silo2S7Posizione, 1), QuotaMinGraficoSiloS7AsseX, QuotaMaxGraficoSiloS7AsseX, .lblPosGraf(101).width / 2, MemWidthshAreaGrPosNav - .lblPosGraf(101).width / 2), 0))
            PosNavettaAsseY = Abs(Round(Linearizza(RoundNumber(SiloS7Posizione, 1), QuotaMinGraficoSiloS7AsseY, QuotaMaxGraficoSiloS7AsseY, .lblPosGraf(101).Height / 2, .shAreaGrPosNav(1).Height - .lblPosGraf(101).Height / 2), 0))
    
            .imgGrafPos(1).left = PosNavettaAsseX - CentroNavettaX + .shAreaGrPosNav(1).left
            .imgGrafPos(1).top = PosNavettaAsseY - CentroNavettaY + .shAreaGrPosNav(1).top
        End If

    End With
    
    Exit Sub

	ERRORE:

End Sub

Private Sub SiloS7Speed_changed()

    With FrmSiloGenerale

        .TxtSiloS7(0).text = CStr(RoundNumber(SiloS7VelocitaCalc, 2))

        If (InclusioneSilo2S7) Then
            .TxtSiloS7(100).text = CStr(RoundNumber(Silo2S7VelocitaCalc, 2))
        End If

    End With

End Sub


Private Function SiloImmagineStato(siyncroOn As Boolean, fcAperto As Boolean, piena As Boolean) As String

    If (Not siyncroOn) Then

        If (VisualizzaBenna) Then
            SiloImmagineStato = "IDI_BENNANOSYNCRO"
        Else
            SiloImmagineStato = "IDI_NAVETTANOSYNCRO"
        End If

    ElseIf (fcAperto) Then

        If (VisualizzaBenna) Then
            SiloImmagineStato = "IDI_BENNASCARICO"
        Else
            SiloImmagineStato = "IDI_NAVETTASCARICO"
        End If

    Else

        If (piena) Then
            If (VisualizzaBenna) Then
                SiloImmagineStato = "IDI_BENNAPIENA"
            Else
                SiloImmagineStato = "IDI_NAVETTAPIENA"
            End If
        Else
            If (VisualizzaBenna) Then
                SiloImmagineStato = "IDI_BENNA"
            Else
                SiloImmagineStato = "IDI_NAVETTA"
            End If
        End If

    End If

End Function

Private Sub SiloS7Stato_changed()

    FrmSiloGenerale.imgStatoBennaAsse(0).Picture = LoadResPicture( _
        SiloImmagineStato(SiloS7SyncroOn, SiloS7FcAperto, SiloS7BennaPiena), _
        vbResIcon _
        )
    
    CP240.imgStatoBennaAsse(0).Picture = LoadResPicture( _
        SiloImmagineStato(SiloS7SyncroOn, SiloS7FcAperto, SiloS7BennaPiena), _
        vbResIcon _
        )

    If (InclusioneSilo2S7) Then
        FrmSiloGenerale.imgStatoBennaAsse(1).Picture = LoadResPicture( _
            SiloImmagineStato(Silo2S7SyncroOn, Silo2S7FcAperto, Silo2S7BennaPiena), _
            vbResIcon _
            )
        CP240.imgStatoBennaAsse(1).Picture = LoadResPicture( _
            SiloImmagineStato(Silo2S7SyncroOn, Silo2S7FcAperto, Silo2S7BennaPiena), _
            vbResIcon _
            )
    End If

End Sub


Public Sub SiloS7GestioneAllarmi(ByRef IdDescrizione As Integer, ByRef IndirizzoPLC As String)

    Dim allarmePresente As Boolean

    ' Devono essere eseguiti anche senza l'inclusione del silo S7
    Select Case IndirizzoPLC
        Case "G1891"
            IngressoAllarmePresente IdDescrizione, CP240.OPCData.items(PLCTAG_All_SILO_AllarmeBenna).Value
            Exit Sub
        Case "G2011"
            IngressoAllarmePresente IdDescrizione, CP240.OPCData.items(PLCTAG_All_SILO2_AllarmeBenna).Value
            Exit Sub
    End Select
    '

    If (Not InclusioneSiloS7) Then
        Exit Sub
    End If

    If UCase(left(IndirizzoPLC, 2)) = "GS" Then
        Exit Sub
    End If

    Select Case IndirizzoPLC
        Case "G1881"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_TimeoutAP).Value
        Case "G1882"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_TimeoutCH).Value
        Case "G1883"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_ErroreComInverter).Value
'20150420
'            If allarmePresente Then
'                Call SiloS7VerificaAbilitazioni
'            End If
        Case "G1884"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_ErroreInverter).Value
'20150420
'            If allarmePresente Then
'                Call SiloS7VerificaAbilitazioni
'            End If
        Case "G1885"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_ErroreNpInverter).Value
'20150420
'            If allarmePresente Then
'                Call SiloS7VerificaAbilitazioni
'            End If
        Case "G1886"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_FCsicurezzaMin).Value
        Case "G1887"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_FCsicurezzaMax).Value

        Case "G1880"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_BassaVel).Value
        Case "G1890"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO_TermIverterEXT).Value

        Case "G2001"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_TimeoutAP).Value
        Case "G2002"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_TimeoutCH).Value
        Case "G2003"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_ErroreComInverter).Value
'20150420
'            If allarmePresente Then
'                Call SiloS7VerificaAbilitazioni
'            End If
        Case "G2004"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_ErroreInverter).Value
'20150420
'            If allarmePresente Then
'                Call SiloS7VerificaAbilitazioni
'            End If
        Case "G2005"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_ErroreNpInverter).Value
'20150420
'            If allarmePresente Then
'                Call SiloS7VerificaAbilitazioni
'            End If
        Case "G2006"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_FCsicurezzaMin).Value
        Case "G2007"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_FCsicurezzaMax).Value
        Case "G0000"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_BassaVel).Value
        Case "G2010"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_TermIverterEXT).Value
        Case "G2120"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILO2_MovimentoContemporaneoAssi).Value
        Case "G2121"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SILOGEN_ErroreCoperchiSIlo).Value
    
    End Select

    IngressoAllarmePresente IdDescrizione, allarmePresente

End Sub

Public Sub SiloS7InviaParametri()

    If (Not InclusioneSiloS7) Then
        Exit Sub
    End If

    With CP240.OPCData

        .items(PLCTAG_DB307_Zeroset_MoveSpeed).Value = SiloS7ZerosetMoveSpeed
        .items(PLCTAG_DB307_Zeroset_SearchSpeed).Value = SiloS7ZerosetSearchSpeed
        .items(PLCTAG_DB307_Zeroset_ZeroSpeed).Value = SiloS7ZerosetZeroSpeed
        .items(PLCTAG_DB307_RapportoImpulsiUnitaMisura).Value = SiloS7RapportoImpulsiUnitaMisura
        .items(PLCTAG_DB307_Posiset_VeloxMax).Value = SiloS7PosisetVeloxMax
        .items(PLCTAG_DB307_Posiset_VeloxMin).Value = SiloS7PosisetVeloxMin
        .items(PLCTAG_DB307_Posiset_RampaUP).Value = SiloS7PosisetRampaUP
        .items(PLCTAG_DB307_Posiset_RampaDOWN).Value = SiloS7PosisetRampaDOWN
        .items(PLCTAG_DB307_Posiset_Tolleranza).Value = SiloS7PosisetTolleranza
        .items(PLCTAG_DB307_RitPosi_PT).Value = ConvertiTempoSECtoS7(SiloS7RitPosiPT)
        .items(PLCTAG_DB301_TempoSpruzzaAntiadesivo).Value = ConvertiTempoSECtoS7(SiloS7TempoSpruzzaAntiadesivo)
        .items(PLCTAG_DB310_TempoScarico_PT).Value = ConvertiTempoSECtoS7(SiloS7TempoScaricoPT)

        ' .Items(PLCTAG_DB310_).value = SiloS7VelManualeJog
        
        .items(PLCTAG_SiloS7RitardoPosizionaSottoMixer).Value = SiloS7RitardoPosizionaSottoMixer

        
        .items(PLCTAG_DB518_FwLocked).Value = SiloS7FwLocked
        .items(PLCTAG_DB518_BwLocked).Value = SiloS7BwLocked

        .items(PLCTAG_SILO2_Presenza).Value = InclusioneSilo2S7

        If (InclusioneSilo2S7) Then

            .items(PLCTAG_SILO2_Zeroset_MoveSpeed).Value = Silo2S7ZerosetMoveSpeed
            .items(PLCTAG_SILO2_Zeroset_SearchSpeed).Value = Silo2S7ZerosetSearchSpeed
            .items(PLCTAG_SILO2_Zeroset_ZeroSpeed).Value = Silo2S7ZerosetZeroSpeed
            .items(PLCTAG_SILO2_RapportoImpulsiUnitaMisura).Value = Silo2S7RapportoImpulsiUnitaMisura
            .items(PLCTAG_SILO2_Posiset_VeloxMax).Value = Silo2S7PosisetVeloxMax
            .items(PLCTAG_SILO2_Posiset_VeloxMin).Value = Silo2S7PosisetVeloxMin
            .items(PLCTAG_SILO2_Posiset_RampaUP).Value = Silo2S7PosisetRampaUP
            .items(PLCTAG_SILO2_Posiset_RampaDOWN).Value = Silo2S7PosisetRampaDOWN
            .items(PLCTAG_SILO2_Posiset_Tolleranza).Value = Silo2S7PosisetTolleranza
            .items(PLCTAG_SILO2_RitPosi_PT).Value = ConvertiTempoSECtoS7(Silo2S7RitPosiPT)
            .items(PLCTAG_SILO2_TempoSpruzzaAntiadesivo).Value = ConvertiTempoSECtoS7(Silo2S7TempoSpruzzaAntiadesivo)
            .items(PLCTAG_SILO2_TempoScarico_PT).Value = ConvertiTempoSECtoS7(Silo2S7TempoScaricoPT)

            ' .Items(PLCTAG_SILO2_).value = Silo2S7VelManualeJog

            .items(PLCTAG_SILO2_FwLocked).Value = Silo2S7FwLocked
            .items(PLCTAG_SILO2_BwLocked).Value = Silo2S7BwLocked

        End If

        SiloS7ScriviPosizioni

    End With

End Sub

Public Sub SiloS7ScriviPosizioni()

    Dim indice As Integer


   With CP240.OPCData

        If (Not .IsConnected) Then
            Exit Sub
        End If

        For indice = 0 To 17
            .items(PLCTAG_DB309_Posizione1 + indice).Value = SiloS7PosizioneSilo(indice)
        Next indice
        .items(PLCTAG_DB309_Posizione20).Value = SiloS7Posizione1AntiadesivoMain
        .items(PLCTAG_DB309_Posizione21).Value = SiloS7Posizione2AntiadesivoMain
        .items(PLCTAG_DB309_Posizione12).Value = SiloS7PosizioneSiloD
        .items(PLCTAG_DB309_Posizione13).Value = SiloS7PosizioneSiloR
        
        If (InclusioneSilo2S7) Then
            For indice = 0 To 17
                .items(PLCTAG_SILO2_Posizione1 + indice).Value = Silo2S7PosizioneSilo(indice)
            Next indice
            .items(PLCTAG_SILO2_Posizione20).Value = SiloS7Posizione1AntiadesivoAux
            .items(PLCTAG_SILO2_Posizione21).Value = SiloS7Posizione2AntiadesivoAux
            .items(PLCTAG_SILO2_Posizione12).Value = Silo2S7PosizioneSiloD
            .items(PLCTAG_SILO2_Posizione13).Value = Silo2S7PosizioneSiloR
        End If

    End With

    If (FrmSiloGeneraleVisibile) Then
        Call FrmSiloGenerale.SiloS7VisualizzaPosSili
    End If

End Sub

Public Sub ResetCmdSilo()

    With CP240
        
        .OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
        .OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
        .OPCData.items(PLCTAG_DB310_ManuApre).Value = False
        .OPCData.items(PLCTAG_DB310_ManuChiude).Value = False
        .OPCData.items(PLCTAG_DB307_StartSyncro).Value = False
        .OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE2).Value = False
        .OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE2).Value = False
        .OPCData.items(PLCTAG_SILO2_ManuApre).Value = False
        .OPCData.items(PLCTAG_SILO2_ManuChiude).Value = False
        .OPCData.items(PLCTAG_SILO2_StartSyncro).Value = False
        .OPCData.items(PLCTAG_SILOGEN_MEMSALITABENNA).Value = False
        .TimerResetCmdSilo.enabled = False
    
    End With
    
End Sub

Public Sub CalcoloQuotePosGraficaSiloS7()

    Dim indice As Integer
    Dim QuotaMaxAsse1 As Double
    Dim QuotaMinAsse1 As Double
    Dim QuotaMaxAsse2 As Double
    Dim QuotaMinAsse2 As Double

'ricava gli estremi delle quote per la scalatura automatica del grafico di posizione

    For indice = 0 To 18
        
        If SiloS7PosizioneSilo(indice) > QuotaMaxAsse1 Then
            QuotaMaxAsse1 = SiloS7PosizioneSilo(indice)
        End If
        
        If SiloS7PosizioneSilo(indice) < QuotaMinAsse1 Then
            QuotaMinAsse1 = SiloS7PosizioneSilo(indice)
        End If
        
        If Silo2S7PosizioneSilo(indice) > QuotaMaxAsse2 Then
            QuotaMaxAsse2 = Silo2S7PosizioneSilo(indice)
        End If
        
        If Silo2S7PosizioneSilo(indice) < QuotaMinAsse2 Then
            QuotaMinAsse2 = Silo2S7PosizioneSilo(indice)
        End If
        
    Next indice
                
    If QuotaMaxAsse2 = 0 And QuotaMinAsse2 = 0 Then
        'se ho solo la navetta
        'Navetta: asse X
        If InvertiQuoteXGraficoBennaS7 Then
            QuotaMaxGraficoSiloS7AsseX = Round(QuotaMinAsse1, 0)
            QuotaMinGraficoSiloS7AsseX = Round(QuotaMaxAsse1, 0)
        Else
            QuotaMaxGraficoSiloS7AsseX = Round(QuotaMaxAsse1, 0)
            QuotaMinGraficoSiloS7AsseX = Round(QuotaMinAsse1, 0)
        End If

        QuotaMaxGraficoSiloS7AsseY = 0
        QuotaMinGraficoSiloS7AsseY = 0
    Else
        'se ho navetta + carro ponte
        'Navetta: asse Y
        'Carro ponte: asse X
        If InvertiQuoteXGraficoBennaS7 Then
            QuotaMaxGraficoSiloS7AsseX = Round(QuotaMinAsse2, 0)
            QuotaMinGraficoSiloS7AsseX = Round(QuotaMaxAsse2, 0)
        Else
            QuotaMaxGraficoSiloS7AsseX = Round(QuotaMaxAsse2, 0)
            QuotaMinGraficoSiloS7AsseX = Round(QuotaMinAsse2, 0)
        End If
    
        If InvertiQuoteYGraficoBennaS7 Then
            QuotaMaxGraficoSiloS7AsseY = Round(QuotaMinAsse1, 0)
            QuotaMinGraficoSiloS7AsseY = Round(QuotaMaxAsse1, 0)
        Else
            QuotaMaxGraficoSiloS7AsseY = Round(QuotaMaxAsse1, 0)
            QuotaMinGraficoSiloS7AsseY = Round(QuotaMinAsse1, 0)
        End If
    End If

End Sub

Public Function Linearizza(valore As Double, K1min As Double, K2max As Double, LoLim As Double, HiLim As Double) As Double

    Dim DiffK As Double
    Dim DiffLim As Double

	On Error GoTo ERRORE

    DiffK = K1min - K2max
    
    DiffLim = LoLim - HiLim

    If DiffK = 0 Then
        Linearizza = 0
        Exit Function
    End If

    Linearizza = ((valore - K1min) / DiffK) * DiffLim + LoLim
    
    If Linearizza > HiLim Then
        Linearizza = HiLim
    ElseIf Linearizza < LoLim Then
        Linearizza = LoLim
    End If
        
    Exit Function

	ERRORE:

End Function


'20150420
Public Sub SiloS7WarnigEvent()
    
    CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE).Value = False
    CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE).Value = False
    CP240.OPCData.items(PLCTAG_DB310_ManuApre).Value = False
    CP240.OPCData.items(PLCTAG_DB310_ManuChiude).Value = False

    CP240.OPCData.items(PLCTAG_SILOGEN_DISCESAMANUALEASSE2).Value = False
    CP240.OPCData.items(PLCTAG_SILOGEN_SALITAMANUALEASSE2).Value = False
    CP240.OPCData.items(PLCTAG_SILO2_ManuApre).Value = False
    CP240.OPCData.items(PLCTAG_SILO2_ManuChiude).Value = False

End Sub

'20150420
Public Sub SetStatoSiloS7AutoMan()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
                
        SiloStatusLock = True
        
        If SiloStatus = Auto Then
            SiloStatus = Man
        ElseIf SiloStatus = Man Then
            SiloStatus = Auto
        ElseIf SiloStatus = Warning Then
            SiloStatus = Man
        End If

        Call AbilitaOggettiSiloS7(False)

    End If

End Sub

'20150420
Public Sub SetStatoSiloS7Jog()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        SiloStatusLock = True

        If SiloStatus = Jog Then
            SiloStatus = Warning
        Else
            SiloStatus = Jog
        End If
                           
        Call AbilitaOggettiSiloS7(False)
        
    End If
End Sub

'20150420
Public Sub SetStatoSiloS7Stop()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
                
        SiloStatusLock = True
        
        SiloStatus = Warning

        Call AbilitaOggettiSiloS7(False)
    
    End If

End Sub

'20150420
Public Sub SetSiloS7Start()

    If (ShowMsgBox(strSiNo, vbOKCancel, vbQuestion, -1, -1, True) = vbOK) Then
        CP240.OPCData.items(PLCTAG_SILOGEN_MEMSALITABENNA).Value = True
    End If

End Sub

'20150420
Public Sub SiloS7IconStatusUpdate()

    Select Case SiloStatus
        Case Auto
            Call IconaStatoManAutoErr(CP240.CmdAutoManSiloS7, automatico)
            CP240.Image1(10).Visible = False
        Case Man
            Call IconaStatoManAutoErr(CP240.CmdAutoManSiloS7, manuale)
            CP240.Image1(10).Visible = False
        Case Else
            CP240.Image1(10).Visible = Not CP240.Image1(10).Visible
            Call IconaStatoManAutoErr(CP240.CmdAutoManSiloS7, triangologiallo)
    End Select

    If FrmSiloGenerale.Visible Then
        Select Case SiloStatus
            Case Auto
                Call IconaStatoManAutoErr(FrmSiloGenerale.CmdAutoMan, automatico)
            Case Man
                Call IconaStatoManAutoErr(FrmSiloGenerale.CmdAutoMan, manuale)
            Case Else
                Call IconaStatoManAutoErr(FrmSiloGenerale.CmdAutoMan, triangologiallo)
        End Select
    End If

End Sub

'20150420
Public Sub AbilitaOggettiSiloS7(full As Boolean)

    If FrmSiloGenerale.Visible Or full Then
        With FrmSiloGenerale
            
            .CmdApriBenna.enabled = (SiloS7InPosition And (SiloStatus = Man) And DestinazioneSilo > 0)
            .CmdChiudiBenna.enabled = (SiloS7InPosition And (SiloStatus = Man) And DestinazioneSilo > 0)
            .CmdDX.enabled = ((SiloStatus = Man) And DestinazioneSilo > 0)
            .CmdSX.enabled = ((SiloStatus = Man) And DestinazioneSilo > 0)
            .CmdSU.enabled = ((SiloStatus = Man) And DestinazioneSilo > 0)
            .CmdGIU.enabled = ((SiloStatus = Man) And DestinazioneSilo > 0)
            .CmdStart.enabled = (SiloStatus = Auto)
            .CmdSyncroBennaAsse(0).enabled = (SiloStatus = Man)
            .CmdSyncroBennaAsse(1).enabled = (SiloStatus = Man)
        
            .CmdJogSX(0).enabled = (SiloStatus = Jog)
            .CmdJogDX(0).enabled = (SiloStatus = Jog)
            .CmdJogSX(1).enabled = (SiloStatus = Jog)
            .CmdJogDX(1).enabled = (SiloStatus = Jog)
            
            If (SiloStatus = Jog) Then
                .CmdEnableJog(0).Picture = LoadResPicture("IDB_MANUALE", vbResBitmap)
                .CmdEnableJog(1).Picture = LoadResPicture("IDB_MANUALE", vbResBitmap)
            Else
                .CmdEnableJog(0).Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
                .CmdEnableJog(1).Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
            End If
        
        End With
    End If

    CP240.CmdStartSiloS7.enabled = (SiloStatus = Auto)
    CP240.CmdSyncroBennaAsse(0).enabled = (SiloStatus = Man)
    CP240.CmdSyncroBennaAsse(1).enabled = (SiloStatus = Man)

    Select Case SiloStatus
        Case Auto
            If FrmSiloGenerale.Visible Or full Then
                FrmSiloGenerale.CmdAutoMan.Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
            End If
            CP240.CmdAutoManSiloS7.Picture = LoadResPicture("IDB_AUTOMATICO", vbResBitmap)
        Case Man
            If FrmSiloGenerale.Visible Or full Then
                FrmSiloGenerale.CmdAutoMan.Picture = LoadResPicture("IDB_MANUALE", vbResBitmap)
            End If
            CP240.CmdAutoManSiloS7.Picture = LoadResPicture("IDB_MANUALE", vbResBitmap)
        Case Else
            If FrmSiloGenerale.Visible Or full Then
                FrmSiloGenerale.CmdAutoMan.Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
            End If
            CP240.CmdAutoManSiloS7.Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
    End Select

End Sub


