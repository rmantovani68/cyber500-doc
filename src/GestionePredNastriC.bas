Attribute VB_Name = "GestionePredNastriC"

Option Explicit

Public UscitaInversione As Boolean
Public UscitaInversioneRiciclato As Boolean
Public AbilitaInversioneCollettore As Boolean
Public AbilitaInversioneLanciatore As Boolean
Public AbilitaInversioneRiciclato As Boolean
Public OraAllarmePredosatori As Long
Public TempoPermanenzaAllarmePredosatori As Integer
Public PredosatoreVergineVuoto As Boolean
Public PredosatoreRiciclatoVuoto As Boolean
Public TermicaPredosatori As Boolean
Public PortataMaxRamseyInerti As Integer
Public PortataMaxRamseyRic As Integer
Public PesoBilanciaRiciclatoParDrum As Integer
Public PesoBilanciaInerti As Single
Public PesoBilanciaRiciclato As Single
Public PesoBilanciaRiciclatoSecco As Single '20161230
Public PesoBilanciaInertiSecco As Single

Public TotalizzazioneNastroAggr As Double       'Totalizzazione peso transitato su nastro elevatore fretto
Public TotalizzazioneNastroRAP As Double        'Totalizzazione peso transitato su nestro elevatore RAP
Public TotalizzazioneNastroRAPParDrum As Double 'Totalizzazione peso transitato su nastro RAP Essiccatore Ricilato
Public PonderaleNastroRicAttvo As Boolean
Public PidPonderaleNastroRic As PidType
Public PredosatoriAutomaticoOn As Boolean
Public TotaleUmiditaPredosatore As Double
Public Const FileUmiditaPredosatore = "Umidita-Predosatore.ini"
Public Const FileUmiditaPredosatoreRic = "Umidita-PredosatoreRic.ini"

Public TotaleUmiditaPredRic As Double
Public TotaleUmiditaPredRicParDrum As Double

Public Enum NastriPredosatori
    Collettore1 = 0
    Collettore2 = 1
    RiciclatoCaldo = 2
    RiciclatoFreddo = 3
    Collettore3 = 4
    'Si considera che i predosatori su jolly siano sempre gli ultimi e dichiarati sul freddo
    RiciclatoJolly = 5

    MaxNastri
End Enum
Public NumeroPredosatoriNastroC(0 To MaxNastri - 1) As Integer
Public AutomaticoPredosatori As Boolean
Public ShowHotRecyScreen As Boolean   'abilitazione visualizzazione vaglio sgrossatore su linea fresato caldo, al posto del nastro collettore e solo se presente un solo predosatore
Public ShowColdRecyScreen As Boolean   'abilitazione visualizzazione vaglio sgrossatore su linea fresato freddo, al posto del nastro collettore e solo se presente un solo predosatore
Private GestioneConsumi_Timer As Double     'ultimo istante in cui é stata eseguita la routine GestioneConsumi

Public uscitaAnal As Double

Public InvertiNumerazionePred(0 To MaxNastri - 1) As Boolean
'
'20151106
Public Type TolleranzaNastro
    Tolleranza As Single
    TempoRitardoControllo As Long
    AppoggioTempo As Single
    TempoRitardoInCorso As Boolean
    TempoRitardoEseguito As Boolean
    Abilitazione As Boolean
    ErroreTimer As Boolean
End Type

Public TolleranzaNastroInerti As TolleranzaNastro
Public TolleranzaNastroRAP As TolleranzaNastro
'
Public impulsoResetTotNastri As TemporizzatoreStandardType '20170113


Public Sub DatiSetPredosaggi()
  
    If AbilitaControlloAllarmi < 2 Then
        Exit Sub
    End If

    TotaleUmiditaPredosatore = PredosatoriCalcoloUmiditaTotale(True)
'    TotDatiUmidPercInerti = RoundNumber((TotaleUmiditaPredosatore * 100) / TonOrarieAttualiImpianto, 1)

End Sub

Public Sub AvviamentoGestionePredosatori()

    On Error GoTo Errore

    If (AutomaticoPredosatori And PredosatoriVerginiAccesi) Then
        If (Not ListaMotori(MotoreRotazioneEssiccatore).ritorno And Not ListaTamburi(0).AvviamentoBruciatoreCaldo) Then
            Call AllarmeTemporaneo("XX005", True)
            Call PassaInManualePredosatori
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "NAS-009", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function ControlloPredAutomatico(nastro As Byte) As Boolean

    Dim K As Integer
    Dim predosatore As Integer

    ControlloPredAutomatico = False

    If nastro = 1 And ListaMotori(MotoreNastroCollettore1).presente And Not ListaMotori(MotoreNastroCollettore1).ritorno Then
        For K = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) - 1
            predosatore = K
            If PredosatoreOttieniSet(False, predosatore) <> 0 Then
                ControlloPredAutomatico = True
                Exit Function
            End If
        Next
    End If

    If nastro = 2 And ListaMotori(MotoreNastroCollettore2).presente And Not ListaMotori(MotoreNastroCollettore2).ritorno Then
        For K = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) - 1
            predosatore = NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + K
            If PredosatoreOttieniSet(False, predosatore) <> 0 Then
                ControlloPredAutomatico = True
                Exit Function
            End If
        Next
    End If

    If nastro = 3 And ListaMotori(MotoreNastroCollettore3).presente And Not ListaMotori(MotoreNastroCollettore3).ritorno Then
        For K = 0 To NumeroPredosatoriNastroC(NastriPredosatori.Collettore3) - 1
            predosatore = NumeroPredosatoriNastroC(NastriPredosatori.Collettore1) + NumeroPredosatoriNastroC(NastriPredosatori.Collettore2) + K
            If PredosatoreOttieniSet(False, predosatore) <> 0 Then
                ControlloPredAutomatico = True
                Exit Function
            End If
        Next
    End If

End Function


Public Function PredosatoriVerginiAccesi() As Boolean
Dim i As Integer
    For i = 0 To MAXPREDOSATORI - 1
        If ListaPredosatori(i).motore.uscita Then
            PredosatoriVerginiAccesi = True
            Exit Function
        End If
    Next i
End Function

Public Function PredosatoriRiciclatiAccesi() As Boolean
Dim i As Integer

    For i = 0 To MAXPREDOSATORIRICICLATO - 1
        If ListaPredosatoriRic(i).motore.uscita Then
            PredosatoriRiciclatiAccesi = True
            Exit Function
        End If
    Next i
End Function


Public Sub GestioneStopPredosatori()

    If (PredosatoriVerginiAccesi Or PredosatoriRiciclatiAccesi) And AutomaticoPredosatori Then
        If DosaggioInCorso And QuantitaImpastoProdotto > 0 And CicliStopPred > 0 Then
            If ((CicliDosaggioDaEseguire - CicliDosaggioEseguiti) = CicliStopPred And DosaggioInCorso) Then
                '20161003
                'Call PulsanteStopPred
                Call PredosatoriInManuale
                '20161003
            End If
        End If
    End If
    
End Sub

'Controlla se la ricetta è vuota
Public Function ControllaRicettaPredVuota()
    ControllaRicettaPredVuota = False
    If Not SelezioneRicettaPredosaggioCambiata Then
        If (CP240.LblNomeRicPred.caption = "" Or IsNull(CP240.LblNomeRicPred.caption)) Then
            AllarmeCicalino = True
            Call ShowMsgBox(LoadXLSString(154), vbOKOnly, vbExclamation, -1, -1, False)
            AllarmeCicalino = False

            'Se la ricetta è vuota non trasferisco i set
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set1).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set2).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set3).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set4).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set5).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set6).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set7).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set8).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set9).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set10).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set11).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Inerte_Set12).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set1).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set2).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set3).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set4).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set5).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set6).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Ricic_Set7).Value = 0
            CP240.OPCData.items(PLCTAG_NM_PRED_RICFUT_Afreddo).Value = 0    '20161205
            ControllaRicettaPredVuota = True
        End If
    End If
End Function

Public Sub AvvioPredAutomatico()
               
    If AutomaticoPredosatori Then
        Call PredosatoriInStartAutomatico(True)
    End If
    
