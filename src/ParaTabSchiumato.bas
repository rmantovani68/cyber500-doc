Attribute VB_Name = "ParaTabSchiumato"
'
'   Gestione del bitume schiumato
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Public FrmSchiumaturaVisibile As Boolean

Private FineScaricoBitume As Boolean
Private DosaggioInCorsoBitume As Boolean
Private DosaggioInCorsoBSoft As Boolean

'I TAG ed i relativi indirizzi sono definiti nel file OPCTags.xls (v 9.5.25)
' Per aggiungere/rimuovere TAGs é sufficiente:
' - modificare il relativo foglio del file XLS
' - copiare la prima colonna del foglio e ripopolare l'Enum ed aggiungere sempre l'ultimo valore "PLCTAGWAMFOAM_COUNT")
'La registrazione dei TAG definiti nel file XLS viene effettuata dalla funzione LoadOPCTags()
Public Enum PlcSchiumatoEnum

    LoPortataBitume_idx
    HiPortataBitume_idx
    PortataBitume_idx
    LoPortataH2O_idx
    HiPortataH2O_idx
    PortataH2O_idx
    LoSetBitume_idx
    HiSetBitume_idx
    SetPortataBitume_idx
    LoSetH2O_idx
    HiSetH2O_idx
    SetPortataH2O_idx
    LoSetAggregatiUNUSED_idx
    HiSetAggregatiUNUSED_idx
    PesoAggregatiUNUSED_idx
    LoTempBitume_idx
    HiTempBitume_idx
    TemperaturaBitume_idx
    LoTempBitumeM_idx
    HiTempBitumeM_idx
    TemperaturaBitumeM_idx
    LoTempOlio_idx
    HiTempOlio_idx
    TemperaturaOlio_idx
    LoTempRampa_idx
    HiTempRampa_idx
    TemperaturaRampa_idx
    LoLIBERO_idx
    HiLIBERO_idx
    LIBERO_idx
    LoPressH2O_idx
    HiPressH2O_idx
    PressioneH2O_idx
    LoPressRampa_idx
    HiPressRampa_idx
    PressioneRampa_idx
    LoSetPortataBSoft_idx
    HiSetPortataBSoft_idx
    SetPortataBSoft_idx
    LoTempBSoftM_idx
    HiTempBSoftM_idx
    TemperaturaBSoftM_idx
    LoTempOlioBSoft_idx
    HiTempOlioBSoft_idx
    TemperaturaOlioBSoft_idx
    PercentualeH2O_idx
    TempoRegolatoreH2O_idx
    GuadagnoRegolatoreH2O_idx
    BandaMortaRegolatoreH2O_idx
    RitardoStabMisuraBitume_idx
    VelocitaInverterH2O_idx
    AutomaticoCiclo_idx
    Emergenza_idx
    AbilitaCiclo_idx
    ScaricoAggregati_idx
    CollegamentoPC_idx
    WatchDog_idx
    AutomaticoMotori_Idx
    PesoAggregati_idx
    MinPressioneRampa_idx
    MaxPressioneRampa_idx
    MinTemperaturaRampa_idx
    MaxTemperaturaRampa_idx
    TimeoutPressioneRampa_idx
    All_001_idx
    All_002_idx
    All_003_idx
    All_004_idx
    All_005_idx
    All_006_idx
    All_007_idx
    All_008_idx
    All_009_idx
    All_010_idx
    All_011_idx
    All_012_idx
    All_013_idx
    All_014_idx
    All_015_idx
    All_016_idx
    All_017_idx
    All_018_idx
    All_019_idx
    All_020_idx
    All_021_idx
    All_022_idx
    All_023_idx
    All_024_idx
    All_025_idx
    All_026_idx
    All_027_idx
    All_028_idx
    All_029_idx
    All_030_idx
    All_031_idx
    All_032_idx
    All_033_idx
    All_034_idx
    All_035_idx
    All_036_idx
    All_037_idx
    All_038_idx
    All_039_idx
    All_040_idx
    All_041_idx
    All_042_idx
    All_043_idx
    All_044_idx
    All_045_idx
    All_046_idx
    All_047_idx
    All_048_idx
    All_049_idx
    All_050_idx
    All_051_idx
    All_052_idx
    All_053_idx
    All_054_idx
    All_055_idx
    All_056_idx
    All_057_idx
    All_058_idx
    All_059_idx
    All_060_idx
    All_061_idx
    All_062_idx
    All_063_idx
    All_064_idx
    All_065_idx
    All_066_idx
    All_067_idx
    All_068_idx
    All_069_idx
    All_070_idx
    All_071_idx
    All_072_idx
    All_073_idx
    All_074_idx
    All_075_idx
    All_076_idx
    All_077_idx
    All_078_idx
    All_079_idx
    All_080_idx
    All_081_idx
    All_082_idx
    All_083_idx
    All_084_idx
    All_085_idx
    All_086_idx
    All_087_idx
    All_088_idx
    All_089_idx
    All_090_idx
    All_091_idx
    All_092_idx
    All_093_idx
    All_094_idx
    All_095_idx
    All_096_idx
    All_097_idx
    All_098_idx
    All_099_idx
    All_100_idx
    All_101_idx
    All_102_idx
    All_103_idx
    All_104_idx
    All_105_idx
    All_106_idx
    All_107_idx
    All_108_idx
    All_109_idx
    All_110_idx
    All_111_idx
    All_112_idx
    All_113_idx
    All_114_idx
    All_115_idx
    All_116_idx
    All_117_idx
    All_118_idx
    All_119_idx
    All_120_idx
    All_121_idx
    All_122_idx
    All_123_idx
    All_124_idx
    All_125_idx
    All_126_idx
    All_127_idx
    All_128_idx
    horn_alarm_idx
    lamp_alarm_idx
    alarm_on_idx
    alarm_reset_idx
    IvalvBitumeON_idx
    IvalvBitumeOFF_idx
    IpompaBitumeAvanti_idx
    IpompaBitumeIndietro_idx
    IvalvImmissBitumeON_idx
    IvalvImmissBitumeOFF_idx
    IpompaAcquaON_idx
    IvalvAcquaON_idx
    IvalvAcquaOFF_idx
    IvalvImmissAcquaON_idx
    IvalvImmissAcquaOFF_idx
    DosaggioInCorso_idx
    ManValvBitume_idx
    ManPompaBitume_idx
    ManPompaBitumeIndietro_idx
    ManValvImmissioneBitume_idx
    ManPompaAcqua_idx
    ManValvAcqua_idx
    ManValvImmissSolvente_idx
    BitumeAperto_idx
    AbortCicloBitume_idx
    StepBitume_idx
    PercentualeBitume_idx
    SetImpulsiBitume_idx
    ConteggioImpulsiBitume_idx
    MinPesoAggregati_idx
    MinTemperaturaBitume_idx
    MaxTemperaturaBitume_idx
    DeltaTemperaturaOlio_idx
    MinPressioneAcqua_idx
    MaxPressioneAcqua_idx
    RitardoAvvioCiclo_idx
    RitardoAvvioCiclo_ET_idx
    RitardoAvvioBitume_idx
    RitardoFineAcqua_idx
    TempoValvBitume_idx
    TempoPompaBitume_idx
    TempoValvImmissBitume_idx
    TempoBassaTempBitume_idx
    TempoPompaAcqua_idx
    TempoValvAcqua_idx
    TempoValvSolvente_idx
    TempoImpulsiBitume_idx
    TolleranzaHard_idx
    NettoBitumeHard_idx
    NumeroImpulsiKgHard_idx
    VelocitaInverterHard_idx
    IvalvBSoftON_idx
    IvalvBSoftOFF_idx
    IpompaBSoftAvanti_idx
    IpompaBSoftIndietro_idx
    IvalvImmissBSoftON_idx
    IvalvImmissBSoftOFF_idx
    DosaggioInCorsoBSoft_idx
    ManValvBSoft_idx
    ManPompaBSoft_idx
    ManPompaBSoftIndietro_idx
    ManValvImmissioneBSoft_idx
    BSoftAperto_idx
    AbortCicloBsoft_idx
    abilitabitumesoft_idx
    StepBSoft_idx
    PercentualeBSoft_idx
    SetImpulsiBSoft_idx
    ConteggioImpulsiBSoft_idx
    MinPesoAggregatiBSoft_idx
    MinTemperaturaBSoft_idx
    MaxTemperaturaBSoft_idx
    MinPressioneBSoft_idx
    MaxPressioneBSoft_idx
    RitardoAvvioCicloBSoft_idx
    RitardoAvvioCicloBSoft_ET_idx
    TempoValvBSoft_idx
    TempoPompaBSoft_idx
    TempoValvImmissBSoft_idx
    TempoBassaTempBSoft_idx
    TempoImpulsiBSoft_idx
    TolleranzaSoft_idx
    NettoBitumeSoft_idx
    NumeroImpulsiKgSoft_idx
    VelocitaInverterSoft_idx
    ValoreAnalogico0_idx
    ValoreAnalogico1_idx
    ValoreAnalogico2_idx
    ValoreAnalogico3_idx
    ValoreAnalogico4_idx
    ValoreAnalogico5_idx
    ValoreAnalogico6_idx
    ValoreAnalogico7_idx
    ValoreAnalogico8_idx
    ValoreAnalogico9_idx
    ValoreAnalogico10_idx
    ValoreAnalogico11_idx
    ValoreAnalogico12_idx
    ValoreAnalogico13_idx
    ValoreAnalogico14_idx
    ValoreAnalogico15_idx
    DO_Pompa_Soft_Comando_idx
    DI_Pompa_Soft_Ritorno_idx
    DI_Pompa_Soft_Termica_idx
    DO_Pompa_Soft_Comando_Inversione_idx
    DI_Pompa_Soft_Ritorno_Inversione_idx
    ValoreDigitale0_idx
    ValoreDigitale1_idx
    ValoreDigitale2_idx
    ValoreDigitale3_idx
    ValoreDigitale4_idx
    ValoreDigitale5_idx

    PLCTAGWAMFOAM_COUNT
