Attribute VB_Name = "ParaTab"
'
'   Gestione dei parametri
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Public ParameterPlus As Configuration

Private sendParFromPlcDone As Boolean '20161024
'

Public Const DISPLAY_WIDTH_TWIPS As Integer = 28800


Public Sub ParametriApply()

    Dim indice As Integer

    ParaTabGeneral_Apply
    ParaTabMotor_Apply
    ParaTabComandi_Apply
    ParaTabAmp_Apply
    ParaTabBruc_Apply
    ParaTabLeg_Apply
    ParaTabSchiumato_Apply
    ParaTabPred_Apply
    ParaTabSilo_Apply
    ParaTabDos_Apply
    ParaTabVarie_Apply
    ParaTabAdd_Apply
    ParaTabTrend_Apply
    ParaTabCist_Apply
    ParaTabAquablack_Apply '20160729

    '   Per finire applico le modifiche "trasversali" (utilizzano flag incrociati)

    With CP240

        If InclusioneDMR Then
            .FrameSiloFiller(0).Visible = (ListaMotori(MotoreCocleaEstrazioneFillerRecupero).presente And InclusioneSiloFillerRecuperoDMR)
            .AniPushButtonDeflettore(2).Visible = (ListaMotori(MotoreElevatoreF1).presente)
        Else
            'Se ho la coclea Estrazione Filler Recupero ho la gestione del filler
            .FrameSiloFiller(0).Visible = ListaMotori(MotoreCocleaEstrazioneFillerRecupero).presente
            .AniPushButtonDeflettore(2).Visible = (ListaMotori(MotoreCocleaEstrazioneFillerRecupero).presente And Not AbilitaBindicatorFillerEsterni)
        End If

        'Visualizzazione vaglio sgrossatore o nastro collettore su linee del fresato caldo (1) e freddo (2)
        'opzione attivabile esclusivamente con un solo predosatore
        If (ShowHotRecyScreen) Then 'Vaglio sgrossatore
            ListaMotori(MotoreNastroCollettoreRiciclato).Descrizione = LoadXLSString(482)
            .ImgMotor(MotoreNastroCollettoreRiciclato).ToolTipText = LoadXLSString(482)
            .ImgMotor(100 + MotoreNastroCollettoreRiciclato).top = 355
            .ImgMotor(100 + MotoreNastroCollettoreRiciclato).width = 35
            .ImgMotor(100 + MotoreNastroCollettoreRiciclato).Height = 25
        Else 'Nastro collettore
            ListaMotori(MotoreNastroCollettoreRiciclato).Descrizione = LoadXLSString(27)
            .ImgMotor(MotoreNastroCollettoreRiciclato).ToolTipText = LoadXLSString(27)
            .ImgMotor(100 + MotoreNastroCollettoreRiciclato).top = 360
            .ImgMotor(100 + MotoreNastroCollettoreRiciclato).width = 75
            .ImgMotor(100 + MotoreNastroCollettoreRiciclato).Height = 20
        End If
        
        If (ShowColdRecyScreen) Then 'Vaglio sgrossatore
            ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).Descrizione = LoadXLSString(1094)
            .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).ToolTipText = LoadXLSString(1094)
            .ImgMotor(100 + MotoreNastroCollettoreRiciclatoFreddo).top = 355
            .ImgMotor(100 + MotoreNastroCollettoreRiciclatoFreddo).width = 35
            .ImgMotor(100 + MotoreNastroCollettoreRiciclatoFreddo).Height = 25
        Else 'Nastro collettore
            ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).Descrizione = LoadXLSString(1093)
            .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).ToolTipText = LoadXLSString(1093)
            .ImgMotor(100 + MotoreNastroCollettoreRiciclatoFreddo).top = 360
            .ImgMotor(100 + MotoreNastroCollettoreRiciclatoFreddo).width = 75
            .ImgMotor(100 + MotoreNastroCollettoreRiciclatoFreddo).Height = 20
        End If

        .ImgMotor(MotorePompaCombustibile).enabled = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas)
        .ImgMotor(100 + MotorePompaCombustibile).enabled = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas)

        .ImgMotor(MotorePompaCombustibile2).enabled = (ListaTamburi(1).SelezioneCombustibile <> CombustibileGas)
        .ImgMotor(100 + MotorePompaCombustibile2).enabled = (ListaTamburi(1).SelezioneCombustibile <> CombustibileGas)

        'Temperatura Tubazioni 1
        .LblTempBitume(3).Visible = InclusioneTemperaturaLineaCaricoBitume
        .ImgTempOlio(1).Visible = InclusioneTemperaturaLineaCaricoBitume

        'Temperatura Tubazioni 2
        .LblTempBitume(4).Visible = InclusioneBitume2 And InclusioneTemperaturaLineaCaricoBitume
        .ImgTempOlio(2).Visible = InclusioneBitume2 And InclusioneTemperaturaLineaCaricoBitume

        'Temperatura Tubazioni 3
        .LblTempBitume(6).Visible = ListaMotori(MotorePCL3).presente And InclusioneTemperaturaLineaCaricoBitume
        .ImgTempOlio(3).Visible = ListaMotori(MotorePCL3).presente And InclusioneTemperaturaLineaCaricoBitume

        .LblTempBitume(8).Visible = ListaMotori(MotorePompaEmulsione).presente And InclusioneTemperaturaLineaCaricoBitume
        .ImgTempOlio(4).Visible = ListaMotori(MotorePompaEmulsione).presente And InclusioneTemperaturaLineaCaricoBitume

