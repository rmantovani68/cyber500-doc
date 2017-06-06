Attribute VB_Name = "GestioneSiwarex"
'
'   Gestione dei parametri Siwarex
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const FileSiwarex As String = "Siwarex.ini"
Private Const SEZIONE As String = "Siwarex"

Public FrmSiwarexParaVisibile As Boolean

Public StepDR33 As Integer
Public StepDR30 As Integer
Public StepDR03 As Integer

'   Struttura contenitore dei dati Siwarex
Public Type SiwarexConfigurationType

    presente As Boolean
    SuPredosatore As Boolean    'indica che associato a predosatore/pred.riciclato (False nel caso di nastro)

    'Comandi Siwarex --> Parametri usati dalla FB1043
    SIWA_CMD_INPUT As Integer
    SIWA_CMD_ENABLED As Boolean
    SIWA_CMD_IN_PROGRESS As Boolean
    SIWA_CMD_FINISHED_OK As Boolean
    SIWA_CMD_ERR As Boolean
    SIWA_CMD_ERR_CODE As Integer
    SIWA_SIM_VALUE As Double
    SIWA_ANALOG_OUT_VALUE As Double
    SIWA_RESERVE_18 As Integer
    SIWA_DIG_OUT_FORCE As Integer
    SIWA_INFO_REFRESH_COUNT As Integer
    SIWA_PROCESS_VALUE1 As Double
    SIWA_PROCESS_VALUE2 As Double
    SIWA_SCALE_STATUS As Double
    SIWA_ERR_MSG As Boolean
    SIWA_ERR_MSG_QUIT As Boolean
    SIWA_ERR_MSG_TYPE As Integer
    SIWA_ERR_MSG_CODE As Integer
    SIWA_FB_ERR As Boolean
    SIWA_FB_ERR_CODE As Integer
    
    'DR3
    SIWA_DIGIT_ZERO As Double
    SIWA_DIGIT_TARATURA As Double
    SIWA_PESO_TARATURA As Double
    SIWA_MILLIVOLT As Integer
    SIWA_FILTRO_FREQ As Integer
    SIWA_FILTRO_MEDIA As Integer
    SIWA_AUTOZERO As Boolean
    SIWA_PERC_SOTTO_ZERO As Integer
    SIWA_PERC_SOPRA_ZERO As Integer
    SIWA_TEMPO_CALIBRAZIONE As Double
    'Questo nuovo gruppo di variabili contiene i valori dei parametri DR3 siwarex salvati su file e vengono caricati all'avvio
    SIWA_DIGIT_ZERO_FILE As Double
    SIWA_DIGIT_TARATURA_FILE As Double
    SIWA_PESO_TARATURA_FILE As Double
    SIWA_MILLIVOLT_FILE As Integer
    SIWA_FILTRO_FREQ_FILE As Integer
    SIWA_FILTRO_MEDIA_FILE As Integer
    SIWA_AUTOZERO_FILE As Boolean
    SIWA_PERC_SOTTO_ZERO_FILE As Integer
    SIWA_PERC_SOPRA_ZERO_FILE As Integer
    SIWA_TEMPO_CALIBRAZIONE_FILE As Double

    'DR5
    SIWA_IMPULSI_METRO As Double
    SIWA_LUNGHEZZA As Double
    SIWA_CORREZIONE As Double
    SIWA_MIN_TOTALIZING As Integer
    'Questo nuovo gruppo di variabili contiene i valori dei parametri DR5 siwarex salvati su file e vengono caricati all'avvio
    SIWA_IMPULSI_METRO_FILE As Double
    SIWA_LUNGHEZZA_FILE As Double
    SIWA_CORREZIONE_FILE As Double
    SIWA_MIN_TOTALIZING_FILE As Integer

    'DR30
    SIWA_STATUS_SERVICE_ON As Boolean
    SIWA_CALIBRAZIONE_ON As Boolean
    SIWA_PESO_NASTRO As Double
    SIWA_VELOX_NASTRO As Double
    SIWA_PORTATA_NASTRO As Double
    
    'DR31
    SIWA_AD_DIGIT_FILTERED As Double
    '
    
    'DR33
    SIWA_TOTALIZER_5 As Double
    SIWA_TOTALIZER_6 As Double

