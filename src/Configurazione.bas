Attribute VB_Name = "Configurazione"
Option Explicit

'   Numero di compilazione per modifiche in cantiere o produzione
Public Const BUILDNUMBER As Integer = 0 '
'   Flag di debug
Public DEBUGGING As Boolean
'   Flag di DEMO
Public DEMO_VERSION As Boolean
'   Intestazione dei box
Public CAPTIONSTARTSIMPLE As String
Public CaptionStart As String

Public CharSetSelezionato As Integer

'Controllo esecuzione programma
Public Const ERROR_ALREADY_EXISTS = 183&
Public Declare Function CreateMutex Lib "kernel32" Alias "CreateMutexA" (lpMutexAttributes As Any, ByVal bInitialOwner As Long, ByVal lpName As String) As Long
Public Declare Function ReleaseMutex Lib "kernel32" (ByVal hMutex As Long) As Long
Public Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long

Public Declare Function ShellExecute Lib "SHELL32.DLL" Alias "ShellExecuteA" ( _
    ByVal hWnd As Long, _
    ByVal lpOperation As String, _
    ByVal lpFile As String, _
    ByVal lpParameters As String, _
    ByVal lpDirectory As String, _
    ByVal nShowCmd As Long _
    ) As Long

'Localizzazione
Public Const LOCALE_USER_DEFAULT = &H400
Public Const LOCALE_SDECIMAL = &HE
Public Const LOCALE_STHOUSAND = &HF
Public Const LOCALE_SSHORTDATE = &H1F
Public Const LOCALE_STIME = &H1E
Public Const LOCALE_STIMEFORMAT = &H1003
Public Const LOCALE_ILZERO = &H12

'Public Declare Function GetLocaleInfo& Lib "kernel32" Alias "GetLocaleInfoA" (ByVal Locale As Long, ByVal LCType As Long, ByVal lpLCData As String, ByVal cchData As Long)
Public Declare Function SetLocaleInfo& Lib "kernel32" Alias "SetLocaleInfoA" (ByVal Locale As Long, ByVal LCType As Long, ByVal lpLCData As String)

Public InstallationPath As String
Public UserDataPath As String
Public InstallDataPath As String
Public GraphicPath As String
Public LogPath As String

Public TimeoutAllarmeFiltroAltaTempIN As Long
Public AbilitaSondaAggiuntivaUscitaTamburo As Boolean
'0 = esclusione avviamento caldo per tamburo principale
'1 = esclusione avviamento caldo per tamburo riciclato (ParDrum)
'Public EsclusioneAvvCaldo(0 To 1) As Boolean
Public EsclusioneSpegniVaglio As Boolean
Public AbilitaTemperaturaMixer As Boolean

Public Commessa As String

Public InclusioneAddBacinella As Boolean
Public InclusioneAddMescolatore As Boolean
Public InclusioneAddSacchi As Boolean
Public GestionePesoSacchi As Boolean

Public InclusioneAddFlomac As Boolean
Public InclusioneAddContalitri As Boolean
Public InclusioneAcqua As Boolean
Public PortataAcqua As Double
Public PercConsensoFiller As Integer
Public PercConsensoAcqua As Integer
Public PortataAddBacinella As Double
Public PortataAddMescolatore As Double
Public DensAddMixer As Double
Public InclMinFlussoAddBacinella As Boolean '20150924
Public TempoMinFlussoAddBacinella As Long  '20150924
Public SelezioneRegPid1 As Boolean
Public SelezioneRegPid2 As Boolean
Public MinimoPosModulatorePLC As Integer
Public MassimoPosModulatorePLC As Integer
Public MassimoPosAspPLC As Integer
Public MinimoPosAspPLC As Integer
Public MassimoAriaFredda As Integer
Public MinimoAriaFredda As Integer
Public MassimoModulatoreRAP As Integer
Public MinimoModulatoreRAP As Integer
Public AbilitaSelettoreBitume1 As Boolean
Public AbilitaSelettoreBitume2 As Boolean

Public MinimoModulatoreBruciatoreTamburo2 As Integer
Public MassimoModulatoreBruciatoreTamburo2 As Integer

Public MassimoFSDeprimometroFiltroIN As Integer

Public FrmComandiCisterneVisibile As Boolean
Public ImpastoVagliato As Integer
Public ImpastoNonVagliato As Integer

Public TonOrarieImpianto As Long             'Massima produzione oraria in tonnellate/ora
Public TonOrarieAttualiImpianto As Long      'Attuale produzione oraria in tonnellate/ora

Public Type BilanciaType
    Tara As Double
    Sicurezza As Integer
    FondoScala As Integer
    Peso As Double
    FuoriTolleranza As Boolean
    NumeroDecimali As Integer '20161024
    ProfiNet As Boolean '20161024
    Errore As Boolean '20161107
    CompAttivo As Integer '20170222
    MemFronteDosaEmergPbarNetti As Boolean '20170301
End Type

'20160419
Public Type BilanciaViatopScarMixerType
    Presenza As Boolean
    FondoScala As Integer
    Tara As Double
    Sicurezza As Integer
    PermanenzaScarico As Long
    TimeoutScarico As Long
    TimeoutPesata As Long  'non usato
    AnticipoCompressore As Long
    RitardoCompressore As Long
    Peso As Double
    FuoriTolleranza As Boolean
    OutPesata As Boolean
    OutScarico As Boolean
    OutCmdCompressore As Boolean
    RitCompressore As Boolean
    NumeroDecimali As Integer     '20161024
    ProfiNet As Boolean '20161024
    Errore As Boolean '20161107
    CompAttivo As Integer '20170222
    MemFronteDosaEmergPbarNetti As Boolean '20170301
End Type
'20160419

'20151103
Public Type BilanciaExtType
    Tara As Double
    Sicurezza As Double
    Sonda420ma As Boolean
    Peso As Double
    ValoreAnalogico As Integer
    TempoCampFiltro As Long
    PesaCamionEnLin As Boolean
    PesaCamionNumLin As Integer
    PesaCamionLinX(0 To 4) As Double
    PesaCamionLinY(0 To 4) As Double
    PesaCamionEnFiltro As Boolean
    PesaCamionSampleNr As Integer
    PesaCamionSampleTime As Double
    PesaCamionEnScaling As Boolean
    PesaCamionScalingAnalogMin As Integer
    PesaCamionScalingAnalogMax As Integer
    PesaCamionScalingKgMin As Double
    PesaCamionScalingKgMax As Double
End Type
'

Public BilanciaAggregati As BilanciaType
Public BilanciaFiller As BilanciaType
Public BilanciaLegante As BilanciaType
Public BilanciaViatop As BilanciaType
'20160419
Public BilanciaViatopScarMixer1 As BilanciaViatopScarMixerType
Public BilanciaViatopScarMixer2 As BilanciaViatopScarMixerType
'20160419
'RAPSiwa
Public BilanciaRAPSiwa As BilanciaType
'RAP
Public BilanciaRAP As BilanciaType
'
Public BilanciaTamponeRiciclato As BilanciaType

Public BilanciaPesaCamion As BilanciaExtType '20151103

Public TaraBitumeSoft As Double
Public SicurezzaBitumeSoft As Integer
Public GSetBSoft As Integer
Public VoltPompaLegante As Integer
Public NTramoggeA As Integer
Public NLivelliA As Integer
Public TipoLivelliA As Integer
Public TramoggeLivelliDigitaliMinimo As Boolean
Public TramoggeVisualizzaLivelloMinimo As Boolean
Public TramoggeLivelloMinimo As Integer
Public TramoggeLivelloMassimo As Integer
Public TempMinimaBitume As Integer
Public TempMinimaEmulsione As Integer
Public MaggiorazionePesataBitume As Integer

Public CicliStopPred As Long
Public DimensioneImpastoKg As Long              'Dimensione dell'impasto attuale in Kg
Public RiduzioneImpasto As Integer              'Percentuale di riduzione attuale dell'impasto
Public RiduzioneImpastoDefault As Integer       'Percentuale di riduzione alla partenza
Public RiduzioneProduzione As Integer           'Percentuale di riduzione attuale della produzione predosatori
Public RiduzioneProduzioneDefault As Integer    'Percentuale di riduzione alla partenza

