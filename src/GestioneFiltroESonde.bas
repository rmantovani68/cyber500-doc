Attribute VB_Name = "GestioneFiltro"
Option Explicit

Public FondoscalaDeltaDepressione As Integer
Public TemperaturaFiltroFreddo As Integer
'20160226
Public AttesaFiltrofreddoFlipFlop As Boolean
'
Public CamereFiltroInPulizia(0 To 31) As Boolean
Public SicurezzaTemperaturaFiltro As Boolean 'era AltaTemperaturaFiltro
Public AltaTemperaturaFiltro As Boolean
Public ValoreLettoModulatoreAspFiltroNN As Integer 'NN = Non Normalizzato
Public DepressioneFiltro As Integer
Public AllarmeDepressioneFiltro As Integer
Public ModoFunzFiltro As Integer
Public TempoPausaFiltro As Integer
Public TempoLavoro1Filtro As Integer
Public TempoLavoro2Filtro As Integer
Public NumeroCamereFiltro As Integer
Public MinDepressFiltro As Integer
Public FiltroInPulizia As Boolean
Public AbilitaPuliziaFiltro As Boolean
Public EsclusioneMessaggioAllarmeTemperaturaBassaFiltro As Boolean
Public ValoreTempLavoroFiltro As Integer
Public ValoreTempMaxFiltro As Long
Public NumeroLettureDepressione As Long

Public ArrayLettureDepressioneBruciatore(0 To 1, 1 To 30) As Long 'uno per tamburo x 30 letture

Public DeltaAriaFredda As Integer
Public TempoCampAriaFredda As Integer
Public TempoCorrAriaFredda As Integer
Public AbilitaControlloAriaFredda As Boolean
Public PosizioneModulatoreAriaFreddaDigitale As Boolean
Public ValoreMinAriaFredda As Long
Public ValoreMaxAriaFredda As Long
Public PosizioneModulatoreAriaFredda As Long
Public ManualeModulFiltro As Boolean
Public ManualeModulAriaFredda As Boolean
Public TempoAttesaFiltro As Boolean

Public ValoreTempoOnRegolazioneAspirazioneFiltro As Integer
Public ValoreTempoOffRegolazioneAspirazioneFiltro As Integer
Public RegolazioneAriaAspiratore_cntr As Integer 'Contatore per attivazione funzione RegolazioneAriaAspiratore

Public NumeroLetturaDepressioneFiltroIN As Integer
Public ArrayLettureDepressioneFiltroIN(1 To 30) As Integer
Public DepressioneFiltroIN As Integer
Public Type RegolazioneMinMax
    min As Integer
    max As Integer
End Type
Public DepressioneFiltroRegolazione As RegolazioneMinMax

'Soglia percentuale
Public SogliaPartenzaFillerizzazione As Integer
Public SogliaDepMinFillerizzazione As Integer
Public IsteresiDepMinFillerizzazione As Integer

Public RitardoSpegnimentoCompressoreF1F2 As Integer

Public contatoreFillerizzazione As Integer

Public PressioneCompressoreFillerizOK As Boolean    'True se la pressione del compressore della fillerizzazione è OK

Public SelezioneFillerizzazioneF1F2 As Integer
Public ManualeFillerizzazione As Boolean
Public VelocitaFillerizzazione As Integer       'Velocità dell'estrazione sia automatico sia manuale
Public SpeedManualeFillerizzazione As Integer
Public StartManualeFillerizzazione As Boolean

Public PredosaggioArrestoLivelliTSF As Boolean
Public GestioneArrestoLivelliTSF As Integer
Public TimeoutArrestoLivelliTSF As Long
Public TmrArrestoLivelliAltiTSF As Long
'
Public Inclusione3LivDMR As Boolean '20151228
Public PersistAllMaxFiltroLivContinui(1 To 3) As TipoTemporizzatoreStandard '20151228

Public StepRegolazioneAspDuranteAccFiltro As Integer '20160128
Public TempoRegolazioneAspDuranteAccFiltro As Long '20160128


'LETTURA DI UN VALORE DI TEMPERATURA DA 0-20 mA oppure 4-20mA.
Public Function Sonda_mA(valore As Long, max As Long, min As Long, mA_4_20 As Boolean) As Long
Dim ValRisoluzione As Double
Dim OffSetTemp As Double
Dim ValoreMax As Double

    If mA_4_20 Then
        OffSetTemp = 4 / (20 / 27648)
    Else
        OffSetTemp = 0
    End If
    ValoreMax = 27648 - OffSetTemp
    ValRisoluzione = (max - min) / ValoreMax

    Sonda_mA = ((valore - OffSetTemp) * ValRisoluzione) + min
    
End Function


'LETTURA DI UN VALORE DI TEMPERATURA DA 0-20 mA oppure 4-20mA.
Public Function Sonda_mA_Dbl(valore As Long, max As Long, min As Long, mA_4_20 As Boolean) As Double
Dim ValRisoluzione As Double
Dim OffSetTemp As Double
Dim ValoreMax As Double

    If mA_4_20 Then
        OffSetTemp = 4 / (20 / 27648)
    Else
        OffSetTemp = 0
    End If
    ValoreMax = 27648 - OffSetTemp
    ValRisoluzione = (max - min) / ValoreMax

    Sonda_mA_Dbl = ((valore - OffSetTemp) * ValRisoluzione) + min
    
End Function

