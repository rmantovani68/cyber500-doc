Attribute VB_Name = "GestioneCisternePLC"

'**************************************************************************************************************************
'CODIFICA ALLARMI CISTERNE
'-------------------------------------------------------------------------------------------------------------------------
'Codifica allarme cisterne
'-------------------------------------------------------------------------------------------------------------------------
'Numero   | Bit | Descrizione
'---------+-----+-------------------------------
'Allarme1 | (1) | livello minimo
'Allarme2 | (2) | livello massimo
'Allarme3 | (4) | temperatura minima
'Allarme4 | (8) | temperatura massima
'Allarme5 |(16) | sicurezza meccanica
'Allarme6 |(32) | una valvola in allarme


'-------------------------------------------------------------------------------------------------------------------------
'Codifica allarme valvole
'-------------------------------------------------------------------------------------------------------------------------
'Numero   | Bit | Descrizione
'---------+-----+-------------------------------
'Allarme1 | (1) | entrambi i finecorsa eccitati
'Allarme2 | (2) | nessun finecorsa eccitato
'Allarme3 | (4) | timeout scambio apertura
'Allarme4 | (8) | timeout scambio chiusura


'-------------------------------------------------------------------------------------------------------------------------
'Codifica allarmi generali
'-------------------------------------------------------------------------------------------------------------------------
'Numero   |  Bit | Descrizione
'---------+------+-------------------------------
'Allarme23| 32768| temperatura pompa di carico sotto la soglia minima
'Allarme24|  1   | timeout comunicazione con il pc
'Allarme25|  2   | errore nei parametri dell'impianto (si azzera solo all'avvio)
'Allarme26|  4   | disponibile
'Allarme27|  8   | e' aperta piu' di una valvola di mandata
'Allarme28|  16  | e' aperta piu' di una valvola di carico
'Allarme29|  32  | valvole non ok con pompa circolo in moto
'Allarme30|  64  | valvola manuale di carico in posizione errata
'**************************************************************************************************************************

Option Explicit


Public Type OggettoCisterna

    CisternaSelezionata As Boolean
'-------------------------------------------------------------------------------------------------
'dati grafici della cisterna
'-------------------------------------------------------------------------------------------------
    StatoValvolaRitorno As StatoValvola
    StatoValvolaMandata As StatoValvola
    StatoValvolaAspirazione As StatoValvola
'-------------------------------------------------------------------------------------------------
'parametri generali
'-------------------------------------------------------------------------------------------------
    TipoLivello As Boolean '0= continuo, 1 = con finecorsa
    BloccoValvoleBassaTemperatura As Boolean    '1= blocco valvole
    LminUnitaAnTemperatura As Integer 'limite minimo in unita della scheda analogica
    LMaxUnitaAnTemperatura As Integer 'limite massimo in unita della scheda analogica
    LminUnitaAnLivello As Integer 'limite minimo in unita della scheda analogica
    LMaxUnitaAnLivello As Integer 'limite massimo in unita della scheda analogica
    DensitaLiquido As Single 'densita' del liquido contenuto nella cisterna a 15 gradi C
    LminGradiTemperatura As Integer 'limite minimo in gradi C della temperatura
    LMaxGradiTemperatura As Integer 'limite massimo in gradi C della temperatura
    LminTonLivello As Integer 'limite minimo in tonnellate del livello
    LMaxTonLivello As Integer 'limite massimo in tonnellate del livello
    SogliaAllarmeTempMin As Single 'soglia dell'allarme di minima temperatura in gradi C
    SogliaAllarmeTempMax As Single 'soglia dell'allarme di massima temperatura in gradi C
    SogliaAllarmeLivMin As Single 'soglia dell'allarme di minimo livello in ton
    SogliaAllarmeLivMax As Single 'soglia dell'allarme di massimo livello in ton
    ZonaMortaAllLiv As Single 'zona morta dell'allarme del livello
    ZonaMortaAllTemp As Single 'zona morta dell'allarme della temperatura
    LivMinimoRaggiunto As Boolean 'stato del finecorsa del livello minimo
    LivMassimoRaggiunto As Boolean 'stato del finecorsa del livello massimo
    SicurezzaMeccanicaLivello As Boolean 'SicurezzaMeccanicaLivello
    ValLivelloPerc As Single 'lettura del livello espresso in percentuale
    ValLivelloTon As Single 'lettura del livello espresso in tonnellate
    ValTemperatura As Single 'lettura della temperatura espressa in tonnellate
    CodificaAllarmeCisterna As Long 'allarme cisterna codificato in binario
    NumeroValvoleCisterna As Integer 'numero di valvole presenti nella cisterna
'-------------------------------------------------------------------------------------------------
'valvola di mandata
'-------------------------------------------------------------------------------------------------
    ComandoManAperturaMandata As Boolean 'comando di apertura della valvola, attivo in funzionamento manuale
    ComandoManChiusuraMandata As Boolean 'comando di chiusura della valvola, attivo in funzionamento manuale
    TimeoutAperturaValvMandata As Long 'tempo massimo per l'apertura della valvola in secondi
    TimeoutChiusuraValvMandata As Long 'tempo massimo per la chiusura della valvola in secondi
    TempoTriggFCMandata As Long 'tempo di stabilizzazione (anti rimbalzo) del fincorsa
    ValvolaApertaMandata As Boolean 'lettura filtrata del fincorsa di aperto
    ValvolaChiusaMandata As Boolean 'lettura filtrata del fincorsa di chiuso
    CodiceAllMandata As Long 'allarme valvola codificato in binario
    TempoImpiegatoAperturaMandata As Long 'tempo impiegato dalla valvola per aprirsi
    TempoImpiegatoChiusuraMandata As Long 'tempo impiegato dalla valvola per chiudersi
    NumeroApertureMandata As Long 'numero di aperture della valvola
    NumeroChiusureMandata As Long 'numero di chiusure della valvola
'-------------------------------------------------------------------------------------------------
'valvola di ritorno
'-------------------------------------------------------------------------------------------------
    ComandoManAperturaRitorno As Boolean 'comando di apertura della valvola, attivo in funzionamento manuale
    ComandoManChiusuraRitorno As Boolean 'comando di chiusura della valvola, attivo in funzionamento manuale
    TimeoutAperturaValvRitorno As Long 'tempo massimo per l'apertura della valvola in secondi
    TimeoutChiusuraValvRitorno As Long 'tempo massimo per la chiusura della valvola in secondi
    TempoTriggFCRitorno As Long 'tempo di stabilizzazione (anti rimbalzo) del fincorsa
    ValvolaApertaRitorno As Boolean 'lettura filtrata del fincorsa di aperto
    ValvolaChiusaRitorno As Boolean 'lettura filtrata del fincorsa di chiuso
    CodiceAllRitorno As Long 'allarme valvola codificato in binario
    TempoImpiegatoAperturaRitorno As Long 'tempo impiegato dalla valvola per aprirsi
    TempoImpiegatoChiusuraRitorno As Long 'tempo impiegato dalla valvola per chiudersi
    NumeroApertureRitorno As Long 'numero di aperture della valvola
    NumeroChiusureRitorno As Long 'numero di chiusure della valvola
'-------------------------------------------------------------------------------------------------
'valvola di carico
'-------------------------------------------------------------------------------------------------
    ComandoManAperturaCarico As Boolean 'comando di apertura della valvola, attivo in funzionamento manuale
    ComandoManChiusuraCarico As Boolean 'comando di chiusura della valvola, attivo in funzionamento manuale
    TimeoutAperturaValvCarico As Long 'tempo massimo per l'apertura della valvola in secondi
    TimeoutChiusuraValvCarico As Long 'tempo massimo per la chiusura della valvola in secondi
    TempoTriggFCCarico As Long 'tempo di stabilizzazione (anti rimbalzo) del fincorsa
    ValvolaApertaCarico As Boolean 'lettura filtrata del fincorsa di aperto
    ValvolaChiusaCarico As Boolean 'lettura filtrata del fincorsa di chiuso
    CodiceAllCarico As Long 'allarme valvola codificato in binario
    TempoImpiegatoAperturaCarico As Long 'tempo impiegato dalla valvola per aprirsi
    TempoImpiegatoChiusuraCarico As Long 'tempo impiegato dalla valvola per chiudersi
    NumeroApertureCarico As Long 'numero di aperture della valvola
    NumeroChiusureCarico As Long 'numero di chiusure della valvola
'-------------------------------------------------------------------------------------------------
'valvola ausiliaria
'-------------------------------------------------------------------------------------------------
    ComandoManAperturaAux As Boolean 'comando di apertura della valvola, attivo in funzionamento manuale
    ComandoManChiusuraAux As Boolean 'comando di chiusura della valvola, attivo in funzionamento manuale
    TimeoutAperturaValvAux As Long 'tempo massimo per l'apertura della valvola in secondi
    TimeoutChiusuraValvAux As Long 'tempo massimo per la chiusura della valvola in secondi
    TempoTriggFCAux As Long 'tempo di stabilizzazione (anti rimbalzo) del fincorsa
    ValvolaApertaAux As Boolean 'lettura filtrata del fincorsa di aperto
    ValvolaChiusaAux As Boolean 'lettura filtrata del fincorsa di chiuso
    CodiceAllAux As Long 'allarme valvola codificato in binario
    TempoImpiegatoAperturaAux As Long 'tempo impiegato dalla valvola per aprirsi
    TempoImpiegatoChiusuraAux As Long 'tempo impiegato dalla valvola per chiudersi
    NumeroApertureAux As Long 'numero di aperture della valvola
    NumeroChiusureAux As Long 'numero di chiusure della valvola

    InversioneComandoValvola1 As Boolean
    InversioneComandoValvola2 As Boolean
    InversioneComandoValvola3 As Boolean
    InversioneComandoValvola4 As Boolean

    InclusioneValvolaMandata As Boolean
    InclusioneValvolaRitorno As Boolean
    InclusioneValvolaCarico As Boolean
    InclusioneValvolaAux As Boolean
    CisternaOrizzontale As Boolean
    Diametro As Double
    Lunghezza As Double
    Agitatore As Boolean            'Indica se è presente l'agitatore per la cisterna in questione
    AgitatoreComando As Boolean
    AgitatoreRitorno As Boolean
End Type

Public Type OggettoDBScambioDatiCisterneVecchiaStruttura
    AbilitazioneGestioneMan As Boolean '=1 Controllo diretto delle valvole comandato da pc
    StopCambioCistLavoro As Boolean '=1 Arresta l'operazione in corso
    StartCambioCistLavoro As Boolean '=1 Esegui l'operazione impostata
    Watchdog As Boolean '
    AccettaErrore As Boolean
    ForzaOperazioniSuAllarme As Boolean '=1 Esegue comunque un'operazione su cisterna anche se e' in allarme
    NumeroCisternePresenti As Integer 'Numero di cisterne presenti nell'impianto
    NrCisternaDefault As Integer 'Nr cisterna la cui valvola di ritorno deve rimanere aperta a riposo
    CodiceOperazione As Integer 'Tipo di operazione da eseguire
    CisternaNuovaSelezione As Integer 'Numero cisterna da selezionare
    CisternaSelezioneAttuale As Integer 'Numero cisterna attualmente selezionata
    CisternaSorgenteGruppo1 As Integer 'Cisterna sorgente gruppo 2
    CisternaDestinazGruppo1 As Integer 'Cisterna destinazione gruppo 2
    TonDaTrasferireGruppo1 As Single 'Quantita' da trasferire gruppo 1
    TonDaTrasferireGruppo2 As Single 'Quantita' da trasferire gruppo 2
    SelezioneCistPerOperazione As Integer 'Cisterna da utilizzare per eseguire un'operazione
    StartCambioCistCarico As Boolean 'Esegue il cambio cisterna
    StopCambioCistCarico As Boolean 'Arresta il cambio cisterna
    OperazioneInCorsoCist As Integer 'Codice dell'operazione in esecuzione sul plc
    StatoStartOperazione As Boolean 'Legge se l'operazione lanciata e' in esecuzione
    StatoStopOperazione As Boolean 'Legge se l'operazione lanciata e' stata arrestata
    EseguiTaraCisterna As Boolean 'Esegue l'azzeramento del livello della cisterna
    NrCisternaAzzeramentoTara As Integer 'Indica in quale cisterna va eseguita la tara
    ValoreTemperaturaEmulsione As Single 'Temperatura cisterna emulsione
    CodificaAllarmiGenerali(0 To 52) As Boolean 'allarmi generali 53 bit
    AllarmeGeneraleAttivo As Boolean
    ParametroNrCisternaValvSeparaz As Integer 'parametro per indicare il numero della cisterna dopo la quale si trova la valvola di separazione
    UltimaCisternaUtilizzata As Integer 'memoria ultima cisterna utilizzata (SOLA LETTURA!!!)
    SelezioneCistOperazioneParticolare As Integer
    CodiceOperazionePompaCarico As Integer
    SelezioneCistPerOperazionePompaCarico As Integer

End Type

Public Type OggettoDBScambioDatiCisterne
	'-------------------------------------------------------------------------------------------------
	'Impostazioni e parametri generici
	'-------------------------------------------------------------------------------------------------
    GestManuale As Boolean                      '=1 Controllo diretto delle valvole comandato da pc              'EX AbilitazioneGestioneMan
    NrCisternaAzzeramentoTara As Integer        'Indica in quale cisterna va eseguita la tara
    ParametroNrCisternaValvSeparaz As Integer   'parametro per indicare il numero della cisterna dopo la quale si trova la valvola di separazione
    Watchdog As Boolean '
    AccettaErrore As Boolean
    ForzaOperazioniSuAllarme As Boolean         '= 1 Esegue comunque un'operazione su cisterna anche se e' in allarme
    NumeroCisternePresenti As Integer           'Numero di cisterne presenti nell'impianto
    NrCisternaDefault As Integer                'Nr cisterna la cui valvola di ritorno deve rimanere aperta a riposo
    CisternaSelezioneAttuale As Integer         'Numero cisterna attualmente selezionata           'INUTILE per il momento
	'-------------------------------------------------------------------------------------------------
	'Comandi
	'-------------------------------------------------------------------------------------------------
    CodiceOperazioneCarico As Integer               'Tipo di operazione da eseguire con la pompa di carico
    CodiceOperazioneAlimentazione As Integer        'Tipo di operazione da eseguire con la pompa di alimentazione
    SelCistMandataPompaCarico As Integer            'Cisterna selezionata come mandata in operazioni con pompa di carico
    SelCistCaricoPompaCarico As Integer             'Cisterna selezionata come ritorno in operazioni con pompa di carico
    SelCistMandataPompaAlimentaz As Integer         'Cisterna selezionata come mandata in operazioni con pompa di alimentazione
    SelCistCaricoPompaAlimentaz As Integer          'Cisterna selezionata come ritorno in operazioni con pompa di alimentazione
    SelCistAlimentazioneTorre As Integer            'Cisterna selezionata come mandata alimentazione torre con pompa di alimentazione
    EseguiTaraCisterna As Boolean                   'Esegue l'azzeramento del livello della cisterna
    StartOperazioneCisterne As Boolean              'Invia al PLC il comando di start operazione
    StopOperazioneCisterne As Boolean               'Invia al PLC il comando di stop operazione
    OperazioneCaricoARegime As Boolean              'Flag che mi dice che dopo aver dato lo start all'operazione con pompa di carico questa è effettivamente partita (STEP102 nel PLC)
    OperazioneAlimentazioneARegime As Boolean       'Flag che mi dice che dopo aver dato lo start all'operazione con pompa di alimentazione questa è effettivamente partita (STEP102 nel PLC)
    OperazioneAlimentazioneTorreInAttesa As Boolean 'Flag che mi dice che l'operazione di alimentazione non è in corso perchè manca la pompa di circolazione
    OperazioneAlimentazioneTorreARegime As Boolean  'Flag che mi dice che l'operazione di alimentazione torre è in corso (Operazione particolare -> funziona con più selezione dei combo -> STEP3 nel PLC)
    StatoErroreOperazioniCisterne As Boolean        'Flag che mi dice che l'impianto è nello STEP0 di errore
    OperazioneDoppiaRifiutata As Boolean            'Flag che mi dice che la combinazione delle operazioni scelte con le due pompe non è consentita
    OperazioneParticolareRifiutata As Boolean       'Flag che mi dice che un'operazione particolare è stata rifiutata (In SION è operazione su cisterna 5 rifiutata)
    RidottoSetSelezioneCisternaBitumePCL1 As Integer       '20150505: imposta la selezione cisterna da pc con gestione ridotta
    RidottoTempoTimeoutCambioCisternaPCL1 As Integer    '20150505: imposta il tempo di timeout selezione cisterna da pc con gestione ridotta
    RidottoTimeoutSelezionePCL1 As Boolean              '20150505: stato di allarme timeout selezione cisterna da pc con gestione ridotta
    RidottoAttesaSelezionePCL1 As Boolean               '20150505: stato di attesa selezione cisterna da pc con gestione ridotta
    RidottoSelezioneAttualeCisternaBitumePCL1 As Integer       '20150505: selezione cisterna attuale con gestione ridotta
    RidottoSetSelezioneCisternaBitumePCL2 As Integer       '20150505: imposta la selezione cisterna da pc con gestione ridotta
    RidottoTempoTimeoutCambioCisternaPCL2 As Integer    '20150505: imposta il tempo di timeout selezione cisterna da pc con gestione ridotta
    RidottoTimeoutSelezionePCL2 As Boolean              '20150505: stato di allarme timeout selezione cisterna da pc con gestione ridotta
    RidottoAttesaSelezionePCL2 As Boolean               '20150505: stato di attesa selezione cisterna da pc con gestione ridotta
    RidottoSelezioneAttualeCisternaBitumePCL2 As Integer       '20150505: selezione cisterna attuale con gestione ridotta
    RidottoNumeroCistBitSuPCL1 As Integer               '20150505: numero di cisterne su PCL1
    RidottoNumeroCistBitSuPCL2 As Integer               '20150505: numero di cisterne su PCL2
End Type


'------------------------------------------------------------------------------------------------
'Definizioni degli indici delle immagini
'------------------------------------------------------------------------------------------------
'T5
Public Const cstIndiceLabelTempTuboCaricoLegante = -1 '20161230 198 'indice della casella per la temperatura della valvola di carico
'************************************************************************************************

Public CisternaLegante(1 To NumMaxCisterneImpianto) As OggettoCisterna
Public DBScambioDatiCisterneBitume As OggettoDBScambioDatiCisterne
Public DBScambioDatiCisterneEmulsione As OggettoDBScambioDatiCisterneVecchiaStruttura
Public DBScambioDatiCisterneCombustibile As OggettoDBScambioDatiCisterneVecchiaStruttura

'T5
Public SondaTuboCaricoLegante As Single 'sonda di temperatura nel tubo fra la valvola di carico e la pompa
'

'Public CisternaSelezionataCarico As Integer

Public ConsensoStartPCL3 As Boolean
'Public ValvolaManualeSeparazioneAlimentazioneOpen As Boolean

'Public CodiceOperazioneInCorsoBitume As Integer
Public MemoriaStatoValvolaSeparazione As Boolean

Public Enum TipoValvolaEnum
    automaticaorizzontale
    automaticaverticale
    manualeorizzontale
    manualeverticale
    trevieautomaticaorizzontale
    trevieautomaticaverticale
    treviemanualeorizzontale
    treviemanualeverticale
End Enum

Private PlcInDigitali_Fatta As Boolean
Private plcInAnalogici_Fatta As Boolean
Private TempoRinfrescoValvoleVistaCisterne As Long

Public memoriaOperazioneRifiutata As Boolean
Public memoriaOperazioneParticolareRifiutata As Boolean

'
Public Sub AggiornaGraficaStatoCisternaCombust(cisterna As Integer)

    On Error GoTo Errore

    'verifica presenza di allarme di temperatura minima (4)
    'verifica presenza di allarme di temperatura massima (8)
    If ( _
        (CisternaLegante(cisterna + 20).CodificaAllarmeCisterna And 4) = 4 Or _
        (CisternaLegante(cisterna + 20).CodificaAllarmeCisterna And 8) = 8 _
    ) Then
        CP240.PctCistTemperatura(200).Visible = Not CP240.PctCistTemperatura(200).Visible
    Else
        CP240.PctCistTemperatura(200).Visible = False
    End If

    'verifica presenza di allarme di livello massimo
    If (CisternaLegante(cisterna + 20).CodificaAllarmeCisterna And 18) <> 0 Then
        CP240.PctCistLivello(200).Visible = Not CP240.PctCistLivello(200).Visible
        CP240.PrbCistLivello(200).FillColor = vbRed
    Else
        CP240.PctCistLivello(200).Visible = False
        CP240.PrbCistLivello(200).FillColor = vbBlue
    End If

    Exit Sub

Errore:
    LogInserisci True, "CST-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AggiornaGraficaStatoCisterna(cisterna As Integer)

    On Error GoTo Errore

    'verifica presenza di allarme di temperatura minima (4)
    'verifica presenza di allarme di temperatura massima (8)
    
'20150505
'    If ( _
'        (CisternaLegante(cisterna + 1).CodificaAllarmeCisterna And 4) = 4 Or _
'        (CisternaLegante(cisterna + 1).CodificaAllarmeCisterna And 8) = 8 _
'    ) Then
'
    If ( _
        (CisternaLegante(cisterna + 1).CodificaAllarmeCisterna And 4) = 4 Or _
        (CisternaLegante(cisterna + 1).CodificaAllarmeCisterna And 8) = 8 _
    ) And CistGestione.InclusioneTemperatura Then
'
        CP240.PctCistTemperatura(cisterna).Visible = Not CP240.PctCistTemperatura(cisterna).Visible
    Else
        CP240.PctCistTemperatura(cisterna).Visible = False
    End If

    'verifica presenza di allarme di livello massimo
    If (CisternaLegante(cisterna + 1).CodificaAllarmeCisterna And 18) <> 0 Then
        CP240.PctCistLivello(cisterna).Visible = Not CP240.PctCistLivello(cisterna).Visible
        CP240.PrbCistLivello(cisterna).FillColor = vbRed
    Else
        CP240.PctCistLivello(cisterna).Visible = False
        CP240.PrbCistLivello(cisterna).FillColor = vbBlue
    End If
        
'------------------------------------------------------------------------------------------------------------------------------
'Aggiorna le valvole
'------------------------------------------------------------------------------------------------------------------------------

    If CisternaLegante(cisterna + 1).NumeroValvoleCisterna = 4 Then
        If CisternaLegante(cisterna + 1).ValvolaApertaAux Then
            'MAIO CP240.imgValvolaCisterne(cstIndiceImmagineValvolaAuxT5).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
        End If
        If CisternaLegante(cisterna + 1).ValvolaChiusaAux Then
            'MAIO CP240.imgValvolaCisterne(cstIndiceImmagineValvolaAuxT5).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)
        End If
        If CisternaLegante(cisterna + 1).CodiceAllAux <> 0 Then
            'MAIO CP240.imgValvolaCisterne(cstIndiceImmagineValvolaAuxT5).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
        End If
    End If

    Exit Sub

Errore:
    LogInserisci True, "CST-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ScriviDatiPLCCisterne()
	Dim i As Integer
	Dim offset As Integer
	Dim spread As Integer


	On Error GoTo Errore:

    If (CistGestione.Gestione <> GestionePLC) Then
        Exit Sub
    End If
    
    If DEMO_VERSION Then
        Exit Sub
    End If
    
    With CP240.OPCDataCisterne

        '20160218
        'If Not .IsConnected Or .items.Count = 0 Then
        If (Not IsPlcConnected(CP240.OPCDataCisterne)) Then
        '
            Exit Sub
        End If

        'Scrive continuamente 1 nel watchdog per tenere su la comunicazione. Il PLC lo azzerera' ad ogni ciclo.
        DBScambioDatiCisterneBitume.Watchdog = True
        .items.item(CistTAG_Bitume_Watchdog).Value = DBScambioDatiCisterneBitume.Watchdog
        .items.item(CistTAG_Bitume_AckAllarme).Value = DBScambioDatiCisterneBitume.AccettaErrore
        .items.item(CistTAG_Bitume_NumeroCisternaDefault).Value = DBScambioDatiCisterneBitume.NrCisternaDefault
        .items.item(CistTAG_Bitume_CMD_AzzeraTara).Value = DBScambioDatiCisterneBitume.EseguiTaraCisterna
        .items.item(CistTAG_Emulsione_NumeroCisterne).Value = DBScambioDatiCisterneEmulsione.NumeroCisternePresenti

        If DBScambioDatiCisterneEmulsione.NumeroCisternePresenti > 0 Then
            .items.item(CistTAG_Emulsione_NumeroCisternaDefault).Value = DBScambioDatiCisterneEmulsione.NrCisternaDefault
            .items.item(CistTAG_Emulsione_CMD_AzzeraTara).Value = DBScambioDatiCisterneEmulsione.EseguiTaraCisterna
        End If

        .items.item(CistTAG_Combustibile_NumeroCisterne).Value = DBScambioDatiCisterneCombustibile.NumeroCisternePresenti

        spread = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1

        .items.item(CistTAG_Bitume_DI_PompaCircLegante).Value = ListaMotori(MotorePCL).ritorno
        .items.item(CistTAG_Bitume_DI_PompaCircLegante2).Value = ListaMotori(MotorePCL2).ritorno
        .items.item(CistTAG_Bitume_DI_Compressore).Value = ListaMotori(MotoreCompressore).ritorno
        '.items.item(CistTAG_Emulsione_DI_PompaCircEmulsione).Value = CP240.OPCData.items(PLCTAG_DI_RitMotore23).Value
        .items.item(CistTAG_Emulsione_DI_PompaCircEmulsione).Value = ListaMotori(MotorePCL3).ritorno

        For i = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
            offset = (i - 1) * spread
            .items.item(offset + CistTAG_Bitume_Cisterna1_InclusioneAgitatore).Value = CisternaLegante(i).Agitatore
        Next i
        
        .SOUpdate

    End With

    Exit Sub
Errore:
    LogInserisci True, "CST-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20150505
Public Sub ScriviDatiPLCCisterneRid()
	Dim i As Integer
	Dim offset As Integer
	Dim spread As Integer

	On Error GoTo Errore:

    If (CistGestione.Gestione <> GestioneSemplificata) Then
        Exit Sub
    End If
    
    If DEMO_VERSION Then
        Exit Sub
    End If
    
    With CP240.OPCData

        If Not .IsConnected Or .items.count = 0 Then
            Exit Sub
        End If

'20151028
'        If SbloccoSelezioneCisternaRid Then
        If SbloccoSelezioneCisternaRid And CistGestione.InclusioneComandi Then
'
            .items.item(CistRidTAG_Selezione_Cisterna_Bitume_PCL1).Value = DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL1
            .items.item(CistRidTAG_Selezione_Cisterna_Bitume_PCL2).Value = DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL2
        End If
       
    End With

    Exit Sub
    
Errore:
    LogInserisci True, "CST-014", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'

Private Sub SingolaCisternaInviaParametri(ByRef cisterna As OggettoCisterna, cisternaOffset As Integer)
    
    If DEMO_VERSION Then
        Exit Sub
    End If
    
    With CP240.OPCDataCisterne
    
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TipoLivello - CistTAG_CisternaBitume1)).Value = cisterna.TipoLivello
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempUnitaLimiteInf - CistTAG_CisternaBitume1)).Value = cisterna.LminUnitaAnTemperatura
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempUnitaLimitesup - CistTAG_CisternaBitume1)).Value = cisterna.LMaxUnitaAnTemperatura
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloUnitaLimiteInf - CistTAG_CisternaBitume1)).Value = cisterna.LminUnitaAnLivello
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloUnitaLimiteSup - CistTAG_CisternaBitume1)).Value = cisterna.LMaxUnitaAnLivello
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_Densita - CistTAG_CisternaBitume1)).Value = cisterna.DensitaLiquido
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempGradiLimiteInf - CistTAG_CisternaBitume1)).Value = cisterna.LminGradiTemperatura
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempGradiLimiteSup - CistTAG_CisternaBitume1)).Value = cisterna.LMaxGradiTemperatura
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloTonLimiteInf - CistTAG_CisternaBitume1)).Value = cisterna.LminTonLivello
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloTonLimiteSup - CistTAG_CisternaBitume1)).Value = cisterna.LMaxTonLivello
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempGradiAllarmeMin - CistTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeTempMin
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempGradiAllarmeMax - CistTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeTempMax
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloTonAllarmeMin - CistTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeLivMin
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloTonAllarmeMax - CistTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeLivMax
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LivelloTonAllarmeZonaMorta - CistTAG_CisternaBitume1)).Value = cisterna.ZonaMortaAllLiv
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_TempGradiAllarmeZonaMorta - CistTAG_CisternaBitume1)).Value = cisterna.ZonaMortaAllTemp
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutOpen - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvMandata)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutClose - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvMandata)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita1TempoAntirimbalzoFC - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCMandata)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutOpen - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvRitorno)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutClose - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvRitorno)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata1TempoAntirimbalzoFC - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCRitorno)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutOpen - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvCarico)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutClose - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvCarico)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita2TempoAntirimbalzoFC - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCCarico)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutOpen - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvAux)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutClose - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvAux)
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata2TempoAntirimbalzoFC - CistTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCAux)
'       .Items(cisternaOffset + (CistTAG_Bitume_Cisterna1_NumeroValvolePresenti - CistTAG_CisternaBitume1)).value = cisterna.NumeroValvoleCisterna
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita1InverteComando - CistTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola1
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata1InverteComando - CistTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola2
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvUscita2InverteComando - CistTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola3
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_ValvEntrata2InverteComando - CistTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola4
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_AbilitaOrizzontale - CistTAG_CisternaBitume1)).Value = cisterna.CisternaOrizzontale
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_DiametroMm - CistTAG_CisternaBitume1)).Value = cisterna.Diametro
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_LunghezzaMm - CistTAG_CisternaBitume1)).Value = cisterna.Lunghezza
        .items(cisternaOffset + (CistTAG_Bitume_Cisterna1_InclusioneAgitatore - CistTAG_CisternaBitume1)).Value = cisterna.Agitatore

    End With