End Enum

'   Contenitore dei dati del PLC sul file
Public Type PlcSchiumatoType

    Abilitazione As Boolean
    abilitazioneSoft As Boolean

    inversionePompaBitume As Boolean
    inversionePompaBSoft As Boolean

    'DB1
    LoPortataBitume As Double           'Valore riferito allo 0 della portata del bitume (Kg/h)
    HiPortataBitume As Double           'Valore riferito al max della portata del bitume (Kg/h)
    LoPortataH2O As Double              'Valore riferito allo 0 della portata dell'acqua (Kg/h)
    HiPortataH2O As Double              'Valore riferito al max della portata dell'acqua (Kg/h)
    LoSetBitume As Double               'Valore riferito allo 0 del riferimento del bitume (Kg/h)
    HiSetBitume As Double               'Valore riferito al max del riferimento del bitume (Kg/h)
    LoSetH2O As Double                  'Valore riferito allo 0 del riferimento dell'acqua (Kg/h)
    HiSetH2O As Double                  'Valore riferito al max del riferimento dell'acqua (Kg/h)
    LoTempBitume As Double              'Min di riferimento per la temperatura del bitume
    HiTempBitume As Double              'Max di riferimento per la temperatura del bitume
    LoTempBitumeM As Double             'Min di riferimento per la temperatura del bitume del massico
    HiTempBitumeM As Double             'Max di riferimento per la temperatura del bitume del massico
    LoTempOlio As Double                'Min di riferimento per la temperatura dell'olio
    HiTempOlio As Double                'Max di riferimento per la temperatura dell'olio
    LoTempRampa As Double               'Min di riferimento per la temperatura della rampa
    HiTempRampa As Double               'Max di riferimento per la temperatura della rampa
    LoPressH2O As Double                'Min di riferimento per la pressione dell'acqua
    HiPressH2O As Double                'Max di riferimento per la pressione dell'acqua
    LoPressRampa As Double              'Min di riferimento per la pressione della rampa
    HiPressRampa As Double              'Max di riferimento per la pressione della rampa
    LoSetPortataBSoft As Double         'Valore riferito allo 0 della portata del bitume SOFT (Kg/h)
    HiSetPortataBSoft As Double         'Valore riferito al max della portata del bitume SOFT (Kg/h)
    LoTempBSoftM As Double              'Min di riferimento per la temperatura del bitume SOFT (massico)
    HiTempBSoftM As Double              'Max di riferimento per la temperatura del bitume SOFT (massico)
    LoTempOlioBSoft As Double           'Min di riferimento per la temperatura dell'olio bitume SOFT
    HiTempOlioBSoft As Double           'Max di riferimento per la temperatura dell'olio bitume SOFT
    Perc_Velox_H2O As Long              'Percentuale della velocità massima dell'inverter

    'DB2
    PercentualeH2O As Double            'Percentuale di H20 riferita al bitume
    TempoRegolatoreH2O As Long          'Tempo di scansione per regolare H2O (msec.)
    GuadagnoRegolatoreH2O As Double     'Fattore moltiplicativo per aumento/riduzione acqua
    BandaMortaRegolatoreH2O As Double   'Banda morta regolatore
    RitardoStabMisuraBitume As Long     'Ritardo stabilizzazione misura bitume

    'DB4
    MinPressioneRampa As Double         'Minima pressione della rampa
    MaxPressioneRampa As Double         'Massima pressione della rampa
    MinTemperaturaRampa As Double       'Minima temperatura della rampa
    MaxTemperaturaRampa As Double       'Massima temperatura della rampa
    TimeoutPressioneRampa As Long       'Timeout nel controllo della bassa pressione della rampa

    'DB40
    MinPesoAggregati As Double          'Minimo peso degli aggregati (allarme se inferiore)
    MinTemperaturaBitume As Double      'Minima temperatura del bitume (allarme se inferiore)
    MaxTemperaturaBitume As Double      'Massima temperatura del bitume (allarme se superiore)
    DeltaTemperaturaOlio As Double      'Differenza min/max fra temperatura bitume e olio
    MinPressioneAcqua As Double         'Minima pressione dell'acqua (allarme se inferiore)
    MaxPressioneAcqua As Double         'Massima pressione dell'acqua (allarme se superiore)
    RitardoAvvioBitume As Long          'Ritardo all'avvio del bitume (dall'avvio dell'acqua)
    RitardoFineAcqua As Long            'Ritardo alla fine dell'acqua (dalla fine del bitume)
    TempoValvBitume As Long             'Timeout comando di apertura/chiusura della valvola del bitume
    TempoPompaBitume As Long            'Timeout accensione/spegnimento della pompa del bitume
    TempoValvImmissBitume As Long       'Timeout comando di apertura/chiusura valvola immissione bitume
    TempoBassaTempBitume As Long        'Timeout bassa temperatura del bitume
    TempoPompaAcqua As Long             'Timeout accensione/spegnimento della pompa dell'acqua
    TempoValvAcqua As Long              'Timeout comando di apertura/chiusura valvola dell'acqua
    TempoValvSolvente As Long           'Timeout comando di apertura/chiusura valvola del solvente
    TempoImpulsiBitume As Long          'Timeout nella sequenza degli impulsi del bitume
    TolleranzaHard As Integer           'Tolleranza sulla pesata
    NettoHard As Double                 'Netto Bitume Hard
    ImpulsiKgHard As Double             'Numero impulsi Kg
    MinimoKgHard As Double              'Kg minimi da dosare
    Perc_Velox_BHard As Long            'Percentuale della velocità massima dell'inverter

    'DB41
    MinPesoAggregatiBSoft As Double     'Minimo peso degli aggregati (allarme se inferiore)
    MinTemperaturaBSoft As Double       'Minima temperatura del bitume (allarme se inferiore)
    MaxTemperaturaBSoft As Double       'Massima temperatura del bitume (allarme se superiore)
    TempoValvBSoft As Long              'Timeout comando di apertura/chiusura della valvola del bitume
    TempoPompaBSoft As Long             'Timeout accensione/spegnimento della pompa del bitume
    TempoValvImmissBSoft As Long        'Timeout comando di apertura/chiusura valvola immissione bitume
    TempoBassaTempBSoft As Long         'Timeout bassa temperatura del bitume
    TempoImpulsiBSoft As Long           'Timeout nella sequenza degli impulsi del bitume
    TolleranzaSoft As Integer           'Tolleranza sulla pesata
    NettoSoft As Double                 'Netto Bitume Soft
    ImpulsiKgSoft As Double             'Numero impulsi Kg
    MinimoKgSoft As Double              'Kg minimi da dosare
    Perc_Velox_BSoft As Long            'Percentuale della velocità massima dell'inverter
    
    'DB246
    DI_Pompa_Soft_Ritorno As Boolean
    DI_Pompa_Soft_Termica As Boolean
    DI_Pompa_Soft_Ritorno_Inversione As Boolean
    
    TempoMinimoSchiumatura As Long
    TempoMassimoSchiumatura As Long
    FlussoTeoricoB_Hard As Long
    Perc_Velox_BHard_Ottimale As Long
    
End Type

Public PlcSchiumato As PlcSchiumatoType


Private Const SEZIONE As String = "Schiumato"

Public Schiumato_FC_Valv3Vie_Norm As Boolean
Public Schiumato_FC_Valv3Vie_Soft As Boolean
Public OraAllarme_FC_Valv3Vie_Norm_Soft As Long

Public SchiumatoOraStartSchiumatura As Long
'