'20151103
'LETTURA DI UN VALORE DI TEMPERATURA DA 0-20 mA oppure 4-20mA.
Public Function SondaDbl_mA(valore As Double, max As Double, min As Double, mA_4_20 As Boolean) As Double
Dim ValRisoluzione As Double
Dim OffSetTemp As Double
Dim ValoreMax As Double

    If mA_4_20 Then
        OffSetTemp = 4 / (20 / 27648)
    Else
        OffSetTemp = 0
    End If
    ValoreMax = 27648 - OffSetTemp
    ValRisoluzione = (max - min) / ValoreMax

    SondaDbl_mA = ((valore - OffSetTemp) * ValRisoluzione) + min
    
End Function
'

'"Anti-sbuffo": in accensione e spegnimento viene incrementato il range di lavoro del modulatore;
' si aumenta la depressione di 'AumentoAspirazioneFiltro' mm per 'PermanenzaAggiuntivaAumentoAspirazione' secondi
' Praticamente si aspira maggiormente dal filtro per evitare i problemi di "sbuffo" del bruciatore
Private Sub AumentoAspirazFiltro()
    
    If PermanenzaAggiuntivaAumentoAspirazione <= 0 Or AumentoAspirazioneFiltro <= 0 Then
        Exit Sub
    End If
    
    On Error GoTo Errore

    If ( _
        ListaTamburi(0).BruciatoreInAccensione Or _
        (ListaTamburi(0).FiammaBruciatorePresente And (ConvertiTimer() < ListaTamburi(0).OraStartBruciatore + PermanenzaAggiuntivaAumentoAspirazione)) Or _
        FaseSpegnimentoBruciatore Or _
        ((OraStopBruciatore > 0) And (ConvertiTimer() < OraStopBruciatore + PermanenzaAggiuntivaAumentoAspirazione)) _
    ) Then
        ListaTamburi(0).ModulatoreFumiTamburo.min = ListaTamburi(0).MinDepressioneBruciatore + AumentoAspirazioneFiltro
        ListaTamburi(0).ModulatoreFumiTamburo.max = ListaTamburi(0).MaxDepressioneBruciatore + AumentoAspirazioneFiltro
    Else
        ListaTamburi(0).ModulatoreFumiTamburo.min = ListaTamburi(0).MinDepressioneBruciatore
        ListaTamburi(0).ModulatoreFumiTamburo.max = ListaTamburi(0).MaxDepressioneBruciatore
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "FIL-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'Gestione filtro; richiamata da VideataPrincipale
Public Function GestioneAspirazioneFiltro()
    Call DepressioneFiltroAllarme
    Call AumentoAspirazFiltro
    
    ' Se aspiratore spento chiudo il modulatore e buonanotte
    If Not ListaMotori(MotoreAspiratoreFiltro).ritorno Then
        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
        Exit Function
    End If
    
    
    ' Gestione automatica aspirazione
    ' Introdotta gestione ad intervalli di regolazione/attesa perché i tempi di reazione sono molto veloci; si utilizza il tempo di attesa
    ' per permettere la stabilizzazione del sistema
    If (Not ModulatoreAspirazioneFiltro.manuale) Then   'Automatico
    
    'In teoria questa sub dovrebbe essere percorsa ogni 250msec (valore del timer tmrRicTrasNET(1) che la richiama), quindi ogni 4 passaggi dovrebbe essere trascorso 1 secondo.
    'Per qualche misteriosa ragione cosi' non e', e per ottenere un secondo servono circa 7 passaggi (valore trovato in via sperimentale), quindi devo moltiplicare il set del tempo di
    'pausa e lavoro della regolazione del modulatore del filtro (che e' espresso in numero di secondi) per questo coefficente.
        
        'If RegolazioneAriaAspiratore_cntr < ValoreTempoOnRegolazioneAspirazioneFiltro * 3 Then ' Sono all'interno dell'intervallo di regolazione
         If RegolazioneAriaAspiratore_cntr < ValoreTempoOnRegolazioneAspirazioneFiltro * 7 Then
            Call RegolazioneAriaAspiratore
        Else 'Intervallo di attesa: non si effettuano regolazioni
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone ' Resetto le i comandi di apertura e chiusura modulatore
            
            If RegolazioneAriaAspiratore_cntr >= ValoreTempoOnRegolazioneAspirazioneFiltro * 7 + ValoreTempoOffRegolazioneAspirazioneFiltro * 7 Then 'il *7 converte il numero di passaggi in secondi
                RegolazioneAriaAspiratore_cntr = 0 ' Raggiunto il termine del periodo di attesa
            End If
        End If
        
        RegolazioneAriaAspiratore_cntr = RegolazioneAriaAspiratore_cntr + 1 'Incremento il contatore di invocazioni
    Else
        RegolazioneAriaAspiratore_cntr = 0   'Manuale: resetto il contatore
    End If
    
    ' Aria fredda
    If Not ManualeAriaFredda Then
        Call RegolazioneAriaFredda
    End If

End Function

' 20160128 invocata durante l'accensione del bruciatotre
Public Sub GestioneAspirazioneFiltroInPreventilazione()
    Dim MinDepressioneMag As Double
    Dim MaxDepressioneMag As Double
    Dim StepRegolazioneAspDuranteAccFiltroFUT As Integer
    Dim Up As Boolean
    Dim Down As Boolean
    MinDepressioneMag = ListaTamburi(0).ModulatoreFumiTamburo.min + AumentoAspirazioneFiltro
    MaxDepressioneMag = ListaTamburi(0).ModulatoreFumiTamburo.max + AumentoAspirazioneFiltro
    StepRegolazioneAspDuranteAccFiltroFUT = -1
    
    ' col filtro spento o il bruciatore non in accensione la routine rimase in step 0 e non agisce
