Attribute VB_Name = "GestioneCisterneCommon"
Option Explicit

Public Const NomeFileCisterneDB = "Cisterne.mdb"

Public Type MotoreS7
    Cmd_Avvio_Manuale As Boolean
    Cmd_Stop_Manuale As Boolean
    DI_Ritorno As Boolean
    DI_Termica As Boolean
    ParametroTimeoutAvvio As Long
    ParametroTimeoutStop As Long
    CodiceAllarme As Integer
    OreFunzionamento As Long
End Type

Public Type PIDCisterne
    TempAttuale As Double 'valore attuale di temperatura
    setpoint As Double 'impostazione di temperatura
    lckset As Boolean 'blocco della lettura del set da plc (true quando si sta modificandone il valore da pc)
    RiscAttivo As Boolean 'segnala quando e' attiva l'uscita per riscaldare la cisterna
    SicurRisc As Boolean 'ingresso termostato sicurezza valvola olio di mantenimento
    SicurRiscBoost As Boolean 'ingresso termostato sicurezza valvola olio di boost
    p As Double 'guadagno proporzionale
    ti As Double 'tempo integrale
    td As Double 'tempo derivativo
End Type

Public Enum StatoValvola
    VChiusa = 1 '(grigia)
    VAperta = 2 '(verde)
    VAllarme = 3 '(rossa)
End Enum

Public PompaAuxCisterne As MotoreS7

Public Const NumMaxCisterneImpianto = 30

Public ComandiCisternaPid(0 To 0) As PIDCisterne

Public Enum TipiGestioneCiterneEnum
    NessunaGestione
    GestioneSemplificata 'Gestione I/O cisterne nel plc principale: nuova gestione 9.6 che rimpiazza la vecchia con IM253
    GestionePLC
End Enum

Public Enum ListaOperazioniCircuito
    Selezione   '0
    Carico      '1
    Travaso     '2
    Ricircolo   '3
    TravasoPCL  '4
    RicircoloPCar_TravasoPCL    '5
    RicircoloPCar_RicircoloPCL  '6
    PrelievoBraccio             '7
    CaricoPCL                   '8
    TravasoPCL_2                '9
    AlimentazioneExt            '10
    
    MaxListaOperazioniCircuito
End Enum
'
Public Type GestioneCisterne

    Gestione As TipiGestioneCiterneEnum
    NumCisterneBitume As Integer
    NumeroCistBitSuPCL1 As Integer '20150505
    NumCisterneEmulsione As Integer
    NumCisterneCombustibile As Integer
    InclusioneTravaso As Boolean
    InclusioneTemperatura As Boolean
    RegolazioneTemperatura As Boolean
    InclusioneSetTemperatura As Boolean
    InclusioneLivello As Boolean
    InclusioneComandi As Boolean
    AbilitaVistaAlto As Boolean
    NumValvoleSopraConfig As Integer
    NumValvoleSottoConfig As Integer
    ValvSeparazioneSopraConfig As Integer
    ValvSeparazioneSottoConfig As Integer
    Valv3VieConfig As Boolean
    TemperatureConfig As Boolean
    LivelliConfig As Boolean
    Termoregolazione As Boolean
    ValvCaricoConfig As Boolean

    OperazioneSelezionata As Integer

    RegolatorePID(1 To NumMaxCisterneImpianto) As PIDCisterne
    materiale(0 To NumMaxCisterneImpianto - 1) As String
'20150513
    MaterialeDosaggioPCL1 As String
    MaterialeDosaggioPCL2 As String
'
    InclusioneValvoleSeparazione12Bitume As Boolean
    InclusioneValvoleSeparazione23Bitume As Boolean
    
    ListaOperazioniEmulsione(0 To MaxListaOperazioniCircuito - 1) As Boolean

End Type


Public Type ContalitriType
    inclusione As Boolean       'Indica se il contalitri è stato incluso da parametri
    Attivazione As Boolean      'Indica se il contalitri è stato abilitato dal Form CP240
    RapportoImpulsi As Double
    ValoreLitri As Double
    NumeroImpulsi As Double
    Reset As Boolean
End Type
'
Public CistGestione As GestioneCisterne
'Public AbilitaResetTaraCisterne As Boolean
Public AckAllarmiCisterne As Boolean
'Public Contalitri As ContalitriType    '20161128

'I TAG ed i relativi indirizzi sono definiti nel file OPCTags.xls (v 9.5.25)
' Per aggiungere/rimuovere TAGs é sufficiente:
' - modificare il relativo foglio del file XLS
' - copiare la prima colonna del foglio e ripopolare l'Enum ed aggiungere sempre l'ultimo valore "CistTAG_COUNT")
'La registrazione dei TAG definiti nel file XLS viene effettuata dalla funzione LoadOPCTags()
Public Enum PlcTagCisterneEnum
    CistTAG_Bitume_InclusioneContalitri
    CistTAG_Bitume_NumeroCisterna4Valvole
    CistTAG_Emulsione_NumeroCisterne
    CistTAG_Combustibile_NumeroCisterne
    CistTAG_Emulsione_NumeroCisternaDefault
    CistTAG_Bitume_AbilitaValvSeparazione_1_2
    CistTAG_Bitume_AbilitaValvSeparazione_2_3
    CistTAG_Bitume_DO_ValvOlioCisterna1
    CistTAG_Bitume_DO_ValvOlioCisterna2
    CistTAG_Bitume_DO_ValvOlioCisterna3
    CistTAG_Bitume_DO_ValvOlioCisterna4
    CistTAG_Bitume_DO_ValvOlioCisterna5
    CistTAG_Bitume_DO_ValvOlioCisterna6
    CistTAG_Bitume_DO_ValvOlioCisterna7
    CistTAG_Bitume_DO_ValvOlioCisterna8
    CistTAG_Bitume_DO_ValvOlioCisterna9
    CistTAG_Bitume_DO_ValvOlioCisterna10
    CistTAG_Bitume_AbilitaRegTempCisterna
    CistTAG_Inclusione_Orologio_Caldaie
    CistTAG_Bitume_SetTempCisterna1
    CistTAG_Bitume_SetTempCisterna2
    CistTAG_Bitume_SetTempCisterna3
    CistTAG_Bitume_SetTempCisterna4
    CistTAG_Bitume_SetTempCisterna5
    CistTAG_Bitume_SetTempCisterna6
    CistTAG_Bitume_SetTempCisterna7
    CistTAG_Bitume_SetTempCisterna8
    CistTAG_Bitume_SetTempCisterna9
    CistTAG_Bitume_SetTempCisterna10
    CistTAG_Bitume_DO_BoostOlioCisterna1
    CistTAG_Bitume_DO_BoostOlioCisterna2
    CistTAG_Bitume_DO_BoostOlioCisterna3
    CistTAG_Bitume_DO_BoostOlioCisterna4
    CistTAG_Bitume_DO_BoostOlioCisterna5
    CistTAG_Bitume_DO_BoostOlioCisterna6
    CistTAG_Bitume_DO_BoostOlioCisterna7
    CistTAG_Bitume_DO_BoostOlioCisterna8
    CistTAG_Bitume_DO_BoostOlioCisterna9
    CistTAG_Bitume_DO_BoostOlioCisterna10
    CistTAG_Bitume_DI_SicRiscValvCisterna1
    CistTAG_Bitume_DI_SicRiscValvCisterna2
    CistTAG_Bitume_DI_SicRiscValvCisterna3
    CistTAG_Bitume_DI_SicRiscValvCisterna4
    CistTAG_Bitume_DI_SicRiscValvCisterna5
    CistTAG_Bitume_DI_SicRiscValvCisterna6
    CistTAG_Bitume_DI_SicRiscValvCisterna7
    CistTAG_Bitume_DI_SicRiscValvCisterna8
    CistTAG_Bitume_DI_SicRiscValvCisterna9
    CistTAG_Bitume_DI_SicRiscValvCisterna10
    CistTAG_Bitume_DI_SicRiscBoostCisterna1
    CistTAG_Bitume_DI_SicRiscBoostCisterna2
    CistTAG_Bitume_DI_SicRiscBoostCisterna3
    CistTAG_Bitume_DI_SicRiscBoostCisterna4
    CistTAG_Bitume_DI_SicRiscBoostCisterna5
    CistTAG_Bitume_DI_SicRiscBoostCisterna6
    CistTAG_Bitume_DI_SicRiscBoostCisterna7
    CistTAG_Bitume_DI_SicRiscBoostCisterna8
    CistTAG_Bitume_DI_SicRiscBoostCisterna9
    CistTAG_Bitume_DI_SicRiscBoostCisterna10
    CistTAG_Bitume_DI_TermicaRiscCisterna1
    CistTAG_Bitume_DI_TermicaRiscCisterna2
    CistTAG_Bitume_DI_TermicaRiscCisterna3
    CistTAG_Bitume_DI_TermicaRiscCisterna4
    CistTAG_Bitume_DI_TermicaRiscCisterna5
    CistTAG_Bitume_DI_TermicaRiscCisterna6
    CistTAG_Bitume_DI_TermicaRiscCisterna7
    CistTAG_Bitume_DI_TermicaRiscCisterna8
    CistTAG_Bitume_DI_TermicaRiscCisterna9
    CistTAG_Bitume_DI_TermicaRiscCisterna10
    CistTAG_Emulsione_DO_ValvOlioCisterna1
    CistTAG_Emulsione_DO_ValvOlioCisterna2
    CistTAG_Emulsione_DO_ValvOlioCisterna3
    CistTAG_Emulsione_DO_ValvOlioCisterna4
    CistTAG_Emulsione_DO_ValvOlioCisterna5
    CistTAG_Emulsione_DO_ValvOlioCisterna6
    CistTAG_Emulsione_DO_ValvOlioCisterna7
    CistTAG_Emulsione_DO_ValvOlioCisterna8
    CistTAG_Emulsione_DO_ValvOlioCisterna9
    CistTAG_Emulsione_DO_ValvOlioCisterna10
    CistTAG_Emulsione_AbilitaRegTempCisterna
    CistTAG_Emulsione_InclusioneOrologio
    CistTAG_Emulsione_SetTempCisterna1
    CistTAG_Emulsione_SetTempCisterna2
    CistTAG_Emulsione_SetTempCisterna3
    CistTAG_Emulsione_SetTempCisterna4
    CistTAG_Emulsione_SetTempCisterna5
    CistTAG_Emulsione_SetTempCisterna6
    CistTAG_Emulsione_SetTempCisterna7
    CistTAG_Emulsione_SetTempCisterna8
    CistTAG_Emulsione_SetTempCisterna9
    CistTAG_Emulsione_SetTempCisterna10
    CistTAG_Emulsione_DO_BoostOlioCisterna1
    CistTAG_Emulsione_DO_BoostOlioCisterna2
    CistTAG_Emulsione_DO_BoostOlioCisterna3
    CistTAG_Emulsione_DO_BoostOlioCisterna4
    CistTAG_Emulsione_DO_BoostOlioCisterna5
    CistTAG_Emulsione_DO_BoostOlioCisterna6
    CistTAG_Emulsione_DO_BoostOlioCisterna7
    CistTAG_Emulsione_DO_BoostOlioCisterna8
    CistTAG_Emulsione_DO_BoostOlioCisterna9
    CistTAG_Emulsione_DO_BoostOlioCisterna10
    CistTAG_Emulsione_DI_SicRiscValvCisterna1
    CistTAG_Emulsione_DI_SicRiscValvCisterna2
    CistTAG_Emulsione_DI_SicRiscValvCisterna3
    CistTAG_Emulsione_DI_SicRiscValvCisterna4
    CistTAG_Emulsione_DI_SicRiscValvCisterna5
    CistTAG_Emulsione_DI_SicRiscValvCisterna6
    CistTAG_Emulsione_DI_SicRiscValvCisterna7
    CistTAG_Emulsione_DI_SicRiscValvCisterna8
    CistTAG_Emulsione_DI_SicRiscValvCisterna9
    CistTAG_Emulsione_DI_SicRiscValvCisterna10
    CistTAG_Emulsione_DI_SicRiscBoostCisterna1
    CistTAG_Emulsione_DI_SicRiscBoostCisterna2
    CistTAG_Emulsione_DI_SicRiscBoostCisterna3
    CistTAG_Emulsione_DI_SicRiscBoostCisterna4
    CistTAG_Emulsione_DI_SicRiscBoostCisterna5
    CistTAG_Emulsione_DI_SicRiscBoostCisterna6
    CistTAG_Emulsione_DI_SicRiscBoostCisterna7
    CistTAG_Emulsione_DI_SicRiscBoostCisterna8
    CistTAG_Emulsione_DI_SicRiscBoostCisterna9
    CistTAG_Emulsione_DI_SicRiscBoostCisterna10
    CistTAG_Emulsione_DI_TermicaRiscCisterna1
    CistTAG_Emulsione_DI_TermicaRiscCisterna2
    CistTAG_Emulsione_DI_TermicaRiscCisterna3
    CistTAG_Emulsione_DI_TermicaRiscCisterna4
    CistTAG_Emulsione_DI_TermicaRiscCisterna5
    CistTAG_Emulsione_DI_TermicaRiscCisterna6
    CistTAG_Emulsione_DI_TermicaRiscCisterna7
    CistTAG_Emulsione_DI_TermicaRiscCisterna8
    CistTAG_Emulsione_DI_TermicaRiscCisterna9
    CistTAG_Emulsione_DI_TermicaRiscCisterna10
    CistTAG_Combustibile_DO_ValvOlioCisterna1
    CistTAG_Combustibile_DO_ValvOlioCisterna2
    CistTAG_Combustibile_DO_ValvOlioCisterna3
    CistTAG_Combustibile_DO_ValvOlioCisterna4
    CistTAG_Combustibile_DO_ValvOlioCisterna5
    CistTAG_Combustibile_DO_ValvOlioCisterna6
    CistTAG_Combustibile_DO_ValvOlioCisterna7
    CistTAG_Combustibile_DO_ValvOlioCisterna8
    CistTAG_Combustibile_DO_ValvOlioCisterna9
    CistTAG_Combustibile_DO_ValvOlioCisterna10
    CistTAG_Combustibile_AbilitaRegTempCisterna
    CistTAG_Combustibile_InclusioneOrologio
    CistTAG_Combustibile_SetTempCisterna1
    CistTAG_Combustibile_SetTempCisterna2
    CistTAG_Combustibile_SetTempCisterna3
    CistTAG_Combustibile_SetTempCisterna4
    CistTAG_Combustibile_SetTempCisterna5
    CistTAG_Combustibile_SetTempCisterna6
    CistTAG_Combustibile_SetTempCisterna7
    CistTAG_Combustibile_SetTempCisterna8
    CistTAG_Combustibile_SetTempCisterna9
    CistTAG_Combustibile_SetTempCisterna10
    CistTAG_Combustibile_DO_BoostOlioCisterna1
    CistTAG_Combustibile_DO_BoostOlioCisterna2
    CistTAG_Combustibile_DO_BoostOlioCisterna3
    CistTAG_Combustibile_DO_BoostOlioCisterna4
    CistTAG_Combustibile_DO_BoostOlioCisterna5
    CistTAG_Combustibile_DO_BoostOlioCisterna6
    CistTAG_Combustibile_DO_BoostOlioCisterna7
    CistTAG_Combustibile_DO_BoostOlioCisterna8
    CistTAG_Combustibile_DO_BoostOlioCisterna9
    CistTAG_Combustibile_DO_BoostOlioCisterna10
    CistTAG_Combustibile_DI_SicRiscValvCisterna1
    CistTAG_Combustibile_DI_SicRiscValvCisterna2
    CistTAG_Combustibile_DI_SicRiscValvCisterna3
    CistTAG_Combustibile_DI_SicRiscValvCisterna4
    CistTAG_Combustibile_DI_SicRiscValvCisterna5
    CistTAG_Combustibile_DI_SicRiscValvCisterna6
    CistTAG_Combustibile_DI_SicRiscValvCisterna7
    CistTAG_Combustibile_DI_SicRiscValvCisterna8
    CistTAG_Combustibile_DI_SicRiscValvCisterna9
    CistTAG_Combustibile_DI_SicRiscValvCisterna10
    CistTAG_Combustibile_DI_SicRiscBoostCisterna1
    CistTAG_Combustibile_DI_SicRiscBoostCisterna2
    CistTAG_Combustibile_DI_SicRiscBoostCisterna3
    CistTAG_Combustibile_DI_SicRiscBoostCisterna4
    CistTAG_Combustibile_DI_SicRiscBoostCisterna5
    CistTAG_Combustibile_DI_SicRiscBoostCisterna6
    CistTAG_Combustibile_DI_SicRiscBoostCisterna7
    CistTAG_Combustibile_DI_SicRiscBoostCisterna8
    CistTAG_Combustibile_DI_SicRiscBoostCisterna9
    CistTAG_Combustibile_DI_SicRiscBoostCisterna10
    CistTAG_Combustibile_DI_TermicaRiscCisterna1
    CistTAG_Combustibile_DI_TermicaRiscCisterna2
    CistTAG_Combustibile_DI_TermicaRiscCisterna3
    CistTAG_Combustibile_DI_TermicaRiscCisterna4
    CistTAG_Combustibile_DI_TermicaRiscCisterna5
    CistTAG_Combustibile_DI_TermicaRiscCisterna6
    CistTAG_Combustibile_DI_TermicaRiscCisterna7
    CistTAG_Combustibile_DI_TermicaRiscCisterna8
    CistTAG_Combustibile_DI_TermicaRiscCisterna9
    CistTAG_Combustibile_DI_TermicaRiscCisterna10
    CistTAG_Bitume_ValvoleGestioneManuale_ZZZ
    CistTAG_Bitume_ArrestoEmergenzaValvole
    CistTAG_Bitume_DI_PompaCircLegante
    CistTAG_CONTALITRI_ATTIVAZIONE
    CistTAG_Bitume_Watchdog
    CistTAG_Bitume_ForzaOperazioneSuAllarme_ZZZ
    CistTAG_Bitume_AckAllarme
    CistTAG_Bitume_DB9_DBX14
    CistTAG_Bitume_DI_PompaCircLegante2
    CistTAG_Bitume_NumeroCisterne
    CistTAG_Bitume_NumeroCisternaDefault
    CistTAG_Bitume_CodiceOperazione_1
    CistTAG_Bitume_CisternaSorgente_1
    CistTAG_Bitume_DB9_DBW10
    CistTAG_Bitume_CodiceOperazione_2
    CistTAG_Bitume_CisternaSorgente_2
    CistTAG_Bitume_CisternaDestinazione_1
    CistTAG_Bitume_CMD_StartOperazione_1
    CistTAG_Bitume_CMD_StopOperazione_1
    CistTAG_Bitume_CMD_StartOperazione_2
    CistTAG_Bitume_CMD_StopOperazione_2
    CistTAG_Bitume_CMD_AzzeraTara
    CistTAG_Bitume_DB9_DBW28
    CistTAG_Bitume_AzzeraTaraCisternaNumero
    CistTAG_Bitume_Allarme0
    CistTAG_Bitume_Allarme1
    CistTAG_Bitume_Allarme2
    CistTAG_Bitume_Allarme3
    CistTAG_Bitume_Allarme4
    CistTAG_Bitume_Allarme5
    CistTAG_Bitume_Allarme6
    CistTAG_Bitume_Allarme7
    CistTAG_Bitume_Allarme8
    CistTAG_Bitume_Allarme9
    CistTAG_Bitume_Allarme10
    CistTAG_Bitume_Allarme11
    CistTAG_Bitume_Allarme12
    CistTAG_Bitume_Allarme13
    CistTAG_Bitume_Allarme14
    CistTAG_Bitume_Allarme15
    CistTAG_Bitume_Allarme16
    CistTAG_Bitume_Allarme17
    CistTAG_Bitume_Allarme18
    CistTAG_Bitume_Allarme19
    CistTAG_Bitume_Allarme20
    CistTAG_Bitume_Allarme21
    CistTAG_Bitume_Allarme22
    CistTAG_Bitume_Allarme23
    CistTAG_Bitume_Allarme24
    CistTAG_Bitume_Allarme25
    CistTAG_Bitume_Allarme26
    CistTAG_Bitume_Allarme27
    CistTAG_Bitume_Allarme28
    CistTAG_Bitume_Allarme29
    CistTAG_Bitume_Allarme30
    CistTAG_Bitume_Allarme31
    CistTAG_Bitume_DB9_DBW36
    CistTAG_Bitume_CisternaSorgente_3
    CistTAG_Bitume_DB9_DBX400
    CistTAG_Bitume_DB9_DBX401
    CistTAG_Bitume_DI_AriaImpiantoCisterneOK
    CistTAG_Bitume_DI_Compressore
    CistTAG_Bitume_DB9_DBX404
    CistTAG_Bitume_DB9_DBX405
    CistTAG_Bitume_DB9_DBX406
    CistTAG_Bitume_DB9_DBX407
    CistTAG_Bitume_DB9_DBX410
    CistTAG_Bitume_DB9_DBX411
    CistTAG_Bitume_DB9_DBX412
    CistTAG_Bitume_DB9_DBX413
    CistTAG_Bitume_TempMinConsensoStartPompaCarico
    CistTAG_Bitume_TempMinCircuito
    CistTAG_Bitume_DB9_DBX540
    CistTAG_Bitume_DB9_DBX541
    CistTAG_Bitume_DB9_DBX542
    CistTAG_Bitume_DB9_DBX543
    CistTAG_Bitume_DB9_DBX544
    CistTAG_Bitume_DB9_DBX545
    CistTAG_Bitume_DB9_DBX546
    CistTAG_Bitume_DB9_DBX547
    CistTAG_Bitume_DB9_DBX550
    CistTAG_Emulsione_ValvoleGestioneManuale
    CistTAG_Emulsione_ArrestoEmergenzaValvole
    CistTAG_Emulsione_DI_PompaCircEmulsione
    CistTAG_Emulsione_ForzaOperazioneSuAllarme
    CistTAG_Emulsione_NumeroCisterneDB9
    CistTAG_Emulsione_NumeroCisternaDefaultDB9
    CistTAG_Emulsione_CodiceOperazioneCisternaDaEseguire
    CistTAG_Emulsione_NumeroCisternaAlimImp_NEW
    CistTAG_Emulsione_NumeroCisternaAlimImp_OLD
    CistTAG_Emulsione_NumeroCisternaCarico
    CistTAG_Emulsione_CMD_StartOperazioneCisterna
    CistTAG_Emulsione_CMD_StopOperazioneCisterna
    CistTAG_Emulsione_CMD_AzzeraTara
    CistTAG_Emulsione_CodiceOperazioneCisternaInCorso
    CistTAG_Emulsione_AzzeraTaraCisternaNumero
    CistTAG_Emulsione_Allarme0
    CistTAG_Emulsione_Allarme1
    CistTAG_Emulsione_Allarme2
    CistTAG_Emulsione_Allarme3
    CistTAG_Emulsione_Allarme4
    CistTAG_Emulsione_Allarme5
    CistTAG_Emulsione_Allarme6
    CistTAG_Emulsione_Allarme7
    CistTAG_Emulsione_Allarme8
    CistTAG_Emulsione_Allarme9
    CistTAG_Emulsione_Allarme10
    CistTAG_Emulsione_Allarme11
    CistTAG_Emulsione_Allarme12
    CistTAG_Emulsione_Allarme13
    CistTAG_Emulsione_Allarme14
    CistTAG_Emulsione_Allarme15
    CistTAG_Emulsione_Allarme16
    CistTAG_Emulsione_Allarme17
    CistTAG_Emulsione_Allarme18
    CistTAG_Emulsione_Allarme19
    CistTAG_Emulsione_Allarme20
    CistTAG_Emulsione_Allarme21
    CistTAG_Emulsione_Allarme22
    CistTAG_Emulsione_Allarme23
    CistTAG_Emulsione_Allarme24
    CistTAG_Emulsione_Allarme25
    CistTAG_Emulsione_Allarme26
    CistTAG_Emulsione_Allarme27
    CistTAG_Emulsione_Allarme28
    CistTAG_Emulsione_Allarme29
    CistTAG_Emulsione_Allarme30
    CistTAG_Emulsione_Allarme31
    CistTAG_Emulsione_DI_ValvBypassOpen
    CistTAG_Emulsione_DI_ValvLineaOpen
    CistTAG_Emulsione_DI_ValvBypassClose
    CistTAG_Emulsione_DI_ValvLineaClose
    CistTAG_Emulsione_DI_ValvCaricoOpen
    CistTAG_Emulsione_DI_ValvCaricoClose
    CistTAG_Emulsione_DI_ValvAntiritOpen
    CistTAG_Emulsione_DI_ValvAntiritClose
    CistTAG_Emulsione_TempMinConsensoStartPompaCarico
    CistTAG_Bitume_Valvola_0_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_0_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_0_DI_Apertura
    CistTAG_Bitume_Valvola_0_DI_Chiusura
    CistTAG_Bitume_Valvola_0_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_0_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_0_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_0_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_0_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_0_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_0_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_0_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_0_CMD_Valvola
    CistTAG_Bitume_Valvola_0_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_0_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_0_Codice_Allarme
    CistTAG_Bitume_Valvola_0_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_0_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_0_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_0_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_1_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_1_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_1_DI_Apertura
    CistTAG_Bitume_Valvola_1_DI_Chiusura
    CistTAG_Bitume_Valvola_1_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_1_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_1_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_1_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_1_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_1_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_1_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_1_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_1_CMD_Valvola
    CistTAG_Bitume_Valvola_1_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_1_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_1_Codice_Allarme
    CistTAG_Bitume_Valvola_1_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_1_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_1_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_1_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_2_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_2_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_2_DI_Apertura
    CistTAG_Bitume_Valvola_2_DI_Chiusura
    CistTAG_Bitume_Valvola_2_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_2_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_2_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_2_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_2_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_2_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_2_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_2_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_2_CMD_Valvola
    CistTAG_Bitume_Valvola_2_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_2_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_2_Codice_Allarme
    CistTAG_Bitume_Valvola_2_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_2_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_2_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_2_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_3_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_3_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_3_DI_Apertura
    CistTAG_Bitume_Valvola_3_DI_Chiusura
    CistTAG_Bitume_Valvola_3_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_3_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_3_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_3_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_3_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_3_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_3_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_3_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_3_CMD_Valvola
    CistTAG_Bitume_Valvola_3_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_3_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_3_Codice_Allarme
    CistTAG_Bitume_Valvola_3_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_3_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_3_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_3_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_4_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_4_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_4_DI_Apertura
    CistTAG_Bitume_Valvola_4_DI_Chiusura
    CistTAG_Bitume_Valvola_4_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_4_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_4_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_4_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_4_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_4_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_4_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_4_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_4_CMD_Valvola
    CistTAG_Bitume_Valvola_4_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_4_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_4_Codice_Allarme
    CistTAG_Bitume_Valvola_4_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_4_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_4_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_4_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_5_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_5_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_5_DI_Apertura
    CistTAG_Bitume_Valvola_5_DI_Chiusura
    CistTAG_Bitume_Valvola_5_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_5_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_5_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_5_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_5_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_5_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_5_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_5_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_5_CMD_Valvola
    CistTAG_Bitume_Valvola_5_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_5_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_5_Codice_Allarme
    CistTAG_Bitume_Valvola_5_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_5_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_5_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_5_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_6_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_6_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_6_DI_Apertura
    CistTAG_Bitume_Valvola_6_DI_Chiusura
    CistTAG_Bitume_Valvola_6_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_6_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_6_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_6_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_6_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_6_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_6_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_6_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_6_CMD_Valvola
    CistTAG_Bitume_Valvola_6_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_6_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_6_Codice_Allarme
    CistTAG_Bitume_Valvola_6_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_6_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_6_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_6_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_7_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_7_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_7_DI_Apertura
    CistTAG_Bitume_Valvola_7_DI_Chiusura
    CistTAG_Bitume_Valvola_7_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_7_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_7_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_7_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_7_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_7_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_7_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_7_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_7_CMD_Valvola
    CistTAG_Bitume_Valvola_7_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_7_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_7_Codice_Allarme
    CistTAG_Bitume_Valvola_7_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_7_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_7_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_7_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_8_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_8_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_8_DI_Apertura
    CistTAG_Bitume_Valvola_8_DI_Chiusura
    CistTAG_Bitume_Valvola_8_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_8_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_8_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_8_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_8_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_8_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_8_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_8_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_8_CMD_Valvola
    CistTAG_Bitume_Valvola_8_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_8_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_8_Codice_Allarme
    CistTAG_Bitume_Valvola_8_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_8_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_8_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_8_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_9_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_9_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_9_DI_Apertura
    CistTAG_Bitume_Valvola_9_DI_Chiusura
    CistTAG_Bitume_Valvola_9_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_9_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_9_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_9_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_9_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_9_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_9_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_9_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_9_CMD_Valvola
    CistTAG_Bitume_Valvola_9_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_9_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_9_Codice_Allarme
    CistTAG_Bitume_Valvola_9_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_9_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_9_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_9_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_10_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_10_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_10_DI_Apertura
    CistTAG_Bitume_Valvola_10_DI_Chiusura
    CistTAG_Bitume_Valvola_10_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_10_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_10_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_10_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_10_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_10_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_10_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_10_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_10_CMD_Valvola
    CistTAG_Bitume_Valvola_10_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_10_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_10_Codice_Allarme
    CistTAG_Bitume_Valvola_10_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_10_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_10_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_10_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_11_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_11_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_11_DI_Apertura
    CistTAG_Bitume_Valvola_11_DI_Chiusura
    CistTAG_Bitume_Valvola_11_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_11_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_11_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_11_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_11_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_11_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_11_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_11_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_11_CMD_Valvola
    CistTAG_Bitume_Valvola_11_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_11_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_11_Codice_Allarme
    CistTAG_Bitume_Valvola_11_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_11_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_11_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_11_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_12_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_12_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_12_DI_Apertura
    CistTAG_Bitume_Valvola_12_DI_Chiusura
    CistTAG_Bitume_Valvola_12_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_12_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_12_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_12_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_12_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_12_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_12_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_12_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_12_CMD_Valvola
    CistTAG_Bitume_Valvola_12_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_12_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_12_Codice_Allarme
    CistTAG_Bitume_Valvola_12_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_12_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_12_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_12_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_13_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_13_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_13_DI_Apertura
    CistTAG_Bitume_Valvola_13_DI_Chiusura
    CistTAG_Bitume_Valvola_13_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_13_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_13_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_13_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_13_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_13_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_13_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_13_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_13_CMD_Valvola
    CistTAG_Bitume_Valvola_13_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_13_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_13_Codice_Allarme
    CistTAG_Bitume_Valvola_13_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_13_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_13_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_13_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_14_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_14_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_14_DI_Apertura
    CistTAG_Bitume_Valvola_14_DI_Chiusura
    CistTAG_Bitume_Valvola_14_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_14_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_14_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_14_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_14_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_14_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_14_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_14_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_14_CMD_Valvola
    CistTAG_Bitume_Valvola_14_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_14_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_14_Codice_Allarme
    CistTAG_Bitume_Valvola_14_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_14_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_14_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_14_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_15_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_15_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_15_DI_Apertura
    CistTAG_Bitume_Valvola_15_DI_Chiusura
    CistTAG_Bitume_Valvola_15_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_15_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_15_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_15_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_15_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_15_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_15_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_15_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_15_CMD_Valvola
    CistTAG_Bitume_Valvola_15_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_15_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_15_Codice_Allarme
    CistTAG_Bitume_Valvola_15_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_15_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_15_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_15_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_16_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_16_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_16_DI_Apertura
    CistTAG_Bitume_Valvola_16_DI_Chiusura
    CistTAG_Bitume_Valvola_16_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_16_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_16_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_16_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_16_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_16_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_16_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_16_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_16_CMD_Valvola
    CistTAG_Bitume_Valvola_16_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_16_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_16_Codice_Allarme
    CistTAG_Bitume_Valvola_16_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_16_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_16_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_16_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_17_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_17_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_17_DI_Apertura
    CistTAG_Bitume_Valvola_17_DI_Chiusura
    CistTAG_Bitume_Valvola_17_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_17_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_17_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_17_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_17_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_17_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_17_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_17_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_17_CMD_Valvola
    CistTAG_Bitume_Valvola_17_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_17_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_17_Codice_Allarme
    CistTAG_Bitume_Valvola_17_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_17_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_17_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_17_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_18_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_18_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_18_DI_Apertura
    CistTAG_Bitume_Valvola_18_DI_Chiusura
    CistTAG_Bitume_Valvola_18_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_18_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_18_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_18_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_18_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_18_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_18_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_18_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_18_CMD_Valvola
    CistTAG_Bitume_Valvola_18_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_18_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_18_Codice_Allarme
    CistTAG_Bitume_Valvola_18_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_18_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_18_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_18_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_19_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_19_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_19_DI_Apertura
    CistTAG_Bitume_Valvola_19_DI_Chiusura
    CistTAG_Bitume_Valvola_19_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_19_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_19_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_19_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_19_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_19_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_19_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_19_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_19_CMD_Valvola
    CistTAG_Bitume_Valvola_19_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_19_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_19_Codice_Allarme
    CistTAG_Bitume_Valvola_19_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_19_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_19_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_19_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_20_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_20_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_20_DI_Apertura
    CistTAG_Bitume_Valvola_20_DI_Chiusura
    CistTAG_Bitume_Valvola_20_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_20_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_20_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_20_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_20_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_20_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_20_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_20_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_20_CMD_Valvola
    CistTAG_Bitume_Valvola_20_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_20_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_20_Codice_Allarme
    CistTAG_Bitume_Valvola_20_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_20_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_20_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_20_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_21_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_21_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_21_DI_Apertura
    CistTAG_Bitume_Valvola_21_DI_Chiusura
    CistTAG_Bitume_Valvola_21_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_21_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_21_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_21_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_21_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_21_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_21_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_21_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_21_CMD_Valvola
    CistTAG_Bitume_Valvola_21_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_21_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_21_Codice_Allarme
    CistTAG_Bitume_Valvola_21_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_21_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_21_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_21_NR_Operazioni_Chiusura
    CistTAG_Bitume_Valvola_22_FC_Valvola_Aperta
    CistTAG_Bitume_Valvola_22_FC_Valvola_Chiusa
    CistTAG_Bitume_Valvola_22_DI_Apertura
    CistTAG_Bitume_Valvola_22_DI_Chiusura
    CistTAG_Bitume_Valvola_22_DI_Blocco_Temperatura
    CistTAG_Bitume_Valvola_22_PARA_Inversione_Comando_Valvola
    CistTAG_Bitume_Valvola_22_PARA_EN_Gestione_Valvola
    CistTAG_Bitume_Valvola_22_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Bitume_Valvola_22_PARA_EN_CMD_Doppio
    CistTAG_Bitume_Valvola_22_PARA_TimeOut_Scambio_AP
    CistTAG_Bitume_Valvola_22_PARA_TimeOut_Scambio_CH
    CistTAG_Bitume_Valvola_22_PARA_Tempo_Trigger_FC
    CistTAG_Bitume_Valvola_22_CMD_Valvola
    CistTAG_Bitume_Valvola_22_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_22_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_22_Codice_Allarme
    CistTAG_Bitume_Valvola_22_OUT_Tempo_AP
    CistTAG_Bitume_Valvola_22_OUT_Tempo_CH
    CistTAG_Bitume_Valvola_22_NR_Operazioni_Apertura
    CistTAG_Bitume_Valvola_22_NR_Operazioni_Chiusura
