Attribute VB_Name = "GestioneLivelliSiliFillerVaglio"
Option Explicit

'   FILLER DMR
Public LivelloFillerRecupero As Boolean
Public LivelloFillerApporto As Boolean
Public LivelloFillerApporto2 As Boolean
Public LivelloMaxF1 As Boolean
Public LivelloMaxF2 As Boolean

Public CameraEspansioneFillerRecupero As Boolean
Public InclusioneEvacuazioneFillerRecuperoDMR As Boolean
Public InclusioneEvacuazioneSiloFiller As Boolean

Public LivelloMaxCameraEspansioneFillerRecupero As Boolean
Public LivelloMedCameraEspansioneFillerRecupero As Boolean
Public LivelloMinCameraEspansioneFillerRecupero As Boolean
Public LivelloMax2CameraEspansioneFillerRecupero As Boolean
Public LivelloMed2CameraEspansioneFillerRecupero As Boolean
Public LivelloMin2CameraEspansioneFillerRecupero As Boolean
Public LivelloMax3CameraEspansioneFillerRecupero As Boolean '20151228
Public LivelliContinuiCameraEspansioneFillerRecupero As Boolean '20151120
Public LivelliContinuiCameraEspansioneFillerRecuperoMaxPercAllarme As Long '20151120
Public ValoreLivelloContCameraEspFilRec_SX As Long  '20151120
Public ValoreLivelloContCameraEspFilRec_DX As Long  '20151120
Public ValoreLivelloContCameraEspFilRec_CE As Long  '20151228

Public LivelloMinSiloFillerRecupero As Boolean
Public LivelloMaxSiloFillerRecupero As Boolean

Public FCMinSiloFiller2 As Boolean
Public FCMedSiloFiller2 As Boolean
Public FCMaxSiloFiller2 As Boolean
Public FCMinSiloFiller3 As Boolean
'Public FCMedSiloFiller3 As Boolean
Public FCMaxSiloFiller3 As Boolean
'
Public LivelliFillerContinui As Boolean
Public LivelloTramoggia(0 To 19) As Integer
Public LivelloRiscalaMaxTramoggia(0 To 19) As Integer
Public LivelloRiscalaMinTramoggia(0 To 19) As Integer
Public LivelloRiscalaMaxFiller(0 To 3) As Integer
Public LivelloRiscalaMinFiller(0 To 3) As Integer
Public ValoreLivelloSiloFiller(0 To 3) As Long
Public FineRitardoConteggioF(0 To 2) As Boolean
Public PesaturaAvvenutaF(0 To 2) As Boolean

Public LivelloSiloFillerContinuo(1 To 3) As Integer
Public LivelloMaxSiloFiller(1 To 3) As Boolean
Public LivelloMinSiloFiller(1 To 3) As Boolean

Public LivelloMaxSiloFillerAn As Integer            'Valore che deve assumere il livello analogico del silo (F1, F2, F3, ...) perché sia considerato al MIN
Public LivelloMinSiloFillerAn As Integer            'Valore che deve assumere il livello analogico del silo (F1, F2, F3, ...) perché sia considerato al MAX

Public SelezioneF3 As Boolean '20151221

Public Sub ValoreLivelloSiloFiller_change(silo As Integer)

    On Error GoTo Errore

    Call SiloFillerLivello(silo, ValoreLivelloSiloFiller(silo))

    Exit Sub
Errore:
    LogInserisci True, "LVL-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub LivelliDigitaliSiloFiller()

    On Error GoTo Errore

    If LivelliFillerContinui Then
        Exit Sub
    End If

    If LivelloMaxSiloFillerRecupero Then            'Livello massimo Filler 1
        ValoreLivelloSiloFiller(0) = 100
    ElseIf LivelloMinSiloFillerRecupero Then        'Livello minimo Filler 1
        ValoreLivelloSiloFiller(0) = 25
    Else
        ValoreLivelloSiloFiller(0) = 0
    End If
    Call ValoreLivelloSiloFiller_change(0)