'20161011
'    If ((Not ListaMotori(MotoreAspiratoreFiltro).ritorno) Or (Not ListaTamburi(0).BruciatoreInAccensione)) Or (ValoreTempoOnRegolazioneAspirazioneFiltro = 0) Or (ValoreTempoOffRegolazioneAspirazioneFiltro = 0) Then
    If ((Not ListaMotori(MotoreAspiratoreFiltro).ritorno) Or (Not ListaTamburi(0).BruciatoreInAccensione)) Or (ValoreTempoOnRegolazioneAspirazioneFiltro = 0) Or (ValoreTempoOffRegolazioneAspirazioneFiltro = 0) Or ModulatoreAspirazioneFiltro.manuale Then
'
        StepRegolazioneAspDuranteAccFiltroFUT = 0
    End If
    
    Up = False
    Down = False
   ' Regolazione
    If (StepRegolazioneAspDuranteAccFiltro >= 100) Then
        If (ListaTamburi(0).depressioneBruciatore < MinDepressioneMag) Then
            Up = True
        ElseIf (ListaTamburi(0).depressioneBruciatore > MaxDepressioneMag) Then
            Down = True
        End If
    End If
    '
    'Debug.Print ModulatoreAspirazioneFiltro.stato
    '
    Select Case StepRegolazioneAspDuranteAccFiltro
        Case 0
            ' STEP= non deve agire
'20161011
'            If (ListaMotori(MotoreAspiratoreFiltro).ritorno) And ListaTamburi(0).BruciatoreInAccensione Then
            If (ListaMotori(MotoreAspiratoreFiltro).ritorno) And ListaTamburi(0).BruciatoreInAccensione And Not ModulatoreAspirazioneFiltro.manuale Then
'
                ' durante l' accensione del tamburo col filtro acceso la routine deve regolare
                StepRegolazioneAspDuranteAccFiltroFUT = 500
            End If
            TempoRegolazioneAspDuranteAccFiltro = 0
        Case 100
            ' STEP= regolazione UP - Uscita ON
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
            If (ConvertiTimer() > TempoRegolazioneAspDuranteAccFiltro + ValoreTempoOnRegolazioneAspirazioneFiltro) Then
                ' transizione a Uscita OFF trascorso ValoreTempoOnRegolazioneAspirazioneFiltro
                StepRegolazioneAspDuranteAccFiltroFUT = 150
                TempoRegolazioneAspDuranteAccFiltro = ConvertiTimer()
            End If
            If (Not Up) Then
                ' transizione a REGOLAZIONE INATTIVO se Up diventa 0
                StepRegolazioneAspDuranteAccFiltroFUT = 500
                TempoRegolazioneAspDuranteAccFiltro = 0
            End If
         Case 150
            ' STEP=regolazione UP - Uscita OFF
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
            If (ConvertiTimer() > TempoRegolazioneAspDuranteAccFiltro + ValoreTempoOffRegolazioneAspirazioneFiltro) Then
                ' transizione a Uscita ON trascorso ValoreTempoOffRegolazioneAspirazioneFiltro
                StepRegolazioneAspDuranteAccFiltroFUT = 100
                TempoRegolazioneAspDuranteAccFiltro = ConvertiTimer()
            End If
            If (Not Up) Then
                ' transizione a REGOLAZIONE INATTIVO se Up diventa 0
                StepRegolazioneAspDuranteAccFiltroFUT = 500
                TempoRegolazioneAspDuranteAccFiltro = 0
            End If
        Case 200
            ' STEP= regolazione DOWN - Uscita ON
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
            If (ConvertiTimer() > TempoRegolazioneAspDuranteAccFiltro + ValoreTempoOnRegolazioneAspirazioneFiltro) Then
                ' transizione a Uscita OFF trascorso ValoreTempoOnRegolazioneAspirazioneFiltro
                StepRegolazioneAspDuranteAccFiltroFUT = 150
                TempoRegolazioneAspDuranteAccFiltro = ConvertiTimer()
            End If
            If (Not Down) Then
                ' transizione a REGOLAZIONE INATTIVO se Up diventa 0
                StepRegolazioneAspDuranteAccFiltroFUT = 500
                TempoRegolazioneAspDuranteAccFiltro = 0
            End If
         Case 250
            ' STEP=regolazione DOWN - Uscita OFF
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
            If (ConvertiTimer() > TempoRegolazioneAspDuranteAccFiltro + ValoreTempoOffRegolazioneAspirazioneFiltro) Then
                ' transizione a Uscita ON trascorso ValoreTempoOffRegolazioneAspirazioneFiltro
                StepRegolazioneAspDuranteAccFiltroFUT = 150
                TempoRegolazioneAspDuranteAccFiltro = ConvertiTimer()
            End If
            If (Not Down) Then
                ' transizione a REGOLAZIONE INATTIVO se Up diventa 0
                StepRegolazioneAspDuranteAccFiltroFUT = 500
                TempoRegolazioneAspDuranteAccFiltro = 0
            End If
        Case 500
            ' STEP=regolazione INATTIVO
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
            If Up Then
                ' Richiesta di UP
                StepRegolazioneAspDuranteAccFiltroFUT = 100
                TempoRegolazioneAspDuranteAccFiltro = ConvertiTimer()
            End If
            ' regolazione ATTIVO
            If Down Then
                ' Richiesta di DOWN
                StepRegolazioneAspDuranteAccFiltroFUT = 200
                TempoRegolazioneAspDuranteAccFiltro = ConvertiTimer()
            End If
    End Select
    If (StepRegolazioneAspDuranteAccFiltroFUT > -1) Then
        StepRegolazioneAspDuranteAccFiltro = StepRegolazioneAspDuranteAccFiltroFUT
    End If
    If (StepRegolazioneAspDuranteAccFiltro = 0) Then
        Exit Sub
    End If