End Sub

'Preparazione avviamento predosatori da CmdAutPred_Click() in CP240,
Public Sub PreparazioneAvvPred()
    Dim NumPred As Integer

    On Error GoTo Errore

    AutomaticoPredosatori = True
    PredosatoriAutomaticoOn = False

    'Proprieta della control a rendere disabilitata al click
    If AutomaticoPredosatori Then

        For NumPred = 0 To MAXPREDOSATORI - 1
            CP240.ImgPred(NumPred).enabled = False
        Next NumPred
        For NumPred = 0 To MAXPREDOSATORIRICICLATO - 1
            CP240.ImgPredRic(NumPred).enabled = False
        Next NumPred

    Else
        VisualizzaSetCalcolatoPredosatori = False
    End If

    Exit Sub
Errore:
    LogInserisci True, "NAS-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'CALCOLO DEL VALORE DA ATTRIBUIRE AL Set DEI PREDOSATORI.
'IN BASE LE T/H (PORTATA PRESA IN 5 PUNTI) TENENDO PRESENTE L'ANDAMENTO DEL GRAFICO.
'
'
' ---------------------------------------------------------------------------------
' Per trovare la ascissa (y) di un punto (x,y) interpolato in modo lineare 
' tra (x1,y1) e (x2,y2) nota l'ordinata (x), occorre applicare la seguente formula:
'
'       (x-x1)*(y2-y1)
' y =  --------------- + y1
'         (x2 - x1)  
' 
' quindi, dati : 
'
'     x          = portataTeorica
'     valori()   = array di ordinate (x)
'     percento() = array di ascisse (y)
'     Dimensione = Dimensione Arrays (attualmente 5
'
'     ' ricavo i punti inferiori (x1,y1) e superiori (x2,y2)
'     ' parto da 1 
'     For i = 1 To Dimensione - 1
'         IF x0 <= valori(i)
'             x1 = valori(i-1)
'             y1 = percento(i-1)
'             x2 = valori(i)
'             y2 = percento(i)
'         end if
'     Next i
'
'     y = CInt(((((x-x1)*(y2-y1))/(x2-x1))+y1))
' 
'     PredosatoreSetCalcolato = y
' --------------------------------------------------------------------------------- 
'

Public Function PredosatoreSetCalcolato(ByRef Pred As PredosatoreType, portataTeorica As Double) As Integer

     With Pred.Grafico.curva(Pred.Grafico.curvaAttiva)

        'In caso che le T/H siano maggiori del punto 4 e minori del punto 5.
        If portataTeorica > .valori(3) Then
            PredosatoreSetCalcolato = CInt(((((.percento(4) - .percento(3)) * (portataTeorica - .valori(3))) / (.valori(4) - .valori(3))) + .percento(3)))
        'In caso che le T/H siano uguale al 5° punto di prova.
        ElseIf portataTeorica = .valori(4) Then
            PredosatoreSetCalcolato = CInt(.percento(4))
        'In caso che le T/H siano uguale al 4° punto di prova.
        ElseIf portataTeorica = .valori(3) Then
            PredosatoreSetCalcolato = CInt(.percento(3))
        'In caso che le T/H siano maggiori del punto 3 e minori del punto 4.
        ElseIf portataTeorica > .valori(2) And (portataTeorica < .valori(3)) Then
            PredosatoreSetCalcolato = CInt(((((.percento(3) - .percento(2)) * (portataTeorica - .valori(2))) / (.valori(3) - .valori(2))) + .percento(2)))
        'In caso che le T/H siano uguale al 3° punto di prova.
        ElseIf portataTeorica = .valori(2) Then
            PredosatoreSetCalcolato = CInt(.percento(2))
        'In caso che le T/H siano maggiori del punto 2 e minori del punto 3.
        ElseIf portataTeorica > .valori(1) And (portataTeorica < .valori(2)) Then
            PredosatoreSetCalcolato = CInt(((((.percento(2) - .percento(1)) * (portataTeorica - .valori(1))) / (.valori(2) - .valori(1))) + .percento(1)))
        'In caso che le T/H siano uguale al 2° punto di prova.
        ElseIf portataTeorica = .valori(1) Then
            PredosatoreSetCalcolato = CInt(.percento(1))
        'In caso che le T/H siano maggiori del punto 1 e minori del punto 2.
        ElseIf (portataTeorica > .valori(0)) And (portataTeorica < .valori(1)) Then
            PredosatoreSetCalcolato = CInt(((((.percento(1) - .percento(0)) * (portataTeorica - .valori(0))) / (.valori(1) - .valori(0))) + .percento(0)))
        'In caso che le T/H siano uguale al 1° punto di prova.
        ElseIf portataTeorica = .valori(0) Then
            PredosatoreSetCalcolato = CInt(.percento(0))
        ElseIf (portataTeorica > 0) And (portataTeorica < .valori(0)) Then
            PredosatoreSetCalcolato = CInt(((.percento(0) * portataTeorica) / .valori(0)))
        End If

    End With

End Function

Public Function ValoreUscitaAnalogicaPred(riciclato As Boolean, ValoreSet As Integer, ValoreSetReale As Integer) As Double

    Dim UnitaPred As Integer

    '20160405 Deve essere tutto positivo
    If riciclato Then
        UnitaPred = CInt(Abs(VRic) * 27648 / 10)
    Else
        UnitaPred = CInt(Abs(Vpred) * 27648 / 10)
    End If
    '20160404 Deve essere tutto positivo
    
    If (Not AutomaticoPredosatori) Then
        'IMPOSTAZIONE MANUALE DI VELOCITA' DEI PREDOSATORI.
        ValoreUscitaAnalogicaPred = CDbl(ValoreSet) * CDbl(UnitaPred) \ 100
    Else
        ValoreUscitaAnalogicaPred = CDbl(ValoreSetReale) * CDbl(UnitaPred) \ 100
    End If
   
    'Limitatore del valore delle unità da scrivere in uscita
    If Abs(ValoreUscitaAnalogicaPred) > Abs(UnitaPred) Then
        ValoreUscitaAnalogicaPred = UnitaPred
    End If

End Function

Public Sub PulsanteStopPred()

    StartPredosatori = False
    StartPredosatori_change
    PredosatoriAutomaticoOn = False
    
'20151125
'20161005
'    If (CP240.OPCData.items.count) Then
'        CP240.OPCData.items(PLCTAG_NM_PRED_Auto_Man).Value = False
'    End If
    'Automatico -> manuale
    'AutomaticoPredosatori = False '20161005
'

    Call VisualizzaRiduzioneProduzione

    Call PassaInManualePredosatori
    
    OrarioPredAutoChange = 0
'
    PredosatoriInStartAutomatico False
    
    Dim posizione As Integer
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "VA002", "IdDescrizione")
    IngressoAllarmePresente posizione, False

End Sub