Public Enum EnumGestioneFiller
    FillerEscluso '0
    FillerIncluso '1
    FillerSoloVisSilo '2
    FillerSoloTramTamp '3
End Enum
'Public GestioneFiller2 As Integer
Public GestioneFiller2 As EnumGestioneFiller
Public GestioneFiller3 As EnumGestioneFiller '20150708 TODO gestione completa come filler 2
Public PresenzaRompiSacchiF2 As Boolean  '20161109
Public InclusioneF2 As Boolean
Public InclusioneF3 As Boolean
Public F2SuElevatoreF2 As Boolean
Public F3SuElevatoreF2 As Boolean
Public NomePortina(0 To 7) As String
Public StartTroppoPienoNV As Long
Public TimeOutTroppoPienoNV As Long 'secondi
Public TimeOutTroppoPienoRifiuti As Long 'secondi   20161129

Public InclusioneTemperaturaLineaCaricoBitume As Boolean
Public AbilitaTermicaComune As Boolean
Public AbilitaPredosatoreVuotoComune As Boolean
Public AbilitaSicurezzaGalleggianteB2 As Boolean
Public AbilitaSicurezzaGalleggianteB3 As Boolean
Public AbilitaBindicatorFillerEsterni As Boolean
Public AbilitaInverterSpruzzaturaLegante As Boolean
Public EsclusioneGestioneBruciatore As Boolean
Public EsclusioneGestioneFiltro As Boolean
Public AbilitaTemperaturaIngressoTamburo As Boolean
Public AbilitaManutenzioni As Boolean
Public AbilitaConsumoEnergia As Boolean

Public RackVersione82x As Boolean

Public Enum ScambioTuboPienoEnum
    DirettoSuF2
    ScambioF1F2
    ScambioF2F3
End Enum

Public GestioneScambioTuboTroppoPieno As ScambioTuboPienoEnum


Public Enum UsersEnum
    NONE
    OPERATOR
    MANAGER
    ADMINISTRATOR
    SUPERUSER
End Enum
Public ActiveUser As UsersEnum

Public Enum ScaleID
    IDaggregati = 0
    IDfiller
    IDBitume
    IDAdditivoMescolatore
    IDAdditivoBacinella
    IDAdditivoSacchi
    IDAdditivoViatop
    IDriciclato
    IDBitumeGravita
    IDAdditivoBacinellaCnt
    IDAdditivoFlomac
    IDBitumeWamFoam
    IDAdditivoAux2
    IDRiciclatoSiwa
    IDDisponibile1
    IDDisponibile2
    IDDisponibile3
    IDDisponibile4
    IDDisponibile5
    IDCicloRiciclatoFreddo
    'AdditivoMescolatoreCnt
    'acqua
    
    MaxScaleID
End Enum

Public Type BilanciaStatusType
    Abilitata As Boolean
    FinePesata As Boolean
    FineScarico As Boolean
    DosaggioAttivo As Boolean
    visibile As Boolean
    step As Integer
    FinePesataOld As Boolean
    FineScaricoOld As Boolean
End Type
Public BilanciaStatus(0 To MaxScaleID - 1) As BilanciaStatusType

Public CmdStartDosaggioLock As Boolean
'
Public EnableControlloComunicazione As Boolean '20150109


Public HardKeyRemoved As Boolean
Private primoinvioparametriplc As Boolean '20150727

'20160412
Public Plus2Monitor As Boolean
'


Public Sub VisualizzaBarraPulsantiCP240(Ena As Boolean)

    With CP240

        '20150904
        'Aggiunto "And Not PlusCommunicationBroken" in tutti i pulsanti "plus"
        '

        .imgPulsanteForm(TBB_SILO).enabled = (Ena And Not PlusCommunicationBroken)
'        .imgPulsanteForm(TBB_SIRENA).enabled = Ena
        .imgPulsanteForm(TBB_STORICO).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_TOTALI).enabled = (Ena And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_ALLARMI).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_TREND).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        '20150409 .imgPulsanteForm(TBB_TREND).enabled = (Ena And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_ENERGIA).enabled = (Ena And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_PARAMETRI).enabled = (Ena And Not PlusCommunicationBroken)
'        .imgPulsanteForm(TBB_HELP).enabled = Ena
        .imgPulsanteForm(TBB_ABOUT).enabled = (Ena And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_EXIT).enabled = Ena
        .imgPulsanteForm(TBB_DOSAGGIO).enabled = Ena
        .imgPulsanteForm(TBB_PREDOSAGGIO).enabled = Ena
        .imgPulsanteForm(TBB_LEGANTE).enabled = Ena
        .imgPulsanteForm(TBB_EMULSIONE).enabled = Ena
        .imgPulsanteForm(TBB_COMBUSTIBILE).enabled = Ena
        .imgPulsanteForm(TBB_PLCIO).enabled = (Ena And Not PlusCommunicationBroken)
        '20150409
        .imgPulsanteForm(TBB_MANUTENZIONI).enabled = (Ena And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_LOGIN).enabled = (Ena And Not PlusCommunicationBroken)
        '
        .imgPulsanteForm(TBB_MOTORI).enabled = Ena
        .imgPulsanteForm(TBB_STORICOPREDOSAGGIO).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_STORICOSILO).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_STORICOIMPMANUALI).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        '20170220
        .imgPulsanteForm(TBB_DOSINGMATERIALS).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        .imgPulsanteForm(TBB_TOTALDOSINGRECIPE).enabled = (Ena And Not DosaggioInCorso And Not PlusCommunicationBroken)
        '
                             
'        .TopBarButton(TBB_PARAMETRI).enabled = Ena
'        .TopBarButton(TBB_STORICO).enabled = (Ena And Not DosaggioInCorso)
'        .TopBarButton(TBB_ALLARMI).enabled = (Ena And Not DosaggioInCorso)
'        .TopBarButton(TBB_TOTALI).enabled = Ena
'        .TopBarButton(TBB_CONSUMOMAT).enabled = Ena
'        .TopBarButton(TBB_SILO).enabled = Ena
'        .TopBarButton(TBB_TREND).enabled = Ena
'        .TopBarButton(TBB_ABOUT).enabled = Ena
'        .TopBarButton(TBB_ENERGIA).enabled = Ena
'        .TopBarButton(TBB_NETTI).enabled = Ena
'        .TopBarButton(TBB_PREDOSAGGIO).enabled = Ena
'        .TopBarButton(TBB_DOSAGGIO).enabled = Ena
'        .TopBarButton(TBB_LEGANTE).enabled = Ena
'        .TopBarButton(TBB_PLCIO).enabled = Ena
'        .TopBarButton(TBB_MOTORI).enabled = Ena
'        .TopBarButton(TBB_STORICOPREDOSAGGIO).enabled = Ena
'

        'Comandi
        .CmdAvvMotori(2).enabled = Ena
        .CmdAvvMotori(1).enabled = Ena
        
        CP240.CmdStartStopGenerale(0).enabled = Ena
        CP240.imgPulsanteForm(TBB_NETTI).enabled = Ena
    End With

    If Ena Then
        CmdStartDosaggioLock = False
    End If

    '20150409
    ''CP240.CmdStartDosaggio.enabled = (Not CmdStartDosaggioLock) And (Not DosaggioInCorso) And (Not PesaturaManuale)
    'CP240.CmdStartDosaggio.enabled = (Not CmdStartDosaggioLock) And (Not DosaggioInCorso) And (Not PesaturaManuale) And Not HardKeyRemoved
    ''
    
    '20161020