End Sub
' 20160128
Public Function ConversioneTemperatura(ValorePLC As Long, ByVal Temp As TemperatureEnum, ByVal fatto As Boolean) As Boolean
	Dim nuovoValore As Long

    ConversioneTemperatura = False

    With ListaTemperature(Temp)

        'Se si tratta di valore misurato direttamente su scheda con ingresso termocoppia.
        '
        'Dove si legge il valore:
        '   valoreLong = CLng(.Items(PLCTAG_AI_...).value)
        '   If (Termocoppia...) Then
        '       valoreLong = valoreLong / 10
        '   End If
        '   If (ConversioneTemperatura(valoreLong, VariabileTemperatura..., PlcInAnalogici_Fatta)) Then
        '   ...
        '
        'Qui dentro:
        'If (Termocoppia... And Temp = Temp...) Then
        '    nuovoValore = ValorePLC * (.Correzione / 100)
        'Else
        '   ...
        '

        nuovoValore = Sonda_mA(ValorePLC, .FondoScalaMax, .FondoScalaMin, .MilliAmpere420) * (.Correzione / 100)
        If (.valore <> nuovoValore Or Not fatto) Then
            .valore = nuovoValore
            ConversioneTemperatura = True
        End If

    End With

End Function

Public Function NormalizzazioneA100(valoreLetto As Integer, MassimoScala As Integer, MinimoScala As Integer, MassimoPLC As Integer, MinimoPLC As Integer) As Integer

	'Funzionamento:
	'La variabile ValoreLetto e' il valore da normalizzare
	'Le variabili MassimoScala e MinimoScala rappresentano il massimo e minimo valore che si desidera venga visualizzato nella grafica.
	'La variabile MassimoPLC rappresenta il valore massimo letto dal PLC
	'La variabile MinimoPLC rappresenta il valore minimo letto dal PLC
    
    Dim parziale As Single

    If (MassimoPLC = 0) Then
        MassimoPLC = 100
    End If
    If (MassimoScala = 0) Then
        MassimoScala = 100
    End If
    
    If (MassimoPLC - MinimoPLC) = 0 Then
        'TODO ERRORE XX
        ShowMsgBox LoadXLSString(806), vbOKOnly, vbExclamation, -1, -1, True
        Exit Function
    End If

    parziale = (MassimoScala - MinimoScala) / (MassimoPLC - MinimoPLC)
    
    NormalizzazioneA100 = CInt(LimitaValore(Round((parziale * valoreLetto) - (parziale * MinimoPLC), 0), CLng(MinimoScala), CLng(MassimoScala)))

End Function
'20170323
Public Function NormalizzazioneA100Dbl(valoreLetto As Double, MassimoScala As Double, MinimoScala As Double, MassimoPLC As Double, MinimoPLC As Double) As Double

	'Funzionamento:
	'La variabile ValoreLetto e' il valore da normalizzare
	'Le variabili MassimoScala e MinimoScala rappresentano il massimo e minimo valore che si desidera venga visualizzato nella grafica.
	'La variabile MassimoPLC rappresenta il valore massimo letto dal PLC
	'La variabile MinimoPLC rappresenta il valore minimo letto dal PLC
    
    Dim parziale As Double

    If (MassimoPLC = 0) Then
        MassimoPLC = 100#
    End If
    If (MassimoScala = 0) Then
        MassimoScala = 100#
    End If
    
    If (MassimoPLC - MinimoPLC) = 0 Then
        'TODO ERRORE XX
        ShowMsgBox LoadXLSString(806), vbOKOnly, vbExclamation, -1, -1, True
        Exit Function
    End If

    parziale = (MassimoScala - MinimoScala) / (MassimoPLC - MinimoPLC)
    
    NormalizzazioneA100Dbl = LimitaValoreDbl((parziale * valoreLetto) - (parziale * MinimoPLC), MinimoScala, MassimoScala)

End Function
'

Public Sub ResettaTimerGestioneFiltro()
    FrmGestioneTimer.TimerGestioneFiltro.enabled = False
    FrmGestioneTimer.TimerGestioneFiltro.Interval = ListaMotori(MotoreAspiratoreFiltro).tempoStart * 1000
    FrmGestioneTimer.TimerGestioneFiltro.enabled = True
    TempoAttesaFiltro = False
End Sub

Public Sub ManualeFiltroManiche()

    ModulatoreAspirazioneFiltro.manuale = True
    CP240.AniPushButtonDeflettore(8).Value = 2

    ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone

    CP240.CmdUpDownAriaFiltro(0).enabled = True
    CP240.CmdUpDownAriaFiltro(1).enabled = True

    'con modulatore aspirazione filtro in manuale i due modulatori aspirazione fumi tamburo vanno forzati in manuale (la routine di controllo automatico non e' attiva)
    If ParallelDrum Then
        Call ManualeModulatoreFumiTamburo(0)
        Call ManualeModulatoreFumiTamburo(1)
    End If

End Sub

Public Sub AutomaticoFiltroManiche()

    ModulatoreAspirazioneFiltro.manuale = False
    CP240.AniPushButtonDeflettore(8).Value = 1

    CP240.CmdUpDownAriaFiltro(0).enabled = False
    CP240.CmdUpDownAriaFiltro(1).enabled = False

End Sub

Public Sub AutomaticoAriaFreddaFiltro()

    ManualeAriaFredda = False
    CP240.AniPushButtonDeflettore(9).Value = 1

    CP240.CmdUpDownAriaFiltro(2).enabled = False
    CP240.CmdUpDownAriaFiltro(3).enabled = False

    'con modulatore aspirazione filtro in automatico i due modulatori aspirazione fumi tamburo vanno forzati in auto
    If ParallelDrum Then
        Call AutomaticoModulatoreFumiTamburo(0)
        Call AutomaticoModulatoreFumiTamburo(1)
    End If