End Sub
'

'20150505
Private Sub SingolaCisternaRidInviaParametri(ByRef cisterna As OggettoCisterna, cisternaOffset As Integer)
    
    If DEMO_VERSION Then
        Exit Sub
    End If
    
    With CP240.OPCData
    
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TipoLivello - CistRidTAG_CisternaBitume1)).Value = cisterna.TipoLivello
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempUnitaLimiteInf - CistRidTAG_CisternaBitume1)).Value = cisterna.LminUnitaAnTemperatura
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempUnitaLimitesup - CistRidTAG_CisternaBitume1)).Value = cisterna.LMaxUnitaAnTemperatura
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloUnitaLimiteInf - CistRidTAG_CisternaBitume1)).Value = cisterna.LminUnitaAnLivello
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloUnitaLimiteSup - CistRidTAG_CisternaBitume1)).Value = cisterna.LMaxUnitaAnLivello
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_Densita - CistRidTAG_CisternaBitume1)).Value = cisterna.DensitaLiquido
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempGradiLimiteInf - CistRidTAG_CisternaBitume1)).Value = cisterna.LminGradiTemperatura
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempGradiLimiteSup - CistRidTAG_CisternaBitume1)).Value = cisterna.LMaxGradiTemperatura
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloTonLimiteInf - CistRidTAG_CisternaBitume1)).Value = cisterna.LminTonLivello
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloTonLimiteSup - CistRidTAG_CisternaBitume1)).Value = cisterna.LMaxTonLivello
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempGradiAllarmeMin - CistRidTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeTempMin
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempGradiAllarmeMax - CistRidTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeTempMax
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloTonAllarmeMin - CistRidTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeLivMin
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloTonAllarmeMax - CistRidTAG_CisternaBitume1)).Value = cisterna.SogliaAllarmeLivMax
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LivelloTonAllarmeZonaMorta - CistRidTAG_CisternaBitume1)).Value = cisterna.ZonaMortaAllLiv
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_TempGradiAllarmeZonaMorta - CistRidTAG_CisternaBitume1)).Value = cisterna.ZonaMortaAllTemp
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutOpen - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvMandata)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita1TempoTimeOutClose - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvMandata)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita1TempoAntirimbalzoFC - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCMandata)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutOpen - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvRitorno)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata1TempoTimeOutClose - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvRitorno)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata1TempoAntirimbalzoFC - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCRitorno)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutOpen - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvCarico)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita2TempoTimeOutClose - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvCarico)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita2TempoAntirimbalzoFC - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCCarico)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutOpen - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutAperturaValvAux)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata2TempoTimeOutClose - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TimeoutChiusuraValvAux)
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata2TempoAntirimbalzoFC - CistRidTAG_CisternaBitume1)).Value = ConvertiTempoMilliSECtoS7(cisterna.TempoTriggFCAux)
'       .Items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_NumeroValvolePresenti - CistRidTAG_CisternaBitume1)).value = cisterna.NumeroValvoleCisterna
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita1InverteComando - CistRidTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola1
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata1InverteComando - CistRidTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola2
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvUscita2InverteComando - CistRidTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola3
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_ValvEntrata2InverteComando - CistRidTAG_CisternaBitume1)).Value = cisterna.InversioneComandoValvola4
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_AbilitaOrizzontale - CistRidTAG_CisternaBitume1)).Value = cisterna.CisternaOrizzontale
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_DiametroMm - CistRidTAG_CisternaBitume1)).Value = cisterna.Diametro
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_LunghezzaMm - CistRidTAG_CisternaBitume1)).Value = cisterna.Lunghezza
        .items(cisternaOffset + (CistRidTAG_Bitume_Cisterna1_InclusioneAgitatore - CistRidTAG_CisternaBitume1)).Value = cisterna.Agitatore

    End With