'20150624
'    If (GestioneFiller2 = 1 Or GestioneFiller2 = 2) Then
    If (GestioneFiller2 = FillerIncluso) Or (GestioneFiller2 = FillerSoloVisSilo) Then
'
        If FCMaxSiloFiller2 Then       'Livello massimo Filler 2
            ValoreLivelloSiloFiller(1) = 100
        ElseIf FCMedSiloFiller2 Then   'Livello medio Filler 2
            ValoreLivelloSiloFiller(1) = 50
        ElseIf FCMinSiloFiller2 Then   'Livello minimo Filler 2
            ValoreLivelloSiloFiller(1) = 25
        Else
            ValoreLivelloSiloFiller(1) = 0
        End If
        Call ValoreLivelloSiloFiller_change(1)
    End If

'20151030
''20150708
''    If (InclusioneF3) Then
'    If InclusioneF3 Or (GestioneFiller3 = FillerSoloVisSilo) Then
    If (GestioneFiller3 = FillerIncluso) Or (GestioneFiller3 = FillerSoloVisSilo) Then
'
        If FCMaxSiloFiller3 Then       'Livello massimo Filler 3
            ValoreLivelloSiloFiller(2) = 100
        ElseIf FCMinSiloFiller3 Then   'Livello minimo Filler 3
            ValoreLivelloSiloFiller(2) = 25
        Else
            ValoreLivelloSiloFiller(2) = 0
        End If
        Call ValoreLivelloSiloFiller_change(2)
    End If

    Exit Sub
Errore:
    LogInserisci True, "LVL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub LivelloTramoggia_change(tramoggia As Integer)

Dim TramoggiaCP240 As Integer

    On Error GoTo Errore

    TramoggiaCP240 = tramoggia
    
    If TramoggiaCP240 = 18 Then
        ComponenteLivello DosaggioRAP, NormalizzazioneA100(LivelloTramoggia(tramoggia), 100, 0, LivelloRiscalaMaxTramoggia(tramoggia), LivelloRiscalaMinTramoggia(tramoggia))
    Else
        ComponenteLivello DosaggioAggregati(TramoggiaCP240), NormalizzazioneA100(LivelloTramoggia(tramoggia), 100, 0, LivelloRiscalaMaxTramoggia(tramoggia), LivelloRiscalaMinTramoggia(tramoggia))
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "LVL-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub



Public Function CocleaFillerApportoDaAccendere(accendi As Boolean) As Boolean

    Dim forzaSpegnimento As Boolean

    CocleaFillerApportoDaAccendere = False

    If (Not InclusioneF2) Then
        Exit Function
    End If

    If (Not InclusioneTramoggiaTamponeF2) Then
        'Coclea estrattrice in pesata
        CocleaFillerApportoDaAccendere = (Not ScattoTermicaCocleaPesataF2 And RitornoPesataFiller(1))

        Exit Function
    End If

    If (AbilitaBindicatorFillerEsterni) Then
        CocleaFillerApportoDaAccendere = True
        Exit Function
    End If

    If ((Not LivelloMaxF2 And Not LivelloFillerApporto) Or (LivelloMaxF2 And LivelloFillerApporto)) Then
        'Il livello alto (o non basso) deve sempre fermare, manuale o automatico che sia
        CocleaFillerApportoDaAccendere = False
        forzaSpegnimento = (Not CocleaFillerApportoDaAccendere)
    Else
        If (CP240.AniPushButtonDeflettore(15).Value = 1 And MotoriInAutomatico) Then
            'In automatico si può partire
            CocleaFillerApportoDaAccendere = True
        Else
            'In manuale comanda la coclea
            CocleaFillerApportoDaAccendere = ListaMotori(MotoreCocleaEstrazioneFillerApporto).ritorno
        End If
    End If

End Function
'

Public Sub LivelloFillerApporto_change()

    On Error GoTo Errore

    If (Not FrmGestioneTimer.TmrBindicatorApporto.enabled) Then
        FrmGestioneTimer.TmrBindicatorApporto.Interval = tempoAttesaMotOn * 1000
        FrmGestioneTimer.TmrBindicatorApporto.enabled = True
    End If

    Exit Sub