End Sub

Public Sub ManualeAriaFreddaFiltro()

    ManualeAriaFredda = True
    CP240.AniPushButtonDeflettore(9).Value = 2

    ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone

    CP240.CmdUpDownAriaFiltro(2).enabled = True
    CP240.CmdUpDownAriaFiltro(3).enabled = True

End Sub


Public Sub GestioneLivelliFiltroDMR()
	'E22.1   Livello min. SX TSF
	'E22.2   Livello med. SX TSF

	'E22.5   Livello min. DX TFF
	'E23.4   Livello med. DX TSF

	'E36.4   Livello max. SX TSF
	'E46.3   Livello max. DX TSF

    'Dim nuovoLivello As Long

    On Error GoTo Errore

    If (Not InclusioneDMR) Then
        Exit Sub
    End If

    With CP240
        If (Not LivelliContinuiCameraEspansioneFillerRecupero) Then '20151120
            '   Livello SX tramoggia sotto filtro
            If LivelloMaxCameraEspansioneFillerRecupero Then
                '   Alto
                .GaugeLivelloFiller(0).Value = 100
            ElseIf (CameraEspansioneFillerRecupero And LivelloMedCameraEspansioneFillerRecupero) Then   'il medio ce l'ho solo con l'espansione
                '   Medio
                .GaugeLivelloFiller(0).Value = 50
            ElseIf (LivelloMinCameraEspansioneFillerRecupero) Then
                '   Basso
                .GaugeLivelloFiller(0).Value = 25
            Else
             '   Nè alto nè basso (nè medio)
                .GaugeLivelloFiller(0).Value = 0
            End If
    
            '   Livello DX tramoggia sotto filtro
            If LivelloMax2CameraEspansioneFillerRecupero Then
                '   Alto
                .GaugeLivelloFiller(1).Value = 100
            ElseIf (CameraEspansioneFillerRecupero And LivelloMed2CameraEspansioneFillerRecupero) Then   'il medio ce l'ho solo con l'espansione
                '   Medio
                .GaugeLivelloFiller(1).Value = 50
            ElseIf (LivelloMin2CameraEspansioneFillerRecupero) Then
                '   Basso
                .GaugeLivelloFiller(1).Value = 25
            Else
             '   Nè alto nè basso (nè medio)
                .GaugeLivelloFiller(1).Value = 0
            End If
        Else
            '20151120
            CP240.GaugeLivelloFiller(0).Value = ValoreLivelloContCameraEspFilRec_SX
            CP240.GaugeLivelloFiller(1).Value = ValoreLivelloContCameraEspFilRec_DX
            '20151228
            CP240.GaugeLivelloFiller(2).Value = ValoreLivelloContCameraEspFilRec_CE
        End If
        Select Case GestioneArrestoLivelliTSF
            Case 1
                'OR --> almeno un livello
'20151228
'                PredosaggioArrestoLivelliTSF = (Not LivelliContinuiCameraEspansioneFillerRecupero And (.GaugeLivelloFiller(0).Value = 100 Or .GaugeLivelloFiller(1).Value = 100)) Or _
'                (LivelliContinuiCameraEspansioneFillerRecupero And ((.GaugeLivelloFiller(0).Value >= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme) Or (.GaugeLivelloFiller(1).Value >= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme))) '20151120
                PredosaggioArrestoLivelliTSF = (Not LivelliContinuiCameraEspansioneFillerRecupero And (.GaugeLivelloFiller(0).Value = 100 Or .GaugeLivelloFiller(1).Value = 100)) Or _
                (LivelliContinuiCameraEspansioneFillerRecupero And (LivelloMaxCameraEspansioneFillerRecupero Or LivelloMax2CameraEspansioneFillerRecupero Or LivelloMax3CameraEspansioneFillerRecupero))
'
            Case 2
                'AND --> tutti i livelli
'20151228
'                PredosaggioArrestoLivelliTSF = (Not LivelliContinuiCameraEspansioneFillerRecupero And (.GaugeLivelloFiller(0).Value = 100 And .GaugeLivelloFiller(1).Value = 100)) Or _
'                (LivelliContinuiCameraEspansioneFillerRecupero And ((.GaugeLivelloFiller(0).Value >= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme) And (.GaugeLivelloFiller(1).Value >= LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme))) '20151120
                PredosaggioArrestoLivelliTSF = (Not LivelliContinuiCameraEspansioneFillerRecupero And (.GaugeLivelloFiller(0).Value = 100 And .GaugeLivelloFiller(1).Value = 100)) Or _
                (LivelliContinuiCameraEspansioneFillerRecupero And (LivelloMaxCameraEspansioneFillerRecupero And LivelloMax2CameraEspansioneFillerRecupero And LivelloMax3CameraEspansioneFillerRecupero))
'
            Case Else
                PredosaggioArrestoLivelliTSF = False
        End Select
        If (Not PredosaggioArrestoLivelliTSF Or TimeoutArrestoLivelliTSF = 0) Then
            TmrArrestoLivelliAltiTSF = 0
        End If
'
        If (PredosaggioArrestoLivelliTSF) Then
            If (PredosatoriAccesi(False, -1)) Then
