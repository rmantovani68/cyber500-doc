Attribute VB_Name = "GestioneRiciclato"
Option Explicit

Public AspiratoreFresatoFreddo As Boolean
Public RitornoAspFresatoFreddo As Boolean
Public ManualeAspFresatoFreddo As Boolean

Public NettoRAPSiwaBilancia As Double
Public NettoRAPBilancia As Double

Public AbilitaDeflettoreAnello As Boolean
Public DeflettoreRiciclatoComandoElevatore As Boolean   'Se True il deflettore va a elevatore (o rifiuti che sia)
Public DeflettoreRiciclatoFcAnello As Boolean
Public DeflettoreRiciclatoFcElevatore As Boolean        'O rifiuti

Public AbilitaModulatoreDeflettoreAnello As Boolean
Public ModulatoreDeflettoreAnelloInApertura As Boolean
Public ModulatoreDeflettoreAnelloInChiusura As Boolean
Public PosizioneModulatoreDeflettoreAnello As Integer
Public AbilitaNastroDeflettoreAnello As Boolean
Public NastroDeflettoreAnelloAcceso As Boolean
Public NastroDeflettoreAnelloSpento0 As Integer
Public DeflettoreMulinoEXT As Integer

Public NastroDeflettoreAnelloAccesoOld As Boolean

Public AbilitaDeflettoreAnelloElevatoreRic As Boolean

Public ComandoRifrantumazione As Boolean
Public OraStartRifrantumazione As Long
Public InclusioneRifrantumazione As Boolean
Public AttesaRitornoRifrantumazione As Integer
Public TermicaRifrantumazione As Boolean
Public RitornoRifrantumazione As Boolean
Public VaglioRiciclatoNastro As Boolean
Public VaglioRiciclatoPesata As Boolean
Public RiciclatoInTramoggia As Boolean
Public ValoreRicInTramoggia As Boolean
Public ValoreRicInEssicatore As Boolean
Public LivelloAltoTramoggiaRic As Boolean
Public LivelloBassoTramoggiaRic As Boolean
Public OraStopPredosatoreRic(8) As Long

Public AspFumiRAP_PARA_TempoApertura As Integer
Public OraStartAspirazioneFumiRAP As Long
Public OraStartRitardoAspirazioneFumiRAP As Long
Public OraStartDurataAspirazioneFumiRAP As Long
Public TempoSpegnimentoNastriRiciclatoCaldo As Long
Public TempoSpegnimentoNastriCollettori As Long
Public NastriRiciclatoCaldoTimeout As Long
Public NastriRiciclatoFreddoTimeout As Long

Public AspiratoreFresatoFreddo_OLD As Boolean

'Automatico/manuale del deflettore bypass tamburo ER
Public ManualeDeflettoreByPassTamburoParallelo As Boolean
'Deflettore bypass tamburo ER
Public DeflettoreByPassTamburoParalleloVersoNastro As Boolean
Public DeflettoreByPassTamburoParalleloFCTamburo As Boolean
Public DeflettoreByPassTamburoParalleloFCNastro As Boolean

Public OrarioPredAutoChange As Long
Public RitardoAllarmeVaglio As Long


'


Public Sub DatiSetPredRiciclato()

    TotaleUmiditaPredRic = PredosatoriRiciclatoCalcoloUmiditaTotale(0)
        
End Sub


Public Sub DatiSetPredRiciclatoParDrum()

    TotaleUmiditaPredRicParDrum = PredosatoriRiciclatoCalcoloUmiditaTotale(1)
    
End Sub

Public Sub AvviaElevatoreRiciclato()

    If PredosatoriRiciclatiAccesi And AutomaticoPredosatori Then
        'SE E' STATO SELEZIONATO IL RICICLATO IN TRAMOGGIA.
        If (AbilitaRAPSiwa And AbilitaRAP And PesaturaRiciclatoAggregato7) Then
            If (DosaggioRAPSiwa.set <> 0 Or DosaggioRAP.set <> 0) And RiciclatoInTramoggia Then
                Call SetMotoreUscita(MotoreElevatoreRiciclato, True)  '28       '<<-- TODO??
            End If
        End If
    End If
    
End Sub


Public Sub GestioneRiciclatoInTramoggia()

