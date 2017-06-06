Attribute VB_Name = "ParaTabMotor"
'
'   Gestione dei parametri dei motori
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE As String = "Motori"


Public Function ParaTabMotor_ReadFile() As Boolean

    Dim motore As Integer


    ParaTabMotor_ReadFile = False

    'CYBERTRONIC_PLUS

    GruppoAvviamentoSelezionato(0) = String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "", "Gruppo0"))
    GruppoAvviamentoSelezionato(1) = String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "", "Gruppo1"))
    GruppoAvviamentoSelezionato(2) = String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "", "Gruppo2"))

    tempoAttesaMotOn = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "tempoAttesaMotOn"))
    NumeroCocleeRecupero = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumeroCocleeRecupero"))
    NumeroCocleePreseparatore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumeroCocleePreseparatore"))
    AbilitaTermicaComune = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaTermicaComune"))

    For motore = 1 To MAXMOTORI

        With ListaMotori(motore)

            .presente = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "Presente"))
            .asservimento = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "Asservimento"))
            .tempoStart = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "tempoStart"))
            .tempoStop = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "tempoStop"))
            .offStart = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "offStart"))
            .onStop = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "onStop"))
            '20150625
            '.uscitaAnalogica = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "UscitaAnalogica"))
            '.tempoAttesaRitorno = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoAttesaRitorno"))
            '
            .tempoRitAllSlittamento = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoRitAllSlittamento"))
            If (.tempoAttesaRitorno = 0) Then
                .tempoAttesaRitorno = 3
            End If
            '20161020
            .GestioneInternaSlittamento = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "GestioneInternaSlittamento"))
            .Soglia1Slittamento = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "Soglia1Slittamento"))
            .TempoSoglia1Slittamento = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoSoglia1Slittamento")) * 1000
            .Soglia2Slittamento = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "Soglia2Slittamento"))
            .TempoSoglia2Slittamento = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoSoglia2Slittamento")) * 1000
            '20161020
            '20150625
            '.InverterPresente = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "InverterPresente"))
            .InverterPresente = ((String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TipoAzionamento"))) = 1)
            .SoftStarterPresente = ((String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TipoAzionamento"))) = 2)
            .tempoAttesaRitorno = IIf( _
                (.InverterPresente Or .SoftStarterPresente), _
                String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoAttesaRitorno")), _
                tempoAttesaMotOn _
                )
            .uscitaAnalogica = IIf(.InverterPresente, String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "UscitaAnalogica")), 0)
            '

            .SoloVisualizzazione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "SoloVisualizzazione"))
            If (motore <> MotoreMescolatore And motore <> MotoreElevatoreCaldo And motore <> MotoreRotazioneEssiccatore And motore <> MotoreRotazioneEssiccatore2) Then
                'NON GESTITA!
                .uscitaAnalogica = -1
            End If
            .pausaLavoro.TempoLavoro = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoLavoro"))
            .pausaLavoro.TempoPausa = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Motore" + CStr(motore), "", "TempoPausa"))
            If (ListaMotori(motore).pausaLavoro.TempoLavoro <= 0 Or ListaMotori(motore).pausaLavoro.TempoPausa <= 0) Then
                ListaMotori(motore).pausaLavoro.TempoLavoro = 0
                ListaMotori(motore).pausaLavoro.TempoPausa = 0
            End If
            .pausaLavoro.abilitato = (.pausaLavoro.TempoLavoro > 0 And .pausaLavoro.TempoPausa > 0)
            If (.tempoStart <= 0) Then
                .tempoStart = 1
            End If
            If (.tempoStop <= 0) Then
                .tempoStop = 1
            End If
    
            GruppoAvviamentoSelezionato(0) = String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "", "Gruppo0"))
            
            OrdineAvviamentoMotori(motore) = CInt(left(ParameterPlus.GetParameterValue("OrdineMotori", "OrdineAvviamento", "", "OrdineAvvio" + CStr(motore)), 2))
            OrdineSpegnimentoMotori(motore) = CInt(left(ParameterPlus.GetParameterValue("OrdineMotori", "OrdineSpegnimentoMotori", "", "OrdineArresto" + CStr(motore)), 2))

            ListaMotori(motore).EsclusioneConAvviamentoRidotto = False
            ListaMotori(motore).GruppoEsclusione = AvviamentoMotoriCompleto

            If String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "EsclusioneTamburoPrincipale", "Motore" + CStr(motore))) Then
                ListaMotori(motore).EsclusioneConAvviamentoRidotto = True
                ListaMotori(motore).GruppoEsclusione = AvviamentoMotoriNoTamburoPrincipale
            End If
            If String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "EsclusioneTamburoParallelo", "Motore" + CStr(motore))) Then
                ListaMotori(motore).EsclusioneConAvviamentoRidotto = True
                ListaMotori(motore).GruppoEsclusione = AvviamentoMotoriNoTamburoParallelo
            End If
            If String2Bool(ParameterPlus.GetParameterValue("OrdineMotori", "AvviamentoRidotto", "EsclusioneRiciclatoFreddo", "Motore" + CStr(motore))) Then
                ListaMotori(motore).EsclusioneConAvviamentoRidotto = True
                ListaMotori(motore).GruppoEsclusione = AvviamentoMotoriNoRiciclatoFreddo
            End If
        
        End With

    Next motore

    'OKKIO a MAXMOTORI
    If (DEBUGGING) Then
        For motore = 1 To MAXMOTORI
            Debug.Assert (OrdineAvviamentoMotori(motore) <> 0)
            Debug.Assert (OrdineSpegnimentoMotori(motore) <> 0)
        Next motore
    End If

        
    ParaTabMotor_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabMotor_Apply()

    Dim motore As Integer

    With CP240

        Call CaricaTestiMotori

        .CmdAvviamentoBruciatoreCaldo(0).Visible = (Not ListaTamburi(0).EsclusioneAvviamentoCaldo)
        .CmdAvviamentoBruciatoreCaldo(1).Visible = (Not ListaTamburi(1).EsclusioneAvviamentoCaldo)

        For motore = 1 To MAXMOTORI

            If motore <> MotoreElevatoreCaldo And motore <> MotoreAspiratoreFiltro And motore <> MotoreMescolatore And motore <> MotoreRotazioneEssiccatore And motore <> MotoreRotazioneEssiccatore2 _
            And motore <> MotoreFillerizzazioneFiltroRecupero And motore <> MotoreFillerizzazioneFiltroApporto Then
                ListaMotori(motore).tempoAttesaRitorno = tempoAttesaMotOn
            End If

            .ImgMotor(motore).Picture = LoadResPicture("IDB_MOTORE", vbResBitmap)

            .ImgMotor(motore).ToolTipText = ListaMotori(motore).Descrizione

            If ( _
                motore = MotoreCoclea123_2 Or motore = MotoreCoclea123_3 Or motore = MotoreCoclea123_4 Or motore = MotoreCoclea123_5 Or _
                motore = MotoreCocleaPreseparatrice_2 Or motore = MotoreCocleaPreseparatrice_3 Or motore = MotoreCocleaPreseparatrice_4 Or motore = MotoreCocleaPreseparatrice_5 _
            ) Then
                'MAI e dico MAI visibili
                .ImgMotor(motore).Visible = False
                .ImgMotor(100 + motore).Visible = False
            Else
                .ImgMotor(motore).Visible = ListaMotori(motore).presente And (Not ListaMotori(motore).SoloVisualizzazione)
                .ImgMotor(100 + motore).Visible = ListaMotori(motore).presente
            End If

            .ImgMotor(100 + motore).ToolTipText = ListaMotori(motore).Descrizione

            Call MotoreAggiornaGrafica(motore)

        Next motore
        .ImgMotor(100 + MotorePompaAltaPressione).Visible = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And ListaMotori(MotorePompaAltaPressione).presente)
        .ImgMotor(100 + MotorePompaAltaPressione2).Visible = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And ListaMotori(MotorePompaAltaPressione2).presente)
        
        .ImgMotor(MotorePompaAltaPressione).Visible = False
        .ImgMotor(MotorePompaAltaPressione2).Visible = False
        .ImgMotor(MotorePompaCombustibile).Visible = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And ListaMotori(MotorePompaCombustibile).presente And Not ListaMotori(MotorePompaCombustibile).SoloVisualizzazione)
        .ImgMotor(100 + MotorePompaCombustibile).Visible = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And ListaMotori(MotorePompaCombustibile).presente)
        .ImgMotor(100 + MotorePompaCombustibile2).Visible = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And ListaMotori(MotorePompaCombustibile2).presente)

        'Preseparatore
        .ImgMotor(200 + MotoreCocleaPreseparatrice).Visible = ListaMotori(MotoreCocleaPreseparatrice).presente
        .ImgMotor(200 + MotoreCocleaPreseparatrice).ToolTipText = ListaMotori(MotoreCocleaPreseparatrice).Descrizione

        If InclusioneDMR Then
            
            .ImgMotor(MotoreCocleaPreseparatrice).top = 245
            .ImgMotor(100 + MotoreCocleaPreseparatrice).top = 240
            .ImgMotor(200 + MotoreCocleaPreseparatrice).top = 101
        
        End If
            
        'Posiziono la coclea filtro in base al tipo di filtro
        If InclusioneDMR Then
            .ImgMotor(100 + MotoreCocleaFiltro).top = 240
            .ImgMotor(MotoreCocleaFiltro).top = 245
        Else
            .ImgMotor(MotoreCocleaFiltro).top = 192
            .ImgMotor(100 + MotoreCocleaFiltro).top = 188
        End If

        '20161114
        '.imgValvolaCisterne(5).left = 602
        .imgValvolaCisterne(5).left = 618
        '
        .imgValvolaCisterne(5).top = 240
        .imgValvolaCisterne(5).Visible = InclusioneDMR

        'Posiziono la coclea recupero in base al tipo di filtro
        If InclusioneDMR Then
            .ImgMotor(MotoreCoclea123).top = 260
            .ImgMotor(100 + MotoreCoclea123).top = 255
            
            '20161114
            '.ImgMotor(MotoreCoclea123).left = 608
            '.ImgMotor(100 + MotoreCoclea123).left = 608
            .ImgMotor(MotoreCoclea123).left = 624
            .ImgMotor(100 + MotoreCoclea123).left = 624
            '
        Else
            .ImgMotor(MotoreCoclea123).top = 196
            .ImgMotor(100 + MotoreCoclea123).top = 192
        End If
        
        'Posizione il "motorino bianco" dell'aspiratore filtro in base al tipo di filtro
        If InclusioneDMR Then
            .ImgMotor(MotoreAspiratoreFiltro).top = 152
        Else
            .ImgMotor(MotoreAspiratoreFiltro).top = 160
        End If

        'Temperatura PCL1
        .lblEtichetta(51).Visible = (ListaMotori(MotorePCL).presente And ListaMotori(MotorePCL2).presente)
        .Image10(4).Visible = ListaMotori(MotorePCL).presente
        .LblTempBitume(0).Visible = ListaMotori(MotorePCL).presente
        .lblEtichetta(11).Visible = ListaMotori(MotorePCL).presente

        'Temperatura PCL2
        .lblEtichetta(52).Visible = ListaMotori(MotorePCL2).presente
        .Image10(7).Visible = ListaMotori(MotorePCL2).presente
        .LblTempBitume(2).Visible = ListaMotori(MotorePCL2).presente
        .lblEtichetta(25).Visible = ListaMotori(MotorePCL2).presente

        'Temperatura PCL3
        .lblEtichetta(14).Visible = ListaMotori(MotorePCL3).presente
        .Image10(0).Visible = ListaMotori(MotorePCL3).presente
        .LblTempBitume(5).Visible = ListaMotori(MotorePCL3).presente
        .lblEtichetta(45).Visible = ListaMotori(MotorePCL3).presente
        '

        'Temperatura Emulsione
        .lblEtichetta(71).Visible = ListaMotori(MotorePompaEmulsione).presente
        .Image10(8).Visible = ListaMotori(MotorePompaEmulsione).presente
        .LblTempBitume(7).Visible = ListaMotori(MotorePompaEmulsione).presente
        .lblEtichetta(68).Visible = ListaMotori(MotorePompaEmulsione).presente
        '

        .Frame1(57).Visible = ListaMotori(MotoreTrasportoFillerizzazioneFiltro).presente
        .AniPushButtonDeflettore(36).Visible = ListaMotori(MotoreTrasportoFillerizzazioneFiltro).presente

        .AniPushButtonDeflettore(29).Visible = ListaMotori(MotoreNastroBypassEssicatore).presente
        .AniPushButtonDeflettore(30).Visible = ListaMotori(MotoreNastroBypassEssicatore).presente

        .AniPushButtonDeflettore(24).Visible = ListaMotori(MotoreNastroRapJolly).presente   '20170220
        '20161212
        If ((Not ListaMotori(MotoreNastroCollettore2).presente) And (Not ListaMotori(MotoreNastroCollettore3).presente)) Then
            .ImgMotor(100 + MotoreNastroRapJolly).top = 500
            .ImgMotor(MotoreNastroRapJolly).top = 505
