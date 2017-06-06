Attribute VB_Name = "ImpastiManuali"
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Creo una nuova tabella per memorizzare gli impasti fatti manualmente.
'
'Campi:  DataOra
'        Aggregati
'        Filler
'        Bitume
'  ???   MemAggregati(7)  ???
'  ???   MemFiller(2)   ???
'
'Per questa tabella devo prevedere un "BROWSE" con le funzioni di
'INSERIMENTO (vedi punto 6), CANCELLAZIONE, RICERCA, STAMPA
'
'1. Non li metto nella tabella StoricoImpasti perchè servirebbe un record
'   correlato nella tabella Dosaggio per la ricetta.
'2. La suddivisione dei pesi tra i vari aggregati la posso fare solo se
'   non è andata via la corrente, ovvero se nelle caselle della pagina
'   dei netti ho i valori realmente pesati, altrimenti metto solo un campo
'   per il totale degli aggregati. Idem per il Filler.
'3. Secondo me è meglio se metto solo il totale, perchè se ho fatto le pesate
'   dal quadro anzichè dal pc cosa metto? Se il materiale che mi trovo pesato
'   viene da uno scarico contemporaneo? Se peso 1000 e scarico solo 500 so
'   comunque come sono composti i 500? Se scarico una bilancia che era in
'   sicurezza e non voglio buttare via il materiale bianco ma lo impasto lo
'   faccio in più impasti.
'4. Problema per il filler di apporto, SAPABA vuole vederne il consumo! Per gli
'   aggregati me ne frega relativamente poco o nulla!
'5. Se nel mescolatore ho già del materiale come mi comporto? Può essere bianco,
'   nero o parzialmente nero! Il peso chi lo sa?
'6. L'operatore potrebbe immettere i dati manualmente?
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

'NUOVA GESTIONE PESATE MANUALI VERSIONE PLUS
' In questa versione memorizzo SEMPRE gli scarichi manuali per via della gestione materiali sempre attiva.
' Per ogni bilancia abbiamo un totalizzatore generale e diversi contatori indipendenti per ogni componente. Anche nello storico degli scarichi manuali
' sono presenti per ogni bilancia sia i contatori singoli che quello totale.

' I casi possibli considerati sono i seguenti:
' 1) Appena passo le portine in manuale premo un pulsante di pesata manuale di una bilancia e il peso presente era zero (o in tara):
'    acquisisco i valori delle pesate con i contatori dedicati dei componenti e le inserisco nello storico quando viene scaricato il mescolatore.
'    La somma dei contatori (salvo approssimazioni) sara' uguale al totale della bilancia;
' 2) Appena passo le portine in manuale premo un pulsante di pesata manuale di una bilancia e il peso presente non era zero: aggiungo il peso gia' presente
'    a quello totale della bilancia e procedo con il punto 1 aggiungendo le singole pesate ai contatori dedicati dei componenti;
'    La somma dei contatori sara' diversa dal totale della bilancia e la distribuzione del peso verra' elaborata dal Cybertronic plus secondo criteri
'    da definire.
' 3) Appena passo le portine in manuale premo un pulsante di scarico manuale di una bilancia e il peso presente era zero (o in tara). La storicizzazione
'    avverra' solo se almeno una delle bilance ha un peso da conteggiare.
' 4) Appena passo le portine in manuale premo un pulsante di scarico manuale di una bilancia e il peso presente non era zero: aggiungo il peso gia' presente
'    a quello totale della bilancia. Se successivamente premo un pulsante di pesata manuale di una bilancia verrano conteggiati i pesi successivi nel modo
'    normale come al punto 1.
'    La somma dei contatori sara' diversa dal totale della bilancia e la distribuzione del peso verra' elaborata dal Cybertronic plus secondo criteri
'    da definire.
' 5) Appena passo le portine in manuale premo un pulsante di scarico manuale di una bilancia e il peso presente non era zero: aggiungo il peso gia' presente
'    a quello totale della bilancia. Se successivamente non premo nessun pulsante di pesata manuale di almeno una bilancia e scarico direttamente il mescolatore
'    ed era stato premuto in precedenza l'arresto di emergenza del ciclo di dosaggio, attivero' un messaggio di richiesta per l'operatore per inserire o no
'    questo impasto nello storico dei dosaggi automatici: in caso affermativo l'impasto non comparira' nei dosaggi manuali.

