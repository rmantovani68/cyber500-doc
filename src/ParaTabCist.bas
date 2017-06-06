Attribute VB_Name = "ParaTabCist"
'
'   Gestione dei parametri delle cisterne
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit



Private Const FileCisterne As String = "Cisterne.ini"
Private Const SEZIONE As String = "Cisterne"



'   Lettura del file
Public Function ParaTabCist_ReadFile() As Boolean

    ParaTabCist_ReadFile = False

    'CYBERTRONIC_PLUS

    With CistGestione

        .Gestione = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "Gestione"))
        .InclusioneTravaso = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneTravaso"))
        .InclusioneTemperatura = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneTemperatura"))
        .RegolazioneTemperatura = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RegolazioneTemperatura"))
        .InclusioneSetTemperatura = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneSetTemperatura"))
        .InclusioneLivello = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneLivello"))
        .InclusioneComandi = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneComandi"))
        .AbilitaVistaAlto = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaVistaAlto"))
        '.ListaOperazioniEmulsione(0) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso0"))
        '.ListaOperazioniEmulsione(1) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso1"))
        '.ListaOperazioniEmulsione(2) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso2"))
        '.ListaOperazioniEmulsione(3) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso3"))
        '.ListaOperazioniEmulsione(4) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso4"))
        '.ListaOperazioniEmulsione(5) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso5"))
        '.ListaOperazioniEmulsione(6) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso6"))
        '.ListaOperazioniEmulsione(7) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso7"))
        '.ListaOperazioniEmulsione(8) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso8"))
        '.ListaOperazioniEmulsione(9) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso9"))
        '.ListaOperazioniEmulsione(10) = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "ListaOperazioniEmulsione_Incluso10"))
        Caldaia(0).AbilitazioneCaldaia = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "Presente"))
        Caldaia(1).AbilitazioneCaldaia = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "AbilitazioneCaldaia2"))
        Caldaia(0).InclusioneValvole = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "InclusioneValvoleCaldaia1"))
        Caldaia(1).InclusioneValvole = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "InclusioneValvoleCaldaia2"))
        Caldaia(0).DeltaTemperatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "DeltaTemperaturaCaldaia1"))
        Caldaia(1).DeltaTemperatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "DeltaTemperaturaCaldaia2"))
        Caldaia(0).TimerSpegnimentoPompa = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "TimerSpegnimentoPompaCaldaia1"))
        Caldaia(1).TimerSpegnimentoPompa = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Caldaie", "", "TimerSpegnimentoPompaCaldaia2"))
'20150916
        .NumCisterneBitume = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumCistBitume"))
        .NumeroCistBitSuPCL1 = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumCistBitumePCL1"))
'
        .NumValvoleSopraConfig = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumValvSopraCist"))
        .NumValvoleSottoConfig = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumValvSottoCist"))
        .ValvSeparazioneSopraConfig = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneValvSeparazSopra"))
        .ValvSeparazioneSottoConfig = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneValvSeparazSotto"))
        .Valv3VieConfig = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneValv3Vie"))
        .TemperatureConfig = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneTemperatura"))
        .LivelliConfig = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneLivello"))
        .Termoregolazione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneTermoregolazione"))
        .ValvCaricoConfig = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneValvCarico"))
        .NumCisterneEmulsione = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumCistEmulsione"))
        .NumCisterneCombustibile = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumCistCombustibile"))

    End With

    ParaTabCist_ReadFile = True
    
End Function