'    CP240.CmdStartDosaggio.enabled = ( _
'        Not CmdStartDosaggioLock And _
'        Not DosaggioInCorso And _
'        Not PesaturaManuale And _
'        Not HardKeyRemoved And _
'        Not PlusCommunicationBroken _
'    )
    
    CP240.CmdStartDosaggio.enabled = ( _
        Not CmdStartDosaggioLock And _
        Not DosaggioInCorso And _
        Not HardKeyRemoved And _
        Not PlusCommunicationBroken _
    )
'
    
    
    '
    Call CP240.UpdatePulsantiForm

End Sub

Public Sub PlcInviaParametri()

    Dim indice As Integer
    Dim spread As Integer

    On Error GoTo Errore

    If (DEMO_VERSION) Then
        Exit Sub
    End If

    With CP240.OPCData

        If (.items.count = 0 Or Not .IsConnected) Then
            Exit Sub
        End If

        .items(PLCTAG_ThImpianto).Value = CSng(TonOrarieImpianto)
        .items(PLCTAG_UnitaPLC).Value = 2048
        .items(PLCTAG_FondoScalaBilA).Value = CSng(BilanciaAggregati.FondoScala)
        .items(PLCTAG_FondoScalaBilF).Value = CSng(BilanciaFiller.FondoScala)
        .items(PLCTAG_FondoScalaBilB).Value = CSng(BilanciaLegante.FondoScala)

        If InclusioneViatop Then
            .items(PLCTAG_FondoScalaBilV).Value = CSng(BilanciaViatop.FondoScala)
        Else
            .items(PLCTAG_FondoScalaBilV).Value = CSng(0)
        End If
        
        If (AbilitaRAP) Then
            .items(PLCTAG_FondoScalaBilRic).Value = CSng(BilanciaRAP.FondoScala)
        Else
            .items(PLCTAG_FondoScalaBilRic).Value = CSng(0)
        End If
        '20161024
        .items(PLCTAG_BIL_PNET_Aggregati_Presenza).Value = BilanciaAggregati.ProfiNet
        .items(PLCTAG_BIL_PNET_Filler_Presenza).Value = BilanciaFiller.ProfiNet
        .items(PLCTAG_BIL_PNET_Bitume_Presenza).Value = BilanciaLegante.ProfiNet
        .items(PLCTAG_BIL_PNET_Riciclato_Presenza).Value = BilanciaRAP.ProfiNet
        .items(PLCTAG_BIL_PNET_Aggregati_NumeroDecimali).Value = BilanciaAggregati.NumeroDecimali
        .items(PLCTAG_BIL_PNET_Filler_NumeroDecimali).Value = BilanciaFiller.NumeroDecimali
        .items(PLCTAG_BIL_PNET_Bitume_NumeroDecimali).Value = BilanciaLegante.NumeroDecimali
        .items(PLCTAG_BIL_PNET_Riciclato_NumeroDecimali).Value = BilanciaRAP.NumeroDecimali
        If (BilanciaViatopScarMixer1.Presenza) Then
            .items(PLCTAG_BIL_PNET_Viatop_Presenza).Value = BilanciaViatopScarMixer1.ProfiNet
            .items(PLCTAG_BIL_PNET_Viatop_NumeroDecimali).Value = BilanciaViatopScarMixer1.NumeroDecimali
        Else
            .items(PLCTAG_BIL_PNET_Viatop_Presenza).Value = BilanciaViatop.ProfiNet
            .items(PLCTAG_BIL_PNET_Viatop_NumeroDecimali).Value = BilanciaViatop.NumeroDecimali
        End If
        .items(PLCTAG_BIL_PNET_Viatop2_Presenza).Value = BilanciaViatopScarMixer2.ProfiNet
        .items(PLCTAG_BIL_PNET_Viatop2_NumeroDecimali).Value = BilanciaViatopScarMixer2.NumeroDecimali
        '20161024
    '    .Items(PLCTAG_FondoScalaBil7).value = CSng(0)
        .items(PLCTAG_TaraMaxA).Value = BilanciaAggregati.Tara
        .items(PLCTAG_TaraMaxF).Value = BilanciaFiller.Tara
        .items(PLCTAG_TaraMaxB).Value = BilanciaLegante.Tara
        .items(PLCTAG_TaraMaxViatop).Value = BilanciaViatop.Tara
        .items(PLCTAG_DB5_ViatopScarMixer1_Tara).Value = BilanciaViatopScarMixer1.Tara  '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_Tara).Value = BilanciaViatopScarMixer2.Tara  '20160419
    '    .Items(PLCTAG_TaraMaxAdd).value = CSng(0)
        .items(PLCTAG_TaraMaxBil4).Value = BilanciaRAP.Tara
    '    .Items(PLCTAG_TaraMaxBil7).value = CSng(0)
        .items(PLCTAG_SicurezzaBilA).Value = CSng(BilanciaAggregati.Sicurezza)
        .items(PLCTAG_SicurezzaBilF).Value = CSng(BilanciaFiller.Sicurezza)
        .items(PLCTAG_SicurezzaBilB).Value = CSng(BilanciaLegante.Sicurezza)
        .items(PLCTAG_SicurezzaBilViatop).Value = CSng(BilanciaViatop.Sicurezza)
        .items(PLCTAG_TempoSvuotTraspViatop).Value = CInt(PermanenzaScaricoBilanciaViatop)
        .items(PLCTAG_TempoSvuotCicviatop).Value = CInt(PermanenzaScaricoCicloneViatop)
        .items(PLCTAG_DB5_ViatopScarMixer1_Sicurezza).Value = BilanciaViatopScarMixer1.Sicurezza  '20160419
        .items(PLCTAG_DB5_ViatopScarMixer1_TempoPermanenza).Value = BilanciaViatopScarMixer1.PermanenzaScarico  '20160419
        .items(PLCTAG_DB5_ViatopScarMixer1_Ant_Start_Compressore).Value = BilanciaViatopScarMixer1.AnticipoCompressore '20160419
        .items(PLCTAG_DB5_ViatopScarMixer1_Rit_Stop_Compressore).Value = BilanciaViatopScarMixer1.RitardoCompressore '20160419
        .items(PLCTAG_DB5_ViatopScarMixer1_FondoScala).Value = BilanciaViatopScarMixer1.FondoScala '20160422
        .items(PLCTAG_DB5_ViatopScarMixer2_Sicurezza).Value = BilanciaViatopScarMixer2.Sicurezza  '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_TempoPermanenza).Value = BilanciaViatopScarMixer2.PermanenzaScarico  '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_Ant_Start_Compressore).Value = BilanciaViatopScarMixer2.AnticipoCompressore '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_Rit_Stop_Compressore).Value = BilanciaViatopScarMixer2.RitardoCompressore '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_FondoScala).Value = BilanciaViatopScarMixer2.FondoScala '20160422
    '    .Items(PLCTAG_SicurezzaBilAdd).value = CSng(0)
        .items(PLCTAG_SicurezzaBilRAP).Value = CSng(BilanciaRAP.Sicurezza)
    '    .Items(PLCTAG_SicurezzaBil7).value = CSng(0)
        .items(PLCTAG_FondoScalaBilNastroA).Value = CSng(PortataMaxRamseyInerti)
        .items(PLCTAG_FondoScalaBilNastroR).Value = CSng(PortataMaxRamseyRic)
        'Predisposizione
        '.Items(TODO).value = CSng(PortataMaxRamseyRicParDrum)
        '
        .items(PLCTAG_TPausaLavoroFiltro).Value = TempoPausaFiltro
        .items(PLCTAG_TimerLavoro1Filtro).Value = TempoLavoro1Filtro
        .items(PLCTAG_TimerLavoro2Filtro).Value = TempoLavoro2Filtro
        .items(PLCTAG_NumeroCamere).Value = NumeroCamereFiltro
        .items(PLCTAG_ModoFunzFiltro).Value = ModoFunzFiltro
        .items(PLCTAG_PressFiltroMax).Value = CSng(30)
        .items(PLCTAG_SicurezzaTemperatura).Value = CInt(MaxTempSpruzzatura)
        .items(PLCTAG_ValoreMaxVolo).Value = CSng(90)
        .items(PLCTAG_ValoreMaxVoloBit).Value = CSng(90)
        .items(PLCTAG_ValoreSetMaggioratoBit).Value = CSng(MaggiorazionePesataBitume)
        .items(PLCTAG_TempoRitApValvPresep).Value = ValvolaPreseparatore.RitardoApertura
        .items(PLCTAG_TempoRitChValvPresep).Value = ValvolaPreseparatore.RitardoChiusura

        .items(PLCTAG_CelleSiloStabBilancia).Value = CelleSiloStabilizzazioneBilancia * 1000