End Sub

'

Public Sub CisterneInviaParametri()

	Dim offset As Integer
	Dim spread As Integer
	Dim cisterna As Integer

		On Error GoTo Errore
		
		If DEMO_VERSION Then
			Exit Sub
		End If
		
	'20150505
		If (CistGestione.Gestione = GestioneSemplificata) Then

			'20160218
			'If CP240.OPCData.IsConnected And (CP240.OPCData.items.Count > 0) Then
			If (IsPlcConnected(CP240.OPCData)) Then
			'
		
				spread = CistRidTAG_CisternaBitume2 - CistRidTAG_CisternaBitume1
				
				For cisterna = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
					offset = (cisterna - 1) * spread
					Call SingolaCisternaRidInviaParametri(CisternaLegante(cisterna), CistRidTAG_CisternaBitume1 + offset)
				Next cisterna
				
				'20151027
				'Tempo fisso in secondi
				DBScambioDatiCisterneBitume.RidottoTempoTimeoutCambioCisternaPCL1 = 30
				DBScambioDatiCisterneBitume.RidottoTempoTimeoutCambioCisternaPCL2 = 30
				'
				
				CP240.OPCData.items.item(CistRidTAG_Tempo_Timeout_Cambio_Cisterna_PCL1).Value = DBScambioDatiCisterneBitume.RidottoTempoTimeoutCambioCisternaPCL1
				CP240.OPCData.items.item(CistRidTAG_Tempo_Timeout_Cambio_Cisterna_PCL2).Value = DBScambioDatiCisterneBitume.RidottoTempoTimeoutCambioCisternaPCL2
			End If
			
			Exit Sub
		End If
	'
		
		If (CistGestione.Gestione <> GestionePLC) Then
			Exit Sub
		End If

		'2016218
		'If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.Count = 0 Then
		If (Not IsPlcConnected(CP240.OPCDataCisterne)) Then
		'
			Exit Sub
		End If
		
		
		CP240.OPCDataCisterne.items.item(CistTAG_PompaCaricoBitume_TempoTimeOutStart).Value = PompaAuxCisterne.ParametroTimeoutAvvio
		CP240.OPCDataCisterne.items.item(CistTAG_PompaCaricoBitume_TempoTimeOutStop).Value = PompaAuxCisterne.ParametroTimeoutStop

		spread = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1
		
		For cisterna = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
			offset = (cisterna - 1) * spread
			Call SingolaCisternaInviaParametri(CisternaLegante(cisterna), CistTAG_CisternaBitume1 + offset)
		Next cisterna

		For cisterna = 11 To CistGestione.NumCisterneEmulsione + 10
			offset = (cisterna - 11) * spread
			Call SingolaCisternaInviaParametri(CisternaLegante(cisterna), CistTAG_CisternaEmulsione1 + offset)
		Next cisterna

		For cisterna = 21 To CistGestione.NumCisterneCombustibile + 20
			offset = (cisterna - 21) * spread
			Call SingolaCisternaInviaParametri(CisternaLegante(cisterna), CistTAG_CisternaCombustibile1 + offset)
		Next cisterna

		'Inizializzazione per sincronizzare i parametri presenti nel PC con quelli del PLC
		'Call InizializzaContalitri  '20161128

		CP240.OPCDataCisterne.SOUpdate


		Exit Sub
Errore:
    LogInserisci True, "CST-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub LeggiDatiPLCCisterneBitume()

    Dim i As Integer
    Dim offset As Integer
    Dim spread  As Integer
'    Dim valoreInt As Integer
'    Dim valoreBool As Boolean
'    Dim digitaleModificato As Boolean
'    Dim valoreByte As Byte
'    Dim valoreLong As Long
'    Dim offsetCisterneBitume As Integer

	On Error GoTo Errore

    If DEMO_VERSION Then
        Exit Sub
    End If

    If (CistGestione.Gestione <> GestionePLC) Then
        Exit Sub
    End If

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
        Exit Sub
    End If


    With CP240.OPCDataCisterne.items
    
'---------------------------------------------------------
'gestione combo
'---------------------------------------------------------
    If CP240.Frame1(24).Visible = True Then
        'combo 0
        
        If .item(CistTAG_Stato_OpCar_Bitume).Value = 0 And .item(CistTAG_Stato_OpAlim_Bitume).Value = 0 Then
            DBScambioDatiCisterneBitume.CodiceOperazioneCarico = 0
            CP240.cmbGestioneCisterne(0).ListIndex = 0
        ElseIf DBScambioDatiCisterneBitume.CodiceOperazioneCarico <> .item(CistTAG_SelOperazionePompaCarico).Value Then
            DBScambioDatiCisterneBitume.CodiceOperazioneCarico = .item(CistTAG_SelOperazionePompaCarico).Value
            CP240.cmbGestioneCisterne(0).ListIndex = DBScambioDatiCisterneBitume.CodiceOperazioneCarico
        End If
        
        'combo 1
        If DBScambioDatiCisterneBitume.SelCistMandataPompaCarico <> .item(CistTAG_SelCisternaMandataPompaCarico).Value Then
            DBScambioDatiCisterneBitume.SelCistMandataPompaCarico = .item(CistTAG_SelCisternaMandataPompaCarico).Value
            If DBScambioDatiCisterneBitume.SelCistMandataPompaCarico > 0 And DBScambioDatiCisterneBitume.SelCistMandataPompaCarico <= CistGestione.NumCisterneBitume Then
                CP240.cmbGestioneCisterne(1).ListIndex = DBScambioDatiCisterneBitume.SelCistMandataPompaCarico - 1
            End If
        End If
        
        'combo 2
        If DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico <> .item(CistTAG_SelCisternaCaricoPompaCarico).Value Then
            DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico = .item(CistTAG_SelCisternaCaricoPompaCarico).Value
            If DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico > 0 And DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico <= CistGestione.NumCisterneBitume Then
                CP240.cmbGestioneCisterne(2).ListIndex = DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico - 1
            End If
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
        If DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz <> .item(CistTAG_SelCisternaCaricoPompaAlimentazione).Value Then
            DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz = .item(CistTAG_SelCisternaCaricoPompaAlimentazione).Value
            If DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz > 0 And DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz <= CistGestione.NumCisterneBitume Then
                CP240.cmbGestioneCisterne(4).ListIndex = DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz - 1
            End If
        End If
        
        'combo 5
        If .item(CistTAG_Stato_OpCar_Bitume).Value = 0 And .item(CistTAG_Stato_OpAlim_Bitume).Value = 0 Then
            DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione = 0
            CP240.cmbGestioneCisterne(5).ListIndex = 0
        ElseIf DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione <> .item(CistTAG_SelOperazionePompaAlimentazione).Value Then
            DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione = .item(CistTAG_SelOperazionePompaAlimentazione).Value
            CP240.cmbGestioneCisterne(5).ListIndex = DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione
        End If

        DBScambioDatiCisterneBitume.OperazioneCaricoARegime = .item(CistTAG_OperazioneCaricoARegime).Value
        DBScambioDatiCisterneBitume.OperazioneAlimentazioneARegime = .item(CistTAG_OperazioneAlimentazioneARegime).Value
        DBScambioDatiCisterneBitume.OperazioneAlimentazioneTorreARegime = .item(CistTAG_OperazioneAlimentazioneTorreARegime).Value
        DBScambioDatiCisterneBitume.StatoErroreOperazioniCisterne = .item(CistTAG_StatoErroreOperazioniCisterne).Value
        DBScambioDatiCisterneBitume.OperazioneAlimentazioneTorreInAttesa = .item(CistTAG_AttesaAlimentazioneTorre).Value
        DBScambioDatiCisterneBitume.OperazioneDoppiaRifiutata = .item(CistTAG_Bitume_Allarme12).Value
        DBScambioDatiCisterneBitume.OperazioneParticolareRifiutata = .item(CistTAG_Bitume_Allarme13).Value
        
        AggiornamentoGraficaOperazioniCisterne
        'controllo sulla fattibilità di una doppia operazione
        If DBScambioDatiCisterneBitume.OperazioneDoppiaRifiutata Then
            If memoriaOperazioneRifiutata = False Then
                memoriaOperazioneRifiutata = True
                ShowMsgBox LoadXLSString(1467), vbOKOnly, vbExclamation, -1, -1, True
            End If
        Else
            memoriaOperazioneRifiutata = False
        End If
        'controllo sull'operazione particolare
        If DBScambioDatiCisterneBitume.OperazioneParticolareRifiutata Then
            If memoriaOperazioneParticolareRifiutata = False Then
                memoriaOperazioneParticolareRifiutata = True
                ShowMsgBox LoadXLSString(1468), vbOKOnly, vbExclamation, -1, -1, True
            End If
        Else
            memoriaOperazioneParticolareRifiutata = False
        End If
            'Aggiorna lo stato solo in presenza di una posizione valida della valvola di separazione
            If ValvolaCircuitoBitume(ValvolaBitume_SEPARAZIONE_GRUPPI_ALIM).VALV_AP_Triggerata Or ValvolaCircuitoBitume(ValvolaBitume_SEPARAZIONE_GRUPPI_ALIM).VALV_CH_Triggerata Then
                MemoriaStatoValvolaSeparazione = ValvolaCircuitoBitume(ValvolaBitume_SEPARAZIONE_GRUPPI_ALIM).VALV_AP_Triggerata
            End If

            'CP240.cmbGestioneCisterne(11).ListIndex = .Item(CistTAG_Emulsione_NumeroCisternaAlimImp_NEW).value - 1
            If CistGestione.NumCisterneEmulsione > 0 Then
                CP240.cmbGestioneCisterne(11).ListIndex = .item(CistTAG_Emulsione_NumeroCisternaAlimImp_NEW).Value - 1
            End If
  
    End If

    CistGestione.InclusioneValvoleSeparazione12Bitume = .item(CistTAG_Bitume_AbilitaValvSeparazione_1_2).Value
    CistGestione.InclusioneValvoleSeparazione23Bitume = .item(CistTAG_Bitume_AbilitaValvSeparazione_2_3).Value

'---------------------------------------------------------
'parametri cisterna
'---------------------------------------------------------
        spread = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1
        
        For i = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
            offset = (i - 1) * spread

            CisternaLegante(i).LivMinimoRaggiunto = .item(offset + CistTAG_Bitume_Cisterna1_LivelloMin_DI_Trigger).Value
            CisternaLegante(i).LivMassimoRaggiunto = .item(offset + CistTAG_Bitume_Cisterna1_LivelloMax_DI_Trigger).Value
            CisternaLegante(i).SicurezzaMeccanicaLivello = .item(offset + CistTAG_Bitume_Cisterna1_LivelloSic_DI_Trigger).Value

            If ( _
                CisternaLegante(i).ValLivelloPerc <> .item(offset + CistTAG_Bitume_Cisterna1_LivelloPercentualeValore).Value Or _
                CisternaLegante(i).ValLivelloTon <> .item(offset + CistTAG_Bitume_Cisterna1_LivelloTonValore).Value Or _
                CisternaLegante(i).ValLivelloTon <> CP240.PrbCistLivello(i - 1).caption _
            ) Then
            '
                CisternaLegante(i).ValLivelloPerc = .item(offset + CistTAG_Bitume_Cisterna1_LivelloPercentualeValore).Value
                CisternaLegante(i).ValLivelloTon = .item(offset + CistTAG_Bitume_Cisterna1_LivelloTonValore).Value

                Call CistVisualizzaLivello( _
                    i - 1, _
                    CisternaLegante(i).ValLivelloPerc, _
                    RoundNumber(CisternaLegante(i).ValLivelloTon, 1) _
                    )
            End If

            If (CisternaLegante(i).ValTemperatura <> .item(offset + CistTAG_Bitume_Cisterna1_TempGradiValore).Value) Then
                CisternaLegante(i).ValTemperatura = .item(offset + CistTAG_Bitume_Cisterna1_TempGradiValore).Value
                Call CistVisualizzaTemperatura(i - 1, CisternaLegante(i).ValTemperatura)
            End If

            CisternaLegante(i).CodificaAllarmeCisterna = .item(offset + CistTAG_Bitume_Cisterna1_AllarmeCodiceGen).Value
            
