Attribute VB_Name = "ParaTabAquablack"
'20160729
'
'   Gestione dei parametri dell'Aquablack
'
'   2016 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'

Option Explicit

Private Const SEZIONE As String = "Addittivi"

Public Type ParaTabAquablackColumnType
    modificato As Boolean
    ValueCol As Integer
    MinCol As Integer
    MaxCol As Integer
    DefaultCol As Integer
    IdParametro As Integer
    DescrizioneTag As Integer
End Type

Public ParaTabAquablackColumn As ParaTabAquablackColumnType
Public ScriviTagAquablackOnce As Boolean
Public DgAquablackOldValue() As Variant


Public Sub ParaTabAquablack_ReadFile()

    '20160915
    AquablackParameter.PressioneH2O_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PressioneH2O_Analog_Max"))
    AquablackParameter.PressioneH2O_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PressioneH2O_Analog_Min"))
    AquablackParameter.PressioneH2O_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PressioneH2O_Scaled_Max"))
    AquablackParameter.PressioneH2O_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PressioneH2O_Scaled_Min"))
    AquablackParameter.FlussoH2O_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "FlussoH2O_Analog_Max"))
    AquablackParameter.FlussoH2O_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "FlussoH2O_Analog_Min"))
    AquablackParameter.FlussoH2O_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "FlussoH2O_Scaled_Max"))
    AquablackParameter.FlussoH2O_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "FlussoH2O_Scaled_Min"))
    AquablackParameter.Velocita_IN_PompaH2O_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_IN_PompaH2O_Analog_Max"))
    AquablackParameter.Velocita_IN_PompaH2O_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_IN_PompaH2O_Analog_Min"))
    AquablackParameter.Velocita_IN_PompaH2O_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_IN_PompaH2O_Scaled_Max"))
    AquablackParameter.Velocita_IN_PompaH2O_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_IN_PompaH2O_Scaled_Min"))
    AquablackParameter.Velocita_OUT_PompaH2O_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_OUT_PompaH2O_Analog_Max"))
    AquablackParameter.Velocita_OUT_PompaH2O_Analaog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_OUT_PompaH2O_Analaog_Min"))
    AquablackParameter.Velocita_OUT_PompaH2O_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_OUT_PompaH2O_Scaled_Max"))
    AquablackParameter.Velocita_OUT_PompaH2O_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_OUT_PompaH2O_Scaled_Min"))
    AquablackParameter.Velocita_PompaBitume_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_PompaBitume_Analog_Max"))
    AquablackParameter.Velocita_PompaBitume_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_PompaBitume_Analog_Min"))
    AquablackParameter.Velocita_PompaBitume_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_PompaBitume_Scaled_Max"))
    AquablackParameter.Velocita_PompaBitume_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Velocita_PompaBitume_Scaled_Min"))
    AquablackParameter.Temperatura_PompaBitume_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Temperatura_PompaBitume_Analog_Max"))
    AquablackParameter.Temperatura_PompaBitume_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Temperatura_PompaBitume_Analog_Min"))
    AquablackParameter.Temperatura_PompaBitume_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Temperatura_PompaBitume_Scaled_Max"))
    AquablackParameter.Temperatura_PompaBitume_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Temperatura_PompaBitume_Scaled_Min"))
    AquablackParameter.Massico_Bitume_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Massico_Bitume_Analog_Max"))
    AquablackParameter.Massico_Bitume_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Massico_Bitume_Analog_Min"))
    AquablackParameter.Massico_Bitume_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Massico_Bitume_Scaled_Max"))
    AquablackParameter.Massico_Bitume_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Massico_Bitume_Scaled_Min"))
    AquablackParameter.Peso_Bitume_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Peso_Bitume_Analog_Max"))
    AquablackParameter.Peso_Bitume_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Peso_Bitume_Analog_Min"))
    AquablackParameter.Peso_Bitume_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Peso_Bitume_Scaled_Max"))
    AquablackParameter.Peso_Bitume_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Peso_Bitume_Scaled_Min"))
    AquablackParameter.Tara_Bitume_Analog_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tara_Bitume_Analog_Max"))
    AquablackParameter.Tara_Bitume_Analog_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tara_Bitume_Analog_Min"))
    AquablackParameter.Tara_Bitume_Scaled_Max = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tara_Bitume_Scaled_Max"))
    AquablackParameter.Tara_Bitume_Scaled_Min = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tara_Bitume_Scaled_Min"))
    AquablackParameter.Compensazione_Transitorio_Flusso = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Compensazione_Transitorio_Flusso"))
    AquablackParameter.Tempo_Ap_Valv_Spruzz_Bit = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Ap_Valv_Spruzz_Bit"))
    AquablackParameter.Tempo_ACh_Valv_Spruzz_Bit = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_ACh_Valv_Spruzz_Bit"))
    AquablackParameter.Allarme_Alta_Pressione = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Alta_Pressione"))
    AquablackParameter.Rit_Allarme_Alta_Pressione = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Rit_Allarme_Alta_Pressione"))
    AquablackParameter.Percentuale_H2O_Bitume_Ch = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Percentuale_H2O_Bitume_Ch"))
    AquablackParameter.Rit_Allarme_Min_Flusso = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Rit_Allarme_Min_Flusso"))
    AquablackParameter.Allarme_Min_Flusso = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Min_Flusso"))
    AquablackParameter.Flusso_Bit_Dur_Ritardo_Ch = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Flusso_Bit_Dur_Ritardo_Ch"))
    AquablackParameter.Allarme_Bassa_Pressione = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Bassa_Pressione"))
    AquablackParameter.Rit_Allarme_Bassa_Pressione = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Rit_Allarme_Bassa_Pressione"))
    AquablackParameter.Tempo_Step1_Spurgo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Step1_Spurgo"))
    AquablackParameter.Tempo_Step2_Spurgo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Step2_Spurgo"))
    AquablackParameter.Tempo_Start_Trickle = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Start_Trickle"))
    AquablackParameter.Tempo_Stop_Trickle = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Stop_Trickle"))
    AquablackParameter.Selezione_Sorgente = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Selezione_Sorgente"))
    AquablackParameter.Tipo_Impianto = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tipo_Impianto"))
    AquablackParameter.Gravita_Bitume = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Gravita_Bitume"))
    AquablackParameter.Tempo_Totalizzazione_Continui = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Totalizzazione_Continui"))
    AquablackParameter.Tipo_Bitume = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tipo_Bitume"))
    AquablackParameter.Allarme_Min_Temp_Bit_1 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Min_Temp_Bit_1"))
    AquablackParameter.Allarme_Min_Temp_Bit_2 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Min_Temp_Bit_2"))
    AquablackParameter.Allarme_Min_Temp_Bit_3 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Min_Temp_Bit_3"))
    AquablackParameter.Allarme_Min_Temp_Bit_4 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Min_Temp_Bit_4"))
    AquablackParameter.Allarme_Max_Temp_Bit_1 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Max_Temp_Bit_1"))
    AquablackParameter.Allarme_Max_Temp_Bit_2 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Max_Temp_Bit_2"))
    AquablackParameter.Allarme_Max_Temp_Bit_3 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Max_Temp_Bit_3"))
    AquablackParameter.Allarme_Max_Temp_Bit_4 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Allarme_Max_Temp_Bit_4"))
    AquablackParameter.Imp_Litro_Massico = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Imp_Litro_Massico"))
    AquablackParameter.Densita_Massico = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Densita_Massico"))
    AquablackParameter.Risoluzione_OUT_Massico = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Risoluzione_OUT_Massico"))
    AquablackParameter.Campioni_Media_Bilancia = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Campioni_Media_Bilancia"))
    AquablackParameter.Risoluzione_OUT_Bilancia = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Risoluzione_OUT_Bilancia"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel1 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Vel1"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel2 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Vel2"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel3 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Vel3"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel4 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Vel4"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Vel5 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Vel5"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso1 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Flusso1"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso2 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Flusso2"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso3 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Flusso3"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso4 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Flusso4"))
    AquablackParameter.Num_Punti_Appross_Vel_Flusso_Flusso5 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Vel_Flusso_Flusso5"))
    AquablackParameter.Stabilizz_Aggregati = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Stabilizz_Aggregati"))
    AquablackParameter.Stabilizz_Bitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Stabilizz_Bitume"))
    AquablackParameter.Tara_Valore_Fisso_Bitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tara_Valore_Fisso_Bitume"))
    AquablackParameter.Tempo_Mantenimento_Flusso_Prec = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Tempo_Mantenimento_Flusso_Prec"))
    AquablackParameter.Ponderale_H2O = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_H2O"))
    AquablackParameter.Ponderale_G_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_G_H2O"))
    AquablackParameter.Ponderale_TI_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_TI_H2O"))
    AquablackParameter.Ponderale_TD_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_TD_H2O"))
    AquablackParameter.Ponderale_BW_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_BW_H2O"))
    AquablackParameter.Ponderale_TCamp_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_TCamp_H2O"))
    AquablackParameter.Ponderale_LimMax_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_LimMax_H2O"))
    AquablackParameter.Ponderale_LimMin_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_LimMin_H2O"))
    AquablackParameter.Ponderale_TI_Start_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_TI_Start_H2O"))
    AquablackParameter.Ponderale_EnableG_H2O = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_EnableG_H2O"))
    AquablackParameter.Ponderale_EnableTI_H2O = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_EnableTI_H2O"))
    AquablackParameter.Ponderale_EnableTD_H2O = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_EnableTD_H2O"))
    AquablackParameter.Ponderale_EnableFinestra_H2O = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_EnableFinestra_H2O"))
    AquablackParameter.Ponderale_Finestra_H2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ponderale_Finestra_H2O"))
    AquablackParameter.VelPompaH2O_Ricircolo = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "VelPompaH2O_Ricircolo"))
    AquablackParameter.PompaH2O_Max_Perc = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PompaH2O_Max_Perc"))
    AquablackParameter.PompaH2O_TStart = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PompaH2O_TStart"))
    AquablackParameter.PompaH2O_TStop = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "PompaH2O_TStop"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso1 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Flusso1"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso2 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Flusso2"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso3 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Flusso3"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso4 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Flusso4"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Flusso5 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Flusso5"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel1 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Vel1"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel2 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Vel2"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel3 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Vel3"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel4 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Vel4"))
    AquablackParameter.Num_Punti_Appross_Flusso_Vel_Vel5 = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Num_Punti_Appross_Flusso_Vel_Vel5"))
    AquablackParameter.ValvolaH2O_Tmout_Ap = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaH2O_Tmout_Ap"))
    AquablackParameter.ValvolaH2O_Tmout_Ch = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaH2O_Tmout_Ch"))
    AquablackParameter.ValvolaH2O_Tmout_Trigger = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaH2O_Tmout_Trigger"))
    AquablackParameter.ValvolaH2O_Tmout_Simulata = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaH2O_Tmout_Simulata"))
    AquablackParameter.ValvolaH2O_Tmout_Invertita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaH2O_Tmout_Invertita"))
    AquablackParameter.ValvolaH2O_Tmout_TreVie = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaH2O_Tmout_TreVie"))
    AquablackParameter.ValvolaPurge_Tmout_Ap = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaPurge_Tmout_Ap"))
    AquablackParameter.ValvolaPurge_Tmout_Ch = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaPurge_Tmout_Ch"))
    AquablackParameter.ValvolaPurge_Tmout_Trigger = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaPurge_Tmout_Trigger"))
    AquablackParameter.ValvolaPurge_Tmout_Simulata = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaPurge_Tmout_Simulata"))
    AquablackParameter.ValvolaTrickle_Tmout_Ap = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaTrickle_Tmout_Ap"))
    AquablackParameter.ValvolaPurge_Tmout_Invertita = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaPurge_Tmout_Invertita"))
    AquablackParameter.ValvolaTrickle_Tmout_Ch = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaTrickle_Tmout_Ch"))
    AquablackParameter.ValvolaTrickle_Tmout_Trigger = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaTrickle_Tmout_Trigger"))
    AquablackParameter.ValvolaTrickle_Tmout_Simulata = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaTrickle_Tmout_Simulata"))
    AquablackParameter.ValvolaTrickle_Tmout_Invertita = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "ValvolaTrickle_Tmout_Invertita"))
    AquablackParameter.GestioneH2O_e_Totalizzatore = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "GestioneH2O_e_Totalizzatore"))
    AquablackParameter.Abilitazione_Ch_Trickle_Dur_Spurgo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Abilitazione_Ch_Trickle_Dur_Spurgo"))
    AquablackParameter.Abilitazione_Spurgo_Sullo_Stop = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Abilitazione_Spurgo_Sullo_Stop"))
    AquablackParameter.Ritardo_Allarme_Tolleranza_Continuo = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Ritardo_Allarme_Tolleranza_Continuo"))
    AquablackParameter.Connessione_S7 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Connessione_S7"))
    AquablackParameter.Controllo_Cyb500 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Controllo_Cyb500"))
    '