'            .LblEtichetta(76).top = 500
'            .LblEtichetta(76).left = .ImgMotor(MotoreNastroRapJolly).left - 50
            '.AniPushButtonDeflettore(24).Visible = ListaMotori(MotoreNastroRapJolly).presente   '20170220
            .AniPushButtonDeflettore(24).top = 500
'            .AniPushButtonDeflettore(24).left = .LblEtichetta(76).left - 50
            .AniPushButtonDeflettore(24).left = .ImgMotor(MotoreNastroRapJolly).left - 70
        End If
        '20161212
    End With

    NessunRidottoSelezionato = (Not GruppoAvviamentoSelezionato(0) And Not GruppoAvviamentoSelezionato(1) And Not GruppoAvviamentoSelezionato(2))

    Call ParaTabAmp_Apply

End Sub


Public Sub CaricaTestiMotori()

    ListaMotori(MotoreCompressore).Descrizione = LoadXLSString(1)
    ListaMotori(MotorePCL).Descrizione = LoadXLSString(2)
    If (ListaMotori(MotorePCL2).presente) Then
        ListaMotori(MotorePCL).Descrizione = LoadXLSString(2) + " 1"
    End If
    ListaMotori(MotorePCL2).Descrizione = LoadXLSString(2) + " 2"
    ListaMotori(MotoreAspiratoreFiltro).Descrizione = LoadXLSString(22)
    ListaMotori(MotoreMescolatore).Descrizione = LoadXLSString(4)
    ListaMotori(MotoreAspiratoreVaglio).Descrizione = LoadXLSString(5)
    ListaMotori(MotoreVaglio).Descrizione = LoadXLSString(6)
    ListaMotori(MotoreElevatoreCaldo).Descrizione = LoadXLSString(7)
    ListaMotori(MotoreCocleaRitorno).Descrizione = LoadXLSString(8)
    ListaMotori(MotoreElevatoreF1).Descrizione = LoadXLSString(9)
    ListaMotori(MotoreCoclea123).Descrizione = LoadXLSString(23)
    ListaMotori(MotoreCocleaEstrazioneFillerRecupero).Descrizione = LoadXLSString(10)
    ListaMotori(MotoreCocleaPreseparatrice).Descrizione = LoadXLSString(12)
    ListaMotori(MotoreElevatoreF2).Descrizione = LoadXLSString(29)
    ListaMotori(MotoreCocleaEstrazioneFillerApporto).Descrizione = LoadXLSString(24)
    ListaMotori(MotoreCocleaFiltro).Descrizione = LoadXLSString(13)
    ListaMotori(MotoreRotazioneEssiccatore).Descrizione = LoadXLSString(15)
    ListaMotori(MotorePompaCombustibile).Descrizione = LoadXLSString(14)
    ListaMotori(MotoreVentolaBruciatore).Descrizione = LoadXLSString(501)
    ListaMotori(MotoreNastroElevatoreFreddo).Descrizione = LoadXLSString(16)
    ListaMotori(MotoreNastroCollettore1).Descrizione = LoadXLSString(17)
    ListaMotori(MotoreNastroCollettore2).Descrizione = LoadXLSString(18)
    ListaMotori(MotorePCL3).Descrizione = LoadXLSString(2) + " 3" 'LoadXLSString(25)
    ListaMotori(MotoreNastroTrasportatoreRiciclato).Descrizione = LoadXLSString(26)
    ListaMotori(MotoreNastroCollettoreRiciclato).Descrizione = LoadXLSString(27)
    ListaMotori(MotoreArganoBenna).Descrizione = LoadXLSString(28)
    ListaMotori(MotoreVentolaViatop).Descrizione = LoadXLSString(99)
    ListaMotori(MotoreElevatoreRiciclato).Descrizione = LoadXLSString(1092)
    ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).Descrizione = LoadXLSString(1093)
    ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).Descrizione = LoadXLSString(1398)
    ListaMotori(MotoreVaglioInerti).Descrizione = LoadXLSString(100)
    ListaMotori(MotoreNastroLanciatore).Descrizione = LoadXLSString(101)

    ListaMotori(MotoreNastroAuxRiciclato).Descrizione = LoadXLSString(270)

    ListaMotori(MotoreCompressoreBruciatore).Descrizione = LoadXLSString(784)

    ListaMotori(MotorePompaAltaPressione).Descrizione = LoadXLSString(442)

    ListaMotori(MotorePompaEmulsione).Descrizione = LoadXLSString(443)
    ListaMotori(MotoreNastroCollettore3).Descrizione = LoadXLSString(444)

    ListaMotori(MotoreNastroRapJolly).Descrizione = LoadXLSString(378)

    ListaMotori(MotoreRotazioneEssiccatore2).Descrizione = LoadXLSString(497)
    ListaMotori(MotorePompaCombustibile2).Descrizione = LoadXLSString(498)
    ListaMotori(MotoreVentolaBruciatore2).Descrizione = LoadXLSString(502)
    ListaMotori(MotorePompaAltaPressione2).Descrizione = LoadXLSString(500)
    ListaMotori(MotoreCompressoreBruciatore2).Descrizione = LoadXLSString(499)

    '20170406
    'ListaMotori(MotoreNastroBypassEssicatore).Descrizione = LoadXLSString(1490)
    ListaMotori(MotoreNastroBypassEssicatore).Descrizione = LoadXLSString(889)
    '

    ListaMotori(MotoreTrasportoFillerizzazioneFiltro).Descrizione = LoadXLSString(1395)
    ListaMotori(MotoreFillerizzazioneFiltroRecupero).Descrizione = LoadXLSString(1396)
    ListaMotori(MotoreFillerizzazioneFiltroApporto).Descrizione = LoadXLSString(1397)

    ListaMotori(MotoreCoclea123_2).Descrizione = LoadXLSString(1494)
    ListaMotori(MotoreCoclea123_3).Descrizione = LoadXLSString(1495)
    ListaMotori(MotoreCoclea123_4).Descrizione = LoadXLSString(1496)
    ListaMotori(MotoreCoclea123_5).Descrizione = LoadXLSString(1497)
    
    ListaMotori(MotoreCocleaPreseparatrice_2).Descrizione = LoadXLSString(1498)
    ListaMotori(MotoreCocleaPreseparatrice_3).Descrizione = LoadXLSString(1499)
    ListaMotori(MotoreCocleaPreseparatrice_4).Descrizione = LoadXLSString(1500)
    ListaMotori(MotoreCocleaPreseparatrice_5).Descrizione = LoadXLSString(1501)
'20151221
    ListaMotori(MotoreCocleaEstrazioneFillerApporto2).Descrizione = LoadXLSString(1512)
'
    If (DEBUGGING) Then
        Dim motore As Integer
        
        For motore = 1 To MAXMOTORI
            Debug.Assert (ListaMotori(motore).Descrizione <> "")
        Next motore
    End If

End Sub