'            If ( _
'                CisternaLegante(i).ValvolaApertaMandata <> .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger).Value Or _
'                CisternaLegante(i).ValvolaApertaCarico <> .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger).Value Or _
'                CisternaLegante(i).ValvolaApertaRitorno <> .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger).Value _
'            ) Then
'
'                Call ColoraCisterna(i, _
'                .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger).Value, _
'                .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger).Value, _
'                .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger).Value)
'
'            End If
        
            'Valvola Uscita1
            If ( _
                CisternaLegante(i).ValvolaApertaMandata <> .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger).Value Or _
                CisternaLegante(i).ValvolaChiusaMandata <> .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1Close_DI_Trigger).Value Or _
                CisternaLegante(i).CodiceAllMandata <> CLng(.item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice).Value) _
            ) Then
                CisternaLegante(i).ValvolaApertaMandata = .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger).Value
                CisternaLegante(i).ValvolaChiusaMandata = .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1Close_DI_Trigger).Value
                CisternaLegante(i).CodiceAllMandata = .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice).Value

                Call CistVisualizzaValvolaUscita1( _
                    i - 1, _
                    CisternaLegante(i).ValvolaApertaMandata, _
                    CisternaLegante(i).ValvolaChiusaMandata, _
                    CisternaLegante(i).CodiceAllMandata <> 0 _
                    )
            End If
            
            'Valvola Uscita2
            If ( _
                CisternaLegante(i).ValvolaApertaCarico <> .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger).Value Or _
                CisternaLegante(i).ValvolaChiusaCarico <> .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2Close_DI_Trigger).Value Or _
                CisternaLegante(i).CodiceAllCarico <> CLng(.item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice).Value) _
            ) Then
                CisternaLegante(i).ValvolaApertaCarico = .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger).Value
                CisternaLegante(i).ValvolaChiusaCarico = .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2Close_DI_Trigger).Value
                CisternaLegante(i).CodiceAllCarico = .item(offset + CistTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice).Value

                Call CistVisualizzaValvolaUscita2( _
                    i - 1, _
                    CisternaLegante(i).ValvolaApertaCarico, _
                    CisternaLegante(i).ValvolaChiusaCarico, _
                    CisternaLegante(i).CodiceAllCarico <> 0 _
                    )
            End If

            'Valvola Entrata1
            If ( _
                CisternaLegante(i).ValvolaApertaRitorno <> .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger).Value Or _
                CisternaLegante(i).ValvolaChiusaRitorno <> .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1Close_DI_Trigger).Value Or _
                CisternaLegante(i).CodiceAllRitorno <> CLng(.item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice).Value) _
            ) Then
                CisternaLegante(i).ValvolaApertaRitorno = .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger).Value
                CisternaLegante(i).ValvolaChiusaRitorno = .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1Close_DI_Trigger).Value
                CisternaLegante(i).CodiceAllRitorno = .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice).Value

                Call CistVisualizzaValvolaEntrata1( _
                    i - 1, _
                    CisternaLegante(i).ValvolaApertaRitorno, _
                    CisternaLegante(i).ValvolaChiusaRitorno, _
                    CisternaLegante(i).CodiceAllRitorno <> 0 _
                    )
            End If
            
            'Agitatore
            If CisternaLegante(i).AgitatoreRitorno <> .item(CistTAG_Bitume_Cisterna1_Agitatore_Ritorno + (i - 1) * 2).Value Then
                CisternaLegante(i).AgitatoreRitorno = .item(CistTAG_Bitume_Cisterna1_Agitatore_Ritorno + (i - 1) * 2).Value
                Call VisualizzaAgitatoreCisterne(i - 1, CisternaLegante(i).AgitatoreRitorno)
            End If
                                
            'valvola ausiliaria
            CisternaLegante(i).ValvolaApertaAux = .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata2Open_DI_Trigger).Value
            CisternaLegante(i).ValvolaChiusaAux = .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata2Close_DI_Trigger).Value
            CisternaLegante(i).CodiceAllAux = .item(offset + CistTAG_Bitume_Cisterna1_ValvEntrata2AllarmeCodice).Value
        
        Next i


