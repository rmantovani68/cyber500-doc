Attribute VB_Name = "BrucAuto"
'
'   Bruciatore Automatico (CITECT edition)
'
'20161230

Option Explicit

Public LimiteCorrUpRaggiunto(0 To 1) As Boolean
Public LimiteCorrDownRaggiunto(0 To 1) As Boolean

'

Private Sub TableShift(ByRef lista() As Double, listaDim As Integer, verso As Integer)

    Dim Index As Integer

    For Index = listaDim To 1 Step -1
        lista(Index) = lista(Index - 1)
    Next Index

End Sub


'Questa Funzione Gestisce La regolazione e Le Funzioni Del Bruciatore dell'essiccatore.
Private Sub GestSetRegBruciatore()

	'------------------------------------
	'   ATTENZIONE: TAMBURO PRINCIPALE  '
	'------------------------------------

    Dim indice As Integer
    Dim numPredAttivi As Integer
    Dim numPredRicAttivi As Integer
    Dim predosatore As Integer
    Dim tempoMedioStartStopPredRic As Integer
    Dim allarmeVuotoPredRic As Boolean

    Dim portataTotaleSetPredVerg As Double
    Dim portataTotaleSetPredRicicl As Double

    Dim diffPercDiTempTraTestESet As Double

    Dim TOutEss As Double
    Dim StartPred As Boolean
    Dim LavTmpRicPrd As Double 'Set di temperatura
    Dim IncrPercPrimaAccensione As Double 'Valore temporaneo per l'incremento del bruciatore alla 1*Accensione.
    Dim SetModulatoreCorrettoAMano As Boolean
    Dim ProdTeorRichRic As Double

    Dim combustibile As Integer
    Dim posizioneSetModulatoreOld As Integer
    Dim portataTotaleSetPredVergERiciclOld As Double


    With ListaTamburi(0)

        TOutEss = .temperaturaScivolo
        StartPred = (AlmenoUnoAccesoPredVergini Or AlmenoUnoAccesoPredRiciclatoCaldo)
        LavTmpRicPrd = .setTemperaturaScivolo
        SetModulatoreCorrettoAMano = (.BA_LavTmpRicPrd <> LavTmpRicPrd)
    
        posizioneSetModulatoreOld = Round(.BA_PosizioneSetModulatore, 0)
        portataTotaleSetPredVergERiciclOld = Round(.BA_portataTotaleSetPredVergERicicl, 0)
    
    
        'Considero i pesi secchi
    
        portataTotaleSetPredVerg = PesoBilanciaInertiSecco
        portataTotaleSetPredRicicl = PesoBilanciaRiciclatoSecco
    
        'Calcolo i tempi medi di start-stop predosatori riciclato in base al set degli stessi
    
        'Assegno la portata teorica in base a tempi che posso impostare liberamente
    
        indice = 0
        tempoMedioStartStopPredRic = 0
        allarmeVuotoPredRic = False
    
        numPredAttivi = 0
        numPredRicAttivi = 0
        .BA_UmPercIstantTotVergERicicl = 0
    
        For predosatore = 0 To NumeroPredosatoriInseriti - 1
           If (ListaPredosatori(predosatore).setAttuale.set > 0) Then
                numPredAttivi = numPredAttivi + 1
    
                .BA_UmPercIstantTotVergERicicl = (.BA_UmPercIstantTotVergERicicl + ListaPredosatori(predosatore).Umidita)
            End If
        Next predosatore
    
        For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
           If (ListaPredosatoriRic(predosatore).setAttuale.set > 0) Then
                numPredRicAttivi = numPredRicAttivi + 1
    
                If (ListaPredosatoriRic(predosatore).setAttuale.tempoStart > 0) Then
                    tempoMedioStartStopPredRic = tempoMedioStartStopPredRic + ListaPredosatoriRic(predosatore).setAttuale.tempoStart
                End If
                allarmeVuotoPredRic = (allarmeVuotoPredRic Or ListaPredosatoriRic(predosatore).vuoto)
                ProdTeorRichRic = (ProdTeorRichRic + ListaPredosatoriRic(predosatore).portataTeorica)
    
                .BA_UmPercIstantTotVergERicicl = (.BA_UmPercIstantTotVergERicicl + ListaPredosatoriRic(predosatore).Umidita)
            End If
        Next predosatore
    
        If (numPredRicAttivi > 0) Then
            tempoMedioStartStopPredRic = (tempoMedioStartStopPredRic / numPredRicAttivi)
        End If
        If (numPredAttivi + numPredRicAttivi > 0) Then
            .BA_UmPercIstantTotVergERicicl = (.BA_UmPercIstantTotVergERicicl / (numPredAttivi + numPredRicAttivi))
        End If
        '
    
        'faccio in modo che la variabile 'TempoMedioStartStopPredRic' non sia inferiore ad '.BAP_AntRegModRicicl'
        If (tempoMedioStartStopPredRic < .BAP_AntRegModRicicl) Then
            tempoMedioStartStopPredRic = .BAP_AntRegModRicicl
        End If
    
        'Siccome il bruciatore va regolato in RITARDO rispetto al passaggio degli aggregati sulla pesa, gli inserisco nella tabella il valore REALE
        'INVECE per il RICICLATO, il modulatore va regolato in anticipo rispetto al passaggio del riciclato sulla pesa, devo prendere il valore teorico.
    
        Call TableShift(.BA_ValThPrVerg, 1001, -1) 'avanzamento della tabella di una posizione
        Call TableShift(.BA_ValThPrRicicl, 1001, -1) 'avanzamento della tabella di una posizione
    
        'Produzione Reale Vergini
        .BA_ValThPrVerg(0) = portataTotaleSetPredVerg
    
        'Finché la produzione teorica del riciclato è zero, tengo aggiornato il tempo di controllo
        If ProdTeorRichRic = 0 Then
            .BA_TimerPartenzaRic = ConvertiTimer()
        End If
    
        If ((ConvertiTimer() - .BA_TimerPartenzaRic) < (tempoMedioStartStopPredRic * 2)) Then
            'All'inizio prendo il riciclato teorico
            .BA_ValThPrRicicl(0) = ProdTeorRichRic '   Produzione Teorica Riciclato
        Else
            'poi a regime uso il reale.
            .BA_ValThPrRicicl(0) = portataTotaleSetPredRicicl '   Produzione Reale Riciclato
        End If
    
        If (Not .FiammaBruciatorePresente Or Not .BruciatoreAutomatico) Then
            .BA_PosizioneSetModulatore = 0#
            .BA_TimerAttesaRegolSucc = ConvertiTimer()
            'Per sicurezza, ma non dovrebbe servire
            .BA_TimerRifTempoAttravTamb = ConvertiTimer()
            CP240.LblModulatore(3).caption = FormatNumber(.BA_PosizioneSetModulatore, 0, vbTrue, vbFalse, vbFalse)
            Exit Sub
        End If
    
    
        '*** Correzione della potenzialità del bruciatore sull'umidità media del materiale. *****
        'Il calcolo presuppone che ad ogni variazione di 1 punto percentuale di umidità, vi sia un
        'incremento del 12% sulla potenzialità del bruciatore
    
        'Faccio un'ulteriore verifica per precauzione anche se in realtà non è necessaria
        If (tempoMedioStartStopPredRic - .BAP_AntRegModRicicl) < 0 Then
            .BA_portataTotaleSetPredVergERicicl = (.BA_ValThPrVerg(.BAP_RitRegModVerg) + .BA_ValThPrRicicl(tempoMedioStartStopPredRic))
        Else
            .BA_portataTotaleSetPredVergERicicl = (.BA_ValThPrVerg(.BAP_RitRegModVerg) + .BA_ValThPrRicicl(tempoMedioStartStopPredRic - .BAP_AntRegModRicicl))
        End If
    
        .BA_portataTotaleSetPredVergERicicl = (.BA_portataTotaleSetPredVergERicicl + ((.BA_portataTotaleSetPredVergERicicl * .BAP_CorrManSetPosMod) / 100#))
    
        'Correggo La Portata dei vergini e riciclato, Con La Differenza di Umidità che c'è tra quella del test e quella attuale.
        .BA_diffPercDiUmiditaTraTestESet = (((.BA_UmPercIstantTotVergERicicl - .BAP_UMediaAlTest) * 12#) * .BAP_GuadDiffUmidita) '.BAP_GuadDiffUmidita è impostabile dall'operatore
    
        .BA_portataTotaleSetPredVergERicicl = .BA_portataTotaleSetPredVergERicicl + ((.BA_portataTotaleSetPredVergERicicl * .BA_diffPercDiUmiditaTraTestESet) / 100#)
    
    
        '20170323
        'Tengo a zero il tempo di riferimento per calcolare il tempo di attraversamento del tamburo per iniziare la correzione di temperatura.
        'Controllo che gli aggregati siano sotto le 15 T/h e che i predosatori dei vergini siano in procinto di partire
        If portataTotaleSetPredVerg < 15 Or Not StartPred Then
            .BA_TimerRifTempoAttravTamb = ConvertiTimer()
        End If
    
    
        'Correggo La Portata dei vergini e del riciclato Con La Differenza di Temperatura che c'è
        'tra quella del test e quella di set Sommata a quella che c'è tra quella reale e quella di set.
        'Se sono in fase di spegnimento non correggo più la differenza di temperatura perché a quel punto l'essiccatore non essendo più pieno come a regime,
        'le correzioni di temperatura che si andranno a fare non hanno più significato.
        'Se ho un allarme di un palpatore del riciclato, non correggo la differenza di temperatura
        'If (TOutEss >= .BAP_LimiteMinDiTempPerCorr And StartPred And Not allarmeVuotoPredRic) Then
        If (ConvertiTimer() - .BA_TimerRifTempoAttravTamb) >= .BAP_LimiteMinDiTempPerCorr And StartPred And Not allarmeVuotoPredRic Then
    
            'Se vario il set di temperatura, reinizializzo il tempo.
            If (.BA_LavTmpRicPrd <> LavTmpRicPrd) Then
                .BA_TimerAttesaRegolSucc = ConvertiTimer()
                .BA_LavTmpRicPrd = LavTmpRicPrd
            End If
    
            'Se correggo il set manuale, reinizializzo il tempo.
            If (SetModulatoreCorrettoAMano > 0) Then
                .BA_TimerAttesaRegolSucc = ConvertiTimer()
                SetModulatoreCorrettoAMano = 0
            End If
    
            If (ConvertiTimer() - .BA_TimerAttesaRegolSucc) >= .BAP_AttesaSuRegolSucc Then
    
                .BA_TimerAttesaRegolSucc = ConvertiTimer()
'Debug.Print "MAIO AttesaRegolSucc - " + CStr(DateTime.Now)
    
                'se ho un set di correzione manuale, tolgo la differenza di temperatura da lì fino a zero, poi utilizzo la variabile '.BA_DiffPercDiTempSetEReale'
                If (.BAP_CorrManSetPosMod > 0) Then
                    If (LavTmpRicPrd > 0) Then
                        If ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp) > 0 Then
                            If .BA_PosizioneSetModulatoreTotale < 100# Then
                                'Progressivo differenza di temperatura
                                .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100#) * .BAP_GuadDiffTemp)
                            End If
                        Else
                            If .BA_PosizioneSetModulatoreTotale > 0 Then
                                If (.BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)) > 0 Then
                                    .BAP_CorrManSetPosMod = .BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                Else
                                    'Progressivo differenza di temperatura
                                    .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                End If
                            End If
                        End If
                    End If
                Else
                    If LavTmpRicPrd > 0 Then
                        If ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp) < 0 Then
                            If .BA_PosizioneSetModulatoreTotale > 0 Then
                                'Progressivo differenza di temperatura
                                .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                            End If
                        Else
                            If .BA_PosizioneSetModulatoreTotale < 100 Then
                                If (.BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)) < 0 Then
                                    .BAP_CorrManSetPosMod = .BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                Else
                                    'Progressivo differenza di temperatura
                                    .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                End If
                            End If
                        End If
                    End If
                End If
    
                LimiteCorrUpRaggiunto(0) = False
                LimiteCorrDownRaggiunto(0) = False
        
                'Limito La Correzione Tra Temperatura Reale e quella di Set Ad Un 50%
                If .BA_DiffPercDiTempSetEReale > 50 Then
                    LimiteCorrUpRaggiunto(0) = True
                    .BA_DiffPercDiTempSetEReale = 50
                End If
    
                If .BA_DiffPercDiTempSetEReale < -50 Then
                    LimiteCorrDownRaggiunto(0) = True
                    .BA_DiffPercDiTempSetEReale = -50
                End If
            End If
            
            'Allarme Temperatura Uscita Essiccatore
            If (.BA_TollTempUscEssPerSegnAll <> 0) Then
                If LavTmpRicPrd > 0 Then
                    If Abs((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100)) > .BA_TollTempUscEssPerSegnAll Then
                        .BA_All_141 = True 'Allarme uscita essiccatore
                    Else
                        .BA_All_141 = False 'Allarme uscita essiccatore
                    End If
                End If
            Else
                .BA_All_141 = False 'Allarme uscita essiccatore
            End If
    
        Else
            .BA_TimerAttesaRegolSucc = ConvertiTimer()
            .BA_All_141 = False 'Allarme uscita essiccatore
        End If
    
        'Se la temperatura di uscita essicatore è inferiore ad un certo valore, presuppongo che l'impianto sia stato riavviato dopo un periodo di ferma e quindi incremento un po' il bruciatore
        'fino alla prima correzione di temperatura la variabile si chiama .BAP_TempStartUscEssic , ma in realtà in questo caso uso la temperatura di uscita dell'essiccatore.
        If (TOutEss < .BAP_TempStartUscEssic) Then
            IncrPercPrimaAccensione = .BAP_PercIncrPrimaAccens
        Else
            IncrPercPrimaAccensione = 0
        End If
    
        If (.BAP_TempEssAlTest > 0) Then
            '.BAP_GuadDiffTemp è impostabile dall'operatore
            diffPercDiTempTraTestESet = ((((LavTmpRicPrd - .BAP_TempEssAlTest) / .BAP_TempEssAlTest) * 100) * .BAP_GuadDiffTemp)
        Else
            diffPercDiTempTraTestESet = 0
        End If
    
        .BA_portataTotaleSetPredVergERicicl = .BA_portataTotaleSetPredVergERicicl + ((.BA_portataTotaleSetPredVergERicicl * (diffPercDiTempTraTestESet + .BA_DiffPercDiTempSetEReale + IncrPercPrimaAccensione)) / 100#)
    
        If (.BA_portataTotaleSetPredVergERicicl <= 0) Then
            .BA_PosizioneSetModulatore = 0
            Exit Sub
        End If
		
    
        'Calcolo La Posizione Del Modulatore In Base Alla Curva Del Bruciatore Sull'apposito Combustibile
    
        combustibile = .SelezioneCombustibile
		
		' ----------------------------------------------------------------------------------
		' si può riscrivere così
		'
        ' .BA_PosizioneSetModulatore = 100#
        ' For i = 0 To numero_punti_curva_portata
		' 	If (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, i)) Then
		' 		if i>0 then
		' 			.BA_PosizioneSetModulatore = (i-1)*10# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, i) - .BAP_RapportoPortataModulatore(combustibile, i-1))) * 
		'                                                            (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, i-1)))
		' 		else
		' 			.BA_PosizioneSetModulatore = 0#
		' 		end if
		' 	end if
		' next i
		' ----------------------------------------------------------------------------------
		    
        If (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 0)) Then
            .BA_PosizioneSetModulatore = 0#
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 1)) Then
            .BA_PosizioneSetModulatore = 0# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 1) - .BAP_RapportoPortataModulatore(combustibile, 0))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 0)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 2)) Then
            .BA_PosizioneSetModulatore = 10# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 2) - .BAP_RapportoPortataModulatore(combustibile, 1))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 1)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 3)) Then
            .BA_PosizioneSetModulatore = 20# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 3) - .BAP_RapportoPortataModulatore(combustibile, 2))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 2)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 4)) Then
            .BA_PosizioneSetModulatore = 30# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 4) - .BAP_RapportoPortataModulatore(combustibile, 3))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 3)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 5)) Then
            .BA_PosizioneSetModulatore = 40# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 5) - .BAP_RapportoPortataModulatore(combustibile, 4))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 4)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 6)) Then
            .BA_PosizioneSetModulatore = 50# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 6) - .BAP_RapportoPortataModulatore(combustibile, 5))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 5)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 7)) Then
            .BA_PosizioneSetModulatore = 60# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 7) - .BAP_RapportoPortataModulatore(combustibile, 6))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 6)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 8)) Then
            .BA_PosizioneSetModulatore = 70# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 8) - .BAP_RapportoPortataModulatore(combustibile, 7))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 7)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 9)) Then
            .BA_PosizioneSetModulatore = 80# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 9) - .BAP_RapportoPortataModulatore(combustibile, 8))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 8)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 10)) Then
            .BA_PosizioneSetModulatore = 90# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 10) - .BAP_RapportoPortataModulatore(combustibile, 9))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 9)))
        Else
            .BA_PosizioneSetModulatore = 100#
        End If

        CP240.LblModulatore(3).caption = FormatNumber(.BA_PosizioneSetModulatore, 0, vbTrue, vbFalse, vbFalse)
        CP240.LblModulatore(3).BackColor = IIf(LimiteCorrUpRaggiunto(0) Or LimiteCorrDownRaggiunto(0), &HFF&, &HFFFFFF)

    End With