'20150704
'        .items(PLCTAG_TimeOutScaricoAggregati).Value = TempoAllarmeScaricoAggregati * 1000
'        .items(PLCTAG_TimeOutScaricoFiller).Value = TempoAllarmeScaricoFiller * 1000
'        .items(PLCTAG_TimeOutScaricoLegante).Value = TempoAllarmeScaricoLegante * 1000
'        .items(PLCTAG_TimeOutScaricoLeganteGR).Value = TempoAllarmeScaricoLeganteGR * 1000
'        .items(PLCTAG_TimeOutScaricoContalitri).Value = TempoAllarmeScaricoContalitri * 1000
'        .items(PLCTAG_TimeOutScaricoRiciclato).Value = TempoAllarmeScaricoRiciclato * 1000
'        .items(PLCTAG_TimeOutScaricoViatop).Value = TempoAllarmeScaricoViatop * 1000
'        .items(PLCTAG_TimeOutScaricoMixer).Value = TempoAllarmeScaricoMixer * 1000
'        .items(PLCTAG_PermanenzaScaricoAggregati).Value = TempoPermanenzaScaricoAggregati * 1000
'        .items(PLCTAG_PermanenzaScaricoFiller).Value = TempoPermanenzaScaricoFiller * 1000
'        .items(PLCTAG_PermanenzaScaricoRiciclato).Value = TempoPermanenzaScaricoRiciclato * 1000
'        .items(PLCTAG_PermanenzaScaricoLeganteGR).Value = TempoPermanenzaScaricoLeganteGR * 1000

        .items(PLCTAG_TimeOutScaricoAggregati).Value = TempoAllarmeScaricoAggregati
        .items(PLCTAG_TimeOutScaricoFiller).Value = TempoAllarmeScaricoFiller
        .items(PLCTAG_TimeOutScaricoLegante).Value = TempoAllarmeScaricoLegante
        .items(PLCTAG_TimeOutScaricoLeganteGR).Value = TempoAllarmeScaricoLeganteGR
        .items(PLCTAG_TimeOutScaricoContalitri).Value = TempoAllarmeScaricoContalitri
        .items(PLCTAG_TimeOutScaricoRiciclato).Value = TempoAllarmeScaricoRiciclato
        .items(PLCTAG_TimeOutScaricoViatop).Value = TempoAllarmeScaricoViatop
        .items(PLCTAG_DB5_ViatopScarMixer1_Tmout_Scarico).Value = BilanciaViatopScarMixer1.TimeoutScarico '20160419
        .items(PLCTAG_DB5_ViatopScarMixer1_Tmout_Pesata).Value = BilanciaViatopScarMixer1.TimeoutPesata '20160419 sempre a zero
        .items(PLCTAG_DB5_ViatopScarMixer2_Tmout_Scarico).Value = BilanciaViatopScarMixer2.TimeoutScarico '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_Tmout_Pesata).Value = BilanciaViatopScarMixer2.TimeoutPesata '20160419 sempre a zero
        .items(PLCTAG_TimeOutScaricoMixer).Value = TempoAllarmeScaricoMixer
        .items(PLCTAG_PermanenzaScaricoAggregati).Value = TempoPermanenzaScaricoAggregati
        .items(PLCTAG_PermanenzaScaricoFiller).Value = TempoPermanenzaScaricoFiller
        .items(PLCTAG_PermanenzaScaricoRiciclato).Value = TempoPermanenzaScaricoRiciclato
        .items(PLCTAG_PermanenzaScaricoLeganteGR).Value = TempoPermanenzaScaricoLeganteGR
'

        If AbilitaRAPSiwa Then
            .items(PLCTAG_VeloxMax_SiwarexPESA).Value = CDbl(SiwarexPESA_Velox_MAX_AO)
            .items(PLCTAG_VeloxMin_SiwarexPESA).Value = CDbl(SiwarexPESA_Velox_MIN_AO)
            .items(PLCTAG_Kg_Lenta_SiwarexPESA).Value = CDbl(SiwarexPESA_Kg_Velox_MIN)
        End If

        .items(PLCTAG_PercConsensoFillerRF).Value = PercConsensoFiller
        .items(PLCTAG_PercConsensoAcquaRF).Value = PercConsensoAcqua

        .items(PLCTAG_AbilitaSicurezzaGalleggianteB2).Value = AbilitaSicurezzaGalleggianteB2
        .items(PLCTAG_AbilitaSicurezzaGalleggianteB3).Value = AbilitaSicurezzaGalleggianteB3

        Call PlcGriglieVibranti

        .items(PLCTAG_AbilitaBilanciaAggregati).Value = True
        .items(PLCTAG_AbilitaBilanciaFiller).Value = True
        .items(PLCTAG_AbilitaBilanciaBitume).Value = Not BitumeGravita
        .items(PLCTAG_AbilitaBilanciaBitumeGR).Value = BitumeGravita
        .items(PLCTAG_AbilitaBilanciaContalitri).Value = InclusioneAddContalitri
        .items(PLCTAG_AbilitaBilanciaAddMix).Value = InclusioneAddMescolatore
        .items(PLCTAG_AbilitaBilanciaAddBaci).Value = InclusioneAddBacinella
        .items(PLCTAG_AbilitaBilanciaViatop).Value = InclusioneViatop
        .items(PLCTAG_DB5_ViatopScarMixer1_Enable).Value = BilanciaViatopScarMixer1.Presenza  '20160419
        .items(PLCTAG_DB5_ViatopScarMixer2_Enable).Value = BilanciaViatopScarMixer2.Presenza  '20160419'20161010
        .items(PLCTAG_AbilitaBilanciaRiciclato).Value = AbilitaRAP
        .items(PLCTAG_AbilitaBilanciaRiciclatoSiwa).Value = AbilitaRAPSiwa
        .items(PLCTAG_AbilitaBilanciaAddSacchi).Value = InclusioneAddSacchi
        .items(PLCTAG_AbilitaBilanciaAcqua).Value = InclusioneAcqua
        .items(PLCTAG_AbilitaAquablack).Value = InclusioneAquablack
        .items(PLCTAG_MaxValKgAquablack).Value = MaxValKgAquablack
        
        .items(PLCTAG_Add2_Abilita_MinFlusso).Value = InclMinFlussoAddBacinella '20150924
        .items(PLCTAG_Add2_Tempo_MinFlusso).Value = TempoMinFlussoAddBacinella '20150924
        
        For indice = 0 To 7
            .items(PLCTAG_AbilitaPesataFineA1 + indice).Value = AbilitaFineCorsaIntermedioAggregati
            .items(PLCTAG_PesataFineA1_Kg + indice).Value = PesataFineAggregatiKg(indice + 1)
            .items(PLCTAG_CoefficienteGrossaFineA1_Kg + indice).Value = CoeffCommutaPesataFineAggregati(indice + 1)
            .items(PLCTAG_CoefficienteFineChiusoA1_Kg + indice).Value = CoeffVoloPesataFineAggregati(indice + 1)
            .items(PLCTAG_CoefficienteGrossaChiusoA1_Kg + indice).Value = CoeffVoloPesataUnicaAggregati(indice + 1)
        Next indice
        .items(PLCTAG_NumCampionamentiCalcoloFlusso).Value = NumeroCampionamentiCalcoloFlusso
        .items(PLCTAG_AbilitaVoloDinamicoFlusso).Value = AbilitaVoloDinamicoFlusso
        .items(PLCTAG_MinimoPesataVeloce_Kg).Value = PesoMinimoPesataVeloce

        'Tutti i calcoli del legante dentro o fuori dal 100% li fa il PC
        .items(PLCTAG_InclusioneLegante100).Value = False

        .items(PLCTAG_AbilitaBennaApribile).Value = InclusioneBennaApribile
        
        .items(PLCTAG_VibratoriPredTempoOn).Value = ColdFeederVibratorWorkingCycle.On
        .items(PLCTAG_VibratoriPredTempoOff).Value = ColdFeederVibratorWorkingCycle.Idle
        .items(PLCTAG_VibratoriPredRicTempoOn).Value = RecyColdFeederVibratorWorkingCycle.On
        .items(PLCTAG_VibratoriPredRicTempoOff).Value = RecyColdFeederVibratorWorkingCycle.Idle
        .items(PLCTAG_SoffioAriaPredRicTempoOn).Value = RecyColdFeederBlowerWorkingCycle.On
        .items(PLCTAG_SoffioAriaPredRicTempoOff).Value = RecyColdFeederBlowerWorkingCycle.Idle
        
        .items(PLCTAG_EN_Antiad_Sciv_Sc_BilRAP).Value = AntiadesivoScivoloScarBilRAP.Inclusione
        .items(PLCTAG_NrImpAttAntiadScarBilRic).Value = AntiadesivoScivoloScarBilRAP.nr_eventi_attesa
        .items(PLCTAG_TempoSpruzAntiadScarBilR).Value = AntiadesivoScivoloScarBilRAP.tempo_spruzzatura
