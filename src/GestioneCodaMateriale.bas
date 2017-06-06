Attribute VB_Name = "GestioneCodaMateriale"
'
'   Gestione della coda dei materiali
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Public AbilitaCodaMateriale As Boolean
Public TempoCodaInerti As Integer
Public OraTamburoParalleloCorrezionePortata As Long

Private m_codaInertiTime As Long
Private m_codaRiciclatoTime As Long
Private m_codaTamburoParalleloTime As Long

Public PercentualeFillerRecuperatoFiltro As Double

Public Type Antiadesivo
    presente As Boolean 'se esiste nell'impianto
    inclusione As Boolean   'se il suo funzionamento e' attivato o escluso
    spruzzatura_on As Boolean 'stato dell'uscita dell'elettrovalvola di spuzzatura
    nr_eventi_attesa As Integer 'numero di eventi trascorsi i quali avviene la spruzzatura successiva (con 0= tutte le volte che c'e' il consenso)
    tempo_spruzzatura As Integer 'tempo di spruzzatura in secondi
End Type

Public AntiadesivoScivoloScarBilRAP As Antiadesivo
Public ManualeLivelloTramoggiaTamponeRAP As Boolean
Public NrImpastiGestLivTramTamponeRAP As Integer
Public TempoPermApertFlapScivoloScarBilRAP As Integer

Public ManualeArrestoPredosLivelloTramoggiaTamponeRAP As Boolean
Private OraStartPredosatoriRicFreddo As Long


'

Public Sub GcmCodaInerti_timer()

    Dim adesso As Long
    Dim destinazione As Integer
    Dim materialeIn As FifoMaterialeType
    Dim materialeOut As FifoMaterialeType
    Dim nomeTr As String
    Dim Index As Integer
    Dim PesoBilanciaRiciclatoTMP As Single
    
    If (AbilitaControlloAllarmi <> 2) Then
        Exit Sub
    End If

    adesso = ConvertiTimer()
    If (adesso - m_codaInertiTime < 1) Then
        Exit Sub
    End If

    m_codaInertiTime = adesso

    destinazione = -1
    If (Not DeflettoreSuVagliato) Then
        destinazione = 0
    End If

    If (VaglioEscluso) Then
        If (CqRemoveIf(CodaInerti, materialeOut)) Then
            CP240.lblEtichetta(55).caption = CStr(materialeOut.Kg)

            If (destinazione >= 0) Then
                LivelloTeoricoIn DosaggioAggregati(destinazione), materialeOut.Kg * (100 - PercentualeFillerRecuperatoFiltro) / 100
                CP240.LblNomeRicDos(10 + destinazione).caption = materialeOut.ricetta
            End If
        Else
            CP240.lblEtichetta(55).caption = "ERR"
        End If
    End If


    If ParallelDrum Then
        PesoBilanciaRiciclatoTMP = 0
    Else
        PesoBilanciaRiciclatoTMP = PesoBilanciaRiciclato
    End If

    If ( _
        ListaMotori(MotoreNastroElevatoreFreddo).ritorno And _
        ListaMotori(MotoreElevatoreCaldo).ritorno And _
        (PesoBilanciaInertiSecco + PesoBilanciaRiciclatoTMP) > 12 _
    ) Then
           
        materialeIn.Kg = (PesoBilanciaInertiSecco + PesoBilanciaRiciclatoTMP) / 3.6
        materialeIn.orario = adesso
        materialeIn.ricetta = CP240.LblNomeRicPred.caption

        If (CqAdd(CodaInerti, materialeIn)) Then
            CP240.lblEtichetta(53).caption = CStr(materialeIn.Kg)
        Else
            CP240.lblEtichetta(53).caption = "ERR"
        End If
    End If

    CP240.lblEtichetta(58).caption = CStr(CodaInerti.startPos)
    CP240.lblEtichetta(60).caption = CStr(CodaInerti.endPos)

End Sub


Public Sub GcmCodaRiciclato_timer()

    Dim adesso As Long