'---------------------------------------------------------
'valvole circuito legante
'---------------------------------------------------------
        
        For i = 0 To MAX_Valvole_Bitume
            ValvolaCircuitoBitume(i).FC_Valvola_Aperta = .item(CistTAG_Bitume_Valvola_0_FC_Valvola_Aperta + (i * 20)).Value
            ValvolaCircuitoBitume(i).FC_Valvola_Chiusa = .item(CistTAG_Bitume_Valvola_0_FC_Valvola_Chiusa + (i * 20)).Value
            ValvolaCircuitoBitume(i).DI_Apertura = .item(CistTAG_Bitume_Valvola_0_DI_Apertura + (i * 20)).Value
            ValvolaCircuitoBitume(i).DI_Chiusura = .item(CistTAG_Bitume_Valvola_0_DI_Chiusura + (i * 20)).Value
            ValvolaCircuitoBitume(i).DI_Blocco_Temperatura = .item(CistTAG_Bitume_Valvola_0_DI_Blocco_Temperatura + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_Inversione_Comando_Valvola = .item(CistTAG_Bitume_Valvola_0_PARA_Inversione_Comando_Valvola + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_EN_Gestione_Valvola = .item(CistTAG_Bitume_Valvola_0_PARA_EN_Gestione_Valvola + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_EN_Tipo_Valvola_Manuale = .item(CistTAG_Bitume_Valvola_0_PARA_EN_Tipo_Valvola_Manuale + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_EN_CMD_Doppio = .item(CistTAG_Bitume_Valvola_0_PARA_EN_CMD_Doppio + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_TimeOut_Scambio_AP = .item(CistTAG_Bitume_Valvola_0_PARA_TimeOut_Scambio_AP + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_TimeOut_Scambio_CH = .item(CistTAG_Bitume_Valvola_0_PARA_TimeOut_Scambio_CH + (i * 20)).Value
            ValvolaCircuitoBitume(i).PARA_Tempo_Trigger_FC = .item(CistTAG_Bitume_Valvola_0_PARA_Tempo_Trigger_FC + (i * 20)).Value
            ValvolaCircuitoBitume(i).CMD_Valvola = .item(CistTAG_Bitume_Valvola_0_CMD_Valvola + (i * 20)).Value
            ValvolaCircuitoBitume(i).VALV_AP_Triggerata = .item(CistTAG_Bitume_Valvola_0_VALV_AP_Triggerata + (i * 20)).Value
            ValvolaCircuitoBitume(i).VALV_CH_Triggerata = .item(CistTAG_Bitume_Valvola_0_VALV_CH_Triggerata + (i * 20)).Value
            ValvolaCircuitoBitume(i).Codice_Allarme = .item(CistTAG_Bitume_Valvola_0_Codice_Allarme + (i * 20)).Value
            ValvolaCircuitoBitume(i).OUT_Tempo_AP = .item(CistTAG_Bitume_Valvola_0_OUT_Tempo_AP + (i * 20)).Value
            ValvolaCircuitoBitume(i).OUT_Tempo_CH = .item(CistTAG_Bitume_Valvola_0_OUT_Tempo_CH + (i * 20)).Value
            ValvolaCircuitoBitume(i).NR_Operazioni_Apertura = .item(CistTAG_Bitume_Valvola_0_NR_Operazioni_Apertura + (i * 20)).Value
            ValvolaCircuitoBitume(i).NR_Operazioni_Chiusura = .item(CistTAG_Bitume_Valvola_0_NR_Operazioni_Chiusura + (i * 20)).Value
        Next i
        For i = 0 To 13
            ValvolaCircuitoEmulsione(i).FC_Valvola_Aperta = .item(CistTAG_Emulsione_Valvola_0_FC_Valvola_Aperta + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).FC_Valvola_Chiusa = .item(CistTAG_Emulsione_Valvola_0_FC_Valvola_Chiusa + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).DI_Apertura = .item(CistTAG_Emulsione_Valvola_0_DI_Apertura + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).DI_Chiusura = .item(CistTAG_Emulsione_Valvola_0_DI_Chiusura + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).DI_Blocco_Temperatura = .item(CistTAG_Emulsione_Valvola_0_DI_Blocco_Temperatura + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_Inversione_Comando_Valvola = .item(CistTAG_Emulsione_Valvola_0_PARA_Inversione_Comando_Valvola + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_EN_Gestione_Valvola = .item(CistTAG_Emulsione_Valvola_0_PARA_EN_Gestione_Valvola + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_EN_Tipo_Valvola_Manuale = .item(CistTAG_Emulsione_Valvola_0_PARA_EN_Tipo_Valvola_Manuale + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_EN_CMD_Doppio = .item(CistTAG_Emulsione_Valvola_0_PARA_EN_CMD_Doppio + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_TimeOut_Scambio_AP = .item(CistTAG_Emulsione_Valvola_0_PARA_TimeOut_Scambio_AP + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_TimeOut_Scambio_CH = .item(CistTAG_Emulsione_Valvola_0_PARA_TimeOut_Scambio_CH + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).PARA_Tempo_Trigger_FC = .item(CistTAG_Emulsione_Valvola_0_PARA_Tempo_Trigger_FC + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).CMD_Valvola = .item(CistTAG_Emulsione_Valvola_0_CMD_Valvola + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).VALV_AP_Triggerata = .item(CistTAG_Emulsione_Valvola_0_VALV_AP_Triggerata + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).VALV_CH_Triggerata = .item(CistTAG_Emulsione_Valvola_0_VALV_CH_Triggerata + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).Codice_Allarme = .item(CistTAG_Emulsione_Valvola_0_Codice_Allarme + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).OUT_Tempo_AP = .item(CistTAG_Emulsione_Valvola_0_OUT_Tempo_AP + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).OUT_Tempo_CH = .item(CistTAG_Emulsione_Valvola_0_OUT_Tempo_CH + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).NR_Operazioni_Apertura = .item(CistTAG_Emulsione_Valvola_0_NR_Operazioni_Apertura + (i * 20)).Value
            ValvolaCircuitoEmulsione(i).NR_Operazioni_Chiusura = .item(CistTAG_Emulsione_Valvola_0_NR_Operazioni_Chiusura + (i * 20)).Value
        Next i
        For i = 0 To 9
            ValvolaCircuitoCombustibile(i).FC_Valvola_Aperta = .item(CistTAG_Combustibile_Valvola_0_FC_Valvola_Aperta + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).FC_Valvola_Chiusa = .item(CistTAG_Combustibile_Valvola_0_FC_Valvola_Chiusa + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).DI_Apertura = .item(CistTAG_Combustibile_Valvola_0_DI_Apertura + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).DI_Chiusura = .item(CistTAG_Combustibile_Valvola_0_DI_Chiusura + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).DI_Blocco_Temperatura = .item(CistTAG_Combustibile_Valvola_0_DI_Blocco_Temperatura + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_Inversione_Comando_Valvola = .item(CistTAG_Combustibile_Valvola_0_PARA_Inversione_Comando_Valvola + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_EN_Gestione_Valvola = .item(CistTAG_Combustibile_Valvola_0_PARA_EN_Gestione_Valvola + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_EN_Tipo_Valvola_Manuale = .item(CistTAG_Combustibile_Valvola_0_PARA_EN_Tipo_Valvola_Manuale + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_EN_CMD_Doppio = .item(CistTAG_Combustibile_Valvola_0_PARA_EN_CMD_Doppio + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_TimeOut_Scambio_AP = .item(CistTAG_Combustibile_Valvola_0_PARA_TimeOut_Scambio_AP + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_TimeOut_Scambio_CH = .item(CistTAG_Combustibile_Valvola_0_PARA_TimeOut_Scambio_CH + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).PARA_Tempo_Trigger_FC = .item(CistTAG_Combustibile_Valvola_0_PARA_Tempo_Trigger_FC + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).CMD_Valvola = .item(CistTAG_Combustibile_Valvola_0_CMD_Valvola + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).VALV_AP_Triggerata = .item(CistTAG_Combustibile_Valvola_0_VALV_AP_Triggerata + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).VALV_CH_Triggerata = .item(CistTAG_Combustibile_Valvola_0_VALV_CH_Triggerata + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).Codice_Allarme = .item(CistTAG_Combustibile_Valvola_0_Codice_Allarme + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).OUT_Tempo_AP = .item(CistTAG_Combustibile_Valvola_0_OUT_Tempo_AP + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).OUT_Tempo_CH = .item(CistTAG_Combustibile_Valvola_0_OUT_Tempo_CH + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).NR_Operazioni_Apertura = .item(CistTAG_Combustibile_Valvola_0_NR_Operazioni_Apertura + (i * 20)).Value
            ValvolaCircuitoCombustibile(i).NR_Operazioni_Chiusura = .item(CistTAG_Combustibile_Valvola_0_NR_Operazioni_Chiusura + (i * 20)).Value
        Next i
        '

'---------------------------------------------------------------------------------------------------------------
'sonda di temperatura nel tubo fra la valvola di carico e la pompa
'---------------------------------------------------------------------------------------------------------------
        SondaTuboCaricoLegante = .item(CistTAG_SondaTuboCaricoBitume).Value    'sonda di temperatura nel tubo fra la valvola di carico e la pompa

'        valoreBool = .item(CistTAG_PompaCaricoBitume_DI_Ritorno).Value
'        valoreInt = .item(CistTAG_PompaCaricoBitume_AllarmeCodice).Value
'        If (BooleanModificato(PompaAuxCisterne.DI_Ritorno, valoreBool, PlcInDigitali_Fatta)) Or (IntegerModificato(PompaAuxCisterne.CodiceAllarme, valoreInt, plcInAnalogici_Fatta)) Then
'            Call PompaCircuitoLegante_Change(PompaAuxCisterne.DI_Ritorno, PompaAuxCisterne.CodiceAllarme, FormVistaCisterne.ImgPumpCirc(1))
'        End If


'        If .item(CistTAG_Bitume_Allarme22).Value Then
'            ListaMotori(MotorePCL).uscita = False
'        End If
'
'        If .item(CistTAG_Bitume_Allarme17).Value Then
'            ListaMotori(MotorePCL2).uscita = False
'        End If

        PlcInDigitali_Fatta = True
        plcInAnalogici_Fatta = True

    End With
    
    '20161230
    If (cstIndiceLabelTempTuboCaricoLegante >= 0) Then
    '
        CP240.LblEtichetta(cstIndiceLabelTempTuboCaricoLegante).caption = CStr(Round(SondaTuboCaricoLegante, 0))
    End If

    If AbilitaValvolaConsensoBitumeNeutro Then
    
    Else
        ConsensoStartPCL3 = True
    End If

    'Ogni 2 secondi rinfresco lo stato delle valvole per evitare lo sfarfallio dell'immagine
    If ConvertiTimer() > TempoRinfrescoValvoleVistaCisterne + 2 Then
    
    'Valvola separa 1-2 sopra
        Call GraficaValvolaStandard_Change(ValvolaBitume_SEPARAZIONE_CARICO_GRUPPO_1_2, CP240.ImgCistValvolaSepara(0), automaticaorizzontale)
    
    'Valvola separa 1-2 sotto
        Call GraficaValvolaStandard_Change(ValvolaBitume_SEPARAZIONE_ASPIRAZIONE_GRUPPO_1_2, CP240.ImgCistValvolaSepara(1), automaticaorizzontale)
    
    'Valvola separa 2-3 sopra
        Call GraficaValvolaStandard_Change(ValvolaBitume_SEPARAZIONE_CARICO_GRUPPO_2_3, CP240.ImgCistValvolaSepara(2), automaticaorizzontale)
        
    'Valvola separa 2-3 sotto
        Call GraficaValvolaStandard_Change(ValvolaBitume_SEPARAZIONE_ASPIRAZIONE_GRUPPO_2_3, CP240.ImgCistValvolaSepara(3), automaticaorizzontale)
    
    'Valvola separa gruppi di alimentazione
'        Call GraficaValvolaStandard_Change(ValvolaBitume_SEPARAZIONE_GRUPPI_ALIM, FormVistaCisterne.ImgValvSepCist, automaticaverticale)
        Call GraficaValvolaStandard_Change(ValvolaBitume_SEPARAZIONE_GRUPPI_ALIM, CP240.ImgCistValvolaSepara(4), automaticaorizzontale)
        
    'Valvola inclusione contalitri
'        Call GraficaValvolaStandard_Change(ValvolaBitume_INCLUSIONE_CONTALITRI, FormVistaCisterne.ImgValvIncContalitri(0), automaticaorizzontale)
'        Call GraficaValvolaStandard_Change(ValvolaBitume_INCLUSIONE_CONTALITRI, FormVistaCisterne.ImgValvIncContalitri(1), automaticaorizzontale)
        'Call GraficaValvolaStandard_Change(ValvolaBitume_INCLUSIONE_CONTALITRI, CP240.ImgValvolaInclContalitri, automaticaorizzontale) '20161130
            
    'Valvola esclusione contalitri
'        Call GraficaValvolaStandard_Change(ValvolaBitume_ESCLUSIONE_CONTALITRI, FormVistaCisterne.ImgValvEscContalitri, automaticaorizzontale)
        'Call GraficaValvolaStandard_Change(ValvolaBitume_ESCLUSIONE_CONTALITRI, CP240.ImgValvolaEsclContalitri, automaticaorizzontale) '20161130
        
    'VALVOLA 23
'        Call GraficaValvolaStandard_Change(ValvolaBitume_LINEA1_INCLUSIONE_POMPA_CARICO, FormVistaCisterne.ImgValvManualCist(3), manualeorizzontale)
    
    'VALVOLA 24
'        Call GraficaValvolaStandard_Change(ValvolaBitume_LINEA2_INCLUSIONE_POMPA_CARICO, FormVistaCisterne.ImgValvManualCist(2), manualeorizzontale)
    
    'VALVOLA 25
'        Call GraficaValvolaStandard_Change(ValvolaBitume_BYPASS_ESCLUSIONE_POMPA_CARICO, FormVistaCisterne.ImgValvManualCist(4), manualeorizzontale)
           
    'VALVOLA 2
'        Call GraficaValvolaStandard_Change(ValvolaBitume_ENTRATA_POMPA_CARICO, FormVistaCisterne.ImgValvManualCist(5), manualeorizzontale)
        
    'VALVOLA ENTRATA 2 POMPA CARICO
'        Call GraficaValvolaStandard_Change(ValvolaBitume_AUX1, FormVistaCisterne.ImgValvManualCist(6), manualeorizzontale)
                   
    'VALVOLA 15 BRACCIO DI CARICO 1
'        Call GraficaValvolaStandard_Change(ValvolaBitume_BRACCIO_CARICO, FormVistaCisterne.ImgValvManualCist(0), manualeverticale)
                
    'VALVOLA 16 BRACCIO DI CARICO 2
'        Call GraficaValvolaStandard_Change(ValvolaBitume_AUX4, FormVistaCisterne.ImgValvManualCist(1), manualeverticale)
        
    'VALVOLA 14 ALIM ESTERNA PC 1
'        Call GraficaValvolaStandard_Change(ValvolaBitume_ALIMENTAZIONE_ESTERNA, FormVistaCisterne.ImgValvAlimEst(0), automaticaverticale)
                
    'VALVOLA 19 ALIM ESTERNA PC 2
'        Call GraficaValvolaStandard_Change(ValvolaBitume_AUX7, FormVistaCisterne.ImgValvAlimEst(1), automaticaverticale)
        
    'VALVOLA 12 VALVOLA RICIRCOLO SU POMPA DI CARICO
'        Call GraficaValvolaStandard_Change(ValvolaBitume_RICIRCOLO_POMPA_CARICO_1, FormVistaCisterne.ImgValvRicircolo, automaticaorizzontale)
            
    'VALVOLA 17 VALVOLA 3 VIE SU BRACCIO DI CARICO
'        Call GraficaValvolaStandard_Change(ValvolaBitume_AUX5, FormVistaCisterne.ImgValvCist3Vie, treviemanualeorizzontale)
        
    'VALVOLA AUX2 VALVOLA A IMPIANTO ESTERNO PER BITUME MODIFICATO
'        Call GraficaValvolaStandard_Change(ValvolaBitume_AUX2, FormVistaCisterne.ImgValvManualCist(7), manualeorizzontale)
    
    'VALVOLA AUX3 VALVOLA DA IMPIANTO ESTERNO PER BITUME MODIFICATO
'        Call GraficaValvolaStandard_Change(ValvolaBitume_AUX3, FormVistaCisterne.ImgValvManualCist(8), manualeorizzontale)
        
        TempoRinfrescoValvoleVistaCisterne = ConvertiTimer()
    
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "CST-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AggiornamentoGraficaOperazioniCisterne()

    'gestione immagine operazioni con pompa di carico
    If DBScambioDatiCisterneBitume.CodiceOperazioneCarico <> 0 Then
        If DBScambioDatiCisterneBitume.OperazioneCaricoARegime Then
            Select Case DBScambioDatiCisterneBitume.CodiceOperazioneCarico
                Case 0      'nessuna operazione
                    CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
                Case 1      'carico
                    CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneCarico", vbResBitmap)
                Case 2      'travaso
                    CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneTravaso", vbResBitmap)
                Case 3      'ricircolo
                    CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneRicircolo", vbResBitmap)
            End Select
        Else
            CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
        End If
    Else
        CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
    End If

    'gestione immagine operazioni con pompa di alimentazione
    If DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione <> 0 Then
        If DBScambioDatiCisterneBitume.OperazioneAlimentazioneARegime Then
            Select Case DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione
                Case 0      'nessuna operazione
                    CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
                Case 1      'carico
                    CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneCarico", vbResBitmap)
                Case 2      'travaso
                    CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneTravaso", vbResBitmap)
                Case 3      'alimentazione da esterno
                    CP240.Image1(22).Picture = LoadResPicture("IDB_Camionspruzzatrice_on", vbResBitmap)
                Case 4      'alimentazione torre
                    CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneAlimentazioneImpianto", vbResBitmap)
                Case 5      'ricircolo
                    CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneRicircolo", vbResBitmap)
            End Select
        Else
            CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
        End If
    Else
        CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
    End If
    
    'stato particolare di alimentazione torre con doppia selezione a 0
    If DBScambioDatiCisterneBitume.OperazioneAlimentazioneTorreARegime Then
        CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
        CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneAlimentazioneImpianto", vbResBitmap)
    End If
    'stato particolare di attesa alimentazione torre
    If DBScambioDatiCisterneBitume.OperazioneAlimentazioneTorreInAttesa Then
        CP240.Image1(3).Picture = LoadResPicture("IDB_CisterneSpente", vbResBitmap)
        CP240.Image1(22).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
    End If
End Sub

Public Sub LeggiDatiPLCCisterneEmulsione()

	Dim i As Integer
	Dim offset As Integer
	Dim spread As Integer


	On Error GoTo Errore

		If (CistGestione.Gestione <> GestionePLC) Then
			Exit Sub
		End If

		If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
			Exit Sub
		End If
		
		If DBScambioDatiCisterneEmulsione.NumeroCisternePresenti <= 0 Then
			Exit Sub
		End If


		With CP240.OPCDataCisterne.items
		
	'---------------------------------------------------------
	'parametri generali
	'---------------------------------------------------------
			'Non coloro più le cisterne di verde

			If (DBScambioDatiCisterneEmulsione.OperazioneInCorsoCist <> .item(CistTAG_Pannello_OperazioneEmulsione).Value) Then
				DBScambioDatiCisterneEmulsione.OperazioneInCorsoCist = .item(CistTAG_Pannello_OperazioneEmulsione).Value
				'Operazione attualmente in corso
				Select Case DBScambioDatiCisterneEmulsione.OperazioneInCorsoCist
					Case 1
						CP240.Image1(13).Picture = LoadResPicture("IDB_CisterneAlimentazioneImpianto", vbResBitmap)
					Case 2
						CP240.Image1(13).Picture = LoadResPicture("IDB_CisterneCarico", vbResBitmap)
					Case 3
						CP240.Image1(13).Picture = LoadResPicture("IDB_CisterneTravaso", vbResBitmap)
					Case 4
						CP240.Image1(13).Picture = LoadResPicture("IDB_CisterneRicircolo", vbResBitmap)
					Case 5
						CP240.Image1(13).Picture = LoadResPicture("IDB_CisterneBraccioCarico", vbResBitmap)
					Case Else
						CP240.Image1(13).Picture = LoadResPicture("IDB_CisterneAttesa", vbResBitmap)
				End Select
			End If

			spread = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1
			
	'---------------------------------------------------------
	'parametri cisterna
	'---------------------------------------------------------
			For i = 11 To DBScambioDatiCisterneEmulsione.NumeroCisternePresenti + 10
				offset = (i - 11) * spread

				CisternaLegante(i).LivMinimoRaggiunto = .item(offset + CistTAG_Emulsione_Cisterna1_LivelloMin_DI_Trigger).Value
				CisternaLegante(i).LivMassimoRaggiunto = .item(offset + CistTAG_Emulsione_Cisterna1_LivelloMax_DI_Trigger).Value
				CisternaLegante(i).SicurezzaMeccanicaLivello = .item(offset + CistTAG_Emulsione_Cisterna1_LivelloSic_DI_Trigger).Value

				If ( _
					CisternaLegante(i).ValLivelloPerc <> .item(offset + CistTAG_Emulsione_Cisterna1_LivelloPercentualeValore).Value Or _
					CisternaLegante(i).ValLivelloTon <> .item(offset + CistTAG_Emulsione_Cisterna1_LivelloTonValore).Value _
				) Then
					CisternaLegante(i).ValLivelloPerc = .item(offset + CistTAG_Emulsione_Cisterna1_LivelloPercentualeValore).Value
					CisternaLegante(i).ValLivelloTon = .item(offset + CistTAG_Emulsione_Cisterna1_LivelloTonValore).Value

					Call CistVisualizzaLivello( _
						i - 1 + 90, _
						CisternaLegante(i).ValLivelloPerc, _
						RoundNumber(CisternaLegante(i).ValLivelloTon, 1) _
						)
				End If

				If (CisternaLegante(i).ValTemperatura <> .item(offset + CistTAG_Emulsione_Cisterna1_TempGradiValore).Value) Then
					CisternaLegante(i).ValTemperatura = .item(offset + CistTAG_Emulsione_Cisterna1_TempGradiValore).Value
					Call CistVisualizzaTemperatura(i - 1 + 90, CisternaLegante(i).ValTemperatura)
				End If

				CisternaLegante(i).CodificaAllarmeCisterna = .item(offset + CistTAG_Emulsione_Cisterna1_AllarmeCodiceGen).Value

				'valvola di mandata

				If ( _
					CisternaLegante(i).ValvolaApertaMandata <> .item(offset + CistTAG_Emulsione_Cisterna1_ValvMandataOpen_DI_Trigger).Value Or _
					CisternaLegante(i).ValvolaChiusaMandata <> .item(offset + CistTAG_Emulsione_Cisterna1_ValvMandataClose_DI_Trigger).Value Or _
					CisternaLegante(i).CodiceAllMandata <> CLng(.item(offset + CistTAG_Emulsione_Cisterna1_ValvMandataAllarmeCodice).Value) _
				) Then
					CisternaLegante(i).ValvolaApertaMandata = .item(offset + CistTAG_Emulsione_Cisterna1_ValvMandataOpen_DI_Trigger).Value
					CisternaLegante(i).ValvolaChiusaMandata = .item(offset + CistTAG_Emulsione_Cisterna1_ValvMandataClose_DI_Trigger).Value
					CisternaLegante(i).CodiceAllMandata = .item(offset + CistTAG_Emulsione_Cisterna1_ValvMandataAllarmeCodice).Value

					Call CistVisualizzaValvolaUscita1( _
						i - 1 + 90, _
						CisternaLegante(i).ValvolaApertaMandata, _
						CisternaLegante(i).ValvolaChiusaMandata, _
						CisternaLegante(i).CodiceAllMandata <> 0 _
						)
				End If

				'valvola di ritorno

				If ( _
					CisternaLegante(i).ValvolaApertaRitorno <> .item(offset + CistTAG_Emulsione_Cisterna1_ValvRitornoOpen_DI_Trigger).Value Or _
					CisternaLegante(i).ValvolaChiusaRitorno <> .item(offset + CistTAG_Emulsione_Cisterna1_ValvRitornoClose_DI_Trigger).Value Or _
					CisternaLegante(i).CodiceAllRitorno <> CLng(.item(offset + CistTAG_Emulsione_Cisterna1_ValvRitornoAllarmeCodice).Value) _
				) Then
					CisternaLegante(i).ValvolaApertaRitorno = .item(offset + CistTAG_Emulsione_Cisterna1_ValvRitornoOpen_DI_Trigger).Value
					CisternaLegante(i).ValvolaChiusaRitorno = .item(offset + CistTAG_Emulsione_Cisterna1_ValvRitornoClose_DI_Trigger).Value
					CisternaLegante(i).CodiceAllRitorno = .item(offset + CistTAG_Emulsione_Cisterna1_ValvRitornoAllarmeCodice).Value

					Call CistVisualizzaValvolaUscita2( _
						i - 1 + 90, _
						CisternaLegante(i).ValvolaApertaRitorno, _
						CisternaLegante(i).ValvolaChiusaRitorno, _
						CisternaLegante(i).CodiceAllRitorno <> 0 _
						)
				End If

				'valvola di carico

				If ( _
					CisternaLegante(i).ValvolaApertaCarico <> .item(offset + CistTAG_Emulsione_Cisterna1_ValvCaricoOpen_DI_Trigger).Value Or _
					CisternaLegante(i).ValvolaChiusaCarico <> .item(offset + CistTAG_Emulsione_Cisterna1_ValvCaricoClose_DI_Trigger).Value Or _
					CisternaLegante(i).CodiceAllCarico <> CLng(.item(offset + CistTAG_Emulsione_Cisterna1_ValvCaricoAllarmeCodice).Value) _
				) Then
					CisternaLegante(i).ValvolaApertaCarico = .item(offset + CistTAG_Emulsione_Cisterna1_ValvCaricoOpen_DI_Trigger).Value
					CisternaLegante(i).ValvolaChiusaCarico = .item(offset + CistTAG_Emulsione_Cisterna1_ValvCaricoClose_DI_Trigger).Value
					CisternaLegante(i).CodiceAllCarico = .item(offset + CistTAG_Emulsione_Cisterna1_ValvCaricoAllarmeCodice).Value

					Call CistVisualizzaValvolaEntrata1( _
						i - 1 + 90, _
						CisternaLegante(i).ValvolaApertaCarico, _
						CisternaLegante(i).ValvolaChiusaCarico, _
						CisternaLegante(i).CodiceAllCarico <> 0 _
						)
				End If

				'valvola ausiliaria

				CisternaLegante(i).ValvolaApertaAux = .item(offset + CistTAG_Emulsione_Cisterna1_ValvAuxOpen_DI_Trigger).Value
				CisternaLegante(i).ValvolaChiusaAux = .item(offset + CistTAG_Emulsione_Cisterna1_ValvAuxClose_DI_Trigger).Value
				CisternaLegante(i).CodiceAllAux = .item(offset + CistTAG_Emulsione_Cisterna1_ValvAuxAllarmeCodice).Value
			
			Next i

		End With


		Exit Sub
Errore:
    LogInserisci True, "CST-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub LeggiDatiPLCCisterneCombustibile()

	Dim i As Integer
	Dim offset As Integer
	Dim spread As Integer


	On Error GoTo Errore

		If (CistGestione.Gestione <> GestionePLC) Then
			Exit Sub
		End If

		If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.count = 0 Then
			Exit Sub
		End If
		
		If DBScambioDatiCisterneCombustibile.NumeroCisternePresenti <= 0 Then
			Exit Sub
		End If


		spread = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1
		
		With CP240.OPCDataCisterne.items
	'---------------------------------------------------------
	'parametri cisterna
	'---------------------------------------------------------
			For i = 21 To DBScambioDatiCisterneCombustibile.NumeroCisternePresenti + 20
				offset = (i - 21) * spread
				
				CisternaLegante(i).LivMinimoRaggiunto = .item(offset + CistTAG_Combustibile_Cisterna1_LivelloMin_DI_Trigger).Value
				CisternaLegante(i).LivMassimoRaggiunto = .item(offset + CistTAG_Combustibile_Cisterna1_LivelloMax_DI_Trigger).Value
				CisternaLegante(i).SicurezzaMeccanicaLivello = .item(offset + CistTAG_Combustibile_Cisterna1_LivelloSic_DI_Trigger).Value

				If ( _
					CisternaLegante(i).ValLivelloPerc <> .item(offset + CistTAG_Combustibile_Cisterna1_LivelloPercentualeValore).Value Or _
					CisternaLegante(i).ValLivelloTon <> .item(offset + CistTAG_Combustibile_Cisterna1_LivelloTonValore).Value _
				) Then
					CisternaLegante(i).ValLivelloPerc = .item(offset + CistTAG_Combustibile_Cisterna1_LivelloPercentualeValore).Value
					CisternaLegante(i).ValLivelloTon = .item(offset + CistTAG_Combustibile_Cisterna1_LivelloTonValore).Value

					Call CistVisualizzaLivello( _
						i - 1 + 180, _
						CisternaLegante(i).ValLivelloPerc, _
						RoundNumber(CisternaLegante(i).ValLivelloTon, 1) _
						)
				End If

				If (CisternaLegante(i).ValTemperatura <> .item(offset + CistTAG_Combustibile_Cisterna1_TempGradiValore).Value) Then
					CisternaLegante(i).ValTemperatura = .item(offset + CistTAG_Combustibile_Cisterna1_TempGradiValore).Value
					Call CistVisualizzaTemperatura(i - 1 + 180, CisternaLegante(i).ValTemperatura)
				End If

				CisternaLegante(i).CodificaAllarmeCisterna = .item(offset + CistTAG_Combustibile_Cisterna1_AllarmeCodiceGen).Value

				'valvola di mandata

				If ( _
					CisternaLegante(i).ValvolaApertaMandata <> .item(offset + CistTAG_Combustibile_Cisterna1_ValvMandataOpen_DI_Trigger).Value Or _
					CisternaLegante(i).ValvolaChiusaMandata <> .item(offset + CistTAG_Combustibile_Cisterna1_ValvMandataClose_DI_Trigger).Value Or _
					CisternaLegante(i).CodiceAllMandata <> CLng(.item(offset + CistTAG_Combustibile_Cisterna1_ValvMandataAllarmeCodice).Value) _
				) Then
					CisternaLegante(i).ValvolaApertaMandata = .item(offset + CistTAG_Combustibile_Cisterna1_ValvMandataOpen_DI_Trigger).Value
					CisternaLegante(i).ValvolaChiusaMandata = .item(offset + CistTAG_Combustibile_Cisterna1_ValvMandataClose_DI_Trigger).Value
					CisternaLegante(i).CodiceAllMandata = .item(offset + CistTAG_Combustibile_Cisterna1_ValvMandataAllarmeCodice).Value

					Call CistVisualizzaValvolaUscita1( _
						i - 1 + 180, _
						CisternaLegante(i).ValvolaApertaMandata, _
						CisternaLegante(i).ValvolaChiusaMandata, _
						CisternaLegante(i).CodiceAllMandata <> 0 _
						)
				End If

				'valvola di ritorno

				If ( _
					CisternaLegante(i).ValvolaApertaRitorno <> .item(offset + CistTAG_Combustibile_Cisterna1_ValvRitornoOpen_DI_Trigger).Value Or _
					CisternaLegante(i).ValvolaChiusaRitorno <> .item(offset + CistTAG_Combustibile_Cisterna1_ValvRitornoClose_DI_Trigger).Value Or _
					CisternaLegante(i).CodiceAllRitorno <> CLng(.item(offset + CistTAG_Combustibile_Cisterna1_ValvRitornoAllarmeCodice).Value) _
				) Then
					CisternaLegante(i).ValvolaApertaRitorno = .item(offset + CistTAG_Combustibile_Cisterna1_ValvRitornoOpen_DI_Trigger).Value
					CisternaLegante(i).ValvolaChiusaRitorno = .item(offset + CistTAG_Combustibile_Cisterna1_ValvRitornoClose_DI_Trigger).Value
					CisternaLegante(i).CodiceAllRitorno = .item(offset + CistTAG_Combustibile_Cisterna1_ValvRitornoAllarmeCodice).Value

					Call CistVisualizzaValvolaUscita2( _
						i - 1 + 180, _
						CisternaLegante(i).ValvolaApertaRitorno, _
						CisternaLegante(i).ValvolaChiusaRitorno, _
						CisternaLegante(i).CodiceAllRitorno <> 0 _
						)
				End If

				'valvola di carico

				If ( _
					CisternaLegante(i).ValvolaApertaCarico <> .item(offset + CistTAG_Combustibile_Cisterna1_ValvCaricoOpen_DI_Trigger).Value Or _
					CisternaLegante(i).ValvolaChiusaCarico <> .item(offset + CistTAG_Combustibile_Cisterna1_ValvCaricoClose_DI_Trigger).Value Or _
					CisternaLegante(i).CodiceAllCarico <> CLng(.item(offset + CistTAG_Combustibile_Cisterna1_ValvCaricoAllarmeCodice).Value) _
				) Then
					CisternaLegante(i).ValvolaApertaCarico = .item(offset + CistTAG_Combustibile_Cisterna1_ValvCaricoOpen_DI_Trigger).Value
					CisternaLegante(i).ValvolaChiusaCarico = .item(offset + CistTAG_Combustibile_Cisterna1_ValvCaricoClose_DI_Trigger).Value
					CisternaLegante(i).CodiceAllCarico = .item(offset + CistTAG_Combustibile_Cisterna1_ValvCaricoAllarmeCodice).Value

					Call CistVisualizzaValvolaEntrata1( _
						i - 1 + 180, _
						CisternaLegante(i).ValvolaApertaCarico, _
						CisternaLegante(i).ValvolaChiusaCarico, _
						CisternaLegante(i).CodiceAllCarico <> 0 _
						)
				End If

				'valvola ausiliaria

				CisternaLegante(i).ValvolaApertaAux = .item(offset + CistTAG_Combustibile_Cisterna1_ValvAuxOpen_DI_Trigger).Value
				CisternaLegante(i).ValvolaChiusaAux = .item(offset + CistTAG_Combustibile_Cisterna1_ValvAuxClose_DI_Trigger).Value
				CisternaLegante(i).CodiceAllAux = .item(offset + CistTAG_Combustibile_Cisterna1_ValvAuxAllarmeCodice).Value
			
			Next i

		End With


		Exit Sub
Errore:
    LogInserisci True, "CST-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub CaricaParametriCisterne()

    Dim i As Integer
    Dim offsetCisterneBitume As Integer
    Dim test As Boolean

'20150505
'    If (CistGestione.Gestione <> GestionePLC) Then
    If (CistGestione.Gestione <> GestionePLC) And (CistGestione.Gestione <> GestioneSemplificata) Then
'
        Exit Sub
    End If

'---------------------------------------------------------------------------------------------------------
'parametri cisterne
'---------------------------------------------------------------------------------------------------------

    Call LeggiFileCisterne
    
'20150505
    If (CistGestione.Gestione = GestionePLC) Then
        'lettura parametri generali prima impostati nei parametri qui in VB6 e ora letti dal PLC perchè configurati con il nuovo config. esterno
        If CP240.OPCDataCisterne.IsConnected And CP240.OPCDataCisterne.items.count <> 0 Then
            test = (GetQuality(CP240.OPCDataCisterne.items(0).quality) = STATOOK)
            If test Then
                'se il plc2 è connesso allora leggo il valore dei parametri, altrimenti utilizzo i valori del DB per impostare il parco legante -> non facendo
                'così in assenza di comunicazione scriveva 0 in tutti i parametri
    
                With CP240.OPCDataCisterne.items
                    CistGestione.NumCisterneBitume = .item(CistTAG_Bitume_NumeroCisterne).Value
                    offsetCisterneBitume = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1
                    
                    For i = 1 To CistGestione.NumCisterneBitume
                        CisternaLegante(i).InclusioneValvolaMandata = .item(CistTAG_Bitume_Cisterna1_AbilitaValvolaMandata + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).InclusioneValvolaRitorno = .item(CistTAG_Bitume_Cisterna1_AbilitaValvolaRitorno + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).InclusioneValvolaCarico = .item(CistTAG_Bitume_Cisterna1_AbilitaValvolaCarico + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).InclusioneValvolaAux = .item(CistTAG_Bitume_Cisterna1_AbilitaValvolaAux + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).NumeroValvoleCisterna = .item(CistTAG_Bitume_Cisterna1_NumeroValvolePresenti + offsetCisterneBitume * (i - 1)).Value
                    Next i
                End With
            End If
        End If
    Else
        'lettura parametri generali prima impostati nei parametri qui in VB6 e ora letti dal PLC perchè configurati con il nuovo config. esterno
        If CP240.OPCData.IsConnected And CP240.OPCData.items.count <> 0 Then
            test = (GetQuality(CP240.OPCData.items(0).quality) = STATOOK)
            If test Then
                'se il plc è connesso allora leggo il valore dei parametri, altrimenti utilizzo i valori del DB per impostare il parco legante -> non facendo
                'così in assenza di comunicazione scriveva 0 in tutti i parametri
    
                With CP240.OPCData.items
                    offsetCisterneBitume = CistRidTAG_CisternaBitume2 - CistRidTAG_CisternaBitume1
                    For i = 1 To CistGestione.NumCisterneBitume
                        CisternaLegante(i).InclusioneValvolaMandata = .item(CistRidTAG_Bitume_Cisterna1_AbilitaValvolaMandata + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).InclusioneValvolaRitorno = .item(CistRidTAG_Bitume_Cisterna1_AbilitaValvolaRitorno + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).InclusioneValvolaCarico = .item(CistRidTAG_Bitume_Cisterna1_AbilitaValvolaCarico + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).InclusioneValvolaAux = .item(CistRidTAG_Bitume_Cisterna1_AbilitaValvolaAux + offsetCisterneBitume * (i - 1)).Value
                        CisternaLegante(i).NumeroValvoleCisterna = .item(CistRidTAG_Bitume_Cisterna1_NumeroValvolePresenti + offsetCisterneBitume * (i - 1)).Value
                    Next i
                End With
            End If
        End If
    End If
    
    DBScambioDatiCisterneBitume.NumeroCisternePresenti = CistGestione.NumCisterneBitume
    
    ParametriDBCisterneModificati = False

    Debug.Assert CistGestione.NumCisterneBitume = DBScambioDatiCisterneBitume.NumeroCisternePresenti

End Sub


Public Sub ControllaCisterneAllarmi(ByRef IdDescrizione As Integer, ByRef CodiceAllarme As String)
	Dim i As Integer
	Dim J As Integer
	Dim offset As Integer
	Dim tagOffset As Integer
	Dim spread As Integer
	Dim NumeroAllarme As Integer
	Dim cisterna As Integer
    
    If Not CP240.OPCDataCisterne.IsConnected Then
        Exit Sub
    End If
    
    NumeroAllarme = CInt(Right(CodiceAllarme, 3))
    
    If UCase(left(CodiceAllarme, 2)) = "PC" Then
        NumeroAllarme = NumeroAllarme + 10000
    End If

    spread = CistTAG_CisternaBitume2 - CistTAG_CisternaBitume1

    If NumeroAllarme <= 32 And NumeroAllarme <> 12 Then
            Call IngressoAllarmePresente(IdDescrizione, CP240.OPCDataCisterne.items(CistTAG_Bitume_Allarme0 + NumeroAllarme).Value)
    ElseIf NumeroAllarme >= 36 And NumeroAllarme <= 60 Then
        'niente!?
    ElseIf NumeroAllarme >= 61 And NumeroAllarme <= 67 Then
        If (NumeroAllarme <= 66) Then
            Call IngressoAllarmePresente(IdDescrizione, CP240.OPCDataCisterne.items(CistTAG_Emulsione_Allarme25 + NumeroAllarme - 61).Value)
        End If
        '
    ElseIf NumeroAllarme >= 32 And NumeroAllarme <= 35 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB200 Pompa Carico Bitume
        '-------------------------------------------------------------------------------------------------------------------------
        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_PompaCaricoBitume_AllarmeCodice).Value And 2 ^ (NumeroAllarme - 32)) <> 0)
        '
    ElseIf NumeroAllarme >= 68 And NumeroAllarme <= 71 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB202 Pompa Carico Emulsione
        '-------------------------------------------------------------------------------------------------------------------------
        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_PompaCaricoEmulsione_AllarmeCodice).Value And 2 ^ (NumeroAllarme - 68)) <> 0)
        '
    ElseIf NumeroAllarme >= 72 And NumeroAllarme <= 88 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB199 Comandi Ausiliari
        '-------------------------------------------------------------------------------------------------------------------------
        If (NumeroAllarme <= 84) Then
            Call IngressoAllarmePresente(IdDescrizione, CP240.OPCDataCisterne.items(CistTAG_AUX_RiscLineaCircBitume_DI_Termica + (NumeroAllarme - 72) * 2).Value)
        End If
        '
    ElseIf NumeroAllarme >= 89 And NumeroAllarme <= 338 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB101 Cisterna 1 Bitume .. DB110
        '-------------------------------------------------------------------------------------------------------------------------
        For i = 1 To CistGestione.NumCisterneBitume
            offset = 89 + (i - 1) * 25
            tagOffset = (i - 1) * spread
            For J = 0 To 4
                Select Case CodiceAllarme
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_Cisterna1_AllarmeCodiceGen + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 5, "000")       'mandata
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 10, "000")      'ritorno
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_Cisterna1_ValvEntrata2AllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 15, "000")      'carico
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 20, "000")      'aux
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                End Select
            Next J
        Next i
    ElseIf NumeroAllarme >= 339 And NumeroAllarme <= 588 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB301 Cisterna 1 Emulsione .. DB310
        '-------------------------------------------------------------------------------------------------------------------------
        For i = 1 To CistGestione.NumCisterneEmulsione
            offset = 339 + (i - 1) * 25
            tagOffset = (i - 1) * spread

            For J = 0 To 4
                Select Case CodiceAllarme
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_Cisterna1_AllarmeCodiceGen + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 5, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_Cisterna1_ValvMandataAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 10, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_Cisterna1_ValvRitornoAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 15, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_Cisterna1_ValvCaricoAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 20, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_Cisterna1_ValvAuxAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                End Select
            Next J
        Next i
    ElseIf NumeroAllarme >= 589 And NumeroAllarme <= 838 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB401 Cisterna 1 Combustibile .. DB410
        '-------------------------------------------------------------------------------------------------------------------------
        For i = 1 To CistGestione.NumCisterneCombustibile
            offset = 589 + (i - 1) * 25
            tagOffset = (i - 1) * spread

            For J = 0 To 4
                Select Case CodiceAllarme
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_Cisterna1_AllarmeCodiceGen + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 5, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_Cisterna1_ValvMandataAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 10, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_Cisterna1_ValvRitornoAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 15, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_Cisterna1_ValvCaricoAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J + 20, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_Cisterna1_ValvAuxAllarmeCodice + tagOffset).Value And 2 ^ (J)) <> 0)
                End Select
            Next J
        Next i
    ElseIf NumeroAllarme >= 879 And NumeroAllarme <= 968 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB8 Regolazioni temperature
        '-------------------------------------------------------------------------------------------------------------------------
        For i = 1 To CistGestione.NumCisterneBitume
            offset = (i - 1)
            Select Case CodiceAllarme
                Case "CI" & Format(879 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_DI_SicRiscValvCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
                Case "CI" & Format(880 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_DI_SicRiscBoostCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
                Case "CI" & Format(881 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Bitume_DI_TermicaRiscCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
            End Select
        Next i
        For i = 1 To CistGestione.NumCisterneEmulsione
            offset = (i - 1)
            Select Case CodiceAllarme
                Case "CI" & Format(909 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_DI_SicRiscValvCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
                Case "CI" & Format(910 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_DI_SicRiscBoostCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
                Case "CI" & Format(911 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_DI_TermicaRiscCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
            End Select
        Next i
        For i = 1 To CistGestione.NumCisterneCombustibile
            offset = (i - 1)
            Select Case CodiceAllarme
                Case "CI" & Format(939 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_DI_SicRiscValvCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
                Case "CI" & Format(940 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_DI_SicRiscBoostCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
                Case "CI" & Format(941 + offset * 3, "000")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Combustibile_DI_TermicaRiscCisterna1 + offset).Value And 2 ^ (i)) <> 0)
                    Exit Sub
            End Select
        Next i
    ElseIf NumeroAllarme >= 969 And NumeroAllarme <= 977 Then
        'DISPONIBILI
        '
    ElseIf NumeroAllarme >= 978 And NumeroAllarme <= 988 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB49 Allarmi Operazioni Bitume
        '-------------------------------------------------------------------------------------------------------------------------
        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCDataCisterne.items(CistTAG_Emulsione_Operazioni_Allarme0 + NumeroAllarme - 978).Value))
        '
    ElseIf NumeroAllarme >= 990 And NumeroAllarme <= 997 Then
        'DISPONIBILI
'        '
    ElseIf NumeroAllarme >= 10001 And NumeroAllarme <= 10198 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB20 Gestione Valvole Circuito Bitume
        '-------------------------------------------------------------------------------------------------------------------------
        cisterna = Mid(CodiceAllarme, 3, 2)
        For i = 0 To 7
            Select Case CodiceAllarme
                Case "PC" & Format(cisterna, "00") & Format(i + 1, "0")
                    Call IngressoAllarmePresente(IdDescrizione, (ValvolaCircuitoBitume(cisterna).Codice_Allarme And 2 ^ (i)) <> 0)
                    Exit Sub
            End Select
        Next i
    ElseIf NumeroAllarme >= 10201 And NumeroAllarme <= 10338 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB21 Gestione Valvole Circuito Emulsione
        '-------------------------------------------------------------------------------------------------------------------------
        cisterna = Mid(CodiceAllarme, 3, 2) - 20
        For i = 0 To 7
            Select Case CodiceAllarme
                Case "PC" & Format(cisterna + 20, "00") & Format(i + 1, "0")
                    Call IngressoAllarmePresente(IdDescrizione, (ValvolaCircuitoEmulsione(cisterna).Codice_Allarme And 2 ^ (i)) <> 0)
                    Exit Sub
            End Select
        Next i
    ElseIf NumeroAllarme >= 10341 And NumeroAllarme <= 10438 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi DB22 Gestione Valvole Circuito Combustibile
        '-------------------------------------------------------------------------------------------------------------------------
        cisterna = Mid(CodiceAllarme, 3, 2) - 34
        For i = 0 To 7
            Select Case CodiceAllarme
                Case "PC" & Format(cisterna + 34, "00") & Format(i + 1, "0")
                    Call IngressoAllarmePresente(IdDescrizione, (ValvolaCircuitoCombustibile(cisterna).Codice_Allarme And 2 ^ (i)) <> 0)
                    Exit Sub
            End Select
        Next i

    End If


End Sub


Public Sub GestioneMUPComandiCisterne(indice As Integer)

   If Not CP240.OPCDataCisterne.IsConnected Then
        '20160312
        If CistGestione.Gestione = GestionePLC Then
            LogInserisci False, "GestioneCisternePLC.GestioneMUPComandiCisterne", "OPCDataCisterne not connected"
        End If
        '
        Exit Sub
    End If
    
    Select Case indice
        Case 0  'start
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_CMD_StartOperazione_1).Value = DBScambioDatiCisterneBitume.StartOperazioneCisterne
        
        Case 1  'stop
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_CMD_StopOperazione_1).Value = DBScambioDatiCisterneBitume.StopOperazioneCisterne
            
        Case 10
            DBScambioDatiCisterneEmulsione.StartCambioCistCarico = False
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_CMD_StartOperazioneCisterna).Value = DBScambioDatiCisterneEmulsione.StartCambioCistCarico
            
        Case 30
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_CMD_StartOperazione_2).Value = False
            
    End Select

End Sub

Public Sub GestioneMDownComandiCisterne(indice As Integer)
    
'20151027
    If CistGestione.Gestione = GestioneSemplificata Then
        Select Case indice
            Case 2 'Arresto con urgenza
                CP240.cmbGestioneCisterne(14).ListIndex = 0
                CP240.cmbGestioneCisterne(6).ListIndex = 0
        End Select
    End If
'

    If Not CP240.OPCDataCisterne.IsConnected Then
        '20160312
        If CistGestione.Gestione = GestionePLC Then
            LogInserisci False, "GestioneCisternePLC.GestioneMUPComandiCisterne", "OPCDataCisterne not connected"
        End If
        '
        Exit Sub
    End If
    
    Select Case indice
        Case 0  'start
            'controllo di coerenza sul mandata e carico nel caso di ricircolo
            If (CP240.cmbGestioneCisterne(0).ListIndex = 3 And (CP240.cmbGestioneCisterne(1).ListIndex <> CP240.cmbGestioneCisterne(2).ListIndex)) _
                Or (CP240.cmbGestioneCisterne(5).ListIndex = 5 And (CP240.cmbGestioneCisterne(3).ListIndex <> CP240.cmbGestioneCisterne(4).ListIndex)) Then
                ShowMsgBox LoadXLSString(1466), vbOKOnly, vbExclamation, -1, -1, True
                Exit Sub
            End If

            'controllo di coerenza sul mandata e carico nel caso di travaso
            If (CP240.cmbGestioneCisterne(0).ListIndex = 2 And (CP240.cmbGestioneCisterne(1).ListIndex = CP240.cmbGestioneCisterne(2).ListIndex)) _
                Or (CP240.cmbGestioneCisterne(5).ListIndex = 2 And (CP240.cmbGestioneCisterne(3).ListIndex = CP240.cmbGestioneCisterne(4).ListIndex)) Then
                
                ShowMsgBox LoadXLSString(1471), vbOKOnly, vbExclamation, -1, -1, True
                Exit Sub
            End If

            DBScambioDatiCisterneBitume.StartOperazioneCisterne = True
            DBScambioDatiCisterneBitume.StopOperazioneCisterne = False
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_ArrestoEmergenzaValvole).Value = False
            
        Case 1  'stop
            DBScambioDatiCisterneBitume.StartOperazioneCisterne = False
            DBScambioDatiCisterneBitume.StopOperazioneCisterne = True

        Case 4 'Arresto con urgenza
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_ArrestoEmergenzaValvole).Value = True
            
        Case 10
            DBScambioDatiCisterneEmulsione.StartCambioCistCarico = True
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_CMD_StartOperazioneCisterna).Value = DBScambioDatiCisterneEmulsione.StartCambioCistCarico
            DBScambioDatiCisterneEmulsione.StopCambioCistCarico = False
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_CMD_StopOperazioneCisterna).Value = DBScambioDatiCisterneEmulsione.StopCambioCistCarico
            'Arresto con urgenza
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_ArrestoEmergenzaValvole).Value = False

        Case 11
            DBScambioDatiCisterneEmulsione.StopCambioCistCarico = True
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_CMD_StopOperazioneCisterna).Value = DBScambioDatiCisterneEmulsione.StopCambioCistCarico

        Case 12
            DBScambioDatiCisterneEmulsione.ForzaOperazioniSuAllarme = Not (DBScambioDatiCisterneEmulsione.ForzaOperazioniSuAllarme)
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_ForzaOperazioneSuAllarme).Value = DBScambioDatiCisterneEmulsione.ForzaOperazioniSuAllarme

        Case 14 'Arresto con urgenza
            CP240.OPCDataCisterne.items.item(CistTAG_Emulsione_ArrestoEmergenzaValvole).Value = True

        Case 6, 16, 26 '   Comandi ausiliari pannello cisterne
            If (CistGestione.Gestione = GestionePLC And CistGestione.InclusioneComandi And Not FrmComandiCisterneVisibile) Then
                FrmComandiCisterneVisibile = True
                FrmComandiCisterne.Show vbModeless, CP240
            End If
            
        Case 30
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_CMD_StartOperazione_2).Value = True
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_CMD_StopOperazione_2).Value = False
        Case 31
            CP240.OPCDataCisterne.items.item(CistTAG_Bitume_CMD_StopOperazione_2).Value = True

    End Select