Public Sub RichiamoRicettaPredos()
Dim NumPred As Integer

    On Error GoTo Errore
       
    If CP240.adoComboPredosaggio.text = "" Then
        Exit Sub
    End If

    If RiduzioneProduzione > 0 Then
        
        If CP240.adoComboPredosaggio.text <> "" Then
            
            '20170206
            '20160930
            'Call RinfrescaOrigineDatiPredosaggio(CP240.adoComboPredosaggio.text, True)
            'If (abilitaRinfrescoDati_pred) Then
            If (abilitaRinfrescoDati_pred) Or (JobAttivo.StatusVB <> EnumStatoJobVB.Idle) Then
                Call RinfrescaOrigineDatiPredosaggio(CP240.adoComboPredosaggio.text, True)
                abilitaRinfrescoDati_pred = False
            End If
            '20160930
            
            Call ChkCoherenceMaterial(CInt(CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio")))   '20160405
            If (Not CP240.AdoPredosaggio.Recordset.EOF) Then
                For NumPred = 0 To NumeroPredosatoriInseriti - 1
                    PredosatoreCambiaSet False, NumPred, CP240.AdoPredosaggio.Recordset.Fields("SetPredosatore" & NumPred + 1), False
                Next NumPred
                For NumPred = 0 To NumeroPredosatoriRicInseriti - 1
                    PredosatoreCambiaSet True, NumPred, CP240.AdoPredosaggio.Recordset.Fields("SetPredosatoreRic" & NumPred + 1), False
                Next NumPred
            End If

        End If

        Call SendMessagetoPlus(PlusSendActiveFeederRecipeID, val(CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio").Value))

    Else
        ShowMsgBox LoadXLSString(826), vbOKOnly, vbExclamation, -1, -1, True
    End If

    Exit Sub
Errore:
    LogInserisci True, "NAS-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AggiornaProssimaRicettaPredos()

    Dim NumPred As Integer
    Dim rs As New adodb.Recordset
    Dim NomeRicetta As String
    Dim query As String

    On Error GoTo Errore
       
    NomeRicetta = CP240.adoComboPredosaggio.text
       
    If NomeRicetta = "" Then
        Exit Sub
    End If

    With rs
        query = "SELECT * FROM Predosaggio WHERE [Descrizione] LIKE '" & NomeRicetta & "';"
        
        Set .ActiveConnection = DBcon
        .Source = query
        .LockType = adLockReadOnly
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon

        If (Not .EOF) Then
            
            If NumeroPredosatoriRicInseriti > 0 Then
                NumPred = NumeroPredosatoriRicInseriti - 1
            End If

            NumPredVergProssimoSet = 0
            NumPredRicFreddoProssimoSet = 0

            For NumPred = 0 To NumeroPredosatoriInseriti - 1
                If rs.Fields("SetPredosatore" & NumPred + 1) <> 0 Then
                    NumPredVergProssimoSet = NumPredVergProssimoSet + 1
                End If
            Next NumPred
            
            For NumPred = 0 To NumeroPredosatoriRicInseriti - 1
                If rs.Fields("SetPredosatoreRic" & NumPred + 1) <> 0 And NumPred > (PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoFreddo) - 1) Then
                    NumPredRicFreddoProssimoSet = NumPredRicFreddoProssimoSet + 1
                End If
            Next NumPred

            For NumPred = 0 To NumeroPredosatoriRicInseriti - 1
                If rs.Fields("SetPredosatoreRic" & NumPred + 1) <> 0 And NumPred < (PrimoPredosatoreDelNastro(NastriPredosatori.RiciclatoFreddo)) Then
                    NumPredRicCaldoProssimoSet = NumPredRicCaldoProssimoSet + 1
                End If
            Next NumPred

        End If
    End With
    

    Exit Sub
Errore:
    LogInserisci True, "NAS-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub PassaInManualePredosatori()
    '20161005
'    If (CP240.OPCData.items.Count > 0) Then
'        CP240.OPCData.items(PLCTAG_NM_PRED_Auto_Man).Value = False
'    End If
    
    Dim NumPred As Integer
    
'20170110
''20151125
''    CP240.PctPredosatoriWorking.Picture = LoadResPicture("IDI_WORKING", vbResIcon)    'IDI_PREDOSATORE
'    CP240.PctPredosatoriWorking.Picture = LoadResPicture("IDI_MANUALE", vbResIcon)    'IDI_PREDOSATORE
''

    If (StartPredosatori) Then
        StartPredosatori = False
        StartPredosatori_change
    End If

    'Fermo i predosatori passandoli in manuale
    For NumPred = 0 To MAXPREDOSATORI - 1
        CP240.ImgPred(NumPred).enabled = True
    Next NumPred
    For NumPred = 0 To MAXPREDOSATORIRICICLATO - 1
        CP240.ImgPredRic(NumPred).enabled = True
    Next NumPred
    If (Not AttesaFineRicetta) Then         '20160201
        AutomaticoPredosatori = False
    End If                                  '20160201
        
    CP240.AniPushButtonDeflettore(11).enabled = Not AutomaticoPredosatori
        
    'Disabilito il pulsante di start predosatori.
    PredosatoriAutomaticoOn = False
'    CP240.CmdStartPred.enabled = False '20151125
    
    If (Not AttesaFineRicetta) Then         '20160201
        PredosatoriArrestoImmediato True, -1
        PredosatoriArrestoImmediato False, -1
    End If  '20160201
    
    PredosatoriInManuale

    Call CP240.AbilitaCalibrazione

End Sub


Public Function PredosatoriRicConBilancia() As Boolean

    Dim predosatore As Integer

    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        If (ListaPredosatoriRic(predosatore).bilanciaPresente) Then
            PredosatoriRicConBilancia = True
            Exit Function
        End If
    Next predosatore

    PredosatoriRicConBilancia = False

End Function

'Visualizza o meno i controlli (in CP240) dedicati alla visualizzazione e memorizzazione
'della portata (effettiva o teorica) che transita sui nastri elevatori.
'La portata viene visualizzata se presente la relativa bilancia o se abilitato il parametro 'Abilita portate nastri' (TAB Predosaggio)
Public Sub VisualizzaPortateNastri()

    With CP240

        'Nastro elevatore freddo aggregati
        .Frame1(8).Visible = ListaMotori(MotoreNastroElevatoreFreddo).presente And (ConfigPortataNastroInerti > 0)

        'RAP
        .Frame1(33).Visible = ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And (ConfigPortataNastroRiciclato > 0)
        
        'RAP ER (Essiccatore riciclato)
        .Frame1(5).Visible = ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And (ConfigPortataNastroRiciclatoParDrum > 0)
        
    End With

End Sub


Public Sub StartPredosatori_change()

    With CP240

        .CmdAvvPredPrimaDopoBruc.enabled = Not StartPredosatori
        .AniPushButtonDeflettore(1).enabled = StartPredosatori

    End With

End Sub


Public Sub LeggeFileUmiditaPredosatore()

    Dim nomeFile As String

    nomeFile = UserDataPath + FileUmiditaPredosatore

    If (Not FileExist(nomeFile)) Then

        LogInserisci True, "File not found", nomeFile

    Else

        Open nomeFile For Input As #36

        Input #36, ListaPredosatori(0).Umidita, ListaPredosatori(1).Umidita, ListaPredosatori(2).Umidita, ListaPredosatori(3).Umidita
        Input #36, ListaPredosatori(4).Umidita, ListaPredosatori(5).Umidita, ListaPredosatori(6).Umidita, ListaPredosatori(7).Umidita
        Input #36, ListaPredosatori(8).Umidita, ListaPredosatori(9).Umidita, TotaleUmiditaPredosatore, ListaPredosatori(10).Umidita, ListaPredosatori(11).Umidita

        Close #36

    End If

End Sub

Public Sub LeggeFileUmiditaPredosatoreRic()

    Dim nomeFile As String
    'Dim umiditaPredRic4 As Double


    nomeFile = UserDataPath + FileUmiditaPredosatoreRic

    If (Not FileExist(nomeFile)) Then

        LogInserisci True, "File not found", nomeFile

    Else

        Open nomeFile For Input As #39

        Input #39, ListaPredosatoriRic(0).Umidita, ListaPredosatoriRic(1).Umidita, ListaPredosatoriRic(2).Umidita, ListaPredosatoriRic(3).Umidita
        Input #39, TotaleUmiditaPredRic
        If (Not EOF(39)) Then
            Input #39, ListaPredosatoriRic(4).Umidita, ListaPredosatoriRic(5).Umidita, ListaPredosatoriRic(6).Umidita, ListaPredosatoriRic(7).Umidita
        End If
       
        Close #39

    End If

End Sub


Public Sub RinfrescaOrigineDatiPredosaggio(NomeRicPredSel As String, Optional AggiornaCP240 As Boolean)

    Dim memoric As String '20170221

    With CP240

        memoric = .adoComboPredosaggio.text

        .AdoPredosaggioCombo.Refresh
        .adoComboPredosaggio.ReFill
        
        If AggiornaCP240 Then
            .AdoPredosaggio.Refresh
            .adoComboPredosaggio.ReFill

            Dim Stringa2 As String

            Stringa2 = RTrim(NomeRicPredSel)
        
            Do Until .AdoPredosaggio.Recordset.EOF
                If RTrim(.LblNomeRicPred.caption) = Stringa2 Then
                
'                    .adoComboPredosaggio.Refresh '20170221
                    .adoComboPredosaggio.text = memoric '20170221
                    
                    Exit Do
                End If
                .AdoPredosaggio.Recordset.MoveNext
'                .AdoPredosaggioCombo.Recordset.MoveNext '20170221
            Loop

        End If

    End With
    
End Sub

'20160301
Public Sub RinfrescaNomeRicPreDosaggio()

    Dim IdRicPreDosSel As String
    Dim IdRicPreDosCombo As String

    If Not CP240.AdoPredosaggio.Recordset.EOF Then
        IdRicPreDosCombo = CP240.AdoPredosaggioCombo.Recordset.Fields("IdPredosaggio").Value
        IdRicPreDosSel = CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio").Value
    End If
    
    CP240.AdoPredosaggio.Refresh

    CP240.AdoPredosaggioCombo.Refresh
    
    CP240.adoComboPredosaggio.ReFill
                           
    '20160907
    If IdRicPreDosSel <> "" Then
        Do Until CP240.AdoPredosaggio.Recordset.EOF
            If IdRicPreDosSel = CP240.AdoPredosaggio.Recordset.Fields("IdPredosaggio").Value Then
                CP240.adoComboPredosaggio.text = CP240.AdoPredosaggio.Recordset.Fields("Descrizione").Value
                CP240.LblNomeRicPred.caption = CP240.AdoPredosaggio.Recordset.Fields("Descrizione").Value
                Exit Do
            End If
            CP240.AdoPredosaggio.Recordset.MoveNext
        Loop
    
        Do Until CP240.AdoPredosaggioCombo.Recordset.EOF
            If IdRicPreDosSel = CP240.AdoPredosaggioCombo.Recordset.Fields("IdPredosaggio").Value Then
                Exit Do
            End If
            CP240.AdoPredosaggioCombo.Recordset.MoveNext
        Loop
    End If
    
End Sub
'

Public Sub NastroRicRegolazionePonderale()

    Dim posizione As Integer
    Dim predosatore As Integer
    Dim ponderaleOk As Boolean
    Dim uscitaAnalTeorica As Double
    Dim ramseyRicTeorica As Double
    Dim sommaPercPredRic As Double
    Dim sommaPercPredRicCaldo As Double
    Dim sommaPercRicTot As Double
    Dim ponderalesospeso As Integer
    Dim NumPred As Integer
    Dim almenounpredvergine As Boolean


    ponderaleOk = True
    '   Somma delle percentuali dei predosatori riciclato
    sommaPercPredRic = 0
    '   Somma delle uscite analogiche teoriche dei predosatori ric.
    uscitaAnalTeorica = 0

    For NumPred = 0 To NumeroPredosatoriInseriti - 1
        'controllo se c'e' almeno un predosatore vergine inserito
        If ListaPredosatori(NumPred).setAttuale.set <> 0 Then
            almenounpredvergine = True
        End If
    Next NumPred
    
    If Not almenounpredvergine Then
        CP240.AniPushButtonDeflettore(1).Value = 2 'manuale
    End If

    If ( _
        Not AutomaticoPredosatori Or _
        Not StartPredosatori Or _
        ((ConfigPortataNastroRiciclato <= 1) And Not PredosatoriRicConBilancia) Or _
        CP240.AniPushButtonDeflettore(1).Value <> 1 _
    ) Then
        ponderaleOk = False

        PidPonderaleNastroRic.maxCorrezioneRaggiunta = 0
    End If


    'Se abilitato il deflettore a Elevatore/Anello (par: AbilitaDeflettoreAnelloElevatore nel tab Predosatori)
    'il riclato caldo (Anello) diventa riciclato freddo (Elevatore) e nel secondo caso si deve disattivare la regolazione
    'ponderale sul nastro del riciclato
    If (AbilitaDeflettoreAnelloElevatoreRic) Then
        If (DeflettoreRiciclatoFcElevatore And Not DeflettoreRiciclatoFcAnello) Then
            CP240.AniPushButtonDeflettore(1).Value = 2
            CP240.AniPushButtonDeflettore(1).enabled = False
            ponderaleOk = False
        Else
            CP240.AniPushButtonDeflettore(1).enabled = True
        End If
    End If
    
    If (ponderaleOk) Then
        For predosatore = 0 To NumeroPredosatoriInseriti - 1
            If (val(CP240.TxtPredSet(predosatore)) > 0 And Not ListaPredosatori(predosatore).motore.ritorno) Then
                '   Se non sono partiti tutti i predosatori inerti, fermo la correzione ponderale
                ponderaleOk = False
                Exit For
            End If
        Next predosatore
    End If

    If (ponderaleOk) Then
        If ParallelDrum Then
        
            For predosatore = 0 To PrimoPredosatoreDelNastro(RiciclatoFreddo) - 1
                If (ListaPredosatoriRic(predosatore).motore.ritorno) Then
                    sommaPercPredRic = sommaPercPredRic + CDbl(CP240.TxtPredRicSet(predosatore))
                    uscitaAnalTeorica = uscitaAnalTeorica + ListaPredosatoriRic(predosatore).uscitaAnalogicaTeorica

                    If ListaPredosatoriRic(predosatore).stato <> predosatoreInStart Then
                        ponderalesospeso = ponderalesospeso + 1
                    End If
                Else
                    '   Se non sono partiti tutti i predosatori riciclati, fermo la correzione ponderale
                    ponderaleOk = False
                    Exit For
                End If
            Next predosatore
            
            For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                If (ListaPredosatoriRic(predosatore).motore.ritorno) Then
                    sommaPercRicTot = sommaPercRicTot + CDbl(CP240.TxtPredRicSet(predosatore))
                End If
            Next predosatore
            
        Else
        
            For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                If (val(CP240.TxtPredRicSet(predosatore)) > 0) Then
    
                    If (ListaPredosatoriRic(predosatore).SuNastroJolly And Not NastroRapJollyVersoFreddo) Then
                        sommaPercPredRicCaldo = sommaPercPredRicCaldo + CDbl(CP240.TxtPredRicSet(predosatore))
                    End If
                    If predosatore <= (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1) Then
                        sommaPercPredRicCaldo = sommaPercPredRicCaldo + CDbl(CP240.TxtPredRicSet(predosatore))
                        sommaPercPredRic = sommaPercPredRic + CDbl(CP240.TxtPredRicSet(predosatore))
                    End If

                    If (ListaPredosatoriRic(predosatore).motore.ritorno) And ListaPredosatoriRic(predosatore).stato <> predosatoreInStart Then
                        ponderalesospeso = ponderalesospeso + 1
                    End If

                    If (ListaPredosatoriRic(predosatore).motore.ritorno) Then
                        uscitaAnalTeorica = uscitaAnalTeorica + ListaPredosatoriRic(predosatore).uscitaAnalogicaTeorica
                    End If
                End If
            Next predosatore
        End If

        If (sommaPercPredRic = 0) Then
            '   Nessun predosatore riciclato impostato
            ponderaleOk = False
        End If
    End If

    If (ponderaleOk) Then
        '   Se un predosatore è vuoto, fermo la correzione ponderale
        If (PredosatoreRiciclatoVuoto Or PredosatoreVergineVuoto) Then
            ponderaleOk = False
        End If
    End If

    If (ponderaleOk) Then

        With PidPonderaleNastroRic

            If (Not PonderaleNastroRicAttvo) Then
                PonderaleNastroRicAttvo = True
                .primaVolta = True
                .Campionamento = ConvertiTimer()
            End If

            If ( _
                (.primaVolta And .Campionamento + .ritardoTC <= ConvertiTimer()) Or _
                (Not .primaVolta And .Campionamento + .TC <= ConvertiTimer()) _
            ) Then
                'Se ho i le bilance sui singoli predosatori del riciclato faccio il PID sul singolo

                If (ConfigPortataNastroRiciclato > 1) Then
                    '   Peso che teoricamente dovrebbe avere il nastro riciclato
                    
                    If ParallelDrum Then
                        ramseyRicTeorica = RoundNumber((PesoBilanciaInertiSecco * sommaPercPredRic) / (100 - sommaPercRicTot), 1)
                    Else
                        ramseyRicTeorica = RoundNumber((PesoBilanciaInertiSecco * sommaPercPredRicCaldo) / (100 - sommaPercPredRic), 1)
                    End If
                    
                    '   uscitaAnal = uscita reale da dividere per tutti i predosatori ric.
                    If ponderalesospeso = 0 Then
                    
                        Call PIDcontroller( _
                            PidPonderaleNastroRic, _
                            uscitaAnalTeorica, _
                            ramseyRicTeorica, _
                            uscitaAnal, _
                            CDbl(PesoBilanciaRiciclato) _
                            )
                    End If
    
                    '   I predosatori riciclati accesi li riporto all'uscita analogica originale
                    For predosatore = PrimoPredosatoreDelNastro(RiciclatoJolly) To NumeroPredosatoriRicInseriti - 1
                        If (ListaPredosatoriRic(predosatore).SuNastroJolly And Not NastroRapJollyVersoFreddo) Then
                            If (val(CP240.TxtPredRicSet(predosatore)) > 0 And ListaPredosatoriRic(predosatore).motore.ritorno) Then
                                ListaPredosatoriRic(predosatore).uscitaAnalogica = uscitaAnal * CDbl(CP240.TxtPredRicSet(predosatore).text) / sommaPercPredRic
                            End If
                        End If
                    Next predosatore
                    For predosatore = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
                        If (val(CP240.TxtPredRicSet(predosatore)) > 0 And ListaPredosatoriRic(predosatore).motore.ritorno) Then
                            'divido la correzione pid totale nelle giuste parti in base alla portata max del singolo predosatore
                            If uscitaAnalTeorica <> 0 Then
                                ListaPredosatoriRic(predosatore).uscitaAnalogica = (ListaPredosatoriRic(predosatore).uscitaAnalogicaTeorica / uscitaAnalTeorica) * uscitaAnal
                                If ListaPredosatoriRic(predosatore).uscitaAnalogica > CInt(VRic / 10 * 27648) Then
                                    ListaPredosatoriRic(predosatore).uscitaAnalogica = CInt(VRic / 10 * 27648)
                                End If
                            End If
                        End If
                    
                    Next predosatore
                    
                     If ParallelDrum And (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) = 0) Then
                    
                        For predosatore = 0 To (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1)
                            If (val(CP240.TxtPredRicSet(predosatore)) > 0 And ListaPredosatoriRic(predosatore).motore.ritorno) Then
                                If uscitaAnalTeorica <> 0 Then
                                    ListaPredosatoriRic(predosatore).uscitaAnalogica = (ListaPredosatoriRic(predosatore).uscitaAnalogicaTeorica / uscitaAnalTeorica) * uscitaAnal
                                    If ListaPredosatoriRic(predosatore).uscitaAnalogica > CInt(VRic / 10 * 27648) Then
                                        ListaPredosatoriRic(predosatore).uscitaAnalogica = CInt(VRic / 10 * 27648)
                                    End If
                                End If
                            End If
                        Next predosatore
                    End If
                Else
                    'PID sul singolo riciclato
                    ramseyRicTeorica = RoundNumber((PesoBilanciaInertiSecco * sommaPercPredRic) / (100 - sommaPercPredRic), 1)
                    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                        Call PIDcontroller( _
                                PidPonderaleNastroRic, _
                                ListaPredosatoriRic(predosatore).uscitaAnalogicaTeorica, _
                                (CDbl(CP240.TxtPredRicSet(predosatore)) * ramseyRicTeorica / sommaPercPredRic), _
                                ListaPredosatoriRic(predosatore).uscitaAnalogica, _
                                ListaPredosatoriRic(predosatore).portataBilancia _
                                )
                    Next predosatore
                End If

            End If

        End With

    Else
        For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
            ListaPredosatoriRic(predosatore).pid.primaVolta = True
        Next predosatore
        
        PonderaleNastroRicAttvo = False
    End If

    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "PR001", "IdDescrizione")

    '   Segnalo quando viene raggiunto il parametro di correzione max impostato
    If (PonderaleNastroRicAttvo And PidPonderaleNastroRic.maxCorrezioneRaggiunta <> 0) Then
        IngressoAllarmePresente posizione, True
    Else
        IngressoAllarmePresente posizione, False
    End If

    If (Not PonderaleNastroRicAttvo) Then
        '   I predosatori riciclati accesi li riporto all'uscita analogica originale
        For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
            If (ListaPredosatoriRic(predosatore).motore.ritorno) Then
                ListaPredosatoriRic(predosatore).uscitaAnalogica = ListaPredosatoriRic(predosatore).uscitaAnalogicaTeorica
            End If
        Next predosatore
    End If

End Sub


Public Sub PesoNastroInerti_change()

Dim tmp As Integer

    'Calcolo Umidità (quantità di acqua) totale dei soli predosatori vergini.
    TotaleUmiditaPredosatore = PredosatoriCalcoloUmiditaTotale(False)

    If (PesoBilanciaInerti < 0) Then
        PesoBilanciaInerti = 0
    End If

    CP240.LblRamseyInerti.caption = CStr(Round(PesoBilanciaInerti, 0))

    tmp = Round(PesoBilanciaInerti - PredosatoriCalcoloUmiditaTotale(True), 0)
    If (tmp < 0) Then
        CP240.LblInertiSecchi.caption = "0"
        PesoBilanciaInertiSecco = 0
    Else
        CP240.LblInertiSecchi.caption = CStr(tmp)
        PesoBilanciaInertiSecco = tmp
    End If

End Sub

Public Sub PesoNastroInerti()

    Dim valoreSng As Single
    Dim nuovoPeso As Single
    Dim predosatore As Integer
    Dim nuovopesoteorico As Single '20151106
    Dim tonHteorico As Single '20151106
    Dim Criterio As String '20151106
    Dim posizione As Integer '20151106
    Dim valoremaxritardopred As Long '20151106
    Dim predcambioset As Boolean '20160301
    
    On Error GoTo Errore
    
    Select Case ConfigPortataNastroInerti

        Case nessuna
        
        Case teorica
            nuovoPeso = 0
            For predosatore = 0 To NumeroPredosatoriInseriti - 1
                If (ListaPredosatori(predosatore).motore.ritorno And PredosatoreOttieniSet(False, predosatore) > 0) Then
                    nuovoPeso = nuovoPeso + ListaPredosatori(predosatore).portataTeorica
                End If
            Next predosatore

        Case analogica
            valoreSng = CSng(CP240.OPCData.items(PLCTAG_AI_PesoNastroInerti).Value)
            nuovoPeso = CSng(SondaDbl_mA(CLng(valoreSng), CLng(PortataMaxRamseyInerti), 0, False))

        Case schedaSiwarex
            nuovoPeso = CInt(Siwarex(0).SIWA_PORTATA_NASTRO)
            If Siwarex(0).SIWA_ERR_MSG Then
                If CP240.LblRamseyInerti.BackColor = vbBlack Then
                    CP240.LblRamseyInerti.BackColor = vbWhite
                    CP240.LblRamseyInerti.ForeColor = vbBlack
                Else
                    CP240.LblRamseyInerti.BackColor = vbBlack
                    CP240.LblRamseyInerti.ForeColor = vbWhite
                End If
            Else
                CP240.LblRamseyInerti.BackColor = &HC0E0FF
                CP240.LblRamseyInerti.ForeColor = vbBlack
            End If
    End Select

'20151106
    nuovopesoteorico = 0
    valoremaxritardopred = 0
    For predosatore = 0 To NumeroPredosatoriInseriti - 1
        If (ListaPredosatori(predosatore).motore.ritorno And PredosatoreOttieniSet(False, predosatore) > 0) Then
            nuovopesoteorico = nuovopesoteorico + ListaPredosatori(predosatore).portataTeorica
        End If
'20160301
        If (ListaPredosatori(predosatore).setAttuale.tempoStart > valoremaxritardopred) And (Not ListaPredosatori(predosatore).immediato) And (PredosatoreOttieniSet(False, predosatore) > 0) Then
            valoremaxritardopred = ListaPredosatori(predosatore).setAttuale.tempoStart
        End If
    
        If (ListaPredosatori(predosatore).stato = predosatoreStarting) Or (ListaPredosatori(predosatore).stato = predosatoreStopping) Then
            predcambioset = True
        End If
'
    Next predosatore

'20160301
'    Call TemporizzatoreStandard( _
'        1, _
'        TolleranzaNastroInerti.TempoRitardoControllo + valoremaxritardopred, _
'        TolleranzaNastroInerti.AppoggioTempo, _
'        TolleranzaNastroInerti.TempoRitardoInCorso, _
'        TolleranzaNastroInerti.TempoRitardoEseguito, _
'        StartPredosatori, _
'        TolleranzaNastroInerti.ErroreTimer _
'        )

    Call TemporizzatoreStandard( _
        1, _
        TolleranzaNastroInerti.TempoRitardoControllo + IIf(predcambioset, valoremaxritardopred, 0), _
        TolleranzaNastroInerti.AppoggioTempo, _
        TolleranzaNastroInerti.TempoRitardoInCorso, _
        TolleranzaNastroInerti.TempoRitardoEseguito, _
        StartPredosatori And Not predcambioset, _
        TolleranzaNastroInerti.ErroreTimer _
        )
'

    Criterio = "DO005"
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
    IngressoAllarmePresente posizione, TolleranzaNastroInerti.TempoRitardoEseguito And StartPredosatori And (PesoBilanciaInerti > (nuovopesoteorico + TolleranzaNastroInerti.Tolleranza) Or PesoBilanciaInerti < (nuovopesoteorico - TolleranzaNastroInerti.Tolleranza))
'

    If (PesoBilanciaInerti <> nuovoPeso) Then
        PesoBilanciaInerti = LimitaValoreSng(nuovoPeso, 0, CSng(TonOrarieImpianto))
        PesoNastroInerti_change
    End If

    Exit Sub
Errore:
    LogInserisci True, "NAS-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PesoNastroRiciclato_change()

    '20161230 Dim ricSecco As Integer

    CP240.LblRamseyRic(0).caption = RoundNumber(PesoBilanciaRiciclato, 0)

    '20161230
    'ricSecco = RoundNumber(PesoBilanciaRiciclato - PredosatoriRiciclatoCalcoloUmiditaTotale(0), 0)
    PesoBilanciaRiciclatoSecco = RoundNumber(PesoBilanciaRiciclato - PredosatoriRiciclatoCalcoloUmiditaTotale(0), 0)
    '

    '20161230
    'If (ricSecco < 0) Then
    '    ricSecco = 0
    'End If
    '
    'CP240.LblRicSecco(0).caption = CStr(ricSecco)
    If (PesoBilanciaRiciclatoSecco < 0) Then
        PesoBilanciaRiciclatoSecco = 0
    End If
    CP240.LblRicSecco(0).caption = CStr(PesoBilanciaRiciclatoSecco)
    '

End Sub

Public Sub PesoNastroRiciclatoParDrum_change()
  
    Dim ricSecco As Integer

    CP240.LblRamseyRic(1).caption = PesoBilanciaRiciclatoParDrum

    ricSecco = RoundNumber(PesoBilanciaRiciclatoParDrum - TotaleUmiditaPredRicParDrum, 0)
    If (ricSecco < 0) Then
        ricSecco = 0
    End If
    
    CP240.LblRicSecco(1).caption = CStr(ricSecco)

End Sub

Public Sub PesoNastroRiciclato()

	'    Dim tonH As Integer
    Dim tonH As Single
    Dim nuovoPeso As Single
    Dim predosatore As Integer
	'    Dim valoreInt As Integer
    Dim valoreSng As Single
	'
    Dim nuovopesoteorico As Single '20151106
    Dim tonHteorico As Single '20151106
    Dim Criterio As String '20151106
    Dim posizione As Integer '20151106
    Dim valoremaxritardopred As Long '20151106
    Dim predcambioset As Boolean   '20160301
    
    On Error GoTo Errore

    Select Case ConfigPortataNastroRiciclato
        Case nessuna
        
        Case teorica
            nuovoPeso = 0
            For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                If (ListaPredosatoriRic(predosatore).motore.ritorno And val(CP240.TxtPredRicSet(predosatore)) > 0) Then
                    tonH = CSng(TonOrarieAttualiImpianto) * CSng(CP240.TxtPredRicSet(predosatore).text) / 100
                    nuovoPeso = nuovoPeso + tonH
                End If
            Next predosatore

        Case analogica
            valoreSng = CSng(CP240.OPCData.items(PLCTAG_AI_PesoNastroRiciclat).Value)
            nuovoPeso = CSng(SondaDbl_mA(CLng(valoreSng), CLng(PortataMaxRamseyRic), 0, False))

        Case schedaSiwarex
            nuovoPeso = CInt(Siwarex(1).SIWA_PORTATA_NASTRO)
            If Siwarex(1).SIWA_ERR_MSG Then
                If CP240.LblRamseyRic(0).BackColor = vbBlack Then
                    CP240.LblRamseyRic(0).BackColor = vbWhite
                    CP240.LblRamseyRic(0).ForeColor = vbBlack
                Else
                    CP240.LblRamseyRic(0).BackColor = vbBlack
                    CP240.LblRamseyRic(0).ForeColor = vbWhite
                End If
            Else
                CP240.LblRamseyRic(0).BackColor = &HC0E0FF
                CP240.LblRamseyRic(0).ForeColor = vbBlack
            End If
    End Select
    
'20151106
    For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
        If (ListaPredosatoriRic(predosatore).motore.ritorno And val(CP240.TxtPredRicSet(predosatore)) > 0) Then
            tonHteorico = CSng(TonOrarieAttualiImpianto) * CSng(CP240.TxtPredRicSet(predosatore).text) / 100
            nuovopesoteorico = nuovopesoteorico + tonHteorico
        End If
'20160301
        If (ListaPredosatoriRic(predosatore).setAttuale.tempoStart > valoremaxritardopred) And Not (ListaPredosatoriRic(predosatore).immediato) And (val(CP240.TxtPredRicSet(predosatore)) > 0) Then
            valoremaxritardopred = ListaPredosatoriRic(predosatore).setAttuale.tempoStart
        End If
        If (ListaPredosatoriRic(predosatore).stato = predosatoreStarting) Or (ListaPredosatoriRic(predosatore).stato = predosatoreStopping) Then
            predcambioset = True
        End If
'
    Next predosatore

'20160301
'    Call TemporizzatoreStandard( _
'        1, _
'        TolleranzaNastroRAP.TempoRitardoControllo + valoremaxritardopred, _
'        TolleranzaNastroRAP.AppoggioTempo, _
'        TolleranzaNastroRAP.TempoRitardoInCorso, _
'        TolleranzaNastroRAP.TempoRitardoEseguito, _
'        StartPredosatori, _
'        TolleranzaNastroRAP.ErroreTimer _
'        )

    Call TemporizzatoreStandard( _
        1, _
        TolleranzaNastroRAP.TempoRitardoControllo + IIf(predcambioset, valoremaxritardopred, 0), _
        TolleranzaNastroRAP.AppoggioTempo, _
        TolleranzaNastroRAP.TempoRitardoInCorso, _
        TolleranzaNastroRAP.TempoRitardoEseguito, _
        StartPredosatori And Not predcambioset, _
        TolleranzaNastroRAP.ErroreTimer _
        )
'

    Criterio = "DO006"
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
'20160301
'    IngressoAllarmePresente posizione, StartPredosatori And (PesoBilanciaRiciclato > (nuovopesoteorico + TolleranzaNastroRAP.Tolleranza) Or PesoBilanciaRiciclato < (nuovopesoteorico - TolleranzaNastroRAP.Tolleranza))
    IngressoAllarmePresente posizione, TolleranzaNastroRAP.TempoRitardoEseguito And StartPredosatori And (PesoBilanciaRiciclato > (nuovopesoteorico + TolleranzaNastroRAP.Tolleranza) Or PesoBilanciaRiciclato < (nuovopesoteorico - TolleranzaNastroRAP.Tolleranza))
'
    
    If (PesoBilanciaRiciclato <> nuovoPeso) Then
        PesoBilanciaRiciclato = LimitaValoreSng(CSng(nuovoPeso), 0, CSng(TonOrarieImpianto))
        If (PesoBilanciaRiciclato < 0) Then
            PesoBilanciaRiciclato = 0
        End If

        PesoNastroRiciclato_change
    End If

    Exit Sub
Errore:
    LogInserisci True, "NAS-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PesoNastroRiciclatoParDrum()

	'    Dim tonH As Integer
    Dim tonH As Single
    Dim nuovoPeso As Integer
    Dim predosatore As Integer
	'    Dim valoreInt As Integer
    'Dim valoreSng As Single

    On Error GoTo Errore


    Select Case ConfigPortataNastroRiciclatoParDrum
        Case nessuna

        Case teorica
            If ListaPredosatoriRic(0).bilanciaSiwarex Or ListaPredosatoriRic(1).bilanciaSiwarex Or ListaPredosatoriRic(2).bilanciaSiwarex Or ListaPredosatoriRic(3).bilanciaSiwarex Then
                'Somma delle portate siwarex dei singoli predosatori
                nuovoPeso = 0
                For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                    If ListaPredosatoriRic(predosatore).bilanciaSiwarex Then
                        If predosatore <= 1 Then
                            tonH = CSng(Siwarex(2 + predosatore).SIWA_PORTATA_NASTRO)
                        Else
                            tonH = CSng(Siwarex(3 + predosatore).SIWA_PORTATA_NASTRO)
                        End If
                        nuovoPeso = nuovoPeso + tonH
                    End If
                Next predosatore
            Else
                '   Bilancia assente: calcolo teorico
                nuovoPeso = 0
                For predosatore = 0 To NumeroPredosatoriRicInseriti - 1
                    If (ListaPredosatoriRic(predosatore).motore.ritorno And val(CP240.TxtPredRicSet(predosatore)) > 0) Then
                        tonH = TonOrarieAttualiImpianto * CSng(CP240.TxtPredRicSet(predosatore).text) / 100
                        nuovoPeso = nuovoPeso + tonH
                    End If
                Next predosatore
            End If

        Case analogica
        
        Case schedaSiwarex
            nuovoPeso = CInt(Siwarex(7).SIWA_PORTATA_NASTRO)
            If Siwarex(7).SIWA_ERR_MSG Then
                If CP240.LblRamseyRic(1).BackColor = vbBlack Then
                    CP240.LblRamseyRic(1).BackColor = vbWhite
                    CP240.LblRamseyRic(1).ForeColor = vbBlack
                Else
                    CP240.LblRamseyRic(1).BackColor = vbBlack
                    CP240.LblRamseyRic(1).ForeColor = vbWhite
                End If
            Else
                CP240.LblRamseyRic(1).BackColor = &HC0E0FF
                CP240.LblRamseyRic(1).ForeColor = vbBlack
            End If
    End Select
'
           
    If (PesoBilanciaRiciclatoParDrum <> nuovoPeso) Then
        PesoBilanciaRiciclatoParDrum = LimitaValoreSng(CSng(nuovoPeso), 0, CSng(TonOrarieImpianto))
        If (PesoBilanciaRiciclatoParDrum < 0) Then
            PesoBilanciaRiciclatoParDrum = 0
        End If

        PesoNastroRiciclatoParDrum_change
    End If

    Exit Sub
Errore:
    LogInserisci True, "NAS-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'

Public Function SelezioneRicettaPredosaggioCambiata() As Boolean
    'Dim tonH As Integer
    
    SelezioneRicettaPredosaggioCambiata = False
    If RTrim(CP240.adoComboPredosaggio.text) <> RTrim(CP240.LblNomeRicPred.caption) Then
        SelezioneRicettaPredosaggioCambiata = True
    End If
End Function

'In base nastro in ingresso ritorna l'indice assoluto del primo predosatore
'Es.    5 NC1 + 3 NC2 + 1 NRCaldo + 1 NRFreddo + 2 NJolly
'Case Collettore1 = 0
'Case Collettore2 = 5
'Case Collettore3 = 0
'Case RiciclatoCaldo = 0
'Case RiciclatoFreddo = 1
'Case RiciclatoJolly = 2
'Si considera che i predosatori su jolly siano sempre gli ultimi e dichiarati sul freddo
Public Function PrimoPredosatoreDelNastro(nastro As NastriPredosatori) As Integer
	'Dim numDiPredSuJolly As Integer
	'Dim predosatore As Integer

    Select Case nastro

        Case Collettore1
            '0
        Case Collettore2
            PrimoPredosatoreDelNastro = NumeroPredosatoriNastroC(Collettore1)
        Case Collettore3
            PrimoPredosatoreDelNastro = NumeroPredosatoriNastroC(Collettore1) + NumeroPredosatoriNastroC(Collettore2)
        Case RiciclatoCaldo
            PrimoPredosatoreDelNastro = 0
        Case RiciclatoFreddo
            PrimoPredosatoreDelNastro = NumeroPredosatoriNastroC(RiciclatoCaldo)
        Case RiciclatoJolly
            If (ListaMotori(MotoreNastroRapJolly).presente) Then
                PrimoPredosatoreDelNastro = NumeroPredosatoriNastroC(RiciclatoCaldo) + (NumeroPredosatoriNastroC(RiciclatoFreddo) - NumeroPredosatoriNastroC(RiciclatoJolly))
            Else
                PrimoPredosatoreDelNastro = 0
            End If
        Case Else
            Debug.Assert False

    End Select

End Function

'Invocata direttamente da VideataPrincipale; al max una chiamata al secondo
'Aggiorna totatilizzazione peso dei nastri elevatori, se la bilancia non é inclusa 'PesoBilanciaxxx' utilizza un valore teorico.
Public Sub GestioneConsumi()
    Dim sogliaInerti As Integer     'soglie min. per conteggio consumo, per valori inferiori si considera il nastro vuoto
    Dim sogliaRAP As Integer
    Dim pesoBilancia As Double      'peso istantaneo sul nastro
    Dim tempoTrascorso As Long      'Tempo trascorso dall'ultima invocazione (min. 1 sec), necessario per ricavare il peso istantaneo sul nastro
    Dim coeffTemp As Double         'coefficiente per calcolo peso istantaneo su nastro
    Dim tick As Long                'istante di invocazione


    On Error GoTo Errore
    
    '20170113
    Call TemporizzatoreStandard(1, 2, impulsoResetTotNastri.AppTempo, _
                            impulsoResetTotNastri.TempoExec, impulsoResetTotNastri.uscita, _
                            impulsoResetTotNastri.Abilitazione, impulsoResetTotNastri.ErrTimer)

    If impulsoResetTotNastri.uscita Then
        CP240.OPCData.items(PLCTAG_Reset_Totalizzatore_Nastro_Agg).Value = False
        CP240.OPCData.items(PLCTAG_Reset_Totalizzatore_Nastro_Ric).Value = False
        CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Ric_Par).Value = False
        impulsoResetTotNastri.Abilitazione = False
    End If
    '
    
    sogliaInerti = 10   'Kg al di sopra dei quali si considera che ci sia materiale sul nastro
    sogliaRAP = 2
    'acquisisco istante di invocazione (sec.)
    tick = ConvertiTimer()

    'Prima invocazione: aggiorno il timer
    If (GestioneConsumi_Timer = 0) Then GestioneConsumi_Timer = tick
    
    'Chiamata al max ogni secondo, non piú frequentemente
    If (tick = GestioneConsumi_Timer) Then Exit Sub
    
    tempoTrascorso = ConvertiTimer - GestioneConsumi_Timer 'Secondi trascorsi dall'ultima esecuzione, "in condizioni normali" = 1
    GestioneConsumi_Timer = tick 'Memorizza l'istante di chiamata (per calcolo coefficiente alla prox invocazione)
    
    tempoTrascorso = IIf(tempoTrascorso = 0, 1, tempoTrascorso) 'anche se impossibile scongiuro divisione per 0
    coeffTemp = 3600 / tempoTrascorso   'COEFFICIENTE PER CALCOLO PESO IN TRANSITO SUL NASTRO
    
    'Condizioni di aggiornamento consumi
    ' - Nastro in moto + peso sopra la soglia + (bilancia inclusa o abilitazione visualiz. portata)
    '##### Nastro elevatore inerti

    If (ConfigPortataNastroInerti = schedaSiwarex) Or (ConfigPortataNastroInerti = analogica) Then
        'Gestione totalizzatore su PLC (+ preciso)
        TotalizzazioneNastroAggr = CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Agg).Value
        CP240.LblConsumi(0).caption = RoundNumber(TotalizzazioneNastroAggr, 2)
    Else
        If ( _
            ListaMotori(MotoreNastroElevatoreFreddo).ritorno And _
            RoundNumber(PesoBilanciaInerti, 0) > sogliaInerti And _
            (ConfigPortataNastroInerti > 0) _
        ) Then
            pesoBilancia = PesoBilanciaInerti / coeffTemp
            TotalizzazioneNastroAggr = TotalizzazioneNastroAggr + pesoBilancia
            CP240.LblConsumi(0).caption = RoundNumber(TotalizzazioneNastroAggr, 2)
        End If
    End If
