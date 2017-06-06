Attribute VB_Name = "GestioneTrend"
'
'   Gestione del trend
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


'   Enum dei tipi di trend
Public Enum TrendType

    TrendTempScivolo = 0
    TrendTempFiltroIN = 1
    TrendTempFiltroOUT = 2
    TrendTempBitume = 3
    TrendTempSabbia = 4
    TrendTempScaricoMixer = 5
    TrendTempCisterna1 = 6
    TrendTempCisterna2 = 7
    TrendTempCisterna3 = 8
    TrendTempCisterna4 = 9
    TrendTempCisterna5 = 10
    TrendTempCisterna6 = 11
    TrendPortataOrariaPred = 12
    TrendPortataOrariaPredRic = 13
    TrendPortataOrariaMixer = 14
    TrendAperturaModulatoreBruc = 15
    TrendAperturaAspiratoreBruc = 16
    TrendAperturaModulatoreAriaF = 17
    TrendTempTamburoIN = 18
    TrendAmperometroMixer = 19
    TrendAmperometroElevCaldo = 20
    TrendAmperometroEssicatore = 21
    TrendAmperometroVentolaBruc = 22
    TrendAmperometroAspFiltro = 23
    TrendAmperometroArganoB = 24
    TrendAmperometroMixer2 = 25
    TrendAmperometroEssicatore2 = 26
    TrendAmperometroEssicatore3 = 27
    TrendAmperometroEssicatore4 = 28
    TrendAmperometroVaglio = 29
    TrendAmperometroVaglio2 = 30

    'Numero di trend
    NumTrend = 31

End Enum


'   Struttura contente la descrizione del singolo trend
Public Type trend

    '   Nome del trend
    Nome As String

    '   Flag di abilitazione (da parametri)
    abilitato As Boolean

    '   Tempo di campionamento
    SampleTime As Long

    '   Contatore per il campionamento
    SampleCount As Long

    '20161125
    RunTime As Boolean
    '

End Type

Public TrendLista(0 To NumTrend - 1) As trend


'   Struttura contenente le informazioni relative ad un singolo trend (profilo)
'   visualizzato nel form dei trend
Public Type TrendProfilo

    '   Indice del trend
    m_Type As TrendType

    '   Flag di profilo selezionato nel form
    m_check As Integer

    '   Y associata
    m_y As Integer

    '   Numero di campionamenti
    m_dataCount As Long
    '   Storico dei tempi
    m_time() As Double
    '   Storico dei valori
    m_value() As Double
    '   Ultimo dato visualizzato nel run time
    m_lastTimeIndexRT As Long

End Type


'   Numero di profili (ovvero check box ovvero curve) da visualizzare nel form del trend
Public TrendNumeroProfiliDaParametri As Long
'   Lista di profili
Public TrendListaProfili(0 To NumTrend - 1) As TrendProfilo

'   Flag per non campionare nel caso di cambio data
Public TrendSaltaCampionamenti As Boolean


'   Momento in cui sono stati finiti i cicli per azzerare la portata oraria del mescolatore
Public TrendPortataOrariaMixerCicliEseguiti As Date

Private CsSampleCount As Long '20161125

'


'   Inizializzazione della visualizzazione
Public Sub TrendInizializza()

    TrendNumeroProfiliDaParametri = 0

End Sub

'   Inserimento di un nuovo dato da visualizzare
Public Function TrendProfiloInserisci(ByVal indice As TrendType) As Boolean
    
    '   Profilo in più
    TrendNumeroProfiliDaParametri = TrendNumeroProfiliDaParametri + 1

    With TrendListaProfili(TrendNumeroProfiliDaParametri - 1)

        .m_Type = indice
        .m_dataCount = 0
        .m_lastTimeIndexRT = 0

    End With

    TrendProfiloInserisci = True

End Function