End Sub


'Questa Funzione Gestisce La regolazione e Le Funzioni Del Bruciatore dell'essiccatore.
Public Sub GestSetRegBruciatore2()

	'------------------------------------
	'   ATTENZIONE: TAMBURO PARALLELO   '
	'------------------------------------

    Dim indice As Integer
    Dim numPredAttivi As Integer
    Dim numPredRicAttivi As Integer
    Dim predosatore As Integer
    Dim tempoMedioStartStopPredRic As Integer
    Dim allarmeVuotoPredRic As Boolean

    Dim portataTotaleSetPredVerg As Double
    Dim portataTotaleSetPredRicicl As Double

    Dim diffPercDiTempTraTestESet As Double

    Dim TOutEss As Double
    Dim StartPred As Boolean
    Dim LavTmpRicPrd As Double 'Set di temperatura
    Dim IncrPercPrimaAccensione As Double 'Valore temporaneo per l'incremento del bruciatore alla 1*Accensione.
    Dim SetModulatoreCorrettoAMano As Boolean
    Dim ProdTeorRichRic As Double

    Dim combustibile As Integer
    Dim posizioneSetModulatoreOld As Integer
    Dim portataTotaleSetPredVergERiciclOld As Double


    With ListaTamburi(1)

        TOutEss = .temperaturaScivolo
        StartPred = (AlmenoUnoAccesoPredVergini Or AlmenoUnoAccesoPredRiciclatoCaldo)
        LavTmpRicPrd = .setTemperaturaScivolo
        SetModulatoreCorrettoAMano = (.BA_LavTmpRicPrd <> LavTmpRicPrd)
    
        posizioneSetModulatoreOld = Round(.BA_PosizioneSetModulatore, 0)
        portataTotaleSetPredVergERiciclOld = Round(.BA_portataTotaleSetPredVergERicicl, 0)
    
    
        'Considero i pesi secchi
    
        portataTotaleSetPredVerg = PesoBilanciaInertiSecco
        portataTotaleSetPredRicicl = PesoBilanciaRiciclatoSecco
    
        'Calcolo i tempi medi di start-stop predosatori riciclato in base al set degli stessi
    
        'Assegno la portata teorica in base a tempi che posso impostare liberamente
    
        indice = 0
        tempoMedioStartStopPredRic = 0
        allarmeVuotoPredRic = False
    
        numPredAttivi = 0
        numPredRicAttivi = 0
        .BA_UmPercIstantTotVergERicicl = 0
    
        For predosatore = 0 To NumeroPredosatoriInseriti - 1
           If (ListaPredosatori(predosatore).setAttuale.set > 0) Then
                numPredAttivi = numPredAttivi + 1
    
                .BA_UmPercIstantTotVergERicicl = (.BA_UmPercIstantTotVergERicicl + ListaPredosatori(predosatore).Umidita)
            End If
        Next predosatore
    
        For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
           If (ListaPredosatoriRic(predosatore).setAttuale.set > 0) Then
                numPredRicAttivi = numPredRicAttivi + 1
    
                If (ListaPredosatoriRic(predosatore).setAttuale.tempoStart > 0) Then
                    tempoMedioStartStopPredRic = tempoMedioStartStopPredRic + ListaPredosatoriRic(predosatore).setAttuale.tempoStart
                End If
                allarmeVuotoPredRic = (allarmeVuotoPredRic Or ListaPredosatoriRic(predosatore).vuoto)
                ProdTeorRichRic = (ProdTeorRichRic + ListaPredosatoriRic(predosatore).portataTeorica)
    
                .BA_UmPercIstantTotVergERicicl = (.BA_UmPercIstantTotVergERicicl + ListaPredosatoriRic(predosatore).Umidita)
            End If
        Next predosatore
    
        If (numPredRicAttivi > 0) Then
            tempoMedioStartStopPredRic = (tempoMedioStartStopPredRic / numPredRicAttivi)
        End If
        If (numPredAttivi + numPredRicAttivi > 0) Then
            .BA_UmPercIstantTotVergERicicl = (.BA_UmPercIstantTotVergERicicl / (numPredAttivi + numPredRicAttivi))
        End If
        '
    
        'faccio in modo che la variabile 'TempoMedioStartStopPredRic' non sia inferiore ad '.BAP_AntRegModRicicl'
        If (tempoMedioStartStopPredRic < .BAP_AntRegModRicicl) Then
            tempoMedioStartStopPredRic = .BAP_AntRegModRicicl
        End If
    
        'Siccome il bruciatore va regolato in RITARDO rispetto al passaggio degli aggregati sulla pesa, gli inserisco nella tabella il valore REALE
        'INVECE per il RICICLATO, il modulatore va regolato in anticipo rispetto al passaggio del riciclato sulla pesa, devo prendere il valore teorico.
    
        Call TableShift(.BA_ValThPrVerg, 1001, -1) 'avanzamento della tabella di una posizione
        Call TableShift(.BA_ValThPrRicicl, 1001, -1) 'avanzamento della tabella di una posizione
    
        'Produzione Reale Vergini
        .BA_ValThPrVerg(0) = portataTotaleSetPredVerg
    
        'Finché la produzione teorica del riciclato è zero, tengo aggiornato il tempo di controllo
        If ProdTeorRichRic = 0 Then
            .BA_TimerPartenzaRic = ConvertiTimer()
        End If
    
        If ((ConvertiTimer() - .BA_TimerPartenzaRic) < (tempoMedioStartStopPredRic * 2)) Then
            'All'inizio prendo il riciclato teorico
            .BA_ValThPrRicicl(0) = ProdTeorRichRic '   Produzione Teorica Riciclato
        Else
            'poi a regime uso il reale.
            .BA_ValThPrRicicl(0) = portataTotaleSetPredRicicl '   Produzione Reale Riciclato
        End If
    
        If (Not .FiammaBruciatorePresente Or Not .BruciatoreAutomatico) Then
            .BA_PosizioneSetModulatore = 0#
            .BA_TimerAttesaRegolSucc = ConvertiTimer()
            'Per sicurezza, ma non dovrebbe servire
            .BA_TimerRifTempoAttravTamb = ConvertiTimer()
            CP240.LblModulatore(3).caption = FormatNumber(.BA_PosizioneSetModulatore, 0, vbTrue, vbFalse, vbFalse)
            Exit Sub
        End If
    
    
        '*** Correzione della potenzialità del bruciatore sull'umidità media del materiale. *****
        'Il calcolo presuppone che ad ogni variazione di 1 punto percentuale di umidità, vi sia un
        'incremento del 12% sulla potenzialità del bruciatore
    
        'Faccio un'ulteriore verifica per precauzione anche se in realtà non è necessaria
        If (tempoMedioStartStopPredRic - .BAP_AntRegModRicicl) < 0 Then
            .BA_portataTotaleSetPredVergERicicl = (.BA_ValThPrVerg(.BAP_RitRegModVerg) + .BA_ValThPrRicicl(tempoMedioStartStopPredRic))
        Else
            .BA_portataTotaleSetPredVergERicicl = (.BA_ValThPrVerg(.BAP_RitRegModVerg) + .BA_ValThPrRicicl(tempoMedioStartStopPredRic - .BAP_AntRegModRicicl))
        End If
    
        .BA_portataTotaleSetPredVergERicicl = (.BA_portataTotaleSetPredVergERicicl + ((.BA_portataTotaleSetPredVergERicicl * .BAP_CorrManSetPosMod) / 100))
    
        'Correggo La Portata dei vergini e riciclato, Con La Differenza di Umidità che c'è tra quella del test e quella attuale.
        .BA_diffPercDiUmiditaTraTestESet = (((.BA_UmPercIstantTotVergERicicl - .BAP_UMediaAlTest) * 12#) * .BAP_GuadDiffUmidita) '.BAP_GuadDiffUmidita è impostabile dall'operatore
    
        .BA_portataTotaleSetPredVergERicicl = .BA_portataTotaleSetPredVergERicicl + ((.BA_portataTotaleSetPredVergERicicl * .BA_diffPercDiUmiditaTraTestESet) / 100)
    
        'Correggo La Portata dei vergini e del riciclato Con La Differenza di Temperatura che c'è
        'tra quella del test e quella di set Sommata a quella che c'è tra quella reale e quella di set.
        'Se sono in fase di spegnimento non correggo più la differenza di temperatura perché a quel punto l'essiccatore non essendo più pieno come a regime,
        'le correzioni di temperatura che si andranno a fare non hanno più significato.
        'Se ho un allarme di un palpatore del riciclato, non correggo la differenza di temperatura
        'If (TOutEss >= .BAP_LimiteMinDiTempPerCorr And StartPred And Not allarmeVuotoPredRic) Then
        If (ConvertiTimer() - .BA_TimerRifTempoAttravTamb) >= .BAP_LimiteMinDiTempPerCorr And StartPred And Not allarmeVuotoPredRic Then
    
            'Se vario il set di temperatura, reinizializzo il tempo.
            If (.BA_LavTmpRicPrd <> LavTmpRicPrd) Then
                .BA_TimerAttesaRegolSucc = ConvertiTimer()
                .BA_LavTmpRicPrd = LavTmpRicPrd
            End If
    
            'Se correggo il set manuale, reinizializzo il tempo.
            If (SetModulatoreCorrettoAMano > 0) Then
                .BA_TimerAttesaRegolSucc = ConvertiTimer()
                SetModulatoreCorrettoAMano = 0
            End If
    
            If (ConvertiTimer() - .BA_TimerAttesaRegolSucc) >= .BAP_AttesaSuRegolSucc Then
    
                .BA_TimerAttesaRegolSucc = ConvertiTimer()
'Debug.Print "MAIO AttesaRegolSucc - " + CStr(DateTime.Now)
    
                'se ho un set di correzione manuale, tolgo la differenza di temperatura da lì fino a zero, poi utilizzo la variabile '.BA_DiffPercDiTempSetEReale'
                If (.BAP_CorrManSetPosMod > 0) Then
                    If (LavTmpRicPrd > 0) Then
                        If ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp) > 0 Then
                            If .BA_PosizioneSetModulatoreTotale < 100# Then
                                'Progressivo differenza di temperatura
                                .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100#) * .BAP_GuadDiffTemp)
                            End If
                        Else
                            If .BA_PosizioneSetModulatoreTotale > 0 Then
                                If (.BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)) > 0 Then
                                    .BAP_CorrManSetPosMod = .BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                Else
                                    'Progressivo differenza di temperatura
                                    .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                End If
                            End If
                        End If
                    End If
                Else
                    If LavTmpRicPrd > 0 Then
                        If ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp) < 0 Then
                            If .BA_PosizioneSetModulatoreTotale > 0 Then
                                'Progressivo differenza di temperatura
                                .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                            End If
                        Else
                            If .BA_PosizioneSetModulatoreTotale < 100 Then
                                If (.BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)) < 0 Then
                                    .BAP_CorrManSetPosMod = .BAP_CorrManSetPosMod + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                Else
                                    'Progressivo differenza di temperatura
                                    .BA_DiffPercDiTempSetEReale = .BA_DiffPercDiTempSetEReale + ((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100) * .BAP_GuadDiffTemp)
                                End If
                            End If
                        End If
                    End If
                End If
    
                'Limito La Correzione Tra Temperatura Reale e quella di Set Ad Un 50%
                If .BA_DiffPercDiTempSetEReale > 50 Then
                    .BA_DiffPercDiTempSetEReale = 50
                End If
    
                If .BA_DiffPercDiTempSetEReale < -50 Then
                    .BA_DiffPercDiTempSetEReale = -50
                End If
            End If
    
            'Allarme Temperatura Uscita Essiccatore
            If (.BA_TollTempUscEssPerSegnAll <> 0) Then
                If LavTmpRicPrd > 0 Then
                    If Abs((((LavTmpRicPrd - TOutEss) / LavTmpRicPrd) * 100)) > .BA_TollTempUscEssPerSegnAll Then
                        .BA_All_141 = True 'Allarme uscita essiccatore
                    Else
                        .BA_All_141 = False 'Allarme uscita essiccatore
                    End If
                End If
            Else
                .BA_All_141 = False 'Allarme uscita essiccatore
            End If
    
        Else
            .BA_TimerAttesaRegolSucc = ConvertiTimer()
            .BA_All_141 = False 'Allarme uscita essiccatore
        End If
    
        'Se la temperatura di uscita essicatore è inferiore ad un certo valore, presuppongo che l'impianto sia stato riavviato dopo un periodo di ferma e quindi incremento un po' il bruciatore
        'fino alla prima correzione di temperatura la variabile si chiama .BAP_TempStartUscEssic , ma in realtà in questo caso uso la temperatura di uscita dell'essiccatore.
        If (TOutEss < .BAP_TempStartUscEssic) Then
            IncrPercPrimaAccensione = .BAP_PercIncrPrimaAccens
        Else
            IncrPercPrimaAccensione = 0
        End If
    
        If (.BAP_TempEssAlTest > 0) Then
            '.BAP_GuadDiffTemp è impostabile dall'operatore
            diffPercDiTempTraTestESet = ((((LavTmpRicPrd - .BAP_TempEssAlTest) / .BAP_TempEssAlTest) * 100) * .BAP_GuadDiffTemp)
        Else
            diffPercDiTempTraTestESet = 0
        End If
    
        .BA_portataTotaleSetPredVergERicicl = .BA_portataTotaleSetPredVergERicicl + ((.BA_portataTotaleSetPredVergERicicl * (diffPercDiTempTraTestESet + .BA_DiffPercDiTempSetEReale + IncrPercPrimaAccensione)) / 100#)
    
        If (.BA_portataTotaleSetPredVergERicicl <= 0) Then
            .BA_PosizioneSetModulatore = 0
            Exit Sub
        End If
    
        'Calcolo La Posizione Del Modulatore In Base Alla Curva Del Bruciatore Sull'apposito Combustibile
    
        combustibile = .SelezioneCombustibile
    

		' ----------------------------------------------------------------------------------
		' si può riscrivere così
		'
        ' .BA_PosizioneSetModulatore = 100#
        ' For i = 0 To numero_punti_curva_portata
		' 	If (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, i)) Then
		' 		if i>0 then
		' 			.BA_PosizioneSetModulatore = (i-1)*10# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, i) - .BAP_RapportoPortataModulatore(combustibile, i-1))) 
		'                                               * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, i-1)))
		' 		else
		' 			.BA_PosizioneSetModulatore = 0#
		' 		end if
		' 	end if
		' next i
		' ----------------------------------------------------------------------------------
	
	
	
        If (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 0)) Then
            .BA_PosizioneSetModulatore = 0#
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 1)) Then
            .BA_PosizioneSetModulatore = 0# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 1) - .BAP_RapportoPortataModulatore(combustibile, 0))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 0)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 2)) Then
            .BA_PosizioneSetModulatore = 10# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 2) - .BAP_RapportoPortataModulatore(combustibile, 1))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 1)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 3)) Then
            .BA_PosizioneSetModulatore = 20# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 3) - .BAP_RapportoPortataModulatore(combustibile, 2))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 2)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 4)) Then
            .BA_PosizioneSetModulatore = 30# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 4) - .BAP_RapportoPortataModulatore(combustibile, 3))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 3)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 5)) Then
            .BA_PosizioneSetModulatore = 40# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 5) - .BAP_RapportoPortataModulatore(combustibile, 4))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 4)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 6)) Then
            .BA_PosizioneSetModulatore = 50# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 6) - .BAP_RapportoPortataModulatore(combustibile, 5))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 5)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 7)) Then
            .BA_PosizioneSetModulatore = 60# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 7) - .BAP_RapportoPortataModulatore(combustibile, 6))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 6)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 8)) Then
            .BA_PosizioneSetModulatore = 70# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 8) - .BAP_RapportoPortataModulatore(combustibile, 7))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 7)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 9)) Then
            .BA_PosizioneSetModulatore = 80# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 9) - .BAP_RapportoPortataModulatore(combustibile, 8))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 8)))
        ElseIf (.BA_portataTotaleSetPredVergERicicl < .BAP_RapportoPortataModulatore(combustibile, 10)) Then
            .BA_PosizioneSetModulatore = 90# + ((10# / (.BAP_RapportoPortataModulatore(combustibile, 10) - .BAP_RapportoPortataModulatore(combustibile, 9))) * (.BA_portataTotaleSetPredVergERicicl - .BAP_RapportoPortataModulatore(combustibile, 9)))
        Else
            .BA_PosizioneSetModulatore = 100#
        End If

        CP240.LblModulatore(3).caption = FormatNumber(.BA_PosizioneSetModulatore, 0, vbTrue, vbFalse, vbFalse)

    End With