'20161206
'        .CmdNettiSiloStoricoSommaSalva(16).Visible = (AbilitaInversionePCL Or AbilitaInversioneAdditivoBacinella )
        .CmdNettiSiloStoricoSommaSalva(16).Visible = (AbilitaInversionePCL Or (AbilitaInversioneAdditivoBacinella And InclusioneAddBacinella))
'
        
        .TextTempiRitardoSc(15).text = CStr(AntiadesivoScivoloScarBilRAP.tempo_spruzzatura)
        
        .Frame1(15).Visible = AbilitaRAPSiwa
        .ProgressBil(7).Visible = AbilitaRAP
        .ProgressBil(8).Visible = AbilitaRAPSiwa
        .Image1(69).Visible = AbilitaRAP
        .AniPushButtonDeflettore(32).Visible = AbilitaRAP
        .AniPushButtonDeflettore(33).Visible = AbilitaRAP
        .ImgAdditivo(40).Visible = AbilitaRAP
        .AniPushGenerico(1).Visible = AbilitaRAP
        .TextTempiRitardoSc(15).Visible = AbilitaRAP
        .TextTempiRitardoSc(16).Visible = AbilitaRAP
        .TextTempiRitardoSc(17).Visible = AbilitaRAPSiwa    '20161222
    End With


    For indice = 0 To MAXAMPEROMETRI - 1
        If (ListaAmperometri(indice).Inclusione) Then
            ValoreAmperometri_change indice
        End If
    Next indice

    Call PlcInviaParametri
    Call CisterneInviaParametri

    For indice = 0 To MAXPREDOSATORI - 1
        ListaPredosatori(indice).motore.tempoAttesaRitorno = tempoAttesaMotOn
    Next indice
    For indice = 0 To MAXPREDOSATORIRICICLATO - 1
        ListaPredosatoriRic(indice).motore.tempoAttesaRitorno = tempoAttesaMotOn
    Next indice

    Call VisualizzaPortateNastri

    InclusioneTramoggiaTamponeF1 = ListaMotori(MotoreElevatoreF1).presente

    'Aggiorna la visualizzazione dei livelli tramogge a seguito di una modifica nella riscalatura dei livelli nei parametri
    '20170222
    'For indice = 0 To 8
    For indice = LBound(DosaggioAggregati) To UBound(DosaggioAggregati)
    '
        Call LivelloTramoggia_change(indice)
    Next indice
    
    LivelloTramoggia_change (18)
    
    '20170222
    For indice = LBound(DosaggioFiller) To UBound(DosaggioFiller)
    'For indice = 0 To 2
    '
        Call ValoreLivelloSiloFiller_change(indice)
    Next indice
    '

    'ParallelDrum: verifica/gestione tamburo parallelo
    Call ParallelDrumManagement

    
    Call DisponiPulsantiPlusForm(CP240, TBB_MOTORI, TBB_TREND, False, False)
    CP240.Frame1(47).left = CP240.imgPulsanteForm(TBB_GRUPPO_STORICI).left / 15

    Call DisponiPulsantiPlusForm(CP240, TBB_LEGANTE, TBB_COMBUSTIBILE, False, False)
    CP240.Frame1(48).left = CP240.imgPulsanteForm(TBB_GRUPPO_CISTERNE).left / 15
    CP240.Frame1(48).width = IIf(CistGestione.NumCisterneEmulsione > 0 And CistGestione.NumCisterneCombustibile > 0, 241, 169)