'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Option Explicit

Public PesoTotaleAggregatiManuale As Double
Public PesoTotaleFillerManuale As Double
Public PesoTotaleBitumeManuale As Double
Public PesoTotaleRiciclatoManuale As Double
Public PesoTotaleViatopManuale As Double
'20160421
Public PesoTotaleViatopScarMixer1Manuale As Double
Public PesoTotaleViatopScarMixer2Manuale As Double
'20160421

'/////////////////////////////////////////////////////////////////////////////
'Ogni volta che scarico gli aggregati, filler o bitume devo salvarmi in
'una variabile il peso, per fare poi la differenza quando smetto di
'scaricare.
'/////////////////////////////////////////////////////////////////////////////
Public PesoAggregatiManuale As Double
Public PesoFillerManuale As Double
Public PesoBitumeManuale As Double
Public PesoRiciclatoManuale As Double
Public PesoViatopManuale As Double
'20160421
Public PesoViatopScarMixer1Manuale As Double
Public PesoViatopScarMixer2Manuale As Double
'20160421

Public Type ScManualeComponente
    Peso As Double
    PesoBuffer As Double
    ScAttivato As Boolean
    TempoDosaggioStart As Long
    TempoDosaggioStop As Long
End Type

Public ScManualeAggregati(CompAggregato1 To CompNonVagliato) As ScManualeComponente
Public ScManualeFiller(CompFiller1 To CompFiller3) As ScManualeComponente
Public ScManualeBitume(CompLegante1 To CompLegante3) As ScManualeComponente
Public ScManualeRiciclato(CompRAP To CompRAPSiwa) As ScManualeComponente
'20170302
'Public ScManualeViatop(CompViatop To CompViatop) As ScManualeComponente 'per ora ha un solo elemento, predisposto per piu' componenti
Public ScManualeViatop As ScManualeComponente
'
Public ScManualeViatopScarMixer1 As ScManualeComponente '20160421
Public ScManualeViatopScarMixer2 As ScManualeComponente '20160421
Public ScManualeAddMesc As ScManualeComponente
Public ScManualeAddBac As ScManualeComponente
Public ScManualeAddSacchi As ScManualeComponente
Public ScManualeAcqua As ScManualeComponente

Public CodiceCompScManuale As Integer
Public FronteScMescMemManuali As Boolean
Public FronteScCicloneViatopManuale As Boolean
Public TotaleKgMescImpastoMan As Double
Public MemPesataManualeAggregatiAttivata As Boolean
Public MemPesataManualeFillerAttivata As Boolean
Public MemPesataManualeBitumeAttivata As Boolean
Public MemPesataManualeRiciclatoAttivata As Boolean
Public MemPesataManualeViatopAttivata As Boolean
'20160421
Public MemPesataManualeViatopScarMixer1Attivata As Boolean
Public MemPesataManualeViatopScarMixer2Attivata As Boolean
'20160421
'
Public MemFronteEmergenzaDosaggio As Boolean


Public Sub ResettaTimerAggregatiMan()
Dim indice As Integer

    Call AbilitaPulsantiPortineMan(False)
    
    FrmGestioneTimer.TimerAggregatiMan.enabled = False
    FrmGestioneTimer.TimerAggregatiMan.Interval = 1500
    FrmGestioneTimer.TimerAggregatiMan.enabled = True
End Sub

Public Sub ResettaTimerFillerMan()

    Call AbilitaPulsantiPortineMan(False)

    FrmGestioneTimer.TimerFillerMan.enabled = False
    FrmGestioneTimer.TimerFillerMan.Interval = 1500
    FrmGestioneTimer.TimerFillerMan.enabled = True
End Sub

