Attribute VB_Name = "GestionePredosatori"
'
'   Gestione dei predosatori
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


'   Numero di secondi entro cui il cambio al volo è concesso
Private Const SECONDIXCAMBIO As Integer = 3
Public NumeroPredosatoriInseriti As Integer
Public NumeroPredosatoriRicInseriti As Integer
Public AllarmiPredosatori As Boolean

Private LampeggioLampada As Boolean
Private LampeggioLampadaTm As Long

'   Predosatori in avvio/arresto senza tempi
Public PredosatoriImmediati As Boolean

Public StartPredosatori As Boolean

'   Operazioni effettuabili al cambio di set di un predosatore
Public Enum CambioSetPredosatoreType

    tempoNessuno = 0
    tempoStart = 1
    tempoStop = 2

End Enum

'   Operazione da fare al cambio di set
Public PredosatoriCambioSet As CambioSetPredosatoreType

'   Stato di un predosatore
Public Enum StatoPredosatoreType

    predosatoreInStop = 0
    predosatoreStopping = 1
    predosatoreInStart = 2
    predosatoreStarting = 3

End Enum

'   Struttura contenente il set di un predosatore
Public Type SetPredosatoreType

    set As Integer

    '   Ora per verificare due set consecutivi
    setOra As Long

    tempoStart As Long
    tempoStop As Long

    cambioManuale As Boolean

End Type


'   Struttura contenente tutte le informazioni di un pid
Public Type PidType

    '   Regolazione P.I.D.
    primaVolta As Boolean
    integrale As Double
    derivata As Double
    proporzionale As Double
    errorePrecedente As Double
    valoreRealePrecedente As Double
    Campionamento As Double
    derivataPrecedente As Double
    integralePrecedente As Double
    
    '   Costanti per il P.I.D.
    KP As Double
    ti As Double
    td As Double
    TC As Double
    ritardoTC As Double
    '   Massima correzione (%)
    maxCorrezione As Integer
    '   Flag per correzione massima raggiunta (-1 corr. inferiore, 0 range ok, +1 corr. superiore)
    maxCorrezioneRaggiunta As Integer

End Type

Public Const MAXPUNTICURVAPREDOSATORE As Integer = 5
Public Const MAXCURVEPREDOSATORE As Integer = 3

Public Type CurvaPredosatoreType
    Nome As String

    'Dati taratura predosatore
    valori(0 To MAXPUNTICURVAPREDOSATORE - 1) As Integer

    'Valore introdotto del potenziometro individuale predosatore
    percento(0 To MAXPUNTICURVAPREDOSATORE - 1) As Integer

    IdMaterialeLog As Long

End Type

Public Type GraficoPredosatoreType

    'Inclusione serie di 5 dati da introdurre. (ex SerieDatiPred)
    curvaAttiva As Integer '0, 1 o 2 per primo, secondo o terzo grafico

    curva(0 To MAXCURVEPREDOSATORE - 1) As CurvaPredosatoreType

End Type


Public Type MotorePredosatoreType

    presente As Boolean

    Descrizione As String

    uscita As Boolean

    ritorno As Boolean

    termica As Boolean

    'BUS SYSTEM
    Sicurezza As Boolean
    'BUS SYSTEM

    '   Ora in cui è stato dato lo start al motore
    oraStart As Long
    '   Secondi di attesa del ritorno
    tempoAttesaRitorno As Long
    '   Secondi di start
    tempoStart As Long
    '   Secondi di stop
    tempoStop As Long

    '   Flag per non accendere il motore all'avvio automatico
    offStart As Boolean

    '   Flag per non spegnere il motore allo spegnimento automatico
    onStop As Boolean

    '   Motore asservito (0 = se stesso)
    asservimento As Integer

    '   In verità vi dico che contengono minuti, non ore
    MinutiLavoroParz As Long
    MinutiLavoroTot As Long
    MinutiLavoroUltimoControllo As Long

    SecondiLavoroAppoggio As Long 'Appoggio per il conteggio delle ore di lavoro dei motori con funzionamento temporizzato

    '   Ottimizzazione per salvataggio lento

'    pausaLavoro As MotorePausaLavoro

    uscitaAnalogica As Integer
    
'    '   Flag per inserire il motore in una lista di avviamento automatico ridotto
'    EsclusioneConAvviamentoRidotto As Boolean
'    '   Flag per dire se la lista dove il motore è stato inserito è anche selezionata da parte dell'utente
'    EsclusioneSelezionata As Boolean
'    '   Serve per discriminare l'esclusione del motore fra i vari gruppi di esclusione
'    GruppoEsclusione As Integer
'    '  Serve in fase di avviamento automatico dei motori -> se mi manca il ritorno questo boolean viene messo a true e si esce dall'avviamento automatico
    allarmePresente As Boolean

    InverterPresente As Boolean

    SoloVisualizzazione As Boolean

End Type



'   Struttura contenente tutte le informazioni di un predosatore
Public Type PredosatoreType

    '   Numero progressivo
    progressivo As Integer

    '   Flag di predosatore riciclato
    riciclato As Boolean

    '   Motore associato
    motore As MotorePredosatoreType

    oraStart As Long

    '   Gestione immediata (seppur presenti ritardi)
    immediato As Boolean

    '   Produzione teorica in Ton/h --> % riferita alle Ton/h dell'impianto (AUTO+MAN)
    portataTeorica As Double

    '   Percentuale ricalcolata --> percentuale ricalcolata per ottenere le Ton/h richieste - portataTeorica - (AUTO)
    setCalcolato As Integer

    '   Ingresso analogico cui fa capo la bialncia
    ingressoAnalogicoBilancia As Integer

    '   Portata reale della bilancia in Ton/h
    portataBilancia As Double

    '   Portata massima della bilancia in Ton/h
    portataMaxBilancia As Double

    '   Gestione ponderale
    ponderaleAttivo As Boolean

    '   Regolazione P.I.D.
    pid As PidType

    '   Valore analogico in uscita (calcolato teorico)
    uscitaAnalogicaTeorica As Double
    '   Valore analogico in uscita (corretto con il P.I.D.)
    uscitaAnalogica As Double

    '   Flag di start (abilitazione)
    start As Boolean

    '   Coda dei set assegnati
    codaSet(0 To 100) As SetPredosatoreType

    '   Set attuale
    setAttuale As SetPredosatoreType

    setPrecedente As Integer '20160802
    
    '   Numero di set in coda
    codaSetLivello As Integer

    '   Flag per evitare di inserire a loop un set
    bloccaCambioSet As Boolean

    '   Stato attuale
    stato As StatoPredosatoreType

    statoprecedente As StatoPredosatoreType '20160802
    
    '   Ora per start o stop
    setOra As Long

    '   Flag di bilancia presente
    bilanciaPresente As Boolean

    '   Tipo di bilancia
    bilanciaRamsey As Boolean
    bilanciaSiwarex As Boolean
    bilanciaSiwarexIndice As Integer

    '   Flag di gestione ponderale (se bilancia presente)
    ponderale As Boolean

    '   Flag di raggiunta correzione ponderale min o max gia' visualizzata
    raggiuntaMinCorrezioneVis As Boolean
    raggiuntaMaxCorrezioneVis As Boolean

    '   Flag di vibratore presente
    vibratorePresente As Boolean
    
    abilitazioneVibratore As Boolean        'flag che dice che si può abilitare il vibratore
    
    vibratoreAbilitato As Boolean           'flag che dice che il vibratore è stato abilitato a seguito delle verifiche delle condizioni(ES: vuoto)
    
    autoOnVibratore As Boolean
    
    abilitaSuVuotoVibratore As Boolean
    
    tempoVuotoOnVibratore As Long           'Tempo in cui il predosatore è diventato vuoto per vibratore
    
    tempoVuotoOffVibratore As Long
    
    soffioPresente As Boolean
    
    abilitazioneSoffio As Boolean           'flag che dice che si può abilitare il soffio
    
    soffioAbilitato As Boolean              'flag che dice che il soffio è stato abilitato a seguito delle verifiche delle condizioni(ES: vuoto)
    
    tempoVuotoOnSoffio As Boolean           'Tempo in cui il predosatore è diventato vuoto per soffiare
    
    tempoVuotoOffSoffio As Boolean

    '   Flag di livello basso presente
    livelloBassoPresente As Boolean

    PortataMax As Integer

    '   Livello minimo
    minimo As Boolean

    '   Predosatore vuoto
    vuoto As Boolean

    Umidita As Double

    SetTonH As Integer

    '   Uscita di accensione della lampada
    UscitaLampada As Boolean

    Grafico As GraficoPredosatoreType
    
    GrigliaVibrantePresente As Boolean

    'Si considera che i predosatori su jolly siano sempre gli ultimi e dichiarati sul freddo
    SuNastroJolly As Boolean

End Type

Public Const MAXPREDOSATORI = 16    '20151116 (espansione a 16 vergini)
Public Const MAXPREDOSATORIRICICLATO = 8
Public ListaPredosatori(0 To MAXPREDOSATORI - 1) As PredosatoreType
Public ListaPredosatoriRic(0 To MAXPREDOSATORIRICICLATO - 1) As PredosatoreType
Public NumeroPredSiwarex1 As Integer
Public NumeroPredSiwarex2 As Integer

Public Enum BilanciaNastro
    nessuna = 0
    teorica
    analogica
    schedaSiwarex
End Enum
Public ConfigPortataNastroInerti As BilanciaNastro
Public ConfigPortataNastroRiciclato As BilanciaNastro
Public ConfigPortataNastroRiciclatoParDrum As BilanciaNastro

Public AvvioPredosatoriSenzaBruciatore As Boolean

Public FrmStatoPredosatoriVisibile  As Boolean
'
Public AlmenoUnoAccesoPredVergini As Boolean
Public AlmenoUnoAccesoPredRiciclatoCaldo As Boolean
Public AlmenoUnoAccesoPredRiciclatoFreddo As Boolean

Public MemAlmenoUnoAccesoPredVergini As Boolean '20150619
Public MemAlmenoUnoAccesoPredRiciclatoCaldo As Boolean  '20150619
Public MemAlmenoUnoAccesoPredRiciclatoFreddo As Boolean '20150619

Public AlmenoUnoPredosatoreAcceso As Boolean

Public NumPredVergProssimoSet As Integer
Public NumPredRicFreddoProssimoSet As Integer
'
Public NumPredRicCaldoProssimoSet As Integer

' ST - Ciclo di lavoro vibratori predosatori
Public Type FeederVibratorWorkingCycle_TYPE
    On As Integer       ' Secondi di lavoro
    Idle As Integer     ' Secondi di arresto
End Type
Public ColdFeederVibratorWorkingCycle As FeederVibratorWorkingCycle_TYPE
Public RecyColdFeederVibratorWorkingCycle As FeederVibratorWorkingCycle_TYPE
Public RecyColdFeederBlowerWorkingCycle As FeederVibratorWorkingCycle_TYPE

'   Secondi di ritardo allo start/stop del vibratore se predosatore vuoto
Public RitardoStartVibratorePredVuoto As Integer
Public RitardoStopVibratorePredVuoto As Integer

Public RitardoStartGriglieVibranti As Integer
Public RitardoStopGriglieVibranti As Integer

Private StoricoPredosaggioTm As Long
Private StoricoPredosaggioGroupID As Long
Public VisualizzaSetCalcolatoPredosatori As Boolean

Public StartRicPred As Boolean
Public ArrestoImmPred As Boolean
Public attesastartplc As Boolean

Public Vpred As Long
Public VRic As Long

Public AttesaFineRicetta As Boolean '20160201

'20160512
Private feederRecipeListAlreadyDone As Boolean
'
Public abilitaRinfrescoDati_pred As Boolean  '20160930

Public Sub VisualizzaPredosatoriImpostati()
    Dim i As Integer

    With CP240

        For i = 0 To MAXPREDOSATORI - 1
            .FramePred(i).Visible = (i < NumeroPredosatoriInseriti)
            .LblPredBil(i).Visible = True '2140404 ListaPredosatori(i).bilanciaPresente
            '2140404
            .LblPredBil(i).BackColor = IIf(ListaPredosatori(i).bilanciaPresente, &H80FFFF, &H80C0FF)
            '
        Next i

        '20161214
        '.LblEtichetta(76).Visible = ListaMotori(MotoreNastroRapJolly).presente
                

        For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1
            Call DisposizionePredNC1(i)
        Next i

        If ListaMotori(MotoreNastroCollettore2).presente Then
'            For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1
'                Call DisposizionePredNC1(i)
'            Next i
            If NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) > 0 Then
                For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1
                    Call DisposizionePredNC2(i)
                Next i
            End If
        End If

        If ListaMotori(MotoreNastroCollettore3).presente Then
            If NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) > 0 Then
                For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) - 1
                    Call DisposizionePredNC3(i)
                Next i
            End If
        End If

        .Frame1(26).Visible = ListaMotori(MotoreNastroCollettore2).presente
        .LblEtichetta(191).Visible = (NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) > 0)

        Call VisualizzaPredosatoriRicImpostati

    End With

End Sub


Public Sub VisualizzaPredosatoriRicImpostati()
    Dim i As Integer
    Dim count As Integer '20161212
    With CP240
        count = 0 '20161212
        For i = 0 To MAXPREDOSATORIRICICLATO - 1
            .FramePredRic(i).Visible = (i < NumeroPredosatoriRicInseriti)
            .LblPredRicBil(i).Visible = True
            .LblPredRicBil(i).BackColor = IIf(ListaPredosatoriRic(i).bilanciaPresente, &H80FFFF, &H80C0FF)
            ListaPredosatoriRic(i).motore.presente = (i < NumeroPredosatoriRicInseriti)
            '20161212
            If (ListaPredosatoriRic(i).SuNastroJolly) Then
                Call DisposizionePredNRicJolly(i, count)
            End If
        Next i

        
        count = 0 '20161212
        For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
            '20161212
            If (Not ListaPredosatoriRic(i).SuNastroJolly) Then
                Call DisposizionePredNCRic1(count)
                'Call DisposizionePredNCRic1(i)'20161212
                count = count + 1
            End If
            '20161212
        Next i
        
        count = 0 '20161212
        For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1
            '20161212
            If (Not ListaPredosatoriRic(i + 1).SuNastroJolly) Then
                Call DisposizionePredNCRic2(count)
                'Call DisposizionePredNCRic1(i)'20161212
                count = count + 1
            End If
            '20161212
        Next i

        If NumeroPredosatoriRicInseriti = 1 Then
            .LblEtichetta(192).left = 264
        Else
            .LblEtichetta(192).left = 324
        End If
        .LblEtichetta(192).Visible = (NumeroPredosatoriRicInseriti > 0)

    End With