'   Eliminazione dell'ultimo dato da visualizzare
Public Function TrendProfiloElimina() As Boolean

    If (TrendNumeroProfiliDaParametri <= 0) Then

        '   Non c'è più niente da togliere
        TrendProfiloElimina = False
        Exit Function

    End If

    '   La visualizzazione dovrà ripartire da 0
    TrendListaProfili(TrendNumeroProfiliDaParametri).m_lastTimeIndexRT = 0

    '   Un profilo in meno
    TrendNumeroProfiliDaParametri = TrendNumeroProfiliDaParametri - 1

    TrendProfiloElimina = True

End Function

'   Gestione del campionamento
Public Sub TrendCampionamento()

    Dim valore As Double
    Dim ti As Integer   '   trendIndex
    Dim salta As Boolean
    Dim trendEnabledCount As Integer
    Dim xCS As Boolean '20161125
    Dim xDB As Boolean '20161125


    If (TrendSaltaCampionamenti) Then
        If (TrendMaxDataCampionamento >= DateTime.Now) Then
            '   Non campiona finchè la data non risulta essere corretta
            Exit Sub
        End If

        '   Ok non devo più saltare i campionamenti
        TrendSaltaCampionamenti = False
    End If

    trendEnabledCount = 0
    For ti = 0 To NumTrend - 1

        If (TrendLista(ti).abilitato) Then
            '   Campionamento
            
            'Mezzanotte --> "Timer" si azzera
            If ConvertiTimer() <= 1 Then
                TrendLista(ti).SampleCount = ConvertiTimer()
            End If

            '20161125
            'If (ConvertiTimer() - TrendLista(ti).SampleCount >= TrendLista(ti).SampleTime) Then
            If (TrendLista(ti).RunTime And (ConvertiTimer() - CsSampleCount >= 1)) Then
                xCS = True
            End If
            If (ConvertiTimer() - TrendLista(ti).SampleCount >= TrendLista(ti).SampleTime) Then
                xDB = True
            End If
            If (xCS Or xDB) Then
            '
                '   Campionamento da fare
                '20161125
                If (xCS) Then
                    CsSampleCount = ConvertiTimer()
                End If
                If (xDB) Then
                '
                    TrendLista(ti).SampleCount = ConvertiTimer()
                End If

                salta = False

                Select Case ti

                    Case TrendTempScivolo
                        valore = CDbl(ListaTamburi(0).temperaturaScivolo)

                    Case TrendTempFiltroIN
                        valore = CDbl(ListaTemperature(TempEntrataFiltro).valore)

                    Case TrendTempFiltroOUT
                        valore = CDbl(ListaTemperature(TempUscitaFiltro).valore)

                    Case TrendTempBitume
                        valore = CDbl(ListaTemperature(TempLegante1Pompa).valore)

                    Case TrendTempSabbia
                        valore = CDbl(TemperaturaTorre)

                    Case TrendTempScaricoMixer
                    
