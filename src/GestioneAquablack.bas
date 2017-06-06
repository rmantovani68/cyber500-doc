Attribute VB_Name = "GestioneAquablack"
'20160729
'   Gestione dell'Aquablack
'
'   2016 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'

Option Explicit

Public Enum PlcAquablackType
    'DB5
    AQUABTAG_AN_H2OPressure_AnalogIN_MAX
    AQUABTAG_AN_H2OPressure_AnalogIN_MIN
    AQUABTAG_AN_H2OPressure_OUT_MAX
    AQUABTAG_AN_H2OPressure_OUT_MIN
    AQUABTAG_AN_H2OFlow_AnalogIN_MAX
    AQUABTAG_AN_H2OFlow_AnalogIN_MIN
    AQUABTAG_AN_H2OFlow_OUT_MAX
    AQUABTAG_AN_H2OFlow_OUT_MIN
    AQUABTAG_AN_H2OINSpeed_AnalogIN_MAX
    AQUABTAG_AN_H2OINSpeed_AnalogIN_MIN
    AQUABTAG_AN_H2OINSpeed_OUT_MAX
    AQUABTAG_AN_H2OINSpeed_OUT_MIN
    AQUABTAG_AN_H2OOUTSpeed_AnalogIN_MAX
    AQUABTAG_AN_H2OOUTSpeed_AnalogIN_MIN
    AQUABTAG_AN_H2OOUTSpeed_OUT_MAX
    AQUABTAG_AN_H2OOUTSpeed_OUT_MIN
    AQUABTAG_AN_BitSpeedPum_AnalogIN_MAX
    AQUABTAG_AN_BitSpeedPum_AnalogIN_MIN
    AQUABTAG_AN_BitSpeedPum_OUT_MAX
    AQUABTAG_AN_BitSpeedPum_OUT_MIN
    AQUABTAG_AN_BitTemp_AnalogIN_MAX
    AQUABTAG_AN_BitTemp_AnalogIN_MIN
    AQUABTAG_AN_BitTemp_OUT_MAX
    AQUABTAG_AN_BitTemp_OUT_MIN
    AQUABTAG_AN_BitMassFlow_AnalogIN_MAX
    AQUABTAG_AN_BitMassFlow_AnalogIN_MIN
    AQUABTAG_AN_BitMassFlow_OUT_MAX
    AQUABTAG_AN_BitMassFlow_OUT_MIN
    AQUABTAG_AN_BitWeight_AnalogIN_MAX
    AQUABTAG_AN_BitWeight_AnalogIN_MIN
    AQUABTAG_AN_BitWeight_OUT_MAX
    AQUABTAG_AN_BitWeight_OUT_MIN
    AQUABTAG_AN_BitTare_AnalogIN_MAX
    AQUABTAG_AN_BitTare_AnalogIN_MIN
    AQUABTAG_AN_BitTare_OUT_MAX
    AQUABTAG_AN_BitTare_OUT_MIN
    AQUABTAG_AN_H2OFlowTransientCompens
    AQUABTAG_MAX_H2OValvDelayOnCloseBi
    AQUABTAG_MAX_H2OValvDelayOnOpenBi
    AQUABTAG_MAX_AlarmHighPressureH2O
    AQUABTAG_MAX_DelayAlarHighPressureH2
    AQUABTAG_MAX_PercentualCloseH20
    AQUABTAG_MAX_MinH2OFlowAlarmDela
    AQUABTAG_MAX_MinH2OFlow
    AQUABTAG_MAX_BitFlowOnH2OCloseDelay
    AQUABTAG_MAX_AlarmLowPressureH2O
    AQUABTAG_MAX_DelayAlarLowPressureH2
    AQUABTAG_PUR_TimePurgeSecStep1
    AQUABTAG_PUR_TimePurgeSecStep2
    AQUABTAG_TRI_DelayOnStartTrickle
    AQUABTAG_TRI_DelayOnStopTrickle
    AQUABTAG_PT_SelectBitFlowInputSource
    AQUABTAG_PT_Batch_Type
    AQUABTAG_PT_Batch_Gravity
    AQUABTAG_PT_ContinuousAcqTime
    AQUABTAG_BIT_BitumenType
    AQUABTAG_BIT_BitumenTempMinAlarm_1
    AQUABTAG_BIT_BitumenTempMinAlarm_2
    AQUABTAG_BIT_BitumenTempMinAlarm_3
    AQUABTAG_BIT_BitumenTempMinAlarm_4
    AQUABTAG_BIT_BitumenTempMaxAlarm_1
    AQUABTAG_BIT_BitumenTempMaxAlarm_2
    AQUABTAG_BIT_BitumenTempMaxAlarm_3
    AQUABTAG_BIT_BitumenTempMaxAlarm_4
    AQUABTAG_BIT_LT_PulseLiter
    AQUABTAG_BIT_LT_Density
    AQUABTAG_BIT_LT_TimeBase
    AQUABTAG_BIT_BS_NumberSamples
    AQUABTAG_BIT_BS_TimeBase
    AQUABTAG_BIT_PS_NumberOfPoint
    AQUABTAG_BIT_PS_PointsX_1
    AQUABTAG_BIT_PS_PointsX_2
    AQUABTAG_BIT_PS_PointsX_3
    AQUABTAG_BIT_PS_PointsX_4
    AQUABTAG_BIT_PS_PointsX_5
    AQUABTAG_BIT_PS_PointsY_1
    AQUABTAG_BIT_PS_PointsY_2
    AQUABTAG_BIT_PS_PointsY_3
    AQUABTAG_BIT_PS_PointsY_4
    AQUABTAG_BIT_PS_PointsY_5
    AQUABTAG_BIT_STAB_START
    AQUABTAG_BIT_STAB_STOP
    AQUABTAG_BIT_Fixed_Bitumen_Tare
    AQUABTAG_BIT_Init_Flow_Hold_Delay
    AQUABTAG_H20POND_Ponderal_Volumetric
    AQUABTAG_H20POND_G
    AQUABTAG_H20POND_TI
    AQUABTAG_H20POND_TD
    AQUABTAG_H20POND_DeadBand
    AQUABTAG_H20POND_Tc
    AQUABTAG_H20POND_MaxLimitOutput
    AQUABTAG_H20POND_MinLimitOutput
    AQUABTAG_H20POND_InitialTI
    AQUABTAG_H20POND_EnableP
    AQUABTAG_H20POND_EnableI
    AQUABTAG_H20POND_EnableD
    AQUABTAG_H20POND_EnableTheoriticalLimit
    AQUABTAG_H20PUMP_TheoreticalZone
    AQUABTAG_H20PUMP_H20SpeedPumpOnRecycle
    AQUABTAG_H20PUMP_H2OMaxSpeed
    AQUABTAG_H20PUMP_StartTimeout
    AQUABTAG_H20PUMP_StopTimeout
    AQUABTAG_H20PUMP_NumberOfPoint
    AQUABTAG_H20PUMP_PointsX_1
    AQUABTAG_H20PUMP_PointsX_2
    AQUABTAG_H20PUMP_PointsX_3
    AQUABTAG_H20PUMP_PointsX_4
    AQUABTAG_H20PUMP_PointsX_5
    AQUABTAG_H20PUMP_PointsY_1
    AQUABTAG_H20PUMP_PointsY_2
    AQUABTAG_H20PUMP_PointsY_3
    AQUABTAG_H20PUMP_PointsY_4
    AQUABTAG_H20PUMP_PointsY_5
    AQUABTAG_VALVE_H2O_TimeOut_Open
    AQUABTAG_VALVE_H2O_TimeOut_Close
    AQUABTAG_VALVE_H2O_Trigger
    AQUABTAG_VALVE_H2O_Simulate
    AQUABTAG_VALVE_H2O_Inverted
    AQUABTAG_VALVE_H2O_3Ways
    AQUABTAG_VALVE_PURGE_TimeOut_Open
    AQUABTAG_VALVE_PURGE_TimeOut_Close
    AQUABTAG_VALVE_PURGE_Trigger
    AQUABTAG_VALVE_PURGE_Simulate
    AQUABTAG_VALVE_PURGE_Inverted
    AQUABTAG_VALVE_TRICKLE_TimeOut_Open
    AQUABTAG_VALVE_TRICKLE_TimeOut_Close
    AQUABTAG_VALVE_TRICKLE_Trigger
    AQUABTAG_VALVE_TRICKLE_Simulate
    AQUABTAG_VALVE_TRICKLE_Inverted
    AQUABTAG_OPT_ManageH2OAndCycleRecipe
    AQUABTAG_CUS_CloseTrickleDuringPurge
    AQUABTAG_CUS_AutoPurgeOnStopCycle
    AQUABTAG_AL_DELAY_TOLERANCE_ALARM
    AQUABTAG_OPT_S7_Connection_Enable
    AQUABTAG_OPT_S7_CYB500_Control
    'DB100
    AQUABTAG_AI_H2O_Pressure
    AQUABTAG_AI_H2O_Flow
    AQUABTAG_AI_Bit_Flow
    AQUABTAG_AI_Bit_Temperature
    AQUABTAG_AI_Bit_Inverter_Pump_Speed
    AQUABTAG_AI_H2O_Inverter_Pump_Speed
    AQUABTAG_AI_Bit_Weight
    AQUABTAG_AI_Bit_Tare
    AQUABTAG_AO_H2O_Inverter_Pump_Speed
    AQUABTAG_DI_H2O_Minimum_Level_Tank
    AQUABTAG_DI_H2O_Pump_Return
    AQUABTAG_DI_H2O_Pump_TripOverload
    AQUABTAG_DI_Bit_InSpraying
    AQUABTAG_DI_Bit_DosingEnd
    AQUABTAG_DI_Bit_FlowMeter
    AQUABTAG_DI_Agg_DoorOpened
    AQUABTAG_DI_Bit_Pump_Return
    AQUABTAG_DI_EnableAquaBlackFromOut
    AQUABTAG_DO_H2O_OpenValve
    AQUABTAG_DO_H2O_StartPump
    AQUABTAG_DO_Air_OpenPurge
    AQUABTAG_DO_Air_CloseTrickleValv
    AQUABTAG_DO_Air_CloseBleedValv
    AQUABTAG_DO_Auto_Dosing_Start
    'DB200
    AQUABTAG_ALARM_H2O_PUMP_Start_Timeout
    AQUABTAG_ALARM_H2O_PUMP_FeedBack_Error
    AQUABTAG_ALARM_H2O_PUMP_Overload_Tripped
    AQUABTAG_ALARM_H2O_PUMP_Stop_Timeout
    AQUABTAG_ALARM_H2O_VALVE_BothClose
    AQUABTAG_ALARM_H2O_VALVE_BothOpen
    AQUABTAG_ALARM_H2O_VALVE_Open_Timeout
    AQUABTAG_ALARM_H2O_VALVE_Close_Timeout
    AQUABTAG_ALARM_H2O_VALVE_Incongrous_FeedBack
    AQUABTAG_ALARM_PURGE_VALVE_BothClose
    AQUABTAG_ALARM_PURGE_VALVE_BothOpen
    AQUABTAG_ALARM_PURGE_VALVE_Open_Timeout
    AQUABTAG_ALARM_PURGE_VALVE_Close_Timeout
    AQUABTAG_ALARM_PURGE_VALVE_Incongrous_FeedBack
    AQUABTAG_ALARM_TRICKLE_VALVE_BothClose
    AQUABTAG_ALARM_TRICKLE_VALVE_BothOpen
    AQUABTAG_ALARM_TRICKLE_VALVE_Open_Timeout
    AQUABTAG_ALARM_TRICKLE_VALVE_Close_Timeout
    AQUABTAG_ALARM_TRICKLE_VALVE_Incongrous_FeedBack
    AQUABTAG_ALARM_BITUMEN_TEMPERATURE
    AQUABTAG_ALARM_H2O_MINIMUM_LEVEL_TANK
    AQUABTAG_ALARM_H2O_FLOW_ERROR
    AQUABTAG_ALARM_BITUMEN_INVALID_TYPE
    AQUABTAG_ALARM_BITUMEN_PULSE_FLOW_CONVERSION_ERROR
    AQUABTAG_ALARM_H2O_MINIMUM_PRESSURE
    AQUABTAG_ALARM_H2O_MAX_PRESSURE
    AQUABTAG_ALARM_TOLERANCE_ERROR
    AQUABTAG_ALARM_S7_TIMEOUT
    'DB210
    AQUABTAG_H2OValve_FeedBack
    'DB211
    AQUABTAG_PURGEValve_FeedBack
    'DB212
    AQUABTAG_TRICKLEValve_FeedBack
    'DB300
    AQUABTAG_FromPLC_H2O_Partial
    AQUABTAG_FromPLC_H2O_Partial_Recipe
    AQUABTAG_FromPLC_H2O_Total
    AQUABTAG_FromPLC_H2O_Flow
    AQUABTAG_FromPLC_H2O_Pressure
    AQUABTAG_FromPLC_BIT_Partial
    AQUABTAG_FromPLC_BIT_Partial_Recipe
    AQUABTAG_FromPLC_BIT_Total
    AQUABTAG_FromPLC_BIT_FlowCalculated
    AQUABTAG_FromPLC_BIT_Weight
    AQUABTAG_FromPLC_BIT_FlowMediumCalculated
    AQUABTAG_FromPLC_BIT_TimeSpraying
    AQUABTAG_FromPLC_Cycle_TotalCycle
    AQUABTAG_FromPLC_Cycle_RecipeCycle
    AQUABTAG_FromPLC_ChangeAtFlight
    AQUABTAG_FromPLC_StartFromExternal
    AQUABTAG_FromPLC_BIT_Recipe_Min_Temp
    AQUABTAG_FromPLC_BIT_Recipe_Max_Temp
    AQUABTAG_FromPLC_Istantaneous_H2OPartial
    AQUABTAG_FromPLC_Istantaneous_H2OPartial_Recipe
    AQUABTAG_FromPLC_Istantaneous_H2OTotal
    AQUABTAG_FromPLC_Istantaneous_BIT
    AQUABTAG_FromPLC_Istantaneous_CYCLE_Recipe
    AQUABTAG_BitumenTemperature
    AQUABTAG_H2OActualPumpSpeed
    AQUABTAG_IstantaneousTotalH2O_Ton
    AQUABTAG_TotalCycle_real
    AQUABTAG_H2O_Press_Peak
    AQUABTAG_H2O_Theor_Flow
    AQUABTAG_FROM_HMI_Ack
    AQUABTAG_FROM_HMI_Factory_Reset
    AQUABTAG_FROM_HMI_Start_Purge
    AQUABTAG_FROM_HMI_Start_Trickle
    AQUABTAG_FROM_HMI_Start_H2O_Valv
    AQUABTAG_FROM_HMI_Start_H2O_Pump
    AQUABTAG_FROM_HMI_Manual
    AQUABTAG_FROM_HMI_Start
    AQUABTAG_FROM_HMI_Stop
    AQUABTAG_FROM_HMI_Abort
    AQUABTAG_FROM_HMI_ManualSpeedH2OPump
    AQUABTAG_SW_VERSION_PLC_Major
    AQUABTAG_SW_VERSION_PLC_Minor
    AQUABTAG_SW_VERSION_PLC_Revision
    AQUABTAG_SW_VERSION_PLC_Fix
    'DB1000
    AQUABTAG_REC_ACT_ChangeAtFlight
    AQUABTAG_REC_ACT_PERCENTAGE_H2O
    AQUABTAG_REC_ACT_BITUMEN_SELECTION
    AQUABTAG_REC_ACT_BIT_MIN_FLOW
    AQUABTAG_REC_ACT_TOLERANCE_H2O
    AQUABTAG_REC_ACT_BITUMEN_DISCH_2_STEPS
    'DB1001
    AQUABTAG_REC_NXT_ChangeAtFlight
    AQUABTAG_REC_NXT_PERCENTAGE_H2O
    AQUABTAG_REC_NXT_BITUMEN_SELECTION
    AQUABTAG_REC_NXT_BIT_MIN_FLOW
    AQUABTAG_REC_NXT_TOLERANCE_H2O
    AQUABTAG_REC_NXT_BITUMEN_DISCH_2_STEPS
    'DB1500
    AQUABTAG_AUTO_DOSING_STATUS
    AQUABTAG_MANUAL_MODE_STATUS
    'FINE TAG
    PLCTAGAQUABLACK_COUNT