Public Sub LeggiFileCisternaSingola(cisterna As Integer, Paragraph As String)
    
    Dim nomeFile As String

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)
    nomeFile = UserDataPath + FileCisterne

    With CisternaLegante(cisterna)

        .TipoLivello = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TipoLivello"))
        .LminUnitaAnTemperatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "UnitaMinTemp"))   '20151117 era Unit‡MinTemp
        .LMaxUnitaAnTemperatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "UnitaMaxTemp"))   '20151117 era Unit‡MaxTemp
        .LminUnitaAnLivello = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "UnitaMinLivello"))    '20151117 era Unit‡MinLivello
        .LMaxUnitaAnLivello = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "UnitaMaxLivello"))    '20151117 era Unit‡MaxLivello
        .DensitaLiquido = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "DensitaLiquido"))         '20151117 era Densit‡Liquido
        .LminGradiTemperatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempMin "))
        .LMaxGradiTemperatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempMax"))
        .LminTonLivello = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TonMin"))
        .LMaxTonLivello = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TonMax"))
        .SogliaAllarmeTempMin = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "AllarmeMinTemp"))
        .SogliaAllarmeTempMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "AllarmeMaxTemp"))
        .SogliaAllarmeLivMin = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "AllarmeMinLivello"))
        .SogliaAllarmeLivMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "AllarmeMaxLivello"))
        .ZonaMortaAllLiv = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "ZonaMortaAllarmeLivello"))
        .ZonaMortaAllTemp = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "ZonaMortaAllarmeTemp"))
        .TimeoutAperturaValvMandata = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxAperturaValvolaMandata"))
        .TimeoutChiusuraValvMandata = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxChiusuraValvolaMandata"))
        .TempoTriggFCMandata = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoStabilizzazioneFinecorsaMandata"))
        .TimeoutAperturaValvRitorno = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxAperturaValvolaRitorno"))
        .TimeoutChiusuraValvRitorno = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxChiusuraValvolaRitorno"))
        .TempoTriggFCRitorno = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoStabilizzazioneFinecorsaRitorno"))
        .TimeoutAperturaValvCarico = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxAperturaValvolaCarico"))
        .TimeoutChiusuraValvCarico = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxChiusuraValvolaCarico"))
        .TempoTriggFCCarico = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoStabilizzazioneFinecorsaCarico"))
        .TimeoutAperturaValvAux = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxAperturaValvolaAusiliaria"))
        .TimeoutChiusuraValvAux = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoMaxChiusuraValvolaAusiliaria"))
        .TempoTriggFCAux = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "TempoStabilizzazioneFinecorsaAusiliaria"))
        .InversioneComandoValvola1 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "InversioneComandoValvola1"))
        .InversioneComandoValvola2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "InversioneComandoValvola2"))
        .InversioneComandoValvola3 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "InversioneComandoValvola3"))
        .InversioneComandoValvola4 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "InversioneComandoValvola4"))
        .CisternaOrizzontale = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "CisternaOrizzontale"))
        .Diametro = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "Diametro"))
        .Lunghezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "Lunghezza"))
        .Agitatore = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, Paragraph, "", "InclusioneAgitatore"))

        CistGestione.materiale(cisterna - 1) = FileGetValue(nomeFile, Paragraph, "Materiale", "")

    End With

End Sub



Public Sub LeggiFileCisterne()

    Dim i As Integer
    Dim cisterna As Integer
    Dim ID_Parametro As Integer
    Dim cnn As New adodb.Connection
    Dim rs As New adodb.Recordset

    'CYBERTRONIC_PLUS

    For cisterna = 1 To 6
        Call LeggiFileCisternaSingola(0 * 10 + cisterna, "CisternaBitume" + CStr(cisterna))
    Next cisterna
    For cisterna = 1 To 2
        Call LeggiFileCisternaSingola(1 * 10 + cisterna, "CisternaEmulsione" + CStr(cisterna))
    Next cisterna
    For cisterna = 1 To 2
        Call LeggiFileCisternaSingola(2 * 10 + cisterna, "CisternaCombustibile" + CStr(cisterna))
    Next cisterna

    PompaAuxCisterne.ParametroTimeoutAvvio = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TimeoutAvvioPompaAux"))
    PompaAuxCisterne.ParametroTimeoutStop = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TimeoutArrestoPompaAux"))
    DBScambioDatiCisterneBitume.ParametroNrCisternaValvSeparaz = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumCistValvSeparazione"))
    'CistGestione.NumCisterneBitume
    DBScambioDatiCisterneEmulsione.NumeroCisternePresenti = CistGestione.NumCisterneEmulsione
    DBScambioDatiCisterneCombustibile.NumeroCisternePresenti = CistGestione.NumCisterneCombustibile
    'DBScambioDatiCisterneEmulsione.NrCisternaDefault = rs!valore