On Error GoTo Errore

    If (PesaturaRiciclatoAggregato7 Or AbilitaRAPSiwa Or AbilitaRAP) Then
        If (Not ValoreRicInTramoggia And ValoreRicInEssicatore) Then
            RiciclatoInTramoggia = False
        ElseIf (ValoreRicInTramoggia And Not ValoreRicInEssicatore) Then
            RiciclatoInTramoggia = True
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "RIC-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ControlloPosizioneDeflVaglio()
    Dim NumPred As Integer
    Dim appoggio As Integer
    Dim AllarmeFresatoVaglio As Boolean
    Dim Criterio As String
    Dim posizione As Integer

On Error GoTo Errore

    'Segnalo se ho il riciclato acceso con una ricetta vagliata
    If StartPredosatori Then 'Ho i predosatori in start automatico
        If NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) > 0 Then 'Ho il fresato caldo
            If ListaMotori(MotoreNastroRapJolly).presente And Not NastroRapJollyVersoFreddo Then
                For NumPred = PrimoPredosatoreDelNastro(RiciclatoJolly) To NumeroPredosatoriRicInseriti - 1
                    appoggio = appoggio + val(CP240.TxtPredRicSet(NumPred).text)
                Next NumPred
            End If
            For NumPred = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
                appoggio = appoggio + val(CP240.TxtPredRicSet(NumPred).text)
            Next NumPred

            'Se la Appoggio è > 0 ho il riciclato da ricetta e se VaglioIncluso è una ricetta dosaggio vagliata
            AllarmeFresatoVaglio = (appoggio > 0 And VaglioIncluso) And ((AbilitaDeflettoreAnelloElevatoreRic And DeflettoreRiciclatoFcAnello) Or Not AbilitaDeflettoreAnelloElevatoreRic)
        End If
    End If

    CP240.Image1(24).Visible = AllarmeFresatoVaglio
    Criterio = "DO003"
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
    IngressoAllarmePresente posizione, AllarmeFresatoVaglio

    
    'Segnala allarme se il deflettore è sul vaglio, l'elevatore caldo è in funzione ma è spento il vaglio
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "DO014", "IdDescrizione")
    
    If (VaglioIncluso And ListaMotori(MotoreElevatoreCaldo).ritorno And Not ListaMotori(MotoreVaglio).ritorno And ListaMotori(MotoreVaglio).presente) Then
        If RitardoAllarmeVaglio = 0 Then
            RitardoAllarmeVaglio = ConvertiTimer()
        End If
        IngressoAllarmePresente posizione, (ConvertiTimer() > (RitardoAllarmeVaglio + 5))
    Else
        RitardoAllarmeVaglio = 0
        IngressoAllarmePresente posizione, (False)
    End If
'

    Exit Sub
Errore:
    LogInserisci True, "RIC-009", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AspiraFumiFresatoFreddo_change(comando As Boolean)

    If (AspiratoreFresatoFreddo = comando) Then
        Exit Sub
    End If

    AspiratoreFresatoFreddo = comando

    If (AspiratoreFresatoFreddo) Then
    Else
        OraStartRitardoAspirazioneFumiRAP = 0
        OraStartDurataAspirazioneFumiRAP = 0
    End If

End Sub

Public Sub AspiraFumiFresatoFreddoContinuo()

    Dim riciclatoFreddoInserito As Boolean

    '20160301 F005
    'riciclatoFreddoInserito = ((DosaggioRAPSiwa.set > 0) Or (Not ParallelDrum And DosaggioRAP.set > 0) Or (DosaggioAggregati(6).set > 0))
    Dim setRiciclato As Double
    If (Not CP240.AdoDosaggioScarico.Recordset.EOF) Then
        If (AbilitaRAP) Then
            setRiciclato = setRiciclato + CP240.AdoDosaggioScarico.Recordset.Fields("RAP").Value
        End If
        If (AbilitaRAPSiwa) Then
            setRiciclato = setRiciclato + CP240.AdoDosaggioScarico.Recordset.Fields("RAPSiwa").Value
        End If
    End If
    riciclatoFreddoInserito = (setRiciclato > 0 Or DosaggioAggregati(6).set > 0)
    '
    
    If (DosaggioInCorso) Then
        ManualeAspFresatoFreddo = False
        Call AspiraFumiFresatoFreddo_change(riciclatoFreddoInserito)
    Else
        If (Not ManualeAspFresatoFreddo) Then
            Call AspiraFumiFresatoFreddo_change(False)
        End If
    End If

End Sub