End Enum

Public Type Aquablack_Recipe
    ChangeAtFlight As Boolean
    PercentageH2O As Double
    BitumenSelection As Integer
    BitumenMinFlow As Double
    ToleranceH2O As Double
    BitumenDisch2Steps As Boolean
End Type

Public Type Aquablack_Digital_Type
    H2OValve_FeedBack As Boolean
    PURGEValve_FeedBack As Boolean
    TRICKLEValve_FeedBack As Boolean
    DI_H2O_Minimum_Level_Tank As Boolean
    DI_H2O_Pump_Return As Boolean
    DI_H2O_Pump_TripOverload As Boolean
    DI_Bit_InSpraying As Boolean
    AquablackStatoManuale As Boolean
    AquablackDosaggioAttivo As Boolean
End Type


Public Type Aquablack_HMI_PLC_Type
    FromPLC_H2O_Partial As Double
    FromPLC_H2O_Partial_Recipe  As Double
    FromPLC_H2O_Total   As Double
    FromPLC_H2O_Flow    As Double
    FromPLC_H2O_Pressure    As Double
    FromPLC_BIT_Partial As Double
    FromPLC_BIT_Partial_Recipe  As Double
    FromPLC_BIT_Total   As Double
    FromPLC_BIT_FlowCalculated  As Double
    FromPLC_BIT_Weight  As Double
    FromPLC_BIT_FlowMediumCalculated    As Double
    FromPLC_BIT_TimeSpraying    As Double
    FromPLC_Cycle_TotalCycle    As Integer
    FromPLC_Cycle_RecipeCycle   As Integer
    FromPLC_ChangeAtFlight  As Boolean
    FromPLC_StartFromExternal   As Boolean
    FromPLC_BIT_Recipe_Min_Temp As Boolean
    FromPLC_BIT_Recipe_Max_Temp As Boolean
    FromPLC_Istantaneous_H2OPartial As Double
    FromPLC_Istantaneous_H2OPartial_Recipe  As Double
    FromPLC_Istantaneous_H2OTotal   As Double
    FromPLC_Istantaneous_BIT    As Double
    FromPLC_Istantaneous_CYCLE_Recipe   As Integer
    BitumenTemperature  As Double
    H2OActualPumpSpeed  As Double
    IstantaneousTotalH2O_Ton    As Double
    TotalCycle_Double   As Double
    H2O_Press_Peak  As Double
    H2O_Theor_Flow  As Double
    FROM_HMI_Ack    As Boolean
    FROM_HMI_Factory_Reset  As Boolean
    FROM_HMI_Start_Purge    As Boolean
    FROM_HMI_Start_Trickle  As Boolean
    FROM_HMI_Start_H2O_Valv As Boolean
    FROM_HMI_Start_H2O_Pump As Boolean
    FROM_HMI_Manual As Boolean
    FROM_HMI_Start  As Boolean
    FROM_HMI_Stop   As Boolean
    FROM_HMI_Abort  As Boolean
    FROM_HMI_ManualSpeedH2OPump As Double
    SW_VERSION_PLC_Major    As Integer
    SW_VERSION_PLC_Minor    As Integer
    SW_VERSION_PLC_Revision As Integer
    SW_VERSION_PLC_Fix  As Integer
End Type

Public Type AquablackAlarmType
    H2O_PUMP_Start_Timeout  As Boolean
    H2O_PUMP_FeedBack_Error As Boolean
    H2O_PUMP_Overload_Tripped   As Boolean
    H2O_PUMP_Stop_Timeout   As Boolean
    H2O_VALVE_BothClose As Boolean
    H2O_VALVE_BothOpen  As Boolean
    H2O_VALVE_Open_Timeout  As Boolean
    H2O_VALVE_Close_Timeout As Boolean
    H2O_VALVE_Incongrous_FeedBack   As Boolean
    PURGE_VALVE_BothClose   As Boolean
    PURGE_VALVE_BothOpen    As Boolean
    PURGE_VALVE_Open_Timeout    As Boolean
    PURGE_VALVE_Close_Timeout   As Boolean
    PURGE_VALVE_Incongrous_FeedBack As Boolean
    TRICKLE_VALVE_BothClose As Boolean
    TRICKLE_VALVE_BothOpen  As Boolean
    TRICKLE_VALVE_Open_Timeout  As Boolean
    TRICKLE_VALVE_Close_Timeout As Boolean
    TRICKLE_VALVE_Incongrous_FeedBack   As Boolean
    BITUMEN_TEMPERATURE As Boolean
    H2O_MINIMUM_LEVEL_TANK   As Boolean
    H2O_FLOW_ERROR  As Boolean
    BITUMEN_INVALID_TYPE    As Boolean
    BITUMEN_PULSE_FLOW_CONVERSION_ERROR As Boolean
    H2O_MINIMUM_PRESSURE As Boolean
    H2O_MAX_PRESSURE    As Boolean
    TOLERANCE_ERROR As Boolean
    S7_TIMEOUT  As Boolean
End Type