'20150422
        .items(PLCTAG_Tempo_On_Soffio_Silo_Filler).Value = ListaComandi(ComandoSiloFillerSoffioAriaRecupero).tempoStart
        .items(PLCTAG_Tempo_Off_Soffio_Silo_Filler).Value = ListaComandi(ComandoSiloFillerSoffioAriaRecupero).tempoStop
'
        
        .items(PLCTAG_Tempo_Rit_All_FC_Mixer).Value = TempoRitardoAllarmeScaricoMixer '20170221
                       
        .items(PLCTAG_Tempo_Perm_Flap_Sc_Ric).Value = TempoPermApertFlapScivoloScarBilRAP
        .items(PLCTAG_AbilitazSpruzzBennaTemporiz).Value = AbilitazioneSpruzzaturaBennaTemporizzata

        '20161214
        .items(PLCTAG_SILO_Deodorante_Enable).Value = Deodorante.Inclusione
        .items(PLCTAG_SILO_Deodorante_RitStart).Value = Deodorante.RitStart
        .items(PLCTAG_SILO_Deodorante_RitStop).Value = Deodorante.RitStop
        .items(PLCTAG_SILO_Deodorante_MaxDurata).Value = Deodorante.DurataMax
        '20161214

        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)
         Dim i, J As Integer
        .items(PLCTAG_SILI_PAR_AbilitaCelleCaricoSilo) = AbilitaCelleCaricoSilo                         'passo i parametri di navetta o benna al plc
        .items(PLCTAG_DB5_VisualizzaNavetta).Value = InclusioneBenna And Not VisualizzaBenna            'tolleranza per acquisizione peso(ton)
        .items(PLCTAG_SILI_PAR_FondoScala_Peso).Value = CDbl(FondoScalaPesoSilo)                        'fondoscala Peso Celle
        
        .items(PLCTAG_SILI_PAR_CelleSiloStabBilancia).Value = CelleSiloStabilizzazioneBilancia * 1000   'tempo di stabilizzazione [sec]
        
        .items(PLCTAG_SILI_PAR_TempoMinPressTelescarico).Value = TempoColpettiTelesc                    'tempo filtraggio colpetti telescarico [msec]
        
        .items(PLCTAG_SILI_PAR_MaxTara).Value = MaxTara                                                 'valore di massima tara [ton]
        If (AbilitaCelleCaricoSilo) Then
            .items(PLCTAG_SILI_PAR_Tolleranza).Value = CelleSiloTolleranzaBilancia                          'tolleranza per acquisizione peso(ton)
        Else
            .items(PLCTAG_SILI_PAR_Tolleranza).Value = 0
        End If
        
        'assegnazione scomparto silo
        For i = 0 To SILI_MAXPLC            '20151203
            J = ScompartiCompatta(i)
            If (J >= 0) Then
                'azzero tutto
                .items(PLCTAG_SILI_PAR_AppScomparto_0 + J).Value = 0
                .items(PLCTAG_SILI_PAR_AppScomparto_Temp_0 + J).Value = 0 '20151215
            End If
        Next i
        If (AbilitaCelleCaricoSilo) Then
            For i = 0 To CalcolaNumeroModuliSilo(CelleSiloConfigurazioneSilo) - 1
                Dim app As String
                app = RicavaDestinazioniDaModuloSilo(CInt(i), CelleSiloConfigurazioneSilo)
                For J = 1 To Len(app)
                    Dim app2 As Integer
                    app2 = GetSiloIndex(Mid(app, J, 1))
                    .items(PLCTAG_SILI_PAR_AppScomparto_0 + ScompartiCompatta(ScompartiSiliPC_a_PLC(app2))).Value = i + 1
                Next J
            Next i
        End If

'20151215
        For i = 0 To CalcolaNumeroModuliSilo(ConfigurazioneTemperatureSilo) - 1
            app = RicavaDestinazioniDaModuloSilo(CInt(i), ConfigurazioneTemperatureSilo)
            For J = 1 To Len(app)
                app2 = GetSiloIndex(Mid(app, J, 1))
                .items(PLCTAG_SILI_PAR_AppScomparto_Temp_0 + ScompartiCompatta(ScompartiSiliPC_a_PLC(app2))).Value = i + 1
            Next J
        Next i
'
        'Scrittura abilitazione tempi di anticipo blocco telescarichi
        .items(PLCTAG_SILI_PAR_EnableTempoAntBlocco).Value = InclusioneTempiAnticipo
        For i = 0 To SILI_MAXPLC
            J = ScompartiCompatta(i)
            If (J >= 0) Then
                .items(PLCTAG_SILI_PAR_TempoAnticipoBlocco0 + J).Value = TempiCelleSilo(ScompartiSiliPLC_a_PC(i))
            End If
        Next i

        'DirettoconPeso
        PresenzaSiloDirettoConPeso = False
        For i = 1 To Len(CelleSiloConfigurazioneSilo)
            If Mid(CelleSiloConfigurazioneSilo, i, 1) = "D" Then
                PresenzaSiloDirettoConPeso = True
            End If
        Next i

        'RifiuticonPeso
        PresenzaSiloRifiutiConPeso = False
        For i = 1 To Len(CelleSiloConfigurazioneSilo)
            If Mid(CelleSiloConfigurazioneSilo, i, 1) = "R" Then
                PresenzaSiloRifiutiConPeso = True
            End If
        Next i
       .items(PLCTAG_SILI_PAR_Diretto).Value = PresenzaSiloDiretto
       .items(PLCTAG_SILI_PAR_DirettoConPeso).Value = PresenzaSiloDirettoConPeso
       .items(PLCTAG_SILI_PAR_Rifiuti).Value = PresenzaSiloRifiuti
       .items(PLCTAG_SILI_PAR_RifiutiConPeso).Value = PresenzaSiloRifiutiConPeso
       .items(PLCTAG_SILI_PAR_NumeroSili).Value = NumeroVisPesoSili
       .items(PLCTAG_SILI_PAR_NumeroScomparti).Value = NumeroSili
       