End Sub

'   Dispone i predosatori sul nastro 1
Private Sub DisposizionePredNC1(i As Integer)
Dim TopPredosatori As Integer
Dim TopNastro As Integer
Dim K As Integer

    If ListaMotori(MotoreNastroCollettore3).presente Then
        TopPredosatori = 690
        TopNastro = 800
    Else
        TopPredosatori = 523
        TopNastro = 637
    End If
        
    If NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) <= 8 Then                    '6->8 20151116
        If InvertiNumerazionePred(NastriPredosatori.Collettore1) Then
            K = NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1 - i
        Else
            K = i
        End If
        
        CP240.ImgMotor(21).left = 450 - ((NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1) * 64)    '328 20151116
        CP240.ImgMotor(121).left = 450 - ((NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1) * 64)
        CP240.ImgMotor(121).width = 64 * (NumeroPredosatoriNastroC(NastriPredosatori.Collettore1))
    Else
        If InvertiNumerazionePred(NastriPredosatori.Collettore1) Then
            K = NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - i - 1
        Else
            K = i
        End If
    
        CP240.ImgMotor(21).left = 450 - (7 * 64)        '328-450 20151116
        CP240.ImgMotor(121).left = 450 - (7 * 64)
        CP240.ImgMotor(121).width = 64 * 8             '20151116
    End If
    
    If i < 8 Then                                           '6->8 20151116
        CP240.FramePred(K).left = 450 - (i * 64)
        CP240.FramePred(K).top = TopPredosatori             '328 20151116
    Else
        CP240.FramePred(K).top = TopPredosatori - 136
        CP240.FramePred(K).left = 8 + ((i - 8) * 64)    ' 20151116
    End If
                           
End Sub


'   Dispone i predosatori sul nastro 2
Private Sub DisposizionePredNC2(i As Integer)
Dim TopPredosatori As Integer
Dim TopNastro As Integer
Dim K As Integer

    If ListaMotori(MotoreNastroCollettore3).presente Then
        TopPredosatori = 523
        TopNastro = 637
    Else
        TopPredosatori = 387
        TopNastro = 500
    End If

    K = i + NumeroPredosatoriNastroC(NastriPredosatori.Collettore1)

    If InvertiNumerazionePred(NastriPredosatori.Collettore2) Then
        K = NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1 - i
    Else
        K = i + NumeroPredosatoriNastroC(NastriPredosatori.Collettore1)
    End If
    
    CP240.FramePred(K).top = TopPredosatori
    If NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) < 6 Then
        CP240.FramePred(K).left = 450 - (i * 64)    '6->8 20151116
        CP240.ImgMotor(22).left = 450 - ((NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1) * 64)    '6->8 20151116
        CP240.ImgMotor(122).left = 450 - ((NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1) * 64)   '6->8 20151116
        CP240.ImgMotor(122).width = 64 * (NumeroPredosatoriNastroC(NastriPredosatori.Collettore2))
    Else
        CP240.FramePred(K).left = 450 - (i * 64)    '6->8 20151116
        CP240.ImgMotor(22).left = 450 - ((NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1) * 64)    '6->8 20151116
        CP240.ImgMotor(122).left = 450 - ((NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1) * 64)   '6->8 20151116
        CP240.ImgMotor(122).width = 64 * (NumeroPredosatoriNastroC(NastriPredosatori.Collettore2))
    End If
    CP240.ImgMotor(22).top = TopNastro + 4
    CP240.ImgMotor(122).top = TopNastro

End Sub

'   Sistema i predosatori nel nastro 3
Private Sub DisposizionePredNC3(i As Integer)
Dim TopPredosatori As Integer
Dim TopNastro As Integer
Dim K As Integer
    
    If ListaMotori(MotoreNastroCollettore3).presente Then
        TopPredosatori = 387
        TopNastro = 500
    Else
        Exit Sub
    End If

    K = i + NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2)

    CP240.FramePred(K).top = TopPredosatori
    CP240.FramePred(K).left = 328 - (i * 64)
    CP240.ImgMotor(37).top = TopNastro + 4
    CP240.ImgMotor(137).top = TopNastro
    CP240.ImgMotor(137).width = CP240.ImgMotor(121).width
    CP240.LblEtichetta(88).top = 830
    CP240.LblNomeRicPred.top = 830

End Sub
'20161212
'   Sistema i predosatori nel nastro riciclato Jolly
Private Sub DisposizionePredNRicJolly(i As Integer, position As Integer)

    CP240.FramePredRic(i).top = CP240.ImgMotor(MotoreNastroRapJolly).top - CP240.FramePredRic(i).Height - 5
    CP240.FramePredRic(i).left = 100 + (position * 64)

End Sub
'20161212

'   Sistema i predosatori nel nastro riciclato 1
Private Sub DisposizionePredNCRic1(i As Integer)

    CP240.FramePredRic(i).top = 249
    CP240.FramePredRic(i).left = 200 + (i * 64)

End Sub


'   Sistema i predosatori nel nastro riciclato 2
Private Sub DisposizionePredNCRic2(i As Integer)
    Dim K As Integer

    If InvertiNumerazionePred(NastriPredosatori.RiciclatoFreddo) Then
        K = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1 - i
    Else
        K = i + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo)
    End If

    If (ParallelDrum) Then
        CP240.FramePredRic(K).top = 420
        CP240.FramePredRic(K).left = 1920 + 350 - (i * 64) '+ ((ParallelDrum * -1) * 1920)
    Else
        CP240.FramePredRic(K).top = 249
        CP240.FramePredRic(K).left = 8 + (i * 64)
    End If

End Sub


'   Inizializzazione (da fare una sola volta)
Public Sub PredosatoreInizializza()

    Dim predosatore As Integer

    For predosatore = 0 To MAXPREDOSATORI - 1
        ListaPredosatori(predosatore).progressivo = predosatore
        ListaPredosatori(predosatore).riciclato = False
    Next predosatore
    For predosatore = 0 To MAXPREDOSATORIRICICLATO - 1
        ListaPredosatoriRic(predosatore).progressivo = predosatore
        ListaPredosatoriRic(predosatore).riciclato = True
    Next predosatore

    LeggeFileUmiditaPredosatore
    LeggeFileUmiditaPredosatoreRic

End Sub


'   Segnalazione video di un predosatore vuoto
Private Sub AvvisoPredosatoreVuoto(ByRef Pred As PredosatoreType)

    Dim Codice As String

    '"XX151" livello minimo predosatore riciclato 1
    '"XX054" livello minimo predosatore 1
    '"PR030" vuoto predosatore riciclato 1
    '"PR033" vuoto predosatore 1

    If (Pred.riciclato) Then
        Codice = "PR" & Format(Pred.progressivo + 130, "000")
    Else
        Codice = "PR" & Format(Pred.progressivo + 33, "000")
    End If

    Call IngressoAllarmePresente( _
        DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Codice, "IdDescrizione"), _
        (Pred.motore.uscita And Pred.vuoto) _
        )

End Sub


'   Accende (o spegne) un predosatore
Private Sub PredosatoreAcceso(ByVal predosatore As Integer, ByVal acceso As Boolean)

    If (predosatore < 0 Or predosatore >= NumeroPredosatoriInseriti) Then
        Exit Sub
    End If

    Call PredosatoreMinimoVuoto_change(predosatore)

    Call CP240.AbilitaCalibrazione

End Sub


'   Accende (o spegne) un predosatore riciclato
Private Sub PredosatoreRiciclatoAcceso(ByVal predosatore As Integer, ByVal acceso As Boolean)

    If (predosatore < 0 Or predosatore >= NumeroPredosatoriRicInseriti) Then
        Exit Sub
    End If

    '   Disegno fisso se non c'è l'uscita
    CP240.ImgPredRic(predosatore).Visible = True

    PredosatoreRiciclatoMinimoVuoto_change predosatore

    Call CP240.AbilitaCalibrazione

End Sub


'   E' cambiata l'uscita di un predosatore
Public Sub PredosatoreUscita_change(ByVal predosatore As Integer)

    With ListaPredosatori(predosatore)

        '   I 12 vergini sono i primi
        .motore.oraStart = ConvertiTimer()

        If (.motore.uscita) Then
            Dim Criterio As String
            Dim posizione As Integer

            Criterio = "PR0" + CStr(predosatore + 11)
            posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
            IngressoAllarmePresente posizione, False
        End If

        If (AutomaticoPredosatori And .bilanciaPresente) Then
            PredosatoreInVolumetrico .riciclato, .progressivo, True
        End If

        PredosatoreAcceso predosatore, .motore.uscita

        If (DEMO_VERSION) Then
            .motore.ritorno = .motore.uscita
            PredosatoreRitorno_change predosatore
        End If

        CP240.ImgPred(.progressivo).enabled = (.motore.uscita = .motore.ritorno)

    End With

End Sub


'   Cambio dell'uscita di un predosatore
Public Sub SetPredosatoreUscita(ByVal predosatore As Integer, valore As Boolean)

    If (ListaPredosatori(predosatore).motore.uscita <> valore) Then
        ListaPredosatori(predosatore).motore.uscita = valore
        PredosatoreUscita_change predosatore
        
        If (ListaPredosatori(predosatore).bilanciaSiwarex) Then
            If predosatore = NumeroPredSiwarex1 Then
                If valore Then
                    CodiceComandoSiwarex = 106
                    Call AttivaComandoSiwarex(SiwarexPredosatore1)
                Else
                    CodiceComandoSiwarex = 103  'Disattiva totalizzazione
                    Call AttivaComandoSiwarex(SiwarexPredosatore1)
                    CodiceComandoSiwarex = 101  'Belt stop
                    Call AttivaComandoSiwarex(SiwarexPredosatore1)
                End If
            Else
                If valore Then
                    CodiceComandoSiwarex = 106
                    Call AttivaComandoSiwarex(SiwarexPredosatore2)
                Else
                    CodiceComandoSiwarex = 103  'Disattiva totalizzazione
                    Call AttivaComandoSiwarex(SiwarexPredosatore2)
                    CodiceComandoSiwarex = 101  'Belt stop
                    Call AttivaComandoSiwarex(SiwarexPredosatore2)
                End If
            End If
        End If
        
    End If

End Sub

Public Sub CalcolaNumeroPredosatoreSiwarex()
Dim i As Integer
    
    NumeroPredSiwarex1 = -1
    For i = 0 To 11
        If ListaPredosatori(i).bilanciaSiwarex Then
            If NumeroPredSiwarex1 = -1 Then
                NumeroPredSiwarex1 = i
            Else
                NumeroPredSiwarex2 = i
                Exit For
            End If
        End If
    Next i
    
End Sub


'   E' cambiato il ritorno di un predosatore
Public Sub PredosatoreRitorno_change(ByVal predosatore As Integer)

    On Error GoTo Errore

    With ListaPredosatori(predosatore)

        CP240.ImgPred(.progressivo).enabled = (.motore.uscita = .motore.ritorno)

    End With

    Exit Sub
Errore:
    LogInserisci True, "F339", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'   E' cambiata l'uscita di un predosatore riciclato
Public Sub PredosatoreRicUscita_change(ByVal predosatore As Integer)

    On Error GoTo Errore

    With ListaPredosatoriRic(predosatore)

        .motore.oraStart = ConvertiTimer()

        If (.motore.uscita) Then
            Dim Criterio As String
            Dim posizione As Integer

            Criterio = "PR0" + CStr(predosatore + 25)
            posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
            IngressoAllarmePresente posizione, False
        End If

        If (AutomaticoPredosatori And .bilanciaPresente) Then
            PredosatoreInVolumetrico .riciclato, .progressivo, True
        End If
        
        If (ListaMotori(MotoreNastroAuxRiciclato).presente And predosatore = 2) Then
            If (AutomaticoPredosatori) Then
                FrmGestioneTimer.TimerSpegniNastroAuxRiciclato.enabled = False
                FrmGestioneTimer.TimerSpegniNastroAuxRiciclato.enabled = (Not ListaMotori(MotoreNastroAuxRiciclato).ComandoManuale)
            Else
                If (.motore.uscita And Not ListaMotori(MotoreNastroAuxRiciclato).ComandoManuale) Then
                    Call AllarmeTemporaneo("XX127", True)
                    Call PredosatoreManuale(.riciclato, .progressivo, False, True)
                    Exit Sub
                End If
            End If
        End If
        If (ListaMotori(MotoreNastroRapJolly).presente And ListaPredosatoriRic(predosatore).SuNastroJolly) Then
            If (AutomaticoPredosatori) Then
            Else
                'If (.motore.uscita And Not ListaMotori(MotoreNastroRapJolly).ComandoManuale) Then '20161213
                If (.motore.uscita And Not (ListaMotori(MotoreNastroRapJolly).ComandoManuale Or ListaMotori(MotoreNastroRapJolly).ComandoInversione)) Then    '20161213
                    Call AllarmeTemporaneo("XX127", True)
                    Call PredosatoreManuale(.riciclato, .progressivo, False, True)
                    Exit Sub
                End If
            End If
        End If

        PredosatoreRiciclatoAcceso predosatore, .motore.uscita

        If (DEMO_VERSION) Then
            .motore.ritorno = .motore.uscita
            PredosatoreRiciclatoRitorno_change predosatore
        End If

        CP240.ImgPredRic(.progressivo).enabled = (.motore.uscita = .motore.ritorno)

    End With

    Exit Sub
Errore:
    LogInserisci True, "F340", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'   Cambio dell'uscita di un predosatore riciclato
Public Sub SetPredosatoreRicUscita(ByVal predosatore As Integer, valore As Boolean)

    If (ListaPredosatoriRic(predosatore).motore.uscita <> valore) Then
        ListaPredosatoriRic(predosatore).motore.uscita = valore
        PredosatoreRicUscita_change predosatore
    End If

End Sub


'   E' cambiato il ritorno di un predosatore riciclato
Public Sub PredosatoreRiciclatoRitorno_change(ByVal predosatore As Integer)

    On Error GoTo Errore

    With ListaPredosatoriRic(predosatore)

        CP240.ImgPredRic(.progressivo).enabled = (.motore.uscita = .motore.ritorno)

    End With

    Exit Sub
Errore:
    LogInserisci True, "F343", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'   E' cambiato il minimo o il vuoto di un predosatore