'20160915
Public Type AquablackParametersType
	'    PressioneH2O_Analog_Max As Long
	'    PressioneH2O_Analog_Min As Long
	'    PressioneH2O_Scaled_Max As Integer
	'    PressioneH2O_Scaled_Min As Integer
	'    FlussoH2O_Analog_Max As Integer
	'    FlussoH2O_Analog_Min As Integer
	'    FlussoH2O_Scaled_Max As Integer
	'    FlussoH2O_Scaled_Min As Integer
	'    Velocita_IN_PompaH2O_Analog_Max As Integer
	'    Velocita_IN_PompaH2O_Analog_Min As Integer
	'    Velocita_IN_PompaH2O_Scaled_Max As Integer
	'    Velocita_IN_PompaH2O_Scaled_Min As Integer
	'    Velocita_OUT_PompaH2O_Analog_Max As Integer
	'    Velocita_OUT_PompaH2O_Analaog_Min As Integer
	'    Velocita_OUT_PompaH2O_Scaled_Max As Integer
	'    Velocita_OUT_PompaH2O_Scaled_Min As Integer
	'    Velocita_PompaBitume_Analog_Max As Integer
	'    Velocita_PompaBitume_Analog_Min As Integer
	'    Velocita_PompaBitume_Scaled_Max As Integer
	'    Velocita_PompaBitume_Scaled_Min As Integer
	'    Temperatura_PompaBitume_Analog_Max As Integer
	'    Temperatura_PompaBitume_Analog_Min As Integer
	'    Temperatura_PompaBitume_Scaled_Max As Integer
	'    Temperatura_PompaBitume_Scaled_Min As Integer
	'    Massico_Bitume_Analog_Max As Integer
	'    Massico_Bitume_Analog_Min As Integer
	'    Massico_Bitume_Scaled_Max As Integer
	'    Massico_Bitume_Scaled_Min As Integer
	'    Peso_Bitume_Analog_Max As Integer
	'    Peso_Bitume_Analog_Min As Integer
	'    Peso_Bitume_Scaled_Max As Integer
	'    Peso_Bitume_Scaled_Min As Integer
	'    Tara_Bitume_Analog_Max As Integer
	'    Tara_Bitume_Analog_Min As Integer
	'    Tara_Bitume_Scaled_Max As Integer
	'    Tara_Bitume_Scaled_Min As Integer
	'    Compensazione_Transitorio_Flusso As Integer
	'    Tempo_Ap_Valv_Spruzz_Bit As Integer
	'    Tempo_ACh_Valv_Spruzz_Bit As Integer
	'    Allarme_Alta_Pressione As Integer
	'    Rit_Allarme_Alta_Pressione As Integer
	'    Percentuale_H2O_Bitume_Ch As Integer
	'    Rit_Allarme_Min_Flusso As Integer
	'    Allarme_Min_Flusso As Integer
	'    Flusso_Bit_Dur_Ritardo_Ch As Integer
	'    Allarme_Bassa_Pressione As Integer
	'    Rit_Allarme_Bassa_Pressione As Integer
	'    Tempo_Step1_Spurgo As Integer
	'    Tempo_Step2_Spurgo As Integer
	'    Tempo_Start_Trickle As Integer
	'    Tempo_Stop_Trickle As Integer
	'    Selezione_Sorgente As Integer
	'    Tipo_Impianto As Integer
	'    Gravita_Bitume As Boolean
	'    Tempo_Totalizzazione_Continui As Integer
	'    Tipo_Bitume As Integer
	'    Allarme_Min_Temp_Bit_1 As Integer
	'    Allarme_Min_Temp_Bit_2 As Integer
	'    Allarme_Min_Temp_Bit_3 As Integer
	'    Allarme_Min_Temp_Bit_4 As Integer
	'    Allarme_Max_Temp_Bit_1 As Integer
	'    Allarme_Max_Temp_Bit_2 As Integer
	'    Allarme_Max_Temp_Bit_3 As Integer
	'    Allarme_Max_Temp_Bit_4 As Integer
	'    Imp_Litro_Massico As Integer
	'    Densita_Massico As Double
	'    Risoluzione_OUT_Massico As Integer
	'    Campioni_Media_Bilancia As Integer
	'    Risoluzione_OUT_Bilancia As Integer
	'    Num_Punti_Appross_Vel_Flusso As Integer
	'    Num_Punti_Appross_Vel_Flusso_Vel1 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Vel2 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Vel3 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Vel4 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Vel5 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Flusso1 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Flusso2 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Flusso3 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Flusso4 As Integer
	'    Num_Punti_Appross_Vel_Flusso_Flusso5 As Integer
	'    Stabilizz_Aggregati As Integer
	'    Stabilizz_Bitume As Integer
	'    Tara_Valore_Fisso_Bitume As Integer
	'    Tempo_Mantenimento_Flusso_Prec As Integer
	'    Ponderale_H2O As Boolean
	'    Ponderale_G_H2O As Integer
	'    Ponderale_TI_H2O As Integer
	'    Ponderale_TD_H2O As Integer
	'    Ponderale_BW_H2O As Integer
	'    Ponderale_TCamp_H2O As Integer
	'    Ponderale_LimMax_H2O As Integer
	'    Ponderale_LimMin_H2O As Integer
	'    Ponderale_TI_Start_H2O As Integer
	'    Ponderale_EnableG_H2O As Boolean
	'    Ponderale_EnableTI_H2O As Boolean
	'    Ponderale_EnableTD_H2O As Boolean
	'    Ponderale_EnableFinestra_H2O As Boolean
	'    Ponderale_Finestra_H2O As Integer
	'    VelPompaH2O_Ricircolo As Integer
	'    PompaH2O_Max_Perc As Integer
	'    PompaH2O_TStart As Integer
	'    PompaH2O_TStop As Integer
	'    Num_Punti_Appross_Flusso_Vel As Integer
	'    Num_Punti_Appross_Flusso_Vel_Flusso1 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Flusso2 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Flusso3 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Flusso4 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Flusso5 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Vel1 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Vel2 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Vel3 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Vel4 As Integer
	'    Num_Punti_Appross_Flusso_Vel_Vel5 As Integer
	'    ValvolaH2O_Tmout_Ap As Integer
	'    ValvolaH2O_Tmout_Ch As Integer
	'    ValvolaH2O_Tmout_Trigger As Integer
	'    ValvolaH2O_Tmout_Simulata As Integer
	'    ValvolaH2O_Tmout_Invertita As Integer
	'    ValvolaH2O_Tmout_TreVie As Integer
	'    ValvolaPurge_Tmout_Ap As Integer
	'    ValvolaPurge_Tmout_Ch As Integer
	'    ValvolaPurge_Tmout_Trigger As Integer
	'    ValvolaPurge_Tmout_Simulata As Boolean
	'    ValvolaTrickle_Tmout_Ap As Integer
	'    ValvolaPurge_Tmout_Invertita As Boolean
	'    ValvolaTrickle_Tmout_Ch As Integer
	'    ValvolaTrickle_Tmout_Trigger As Integer
	'    ValvolaTrickle_Tmout_Simulata As Boolean
	'    ValvolaTrickle_Tmout_Invertita As Boolean
	'    GestioneH2O_e_Totalizzatore As Boolean
	'    Abilitazione_Ch_Trickle_Dur_Spurgo As Boolean
	'    Abilitazione_Spurgo_Sullo_Stop As Boolean
	'    Ritardo_Allarme_Tolleranza_Continuo As Integer
	'    Connessione_S7 As Boolean
	'    Controllo_Cyb500 As Boolean

    PressioneH2O_Analog_Max As Double
    PressioneH2O_Analog_Min As Double
    PressioneH2O_Scaled_Max As Double
    PressioneH2O_Scaled_Min As Double
    FlussoH2O_Analog_Max As Double
    FlussoH2O_Analog_Min As Double
    FlussoH2O_Scaled_Max As Double
    FlussoH2O_Scaled_Min As Double
    Velocita_IN_PompaH2O_Analog_Max As Double
    Velocita_IN_PompaH2O_Analog_Min As Double
    Velocita_IN_PompaH2O_Scaled_Max As Double
    Velocita_IN_PompaH2O_Scaled_Min As Double
    Velocita_OUT_PompaH2O_Analog_Max As Double
    Velocita_OUT_PompaH2O_Analaog_Min As Double
    Velocita_OUT_PompaH2O_Scaled_Max As Double
    Velocita_OUT_PompaH2O_Scaled_Min As Double
    Velocita_PompaBitume_Analog_Max As Double
    Velocita_PompaBitume_Analog_Min As Double
    Velocita_PompaBitume_Scaled_Max As Double
    Velocita_PompaBitume_Scaled_Min As Double
    Temperatura_PompaBitume_Analog_Max As Double
    Temperatura_PompaBitume_Analog_Min As Double
    Temperatura_PompaBitume_Scaled_Max As Double
    Temperatura_PompaBitume_Scaled_Min As Double
    Massico_Bitume_Analog_Max As Double
    Massico_Bitume_Analog_Min As Double
    Massico_Bitume_Scaled_Max As Double
    Massico_Bitume_Scaled_Min As Double
    Peso_Bitume_Analog_Max As Double
    Peso_Bitume_Analog_Min As Double
    Peso_Bitume_Scaled_Max As Double
    Peso_Bitume_Scaled_Min As Double
    Tara_Bitume_Analog_Max As Double
    Tara_Bitume_Analog_Min As Double
    Tara_Bitume_Scaled_Max As Double
    Tara_Bitume_Scaled_Min As Double
    Compensazione_Transitorio_Flusso As Double
    Tempo_Ap_Valv_Spruzz_Bit As Integer
    Tempo_ACh_Valv_Spruzz_Bit As Integer
    Allarme_Alta_Pressione As Double
    Rit_Allarme_Alta_Pressione As Integer
    Percentuale_H2O_Bitume_Ch As Double
    Rit_Allarme_Min_Flusso As Integer
    Allarme_Min_Flusso As Double
    Flusso_Bit_Dur_Ritardo_Ch As Double
    Allarme_Bassa_Pressione As Double
    Rit_Allarme_Bassa_Pressione As Integer
    Tempo_Step1_Spurgo As Integer
    Tempo_Step2_Spurgo As Integer
    Tempo_Start_Trickle As Integer
    Tempo_Stop_Trickle As Integer
    Selezione_Sorgente As Integer
    Tipo_Impianto As Double
    Gravita_Bitume As Boolean
    Tempo_Totalizzazione_Continui As Double
    Tipo_Bitume As Integer
    Allarme_Min_Temp_Bit_1 As Double
    Allarme_Min_Temp_Bit_2 As Double
    Allarme_Min_Temp_Bit_3 As Double
    Allarme_Min_Temp_Bit_4 As Double
    Allarme_Max_Temp_Bit_1 As Double
    Allarme_Max_Temp_Bit_2 As Double
    Allarme_Max_Temp_Bit_3 As Double
    Allarme_Max_Temp_Bit_4 As Double
    Imp_Litro_Massico As Double
    Densita_Massico As Double
    Risoluzione_OUT_Massico As Double
    Campioni_Media_Bilancia As Double
    Risoluzione_OUT_Bilancia As Double
    Num_Punti_Appross_Vel_Flusso As Integer
    Num_Punti_Appross_Vel_Flusso_Vel1 As Double
    Num_Punti_Appross_Vel_Flusso_Vel2 As Double
    Num_Punti_Appross_Vel_Flusso_Vel3 As Double
    Num_Punti_Appross_Vel_Flusso_Vel4 As Double
    Num_Punti_Appross_Vel_Flusso_Vel5 As Double
    Num_Punti_Appross_Vel_Flusso_Flusso1 As Double
    Num_Punti_Appross_Vel_Flusso_Flusso2 As Double
    Num_Punti_Appross_Vel_Flusso_Flusso3 As Double
    Num_Punti_Appross_Vel_Flusso_Flusso4 As Double
    Num_Punti_Appross_Vel_Flusso_Flusso5 As Double
    Stabilizz_Aggregati As Double
    Stabilizz_Bitume As Double
    Tara_Valore_Fisso_Bitume As Double
    Tempo_Mantenimento_Flusso_Prec As Double
    Ponderale_H2O As Boolean
    Ponderale_G_H2O As Double
    Ponderale_TI_H2O As Double
    Ponderale_TD_H2O As Double
    Ponderale_BW_H2O As Double
    Ponderale_TCamp_H2O As Double
    Ponderale_LimMax_H2O As Double
    Ponderale_LimMin_H2O As Double
    Ponderale_TI_Start_H2O As Double
    Ponderale_EnableG_H2O As Boolean
    Ponderale_EnableTI_H2O As Boolean
    Ponderale_EnableTD_H2O As Boolean
    Ponderale_EnableFinestra_H2O As Boolean
    Ponderale_Finestra_H2O As Double
    VelPompaH2O_Ricircolo As Double
    PompaH2O_Max_Perc As Double
    PompaH2O_TStart As Integer
    PompaH2O_TStop As Integer
    Num_Punti_Appross_Flusso_Vel As Integer
    Num_Punti_Appross_Flusso_Vel_Flusso1 As Double
    Num_Punti_Appross_Flusso_Vel_Flusso2 As Double
    Num_Punti_Appross_Flusso_Vel_Flusso3 As Double
    Num_Punti_Appross_Flusso_Vel_Flusso4 As Double
    Num_Punti_Appross_Flusso_Vel_Flusso5 As Double
    Num_Punti_Appross_Flusso_Vel_Vel1 As Double
    Num_Punti_Appross_Flusso_Vel_Vel2 As Double
    Num_Punti_Appross_Flusso_Vel_Vel3 As Double
    Num_Punti_Appross_Flusso_Vel_Vel4 As Double
    Num_Punti_Appross_Flusso_Vel_Vel5 As Double
    ValvolaH2O_Tmout_Ap As Double
    ValvolaH2O_Tmout_Ch As Double
    ValvolaH2O_Tmout_Trigger As Double
    ValvolaH2O_Tmout_Simulata As Boolean
    ValvolaH2O_Tmout_Invertita As Boolean
    ValvolaH2O_Tmout_TreVie As Boolean
    ValvolaPurge_Tmout_Ap As Double
    ValvolaPurge_Tmout_Ch As Double
    ValvolaPurge_Tmout_Trigger As Double
    ValvolaPurge_Tmout_Simulata As Boolean
    ValvolaTrickle_Tmout_Ap As Double
    ValvolaPurge_Tmout_Invertita As Boolean
    ValvolaTrickle_Tmout_Ch As Double
    ValvolaTrickle_Tmout_Trigger As Double
    ValvolaTrickle_Tmout_Simulata As Boolean
    ValvolaTrickle_Tmout_Invertita As Boolean
    GestioneH2O_e_Totalizzatore As Boolean
    Abilitazione_Ch_Trickle_Dur_Spurgo As Boolean
    Abilitazione_Spurgo_Sullo_Stop As Boolean
    Ritardo_Allarme_Tolleranza_Continuo As Boolean
    Connessione_S7 As Boolean
    Controllo_Cyb500 As Boolean