'   Valvola linea 1 inclusione pompa di carico
'    CistTAG_Bitume_Valvola_23_FC_Valvola_Aperta
'    CistTAG_Bitume_Valvola_23_FC_Valvola_Chiusa
'    CistTAG_Bitume_Valvola_23_DI_Apertura
'    CistTAG_Bitume_Valvola_23_DI_Chiusura
'    CistTAG_Bitume_Valvola_23_DI_Blocco_Temperatura
'    CistTAG_Bitume_Valvola_23_PARA_Inversione_Comando_Valvola
'    CistTAG_Bitume_Valvola_23_PARA_EN_Gestione_Valvola
'    CistTAG_Bitume_Valvola_23_PARA_EN_Tipo_Valvola_Manuale
'    CistTAG_Bitume_Valvola_23_PARA_EN_CMD_Doppio
'    CistTAG_Bitume_Valvola_23_PARA_TimeOut_Scambio_AP
'    CistTAG_Bitume_Valvola_23_PARA_TimeOut_Scambio_CH
'    CistTAG_Bitume_Valvola_23_PARA_Tempo_Trigger_FC
'    CistTAG_Bitume_Valvola_23_CMD_Valvola
    CistTAG_Bitume_Valvola_23_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_23_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_23_Codice_Allarme
'    CistTAG_Bitume_Valvola_23_OUT_Tempo_AP
'    CistTAG_Bitume_Valvola_23_OUT_Tempo_CH
'    CistTAG_Bitume_Valvola_23_NR_Operazioni_Apertura
'    CistTAG_Bitume_Valvola_23_NR_Operazioni_Chiusura
'    '
'    Valvola linea 2 inclusione pompa di carico
'    CistTAG_Bitume_Valvola_24_FC_Valvola_Aperta
'    CistTAG_Bitume_Valvola_24_FC_Valvola_Chiusa
'    CistTAG_Bitume_Valvola_24_DI_Apertura
'    CistTAG_Bitume_Valvola_24_DI_Chiusura
'    CistTAG_Bitume_Valvola_24_DI_Blocco_Temperatura
'    CistTAG_Bitume_Valvola_24_PARA_Inversione_Comando_Valvola
'    CistTAG_Bitume_Valvola_24_PARA_EN_Gestione_Valvola
'    CistTAG_Bitume_Valvola_24_PARA_EN_Tipo_Valvola_Manuale
'    CistTAG_Bitume_Valvola_24_PARA_EN_CMD_Doppio
'    CistTAG_Bitume_Valvola_24_PARA_TimeOut_Scambio_AP
'    CistTAG_Bitume_Valvola_24_PARA_TimeOut_Scambio_CH
'    CistTAG_Bitume_Valvola_24_PARA_Tempo_Trigger_FC
'    CistTAG_Bitume_Valvola_24_CMD_Valvola
    CistTAG_Bitume_Valvola_24_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_24_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_24_Codice_Allarme
'    CistTAG_Bitume_Valvola_24_OUT_Tempo_AP
'    CistTAG_Bitume_Valvola_24_OUT_Tempo_CH
'    CistTAG_Bitume_Valvola_24_NR_Operazioni_Apertura
'    CistTAG_Bitume_Valvola_24_NR_Operazioni_Chiusura
'    '
'    Valvola bypass esclusione pompa di carico
'    CistTAG_Bitume_Valvola_25_FC_Valvola_Aperta
'    CistTAG_Bitume_Valvola_25_FC_Valvola_Chiusa
'    CistTAG_Bitume_Valvola_25_DI_Apertura
'    CistTAG_Bitume_Valvola_25_DI_Chiusura
'    CistTAG_Bitume_Valvola_25_DI_Blocco_Temperatura
'    CistTAG_Bitume_Valvola_25_PARA_Inversione_Comando_Valvola
'    CistTAG_Bitume_Valvola_25_PARA_EN_Gestione_Valvola
'    CistTAG_Bitume_Valvola_25_PARA_EN_Tipo_Valvola_Manuale
'    CistTAG_Bitume_Valvola_25_PARA_EN_CMD_Doppio
'    CistTAG_Bitume_Valvola_25_PARA_TimeOut_Scambio_AP
'    CistTAG_Bitume_Valvola_25_PARA_TimeOut_Scambio_CH
'    CistTAG_Bitume_Valvola_25_PARA_Tempo_Trigger_FC
'    CistTAG_Bitume_Valvola_25_CMD_Valvola
    CistTAG_Bitume_Valvola_25_VALV_AP_Triggerata
    CistTAG_Bitume_Valvola_25_VALV_CH_Triggerata
    CistTAG_Bitume_Valvola_25_Codice_Allarme