End Sub

Public Sub GestioneComboCisterne(indice As Integer)

    'cmbGestioneCisterne(0) = selezione operazione pompa di carico
    'cmbGestioneCisterne(1) = cisterna di mandata per operazioni con pompa di carico
    'cmbGestioneCisterne(2) = cisterna di carico per operazioni con pompa di carico
    'cmbGestioneCisterne(3) = cisterna di mandata per operazioni con pompa di alimentazione
    'cmbGestioneCisterne(4) = cisterna di carico per operazioni con pompa di alimentazione
    'cmbGestioneCisterne(5) = selezione operazione pompa alimentazione

    With CP240

        '20160218
        ''20151027
        ''If Not .OPCDataCisterne.IsConnected Then
        'If Not .OPCDataCisterne.IsConnected And (CistGestione.Gestione <> GestioneSemplificata) Then
        If (Not IsPlcConnected(CP240.OPCDataCisterne) And (CistGestione.Gestione <> GestioneSemplificata)) Then
        '
            Exit Sub
        End If

        'Controlli sulla selezione dell'operazione -> con certe operazioni mandata o carico non devono essere abilitate
        Select Case .cmbGestioneCisterne(0).ListIndex
            Case 1  'carico
                .cmbGestioneCisterne(1).enabled = False
                .cmbGestioneCisterne(2).enabled = True
            Case Else
                .cmbGestioneCisterne(1).enabled = True
                .cmbGestioneCisterne(2).enabled = True
        End Select
        
        Select Case .cmbGestioneCisterne(5).ListIndex
            Case 1  'carico
                .cmbGestioneCisterne(3).enabled = False
                .cmbGestioneCisterne(4).enabled = True
            Case 3  'alimentazione esterna
                .cmbGestioneCisterne(3).enabled = False
                .cmbGestioneCisterne(4).enabled = False
            Case 4  'alimentazione torre
                .cmbGestioneCisterne(3).enabled = True
                .cmbGestioneCisterne(4).enabled = False
            Case Else
                .cmbGestioneCisterne(3).enabled = True
                .cmbGestioneCisterne(4).enabled = True
        End Select
        
        'caso particolare di alimentazione torre con doppia selezione 0
        If .cmbGestioneCisterne(5).ListIndex = 0 And .cmbGestioneCisterne(0).ListIndex = 0 Then
            .cmbGestioneCisterne(4).enabled = False
        End If

        Select Case indice
            'BITUME
            Case 0
                DBScambioDatiCisterneBitume.CodiceOperazioneCarico = CInt(.cmbGestioneCisterne(indice).ListIndex)
                .OPCDataCisterne.items.item(CistTAG_SelOperazionePompaCarico).Value = DBScambioDatiCisterneBitume.CodiceOperazioneCarico

            Case 1
                DBScambioDatiCisterneBitume.SelCistMandataPompaCarico = CInt(.cmbGestioneCisterne(indice).ListIndex + 1)
                .OPCDataCisterne.items.item(CistTAG_SelCisternaMandataPompaCarico).Value = DBScambioDatiCisterneBitume.SelCistMandataPompaCarico

            Case 2
                DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico = CInt(.cmbGestioneCisterne(indice).ListIndex + 1)
                .OPCDataCisterne.items.item(CistTAG_SelCisternaCaricoPompaCarico).Value = DBScambioDatiCisterneBitume.SelCistCaricoPompaCarico

            Case 3
                If (.cmbGestioneCisterne(5).ListIndex = 0 And .cmbGestioneCisterne(0).ListIndex = 0) Or (.cmbGestioneCisterne(5).ListIndex = 4) Then
                    DBScambioDatiCisterneBitume.SelCistAlimentazioneTorre = CInt(.cmbGestioneCisterne(indice).ListIndex + 1)
                    .OPCDataCisterne.items.item(CistTAG_SelAlimentazioneTorrePompaAlimentazione).Value = DBScambioDatiCisterneBitume.SelCistAlimentazioneTorre
                Else
                    DBScambioDatiCisterneBitume.SelCistMandataPompaAlimentaz = CInt(.cmbGestioneCisterne(indice).ListIndex + 1)
                    .OPCDataCisterne.items.item(CistTAG_SelCisternaMandataPompaAlimentazione).Value = DBScambioDatiCisterneBitume.SelCistMandataPompaAlimentaz
                End If

            Case 4
                DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz = CInt(.cmbGestioneCisterne(indice).ListIndex + 1)
                .OPCDataCisterne.items.item(CistTAG_SelCisternaCaricoPompaAlimentazione).Value = DBScambioDatiCisterneBitume.SelCistCaricoPompaAlimentaz

            Case 5
                DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione = CInt(.cmbGestioneCisterne(indice).ListIndex)
                .OPCDataCisterne.items.item(CistTAG_SelOperazionePompaAlimentazione).Value = DBScambioDatiCisterneBitume.CodiceOperazioneAlimentazione
            '20151027
            Case 6
                DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL2 = CP240.cmbGestioneCisterne(6).ListIndex
                Exit Sub
            '
            'OPERAZIONE emulsione
            Case 10
                DBScambioDatiCisterneEmulsione.CodiceOperazione = CalcolaCodiceOperazioneCisterna(3, CInt(.cmbGestioneCisterne(indice).ListIndex))
            'SELEZIONE x operazioni particolari emulsione
            Case 11
            'DESTINAZIONE operazione emulsione
            Case 12
                DBScambioDatiCisterneEmulsione.SelezioneCistPerOperazione = CInt(Null2zero(.cmbGestioneCisterne(indice).text))
            'SELEZIONE cisterna emulsione
            Case 13
                DBScambioDatiCisterneEmulsione.CisternaNuovaSelezione = CInt(Null2zero(.cmbGestioneCisterne(indice).text))
            '20151027
            Case 14
                DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL1 = CP240.cmbGestioneCisterne(14).ListIndex
                Exit Sub
            '
            'OPERAZIONE combustibile
            Case 20
                DBScambioDatiCisterneCombustibile.CodiceOperazione = CInt(.cmbGestioneCisterne(indice).ListIndex)
            'SELEZIONE x operazioni particolari  combustibile
            Case 21
            'DESTINAZIONE operazione combustibile
            Case 22
                DBScambioDatiCisterneCombustibile.SelezioneCistPerOperazione = CInt(Null2zero(.cmbGestioneCisterne(indice).text))
            'SELEZIONE cisterna combustibile
            Case 23
                DBScambioDatiCisterneCombustibile.CisternaNuovaSelezione = CInt(Null2zero(.cmbGestioneCisterne(indice).text))

        End Select


        .OPCDataCisterne.items.item(CistTAG_Emulsione_CodiceOperazioneCisternaDaEseguire).Value = DBScambioDatiCisterneEmulsione.CodiceOperazione
        .OPCDataCisterne.items.item(CistTAG_Emulsione_NumeroCisternaCarico).Value = DBScambioDatiCisterneEmulsione.SelezioneCistPerOperazione
        .OPCDataCisterne.items.item(CistTAG_Emulsione_NumeroCisternaAlimImp_NEW).Value = DBScambioDatiCisterneEmulsione.CisternaNuovaSelezione
        .OPCDataCisterne.items.item(CistTAG_Emulsione_CodiceOperazioneCisternaDaEseguire).Value = DBScambioDatiCisterneEmulsione.CodiceOperazione

        If DBScambioDatiCisterneEmulsione.SelezioneCistPerOperazione Then
            .OPCDataCisterne.items.item(CistTAG_Emulsione_NumeroCisternaCarico).Value = DBScambioDatiCisterneEmulsione.SelezioneCistPerOperazione
        End If

        If DBScambioDatiCisterneEmulsione.CisternaNuovaSelezione <> 0 Then
            .OPCDataCisterne.items.item(CistTAG_Emulsione_NumeroCisternaAlimImp_NEW).Value = DBScambioDatiCisterneEmulsione.CisternaNuovaSelezione
        End If
        
    End With