Public Sub ResettaTimerBitumeMan()

    Call AbilitaPulsantiPortineMan(False)

    FrmGestioneTimer.TimerBitumeMan.enabled = False
    FrmGestioneTimer.TimerBitumeMan.Interval = 1500
    FrmGestioneTimer.TimerBitumeMan.enabled = True
End Sub

Public Sub ResettaTimerRiciclatoMan()
        
    Call AbilitaPulsantiPortineMan(False)
                                
    FrmGestioneTimer.TimerRiciclatoMan.enabled = False
    FrmGestioneTimer.TimerRiciclatoMan.Interval = 1500
    FrmGestioneTimer.TimerRiciclatoMan.enabled = True
End Sub


Public Sub ResettaTimerViatopMan()
    
    Call AbilitaPulsantiPortineMan(False)
        
    FrmGestioneTimer.TimerViatopMan.enabled = False
    FrmGestioneTimer.TimerViatopMan.Interval = 1500
    FrmGestioneTimer.TimerViatopMan.enabled = True
End Sub

'20160421
Public Sub ResettaTimerViatopScarMixer1Man()

    Call AbilitaPulsantiPortineMan(False)
    
    FrmGestioneTimer.TimerViatopScarMixer1Man.enabled = False
    FrmGestioneTimer.TimerViatopScarMixer1Man.Interval = 1500
    FrmGestioneTimer.TimerViatopScarMixer1Man.enabled = True
End Sub

Public Sub ResettaTimerViatopScarMixer2Man()

    Call AbilitaPulsantiPortineMan(False)
    
    FrmGestioneTimer.TimerViatopScarMixer2Man.enabled = False
    FrmGestioneTimer.TimerViatopScarMixer2Man.Interval = 1500
    FrmGestioneTimer.TimerViatopScarMixer2Man.enabled = True
End Sub
'20160421

Public Sub MemorizzaManualiDB()
Dim rs As New adodb.Recordset
Dim appoggio As Double

    '20160421
    'appoggio = PesoTotaleAggregatiManuale + PesoTotaleFillerManuale + PesoTotaleBitumeManuale + PesoTotaleRiciclatoManuale + PesoTotaleViatopManuale
    appoggio = PesoTotaleAggregatiManuale + PesoTotaleFillerManuale + PesoTotaleBitumeManuale + PesoTotaleRiciclatoManuale + PesoTotaleViatopManuale + PesoTotaleViatopScarMixer1Manuale + PesoTotaleViatopScarMixer2Manuale
    '20160421
    
    If appoggio = 0 Then
        Exit Sub
    End If

    'Scrivo i dati nella tabella
    With rs
        Set .ActiveConnection = DBcon
        .Source = "Select * From StoricoPesateManuali;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With
    
    rs.AddNew
    rs!DataOra = Now()
    rs!AggregatiTot = Round(PesoTotaleAggregatiManuale, 1)
    rs!FillerTot = Round(PesoTotaleFillerManuale, 1)
    rs!BitumeTot = Round(PesoTotaleBitumeManuale, 1)
    rs!RiciclatoTot = Round(PesoTotaleRiciclatoManuale, 1)
    rs!ViatopTot = Round(PesoTotaleViatopManuale, 1)
    rs!AddMesc = Round(ScManualeAddMesc.Peso, 1)
    rs!AddBac = Round(ScManualeAddBac.Peso, 1)
    rs!AddSacchi = Round(ScManualeAddSacchi.Peso, 1)
    rs!NumSacchi = Abs(ScManualeAddSacchi.ScAttivato)
    rs!AddMesc = Round(ScManualeAddMesc.Peso, 1)
    rs!AddAcqua = Round(ScManualeAcqua.Peso, 1)
    rs!DaGestireComeConsumo = True
    rs!Aggregato1 = Round(ScManualeAggregati(CompAggregato1).Peso, 1)
    rs!Aggregato2 = Round(ScManualeAggregati(CompAggregato2).Peso, 1)
    rs!Aggregato3 = Round(ScManualeAggregati(CompAggregato3).Peso, 1)
    rs!Aggregato4 = Round(ScManualeAggregati(CompAggregato4).Peso, 1)
    rs!Aggregato5 = Round(ScManualeAggregati(CompAggregato5).Peso, 1)
    rs!Aggregato6 = Round(ScManualeAggregati(CompAggregato6).Peso, 1)
    rs!Aggregato7 = Round(ScManualeAggregati(CompRAPAgg7).Peso, 1)
    rs!Aggregato8 = Round(ScManualeAggregati(CompNonVagliato).Peso, 1)
           
    rs!Filler1 = Round(ScManualeFiller(CompFiller1).Peso, 1)
    rs!Filler2 = Round(ScManualeFiller(CompFiller2).Peso, 1)
    rs!Filler3 = Round(ScManualeFiller(CompFiller3).Peso, 1)
    
    rs!Bitume1 = Round(ScManualeBitume(CompLegante1).Peso, 1)
    rs!bitume2 = Round(ScManualeBitume(CompLegante2).Peso, 1)
    rs!Bitume3 = Round(ScManualeBitume(CompLegante3).Peso, 1)
    
    rs!RAP = Round(ScManualeRiciclato(CompRAP).Peso, 1)
    rs!RAPSiwa = Round(ScManualeRiciclato(CompRAPSiwa).Peso, 1)