Public Sub PredosatoreMinimoVuoto_change(ByVal predosatore As Integer)

    Dim vuoto As Boolean
    Dim acceso As Boolean
    Dim indice As Integer
    Dim allarme As Integer

    On Error GoTo Errore

    With CP240
        
        acceso = ListaPredosatori(predosatore).motore.uscita

        If Not AbilitaPredosatoreVuotoComune Then

            AvvisoPredosatoreVuoto ListaPredosatori(predosatore)

            If (ListaPredosatori(predosatore).vuoto) Then
                If (acceso) Then
                    '   Solo se è in moto
                    vuoto = True
                    .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREONVUOTO", vbResBitmap)
                Else
                    .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREVUOTO", vbResBitmap)
                End If
            ElseIf (ListaPredosatori(predosatore).minimo) Then
                If (acceso) Then
                    .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREONMINIMO", vbResBitmap)
                Else
                    .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREMINIMO", vbResBitmap)
                End If
            Else
                If (acceso) Then
                    .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREON", vbResBitmap)
                Else
                    .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATORE", vbResBitmap)
                End If
            End If
            
            indice = 0
            While (indice < NumeroPredosatoriInseriti And Not vuoto)
                If (ListaPredosatori(indice).vuoto And ListaPredosatori(indice).motore.uscita) Then
                    '   Solo se è in moto
                    vuoto = True
                End If
                indice = indice + 1
            Wend
    
            If (PredosatoreVergineVuoto <> vuoto) Then
                PredosatoreVergineVuoto = vuoto
                
                If (PredosatoreVergineVuoto) Then
                    If AllarmiPredosatori Then
                        If Not AllarmeTemporaneoGiaVisualizzato(97) Then
                            Call AllarmeTemporaneo("XX097", True)
                        End If
                        CP240.Frame1(58).Visible = PredosatoreVergineVuoto
                        CP240.Frame1(59).Visible = PredosatoreVergineVuoto And ParallelDrum

                        OraAllarmePredosatori = ConvertiTimer()
                        CP240.LblEtichetta(0).Visible = True
                    End If
                End If
            End If
            
            Call GestioneVibratoriESoffi(predosatore, False)
        Else

            If (acceso) Then
                .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREON", vbResBitmap)
            Else
                .ImgPred(predosatore).Picture = LoadResPicture("IDB_PREDOSATORE", vbResBitmap)
            End If

            'Uso l'ingresso di predosatore 1 vuoto come vuoto comune per i Cyb400 o vecchi Cyb500
            If predosatore = 1 Then
                
                allarme = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "PR023", "IdDescrizione")
                IngressoAllarmePresente allarme, ListaPredosatori(predosatore).vuoto

                indice = 0
                While (indice < NumeroPredosatoriInseriti And Not vuoto)
                    If (ListaPredosatori(predosatore).vuoto And ListaPredosatori(indice).motore.uscita) Then
                        '   Solo se è in moto
                        vuoto = True
                    End If
                    indice = indice + 1
                Wend

                If (PredosatoreVergineVuoto <> vuoto) Then
                    PredosatoreVergineVuoto = vuoto
                    
                    If (PredosatoreVergineVuoto) Then
                        If AllarmiPredosatori Then
                            If Not AllarmeTemporaneoGiaVisualizzato(97) Then
                                Call AllarmeTemporaneo("XX097", True)
                            End If
                            CP240.Frame1(58).Visible = PredosatoreVergineVuoto
                            CP240.Frame1(59).Visible = PredosatoreVergineVuoto And ParallelDrum

                            OraAllarmePredosatori = ConvertiTimer()
                        End If
                    End If
                End If

            End If

        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "F341", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'   E' cambiato il minimo o il vuoto di un predosatore riciclato
Public Sub PredosatoreRiciclatoMinimoVuoto_change(ByVal predosatore As Integer)

    Dim vuoto As Boolean
    Dim acceso As Boolean
    Dim indice As Integer
    'Dim allarme As Integer

    On Error GoTo Errore

    With CP240

        acceso = ListaPredosatoriRic(predosatore).motore.uscita
        'acceso = ListaPredosatoriRic(predosatore).motore.ritorno

        If Not AbilitaPredosatoreVuotoComune Then

            AvvisoPredosatoreVuoto ListaPredosatoriRic(predosatore)

            If (ListaPredosatoriRic(predosatore).vuoto) Then

                If (acceso) Then
                    '   Solo se è in moto
                    vuoto = True
                    .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREONVUOTO", vbResBitmap)
                Else
                    .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREVUOTO", vbResBitmap)
                End If

            ElseIf (ListaPredosatoriRic(predosatore).minimo) Then

                If (acceso) Then
                    .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREONMINIMO", vbResBitmap)
                Else
                    .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREMINIMO", vbResBitmap)
                End If

            Else

                If (acceso) Then
                    .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREON", vbResBitmap)
                Else
                    .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATORE", vbResBitmap)
                End If

            End If

            indice = 0
            While (indice < NumeroPredosatoriRicInseriti And Not vuoto)
                If (ListaPredosatoriRic(indice).vuoto And ListaPredosatoriRic(indice).motore.uscita) Then
                    '   Solo se è in moto
                    vuoto = True
                End If
                indice = indice + 1
            Wend

        Else
            If (acceso) Then
                .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATOREON", vbResBitmap)
            Else
                .ImgPredRic(predosatore).Picture = LoadResPicture("IDB_PREDOSATORE", vbResBitmap)
            End If
        End If

        If (PredosatoreRiciclatoVuoto <> vuoto) Then
            PredosatoreRiciclatoVuoto = vuoto
            
            If (PredosatoreRiciclatoVuoto) Then

                If AllarmiPredosatori Then
                    If Not AllarmeTemporaneoGiaVisualizzato(97) Then
                        Call AllarmeTemporaneo("XX097", True)
                    End If
                    CP240.Frame1(58).Visible = PredosatoreRiciclatoVuoto
                    CP240.Frame1(59).Visible = PredosatoreRiciclatoVuoto And ParallelDrum

                    OraAllarmePredosatori = ConvertiTimer()
                End If

            End If
        End If
        
        Call GestioneVibratoriESoffi(predosatore, True)
    
    End With

    Exit Sub
Errore:
    LogInserisci True, "F342", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'   Calcolo umidità (quantità di acqua) totale dei predosatori.
Public Function PredosatoriCalcoloUmiditaTotaleTmp(Umidita() As Double, tutti As Boolean) As Double

    Dim pp As Integer
    Dim umiditaPredTmp(0 To MAXPREDOSATORI - 1) As Double
    Dim umiditaPredTotaleTmp As Double


    With CP240

        For pp = 0 To NumeroPredosatoriInseriti - 1
            If (ListaPredosatori(pp).PortataMax > 0 And PredosatoreOttieniSet(False, pp)) > 0 Then
                ListaPredosatori(pp).SetTonH = RoundNumber((TonOrarieAttualiImpianto * PredosatoreOttieniSet(False, pp)) / 100, 0)
                umiditaPredTmp(pp) = 0
                If (tutti Or ListaPredosatori(pp).motore.uscita) Then
                    umiditaPredTmp(pp) = RoundNumber((Umidita(pp) * ListaPredosatori(pp).SetTonH) / 100, 2)
                End If
                umiditaPredTotaleTmp = RoundNumber(umiditaPredTotaleTmp + umiditaPredTmp(pp), 2)
            End If
        Next pp

        PredosatoriCalcoloUmiditaTotaleTmp = RoundNumber(umiditaPredTotaleTmp, 1)

    End With

End Function


'   Calcolo umidità (quantità di acqua) totale dei predosatori.
Public Function PredosatoriCalcoloUmiditaTotale(tutti As Boolean) As Double

    Dim pp As Integer
    Dim umiditaTmp(0 To MAXPREDOSATORI - 1) As Double

    For pp = 0 To NumeroPredosatoriInseriti - 1
        umiditaTmp(pp) = ListaPredosatori(pp).Umidita
    Next pp

    PredosatoriCalcoloUmiditaTotale = PredosatoriCalcoloUmiditaTotaleTmp(umiditaTmp, tutti)

End Function


'Calcolo dell'umidità interamente rifatto
Public Function PredosatoriRiciclatoCalcoloUmiditaTotaleTmp(Umidita() As Double, Index As Integer) As Double

    Dim pp As Integer
    Dim umiditaPredRicTmp(0 To MAXPREDOSATORIRICICLATO - 1) As Double
    Dim umiditaPredRicTotaleTmp, umiditaPredRicTotaleTmpParDrum As Double

    With CP240
    
    If Not ParallelDrum Then
        For pp = 0 To NumeroPredosatoriRicInseriti - 1
            If (ListaPredosatoriRic(pp).PortataMax > 0 And PredosatoreOttieniSet(True, pp)) > 0 Then
                ListaPredosatoriRic(pp).SetTonH = RoundNumber((TonOrarieAttualiImpianto * PredosatoreOttieniSet(True, pp)) / 100, 0)
                umiditaPredRicTmp(pp) = 0
                umiditaPredRicTmp(pp) = RoundNumber((Umidita(pp) * ListaPredosatoriRic(pp).SetTonH) / 100, 2)
                umiditaPredRicTotaleTmp = RoundNumber(umiditaPredRicTotaleTmp + umiditaPredRicTmp(pp), 2)
            End If
        Next pp

        PredosatoriRiciclatoCalcoloUmiditaTotaleTmp = RoundNumber(umiditaPredRicTotaleTmp, 1)
    Else
        ' in questa prima parte calcola l'umidità totale associata al riciclato del primo tamburo
        For pp = 0 To PrimoPredosatoreDelNastro(RiciclatoFreddo) - 1
            If (ListaPredosatoriRic(pp).PortataMax > 0 And PredosatoreOttieniSet(True, pp)) > 0 Then
                ListaPredosatoriRic(pp).SetTonH = RoundNumber((TonOrarieAttualiImpianto * PredosatoreOttieniSet(True, pp)) / 100, 0)
                umiditaPredRicTmp(pp) = 0
                umiditaPredRicTmp(pp) = RoundNumber((Umidita(pp) * ListaPredosatoriRic(pp).SetTonH) / 100, 2)
                umiditaPredRicTotaleTmp = RoundNumber(umiditaPredRicTotaleTmp + umiditaPredRicTmp(pp), 2)
            End If
        Next pp
        ' in questa seconda parte calcola l'umidità totale associata al ricicalto del tamburo parallelo
        For pp = PrimoPredosatoreDelNastro(RiciclatoFreddo) To NumeroPredosatoriRicInseriti - 1
            If (ListaPredosatoriRic(pp).PortataMax > 0 And PredosatoreOttieniSet(True, pp)) > 0 Then
                ListaPredosatoriRic(pp).SetTonH = RoundNumber((TonOrarieAttualiImpianto * PredosatoreOttieniSet(True, pp)) / 100, 0)
                umiditaPredRicTmp(pp) = 0
                umiditaPredRicTmp(pp) = RoundNumber((Umidita(pp) * ListaPredosatoriRic(pp).SetTonH) / 100, 2)
                umiditaPredRicTotaleTmpParDrum = RoundNumber(umiditaPredRicTotaleTmpParDrum + umiditaPredRicTmp(pp), 2)
            End If
        Next pp
        ' l'indice identifica la richiesta => se la function è stata chiamata con indice 0 significa che interessa ricevere
        ' la quantità di umidità totale relativa al primo tamburo, se l'indice è 1 invece si vuole ricevere la quantità di
        ' umidità totale relativa al tamburo parallelo
        If Index = 0 Then
            PredosatoriRiciclatoCalcoloUmiditaTotaleTmp = RoundNumber(umiditaPredRicTotaleTmp, 1)
        ElseIf Index = 1 Then
            PredosatoriRiciclatoCalcoloUmiditaTotaleTmp = RoundNumber(umiditaPredRicTotaleTmpParDrum, 1)
        End If
    End If
    
    End With

End Function

'   Calcolo umidità (quantità di acqua) totale dei predosatori riciclato.
Public Function PredosatoriRiciclatoCalcoloUmiditaTotale(Index As Integer) As Double

    Dim pp As Integer
    Dim umiditaTmp(0 To MAXPREDOSATORIRICICLATO - 1) As Double

    For pp = 0 To NumeroPredosatoriRicInseriti - 1
        umiditaTmp(pp) = ListaPredosatoriRic(pp).Umidita
    Next pp

    PredosatoriRiciclatoCalcoloUmiditaTotale = PredosatoriRiciclatoCalcoloUmiditaTotaleTmp(umiditaTmp, Index)
    
    
End Function

'   Funzione chiamata a timer per verificare i ritardi
Public Sub RitardoVibratorePredVuoto()

    Dim predosatore As Integer

    For predosatore = 0 To NumeroPredosatoriInseriti - 1

        If (ListaPredosatori(predosatore).tempoVuotoOnVibratore <> 0) Then

            If (ConvertiTimer() - ListaPredosatori(predosatore).tempoVuotoOnVibratore) >= RitardoStartVibratorePredVuoto Then
                ListaPredosatori(predosatore).tempoVuotoOnVibratore = 0
                ListaPredosatori(predosatore).vibratoreAbilitato = True
            End If
        ElseIf (ListaPredosatori(predosatore).tempoVuotoOffVibratore <> 0) Then
             If (ConvertiTimer() - ListaPredosatori(predosatore).tempoVuotoOffVibratore) >= RitardoStartVibratorePredVuoto Then
                ListaPredosatori(predosatore).tempoVuotoOffVibratore = 0
                ListaPredosatori(predosatore).vibratoreAbilitato = False
              End If
        End If

    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        
        If (ListaPredosatoriRic(predosatore).tempoVuotoOnVibratore <> 0) Then
            If (ConvertiTimer() - ListaPredosatoriRic(predosatore).tempoVuotoOnVibratore) >= RitardoStopVibratorePredVuoto Then
                ListaPredosatoriRic(predosatore).tempoVuotoOnVibratore = 0
                ListaPredosatoriRic(predosatore).vibratoreAbilitato = True
            End If
        ElseIf (ListaPredosatoriRic(predosatore).tempoVuotoOffVibratore <> 0) Then
             If (ConvertiTimer() - ListaPredosatoriRic(predosatore).tempoVuotoOffVibratore) >= RitardoStartVibratorePredVuoto Then
                ListaPredosatoriRic(predosatore).tempoVuotoOffVibratore = 0
                ListaPredosatoriRic(predosatore).vibratoreAbilitato = False
              End If
        End If
        
    Next predosatore
    