'    CistTAG_Bitume_Valvola_25_OUT_Tempo_AP
'    CistTAG_Bitume_Valvola_25_OUT_Tempo_CH
'    CistTAG_Bitume_Valvola_25_NR_Operazioni_Apertura
'    CistTAG_Bitume_Valvola_25_NR_Operazioni_Chiusura
    '
    CistTAG_Emulsione_Valvola_0_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_0_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_0_DI_Apertura
    CistTAG_Emulsione_Valvola_0_DI_Chiusura
    CistTAG_Emulsione_Valvola_0_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_0_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_0_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_0_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_0_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_0_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_0_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_0_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_0_CMD_Valvola
    CistTAG_Emulsione_Valvola_0_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_0_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_0_Codice_Allarme
    CistTAG_Emulsione_Valvola_0_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_0_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_0_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_0_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_1_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_1_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_1_DI_Apertura
    CistTAG_Emulsione_Valvola_1_DI_Chiusura
    CistTAG_Emulsione_Valvola_1_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_1_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_1_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_1_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_1_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_1_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_1_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_1_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_1_CMD_Valvola
    CistTAG_Emulsione_Valvola_1_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_1_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_1_Codice_Allarme
    CistTAG_Emulsione_Valvola_1_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_1_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_1_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_1_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_2_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_2_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_2_DI_Apertura
    CistTAG_Emulsione_Valvola_2_DI_Chiusura
    CistTAG_Emulsione_Valvola_2_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_2_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_2_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_2_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_2_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_2_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_2_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_2_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_2_CMD_Valvola
    CistTAG_Emulsione_Valvola_2_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_2_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_2_Codice_Allarme
    CistTAG_Emulsione_Valvola_2_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_2_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_2_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_2_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_3_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_3_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_3_DI_Apertura
    CistTAG_Emulsione_Valvola_3_DI_Chiusura
    CistTAG_Emulsione_Valvola_3_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_3_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_3_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_3_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_3_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_3_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_3_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_3_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_3_CMD_Valvola
    CistTAG_Emulsione_Valvola_3_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_3_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_3_Codice_Allarme
    CistTAG_Emulsione_Valvola_3_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_3_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_3_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_3_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_4_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_4_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_4_DI_Apertura
    CistTAG_Emulsione_Valvola_4_DI_Chiusura
    CistTAG_Emulsione_Valvola_4_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_4_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_4_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_4_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_4_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_4_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_4_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_4_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_4_CMD_Valvola
    CistTAG_Emulsione_Valvola_4_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_4_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_4_Codice_Allarme
    CistTAG_Emulsione_Valvola_4_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_4_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_4_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_4_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_5_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_5_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_5_DI_Apertura
    CistTAG_Emulsione_Valvola_5_DI_Chiusura
    CistTAG_Emulsione_Valvola_5_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_5_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_5_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_5_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_5_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_5_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_5_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_5_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_5_CMD_Valvola
    CistTAG_Emulsione_Valvola_5_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_5_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_5_Codice_Allarme
    CistTAG_Emulsione_Valvola_5_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_5_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_5_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_5_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_6_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_6_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_6_DI_Apertura
    CistTAG_Emulsione_Valvola_6_DI_Chiusura
    CistTAG_Emulsione_Valvola_6_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_6_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_6_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_6_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_6_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_6_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_6_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_6_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_6_CMD_Valvola
    CistTAG_Emulsione_Valvola_6_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_6_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_6_Codice_Allarme
    CistTAG_Emulsione_Valvola_6_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_6_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_6_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_6_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_7_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_7_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_7_DI_Apertura
    CistTAG_Emulsione_Valvola_7_DI_Chiusura
    CistTAG_Emulsione_Valvola_7_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_7_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_7_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_7_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_7_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_7_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_7_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_7_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_7_CMD_Valvola
    CistTAG_Emulsione_Valvola_7_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_7_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_7_Codice_Allarme
    CistTAG_Emulsione_Valvola_7_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_7_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_7_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_7_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_8_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_8_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_8_DI_Apertura
    CistTAG_Emulsione_Valvola_8_DI_Chiusura
    CistTAG_Emulsione_Valvola_8_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_8_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_8_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_8_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_8_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_8_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_8_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_8_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_8_CMD_Valvola
    CistTAG_Emulsione_Valvola_8_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_8_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_8_Codice_Allarme
    CistTAG_Emulsione_Valvola_8_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_8_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_8_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_8_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_9_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_9_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_9_DI_Apertura
    CistTAG_Emulsione_Valvola_9_DI_Chiusura
    CistTAG_Emulsione_Valvola_9_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_9_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_9_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_9_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_9_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_9_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_9_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_9_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_9_CMD_Valvola
    CistTAG_Emulsione_Valvola_9_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_9_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_9_Codice_Allarme
    CistTAG_Emulsione_Valvola_9_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_9_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_9_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_9_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_10_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_10_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_10_DI_Apertura
    CistTAG_Emulsione_Valvola_10_DI_Chiusura
    CistTAG_Emulsione_Valvola_10_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_10_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_10_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_10_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_10_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_10_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_10_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_10_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_10_CMD_Valvola
    CistTAG_Emulsione_Valvola_10_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_10_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_10_Codice_Allarme
    CistTAG_Emulsione_Valvola_10_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_10_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_10_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_10_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_11_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_11_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_11_DI_Apertura
    CistTAG_Emulsione_Valvola_11_DI_Chiusura
    CistTAG_Emulsione_Valvola_11_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_11_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_11_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_11_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_11_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_11_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_11_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_11_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_11_CMD_Valvola
    CistTAG_Emulsione_Valvola_11_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_11_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_11_Codice_Allarme
    CistTAG_Emulsione_Valvola_11_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_11_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_11_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_11_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_12_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_12_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_12_DI_Apertura
    CistTAG_Emulsione_Valvola_12_DI_Chiusura
    CistTAG_Emulsione_Valvola_12_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_12_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_12_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_12_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_12_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_12_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_12_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_12_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_12_CMD_Valvola
    CistTAG_Emulsione_Valvola_12_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_12_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_12_Codice_Allarme
    CistTAG_Emulsione_Valvola_12_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_12_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_12_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_12_NR_Operazioni_Chiusura
    CistTAG_Emulsione_Valvola_13_FC_Valvola_Aperta
    CistTAG_Emulsione_Valvola_13_FC_Valvola_Chiusa
    CistTAG_Emulsione_Valvola_13_DI_Apertura
    CistTAG_Emulsione_Valvola_13_DI_Chiusura
    CistTAG_Emulsione_Valvola_13_DI_Blocco_Temperatura
    CistTAG_Emulsione_Valvola_13_PARA_Inversione_Comando_Valvola
    CistTAG_Emulsione_Valvola_13_PARA_EN_Gestione_Valvola
    CistTAG_Emulsione_Valvola_13_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Emulsione_Valvola_13_PARA_EN_CMD_Doppio
    CistTAG_Emulsione_Valvola_13_PARA_TimeOut_Scambio_AP
    CistTAG_Emulsione_Valvola_13_PARA_TimeOut_Scambio_CH
    CistTAG_Emulsione_Valvola_13_PARA_Tempo_Trigger_FC
    CistTAG_Emulsione_Valvola_13_CMD_Valvola
    CistTAG_Emulsione_Valvola_13_VALV_AP_Triggerata
    CistTAG_Emulsione_Valvola_13_VALV_CH_Triggerata
    CistTAG_Emulsione_Valvola_13_Codice_Allarme
    CistTAG_Emulsione_Valvola_13_OUT_Tempo_AP
    CistTAG_Emulsione_Valvola_13_OUT_Tempo_CH
    CistTAG_Emulsione_Valvola_13_NR_Operazioni_Apertura
    CistTAG_Emulsione_Valvola_13_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_0_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_0_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_0_DI_Apertura
    CistTAG_Combustibile_Valvola_0_DI_Chiusura
    CistTAG_Combustibile_Valvola_0_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_0_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_0_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_0_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_0_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_0_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_0_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_0_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_0_CMD_Valvola
    CistTAG_Combustibile_Valvola_0_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_0_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_0_Codice_Allarme
    CistTAG_Combustibile_Valvola_0_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_0_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_0_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_0_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_1_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_1_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_1_DI_Apertura
    CistTAG_Combustibile_Valvola_1_DI_Chiusura
    CistTAG_Combustibile_Valvola_1_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_1_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_1_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_1_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_1_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_1_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_1_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_1_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_1_CMD_Valvola
    CistTAG_Combustibile_Valvola_1_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_1_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_1_Codice_Allarme
    CistTAG_Combustibile_Valvola_1_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_1_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_1_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_1_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_2_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_2_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_2_DI_Apertura
    CistTAG_Combustibile_Valvola_2_DI_Chiusura
    CistTAG_Combustibile_Valvola_2_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_2_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_2_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_2_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_2_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_2_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_2_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_2_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_2_CMD_Valvola
    CistTAG_Combustibile_Valvola_2_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_2_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_2_Codice_Allarme
    CistTAG_Combustibile_Valvola_2_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_2_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_2_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_2_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_3_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_3_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_3_DI_Apertura
    CistTAG_Combustibile_Valvola_3_DI_Chiusura
    CistTAG_Combustibile_Valvola_3_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_3_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_3_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_3_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_3_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_3_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_3_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_3_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_3_CMD_Valvola
    CistTAG_Combustibile_Valvola_3_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_3_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_3_Codice_Allarme
    CistTAG_Combustibile_Valvola_3_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_3_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_3_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_3_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_4_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_4_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_4_DI_Apertura
    CistTAG_Combustibile_Valvola_4_DI_Chiusura
    CistTAG_Combustibile_Valvola_4_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_4_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_4_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_4_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_4_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_4_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_4_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_4_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_4_CMD_Valvola
    CistTAG_Combustibile_Valvola_4_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_4_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_4_Codice_Allarme
    CistTAG_Combustibile_Valvola_4_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_4_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_4_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_4_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_5_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_5_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_5_DI_Apertura
    CistTAG_Combustibile_Valvola_5_DI_Chiusura
    CistTAG_Combustibile_Valvola_5_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_5_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_5_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_5_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_5_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_5_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_5_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_5_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_5_CMD_Valvola
    CistTAG_Combustibile_Valvola_5_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_5_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_5_Codice_Allarme
    CistTAG_Combustibile_Valvola_5_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_5_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_5_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_5_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_6_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_6_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_6_DI_Apertura
    CistTAG_Combustibile_Valvola_6_DI_Chiusura
    CistTAG_Combustibile_Valvola_6_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_6_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_6_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_6_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_6_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_6_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_6_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_6_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_6_CMD_Valvola
    CistTAG_Combustibile_Valvola_6_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_6_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_6_Codice_Allarme
    CistTAG_Combustibile_Valvola_6_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_6_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_6_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_6_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_7_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_7_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_7_DI_Apertura
    CistTAG_Combustibile_Valvola_7_DI_Chiusura
    CistTAG_Combustibile_Valvola_7_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_7_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_7_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_7_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_7_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_7_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_7_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_7_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_7_CMD_Valvola
    CistTAG_Combustibile_Valvola_7_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_7_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_7_Codice_Allarme
    CistTAG_Combustibile_Valvola_7_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_7_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_7_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_7_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_8_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_8_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_8_DI_Apertura
    CistTAG_Combustibile_Valvola_8_DI_Chiusura
    CistTAG_Combustibile_Valvola_8_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_8_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_8_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_8_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_8_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_8_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_8_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_8_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_8_CMD_Valvola
    CistTAG_Combustibile_Valvola_8_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_8_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_8_Codice_Allarme
    CistTAG_Combustibile_Valvola_8_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_8_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_8_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_8_NR_Operazioni_Chiusura
    CistTAG_Combustibile_Valvola_9_FC_Valvola_Aperta
    CistTAG_Combustibile_Valvola_9_FC_Valvola_Chiusa
    CistTAG_Combustibile_Valvola_9_DI_Apertura
    CistTAG_Combustibile_Valvola_9_DI_Chiusura
    CistTAG_Combustibile_Valvola_9_DI_Blocco_Temperatura
    CistTAG_Combustibile_Valvola_9_PARA_Inversione_Comando_Valvola
    CistTAG_Combustibile_Valvola_9_PARA_EN_Gestione_Valvola
    CistTAG_Combustibile_Valvola_9_PARA_EN_Tipo_Valvola_Manuale
    CistTAG_Combustibile_Valvola_9_PARA_EN_CMD_Doppio
    CistTAG_Combustibile_Valvola_9_PARA_TimeOut_Scambio_AP
    CistTAG_Combustibile_Valvola_9_PARA_TimeOut_Scambio_CH
    CistTAG_Combustibile_Valvola_9_PARA_Tempo_Trigger_FC
    CistTAG_Combustibile_Valvola_9_CMD_Valvola
    CistTAG_Combustibile_Valvola_9_VALV_AP_Triggerata
    CistTAG_Combustibile_Valvola_9_VALV_CH_Triggerata
    CistTAG_Combustibile_Valvola_9_Codice_Allarme
    CistTAG_Combustibile_Valvola_9_OUT_Tempo_AP
    CistTAG_Combustibile_Valvola_9_OUT_Tempo_CH
    CistTAG_Combustibile_Valvola_9_NR_Operazioni_Apertura
    CistTAG_Combustibile_Valvola_9_NR_Operazioni_Chiusura
    CistTAG_Bitume_Cisterna1_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna1_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna2_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna2_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna3_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna3_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna4_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna4_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna5_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna5_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna6_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna6_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna7_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna7_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna8_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna8_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna9_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna9_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna10_Agitatore_CmdAvvio
    CistTAG_Bitume_Cisterna10_Agitatore_Ritorno
    CistTAG_Bitume_Cisterna1_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna2_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna3_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna4_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna5_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna6_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna7_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna8_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna9_AbilitazioneAgitatore
    CistTAG_Bitume_Cisterna10_AbilitazioneAgitatore
    '
    CistTAG_Bitume_Cisterna1_PID_GAIN
    CistTAG_Bitume_Cisterna1_PID_TI
    CistTAG_Bitume_Cisterna1_PID_TD
    CistTAG_Bitume_Cisterna1_PID_ControlZone
    CistTAG_Bitume_Cisterna2_PID_GAIN
    CistTAG_Bitume_Cisterna2_PID_TI
    CistTAG_Bitume_Cisterna2_PID_TD
    CistTAG_Bitume_Cisterna2_PID_ControlZone
    CistTAG_Bitume_Cisterna3_PID_GAIN
    CistTAG_Bitume_Cisterna3_PID_TI
    CistTAG_Bitume_Cisterna3_PID_TD
    CistTAG_Bitume_Cisterna3_PID_ControlZone
    CistTAG_Bitume_Cisterna4_PID_GAIN
    CistTAG_Bitume_Cisterna4_PID_TI
    CistTAG_Bitume_Cisterna4_PID_TD
    CistTAG_Bitume_Cisterna4_PID_ControlZone
    CistTAG_Bitume_Cisterna5_PID_GAIN
    CistTAG_Bitume_Cisterna5_PID_TI
    CistTAG_Bitume_Cisterna5_PID_TD
    CistTAG_Bitume_Cisterna5_PID_ControlZone
    CistTAG_Bitume_Cisterna6_PID_GAIN
    CistTAG_Bitume_Cisterna6_PID_TI
    CistTAG_Bitume_Cisterna6_PID_TD
    CistTAG_Bitume_Cisterna6_PID_ControlZone
    CistTAG_Bitume_Cisterna7_PID_GAIN
    CistTAG_Bitume_Cisterna7_PID_TI
    CistTAG_Bitume_Cisterna7_PID_TD
    CistTAG_Bitume_Cisterna7_PID_ControlZone
    CistTAG_Bitume_Cisterna8_PID_GAIN
    CistTAG_Bitume_Cisterna8_PID_TI
    CistTAG_Bitume_Cisterna8_PID_TD
    CistTAG_Bitume_Cisterna8_PID_ControlZone
    CistTAG_Bitume_Cisterna9_PID_GAIN
    CistTAG_Bitume_Cisterna9_PID_TI
    CistTAG_Bitume_Cisterna9_PID_TD
    CistTAG_Bitume_Cisterna9_PID_ControlZone
    CistTAG_Bitume_Cisterna10_PID_GAIN
    CistTAG_Bitume_Cisterna10_PID_TI
    CistTAG_Bitume_Cisterna10_PID_TD
    CistTAG_Bitume_Cisterna10_PID_ControlZone
    CistTAG_Mixer_PID_GAIN
    CistTAG_Mixer_PID_TI
    CistTAG_Mixer_PID_TD
    CistTAG_Mixer_PID_ControlZone
    CistTAG_Pannello_OperazioneBitumeCarico
    CistTAG_Pannello_OperazioneBitume
    CistTAG_Pannello_OperazioneEmulsione
    CistTAG_Pannello_ComandoAuxIncluso_1
    CistTAG_Pannello_ComandoAuxIncluso_2
    CistTAG_Pannello_ComandoAuxIncluso_3
    CistTAG_Pannello_ComandoAuxIncluso_4
    CistTAG_Pannello_ComandoAuxIncluso_5
    CistTAG_Pannello_ComandoAuxIncluso_6
    CistTAG_Pannello_ComandoAuxIncluso_7
    CistTAG_Pannello_ComandoAuxIncluso_8
    CistTAG_Sel_turni_settim_giorn
    CistTAG_Stato_LED_CALDAIA1
    CistTAG_Stato_LED_CALDAIA2
    CistTAG_Bitume_Cisterna1_TipoLivello
    CistTAG_Bitume_Cisterna1_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna1_InclusioneAgitatore
    CistTAG_Bitume_Cisterna1_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna1_TempUnitaLimitesup
    CistTAG_Bitume_Cisterna1_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna1_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna1_Densita
    CistTAG_Bitume_Cisterna1_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna1_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna1_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna1_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna1_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna1_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna1_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna1_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna1_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna1_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna1_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna1_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna1_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna1_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna1_LivelloTonValore
    CistTAG_Bitume_Cisterna1_TempGradiValore
    CistTAG_Bitume_Cisterna1_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna1_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna1_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna1_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna1_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna1_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna1_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna1_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna1_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna1_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna1_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna1_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna1_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna1_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna1_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna1_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna1_DiametroMm
    CistTAG_Bitume_Cisterna1_LunghezzaMm
    CistTAG_Bitume_Cisterna1_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna1_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna1_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna1_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna2_TipoLivello
    CistTAG_Bitume_Cisterna2_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna2_InclusioneAgitatore
    CistTAG_Bitume_Cisterna2_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna2_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna2_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna2_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna2_Densita
    CistTAG_Bitume_Cisterna2_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna2_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna2_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna2_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna2_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna2_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna2_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna2_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna2_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna2_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna2_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna2_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna2_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna2_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna2_LivelloTonValore
    CistTAG_Bitume_Cisterna2_TempGradiValore
    CistTAG_Bitume_Cisterna2_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna2_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna2_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna2_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna2_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna2_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna2_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna2_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna2_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna2_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna2_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna2_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna2_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna2_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna2_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna2_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna2_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna2_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna2_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna2_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna2_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna2_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna2_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna2_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna2_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna2_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna2_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna2_DiametroMm
    CistTAG_Bitume_Cisterna2_LunghezzaMm
    CistTAG_Bitume_Cisterna2_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna2_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna2_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna2_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna3_TipoLivello
    CistTAG_Bitume_Cisterna3_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna3_InclusioneAgitatore
    CistTAG_Bitume_Cisterna3_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna3_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna3_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna3_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna3_Densita
    CistTAG_Bitume_Cisterna3_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna3_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna3_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna3_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna3_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna3_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna3_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna3_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna3_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna3_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna3_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna3_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna3_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna3_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna3_LivelloTonValore
    CistTAG_Bitume_Cisterna3_TempGradiValore
    CistTAG_Bitume_Cisterna3_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna3_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna3_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna3_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna3_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna3_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna3_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna3_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna3_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna3_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna3_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna3_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna3_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna3_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna3_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna3_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna3_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna3_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna3_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna3_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna3_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna3_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna3_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna3_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna3_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna3_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna3_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna3_DiametroMm
    CistTAG_Bitume_Cisterna3_LunghezzaMm
    CistTAG_Bitume_Cisterna3_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna3_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna3_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna3_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna4_TipoLivello
    CistTAG_Bitume_Cisterna4_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna4_InclusioneAgitatore
    CistTAG_Bitume_Cisterna4_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna4_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna4_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna4_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna4_Densita
    CistTAG_Bitume_Cisterna4_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna4_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna4_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna4_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna4_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna4_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna4_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna4_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna4_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna4_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna4_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna4_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna4_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna4_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna4_LivelloTonValore
    CistTAG_Bitume_Cisterna4_TempGradiValore
    CistTAG_Bitume_Cisterna4_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna4_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna4_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna4_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna4_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna4_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna4_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna4_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna4_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna4_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna4_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna4_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna4_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna4_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna4_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna4_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna4_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna4_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna4_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna4_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna4_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna4_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna4_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna4_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna4_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna4_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna4_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna4_DiametroMm
    CistTAG_Bitume_Cisterna4_LunghezzaMm
    CistTAG_Bitume_Cisterna4_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna4_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna4_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna4_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna5_TipoLivello
    CistTAG_Bitume_Cisterna5_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna5_InclusioneAgitatore
    CistTAG_Bitume_Cisterna5_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna5_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna5_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna5_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna5_Densita
    CistTAG_Bitume_Cisterna5_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna5_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna5_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna5_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna5_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna5_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna5_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna5_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna5_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna5_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna5_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna5_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna5_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna5_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna5_LivelloTonValore
    CistTAG_Bitume_Cisterna5_TempGradiValore
    CistTAG_Bitume_Cisterna5_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna5_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna5_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna5_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna5_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna5_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna5_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna5_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna5_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna5_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna5_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna5_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna5_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna5_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna5_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna5_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna5_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna5_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna5_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna5_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna5_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna5_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna5_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna5_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna5_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna5_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna5_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna5_DiametroMm
    CistTAG_Bitume_Cisterna5_LunghezzaMm
    CistTAG_Bitume_Cisterna5_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna5_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna5_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna5_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna6_TipoLivello
    CistTAG_Bitume_Cisterna6_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna6_InclusioneAgitatore
    CistTAG_Bitume_Cisterna6_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna6_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna6_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna6_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna6_Densita
    CistTAG_Bitume_Cisterna6_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna6_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna6_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna6_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna6_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna6_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna6_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna6_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna6_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna6_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna6_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna6_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna6_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna6_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna6_LivelloTonValore
    CistTAG_Bitume_Cisterna6_TempGradiValore
    CistTAG_Bitume_Cisterna6_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna6_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna6_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna6_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna6_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna6_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna6_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna6_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna6_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna6_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna6_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna6_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna6_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna6_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna6_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna6_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna6_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna6_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna6_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna6_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna6_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna6_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna6_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna6_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna6_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna6_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna6_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna6_DiametroMm
    CistTAG_Bitume_Cisterna6_LunghezzaMm
    CistTAG_Bitume_Cisterna6_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna6_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna6_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna6_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna7_TipoLivello
    CistTAG_Bitume_Cisterna7_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna7_InclusioneAgitatore
    CistTAG_Bitume_Cisterna7_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna7_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna7_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna7_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna7_Densita
    CistTAG_Bitume_Cisterna7_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna7_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna7_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna7_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna7_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna7_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna7_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna7_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna7_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna7_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna7_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna7_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna7_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna7_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna7_LivelloTonValore
    CistTAG_Bitume_Cisterna7_TempGradiValore
    CistTAG_Bitume_Cisterna7_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna7_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna7_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna7_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna7_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna7_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna7_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna7_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna7_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna7_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna7_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna7_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna7_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna7_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna7_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna7_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna7_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna7_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna7_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna7_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna7_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna7_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna7_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna7_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna7_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna7_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna7_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna7_DiametroMm
    CistTAG_Bitume_Cisterna7_LunghezzaMm
    CistTAG_Bitume_Cisterna7_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna7_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna7_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna7_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna8_TipoLivello
    CistTAG_Bitume_Cisterna8_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna8_InclusioneAgitatore
    CistTAG_Bitume_Cisterna8_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna8_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna8_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna8_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna8_Densita
    CistTAG_Bitume_Cisterna8_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna8_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna8_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna8_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna8_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna8_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna8_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna8_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna8_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna8_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna8_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna8_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna8_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna8_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna8_LivelloTonValore
    CistTAG_Bitume_Cisterna8_TempGradiValore
    CistTAG_Bitume_Cisterna8_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna8_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna8_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna8_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna8_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna8_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna8_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna8_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna8_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna8_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna8_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna8_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna8_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna8_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna8_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna8_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna8_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna8_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna8_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna8_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna8_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna8_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna8_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna8_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna8_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna8_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna8_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna8_DiametroMm
    CistTAG_Bitume_Cisterna8_LunghezzaMm
    CistTAG_Bitume_Cisterna8_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna8_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna8_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna8_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna9_TipoLivello
    CistTAG_Bitume_Cisterna9_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna9_InclusioneAgitatore
    CistTAG_Bitume_Cisterna9_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna9_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna9_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna9_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna9_Densita
    CistTAG_Bitume_Cisterna9_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna9_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna9_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna9_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna9_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna9_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna9_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna9_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna9_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna9_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna9_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna9_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna9_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna9_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna9_LivelloTonValore
    CistTAG_Bitume_Cisterna9_TempGradiValore
    CistTAG_Bitume_Cisterna9_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna9_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna9_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna9_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna9_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna9_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna9_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna9_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna9_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna9_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna9_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna9_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna9_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna9_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna9_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna9_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna9_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna9_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna9_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna9_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna9_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna9_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna9_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna9_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna9_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna9_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna9_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna9_DiametroMm
    CistTAG_Bitume_Cisterna9_LunghezzaMm
    CistTAG_Bitume_Cisterna9_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna9_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna9_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna9_AbilitaValvolaAux
    CistTAG_Bitume_Cisterna10_TipoLivello
    CistTAG_Bitume_Cisterna10_BloccoValvoleBassaTemperatura
    CistTAG_Bitume_Cisterna10_InclusioneAgitatore
    CistTAG_Bitume_Cisterna10_TempUnitaLimiteInf
    CistTAG_Bitume_Cisterna10_TempUnitaLimieSup
    CistTAG_Bitume_Cisterna10_LivelloUnitaLimiteInf
    CistTAG_Bitume_Cisterna10_LivelloUnitaLimiteSup
    CistTAG_Bitume_Cisterna10_Densita
    CistTAG_Bitume_Cisterna10_TempGradiLimiteInf
    CistTAG_Bitume_Cisterna10_TempGradiLimiteSup
    CistTAG_Bitume_Cisterna10_LivelloTonLimiteInf
    CistTAG_Bitume_Cisterna10_LivelloTonLimiteSup
    CistTAG_Bitume_Cisterna10_TempGradiAllarmeMin
    CistTAG_Bitume_Cisterna10_TempGradiAllarmeMax
    CistTAG_Bitume_Cisterna10_LivelloTonAllarmeMin
    CistTAG_Bitume_Cisterna10_LivelloTonAllarmeMax
    CistTAG_Bitume_Cisterna10_LivelloTonAllarmeZonaMorta
    CistTAG_Bitume_Cisterna10_TempGradiAllarmeZonaMorta
    CistTAG_Bitume_Cisterna10_LivelloMin_DI_Trigger
    CistTAG_Bitume_Cisterna10_LivelloMax_DI_Trigger
    CistTAG_Bitume_Cisterna10_LivelloSic_DI_Trigger
    CistTAG_Bitume_Cisterna10_LivelloPercentualeValore
    CistTAG_Bitume_Cisterna10_LivelloTonValore
    CistTAG_Bitume_Cisterna10_TempGradiValore
    CistTAG_Bitume_Cisterna10_AllarmeCodiceGen
    CistTAG_Bitume_Cisterna10_ValvUscita1InverteComando
    CistTAG_Bitume_Cisterna10_ValvUscita1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna10_ValvUscita1TempoTimeOutClose
    CistTAG_Bitume_Cisterna10_ValvUscita1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna10_ValvUscita1Open_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvUscita1Close_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvUscita1AllarmeCodice
    CistTAG_Bitume_Cisterna10_DI_ValvRitornoBloccoTemp
    CistTAG_Bitume_Cisterna10_ValvEntrata1InverteComando
    CistTAG_Bitume_Cisterna10_ValvEntrata1TempoTimeOutOpen
    CistTAG_Bitume_Cisterna10_ValvEntrata1TempoTimeOutClose
    CistTAG_Bitume_Cisterna10_ValvEntrata1TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna10_ValvEntrata1Open_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvEntrata1Close_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvEntrata1AllarmeCodice
    CistTAG_Bitume_Cisterna10_DI_ValvCaricoBloccoTemp
    CistTAG_Bitume_Cisterna10_ValvUscita2InverteComando
    CistTAG_Bitume_Cisterna10_ValvUscita2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna10_ValvUscita2TempoTimeOutClose
    CistTAG_Bitume_Cisterna10_ValvUscita2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna10_ValvUscita2Open_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvUscita2Close_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvUscita2AllarmeCodice
    CistTAG_Bitume_Cisterna10_DI_ValvAuxBloccoTemp
    CistTAG_Bitume_Cisterna10_ValvEntrata2InverteComando
    CistTAG_Bitume_Cisterna10_ValvEntrata2TempoTimeOutOpen
    CistTAG_Bitume_Cisterna10_ValvEntrata2TempoTimeOutClose
    CistTAG_Bitume_Cisterna10_ValvEntrata2TempoAntirimbalzoFC
    CistTAG_Bitume_Cisterna10_ValvEntrata2Open_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvEntrata2Close_DI_Trigger
    CistTAG_Bitume_Cisterna10_ValvEntrata2AllarmeCodice
    CistTAG_Bitume_Cisterna10_NumeroValvolePresenti
    CistTAG_Bitume_Cisterna10_AbilitaOrizzontale
    CistTAG_Bitume_Cisterna10_DiametroMm
    CistTAG_Bitume_Cisterna10_LunghezzaMm
    CistTAG_Bitume_Cisterna10_AbilitaValvolaMandata
    CistTAG_Bitume_Cisterna10_AbilitaValvolaRitorno
    CistTAG_Bitume_Cisterna10_AbilitaValvolaCarico
    CistTAG_Bitume_Cisterna10_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna1_TipoLivello
    CistTAG_Emulsione_Cisterna1_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna1_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna1_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna1_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna1_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna1_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna1_Densita
    CistTAG_Emulsione_Cisterna1_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna1_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna1_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna1_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna1_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna1_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna1_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna1_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna1_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna1_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna1_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna1_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna1_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna1_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna1_LivelloTonValore
    CistTAG_Emulsione_Cisterna1_TempGradiValore
    CistTAG_Emulsione_Cisterna1_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna1_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna1_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna1_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna1_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna1_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna1_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna1_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna1_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna1_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna1_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna1_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna1_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna1_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna1_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna1_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna1_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna1_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna1_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna1_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna1_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna1_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna1_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna1_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna1_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna1_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna1_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna1_DiametroMm
    CistTAG_Emulsione_Cisterna1_LunghezzaMm
    CistTAG_Emulsione_Cisterna1_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna1_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna1_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna1_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna2_TipoLivello
    CistTAG_Emulsione_Cisterna2_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna2_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna2_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna2_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna2_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna2_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna2_Densita
    CistTAG_Emulsione_Cisterna2_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna2_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna2_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna2_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna2_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna2_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna2_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna2_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna2_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna2_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna2_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna2_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna2_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna2_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna2_LivelloTonValore
    CistTAG_Emulsione_Cisterna2_TempGradiValore
    CistTAG_Emulsione_Cisterna2_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna2_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna2_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna2_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna2_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna2_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna2_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna2_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna2_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna2_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna2_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna2_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna2_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna2_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna2_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna2_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna2_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna2_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna2_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna2_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna2_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna2_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna2_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna2_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna2_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna2_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna2_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna2_DiametroMm
    CistTAG_Emulsione_Cisterna2_LunghezzaMm
    CistTAG_Emulsione_Cisterna2_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna2_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna2_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna2_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna3_TipoLivello
    CistTAG_Emulsione_Cisterna3_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna3_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna3_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna3_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna3_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna3_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna3_Densita
    CistTAG_Emulsione_Cisterna3_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna3_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna3_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna3_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna3_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna3_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna3_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna3_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna3_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna3_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna3_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna3_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna3_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna3_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna3_LivelloTonValore
    CistTAG_Emulsione_Cisterna3_TempGradiValore
    CistTAG_Emulsione_Cisterna3_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna3_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna3_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna3_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna3_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna3_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna3_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna3_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna3_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna3_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna3_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna3_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna3_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna3_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna3_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna3_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna3_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna3_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna3_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna3_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna3_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna3_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna3_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna3_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna3_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna3_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna3_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna3_DiametroMm
    CistTAG_Emulsione_Cisterna3_LunghezzaMm
    CistTAG_Emulsione_Cisterna3_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna3_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna3_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna3_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna4_TipoLivello
    CistTAG_Emulsione_Cisterna4_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna4_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna4_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna4_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna4_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna4_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna4_Densita
    CistTAG_Emulsione_Cisterna4_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna4_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna4_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna4_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna4_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna4_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna4_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna4_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna4_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna4_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna4_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna4_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna4_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna4_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna4_LivelloTonValore
    CistTAG_Emulsione_Cisterna4_TempGradiValore
    CistTAG_Emulsione_Cisterna4_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna4_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna4_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna4_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna4_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna4_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna4_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna4_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna4_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna4_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna4_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna4_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna4_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna4_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna4_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna4_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna4_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna4_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna4_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna4_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna4_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna4_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna4_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna4_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna4_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna4_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna4_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna4_DiametroMm
    CistTAG_Emulsione_Cisterna4_LunghezzaMm
    CistTAG_Emulsione_Cisterna4_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna4_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna4_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna4_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna5_TipoLivello
    CistTAG_Emulsione_Cisterna5_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna5_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna5_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna5_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna5_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna5_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna5_Densita
    CistTAG_Emulsione_Cisterna5_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna5_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna5_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna5_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna5_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna5_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna5_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna5_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna5_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna5_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna5_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna5_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna5_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna5_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna5_LivelloTonValore
    CistTAG_Emulsione_Cisterna5_TempGradiValore
    CistTAG_Emulsione_Cisterna5_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna5_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna5_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna5_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna5_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna5_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna5_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna5_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna5_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna5_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna5_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna5_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna5_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna5_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna5_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna5_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna5_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna5_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna5_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna5_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna5_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna5_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna5_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna5_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna5_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna5_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna5_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna5_DiametroMm
    CistTAG_Emulsione_Cisterna5_LunghezzaMm
    CistTAG_Emulsione_Cisterna5_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna5_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna5_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna5_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna6_TipoLivello
    CistTAG_Emulsione_Cisterna6_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna6_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna6_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna6_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna6_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna6_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna6_Densita
    CistTAG_Emulsione_Cisterna6_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna6_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna6_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna6_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna6_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna6_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna6_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna6_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna6_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna6_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna6_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna6_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna6_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna6_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna6_LivelloTonValore
    CistTAG_Emulsione_Cisterna6_TempGradiValore
    CistTAG_Emulsione_Cisterna6_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna6_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna6_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna6_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna6_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna6_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna6_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna6_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna6_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna6_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna6_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna6_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna6_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna6_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna6_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna6_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna6_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna6_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna6_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna6_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna6_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna6_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna6_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna6_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna6_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna6_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna6_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna6_DiametroMm
    CistTAG_Emulsione_Cisterna6_LunghezzaMm
    CistTAG_Emulsione_Cisterna6_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna6_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna6_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna6_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna7_TipoLivello
    CistTAG_Emulsione_Cisterna7_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna7_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna7_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna7_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna7_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna7_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna7_Densita
    CistTAG_Emulsione_Cisterna7_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna7_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna7_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna7_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna7_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna7_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna7_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna7_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna7_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna7_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna7_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna7_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna7_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna7_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna7_LivelloTonValore
    CistTAG_Emulsione_Cisterna7_TempGradiValore
    CistTAG_Emulsione_Cisterna7_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna7_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna7_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna7_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna7_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna7_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna7_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna7_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna7_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna7_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna7_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna7_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna7_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna7_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna7_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna7_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna7_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna7_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna7_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna7_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna7_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna7_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna7_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna7_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna7_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna7_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna7_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna7_DiametroMm
    CistTAG_Emulsione_Cisterna7_LunghezzaMm
    CistTAG_Emulsione_Cisterna7_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna7_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna7_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna7_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna8_TipoLivello
    CistTAG_Emulsione_Cisterna8_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna8_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna8_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna8_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna8_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna8_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna8_Densita
    CistTAG_Emulsione_Cisterna8_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna8_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna8_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna8_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna8_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna8_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna8_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna8_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna8_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna8_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna8_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna8_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna8_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna8_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna8_LivelloTonValore
    CistTAG_Emulsione_Cisterna8_TempGradiValore
    CistTAG_Emulsione_Cisterna8_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna8_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna8_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna8_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna8_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna8_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna8_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna8_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna8_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna8_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna8_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna8_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna8_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna8_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna8_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna8_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna8_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna8_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna8_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna8_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna8_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna8_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna8_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna8_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna8_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna8_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna8_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna8_DiametroMm
    CistTAG_Emulsione_Cisterna8_LunghezzaMm
    CistTAG_Emulsione_Cisterna8_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna8_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna8_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna8_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna9_TipoLivello
    CistTAG_Emulsione_Cisterna9_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna9_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna9_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna9_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna9_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna9_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna9_Densita
    CistTAG_Emulsione_Cisterna9_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna9_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna9_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna9_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna9_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna9_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna9_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna9_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna9_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna9_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna9_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna9_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna9_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna9_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna9_LivelloTonValore
    CistTAG_Emulsione_Cisterna9_TempGradiValore
    CistTAG_Emulsione_Cisterna9_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna9_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna9_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna9_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna9_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna9_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna9_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna9_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna9_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna9_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna9_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna9_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna9_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna9_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna9_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna9_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna9_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna9_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna9_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna9_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna9_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna9_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna9_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna9_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna9_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna9_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna9_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna9_DiametroMm
    CistTAG_Emulsione_Cisterna9_LunghezzaMm
    CistTAG_Emulsione_Cisterna9_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna9_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna9_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna9_AbilitaValvolaAux
    CistTAG_Emulsione_Cisterna10_TipoLivello
    CistTAG_Emulsione_Cisterna10_BloccoValvoleBassaTemperatura
    CistTAG_Emulsione_Cisterna10_InclusioneAgitatore
    CistTAG_Emulsione_Cisterna10_TempUnitaLimiteInf
    CistTAG_Emulsione_Cisterna10_TempUnitaLimieSup
    CistTAG_Emulsione_Cisterna10_LivelloUnitaLimiteInf
    CistTAG_Emulsione_Cisterna10_LivelloUnitaLimiteSup
    CistTAG_Emulsione_Cisterna10_Densita
    CistTAG_Emulsione_Cisterna10_TempGradiLimiteInf
    CistTAG_Emulsione_Cisterna10_TempGradiLimiteSup
    CistTAG_Emulsione_Cisterna10_LivelloTonLimiteInf
    CistTAG_Emulsione_Cisterna10_LivelloTonLimiteSup
    CistTAG_Emulsione_Cisterna10_TempGradiAllarmeMin
    CistTAG_Emulsione_Cisterna10_TempGradiAllarmeMax
    CistTAG_Emulsione_Cisterna10_LivelloTonAllarmeMin
    CistTAG_Emulsione_Cisterna10_LivelloTonAllarmeMax
    CistTAG_Emulsione_Cisterna10_LivelloTonAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna10_TempGradiAllarmeZonaMorta
    CistTAG_Emulsione_Cisterna10_LivelloMin_DI_Trigger
    CistTAG_Emulsione_Cisterna10_LivelloMax_DI_Trigger
    CistTAG_Emulsione_Cisterna10_LivelloSic_DI_Trigger
    CistTAG_Emulsione_Cisterna10_LivelloPercentualeValore
    CistTAG_Emulsione_Cisterna10_LivelloTonValore
    CistTAG_Emulsione_Cisterna10_TempGradiValore
    CistTAG_Emulsione_Cisterna10_AllarmeCodiceGen
    CistTAG_Emulsione_Cisterna10_ValvMandataInverteComando
    CistTAG_Emulsione_Cisterna10_ValvMandataTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna10_ValvMandataTempoTimeOutClose
    CistTAG_Emulsione_Cisterna10_ValvMandataTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna10_ValvMandataOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvMandataClose_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvMandataAllarmeCodice
    CistTAG_Emulsione_Cisterna10_DI_ValvRitornoBloccoTemp
    CistTAG_Emulsione_Cisterna10_ValvRitornoInverteComando
    CistTAG_Emulsione_Cisterna10_ValvRitornoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna10_ValvRitornoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna10_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna10_ValvRitornoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvRitornoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvRitornoAllarmeCodice
    CistTAG_Emulsione_Cisterna10_DI_ValvCaricoBloccoTemp
    CistTAG_Emulsione_Cisterna10_ValvCaricoInverteComando
    CistTAG_Emulsione_Cisterna10_ValvCaricoTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna10_ValvCaricoTempoTimeOutClose
    CistTAG_Emulsione_Cisterna10_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna10_ValvCaricoOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvCaricoClose_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvCaricoAllarmeCodice
    CistTAG_Emulsione_Cisterna10_DI_ValvAuxBloccoTemp
    CistTAG_Emulsione_Cisterna10_ValvAuxInverteComando
    CistTAG_Emulsione_Cisterna10_ValvAuxTempoTimeOutOpen
    CistTAG_Emulsione_Cisterna10_ValvAuxTempoTimeOutClose
    CistTAG_Emulsione_Cisterna10_ValvAuxTempoAntirimbalzoFC
    CistTAG_Emulsione_Cisterna10_ValvAuxOpen_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvAuxClose_DI_Trigger
    CistTAG_Emulsione_Cisterna10_ValvAuxAllarmeCodice
    CistTAG_Emulsione_Cisterna10_NumeroValvolePresenti
    CistTAG_Emulsione_Cisterna10_AbilitaOrizzontale
    CistTAG_Emulsione_Cisterna10_DiametroMm
    CistTAG_Emulsione_Cisterna10_LunghezzaMm
    CistTAG_Emulsione_Cisterna10_AbilitaValvolaMandata
    CistTAG_Emulsione_Cisterna10_AbilitaValvolaRitorno
    CistTAG_Emulsione_Cisterna10_AbilitaValvolaCarico
    CistTAG_Emulsione_Cisterna10_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna1_TipoLivello
    CistTAG_Combustibile_Cisterna1_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna1_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna1_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna1_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna1_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna1_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna1_Densita
    CistTAG_Combustibile_Cisterna1_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna1_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna1_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna1_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna1_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna1_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna1_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna1_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna1_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna1_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna1_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna1_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna1_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna1_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna1_LivelloTonValore
    CistTAG_Combustibile_Cisterna1_TempGradiValore
    CistTAG_Combustibile_Cisterna1_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna1_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna1_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna1_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna1_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna1_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna1_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna1_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna1_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna1_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna1_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna1_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna1_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna1_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna1_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna1_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna1_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna1_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna1_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna1_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna1_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna1_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna1_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna1_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna1_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna1_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna1_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna1_DiametroMm
    CistTAG_Combustibile_Cisterna1_LunghezzaMm
    CistTAG_Combustibile_Cisterna1_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna1_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna1_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna1_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna2_TipoLivello
    CistTAG_Combustibile_Cisterna2_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna2_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna2_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna2_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna2_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna2_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna2_Densita
    CistTAG_Combustibile_Cisterna2_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna2_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna2_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna2_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna2_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna2_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna2_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna2_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna2_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna2_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna2_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna2_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna2_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna2_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna2_LivelloTonValore
    CistTAG_Combustibile_Cisterna2_TempGradiValore
    CistTAG_Combustibile_Cisterna2_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna2_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna2_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna2_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna2_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna2_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna2_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna2_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna2_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna2_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna2_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna2_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna2_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna2_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna2_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna2_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna2_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna2_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna2_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna2_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna2_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna2_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna2_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna2_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna2_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna2_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna2_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna2_DiametroMm
    CistTAG_Combustibile_Cisterna2_LunghezzaMm
    CistTAG_Combustibile_Cisterna2_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna2_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna2_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna2_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna3_TipoLivello
    CistTAG_Combustibile_Cisterna3_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna3_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna3_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna3_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna3_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna3_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna3_Densita
    CistTAG_Combustibile_Cisterna3_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna3_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna3_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna3_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna3_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna3_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna3_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna3_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna3_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna3_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna3_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna3_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna3_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna3_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna3_LivelloTonValore
    CistTAG_Combustibile_Cisterna3_TempGradiValore
    CistTAG_Combustibile_Cisterna3_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna3_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna3_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna3_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna3_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna3_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna3_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna3_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna3_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna3_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna3_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna3_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna3_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna3_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna3_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna3_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna3_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna3_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna3_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna3_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna3_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna3_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna3_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna3_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna3_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna3_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna3_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna3_DiametroMm
    CistTAG_Combustibile_Cisterna3_LunghezzaMm
    CistTAG_Combustibile_Cisterna3_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna3_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna3_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna3_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna4_TipoLivello
    CistTAG_Combustibile_Cisterna4_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna4_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna4_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna4_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna4_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna4_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna4_Densita
    CistTAG_Combustibile_Cisterna4_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna4_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna4_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna4_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna4_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna4_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna4_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna4_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna4_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna4_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna4_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna4_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna4_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna4_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna4_LivelloTonValore
    CistTAG_Combustibile_Cisterna4_TempGradiValore
    CistTAG_Combustibile_Cisterna4_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna4_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna4_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna4_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna4_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna4_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna4_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna4_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna4_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna4_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna4_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna4_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna4_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna4_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna4_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna4_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna4_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna4_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna4_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna4_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna4_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna4_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna4_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna4_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna4_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna4_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna4_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna4_DiametroMm
    CistTAG_Combustibile_Cisterna4_LunghezzaMm
    CistTAG_Combustibile_Cisterna4_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna4_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna4_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna4_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna5_TipoLivello
    CistTAG_Combustibile_Cisterna5_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna5_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna5_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna5_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna5_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna5_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna5_Densita
    CistTAG_Combustibile_Cisterna5_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna5_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna5_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna5_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna5_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna5_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna5_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna5_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna5_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna5_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna5_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna5_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna5_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna5_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna5_LivelloTonValore
    CistTAG_Combustibile_Cisterna5_TempGradiValore
    CistTAG_Combustibile_Cisterna5_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna5_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna5_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna5_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna5_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna5_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna5_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna5_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna5_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna5_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna5_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna5_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna5_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna5_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna5_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna5_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna5_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna5_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna5_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna5_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna5_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna5_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna5_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna5_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna5_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna5_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna5_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna5_DiametroMm
    CistTAG_Combustibile_Cisterna5_LunghezzaMm
    CistTAG_Combustibile_Cisterna5_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna5_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna5_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna5_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna6_TipoLivello
    CistTAG_Combustibile_Cisterna6_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna6_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna6_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna6_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna6_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna6_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna6_Densita
    CistTAG_Combustibile_Cisterna6_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna6_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna6_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna6_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna6_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna6_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna6_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna6_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna6_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna6_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna6_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna6_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna6_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna6_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna6_LivelloTonValore
    CistTAG_Combustibile_Cisterna6_TempGradiValore
    CistTAG_Combustibile_Cisterna6_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna6_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna6_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna6_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna6_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna6_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna6_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna6_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna6_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna6_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna6_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna6_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna6_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna6_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna6_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna6_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna6_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna6_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna6_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna6_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna6_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna6_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna6_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna6_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna6_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna6_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna6_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna6_DiametroMm
    CistTAG_Combustibile_Cisterna6_LunghezzaMm
    CistTAG_Combustibile_Cisterna6_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna6_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna6_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna6_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna7_TipoLivello
    CistTAG_Combustibile_Cisterna7_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna7_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna7_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna7_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna7_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna7_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna7_Densita
    CistTAG_Combustibile_Cisterna7_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna7_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna7_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna7_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna7_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna7_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna7_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna7_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna7_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna7_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna7_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna7_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna7_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna7_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna7_LivelloTonValore
    CistTAG_Combustibile_Cisterna7_TempGradiValore
    CistTAG_Combustibile_Cisterna7_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna7_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna7_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna7_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna7_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna7_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna7_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna7_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna7_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna7_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna7_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna7_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna7_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna7_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna7_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna7_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna7_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna7_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna7_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna7_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna7_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna7_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna7_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna7_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna7_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna7_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna7_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna7_DiametroMm
    CistTAG_Combustibile_Cisterna7_LunghezzaMm
    CistTAG_Combustibile_Cisterna7_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna7_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna7_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna7_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna8_TipoLivello
    CistTAG_Combustibile_Cisterna8_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna8_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna8_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna8_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna8_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna8_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna8_Densita
    CistTAG_Combustibile_Cisterna8_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna8_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna8_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna8_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna8_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna8_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna8_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna8_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna8_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna8_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna8_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna8_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna8_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna8_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna8_LivelloTonValore
    CistTAG_Combustibile_Cisterna8_TempGradiValore
    CistTAG_Combustibile_Cisterna8_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna8_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna8_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna8_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna8_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna8_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna8_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna8_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna8_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna8_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna8_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna8_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna8_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna8_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna8_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna8_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna8_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna8_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna8_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna8_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna8_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna8_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna8_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna8_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna8_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna8_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna8_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna8_DiametroMm
    CistTAG_Combustibile_Cisterna8_LunghezzaMm
    CistTAG_Combustibile_Cisterna8_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna8_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna8_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna8_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna9_TipoLivello
    CistTAG_Combustibile_Cisterna9_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna9_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna9_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna9_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna9_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna9_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna9_Densita
    CistTAG_Combustibile_Cisterna9_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna9_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna9_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna9_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna9_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna9_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna9_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna9_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna9_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna9_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna9_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna9_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna9_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna9_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna9_LivelloTonValore
    CistTAG_Combustibile_Cisterna9_TempGradiValore
    CistTAG_Combustibile_Cisterna9_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna9_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna9_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna9_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna9_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna9_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna9_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna9_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna9_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna9_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna9_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna9_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna9_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna9_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna9_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna9_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna9_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna9_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna9_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna9_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna9_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna9_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna9_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna9_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna9_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna9_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna9_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna9_DiametroMm
    CistTAG_Combustibile_Cisterna9_LunghezzaMm
    CistTAG_Combustibile_Cisterna9_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna9_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna9_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna9_AbilitaValvolaAux
    CistTAG_Combustibile_Cisterna10_TipoLivello
    CistTAG_Combustibile_Cisterna10_BloccoValvoleBassaTemperatura
    CistTAG_Combustibile_Cisterna10_InclusioneAgitatore
    CistTAG_Combustibile_Cisterna10_TempUnitaLimiteInf
    CistTAG_Combustibile_Cisterna10_TempUnitaLimieSup
    CistTAG_Combustibile_Cisterna10_LivelloUnitaLimiteInf
    CistTAG_Combustibile_Cisterna10_LivelloUnitaLimiteSup
    CistTAG_Combustibile_Cisterna10_Densita
    CistTAG_Combustibile_Cisterna10_TempGradiLimiteInf
    CistTAG_Combustibile_Cisterna10_TempGradiLimiteSup
    CistTAG_Combustibile_Cisterna10_LivelloTonLimiteInf
    CistTAG_Combustibile_Cisterna10_LivelloTonLimiteSup
    CistTAG_Combustibile_Cisterna10_TempGradiAllarmeMin
    CistTAG_Combustibile_Cisterna10_TempGradiAllarmeMax
    CistTAG_Combustibile_Cisterna10_LivelloTonAllarmeMin
    CistTAG_Combustibile_Cisterna10_LivelloTonAllarmeMax
    CistTAG_Combustibile_Cisterna10_LivelloTonAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna10_TempGradiAllarmeZonaMorta
    CistTAG_Combustibile_Cisterna10_LivelloMin_DI_Trigger
    CistTAG_Combustibile_Cisterna10_LivelloMax_DI_Trigger
    CistTAG_Combustibile_Cisterna10_LivelloSic_DI_Trigger
    CistTAG_Combustibile_Cisterna10_LivelloPercentualeValore
    CistTAG_Combustibile_Cisterna10_LivelloTonValore
    CistTAG_Combustibile_Cisterna10_TempGradiValore
    CistTAG_Combustibile_Cisterna10_AllarmeCodiceGen
    CistTAG_Combustibile_Cisterna10_ValvMandataInverteComando
    CistTAG_Combustibile_Cisterna10_ValvMandataTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna10_ValvMandataTempoTimeOutClose
    CistTAG_Combustibile_Cisterna10_ValvMandataTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna10_ValvMandataOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvMandataClose_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvMandataAllarmeCodice
    CistTAG_Combustibile_Cisterna10_DI_ValvRitornoBloccoTemp
    CistTAG_Combustibile_Cisterna10_ValvRitornoInverteComando
    CistTAG_Combustibile_Cisterna10_ValvRitornoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna10_ValvRitornoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna10_ValvRitornoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna10_ValvRitornoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvRitornoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvRitornoAllarmeCodice
    CistTAG_Combustibile_Cisterna10_DI_ValvCaricoBloccoTemp
    CistTAG_Combustibile_Cisterna10_ValvCaricoInverteComando
    CistTAG_Combustibile_Cisterna10_ValvCaricoTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna10_ValvCaricoTempoTimeOutClose
    CistTAG_Combustibile_Cisterna10_ValvCaricoTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna10_ValvCaricoOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvCaricoClose_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvCaricoAllarmeCodice
    CistTAG_Combustibile_Cisterna10_DI_ValvAuxBloccoTemp
    CistTAG_Combustibile_Cisterna10_ValvAuxInverteComando
    CistTAG_Combustibile_Cisterna10_ValvAuxTempoTimeOutOpen
    CistTAG_Combustibile_Cisterna10_ValvAuxTempoTimeOutClose
    CistTAG_Combustibile_Cisterna10_ValvAuxTempoAntirimbalzoFC
    CistTAG_Combustibile_Cisterna10_ValvAuxOpen_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvAuxClose_DI_Trigger
    CistTAG_Combustibile_Cisterna10_ValvAuxAllarmeCodice
    CistTAG_Combustibile_Cisterna10_NumeroValvolePresenti
    CistTAG_Combustibile_Cisterna10_AbilitaOrizzontale
    CistTAG_Combustibile_Cisterna10_DiametroMm
    CistTAG_Combustibile_Cisterna10_LunghezzaMm
    CistTAG_Combustibile_Cisterna10_AbilitaValvolaMandata
    CistTAG_Combustibile_Cisterna10_AbilitaValvolaRitorno
    CistTAG_Combustibile_Cisterna10_AbilitaValvolaCarico
    CistTAG_Combustibile_Cisterna10_AbilitaValvolaAux
    CistTAG_AUX_RiscLineaCircBitume_CmdStart
    CistTAG_AUX_RiscLineaCircBitume_DI_Termica
    CistTAG_AUX_RiscLineaCaricoBitume_CmdStart
    CistTAG_AUX_RiscLineaCaricoBitume_DI_Termica
    CistTAG_AUX_RiscPompaCircBitume_CmdStart
    CistTAG_AUX_RiscPompaCircBitume_DI_Termica
    CistTAG_AUX_RiscLineaMixer_CmdStart
    CistTAG_AUX_RiscLineaMixer_DI_Termica
    CistTAG_AUX_RiscLineaCombustibile_CmdStart
    CistTAG_AUX_RiscLineaCombustibile_DI_Termica
    CistTAG_AUX_Scambiatore_CmdStart
    CistTAG_AUX_Scambiatore_DI_Termica
    CistTAG_AUX_RiscAdditivo_CmdStart
    CistTAG_AUX_RiscAdditivo_DI_Termica
    CistTAG_AUX_Agitatore_CmdStart
    CistTAG_AUX_Agitatore_DI_Termica
    CistTAG_AUX_AlimentazioneCisterne_CmdStart
    CistTAG_AUX_AlimentazioneCisterne_DI_Termica
    CistTAG_AUX_RiscLinea1Emulsione_CmdStart
    CistTAG_AUX_RiscLinea1Emulsione_DI_Termica
    CistTAG_AUX_RiscLinea2Emulsione_CmdStart
    CistTAG_AUX_RiscLinea2Emulsione_DI_Termica
    CistTAG_AUX_RiscLinea3Emulsione_CmdStart
    CistTAG_AUX_RiscLinea3Emulsione_DI_Termica
    CistTAG_AUX_RiscLinea4Emulsione_CmdStart
    CistTAG_AUX_RiscLinea4Emulsione_DI_Termica
    CistTAG_PUMPAUX1_Start
    CistTAG_PUMPAUX1_Ritorno
    CistTAG_PUMPAUX1_ErroriPresenti
    CistTAG_PUMPAUX2_Start
    CistTAG_PUMPAUX2_Ritorno
    CistTAG_PUMPAUX2_ErroriPresenti
    CistTAG_PUMPAUX3_Start
    CistTAG_PUMPAUX3_Ritorno
    CistTAG_PUMPAUX3_ErroriPresenti

    CistTAG_PompaCaricoBitume_DI_Ritorno
    CistTAG_PompaCaricoBitume_TempoTimeOutStart
    CistTAG_PompaCaricoBitume_TempoTimeOutStop
    CistTAG_PompaCaricoBitume_AllarmeCodice
    CistTAG_PompaCaricoEmulsione_DI_Ritorno
    CistTAG_PompaCaricoEmulsione_TempoTimeOutStart
    CistTAG_PompaCaricoEmulsione_TempoTimeOutStop
    CistTAG_PompaCaricoEmulsione_AllarmeCodice
    CistTAG_PompaCaricoBitume2_TimeOutAvvio
    CistTAG_PompaCaricoBitume2_ScattoTermica
    CistTAG_SondaTuboCaricoBitume_UnitaLimiteInf
    CistTAG_SondaTuboCaricoBitume_UnitaLimiteSup
    CistTAG_SondaTuboCaricoBitume_GradiLimiteInf
    CistTAG_SondaTuboCaricoBitume_GradiLimiteSup

    CistTAG_Stato_OpCar_Bitume
    CistTAG_Stato_OpAlim_Bitume

    CistTAG_SondaTuboCaricoBitume_TempGradiValore
    'Nuovi TAG operazioni separate cisterne
    CistTAG_SelOperazionePompaCarico
    CistTAG_SelOperazionePompaAlimentazione
    CistTAG_SelCisternaCaricoPompaCarico
    CistTAG_SelCisternaMandataPompaCarico
    CistTAG_SelCisternaCaricoPompaAlimentazione
    CistTAG_SelCisternaMandataPompaAlimentazione
    CistTAG_SelAlimentazioneTorrePompaAlimentazione
    CistTAG_OperazioneCaricoARegime
    CistTAG_OperazioneAlimentazioneARegime
    CistTAG_OperazioneAlimentazioneTorreARegime
    CistTAG_StatoErroreOperazioniCisterne
    CistTAG_AttesaAlimentazioneTorre
    CistTAG_Emulsione_Operazioni_Allarme0
    CistTAG_Emulsione_Operazioni_Allarme1
    CistTAG_Emulsione_Operazioni_Allarme2
    CistTAG_Emulsione_Operazioni_Allarme3
    CistTAG_Emulsione_Operazioni_Allarme4
    CistTAG_Emulsione_Operazioni_Allarme5
    CistTAG_Emulsione_Operazioni_Allarme6
    CistTAG_Emulsione_Operazioni_Allarme7
    CistTAG_Emulsione_Operazioni_Allarme8
    CistTAG_Emulsione_Operazioni_Allarme9
    CistTAG_Emulsione_Operazioni_Allarme10
    CistTAG_AB10
    CistTAG_AB11
    CistTAG_AB12
    CistTAG_AB13
    CistTAG_AB14
    CistTAG_AB15
    CistTAG_AB16
    CistTAG_AB17
    CistTAG_AB18
    CistTAG_AB19
    CistTAG_AB20
    CistTAG_AB21
    CistTAG_EB70
    CistTAG_EB71
    CistTAG_EB72
    CistTAG_EB73
    CistTAG_EB74
    CistTAG_EB75
    CistTAG_EB76
    CistTAG_EB77
    CistTAG_EB78
    CistTAG_EB79
    CistTAG_EB80
    CistTAG_EB81
    CistTAG_EB82
    CistTAG_EB83
    CistTAG_EB84
    CistTAG_EB85
    CistTAG_EB86
    CistTAG_EB87
    CistTAG_AB22
    CistTAG_AB23
    CistTAG_AB24
    CistTAG_AB25
    CistTAG_EB88
    CistTAG_EB89
    CistTAG_EB90
    CistTAG_EB91
    CistTAG_EB92
    CistTAG_EB93
    CistTAG_AB26
    CistTAG_AB27
    CistTAG_EB94
    CistTAG_EB95
    CistTAG_EB96
    CistTAG_EB97

    CistTAG_AI_PEW128
    CistTAG_AI_PEW130
    CistTAG_AI_PEW132
    CistTAG_AI_PEW134
    CistTAG_AI_PEW136
    CistTAG_AI_PEW138
    CistTAG_AI_PEW140
    CistTAG_AI_PEW142
    CistTAG_AI_PEW160
    CistTAG_AI_PEW162
    CistTAG_AI_PEW164
    CistTAG_AI_PEW166
    CistTAG_AI_PEW168
    CistTAG_AI_PEW170
    CistTAG_AI_PEW172
    CistTAG_AI_PEW174
    CistTAG_AI_PEW176
    CistTAG_AI_PEW178
    CistTAG_AI_PEW180
    CistTAG_AI_PEW182
    CistTAG_AI_PEW184
    CistTAG_AI_PEW186
    CistTAG_AI_PEW188
    CistTAG_AI_PEW190
    CistTAG_CALDAIA1_ABILITAZIONE
    CistTAG_CALDAIA1_EN_VALV_IN_OUT
    CistTAG_CALDAIA1_BRUC_ON_CALDAIA_1
    CistTAG_CALDAIA1_NOTUSED1
    CistTAG_CALDAIA1_BRUC_2A_FIAMMA_ON
    CistTAG_CALDAIA1_POMPA_CIRC_ON
    CistTAG_CALDAIA1_NOTUSED2
    CistTAG_CALDAIA1_ACK_ALLARMI
    CistTAG_CALDAIA1_START
    CistTAG_CALDAIA1_STOP_EMERGENZA
    CistTAG_CALDAIA1_CARICAMENTO_OLIO_CIRC
    CistTAG_CALDAIA1_TEMPERATURA_SET
    CistTAG_CALDAIA1_DELTA_TEMPERATURA
    CistTAG_CALDAIA1_TEMPO_ARR_P_CIRC
    CistTAG_CALDAIA1_NOTUSED3
    CistTAG_CALDAIA1_NOTUSED4
    CistTAG_CALDAIA1_TEMPERATURA_CIRCUITO
    CistTAG_CALDAIA2_ABILITAZIONE
    CistTAG_CALDAIA2_EN_VALV_IN_OUT
    CistTAG_CALDAIA2_BRUC_ON_CALDAIA_1
    CistTAG_CALDAIA2_NOTUSED1
    CistTAG_CALDAIA2_BRUC_2A_FIAMMA_ON
    CistTAG_CALDAIA2_POMPA_CIRC_ON
    CistTAG_CALDAIA2_NOTUSED2
    CistTAG_CALDAIA2_ACK_ALLARMI
    CistTAG_CALDAIA2_START
    CistTAG_CALDAIA2_STOP_EMERGENZA
    CistTAG_CALDAIA2_CARICAMENTO_OLIO_CIRC
    CistTAG_CALDAIA2_TEMPERATURA_SET
    CistTAG_CALDAIA2_DELTA_TEMPERATURA
    CistTAG_CALDAIA2_TEMPO_ARR_P_CIRC
    CistTAG_CALDAIA2_NOTUSED3
    CistTAG_CALDAIA2_NOTUSED4
    CistTAG_CALDAIA2_TEMPERATURA_CIRCUITO
    CistTAG_SCATTO_TERMICA_GEN
    CistTAG_ALM_CALDAIA1_BloccoBruciatore
    CistTAG_ALM_CALDAIA1_TemperaturaOlioOltreSicurezza
    CistTAG_ALM_CALDAIA1_ScattoTermicaPompaCircolazione
    CistTAG_ALM_CALDAIA1_ErrorePressostatoDifferenziale
    CistTAG_ALM_CALDAIA1_ErroriValvoleIN
    CistTAG_ALM_CALDAIA1_ErroriValvoleOUT
    CistTAG_ALM_CALDAIA1_TimeoutAvvioPompaCircolazione
    CistTAG_ALM_CALDAIA1_TimeoutArrestoPompaCircolazione
    CistTAG_ALM_CALDAIA1_MancatoRitornoPompaCircDuranteFunzionamento
    CistTAG_ALM_CALDAIA1_LivelloMinimoOlio
    CistTAG_ALM_CALDAIA1_ValvoleChiuseConPompaCircInMoto
    CistTAG_ALM_CALDAIA1_12
    CistTAG_ALM_CALDAIA1_13
    CistTAG_ALM_CALDAIA1_14
    CistTAG_ALM_CALDAIA1_15
    CistTAG_ALM_CALDAIA1_16
    CistTAG_ALM_CALDAIA2_BloccoBruciatore
    CistTAG_ALM_CALDAIA2_TemperaturaOlioOltreSicurezza
    CistTAG_ALM_CALDAIA2_ScattoTermicaPompaCircolazione
    CistTAG_ALM_CALDAIA2_ErrorePressostatoDifferenziale
    CistTAG_ALM_CALDAIA2_ErroriValvoleIN
    CistTAG_ALM_CALDAIA2_ErroriValvoleOUT
    CistTAG_ALM_CALDAIA2_TimeoutAvvioPompaCircolazione
    CistTAG_ALM_CALDAIA2_TimeoutArrestoPompaCircolazione
    CistTAG_ALM_CALDAIA2_MancatoRitornoPompaCircDuranteFunzionamento
    CistTAG_ALM_CALDAIA2_LivelloMinimoOlio
    CistTAG_ALM_CALDAIA2_ValvoleChiuseConPompaCircInMoto
    CistTAG_ALM_CALDAIA2_12
    CistTAG_ALM_CALDAIA2_13
    CistTAG_ALM_CALDAIA2_14
    CistTAG_ALM_CALDAIA2_15
    CistTAG_ALM_CALDAIA2_16
    CistTAG_CALDAIA1_VALVOLA_APERTA_RITORNO
    CistTAG_CALDAIA1_VALVOLA_CHIUSA_RITORNO
    CistTAG_CALDAIA1_VALVOLA_APERTA_MANDATA
    CistTAG_CALDAIA1_VALVOLA_CHIUSA_MANDATA
    CistTAG_CALDAIA2_VALVOLA_APERTA_RITORNO
    CistTAG_CALDAIA2_VALVOLA_CHIUSA_RITORNO
    CistTAG_CALDAIA2_VALVOLA_APERTA_MANDATA
    CistTAG_CALDAIA2_VALVOLA_CHIUSA_MANDATA
    CistTAG_TURNO_1_ORA_SET
    CistTAG_TURNO_1_MINUTI_SET
    CistTAG_TURNO_1_SECONDI_SET
    CistTAG_TURNO_1_ORA_RESET
    CistTAG_TURNO_1_MINUTI_RESET
    CistTAG_TURNO_1_SECONDI_RESET
    CistTAG_TURNO_2_ORA_SET
    CistTAG_TURNO_2_MINUTI_SET
    CistTAG_TURNO_2_SECONDI_SET
    CistTAG_TURNO_2_ORA_RESET
    CistTAG_TURNO_2_MINUTI_RESET
    CistTAG_TURNO_2_SECONDI_RESET
    CistTAG_TURNO_3_ORA_SET
    CistTAG_TURNO_3_MINUTI_SET
    CistTAG_TURNO_3_SECONDI_SET
    CistTAG_TURNO_3_ORA_RESET
    CistTAG_TURNO_3_MINUTI_RESET
    CistTAG_TURNO_3_SECONDI_RESET
    CistTAG_TURNO_4_ORA_SET
    CistTAG_TURNO_4_MINUTI_SET
    CistTAG_TURNO_4_SECONDI_SET
    CistTAG_TURNO_4_ORA_RESET
    CistTAG_TURNO_4_MINUTI_RESET
    CistTAG_TURNO_4_SECONDI_RESET
    CistTAG_TURNO_5_ORA_SET
    CistTAG_TURNO_5_MINUTI_SET
    CistTAG_TURNO_5_SECONDI_SET
    CistTAG_TURNO_5_ORA_RESET
    CistTAG_TURNO_5_MINUTI_RESET
    CistTAG_TURNO_5_SECONDI_RESET
    CistTAG_TURNO_6_ORA_SET
    CistTAG_TURNO_6_MINUTI_SET
    CistTAG_TURNO_6_SECONDI_SET
    CistTAG_TURNO_6_ORA_RESET
    CistTAG_TURNO_6_MINUTI_RESET
    CistTAG_TURNO_6_SECONDI_RESET
    CistTAG_TURNO_7_ORA_SET
    CistTAG_TURNO_7_MINUTI_SET
    CistTAG_TURNO_7_SECONDI_SET
    CistTAG_TURNO_7_ORA_RESET
    CistTAG_TURNO_7_MINUTI_RESET
    CistTAG_TURNO_7_SECONDI_RESET
    CistTAG_CONTALITRI_PULSE_RAPP
    CistTAG_CONTALITRI_NUMERO_IMPULSI
    CistTAG_CONTALITRI_VALORE_LITRI
    CistTAG_CONTALITRI_RESET

    '
    CistTAG_COUNT