Errore:
    LogInserisci True, "LVL-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function CocleaFillerRecuperoDaAccendere(accendi As Boolean) As Boolean

    Dim forzaSpegnimento As Boolean

    CocleaFillerRecuperoDaAccendere = False

    If (Not InclusioneTramoggiaTamponeF1) Then
        'Coclee in pesata
        CocleaFillerRecuperoDaAccendere = (Not ScattoTermicaCocleaPesataF1 And RitornoPesataFiller(0))

        Exit Function
    End If
    
    If (AbilitaBindicatorFillerEsterni) Then
        CocleaFillerRecuperoDaAccendere = True
        Exit Function
    End If


    If ((Not LivelloMaxF1 And Not LivelloFillerRecupero) Or (LivelloMaxF1 And LivelloFillerRecupero)) Then
        'Il livello alto (o non basso) deve sempre fermare, manuale o automatico che sia
        'A meno che non si sia in evacuazione
        CocleaFillerRecuperoDaAccendere = (EvacuazioneFiltroDMR And RitornoEvacuazioneFiltroDMR)
        forzaSpegnimento = (Not CocleaFillerRecuperoDaAccendere)
    Else
        If (CP240.AniPushButtonDeflettore(2).Value = 1 And MotoriInAutomatico) Then
            'In automatico si può partire
            CocleaFillerRecuperoDaAccendere = True
        Else
            'In manuale comanda la coclea filtro
            CocleaFillerRecuperoDaAccendere = ListaMotori(MotoreCocleaFiltro).ritorno Or (EvacuazioneFiltroDMR And RitornoEvacuazioneFiltroDMR)
        End If
    End If

End Function
'

Public Sub LivelloFillerRecupero_change()

    On Error GoTo Errore

    If (Not FrmGestioneTimer.TmrBindicatorRecupero.enabled) Then
        FrmGestioneTimer.TmrBindicatorRecupero.Interval = tempoAttesaMotOn * 1000
        FrmGestioneTimer.TmrBindicatorRecupero.enabled = True
    End If

    Exit Sub
Errore:
    LogInserisci True, "LVL-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ComandoPesataFiller_change(filler As Integer)

    On Error GoTo Errore

    'filler := da 0 a 2

    Call ComponenteInPesata(DosaggioFiller(filler), ComandoPesataFiller(filler))

    Exit Sub
Errore:
    LogInserisci True, "LVL-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function CambioRicettaSenzaF2toF2() As Boolean
    
    With CP240.AdoDosaggioNext.Recordset
        If (Not .EOF) Then
            CambioRicettaSenzaF2toF2 = (.Fields("Filler2") <> 0)
        End If
    End With

End Function

Public Function CambioRicettaSenzaF3toF3() As Boolean

    With CP240.AdoDosaggioNext.Recordset
        If (Not .EOF) Then
            CambioRicettaSenzaF3toF3 = (.Fields("Filler3") <> 0)
        End If
    End With

End Function

Public Sub LivelloFillerApporto2_change()
    
    On Error GoTo Errore

    If Not InclusioneDMR Then
    
        CocleaFillerApporto2DaAccendere True
    
    End If

    Exit Sub
Errore:
    LogInserisci True, "LVL-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
'

Public Function CocleaFillerApporto2DaAccendere(accendi As Boolean) As Boolean
    
    If Not ListaMotori(MotoreElevatoreF2).presente Then
        Exit Function
    End If

    CocleaFillerApporto2DaAccendere = False

    If Not InclusioneF3 Then
        Exit Function
    End If

    If AbilitaBindicatorFillerEsterni Then
        CocleaFillerApporto2DaAccendere = True
    End If

    If (CP240.AniPushButtonDeflettore(28).Value = 1 And MotoriInAutomatico) Then
        CocleaFillerApporto2DaAccendere = LivelloFillerApporto2
    Else
        CocleaFillerApporto2DaAccendere = ListaMotori(MotoreCocleaEstrazioneFillerApporto).ritorno
    End If

    If (accendi) Then
        '   Accensione vera e propria
        If (CocleaFillerApporto2DaAccendere) Then
            If (ListaMotori(MotoreElevatoreF2).ritorno) Then
                'elevatore filler 2 in moto
                If (Not ListaMotori(MotoreCocleaEstrazioneFillerApporto).ritorno) Then
                    'Coclea Estr. F.App.2 ferma
                    Call SetMotoreUscita(MotoreCocleaEstrazioneFillerApporto, True)
                End If
            End If
        Else
            Call SetMotoreUscita(MotoreCocleaEstrazioneFillerApporto, False)
        End If
    End If