End Sub

'   Scrittura su file
Public Function ParaTabCist_WriteFile() As Boolean

    Dim cisterna As Integer
    Dim nomeFile As String

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)
    nomeFile = UserDataPath + FileCisterne

    With CistGestione

        For cisterna = 1 To 6
            Call FileSetValue(nomeFile, "CisternaBitume" + CStr(cisterna), "Materiale", .materiale(0 * 10 + cisterna - 1))
        Next cisterna
        For cisterna = 1 To 2
            Call FileSetValue(nomeFile, "CisternaEmulsione" + CStr(cisterna), "Materiale", .materiale(1 * 10 + cisterna - 1))
        Next cisterna
        For cisterna = 1 To 2
            Call FileSetValue(nomeFile, "CisternaCombustibile" + CStr(cisterna), "Materiale", .materiale(2 * 10 + cisterna - 1))
        Next cisterna

    End With

    ParaTabCist_WriteFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabCist_Apply()

    Dim indice As Integer
    Dim indiceCisterna As Integer
    Dim CisternaDaVisualizzare As Boolean

    Call CaricaParametriCisterne

    With CistGestione

            For indice = 0 To NumMaxCisterneImpianto - 1
                indiceCisterna = -1
                CisternaDaVisualizzare = False
                If indice <= 5 Then
                    indiceCisterna = indice
                    If indice <= .NumCisterneBitume - 1 Then
                        CisternaDaVisualizzare = True
                    End If
'20150513
                    CP240.adoDBMatCist(indiceCisterna).text = .materiale(indice)