End Enum

'20150505
Public Enum PlcTagCisterneRidottoEnum
    CistRidTAG_Bitume_Cisterna1_TipoLivello = PLCTAG_COUNT
    CistRidTAG_Bitume_Cisterna1_BloccoValvoleBassaTemperatura
    CistRidTAG_Bitume_Cisterna1_InclusioneAgitatore
    CistRidTAG_Bitume_Cisterna1_TempUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna1_TempUnitaLimitesup
    CistRidTAG_Bitume_Cisterna1_LivelloUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna1_LivelloUnitaLimiteSup
    CistRidTAG_Bitume_Cisterna1_Densita
    CistRidTAG_Bitume_Cisterna1_TempGradiLimiteInf
    CistRidTAG_Bitume_Cisterna1_TempGradiLimiteSup
    CistRidTAG_Bitume_Cisterna1_LivelloTonLimiteInf
    CistRidTAG_Bitume_Cisterna1_LivelloTonLimiteSup
    CistRidTAG_Bitume_Cisterna1_TempGradiAllarmeMin
    CistRidTAG_Bitume_Cisterna1_TempGradiAllarmeMax
    CistRidTAG_Bitume_Cisterna1_LivelloTonAllarmeMin
    CistRidTAG_Bitume_Cisterna1_LivelloTonAllarmeMax
    CistRidTAG_Bitume_Cisterna1_LivelloTonAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna1_TempGradiAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna1_LivelloMin_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_LivelloMax_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_LivelloSic_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_LivelloPercentualeValore
    CistRidTAG_Bitume_Cisterna1_LivelloTonValore
    CistRidTAG_Bitume_Cisterna1_TempGradiValore
    CistRidTAG_Bitume_Cisterna1_AllarmeCodiceGen
    CistRidTAG_Bitume_Cisterna1_ValvUscita1InverteComando
    CistRidTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna1_ValvUscita1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvUscita1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice
    CistRidTAG_Bitume_Cisterna1_DI_ValvRitornoBloccoTemp
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1InverteComando
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice
    CistRidTAG_Bitume_Cisterna1_DI_ValvCaricoBloccoTemp
    CistRidTAG_Bitume_Cisterna1_ValvUscita2InverteComando
    CistRidTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna1_ValvUscita2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvUscita2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice
    CistRidTAG_Bitume_Cisterna1_DI_ValvAuxBloccoTemp
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2InverteComando
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna1_ValvEntrata2AllarmeCodice
    CistRidTAG_Bitume_Cisterna1_NumeroValvolePresenti
    CistRidTAG_Bitume_Cisterna1_AbilitaOrizzontale
    CistRidTAG_Bitume_Cisterna1_DiametroMm
    CistRidTAG_Bitume_Cisterna1_LunghezzaMm
    CistRidTAG_Bitume_Cisterna1_AbilitaValvolaMandata
    CistRidTAG_Bitume_Cisterna1_AbilitaValvolaRitorno
    CistRidTAG_Bitume_Cisterna1_AbilitaValvolaCarico
    CistRidTAG_Bitume_Cisterna1_AbilitaValvolaAux
    CistRidTAG_Bitume_Cisterna2_TipoLivello
    CistRidTAG_Bitume_Cisterna2_BloccoValvoleBassaTemperatura
    CistRidTAG_Bitume_Cisterna2_InclusioneAgitatore
    CistRidTAG_Bitume_Cisterna2_TempUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna2_TempUnitaLimieSup
    CistRidTAG_Bitume_Cisterna2_LivelloUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna2_LivelloUnitaLimiteSup
    CistRidTAG_Bitume_Cisterna2_Densita
    CistRidTAG_Bitume_Cisterna2_TempGradiLimiteInf
    CistRidTAG_Bitume_Cisterna2_TempGradiLimiteSup
    CistRidTAG_Bitume_Cisterna2_LivelloTonLimiteInf
    CistRidTAG_Bitume_Cisterna2_LivelloTonLimiteSup
    CistRidTAG_Bitume_Cisterna2_TempGradiAllarmeMin
    CistRidTAG_Bitume_Cisterna2_TempGradiAllarmeMax
    CistRidTAG_Bitume_Cisterna2_LivelloTonAllarmeMin
    CistRidTAG_Bitume_Cisterna2_LivelloTonAllarmeMax
    CistRidTAG_Bitume_Cisterna2_LivelloTonAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna2_TempGradiAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna2_LivelloMin_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_LivelloMax_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_LivelloSic_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_LivelloPercentualeValore
    CistRidTAG_Bitume_Cisterna2_LivelloTonValore
    CistRidTAG_Bitume_Cisterna2_TempGradiValore
    CistRidTAG_Bitume_Cisterna2_AllarmeCodiceGen
    CistRidTAG_Bitume_Cisterna2_ValvUscita1InverteComando
    CistRidTAG_Bitume_Cisterna2_ValvUscita1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna2_ValvUscita1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna2_ValvUscita1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna2_ValvUscita1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvUscita1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvUscita1AllarmeCodice
    CistRidTAG_Bitume_Cisterna2_DI_ValvRitornoBloccoTemp
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1InverteComando
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvEntrata1AllarmeCodice
    CistRidTAG_Bitume_Cisterna2_DI_ValvCaricoBloccoTemp
    CistRidTAG_Bitume_Cisterna2_ValvUscita2InverteComando
    CistRidTAG_Bitume_Cisterna2_ValvUscita2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna2_ValvUscita2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna2_ValvUscita2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna2_ValvUscita2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvUscita2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvUscita2AllarmeCodice
    CistRidTAG_Bitume_Cisterna2_DI_ValvAuxBloccoTemp
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2InverteComando
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna2_ValvEntrata2AllarmeCodice
    CistRidTAG_Bitume_Cisterna2_NumeroValvolePresenti
    CistRidTAG_Bitume_Cisterna2_AbilitaOrizzontale
    CistRidTAG_Bitume_Cisterna2_DiametroMm
    CistRidTAG_Bitume_Cisterna2_LunghezzaMm
    CistRidTAG_Bitume_Cisterna2_AbilitaValvolaMandata
    CistRidTAG_Bitume_Cisterna2_AbilitaValvolaRitorno
    CistRidTAG_Bitume_Cisterna2_AbilitaValvolaCarico
    CistRidTAG_Bitume_Cisterna2_AbilitaValvolaAux
    CistRidTAG_Bitume_Cisterna3_TipoLivello
    CistRidTAG_Bitume_Cisterna3_BloccoValvoleBassaTemperatura
    CistRidTAG_Bitume_Cisterna3_InclusioneAgitatore
    CistRidTAG_Bitume_Cisterna3_TempUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna3_TempUnitaLimieSup
    CistRidTAG_Bitume_Cisterna3_LivelloUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna3_LivelloUnitaLimiteSup
    CistRidTAG_Bitume_Cisterna3_Densita
    CistRidTAG_Bitume_Cisterna3_TempGradiLimiteInf
    CistRidTAG_Bitume_Cisterna3_TempGradiLimiteSup
    CistRidTAG_Bitume_Cisterna3_LivelloTonLimiteInf
    CistRidTAG_Bitume_Cisterna3_LivelloTonLimiteSup
    CistRidTAG_Bitume_Cisterna3_TempGradiAllarmeMin
    CistRidTAG_Bitume_Cisterna3_TempGradiAllarmeMax
    CistRidTAG_Bitume_Cisterna3_LivelloTonAllarmeMin
    CistRidTAG_Bitume_Cisterna3_LivelloTonAllarmeMax
    CistRidTAG_Bitume_Cisterna3_LivelloTonAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna3_TempGradiAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna3_LivelloMin_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_LivelloMax_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_LivelloSic_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_LivelloPercentualeValore
    CistRidTAG_Bitume_Cisterna3_LivelloTonValore
    CistRidTAG_Bitume_Cisterna3_TempGradiValore
    CistRidTAG_Bitume_Cisterna3_AllarmeCodiceGen
    CistRidTAG_Bitume_Cisterna3_ValvUscita1InverteComando
    CistRidTAG_Bitume_Cisterna3_ValvUscita1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna3_ValvUscita1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna3_ValvUscita1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna3_ValvUscita1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvUscita1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvUscita1AllarmeCodice
    CistRidTAG_Bitume_Cisterna3_DI_ValvRitornoBloccoTemp
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1InverteComando
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvEntrata1AllarmeCodice
    CistRidTAG_Bitume_Cisterna3_DI_ValvCaricoBloccoTemp
    CistRidTAG_Bitume_Cisterna3_ValvUscita2InverteComando
    CistRidTAG_Bitume_Cisterna3_ValvUscita2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna3_ValvUscita2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna3_ValvUscita2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna3_ValvUscita2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvUscita2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvUscita2AllarmeCodice
    CistRidTAG_Bitume_Cisterna3_DI_ValvAuxBloccoTemp
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2InverteComando
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna3_ValvEntrata2AllarmeCodice
    CistRidTAG_Bitume_Cisterna3_NumeroValvolePresenti
    CistRidTAG_Bitume_Cisterna3_AbilitaOrizzontale
    CistRidTAG_Bitume_Cisterna3_DiametroMm
    CistRidTAG_Bitume_Cisterna3_LunghezzaMm
    CistRidTAG_Bitume_Cisterna3_AbilitaValvolaMandata
    CistRidTAG_Bitume_Cisterna3_AbilitaValvolaRitorno
    CistRidTAG_Bitume_Cisterna3_AbilitaValvolaCarico
    CistRidTAG_Bitume_Cisterna3_AbilitaValvolaAux
    CistRidTAG_Bitume_Cisterna4_TipoLivello
    CistRidTAG_Bitume_Cisterna4_BloccoValvoleBassaTemperatura
    CistRidTAG_Bitume_Cisterna4_InclusioneAgitatore
    CistRidTAG_Bitume_Cisterna4_TempUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna4_TempUnitaLimitesup
    CistRidTAG_Bitume_Cisterna4_LivelloUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna4_LivelloUnitaLimiteSup
    CistRidTAG_Bitume_Cisterna4_Densita
    CistRidTAG_Bitume_Cisterna4_TempGradiLimiteInf
    CistRidTAG_Bitume_Cisterna4_TempGradiLimiteSup
    CistRidTAG_Bitume_Cisterna4_LivelloTonLimiteInf
    CistRidTAG_Bitume_Cisterna4_LivelloTonLimiteSup
    CistRidTAG_Bitume_Cisterna4_TempGradiAllarmeMin
    CistRidTAG_Bitume_Cisterna4_TempGradiAllarmeMax
    CistRidTAG_Bitume_Cisterna4_LivelloTonAllarmeMin
    CistRidTAG_Bitume_Cisterna4_LivelloTonAllarmeMax
    CistRidTAG_Bitume_Cisterna4_LivelloTonAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna4_TempGradiAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna4_LivelloMin_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_LivelloMax_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_LivelloSic_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_LivelloPercentualeValore
    CistRidTAG_Bitume_Cisterna4_LivelloTonValore
    CistRidTAG_Bitume_Cisterna4_TempGradiValore
    CistRidTAG_Bitume_Cisterna4_AllarmeCodiceGen
    CistRidTAG_Bitume_Cisterna4_ValvUscita1InverteComando
    CistRidTAG_Bitume_Cisterna4_ValvUscita1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna4_ValvUscita1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna4_ValvUscita1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna4_ValvUscita1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvUscita1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvUscita1AllarmeCodice
    CistRidTAG_Bitume_Cisterna4_DI_ValvRitornoBloccoTemp
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1InverteComando
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvEntrata1AllarmeCodice
    CistRidTAG_Bitume_Cisterna4_DI_ValvCaricoBloccoTemp
    CistRidTAG_Bitume_Cisterna4_ValvUscita2InverteComando
    CistRidTAG_Bitume_Cisterna4_ValvUscita2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna4_ValvUscita2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna4_ValvUscita2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna4_ValvUscita2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvUscita2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvUscita2AllarmeCodice
    CistRidTAG_Bitume_Cisterna4_DI_ValvAuxBloccoTemp
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2InverteComando
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna4_ValvEntrata2AllarmeCodice
    CistRidTAG_Bitume_Cisterna4_NumeroValvolePresenti
    CistRidTAG_Bitume_Cisterna4_AbilitaOrizzontale
    CistRidTAG_Bitume_Cisterna4_DiametroMm
    CistRidTAG_Bitume_Cisterna4_LunghezzaMm
    CistRidTAG_Bitume_Cisterna4_AbilitaValvolaMandata
    CistRidTAG_Bitume_Cisterna4_AbilitaValvolaRitorno
    CistRidTAG_Bitume_Cisterna4_AbilitaValvolaCarico
    CistRidTAG_Bitume_Cisterna4_AbilitaValvolaAux
    CistRidTAG_Bitume_Cisterna5_TipoLivello
    CistRidTAG_Bitume_Cisterna5_BloccoValvoleBassaTemperatura
    CistRidTAG_Bitume_Cisterna5_InclusioneAgitatore
    CistRidTAG_Bitume_Cisterna5_TempUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna5_TempUnitaLimieSup
    CistRidTAG_Bitume_Cisterna5_LivelloUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna5_LivelloUnitaLimiteSup
    CistRidTAG_Bitume_Cisterna5_Densita
    CistRidTAG_Bitume_Cisterna5_TempGradiLimiteInf
    CistRidTAG_Bitume_Cisterna5_TempGradiLimiteSup
    CistRidTAG_Bitume_Cisterna5_LivelloTonLimiteInf
    CistRidTAG_Bitume_Cisterna5_LivelloTonLimiteSup
    CistRidTAG_Bitume_Cisterna5_TempGradiAllarmeMin
    CistRidTAG_Bitume_Cisterna5_TempGradiAllarmeMax
    CistRidTAG_Bitume_Cisterna5_LivelloTonAllarmeMin
    CistRidTAG_Bitume_Cisterna5_LivelloTonAllarmeMax
    CistRidTAG_Bitume_Cisterna5_LivelloTonAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna5_TempGradiAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna5_LivelloMin_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_LivelloMax_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_LivelloSic_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_LivelloPercentualeValore
    CistRidTAG_Bitume_Cisterna5_LivelloTonValore
    CistRidTAG_Bitume_Cisterna5_TempGradiValore
    CistRidTAG_Bitume_Cisterna5_AllarmeCodiceGen
    CistRidTAG_Bitume_Cisterna5_ValvUscita1InverteComando
    CistRidTAG_Bitume_Cisterna5_ValvUscita1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna5_ValvUscita1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna5_ValvUscita1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna5_ValvUscita1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvUscita1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvUscita1AllarmeCodice
    CistRidTAG_Bitume_Cisterna5_DI_ValvRitornoBloccoTemp
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1InverteComando
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvEntrata1AllarmeCodice
    CistRidTAG_Bitume_Cisterna5_DI_ValvCaricoBloccoTemp
    CistRidTAG_Bitume_Cisterna5_ValvUscita2InverteComando
    CistRidTAG_Bitume_Cisterna5_ValvUscita2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna5_ValvUscita2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna5_ValvUscita2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna5_ValvUscita2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvUscita2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvUscita2AllarmeCodice
    CistRidTAG_Bitume_Cisterna5_DI_ValvAuxBloccoTemp
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2InverteComando
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna5_ValvEntrata2AllarmeCodice
    CistRidTAG_Bitume_Cisterna5_NumeroValvolePresenti
    CistRidTAG_Bitume_Cisterna5_AbilitaOrizzontale
    CistRidTAG_Bitume_Cisterna5_DiametroMm
    CistRidTAG_Bitume_Cisterna5_LunghezzaMm
    CistRidTAG_Bitume_Cisterna5_AbilitaValvolaMandata
    CistRidTAG_Bitume_Cisterna5_AbilitaValvolaRitorno
    CistRidTAG_Bitume_Cisterna5_AbilitaValvolaCarico
    CistRidTAG_Bitume_Cisterna5_AbilitaValvolaAux
    CistRidTAG_Bitume_Cisterna6_TipoLivello
    CistRidTAG_Bitume_Cisterna6_BloccoValvoleBassaTemperatura
    CistRidTAG_Bitume_Cisterna6_InclusioneAgitatore
    CistRidTAG_Bitume_Cisterna6_TempUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna6_TempUnitaLimieSup
    CistRidTAG_Bitume_Cisterna6_LivelloUnitaLimiteInf
    CistRidTAG_Bitume_Cisterna6_LivelloUnitaLimiteSup
    CistRidTAG_Bitume_Cisterna6_Densita
    CistRidTAG_Bitume_Cisterna6_TempGradiLimiteInf
    CistRidTAG_Bitume_Cisterna6_TempGradiLimiteSup
    CistRidTAG_Bitume_Cisterna6_LivelloTonLimiteInf
    CistRidTAG_Bitume_Cisterna6_LivelloTonLimiteSup
    CistRidTAG_Bitume_Cisterna6_TempGradiAllarmeMin
    CistRidTAG_Bitume_Cisterna6_TempGradiAllarmeMax
    CistRidTAG_Bitume_Cisterna6_LivelloTonAllarmeMin
    CistRidTAG_Bitume_Cisterna6_LivelloTonAllarmeMax
    CistRidTAG_Bitume_Cisterna6_LivelloTonAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna6_TempGradiAllarmeZonaMorta
    CistRidTAG_Bitume_Cisterna6_LivelloMin_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_LivelloMax_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_LivelloSic_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_LivelloPercentualeValore
    CistRidTAG_Bitume_Cisterna6_LivelloTonValore
    CistRidTAG_Bitume_Cisterna6_TempGradiValore
    CistRidTAG_Bitume_Cisterna6_AllarmeCodiceGen
    CistRidTAG_Bitume_Cisterna6_ValvUscita1InverteComando
    CistRidTAG_Bitume_Cisterna6_ValvUscita1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna6_ValvUscita1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna6_ValvUscita1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna6_ValvUscita1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvUscita1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvUscita1AllarmeCodice
    CistRidTAG_Bitume_Cisterna6_DI_ValvRitornoBloccoTemp
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1InverteComando
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvEntrata1AllarmeCodice
    CistRidTAG_Bitume_Cisterna6_DI_ValvCaricoBloccoTemp
    CistRidTAG_Bitume_Cisterna6_ValvUscita2InverteComando
    CistRidTAG_Bitume_Cisterna6_ValvUscita2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna6_ValvUscita2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna6_ValvUscita2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna6_ValvUscita2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvUscita2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvUscita2AllarmeCodice
    CistRidTAG_Bitume_Cisterna6_DI_ValvAuxBloccoTemp
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2InverteComando
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2TempoTimeOutOpen
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2TempoTimeOutClose
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2TempoAntirimbalzoFC
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2Open_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2Close_DI_Trigger
    CistRidTAG_Bitume_Cisterna6_ValvEntrata2AllarmeCodice
    CistRidTAG_Bitume_Cisterna6_NumeroValvolePresenti
    CistRidTAG_Bitume_Cisterna6_AbilitaOrizzontale
    CistRidTAG_Bitume_Cisterna6_DiametroMm
    CistRidTAG_Bitume_Cisterna6_LunghezzaMm
    CistRidTAG_Bitume_Cisterna6_AbilitaValvolaMandata
    CistRidTAG_Bitume_Cisterna6_AbilitaValvolaRitorno
    CistRidTAG_Bitume_Cisterna6_AbilitaValvolaCarico
    CistRidTAG_Bitume_Cisterna6_AbilitaValvolaAux
    CistRidTAG_Bitume_Cisterna1_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna2_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna3_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna4_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna5_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna6_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna7_Selezionata_PCL1
    CistRidTAG_Bitume_Cisterna8_Selezionata_PCL1
    CistRidTAG_Selezione_Cisterna_Bitume_PCL1
    CistRidTAG_Tempo_Timeout_Cambio_Cisterna_PCL1
    CistRidTAG_Timeout_Selezione_PCL1
    CistRidTAG_Attesa_Selezione_PCL1
    CistRidTAG_Bitume_Cisterna1_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna2_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna3_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna4_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna5_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna6_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna7_Selezionata_PCL2
    CistRidTAG_Bitume_Cisterna8_Selezionata_PCL2
    CistRidTAG_Selezione_Cisterna_Bitume_PCL2
    CistRidTAG_Tempo_Timeout_Cambio_Cisterna_PCL2
    CistRidTAG_Timeout_Selezione_PCL2
    CistRidTAG_Attesa_Selezione_PCL2
    CistRidTAG_COUNT