'   Lettura del file
Public Function ParaTabSchiumato_ReadFile() As Boolean

    Dim nomeFile As String


    ParaTabSchiumato_ReadFile = False

    'CYBERTRONIC_PLUS

    With PlcSchiumato

        .Abilitazione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Presente"))
        .abilitazioneSoft = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitazioneSoft"))

        .LoPortataBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoPortataBitume"))
        .HiPortataBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiPortataBitume"))
        .LoPortataH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoPortataH2O"))
        .HiPortataH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiPortataH2O"))
        .LoSetBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoSetBitume"))
        .HiSetBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiSetBitume"))
        .LoSetH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoSetH2O"))
        .HiSetH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiSetH2O"))
        .LoTempBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoTempBitume"))
        .HiTempBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiTempBitume"))
        .LoTempBitumeM = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoTempBitumeM"))
        .HiTempBitumeM = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiTempBitumeM"))
        .LoTempOlio = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoTempOlio"))
        .HiTempOlio = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiTempOlio"))
        .LoTempRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoTempRampa"))
        .HiTempRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiTempRampa"))
        .LoPressH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoPressH2O"))
        .HiPressH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiPressH2O"))
        .LoPressRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoPressRampa"))
        .HiPressRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiPressRampa"))
        .LoSetPortataBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoSetPortataBSoft"))
        .HiSetPortataBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiSetPortataBSoft"))
        .LoTempBSoftM = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoTempBSoftM"))
        .HiTempBSoftM = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiTempBSoftM"))
        .LoTempOlioBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "LoTempOlioBSoft"))
        .HiTempOlioBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "HiTempOlioBSoft"))

        .PercentualeH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "PercentualeH2O"))
        .TempoRegolatoreH2O = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoRegolatoreH2O"))
        .GuadagnoRegolatoreH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "GuadagnoRegolatoreH2O"))
        .BandaMortaRegolatoreH2O = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "BandaMortaRegolatoreH2O"))
        .RitardoStabMisuraBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RitardoStabMisuraBitume"))
        .Perc_Velox_H2O = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Perc_Velox_H2O"))

        .MinPressioneRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinPressioneRampa"))
        .MaxPressioneRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxPressioneRampa"))
        .MinTemperaturaRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinTemperaturaRampa"))
        .MaxTemperaturaRampa = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxTemperaturaRampa"))
        .TimeoutPressioneRampa = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TimeoutPressioneRampa"))
        .TempoMinimoSchiumatura = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoMinimoSchiumatura"))
        .TempoMassimoSchiumatura = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoMassimoSchiumatura"))
        
        .MinPesoAggregati = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinPesoAggregati"))
        .MinTemperaturaBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinTemperaturaBitume"))
        .MaxTemperaturaBitume = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxTemperaturaBitume"))
        .DeltaTemperaturaOlio = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "DeltaTemperaturaOlio"))
        .MinPressioneAcqua = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinPressioneAcqua"))
        .MaxPressioneAcqua = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxPressioneAcqua"))
        .RitardoAvvioBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RitardoAvvioBitume"))
        .RitardoFineAcqua = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RitardoFineAcqua"))
        .TempoValvBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoValvBitume"))
        .TempoPompaBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoPompaBitume"))
        .TempoValvImmissBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoValvImmissBitume"))
        .TempoBassaTempBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoBassaTempBitume"))
        .TempoPompaAcqua = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoPompaAcqua"))
        .TempoValvAcqua = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoValvAcqua"))
        .TempoValvSolvente = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoValvSolvente"))
        .TempoImpulsiBitume = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoImpulsiBitume"))
        .ImpulsiKgHard = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ImpulsiKgHard"))
        .MinimoKgHard = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinimoKgHard"))
        .Perc_Velox_BHard = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Perc_Velox_BHard"))
        .Perc_Velox_BHard_Ottimale = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Perc_Velox_BHard_Ottimale"))

        .MinPesoAggregatiBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinPesoAggregatiBSoft"))
        .MinTemperaturaBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinTemperaturaBSoft"))
        .MaxTemperaturaBSoft = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxTemperaturaBSoft"))
        .TempoValvBSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoValvBSoft"))
        .TempoPompaBSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoPompaBSoft"))
        .TempoValvImmissBSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoValvImmissBSoft"))
        .TempoBassaTempBSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoBassaTempBSoft"))
        .TempoImpulsiBSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoImpulsiBSoft"))
        .ImpulsiKgSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ImpulsiKgSoft"))
        .MinimoKgSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MinimoKgSoft"))
        .Perc_Velox_BSoft = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Perc_Velox_BSoft"))

    End With

    ParaTabSchiumato_ReadFile = True
        
End Function

'   Salva i valori nel PLC
Public Sub PlcSchiumatoInviaParametri()

    If (Not PlcSchiumatoConnesso) Then
        Exit Sub
    End If

    With CP240.OPCDataSchiumato

        'DB1
        .items(PlcSchiumatoEnum.LoPortataBitume_idx).Value = PlcSchiumato.LoPortataBitume
        .items(HiPortataBitume_idx).Value = PlcSchiumato.HiPortataBitume

        .items(LoPortataH2O_idx).Value = PlcSchiumato.LoPortataH2O
        .items(HiPortataH2O_idx).Value = PlcSchiumato.HiPortataH2O

        .items(LoSetBitume_idx).Value = PlcSchiumato.LoSetBitume
        .items(HiSetBitume_idx).Value = PlcSchiumato.HiSetBitume

        .items(LoSetH2O_idx).Value = PlcSchiumato.LoSetH2O
        .items(HiSetH2O_idx).Value = PlcSchiumato.HiSetH2O

        .items(LoTempBitume_idx).Value = PlcSchiumato.LoTempBitume
        .items(HiTempBitume_idx).Value = PlcSchiumato.HiTempBitume

        .items(LoTempBitumeM_idx).Value = PlcSchiumato.LoTempBitumeM
        .items(HiTempBitumeM_idx).Value = PlcSchiumato.HiTempBitumeM

        .items(LoTempOlio_idx).Value = PlcSchiumato.LoTempOlio
        .items(HiTempOlio_idx).Value = PlcSchiumato.HiTempOlio

        .items(LoTempRampa_idx).Value = PlcSchiumato.LoTempRampa
        .items(HiTempRampa_idx).Value = PlcSchiumato.HiTempRampa

        .items(LoPressH2O_idx).Value = PlcSchiumato.LoPressH2O
        .items(HiPressH2O_idx).Value = PlcSchiumato.HiPressH2O

        .items(LoPressRampa_idx).Value = PlcSchiumato.LoPressRampa
        .items(HiPressRampa_idx).Value = PlcSchiumato.HiPressRampa

        .items(LoSetPortataBSoft_idx).Value = PlcSchiumato.LoSetPortataBSoft
        .items(HiSetPortataBSoft_idx).Value = PlcSchiumato.HiSetPortataBSoft

        .items(LoTempBSoftM_idx).Value = PlcSchiumato.LoTempBSoftM
        .items(HiTempBSoftM_idx).Value = PlcSchiumato.HiTempBSoftM
    
        .items(LoTempOlioBSoft_idx).Value = PlcSchiumato.LoTempOlioBSoft
        .items(HiTempOlioBSoft_idx).Value = PlcSchiumato.HiTempOlioBSoft

        'DB2
        .items(PercentualeH2O_idx).Value = PlcSchiumato.PercentualeH2O
        .items(TempoRegolatoreH2O_idx).Value = PlcSchiumato.TempoRegolatoreH2O

        .items(GuadagnoRegolatoreH2O_idx).Value = PlcSchiumato.GuadagnoRegolatoreH2O / 100  'espresso in percentuale
        .items(BandaMortaRegolatoreH2O_idx).Value = PlcSchiumato.BandaMortaRegolatoreH2O    'espresso in litri/ora
        '
        .items(RitardoStabMisuraBitume_idx).Value = PlcSchiumato.RitardoStabMisuraBitume

        .items(VelocitaInverterH2O_idx).Value = PlcSchiumato.Perc_Velox_H2O * 27648 / 100
        '
        '.Items(SetPortataH2O_idx).value 'L'acqua ha un suo calcolo per la velox in automatico

        'DB4
        .items(MinPressioneRampa_idx).Value = PlcSchiumato.MinPressioneRampa
        .items(MaxPressioneRampa_idx).Value = PlcSchiumato.MaxPressioneRampa
        .items(MinTemperaturaRampa_idx).Value = PlcSchiumato.MinTemperaturaRampa
        .items(MaxTemperaturaRampa_idx).Value = PlcSchiumato.MaxTemperaturaRampa
        .items(TimeoutPressioneRampa_idx).Value = PlcSchiumato.TimeoutPressioneRampa

        'DB40
        .items(MinPesoAggregati_idx).Value = PlcSchiumato.MinPesoAggregati
        .items(MinTemperaturaBitume_idx).Value = PlcSchiumato.MinTemperaturaBitume
        .items(MaxTemperaturaBitume_idx).Value = PlcSchiumato.MaxTemperaturaBitume
        .items(DeltaTemperaturaOlio_idx).Value = PlcSchiumato.DeltaTemperaturaOlio
        .items(MinPressioneAcqua_idx).Value = PlcSchiumato.MinPressioneAcqua
        .items(MaxPressioneAcqua_idx).Value = PlcSchiumato.MaxPressioneAcqua
        .items(RitardoAvvioBitume_idx).Value = PlcSchiumato.RitardoAvvioBitume
        .items(RitardoFineAcqua_idx).Value = PlcSchiumato.RitardoFineAcqua
        .items(TempoValvBitume_idx).Value = PlcSchiumato.TempoValvBitume
        .items(TempoPompaBitume_idx).Value = PlcSchiumato.TempoPompaBitume
        .items(TempoValvImmissBitume_idx).Value = PlcSchiumato.TempoValvImmissBitume
        .items(TempoBassaTempBitume_idx).Value = PlcSchiumato.TempoBassaTempBitume
        .items(TempoPompaAcqua_idx).Value = PlcSchiumato.TempoPompaAcqua
        .items(TempoValvAcqua_idx).Value = PlcSchiumato.TempoValvAcqua
        .items(TempoValvSolvente_idx).Value = PlcSchiumato.TempoValvSolvente
        .items(TempoImpulsiBitume_idx).Value = PlcSchiumato.TempoImpulsiBitume
        .items(NumeroImpulsiKgHard_idx).Value = 1 / PlcSchiumato.ImpulsiKgHard
        .items(VelocitaInverterHard_idx).Value = (PlcSchiumato.Perc_Velox_BHard * 27648 / 100) * (PlcSchiumato.Perc_Velox_BHard_Ottimale / 100)
        .items(SetPortataBitume_idx).Value = PlcSchiumato.LoPortataBitume + PlcSchiumato.Perc_Velox_BHard * (PlcSchiumato.HiSetPortataBSoft - PlcSchiumato.LoPortataBitume) / 100

        'DB41
        .items(MinPesoAggregatiBSoft_idx).Value = PlcSchiumato.MinPesoAggregatiBSoft
        .items(MinTemperaturaBSoft_idx).Value = PlcSchiumato.MinTemperaturaBSoft
        .items(MaxTemperaturaBSoft_idx).Value = PlcSchiumato.MaxTemperaturaBSoft
        .items(TempoValvBSoft_idx).Value = PlcSchiumato.TempoValvBSoft
        .items(TempoPompaBSoft_idx).Value = PlcSchiumato.TempoPompaBSoft
        .items(TempoValvImmissBSoft_idx).Value = PlcSchiumato.TempoValvImmissBSoft
        .items(TempoBassaTempBSoft_idx).Value = PlcSchiumato.TempoBassaTempBSoft
        .items(TempoImpulsiBSoft_idx).Value = PlcSchiumato.TempoImpulsiBSoft
        .items(abilitabitumesoft_idx).Value = PlcSchiumato.abilitazioneSoft
        .items(NumeroImpulsiKgSoft_idx).Value = 1 / PlcSchiumato.ImpulsiKgSoft
        .items(VelocitaInverterSoft_idx).Value = PlcSchiumato.Perc_Velox_BSoft * 27648 / 100
        .items(SetPortataBSoft_idx).Value = PlcSchiumato.Perc_Velox_BSoft

    End With