End Sub


Public Sub RitardoSoffioPredVuoto()
        
    Dim predosatore As Integer
    
    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        
        If (ListaPredosatoriRic(predosatore).tempoVuotoOnSoffio <> 0) Then
            If (ConvertiTimer() - ListaPredosatoriRic(predosatore).tempoVuotoOnSoffio) >= RitardoStopVibratorePredVuoto Then
                ListaPredosatoriRic(predosatore).tempoVuotoOnSoffio = 0
                ListaPredosatoriRic(predosatore).soffioAbilitato = True
            End If
        ElseIf (ListaPredosatoriRic(predosatore).tempoVuotoOffVibratore <> 0) Then
             If (ConvertiTimer() - ListaPredosatoriRic(predosatore).tempoVuotoOffSoffio) >= RitardoStartVibratorePredVuoto Then
                ListaPredosatoriRic(predosatore).tempoVuotoOffSoffio = 0
                ListaPredosatoriRic(predosatore).soffioAbilitato = False
              End If
        End If
        
    Next predosatore

End Sub


'   E' cambiato il flag di termica dei predosatori
Public Sub TermicaPredosatori_change()

    If TermicaPredosatori Then
        
        PredosatoriArrestoImmediato True, -1
        PredosatoriArrestoImmediato False, -1

        Call PulsanteStopPred
    End If
    
'20151125
'    CP240.CmdStartPred.enabled = (AutomaticoPredosatori And Not TermicaPredosatori)
    CP240.CmdStartPred.enabled = Not TermicaPredosatori
'
End Sub

'   Verifica se il predosatore è ritardato
Private Function PredosatoreRitardato(ByRef Pred As PredosatoreType) As Boolean

    With Pred

        PredosatoreRitardato = Not PredosatoriImmediati And Not .immediato

    End With

End Function

'   Ottiene il set del predosatore
Public Function PredosatoreOttieniSet(riciclato As Boolean, ByVal predosatore As Integer) As Integer

    If (riciclato) Then

        If (predosatore >= MAXPREDOSATORIRICICLATO) Then
            Exit Function
        End If

        PredosatoreOttieniSet = ListaPredosatoriRic(predosatore).setAttuale.set

    Else

        If (predosatore >= MAXPREDOSATORI) Then
            Exit Function
        End If

        PredosatoreOttieniSet = ListaPredosatori(predosatore).setAttuale.set

    End If

End Function


'   Modifica il set del predosatore
Public Sub PredosatoreCambiaSet(riciclato As Boolean, ByVal predosatore As Integer, valore As Integer, cambioManuale As Boolean)

    On Error GoTo Errore

    If (riciclato) Then

        If (predosatore >= MAXPREDOSATORIRICICLATO) Then
            Exit Sub
        End If

        Call PredosatoreInserisciSet(ListaPredosatoriRic(predosatore), valore, cambioManuale)

    Else

        If (predosatore >= MAXPREDOSATORI) Then
            Exit Sub
        End If

        Call PredosatoreInserisciSet(ListaPredosatori(predosatore), valore, cambioManuale)

    End If

    Exit Sub

Errore:
    LogInserisci True, "F88", CStr(Err.Number) + " [" + Err.description + "]"

End Sub


Private Sub PredosatoreInserisciSet(ByRef Pred As PredosatoreType, valore As Integer, cambioManuale As Boolean)

    Dim Livello As Integer
    'Dim NomeCampo As String
    Dim incrementa As Boolean

    On Error GoTo Errore

    With Pred

        If (.bloccaCambioSet) Then
            .bloccaCambioSet = False
            Exit Sub
        End If

        If (AutomaticoPredosatori And .start) Then

            If (CP240.adoComboPredosaggio.text = "") Then
                Exit Sub
            End If

            Livello = .codaSetLivello
            incrementa = True

            If (.codaSetLivello > 0) Then
                If ( _
                    ConvertiTimer() <= .codaSet(.codaSetLivello - 1).setOra + SECONDIXCAMBIO _
                ) Then
                    '   Riutilizzo l'ultima posizione se:
                    '   1) il set è lo stesso       valore = .codaSet(.codaSetLivello - 1).set Or
                    '   2) il cambio è avvenuto entro pochi secondi
                    Livello = .codaSetLivello - 1
                    incrementa = False
                End If
            End If

            .codaSet(Livello).set = valore
            .codaSet(Livello).setOra = ConvertiTimer()

            If (.riciclato) Then
                .codaSet(Livello).tempoStart = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StartPredRic" & .progressivo + 1).Value)  '20160229
                .codaSet(Livello).tempoStop = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StopPredRic" & .progressivo + 1).Value)
            Else
                .codaSet(Livello).tempoStart = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StartStopPred" & .progressivo + 1).Value)
                .codaSet(Livello).tempoStop = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StartStopPred" & .progressivo + 1).Value)
            End If

            .codaSet(Livello).cambioManuale = cambioManuale

            If (incrementa) Then
                .codaSetLivello = .codaSetLivello + 1
            End If

        Else

            '   Se non sono in automatico inserisco sempre nell'attuale
            .setAttuale.set = valore
            .setAttuale.setOra = ConvertiTimer()

            If (CP240.adoComboPredosaggio.text <> "") Then
                '   Ricetta selezionata
                If (.riciclato) Then
                    .setAttuale.tempoStart = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StartPredRic" & .progressivo + 1).Value)
                    .setAttuale.tempoStop = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StopPredRic" & .progressivo + 1).Value)
                Else
                    .setAttuale.tempoStart = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StartStopPred" & .progressivo + 1).Value)
                    .setAttuale.tempoStop = Null2zero(CP240.AdoPredosaggio.Recordset.Fields("StartStopPred" & .progressivo + 1).Value)
                End If
            Else
                .setAttuale.tempoStart = 0
                .setAttuale.tempoStop = 0
            End If

            .codaSet(Livello).cambioManuale = cambioManuale

            If (.start And .setAttuale.set > 0) Then
                PredosatoreCambiaStato Pred, predosatoreInStart 'StatoPredosatoreType.predosatoreInStart
            Else
                PredosatoreCambiaStato Pred, predosatoreInStop 'StatoPredosatoreType.predosatoreInStop
            End If

        End If

    End With

    Exit Sub

Errore:
    LogInserisci True, "F87", CStr(Err.Number) + " [" + Err.description + "]"

End Sub


Private Sub PredosatoreProssimoSet(ByRef Pred As PredosatoreType, forzaTempi As Boolean)

    Dim Livello As Integer
    Dim verificaStop As Boolean
    Dim predRelativo As Integer
    
    With Pred

        If (.codaSetLivello > 0) Then

            '   Se c'e qualcosa in coda lo utilizza, altrimenti i set rimangono quelli vecchi

            If (ConvertiTimer() <= SECONDIXCAMBIO) Then
                Exit Sub
            End If

            Dim tempostopvecchio As Integer
            Dim usatempostopvecchio As Boolean
            If (.setAttuale.set > 0 And .codaSet(0).set = 0 And .codaSet(0).tempoStop = 0) Then
                'Devo spegnerlo ma non ho il nuovo tempo di stop --> mi tengo il vecchio
                tempostopvecchio = .setAttuale.tempoStop
                usatempostopvecchio = True
            End If
            '

            .setAttuale = .codaSet(0)

            If (usatempostopvecchio) Then
                .setAttuale.tempoStop = tempostopvecchio
            End If

            For Livello = 0 To .codaSetLivello - 1
                '   Shift di tutti i livelli
                .codaSet(Livello) = .codaSet(Livello + 1)
            Next Livello

            '   Un livello in meno
            .codaSetLivello = .codaSetLivello - 1

            verificaStop = True

        End If

        If (.start) Then
            If (.setAttuale.set > 0) Then
                '   Pronto per una nuova ripartenza
                If ( _
                    AutomaticoPredosatori And PredosatoreRitardato(Pred) And _
                    (forzaTempi Or PredosatoriCambioSet = CambioSetPredosatoreType.tempoStart) And _
                    Not .setAttuale.cambioManuale _
                ) Then
                    PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreStarting
                Else
                    PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreInStart
                End If
            ElseIf (verificaStop) Then
                If (AutomaticoPredosatori And PredosatoreRitardato(Pred) And Not .setAttuale.cambioManuale) Then
                    PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreStopping
                Else
                    PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreInStop
                End If
            End If
        End If

    End With

End Sub

Public Function PIDcontroller( _
    ByRef pid As PidType, _
    ByVal uscitaTeorica As Double, _
    ByVal ValoreTeorico As Double, _
    ByRef uscitaReale As Double, _
    ByVal valoreReale As Double _
) As Double

    Dim Ki As Double    'per il momento la dichiaro così. In futuro sostituirà la Ti nel FrmParametri
    Dim Kd As Double    'per il momento la dichiaro così. In futuro sostituirà la Td nel FrmParametri
    Dim errorePortata As Double         'errore fra il valore teorico (setpoint) e il valore reale
    Dim erroreCorrente As Double   'è l'errore di portata convertito nella cifra di controllo dell'apertura del predosatore
    Dim Cost As Double
    Dim LimiteCorrezionePonderaleMax As Integer
    Dim LimiteCorrezionePonderaleMin As Integer
    Dim UscitaRealeAppoggio As Double
    
    On Error GoTo overflow
        
    With pid

        .Campionamento = CDbl(Timer)
        
        'calcolo delle costanti del PID -> Kp, Ti e Td si impostano da parametri
        Ki = .KP / .ti
        Kd = .KP * .td
        Cost = 276      'costante di conversione da tonnellate ad unità
        
        'calcolo dei limiti di correzione ponderale -> sorta di antiwindup
        LimiteCorrezionePonderaleMax = uscitaTeorica + Round(uscitaTeorica * (.maxCorrezione / 100), 0)
        LimiteCorrezionePonderaleMin = uscitaTeorica - Round(uscitaTeorica * (.maxCorrezione / 100), 0)
        
        If (.primaVolta) Then   'inizializzazione
             erroreCorrente = 0
            .errorePrecedente = 0
            .primaVolta = False
             uscitaReale = uscitaTeorica
            .integrale = 0
            .derivata = 0
            .maxCorrezioneRaggiunta = 0
        Else
        ' da qui inizia il PID
           
            errorePortata = ValoreTeorico - valoreReale
            erroreCorrente = errorePortata * Cost
                        
            .integrale = (.integrale + erroreCorrente * (.TC / 100)) * Ki
            
            .derivata = ((erroreCorrente - .errorePrecedente) / (.TC)) * Kd
                                
            .proporzionale = (.KP * erroreCorrente) / 10
                                
            'il proporzionale e' stato sostituito dall'uscita teorica per ridurre i tempi della correzione ed evitare forti variazioni di pesata
            UscitaRealeAppoggio = uscitaTeorica + Ki * .integrale + Kd * .derivata
                                                
            If UscitaRealeAppoggio >= LimiteCorrezionePonderaleMax Then
                'sono al di sopra della zona di correzione
                uscitaReale = LimiteCorrezionePonderaleMax
                .maxCorrezioneRaggiunta = 1
                .integrale = .integralePrecedente
            ElseIf UscitaRealeAppoggio <= LimiteCorrezionePonderaleMin Then
                'sono al di sotto della zona di correzione
                uscitaReale = LimiteCorrezionePonderaleMin
                .maxCorrezioneRaggiunta = -1
                .integrale = .integralePrecedente
            Else
                'sono dentro la zona di correzione
                uscitaReale = Round(UscitaRealeAppoggio, 0)
                .maxCorrezioneRaggiunta = 0
                .integralePrecedente = .integrale
            End If
            
            .errorePrecedente = erroreCorrente
        End If
                        
    End With
    
    Exit Function
        
overflow:
    
    Debug.Print "PIDcontroller overflow"

End Function


Private Sub VisualizzaMinMaxPonderale(ByRef Pred As PredosatoreType)

    With Pred

        If (.raggiuntaMinCorrezioneVis) Then
            If (.riciclato) Then
                Call AllarmeTemporaneo("XX0" & Format(.progressivo + 78, "00"), True)
            Else
                Call AllarmeTemporaneo("XX0" & Format(.progressivo + 66, "00"), True)
            End If
        Else
            If (.riciclato) Then
                Call AllarmeTemporaneo("XX0" & Format(.progressivo + 93, "00"), True)
            Else
                Call AllarmeTemporaneo("XX0" & Format(.progressivo + 81, "00"), True)
            End If
        End If

    End With

End Sub

Private Sub PredosatoreRegolazionePonderale(ByRef Pred As PredosatoreType)

    With Pred

        If (Not .bilanciaPresente Or Not .ponderaleAttivo) Then
            Exit Sub
        End If

        If ( _
            (.pid.primaVolta And .pid.Campionamento + .pid.ritardoTC <= CDbl(Timer)) Or _
            (Not .pid.primaVolta And .pid.Campionamento + .pid.TC <= CDbl(Timer)) _
        ) Then

            Call PIDcontroller( _
                .pid, _
                .uscitaAnalogicaTeorica, _
                .portataTeorica, _
                .uscitaAnalogica, _
                .portataBilancia _
                )

            If (.pid.maxCorrezioneRaggiunta < 0) Then

                If (Not .raggiuntaMinCorrezioneVis) Then
                    .raggiuntaMinCorrezioneVis = True
                    VisualizzaMinMaxPonderale Pred
                End If

            ElseIf (.pid.maxCorrezioneRaggiunta > 0) Then

                If (Not .raggiuntaMaxCorrezioneVis) Then
                    .raggiuntaMaxCorrezioneVis = True
                    VisualizzaMinMaxPonderale Pred
                End If

            Else

                .raggiuntaMinCorrezioneVis = False
                .raggiuntaMaxCorrezioneVis = False

            End If

        End If

    End With

End Sub


Private Sub PredosatoreVolumetricoPonderale(ByRef Pred As PredosatoreType, attivo As Boolean)

    'Dim indiceCP240 As Integer

    With Pred

        If (AutomaticoPredosatori And .motore.uscita) Then 'StartPredosatori And
            .ponderaleAttivo = attivo
        Else
            .ponderaleAttivo = False
        End If

        If (Not .ponderaleAttivo) Then
            .uscitaAnalogica = .uscitaAnalogicaTeorica

            .raggiuntaMinCorrezioneVis = False
            .raggiuntaMaxCorrezioneVis = False
        End If

        If (FrmStatoPredosatoriVisibile) Then
            FrmStatoPredosatori.AggiornaVolumetricoPonderale
        End If

    End With