End Enum

Public SbloccoSelezioneCisternaRid As Boolean
'

'I seguenti TAG sono utilizzati nel codice nelle routine di lettura/scrittura
' erano merker dell'enumerato 'vecchia gestione' (pre v 9.5.25)
'Private Const CistTAG_INOUTDIGITALI = CistTAG_AB10
Public Const CistTAG_CisternaBitume2 = CistTAG_Bitume_Cisterna2_TipoLivello 'primo TAG cist bitume nr 2
Public Const CistTAG_CisternaBitume1 = CistTAG_Bitume_Cisterna1_TipoLivello 'primo TAG cist bitume nr 1
'20150505
Public Const CistRidTAG_CisternaBitume2 = CistRidTAG_Bitume_Cisterna2_TipoLivello 'primo TAG cist bitume nr 2
Public Const CistRidTAG_CisternaBitume1 = CistRidTAG_Bitume_Cisterna1_TipoLivello 'primo TAG cist bitume nr 1
'
Public Const CistTAG_CisternaEmulsione1 = CistTAG_Emulsione_Cisterna1_TipoLivello 'primo TAG cist emulsione nr 1
Public Const CistTAG_CisternaCombustibile1 = CistTAG_Combustibile_Cisterna1_TipoLivello 'primo TAG cist combustibile nr 1
Public Const CistTAG_SondaTuboCaricoBitume = CistTAG_SondaTuboCaricoBitume_UnitaLimiteInf