End Type
'

Public Enum AquablackTuboContenuto
    Aq_Tubo_Vuoto
    Aq_Tubo_H2O
    Aq_Tubo_Aria
    Aq_Tubo_Bitume
    Aq_Tubo_Schiumato
End Enum

Public Aquablack_HMI_PLC As Aquablack_HMI_PLC_Type
Public Aquablack_Digital As Aquablack_Digital_Type
Public AquablackRecipeActual As Aquablack_Recipe
Public AquablackRecipeNext As Aquablack_Recipe
Public AquablackAlarm As AquablackAlarmType
Private PlcInDigitali_Fatta As Boolean
Private plcInAnalogici_Fatta As Boolean
'20160915
Public AquablackParameter As AquablackParametersType
'

Public tmrResetComandiAquablack As TemporizzatoreStandardType
Public DosaggioAquablackNoStart As String
Public DosaggioAquablack_ChangeAtFlight_DosInStop As Boolean    '20170203

'20160915
Public Sub PLCAquablack_InviaParametri()

    If (Not InclusioneAquablack) Then
        Exit Sub
    End If

    With CP240.OPCDataAquablack
                               
        If (.items.count = 0) Then
            Exit Sub
        End If

        .items(AQUABTAG_AN_H2OPressure_AnalogIN_MAX).Value = AquablackParameter.PressioneH2O_Analog_Max
        .items(AQUABTAG_AN_H2OPressure_AnalogIN_MIN).Value = AquablackParameter.PressioneH2O_Analog_Min
        .items(AQUABTAG_AN_H2OPressure_OUT_MAX).Value = AquablackParameter.PressioneH2O_Scaled_Max
        .items(AQUABTAG_AN_H2OPressure_OUT_MIN).Value = AquablackParameter.PressioneH2O_Scaled_Min
        .items(AQUABTAG_AN_H2OFlow_AnalogIN_MAX).Value = AquablackParameter.FlussoH2O_Analog_Max
        .items(AQUABTAG_AN_H2OFlow_AnalogIN_MIN).Value = AquablackParameter.FlussoH2O_Analog_Min
        .items(AQUABTAG_AN_H2OFlow_OUT_MAX).Value = AquablackParameter.FlussoH2O_Scaled_Max
        .items(AQUABTAG_AN_H2OFlow_OUT_MIN).Value = AquablackParameter.FlussoH2O_Scaled_Min
        .items(AQUABTAG_AN_H2OINSpeed_AnalogIN_MAX).Value = AquablackParameter.Velocita_IN_PompaH2O_Analog_Max
        .items(AQUABTAG_AN_H2OINSpeed_AnalogIN_MIN).Value = AquablackParameter.Velocita_IN_PompaH2O_Analog_Min
        .items(AQUABTAG_AN_H2OINSpeed_OUT_MAX).Value = AquablackParameter.Velocita_IN_PompaH2O_Scaled_Max
        .items(AQUABTAG_AN_H2OINSpeed_OUT_MIN).Value = AquablackParameter.Velocita_IN_PompaH2O_Scaled_Min
        .items(AQUABTAG_AN_H2OOUTSpeed_AnalogIN_MAX).Value = AquablackParameter.Velocita_OUT_PompaH2O_Analog_Max
        .items(AQUABTAG_AN_H2OOUTSpeed_AnalogIN_MIN).Value = AquablackParameter.Velocita_OUT_PompaH2O_Analaog_Min
        .items(AQUABTAG_AN_H2OOUTSpeed_OUT_MAX).Value = AquablackParameter.Velocita_OUT_PompaH2O_Scaled_Max
        .items(AQUABTAG_AN_H2OOUTSpeed_OUT_MIN).Value = AquablackParameter.Velocita_OUT_PompaH2O_Scaled_Min
        .items(AQUABTAG_AN_BitSpeedPum_AnalogIN_MAX).Value = AquablackParameter.Velocita_PompaBitume_Analog_Max
        .items(AQUABTAG_AN_BitSpeedPum_AnalogIN_MIN).Value = AquablackParameter.Velocita_PompaBitume_Analog_Min
        .items(AQUABTAG_AN_BitSpeedPum_OUT_MAX).Value = AquablackParameter.Velocita_PompaBitume_Scaled_Max
        .items(AQUABTAG_AN_BitSpeedPum_OUT_MIN).Value = AquablackParameter.Velocita_PompaBitume_Scaled_Min
        .items(AQUABTAG_AN_BitTemp_AnalogIN_MAX).Value = AquablackParameter.Temperatura_PompaBitume_Analog_Max
        .items(AQUABTAG_AN_BitTemp_AnalogIN_MIN).Value = AquablackParameter.Temperatura_PompaBitume_Analog_Min
        .items(AQUABTAG_AN_BitTemp_OUT_MAX).Value = AquablackParameter.Temperatura_PompaBitume_Scaled_Max
        .items(AQUABTAG_AN_BitTemp_OUT_MIN).Value = AquablackParameter.Temperatura_PompaBitume_Scaled_Min
        .items(AQUABTAG_AN_BitMassFlow_AnalogIN_MAX).Value = AquablackParameter.Massico_Bitume_Analog_Max
        .items(AQUABTAG_AN_BitMassFlow_AnalogIN_MIN).Value = AquablackParameter.Massico_Bitume_Analog_Min
        .items(AQUABTAG_AN_BitMassFlow_OUT_MAX).Value = AquablackParameter.Massico_Bitume_Scaled_Max
        .items(AQUABTAG_AN_BitMassFlow_OUT_MIN).Value = AquablackParameter.Massico_Bitume_Scaled_Min
        .items(AQUABTAG_AN_BitWeight_AnalogIN_MAX).Value = AquablackParameter.Peso_Bitume_Analog_Max
        .items(AQUABTAG_AN_BitWeight_AnalogIN_MIN).Value = AquablackParameter.Peso_Bitume_Analog_Min
        .items(AQUABTAG_AN_BitWeight_OUT_MAX).Value = AquablackParameter.Peso_Bitume_Scaled_Max
        .items(AQUABTAG_AN_BitWeight_OUT_MIN).Value = AquablackParameter.Peso_Bitume_Scaled_Min
        .items(AQUABTAG_AN_BitTare_AnalogIN_MAX).Value = AquablackParameter.Tara_Bitume_Analog_Max
        .items(AQUABTAG_AN_BitTare_AnalogIN_MIN).Value = AquablackParameter.Tara_Bitume_Analog_Min
        .items(AQUABTAG_AN_BitTare_OUT_MAX).Value = AquablackParameter.Tara_Bitume_Scaled_Max
        .items(AQUABTAG_AN_BitTare_OUT_MIN).Value = AquablackParameter.Tara_Bitume_Scaled_Min
        .items(AQUABTAG_AN_H2OFlowTransientCompens).Value = AquablackParameter.Compensazione_Transitorio_Flusso
        .items(AQUABTAG_MAX_H2OValvDelayOnCloseBi).Value = AquablackParameter.Tempo_Ap_Valv_Spruzz_Bit
        .items(AQUABTAG_MAX_H2OValvDelayOnOpenBi).Value = AquablackParameter.Tempo_ACh_Valv_Spruzz_Bit
        .items(AQUABTAG_MAX_AlarmHighPressureH2O).Value = AquablackParameter.Allarme_Alta_Pressione
        .items(AQUABTAG_MAX_DelayAlarHighPressureH2).Value = AquablackParameter.Rit_Allarme_Alta_Pressione
        .items(AQUABTAG_MAX_PercentualCloseH20).Value = AquablackParameter.Percentuale_H2O_Bitume_Ch
        .items(AQUABTAG_MAX_MinH2OFlowAlarmDela).Value = AquablackParameter.Rit_Allarme_Min_Flusso
        .items(AQUABTAG_MAX_MinH2OFlow).Value = AquablackParameter.Allarme_Min_Flusso
        .items(AQUABTAG_MAX_BitFlowOnH2OCloseDelay).Value = AquablackParameter.Flusso_Bit_Dur_Ritardo_Ch
        .items(AQUABTAG_MAX_AlarmLowPressureH2O).Value = AquablackParameter.Allarme_Bassa_Pressione
        .items(AQUABTAG_MAX_DelayAlarLowPressureH2).Value = AquablackParameter.Rit_Allarme_Bassa_Pressione
        .items(AQUABTAG_PUR_TimePurgeSecStep1).Value = AquablackParameter.Tempo_Step1_Spurgo
        .items(AQUABTAG_PUR_TimePurgeSecStep2).Value = AquablackParameter.Tempo_Step2_Spurgo
        .items(AQUABTAG_TRI_DelayOnStartTrickle).Value = AquablackParameter.Tempo_Start_Trickle
        .items(AQUABTAG_TRI_DelayOnStopTrickle).Value = AquablackParameter.Tempo_Stop_Trickle
        .items(AQUABTAG_PT_SelectBitFlowInputSource).Value = AquablackParameter.Selezione_Sorgente
        .items(AQUABTAG_PT_Batch_Type).Value = AquablackParameter.Tipo_Impianto
        .items(AQUABTAG_PT_Batch_Gravity).Value = AquablackParameter.Gravita_Bitume
        .items(AQUABTAG_PT_ContinuousAcqTime).Value = AquablackParameter.Tempo_Totalizzazione_Continui
        .items(AQUABTAG_BIT_BitumenType).Value = AquablackParameter.Tipo_Bitume
        .items(AQUABTAG_BIT_BitumenTempMinAlarm_1).Value = AquablackParameter.Allarme_Min_Temp_Bit_1
        .items(AQUABTAG_BIT_BitumenTempMinAlarm_2).Value = AquablackParameter.Allarme_Min_Temp_Bit_2
        .items(AQUABTAG_BIT_BitumenTempMinAlarm_3).Value = AquablackParameter.Allarme_Min_Temp_Bit_3
        .items(AQUABTAG_BIT_BitumenTempMinAlarm_4).Value = AquablackParameter.Allarme_Min_Temp_Bit_4
        .items(AQUABTAG_BIT_BitumenTempMaxAlarm_1).Value = AquablackParameter.Allarme_Max_Temp_Bit_1
        .items(AQUABTAG_BIT_BitumenTempMaxAlarm_2).Value = AquablackParameter.Allarme_Max_Temp_Bit_2
        .items(AQUABTAG_BIT_BitumenTempMaxAlarm_3).Value = AquablackParameter.Allarme_Max_Temp_Bit_3
        .items(AQUABTAG_BIT_BitumenTempMaxAlarm_4).Value = AquablackParameter.Allarme_Max_Temp_Bit_4
        .items(AQUABTAG_BIT_LT_PulseLiter).Value = AquablackParameter.Imp_Litro_Massico
        .items(AQUABTAG_BIT_LT_Density).Value = AquablackParameter.Densita_Massico
        .items(AQUABTAG_BIT_LT_TimeBase).Value = AquablackParameter.Risoluzione_OUT_Massico
        .items(AQUABTAG_BIT_BS_NumberSamples).Value = AquablackParameter.Campioni_Media_Bilancia
        .items(AQUABTAG_BIT_BS_TimeBase).Value = AquablackParameter.Risoluzione_OUT_Bilancia
        .items(AQUABTAG_BIT_PS_NumberOfPoint).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso
        .items(AQUABTAG_BIT_PS_PointsX_1).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel1
        .items(AQUABTAG_BIT_PS_PointsX_2).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel2
        .items(AQUABTAG_BIT_PS_PointsX_3).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel3
        .items(AQUABTAG_BIT_PS_PointsX_4).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel4
        .items(AQUABTAG_BIT_PS_PointsX_5).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel5
        .items(AQUABTAG_BIT_PS_PointsY_1).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso1
        .items(AQUABTAG_BIT_PS_PointsY_2).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso2
        .items(AQUABTAG_BIT_PS_PointsY_3).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso3
        .items(AQUABTAG_BIT_PS_PointsY_4).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso4
        .items(AQUABTAG_BIT_PS_PointsY_5).Value = AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso5
        .items(AQUABTAG_BIT_STAB_START).Value = AquablackParameter.Stabilizz_Aggregati
        .items(AQUABTAG_BIT_STAB_STOP).Value = AquablackParameter.Stabilizz_Bitume
        .items(AQUABTAG_BIT_Fixed_Bitumen_Tare).Value = AquablackParameter.Tara_Valore_Fisso_Bitume
        .items(AQUABTAG_BIT_Init_Flow_Hold_Delay).Value = AquablackParameter.Tempo_Mantenimento_Flusso_Prec
        .items(AQUABTAG_H20POND_Ponderal_Volumetric).Value = AquablackParameter.Ponderale_H2O
        .items(AQUABTAG_H20POND_G).Value = AquablackParameter.Ponderale_G_H2O
        .items(AQUABTAG_H20POND_TI).Value = AquablackParameter.Ponderale_TI_H2O
        .items(AQUABTAG_H20POND_TD).Value = AquablackParameter.Ponderale_TD_H2O
        .items(AQUABTAG_H20POND_DeadBand).Value = AquablackParameter.Ponderale_BW_H2O
        .items(AQUABTAG_H20POND_Tc).Value = AquablackParameter.Ponderale_TCamp_H2O
        .items(AQUABTAG_H20POND_MaxLimitOutput).Value = AquablackParameter.Ponderale_LimMax_H2O
        .items(AQUABTAG_H20POND_MinLimitOutput).Value = AquablackParameter.Ponderale_LimMin_H2O
        .items(AQUABTAG_H20POND_InitialTI).Value = AquablackParameter.Ponderale_TI_Start_H2O
        .items(AQUABTAG_H20POND_EnableP).Value = AquablackParameter.Ponderale_EnableG_H2O
        .items(AQUABTAG_H20POND_EnableI).Value = AquablackParameter.Ponderale_EnableTI_H2O
        .items(AQUABTAG_H20POND_EnableD).Value = AquablackParameter.Ponderale_EnableTD_H2O
        .items(AQUABTAG_H20POND_EnableTheoriticalLimit).Value = AquablackParameter.Ponderale_EnableFinestra_H2O
        .items(AQUABTAG_H20PUMP_TheoreticalZone).Value = AquablackParameter.Ponderale_Finestra_H2O
        .items(AQUABTAG_H20PUMP_H20SpeedPumpOnRecycle).Value = AquablackParameter.VelPompaH2O_Ricircolo
        .items(AQUABTAG_H20PUMP_H2OMaxSpeed).Value = AquablackParameter.PompaH2O_Max_Perc
        .items(AQUABTAG_H20PUMP_StartTimeout).Value = AquablackParameter.PompaH2O_TStart
        .items(AQUABTAG_H20PUMP_StopTimeout).Value = AquablackParameter.PompaH2O_TStop
        .items(AQUABTAG_H20PUMP_NumberOfPoint).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel
        .items(AQUABTAG_H20PUMP_PointsX_1).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso1
        .items(AQUABTAG_H20PUMP_PointsX_2).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso2
        .items(AQUABTAG_H20PUMP_PointsX_3).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso3
        .items(AQUABTAG_H20PUMP_PointsX_4).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso4
        .items(AQUABTAG_H20PUMP_PointsX_5).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso5
        .items(AQUABTAG_H20PUMP_PointsY_1).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel1
        .items(AQUABTAG_H20PUMP_PointsY_2).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel2
        .items(AQUABTAG_H20PUMP_PointsY_3).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel3
        .items(AQUABTAG_H20PUMP_PointsY_4).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel4
        .items(AQUABTAG_H20PUMP_PointsY_5).Value = AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel5
        .items(AQUABTAG_VALVE_H2O_TimeOut_Open).Value = AquablackParameter.ValvolaH2O_Tmout_Ap
        .items(AQUABTAG_VALVE_H2O_TimeOut_Close).Value = AquablackParameter.ValvolaH2O_Tmout_Ch
        .items(AQUABTAG_VALVE_H2O_Trigger).Value = AquablackParameter.ValvolaH2O_Tmout_Trigger
        .items(AQUABTAG_VALVE_H2O_Simulate).Value = AquablackParameter.ValvolaH2O_Tmout_Simulata
        .items(AQUABTAG_VALVE_H2O_Inverted).Value = AquablackParameter.ValvolaH2O_Tmout_Invertita
        .items(AQUABTAG_VALVE_H2O_3Ways).Value = AquablackParameter.ValvolaH2O_Tmout_TreVie
        .items(AQUABTAG_VALVE_PURGE_TimeOut_Open).Value = AquablackParameter.ValvolaPurge_Tmout_Ap
        .items(AQUABTAG_VALVE_PURGE_TimeOut_Close).Value = AquablackParameter.ValvolaPurge_Tmout_Ch
        .items(AQUABTAG_VALVE_PURGE_Trigger).Value = AquablackParameter.ValvolaPurge_Tmout_Trigger
        .items(AQUABTAG_VALVE_PURGE_Simulate).Value = AquablackParameter.ValvolaPurge_Tmout_Simulata
        .items(AQUABTAG_VALVE_PURGE_Inverted).Value = AquablackParameter.ValvolaTrickle_Tmout_Ap
        .items(AQUABTAG_VALVE_TRICKLE_TimeOut_Open).Value = AquablackParameter.ValvolaPurge_Tmout_Invertita
        .items(AQUABTAG_VALVE_TRICKLE_TimeOut_Close).Value = AquablackParameter.ValvolaTrickle_Tmout_Ch
        .items(AQUABTAG_VALVE_TRICKLE_Trigger).Value = AquablackParameter.ValvolaTrickle_Tmout_Trigger
        .items(AQUABTAG_VALVE_TRICKLE_Simulate).Value = AquablackParameter.ValvolaTrickle_Tmout_Simulata
        .items(AQUABTAG_VALVE_TRICKLE_Inverted).Value = AquablackParameter.ValvolaTrickle_Tmout_Invertita
        .items(AQUABTAG_OPT_ManageH2OAndCycleRecipe).Value = AquablackParameter.GestioneH2O_e_Totalizzatore
        .items(AQUABTAG_CUS_CloseTrickleDuringPurge).Value = AquablackParameter.Abilitazione_Ch_Trickle_Dur_Spurgo
        .items(AQUABTAG_CUS_AutoPurgeOnStopCycle).Value = AquablackParameter.Abilitazione_Spurgo_Sullo_Stop
        .items(AQUABTAG_AL_DELAY_TOLERANCE_ALARM).Value = AquablackParameter.Ritardo_Allarme_Tolleranza_Continuo
        .items(AQUABTAG_OPT_S7_Connection_Enable).Value = AquablackParameter.Connessione_S7
        .items(AQUABTAG_OPT_S7_CYB500_Control).Value = AquablackParameter.Controllo_Cyb500

    End With