End Sub

'   Legge il file dei parametri
Public Sub ParametriReadFile()

    ParaTabGeneral_ReadFile
    ParaTabBruc_ReadFile
    ParaTabCist_ReadFile
    ParaTabLeg_ReadFile
    ParaTabSchiumato_ReadFile
    ParaTabMotor_ReadFile
    ParaTabComandi_ReadFile
    ParaTabAmp_ReadFile
    ParaTabPred_ReadFile
    ParaTabSilo_ReadFile
    ParaTabDos_ReadFile
    ParaTabVarie_ReadFile
    ParaTabAdd_ReadFile
    ParaTabTrend_ReadFile
    ReadFileRiscaldamenti
    ParaTabAquablack_ReadFile '20160729
    
End Sub

'20161024 non usata
Public Sub SendParametersFromPLC()

    If (Not sendParFromPlcDone) Then
        Dim presBilPNetAgg As Boolean
        Dim presBilPNetFil As Boolean
        Dim presBilPNetBit As Boolean
        Dim presBilPNetRic As Boolean
        Dim presBilPNetVia As Boolean
        Dim presBilPNetVia2 As Boolean
                  
        presBilPNetAgg = CP240.OPCData.items(PLCTAG_BIL_PNET_Aggregati_Presenza).Value
        presBilPNetFil = CP240.OPCData.items(PLCTAG_BIL_PNET_Filler_Presenza).Value
        presBilPNetBit = CP240.OPCData.items(PLCTAG_BIL_PNET_Bitume_Presenza).Value
        presBilPNetRic = CP240.OPCData.items(PLCTAG_BIL_PNET_Riciclato_Presenza).Value
        presBilPNetVia = CP240.OPCData.items(PLCTAG_BIL_PNET_Viatop_Presenza).Value
        presBilPNetVia2 = CP240.OPCData.items(PLCTAG_BIL_PNET_Viatop2_Presenza).Value
        Dim msg As String
        msg = "PresenzaBilPNetAgg" + "|" + CStr(presBilPNetAgg) + "|" + "PresenzaBilPNetFil" + "|" + CStr(presBilPNetFil) + "|" + "PresenzaBilPNetBit" + "|" + CStr(presBilPNetBit) + "|" + "PresenzaBilPNetRic" + "|" + CStr(presBilPNetRic)
        msg = msg + CStr(presBilPNetBit) + "|" + "PresenzaBilPNetViatop" + "|" + CStr(presBilPNetVia) + "|" + "PresenzaBilPNetViatop2" + "|" + CStr(presBilPNetVia2)
        Call SendMessagetoPlus(PlusSendParametersFromPlc, msg)
        sendParFromPlcDone = True
    End If
End Sub
'20161024