'                        valore = CDbl(ListaTemperature(TempSottoMescolatore).valore)
                    
                        'Gestione ad eventi valore = CDbl(ListaTemperature(TempSottoMescolatore).valore)
                        valore = 0
                        salta = True

                    Case TrendTempCisterna1
                        valore = CDbl(CP240.LblCistTemp(0).caption)

                    Case TrendTempCisterna2
                        valore = CDbl(CP240.LblCistTemp(1).caption)

                    Case TrendTempCisterna3
                        valore = CDbl(CP240.LblCistTemp(2).caption)

                    Case TrendTempCisterna4
                        valore = CDbl(CP240.LblCistTemp(3).caption)

                    Case TrendTempCisterna5
                        valore = CDbl(CP240.LblCistTemp(4).caption)

                    Case TrendTempCisterna6
                        valore = CDbl(CP240.LblCistTemp(5).caption)

                    Case TrendPortataOrariaPred
                        If (StartPredosatori) Then
                            valore = RoundNumber(PesoBilanciaInerti, 0)
                        Else
                            valore = 0
                            salta = True
                        End If

                    Case TrendPortataOrariaPredRic
                        If (StartPredosatori) Then
                            valore = RoundNumber(PesoBilanciaRiciclato, 0)
                        Else
                            valore = 0
                            salta = True
                        End If

                    Case TrendPortataOrariaMixer
                        'Gestione ad eventi
                        If ( _
                            TrendPortataOrariaMixerCicliEseguiti > 0 And _
                            DateDiff("s", TrendPortataOrariaMixerCicliEseguiti, Now) > 0 _
                        ) Then
                            TrendPortataOrariaMixerCicliEseguiti = 0
                            valore = 0
                        Else
                            valore = 0
                            salta = True
                        End If

                    Case TrendAperturaModulatoreBruc
                        'Legge il valore del modulatore del filtro anziche' quello del bruciatore
                        valore = CDbl(ListaTamburi(0).posizioneModulatoreBruciatore)

                    Case TrendAperturaAspiratoreBruc
                        'Legge il valore del modulatore del bruciatore anziche' quello del filtro
                        valore = CDbl(ModulatoreAspirazioneFiltro.posizione)

                    Case TrendAperturaModulatoreAriaF
                        valore = CDbl(PosizioneModulatoreAriaFredda)

                    Case TrendTempTamburoIN
                        valore = CDbl(ListaTemperature(TempTamburoIngresso).valore)

                    Case TrendAmperometroMixer
                        'Lo memorizzo all'inizio del tempo di mescolazione
                        'valore = CDbl(listaAmperometri(AmperometroMescolatore).valore)
                        '
                    Case TrendAmperometroElevCaldo
                        valore = CDbl(ListaAmperometri(AmperometroElevatoreCaldo).valore)

                    Case TrendAmperometroEssicatore
                        valore = CDbl(ListaAmperometri(AmperometroEssicatore_1).valore)

                    Case TrendAmperometroVentolaBruc
                        valore = CDbl(ListaAmperometri(AmperometroVentolaBruciatore).valore)

                    Case TrendAmperometroAspFiltro
                        valore = CDbl(ListaAmperometri(AmperometroAspiratoreFiltro).valore)

                    Case TrendAmperometroArganoB
                        valore = CDbl(ListaAmperometri(AmperometroArganoBenna).valore)

                    Case TrendAmperometroMixer2
                        'Lo memorizzo all'inizio del tempo di mescolazione
                        'valore = CDbl(listaAmperometri(AmperometroMescolatore2).valore)
                        '
                    Case TrendAmperometroEssicatore2
                        valore = CDbl(ListaAmperometri(AmperometroEssicatore_2).valore)

                    Case TrendAmperometroEssicatore3
                        valore = CDbl(ListaAmperometri(AmperometroEssicatore_3).valore)

                    Case TrendAmperometroEssicatore4
                        valore = CDbl(ListaAmperometri(AmperometroEssicatore_4).valore)

                    Case TrendAmperometroVaglio
                        valore = CDbl(ListaAmperometri(AmperometroVaglio_1).valore)

                    Case TrendAmperometroVaglio2
                        valore = CDbl(ListaAmperometri(AmperometroVaglio_2).valore)

                    Case Else
                        valore = 0
                        salta = True

                End Select

                If (Not salta) Then
                    '20161125
                    If (xCS) Then
                        Call SendMessagetoPlus(TrendRunTimeValue, CStr(DateTime.Now) + "|" + CStr(ti) + "|" + CStr(valore))
                    End If
                    If (xDB) Then
                    '
                        TrendCampionamentoInserisci trendEnabledCount, DateTime.Now, valore
                    End If
                End If

            End If

            trendEnabledCount = trendEnabledCount + 1

        End If

    Next ti

End Sub