End Sub


'Questa Funzione Calcola La Differenza Di Set Tra Temperatura Attuale e Quella Impostata
'E Va A Variare un Valore Che Poi Andrà sommato alla portata del materiale che poi in base alla curva andrà a variare il modulatore.
Private Sub GestTotRegBruciatore(tamburo As Integer)

    Dim LimiteDiAp_ChTot As Double  'Quando la differenza tra Set Modulatore Essiccatore e Reale Modulatore Essiccatore è Superiore a questo valore, tengo il modulatore sempre in apertura oppure in chiusura.
    Dim TempoMaxAttivUscita As Double 'E' il tempo massimo che posso tenere alta l'uscita (In MilliSecondi)
    Dim AttesaContr As Integer
    Dim DiffDiCorr As Double 'Se il valore assoluto di differenza tra set posizione modulat. e reale, è all'interno di questo valore, non muovo il modulatore
    Dim PosModEss As Double


    With ListaTamburi(tamburo)
    
        LimiteDiAp_ChTot = 5#
        TempoMaxAttivUscita = 2000#
        AttesaContr = 3 'Tempo Attesa Dopo Che è stato dato un impulso al modulatore
        DiffDiCorr = 0.5
        
        PosModEss = CDbl(.posizioneModulatoreBruciatorePrecisa)
    
        .BA_PosizioneSetModulatoreTotale = .BA_PosizioneSetModulatore
    
        If (.BA_PosizioneSetModulatoreTotale - PosModEss) > 0 Then
        'caso in cui e' richiesto un aumento del modulatore
            If Abs(.BA_PosizioneSetModulatoreTotale - PosModEss) > LimiteDiAp_ChTot Then
            'sono fuori dalla zona di regolazione: apri a tutto gas!
                .ModulatoreBrucOnUp = True
    
                .BA_AperturaTemporanea = True
                .BA_TimerApertura = ConvertiTimer()
            Else
            'dentro la zona di regolazione: regola a impulsi
                If (.BA_AperturaTemporanea) Then
                    .ModulatoreBrucOnUp = False
                    .BA_AperturaTemporanea = False
                End If

                If (Abs(.BA_PosizioneSetModulatoreTotale - PosModEss) > DiffDiCorr) Then
                    .BA_DurataImpulsoUscitaRegMod = Round((((TempoMaxAttivUscita / LimiteDiAp_ChTot) * Abs(.BA_PosizioneSetModulatoreTotale - PosModEss)) * .BAP_GuadAmplMod), 0)
                    .BA_DurataImpulsoUscitaRegMod = Abs(.BA_DurataImpulsoUscitaRegMod)

                    If (.BA_DurataImpulsoUscitaRegMod < 500) Then
                    'limite minimo durata impulso
                        .BA_DurataImpulsoUscitaRegMod = 500