'ParallelDrum
Sub ParallelDrumManagement()
    
    ParallelDrum = ListaMotori(MotoreRotazioneEssiccatore2).presente
    
    If Not ParallelDrum And AbilitaRAP And AbilitaRAPSiwa Then
        AbilitaRAP = False
        AbilitaRAPSiwa = False
    End If

    
    '-----------------------------------------------------------------------------
    '------------------------------- GRAFICA CP240 -------------------------------
    '-----------------------------------------------------------------------------
    ' i primi due predosatori-fresato sono designati al trattamento 'caldo'
    ' il 3 e 4 vengono accorpati ad ulteriori 4 per alimentare il tamburo parallelo
    Call VisualizzaPredosatoriImpostati
        
    With CP240
        .FrameTamburoParallelo(1).Visible = ParallelDrum
        .FrameTamburoParallelo(2).Visible = ParallelDrum
        .FrameTamburoParallelo(3).Visible = ParallelDrum
        
        .LblDepressioneBruc(2).Visible = ParallelDrum 'depressione ingresso filtro
        .lblEtichetta(101).Visible = ParallelDrum
        
        'Nastro bypass tamburo parallelo
        .ImgMotor(MotoreNastroBypassEssicatore).Visible = ParallelDrum And ListaMotori(MotoreNastroBypassEssicatore).presente
        .ImgMotor(MotoreNastroBypassEssicatore + 100).Visible = ParallelDrum And ListaMotori(MotoreNastroBypassEssicatore).presente
        .AniPushButtonDeflettore(29).Visible = ListaMotori(MotoreNastroBypassEssicatore).presente
        .AniPushButtonDeflettore(30).Visible = ListaMotori(MotoreNastroBypassEssicatore).presente
        ' TODO Tramoggia tampone sotto nastro Bypass tamb. parallelo
        .FrameTr(18).Visible = AbilitaRAP
        .FrameTr(19).Visible = AbilitaRAPSiwa
     '   .FrameTr(18).top = .FrameTr(6).top 'allineo la tramoggia del freddo con quella del tamb. parallelo


        'Il tamburo parallelo utilizza 2 monitor
        .width = DISPLAY_WIDTH_TWIPS
        .ScaleWidth = 1920
        If ParallelDrum Then
            .width = .width * 2 '57600 Twips
            'TODO Vecchio nome della barra menu..gestire eventualmente la nuova
            '.Frame1(8).width = .Frame1(8).width + 1920 ' espando la barra del top-menu anche sul 2o monitor
        End If
        
        'sistemazione del RAPSiwa nel monitor di sinistra in assenza di tamburo parallelo
        If Not ParallelDrum Then
            .FrameTr(19).left = CP240.ImgMotor(100 + MotoreElevatoreCaldo).left - 65
            .FrameTr(19).top = 113
            .Frame1(15).Visible = False

            'Tramoggia riciclato caldo
            'con monitor singolo è sovrapposta alla bil Siwa, quindi è ammessa la presenza di una sola delle due bilance alla volta
            .FrameTr(18).left = CP240.ImgMotor(100 + MotoreElevatoreCaldo).left - 65
            .FrameTr(18).top = 113
            .ProgressBil(7).left = CP240.ImgMotor(100 + MotoreElevatoreCaldo).left - 65
            .ProgressBil(8).left = CP240.ImgMotor(100 + MotoreElevatoreCaldo).left - 65
            .TextTempiRitardoSc(16).left = .FrameTr(18).left
            .TextTempiRitardoSc(17).left = .FrameTr(19).left    '20161222
            .TextTempiRitardoSc(17).top = 370   '20161222