Public Sub GestioneAspFresatoFreddo()

    Dim durata As Integer
    Dim ritardo As Integer
    Dim riciclatoFreddoInserito As Boolean
    Dim riciclatoFreddoInScarico As Boolean

On Error GoTo Errore

    If (Not AbilitaAspirazFumiRAP Or (AspFumiRAP_PARA_TempoApertura = 0)) Then
        Exit Sub
    End If

    If (RitornoAspFresatoFreddo And CP240.AniPButtonAspFresato.Value <> 2) Then
        'Aperta ok
        CP240.AniPButtonAspFresato.Value = 2
    End If
    If (Not RitornoAspFresatoFreddo And CP240.AniPButtonAspFresato.Value <> 1) Then
        'Rimasta chiusa
        CP240.AniPButtonAspFresato.Value = 1
    End If

    If AspiratoreFresatoFreddo <> AspiratoreFresatoFreddo_OLD Then
        AspiratoreFresatoFreddo_OLD = AspiratoreFresatoFreddo
        OraStartAspirazioneFumiRAP = ConvertiTimer()
    End If
     
    If (AspiratoreFresatoFreddo = RitornoAspFresatoFreddo) Then
        OraStartAspirazioneFumiRAP = 0
    End If
                                           
    If (AspiratoreFresatoFreddo <> RitornoAspFresatoFreddo) And (ConvertiTimer() > OraStartAspirazioneFumiRAP + AspFumiRAP_PARA_TempoApertura) Then
        'Debug.Print "Timer = " & ConvertiTimer()
        'Debug.Print OraStartAspirazioneFumiRAP + AspFumiRAP_PARA_TempoApertura

        Call AllarmeTemporaneo("XX100", True)
        Call AspiraFumiFresatoFreddo_change(False)
    End If
    
    CP240.AniPButtonAspFresato.enabled = (Not DosaggioInCorso)
    If (DosaggioInCorso) Then
        ManualeAspFresatoFreddo = False
    End If

    '20140328
    'If (Not ManualeAspFresatoFreddo And (ComandoScaricoFiller Or BitumeInSpruzzatura)) Then
    If (Not ManualeAspFresatoFreddo And (durata = 98 And (ComandoScaricoFiller Or BitumeInSpruzzatura))) Then
        'Con Durata = 99 la valvola sta SEMPRE aperta, con 98 apre tranne durante lo scarico filler-bitume
    '
        'Se si sta scaricando il filler o il bitume, l'aspirazione si chiude comunque per non tirare via quello che si cerca di scaricare nel mescolatore
        Call AspiraFumiFresatoFreddo_change(False)
        Exit Sub
    End If

    '20160301 F005
    'riciclatoFreddoInserito = ((DosaggioRAPSiwa.set > 0) Or (Not ParallelDrum And DosaggioRAP.set > 0) Or (DosaggioAggregati(6).set > 0))
    'riciclatoFreddoInScarico = ((DosaggioRAPSiwa.set > 0 And RAPSiwaInScarico) Or (Not ParallelDrum And DosaggioRAP.set > 0 And RAPInScarico) Or (DosaggioAggregati(6).set > 0 And ComandoScaricoAggregati))
    Dim setRiciclato As Double
    If (Not CP240.AdoDosaggioScarico.Recordset.EOF) Then
        If (AbilitaRAP) Then
            setRiciclato = setRiciclato + CP240.AdoDosaggioScarico.Recordset.Fields("RAP").Value
        End If
        If (AbilitaRAPSiwa) Then
            setRiciclato = setRiciclato + CP240.AdoDosaggioScarico.Recordset.Fields("RAPSiwa").Value
        End If
    End If
    riciclatoFreddoInserito = (setRiciclato > 0 Or DosaggioAggregati(6).set > 0)
    riciclatoFreddoInScarico = (setRiciclato > 0 And (RAPSiwaInScarico Or RAPInScarico) Or (DosaggioAggregati(6).set > 0 And ComandoScaricoAggregati))
    '

    '20160301 F005
    'If (Not CP240.AdoDosaggio.Recordset.EOF) Then
    '    durata = Null2zero(CP240.AdoDosaggio.Recordset.Fields("DurataAspFumiRic"))
    '    ritardo = Null2zero(CP240.AdoDosaggio.Recordset.Fields("RitardoAspFumiRic"))
    'End If
    If (Not CP240.AdoDosaggioScarico.Recordset.EOF) Then
        durata = Null2zero(CP240.AdoDosaggioScarico.Recordset.Fields("DurataAspFumiRic"))
        ritardo = Null2zero(CP240.AdoDosaggioScarico.Recordset.Fields("RitardoAspFumiRic"))
    End If
    '

    If durata = 0 And Not ManualeAspFresatoFreddo Then
        Call AspiraFumiFresatoFreddo_change(False)
        Exit Sub
    End If
    '
    'Se inserisco 99 secondi di durata da ricetta deve andare sempre
    If (durata = 99) Then
        Call AspiraFumiFresatoFreddoContinuo
        Exit Sub
    End If

    'Gestione ritardo e durata
    If (DosaggioInCorso) Then
        If (riciclatoFreddoInserito) Then   'Fresato Freddo Inserito
            If (MescolatoreAperto) Then
                Call AspiraFumiFresatoFreddo_change(False)
            End If
            
            If ritardo > 0 Then
                If riciclatoFreddoInScarico And OraStartRitardoAspirazioneFumiRAP = 0 Then
                    OraStartRitardoAspirazioneFumiRAP = ConvertiTimer()
                End If
                
                If (OraStartRitardoAspirazioneFumiRAP <> 0) And (ConvertiTimer() > OraStartRitardoAspirazioneFumiRAP + ritardo) Then
                    OraStartRitardoAspirazioneFumiRAP = 0
                    If OraStartDurataAspirazioneFumiRAP = 0 Then
                        OraStartDurataAspirazioneFumiRAP = ConvertiTimer()
                    End If
                    Call AspiraFumiFresatoFreddo_change(True)
                End If
                
            Else    'caso senza ritardo
                If riciclatoFreddoInScarico And OraStartDurataAspirazioneFumiRAP = 0 Then
                    OraStartDurataAspirazioneFumiRAP = ConvertiTimer()
                    Call AspiraFumiFresatoFreddo_change(True)
                End If
                
            End If
            
            'Timer verifica durata
            If (OraStartDurataAspirazioneFumiRAP <> 0) And (ConvertiTimer() > OraStartDurataAspirazioneFumiRAP + durata) Then
                'Finito il tempo -> fermo tutto
                Call AspiraFumiFresatoFreddo_change(False)
            End If
            
        End If
    End If