'   Inserisce un campionamento
'
'   pi = (profileIndex) indice del profilo (0...)
'   time = valore della data
'   value = valore associato alla data
Private Function TrendCampionamentoInserisci( _
    pi As Integer, _
    time As Date, _
    Value As Double _
    ) As Boolean

    On Error GoTo Errore

    TrendCampionamentoInserisci = False

    If (pi > TrendNumeroProfiliDaParametri) Then

        '   Profilo inesistente
        Exit Function

    End If

    With TrendListaProfili(pi)

        '   Un nuovo cammpionamento
        .m_dataCount = .m_dataCount + 1

        '   Ridimensiona gli array dei campionamenti
        ReDim Preserve .m_time(.m_dataCount)
        ReDim Preserve .m_value(.m_dataCount)

        '   Memorizza i nuovi dati
        .m_time(.m_dataCount) = CDbl(time)
        .m_value(.m_dataCount) = Value

    End With

    With Rs_Registrazioni_AddNew
        .AddNew
        !DataOra = time
        !valore = CInt(Value)
        !IdTrend = TrendListaProfili(pi).m_Type
        .Update
    End With

    TrendCampionamentoInserisci = True

    Exit Function

Errore:

'   Via di fuga inserita per fare in modo che non crei danni l'inserimento accidentale nel
'   DB di due campionamenti allo stesso secondo (non dovrebbe succedere ma a volte succede!)

End Function

'   Inserisce un campionamento ad evento
'
'   evento =
'   time = valore della data
'   value = valore associato alla data
Public Function TrendCampionamentoInserisciEvento( _
    evento As TrendType, _
    time As Date, _
    valore As Double _
    ) As Boolean
    
    Dim ti As Integer   '   trendIndex
    Dim trendEnabledCount As Integer


    If (TrendSaltaCampionamenti) Then
        If (TrendMaxDataCampionamento >= DateTime.Now) Then
            '   Non campiona finchè la data non risulta essere corretta
            Exit Function
        End If

        '   Ok non devo più saltare i campionamenti
        TrendSaltaCampionamenti = False
    End If

    trendEnabledCount = 0
    For ti = 0 To NumTrend - 1

        If (TrendLista(ti).abilitato) Then
            '   Campionamento

            If (ti = evento) Then

                TrendCampionamentoInserisci trendEnabledCount, time, valore

            End If

            trendEnabledCount = trendEnabledCount + 1

        End If

    Next ti

End Function

'   Ottiene l'ultima data campionata
Public Function TrendMaxDataCampionamento() As Date

    Dim rs As New adodb.Recordset


    TrendMaxDataCampionamento = 0

    If (DBcon.State = adStateClosed) Then
        Exit Function
    End If

    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT MAX(DataOra) AS MaxDataOra FROM Registrazioni;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon

        If (Not IsNull(!MaxDataOra)) Then
            TrendMaxDataCampionamento = !MaxDataOra
        End If

        .Close
    End With

End Function

'   Verifica se la data è stata modificata rispetto all'ultima memorizzazione
'   dello storico dei trend
Public Sub TrendVerificaData()

    Dim tastoPremuto As Integer


    'Viene segnalato che la modifica della data può destabilizzare la storicizzazione dei dati
    If (TrendMaxDataCampionamento >= DateTime.Now) Then
        tastoPremuto = ShowMsgBox( _
            LoadXLSString(845) + vbCrLf + LoadXLSString(846), _
            vbOKCancel, _
            vbExclamation, _
            -1, _
            -1, _
            True _
            )
        Select Case tastoPremuto

            Case vbOK
                '   Cancellazione dati che si sovrappongono
                Call SqlServerCancellaTrendData(DateTime.Now)

            Case vbCancel
                '   Non campiona finchè la data non raggiunge l'ultimo campionamento effettuato
                TrendSaltaCampionamenti = True

        End Select
    End If

End Sub


'20161125
Public Sub TrendSetRunTimeCs(pen As Integer, add As Boolean)

    Dim ti As Integer   '   trendIndex

    ti = pen
    'For ti = 0 To NumTrend - 1
    '    If (ti = pen) Then
            TrendLista(ti).RunTime = add
    '    End If
    'Next ti
    
End Sub
'