End Function
'

Public Sub APBScambioFillerRecuperoInApporto_Change(comando As Boolean)

    If Not AbilitaValvolaTroppoPienoF1 Then     'nel caso non sia prevista la valvola nell'impianto ma soltanto il tubo troppo pieno
        Exit Sub
    End If

    If ( _
        Not ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(2)) Or _
        (ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(1)) Or _
        (ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(3) _
    ) Then
        ScambioFillerRecuperoInApporto = False
    Else
        ScambioFillerRecuperoInApporto = comando
    End If
                                
    CP240.OPCData.items(PLCTAG_DO_ApertTuboTroppoPienoF1).Value = ScambioFillerRecuperoInApporto
    
    If ScambioFillerRecuperoInApporto Then
        CP240.AniPushButtonDeflettore(23).Value = 2
    Else
        CP240.AniPushButtonDeflettore(23).Value = 1
    End If

End Sub

Public Sub APBScambioTuboTroppoPienoF1F2_Change(comando As Boolean)

    If GestioneScambioTuboTroppoPieno = ScambioF1F2 Then

        If ( _
            (Not ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(2)) Or _
            (ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(1)) Or _
            (Not LivelloMaxSiloFiller(1) And Not LivelloMaxSiloFiller(2)) _
        ) Then
            ScambioTuboTroppoPienoF1F2 = Not ScambioTuboTroppoPienoF1F2
        End If
                                           
        If (Not DEMO_VERSION) Then
            CP240.OPCData.items(PLCTAG_DO_Dest_Trop_Pieno_F1F2).Value = ScambioTuboTroppoPienoF1F2
        End If
        
        If ScambioTuboTroppoPienoF1F2 Then
            CP240.AniPushButtonDeflettore(35).Value = 2 'F1
        Else
            CP240.AniPushButtonDeflettore(35).Value = 1 'F2
        End If
        
    ElseIf GestioneScambioTuboTroppoPieno = ScambioF2F3 Then

        If ( _
            (Not ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(2)) Or _
            (ScambioTuboTroppoPienoF1F2 And LivelloMaxSiloFiller(3)) Or _
            (Not LivelloMaxSiloFiller(3) And Not LivelloMaxSiloFiller(2)) _
        ) Then
            ScambioTuboTroppoPienoF1F2 = Not ScambioTuboTroppoPienoF1F2
        End If
        
        If (Not DEMO_VERSION) Then
            CP240.OPCData.items(PLCTAG_DO_Dest_Trop_Pieno_F1F2).Value = ScambioTuboTroppoPienoF1F2
        End If
        
        If ScambioTuboTroppoPienoF1F2 Then
            CP240.AniPushButtonDeflettore(35).Value = 1 'F3
        Else
            CP240.AniPushButtonDeflettore(35).Value = 2 'F2
        End If
    
    End If

End Sub
'20151218
'Public Sub SelezioneF23_change(value As Integer)
'    On Error GoTo ERRORE
'        Select Case value
'            Case 1
'                'priorità F3
''                CP240.AniPushButtonDeflettore(16) = 2
'                CP240.OPCData.items(PLCTAG_SelezioneF3).value = True
'            Case 2
'                'priorità F2
''                CP240.AniPushButtonDeflettore(16) = 1
'                CP240.OPCData.items(PLCTAG_SelezioneF3).value = False
'        End Select
'    Exit Sub
'ERRORE:
'    LogInserisci True, "LVL-008", CStr(Err.Number) + " [" + Err.description + "]"
'End Sub