End Sub


Public Sub PredosatoreInVolumetrico(riciclato As Boolean, predosatore As Integer, attivo As Boolean)

    If (riciclato) Then
        PredosatoreVolumetricoPonderale ListaPredosatoriRic(predosatore), attivo
    Else
        PredosatoreVolumetricoPonderale ListaPredosatori(predosatore), attivo
    End If

End Sub


'   Calcola l'uscita analogica del predosatore
Private Sub PredosatoreUscitaAnalogica(ByRef Pred As PredosatoreType, ValoreSet As Integer)

     With Pred

        If (ValoreSet = 0) Then
            .portataTeorica = 0
            .setCalcolato = 0
            .uscitaAnalogica = 0
            .uscitaAnalogicaTeorica = 0
            Exit Sub
        End If

        .portataTeorica = (ValoreSet * TonOrarieAttualiImpianto) / 100

        .setCalcolato = CInt(PredosatoreSetCalcolato(Pred, .portataTeorica))

        .uscitaAnalogicaTeorica = CInt(ValoreUscitaAnalogicaPred(.riciclato, ValoreSet, .setCalcolato))

        .uscitaAnalogica = .uscitaAnalogicaTeorica

    End With

End Sub


'   Cambio di stato del predosatore
Private Sub PredosatoreCambiaStato(ByRef Pred As PredosatoreType, nuovoStato As StatoPredosatoreType)

    On Error GoTo Errore

    With Pred

        .setOra = ConvertiTimer()
        .stato = nuovoStato

        Select Case .stato

             Case StatoPredosatoreType.predosatoreInStop
                PredosatoreUscitaAnalogica Pred, 0
                If (.riciclato) Then
                    SetPredosatoreRicUscita .progressivo, False
                Else
                    SetPredosatoreUscita .progressivo, False
                End If

                If (.riciclato) Then
                    CP240.TxtPredRicSet(.progressivo).text = CStr(.setAttuale.set)
                Else
                    CP240.TxtPredSet(.progressivo).text = CStr(.setAttuale.set)
                End If

                Call DatiSetPredosaggi

                Call GestioneStoricoPredosaggioAggiungi

            Case StatoPredosatoreType.predosatoreStopping

            Case StatoPredosatoreType.predosatoreInStart
                .pid.primaVolta = True
                .pid.Campionamento = CDbl(Timer)

                PredosatoreUscitaAnalogica Pred, .setAttuale.set
                If (.riciclato) Then
                    SetPredosatoreRicUscita .progressivo, True
                Else
                    SetPredosatoreUscita .progressivo, True
                End If

                Call DatiSetPredosaggi

                Call GestioneStoricoPredosaggioAggiungi

            Case StatoPredosatoreType.predosatoreStarting

        End Select

        '   Evita il loop di inserimento in coda
        .bloccaCambioSet = True
        If (.riciclato) Then
            CP240.TxtPredRicSet(.progressivo).text = CStr(.setAttuale.set)
        Else
            CP240.TxtPredSet(.progressivo).text = CStr(.setAttuale.set)
        End If
        .bloccaCambioSet = False

        .setAttuale.cambioManuale = False

    End With

    Exit Sub

Errore:
    LogInserisci True, "F86", CStr(Err.Number) + " [" + Err.description + "]"

End Sub


Public Sub PredosatoreVerificaSet(ByRef Pred As PredosatoreType, forza As Boolean)

    Dim indice As Integer
    Dim stato As String
    Dim predosatore As Integer
 
    With Pred

        If (.bilanciaPresente) Then
            If (.bilanciaSiwarex) Then
                If (Not .riciclato) Then
                    If .progressivo = NumeroPredSiwarex1 Then
                        .portataBilancia = CInt(Siwarex(2).SIWA_PORTATA_NASTRO)
                        If Siwarex(2).SIWA_ERR_MSG Then
                            If CP240.LblPredBil(.progressivo).BackColor = vbBlack Then
                                CP240.LblPredBil(.progressivo).BackColor = vbWhite
                            Else
                                CP240.LblPredBil(.progressivo).BackColor = vbBlack
                            End If
                        Else
                            CP240.LblPredBil(.progressivo).BackColor = &H80FFFF
                        End If
                    Else
                        .portataBilancia = CInt(Siwarex(3).SIWA_PORTATA_NASTRO)
                        If Siwarex(3).SIWA_ERR_MSG Then
                            If CP240.LblPredBil(.progressivo).BackColor = vbBlack Then
                                CP240.LblPredBil(.progressivo).BackColor = vbWhite
                            Else
                                CP240.LblPredBil(.progressivo).BackColor = vbBlack
                            End If
                        Else
                            CP240.LblPredBil(.progressivo).BackColor = &H80FFFF
                        End If
                    End If
                Else
                    If (.progressivo <= 1) Then
                        .portataBilancia = CInt(Siwarex(2 + .progressivo).SIWA_PORTATA_NASTRO)
                        If Siwarex(2 + .progressivo).SIWA_ERR_MSG Then
                            If CP240.LblPredRicBil(.progressivo).BackColor = vbBlack Then
                                CP240.LblPredRicBil(.progressivo).BackColor = vbWhite
                            Else
                                CP240.LblPredRicBil(.progressivo).BackColor = vbBlack
                            End If
                        Else
                            CP240.LblPredRicBil(.progressivo).BackColor = &H80FFFF
                        End If
                    Else
                        .portataBilancia = CInt(Siwarex(3 + .progressivo).SIWA_PORTATA_NASTRO)
                        If Siwarex(3 + .progressivo).SIWA_ERR_MSG Then
                            If CP240.LblPredRicBil(.progressivo).BackColor = vbBlack Then
                                CP240.LblPredRicBil(.progressivo).BackColor = vbWhite
                            Else
                                CP240.LblPredRicBil(.progressivo).BackColor = vbBlack
                            End If
                        Else
                            CP240.LblPredRicBil(.progressivo).BackColor = &H80FFFF
                        End If
                    End If
                End If
            Else
                .portataBilancia = CDbl(Sonda_mA(CLng(AnalogIO(.ingressoAnalogicoBilancia).Value), CLng(.portataMaxBilancia), 0, False))
            End If

            indice = .progressivo

            If (Not .riciclato) Then
                CP240.LblPredBil(indice).caption = Format(.portataBilancia, "0.0") + " T/h"
            Else
                CP240.LblPredRicBil(indice).caption = Format(.portataBilancia, "0.0") + " T/h"
            End If

        Else
            indice = .progressivo

            If (VisualizzaSetCalcolatoPredosatori) Then
                stato = Format(.setCalcolato, "0.0") + " %"
            Else
                stato = Format(.portataTeorica, "0.0") + " T/h"
            End If

            If (Not .riciclato) Then
                CP240.LblPredBil(indice).caption = stato
            Else
                CP240.LblPredRicBil(indice).caption = stato
            End If
        End If

        Select Case .stato

            Case StatoPredosatoreType.predosatoreInStop
                If (.start) Then
                    '   Pronto per una nuova partenza
                    PredosatoreProssimoSet Pred, True
                End If

            Case StatoPredosatoreType.predosatoreStopping
                If (forza Or Not PredosatoreRitardato(Pred) Or ConvertiTimer() >= .setOra + .setAttuale.tempoStop) Then

                    If (Not forza And AutomaticoPredosatori And .codaSetLivello > 0) Then
                        '   Pronto per una nuova partenza
                        PredosatoreProssimoSet Pred, False
                    Else
                        PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreInStop
                    End If

                End If

            Case StatoPredosatoreType.predosatoreInStart
                If (Not .start) Then

                    '   Fermo
                    If (forza Or Not AutomaticoPredosatori) Then
                        PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreInStop
                    Else
                        PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreStopping
                    End If

                ElseIf (AutomaticoPredosatori And .start And .bilanciaPresente) Then
                    If Not .riciclato Then
                        PredosatoreRegolazionePonderale Pred
                    End If
                End If

                If (AutomaticoPredosatori And .codaSetLivello > 0) Then

                    '   C'è qualcosa in attesa
                    PredosatoreProssimoSet Pred, False

                End If

            Case StatoPredosatoreType.predosatoreStarting
                If (.start) Then
                    If (Not PredosatoreRitardato(Pred) Or ConvertiTimer() >= .setOra + .setAttuale.tempoStart) Then
                        PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreInStart
                    End If
                Else
                    PredosatoreCambiaStato Pred, StatoPredosatoreType.predosatoreInStop
                End If

        End Select

    End With

End Sub


Public Sub PredosatoriSet_timer()

    Dim percento As Integer
    Dim predosatore As Integer
    Dim almenoUnoAcceso As Boolean
    Dim Criterio As String
    Dim PredRAPinRicetta As Integer

    percento = 0

    If (ConvertiTimer() >= LampeggioLampadaTm + 1) Then
        '   lampeggio 1 secondo
        LampeggioLampada = (Not LampeggioLampada)
        LampeggioLampadaTm = ConvertiTimer()
    End If

    AlmenoUnoAccesoPredVergini = False
    AlmenoUnoAccesoPredRiciclatoCaldo = False
    AlmenoUnoAccesoPredRiciclatoFreddo = False

    For predosatore = 0 To NumeroPredosatoriInseriti - 1

        With ListaPredosatori(predosatore)
            If (Not attesastartplc) Then
                Call PredosatoreVerificaSet(ListaPredosatori(predosatore), False)
            End If
            percento = percento + .setAttuale.set
            
            'Gestione lampeggiante predosatore
            .UscitaLampada = False
            If (.motore.uscita) Then
            
                AlmenoUnoAccesoPredVergini = True
                almenoUnoAcceso = True
                If (.vuoto) Then
                    .UscitaLampada = True
                ElseIf (.minimo) Then
                    .UscitaLampada = LampeggioLampada
                End If
            End If

            Criterio = "PR0" + CStr(predosatore + 11)
            If (Not VerificaMotorePred(.motore, Criterio)) Then
                Call PassaInManualePredosatori

                If AllarmiPredosatori And AutomaticoPredosatori Then
                    Call PulsanteStopPred
                End If
            End If

        End With

    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1

        With ListaPredosatoriRic(predosatore)
            If (Not attesastartplc) Then
                PredosatoreVerificaSet ListaPredosatoriRic(predosatore), False
            End If
            percento = percento + .setAttuale.set
            
            .UscitaLampada = False

            If (.motore.uscita) Then
                If predosatore >= (PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoFreddo)) Then
                    AlmenoUnoAccesoPredRiciclatoFreddo = True
                Else
                    AlmenoUnoAccesoPredRiciclatoCaldo = True
                End If

                .UscitaLampada = False
                If (.vuoto) Then
                    .UscitaLampada = True
                ElseIf (.minimo) Then
                    .UscitaLampada = LampeggioLampada
                End If
            End If

            Criterio = "PR0" + CStr(predosatore + 25)
            If (Not VerificaMotorePred(.motore, Criterio)) Then
                Call PassaInManualePredosatori

                If AllarmiPredosatori And AutomaticoPredosatori Then
                    Call PulsanteStopPred
                End If
            End If

        End With

    Next predosatore


    '   Visualizza percentuale
    CP240.LblEtichetta(88).caption = CStr(percento) + "%"
    If (percento = 100) Then
        CP240.LblEtichetta(88).ForeColor = &H8000&
    Else
        CP240.LblEtichetta(88).ForeColor = &HFF&
    End If

    '   Verifica arresto bruciatore
    If (Not almenoUnoAcceso Or percento = 0) Then
        'L'allarme della partenza del tempo di arresto veniva visualizzato anche dopo aver spento il
        'bruciatore perché l'OPC vedeva ancora attiva la fiamma per un attimo. Ho messo il controllo
        'sul tempo di arresto che non sia già terminato.
        ListaTamburi(0).TempoArrestoBrucAttivo = TemperaturaLavoroFiltroOK And ListaTamburi(0).FiammaBruciatorePresente And (ListaTamburi(0).ConteggioSecondiSpegniBruciatore > 1)
        If PredosatoriAutomaticoOn And AlmenoUnoAccesoPredRiciclatoCaldo And Not AvvioPredosatoriSenzaBruciatore Then
            Call PulsanteStopPred
        End If
    Else
        ListaTamburi(0).TempoArrestoBrucAttivo = False
    End If



    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1
        PredRAPinRicetta = PredRAPinRicetta + ListaPredosatoriRic(predosatore).setAttuale.set
    Next predosatore


    If (Not AlmenoUnoAccesoPredRiciclatoFreddo Or percento = 0) Then
        'L'allarme della partenza del tempo di arresto veniva visualizzato anche dopo aver spento il
        'bruciatore perché l'OPC vedeva ancora attiva la fiamma per un attimo. Ho messo il controllo
        'sul tempo di arresto che non sia già terminato.
        ListaTamburi(1).TempoArrestoBrucAttivo = TemperaturaLavoroFiltroOK And ListaTamburi(1).FiammaBruciatorePresente And (ListaTamburi(1).ConteggioSecondiSpegniBruciatore > 1)
        '
        'Se azzero manualmente tutti i predosatori devo toglierli dallo start automatico
        If PredosatoriAutomaticoOn And PredRAPinRicetta > 0 And Not AvvioPredosatoriSenzaBruciatore Then
            'Call PulsanteStopPred
        End If
    Else
        ListaTamburi(1).TempoArrestoBrucAttivo = False
    End If
'


    Call PredosatoriVerificaAllarme

    Dim SoloRiciclato As Boolean
    SoloRiciclato = True
    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        If ListaPredosatori(predosatore).setAttuale.set > 0 Then
            SoloRiciclato = False
            Exit For
        End If
    Next predosatore

    If Not SoloRiciclato And ((ConfigPortataNastroInerti > 1) Or (ConfigPortataNastroRiciclato > 1)) Then
        Call NastroRicRegolazionePonderale
    End If

    If ListaMotori(MotoreTrasportoFillerizzazioneFiltro).presente Then
        Call GestioneFillerizzazione
    End If

    '20160802 : test di variazione di velocita' di tutti i predosatori
    Dim variazionepred As Boolean
    variazionepred = False
    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        'If (ListaPredosatori(predosatore).stato <> ListaPredosatori(predosatore).statoprecedente) Or (ListaPredosatori(predosatore).setPrecedente <> ListaPredosatori(predosatore).SetTonH) Then
        If (ListaPredosatori(predosatore).setPrecedente <> ListaPredosatori(predosatore).SetTonH) Then
            variazionepred = True
        End If
        'ListaPredosatori(predosatore).statoprecedente = ListaPredosatori(predosatore).stato
        ListaPredosatori(predosatore).setPrecedente = ListaPredosatori(predosatore).SetTonH
    Next predosatore
    
    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        'If (ListaPredosatoriRic(predosatore).stato <> ListaPredosatoriRic(predosatore).statoprecedente) Or (ListaPredosatoriRic(predosatore).setPrecedente <> ListaPredosatoriRic(predosatore).SetTonH) Then
        If (ListaPredosatoriRic(predosatore).setPrecedente <> ListaPredosatoriRic(predosatore).SetTonH) Then
            variazionepred = True
        End If
        'ListaPredosatoriRic(predosatore).statoprecedente = ListaPredosatoriRic(predosatore).stato
        ListaPredosatoriRic(predosatore).setPrecedente = ListaPredosatoriRic(predosatore).SetTonH
    Next predosatore
    
    If variazionepred Then
        Call GestioneStoricoPredosaggio
    End If
    '
           