End Sub

Public Function CalcolaCodiceOperazioneCisterna(OperazioneCircuito As Integer, Selezione As Integer) As Integer
	'OperazioneCircuito = 3 --> Operazione Emulsione

	Dim i As Integer
	Dim K As Integer
    
    Select Case OperazioneCircuito
      
        Case 3
            For i = 0 To MaxListaOperazioniCircuito - 1
                If CistGestione.ListaOperazioniEmulsione(i) Then
                    If K = Selezione Then
                        CalcolaCodiceOperazioneCisterna = i
                        Exit Function
                    End If
                    K = K + 1
                End If
            Next i
    End Select
    
End Function

Public Sub PompaCircuitoLegante_Change(ritorno As Boolean, CodiceAllarme As Integer, ByRef immagine As Object)

    If CodiceAllarme <> 0 Then
        immagine.Picture = LoadPicture(GraphicPath + "Pompa circolazione_ERR.gif")
    ElseIf ritorno Then
        immagine.Picture = LoadPicture(GraphicPath + "Pompa circolazione_ON.gif")
    Else
        immagine.Picture = LoadPicture(GraphicPath + "Pompa circolazione_OFF.gif")
    End If

End Sub


Public Sub GraficaValvolaStandard_Change(valvola As Integer, ByRef immagine As Object, TipoValvola As TipoValvolaEnum)
    
    'Codifica del tipo di grafica da rappresentare (TipoValvolaEnum):
    'automaticaorizzontale
    'automaticaverticale
    'manualeorizzontale
    'manualeverticale
    'trevieautomaticaorizzontale    'TODO
    'trevieautomaticaverticale      'TODO
    'treviemanualeorizzontale
    'treviemanualeverticale         'TODO
    
    
    With ValvolaCircuitoBitume(valvola)
        
        Select Case TipoValvola
        
            Case automaticaorizzontale
                
                If .Codice_Allarme <> 0 Or (.VALV_AP_Triggerata And .VALV_CH_Triggerata) Or (Not .VALV_AP_Triggerata And Not .VALV_CH_Triggerata) Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAORIZZERRORE", vbResBitmap)
                ElseIf .VALV_AP_Triggerata And Not .VALV_CH_Triggerata Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAORIZZON", vbResBitmap)
                Else
                    immagine.Picture = LoadResPicture("IDB_VALVOLAORIZZ", vbResBitmap)
                End If
                
            Case automaticaverticale
                
                If .Codice_Allarme <> 0 Or (.VALV_AP_Triggerata And .VALV_CH_Triggerata) Or (Not .VALV_AP_Triggerata And Not .VALV_CH_Triggerata) Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                ElseIf .VALV_AP_Triggerata And Not .VALV_CH_Triggerata Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
                Else
                    immagine.Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)
                End If
            
            Case manualeorizzontale
            
                If .Codice_Allarme <> 0 Or (.VALV_AP_Triggerata And .VALV_CH_Triggerata) Or (Not .VALV_AP_Triggerata And Not .VALV_CH_Triggerata) Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAORIZZERRORE", vbResBitmap)
                ElseIf .VALV_AP_Triggerata And Not .VALV_CH_Triggerata Then
                    immagine.Picture = LoadResPicture("IDB_VALVMANORIZON", vbResBitmap)
                Else
                    immagine.Picture = LoadResPicture("IDB_VALVMANORIZOFF", vbResBitmap)
                End If
                        
            Case manualeverticale
            
                If .Codice_Allarme <> 0 Or (.VALV_AP_Triggerata And .VALV_CH_Triggerata) Or (Not .VALV_AP_Triggerata And Not .VALV_CH_Triggerata) Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                ElseIf .VALV_AP_Triggerata And Not .VALV_CH_Triggerata Then
                    immagine.Picture = LoadResPicture("IDB_VALVMANVERTOFF", vbResBitmap)
                Else
                    immagine.Picture = LoadResPicture("IDB_VALVMANVERTOFF", vbResBitmap)
                End If
                        
            Case treviemanualeorizzontale
                        
                If .Codice_Allarme <> 0 Then
                    immagine.Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                ElseIf .VALV_AP_Triggerata And Not .VALV_CH_Triggerata Then
                    immagine.Picture = LoadResPicture("IDB_VALV_3V_MAN_LINEA", vbResBitmap)
                ElseIf .VALV_CH_Triggerata And Not .VALV_AP_Triggerata Then
                    immagine.Picture = LoadResPicture("IDB_VALV_3V_MAN_APDX", vbResBitmap)
                Else
                    'immagine.Picture = LoadResPicture("IDB_VALV_3V_MAN_NEUTRA", vbResBitmap)
                End If
                    
            End Select
    
    End With