End Sub


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabAquablack_Apply()

    '20160915 Call ParaAquablack_Scrivi
    
End Sub

'20160915
'Public Sub ParaAquablack_Scrivi()
'
''TODO
'
''    Dim i As Integer
''    Dim rs As ADODB.Recordset
''    Dim fld As ADODB.Field
''
''    On Error GoTo Errore
''
''    If Not CP240.OPCDataAquablack.IsConnected Or CP240.OPCDataAquablack.items.Count = 0 Then
''        Exit Sub
''    End If
''
''    Set rs = FrmParametri.AdodcParaAquablack.Recordset.Clone
''
''    i = AQUABTAG_AN_H2OPressure_AnalogIN_MAX
''
''    With rs
''
''        .MoveFirst
''
''        Do While Not .EOF
'''
'''            Debug.Print .Fields("italiano").value; .Fields("Valore").value
'''            Debug.Print CP240.OPCDataAquablack.Items(i).ItemID
''
''            If Right(CP240.OPCDataAquablack.items(i).ItemID, 4) = "REAL" Then
''                'in caso di tag REAL va convertito in double, perche' in Excel il separatore decimale e' la virgola
''                CP240.OPCDataAquablack.items(i).Value = CDbl(.Fields("Valore").Value)
''            Else
''                CP240.OPCDataAquablack.items(i).Value = val(.Fields("Valore").Value)
''            End If
''
''            i = i + 1
''
''            .MoveNext
''        Loop
''
''    End With
''
''    CP240.OPCDataAquablack.Update
''
''    rs.Close
''    Set rs = Nothing
''
''    ScriviTagAquablackOnce = True
''
''    Exit Sub
''
''Errore:
''
''    If Not rs Is Nothing Then
''        If rs.State = adStateOpen Then rs.Close
''    End If
''
''    LogInserisci True, "AQ003", CStr(Err.Number) + " [" + Err.description + "]"
'
'End Sub
'
'
''   Verifica se i dati sono modificati
'Public Function ParaTabAquablack_IsModified() As Boolean
'
'    ParaTabAquablack_IsModified = ParaTabAquablackColumn.modificato
'
'End Function
'