'    '20140328
'    Call GestioneStoricoPredosaggio
'    '

    If (AlmenoUnoPredosatoreAcceso <> AlmenoUnoAccesoPredVergini Or AlmenoUnoAccesoPredRiciclatoCaldo Or AlmenoUnoAccesoPredRiciclatoFreddo) Then
        AlmenoUnoPredosatoreAcceso = AlmenoUnoAccesoPredVergini Or AlmenoUnoAccesoPredRiciclatoCaldo Or AlmenoUnoAccesoPredRiciclatoFreddo

        Call SendMessagetoPlus(PlusSendFeederInStart, IIf(AlmenoUnoPredosatoreAcceso, 1, 0))
    End If
    
    '20150619
    If ((MemAlmenoUnoAccesoPredVergini Xor AlmenoUnoAccesoPredVergini) Or (MemAlmenoUnoAccesoPredRiciclatoCaldo Xor AlmenoUnoAccesoPredRiciclatoCaldo) Or (MemAlmenoUnoAccesoPredRiciclatoFreddo Xor AlmenoUnoAccesoPredRiciclatoFreddo)) Then
        CP240.AbilitaCalibrazione
    End If
    MemAlmenoUnoAccesoPredVergini = AlmenoUnoAccesoPredVergini
    MemAlmenoUnoAccesoPredRiciclatoCaldo = AlmenoUnoAccesoPredRiciclatoCaldo
    MemAlmenoUnoAccesoPredRiciclatoFreddo = AlmenoUnoAccesoPredRiciclatoFreddo
    'fine '20150618
End Sub


Public Sub PredosatoreManuale(riciclato As Boolean, predosatore As Integer, start As Boolean, forza As Boolean)

    If (riciclato) Then

        If (predosatore >= MAXPREDOSATORIRICICLATO) Then
            Exit Sub
        End If

        ListaPredosatoriRic(predosatore).start = start

        Call PredosatoreVerificaSet(ListaPredosatoriRic(predosatore), forza)

    Else

        If (predosatore >= MAXPREDOSATORI) Then
            Exit Sub
        End If

        ListaPredosatori(predosatore).start = start

        Call PredosatoreVerificaSet(ListaPredosatori(predosatore), forza)

    End If

End Sub


Private Sub PredosatoreAutomatico(Pred As PredosatoreType, start As Boolean)

    With Pred

        If (Not AutomaticoPredosatori) Then
            .codaSetLivello = 0
        End If

        .start = start

        Call PredosatoreVerificaSet(Pred, False)

    End With

End Sub


'   Setta i predosatori in automatico ed in start (o stop)
Public Sub PredosatoriInStartAutomatico(start As Boolean)

    Dim Index As Integer
    Dim predosatore As Integer
    Dim nomeTr As String
    'Dim contenuto As String

    On Error GoTo Errore

    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        PredosatoreAutomatico ListaPredosatori(predosatore), start
    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        PredosatoreAutomatico ListaPredosatoriRic(predosatore), start
    Next predosatore

    PredosatoriAutomaticoOn = start

    Call CP240StatusBar_Change(STB_PREDOSAGGIO, PredosatoriAutomaticoOn) '20161020

    Exit Sub
Errore:
    LogInserisci True, "F51", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'   Setta i predosatori in manuale
Public Sub PredosatoriInManuale()

    Dim predosatore As Integer

    PredosatoriInStartAutomatico False

    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        PredosatoreManuale False, predosatore, False, False
    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        PredosatoreManuale True, predosatore, False, False
    Next predosatore

    Call CP240StatusBar_Change(STB_PREDOSAGGIO, PredosatoriAutomaticoOn) '20161020

End Sub


'   Ricalcola il set di uscita dei predosatori
Public Sub PredosatoriRicalcolaSet()

    Dim predosatore As Integer

    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        PredosatoreUscitaAnalogica _
            ListaPredosatori(predosatore), _
            ListaPredosatori(predosatore).setAttuale.set
    Next predosatore

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        'per il riciclato, se non ho disattivato i tempi di ritardo, e' meglio cambiare la velocita' dopo il tempo da ricetta invece che immediatamente
        If PredosatoriImmediati Then
            'cambio immediato
            PredosatoreUscitaAnalogica _
                ListaPredosatoriRic(predosatore), _
                ListaPredosatoriRic(predosatore).setAttuale.set
        Else
            'cambio ritardato
            PredosatoreProssimoSet ListaPredosatoriRic(predosatore), False
        End If
    Next predosatore

    Call DatiSetPredosaggi 'PREPARAZIONE DEI DATI DI SET DA SPEDIRE AL PLC.

End Sub


Private Sub PredosatoriVerificaAllarme()

    Dim secondi As Long

    If (AllarmiPredosatori And OraAllarmePredosatori <> 0) Then

        secondi = ConvertiTimer() - OraAllarmePredosatori
    
        CP240.LblMessaggioBruciatore(2).caption = TempoPermanenzaAllarmePredosatori - secondi
        CP240.LblMessaggioBruciatore(5).caption = TempoPermanenzaAllarmePredosatori - secondi

        If (Not PredosatoreVergineVuoto And Not PredosatoreRiciclatoVuoto And Not TermicaPredosatori) Then
            OraAllarmePredosatori = 0
            AllarmeTemporaneoGiaVisualizzato(97) = False

            CP240.Frame1(58).Visible = False
            CP240.Frame1(59).Visible = False
        End If

        If (secondi >= TempoPermanenzaAllarmePredosatori) Then
            Call PredosatoriArrestoImmediato(False, -1)
            Call PredosatoriArrestoImmediato(True, -1)
            '
            OraAllarmePredosatori = 0
            AllarmeTemporaneoGiaVisualizzato(97) = False

            CP240.Frame1(58).Visible = False
            CP240.Frame1(59).Visible = False
        End If
        
    End If

End Sub

Public Function PredosatoriAccesi(riciclato As Boolean, nastro As Integer) As Boolean

    Dim predosatore As Integer


    PredosatoriAccesi = True

    If (riciclato) Then
        'RICICLATI

        Select Case nastro
            Case -1
                For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                    If (ListaPredosatoriRic(predosatore).motore.uscita) Then
                        Exit Function
                    End If
                Next predosatore

            Case 0
                If (ListaMotori(MotoreNastroTrasportatoreRiciclato).presente Or ListaMotori(MotoreNastroCollettoreRiciclato).presente) Then
                    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
                        If (ListaPredosatoriRic(PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoCaldo) + predosatore).motore.uscita) Then
                            Exit Function
                        End If
                    Next predosatore
                End If

            Case 1
                If (ListaMotori(MotoreElevatoreRiciclato).presente Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente) Then
                    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1
                        If (ListaPredosatoriRic(PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoFreddo) + predosatore).motore.uscita) Then
                            Exit Function
                        End If
                    Next predosatore
                End If

            Case 2
                If (ListaMotori(MotoreNastroRapJolly).presente) Then
                    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoJolly) - 1
                        If (ListaPredosatoriRic(PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoJolly) + predosatore).motore.uscita) Then
                            Exit Function
                        End If
                    Next predosatore
                End If
        End Select

    Else
        'VERGINI (averne...)

        Select Case nastro
            Case -1
                For predosatore = 0 To NumeroPredosatoriInseriti - 1
                    If (ListaPredosatori(predosatore).motore.uscita) Then
                        Exit Function
                    End If
                Next predosatore

            Case 0
                For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1
                    If (ListaPredosatori(PrimoPredosatoreDelNastro(NastriPredosatori.Collettore1) + predosatore).motore.uscita) Then
                        Exit Function
                    End If
                Next predosatore

            Case 1
                If (ListaMotori(MotoreNastroCollettore2).presente) Then
                    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1
                        If (ListaPredosatori(PrimoPredosatoreDelNastro(NastriPredosatori.Collettore2) + predosatore).motore.uscita) Then
                            Exit Function
                        End If
                    Next predosatore
                End If

            Case 2
                If (ListaMotori(MotoreNastroCollettore3).presente) Then
                    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) - 1
                        If (ListaPredosatori(PrimoPredosatoreDelNastro(NastriPredosatori.Collettore3) + predosatore).motore.uscita) Then
                            Exit Function
                        End If
                    Next predosatore
                End If
            '
        End Select

    End If

    PredosatoriAccesi = False

End Function

'La routine è invocata sul passaggio in manuale, su allarmi dei predosatori e su stop del bruciatore/tamburo
'La routine arresta immediatamente una linea di predosaggio
Public Sub PredosatoriArrestoImmediato(riciclato As Boolean, nastro As Integer)

    Dim predosatore As Integer
    Dim predRelativo As Integer
    Dim almenoUnoAcceso As Boolean


    'Arresto immediato dei predosatori.

    If (riciclato) Then

        Select Case nastro

            Case -1
                For predRelativo = 0 To NumeroPredosatoriRicInseriti - 1
                    predosatore = predRelativo
                    If (ListaPredosatoriRic(predosatore).motore.uscita) Then
                        almenoUnoAcceso = True
                    End If
                    Call PredosatoreManuale(True, predosatore, False, True)
                Next predRelativo

            Case 0
                If (ListaMotori(MotoreNastroTrasportatoreRiciclato).presente Or ListaMotori(MotoreNastroCollettoreRiciclato).presente) Then
                    If ListaMotori(MotoreNastroRapJolly).presente Then
                        If Not NastroRapJollyVersoFreddo Then
                            For predRelativo = PrimoPredosatoreDelNastro(RiciclatoJolly) To NumeroPredosatoriRicInseriti - 1
                                If ListaPredosatoriRic(predRelativo).SuNastroJolly Then
                                    If (ListaPredosatoriRic(predRelativo).motore.uscita) Then
                                        almenoUnoAcceso = True
                                        Call PredosatoreManuale(True, predRelativo, False, True)
                                    End If
                                End If
                            Next predRelativo
                        End If
                    Else
                        For predRelativo = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
                            predosatore = PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoCaldo) + predRelativo
                            If (ListaPredosatoriRic(predosatore).motore.uscita) Then
                                almenoUnoAcceso = True
                            End If
                            Call PredosatoreManuale(True, predosatore, False, True)
                        Next predRelativo
                    End If
                End If

            Case 1
                If (ListaMotori(MotoreElevatoreRiciclato).presente Or ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente) Then
                    If ListaMotori(MotoreNastroRapJolly).presente Then
                        If NastroRapJollyVersoFreddo Then
                            For predRelativo = PrimoPredosatoreDelNastro(RiciclatoJolly) To NumeroPredosatoriRicInseriti - 1
                                If ListaPredosatoriRic(predRelativo).SuNastroJolly Then
                                    If (ListaPredosatoriRic(predRelativo).motore.uscita) Then
                                        almenoUnoAcceso = True
                                        Call PredosatoreManuale(True, predRelativo, False, True)
                                    End If
                                End If
                            Next predRelativo
                        End If
                        For predRelativo = PrimoPredosatoreDelNastro(RiciclatoFreddo) To PrimoPredosatoreDelNastro(RiciclatoJolly) - 1
                            If (ListaPredosatoriRic(predRelativo).motore.uscita) Then
                                almenoUnoAcceso = True
                            End If
                            Call PredosatoreManuale(True, predRelativo, False, True)
                        Next predRelativo
                    Else
                        For predRelativo = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1
                            predosatore = PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoFreddo) + predRelativo
                            If (ListaPredosatoriRic(predosatore).motore.uscita) Then
                                almenoUnoAcceso = True
                            End If
                            Call PredosatoreManuale(True, predosatore, False, True)
                        Next predRelativo
                    End If
                End If

            Case 2
                If (ListaMotori(MotoreNastroRapJolly).presente) Then
                    For predRelativo = PrimoPredosatoreDelNastro(RiciclatoJolly) To NumeroPredosatoriRicInseriti - 1
                        If ListaPredosatoriRic(predRelativo).SuNastroJolly Then
                            If (ListaPredosatoriRic(predRelativo).motore.uscita) Then
                                almenoUnoAcceso = True
                            End If
                            Call PredosatoreManuale(True, predRelativo, False, True)
                        End If
                    Next predRelativo
                End If

        End Select

    Else

        Select Case nastro

            Case -1

                For predRelativo = 0 To NumeroPredosatoriInseriti - 1
                    predosatore = predRelativo
                    If (ListaPredosatori(predosatore).motore.uscita) Then
                        almenoUnoAcceso = True
                    End If
                    Call PredosatoreManuale(False, predosatore, False, True)
                Next predRelativo

            Case 0
                For predRelativo = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1
                    predosatore = PrimoPredosatoreDelNastro(NastriPredosatori.Collettore1) + predRelativo
                    If (ListaPredosatori(predosatore).motore.uscita) Then
                        almenoUnoAcceso = True
                    End If
                    Call PredosatoreManuale(False, predosatore, False, True)
                Next predRelativo

            Case 1
                If (ListaMotori(MotoreNastroCollettore2).presente) Then
                    For predRelativo = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1
                        predosatore = PrimoPredosatoreDelNastro(NastriPredosatori.Collettore2) + predRelativo
                        If (ListaPredosatori(predosatore).motore.uscita) Then
                            almenoUnoAcceso = True
                        End If
                        Call PredosatoreManuale(False, predosatore, False, True)
                    Next predRelativo
                End If

            Case 2
                If (ListaMotori(MotoreNastroCollettore3).presente) Then
                    For predRelativo = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) - 1
                        predosatore = PrimoPredosatoreDelNastro(NastriPredosatori.Collettore3) + predRelativo
                        If (ListaPredosatori(predosatore).motore.uscita) Then
                            almenoUnoAcceso = True
                        End If
                        Call PredosatoreManuale(False, predosatore, False, True)
                    Next predRelativo
                End If

        End Select

    End If

    If (AutomaticoPredosatori And almenoUnoAcceso) Then
        Call PassaInManualePredosatori
    End If