'20160418
'       If (Not DopoPrimoTrasferimentoSiliDeposito) Then
'            CelleSiloInizializza
'            'scrittura dei pesi scomparto e delle tare dei Sili
'            For i = 0 To SILI_MAXPLC
'                j = ScompartiCompattaSalta(i)
'                If (j >= 0) Then
'                    If (ScompartiSiliPLC_a_PC(i) > 0) Then
'                        .items(PLCTAG_SILI_HMI_PesoIniziale_0 + ScompartiCompatta(i)).Value = ListaSili(ScompartiSiliPLC_a_PC(i)).Peso
'                    End If
'                End If
'            Next i
'            .items(PLCTAG_SILI_HMI_PesoInizialeCamion).Value = 0 'CelleSiloScaricatoCamion meglio riazzerare ogni riavvio
'            .items(PLCTAG_SILI_HMI_TaraInizialeCamion).Value = 0 'BilanciaPesaCamion.Tara meglio riazzerare ogni riavvio
'            For i = 1 To 4
'                .items(PLCTAG_SILI_HMI_TaraInizialeCella_1 + (i - 1)).Value = CelleSiloDetrarreTara(i)
'            Next i
'       End If
            
      If (Not DopoPrimoTrasferimentoSiliDeposito) Then
            .items(PLCTAG_SILI_HMI_TrasfPar).Value = True
            FrmGestioneTimer.TimerAbilitaSiliDeposito.enabled = True  '20151218
      Else
           .items(PLCTAG_SILI_HMI_AggiornaPar).Value = True
      End If
      
       .items(PLCTAG_SILI_PAR_PesaCamionEnable).Value = AbilitaBilanciaCamion
            
'20151215
    For indice = 0 To 4
        Select Case indice 'se fossero in fila sarebbe troppo facile...
            Case 0 To 1
                .items(PLCTAG_SILI_PAR_FondoScala_Temp1 + indice).Value = ListaTemperature(TempSilo0 + indice).FondoScalaMax
                .items(PLCTAG_SILI_PAR_ScalaMin_Temp1 + indice).Value = ListaTemperature(TempSilo0 + indice).FondoScalaMin
                .items(PLCTAG_SILI_PAR_ScalaMinAnalog_Temp1 + indice).Value = IIf(ListaTemperature(TempSilo0 + indice).MilliAmpere420, 5530, 0)
            Case 2 To 4
                .items(PLCTAG_SILI_PAR_FondoScala_Temp1 + indice).Value = ListaTemperature(TempSilo0 + 8 + indice).FondoScalaMax
                .items(PLCTAG_SILI_PAR_ScalaMin_Temp1 + indice).Value = ListaTemperature(TempSilo0 + 8 + indice).FondoScalaMin
                .items(PLCTAG_SILI_PAR_ScalaMinAnalog_Temp1 + indice).Value = IIf(ListaTemperature(TempSilo0 + 8 + indice).MilliAmpere420, 5530, 0)
        End Select
    Next indice