'20150831
'                If (TimeoutArrestoLivelliTSF = 0) Then
'
'                    Call ErroreLivelloAltoFiller
'                Else
'                    'Arresto dosaggio dopo un tot di secondi
'                    If Not FrmGestioneTimer.TimerArrestoPredLivelliAltiFiller.enabled And PredosatoriAccesi(False, -1) Then
                    If (TmrArrestoLivelliAltiTSF = 0) Then
                        TmrArrestoLivelliAltiTSF = ConvertiTimer()
'                        FrmGestioneTimer.TimerArrestoPredLivelliAltiFiller.Interval = TimeoutArrestoLivelliTSF * 1000
'                        FrmGestioneTimer.TimerArrestoPredLivelliAltiFiller.enabled = True
'
                    End If
'                End If
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "FIL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ErroreLivelloAltoFiller()

    If AbilitaTuboTroppoPienoF1 Then    'vuole dire che c'è il tubo del troppo pieno
        'nel caso ci sia la selezione F1/F2 controlla che il selettore sia nella posizione dove c'è il livello massimo per fermare tutto

        If ( _
            (Not AbilitaValvolaTroppoPienoF1 Or ScambioFillerRecuperoInApporto) And _
            (Not ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(2)) Or _
            ((ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(1)) And (GestioneScambioTuboTroppoPieno = ScambioF1F2)) Or _
            ((ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(3)) And (GestioneScambioTuboTroppoPieno = ScambioF2F3)) _
        ) Then
        '
            Call APBScambioFillerRecuperoInApporto_Change(False)
            
            CP240.OPCData.items(PLCTAG_DO_ApertTuboTroppoPienoF1).Value = False
            Call PulsanteStopPred
            Call AllarmeTemporaneo("VA003", True)
            If AbilitaValvolaTroppoPienoF1 Then     'cose da fare solo nel caso ci sia anche la valvola del troppo pieno
                ScambioFillerRecuperoInApporto = False
                ScambioFillerRecuperoInApporto_Change
            End If
        End If
    End If

    If InclusioneDMR And PredosaggioArrestoLivelliTSF Then
        Call PulsanteStopPred
        Call AllarmeTemporaneo("VA003", True)
    End If

End Sub
'

Public Sub AltaTemperaturaFiltro_change()

    On Error GoTo Errore

    'Allarme ITT
    If (SicurezzaTemperaturaFiltro) Then
        CP240.Image1(19).Visible = (Not CP240.Image1(19).Visible)

        If (ListaTamburi(0).BruciatoreAutomatico) Then
            Call BruciatoreInManuale(0)
        End If
        If (ListaTamburi(1).BruciatoreAutomatico) Then
            Call BruciatoreInManuale(1)
        End If

    Else
        CP240.Image1(19).Visible = AltaTemperaturaFiltro
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "FIL-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20150805
Public Sub ValvolaPreseparatoreAnelloRitorno_change()

    On Error GoTo Errore

    If (ValvolaPreseparatoreAnello.ritorno) Then
        CP240.Image1(86).Picture = LoadPicture(GraphicPath & "Valvola_verde.bmp")
    Else
        CP240.Image1(86).Picture = LoadPicture(GraphicPath & "Valvola_riposo.bmp")
    End If

    Exit Sub
Errore:
    LogInserisci True, "F370", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'

Public Sub ValvolaPreseparatoreRitorno_change()

    On Error GoTo Errore

    If ValvolaPreseparatore.ritorno Then
        CP240.Image1(56).Picture = LoadPicture(GraphicPath & "Valvola_verde.bmp")
    Else
        CP240.Image1(56).Picture = LoadPicture(GraphicPath & "Valvola_riposo.bmp")
    End If

    Exit Sub
Errore:
    LogInserisci True, "FIL-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub VisualizzaPuliziaFiltro()

    Dim indice As Integer
    Dim camera As String

    On Error GoTo Errore

    If (Not AbilitaPuliziaFiltro) Then
        Exit Sub
    End If

    'Previste 25 camere invece delle 32 di scambio
    For indice = 0 To 24
        If (CamereFiltroInPulizia(indice)) Then
            If (camera <> "") Then
                camera = camera + " "
            End If
            camera = camera + CStr(indice + 1)
        End If
    Next indice

    CP240.LblEtichetta(29).caption = camera

    Exit Sub
Errore:
    LogInserisci True, "FIL-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SiloFillerLivello(silo As Integer, Value As Long)
    
    'Riscalo il valore del livello continuo
    Value = NormalizzazioneA100(CInt(Value), 100, 0, LivelloRiscalaMaxFiller(silo), LivelloRiscalaMinFiller(silo))
    
    CP240.PrbSiloLivello(silo).Value = Value
    CP240.PrbSiloLivello(silo).caption = CP240.PrbSiloLivello(silo).Value

    LivelloSiloFillerContinuo(silo + 1) = Value
    LivelloMaxSiloFiller(silo + 1) = (Value >= LivelloMaxSiloFillerAn)
    LivelloMinSiloFiller(silo + 1) = (Value < LivelloMinSiloFillerAn)

    If LivelloMaxSiloFiller(silo + 1) Or LivelloMinSiloFiller(silo + 1) Then
        CP240.PrbSiloLivello(silo).FillColor = vbRed
    Else
        CP240.PrbSiloLivello(silo).FillColor = vbBlue
    End If

    If LivelloMaxSiloFiller(silo + 1) Then
        If PredosatoriAccesi(False, -1) Then
            If (TimeoutArrestoLivelliTSF = 0) Then
                    Call ErroreLivelloAltoFiller
'
                End If
        End If
    End If
    
End Sub