'20170302
'    rs!Viatop1 = Round(ScManualeViatop(CompViatop).Peso, 1)
    rs!Viatop1 = Round(ScManualeViatop.Peso, 1)
'
'   '20160426
    rs!ViatopMixerScar1 = ScManualeViatopScarMixer1.Peso
    rs!ViatopMixerScar2 = ScManualeViatopScarMixer2.Peso
    '20160426
    rs.Update

    Call ResetVariabiliImpaManuali

End Sub


Public Sub ResetVariabiliImpaManuali()

    Dim indice As Integer

    PesoTotaleAggregatiManuale = 0
    PesoTotaleFillerManuale = 0
    PesoTotaleBitumeManuale = 0
    PesoTotaleRiciclatoManuale = 0
    PesoTotaleViatopManuale = 0
    TotaleKgMescImpastoMan = 0 '20160920
    
    For indice = CompAggregato1 To (compMax - 1)
        Select Case indice
            Case CompAggregato1 To CompNonVagliato
                ScManualeAggregati(indice).Peso = 0
            Case CompFiller1 To CompFiller3
                ScManualeFiller(indice).Peso = 0
            Case CompLegante1 To CompLegante3
                ScManualeBitume(indice).Peso = 0
            Case CompRAP To CompRAPSiwa
                ScManualeRiciclato(indice).Peso = 0
            Case CompViatop
                '20170302
                'ScManualeViatop(indice).Peso = 0
                ScManualeViatop.Peso = 0
                '
            '20160421
            Case CompViatopScarMixer1
                ScManualeViatopScarMixer1.Peso = 0
            Case CompViatopScarMixer2
                ScManualeViatopScarMixer2.Peso = 0
            '20160421
        End Select
    Next indice

    ScManualeAcqua.Peso = 0
    ScManualeAddBac.Peso = 0
    ScManualeAddMesc.Peso = 0
    ScManualeAddSacchi.Peso = 0

    MemPesataManualeAggregatiAttivata = False
    MemPesataManualeFillerAttivata = False
    MemPesataManualeBitumeAttivata = False
    MemPesataManualeRiciclatoAttivata = False
    MemPesataManualeViatopAttivata = False
    '20160421
    MemPesataManualeViatopScarMixer1Attivata = False
    MemPesataManualeViatopScarMixer2Attivata = False
    '20160421
    
    ScManualeAcqua.ScAttivato = False
    ScManualeAddBac.ScAttivato = False
    ScManualeAddMesc.ScAttivato = False
    ScManualeAddSacchi.ScAttivato = False
        
        
    '20170223
    Call InitPbarNettoPesata(CompGrafAggregato1, CompGrafNonVagliato)
    Call InitPbarNettoPesata(CompGrafFiller1, CompGrafFiller3)
    Call InitPbarNettoPesata(CompGrafLegante1, CompLegante3)
    Call InitPbarNettoPesata(CompGrafRAP, CompGrafRAP)
    Call InitPbarNettoPesata(CompGrafViatop, CompGrafViatop)
    
    BilanciaAggregati.CompAttivo = -1 '20170223
    BilanciaFiller.CompAttivo = -1 '20170223
    BilanciaLegante.CompAttivo = -1 '20170223
    BilanciaViatop.CompAttivo = -1 '20170223
    BilanciaRAP.CompAttivo = -1 '20170223
    '
        