End Sub


Public Sub VisualizzaRiduzioneProduzione()

    CP240.TxtImpastoRidotto(2).text = CStr(TonOrarieAttualiImpianto)
    CP240.TxtImpastoRidotto(2).Visible = AutomaticoPredosatori
    CP240.LblEtichetta(23).Visible = AutomaticoPredosatori

End Sub

Public Sub SetRiduzioneProduzione(nuovaRiduzione As Integer)
    
    If (RiduzioneProduzione <> nuovaRiduzione) Then

        If (nuovaRiduzione < 30) Then
            CP240.LblProdPredos.caption = "30"
            Exit Sub
        End If

        If (nuovaRiduzione > 100) Then
            CP240.LblProdPredos.caption = "100"
            Exit Sub
        End If

        RiduzioneProduzione = nuovaRiduzione
        TonOrarieAttualiImpianto = (CLng(TonOrarieImpianto) * CLng(RiduzioneProduzione)) / 100
        
        CP240.LblProdPredos.caption = CStr(RiduzioneProduzione)

        Call VisualizzaRiduzioneProduzione
        If AutomaticoPredosatori Then
            Call PredosatoriRicalcolaSet
        End If

    End If

End Sub
Public Function CalcolaSetNastri(Index As Integer) As Double
    
    Dim totaleSetPercentualeInerti
    Dim totaleSetPercentualeRiciclato1 As Double
    Dim totaleSetPercentualeRiciclato2 As Double
    
    Dim i As Integer
    Select Case Index
        Case 0
            'calcolo il set totale della linea del riciclato del tamburo 1
            If ParallelDrum Then
                For i = 0 To PrimoPredosatoreDelNastro(RiciclatoFreddo) - 1
                    totaleSetPercentualeRiciclato1 = totaleSetPercentualeRiciclato1 + PredosatoreOttieniSet(True, i)
                Next
            Else
                For i = 0 To NumeroPredosatoriRicInseriti - 1
                    totaleSetPercentualeRiciclato1 = totaleSetPercentualeRiciclato1 + PredosatoreOttieniSet(True, i)
                Next
            End If
            
            CalcolaSetNastri = totaleSetPercentualeRiciclato1 / 100
        Case 1
            'calcolo il set totale della linea del riciclato del tamburo 2
            If ParallelDrum Then
                For i = PrimoPredosatoreDelNastro(RiciclatoFreddo) To NumeroPredosatoriRicInseriti - 1
                    totaleSetPercentualeRiciclato2 = totaleSetPercentualeRiciclato2 + PredosatoreOttieniSet(True, i)
                Next
            End If
            
            CalcolaSetNastri = totaleSetPercentualeRiciclato2 / 100
        Case 2
            'calcolo il set totale della linea degli inerti
            For i = 0 To NumeroPredosatoriInseriti - 1
                totaleSetPercentualeInerti = totaleSetPercentualeInerti + PredosatoreOttieniSet(False, i)
            Next i
            
            CalcolaSetNastri = totaleSetPercentualeInerti / 100
            
    End Select
        
End Function


Public Function PredosatoreOttieniMaterialeLogId(ByRef Pred As PredosatoreType) As Long

    PredosatoreOttieniMaterialeLogId = 0

    With Pred
        If (.riciclato) Then
            If (.progressivo >= NumeroPredosatoriRicInseriti) Then
                Exit Function
            End If
        Else
            If (.progressivo >= NumeroPredosatoriInseriti) Then
                Exit Function
            End If
        End If

        PredosatoreOttieniMaterialeLogId = .Grafico.curva(.Grafico.curvaAttiva).IdMaterialeLog
    End With

End Function

Public Function PredosatoreOttieniNome(ByRef Pred As PredosatoreType) As String

    With Pred
        PredosatoreOttieniNome = .Grafico.curva(.Grafico.curvaAttiva).Nome
    End With

End Function


Public Function PredosatoreOttieniPortata(ByRef Pred As PredosatoreType) As Integer

    With Pred
    
        PredosatoreOttieniPortata = CInt(IIf(.bilanciaPresente, .portataBilancia, .portataTeorica))

    End With

End Function


Private Sub GestioneStoricoPredosaggioAggiungiPred(ByRef rs As adodb.Recordset)
            
    'Dim rsIdPred As New ADODB.Recordset
    'Dim indice As Integer
    
               
    With rs
        ![BruciatoreOn] = ListaTamburi(0).FiammaBruciatorePresente              '[bit]
        ![PortataP1] = PredosatoreOttieniPortata(ListaPredosatori(0))           '[smallint]
        ![CurvaP1] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(0))      '[int]
        ![PortataP2] = PredosatoreOttieniPortata(ListaPredosatori(1))           '[smallint]
        ![CurvaP2] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(1))      '[int]
        ![PortataP3] = PredosatoreOttieniPortata(ListaPredosatori(2))           '[smallint]
        ![CurvaP3] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(2))      '[int]
        ![PortataP4] = PredosatoreOttieniPortata(ListaPredosatori(3))           '[smallint]
        ![CurvaP4] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(3))      '[int]
        ![PortataP5] = PredosatoreOttieniPortata(ListaPredosatori(4))           '[smallint]
        ![CurvaP5] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(4))      '[int]
        ![PortataP6] = PredosatoreOttieniPortata(ListaPredosatori(5))           '[smallint]
        ![CurvaP6] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(5))      '[int]
        ![PortataP7] = PredosatoreOttieniPortata(ListaPredosatori(6))           '[smallint]
        ![CurvaP7] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(6))      '[int]
        ![PortataP8] = PredosatoreOttieniPortata(ListaPredosatori(7))           '[smallint]
        ![CurvaP8] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(7))      '[int]
        ![PortataP9] = PredosatoreOttieniPortata(ListaPredosatori(8))           '[smallint]
        ![CurvaP9] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(8))      '[int]
        ![PortataP10] = PredosatoreOttieniPortata(ListaPredosatori(9))          '[smallint]
        ![CurvaP10] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(9))     '[int]
        ![PortataP11] = PredosatoreOttieniPortata(ListaPredosatori(10))         '[smallint]
        ![CurvaP11] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(10))    '[int]
        ![PortataP12] = PredosatoreOttieniPortata(ListaPredosatori(11))         '[smallint]
        ![CurvaP12] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(11))    '[int]
        ![PortataP13] = PredosatoreOttieniPortata(ListaPredosatori(12))         '[smallint]     '20151118 (epsansione vergini)
        ![CurvaP13] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(12))    '[int]          '20151118 (epsansione vergini)
        ![PortataP14] = PredosatoreOttieniPortata(ListaPredosatori(13))         '[smallint]     '20151118 (epsansione vergini)
        ![CurvaP14] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(13))    '[int]          '20151118 (epsansione vergini)
        ![PortataP15] = PredosatoreOttieniPortata(ListaPredosatori(14))         '[smallint]     '20151118 (epsansione vergini)
        ![CurvaP15] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(14))    '[int]          '20151118 (epsansione vergini)
        ![PortataP16] = PredosatoreOttieniPortata(ListaPredosatori(15))         '[smallint]     '20151118 (epsansione vergini)
        ![CurvaP16] = PredosatoreOttieniMaterialeLogId(ListaPredosatori(15))    '[int]          '20151118 (epsansione vergini)
        ![PortataR1] = PredosatoreOttieniPortata(ListaPredosatoriRic(0))        '[smallint]
        ![CurvaR1] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(0))   '[int]
        ![PortataR2] = PredosatoreOttieniPortata(ListaPredosatoriRic(1))        '[smallint]
        ![CurvaR2] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(1))   '[int]
        ![PortataR3] = PredosatoreOttieniPortata(ListaPredosatoriRic(2))        '[smallint]
        ![CurvaR3] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(2))   '[int]
        ![PortataR4] = PredosatoreOttieniPortata(ListaPredosatoriRic(3))        '[smallint]
        ![CurvaR4] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(3))   '[int]
        ![PortataR5] = PredosatoreOttieniPortata(ListaPredosatoriRic(4))        '[smallint]
        ![CurvaR5] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(4))   '[int]
        ![PortataR6] = PredosatoreOttieniPortata(ListaPredosatoriRic(5))        '[smallint]
        ![CurvaR6] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(5))   '[int]
        ![PortataR7] = PredosatoreOttieniPortata(ListaPredosatoriRic(6))        '[smallint]
        ![CurvaR7] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(6))   '[int]
        ![PortataR8] = PredosatoreOttieniPortata(ListaPredosatoriRic(7))        '[smallint]
        ![CurvaR8] = PredosatoreOttieniMaterialeLogId(ListaPredosatoriRic(7))   '[int]
        ![PortataNVergini] = CInt(PesoBilanciaInerti)                            '[smallint]
        ![PortataNRicCaldo] = CInt(PesoBilanciaRiciclato)                        '[smallint]
        ![PortataNRicFreddo] = CInt(PesoBilanciaRiciclatoParDrum)                '[smallint]

    End With
End Sub

Private Sub GestioneStoricoPredosaggioAggiungiTorre(ByRef rs As adodb.Recordset)
    With rs
        ![DeflettoreVaglio] = DeflettoreSuVagliato  '[bit]
        ![LivelloTramoggia1] = LivelloTramoggia(0)  '[smallint]
        ![LivelloTramoggia2] = LivelloTramoggia(1)  '[smallint]
        ![LivelloTramoggia3] = LivelloTramoggia(2)  '[smallint]
        ![LivelloTramoggia4] = LivelloTramoggia(3)  '[smallint]
        ![LivelloTramoggia5] = LivelloTramoggia(4)  '[smallint]
        ![LivelloTramoggia6] = LivelloTramoggia(5)  '[smallint]
        ![LivelloTramoggia7] = LivelloTramoggia(18) '[smallint]
        ![LivelloNV] = LivelloTramoggia(7)          '[smallint]
    End With
End Sub