'
    Exit Sub
Errore:
    LogInserisci True, "RIC-010", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub GestioneBilanciaRAPSiwa()

On Error GoTo Errore

    If Siwarex(4).SIWA_ERR_MSG Then
        If CP240.LblTrNet(19).BackColor = vbBlack Then
            CP240.LblTrNet(19).BackColor = vbWhite
            CP240.LblTrNet(19).ForeColor = vbBlack
        Else
            CP240.LblTrNet(19).BackColor = vbBlack
            CP240.LblTrNet(19).ForeColor = vbWhite
        End If
    Else
        CP240.LblTrNet(19).BackColor = &H80FF&
        CP240.LblTrNet(19).ForeColor = vbBlack
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "RIC-011", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20150805
Public Sub CheckDeflettoreRiciclato()
    Dim comandoAnello As Boolean
    Dim predosatore As Integer '20160313
    Dim riciclcaldoinserito As Boolean
    
    '20160313
    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        If predosatore <= (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1) Then
            If (ListaPredosatoriRic(predosatore).setAttuale.set > 0) Then
                riciclcaldoinserito = True
                Exit For
            End If
        End If
    Next predosatore
    '

    'UTS120061F033_20150302
    'comandoAnello = False
    comandoAnello = (Not DeflettoreRiciclatoComandoElevatore)
    If (AutomaticoPredosatori) Then
        '20160313
        'comandoAnello = (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno)
        comandoAnello = (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno Or riciclcaldoinserito)
        '
    End If

'    comandoAnello = (Not DeflettoreRiciclatoComandoElevatore)
'    If (AutomaticoPredosatori) Then
'        comandoAnello = True
'    End If
    '
    If (ValvolaPreseparatoreAnello.abilitato) Then
        'UTS120061F019_20140311 20140312
        If (ValvolaPreseparatoreAnello.ModoAutomatico) Then
        '
            comandoAnello = (comandoAnello Or ValvolaPreseparatoreAnello.uscita)
        'UTS120061F019_20140311 20140312
        Else
            comandoAnello = (comandoAnello Or DeflettoreRiciclatoFcAnello)
        '
        End If
    End If

    Call SetDeflettoreRiciclato(Not comandoAnello)

End Sub