End Sub


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabSchiumato_Apply()

    CP240.CmdSchiumatura.Visible = PlcSchiumato.Abilitazione
    CP240.TextTempiRitardoSc(6).Visible = PlcSchiumato.Abilitazione
    CP240.ProgressBil(5).top = CP240.ProgressBil(2).top
    CP240.ProgressBil(5).Visible = PlcSchiumato.Abilitazione
    CP240.ProgressBil(5).max = 100
    CP240.imgValvolaSchiumato.Visible = PlcSchiumato.Abilitazione

    FrmGestioneTimer.TmrSchiumato.enabled = PlcSchiumato.Abilitazione

End Sub


'Riportare i TAG nel file di configurazione OPCTags.xls
Public Function PlcSchiumatoConnessione(connetti As Boolean) As Boolean

    PlcSchiumatoConnessione = False

    On Error GoTo Errore

    If (PlcSchiumato.Abilitazione And connetti) Then

        If (Not CP240.OPCDataSchiumato.IsConnected) Then

            CP240.OPCDataSchiumato.RemoteHost = SetIP
            CP240.OPCDataSchiumato.ServerName = OpcServerName
            CP240.OPCDataSchiumato.UseAsync = True

            LoadOPCTags "WamFoam", CP240.OPCDataSchiumato

            CP240.OPCDataSchiumato.Connect

        End If

    Else

        If (CP240.OPCDataSchiumato.IsConnected) Then

            CP240.OPCDataSchiumato.Disconnect

        End If

    End If

    PlcSchiumatoColoraPulsante

    Call PLCSchiumatoSetAutomaticoMotori(MotoriInAutomatico)

    PlcSchiumatoConnessione = True

    Exit Function
Errore:
    LogInserisci True, "BBL-001", CStr(Err.Number) + " [" + Err.description + "]"
End Function


Public Function PlcSchiumatoConnesso() As Boolean

    Dim connesso As Boolean '21060923
    
    With CP240.OPCDataSchiumato

        '20160923
        'PlcSchiumatoConnesso = (.IsConnected And .items.Count > 0)
        'If (PlcSchiumatoConnesso) Then
        '    PlcSchiumatoConnesso = (GetQuality(.items(0).quality) = STATOOK)
        'End If
        connesso = (.IsConnected And .items.Count > 0)
        If (connesso) Then
            connesso = (GetQuality(.items(0).quality) = STATOOK)
        End If
        PlcSchiumatoConnesso = connesso
        '

    End With

End Function


Public Function PLCSchiumatoOnError() As Boolean

    Debug.Print "PLCSchiumatoOnError"

End Function

Public Sub PLCSchiumato_Timer()

    If (Not PlcSchiumato.Abilitazione Or Not PlcSchiumatoConnesso) Then
        Exit Sub
    End If

    With CP240.OPCDataSchiumato

        .items(CollegamentoPC_idx).Value = True
        .items(WatchDog_idx).Value = True
        
        .items(AbortCicloBitume_idx).Value = (ArrestoUrgenza)
        .items(AbortCicloBsoft_idx).Value = (ArrestoUrgenza)
        

        .SOUpdate

    End With

End Sub

Public Function PLCSchiumatoLetturaDB() As Boolean

    If (FrmSchiumaturaVisibile) Then
        Call FrmSchiumatura.AggiornaStatoSchiumato
    End If

    PlcSchiumatoColoraPulsante      'Pulsante in CP240 sopra il frame dello schiumato
    
    PLCSchiumatoDosaggioBitumeHard      'Dosaggio in corso B.Hard usato per colorare il pulsante
    
    If PlcSchiumato.abilitazioneSoft Then
        PLCSchiumatoDosaggioBitumeSoft  'Dosaggio in corso B.Soft usato per colorare il pulsante
    End If
    
    PLCSchiumatoSetAutomaticoCiclo Not PesaturaManuale
    
    CP240.Picture1(3).Visible = CP240.OPCDataSchiumato.items(Emergenza_idx).Value

    PLCSchiumatoTempoTrascorsoRitardoBitumeHard

    If PlcSchiumato.Abilitazione Then
        PLCSchiumatoGestionePompaSoft
    End If

    PLCSchiumatoLetturaDB = True
    
End Function

Public Function PLCSchiumatoGestionePompaSoft() As Boolean
    
    With CP240
        If .OPCDataSchiumato.IsConnected Then
            PlcSchiumato.DI_Pompa_Soft_Ritorno = .OPCDataSchiumato.items(DI_Pompa_Soft_Ritorno_idx).Value
            PlcSchiumato.DI_Pompa_Soft_Termica = .OPCDataSchiumato.items(DI_Pompa_Soft_Termica_idx).Value
            PlcSchiumato.DI_Pompa_Soft_Ritorno_Inversione = .OPCDataSchiumato.items(DI_Pompa_Soft_Ritorno_Inversione_idx).Value
        End If
        If .OPCData.IsConnected Then
            .OPCData.items(PLCTAG_DI_Pompa_Soft_Ritorno).Value = PlcSchiumato.DI_Pompa_Soft_Ritorno
            .OPCData.items(PLCTAG_DI_Pompa_Soft_Termica).Value = PlcSchiumato.DI_Pompa_Soft_Termica
            .OPCData.items(PLCTAG_DI_Pompa_Soft_Ritorno_Inversione).Value = PlcSchiumato.DI_Pompa_Soft_Ritorno_Inversione
        End If
    End With
    
End Function


Public Function PLCSchiumatoValv3VieBitume_Norm_Soft(FC_Norm As Boolean, FC_Soft As Boolean)

    Dim Errore As Boolean
    Dim Criterio As String
    Dim posizione As Integer

    On Error GoTo Errore

    If CP240.OPCData.items(PLCTAG_DO_ScambioB2).Value Then
        'comando bitume soft
        If FC_Soft And Not FC_Norm Then
            CP240.imgValvolaSchiumato.Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
        Else
            CP240.imgValvolaSchiumato.Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
            Errore = True
        End If
    Else
        'comando bitume normale
        If Not FC_Soft And FC_Norm Then
            CP240.imgValvolaSchiumato.Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
        Else
            CP240.imgValvolaSchiumato.Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
            Errore = True
        End If
    End If
    
    If Errore Then
        CP240.imgValvolaSchiumato.Visible = Not CP240.imgValvolaSchiumato.Visible
        If OraAllarme_FC_Valv3Vie_Norm_Soft = 0 Then
            OraAllarme_FC_Valv3Vie_Norm_Soft = ConvertiTimer()
        Else
            If ConvertiTimer() > OraAllarme_FC_Valv3Vie_Norm_Soft + 5 Then
                Criterio = "WF001"
                posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
                Call IngressoAllarmePresente(posizione, True)
                If DosaggioInCorso Then
                    'Call ArrestoEmergenzaDosaggio
                End If
            End If
        End If
    Else
        CP240.imgValvolaSchiumato.Visible = True
        OraAllarme_FC_Valv3Vie_Norm_Soft = 0
        Criterio = "WF001"
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        Call IngressoAllarmePresente(posizione, False)
    End If
'
    Exit Function
Errore:
    LogInserisci True, "BBL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Function

Private Sub PLCSchiumatoTempoTrascorsoRitardoBitumeHard()
    
    If CP240.OPCDataSchiumato.items(RitardoAvvioCiclo_ET_idx).Value > 0 Then
        CP240.lblEtichetta(46).Visible = True
        If CP240.lblEtichetta(46).BackColor = vbGreen Then
            CP240.lblEtichetta(46).BackColor = vbBlack
            CP240.lblEtichetta(46).ForeColor = vbGreen
        Else
            CP240.lblEtichetta(46).BackColor = vbGreen
            CP240.lblEtichetta(46).ForeColor = vbBlack
        End If
        CP240.lblEtichetta(46).caption = CInt(CP240.OPCDataSchiumato.items(RitardoAvvioCiclo_idx).Value / 1000) - CInt(CP240.OPCDataSchiumato.items(RitardoAvvioCiclo_ET_idx).Value / 1000)
    Else
        CP240.lblEtichetta(46).Visible = False
    
    End If