End Type


'   Emun delle varie bilance
Public Enum SiwarexEnum
    SiwarexNastroInerti
    SiwarexNastroRiciclatoCaldo  'o Ric 1 se singolo
    SiwarexPredosatore1          'o Ric 1 se multipli
    SiwarexPredosatore2          'o Ric 2 se multipli
    SiwarexRiciclatoFreddo
    SiwarexRiciclato3
    SiwarexRiciclato4
    SiwarexNastroRiciclatoFreddo
    
    SivarexMax
End Enum

'   Array delle bilance
Public Siwarex(0 To SivarexMax - 1) As SiwarexConfigurationType

Public CodiceComandoSiwarex As Integer
Public NumeroSiwarex As Integer
Public StepScriviDR3 As Integer
Public StepScriviDR5 As Integer
'
Public AbilitaRAPSiwa As Boolean
Public AbilitaAspirazFumiRAP As Boolean

Public Type SiwarexLetturaDI
    SIWA_DI(0 To 7) As Boolean
End Type
Public SiwarexStatoDI(0 To SivarexMax - 1) As SiwarexLetturaDI

Public SiwarexPESA_Velox_MAX_AO As Integer
Public SiwarexPESA_Velox_MIN_AO As Integer
Public SiwarexPESA_Kg_Velox_MIN As Integer

'
'