Public ParametriDBCisterneModificati As Boolean
'Public ParametriCisterneListaOperazioniModificati As Boolean

Public Type OggettoValvolaPLC
    FC_Valvola_Aperta As Boolean
    FC_Valvola_Chiusa As Boolean
    DI_Apertura As Boolean
    DI_Chiusura As Boolean
    DI_Blocco_Temperatura As Boolean
    PARA_Inversione_Comando_Valvola As Boolean
    PARA_EN_Gestione_Valvola As Boolean
    PARA_EN_Tipo_Valvola_Manuale As Boolean
    PARA_EN_CMD_Doppio As Boolean
    PARA_TimeOut_Scambio_AP As Long
    PARA_TimeOut_Scambio_CH As Long
    PARA_Tempo_Trigger_FC As Long
    CMD_Valvola As Boolean
    VALV_AP_Triggerata As Boolean
    VALV_CH_Triggerata As Boolean
    Codice_Allarme As Integer
    OUT_Tempo_AP As Long
    OUT_Tempo_CH As Long
    NR_Operazioni_Apertura As Long
    NR_Operazioni_Chiusura As Long
End Type

Public Enum ValvoleBitumeEnum
    ValvolaBitume_LINEA_POMPA_CIRCOLAZIONE = 0
    ValvolaBitume_BYPASS_POMPA_CIRCOLAZIONE
    ValvolaBitume_ENTRATA_POMPA_CARICO
    ValvolaBitume_LINEA_POMPA_CARICO
    ValvolaBitume_ENTRATA_2_POMPA_CARICO
    ValvolaBitume_AUX1
    ValvolaBitume_AUX2
    ValvolaBitume_AUX3
    ValvolaBitume_SEPARAZIONE_CARICO_GRUPPO_1_2
    ValvolaBitume_SEPARAZIONE_ASPIRAZIONE_GRUPPO_1_2
    ValvolaBitume_SEPARAZIONE_CARICO_GRUPPO_2_3
    ValvolaBitume_SEPARAZIONE_ASPIRAZIONE_GRUPPO_2_3
    ValvolaBitume_RICIRCOLO_POMPA_CARICO_1
    ValvolaBitume_RICIRCOLO_POMPA_CARICO_2
    ValvolaBitume_ALIMENTAZIONE_ESTERNA
    ValvolaBitume_BRACCIO_CARICO
    ValvolaBitume_AUX4
    ValvolaBitume_AUX5
    ValvolaBitume_AUX6
    ValvolaBitume_AUX7
    ValvolaBitume_INCLUSIONE_CONTALITRI
    ValvolaBitume_ESCLUSIONE_CONTALITRI
    ValvolaBitume_SEPARAZIONE_GRUPPI_ALIM
    ValvolaBitume_LINEA1_INCLUSIONE_POMPA_CARICO
    ValvolaBitume_LINEA2_INCLUSIONE_POMPA_CARICO
    ValvolaBitume_BYPASS_ESCLUSIONE_POMPA_CARICO

    ValvolaBitumeUltima