Public Sub SiloFillerEstrazione(silo As Integer, Value As Boolean)

    '20161013
    If (silo = 1) Then
        CP240.ImgSilo(silo).Picture = LoadResPicture(IIf(Value And Not SelezioneF3, "IDB_TRAMOGGIAON", "IDB_TRAMOGGIA"), vbResBitmap)
    Else
    '
        CP240.ImgSilo(silo).Picture = LoadResPicture(IIf(Value, "IDB_TRAMOGGIAON", "IDB_TRAMOGGIA"), vbResBitmap)
    End If

End Sub

Private Sub DepressioneFiltroAllarme()

    On Error GoTo Errore

    If (AllarmeDepressioneFiltro > 0 And DepressioneFiltro >= AllarmeDepressioneFiltro) Then
        If ConvertiTimer() > OraAllarmeDepressioneFiltro + 5 Then
            Call AllarmeTemporaneo("XX099", True)
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "FIL-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub DepressioneFiltro_change()

    On Error GoTo Errore

	'&HFF = rosso
	'&HE0E0E0 = grigio
	'&HFFFF00 = azzurro

    CP240.LblDepressioneBruc(1).caption = DepressioneFiltro

    If (AllarmeDepressioneFiltro > 0 And DepressioneFiltro >= AllarmeDepressioneFiltro) Then
        CP240.LblDepressioneBruc(1).BackColor = &HFF

        If OraAllarmeDepressioneFiltro = 0 Then
            OraAllarmeDepressioneFiltro = ConvertiTimer()
        End If

    Else
        CP240.LblDepressioneBruc(1).BackColor = &HFFFF00
        Call AllarmeTemporaneo("XX099", False)
        OraAllarmeDepressioneFiltro = 0
    End If

    ControlloPuliziaFiltro

    Exit Sub
Errore:
    LogInserisci True, "FIL-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub DepressioneFiltroIN_change()

    On Error GoTo Errore

    CP240.LblDepressioneBruc(2).caption = DepressioneFiltroIN

    Exit Sub
Errore:
    LogInserisci True, "FIL-008", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ManualeModulatoreFumiTamburo(tamburo As Integer)

    ListaTamburi(tamburo).ModulatoreFumiTamburo.manuale = True
    CP240.AniPushButtonDeflettore(26 + tamburo).Value = 2
    ListaTamburi(tamburo).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone

    CP240.CmdUpDownAriaFiltro(4 + tamburo * 2).enabled = True
    CP240.CmdUpDownAriaFiltro(5 + tamburo * 2).enabled = True

End Sub

Public Sub AutomaticoModulatoreFumiTamburo(tamburo As Integer)

    If ModulatoreAspirazioneFiltro.manuale Then
        Call ManualeModulatoreFumiTamburo(tamburo)
    Else

        ListaTamburi(tamburo).ModulatoreFumiTamburo.manuale = False
        CP240.AniPushButtonDeflettore(26 + tamburo).Value = 1
    
        CP240.CmdUpDownAriaFiltro(4 + tamburo * 2).enabled = False
        CP240.CmdUpDownAriaFiltro(5 + tamburo * 2).enabled = False
    End If

End Sub


Public Sub SetManualeFillerizzazione(manuale As Boolean)

    ManualeFillerizzazione = manuale

    With CP240

        .AniPushButtonDeflettore(36).Value = IIf(manuale, 2, 1)
        .CmdStartStopGenerale(2).enabled = ManualeFillerizzazione
        .CmdStartStopGenerale(3).enabled = ManualeFillerizzazione

        .TxtImpastoRidotto(5).Visible = ManualeFillerizzazione
        .LblEtichetta(104).Visible = ManualeFillerizzazione
        .AniPushButtonDeflettore(38).enabled = True
        StartManualeFillerizzazione = False

    End With

End Sub

Public Sub AbortFillerizzazione()
    Call StopFillerizzazione
    Call SetManualeFillerizzazione(True)
End Sub

'Spegnimento fillerizzazione (automatico o manuale)
Public Sub StopFillerizzazione()
    StartManualeFillerizzazione = False
    VelocitaFillerizzazione = 0

    If RitardoSpegnimentoCompressoreF1F2 > 0 Then
        FrmGestioneTimer.TimerCompresFilleriz.Interval = RitardoSpegnimentoCompressoreF1F2 * 1000
        FrmGestioneTimer.TimerCompresFilleriz.enabled = True
        CP240.FrameArrestoFilleriz.Visible = True
        FrmGestioneTimer.TimerArrestoFilleriz.enabled = True
        CP240.LblMessaggioFilleriz.caption = contatoreFillerizzazione
        CP240.CmdStartStopGenerale(2).enabled = False
        CP240.CmdStartStopGenerale(3).enabled = False
        CP240.AniPushButtonDeflettore(36).enabled = False
    Else
        'Call SetMotoreUscita(MotoreTrasportoFillerizzazioneFiltro, False)
    End If

    ListaMotori(MotoreFillerizzazioneFiltroRecupero).uscitaAnalogica = 0
    'Call SetMotoreUscita(MotoreFillerizzazioneFiltroRecupero, False)
    
    ListaMotori(MotoreFillerizzazioneFiltroApporto).uscitaAnalogica = 0
    'Call SetMotoreUscita(MotoreFillerizzazioneFiltroApporto, False)
End Sub