Public Sub SetDeflettoreRiciclato(nuovoComando As Boolean)

    If (Not AbilitaDeflettoreAnello) And (Not AbilitaDeflettoreAnelloElevatoreRic) Then
        Exit Sub
    End If
    
    If (DeflettoreRiciclatoComandoElevatore <> nuovoComando) Then
        DeflettoreRiciclatoComandoElevatore = nuovoComando

        FrmGestioneTimer.TimerDeflettoreRiciclato.enabled = False
        FrmGestioneTimer.TimerDeflettoreRiciclato.enabled = True

         If DeflettoreRiciclatoComandoElevatore And AbilitaDeflettoreAnello Then
            '   Anello
            CP240.AniPushButtonDeflettore(11).Value = 2
         ElseIf DeflettoreRiciclatoComandoElevatore And AbilitaDeflettoreAnelloElevatoreRic Then
            'elevatore riciclato
            CP240.AniPushButtonDeflettore(11).Value = 4
         Else
            'rifiuti
            CP240.AniPushButtonDeflettore(11).Value = 1
        End If

    End If

End Sub

Public Sub AggiornaDeflettoreRiciclato()

    'Dim nuovoValore As Integer

On Error GoTo Errore

    If (Not AbilitaDeflettoreAnello) Then
        Exit Sub
    End If
    
'20160303
'    If AutomaticoPredosatori Then
'        Call SetDeflettoreRiciclato(Not (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno))
'    End If
    
    If (DeflettoreRiciclatoFcAnello And Not DeflettoreRiciclatoFcElevatore) Then
        If Not DeflettoreRiciclatoComandoElevatore Then
            CP240.AniPushButtonDeflettore(11).Value = 1
        Else
            Call AllarmeTemporaneo("XX009", True)
            CP240.AniPushButtonDeflettore(11).Value = 3
        End If
    ElseIf (DeflettoreRiciclatoFcElevatore And Not DeflettoreRiciclatoFcAnello) Then
        If DeflettoreRiciclatoComandoElevatore Then
            CP240.AniPushButtonDeflettore(11).Value = 2
        Else
            Call AllarmeTemporaneo("XX009", True)
            CP240.AniPushButtonDeflettore(11).Value = 3
        End If
    Else
        CP240.AniPushButtonDeflettore(11).Value = 3
        'Entrambi i fine corsa hanno lo stesso valore
        Call AllarmeTemporaneo("XX010", True)
    End If
    '
'blocca il pulsante del deflettore quando si è in automatico predosatore
    If (CP240.AniPushButtonDeflettore(11).enabled <> Not AutomaticoPredosatori) Then
        CP240.AniPushButtonDeflettore(11).enabled = Not AutomaticoPredosatori
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "RIC-012", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AggiornaDeflettoreRiciclatoAnelloElevRic()

On Error GoTo Errore

    If (Not AbilitaDeflettoreAnelloElevatoreRic) Then
        Exit Sub
    End If
    
    If (DeflettoreRiciclatoFcAnello And Not DeflettoreRiciclatoFcElevatore) Then
        If Not DeflettoreRiciclatoComandoElevatore Then
            CP240.AniPushButtonDeflettore(11).Value = 1
        Else
            Call AllarmeTemporaneo("XX009", True)
            CP240.AniPushButtonDeflettore(11).Value = 3
        End If

    ElseIf (DeflettoreRiciclatoFcElevatore And Not DeflettoreRiciclatoFcAnello) Then
    
        If DeflettoreRiciclatoComandoElevatore Then
            CP240.AniPushButtonDeflettore(11).Value = 4
        Else
            Call AllarmeTemporaneo("XX009", True)
            CP240.AniPushButtonDeflettore(11).Value = 3
        End If
        
    Else
    
        CP240.AniPushButtonDeflettore(11).Value = 3
        'Entrambi i fine corsa hanno lo stesso valore
        Call AllarmeTemporaneo("XX010", True)
        
    End If
    '
    
    Exit Sub
Errore:
    LogInserisci True, "RIC-013", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'

Public Sub GestioneDeflettoreMulino()

'TODO segnalazione allarme