'
      
      DopoPrimoTrasferimentoSiliDeposito = True
        '20151124(NUOVA GESTIONE SILI DI DEPOSITO)


        'PLCTAG_NM_ ... NM=NEW MOTORS ...
        For indice = 0 To MAXNEWMOTORS - 1
            .items(PLCTAG_NM_Sequenze_ListaAvvCompleta_1 + indice).Value = IIf(indice < MAXMOTORI, OrdineAvviamentoMotori(indice + 1), 0)
            .items(PLCTAG_NM_Sequenze_ListaSpegnimento_1 + indice).Value = IIf(indice < MAXMOTORI, OrdineSpegnimentoMotori(indice + 1), 0)
            .items(PLCTAG_NM_ZonaAsservimenti_AsservimentiDefault_1 + indice).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).asservimento, 0)
        Next indice

        .items(PLCTAG_NM_SIRENA_Abilitazione).Value = AbilitaSirenaAvvioImpianto
        
        .items(PLCTAG_NM_SIRENA_Tintervento).Value = TempoAttesaRiavvioSirena
        .items(PLCTAG_NM_SIRENA_Tlavoro).Value = TempoOnSirena
        .items(PLCTAG_NM_SIRENA_Tpausa).Value = TempoOffSirena
        .items(PLCTAG_NM_NV_Timeout).Value = TimeOutTroppoPienoNV
        .items(PLCTAG_NM_RIF_Timeout).Value = TimeOutTroppoPienoRifiuti   '20161129
        .items(PLCTAG_NM_NV_TipoLiv).Value = ((TipoLivelliA And (2 ^ 7)) = 0)
        .items(PLCTAG_NM_NV_Anal_MinIN).Value = 0 'TODO NEW PARA
        .items(PLCTAG_NM_NV_Anal_MaxIN).Value = 0 'TODO NEW PARA
        .items(PLCTAG_NM_NV_Anal_MinOUT).Value = LivelloRiscalaMinTramoggia(7)
        .items(PLCTAG_NM_NV_Anal_MaxOUT).Value = LivelloRiscalaMaxTramoggia(7)
        .items(PLCTAG_NM_NV_LivelloAnalMax).Value = TramoggeLivelloMassimo
        .items(PLCTAG_NM_FILLER_ElevatoreF2SuF1).Value = (Not F2SuElevatoreF2)
        .items(PLCTAG_NM_FILLER_ElevatoreF2SuF3).Value = F3SuElevatoreF2
        .items(PLCTAG_NM_FILLER_InclusioneF2).Value = InclusioneF2
        .items(PLCTAG_NM_FILLER_InclusioneF3).Value = InclusioneF2
        .items(PLCTAG_Filler2_RompiSacchi_Presenza).Value = PresenzaRompiSacchiF2 '20161109
        .items(PLCTAG_NM_BITUME_AvvioPCLConDosaggio).Value = Pcl1AutoOn
        .items(PLCTAG_NM_BITUME_AvvioPCL2ConDosaggio).Value = Pcl2AutoOn
        .items(PLCTAG_NM_FILLERIZZAZIONE_SogliaMinima).Value = 0 'TODO NEW PARA
        .items(PLCTAG_NM_FILLERIZZAZIONE_IsterersiMinDep).Value = 0 'TODO NEW PARA
        .items(PLCTAG_NM_NASTRITimeoutNC).Value = TempoSpegnimentoNastriCollettori
        .items(PLCTAG_NM_NASTRITimeoutNRicF).Value = TempoSpegnimentoNastriCollettori
        .items(PLCTAG_NM_NASTRITimeoutNRicC).Value = TempoSpegnimentoNastriRiciclatoCaldo
        .items(PLCTAG_NM_BRUCIATORE1_InclAvvCaldo).Value = Not (ListaTamburi(0).EsclusioneAvviamentoCaldo)
        .items(PLCTAG_NM_BRUCIATORE2_InclAvvCaldo).Value = Not (ListaTamburi(1).EsclusioneAvviamentoCaldo)
        .items(PLCTAG_NM_BRUCIATORE1_TipoCombGas).Value = (ListaTamburi(0).SelezioneCombustibile = CombustibileGas)
        .items(PLCTAG_NM_BRUCIATORE2_TipoCombGas).Value = (ListaTamburi(1).SelezioneCombustibile = CombustibileGas)
        .items(PLCTAG_NM_BRUCIATORE1_TipoCombOlio).Value = (ListaTamburi(0).SelezioneCombustibile = CombustibileOlioCombustibile)
        .items(PLCTAG_NM_BRUCIATORE2_TipoCombOlio).Value = (ListaTamburi(1).SelezioneCombustibile = CombustibileOlioCombustibile)
        .items(PLCTAG_NM_DEFLETTORI_AbilitaDefAnelloElev).Value = AbilitaDeflettoreAnelloElevatoreRic
        .items(PLCTAG_NM_ELEVCALDO_AbilitaDefAnelloRif).Value = AbilitaDeflettoreAnello
        .items(PLCTAG_NM_ELEVCALDO_AbilitaDefMod).Value = AbilitaModulatoreDeflettoreAnello
        .items(PLCTAG_NM_FILLER_ModTopTowerF1).Value = LivelloMaxF1
        .items(PLCTAG_NM_FILLER_ModTopTowerF2).Value = LivelloMaxF2
        .items(PLCTAG_NM_FILLER_ModTopTowerF3).Value = LivelloMaxF2     '20151218 in caso di gestione completa F3 (C estr F3 presente) la tramoggia tampone è i comune con F2
        .items(PLCTAG_NM_FILLER_LivEsterni).Value = AbilitaBindicatorFillerEsterni
        .items(PLCTAG_NM_FILLER_TramTamp_F2).Value = InclusioneTramoggiaTamponeF2
        spread = (PLCTAG_NM_MOTORE2_Presente - PLCTAG_NM_MOTORE1_Presente)
        
        If ListaTamburi(0).SelezioneCombustibile = CombustibileGas Then
            ListaMotori(MotorePompaCombustibile).presente = False
       End If
        
        For indice = 0 To MAXNEWMOTORS - 1

            .items(PLCTAG_NM_MOTORE1_Presente + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).presente, False)
            .items(PLCTAG_NM_MOTORE1_UscitaInvertita + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_RitornoInvertito + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_TipoInversione + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_IO_InverterPresente + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_IO_InverterScaling_MinIN + (indice * spread)).Value = IIf(indice < MAXMOTORI, 0, 0)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_IO_InverterScaling_MaxIN + (indice * spread)).Value = IIf(indice < MAXMOTORI, 0, 0)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_Esclusioni_Uscita + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_Esclusioni_Ritorno + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)  'TODO NEW PARA
            .items(PLCTAG_NM_MOTORE1_Sequenza_SoloVisualizzazione + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).SoloVisualizzazione, False)
            .items(PLCTAG_NM_MOTORE1_Sequenza_EsclusionAvv + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).offStart, False)
            .items(PLCTAG_NM_MOTORE1_Sequenza_EsclusionSpe + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).onStop, False)
            .items(PLCTAG_NM_MOTORE1_Sequenza_InclAvvRidotto + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)
            .items(PLCTAG_NM_MOTORE1_Sequenza_GruppoAvvRidotto + (indice * spread)).Value = IIf(indice < MAXMOTORI, False, False)
            .items(PLCTAG_NM_MOTORE1_Sequenza_TempoRitAvvMotSuc + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).tempoStart, 0)
            .items(PLCTAG_NM_MOTORE1_Sequenza_TempoRitSpeMotSuc + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).tempoStop, 0)
            .items(PLCTAG_NM_MOTORE1_Timeout_Avvio + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).tempoAttesaRitorno, 0)
            .items(PLCTAG_NM_MOTORE1_Timeout_Arresto + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).tempoAttesaRitorno, 0)
            .items(PLCTAG_NM_MOTORE1_PausaLavoro_Presenza + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).pausaLavoro.abilitato, False)
            .items(PLCTAG_NM_MOTORE1_PausaLavoro_Tpausa + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).pausaLavoro.TempoPausa, 0)
            .items(PLCTAG_NM_MOTORE1_PausaLavoro_Tlavoro + (indice * spread)).Value = IIf(indice < MAXMOTORI, ListaMotori(indice + 1).pausaLavoro.TempoLavoro, 0)
            .items(PLCTAG_NM_MOTORE1_Antislittamento_Tempo + (indice * spread)).Value = IIf(indice < MAXMOTORI - 1, ListaMotori(indice + 1).tempoRitAllSlittamento, 0)  '20161110
            .items(PLCTAG_NM_MOTORE1_Antislittamento_Presente + (indice * spread)).Value = IIf(indice < MAXMOTORI - 1, ListaMotori(indice + 1).tempoRitAllSlittamento > 0, False)  '20161110
        Next indice
 
             '20161020
            .items(PLCTAG_SLIT_MOTORE8_GestioneInternaSlittamento).Value = ListaMotori(MotoreElevatoreCaldo).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE8_Soglia1Slittamento).Value = ListaMotori(MotoreElevatoreCaldo).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE8_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreCaldo).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE8_Soglia2Slittamento).Value = ListaMotori(MotoreElevatoreCaldo).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE8_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreCaldo).TempoSoglia2Slittamento
            
            .items(PLCTAG_SLIT_MOTORE10_GestioneInternaSlittamento).Value = ListaMotori(MotoreElevatoreF1).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE10_Soglia1Slittamento).Value = ListaMotori(MotoreElevatoreF1).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE10_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreF1).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE10_Soglia2Slittamento).Value = ListaMotori(MotoreElevatoreF1).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE10_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreF1).TempoSoglia2Slittamento
            
            .items(PLCTAG_SLIT_MOTORE14_GestioneInternaSlittamento).Value = ListaMotori(MotoreElevatoreF2).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE14_Soglia1Slittamento).Value = ListaMotori(MotoreElevatoreF2).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE14_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreF2).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE14_Soglia2Slittamento).Value = ListaMotori(MotoreElevatoreF2).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE14_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreF2).TempoSoglia2Slittamento
            
            .items(PLCTAG_SLIT_MOTORE28_GestioneInternaSlittamento).Value = ListaMotori(MotoreElevatoreRiciclato).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE28_Soglia1Slittamento).Value = ListaMotori(MotoreElevatoreRiciclato).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE28_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreRiciclato).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE28_Soglia2Slittamento).Value = ListaMotori(MotoreElevatoreRiciclato).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE28_TempoSoglia1Slittamento).Value = ListaMotori(MotoreElevatoreRiciclato).TempoSoglia2Slittamento
            '20161020
            '20161129
            .items(PLCTAG_SLIT_MOTORE21_GestioneInternaSlittamento).Value = ListaMotori(MotoreNastroCollettore1).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE21_Soglia1Slittamento).Value = ListaMotori(MotoreNastroCollettore1).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE21_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroCollettore1).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE21_Soglia2Slittamento).Value = ListaMotori(MotoreNastroCollettore1).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE21_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroCollettore1).TempoSoglia2Slittamento
            
            .items(PLCTAG_SLIT_MOTORE24_GestioneInternaSlittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclato).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE24_Soglia1Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclato).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE24_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclato).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE24_Soglia2Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclato).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE24_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclato).TempoSoglia2Slittamento
            
            .items(PLCTAG_SLIT_MOTORE30_GestioneInternaSlittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE30_Soglia1Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE30_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE30_Soglia2Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE30_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).TempoSoglia2Slittamento

            .items(PLCTAG_SLIT_MOTORE32_GestioneInternaSlittamento).Value = ListaMotori(MotoreNastroLanciatore).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE32_Soglia1Slittamento).Value = ListaMotori(MotoreNastroLanciatore).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE32_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroLanciatore).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE32_Soglia2Slittamento).Value = ListaMotori(MotoreNastroLanciatore).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE32_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroLanciatore).TempoSoglia2Slittamento

            .items(PLCTAG_SLIT_MOTORE38_GestioneInternaSlittamento).Value = ListaMotori(MotoreNastroRapJolly).GestioneInternaSlittamento
            .items(PLCTAG_SLIT_MOTORE38_Soglia1Slittamento).Value = ListaMotori(MotoreNastroRapJolly).Soglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE38_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroRapJolly).TempoSoglia1Slittamento
            .items(PLCTAG_SLIT_MOTORE38_Soglia2Slittamento).Value = ListaMotori(MotoreNastroRapJolly).Soglia2Slittamento
            .items(PLCTAG_SLIT_MOTORE38_TempoSoglia1Slittamento).Value = ListaMotori(MotoreNastroRapJolly).TempoSoglia2Slittamento
            
            '20161129
        spread = PLCTAG_NM_MOTORE2_Amperometri_Presente - PLCTAG_NM_MOTORE1_Amperometri_Presente
        For indice = 0 To MAXNEWMOTORS - 1
            'Amperometro 1
            .items(PLCTAG_NM_MOTORE1_Amperometri_Presente + (spread * indice)).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).Inclusione, False)
            .items(PLCTAG_NM_MOTORE1_Amperometri_MaxOut + (spread * indice)).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).max, 0)
            .items(PLCTAG_NM_MOTORE1_Amperometri_LimMin + (spread * indice)).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).sogliaMin, 0)
            .items(PLCTAG_NM_MOTORE1_Amperometri_LimMax + (spread * indice)).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).sogliaMax, 0)
        Next indice
        
        spread = PLCTAG_NM_MOTORE_AmperometrAux2_Presente - PLCTAG_NM_MOTORE_AmperometrAux1_Presente
        For indice = MAXNEWMOTORS To MAXAMPEROMETRI - 1
            'Amperometro 2,3,4
            .items(PLCTAG_NM_MOTORE_AmperometrAux1_Presente + (spread * (indice - MAXNEWMOTORS))).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).Inclusione, False)
            .items(PLCTAG_NM_MOTORE_AmperometrAux1_ValMaxOut + (spread * (indice - MAXNEWMOTORS))).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).max, 0)
            .items(PLCTAG_NM_MOTORE_AmperometrAux1_ValLimMin + (spread * (indice - MAXNEWMOTORS))).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).sogliaMin, 0)
            .items(PLCTAG_NM_MOTORE_AmperometrAux1_ValLimMax + (spread * (indice - MAXNEWMOTORS))).Value = IIf(indice <= MAXAMPEROMETRI - 1, ListaAmperometri(indice).sogliaMax, 0)
        Next indice
        
        '20160915
        .items(PLCTAG_DB46_XTUA_DRW_Elevatore_Caldo).Value = ListaAmperometri(AmperometroElevatoreCaldo).XTUA
        .items(PLCTAG_DB46_XTUA_DRW_Elevatore_Ric).Value = ListaAmperometri(AmperometroElevatoreRiciclato).XTUA
        .items(PLCTAG_DB46_XTUA_DRW_Tamburo).Value = ListaAmperometri(AmperometroEssicatore_1).XTUA
        .items(PLCTAG_DB46_XTUA_DRW_Ventola_Bruc).Value = ListaAmperometri(AmperometroVentolaBruciatore).XTUA
        .items(PLCTAG_DB46_XTUA_DRW_Tamburo2).Value = ListaAmperometri(AmperometroEssicatore2_1).XTUA
        .items(PLCTAG_DB46_XTUA_DRW_Ventola_Bruc2).Value = ListaAmperometri(AmperometroVentolaBruciatore2).XTUA
        '

        'Predosaggio
        CP240.OPCData.items(PLCTAG_NM_NC1).Value = CInt(NumeroPredosatoriNastroC(0))
        CP240.OPCData.items(PLCTAG_NM_NC2).Value = CInt(NumeroPredosatoriNastroC(1))
        CP240.OPCData.items(PLCTAG_NM_NC3).Value = CInt(NumeroPredosatoriNastroC(4))
        CP240.OPCData.items(PLCTAG_NM_NCRIC).Value = CInt(NumeroPredosatoriNastroC(2))
        CP240.OPCData.items(PLCTAG_NM_NCRICFREDDO).Value = CInt(NumeroPredosatoriNastroC(3))
        '20161207
        Dim associazione As Long
        associazione = 0
        For indice = 0 To MAXPREDOSATORIRICICLATO - 1
            associazione = associazione + (IIf(ListaPredosatoriRic(indice).SuNastroJolly, 1, 0) * (2 ^ indice))
        Next indice
        associazione = associazione * (2 ^ 8)
        CP240.OPCData.items(PLCTAG_PRED_AssociazionePredRicAJolly).Value = associazione
        '20161207
        