End Sub


Private Sub PlcSchiumatoColoraPulsante()

    Dim colore As Long

    If (Not PlcSchiumatoConnesso) Then
        colore = vbRed
    ElseIf (CP240.OPCDataSchiumato.items(alarm_on_idx).Value) Then
        'Connesso, con allarmi
        colore = vbRed
    ElseIf (Not CP240.OPCDataSchiumato.items(AutomaticoCiclo_idx).Value) Then
        'Connesso, niente allarmi, manuale
        colore = vbYellow
    Else
        'Connesso, niente allarmi, automatico, nessun dosaggio
        colore = vbBlack
    End If

    CP240.CmdSchiumatura.BackColor = colore

End Sub


Public Function PlcSchiumatoAllarme(ByVal ID As Integer, ByVal allarme As Long) As Boolean

    PlcSchiumatoAllarme = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If
    
    If allarme > 1 Then
        'L'allarme WF001 lo uso per l'errore fine corsa valvola 3 vie bitume normale-soft
        IngressoAllarmePresente ID, CP240.OPCDataSchiumato.items(All_001_idx + allarme - 1).Value
    End If
    
    Select Case allarme
        Case 31
            PLCSchiumatoFineScaricoBitume
        Case 95
    End Select

    PlcSchiumatoAllarme = True

End Function


Public Function PlcSchiumatoAllarmeAccetta() As Boolean

    PlcSchiumatoAllarmeAccetta = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(alarm_reset_idx).Value = True

    PlcSchiumatoAllarmeAccetta = True

End Function


Public Function PLCSchiumatoAbilitaCiclo()

    Dim abilitaCiclo As Boolean


    PLCSchiumatoAbilitaCiclo = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then

        abilitaCiclo = CP240.OPCDataSchiumato.items(AbilitaCiclo_idx).Value

        'FrmSchiumatura.FrameAcqua.enabled = abilitaCiclo
        'FrmSchiumatura.FrameBitumeHard.enabled = abilitaCiclo
        'FrmSchiumatura.FrameBitumeSoft.enabled = abilitaCiclo

    End If

    PLCSchiumatoAbilitaCiclo = True

End Function

Public Function PLCSchiumatoSetAbilitaCiclo()

    PLCSchiumatoSetAbilitaCiclo = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    With CP240.OPCDataSchiumato

        If (.items(AutomaticoCiclo_idx).Value) Then
            'In automatico abilito il ciclo in base alle percentuali di ricetta
            .items(AbilitaCiclo_idx).Value = (.items(PercentualeBitume_idx).Value > 0 And .items(PercentualeBSoft_idx).Value > 0)
        Else
            'Se non è automatico abilito il ciclo di default
            .items(AbilitaCiclo_idx).Value = True
        End If

    End With

    PLCSchiumatoSetAbilitaCiclo = True

End Function

Public Function PLCSchiumatoAutomatico() As Boolean

    PLCSchiumatoAutomatico = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    PLCSchiumatoSetAbilitaCiclo

    PLCSchiumatoAutomatico = True

End Function

Public Function PLCSchiumatoSetAutomaticoCiclo(automatico As Boolean) As Boolean

    PLCSchiumatoSetAutomaticoCiclo = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(AutomaticoCiclo_idx).Value = automatico

    PLCSchiumatoSetAutomaticoCiclo = True

End Function

Public Function PLCSchiumatoSetAutomaticoMotori(automatico As Boolean) As Boolean

    PLCSchiumatoSetAutomaticoMotori = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(AutomaticoMotori_Idx).Value = automatico

    PLCSchiumatoSetAutomaticoMotori = True

End Function


Public Function PLCSchiumatoSetRicetta( _
    setBitumeHard As Double, _
    setBitumeSoft As Double, _
    ritardoBitumeHard As Integer, _
    ritardoBitumeSoft As Integer, _
    tolleranzaBitumeHard As Double, _
    tolleranzaBitumeSoft As Double _
) As Boolean

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    PLCSchiumatoSetPercentoBitumeHard setBitumeHard
    PLCSchiumatoSetPercentoBitumeSoft setBitumeSoft
    PLCSchiumatoSetRitardoBitumeHard ritardoBitumeHard
    PLCSchiumatoSetRitardoBitumeSoft ritardoBitumeSoft
    PLCSchiumatoSetTolleranzaBitumeHard tolleranzaBitumeHard
    PLCSchiumatoSetTolleranzaBitumeSoft tolleranzaBitumeSoft
    

    PLCSchiumatoSetAbilitaCiclo

End Function


Public Function PLCSchiumatoPesoAggregati(ByVal Peso As Double) As Boolean

    PLCSchiumatoPesoAggregati = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (Peso > CP240.OPCDataSchiumato.items(PesoAggregati_idx).Value) Then
        CP240.OPCDataSchiumato.items(PesoAggregati_idx).Value = Peso
    End If
    If (FrmSchiumaturaVisibile) Then
        FrmSchiumatura.LblPesoAggregati.caption = Format(Peso, "0")
    End If

    PLCSchiumatoPesoAggregati = True

End Function

Public Function PLCSchiumatoScaricoAggregati(ByVal scarico As Boolean) As Boolean

    PLCSchiumatoScaricoAggregati = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (Not scarico And CP240.OPCDataSchiumato.items(ScaricoAggregati_idx).Value) Then
        'Ho finito di scaricare
        CP240.OPCDataSchiumato.items(PesoAggregati_idx).Value = 0
    End If

    CP240.OPCDataSchiumato.items(ScaricoAggregati_idx).Value = scarico

    If (FrmSchiumaturaVisibile) Then
        FrmSchiumatura.ImgScaricoAggregati.Visible = scarico
    End If

    PLCSchiumatoScaricoAggregati = True

End Function

'ACQUA

Public Function PLCSchiumatoCircuitoAcqua() As Boolean

    Dim start As Boolean
    Dim colorePompa As Long
    Dim coloreRicircolo As Long
    Dim coloreImmissione As Long


    PLCSchiumatoCircuitoAcqua = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then

        With CP240.OPCDataSchiumato

            start = .items(IpompaAcquaON_idx).Value

            'Errore
            colorePompa = vbRed
            coloreRicircolo = vbRed
            coloreImmissione = vbRed

            If (Not start) Then

                'Spento
                colorePompa = &HC0C0B0
                coloreRicircolo = &HC0C0B0
                coloreImmissione = &HC0C0B0

            ElseIf (start And .items(IvalvAcquaON_idx).Value) Then
                
                'Aperto
                colorePompa = vbGreen
                coloreRicircolo = &HC0C0B0
                coloreImmissione = vbGreen

            ElseIf (start And .items(IvalvAcquaOFF_idx).Value) Then

                'Chiuso: ricircolo
                colorePompa = vbGreen
                coloreRicircolo = vbGreen
                coloreImmissione = &HC0C0B0

            End If

            FrmSchiumatura.ShapeAcqua(0).BackColor = colorePompa
            FrmSchiumatura.ShapeAcqua(1).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeAcqua(2).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeAcqua(3).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeAcqua(10).BackColor = coloreImmissione

        End With

        PLCSchiumatoCircuitoRampa

    End If

    PLCSchiumatoCircuitoAcqua = True

End Function

Public Function PLCSchiumatoPompaAcqua() As Boolean

    PLCSchiumatoPompaAcqua = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        'If (CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value) Then
            If (CP240.OPCDataSchiumato.items(IpompaAcquaON_idx).Value) Then
                FrmSchiumatura.ApbPompaAcqua.Value = 2
            Else
                FrmSchiumatura.ApbPompaAcqua.Value = 1
            End If
        'End If
        PLCSchiumatoCircuitoAcqua
    End If

    PLCSchiumatoPompaAcqua = True

End Function

Public Function PLCSchiumatoManualePompaAcqua(start As Boolean) As Boolean

    PLCSchiumatoManualePompaAcqua = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManPompaAcqua_idx).Value = start

    PLCSchiumatoManualePompaAcqua = True

End Function

Public Function PLCSchiumatoValvAcqua() As Boolean

    PLCSchiumatoValvAcqua = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(IvalvAcquaON_idx).Value) Then
            FrmSchiumatura.ApbValvAcqua.Value = 3
        Else
            FrmSchiumatura.ApbValvAcqua.Value = 2
        End If
        PLCSchiumatoCircuitoAcqua
    End If

    PLCSchiumatoValvAcqua = True

End Function

Public Function PLCSchiumatoManualeValvAcqua(start As Boolean) As Boolean

    PLCSchiumatoManualeValvAcqua = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManValvAcqua_idx).Value = start

    PLCSchiumatoManualeValvAcqua = True

End Function

Public Function PLCSchiumatoValvImmissAcqua() As Boolean

    PLCSchiumatoValvImmissAcqua = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(IvalvImmissAcquaON_idx).Value) Then
            FrmSchiumatura.ApbValvImmissAcqua.Value = 2
        Else
            FrmSchiumatura.ApbValvImmissAcqua.Value = 1
        End If
        PLCSchiumatoCircuitoAcqua
    End If

    PLCSchiumatoValvImmissAcqua = True

End Function

'BITUME HARD