End Sub

'20150505
Public Sub LeggiDatiPLCCisterneBitumeRid()

    Dim i, J As Integer
    Dim indice As Integer
    Dim offset As Integer
    Dim spread  As Integer
    Dim valoreInt As Integer
    Dim valoreBool As Boolean
    Dim digitaleModificato As Boolean
    Dim valoreByte As Byte
    Dim valoreLong As Long

On Error GoTo Errore

    If DEMO_VERSION Then
        Exit Sub
    End If

    If (CistGestione.Gestione <> GestioneSemplificata) Then
        Exit Sub
    End If


    With CP240.OPCData.items
                                
'---------------------------------------------------------
'parametri cisterna
'---------------------------------------------------------
        spread = CistRidTAG_CisternaBitume2 - CistRidTAG_CisternaBitume1
        
        For i = 1 To DBScambioDatiCisterneBitume.NumeroCisternePresenti
            offset = (i - 1) * spread

            CisternaLegante(i).LivMinimoRaggiunto = .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloMin_DI_Trigger).Value
            CisternaLegante(i).LivMassimoRaggiunto = .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloMax_DI_Trigger).Value
            CisternaLegante(i).SicurezzaMeccanicaLivello = .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloSic_DI_Trigger).Value

            If ( _
                CisternaLegante(i).ValLivelloPerc <> .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloPercentualeValore).Value Or _
                CisternaLegante(i).ValLivelloTon <> .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloTonValore).Value Or _
                CisternaLegante(i).ValLivelloTon <> CP240.PrbCistLivello(i - 1).caption _
            ) Then
            '
                CisternaLegante(i).ValLivelloPerc = .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloPercentualeValore).Value
                CisternaLegante(i).ValLivelloTon = .item(offset + CistRidTAG_Bitume_Cisterna1_LivelloTonValore).Value

                Call CistVisualizzaLivello( _
                    i - 1, _
                    CisternaLegante(i).ValLivelloPerc, _
                    RoundNumber(CisternaLegante(i).ValLivelloTon, 1) _
                    )
            End If

            If (CisternaLegante(i).ValTemperatura <> .item(offset + CistRidTAG_Bitume_Cisterna1_TempGradiValore).Value) Then
                CisternaLegante(i).ValTemperatura = .item(offset + CistRidTAG_Bitume_Cisterna1_TempGradiValore).Value
                Call CistVisualizzaTemperatura(i - 1, CisternaLegante(i).ValTemperatura)
            End If

            CisternaLegante(i).CodificaAllarmeCisterna = .item(offset + CistRidTAG_Bitume_Cisterna1_AllarmeCodiceGen).Value
            
        
            'Valvola Uscita1
            If ( _
                CisternaLegante(i).ValvolaApertaMandata <> .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger).Value Or _
                CisternaLegante(i).ValvolaChiusaMandata <> .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita1Close_DI_Trigger).Value Or _
                CisternaLegante(i).CodiceAllMandata <> CLng(.item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice).Value) _
            ) Then
                CisternaLegante(i).ValvolaApertaMandata = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita1Open_DI_Trigger).Value
                CisternaLegante(i).ValvolaChiusaMandata = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita1Close_DI_Trigger).Value
                CisternaLegante(i).CodiceAllMandata = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita1AllarmeCodice).Value

                Call CistVisualizzaValvolaUscita1( _
                    i - 1, _
                    CisternaLegante(i).ValvolaApertaMandata, _
                    CisternaLegante(i).ValvolaChiusaMandata, _
                    CisternaLegante(i).CodiceAllMandata <> 0 _
                    )
            End If
            
            'Valvola Uscita2
            If ( _
                CisternaLegante(i).ValvolaApertaCarico <> .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger).Value Or _
                CisternaLegante(i).ValvolaChiusaCarico <> .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita2Close_DI_Trigger).Value Or _
                CisternaLegante(i).CodiceAllCarico <> CLng(.item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice).Value) _
            ) Then
                CisternaLegante(i).ValvolaApertaCarico = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita2Open_DI_Trigger).Value
                CisternaLegante(i).ValvolaChiusaCarico = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita2Close_DI_Trigger).Value
                CisternaLegante(i).CodiceAllCarico = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvUscita2AllarmeCodice).Value

                Call CistVisualizzaValvolaUscita2( _
                    i - 1, _
                    CisternaLegante(i).ValvolaApertaCarico, _
                    CisternaLegante(i).ValvolaChiusaCarico, _
                    CisternaLegante(i).CodiceAllCarico <> 0 _
                    )
            End If

            'Valvola Entrata1
            If ( _
                CisternaLegante(i).ValvolaApertaRitorno <> .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger).Value Or _
                CisternaLegante(i).ValvolaChiusaRitorno <> .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata1Close_DI_Trigger).Value Or _
                CisternaLegante(i).CodiceAllRitorno <> CLng(.item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice).Value) _
            ) Then
                CisternaLegante(i).ValvolaApertaRitorno = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata1Open_DI_Trigger).Value
                CisternaLegante(i).ValvolaChiusaRitorno = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata1Close_DI_Trigger).Value
                CisternaLegante(i).CodiceAllRitorno = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata1AllarmeCodice).Value

                Call CistVisualizzaValvolaEntrata1( _
                    i - 1, _
                    CisternaLegante(i).ValvolaApertaRitorno, _
                    CisternaLegante(i).ValvolaChiusaRitorno, _
                    CisternaLegante(i).CodiceAllRitorno <> 0 _
                    )
            End If
                                            
            'valvola ausiliaria
            CisternaLegante(i).ValvolaApertaAux = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata2Open_DI_Trigger).Value
            CisternaLegante(i).ValvolaChiusaAux = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata2Close_DI_Trigger).Value
            CisternaLegante(i).CodiceAllAux = .item(offset + CistRidTAG_Bitume_Cisterna1_ValvEntrata2AllarmeCodice).Value
        Next i

        spread = CistRidTAG_Bitume_Cisterna1_Selezionata_PCL2 - CistRidTAG_Bitume_Cisterna1_Selezionata_PCL1
'        offset = CistRidTAG_Bitume_Cisterna1_Selezionata_PCL1
        For i = 1 To 2
            offset = (i - 1) * spread
            If i = 1 Then
            'PCL1
                For J = 1 To CistGestione.NumeroCistBitSuPCL1
                    valoreBool = .item(offset + (J - 1) + CistRidTAG_Bitume_Cisterna1_Selezionata_PCL1).Value
                    If (BooleanModificato(CisternaLegante(J).CisternaSelezionata, valoreBool, PlcInDigitali_Fatta)) Then
                        
'                        Call GestioneStatoCisterneRidotto
                        Call GestioneMaterialeCisterneRidotto
                    
                    End If
                Next J
            Else
            'PCL2
                For J = 1 To (CistGestione.NumCisterneBitume - CistGestione.NumeroCistBitSuPCL1)
                    valoreBool = .item(offset + (J - 1) + CistRidTAG_Bitume_Cisterna1_Selezionata_PCL1).Value
                    If (BooleanModificato(CisternaLegante(CistGestione.NumeroCistBitSuPCL1 + J).CisternaSelezionata, valoreBool, PlcInDigitali_Fatta)) Then
'                        Call GestioneStatoCisterneRidotto
                        Call GestioneMaterialeCisterneRidotto
                    End If
                Next J
            End If
            
            Select Case i
                Case 1
                    valoreBool = .item(offset + CistRidTAG_Timeout_Selezione_PCL1).Value
                    If (BooleanModificato(DBScambioDatiCisterneBitume.RidottoTimeoutSelezionePCL1, valoreBool, PlcInDigitali_Fatta)) Then
'                        Call GestioneStatoCisterneRidotto
                        Call GestioneMaterialeCisterneRidotto
                    End If
                    
                    valoreBool = .item(offset + CistRidTAG_Attesa_Selezione_PCL1).Value
                    If (BooleanModificato(DBScambioDatiCisterneBitume.RidottoAttesaSelezionePCL1, valoreBool, PlcInDigitali_Fatta)) Then
'                        Call GestioneStatoCisterneRidotto
                        Call GestioneMaterialeCisterneRidotto
                    End If
                    
                    If Not SbloccoSelezioneCisternaRid And CistGestione.InclusioneComandi Then '20151028
                        DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL1 = .item(offset + CistRidTAG_Selezione_Cisterna_Bitume_PCL1).Value
                    End If
                
                Case 2
                    valoreBool = .item(offset + CistRidTAG_Timeout_Selezione_PCL1).Value
                    If (BooleanModificato(DBScambioDatiCisterneBitume.RidottoTimeoutSelezionePCL2, valoreBool, PlcInDigitali_Fatta)) Then
'                        Call GestioneStatoCisterneRidotto
                        Call GestioneMaterialeCisterneRidotto
                    End If
                    
                    valoreBool = .item(offset + CistRidTAG_Attesa_Selezione_PCL1).Value
                    If (BooleanModificato(DBScambioDatiCisterneBitume.RidottoAttesaSelezionePCL2, valoreBool, PlcInDigitali_Fatta)) Then
'                        Call GestioneStatoCisterneRidotto
                        Call GestioneMaterialeCisterneRidotto
                    End If
            
                    If Not SbloccoSelezioneCisternaRid And CistGestione.InclusioneComandi Then '20151028
                        DBScambioDatiCisterneBitume.RidottoSetSelezioneCisternaBitumePCL2 = .item(offset + CistRidTAG_Selezione_Cisterna_Bitume_PCL1).Value
                    End If
                        
            End Select
        Next i


        PlcInDigitali_Fatta = True
        plcInAnalogici_Fatta = True

    End With
    
    
    Exit Sub
Errore:
    LogInserisci True, "CST-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20151028
Public Sub ControllaCisterneAllarmiRidotto(ByRef IdDescrizione As Integer, ByRef CodiceAllarme As String)
	Dim i As Integer
	Dim J As Integer
	Dim offset As Integer
	Dim tagOffset As Integer
	Dim spread As Integer
	Dim NumeroAllarme As Integer
	Dim cisterna As Integer
    
    If CistGestione.Gestione <> GestioneSemplificata Then
        Exit Sub
    End If
    
    NumeroAllarme = CInt(Right(CodiceAllarme, 3))
    
    spread = CistRidTAG_Bitume_Cisterna2_AllarmeCodiceGen - CistRidTAG_Bitume_Cisterna1_AllarmeCodiceGen
                    
    If NumeroAllarme >= 89 And NumeroAllarme <= 338 Then
        '-------------------------------------------------------------------------------------------------------------------------
        'Codifica allarmi
        '-------------------------------------------------------------------------------------------------------------------------
        For i = 1 To CistGestione.NumCisterneBitume
            offset = 89 + (i - 1) * 25
            tagOffset = (i - 1) * spread
            For J = 0 To 4
                Select Case CodiceAllarme
                'uso i bit da 0 a 4
                    Case "CI" & Format(offset + J, "000")
                        Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCData.items(CistRidTAG_Bitume_Cisterna1_AllarmeCodiceGen + tagOffset).Value And 2 ^ (J)) <> 0)
                End Select
            Next J
        Next i
    End If
    
                
End Sub