'

    '##### Nastro RAP
'20151107
'    If ( _
'        ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno And _
'        PesoBilanciaRiciclato > sogliaRAP And _
'        (ConfigPortataNastroRiciclato > 0) _
'    ) Then
'        pesoBilancia = PesoBilanciaRiciclato / coeffTemp
'        TotalizzazioneNastroRAP = TotalizzazioneNastroRAP + pesoBilancia
'        CP240.LblConsumi(1).caption = RoundNumber(TotalizzazioneNastroRAP, 2)
'    End If
    If (ConfigPortataNastroInerti = schedaSiwarex) Or (ConfigPortataNastroInerti = analogica) Then
        'Gestione totalizzatore su PLC (+ preciso)
        TotalizzazioneNastroRAP = CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Ric).Value
        CP240.LblConsumi(1).caption = RoundNumber(TotalizzazioneNastroRAP, 2)
    Else
        If ( _
            ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno And _
            PesoBilanciaRiciclato > sogliaRAP And _
            (ConfigPortataNastroRiciclato > 0) _
        ) Then
            pesoBilancia = PesoBilanciaRiciclato / coeffTemp
            TotalizzazioneNastroRAP = TotalizzazioneNastroRAP + pesoBilancia
            CP240.LblConsumi(1).caption = RoundNumber(TotalizzazioneNastroRAP, 2)
        End If
    End If