Public Function PLCSchiumatoCircuitoBitume() As Boolean

    Dim startAvanti As Boolean
    Dim startIndietro As Boolean
    Dim colorePompa As Long
    Dim coloreRicircolo As Long
    Dim coloreImmissione As Long


    PLCSchiumatoCircuitoBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then

        With CP240.OPCDataSchiumato

            startAvanti = .items(IpompaBitumeAvanti_idx).Value
            startIndietro = .items(IpompaBitumeIndietro_idx).Value

            'Errore
            colorePompa = vbRed
            coloreRicircolo = vbRed
            coloreImmissione = vbRed

            If (Not startAvanti And Not startIndietro) Then

                'Spento
                colorePompa = &HC0C0B0
                coloreRicircolo = &HC0C0B0
                coloreImmissione = &HC0C0B0

            ElseIf (startAvanti And startIndietro) Then

                'Tutto acceso!

            ElseIf ((startAvanti Or startIndietro) And .items(IvalvBitumeOFF_idx).Value) Then

                'Chiuso: ricircolo
                colorePompa = vbGreen
                coloreRicircolo = vbGreen
                coloreImmissione = &HC0C0B0

            ElseIf ((startAvanti Or startIndietro) And .items(IvalvBitumeON_idx).Value) Then

                'Aperto
                colorePompa = vbGreen
                coloreRicircolo = &HC0C0B0
                coloreImmissione = vbGreen

            End If

            FrmSchiumatura.ShapeBitumeHard(0).BackColor = colorePompa
            FrmSchiumatura.ShapeBitumeHard(1).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeBitumeHard(2).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeBitumeHard(3).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeBitumeHard(10).BackColor = coloreImmissione

        End With

        PLCSchiumatoCircuitoRampa

    End If

    PLCSchiumatoCircuitoBitume = True

End Function

Public Function PLCSchiumatoPompaBitume() As Boolean

    PLCSchiumatoPompaBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If ( _
            CP240.OPCDataSchiumato.items(IpompaBitumeAvanti_idx).Value Or _
            CP240.OPCDataSchiumato.items(IpompaBitumeIndietro_idx).Value _
        ) Then
            'If (CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value) Then
                FrmSchiumatura.ApbPompaBitume.Value = 2
            'End If
            FrmSchiumatura.CmdVersoPompaBitume.enabled = False
        Else
            'If (CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value) Then
                FrmSchiumatura.ApbPompaBitume.Value = 1
            'End If
            FrmSchiumatura.CmdVersoPompaBitume.enabled = True
        End If
        PLCSchiumatoCircuitoBitume
        PLCSchiumatoVersoPompaBitume
    End If

    PLCSchiumatoPompaBitume = True

End Function

Public Function PLCSchiumatoManualePompaBitume(start As Boolean) As Boolean

    PLCSchiumatoManualePompaBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (PlcSchiumato.inversionePompaBitume) Then
        CP240.OPCDataSchiumato.items(ManPompaBitume_idx).Value = False
        CP240.OPCDataSchiumato.items(ManPompaBitumeIndietro_idx).Value = start
    Else
        CP240.OPCDataSchiumato.items(ManPompaBitume_idx).Value = start
        CP240.OPCDataSchiumato.items(ManPompaBitumeIndietro_idx).Value = False
    End If

    PLCSchiumatoManualePompaBitume = True

End Function

Public Function PLCSchiumatoVersoPompaBitume() As Boolean

    PLCSchiumatoVersoPompaBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (PlcSchiumato.inversionePompaBitume) Then
            FrmSchiumatura.CmdVersoPompaBitume.Picture = FrmSchiumatura.ImgFrecciaSx.Picture
        Else
            FrmSchiumatura.CmdVersoPompaBitume.Picture = FrmSchiumatura.ImgFrecciaDx.Picture
        End If
    End If

    PLCSchiumatoVersoPompaBitume = True

End Function

Public Function PLCSchiumatoInversionePompaBitume() As Boolean

    PLCSchiumatoInversionePompaBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    PlcSchiumato.inversionePompaBitume = Not PlcSchiumato.inversionePompaBitume
    PLCSchiumatoVersoPompaBitume

    PLCSchiumatoInversionePompaBitume = True

End Function

Public Function PLCSchiumatoValvBitume() As Boolean

    PLCSchiumatoValvBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(IvalvBitumeON_idx).Value) Then
            FrmSchiumatura.ApbValvBitume.Value = 3
        Else
            FrmSchiumatura.ApbValvBitume.Value = 2
        End If
        PLCSchiumatoCircuitoBitume
    End If

    PLCSchiumatoValvBitume = True

End Function

Public Function PLCSchiumatoManualeValvBitume(start As Boolean) As Boolean

    PLCSchiumatoManualeValvBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManValvBitume_idx).Value = start

    PLCSchiumatoManualeValvBitume = True

End Function

Public Function PLCSchiumatoValvImmissBitume() As Boolean

    PLCSchiumatoValvImmissBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(IvalvImmissBitumeON_idx).Value) Then
            FrmSchiumatura.ApbValvImmissBitume.Value = 2
            FrmSchiumatura.LblTempoSchiumatura.BackColor = vbGreen

            If SchiumatoOraStartSchiumatura = 0 Then
                SchiumatoOraStartSchiumatura = ConvertiTimer()
                FrmSchiumatura.LblTempoSchiumatura.caption = "0 sec"
            Else
                FrmSchiumatura.LblTempoSchiumatura.caption = (ConvertiTimer() - SchiumatoOraStartSchiumatura) & " sec"
            End If
        Else
            FrmSchiumatura.ApbValvImmissBitume.Value = 1
            FrmSchiumatura.LblTempoSchiumatura.BackColor = &H8000000F
            SchiumatoOraStartSchiumatura = 0
        End If
    End If

    PLCSchiumatoValvImmissBitume = True

End Function

Public Function PLCSchiumatoManualeValvImmissBitume(start As Boolean) As Boolean

    PLCSchiumatoManualeValvImmissBitume = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManValvImmissioneBitume_idx).Value = start

    PLCSchiumatoManualeValvImmissBitume = True

End Function


Public Function PLCSchiumatoManualeValvImmissH20(start As Boolean) As Boolean

    PLCSchiumatoManualeValvImmissH20 = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    'CP240.OPCDataSchiumato.Items(ManValvImmissioneH20_idx).value = start

    PLCSchiumatoManualeValvImmissH20 = True

End Function

Public Function PLCSchiumatoSetBitumeHard() As Boolean
Dim BSoft_Perc As Double
Dim BHard_Perc As Double

    PLCSchiumatoSetBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If
    
    If DosaggioInCorso Then
        CP240.LblTrSetPeso(CompLeganteHard).caption = RoundNumber(CP240.OPCDataSchiumato.items(SetImpulsiBitume_idx).Value, 1)
        If FrmNetti.Visible Then
            FrmNetti.LblSetB12(4).caption = RoundNumber(CP240.OPCDataSchiumato.items(SetImpulsiBitume_idx).Value, 1)
        End If
    Else
        'Calcolo del bitume schiumato teorico fatto dal PLC --> da fare in futuro nel PLC
        If Not CP240.AdoDosaggio.Recordset.EOF Then
            BSoft_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value / 100
            BHard_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value / 100
            CP240.LblTrSetPeso(CompLeganteHard).caption = RoundNumber(DimensioneImpastoKg / (1 + BSoft_Perc + BHard_Perc) * BHard_Perc, 1)
            If FrmNetti.Visible Then
                FrmNetti.LblSetB12(4).caption = CP240.LblTrSetPeso(CompLeganteHard).caption
            End If
        End If
    End If

    PLCSchiumatoSetBitumeHard = True

End Function

Public Function PLCSchiumatoPercentoBitumeHard() As Boolean

    PLCSchiumatoPercentoBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        FrmSchiumatura.LblPercentoBitume.caption = Format(CDbl(CP240.OPCDataSchiumato.items(PercentualeBitume_idx).Value), "##0.0")
    End If

    PLCSchiumatoPercentoBitumeHard = True

End Function

Public Function PLCSchiumatoSetPercentoBitumeHard(percento As Double) As Boolean

    PLCSchiumatoSetPercentoBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(PercentualeBitume_idx).Value = percento

    PLCSchiumatoSetPercentoBitumeHard = True

End Function

Public Function PLCSchiumatoRitardoBitumeHard() As Boolean

    PLCSchiumatoRitardoBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        FrmSchiumatura.LblRitardoBitume.caption = CStr(CInt(CP240.OPCDataSchiumato.items(RitardoAvvioCiclo_idx).Value) / 1000)
    End If

    PLCSchiumatoRitardoBitumeHard = True

End Function

Public Function PLCSchiumatoSetRitardoBitumeHard(secondi As Integer) As Boolean

    PLCSchiumatoSetRitardoBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(RitardoAvvioCiclo_idx).Value = secondi * 1000

    PLCSchiumatoSetRitardoBitumeHard = True

End Function

Public Function PLCSchiumatoSetTolleranzaBitumeHard(Tolleranza As Double) As Boolean

    PLCSchiumatoSetTolleranzaBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(TolleranzaHard_idx).Value = Tolleranza

    PLCSchiumatoSetTolleranzaBitumeHard = True

End Function

Public Function PLCSchiumatoSetTolleranzaBitumeSoft(Tolleranza As Double) As Boolean

    PLCSchiumatoSetTolleranzaBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(TolleranzaSoft_idx).Value = Tolleranza

    PLCSchiumatoSetTolleranzaBitumeSoft = True

End Function