'    Dim materialeIn As FifoMaterialeType
'    Dim materialeOut As FifoMaterialeType


    If (AbilitaControlloAllarmi <> 2) Then
        Exit Sub
    End If

    adesso = ConvertiTimer()
    If (adesso - m_codaRiciclatoTime < 1) Then
        Exit Sub
    End If

    m_codaRiciclatoTime = adesso

End Sub

Public Sub GcmCodaTamburoParallelo_timer()

    Dim adesso As Long
    Dim TotaleKg As Double
    Dim materialeIn As FifoMaterialeType
    Dim materialeOut As FifoMaterialeType
    Dim TramoggiaTamponeCapacitaTon As Double
    Dim TramoggiaTamponePesoAttualeTon As Double
       
       
    'routine eseguita nel caso di RAP
    If (AbilitaControlloAllarmi <> 2 Or Not ParallelDrum Or Not AbilitaRAP) Then
        Exit Sub
    End If

    adesso = ConvertiTimer()
    If (adesso - m_codaTamburoParalleloTime < 1) Then
        Exit Sub
    End If

    m_codaTamburoParalleloTime = adesso

    CqRemoveIf CodaTamburoParallelo, materialeOut

'test: pulisco la coda
'    CqInit CodaTamburoParallelo, TamburoParallelo_TempoCoda

'    If (ListaMotori(MotoreElevatoreRiciclato).uscita) Then
    If (ListaMotori(MotoreRotazioneEssiccatore2).ritorno) Then
        If (PesoBilanciaRiciclatoParDrum > 5) And (Not DeflettoreByPassTamburoParalleloVersoNastro) Then
            materialeIn.Kg = (PesoBilanciaRiciclatoParDrum) / 3.6
        Else
            materialeIn.Kg = 0
        End If
        materialeIn.orario = adesso
        materialeIn.ricetta = CP240.LblNomeRicPred.caption

        Call CqAdd(CodaTamburoParallelo, materialeIn)
    End If

    'calcolo una volta sola i dati utili
    TramoggiaTamponeCapacitaTon = TamburoParallelo_TramoggiaTamponeCapacita * 1000
    TramoggiaTamponePesoAttualeTon = BilanciaTamponeRiciclato.Peso * 1000


    If TramoggiaTamponePesoAttualeTon > 0 Then
        'Contenuto della tramoggia tampone + quello in transito
        TotaleKg = TramoggiaTamponePesoAttualeTon + CqAmount(CodaTamburoParallelo)
    Else
        TotaleKg = CqAmount(CodaTamburoParallelo)
    End If
    
'solo test
'    CP240.LblConsumi(3).caption = CStr(Round(CqAmount(CodaTamburoParallelo) / 1000, 1))
'
        
        
    Call ComponenteLivello(DosaggioRAP, CInt((TotaleKg * 100) / TramoggiaTamponeCapacitaTon))
    CP240.LblTrLivTeorico(DosaggioRAP.progressivo).caption = RoundNumber(TotaleKg / 1000, 1)

    LivelloTramoggia(DosaggioRAP.progressivo) = CInt((TotaleKg * 100) / TramoggiaTamponeCapacitaTon)
    Call LivelloTramoggia_change(DosaggioRAP.progressivo)


    'se scatta la sicurezza meccanica del livello o il peso supera la soglia di sicurezza fermo predosatori, bruciatore e motori immediatamente
    If ( _
        ((CP240.OPCData.items(PLCTAG_DI_SicurezzaTamponeRiciclatoCaldo).Value) Or (BilanciaTamponeRiciclato.Peso >= BilanciaTamponeRiciclato.Sicurezza)) And _
        CqAmount(CodaTamburoParallelo) > 0 _
    ) Then
        Call PredosatoriArrestoImmediato(True, 1) 'fermo solo la linea del riciclato freddo

        Call StopBruciatore(1)