End Sub


Public Sub AbilitaPulsantiPortineMan(stato As Boolean)

    Dim indice As Integer

    For indice = CompAggregato1 To compMax - 1
        If indice <> CompNonVagliato2 Then
            '20160421
            'CP240.CmdTrPesa(indice).enabled = stato
            CP240.CmdTrPesa(IIf(indice >= CompViatopScarMixer1, indice + OffsetPesViatopScarMixer, indice)).enabled = stato '20160615
            '20160421
        End If
    Next indice
        
    For indice = ScaricoAggregati To ScaricoLAST - 1
        '20160421
        'CP240.CmdScarica(indice).enabled = stato
        CP240.CmdScarica(IIf(indice >= ScaricoViatopScarMixer1, indice + OffsetScarViatopScarMixer, indice)).enabled = stato
        '20160421
    Next indice
    
    For indice = AddAcqua To AddLAST - 1
        CP240.CmdAddPesa(indice).enabled = stato
    Next indice
    
End Sub

'20170301
Public Sub MemPesiAggManEmergenzaDosaggio()

    Dim indice As Integer

    For indice = LBound(ScManualeAggregati) To UBound(ScManualeAggregati)
        If (BilanciaAggregati.CompAttivo >= 0) And (BilanciaAggregati.CompAttivo <> indice) Then
            ScManualeAggregati(indice).Peso = DosaggioAggregati(indice).pesoOut
            PesoAggregatiManuale = PesoAggregatiManuale + DosaggioAggregati(indice).pesoOut
        End If
    Next indice
                    
End Sub
'

'20170301
Public Sub MemPesiFillManEmergenzaDosaggio()

    Dim indice As Integer
                
    For indice = LBound(ScManualeFiller) To UBound(ScManualeFiller)
        If (BilanciaFiller.CompAttivo >= 0) And (BilanciaFiller.CompAttivo + LBound(ScManualeFiller) <> indice) Then
            ScManualeFiller(indice).Peso = DosaggioFiller(indice - LBound(ScManualeFiller)).pesoOut
            PesoFillerManuale = PesoFillerManuale + DosaggioFiller(indice - LBound(ScManualeFiller)).pesoOut
        End If
    Next indice
        
End Sub
'

'20170301
Public Sub MemPesiBitManEmergenzaDosaggio()

    Dim indice As Integer
                
    For indice = LBound(ScManualeBitume) To UBound(ScManualeBitume)
        If (BilanciaLegante.CompAttivo >= 0) And (BilanciaLegante.CompAttivo + LBound(ScManualeBitume) <> indice) Then
            ScManualeBitume(indice).Peso = DosaggioLeganti(indice - LBound(ScManualeBitume)).pesoOut
            PesoBitumeManuale = PesoBitumeManuale + DosaggioLeganti(indice - LBound(ScManualeBitume)).pesoOut
        End If
    Next indice
        
End Sub
'

'20170301
Public Sub MemPesiViatopManEmergenzaDosaggio()

    Dim indice As Integer
                
        If (BilanciaViatop.CompAttivo >= 0) And (BilanciaViatop.CompAttivo <> CompViatop) Then
            ScManualeViatop.Peso = DosaggioViatop.pesoOut
            PesoViatopManuale = PesoViatopManuale + DosaggioViatop.pesoOut
        End If
        
End Sub
'