On Error GoTo Errore

    If (Not AbilitaDeflettoreMulino) Then
        Exit Sub
    End If

    If VaglioRiciclatoNastro Then        'Torna indietro
        If VaglioRiciclatoPesata Then   'Va all'anello
            CP240.AniPushButtonDeflettore(12).Value = 3
        Else
            CP240.AniPushButtonDeflettore(12).Value = 1
        End If
    Else
        If VaglioRiciclatoPesata Then
            CP240.AniPushButtonDeflettore(12).Value = 2
        Else
            CP240.AniPushButtonDeflettore(12).Value = 3
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "RIC-014", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub GestioneRifrantumazioneRiciclato()

Dim RiciclatoAcceso As Boolean
Dim Criterio As String
Dim posizione As Integer

On Error GoTo Errore

    If (Not InclusioneRifrantumazione) Then
        Exit Sub
    End If
    
    RiciclatoAcceso = ListaPredosatoriRic(0).motore.uscita Or ListaPredosatoriRic(1).motore.uscita Or ListaPredosatoriRic(2).motore.uscita

    'Attesa del ritorno linea
    If OraStartRifrantumazione <> 0 Then
        If ConvertiTimer() >= OraStartRifrantumazione + AttesaRitornoRifrantumazione Then
            OraStartRifrantumazione = 0
        End If
    End If
    
    'Controllo ritorno linea dopo il tempo di attesa
    If ComandoRifrantumazione And OraStartRifrantumazione = 0 Then
        If Not RitornoRifrantumazione Then
            ComandoRifrantumazione = False
            Criterio = "AC099"
            posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
            IngressoAllarmePresente posizione, True
            CP240.AniPushButtonDeflettore(13).Value = 1
        End If
    End If
    
    'Controllo arresto linea durante il funzionamento del riciclato
    If Not ComandoRifrantumazione And RiciclatoAcceso Then
        ShowMsgBox LoadXLSString(896), vbOKOnly, vbExclamation, -1, -1, True

        OraStartRifrantumazione = 0
        Call PassaInManualePredosatori
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "RIC-015", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub TermicaRifrantumazione_change()

    Dim posizione As Integer

    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "SI028", "IdDescrizione")

    If TermicaRifrantumazione Then
        ComandoRifrantumazione = False
        CP240.AniPushButtonDeflettore(13).Value = 1
        OraStartRifrantumazione = 0
    End If

    IngressoAllarmePresente posizione, TermicaRifrantumazione

End Sub

Public Sub LivelloTramoggiaRic_change()

    On Error GoTo Errore
    
    'Controllo livello alto tramoggia di pesatura riciclato.

    If (AbilitaRAPSiwa) Then
        'Se c'è la Siwarex il ivello alto è il suo

        If (LivelloAltoTramoggiaRic) Then
            ComponenteLivello DosaggioRAPSiwa, 100
            Call AllarmeTemporaneo("XX016", True)
        ElseIf (LivelloBassoTramoggiaRic) Then
            ComponenteLivello DosaggioRAPSiwa, 0
        Else
            ComponenteLivello DosaggioRAPSiwa, 50  'Sono tra i due livelli ~50%
        End If
    ElseIf (AbilitaRAP) Then
        'Se NON c'è la Siwarex il ivello alto è, per forza di cose, del RAP bilancia

        If (LivelloAltoTramoggiaRic) Then
            ComponenteLivello DosaggioRAP, 100
            Call AllarmeTemporaneo("XX016", True)
        ElseIf (LivelloBassoTramoggiaRic) Then
            ComponenteLivello DosaggioRAP, 0
        Else
            ComponenteLivello DosaggioRAP, 50  'Sono tra i due livelli ~50%
        End If
    ElseIf (PesaturaRiciclatoAggregato7) Then
        'Se la pesata del riciclato è sulla tramoggia7 degli aggregati
        If (LivelloAltoTramoggiaRic) Then
            ComponenteLivello DosaggioAggregati(6), 100
            Call AllarmeTemporaneo("XX016", True)
        ElseIf (LivelloBassoTramoggiaRic) Then
            ComponenteLivello DosaggioAggregati(6), 0
        Else
            ComponenteLivello DosaggioAggregati(6), 50  'Sono tra i due livelli ~50%
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "RIC-016", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ModulatoreDeflettoreAnelloApre(comando As Boolean)

    If (Not AbilitaModulatoreDeflettoreAnello) Then
        Exit Sub
    End If

    ModulatoreDeflettoreAnelloInApertura = comando

End Sub

Public Sub ModulatoreDeflettoreAnelloChiude(comando As Boolean)

    If (Not AbilitaModulatoreDeflettoreAnello) Then
        Exit Sub
    End If

    ModulatoreDeflettoreAnelloInChiusura = comando

