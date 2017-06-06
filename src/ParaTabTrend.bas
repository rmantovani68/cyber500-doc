Attribute VB_Name = "ParaTabTrend"
'
'   Gestione dei parametri del trend
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE As String = "Trend"


'   Lettura del file
Public Function ParaTabTrend_ReadFile() As Boolean

    Dim ti As Integer   '   trendIndex


    ParaTabTrend_ReadFile = False

    'CYBERTRONIC_PLUS

    For ti = 0 To NumTrend - 1
        TrendLista(ti).abilitato = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Trend" + CStr(ti), "", "Presente"))
        TrendLista(ti).SampleTime = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Trend" + CStr(ti), "", "TrendSample"))
    Next ti

    '20161212
    'TrendLista(TrendAmperometroMixer).abilitato = TrendLista(TrendAmperometroMixer).abilitato And ListaAmperometri(MotoreMescolatore).Inclusione    '20150915
    'TrendLista(TrendAmperometroElevCaldo).abilitato = TrendLista(TrendAmperometroElevCaldo).abilitato And ListaAmperometri(MotoreElevatoreCaldo).Inclusione    '20150915
    'TrendLista(TrendAmperometroEssicatore).abilitato = TrendLista(TrendAmperometroEssicatore).abilitato And ListaAmperometri(MotoreRotazioneEssiccatore).Inclusione    '20150915
    'TrendLista(TrendAmperometroVentolaBruc).abilitato = TrendLista(TrendAmperometroVentolaBruc).abilitato And ListaAmperometri(MotoreVentolaBruciatore).Inclusione    '20150915
    'TrendLista(TrendAmperometroAspFiltro).abilitato = TrendLista(TrendAmperometroAspFiltro).abilitato And ListaAmperometri(MotoreAspiratoreFiltro).Inclusione    '20150915
    'TrendLista(TrendAmperometroArganoB).abilitato = TrendLista(TrendAmperometroArganoB).abilitato And ListaAmperometri(MotoreArganoBenna).Inclusione    '20150915
    TrendLista(TrendAmperometroMixer).abilitato = TrendLista(TrendAmperometroMixer).abilitato And ListaAmperometri(AmperometroMescolatore_1).Inclusione
    TrendLista(TrendAmperometroElevCaldo).abilitato = TrendLista(TrendAmperometroElevCaldo).abilitato And ListaAmperometri(AmperometroElevatoreCaldo).Inclusione
    TrendLista(TrendAmperometroEssicatore).abilitato = TrendLista(TrendAmperometroEssicatore).abilitato And ListaAmperometri(AmperometroEssicatore_1).Inclusione
    TrendLista(TrendAmperometroVentolaBruc).abilitato = TrendLista(TrendAmperometroVentolaBruc).abilitato And ListaAmperometri(AmperometroVentolaBruciatore).Inclusione
    TrendLista(TrendAmperometroAspFiltro).abilitato = TrendLista(TrendAmperometroAspFiltro).abilitato And ListaAmperometri(AmperometroAspiratoreFiltro).Inclusione
    TrendLista(TrendAmperometroArganoB).abilitato = TrendLista(TrendAmperometroArganoB).abilitato And ListaAmperometri(AmperometroArganoBenna).Inclusione
    '

    ParaTabTrend_ReadFile = True

End Function

'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabTrend_Apply()

    Dim trendCount As Integer
    Dim ti As Integer   '   trendIndex

    '   Inizializzazione trend
    TrendInizializza

    For ti = 0 To NumTrend - 1

        If (TrendLista(ti).abilitato) Then
            '   Aggiunge dati da visualizzare
            TrendProfiloInserisci ti

            trendCount = trendCount + 1
        End If

    Next ti

    CP240.imgPulsanteForm(TBB_TREND).Visible = (trendCount > 0)

End Sub