'20150727
'        CP240.OPCData.items(PLCTAG_NM_PRED_Auto_Man).Value = False 'si parte in manuale
        If Not primoinvioparametriplc Then '20150727
            CP240.OPCData.items(PLCTAG_NM_PRED_Auto_Man).Value = False 'si parte in manuale
        End If
'
        
'20150708
        CP240.OPCData.items(PLCTAG_NM_FILLER1_EVAC_TIMEOUT).Value = CInt(TimeoutEvacuazioneFiller)  '20150108
'
        CP240.OPCData.items(PLCTAG_NM_FILLER1_EVAC_FORZ_FILTRODMR).Value = EvacuazioneForzataFiltroDMR
        CP240.OPCData.items(PLCTAG_NM_FILLER1_FILTRODMR).Value = InclusioneDMR
'
'20160920
        CP240.OPCData.items(PLCTAG_MOT_ESCLUDI_SPEGN_VAG).Value = EsclusioneSpegniVaglio
'
        'fine
        If (Not primotrasferimentoparametri) Then
            .items(PLCTAG_NM_MOTORI_TrasfParam).Value = True
            .items(PLCTAG_SelezioneF3).Value = False '20151218
            primotrasferimentoparametri = True
            CP240.tmrRicTrasNET(3).enabled = True '20150109
        End If
        'FINE
        
        '20161128
        .items(PLCTAG_GEST_FUMI_TAMB_Enable).Value = GestioneFumiTamburo.Inclusione
        CP240.FrameGestFumiTamburo.Visible = GestioneFumiTamburo.Inclusione
        If (GestioneFumiTamburo.Inclusione) Then
            .items(PLCTAG_GEST_FUMI_TAMB_Fondoscala_depr_vaglio).Value = GestioneFumiTamburo.Fondoscala_depr_vaglio
            .items(PLCTAG_GEST_FUMI_TAMB_Riscalatura_mod_fumi).Value = GestioneFumiTamburo.Riscalatura_mod_fumi_tamb
             If (Not ListaAmperometri(AmperometroElevatoreRiciclato).Inclusione) Then
                 CP240.FrameGestFumiTamburo.left = 860
             Else
                CP240.FrameGestFumiTamburo.left = 760
             End If
        End If
        GestioneFumiTamburo.Modulatore.min = 0
        GestioneFumiTamburo.Modulatore.max = GestioneFumiTamburo.Riscalatura_mod_fumi_tamb
        '20161128
        '20161130
        .items(PLCTAG_GEST_VEL_TAMB_Enable).Value = GestioneVelocitaTamburo.Inclusione
        '20170215
        '.items(PLCTAG_GEST_VEL_TAMB_Fondoscala_depr_vaglio).Value = GestioneVelocitaTamburo.MaxVelocita
        .items(PLCTAG_GEST_VEL_TAMB_Max_Vel_Perc).Value = GestioneVelocitaTamburo.MaxVelocita
        '
        CP240.Frame1(19).Visible = GestioneVelocitaTamburo.Inclusione
        GestioneVelocitaTamburo.Modulatore.min = 0
        GestioneVelocitaTamburo.Modulatore.max = GestioneVelocitaTamburo.MaxVelocita
        '20161130
    End With

    If (InclusioneSiloS7) Then
        Call SiloS7InviaParametri
    End If

    If (PlcSchiumato.Abilitazione) Then
        Call PlcSchiumatoInviaParametri
    End If
    
    primoinvioparametriplc = True '20150727
    
    Exit Sub
Errore:
    LogInserisci True, "CNF-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20160104
'Public Sub StampaTagListaCompleta()
'
'    Dim i As Integer
'    Dim nomeFile As String
'
'On Error GoTo Errore
'
'    nomeFile = LogPath + "StampaTagPLC_MAIN.txt"
'    Open nomeFile For Output As #79
'    For i = 0 To CP240.OPCData.items.Count - 1
'        Print #79, Format(i, "0000") + " - " + CP240.OPCData.items(i).ItemID
'    Next i
'    Close #79
'
'    nomeFile = LogPath + "StampaTagPLC_CIST.txt"
'    Open nomeFile For Output As #79
'    For i = 0 To CP240.OPCDataCisterne.items.Count - 1
'        Print #79, Format(i + 1, "0000") + " - " + CP240.OPCDataCisterne.items(i).ItemID
'    Next i
'    Close #79
'
'    nomeFile = LogPath + "StampaTagPLC_SCHIUMATO.txt"
'    Open nomeFile For Output As #79
'    For i = 0 To CP240.OPCDataSchiumato.items.Count - 1
'        Print #79, Format(i, "0000") + " - " + CP240.OPCDataSchiumato.items(i).ItemID
'    Next i
'    Close #79
'
'    Exit Sub
'
'Errore:
'    LogInserisci True, "CNF-002", CStr(Err.Number) + " [" + Err.description + "]"
'
'End Sub
'