Public Sub PLCSchiumatoSetFineScaricoBitume(Fine As Boolean)

    FineScaricoBitume = Fine
    Call PLCSchiumatoFineScaricoBitume

End Sub

Public Sub PLCSchiumatoFineScaricoBitume()

    CP240.OPCData.items(PLCTAG_DI_FineScaricoCompAux1).Value = FineScaricoBitume And Not CP240.OPCDataSchiumato.items(All_001_idx + 31 - 1).Value
    If DEBUGGING Then
        CP240.lblEtichetta(48).caption = CP240.OPCData.items(PLCTAG_DI_FineScaricoCompAux1).Value
    End If

End Sub

Public Function PLCSchiumatoDosaggioBitumeHard() As Boolean

    PLCSchiumatoDosaggioBitumeHard = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    With CP240.OPCDataSchiumato

        If (DosaggioInCorsoBitume And Not .items(DosaggioInCorso_idx).Value) Then
            'Fine dosaggio
            Call PLCSchiumatoSetFineScaricoBitume(True)
        End If
        
        If (Not DosaggioInCorsoBitume And .items(DosaggioInCorso_idx).Value) Then
            'Inizio dosaggio
            NettoBitumeBuffer(4) = RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeHard_idx).Value, 1)
        End If
        
        If DosaggioInCorsoBitume <> .items(DosaggioInCorso_idx).Value Then
            ComponenteInPesata DosaggioLeganti(4), CP240.OPCDataSchiumato.items(DosaggioInCorso_idx).Value
            DosaggioInCorsoBitume = .items(DosaggioInCorso_idx).Value
        End If
        
        CP240.ProgressBil(5).Value = .items(ConteggioImpulsiBitume_idx).Value
        CP240.ProgressBil(5).caption = RoundNumber(.items(ConteggioImpulsiBitume_idx).Value, 1)
        
        If DosaggioInCorso Then
            If (CP240.AdoDosaggioScarico.Recordset.Fields("SetBitumeHard").Value > 0) Then
                If Not .items(IpompaAcquaON_idx).Value Then
                    Call ArrestoEmergenzaDosaggio
                End If
            End If
        End If
        
    End With

    PLCSchiumatoDosaggioBitumeHard = True

End Function

'SOLVENTE

Public Function PLCSchiumatoValvImmissSolvente() As Boolean

    PLCSchiumatoValvImmissSolvente = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(ManValvImmissSolvente_idx).Value) Then
            FrmSchiumatura.ShapeSolvente(10).BackColor = vbGreen
            FrmSchiumatura.ApbValvImmissSolvente.Value = 2
        Else
            FrmSchiumatura.ShapeSolvente(10).BackColor = &HC0C0B0
            FrmSchiumatura.ApbValvImmissSolvente.Value = 1
        End If
    End If

    PLCSchiumatoValvImmissSolvente = True

End Function

Public Function PLCSchiumatoManualeValvImmissSolvente(start As Boolean) As Boolean

    PLCSchiumatoManualeValvImmissSolvente = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManValvImmissSolvente_idx).Value = start

    PLCSchiumatoManualeValvImmissSolvente = True

End Function

'BITUME SOFT

Public Function PLCSchiumatoCircuitoBitumeSoft() As Boolean

    Dim startAvanti As Boolean
    Dim startIndietro As Boolean
    Dim colorePompa As Long
    Dim coloreRicircolo As Long
    Dim coloreImmissione As Long


    PLCSchiumatoCircuitoBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then

        With CP240.OPCDataSchiumato

            startAvanti = .items(IpompaBSoftAvanti_idx).Value
            startIndietro = .items(IpompaBSoftIndietro_idx).Value

            'Errore
            colorePompa = vbRed
            coloreRicircolo = vbRed
            coloreImmissione = vbRed

            If (Not startAvanti And Not startIndietro) Then

                'Spento
                colorePompa = &HC0C0B0
                coloreRicircolo = &HC0C0B0
                coloreImmissione = &HC0C0B0

            ElseIf (startAvanti And startIndietro) Then

                'Tutto acceso!

            ElseIf ((startAvanti Or startIndietro) And .items(IvalvBSoftOFF_idx).Value) Then

                'Chiuso: ricircolo
                colorePompa = vbGreen
                coloreRicircolo = vbGreen
                coloreImmissione = &HC0C0B0

            ElseIf ((startAvanti Or startIndietro) And .items(IvalvBSoftON_idx).Value) Then

                'Aperto
                colorePompa = vbGreen
                coloreRicircolo = &HC0C0B0
                coloreImmissione = vbGreen

            End If

            FrmSchiumatura.ShapeBitumeSoft(0).BackColor = colorePompa
            FrmSchiumatura.ShapeBitumeSoft(1).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeBitumeSoft(2).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeBitumeSoft(3).BackColor = coloreRicircolo
            FrmSchiumatura.ShapeBitumeSoft(10).BackColor = coloreImmissione

        End With

    End If

    PLCSchiumatoCircuitoBitumeSoft = True

End Function

Public Function PLCSchiumatoPompaBitumeSoft() As Boolean

    PLCSchiumatoPompaBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If ( _
            CP240.OPCDataSchiumato.items(IpompaBSoftAvanti_idx).Value Or _
            CP240.OPCDataSchiumato.items(IpompaBSoftIndietro_idx).Value _
        ) Then
            'If (CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value) Then
                FrmSchiumatura.ApbPompaBitumeSoft.Value = 2
            'End If
            FrmSchiumatura.CmdVersoPompaBitumeSoft.enabled = False
        Else
            'If (CP240.OPCDataSchiumato.Items(AutomaticoMotori_Idx).value) Then
                FrmSchiumatura.ApbPompaBitumeSoft.Value = 1
            'End If
            FrmSchiumatura.CmdVersoPompaBitumeSoft.enabled = True
        End If
        PLCSchiumatoCircuitoBitumeSoft
        PLCSchiumatoVersoPompaBitumeSoft
    End If

    PLCSchiumatoPompaBitumeSoft = True

End Function

Public Function PLCSchiumatoManualePompaBitumeSoft(start As Boolean) As Boolean

    PLCSchiumatoManualePompaBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (PlcSchiumato.inversionePompaBSoft) Then
        CP240.OPCDataSchiumato.items(ManPompaBSoft_idx).Value = False
        CP240.OPCDataSchiumato.items(ManPompaBSoftIndietro_idx).Value = start
    Else
        CP240.OPCDataSchiumato.items(ManPompaBSoft_idx).Value = start
        CP240.OPCDataSchiumato.items(ManPompaBSoftIndietro_idx).Value = False
    End If

    PLCSchiumatoManualePompaBitumeSoft = True

End Function

Public Function PLCSchiumatoVersoPompaBitumeSoft() As Boolean

    PLCSchiumatoVersoPompaBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (PlcSchiumato.inversionePompaBSoft) Then
            FrmSchiumatura.CmdVersoPompaBitumeSoft.Picture = FrmSchiumatura.ImgFrecciaSx.Picture
        Else
            FrmSchiumatura.CmdVersoPompaBitumeSoft.Picture = FrmSchiumatura.ImgFrecciaDx.Picture
        End If
    End If

    PLCSchiumatoVersoPompaBitumeSoft = True

End Function

Public Function PLCSchiumatoInversionePompaBitumeSoft() As Boolean

    PLCSchiumatoInversionePompaBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    PlcSchiumato.inversionePompaBSoft = Not PlcSchiumato.inversionePompaBSoft
    PLCSchiumatoVersoPompaBitumeSoft

    PLCSchiumatoInversionePompaBitumeSoft = True

End Function

Public Function PLCSchiumatoValvBitumeSoft() As Boolean

    PLCSchiumatoValvBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(IvalvBSoftON_idx).Value) Then
            FrmSchiumatura.ApbValvBitumeSoft.Value = 2
        Else
            FrmSchiumatura.ApbValvBitumeSoft.Value = 1
        End If
        PLCSchiumatoCircuitoBitumeSoft
    End If

    PLCSchiumatoValvBitumeSoft = True

End Function

Public Function PLCSchiumatoManualeValvBitumeSoft(start As Boolean) As Boolean

    PLCSchiumatoManualeValvBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManValvBSoft_idx).Value = start

    PLCSchiumatoManualeValvBitumeSoft = True

End Function

Public Function PLCSchiumatoValvImmissBitumeSoft() As Boolean

    PLCSchiumatoValvImmissBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        If (CP240.OPCDataSchiumato.items(IvalvImmissBSoftON_idx).Value) Then
            FrmSchiumatura.ApbValvImmissBitumeSoft.Value = 2
        Else
            FrmSchiumatura.ApbValvImmissBitumeSoft.Value = 1
        End If
    End If

    PLCSchiumatoValvImmissBitumeSoft = True

End Function

Public Function PLCSchiumatoManualeValvImmissBitumeSoft(start As Boolean) As Boolean

    PLCSchiumatoManualeValvImmissBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(ManValvImmissioneBSoft_idx).Value = start

    PLCSchiumatoManualeValvImmissBitumeSoft = True

End Function