'
        
    '##### Nastro RAP ER (Essiccatore riciclato)
    If (ConfigPortataNastroInerti = schedaSiwarex) Or (ConfigPortataNastroInerti = analogica) Then
        'Gestione totalizzatore su PLC (+ preciso)
        TotalizzazioneNastroRAPParDrum = CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Ric_Par).Value
        CP240.LblConsumi(2).caption = RoundNumber(TotalizzazioneNastroRAPParDrum, 2)
    Else
        If ( _
            ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno And _
            PesoBilanciaRiciclatoParDrum > sogliaRAP And _
            (ConfigPortataNastroRiciclatoParDrum > 0) _
        ) Then
            pesoBilancia = PesoBilanciaRiciclatoParDrum / coeffTemp
            TotalizzazioneNastroRAPParDrum = TotalizzazioneNastroRAPParDrum + pesoBilancia
            CP240.LblConsumi(2).caption = RoundNumber(TotalizzazioneNastroRAPParDrum, 2)
        End If
    End If
'

    Exit Sub
Errore:
    LogInserisci True, "NAS-008", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ResetTotalizzatoriNastri(nastro As Integer)

    Select Case nastro
        Case 0 'Nastro elevatore freddo aggregati
            If (ConfigPortataNastroInerti = schedaSiwarex) Or (ConfigPortataNastroInerti = analogica) Then
                CP240.OPCData.items(PLCTAG_Reset_Totalizzatore_Nastro_Agg).Value = True
                CP240.LblConsumi(0).caption = RoundNumber(TotalizzazioneNastroAggr, 2)
                impulsoResetTotNastri.Abilitazione = True
            ElseIf ConfigPortataNastroInerti = teorica Then '20151104
                TotalizzazioneNastroAggr = 0
                CP240.LblConsumi(0).caption = TotalizzazioneNastroAggr
            End If
        Case 1  'Nastro elevatore RAP
            If (ConfigPortataNastroRiciclato = schedaSiwarex) Or (ConfigPortataNastroRiciclato = analogica) Then
                CP240.OPCData.items(PLCTAG_Reset_Totalizzatore_Nastro_Ric).Value = True
                CP240.LblConsumi(1).caption = RoundNumber(TotalizzazioneNastroRAP, 2)
                impulsoResetTotNastri.Abilitazione = True
            ElseIf ConfigPortataNastroInerti = teorica Then '20151104
                TotalizzazioneNastroRAP = 0
                CP240.LblConsumi(1).caption = TotalizzazioneNastroRAP
            End If
        Case 2  'Nastro elevatore RAP tamburo parallelo
            If (ConfigPortataNastroRiciclatoParDrum = schedaSiwarex) Or (ConfigPortataNastroRiciclatoParDrum = analogica) Then
                CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Ric_Par).Value = True
                CP240.LblConsumi(2).caption = RoundNumber(TotalizzazioneNastroRAPParDrum, 2)
                impulsoResetTotNastri.Abilitazione = True
            ElseIf ConfigPortataNastroRiciclatoParDrum = teorica Then '20151104
                TotalizzazioneNastroRAP = 0
                CP240.LblConsumi(1).caption = TotalizzazioneNastroRAP
            End If
        Case 3
            'azzero tutto
            If (ConfigPortataNastroInerti = schedaSiwarex) Or (ConfigPortataNastroInerti = analogica) Then
                CP240.OPCData.items(PLCTAG_Reset_Totalizzatore_Nastro_Agg).Value = True
                CP240.LblConsumi(0).caption = RoundNumber(TotalizzazioneNastroAggr, 2)
                impulsoResetTotNastri.Abilitazione = True
            ElseIf ConfigPortataNastroInerti = teorica Then '20151104
                TotalizzazioneNastroAggr = 0
                CP240.LblConsumi(0).caption = TotalizzazioneNastroAggr
            End If
            If (ConfigPortataNastroRiciclato = schedaSiwarex) Or (ConfigPortataNastroRiciclato = analogica) Then
                CP240.OPCData.items(PLCTAG_Reset_Totalizzatore_Nastro_Ric).Value = True
                CP240.LblConsumi(1).caption = RoundNumber(TotalizzazioneNastroRAP, 2)
                impulsoResetTotNastri.Abilitazione = True
            ElseIf ConfigPortataNastroInerti = teorica Then '20151104
                TotalizzazioneNastroRAP = 0
                CP240.LblConsumi(1).caption = TotalizzazioneNastroRAP
            End If
            If (ConfigPortataNastroRiciclatoParDrum = schedaSiwarex) Or (ConfigPortataNastroRiciclatoParDrum = analogica) Then
                CP240.OPCData.items(PLCTAG_Totalizzatore_Nastro_Ric_Par).Value = True
                CP240.LblConsumi(2).caption = RoundNumber(TotalizzazioneNastroRAPParDrum, 2)
                impulsoResetTotNastri.Abilitazione = True
            ElseIf ConfigPortataNastroRiciclatoParDrum = teorica Then '20151104
                TotalizzazioneNastroRAP = 0
                CP240.LblConsumi(1).caption = TotalizzazioneNastroRAP
            End If
    End Select

End Sub