Public Sub GestioneStoricoPredosaggioAggiungi()

    Dim adesso As Date
    Dim alreadyExist As Boolean
    Dim rs As New adodb.Recordset
    Dim rstStorico As New adodb.Recordset

    adesso = DateTime.Now

    'Verifico se ho già inserito un record con data-ora corrente
    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT * FROM StoricoPredosaggio WHERE DataOra = CONVERT(DATETIME, '" & Format(adesso, "yyyy-mm-dd hh:nn:ss") & "', 102)"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon

        If (Not .BOF And Not .EOF And Not IsNull(rs!GroupId)) Then
            StoricoPredosaggioGroupID = rs!GroupId
            alreadyExist = True
        Else
            .Close
        End If
    End With

    If (alreadyExist) Then
        With rs
            Call GestioneStoricoPredosaggioAggiungiPred(rs)

            .Update
            .Close
        End With

        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * FROM StoricoPredosaggioTorre WHERE DataOra = CONVERT(DATETIME, '" & Format(adesso, "yyyy-mm-dd hh:nn:ss") & "', 102)"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
    
            Call GestioneStoricoPredosaggioAggiungiTorre(rs)

            .Update
            .Close
        End With
    Else
        If (StoricoPredosaggioGroupID = 0) Then
            'Ottengo il numero massimo di ID
            With rs
                Set .ActiveConnection = DBcon
                .Source = "SELECT Max([GroupId]) AS [MaxGroupId] FROM StoricoPredosaggio;"
                .LockType = adLockOptimistic
                .CursorLocation = adUseClient
                .CursorType = adOpenStatic
                .Open , DBcon
            End With
        
            If IsNull(rs!MaxGroupId) Then
                StoricoPredosaggioGroupID = 1
            Else
                StoricoPredosaggioGroupID = rs!MaxGroupId + 1
            End If
    
            rs.Close
        End If

        'Devo risalire al IdPredosaggioLOG della ricetta in uso
        Dim IdPredLOG As String
        If (Not CP240.AdoPredosaggio.Recordset.EOF) Then
            With rs
                Set .ActiveConnection = DBcon
                
                    .Source = "SELECT Max([IdPredosaggioLOG]) AS [RecipeIdLOG] FROM PredosaggioLOG WHERE [IdPredosaggio] =" & val(CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio").Value) & ";"
                
                .LockType = adLockOptimistic
                .CursorLocation = adUseClient
                .CursorType = adOpenStatic
                .Open , DBcon
            End With
            IdPredLOG = rs!RecipeIdLOG
            rs.Close
        End If


        With rstStorico
            Set .ActiveConnection = DBcon
            .Source = "SELECT TOP 10 * FROM StoricoPredosaggio"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
    
            .AddNew
    
            ![GroupId] = StoricoPredosaggioGroupID                              '[int]
            ![DataOra] = adesso                                                 '[datetime]
            ![IdPredosaggioLOG] = IIf(StartPredosatori And PredosatoriAutomaticoOn, IdPredLOG, 0)  '[int]

            Call GestioneStoricoPredosaggioAggiungiPred(rstStorico)

            .Update
            .Close
        End With
    
        With rstStorico
            Set .ActiveConnection = DBcon
            .Source = "SELECT TOP 10 * FROM StoricoPredosaggioTorre"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon

            .AddNew

            'NO!? ![GroupId] = StoricoPredosaggioGroupID      '[int]
            ![DataOra] = adesso                         '[datetime]
            If Not CP240.AdoDosaggio.Recordset.EOF Then
                ![IdDosaggioLOG] = IIf(DosaggioInCorso, CP240.AdoDosaggio.Recordset.Fields("IdLOG").Value, 0) '[int]
            End If

            Call GestioneStoricoPredosaggioAggiungiTorre(rstStorico)

            .Update
            .Close
        End With
    End If

    StoricoPredosaggioTm = ConvertiTimer()

End Sub

'20160803 La chiamata diventa ad evento
'20140328
Public Sub GestioneStoricoPredosaggio()

    'Chiamata a LOOP

    If (Not AlmenoUnoAccesoPredVergini And Not AlmenoUnoAccesoPredRiciclatoFreddo And Not AlmenoUnoAccesoPredRiciclatoCaldo) Then
        StoricoPredosaggioGroupID = 0
        Exit Sub
    End If

'    If (ConvertiTimer() < StoricoPredosaggioTm + 30) Then
'        'Gestione ad 1 minuto
'        Exit Sub
'    End If
'
    Call GestioneStoricoPredosaggioAggiungi

End Sub

'20160405
Public Sub ChkResetColorMateriali()
    Dim Index As Integer
    For Index = 1 To MAXPREDOSATORI
        If (CP240.LblPredNome(Index - 1).Visible) Then
            CP240.LblPredNome(Index - 1).ForeColor = vbWhite
        End If
    Next Index
    For Index = 1 To MAXPREDOSATORIRICICLATO
        If (CP240.LblPredRicNome(Index - 1).Visible) Then
            CP240.LblPredRicNome(Index - 1).ForeColor = vbWhite
        End If
    Next Index
End Sub
'20160405
Public Function ChkCoherenceMaterial(IdPredosaggio)
    Dim rs As New adodb.Recordset
    Dim rownumber As Integer
    Dim Index As Integer
    On Error GoTo Errore
        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT * FROM [CYB500].[dbo].[Predosaggio] JOIN [CYB500].[dbo].PredosaggioLOG ON [CYB500].[dbo].[Predosaggio].IdPredosaggio = [CYB500].[dbo].PredosaggioLOG.IdPredosaggio WHERE [CYB500].[dbo].[Predosaggio].IdPredosaggio ='" & CStr(IdPredosaggio) & "' ORDER BY IdPredosaggioLOG desc;"
            .LockType = adLockReadOnly
            .CursorLocation = adUseClient
            .CursorType = adOpenForwardOnly
            .Open , DBcon
            'Query che restituisce più righe solo se la ricetta è stata modificata; in ogni caso riordina le righe in maniera discendente su IdPredosaggioLOG
            'in maniera che la prima riga sia sempre la più recente
            If Not .BOF Then 'verifica se la tabella non e' vuota
                .MoveFirst
                rownumber = 0
                Do Until .EOF
                    rownumber = rownumber + 1
                    'Verifica coerenza Materiale Ricetta con Materiale della Curva Attiva del Predosatore per i Predosatori in Ricetta
                    If (rownumber = 1) Then
                        Call ChkResetColorMateriali
                        For Index = 1 To MAXPREDOSATORI
                            If String2Double(.Fields("SetPredosatore" + CStr(Index))) > 0 Then
                                CP240.LblPredNome(Index - 1).ToolTipText = .Fields("MaterialeP" + CStr(Index))
                                If Not (.Fields("MaterialeP" + CStr(Index)) = ListaPredosatori(Index - 1).Grafico.curva(ListaPredosatori(Index - 1).Grafico.curvaAttiva).Nome) Then
                                    CP240.LblPredNome(Index - 1).ForeColor = vbRed
                                End If
                            End If
                        Next Index
                        For Index = 1 To MAXPREDOSATORIRICICLATO
                            If String2Double(.Fields("SetPredosatoreRic" + CStr(Index))) > 0 Then
                                CP240.LblPredRicNome(Index - 1).ToolTipText = .Fields("MaterialeR" + CStr(Index))
                                If Not (.Fields("MaterialeR" + CStr(Index)) = ListaPredosatoriRic(Index - 1).Grafico.curva(ListaPredosatoriRic(Index - 1).Grafico.curvaAttiva).Nome) Then
                                    CP240.LblPredRicNome(Index - 1).ForeColor = vbRed
                                End If
                            End If
                        Next Index
                    End If
                    .MoveNext
                Loop
            End If
            .Close
        End With
        Exit Function
Errore:
    rs.Close
    LogInserisci True, "ChkCoherenceMaterial", CStr(Err.Number) + " [" + Err.description + "]"
End Function

Public Sub SelectFeederRecipeByCS(IdRecipe As Long)
        
    Dim found As Boolean
    Dim rs As New adodb.Recordset
    
    On Error GoTo Errore
    
    found = False

    If (IdRecipe > 0) Then

        If (Not feederRecipeListAlreadyDone) Then
            Call RinfrescaNomeRicPreDosaggio
            feederRecipeListAlreadyDone = True
        End If

        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT IdPredosaggio,Descrizione FROM Predosaggio WHERE IdPredosaggio='" & CStr(IdRecipe) & "';"
            .LockType = adLockReadOnly
            .CursorLocation = adUseClient
            .CursorType = adOpenForwardOnly
            .Open , DBcon
        
            If Not .BOF And Not .EOF Then
                CP240.adoComboPredosaggio.text = .Fields("Descrizione").Value
            End If
        
            .Close
        
        End With
        
    End If
        
    Exit Sub

Errore:
    rs.Close
    LogInserisci True, "SelectFeederRecipeByCS", CStr(Err.Number) + " [" + Err.description + "]"

End Sub
'

Public Function ControlloCondizioniStartPreDosaggio() As Boolean

    Dim SoloRiciclatoFreddo As Boolean
    Dim predosatore As Integer
    Dim messaggioerrore As String
    Dim ricettaconjolly As Boolean
    Dim inversione As Boolean
    Dim i As Integer
    Dim controllierr As Boolean

    ControlloCondizioniStartPreDosaggio = False

    'controlla che sia selezionata una ricetta altrimenti esco
    If (ControllaRicettaPredVuota) Then
        Exit Function
    End If

    SoloRiciclatoFreddo = True
    
    EsclusioneMessaggioAllarmeTemperaturaBassaFiltro = False


    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        If ListaPredosatori(predosatore).setAttuale.set > 0 Then
            SoloRiciclatoFreddo = False
            Exit For
        End If
    Next predosatore

    '20161212 coi Motori in Man la direzione del Jolly deve essere coerente con la ricetta
    If (MotorManagement = MotorManagementEnum.SemiAutomaticMotor) Then
        If CP240.adoComboPredosaggio.text <> "" Then
            If (Not CP240.AdoPredosaggio.Recordset.EOF) Then
                If NumeroPredosatoriRicInseriti > 0 Then
                    
                    ricettaconjolly = False
                    For i = 1 To NumeroPredosatoriRicInseriti
                        If (CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic" + CStr(i)).Value) > 0) And (ListaPredosatoriRic(i - 1).SuNastroJolly) Then
                            'La ricetta è con Predosatore su Jolly
                            ricettaconjolly = True
                        End If
                    Next i
                    'Se la ricetta è con Predosatore su Jolly il nastro deve essere fermo o girare nella direzione giusta
                    If (ricettaconjolly) Then
                        inversione = CBool(CP240.AdoPredosaggio.Recordset.Fields("InversioneRic1").Value)
                        NastroRapJollyVersoFreddo = inversione
                    ElseIf (ricettaconjolly) Then
                        NastroRapJollyVersoFreddo = inversione
                    Else
                        NastroRapJollyVersoFreddo = False
                    End If
                End If
             End If
        End If
    End If


    'presenza valvola tubo troppo pieno
    'presenza scambiatore F1/F2
    If AbilitaTuboTroppoPienoF1 And GestioneScambioTuboTroppoPieno = ScambioF1F2 _
            And (LivelloMaxSiloFiller(1) And ScambioTuboTroppoPienoF1F2) Or (LivelloMaxSiloFiller(2) And Not ScambioTuboTroppoPienoF1F2) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1439)
    'presenza scambiatore F2/F3
    ElseIf AbilitaTuboTroppoPienoF1 And (GestioneScambioTuboTroppoPieno = ScambioF2F3) And (LivelloMaxSiloFiller(3) And ScambioTuboTroppoPienoF1F2) _
        Or (LivelloMaxSiloFiller(2) And Not ScambioTuboTroppoPienoF1F2) Then
            
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1439)
    
    ElseIf AbilitaTuboTroppoPienoF1 And (LivelloMaxSiloFiller(2)) Then     'tubo diretto su F2
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1439)
    
    ElseIf InclusioneDMR And PredosaggioArrestoLivelliTSF Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1439)
    '
    
    ElseIf Not SoloRiciclatoFreddo And ( _
            (ListaMotori(MotoreNastroElevatoreFreddo).presente And Not ListaMotori(MotoreNastroElevatoreFreddo).ritorno) Or _
            (ListaMotori(MotoreNastroLanciatore).presente And Not ListaMotori(MotoreNastroLanciatore).ritorno) _
        ) Then
            
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(187)
        
    ElseIf Not SoloRiciclatoFreddo And Not ListaMotori(MotoreRotazioneEssiccatore).ritorno Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(214)

    ElseIf _
        (Not ListaTamburi(0).FiammaBruciatorePresente And ((NumPredVergProssimoSet > 0) Or (NumPredRicCaldoProssimoSet > 0)) Or _
        (ParallelDrum And (Not ListaTamburi(1).FiammaBruciatorePresente And NumPredRicFreddoProssimoSet > 0))) And _
        Not AvvioPredosatoriSenzaBruciatore _
    Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(185)
    
    ElseIf Not SoloRiciclatoFreddo And (Not EsclusioneMessaggioAllarmeTemperaturaBassaFiltro) And Not AvvioPredosatoriSenzaBruciatore And _
                ListaTemperature(TempUscitaFiltro).valore < ValoreTempLavoroFiltro Then
                    
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(186)
        EsclusioneMessaggioAllarmeTemperaturaBassaFiltro = True
    
    'I predosatori possono partire solo se non c'è il blocco per alta temperatura
    ElseIf (BloccoSpruzzaturaAltaTemp) Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(193)

    'I predosatori non possono partire con nastro collettore fermo e gestione semiautomatica
    ElseIf (ControlloPredAutomatico(1) Or ControlloPredAutomatico(2) Or ControlloPredAutomatico(3)) And Not MotoriInAutomatico Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(161)
    
'20170209
'    ElseIf (MotorManagement = MotorManagementEnum.SemiAutomaticMotor) And (CP240.adoComboPredosaggio.text <> "") And (NumeroPredosatoriRicInseriti > 0) _
'        And (Not ((inversione And ListaMotori(MotoreNastroRapJolly).RitornoIndietro) Or (Not inversione And ListaMotori(MotoreNastroRapJolly).ritorno))) Then
        
    ElseIf (MotorManagement = MotorManagementEnum.SemiAutomaticMotor) And (CP240.adoComboPredosaggio.text <> "") And (NumeroPredosatoriRicInseriti > 0) _
            And (Not ((inversione And ListaMotori(MotoreNastroRapJolly).RitornoIndietro) Or (Not inversione And ListaMotori(MotoreNastroRapJolly).ritorno))) _
            And ListaMotori(MotoreNastroRapJolly).presente _
        Then
        
        controllierr = True
        AllarmeCicalino = True
        messaggioerrore = LoadXLSString(1538)
    
    End If

    
'    If (JobAttivo.StatusVB <> EnumStatoJobVB.Idle) Or (JobProssimo.StatusVB <> EnumStatoJobVB.Idle) Then
'        Call StopEmergenzaJob
'    End If

'    If messaggioerrore = "" And AllarmeCicalino Then
'        Debug.Print
'    End If
    

    If controllierr Then
        Call ShowMsgBox(messaggioerrore, vbOKOnly, vbExclamation, -1, -1, True)
        AllarmeCicalino = False
    Else
        ControlloCondizioniStartPreDosaggio = True
    End If
            
            
End Function

'20170111
Public Sub StartPreDosaggio()

    Dim predosatore As Integer

    '20170131
    If Not ControlloCondizioniStartPreDosaggio Then
        Exit Sub
    End If

    '20161212
'20151125
    CP240.OPCData.items(PLCTAG_NM_PRED_Auto_Man).Value = True
    Dim NumPred As Integer

    'Manuale -> automatico
    AutomaticoPredosatori = True

    If Not StartPredosatori Then
'20170110
'        PctPredosatoriWorking.Picture = LoadResPicture("IDI_WORKING", vbResIcon)    'IDI_PREDOSATORE
'
        Call CP240.AbilitaCalibrazione
    
        'Azzeramento dei predosatori in manuale.
        For NumPred = 0 To NumeroPredosatoriInseriti - 1
            Call PredosatoreManuale(False, NumPred, False, False)
        Next NumPred
        
        If NumeroPredosatoriRicInseriti <> 0 Then
            For NumPred = 0 To NumeroPredosatoriRicInseriti - 1
                Call PredosatoreManuale(True, NumPred, False, False)
            Next NumPred
        End If
    
        Call PreparazioneAvvPred
    
        Call VisualizzaRiduzioneProduzione
        OrarioPredAutoChange = ConvertiTimer()
    End If
'fine 20151125
    
    StartPredosatori = True
    StartPredosatori_change
    
    'rinfresco i dati di predosaggio
    If SelezioneRicettaPredosaggioCambiata Then
        abilitaRinfrescoDati_pred = True    '20161004
        Call RichiamoRicettaPredos
        If AutomaticoPredosatori Then
            Call DatiSetPredosaggi
        End If
    End If
       

    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set1).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore1").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set2).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore2").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set3).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore3").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set4).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore4").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set5).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore5").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set6).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore6").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set7).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore7").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set8).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore8").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set9).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore9").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set10).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore10").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set11).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore11").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set12).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore12").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set1).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic1").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set2).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic2").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set3).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic3").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set4).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic4").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set5).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic5").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set6).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic6").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set7).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic7").Value)
    CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Afreddo).Value = CInt(CP240.AdoPredosaggio.Recordset.Fields("InversioneRic1").Value)  '20161205
    
    
    CP240.OPCData.items(PLCTAG_NM_PRED_Start_Auto).Value = True
    attesastartplc = True
    

    Dim Criterio As String
    Dim posizione As Integer
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "VA002", "IdDescrizione")
    If AutomaticoPredosatori And Not MotoriInAutomatico Then
        IngressoAllarmePresente posizione, True
    Else
        IngressoAllarmePresente posizione, False
    End If

    For predosatore = 0 To MAXPREDOSATORI - 1
        Criterio = "PR0" & CStr(predosatore + 11)
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        IngressoAllarmePresente posizione, False
    Next predosatore

    For predosatore = 0 To MAXPREDOSATORIRICICLATO - 1
        Criterio = "PR0" + CStr(predosatore + 25)
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        IngressoAllarmePresente posizione, False
    Next predosatore

    '20160512
    If (AbilitaDeflettoreAnello) Then
        If (Not AbilitaDeflettoreAnelloElevatoreRic And Not ValvolaPreseparatoreAnello.abilitato) Then
            Call SetDeflettoreRiciclato(Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno))
        End If

        Call AggiornaDeflettoreRiciclato
    End If
    '

End Sub