End Enum
Public Const MAX_Valvole_Bitume As Integer = ValvolaBitumeUltima - 1

Public Enum ValvoleEmulsioneEnum
    ValvolaEmulsione_LINEA_POMPA_CIRCOLAZIONE = 0
    ValvolaEmulsione_BYPASS_POMPA_CIRCOLAZIONE
    ValvolaEmulsione_ENTRATA_POMPA_CARICO
    ValvolaEmulsione_RICIRCOLO_POMPA_CARICO
    ValvolaEmulsione_SEPARAZIONE
    ValvolaEmulsione_BRACCIO_CARICO
    ValvolaEmulsione_AUX1
    ValvolaEmulsione_AUX2
    ValvolaEmulsione_AUX3
    ValvolaEmulsione_AUX4
    ValvolaEmulsione_AUX5
    ValvolaEmulsione_AUX6
    ValvolaEmulsione_AUX7
    ValvolaEmulsione_AUX8
    ValvolaEmulsioneUltima
End Enum
Public Const MAX_Valvole_Emulsione As Integer = ValvolaEmulsioneUltima - 1

Public Enum ValvoleCombustibileEnum
    ValvolaCombustibile_CARICO = 0
    ValvolaCombustibile_AUX1
    ValvolaCombustibile_AUX2
    ValvolaCombustibile_AUX3
    ValvolaCombustibile_AUX4
    ValvolaCombustibile_AUX5
    ValvolaCombustibile_AUX6
    ValvolaCombustibile_AUX7
    ValvolaCombustibile_AUX8
    ValvolaCombustibile_AUX9
    ValvolaCombustibileUltima
End Enum

Public Const MAX_Valvole_Combustibile As Integer = ValvolaCombustibileUltima - 1

Public ValvolaCircuitoBitume(0 To MAX_Valvole_Bitume) As OggettoValvolaPLC
Public ValvolaCircuitoEmulsione(0 To MAX_Valvole_Emulsione) As OggettoValvolaPLC
Public ValvolaCircuitoCombustibile(0 To MAX_Valvole_Combustibile) As OggettoValvolaPLC

Public InitFormCisterne As Boolean
'
'20150513
Public ListaCisterneValideDosaggioPCL1 As String
Public ListaCisterneValideDosaggioPCL2 As String
Public MaterialeDosaggioPCL1 As String
Public MaterialeDosaggioPCL2 As String
'

'Elenco Valvole circuiti
'ValvolaCircuitoBitume(0)   --> Valvola LINEA POMPA CIRCOLAZIONE
'ValvolaCircuitoBitume(1)   --> Valvola BYPASS POMPA CIRCOLAZIONE
'ValvolaCircuitoBitume(2)   --> Valvola ENTRATA POMPA CARICO
'ValvolaCircuitoBitume(3)   --> Valvola LINEA POMPA CARICO
'ValvolaCircuitoBitume(4)   --> Valvola ENTRATA 2 POMPA CARICO
'ValvolaCircuitoBitume(5)   --> Valvola AUX1
'ValvolaCircuitoBitume(6)   --> Valvola AUX2
'ValvolaCircuitoBitume(7)   --> Valvola AUX3
'ValvolaCircuitoBitume(8)   --> Valvola SEPARAZIONE CARICO GRUPPO 1-2
'ValvolaCircuitoBitume(9)   --> Valvola SEPARAZIONE ASPIRAZIONE GRUPPO 1-2
'ValvolaCircuitoBitume(10)  --> Valvola SEPARAZIONE CARICO GRUPPO 2-3
'ValvolaCircuitoBitume(11)  --> Valvola SEPARAZIONE ASPIRAZIONE GRUPPO 2-3
'ValvolaCircuitoBitume(12)  --> Valvola RICIRCOLO SU POMPA CARICO 1
'ValvolaCircuitoBitume(13)  --> Valvola RICIRCOLO SU POMPA CARICO 2
'ValvolaCircuitoBitume(14)  --> Valvola ALIMENTAZIONE ESTERNA
'ValvolaCircuitoBitume(15)  --> Valvola BRACCIO DI CARICO
'ValvolaCircuitoBitume(16)  --> Valvola AUX4
'ValvolaCircuitoBitume(17)  --> Valvola AUX5
'ValvolaCircuitoBitume(18)  --> Valvola AUX6
'ValvolaCircuitoBitume(19)  --> Valvola AUX7
'ValvolaCircuitoEmulsione(0)   --> Valvola LINEA POMPA CIRCOLAZIONE
'ValvolaCircuitoEmulsione(1)   --> Valvola BYPASS POMPA CIRCOLAZIONE
'ValvolaCircuitoEmulsione(2)   --> Valvola ENTRATA POMPA CARICO
'ValvolaCircuitoEmulsione(3)   --> Valvola RICIRCOLO POMPA CARICO
'ValvolaCircuitoEmulsione(4)   --> Valvola SEPARAZIONE
'ValvolaCircuitoEmulsione(5)   --> Valvola BRACCIO DI CARICO
'ValvolaCircuitoEmulsione(6)   --> Valvola AUX1
'ValvolaCircuitoEmulsione(7)   --> Valvola AUX2
'ValvolaCircuitoEmulsione(8)   --> Valvola AUX3
'ValvolaCircuitoEmulsione(9)   --> Valvola AUX4
'ValvolaCircuitoEmulsione(10)  --> Valvola AUX5
'ValvolaCircuitoEmulsione(11)  --> Valvola AUX6
'ValvolaCircuitoEmulsione(12)  --> Valvola AUX7
'ValvolaCircuitoEmulsione(13)  --> Valvola AUX8
'ValvolaCircuitoCombustibile(0)   --> Valvola CARICO
'ValvolaCircuitoCombustibile(1)   --> Valvola AUX1
'ValvolaCircuitoCombustibile(2)   --> Valvola AUX2
'ValvolaCircuitoCombustibile(3)   --> Valvola AUX3
'ValvolaCircuitoCombustibile(4)   --> Valvola AUX4
'ValvolaCircuitoCombustibile(5)   --> Valvola AUX5
'ValvolaCircuitoCombustibile(6)   --> Valvola AUX6
'ValvolaCircuitoCombustibile(7)   --> Valvola AUX7
'ValvolaCircuitoCombustibile(8)   --> Valvola AUX8
'ValvolaCircuitoCombustibile(9)   --> Valvola AUX9
'Gli allarmi delle valvole dei circuiti nel file CodificaAllarmi.xls sono codificati PCxxy
'PC significa ParcoCisterne
'xx è il numero della valvola da 01 a 19 per quelle del bitume
'xx è il numero della valvola da 20 a 33 per quelle dell'emulsione
'xx è il numero della valvola da 34 a 43 per quelle del combustibile
'y è il numero del bit dell'allarme da 0 a 7
'   bit 0 = 2 FC eccitati
'   bit 1 = 0 FC eccitati
'   bit 2 = TimeOut apertura
'   bit 3 = TimeOut chiusura
'   bit 4 = Stato non coerente
'   bit 5 = Disponibile
'   bit 6 = Disponibile
'   bit 7 = Disponibile


Public Sub CreaTagCisterneS7_Ver9()

    On Error GoTo Errore

    If CP240.OPCDataCisterne.items.count = 0 Then
        CP240.OPCDataCisterne.RemoteHost = SetIP
        CP240.OPCDataCisterne.ServerName = OpcServerName
        CP240.OPCDataCisterne.UseAsync = True

        LoadOPCTags "plc2", CP240.OPCDataCisterne
    End If

    Exit Sub
Errore:
    LogInserisci True, "CCM-001", CStr(Err.Number) + " [" + Err.description + "]"

    Call AllarmeTemporaneoFull(96, "XX096", True, True)
End Sub


Public Sub LeggiDatiRegolazioneTempCisterne()
	Dim i As Integer
	'Dim offset As Integer

    On Error GoTo Errore

    With CistGestione

        If (.Gestione <> GestionePLC Or Not .RegolazioneTemperatura) Then
            Exit Sub
        End If

        If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
            Exit Sub
        End If

        If .NumCisterneBitume = 0 And .NumCisterneEmulsione = 0 And .NumCisterneCombustibile = 0 Then
            Exit Sub
        End If

        For i = 1 To .NumCisterneBitume
            .RegolatorePID(i).RiscAttivo = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_DO_ValvOlioCisterna1 + i - 1).Value
            If .RegolatorePID(i).lckset = False Then
                .RegolatorePID(i).setpoint = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_SetTempCisterna1 + i - 1).Value
                CP240.LblCistTempSet(i - 1).caption = .RegolatorePID(i).setpoint
            End If
            .RegolatorePID(i).SicurRisc = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_DI_SicRiscValvCisterna1 + i - 1).Value
            .RegolatorePID(i).SicurRiscBoost = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_DI_SicRiscBoostCisterna1 + i - 1).Value
        Next i
        
        For i = 1 To .NumCisterneEmulsione
            .RegolatorePID(i + 10).RiscAttivo = CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_DO_ValvOlioCisterna1 + i - 1).Value
            If .RegolatorePID(i + 10).lckset = False Then
                .RegolatorePID(i + 10).setpoint = CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_SetTempCisterna1 + i - 1).Value
                CP240.LblCistTempSet(i - 1 + 100).caption = .RegolatorePID(i + 10).setpoint
            End If
            .RegolatorePID(i + 10).SicurRisc = CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_DI_SicRiscValvCisterna1 + i - 1).Value
            .RegolatorePID(i + 10).SicurRiscBoost = CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_DI_SicRiscBoostCisterna1 + i - 1).Value
        Next i
        For i = 1 To .NumCisterneCombustibile
            .RegolatorePID(i + 20).RiscAttivo = CP240.OPCDataCisterne.items.item(CistTAG_Combustibile_DO_ValvOlioCisterna1 + i - 1).Value
            If .RegolatorePID(i + 20).lckset = False Then
                .RegolatorePID(i + 20).setpoint = CP240.OPCDataCisterne.items.item(CistTAG_Combustibile_SetTempCisterna1 + i - 1).Value
                CP240.LblCistTempSet(i - 1 + 200).caption = .RegolatorePID(i + 20).setpoint
            End If
            .RegolatorePID(i + 20).SicurRisc = CP240.OPCDataCisterne.items.item(CistTAG_Combustibile_DI_SicRiscValvCisterna1 + i - 1).Value
            .RegolatorePID(i + 20).SicurRiscBoost = CP240.OPCDataCisterne.items.item(CistTAG_Combustibile_DI_SicRiscBoostCisterna1 + i - 1).Value
        Next i

        Call AggiornaGrafPIDCisterne

    End With
    
    Exit Sub
Errore:
    LogInserisci True, "CCM-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ScriviDatiRegolazioneTempCisterne()
	'Dim offset As Integer
	Dim i As Integer
	'Dim OffsetTagScritturaCist As Integer

    On Error GoTo Errore

    With CistGestione

        If (.Gestione <> GestionePLC Or Not .RegolazioneTemperatura) Then
            Exit Sub
        End If

        If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
            Exit Sub
        End If

        For i = 1 To .NumCisterneBitume
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_SetTempCisterna1 + i - 1).Value = .RegolatorePID(i).setpoint
        Next i
        
        For i = 1 To .NumCisterneEmulsione
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_SetTempCisterna1 + i - 1).Value = .RegolatorePID(i + 10).setpoint
        Next i
        
        For i = 1 To .NumCisterneCombustibile
            CP240.OPCDataCisterne.items.item(CistTAG_Combustibile_SetTempCisterna1 + i - 1).Value = .RegolatorePID(i + 20).setpoint
        Next i
        
    End With

    Exit Sub
Errore:
    LogInserisci True, "CCM-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AggiornaGrafPIDCisterne()
	Dim indice As Integer

    With CistGestione
        
        For indice = 0 To CistGestione.NumCisterneBitume - 1
            CP240.ImgCistRiscalda(indice).Visible = CP240.OPCDataCisterne.items(CistTAG_Bitume_DO_ValvOlioCisterna1 + indice).Value
            CP240.ImgCistBoost(indice).Visible = CP240.OPCDataCisterne.items(CistTAG_Bitume_DO_BoostOlioCisterna1 + indice).Value
        Next indice

        For indice = 0 To CistGestione.NumCisterneEmulsione - 1
            CP240.ImgCistRiscalda(indice + 100).Visible = CP240.OPCDataCisterne.items(CistTAG_Emulsione_DO_ValvOlioCisterna1 + indice).Value
            CP240.ImgCistBoost(indice + 100).Visible = CP240.OPCDataCisterne.items(CistTAG_Emulsione_DO_BoostOlioCisterna1 + indice).Value
        Next indice

        For indice = 0 To CistGestione.NumCisterneCombustibile - 1
            CP240.ImgCistRiscalda(indice + 200).Visible = CP240.OPCDataCisterne.items(CistTAG_Combustibile_DO_ValvOlioCisterna1 + indice).Value
            CP240.ImgCistBoost(indice + 200).Visible = CP240.OPCDataCisterne.items(CistTAG_Combustibile_DO_BoostOlioCisterna1 + indice).Value
        Next indice

    End With

End Sub


Public Sub ScriviDatiComandiAuxCisterneOnOff(ByVal indice As Integer, ByVal avvio As Boolean)
	Dim offset As Integer

    On Error GoTo Errore

    If (CistGestione.Gestione <> GestionePLC) Then
        Exit Sub
    End If

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
        Exit Sub
    End If

    offset = indice * 2
    CP240.OPCDataCisterne.items.item(CistTAG_AUX_RiscLineaCircBitume_CmdStart + offset).Value = avvio

    Exit Sub
Errore:
    LogInserisci True, "CCM-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub LeggiDatiComandiAuxCisterneOnOff(ByVal indice As Integer, ByRef uscita As Boolean, ByRef termica As Boolean)
	Dim offset As Integer

    On Error GoTo Errore

    If (CistGestione.Gestione < GestionePLC) Then
        Exit Sub
    End If

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
        Exit Sub
    End If

    offset = indice * 2
    termica = CP240.OPCDataCisterne.items.item(offset + CistTAG_AUX_RiscLineaCircBitume_DI_Termica).Value
    uscita = CP240.OPCDataCisterne.items.item(offset + CistTAG_AUX_RiscLineaCircBitume_CmdStart).Value

    Exit Sub
Errore:
    LogInserisci True, "CCM-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub LeggiDatiPidComandiCisterne(indice As Integer)

    On Error GoTo Errore

    If (CistGestione.Gestione <> GestionePLC) Then
        Exit Sub
    End If

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
        Exit Sub
    End If
    
    If Not ComandiCisternaPid(indice).lckset Then
        ComandiCisternaPid(indice).setpoint = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_SetTempCisterna1 + indice).Value
        ComandiCisternaPid(indice).p = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_PID_GAIN + indice * 4).Value
        ComandiCisternaPid(indice).ti = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_PID_TI + indice * 4).Value
        ComandiCisternaPid(indice).td = CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_PID_TD + indice * 4).Value

        If (FrmComandiCisterneVisibile) Then
            FrmComandiCisterne.TxtTempMesc.text = ComandiCisternaPid(indice).setpoint
        End If
    End If

    If (FrmComandiCisterneVisibile) Then
        ComandiCisternaPid(indice).TempAttuale = Format(CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_TempGradiValore).Value, "##0")
        FrmComandiCisterne.lblTempAttualeMesc.caption = ComandiCisternaPid(indice).TempAttuale
    End If

    Exit Sub
Errore:
    LogInserisci True, "CCM-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ScriviDatiPidComandiCisterne(indice As Integer)

    On Error GoTo Errore

    If (CistGestione.Gestione <> GestionePLC) Then
        Exit Sub
    End If

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
        Exit Sub
    End If

    If Not ComandiCisternaPid(indice).lckset Then
        '
Debug.Print "Come fare?"
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_PID_GAIN + indice * 4).Value = ComandiCisternaPid(indice).p
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_PID_TI + indice * 4).Value = ComandiCisternaPid(indice).ti
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_PID_TD + indice * 4).Value = ComandiCisternaPid(indice).td
        'End If

        If (FrmComandiCisterneVisibile) Then
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_SetTempCisterna1 + indice).Value = ComandiCisternaPid(indice).setpoint
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "CCM-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub InviaComandiAgitatori(indice As Integer, Stato As Boolean)
 On Error GoTo Errore

    If (CistGestione.Gestione <> GestionePLC) Then
        Exit Sub
    End If

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
        Exit Sub
    End If
    
    CP240.OPCDataCisterne.items.item(CistTAG_Bitume_Cisterna1_AbilitazioneAgitatore + indice).Value = Stato
    
    Exit Sub
Errore:
    LogInserisci True, "CCM-008", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CistAccettaErrore(accetta As Boolean)
    DBScambioDatiCisterneBitume.AccettaErrore = accetta
End Sub