Public Sub SiwarexLeggiDaFile(siwarexIndex As SiwarexEnum)

    Dim nomeFile As String


    '   Legge i dati dal file

    nomeFile = UserDataPath + FileSiwarex

    'Per ora continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    With Siwarex(siwarexIndex)

        'In precedenza i valori venivano passati alle variabili normali, ora alle variabili _FILE
        'DR3
        .SIWA_DIGIT_ZERO_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_DIGIT_ZERO", "0"))
        .SIWA_DIGIT_TARATURA_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_DIGIT_TARATURA", "0"))
        .SIWA_PESO_TARATURA_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_PESO_TARATURA", "0"))
        .SIWA_MILLIVOLT_FILE = CInt(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_MILLIVOLT", "0"))
        .SIWA_FILTRO_FREQ_FILE = CInt(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_FILTRO_FREQ", "0"))
        .SIWA_FILTRO_MEDIA_FILE = CInt(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_FILTRO_MEDIA", "0"))
        .SIWA_AUTOZERO_FILE = CBool(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_AUTOZERO", "0"))
        .SIWA_PERC_SOTTO_ZERO_FILE = CInt(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_PERC_SOTTO_ZERO", "0"))
        .SIWA_PERC_SOPRA_ZERO_FILE = CInt(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_PERC_SOPRA_ZERO", "0"))
        .SIWA_TEMPO_CALIBRAZIONE_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_TEMPO_CALIBRAZIONE", "0"))

        'DR5
        .SIWA_IMPULSI_METRO_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_IMPULSI_METRO", "0"))
        .SIWA_LUNGHEZZA_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_LUNGHEZZA", "0"))
        .SIWA_CORREZIONE_FILE = CDbl(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_CORREZIONE", "0"))
        .SIWA_MIN_TOTALIZING_FILE = CInt(FileGetValue(nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_MIN_TOTALIZING", "0"))

    End With

End Sub


Public Sub SiwarexLeggiTutteDaFile()

    Dim indice As SiwarexEnum

    For indice = 0 To SivarexMax - 1
        SiwarexLeggiDaFile indice
    Next indice

End Sub


Public Sub SiwarexScriviSuFile(siwarexIndex As SiwarexEnum)

Dim nomeFile As String

    '   Legge i dati dal file

    nomeFile = UserDataPath + FileSiwarex

    'Per ora continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    With Siwarex(siwarexIndex)
        
        'DR3
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_DIGIT_ZERO", CStr(.SIWA_DIGIT_ZERO_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_DIGIT_TARATURA", CStr(.SIWA_DIGIT_TARATURA_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_PESO_TARATURA", CStr(.SIWA_PESO_TARATURA_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_MILLIVOLT", CStr(.SIWA_MILLIVOLT_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_FILTRO_FREQ", CStr(.SIWA_FILTRO_FREQ_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_FILTRO_MEDIA", CStr(.SIWA_FILTRO_MEDIA_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_AUTOZERO", CStr(.SIWA_AUTOZERO_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_PERC_SOTTO_ZERO", CStr(.SIWA_PERC_SOTTO_ZERO_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_PERC_SOPRA_ZERO", CStr(.SIWA_PERC_SOPRA_ZERO_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_TEMPO_CALIBRAZIONE", CStr(.SIWA_TEMPO_CALIBRAZIONE_FILE)
        
        'DR5
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_IMPULSI_METRO", CStr(.SIWA_IMPULSI_METRO_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_LUNGHEZZA", CStr(.SIWA_LUNGHEZZA_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_CORREZIONE", CStr(.SIWA_CORREZIONE_FILE)
        FileSetValue nomeFile, SEZIONE + CStr(siwarexIndex), "SIWA_MIN_TOTALIZING", CStr(.SIWA_MIN_TOTALIZING_FILE)
        
    End With

    SetPlantInfoNumber PI_PARAMETERTOSAVE, 1

End Sub

Public Sub AttivaComandoSiwarex(siwarexIndex As SiwarexEnum)
    
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    NumeroSiwarex = siwarexIndex
    FrmGestioneTimer.TimerSiwa_Refresh(siwarexIndex).enabled = False
    FrmGestioneTimer.TimerSiwa_Refresh(siwarexIndex).Interval = 50
    FrmGestioneTimer.TimerSiwa_Refresh(siwarexIndex).enabled = True

End Sub

Public Sub SiwarexInviaParametriPlc(siwarexIndex As SiwarexEnum, NumDR As Integer)
Dim offset As Integer
    
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    offset = siwarexIndex * (PLCTAG_BILANCIA_1 - PLCTAG_BILANCIA_0) 'PLCTAG_BILANCIA_1 - PLCTAG_BILANCIA_0 sono i tag di ogni Siwarex
    
    With Siwarex(siwarexIndex)
        Select Case NumDR
            Case 0
                'DR3
                If FrmSiwarexPara.TxtDR3(0).enabled = True Then
                    CP240.OPCData.items(PLCTAG_SIWA0_DIGIT_ZERO + offset).Value = .SIWA_DIGIT_ZERO
                    CP240.OPCData.items(PLCTAG_SIWA0_DIGIT_TARATURA + offset).Value = .SIWA_DIGIT_TARATURA
                End If
                CP240.OPCData.items(PLCTAG_SIWA0_PESO_TARATURA + offset).Value = .SIWA_PESO_TARATURA
                CP240.OPCData.items(PLCTAG_SIWA0_MILLIVOLT + offset).Value = .SIWA_MILLIVOLT
                CP240.OPCData.items(PLCTAG_SIWA0_FILTRO_FREQ + offset).Value = .SIWA_FILTRO_FREQ
                CP240.OPCData.items(PLCTAG_SIWA0_FILTRO_MEDIA + offset).Value = .SIWA_FILTRO_MEDIA
                CP240.OPCData.items(PLCTAG_SIWA0_AUTOZERO + offset).Value = .SIWA_AUTOZERO
                CP240.OPCData.items(PLCTAG_SIWA0_PERC_SOTTO_ZERO + offset).Value = .SIWA_PERC_SOTTO_ZERO
                CP240.OPCData.items(PLCTAG_SIWA0_PERC_SOPRA_ZERO + offset).Value = .SIWA_PERC_SOPRA_ZERO
                CP240.OPCData.items(PLCTAG_SIWA0_TEMPO_CALIBRAZIONE + offset).Value = ConvertiTempoSECtoS7(.SIWA_TEMPO_CALIBRAZIONE)
                
                'Parametri di default per inizializzare correttamente la bilancia
                CP240.OPCData.items(PLCTAG_SIWA0_ZERO_SETTING_START_UP + offset).Value = False 'DBX 125.2
                'DBD126
                CP240.OPCData.items(PLCTAG_SIWA0_MIN_RANGE + offset).Value = 1
                'DBD130
                CP240.OPCData.items(PLCTAG_SIWA0_MAX_RANGE + offset).Value = 100
                'DBD134
                CP240.OPCData.items(PLCTAG_SIWA0_INCREMENT_RANGE + offset).Value = (1 / 10)

                CodiceComandoSiwarex = 103
                Call AttivaComandoSiwarex(siwarexIndex)
                
                StepScriviDR3 = 0
                FrmSiwarexPara.TimerScriviDR3.enabled = False
                FrmSiwarexPara.TimerScriviDR3.Interval = 1000
                FrmSiwarexPara.TimerScriviDR3.enabled = True
                CP240.OPCData.SOUpdate
            Case 1
                'DR5
                CP240.OPCData.items(PLCTAG_SIWA0_IMPULSI_METRO + offset).Value = .SIWA_IMPULSI_METRO
                CP240.OPCData.items(PLCTAG_SIWA0_LUNGHEZZA + offset).Value = .SIWA_LUNGHEZZA
                CP240.OPCData.items(PLCTAG_SIWA0_CORREZIONE + offset).Value = .SIWA_CORREZIONE
                CP240.OPCData.items(PLCTAG_SIWA0_MIN_TOTALIZING + offset).Value = .SIWA_MIN_TOTALIZING
                
                'Parametri di default per inizializzare correttamente la bilancia
                'DBD 254
                'If siwarexIndex <> 4 Then
                If siwarexIndex = SiwarexNastroInerti Or siwarexIndex = SiwarexNastroRiciclatoCaldo Or siwarexIndex = SiwarexRiciclatoFreddo Then
                '
                    CP240.OPCData.items(PLCTAG_SIWA0_STANDARD_BELT_SPEED + offset).Value = 2
                Else
                    CP240.OPCData.items(PLCTAG_SIWA0_STANDARD_BELT_SPEED + offset).Value = (1 / 4)
                End If
                '

                If siwarexIndex = SiwarexRiciclatoFreddo Then
                    'DBD 258
                    CP240.OPCData.items(PLCTAG_SIWA0_MEASURING_TIME_SPEED + offset).Value = ConvertiTempoSECtoS7(Fix(1 / (LogaritmoBASE(.SIWA_IMPULSI_METRO, 10) * 2)), ParteDecimale(1 / (LogaritmoBASE(.SIWA_IMPULSI_METRO, 10) * 2), 3))
                Else
                    'DBD 258
                    CP240.OPCData.items(PLCTAG_SIWA0_MEASURING_TIME_SPEED + offset).Value = ConvertiTempoSECtoS7(2)
                End If

                'DBW 270
                CP240.OPCData.items(PLCTAG_SIWA0_MIN_BELT_SPEED_VALUE + offset).Value = 0
                'DBW 272
                CP240.OPCData.items(PLCTAG_SIWA0_MAX_BELT_SPEED_VALUE + offset).Value = 2000

                If siwarexIndex = SiwarexRiciclatoFreddo Then
                    'DBD 274
                    CP240.OPCData.items(PLCTAG_SIWA0_ALARM_DELAY_START_UP_SPEED + offset).Value = ConvertiTempoSECtoS7(5)
                Else
                    'DBD 274
                    CP240.OPCData.items(PLCTAG_SIWA0_ALARM_DELAY_START_UP_SPEED + offset).Value = ConvertiTempoSECtoS7(30)
                End If

                'DBD 278
                CP240.OPCData.items(PLCTAG_SIWA0_ALARM_DELAY_IN_OPERATION_SPEED + offset).Value = ConvertiTempoSECtoS7(5)

                If siwarexIndex = SiwarexRiciclatoFreddo Then
                    'DBD 286
                    CP240.OPCData.items(PLCTAG_SIWA0_STANDARD_FLOW + offset).Value = 300
                Else
                    'DBD 286
                    CP240.OPCData.items(PLCTAG_SIWA0_STANDARD_FLOW + offset).Value = 100
                End If

                'DBW 298
                CP240.OPCData.items(PLCTAG_SIWA0_MIN_FLOW_VALUE + offset).Value = 0
                'DBW 300
                CP240.OPCData.items(PLCTAG_SIWA0_MAX_FLOW_VALUE + offset).Value = 2000
                'DBW 302
                CP240.OPCData.items(PLCTAG_SIWA0_MIN_LOAD_VALUE + offset).Value = 0
                'DBW 304
                CP240.OPCData.items(PLCTAG_SIWA0_MAX_LOAD_VALUE + offset).Value = 2000

                If siwarexIndex = SiwarexRiciclatoFreddo Then
                    'DBD 310
                    CP240.OPCData.items(PLCTAG_SIWA0_ALARM_DELAY_START_UP_FLOW_LOAD + offset).Value = ConvertiTempoSECtoS7(5)
                Else
                    'DBD 310
                    CP240.OPCData.items(PLCTAG_SIWA0_ALARM_DELAY_START_UP_FLOW_LOAD + offset).Value = ConvertiTempoSECtoS7(30)
                End If

                'DBD 314
                CP240.OPCData.items(PLCTAG_SIWA0_ALARM_DELAY_IN_OPERATION_FLOW_LOAD + offset).Value = ConvertiTempoSECtoS7(5)

                'DBD 318
                CP240.OPCData.items(PLCTAG_SIWA0_TOTALIZING_STEP_1 + offset).Value = 1
                'DBD 322
                CP240.OPCData.items(PLCTAG_SIWA0_TOTALIZING_STEP_2 + offset).Value = 10
                'DBD 326
                CP240.OPCData.items(PLCTAG_SIWA0_QUANTITY_PER_PULSE_1 + offset).Value = 0
                'DBD 330
                CP240.OPCData.items(PLCTAG_SIWA0_PULSE_1_DURATION + offset).Value = ConvertiTempoSECtoS7(0)
                'DBD 334
                CP240.OPCData.items(PLCTAG_SIWA0_MINIMUM_PAUSE_1 + offset).Value = ConvertiTempoSECtoS7(0)
                'DBD 338
                CP240.OPCData.items(PLCTAG_SIWA0_QUANTITY_PER_PULSE_2 + offset).Value = 0
                'DBD 342
                CP240.OPCData.items(PLCTAG_SIWA0_PULSE_2_DURATION + offset).Value = ConvertiTempoSECtoS7(0)
                'DBD 346
                CP240.OPCData.items(PLCTAG_SIWA0_MINIMUM_PAUSE_2 + offset).Value = ConvertiTempoSECtoS7(0)
                'DBD 350
                CP240.OPCData.items(PLCTAG_SIWA0_OVERLOAD_TIME + offset).Value = ConvertiTempoSECtoS7(0)

                'Sono nella DR7
                'DBB 361
                CP240.OPCData.items(PLCTAG_SIWA0_PROCESS_VALUE_OUTPUT + offset).Value = CByte(41)       'Flow3 = Ton/h
                'DBB 362
                CP240.OPCData.items(PLCTAG_SIWA0_PROCESS_VALUE_OUTPUT_2 + offset).Value = CByte(31)     'Totalizer1 = Kg pesati
                'DBD 384
                CP240.OPCData.items(PLCTAG_SIWA0_ANALOG_OUT_ZERO + offset).Value = CDbl(0)              'Min % A.O.
                'DBD 388
                CP240.OPCData.items(PLCTAG_SIWA0_ANALOG_OUT_END + offset).Value = CDbl(100)             'Max % A.O.
                'DBD 392
                CP240.OPCData.items(PLCTAG_SIWA0_ANALOG_OUT_CONST + offset).Value = CDbl(0)             'Simulazione A.O.
                'DBB 396
                CP240.OPCData.items(PLCTAG_SIWA0_ANALOG_OUT_SOURCE + offset).Value = CByte(0)           'Simatic S7 controllo
                'DBX 397.0
                CP240.OPCData.items(PLCTAG_SIWA0_ANALOG_OUT_4_20_M_AMP + offset).Value = CBool(True)    'True = 4-20 mA
                'DBB 404
                CP240.OPCData.items(PLCTAG_SIWA0_DEFINITION_DO1 + offset).Value = CByte(32)             'Avvia nastro
                'DBB 405
                CP240.OPCData.items(PLCTAG_SIWA0_DEFINITION_DO2 + offset).Value = CByte(61)             'Batch attivo
                'DBB 406
                CP240.OPCData.items(PLCTAG_SIWA0_DEFINITION_DO3 + offset).Value = CByte(62)             'Batch finito
                'DBB 416
                CP240.OPCData.items(PLCTAG_SIWA0_DEFINITION_DI1 + offset).Value = CByte(101)            'Spegni Nastro
                'DBB 417
                CP240.OPCData.items(PLCTAG_SIWA0_DEFINITION_DI2 + offset).Value = CByte(107)            'Avvia Batch
                'DBB 418
                CP240.OPCData.items(PLCTAG_SIWA0_DEFINITION_DI3 + offset).Value = CByte(103)            'Abort

                CodiceComandoSiwarex = 103
                Call AttivaComandoSiwarex(siwarexIndex)
                
                StepScriviDR5 = 0
                FrmSiwarexPara.TimerScriviDR5.enabled = False
                FrmSiwarexPara.TimerScriviDR5.Interval = 2000
                FrmSiwarexPara.TimerScriviDR5.enabled = True
                CP240.OPCData.SOUpdate
        End Select
    End With

End Sub

Public Function PredosatoriSiwarex() As Boolean
'Verifica se tra i predosatori è stata usata una siwarex

    Dim indice As Integer

    PredosatoriSiwarex = False
    For indice = 0 To SiwarexEnum.SivarexMax - 1
        If (Siwarex(indice).presente And Siwarex(indice).SuPredosatore) Then
            PredosatoriSiwarex = True
            Exit Function
        End If
    Next indice

End Function

Public Function AssociaSiwarexPredosatori()
'Associa le siwarex ai predosatori

    Dim indice As Integer
    Dim predosatore As Integer

    For indice = 0 To SiwarexEnum.SivarexMax - 1
        Siwarex(indice).presente = False
        Siwarex(indice).SuPredosatore = ( _
            indice = SiwarexEnum.SiwarexPredosatore1 Or _
            indice = SiwarexEnum.SiwarexPredosatore2 Or _
            indice = SiwarexEnum.SiwarexRiciclato3 Or _
            indice = SiwarexEnum.SiwarexRiciclato4 _
            )
    Next indice

    For predosatore = 0 To MAXPREDOSATORI - 1
        With ListaPredosatori(predosatore)
            If (.bilanciaPresente And .bilanciaSiwarex) Then
                Siwarex(.bilanciaSiwarexIndice).presente = True
            End If
        End With
    Next predosatore
    For predosatore = 0 To MAXPREDOSATORIRICICLATO - 1
        With ListaPredosatoriRic(predosatore)
            If (.bilanciaPresente And .bilanciaSiwarex) Then
                Siwarex(.bilanciaSiwarexIndice).presente = True
            End If
        End With
    Next predosatore

End Function

Public Sub INVIA_DatiRapSiwa(Optional AvvioProgramma As Boolean)
'DR21

    If (DEMO_VERSION) Then
        Exit Sub
    End If

    If AvvioProgramma Then
        CP240.OPCData.items(PLCTAG_SIWA4_SET_KG).Value = 0
        CP240.OPCData.items(PLCTAG_SIWA4_VOLO_KG).Value = 0
        CP240.OPCData.items(PLCTAG_SIWA4_ANALOG_OUT_VALUE).Value = 50
    End If

    CP240.OPCData.items(PLCTAG_SIWA4_LOG_SELECTION).Value = 0
    CodiceComandoSiwarex = 421
    Call AttivaComandoSiwarex(SiwarexRiciclatoFreddo)
    
End Sub

Public Function DefinisciTAG_LOG_COMANDI_SIWA5() As Integer
Dim i As Integer
Dim DBNumber As String
    
    'Formato OPC server Softing
    'db<n>.dbx1.2:bool
    'db<n>.dbw2:int
    'db<n>.dbd4:real
    'db<n>.dbd8:dint
    'db<n>.dbd10:time
    'db<n>.dbb14:byte


    DefinisciTAG_LOG_COMANDI_SIWA5 = 0

    DBNumber = "plc4/DB611.db"

    With CP240.OPCData.items
        
        .AddItem (DBNumber & "W56:int")
        DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
        For i = 0 To 99
            .AddItem (DBNumber & "B" & i * 8 + 60 & ":byte")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
            .AddItem (DBNumber & "B" & i * 8 + 61 & ":byte")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
            .AddItem (DBNumber & "B" & i * 8 + 62 & ":byte")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
            .AddItem (DBNumber & "B" & i * 8 + 63 & ":byte")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
            .AddItem (DBNumber & "B" & i * 8 + 64 & ":byte")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
            .AddItem (DBNumber & "B" & i * 8 + 65 & ":byte")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
            .AddItem (DBNumber & "D" & i * 4 + 860 & ":DInt")
            DefinisciTAG_LOG_COMANDI_SIWA5 = DefinisciTAG_LOG_COMANDI_SIWA5 + 1
        Next i
        
    End With

End Function


Public Sub LeggiDatiDaSiwarex(step As Integer, bilancia As SiwarexEnum)
   
    With FrmSiwarexPara
        Select Case step
            Case 0
                CodiceComandoSiwarex = 203
                'Devo rileggere i parametri
                StepDR33 = 0
                .TimerDR03.enabled = False
                .TimerDR03.Interval = 1000
                .TimerDR03.enabled = True

            Case 1
                CodiceComandoSiwarex = 205

                'Faccio leggere anche i totalizzatori
                StepDR33 = 0
                .TimerTotalizer.enabled = False
                .TimerTotalizer.Interval = 1000
                .TimerTotalizer.enabled = True

            Case 2
                CodiceComandoSiwarex = 230

                'Devo rileggere i parametri
                StepDR30 = 0
                .TimerDR30.enabled = False
                .TimerDR30.Interval = 1000
                .TimerDR30.enabled = True

        End Select
    End With

    Call AttivaComandoSiwarex(bilancia)

End Sub


Public Sub FileToSiwa(siwarexIndex As SiwarexEnum)

    With Siwarex(siwarexIndex)
         'DR3
        .SIWA_DIGIT_ZERO = CStr(.SIWA_DIGIT_ZERO_FILE)
        .SIWA_DIGIT_TARATURA = CStr(.SIWA_DIGIT_TARATURA_FILE)
        .SIWA_PESO_TARATURA = CStr(.SIWA_PESO_TARATURA_FILE)
        .SIWA_MILLIVOLT = CStr(.SIWA_MILLIVOLT_FILE)
        .SIWA_FILTRO_FREQ = CStr(.SIWA_FILTRO_FREQ_FILE)
        .SIWA_FILTRO_MEDIA = CStr(.SIWA_FILTRO_MEDIA_FILE)
        .SIWA_AUTOZERO = CStr(.SIWA_AUTOZERO_FILE)
        .SIWA_PERC_SOTTO_ZERO = CStr(.SIWA_PERC_SOTTO_ZERO_FILE)
        .SIWA_PERC_SOPRA_ZERO = CStr(.SIWA_PERC_SOPRA_ZERO_FILE)
        .SIWA_TEMPO_CALIBRAZIONE = CStr(.SIWA_TEMPO_CALIBRAZIONE_FILE)
        
        'DR5
        .SIWA_IMPULSI_METRO = CStr(.SIWA_IMPULSI_METRO_FILE)
        .SIWA_LUNGHEZZA = CStr(.SIWA_LUNGHEZZA_FILE)
        .SIWA_CORREZIONE = CStr(.SIWA_CORREZIONE_FILE)
        .SIWA_MIN_TOTALIZING = CStr(.SIWA_MIN_TOTALIZING_FILE)

        Call SiwarexInviaParametriPlc(siwarexIndex, 0)
        Call SiwarexInviaParametriPlc(siwarexIndex, 1)
        
    End With

End Sub


Public Sub SiwaToFile(siwarexIndex As SiwarexEnum)

    With Siwarex(siwarexIndex)
         'DR3
        FrmSiwarexPara.TxtDR3(0).text = CStr(.SIWA_DIGIT_ZERO)
        FrmSiwarexPara.TxtDR3(1).text = CStr(.SIWA_DIGIT_TARATURA)
        FrmSiwarexPara.TxtDR3(2).text = CStr(.SIWA_PESO_TARATURA)
        FrmSiwarexPara.TxtDR3(3).text = CStr(.SIWA_MILLIVOLT)
        FrmSiwarexPara.TxtDR3(4).text = CStr(.SIWA_FILTRO_FREQ)
        FrmSiwarexPara.TxtDR3(5).text = CStr(.SIWA_FILTRO_MEDIA)
        FrmSiwarexPara.TxtDR3(6).text = CStr(.SIWA_AUTOZERO)
        FrmSiwarexPara.TxtDR3(7).text = CStr(.SIWA_PERC_SOTTO_ZERO)
        FrmSiwarexPara.TxtDR3(8).text = CStr(.SIWA_PERC_SOPRA_ZERO)
        FrmSiwarexPara.TxtDR3(9).text = CStr(.SIWA_TEMPO_CALIBRAZIONE)

        .SIWA_DIGIT_ZERO_FILE = CDbl(FrmSiwarexPara.TxtDR3(0).text)
        .SIWA_DIGIT_TARATURA_FILE = CDbl(FrmSiwarexPara.TxtDR3(1).text)
        .SIWA_PESO_TARATURA_FILE = CDbl(FrmSiwarexPara.TxtDR3(2).text)
        .SIWA_MILLIVOLT_FILE = CInt(FrmSiwarexPara.TxtDR3(3).text)
        .SIWA_FILTRO_FREQ_FILE = CInt(FrmSiwarexPara.TxtDR3(4).text)
        .SIWA_FILTRO_MEDIA_FILE = CInt(FrmSiwarexPara.TxtDR3(5).text)
        .SIWA_AUTOZERO_FILE = CBool(FrmSiwarexPara.TxtDR3(6).text)
        .SIWA_PERC_SOTTO_ZERO_FILE = CInt(FrmSiwarexPara.TxtDR3(7).text)
        .SIWA_PERC_SOPRA_ZERO_FILE = CInt(FrmSiwarexPara.TxtDR3(8).text)
        .SIWA_TEMPO_CALIBRAZIONE_FILE = CDbl(FrmSiwarexPara.TxtDR3(9).text)
        
        'DR5
        FrmSiwarexPara.TxtDR5(0).text = CStr(.SIWA_IMPULSI_METRO)
        FrmSiwarexPara.TxtDR5(1).text = CStr(.SIWA_LUNGHEZZA)
        FrmSiwarexPara.TxtDR5(2).text = CStr(.SIWA_CORREZIONE)
        FrmSiwarexPara.TxtDR5(3).text = CStr(.SIWA_MIN_TOTALIZING)

        .SIWA_IMPULSI_METRO_FILE = CDbl(FrmSiwarexPara.TxtDR5(0).text)
        .SIWA_LUNGHEZZA_FILE = CDbl(FrmSiwarexPara.TxtDR5(1).text)
        .SIWA_CORREZIONE_FILE = CDbl(FrmSiwarexPara.TxtDR5(2).text)
        .SIWA_MIN_TOTALIZING_FILE = CInt(FrmSiwarexPara.TxtDR5(3).text)

        SiwarexScriviSuFile (siwarexIndex)
    End With

End Sub