'Funzione chiamata a loop per verifica start/stop fillerizzazione
Public Sub GestioneFillerizzazione()

    Dim percento As Integer
    Dim rapInRicetta As Integer
    Dim predosatore As Integer

    On Error GoTo Errore


    If Not MotoriInAutomatico Or Not ParallelDrum Or Not ListaMotori(MotoreTrasportoFillerizzazioneFiltro).presente Then
        Exit Sub
    End If


    'Le soglie sono controllate sempre (automatico + manuale)
    '- la depressione del tamburo riciclato deve essere sopra la soglia minima se sto fillerizzando il filtro
    If ( _
        (ListaTamburi(1).depressioneBruciatore <= (SogliaDepMinFillerizzazione - IsteresiDepMinFillerizzazione) And ListaMotori(MotoreTrasportoFillerizzazioneFiltro).ritorno) Or _
        (ListaTamburi(1).depressioneBruciatore < (SogliaDepMinFillerizzazione + IsteresiDepMinFillerizzazione) And Not ListaMotori(MotoreTrasportoFillerizzazioneFiltro).ritorno) _
    ) Then
        Call StopFillerizzazione
        Call AllarmeTemporaneo("XX023", True)
        Exit Sub
    End If


    ' --> MANUALE

    If ManualeFillerizzazione Then

        'asservimenti fillerizzazione in manuale:

        '- nessuna condizione se sto trasferendo il filler 1 al silo del filler 2

        If StartManualeFillerizzazione Then
            VelocitaFillerizzazione = CInt(CP240.TxtImpastoRidotto(5).text)
            Call StartMotoreFillerizzazioneF1F2(VelocitaFillerizzazione)
        ElseIf ListaMotori(MotoreFillerizzazioneFiltroRecupero).ritorno Or ListaMotori(MotoreFillerizzazioneFiltroApporto).ritorno Then
            Call StopFillerizzazione
        End If
        
        Exit Sub
    End If

    ' --> AUTOMATICO

    'VERIFICA CONDIZIONI DI ACCENSIONE
    If (Not ListaTamburi(1).FiammaBruciatorePresente) Then          'FIAMMA ER ACCESA
        Call StopFillerizzazione
        Call SetManualeFillerizzazione(True)
        Call AllarmeTemporaneo("XX024", True)
        Exit Sub
    End If
    If (Not ListaMotori(MotoreAspiratoreFiltro).ritorno) Then        'FILTRO ACCESO
        Call StopFillerizzazione
        Call SetManualeFillerizzazione(True)
        Call AllarmeTemporaneo("XX025", True)
        Exit Sub
    End If
    If ListaTamburi(0).FiammaBruciatorePresente Then                'FIAMMA TAMBURO PRINCIPALE SPENTA
        Call StopFillerizzazione
        Call SetManualeFillerizzazione(True)
        Call AllarmeTemporaneo("XX026", True)
        Exit Sub
    End If

    If (Not ListaMotori(MotoreNastroBypassEssicatore).presente Or DeflettoreByPassTamburoParalleloFCNastro) Or ListaTamburi(0).FiammaBruciatorePresente Then
        If ListaMotori(MotoreFillerizzazioneFiltroRecupero).ritorno Or ListaMotori(MotoreFillerizzazioneFiltroApporto).ritorno Then
            'Non uso il tamburo riciclato o sto usando il tamburo standard per cui niente fillerizzazione
            Call StopFillerizzazione
            Call SetManualeFillerizzazione(True)
            Exit Sub
        End If
    End If

    'Altri requisiti: c'è il bypass ed il deflettore bypass è sul tamburo

'    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
    'scolpito nella pietra per Singapore perchè hanno il riciclato fino al predosatore 5 incluso
    For predosatore = PrimoPredosatoreDelNastro(RiciclatoFreddo) To 4
    '
        rapInRicetta = rapInRicetta + ListaPredosatoriRic(predosatore).setAttuale.set
    Next predosatore

    If (rapInRicetta > SogliaPartenzaFillerizzazione) Then
        'Percentuale di riciclato per fare partire la fillerizzazione

        percento = RoundNumber(PesoBilanciaRiciclatoParDrum * 100 / TonOrarieImpianto, 0)
        'Limito a min 10 e max 100
        percento = IIf(percento > 100, 100, IIf(percento < 10, 10, percento))

        VelocitaFillerizzazione = percento
        Call StartMotoreFillerizzazioneF1F2(VelocitaFillerizzazione)
    Else
        'Percentuale di riciclato sotto la soglia minima di attivazione automatica
        Call StopFillerizzazione
        SetManualeFillerizzazione (True)
        Call AllarmeTemporaneo("XX027", True)
    End If

    Exit Sub
Errore:
    LogInserisci True, "FIL-009", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'
Public Sub StartMotoreFillerizzazioneF1F2(VelocitaPercento As Integer)
    
    If Not PressioneCompressoreFillerizOK Then
        Call AllarmeTemporaneo("XX029", True)
        Exit Sub
    End If
    
    If (ListaMotori(MotoreTrasportoFillerizzazioneFiltro).ritorno) And PressioneCompressoreFillerizOK Then
        ListaMotori(MotoreFillerizzazioneFiltroRecupero + SelezioneFillerizzazioneF1F2).uscitaAnalogica = VelocitaPercento
        ' Call SetMotoreUscita(MotoreFillerizzazioneFiltroRecupero + SelezioneFillerizzazioneF1F2, True)

        If SelezioneFillerizzazioneF1F2 = 0 Then
            'Call SetMotoreUscita(MotoreFillerizzazioneFiltroApporto, False)
            ListaMotori(MotoreFillerizzazioneFiltroApporto).uscitaAnalogica = 0
        ElseIf SelezioneFillerizzazioneF1F2 = 1 Then
            'Call SetMotoreUscita(MotoreFillerizzazioneFiltroRecupero, False)
            ListaMotori(MotoreFillerizzazioneFiltroRecupero).uscitaAnalogica = 0
        End If
    Else
        'Call SetMotoreUscita(MotoreFillerizzazioneFiltroRecupero + SelezioneFillerizzazioneF1F2, False)
    End If

End Sub