'
            .CmdScarica(3).left = .FrameTr(18).left + (.FrameTr(18).width / 2) + 5
            .CmdScarica(3).top = .CmdScarica(0).top
        Else
            .FrameTr(19).left = 3680
            .FrameTr(19).top = 113
            .Frame1(15).top = 366
            .Frame1(15).left = 3656
            .TextTempiRitardoSc(16).left = .FrameTr(18).left + 40
            .TextTempiRitardoSc(16).top = 371
            .FrameTr(18).left = 3540
            .FrameTr(18).top = 113
            .ProgressBil(7).left = 3540
            .ProgressBil(8).left = 3680
        End If

        If Not ParallelDrum Then
            Exit Sub
        End If
        
        'Posizione e dimensione nastro collettore ric. freddo
        'sotto i predosatori abilitati
        Dim left As Long
        Dim K As Integer
        Dim i As Integer
        left = 65000
        For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1

            If InvertiNumerazionePred(NastriPredosatori.RiciclatoFreddo) Then
                K = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1 - i
            Else
                K = i + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)
            End If
            If .FramePredRic(K).left < left Then
                left = .FramePredRic(K).left
            End If
        Next i
        left = left + 5
        
        ' Sposto i dispositivi legati al trattamento del riciclato sul secondo monitor
        .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).width = (.FramePredRic(0).width + 5) * i
        .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).left = left
        .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).top = 530
        .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).left = left
        .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).top = .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).top + _
                                                                .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).Height - _
                                                                .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).Height
        .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).width = 245
        .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).top = .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).top
        .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).left = .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).left + _
                                                                            .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).width + 5
        .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo).top = .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).top + _
                                                                    .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).Height - _
                                                                    .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo).Height
        .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo).left = .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).left
        
        .ImgMotor(MotoreElevatoreRiciclato + 100).top = 270
    
        .ImgMotor(MotoreElevatoreRiciclato + 100).left = .ImgMotor(MotoreNastroBypassEssicatore + 100).left - 25
        
        .ImgMotor(MotoreElevatoreRiciclato).top = .ImgMotor(MotoreElevatoreRiciclato + 100).top + _
                                                    .ImgMotor(MotoreElevatoreRiciclato + 100).Height - _
                                                    .ImgMotor(MotoreElevatoreRiciclato).Height

        .ImgMotor(MotoreElevatoreRiciclato).left = .ImgMotor(MotoreNastroBypassEssicatore + 100).left - 25
        
        'caso in cui non esista il nastro collettore riciclato freddo
        If Not (ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente) And NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) > 0 Then
            .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).width = (.FramePredRic(0).width + 5) * i + 80 'dimensiona per ingrandire il nastro
            .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).left = .FramePredRic(NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1).left
            .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo).left = .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo + 100).left
        End If

        'caso in cui non esista il nastro trasportatore riciclato freddo
        If Not (ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente) And NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) > 0 Then
            .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).width = (.FramePredRic(0).width + 5) * i + 80 'dimensiona per ingrandire il nastro
            .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).left = .FramePredRic(NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1).left
            .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).left = .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo + 100).left
        End If

        ' Se ho due monitor a disposizione muovo il parco legante nel secondo
        If (CistGestione.Gestione <> NessunaGestione) Then
            For i = 0 To 2
                .FrameCisterne(i).left = IIf(.FrameCisterne(i).left > 1920, .FrameCisterne(i).left, .FrameCisterne(i).left + 1920)
            Next i
        End If
        
        If ParallelDrum Then
        
            'posiziona il frame con i controlli della pesa sul nastro riciclato (frame creato nuovo. prima era lo stesso sia per riciclato freddo che caldo)
            .Frame1(5).left = .ImgMotor(MotoreNastroTrasportatoreRiciclatoFreddo).left + 100
            .Frame1(5).top = .ImgMotor(MotoreNastroCollettoreRiciclatoFreddo).top + 40
        
            'posiziona la temperatura dello scivolo + tutti i suoi accessori sul tamburo 2 appena sopra il silo del riciclato freddo

            .LblTempMateriale(6).left = 6300 'casella temperatura scivolo
            .LblTempMateriale(6).top = 2350
            
            .Image10(9).left = 6300 'simbolo termometro
            .Image10(9).top = 2100
            
            .TxtTemperaturaBruciatoreAutomatico(1).left = 6950 'casella set temperatura scivolo
            .TxtTemperaturaBruciatoreAutomatico(1).top = 2350
            
            .lblEtichetta(84).left = 6830 'simbolo gradi C
            .lblEtichetta(84).top = 2050
            
            .Image1(39).left = 5500 'icona allarme alta temperatura
            .Image1(39).top = 2700
        
            .ImgMotor(MotoreRotazioneEssiccatore2).left = 2600
            
            .Image1(44).Picture = LoadResPicture("IDI_PREDRICICLATO", vbResIcon) 'immagine predosatore riciclato accanto al pulsante auto/man per gestione livello automatico tramoggia tampone
            .Image1(44).Visible = True
            
            .AniPushButtonDeflettore(31).Visible = True 'pulsante auto/man per gestione livello automatico tramoggia tampone
            .AniPushButtonDeflettore(31).enabled = True
            
            'gruppo dei pulsanti di controllo start bruciatore 2
            .CmdStartBruc(1).left = 3500
            .CmdStartBruc(1).top = 2100
            
            'allineo gli altri pulsanti a quello sopra
            .CmdAvviamentoBruciatoreCaldo(1).left = .CmdStartBruc(1).left - .CmdAvviamentoBruciatoreCaldo(1).width
            .CmdAvviamentoBruciatoreCaldo(1).top = .CmdStartBruc(1).top

            .CmdStopBruc(1).left = .CmdStartBruc(1).left + .CmdStartBruc(1).width
            .CmdStopBruc(1).top = .CmdStartBruc(1).top

            .PctStartRicevuto(1).left = .CmdStartBruc(1).left + .CmdStartBruc(1).width / 2 - .PctStartRicevuto(1).width / 2
            .PctStartRicevuto(1).top = .CmdStartBruc(1).top + .CmdStartBruc(1).Height + 10
            
            .Image1(38).left = .CmdStartBruc(1).left + .CmdStartBruc(1).width / 2 - .Image1(38).width
            .Image1(38).top = .CmdStartBruc(1).top - .Image1(38).Height - 10
            
            'pulsanti di avvio motori
            .Frame1(20).Height = 170
            
            .FrameCisterne(2).Height = 300
            .Frame1(24).left = 1921
            .Frame1(36).left = 1921
            .Frame1(39).left = 1921
            
            .imgPulsanteForm(TBB_LEGANTE).left = 27930
            .imgPulsanteForm(TBB_EMULSIONE).left = .imgPulsanteForm(TBB_LEGANTE).left + 660
            .imgPulsanteForm(TBB_COMBUSTIBILE).left = .imgPulsanteForm(TBB_EMULSIONE).left + 660

        End If
    End With
     
End Sub