'        Call SetMotoreUscita(MotoreRotazioneEssiccatore2, False)  'Tamburo2
'        Call SetMotoreUscita(MotoreNastroTrasportatoreRiciclatoFreddo, False) 'N.R.F.1
'        Call SetMotoreUscita(MotoreNastroCollettoreRiciclatoFreddo, False) 'N.R.F.2
'        Call SetMotoreUscita(MotoreElevatoreRiciclato, False) 'Elev.Ric.
        
    End If

    'gestione degli allarmi delle soglie
    If (TotaleKg >= (TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaCriticaPercentuale / 100 * TramoggiaTamponeCapacitaTon)) Then
        If Not ManualeArrestoPredosLivelloTramoggiaTamponeRAP Then
            Call PredosatoriArrestoImmediato(True, 1) 'fermo solo la linea del riciclato freddo
        End If
        
        Call AllarmeTemporaneoFull(124, "XX124", True, True)
    ElseIf (TotaleKg >= TamburoParallelo_TramoggiaTamponeLivelloTeoricoSogliaAllarmePercentuale / 100 * TramoggiaTamponeCapacitaTon) Then
        Call AllarmeTemporaneoFull(123, "XX123", True, True)
    Else
        Call AllarmeTemporaneoFull(123, "XX123", False, True)
        Call AllarmeTemporaneoFull(124, "XX124", False, True)
    End If
                
    If AlmenoUnoAccesoPredRiciclatoFreddo And OraStartPredosatoriRicFreddo = 0 Then
        OraStartPredosatoriRicFreddo = ConvertiTimer()
    ElseIf Not AlmenoUnoAccesoPredRiciclatoFreddo Then
        OraStartPredosatoriRicFreddo = 0
    End If
                
                
'gestione della correzione automatica dei predosatori ogni intervallo di tempo impostato come lughezza della coda
    If (ConvertiTimer > (OraStartPredosatoriRicFreddo + TamburoParallelo_TempoCoda)) And DosaggioRAP.setCalcolato > 0 And AlmenoUnoAccesoPredRiciclatoFreddo And Not ManualeLivelloTramoggiaTamponeRAP Then
        If OraTamburoParalleloCorrezionePortata = 0 Then
            
            OraTamburoParalleloCorrezionePortata = ConvertiTimer
            'Se il contenuto della tramoggia e' superiore al quantitativo necessario per il numero di impasti impostato +1, rallenta i predosatori
            If TramoggiaTamponePesoAttualeTon > (DosaggioRAP.setCalcolato * (NrImpastiGestLivTramTamponeRAP + 1)) Then
                Call SetRiduzioneProduzione(RiduzioneProduzione * (100 - TamburoParallelo_PredosasatoriCorrezionePercentuale) / 100)
                Call AvvioPredAutomatico
                Call AllarmeTemporaneo("XX129", True) 'messaggio di avviso che la velocita' di riempimento della tramoggia tampone del rap e' troppo veloce rispetto alla richiesta del ciclo di dosaggio
            Else
                Call AllarmeTemporaneo("XX129", False)
                
            End If
            
            'Se il contenuto della tramoggia e' inferiore al quantitativo necessario per il numero di impasti impostato -1, accelera i predosatori
            If TramoggiaTamponePesoAttualeTon < (DosaggioRAP.setCalcolato * (NrImpastiGestLivTramTamponeRAP - 1)) Then
                Call SetRiduzioneProduzione(RiduzioneProduzione * (100 + TamburoParallelo_PredosasatoriCorrezionePercentuale) / 100)
                Call AvvioPredAutomatico
                Call AllarmeTemporaneo("XX128", True) 'messaggio di avviso che la velocita' di riempimento della tramoggia tampone del rap e' troppo lenta rispetto alla richiesta del ciclo di dosaggio
            Else
                Call AllarmeTemporaneo("XX128", False)
            End If
        Else
            If ConvertiTimer() >= OraTamburoParalleloCorrezionePortata + TamburoParallelo_TempoCoda Then
                OraTamburoParalleloCorrezionePortata = 0
            End If
        End If
    Else
        OraTamburoParalleloCorrezionePortata = 0
    End If


End Sub