End Sub
'

Public Sub PLCAquablack_LeggiTag()

    Dim valoreBool As Boolean
    Dim valoreInt As Integer
    Dim valoreLong As Long
    Dim valoreDouble As Double
    Dim analogModificato As Boolean
    Dim posizioneErrore As Integer

    With CP240.OPCDataAquablack
                               
        If (.items.count = 0) Then
            Exit Sub
        End If
                                                              
        'TAG analogici
                               
        valoreDouble = .items(AQUABTAG_FromPLC_H2O_Partial).Value
        If (DoubleModificato(Aquablack_HMI_PLC.FromPLC_H2O_Partial, valoreDouble, plcInAnalogici_Fatta)) Then
            If FormAquablack.Visible Then
                FormAquablack.lblNetKg.caption = Format(Aquablack_HMI_PLC.FromPLC_H2O_Partial, "0.0")
            End If
            CP240.LblAdd(11).caption = Format(Aquablack_HMI_PLC.FromPLC_H2O_Partial, "0.0")
        End If
                
'        valoreDouble = .Items(AQUABTAG_FromPLC_H2O_Partial_Recipe).value
'        If (DoubleModificato(Aquablack_HMI_PLC.FromPLC_H2O_Partial_Recipe, valoreDouble, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
'            'TODO
'        End If
                                                                                                                                                                                           
        valoreDouble = .items(AQUABTAG_FromPLC_H2O_Pressure).Value
        If (DoubleModificato(Aquablack_HMI_PLC.FromPLC_H2O_Pressure, valoreDouble, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
            FormAquablack.lblPressioneReal.caption = Format(valoreDouble, "0.0")
        End If
        
        valoreDouble = .items(AQUABTAG_H2O_Press_Peak).Value
        If (DoubleModificato(Aquablack_HMI_PLC.H2O_Press_Peak, valoreDouble, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
            FormAquablack.lblPressionePeak.caption = Format(valoreDouble, "0.0")
        End If
        
        valoreDouble = .items(AQUABTAG_FromPLC_H2O_Flow).Value
        If (DoubleModificato(Aquablack_HMI_PLC.FromPLC_H2O_Flow, valoreDouble, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
            FormAquablack.lblFlussoH2OReal.caption = Format(valoreDouble, "0.0")
        End If
                
        valoreDouble = .items(AQUABTAG_H2OActualPumpSpeed).Value
        If (DoubleModificato(Aquablack_HMI_PLC.H2OActualPumpSpeed, valoreDouble, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
            FormAquablack.lblActSpeedH2OPump.caption = Format(valoreDouble, "0.0")
        End If
                                                   
        '----------------------------- lettura dati ricetta attuale -----------------------------
        valoreDouble = .items(AQUABTAG_REC_ACT_PERCENTAGE_H2O).Value
        If (DoubleModificato(AquablackRecipeActual.PercentageH2O, valoreDouble, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
            FormAquablack.lblSetPerc.caption = Format(valoreDouble, "0.0")
        End If
                
        valoreInt = .items(AQUABTAG_REC_ACT_BITUMEN_SELECTION).Value
        If (IntegerModificato(AquablackRecipeActual.BitumenSelection, valoreInt, plcInAnalogici_Fatta)) And FormAquablack.Visible Then
            FormAquablack.lblTipoBitume.caption = Format(valoreInt, "0")
        End If
                
        AquablackRecipeActual.BitumenMinFlow = .items(AQUABTAG_REC_ACT_BIT_MIN_FLOW).Value
        AquablackRecipeActual.ToleranceH2O = .items(AQUABTAG_REC_ACT_TOLERANCE_H2O).Value
        AquablackRecipeActual.BitumenDisch2Steps = .items(AQUABTAG_REC_ACT_BITUMEN_DISCH_2_STEPS).Value
        '------------------------------------------------------------------------------------------
                                                                                      
                                                                                      
        '----------------------------- lettura release PLC '-----------------------------
        Aquablack_HMI_PLC.SW_VERSION_PLC_Major = .items(AQUABTAG_SW_VERSION_PLC_Major).Value
        Aquablack_HMI_PLC.SW_VERSION_PLC_Minor = .items(AQUABTAG_SW_VERSION_PLC_Minor).Value
        Aquablack_HMI_PLC.SW_VERSION_PLC_Revision = .items(AQUABTAG_SW_VERSION_PLC_Revision).Value
        Aquablack_HMI_PLC.SW_VERSION_PLC_Fix = .items(AQUABTAG_SW_VERSION_PLC_Fix).Value
        '--------------------------------------------------------------------------------
                                    
        'TAG digitali
                        
        valoreBool = .items(AQUABTAG_AUTO_DOSING_STATUS).Value
        If (BooleanModificato(Aquablack_Digital.AquablackDosaggioAttivo, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Auto_Mode_Change
        End If
                                                
        valoreBool = .items(AQUABTAG_MANUAL_MODE_STATUS).Value
        If (BooleanModificato(Aquablack_Digital.AquablackStatoManuale, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Manual_Mode_Change
            Call AQ_Auto_Mode_Change
        End If
                                
        valoreBool = .items(AQUABTAG_DI_Bit_InSpraying).Value
        If (BooleanModificato(Aquablack_Digital.DI_Bit_InSpraying, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Gestione_StatoTubi
            Call AQ_SchiumaturaAttiva_Change
        End If
                                
        valoreBool = .items(AQUABTAG_H2OValve_FeedBack).Value
        If (BooleanModificato(Aquablack_Digital.H2OValve_FeedBack, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Valvola_H2O_Change
            Call AQ_SchiumaturaAttiva_Change
        End If
        
        valoreBool = .items(AQUABTAG_PURGEValve_FeedBack).Value
        If (BooleanModificato(Aquablack_Digital.PURGEValve_FeedBack, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Valvola_Purge_Change
        End If
    
        valoreBool = .items(AQUABTAG_TRICKLEValve_FeedBack).Value
        If (BooleanModificato(Aquablack_Digital.TRICKLEValve_FeedBack, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Valvola_Trickle_Change
        End If
                                                             
        valoreBool = .items(AQUABTAG_DI_H2O_Pump_Return).Value
        If (BooleanModificato(Aquablack_Digital.DI_H2O_Pump_Return, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Pompa_H2O_Change
            Call AQ_SchiumaturaAttiva_Change
        End If
                                                             
        valoreBool = .items(AQUABTAG_DI_H2O_Minimum_Level_Tank).Value
        If (BooleanModificato(Aquablack_Digital.DI_H2O_Minimum_Level_Tank, valoreBool, PlcInDigitali_Fatta)) Then
            Call AQ_Gestione_StatoTubi
        End If
'        Aquablack_Digital.DI_H2O_Minimum_Level_Tank = .Items(AQUABTAG_DI_H2O_Minimum_Level_Tank).value
        Call AQ_Livello_Serbatoio_Change 'chamata continua per lampeggio
                                                                                                                          
        'Allarmi
        AquablackAlarm.H2O_PUMP_Start_Timeout = .items(AQUABTAG_ALARM_H2O_PUMP_Start_Timeout).Value
        AquablackAlarm.H2O_PUMP_FeedBack_Error = .items(AQUABTAG_ALARM_H2O_PUMP_FeedBack_Error).Value
        AquablackAlarm.H2O_PUMP_Overload_Tripped = .items(AQUABTAG_ALARM_H2O_PUMP_Overload_Tripped).Value
        AquablackAlarm.H2O_PUMP_Stop_Timeout = .items(AQUABTAG_ALARM_H2O_PUMP_Stop_Timeout).Value
        AquablackAlarm.H2O_VALVE_BothClose = .items(AQUABTAG_ALARM_H2O_VALVE_BothClose).Value
        AquablackAlarm.H2O_VALVE_BothOpen = .items(AQUABTAG_ALARM_H2O_VALVE_BothOpen).Value
        AquablackAlarm.H2O_VALVE_Open_Timeout = .items(AQUABTAG_ALARM_H2O_VALVE_Open_Timeout).Value
        AquablackAlarm.H2O_VALVE_Close_Timeout = .items(AQUABTAG_ALARM_H2O_VALVE_Close_Timeout).Value
        AquablackAlarm.H2O_VALVE_Incongrous_FeedBack = .items(AQUABTAG_ALARM_H2O_VALVE_Incongrous_FeedBack).Value
        AquablackAlarm.PURGE_VALVE_BothClose = .items(AQUABTAG_ALARM_PURGE_VALVE_BothClose).Value
        AquablackAlarm.PURGE_VALVE_BothOpen = .items(AQUABTAG_ALARM_PURGE_VALVE_BothOpen).Value
        AquablackAlarm.PURGE_VALVE_Open_Timeout = .items(AQUABTAG_ALARM_PURGE_VALVE_Open_Timeout).Value
        AquablackAlarm.PURGE_VALVE_Close_Timeout = .items(AQUABTAG_ALARM_PURGE_VALVE_Close_Timeout).Value
        AquablackAlarm.PURGE_VALVE_Incongrous_FeedBack = .items(AQUABTAG_ALARM_PURGE_VALVE_Incongrous_FeedBack).Value
        AquablackAlarm.TRICKLE_VALVE_BothClose = .items(AQUABTAG_ALARM_TRICKLE_VALVE_BothClose).Value
        AquablackAlarm.TRICKLE_VALVE_BothOpen = .items(AQUABTAG_ALARM_TRICKLE_VALVE_BothOpen).Value
        AquablackAlarm.TRICKLE_VALVE_Open_Timeout = .items(AQUABTAG_ALARM_TRICKLE_VALVE_Open_Timeout).Value
        AquablackAlarm.TRICKLE_VALVE_Close_Timeout = .items(AQUABTAG_ALARM_TRICKLE_VALVE_Close_Timeout).Value
        AquablackAlarm.TRICKLE_VALVE_Incongrous_FeedBack = .items(AQUABTAG_ALARM_TRICKLE_VALVE_Incongrous_FeedBack).Value
        AquablackAlarm.BITUMEN_TEMPERATURE = .items(AQUABTAG_ALARM_BITUMEN_TEMPERATURE).Value
        AquablackAlarm.H2O_MINIMUM_LEVEL_TANK = .items(AQUABTAG_ALARM_H2O_MINIMUM_LEVEL_TANK).Value
        AquablackAlarm.H2O_FLOW_ERROR = .items(AQUABTAG_ALARM_H2O_FLOW_ERROR).Value
        AquablackAlarm.BITUMEN_INVALID_TYPE = .items(AQUABTAG_ALARM_BITUMEN_INVALID_TYPE).Value
        AquablackAlarm.BITUMEN_PULSE_FLOW_CONVERSION_ERROR = .items(AQUABTAG_ALARM_BITUMEN_PULSE_FLOW_CONVERSION_ERROR).Value
        AquablackAlarm.H2O_MINIMUM_PRESSURE = .items(AQUABTAG_ALARM_H2O_MINIMUM_PRESSURE).Value
        AquablackAlarm.H2O_MAX_PRESSURE = .items(AQUABTAG_ALARM_H2O_MAX_PRESSURE).Value
        AquablackAlarm.TOLERANCE_ERROR = .items(AQUABTAG_ALARM_TOLERANCE_ERROR).Value
        AquablackAlarm.S7_TIMEOUT = .items(AQUABTAG_ALARM_S7_TIMEOUT).Value
                                                                              
                                                                              
'        Aquablack_HMI_PLC.FromPLC_H2O_Partial = .Items(AQUABTAG_FromPLC_H2O_Partial).value
'
'        Aquablack_HMI_PLC.FromPLC_H2O_Partial_Recipe = .Items(AQUABTAG_FromPLC_H2O_Partial_Recipe).value
'
'        Aquablack_HMI_PLC.FromPLC_H2O_Total = .Items(FromPLC_H2O_Total).value
'
'        Aquablack_HMI_PLC.FromPLC_H2O_Flow = .Items(FromPLC_H2O_Flow).value
'
'        Aquablack_HMI_PLC.FromPLC_H2O_Pressure = .Items(FromPLC_H2O_Pressure).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_Partial = .Items(FromPLC_BIT_Partial).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_Partial_Recipe = .Items(FromPLC_BIT_Partial_Recipe).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_Total = .Items(FromPLC_BIT_Total).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_FlowCalculated = .Items(FromPLC_BIT_FlowCalculated).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_Weight = .Items(FromPLC_BIT_Weight).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_FlowMediumCalculated = .Items(FromPLC_BIT_FlowMediumCalculated).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_TimeSpraying = .Items(FromPLC_BIT_TimeSpraying).value
'
'        Aquablack_HMI_PLC.FromPLC_Cycle_TotalCycle = .Items(FromPLC_Cycle_TotalCycle).value
'
'        Aquablack_HMI_PLC.FromPLC_Cycle_RecipeCycle = .Items(FromPLC_Cycle_RecipeCycle).value
'
'        Aquablack_HMI_PLC.FromPLC_ChangeAtFlight = .Items(FromPLC_ChangeAtFlight).value
'
'        Aquablack_HMI_PLC.FromPLC_StartFromExternal = .Items(FromPLC_StartFromExternal).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_Recipe_Min_Temp = .Items(FromPLC_BIT_Recipe_Min_Temp).value
'
'        Aquablack_HMI_PLC.FromPLC_BIT_Recipe_Max_Temp = .Items(FromPLC_BIT_Recipe_Max_Temp).value
'
'        Aquablack_HMI_PLC.FromPLC_Istantaneous_H2OPartial = .Items(FromPLC_Istantaneous_H2OPartial).value
'
'        Aquablack_HMI_PLC.FromPLC_Istantaneous_H2OPartial_Recipe = .Items(FromPLC_Istantaneous_H2OPartial_Recipe).value
'
'        Aquablack_HMI_PLC.FromPLC_Istantaneous_H2OTotal = .Items(FromPLC_Istantaneous_H2OTotal).value
'
'        Aquablack_HMI_PLC.FromPLC_Istantaneous_BIT = .Items(FromPLC_Istantaneous_BIT).value
'
'        Aquablack_HMI_PLC.FromPLC_Istantaneous_CYCLE_Recipe = .Items(FromPLC_Istantaneous_CYCLE_Recipe).value
'
'        Aquablack_HMI_PLC.BitumenTemperature = .Items(BitumenTemperature).value
'
'        Aquablack_HMI_PLC.H2OActualPumpSpeed = .Items(H2OActualPumpSpeed).value
'
'        Aquablack_HMI_PLC.IstantaneousTotalH2O_Ton = .Items(IstantaneousTotalH2O_Ton).value
'
'        Aquablack_HMI_PLC.TotalCycle_Double = .Items(TotalCycle_Double).value
'
'        Aquablack_HMI_PLC.H2O_Press_Peak = .Items(H2O_Press_Peak).value
'
'        Aquablack_HMI_PLC.H2O_Theor_Flow = .Items(H2O_Theor_Flow).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Ack = .Items(FROM_HMI_Ack).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Factory_Reset = .Items(FROM_HMI_Factory_Reset).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Start_Purge = .Items(FROM_HMI_Start_Purge).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Start_Trickle = .Items(FROM_HMI_Start_Trickle).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv = .Items(FROM_HMI_Start_H2O_Valv).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump = .Items(FROM_HMI_Start_H2O_Pump).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Manual = .Items(FROM_HMI_Manual).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Start = .Items(FROM_HMI_Start).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Stop = .Items(FROM_HMI_Stop).value
'
'        Aquablack_HMI_PLC.FROM_HMI_Abort = .Items(FROM_HMI_Abort).value
'
'        Aquablack_HMI_PLC.FROM_HMI_ManualSpeedH2OPump = .Items(FROM_HMI_ManualSpeedH2OPump).value
'
'        Aquablack_HMI_PLC.SW_VERSION_PLC_Major = .Items(SW_VERSION_PLC_Major).value
'
'        Aquablack_HMI_PLC.SW_VERSION_PLC_Minor = .Items(SW_VERSION_PLC_Minor).value
'
'        Aquablack_HMI_PLC.SW_VERSION_PLC_Revision = .Items(SW_VERSION_PLC_Revision).value
'
'        Aquablack_HMI_PLC.SW_VERSION_PLC_Fix = .Items(SW_VERSION_PLC_Fix).value
                       
'            If (DoubleModificato(BilanciaBitumeCNT.Peso, valoreDouble, plcInAnalogici_Fatta)) Then
'                Call BilBitumeCNT_change
'            End If
                    
    PlcInDigitali_Fatta = True
          
    End With

End Sub

Public Sub PLCAquablack_ScriviTag()

    Dim valoreBool As Boolean
    Dim valoreInt As Integer
    Dim valoreLong As Long
    Dim valoreDouble As Double
    Dim analogModificato As Boolean
    Dim posizioneErrore As Integer


    If Not InclusioneAquablack Then Exit Sub

    With CP240.OPCDataAquablack
                               
        If (.items.count = 0 And PlcAquablackConnesso) Then
            Exit Sub
        End If

        .items(AQUABTAG_FROM_HMI_ManualSpeedH2OPump).Value = Aquablack_HMI_PLC.FROM_HMI_ManualSpeedH2OPump

        'scrittura dati ricetta
        .items(AQUABTAG_REC_NXT_PERCENTAGE_H2O).Value = AquablackRecipeNext.PercentageH2O
        .items(AQUABTAG_REC_NXT_BITUMEN_SELECTION).Value = AquablackRecipeNext.BitumenSelection
        .items(AQUABTAG_REC_NXT_BIT_MIN_FLOW).Value = AquablackRecipeNext.BitumenMinFlow
        .items(AQUABTAG_REC_NXT_TOLERANCE_H2O).Value = AquablackRecipeNext.ToleranceH2O
        .items(AQUABTAG_REC_NXT_BITUMEN_DISCH_2_STEPS).Value = AquablackRecipeNext.BitumenDisch2Steps

        'cambio al volo ricetta
        If AquablackRecipeNext.ChangeAtFlight And MescolazioneInCorso Then
            .items(AQUABTAG_REC_NXT_ChangeAtFlight).Value = AquablackRecipeNext.ChangeAtFlight
            CP240.tmrAqResetComandi.enabled = True
            '20170203
            If (DosaggioAquablack_ChangeAtFlight_DosInStop) Then
                DosaggioAquablack_ChangeAtFlight_DosInStop = False
            End If
            '20170203
        End If

        .items(AQUABTAG_FROM_HMI_Start).Value = Aquablack_HMI_PLC.FROM_HMI_Start
        .items(AQUABTAG_FROM_HMI_Stop).Value = Aquablack_HMI_PLC.FROM_HMI_Stop
        .items(AQUABTAG_FROM_HMI_Abort).Value = Aquablack_HMI_PLC.FROM_HMI_Abort
        .items(AQUABTAG_FROM_HMI_Manual).Value = Aquablack_HMI_PLC.FROM_HMI_Manual

'        .items(AQUABTAG_FROM_HMI_Start_H2O_Pump).Value = Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump
'        .items(AQUABTAG_FROM_HMI_Start_H2O_Valv).Value = Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv
'        .items(AQUABTAG_FROM_HMI_Start_Purge).Value = Aquablack_HMI_PLC.FROM_HMI_Start_Purge
'        .items(AQUABTAG_FROM_HMI_Start_Trickle).Value = Aquablack_HMI_PLC.FROM_HMI_Start_Trickle

        .items(AQUABTAG_FROM_HMI_Ack).Value = Aquablack_HMI_PLC.FROM_HMI_Ack

        .SOUpdate

    End With
        
End Sub

Public Sub ValvolaAquablack_Stato(valvola As Image, feedback As Boolean, comando As Boolean)

    With valvola
        If feedback And comando Then
            .Picture = LoadResPicture("IDB_VALVOLA_3D_ORIZ_ON", vbResBitmap)
        ElseIf Not feedback And Not comando Then
            .Picture = LoadResPicture("IDB_VALVOLA_3D_ORIZ", vbResBitmap)
        Else
            .Picture = LoadResPicture("IDB_VALVOLA_3D_ORIZ_ERR", vbResBitmap)
        End If
    End With
    
End Sub


Public Sub PompaAquablack_Stato(pompa As Image, feedback As Boolean, comando As Boolean, Optional Errore As Boolean)

    With pompa
        If Errore Then
            .Picture = LoadResPicture("IDB_POMPA_3D_ERR", vbResBitmap)
        ElseIf feedback And comando Then
            .Picture = LoadResPicture("IDB_POMPA_3D_ON", vbResBitmap)
        ElseIf Not feedback And Not comando Then
            .Picture = LoadResPicture("IDB_POMPA_3D", vbResBitmap)
        Else
            .Picture = LoadResPicture("IDB_POMPA_3D_ERR", vbResBitmap)
        End If
    End With
    
End Sub

Public Sub LineaAquablack_Stato(tubo As Line, Stato As AquablackTuboContenuto)

    With tubo
        Select Case Stato
            Case AquablackTuboContenuto.Aq_Tubo_Vuoto
                .BorderColor = &HC0C0C0 'grigio
            Case AquablackTuboContenuto.Aq_Tubo_H2O
                .BorderColor = &HFF0000    'blu
            Case AquablackTuboContenuto.Aq_Tubo_Aria
                .BorderColor = &HFFFF&     'giallo
            Case AquablackTuboContenuto.Aq_Tubo_Bitume
                .BorderColor = &H0&        'nero
            Case AquablackTuboContenuto.Aq_Tubo_Schiumato
                .BorderColor = &H800000           'blu scuro
        End Select
    End With

End Sub

Public Sub AQ_Valvola_H2O_Change()

    If FormAquablack.Visible Then
        Call ValvolaAquablack_Stato(FormAquablack.imgValvH2O, Aquablack_Digital.H2OValve_FeedBack, Aquablack_Digital.H2OValve_FeedBack)
        Call AQ_Gestione_StatoTubi
    End If

End Sub

Public Sub AQ_Valvola_Purge_Change()

    If FormAquablack.Visible Then
        Call ValvolaAquablack_Stato(FormAquablack.imgValvPurge, Aquablack_Digital.PURGEValve_FeedBack, Aquablack_Digital.PURGEValve_FeedBack)
        Call AQ_Gestione_StatoTubi
    End If
    
End Sub

Public Sub AQ_Valvola_Trickle_Change()

    If FormAquablack.Visible Then
        Call ValvolaAquablack_Stato(FormAquablack.imgValvTrickle, Aquablack_Digital.TRICKLEValve_FeedBack, Aquablack_Digital.TRICKLEValve_FeedBack)
        Call AQ_Gestione_StatoTubi
    End If
    
End Sub

Public Sub AQ_Pompa_H2O_Change()

    If FormAquablack.Visible Then
        Call PompaAquablack_Stato(FormAquablack.imgPompaH2O, Aquablack_Digital.DI_H2O_Pump_Return, Aquablack_Digital.DI_H2O_Pump_Return)
        Call AQ_Gestione_StatoTubi
    End If

End Sub

Public Sub AQ_Livello_Serbatoio_Change()

    If FormAquablack.Visible Then
        FormAquablack.imgAllarmeLivSerbatoio.Visible = Not FormAquablack.imgAllarmeLivSerbatoio.Visible And Aquablack_Digital.DI_H2O_Minimum_Level_Tank
    End If

End Sub

Public Sub AQ_Gestione_StatoTubi()
    
    If FormAquablack.Visible Then
        With FormAquablack
        
            'linee con dipendenze varie
            If Aquablack_Digital.PURGEValve_FeedBack Then
                'pompa in moto, acqua presente, aria chiusa
                Call LineaAquablack_Stato(.lnInjToValveH2O, AquablackTuboContenuto.Aq_Tubo_Aria)
                Call LineaAquablack_Stato(.lnH2OValveToMass, AquablackTuboContenuto.Aq_Tubo_Aria)
                Call LineaAquablack_Stato(.lnPumpToMass, AquablackTuboContenuto.Aq_Tubo_Aria)
            ElseIf Aquablack_Digital.DI_H2O_Pump_Return And Not Aquablack_Digital.DI_H2O_Minimum_Level_Tank And Not Aquablack_Digital.PURGEValve_FeedBack Then
                'pompa in moto, acqua presente, aria chiusa
                Call LineaAquablack_Stato(.lnInjToValveH2O, IIf(Aquablack_Digital.H2OValve_FeedBack, AquablackTuboContenuto.Aq_Tubo_H2O, AquablackTuboContenuto.Aq_Tubo_Vuoto))
                Call LineaAquablack_Stato(.lnH2OValveToMass, AquablackTuboContenuto.Aq_Tubo_H2O)
                Call LineaAquablack_Stato(.lnPumpToMass, AquablackTuboContenuto.Aq_Tubo_H2O)
            Else
                'tutto vuoto
                Call LineaAquablack_Stato(.lnInjToValveH2O, AquablackTuboContenuto.Aq_Tubo_Vuoto)
                Call LineaAquablack_Stato(.lnH2OValveToMass, AquablackTuboContenuto.Aq_Tubo_Vuoto)
                Call LineaAquablack_Stato(.lnPumpToMass, AquablackTuboContenuto.Aq_Tubo_Vuoto)
            End If
        
            If Aquablack_Digital.DI_Bit_InSpraying And Aquablack_Digital.DI_H2O_Pump_Return And Aquablack_Digital.H2OValve_FeedBack Then
                Call LineaAquablack_Stato(.lnInjToMixer, AquablackTuboContenuto.Aq_Tubo_Schiumato)
            ElseIf Aquablack_Digital.DI_Bit_InSpraying Then
                Call LineaAquablack_Stato(.lnInjToMixer, AquablackTuboContenuto.Aq_Tubo_Bitume)
            Else
                Call LineaAquablack_Stato(.lnInjToMixer, AquablackTuboContenuto.Aq_Tubo_Vuoto)
            End If
            
            'linee dipendenti solo dallo stato della valvola
            Call LineaAquablack_Stato(.lnPurgeOrr, IIf(Aquablack_Digital.PURGEValve_FeedBack, AquablackTuboContenuto.Aq_Tubo_Aria, AquablackTuboContenuto.Aq_Tubo_Vuoto))
            Call LineaAquablack_Stato(.lnPurgeVert, IIf(Aquablack_Digital.PURGEValve_FeedBack, AquablackTuboContenuto.Aq_Tubo_Aria, AquablackTuboContenuto.Aq_Tubo_Vuoto))
        
            Call LineaAquablack_Stato(.lnTrickleOrr, IIf(Aquablack_Digital.TRICKLEValve_FeedBack And Not Aquablack_Digital.DI_H2O_Minimum_Level_Tank, AquablackTuboContenuto.Aq_Tubo_H2O, AquablackTuboContenuto.Aq_Tubo_Vuoto))
            Call LineaAquablack_Stato(.lnTrickleVert, IIf(Aquablack_Digital.TRICKLEValve_FeedBack And Not Aquablack_Digital.DI_H2O_Minimum_Level_Tank, AquablackTuboContenuto.Aq_Tubo_H2O, AquablackTuboContenuto.Aq_Tubo_Vuoto))
        
            Call LineaAquablack_Stato(.lnSerbVert, IIf(Not Aquablack_Digital.DI_H2O_Minimum_Level_Tank, AquablackTuboContenuto.Aq_Tubo_H2O, AquablackTuboContenuto.Aq_Tubo_Vuoto))
            Call LineaAquablack_Stato(.lnSerbOrizz, IIf(Not Aquablack_Digital.DI_H2O_Minimum_Level_Tank, AquablackTuboContenuto.Aq_Tubo_H2O, AquablackTuboContenuto.Aq_Tubo_Vuoto))
            
            Call LineaAquablack_Stato(.lnBitumeToInj, IIf(Aquablack_Digital.DI_Bit_InSpraying, AquablackTuboContenuto.Aq_Tubo_Bitume, AquablackTuboContenuto.Aq_Tubo_Vuoto))
                   
        End With
    End If

End Sub

Public Sub AQ_SchiumaturaAttiva_Change()

    Dim attiva As Boolean

    attiva = Aquablack_Digital.DI_Bit_InSpraying And Aquablack_Digital.DI_H2O_Pump_Return And Aquablack_Digital.H2OValve_FeedBack

    CP240.ImgAdditivo(1).Picture = LoadResPicture(IIf(attiva, "IDB_AQUABLACK_ON", "IDB_AQUABLACK"), vbResBitmap)

    If FormAquablack.Visible Then
        FormAquablack.ImgAdditivo(1).Picture = LoadResPicture(IIf(attiva, "IDB_AQUABLACK_ON", "IDB_AQUABLACK"), vbResBitmap)
    End If

End Sub

Public Sub AQ_Manual_Mode_Change()

    If FormAquablack.Visible Then
        With FormAquablack
            
            .APButton_cmdH2OPump.Visible = Aquablack_Digital.AquablackStatoManuale
            .APButton_cmdH2OValve.Visible = Aquablack_Digital.AquablackStatoManuale
            .APButton_cmdPurgeValve.Visible = Aquablack_Digital.AquablackStatoManuale
            .APButton_cmdTrikleValve.Visible = Aquablack_Digital.AquablackStatoManuale
            .lblSetSpeedH2OPump.Visible = Aquablack_Digital.AquablackStatoManuale
            .lblSetSpeedH2OPumpDesc.Visible = Aquablack_Digital.AquablackStatoManuale
        
            Call AQ_StatoPulsantiForm
                       
        End With
    End If

    If Not Aquablack_Digital.AquablackStatoManuale Then
        Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump = False
        Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv = False
        Aquablack_HMI_PLC.FROM_HMI_Start_Purge = False
        Aquablack_HMI_PLC.FROM_HMI_Start_Trickle = False
        '20161027
        CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_Trickle).Value = Aquablack_HMI_PLC.FROM_HMI_Start_Trickle
        CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_Purge).Value = Aquablack_HMI_PLC.FROM_HMI_Start_Purge
        CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_H2O_Valv).Value = Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Valv
        CP240.OPCDataAquablack.items(AQUABTAG_FROM_HMI_Start_H2O_Pump).Value = Aquablack_HMI_PLC.FROM_HMI_Start_H2O_Pump
        '
    End If

End Sub

Public Sub AQ_PLCConnection_Change()

    If FormAquablack.Visible Then
        With FormAquablack
            .StatusBar1.Panels(AQPlcConnection).Picture = .PlusImageList1.ListImages(IIf(PlcAquablackConnesso, "CONNECTION_OK", "CONNECTION_ERR")).Picture
                
            If (CP240.OPCDataAquablack.IsConnected) Then
                .StatusBar1.Panels(AQPlcConnection).ToolTipText = LoadXLSString(1479) + " " + msgConnessoSi
            Else
                .StatusBar1.Panels(AQPlcConnection).ToolTipText = LoadXLSString(1479) + " " + msgConnessoNo
            End If
        End With
    End If
    
    If Not PlcAquablackConnesso And CP240.AdoDosaggioScarico.Recordset.Fields("AquablackSet") > 0 Then
        Call ArrestoEmergenzaDosaggio
    End If
    
End Sub

Public Sub AQ_Auto_Mode_Change()

    Dim key As String

    If FormAquablack.Visible Then
        With FormAquablack
            
            If Aquablack_Digital.AquablackDosaggioAttivo Then
                key = "AUTO_START"
'                .PctStatus.Picture = LoadResPicture("IDI_WORKING", vbResIcon)
'                .PctStatus.BackColor = vbGreen
            ElseIf Aquablack_Digital.AquablackStatoManuale Then
                key = "MANUAL_START"
'                .PctStatus.Picture = LoadResPicture("IDI_MANUALE", vbResIcon)
'                .PctStatus.BackColor = vbRed
            Else
                key = "AUTO_STOP"
'                .PctStatus.Picture = Nothing
'                .PctStatus.BackColor = &HC0C0C0
            End If
        
        .StatusBar1.Panels(AQStatus).Picture = .PlusImageList1.ListImages(key).Picture
        
        
            Call AQ_StatoPulsantiForm

        End With
    End If

End Sub

Public Sub AQ_Reset_Comandi()
'Reset comandi HMI
                                     
    AquablackRecipeNext.ChangeAtFlight = False

    Aquablack_HMI_PLC.FROM_HMI_Start = False

    Aquablack_HMI_PLC.FROM_HMI_Stop = False

    Aquablack_HMI_PLC.FROM_HMI_Abort = False

    Aquablack_HMI_PLC.FROM_HMI_Ack = False

    Aquablack_HMI_PLC.FROM_HMI_Manual = False

End Sub

Public Sub AQ_Ciclo()
'Routine chiamata ciclicamente
          
    tmrResetComandiAquablack.Abilitazione = Aquablack_HMI_PLC.FROM_HMI_Start Or Aquablack_HMI_PLC.FROM_HMI_Stop Or Aquablack_HMI_PLC.FROM_HMI_Abort Or Aquablack_HMI_PLC.FROM_HMI_Manual
                    
    Call TemporizzatoreStandard(1, 1, tmrResetComandiAquablack.AppTempo, _
                            tmrResetComandiAquablack.TempoExec, tmrResetComandiAquablack.uscita, _
                            tmrResetComandiAquablack.Abilitazione, tmrResetComandiAquablack.ErrTimer)
                            
    If tmrResetComandiAquablack.uscita Then
        Call AQ_Reset_Comandi
        tmrResetComandiAquablack.Abilitazione = False
    End If

End Sub

Public Sub AQ_StatoPulsantiForm()

    If FormAquablack.Visible Then
        With FormAquablack
            .imgPulsanteForm(TB_AQ_START).enabled = (Not Aquablack_Digital.AquablackDosaggioAttivo And Not Aquablack_Digital.AquablackStatoManuale)
            .imgPulsanteForm(TB_AQ_STOP).enabled = (Aquablack_Digital.AquablackDosaggioAttivo And Not Aquablack_Digital.AquablackStatoManuale)
            .imgPulsanteForm(TB_AQ_MANUAL).enabled = (Not Aquablack_Digital.AquablackDosaggioAttivo And Not Aquablack_Digital.AquablackStatoManuale)
            .UpdatePulsantiForm
        End With
    End If

End Sub


Public Sub ControllaAquablackAllarmi(ByRef IdDescrizione As Integer, ByRef IndirizzoPLC As String)

    Select Case IndirizzoPLC
        Case "AQ001"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.BITUMEN_INVALID_TYPE
        Case "AQ002"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.BITUMEN_PULSE_FLOW_CONVERSION_ERROR
        Case "AQ003"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.BITUMEN_TEMPERATURE
        Case "AQ004"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_FLOW_ERROR
        Case "AQ005"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_MAX_PRESSURE
        Case "AQ006"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_MINIMUM_LEVEL_TANK
        Case "AQ007"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_MINIMUM_PRESSURE
        Case "AQ008"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.TOLERANCE_ERROR
        Case "AQ009"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_PUMP_FeedBack_Error
        Case "AQ010"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_PUMP_Overload_Tripped
        Case "AQ011"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_PUMP_Start_Timeout
        Case "AQ012"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_PUMP_Stop_Timeout
        Case "AQ013"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_VALVE_BothClose
        Case "AQ014"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_VALVE_BothOpen
        Case "AQ015"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_VALVE_Close_Timeout
        Case "AQ016"   '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.PURGE_VALVE_Incongrous_FeedBack
        Case "AQ017"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.H2O_VALVE_Open_Timeout
        Case "AQ018"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.PURGE_VALVE_BothClose
        Case "AQ019"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.PURGE_VALVE_BothOpen
        Case "AQ020"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.PURGE_VALVE_Close_Timeout
        Case "AQ021"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.PURGE_VALVE_Incongrous_FeedBack
        Case "AQ022"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.PURGE_VALVE_Open_Timeout
        Case "AQ023"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.S7_TIMEOUT
        Case "AQ024"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.TRICKLE_VALVE_BothClose
        Case "AQ025"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.TRICKLE_VALVE_BothOpen
        Case "AQ026"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.TRICKLE_VALVE_Close_Timeout
        Case "AQ027"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.TRICKLE_VALVE_Incongrous_FeedBack
        Case "AQ028"    '
            IngressoAllarmePresente IdDescrizione, AquablackAlarm.TRICKLE_VALVE_Open_Timeout
    End Select

End Sub


Public Function PlcAquablackConnessione(connetti As Boolean) As Boolean

    Dim indice As Integer
    Dim numBit As Integer
    Dim numByte As Integer
    Dim DB As String

    PlcAquablackConnessione = False

    On Error GoTo Errore

    If (InclusioneAquablack And connetti) Then

        If (Not CP240.OPCDataAquablack.IsConnected) Then

            CP240.OPCDataAquablack.RemoteHost = SetIP
            CP240.OPCDataAquablack.ServerName = OpcServerName
            CP240.OPCDataAquablack.UseAsync = True

            LoadOPCTags "PLC5", CP240.OPCDataAquablack

            CP240.OPCDataAquablack.Connect

        End If

    Else

        If (CP240.OPCDataAquablack.IsConnected) Then

            CP240.OPCDataAquablack.Disconnect

        End If

    End If

    PlcAquablackConnessione = True

    Exit Function
Errore:
    LogInserisci True, "AQ004", CStr(Err.Number) + " [" + Err.description + "]"
End Function

Public Function PlcAquablackConnesso() As Boolean

    Dim connesso As Boolean
    
    With CP240.OPCDataAquablack

        connesso = (.IsConnected And .items.count > 0)
        If (connesso) Then
            connesso = (GetQuality(.items(0).quality) = STATOOK)
        End If

        PlcAquablackConnesso = connesso

    End With

End Function