End Sub

Public Sub PosizioneModulatoreDeflettoreAnello_change()

    On Error GoTo Errore

    If (Not AbilitaModulatoreDeflettoreAnello) Then
        Exit Sub
    End If

    CP240.LblModDeflAnello.caption = CStr(PosizioneModulatoreDeflettoreAnello)

    Exit Sub
Errore:
    LogInserisci True, "RIC-017", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub VerificaNastroDeflettoreAnello()
Dim posizione As Integer
Dim acceso As Boolean

    On Error GoTo Errore

    If (Not AbilitaModulatoreDeflettoreAnello Or Not AbilitaNastroDeflettoreAnello) Then
        Exit Sub
    End If
    If (NastroDeflettoreAnelloSpento0) Then
        acceso = (PosizioneModulatoreDeflettoreAnello > 0) And (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) And ListaMotori(MotoreElevatoreCaldo).ritorno
    Else
        acceso = (PosizioneModulatoreDeflettoreAnello < 100) And (ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Or ListaMotori(MotoreNastroCollettoreRiciclato).ritorno) And ListaMotori(MotoreElevatoreCaldo).ritorno
    End If
    If (NastroDeflettoreAnelloAcceso <> acceso) Then
        NastroDeflettoreAnelloAcceso = acceso
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "AM099", "IdDescrizione")
        IngressoAllarmePresente posizione, False
        Call VisualizzaNastroDeflettoreAnello
        FrmGestioneTimer.TrmNastroDeflettoreAnello.enabled = NastroDeflettoreAnelloAcceso
    End If

    Exit Sub
Errore:
    LogInserisci True, "RIC-018", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub VisualizzaNastroDeflettoreAnello()

    If (Not AbilitaModulatoreDeflettoreAnello Or Not AbilitaNastroDeflettoreAnello) Then
        Exit Sub
    End If
            
    If (NastroDeflettoreAnelloAcceso) <> NastroDeflettoreAnelloAccesoOld Then
        If NastroDeflettoreAnelloAcceso Then
            CP240.ImgMotor(248).Picture = LoadResPicture("IDB_NASTROON", vbResBitmap)
        Else
            CP240.ImgMotor(248).Picture = LoadResPicture("IDB_NASTRO", vbResBitmap)
        End If
        NastroDeflettoreAnelloAccesoOld = NastroDeflettoreAnelloAcceso
    End If

End Sub

Public Sub GestioneSicurezzaBilanciaRAP()
    'RAP
    On Error GoTo Errore

    If (Not AbilitaRAP) Or (DosaggioRAP.setCalcolato <= 0) Then
        Exit Sub
    End If

    If CLng(BilanciaRAP.Peso) > BilanciaRAP.Sicurezza Or CP240.OPCData.items(PLCTAG_All_RAP_Sicurezza).Value Then
        If DosaggioInCorso Then
            Call ArrestoEmergenzaDosaggio
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "RIC-019", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub RAPInScarico_Change()

    On Error GoTo Errore

    If CP240.OPCData.items(PLCTAG_AbilitaCicloRF).Value Then
        Call RiempiBufferAggregatiFiller
    End If

    CP240.ProgressBil(7).BackColor = IIf(RAPInScarico, vbGreen, &H80FFFF)

    If BufferAbilitaCicloRC(1) Then
        Call ScaricoAggregati_change
    End If

    '20161205
    If (RAPInScarico) Then
        Call AbilitazioneCambioRicetta(False)
    End If
    '20161205
    Exit Sub
Errore:
    LogInserisci True, "RIC-020", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub RAPSiwaInScarico_Change()

    On Error GoTo Errore

    If CP240.OPCData.items(PLCTAG_AbilitaCicloRF).Value Then
        Call RiempiBufferAggregatiFiller
    End If

    CP240.ProgressBil(8).BackColor = IIf(RAPSiwaInScarico, vbGreen, &H80FFFF)

    If PesaturaManuale And Not RAPSiwaInScarico And MemPesataManualeRiciclatoAttivata Then
        PesoTotaleRiciclatoManuale = PesoTotaleRiciclatoManuale + BilanciaRAP.Peso
        ScManualeRiciclato(CompRAPSiwa).Peso = ScManualeRiciclato(CompRAPSiwa).Peso + BilanciaRAP.Peso
    End If

    Exit Sub
Errore:
    LogInserisci True, "RIC-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