'                    ElseIf (.BA_DurataImpulsoUscitaRegMod > TempoMaxAttivUscita) Then
'                        .BA_DurataImpulsoUscitaRegMod = TempoMaxAttivUscita
                    End If
                    

                    If (ConvertiTimer() - .BA_TimerApertura) >= (AttesaContr) Then
                        .BA_TimerApertura = ConvertiTimer() + AttesaContr

                        Call AttivaUscitePerRegolazioneEss(1, .BA_DurataImpulsoUscitaRegMod, tamburo) '20170323

'                        .BA_TimerOutIncrBruc = ConvertiTimer()
'                        .ModulatoreBrucOnUp = True
                    
                    End If
                Else
                    .ModulatoreBrucOnUp = False
                    .BA_TimerApertura = ConvertiTimer() + AttesaContr
                End If
            End If
        Else
            .ModulatoreBrucOnUp = False
            .BA_TimerApertura = ConvertiTimer()
        End If


        If .BA_PosizioneSetModulatoreTotale > (PosModEss + 5) And .ModulatoreBrucOnDown Then
        'Controllo se, nonostante il set del modulatore sia superiore alla posizione reale, venga attivata la chiusura: in questo caso la interrompo
        'Questo difetto a volte si manifestava nella versione citect
            .ModulatoreBrucOnDown = False
        Else
        
            If (.BA_PosizioneSetModulatoreTotale - PosModEss) < 0 Then
                If Abs(PosModEss - .BA_PosizioneSetModulatoreTotale) > LimiteDiAp_ChTot Then
                'sono fuori dalla zona di regolazione: chiusura immediata!
                    .ModulatoreBrucOnDown = True
        
                    .BA_ChiusuraTemporanea = True
                    .BA_TimerChiusura = ConvertiTimer()
                Else
                    If (.BA_ChiusuraTemporanea) Then
                        .ModulatoreBrucOnDown = False
                        .BA_ChiusuraTemporanea = False
                    End If
        
                    If (Abs(.BA_PosizioneSetModulatoreTotale - PosModEss) > DiffDiCorr) Then
                        .BA_DurataImpulsoUscitaRegMod = (((TempoMaxAttivUscita / LimiteDiAp_ChTot) * Abs(.BA_PosizioneSetModulatoreTotale - PosModEss)) * .BAP_GuadAmplMod)
                        .BA_DurataImpulsoUscitaRegMod = Abs(.BA_DurataImpulsoUscitaRegMod)
    
                        If (.BA_DurataImpulsoUscitaRegMod < 500) Then
                        'limite minimo durata impulso
                            .BA_DurataImpulsoUscitaRegMod = 500
                        End If
                            
                        If (ConvertiTimer() - .BA_TimerChiusura) >= (AttesaContr) Then
                            .BA_TimerChiusura = ConvertiTimer() + AttesaContr
                        
                            Call AttivaUscitePerRegolazioneEss(-1, .BA_DurataImpulsoUscitaRegMod, tamburo) '20170323
        