'
                Else
                    If indice >= 10 And indice <= 15 Then
                        indiceCisterna = indice + 90
                        If indice <= .NumCisterneEmulsione + 9 Then
                            CisternaDaVisualizzare = True
                        End If
                    Else
                        If indice >= 20 And indice <= 25 Then
                            indiceCisterna = indice + 180
                            If indice <= .NumCisterneCombustibile + 19 Then
                                CisternaDaVisualizzare = True
                            End If
                        End If
                    End If
                End If
                If indiceCisterna >= 0 Then
                    CP240.FrameCist(indiceCisterna).Visible = (CisternaDaVisualizzare And .Gestione <> NessunaGestione)
                    CP240.LblCistTemp(indiceCisterna).Visible = .InclusioneTemperatura
                    CP240.LblCistTempSet(indiceCisterna).Visible = .InclusioneSetTemperatura
                    CP240.PrbCistLivello(indiceCisterna).Visible = .InclusioneLivello
                    CP240.ImgCistValvolaUscita2(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaRitorno
                    CP240.ImgCistValvolaEntrata1(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaCarico
                    CP240.ImgCistValvolaUscita1(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaMandata
                    CP240.ImgCistValvolaEntrata2(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaAux
                    CP240.ImgAgitatoreCist(indiceCisterna).Visible = CisternaLegante(indice + 1).Agitatore
                    
'                    If indiceCisterna < 6 Then
'                        FormVistaCisterne.FrameCistAlto(indiceCisterna).Visible = (CisternaDaVisualizzare And .Gestione <> NessunaGestione)
'                        FormVistaCisterne.ImgValvCistOut2(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaRitorno
'                        FormVistaCisterne.ImgTuboCistOut2(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaRitorno
'                        FormVistaCisterne.ImgArrowCistOut2(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaRitorno
'                        FormVistaCisterne.ImgValvCistOut(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaMandata
'                        FormVistaCisterne.ImgTuboCistOut(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaMandata
'                        FormVistaCisterne.ImgArrowCistOut(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaMandata
'                        FormVistaCisterne.ImgValvCistIn(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaCarico
'                        FormVistaCisterne.ImgTuboCistin(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaCarico
'                        FormVistaCisterne.ImgArrowCistIn(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaCarico
'                        If indiceCisterna > 2 Then
'                            FormVistaCisterne.ImgTuboCistOut(indiceCisterna + 3).Visible = CisternaLegante(indice + 1).InclusioneValvolaMandata
'                            FormVistaCisterne.ImgSnodo(indiceCisterna).Visible = CisternaLegante(indice + 1).InclusioneValvolaMandata
'                            FormVistaCisterne.ImgTuboCistin(indiceCisterna + 3).Visible = CisternaDaVisualizzare
'                            FormVistaCisterne.ImgSnodo(indiceCisterna - 3).Visible = CisternaDaVisualizzare
'                        End If
'                    End If
                    
'20150904
'                    CP240.LblCistMateriale(indiceCisterna).caption = .materiale(indice)
'
                End If
            Next indice
'            Select Case .NumCisterneBitume
'            Case 1
'                FormVistaCisterne.ImgSnodo(37).Left = 4200
'                FormVistaCisterne.ImgSnodo(36).Visible = False
'            Case 2
'                FormVistaCisterne.ImgSnodo(37).Left = 6840
'                FormVistaCisterne.ImgSnodo(36).Visible = False
'            Case 3
'                FormVistaCisterne.ImgSnodo(37).Left = 9600
'                FormVistaCisterne.ImgSnodo(36).Visible = False
'            Case 4
'                FormVistaCisterne.ImgSnodo(37).Left = 9600
'                FormVistaCisterne.ImgSnodo(36).Left = 4200
'                FormVistaCisterne.ImgSnodo(38).Visible = False
'            Case 5
'                FormVistaCisterne.ImgSnodo(37).Left = 9600
'                FormVistaCisterne.ImgSnodo(36).Left = 6840
'                FormVistaCisterne.ImgSnodo(38).Visible = False
'            Case 6
'                FormVistaCisterne.ImgSnodo(37).Left = 9600
'                FormVistaCisterne.ImgSnodo(36).Left = 9600
'            End Select
    End With
    
    CP240.FrameCisterne(0).caption = LoadXLSString(252)
    If CistGestione.NumCisterneBitume + CistGestione.NumCisterneCombustibile + CistGestione.NumCisterneEmulsione <= 6 Then
        CP240.FrameCisterne(0).Visible = (CistGestione.NumCisterneEmulsione > 0) And (CistGestione.Gestione <> NessunaGestione)
        CP240.FrameCisterne(0).left = CistGestione.NumCisterneBitume * 96 + 6
    Else
        CP240.FrameCisterne(0).left = 8
    End If
    CP240.FrameCisterne(0).width = CistGestione.NumCisterneEmulsione * 96 + 1
    CP240.FrameCisterne(1).caption = LoadXLSString(602)
    CP240.FrameCisterne(1).width = CistGestione.NumCisterneCombustibile * 96 + 1
    If CistGestione.NumCisterneBitume + CistGestione.NumCisterneCombustibile + CistGestione.NumCisterneEmulsione <= 6 Then
        CP240.FrameCisterne(1).Visible = (CistGestione.NumCisterneCombustibile > 0) And (CistGestione.Gestione <> NessunaGestione)
        CP240.FrameCisterne(1).left = CistGestione.NumCisterneBitume * 96 + CistGestione.NumCisterneEmulsione * 96 + 10
    Else
        If CistGestione.NumCisterneBitume + CistGestione.NumCisterneCombustibile <= 6 Then
            CP240.FrameCisterne(1).Visible = (CistGestione.NumCisterneCombustibile > 0) And (CistGestione.Gestione <> NessunaGestione)
        End If
        CP240.FrameCisterne(1).left = 96 * (6 - CistGestione.NumCisterneCombustibile) + 8
    End If
    CP240.FrameCisterne(2).width = CistGestione.NumCisterneBitume * 96 + 1
    CP240.FrameCisterne(2).Visible = (CistGestione.NumCisterneBitume > 0) And (CistGestione.Gestione <> NessunaGestione)

    'CP240.ImgCistValvolaSepara(1).Visible =


'20151027
'    CP240.imgPulsanteForm(TBB_GRUPPO_CISTERNE).Visible = (CistGestione.Gestione = GestionePLC) And Not ParallelDrum
    CP240.imgPulsanteForm(TBB_GRUPPO_CISTERNE).Visible = ((CistGestione.Gestione = GestioneSemplificata And CistGestione.InclusioneComandi) Or (CistGestione.Gestione = GestionePLC)) And Not ParallelDrum
'
    CP240.imgPulsanteForm(TBB_LEGANTE).Visible = (CistGestione.Gestione = GestionePLC) And Not ParallelDrum
    CP240.imgPulsanteForm(TBB_EMULSIONE).Visible = (CistGestione.Gestione = GestionePLC And (CistGestione.NumCisterneEmulsione > 0)) 'Emulsione
    CP240.imgPulsanteForm(TBB_COMBUSTIBILE).Visible = (CistGestione.Gestione = GestionePLC And (CistGestione.NumCisterneCombustibile > 0))
'
    
    CP240.ImgCistValvolaSepara(0).Visible = (CistGestione.Gestione = GestionePLC And CistGestione.InclusioneValvoleSeparazione12Bitume)
    CP240.ImgCistValvolaSepara(1).Visible = (CistGestione.Gestione = GestionePLC And CistGestione.InclusioneValvoleSeparazione12Bitume)
    CP240.ImgCistValvolaSepara(2).Visible = (CistGestione.Gestione = GestionePLC And CistGestione.InclusioneValvoleSeparazione23Bitume)
    CP240.ImgCistValvolaSepara(3).Visible = (CistGestione.Gestione = GestionePLC And CistGestione.InclusioneValvoleSeparazione23Bitume)

    CP240.FrameCaldaie.Visible = (CistGestione.Gestione <> NessunaGestione) And Caldaia(0).AbilitazioneCaldaia

    CP240.FrameCald(1).Visible = Caldaia(1).AbilitazioneCaldaia
    CP240.ImgCaldValvolaEntrata(0).Visible = Caldaia(0).InclusioneValvole
    CP240.ImgCaldValvolaUscita(0).Visible = Caldaia(0).InclusioneValvole
    CP240.ImgCaldValvolaEntrata(1).Visible = Caldaia(1).InclusioneValvole
    CP240.ImgCaldValvolaUscita(1).Visible = Caldaia(1).InclusioneValvole
    'CP240.FrameContalitri.Visible = (CistGestione.Gestione <> NessunaGestione) And Contalitri.inclusione    '20161128

    CP240.CmdVistaCistAlto.Visible = CistGestione.AbilitaVistaAlto
'20150513
    CP240.FrameCisterne(3).Visible = (CistGestione.Gestione = GestioneSemplificata)
    
'20151217
'    If (CistGestione.Gestione = GestionePLC) Or (CistGestione.Gestione = GestioneSemplificata) Then
    '20161230
    'If (CistGestione.Gestione = GestionePLC) Or (CistGestione.Gestione = GestioneSemplificata) And (CistGestione.NumCisterneBitume > 0) Then
    If ((CistGestione.Gestione = GestionePLC Or CistGestione.Gestione = GestioneSemplificata) And CistGestione.NumCisterneBitume > 0) Then
    '
        CP240.FrameCisterne(3).left = (CP240.FrameCist(CistGestione.NumCisterneBitume - 1).left / 15) + (CP240.FrameCist(CistGestione.NumCisterneBitume - 1).width / 15) + 20
    End If
    
    CP240.LblCistMateriale(8).Visible = ListaMotori(MotorePCL2).presente
    CP240.LblEtichetta(130).Visible = ListaMotori(MotorePCL2).presente
'20161212
'    CP240.LblCistMateriale(11).Visible = ListaMotori(MotorePCL2).presente
    CP240.LblCistMateriale(10).Visible = (CistGestione.Gestione <> NessunaGestione)
    CP240.LblCistMateriale(11).Visible = ListaMotori(MotorePCL2).presente And (CistGestione.Gestione <> NessunaGestione)
'

    CP240.FrameCisterne(3).top = 770
    CP240.FrameCisterne(3).caption = LoadXLSString(1511)
'

End Sub