Public Function PLCSchiumatoSetBitumeSoft() As Boolean
Dim BSoft_Perc As Double
Dim BHard_Perc As Double

    PLCSchiumatoSetBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If
    
    If DosaggioInCorso Then
        CP240.LblTrSetPeso(CompLeganteSoft).caption = RoundNumber(CP240.OPCDataSchiumato.items(SetImpulsiBSoft_idx).Value, 1)
        FrmNetti.LblSetB12(3).caption = RoundNumber(CP240.OPCDataSchiumato.items(SetImpulsiBSoft_idx).Value, 1)
    Else
        'Calcolo del bitume schiumato teorico fatto dal PLC --> da fare in futuro nel PLC
        If Not CP240.AdoDosaggio.Recordset.EOF Then
            BSoft_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value / 100
            BHard_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value / 100
            CP240.LblTrSetPeso(CompLeganteSoft).caption = RoundNumber(DimensioneImpastoKg / (1 + BSoft_Perc + BHard_Perc) * BSoft_Perc, 1)
            FrmNetti.LblSetB12(3).caption = CP240.LblTrSetPeso(CompLeganteSoft).caption
        End If
    End If
    
    PLCSchiumatoSetBitumeSoft = True

End Function

Public Function PLCSchiumatoPercentoBitumeSoft() As Boolean

    PLCSchiumatoPercentoBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        FrmSchiumatura.LblPercentoBitumeSoft.caption = Format(CDbl(CP240.OPCDataSchiumato.items(PercentualeBSoft_idx).Value), "##0.0")
    End If

    PLCSchiumatoPercentoBitumeSoft = True

End Function

Public Function PLCSchiumatoSetPercentoBitumeSoft(percento As Double) As Boolean

    PLCSchiumatoSetPercentoBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(PercentualeBSoft_idx).Value = percento

    PLCSchiumatoSetPercentoBitumeSoft = True

End Function

Public Function PLCSchiumatoRitardoBitumeSoft() As Boolean

    PLCSchiumatoRitardoBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then
        FrmSchiumatura.LblRitardoBitumeSoft.caption = CStr(CInt(CP240.OPCDataSchiumato.items(RitardoAvvioCicloBSoft_idx).Value) / 1000)
    End If

    PLCSchiumatoRitardoBitumeSoft = True

End Function

Public Function PLCSchiumatoSetRitardoBitumeSoft(secondi As Integer) As Boolean

    PLCSchiumatoSetRitardoBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    CP240.OPCDataSchiumato.items(RitardoAvvioCicloBSoft_idx).Value = secondi * 1000

    PLCSchiumatoSetRitardoBitumeSoft = True

End Function

Public Function PLCSchiumatoDosaggioBitumeSoft() As Boolean

    PLCSchiumatoDosaggioBitumeSoft = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    With CP240.OPCDataSchiumato

        If (DosaggioInCorsoBSoft And Not .items(DosaggioInCorsoBSoft_idx).Value) Then
            'Fine dosaggio
        End If
        
        If (Not DosaggioInCorsoBSoft And .items(DosaggioInCorsoBSoft_idx).Value) Then
            'Inizio dosaggio
            NettoBitumeBuffer(3) = RoundNumber(CP240.OPCDataSchiumato.items(NettoBitumeSoft_idx).Value, 1)
        End If
        
        If DosaggioInCorsoBSoft <> .items(DosaggioInCorsoBSoft_idx).Value Then
            ComponenteInPesata DosaggioLeganti(3), CP240.OPCDataSchiumato.items(DosaggioInCorsoBSoft_idx).Value
            DosaggioInCorsoBSoft = .items(DosaggioInCorsoBSoft_idx).Value
        End If

    End With

    PLCSchiumatoDosaggioBitumeSoft = True

End Function

'RAMPA

Public Function PLCSchiumatoCircuitoRampa() As Boolean

    PLCSchiumatoCircuitoRampa = False

    If (Not PlcSchiumatoConnesso) Then
        Exit Function
    End If

    If (FrmSchiumaturaVisibile) Then

        With CP240.OPCDataSchiumato

            If (.items(IvalvImmissAcquaON_idx).Value Or .items(IvalvImmissBitumeON_idx).Value) Then
                FrmSchiumatura.ImgRampa.Picture = LoadResPicture("IDB_SCHIUMATORAMPAON", vbResBitmap)
            Else
                FrmSchiumatura.ImgRampa.Picture = LoadResPicture("IDB_SCHIUMATORAMPA", vbResBitmap)
            End If

        End With

    End If

    PLCSchiumatoCircuitoRampa = True

End Function


Public Function PlcSchiumatoControllaB_Hard_sec(TempoMin As Long, TempoMax As Long) As Double
	'Restituisce la percentuale di riduzione impasto da applicare tenendo conto dei 2 tempi
	'Se il tempo teorico di schiumatura è compreso tra i due parametri lascio inalterata la riduzione impasto e la velocità è quella massima
	'Se il tempo è minore del minimo aumento l'impasto fino ad avere un tempo entro i parametri
	'Se il tempo è maggiore del massimo diminuisco l'impasto fino ad avere un tempo entro i parametri
	' --> dopo aver soddisfatto i requisiti sopra elencati cerco di fare schiumare nel tempo medio:
	'       cambio la velocità della pompa hard nel preset e poi durante la schiumatura

    Dim KgImpasto As Integer
    Dim BSoft_Perc As Double
    Dim BHard_Perc As Double
    Dim KgB_Hard As Double
    Dim percentuale As Double
    Dim FlussoHard As Double
    Dim RiduzioneImpastoHardTempoOKsec As Double


    percentuale = RoundNumber(CP240.LblProdDos.caption, 1)
    PlcSchiumatoControllaB_Hard_sec = percentuale
    
    'Calcolo del bitume schiumato teorico fatto dal PLC --> da fare in futuro nel PLC
    If Not CP240.AdoDosaggio.Recordset.EOF And PlcSchiumato.Abilitazione Then
        If CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value > 0 Then
            KgImpasto = CInt(ImpastoPeso() / 100 * percentuale)
            BSoft_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value / 100
            BHard_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value / 100
            KgB_Hard = RoundNumber(KgImpasto / (1 + BSoft_Perc + BHard_Perc) * BHard_Perc, 1)
            percentuale = CDbl(CP240.LblProdDos.caption)
            'Verifica del peso minimo di bitume hard da immettere, aumento la grandezza dell'impasto
            'fino a raggiungere il peso minimo impostato nei parametri
            Do While KgB_Hard < PlcSchiumato.MinimoKgHard
                percentuale = percentuale + 1
                KgImpasto = CInt(ImpastoPeso() / 100 * percentuale)
                BSoft_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value / 100
                BHard_Perc = CP240.AdoDosaggio.Recordset.Fields("SetBitumeHard").Value / 100
                KgB_Hard = RoundNumber(KgImpasto / (1 + BSoft_Perc + BHard_Perc) * BHard_Perc, 1)
                If percentuale >= 100 Then
                    percentuale = 100
                    Exit Do
                End If
            Loop
            PlcSchiumatoControllaB_Hard_sec = percentuale
            
            'Calcolo della velocità da applicare al B.Hard per avere una schiumatura con
            'durata tra TempoMin e TempoMax
            
            'Velocità massima ammissibile, imposto la percentuale max di velocità nei parametri
            CP240.OPCDataSchiumato.items(VelocitaInverterHard_idx).Value = PlcSchiumato.Perc_Velox_BHard * 27648 / 100
            
            FlussoHard = PlcSchiumato.HiSetPortataBSoft / 3600 * PlcSchiumato.Perc_Velox_BHard / 100 'uso HiSetPortataBSoft vedi altro commento
            
            If KgB_Hard / FlussoHard > TempoMax Then
                RiduzioneImpastoHardTempoOKsec = FlussoHard * TempoMax / KgB_Hard
                PlcSchiumatoControllaB_Hard_sec = RoundNumber(percentuale * RiduzioneImpastoHardTempoOKsec, 1)
            End If

            'Calcolo del tempo di schiumatura con velocità massima della pompa B.Hard
            Dim TempoVelocitaMax As Double
            Dim FlussoMinimo As Double
            Dim FlussoMassimo As Double
            Dim FlussoOttimale As Double
            TempoVelocitaMax = KgB_Hard / FlussoHard
            FlussoMinimo = PlcSchiumato.MinimoKgHard / PlcSchiumato.TempoMinimoSchiumatura
            FlussoMassimo = (PlcSchiumato.HiSetPortataBSoft / 3600)
            FlussoOttimale = FlussoMassimo * PlcSchiumato.Perc_Velox_BHard_Ottimale / 100

            '1: Verifica se posso schiumare al flusso ottimale
            If ((KgB_Hard / FlussoOttimale) >= TempoMin) And ((KgB_Hard / FlussoOttimale) <= TempoMax) Then
                PlcSchiumato.FlussoTeoricoB_Hard = FlussoOttimale * 60
            Else
                If ((KgB_Hard / FlussoOttimale) > TempoMax) Then
                    '2: applico la velocità massima
                    PlcSchiumato.FlussoTeoricoB_Hard = FlussoMassimo * 60
                Else
                    '3: applico la velocità minima rispettando il tempo minimo di schiumatura
                    PlcSchiumato.FlussoTeoricoB_Hard = KgB_Hard / TempoMin * 60
                End If
            End If
            
            'Velocità teorica B.Hard per una schiumatura con tempo a metà forchetta
            CP240.OPCDataSchiumato.items(VelocitaInverterHard_idx).Value = PlcSchiumato.FlussoTeoricoB_Hard / (FlussoMassimo * 60) * 27648

            'Solo per prove in cantiere
            FrmSchiumatura.LblFlussoTeorico.caption = PlcSchiumato.FlussoTeoricoB_Hard
            '
        End If
    End If

End Function