'                            .BA_TimerOutDecrBruc = ConvertiTimer()
'                            .ModulatoreBrucOnDown = True
                        End If
                    Else
                        .ModulatoreBrucOnDown = False
                        .BA_TimerChiusura = ConvertiTimer() + AttesaContr
                    End If
                End If
            Else
                .ModulatoreBrucOnDown = False
                .BA_TimerChiusura = ConvertiTimer()
            End If
        End If

    End With

End Sub


'Questa Funzione Gestisce SOLO LA REGOLAZIONE Dell'essiccatore.
Public Sub GestRegolazioneBruciatore(tamburo As Integer)

    With ListaTamburi(tamburo)

        If ((ConvertiTimer() - .BA_TimerRegBruciatore) >= 1) Then
            'Loop a 1 secondo

            If (tamburo = 0) Then
                Call GestSetRegBruciatore
            Else
                Call GestSetRegBruciatore2
            End If

            .BA_TimerRegBruciatore = ConvertiTimer()
        End If
            
        If (.FiammaBruciatorePresente And .BruciatoreAutomatico) Then
        
'            If (.BA_TimerOutIncrBruc > 0 And (ConvertiTimer() - .BA_TimerOutIncrBruc) >= .BA_DurataImpulsoUscitaRegMod / 1000) Then
'                'mantiene l'uscita per il tempo di durata impulso
'                .BA_TimerOutIncrBruc = 0
'                .ModulatoreBrucOnUp = False
'                .ModulatoreBrucOnDown = False
'            ElseIf (.BA_TimerOutDecrBruc > 0 And (ConvertiTimer() - .BA_TimerOutDecrBruc) >= .BA_DurataImpulsoUscitaRegMod / 1000) Then
'                'mantiene l'uscita per il tempo di durata impulso
'                .BA_TimerOutDecrBruc = 0
'                .ModulatoreBrucOnUp = False
'                .ModulatoreBrucOnDown = False
'            End If

            Call GestTotRegBruciatore(tamburo)

        Else
    
            .BA_PosizioneSetModulatoreTotale = 0
    
        End If
    
        If (FormPIDBruc_Visible And TamburoAssociatoAlPID = tamburo) Then
            Call FormPIDBruc.SetLblDebug(0, CStr(.BA_All_141))
            Call FormPIDBruc.SetLblDebug(1, CStr(.BA_DurataImpulsoUscitaRegMod))
            Call FormPIDBruc.SetLblDebug(2, CStr(.BA_TimerOutIncrBruc > 0))
            Call FormPIDBruc.SetLblDebug(3, CStr(.BA_TimerOutDecrBruc > 0))
            Call FormPIDBruc.SetLblDebug(4, Format(CStr(.BA_DiffPercDiTempSetEReale), "##0.0"))
            Call FormPIDBruc.SetLblDebug(5, Format(CStr(.BA_portataTotaleSetPredVergERicicl), "##0.0"))
            Call FormPIDBruc.SetLblDebug(6, Format(CStr(.BA_diffPercDiUmiditaTraTestESet), "##0.0"))
            Call FormPIDBruc.SetLblDebug(7, Format(CStr(.BA_UmPercIstantTotVergERicicl), "##0.0"))
            Call FormPIDBruc.SetLblDebug(8, CStr(.BA_PosizioneSetModulatore))
            Call FormPIDBruc.SetLblDebug(9, CStr(.BA_PosizioneSetModulatoreTotale))
        
            FormPIDBruc.LblDebug(10).caption = "PSetModulatoreTotale = " + FormatNumber(.BA_PosizioneSetModulatoreTotale) + _
                                               "PSetModulatore = " + FormatNumber(.BA_PosizioneSetModulatore) + _
                                               "DurataIUscitaRegMod" + FormatNumber(.BA_DurataImpulsoUscitaRegMod)
        
        End If

    End With

End Sub

'20170323
Public Sub AttivaUscitePerRegolazioneEss(verso As Integer, smSec As Long, tamburo As Integer)

    With FrmGestioneTimer
        
        .tmrImpulsoRegBruc(tamburo).enabled = False
        .tmrImpulsoRegBruc(tamburo).Interval = smSec
        .tmrImpulsoRegBruc(tamburo).enabled = True
        ListaTamburi(tamburo).ModulatoreBrucOnUp = (verso > 0)
        ListaTamburi(tamburo).ModulatoreBrucOnDown = (verso < 0)

    End With

End Sub
'