Public Sub CistShowMenu(Index As Integer)
	Dim i As Integer

    On Error GoTo Errore

    CP240.CmdTipoPesate(6).Visible = False

    For i = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
        If CisternaLegante(i).Agitatore Then
            CP240.CmdTipoPesate(6).Visible = True
        End If
    Next i

    With CP240.OPCDataCisterne.items
        'Leggo dal PLC i valori attuali e inizializzo le varie combo

        If (CP240.OPCDataCisterne.IsConnected) Then
            If (GetQuality(.item(1).quality) <> STATOOK) Then
                Exit Sub
            End If
            For i = 0 To 7
                If CP240.OPCDataCisterne.items(CistTAG_Pannello_ComandoAuxIncluso_1 + i).Value Then
                    CP240.CmdTipoPesate(6).Visible = True
                End If
            Next i

            'combo 0
            DBScambioDatiCisterneBitume.CodiceOperazioneCarico = .item(CistTAG_SelOperazionePompaCarico).Value
            CP240.cmbGestioneCisterne(0).ListIndex = DBScambioDatiCisterneBitume.CodiceOperazioneCarico
            
            'combo 1
            DBScambioDatiCisterneBitume.SelCistMandataPompaCarico = .item(CistTAG_SelCisternaMandataPompaCarico).Value
            
            If DBScambioDatiCisterneBitume.SelCistMandataPompaCarico > 0 And DBScambioDatiCisterneBitume.SelCistMandataPompaCarico <= CistGestione.NumCisterneBitume Then
                CP240.cmbGestioneCisterne(1).ListIndex = DBScambioDatiCisterneBitume.SelCistMandataPompaCarico - 1
            End If
            'combo 2
            DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico = .item(CistTAG_SelCisternaCaricoPompaCarico).Value
            
            If DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico > 0 And DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico <= CistGestione.NumCisterneBitume Then
                CP240.cmbGestioneCisterne(2).ListIndex = DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico - 1
            End If
            'combo 3
            If (CP240.cmbGestioneCisterne(5).ListIndex = 0 And CP240.cmbGestioneCisterne(0).ListIndex = 0) Or (CP240.cmbGestioneCisterne(5).ListIndex = 4) Then
                DBScambioDatiCisterneBitume.SelCistAlimentazioneTorre = .item(CistTAG_SelAlimentazioneTorrePompaAlimentazione).Value
                
                If DBScambioDatiCisterneBitume.SelCistAlimentazioneTorre > 0 And DBScambioDatiCisterneBitume.SelCistAlimentazioneTorre <= CistGestione.NumCisterneBitume Then
                    CP240.cmbGestioneCisterne(3).ListIndex = DBScambioDatiCisterneBitume.SelCistAlimentazioneTorre - 1
                End If
            Else
                DBScambioDatiCisterneBitume.SelCistMandataPompaAlimentaz = .item(CistTAG_SelCisternaMandataPompaAlimentazione).Value

                If DBScambioDatiCisterneBitume.SelCistMandataPompaAlimentaz > 0 And DBScambioDatiCisterneBitume.SelCistMandataPompaAlimentaz <= CistGestione.NumCisterneBitume Then
                    CP240.cmbGestioneCisterne(3).ListIndex = DBScambioDatiCisterneBitume.SelCistMandataPompaAlimentaz - 1
                End If
            End If
           
            'combo 4
            DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz = .item(CistTAG_SelCisternaCaricoPompaAlimentazione).Value
            
            If DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz > 0 And DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz <= CistGestione.NumCisterneBitume Then
                CP240.cmbGestioneCisterne(4).ListIndex = DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz - 1
            End If
            'combo 5
            DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione = .item(CistTAG_SelOperazionePompaAlimentazione).Value
            CP240.cmbGestioneCisterne(5).ListIndex = DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione
    
            If CP240.cmbGestioneCisterne(11).ListIndex <> .item(CistTAG_Emulsione_NumeroCisternaAlimImp_NEW).Value Then
                'Cisterna Emulsione
                DBScambioDatiCisterneEmulsione.CisternaNuovaSelezione = .item(CistTAG_Emulsione_NumeroCisternaAlimImp_NEW).Value
            End If
            
        End If
        
    End With

    Exit Sub

Errore:
    LogInserisci True, "CCM-015", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CistSetTemperatura(Index As Integer)
	Dim valore As Long
	Dim indiceCisterna As Integer

    If Index <= 5 Then
        indiceCisterna = Index + 1
    Else
        If Index >= 100 And Index <= 105 Then
            indiceCisterna = Index - 89
        Else
            If Index >= 200 And Index <= 205 Then
                indiceCisterna = Index - 179
            End If
        End If
    End If

    With CistGestione

        .RegolatorePID(indiceCisterna).lckset = True
        valore = FrmNewValue.InputLongValue(CP240, CLng(.RegolatorePID(indiceCisterna).setpoint), 0, 250)
        .RegolatorePID(indiceCisterna).setpoint = CDbl(valore)
        Call ScriviDatiRegolazioneTempCisterne
        .RegolatorePID(indiceCisterna).lckset = False

    End With

End Sub

Public Sub CistSetMateriale(Index As Integer)

    Dim cisterna As Integer

    With CistGestione

        If (Index < 100) Then
            cisterna = Index
        ElseIf (Index < 200) Then
            cisterna = Index - 100 + 10
        Else
            cisterna = Index - 200 + 20
        End If

'20150512
'        .materiale(cisterna) = FrmNewValue.InputStringValue(CP240, .materiale(cisterna))
'        CP240.LblCistMateriale(Index).caption = .materiale(cisterna)
        If Index < 6 Then
            .materiale(cisterna) = CP240.adoDBMatCist(Index).text
        End If
'
        '   Salvo anche su file
        ParaTabCist_WriteFile

    End With

End Sub

Public Sub CistConnessionePLC()
    
    On Error GoTo Errore
    
    With CistGestione

'20150904
'        If Not (CP240.OPCDataCisterne.IsConnected) And Not DEMO_VERSION And ((.Gestione = GestionePLC) Or (.Gestione = GestioneSemplificata)) Then
        If Not (CP240.OPCDataCisterne.IsConnected) And (Not DEMO_VERSION) And (.Gestione = GestionePLC) Then
'
            Call CreaTagCisterneS7_Ver9
            CP240.OPCDataCisterne.Connect
        
        End If
        
    End With

    Exit Sub
Errore:
    LogInserisci True, "CCM-010", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub CistAzzeramentoTara(cisterna As Integer)

    Dim risposta As Integer

    With CP240
        If Round(CisternaLegante(cisterna).ValLivelloPerc, 1) > 2 Then
            risposta = MsgBox(LoadXLSString(802), vbCritical + vbOKOnly)
            Exit Sub
        End If
        
        risposta = MsgBox( _
            LoadXLSString(804) + " " + CStr(cisterna) + vbCrLf + LoadXLSString(803), _
            vbExclamation + vbYesNo _
            )
        
        If risposta = vbYes Then
            DBScambioDatiCisterneBitume.NrCisternaAzzeramentoTara = cisterna
            .OPCDataCisterne.items.item(CistTAG_Bitume_AzzeraTaraCisternaNumero).Value = DBScambioDatiCisterneBitume.NrCisternaAzzeramentoTara
            DBScambioDatiCisterneBitume.EseguiTaraCisterna = True
        End If

    End With

End Sub


Public Sub CistGestioneLoop()

    Dim cisterna As Integer

	On Error GoTo Errore

	'20150904
	'    Call GestioneIngressiCisterneSemplificato

    For cisterna = 0 To DBScambioDatiCisterneBitume.NumeroCisternePresenti - 1
        Call AggiornaGraficaStatoCisterna(cisterna)
    Next cisterna
    
    If DBScambioDatiCisterneCombustibile.NumeroCisternePresenti > 0 Then
        Call AggiornaGraficaStatoCisternaCombust(1)
    End If

    Exit Sub
Errore:
    LogInserisci True, "CCM-011", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CisterneCaricaImmagini()
	Dim indice As Integer
	Dim indiceCisterna As Integer
    
    CP240.ImgCist(0).Picture = LoadResPicture("IDB_CISTERNA", vbResBitmap)
    CP240.ImgCistValvolaUscita2(0).Picture = LoadResPicture("IDI_VALVOLAFRECCIAGIU", vbResIcon)
    CP240.ImgCistRiscalda(0).Picture = LoadResPicture("IDB_RISCALDACISTERNA", vbResBitmap)
    CP240.ImgCistBoost(0).Picture = LoadResPicture("IDB_RISCALDACISTERNA", vbResBitmap)
   
    
    For indice = 0 To NumMaxCisterneImpianto - 1
        indiceCisterna = -1
        If indice <= 5 Then
            indiceCisterna = indice
        Else
            If indice >= 10 And indice <= 15 Then
                indiceCisterna = indice + 90
            Else
                If indice >= 20 And indice <= 25 Then
                    indiceCisterna = indice + 180
                End If
            End If
        End If
        If indiceCisterna >= 0 Then
            CP240.ImgCist(indiceCisterna).Picture = CP240.ImgCist(0).Picture
            CP240.ImgCistValvolaUscita2(indiceCisterna).Picture = CP240.ImgCistValvolaUscita2(0).Picture
            CP240.ImgCistValvolaUscita2(indiceCisterna).ToolTipText = LoadXLSString(115)     'Mandata
            CP240.ImgCistValvolaEntrata1(indiceCisterna).ToolTipText = LoadXLSString(121) 'Carico
            CP240.ImgCistValvolaUscita1(indiceCisterna).ToolTipText = LoadXLSString(116)    'Ritorno
            CP240.ImgCistValvolaEntrata1(indiceCisterna).Picture = CP240.ImgCistValvolaUscita2(0).Picture
            CP240.ImgCistValvolaUscita1(indiceCisterna).Picture = CP240.ImgCistValvolaUscita2(0).Picture
            CP240.ImgCistValvolaEntrata2(indiceCisterna).Picture = CP240.ImgCistValvolaUscita2(0).Picture
            CP240.ImgCistValvolaEntrata2(indiceCisterna).ToolTipText = LoadXLSString(818)
            CP240.ImgCistRiscalda(indiceCisterna).Picture = CP240.ImgCistRiscalda(0).Picture
            CP240.ImgCistBoost(indiceCisterna).Picture = CP240.ImgCistBoost(0).Picture
            CP240.ImgCistRiscalda(indiceCisterna).ToolTipText = LoadXLSString(832)
            CP240.ImgCistBoost(indiceCisterna).ToolTipText = LoadXLSString(833)
            
        End If
    Next indice
    
End Sub

Public Sub GestioneMaterialeCisterneRidotto()

	Dim i As Integer
	Dim numeroselezionatePCL1 As Integer
	Dim numerocisternaattivaPCL1 As Integer
	Dim numeroselezionatePCL2 As Integer
	Dim numerocisternaattivaPCL2 As Integer
	Dim selezDosaggioAuto As Boolean
	Dim erroreattivo As Boolean
	Dim posizione As Integer
    
    On Error GoTo Errore

    With CistGestione

        If (.Gestione <> GestioneSemplificata) Then
            Exit Sub
        End If

        DBScambioDatiCisterneBitume.RidottoNumeroCistBitSuPCL1 = CistGestione.NumeroCistBitSuPCL1
        DBScambioDatiCisterneBitume.RidottoNumeroCistBitSuPCL2 = DBScambioDatiCisterneBitume.NumeroCisternePresenti - DBScambioDatiCisterneBitume.RidottoNumeroCistBitSuPCL1

        selezDosaggioAuto = CP240.OPCData.items(PLCTAG_DosaggioAttivo).Value Or CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value
    
        For i = 1 To .NumCisterneBitume
            'verifica la cisterna selezionata nei due circuiti
            If i <= CistGestione.NumeroCistBitSuPCL1 Then
                'caso PCL1
                If CisternaLegante(i).CisternaSelezionata Then
                    numeroselezionatePCL1 = numeroselezionatePCL1 + 1
                    DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 = i
                End If
                'aggiorna bitmap cisterna: verde = ok, rossa = selezionata ma non coerente con la ricetta, grigia = non selezionata
                If (Not selezDosaggioAuto) Then
                    If CisternaLegante(i).CisternaSelezionata Then
                    'a dosaggio fermo va bene la cisterna attualmente selezionata
                        Call CistVisualizzaSelezione(i - 1)
                    Else
                        Call CistVisualizzaIdle(i - 1)
                    End If
                Else
                    If Not CisternaLegante(i).CisternaSelezionata Then
                        Call CistVisualizzaIdle(i - 1)
                    ElseIf VerificaMaterialeCistDosaggio(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1, ListaCisterneValideDosaggioPCL1) Or (MaterialeDosaggioPCL1 = "") Then
                    'a dosaggio attivo va bene se la cisterna attualmente selezionata solo se e' quella richiesta in ricetta
                        Call CistVisualizzaSelezione(i - 1)
                    ElseIf Not VerificaMaterialeCistDosaggio(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1, ListaCisterneValideDosaggioPCL1) Then
                    'a dosaggio attivo segnalo che la cisterna attualmente selezionata non e' quella richiesta in ricetta
                        Call CistVisualizzaErrore(i - 1)
                        erroreattivo = True
                    End If
                End If
            Else
                'caso PCL2
                If CisternaLegante(i).CisternaSelezionata Then
                    numeroselezionatePCL2 = numeroselezionatePCL2 + 1
                    DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 = i
                End If
                
                'aggiorna bitmap cisterna: verde = ok, rossa = selezionata ma non coerente con la ricetta, grigia = non selezionata
                If (Not selezDosaggioAuto) Then
                    If CisternaLegante(i).CisternaSelezionata Then
                    'a dosaggio fermo va bene la cisterna attualmente selezionata
                        Call CistVisualizzaSelezione(i - 1)
                    Else
                        Call CistVisualizzaIdle(i - 1)
                    End If
                Else
                    If Not CisternaLegante(i).CisternaSelezionata Then
                        Call CistVisualizzaIdle(i - 1)
                    ElseIf VerificaMaterialeCistDosaggio(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2, ListaCisterneValideDosaggioPCL2) Or (MaterialeDosaggioPCL2 = "") Then
                    'a dosaggio attivo va bene se la cisterna attualmente selezionata solo se e' quella richiesta in ricetta
                        Call CistVisualizzaSelezione(i - 1)
                    ElseIf Not VerificaMaterialeCistDosaggio(DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2, ListaCisterneValideDosaggioPCL2) Then
                    'a dosaggio attivo segnalo che la cisterna attualmente selezionata non e' quella richiesta in ricetta
                        Call CistVisualizzaErrore(i - 1)
                        erroreattivo = True
                    End If
                End If
            End If
        
        Next i
 
        'aggiorna bitmap frame gestione cisterne
        Select Case numeroselezionatePCL1
            Case 0
'20151027
                'CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
                CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
'
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 = 0
            Case 1
                CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneAlimentazioneImpianto", vbResBitmap)
            Case Else
                CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 = -1
        End Select

        Select Case numeroselezionatePCL2
            Case 0
'20151027
                'CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
                CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 = 0
'
            Case 1
                CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneRicircolo", vbResBitmap)
            Case Else
                CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 = -1
        End Select

    End With

    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "PC500", "IdDescrizione")
    IngressoAllarmePresente posizione, erroreattivo
    
    '20151027
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "PC501", "IdDescrizione")
    IngressoAllarmePresente posizione, DBScambioDatiCisterneBitume.RidottoTimeoutSelezionePCL1
    
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "PC502", "IdDescrizione")
    IngressoAllarmePresente posizione, DBScambioDatiCisterneBitume.RidottoTimeoutSelezionePCL2
    '
        
    Exit Sub
Errore:
    LogInserisci True, "CCM-013", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20150505
Public Sub GestioneStatoCisterneRidotto()

	Dim i As Integer
	Dim numeroselezionatePCL1 As Integer
	Dim numerocisternaattivaPCL1 As Integer
	Dim numeroselezionatePCL2 As Integer
	Dim numerocisternaattivaPCL2 As Integer
	Dim selezDosaggioAuto As Boolean
    
    On Error GoTo Errore

    With CistGestione

        If (.Gestione <> GestioneSemplificata) Then
            Exit Sub
        End If

        DBScambioDatiCisterneBitume.RidottoNumeroCistBitSuPCL1 = CistGestione.NumeroCistBitSuPCL1
        DBScambioDatiCisterneBitume.RidottoNumeroCistBitSuPCL2 = DBScambioDatiCisterneBitume.NumeroCisternePresenti - DBScambioDatiCisterneBitume.RidottoNumeroCistBitSuPCL1

        selezDosaggioAuto = CP240.OPCData.items(PLCTAG_DosaggioAttivo).Value Or CP240.OPCData.items(PLCTAG_DosaggioInArresto).Value

        For i = 1 To .NumCisterneBitume
            'verifica la cisterna selezionata nei due circuiti
            If i <= CistGestione.NumeroCistBitSuPCL1 Then
                'caso PCL1
                If CisternaLegante(i).CisternaSelezionata Then
                    numeroselezionatePCL1 = numeroselezionatePCL1 + 1
                    DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 = i
                End If
                'aggiorna bitmap cisterna
                If (i <> DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL1) And CisternaLegante(i).CisternaSelezionata And (selezDosaggioAuto And DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL1 <> 0) Then
                    Call CistVisualizzaErrore(i - 1)
                ElseIf CisternaLegante(i).CisternaSelezionata Then
                    Call CistVisualizzaSelezione(i - 1)
                ElseIf (i = DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL1) And Not CisternaLegante(i).CisternaSelezionata Then
                    Call CistVisualizzaAttesa(i - 1)
                Else
                    Call CistVisualizzaIdle(i - 1)
                End If
            Else
                'caso PCL2
                If CisternaLegante(i).CisternaSelezionata Then
                    numeroselezionatePCL2 = numeroselezionatePCL2 + 1
                    DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 = i
                End If
                'aggiorna bitmap cisterna
                If (i <> (DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL2 + CistGestione.NumeroCistBitSuPCL1)) And CisternaLegante(i).CisternaSelezionata And (selezDosaggioAuto And DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL2 <> 0) Then
                    Call CistVisualizzaErrore(i - 1)
                ElseIf CisternaLegante(i).CisternaSelezionata Then
                    Call CistVisualizzaSelezione(i - 1)
                ElseIf (i = DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL2 + CistGestione.NumeroCistBitSuPCL1) And Not CisternaLegante(i).CisternaSelezionata Then
                    Call CistVisualizzaAttesa(i - 1)
                Else
                    Call CistVisualizzaIdle(i - 1)
                End If
            End If
        

        
        Next i
 
        'aggiorna bitmap frame gestione cisterne
        Select Case numeroselezionatePCL1
            Case 0
                CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 = 0
            Case 1
                CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneRicircolo", vbResBitmap)
            Case Else
                CP240.Image1(45).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL1 = -1
        End Select

        Select Case numeroselezionatePCL2
            Case 0
                CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 = 0
            Case 1
                CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneRicircolo", vbResBitmap)
            Case Else
                CP240.Image1(32).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
                DBScambioDatiCisterneBitume.RidottoSelezioneAttualeCisternaBitumePCL2 = -1
        End Select

    End With

    Exit Sub
Errore:
    LogInserisci True, "CCM-014", CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'

'20150513
Public Sub CompilaListaCistDosaggio()

	Dim i As Integer
    
        ListaCisterneValideDosaggioPCL1 = ""
        ListaCisterneValideDosaggioPCL2 = ""
    
        For i = 1 To CistGestione.NumCisterneBitume
            'verifica la cisterna selezionata nei due circuiti
            If i <= CistGestione.NumeroCistBitSuPCL1 Then
                'caso PCL1
                If MaterialeDosaggioPCL1 = CistGestione.materiale(i - 1) Then
                    ListaCisterneValideDosaggioPCL1 = ListaCisterneValideDosaggioPCL1 + CStr(i)
                    'separatore elenco
                    If i >= 1 And i < CistGestione.NumeroCistBitSuPCL1 Then
                        ListaCisterneValideDosaggioPCL1 = ListaCisterneValideDosaggioPCL1 + ","
                    End If
                End If
            Else
                'caso PCL2
                If MaterialeDosaggioPCL2 = CistGestione.materiale(i - 1) Then
                    ListaCisterneValideDosaggioPCL2 = ListaCisterneValideDosaggioPCL2 + CStr(i)
                    'separatore elenco
                    If i >= CistGestione.NumeroCistBitSuPCL1 And i < CistGestione.NumCisterneBitume Then
                        ListaCisterneValideDosaggioPCL2 = ListaCisterneValideDosaggioPCL2 + ","
                    End If
                End If
            End If
        
        Next i

    CP240.LblCistMateriale(6).caption = MaterialeDosaggioPCL1
    CP240.LblCistMateriale(8).caption = MaterialeDosaggioPCL2

End Sub

'20150513
Public Function VerificaMaterialeCistDosaggio(numcisternaselezionata As Integer, listacisternevalidepcl As String) As Boolean

    Dim i As Integer
    Dim numcisterna As Integer
    Dim carattere As String
    Dim scratch As String
    Dim numerocistvalido As String

    'listacisternevalidepcl contiene la lista di cisterne che contengono un bitume (su uno dei due circuiti) compatibile con la selezione in ricetta
    ' numcisterna contiene la cisterna attualmente selezionata
    
    If listacisternevalidepcl = "" Then
        VerificaMaterialeCistDosaggio = False
        Exit Function
    End If

    VerificaMaterialeCistDosaggio = False
    
    For i = 1 To Len(listacisternevalidepcl)
        
        carattere = Mid(listacisternevalidepcl, i, 1)

        If Asc(carattere) >= 49 And Asc(carattere) <= 57 Then
            scratch = scratch + carattere
        Else
            scratch = ""
        End If
                
        If scratch <> "" Then
            If numcisternaselezionata = CInt(scratch) Then
                VerificaMaterialeCistDosaggio = True
                Exit Function
            End If
            scratch = ""
        End If
                
    Next i

End Function
'

'20150514
Public Sub EnableComboMatCP240(visibility As Boolean)

	Dim indice As Integer

    For indice = 0 To 5
        CP240.adoDBMatCist(indice).enabled = visibility
    Next indice
    For indice = 100 To 101
        CP240.adoDBMatCist(indice).enabled = visibility
    Next indice
    CP240.adoDBMatCist(200).enabled = visibility

End Sub



