Attribute VB_Name = "GestioneBruciatore"
Option Explicit

Public OraStopPredosatori As Long
Public OraStartPredosatori As Long
Public OraStopPredosatoriRic As Long
Public OraStartPredosatoriRic As Long
Public TemperaturaLavoroFiltroOK As Boolean
Public MinTempEssicatore As Long
Public MaxTempEssicatore As Long
Public MinTempEssicatore2 As Long
Public MaxTempEssicatore2 As Long
'
'20161230 Public ResetPID As Boolean
'20161230 Public ErrorePID As Boolean
'20161230 Public TempoDurataCorr As Double
'20161230 Public FattoreDiCorrezioneKi As Double
'20161230 Public FattoreDiCorrezioneKd As Double
'20161230 Public FattoreDiCorrezioneKp As Long
'20161230 Public TInterventoCampionamento As Long

Public NumeroLettureScivolo As Long
'Public SelezioneStopFiamma(0 To 2) As Boolean
Public StopFiammaDopoNastri As Boolean
'
Public ManualeAriaFredda As Boolean

Public Enum ModulatoreStatusEnum
  ModulatoreNone
  ModulatoreUP
  Modulatoredown
End Enum

Public Type ModulatoreType
  manuale As Boolean
  'la depressione si trova dentro al tamburo -> ListatTamburi(x).depressioneBruciatore
  posizione As Long
  min As Long
  max As Long
  Stato As ModulatoreStatusEnum
End Type

Public ModulatoreAspirazioneFiltro As ModulatoreType
Public ModulatoreAriaFreddaFiltro As ModulatoreType
Public TamburoAssociatoAlPID As Integer

Public Enum CodiceColoriCasellaTemp
    azzurroblu 'testo blu su sfondo azzurro
    gialloblu 'testo blu su sfondo giallo
    grigioblu 'testo blu su sfondo grigio
End Enum

Public VisualizzaTempScambComb As Boolean

Public BrucAutoPreriscaldo As Boolean

Public avvCaldo_prenotazione As Boolean '20150630

'21060923
Public ValvolaDieselPresente As Boolean
'
Public ValvolaDieselAperta As Boolean '20151108
'21060923
Public ValvolaOlioCombPresente As Boolean
Public ValvolaOlioCombAperta As Boolean
'

'20161128
Public GestioneFumiTamburo As TypeGestioneFumiTamburo
Public Const IndexGestioneFumiTamburo As Integer = 12

Public Type TypeGestioneFumiTamburo
    inclusione As Boolean
    Modulatore As ModulatoreType
    Depressione_vaglio As Long
    Fondoscala_depr_vaglio As Double
    Riscalatura_mod_fumi_tamb As Double
End Type
'20161128
'20161130
Public Type TypeGestioneVelocitaTamburo
    inclusione As Boolean
    Modulatore As ModulatoreType
    MaxVelocita As Double
    '20170215
    DefaultVelocita As Double
    '
End Type
Public GestioneVelocitaTamburo As TypeGestioneVelocitaTamburo
'20161130
Public ChiusuraForzVelocitaTamburo As Boolean   '20170208
'20161230
Public FormPIDBruc_Visible As Boolean
'



Public Sub FiammaBruciatorePresente_change(tamburo As Integer)
    Dim litri As Double
    Dim rs As New adodb.Recordset
    Dim rotazioneEssiccatore As Integer
    Dim elevatore As Integer

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If (tamburo = 0) Then
            rotazioneEssiccatore = MotoreRotazioneEssiccatore
            elevatore = MotoreNastroElevatoreFreddo
        Else
            rotazioneEssiccatore = MotoreRotazioneEssiccatore2
            elevatore = MotoreElevatoreRiciclato
        End If

        If (.FiammaBruciatorePresente) Then
            
            Call DimensionaFiamma(tamburo)  '20170322
            
            'Bruciatore appena acceso
    
            .MemoriaAccensioneBruciatore = True
    
            .OraStartBruciatore = ConvertiTimer()
            
            If (.AbilitazioneConsumoCombustibile) Then
                'Azzero la partenza del contalitri combustibile
                .PartenzaLitriCombustibileUtilizzati = .LitriCombustibileUtilizzati
            End If
    
            'Quando si riaccende il bruciatore in seguito ad un avviamento a caldo devo accendere il tamburo, il nastro elev. freddo
            'Devo anche riportare i motori in gestione automatica
            If .AvviamentoBruciatoreCaldo Then
                'Call SetMotoreUscita(rotazioneEssiccatore, True)
                'Call SetMotoreUscita(elevatore, True)
                If (tamburo = 0) Then
                    'Se per un qualche motivo è spento, lo riaccendo per evitare ritardi...
                    'Call SetMotoreUscita(MotoreElevatoreCaldo, True)
                End If

                Call RimettiAutomaticoMotori
            End If
    
            OraStopBruciatore = 0

            If ListaTemperature(TempUscitaFiltro).valore < ValoreTempLavoroFiltro Then
                CP240.AniPushButtonDeflettore(5).Value = 1
                Call BruciatoreInManuale(0)
                CP240.AniPushButtonDeflettore(5).enabled = False
                BrucAutoPreriscaldo = True
            End If

        Else
            'Bruciatore appena spento
    
            '20161230
            Call BruciatoreInManuale(tamburo)
            '

            '20170206
            'Sullo spegnimento del bruciatore si arresta il predosaggio se non è bypassata la fiamma
            Dim almenounpredacceso As Boolean
            Dim NumPred As Integer
            almenounpredacceso = False
            For NumPred = 0 To NumeroPredosatoriInseriti - 1
                If ListaPredosatori(NumPred).motore.uscita <> 0 Then
                    almenounpredacceso = True
                End If
            Next NumPred
            For NumPred = 0 To NumeroPredosatoriRicInseriti - 1
                If ListaPredosatoriRic(NumPred).motore.uscita <> 0 Then
                    almenounpredacceso = True
                End If
            Next NumPred
            If ((Not AvvioPredosatoriSenzaBruciatore) And almenounpredacceso) Then
                Call PredosatoriArrestoImmediato(False, -1)
                Call PredosatoriArrestoImmediato(True, -1)
            End If
            '20170206
            
            'Se va in blocco il bruciatore devo fermare il tamburo
            If (Not ListaTamburi(tamburo).EsclusioneAvviamentoCaldo) Then
                Call StopBruciatoreTamburo(tamburo)
            Else
                Call StopBruciatore(tamburo)
            End If
            '

            If (.AbilitazioneConsumoCombustibile) Then
                'Memorizzo il contalitri combustibile
                
                litri = .LitriCombustibileUtilizzati - .PartenzaLitriCombustibileUtilizzati
'20151204
                If (litri > 0) Then
'                    'Inserisce nello storico odierno
'                    With rs
'                        Set .ActiveConnection = DBcon
'                        .Source = "Select * From ConsumoMateriali;"
'                        .LockType = adLockOptimistic
'                        .CursorLocation = adUseClient
'                        .CursorType = adOpenStatic
'                        .Open , DBcon
'                    End With
'
'                    rs.AddNew
'                    rs!data = Now
'                    rs!combustibile = litri
'                    rs.Update
                
                    If ListaTamburi(0).IdCombustibileLOG <> 0 Then
                        With rs
                            Set .ActiveConnection = DBcon
                            .Source = "Select * From MovimentazioneMateriali;"
                            .LockType = adLockOptimistic
                            .CursorLocation = adUseClient
                            .CursorType = adOpenStatic
                            .Open , DBcon
                        End With
        
                        rs.AddNew
                        rs!data = Now
                        rs!IdMaterialeLog = ListaTamburi(0).IdCombustibileLOG
                        rs!tipo = 1
                        rs!Quantita = litri
                        rs!note = ""
                        rs.Update
                    End If
'
                End If
            
            End If

            OraStopBruciatore = ConvertiTimer()

            BrucAutoPreriscaldo = False

        End If

        Call BrucInAccensione(tamburo)

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub BloccoFiammaBruciatore_change(tamburo As Integer)

    On Error GoTo Errore

    If ListaTamburi(tamburo).BloccoFiammaBruciatore = True Then
        ListaTamburi(tamburo).MemPosModulatoreAvvioCaldo = ListaTamburi(tamburo).posizioneModulatoreBruciatore
    End If

    If (tamburo = 0) Then
        Call MotoreAggiornaGrafica(MotoreRotazioneEssiccatore)
    Else
        Call MotoreAggiornaGrafica(MotoreRotazioneEssiccatore2)
    End If

    If (ListaTamburi(tamburo).BruciatoreAutomatico And ListaTamburi(tamburo).BloccoFiammaBruciatore) Then
        Call BruciatoreInManuale(tamburo)
    End If

    If (Not ListaTamburi(tamburo).EsclusioneAvviamentoCaldo) Then
        Call StopBruciatoreTamburo(tamburo)
    Else
        If ListaTamburi(tamburo).BloccoFiammaBruciatore Then
            Call StopBruciatore(tamburo)
        End If

    End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PressioneInsufficienteOlioCombustibile_change(tamburo As Integer)

    On Error GoTo Errore

    Exit Sub
Errore:
    LogInserisci True, "BRU-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ImpulsiContalitriCombustibile_change(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If (.AbilitazioneConsumoCombustibile And .ImpulsiPerLitroCombustibile > 0) Then
            .LitriCombustibileUtilizzati = CDbl(.ImpulsiContalitriCombustibile) / .ImpulsiPerLitroCombustibile
            CP240.lblLitriCombUtilizzati(tamburo).caption = Format(.LitriCombustibileUtilizzati - .ParzialeLitriCombustibile, "###0")
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TempSondaAggiuntivaUscitaTamburo_change()

    On Error GoTo Errore

    CP240.LblTempMateriale(3).caption = ListaTemperature(TempTamburoUscita).valore
    If ListaTemperature(TempTamburoUscita).valore < MinTempEssicatore Then
        Call ColoreCasellaTemperatura(CP240.LblTempMateriale(3), grigioblu)
    Else
        Call ColoreCasellaTemperatura(CP240.LblTempMateriale(3), azzurroblu)
    End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TempIngressoTamburo_change()

    On Error GoTo Errore

    CP240.LblTempMateriale(4).caption = ListaTemperature(TempTamburoIngresso).valore

    Exit Sub
Errore:
    LogInserisci True, "BRU-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AggiornaTemperaturaTorre()

    On Error GoTo Errore

    'Niente di selezionato
    TemperaturaTorre = 0

    With CP240.AdoDosaggio.Recordset
        If Not .EOF Then
            If (.Fields("AggregatoNV").Value = 0) Then
                'SABBIA
                TemperaturaTorre = ListaTemperature(TempTorre0).valore
            ElseIf (.Fields("AggregatoNV").Value > 0) Then
                'N.V.
                TemperaturaTorre = ListaTemperature(TempTorre1).valore
            End If
        End If
    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TempTorre_change(Index As Integer, temperatura As Long)

    On Error GoTo Errore

    Select Case Index
        Case 0
            'SABBIA
            ComponenteTemperatura DosaggioAggregati(NTramoggeA), CDbl(temperatura)

        Case 1
            'N.V.
            ComponenteTemperatura DosaggioAggregati(7), CDbl(temperatura)

        Case 2
            'N.V.2
            ComponenteTemperatura DosaggioAggregati(IIf(NTramoggeA - 1 >= 0, NTramoggeA - 1, 0)), CDbl(temperatura)

        Case 3
            ComponenteTemperatura DosaggioAggregati(IIf(NTramoggeA - 2 >= 0, NTramoggeA - 2, 0)), CDbl(temperatura)
        
        Case 4
            ComponenteTemperatura DosaggioAggregati(IIf(NTramoggeA - 3 >= 0, NTramoggeA - 3, 0)), CDbl(temperatura)
        
        Case 5
            ComponenteTemperatura DosaggioAggregati(IIf(NTramoggeA - 4 >= 0, NTramoggeA - 4, 0)), CDbl(temperatura)
        
        Case 6
            ComponenteTemperatura DosaggioAggregati(IIf(NTramoggeA - 5 >= 0, NTramoggeA - 5, 0)), CDbl(temperatura)

    End Select

    Call AggiornaTemperaturaTorre

    Exit Sub
Errore:
    LogInserisci True, "BRU-008", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TempEntrataFiltro_change()

	'rifatta: la gestione dell'evento alta temperatura e' stata spostata nella sub AltaTemperaturaFiltroSw
    
    On Error GoTo Errore

    CP240.LblFiltro(1).caption = ListaTemperature(TempEntrataFiltro).valore
    
    SuperamentoSogliaAllarmeTemperaturaFiltro = (ListaTemperature(TempEntrataFiltro).valore > ValoreTempMaxFiltro)

    If SuperamentoSogliaAllarmeTemperaturaFiltro Then
        Call ColoreCasellaTemperatura(CP240.LblFiltro(1), gialloblu)
    Else
        Call ColoreCasellaTemperatura(CP240.LblFiltro(1), azzurroblu)
    End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-009", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AltaTemperaturaFiltroSw()

On Error GoTo Errore

    If SuperamentoSogliaAllarmeTemperaturaFiltro Then
        
        If OraSicurezzaTemperaturaFiltroSw = 0 Then
            OraSicurezzaTemperaturaFiltroSw = ConvertiTimer()
        End If
        
                
        If ( _
            (ListaTamburi(0).FiammaBruciatorePresente Or ListaTamburi(1).FiammaBruciatorePresente) And _
            (ConvertiTimer() > OraSicurezzaTemperaturaFiltroSw + TimeoutAllarmeFiltroAltaTempIN) _
        ) Then

            If (Not ListaTamburi(0).EsclusioneAvviamentoCaldo) Then
                Call StopBruciatoreTamburo(0)
            Else
                Call StopBruciatore(0)
            End If

            If (Not ListaTamburi(1).EsclusioneAvviamentoCaldo) Then
                Call StopBruciatoreTamburo(1)
            Else
                Call StopBruciatore(1)
            End If

            SicurezzaTemperaturaFiltroSw = True
        
        End If
    
    Else
        SicurezzaTemperaturaFiltroSw = False
        OraSicurezzaTemperaturaFiltroSw = 0
    End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-010", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub TempUscitaFiltro_change()

    On Error GoTo Errore

    'ValoreLettoTempUscitaFiltro = Lettura temperatura USCITA FILTRO.
    CP240.LblFiltro(0).caption = ListaTemperature(TempUscitaFiltro).valore

    'Colora di grigio la casella della temperatura se e' inferiore al limite impostato
    'Colora di azzurro la casella della temperatura se e' superiore al limite impostato
    If ListaTemperature(TempUscitaFiltro).valore < ValoreTempLavoroFiltro Then
        Call ColoreCasellaTemperatura(CP240.LblFiltro(0), grigioblu)
    Else
        Call ColoreCasellaTemperatura(CP240.LblFiltro(0), azzurroblu)
        
        BrucAutoPreriscaldo = False
        CP240.AniPushButtonDeflettore(5).enabled = True
    End If

    'Controllo se il filtro è arrivato in temperatura di lavoro.
    TemperaturaLavoroFiltroOK = (ListaTemperature(TempUscitaFiltro).valore >= ValoreTempLavoroFiltro)

    CP240.PctFiltroOkLavoro.Visible = TemperaturaLavoroFiltroOK

    Exit Sub
Errore:
    LogInserisci True, "BRU-011", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TempSottoMesc_change()

    On Error GoTo Errore
    
    If (ListaTemperature(TempSottoMescolatore).valore > 350) Then
        ListaTemperature(TempSottoMescolatore).valore = 0
    End If
    If (ListaTemperature(TempSottoMescolatore).valore > MaxValoreTempSottoMesc) Then
        MaxValoreTempSottoMesc = ListaTemperature(TempSottoMescolatore).valore
        CP240.LblTempMateriale(0).caption = MaxValoreTempSottoMesc
    End If
    CP240.LblTempMateriale(2).caption = ListaTemperature(TempSottoMescolatore).valore 'MaxValoreTempSottoMesc

    Exit Sub
Errore:
    LogInserisci True, "BRU-012", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ModulatoreBruciatore_change(tamburo As Integer)

    On Error GoTo Errore
    
    With ListaTamburi(tamburo)
        If tamburo = 0 Then
            .posizioneModulatoreBruciatore = NormalizzazioneA100( _
                .posizioneModulatoreBruciatoreNN, _
                100, _
                0, _
                MassimoPosModulatorePLC, _
                MinimoPosModulatorePLC _
                )
            '20170323
            .posizioneModulatoreBruciatorePrecisa = NormalizzazioneA100Dbl( _
                CDbl(.posizioneModulatoreBruciatoreNN), _
                100#, _
                0, _
                CDbl(MassimoPosModulatorePLC), _
                CDbl(MinimoPosModulatorePLC) _
                )
            '
        Else
            .posizioneModulatoreBruciatore = NormalizzazioneA100( _
                .posizioneModulatoreBruciatoreNN, _
                100, _
                0, _
                MassimoModulatoreBruciatoreTamburo2, _
                MinimoModulatoreBruciatoreTamburo2 _
                )
            '20170323
            .posizioneModulatoreBruciatorePrecisa = NormalizzazioneA100Dbl( _
                CDbl(.posizioneModulatoreBruciatoreNN), _
                100#, _
                0, _
                CDbl(MassimoModulatoreBruciatoreTamburo2), _
                CDbl(MinimoModulatoreBruciatoreTamburo2) _
                )
            '
        End If

        Call DimensionaFiamma(tamburo) '20170322

        CP240.LblModulatore(tamburo).caption = .posizioneModulatoreBruciatore
        
        'UTS160207F003_20161030
        'If FormPIDBruc.Visible = True Then
        If (FormPIDBruc_Visible) Then
        '
            If TamburoAssociatoAlPID = tamburo Then
                FormPIDBruc.LblModulatore.caption = .posizioneModulatoreBruciatore
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-013", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ModulatoreAspFiltro_change()

    On Error GoTo Errore

    ModulatoreAspirazioneFiltro.posizione = NormalizzazioneA100( _
        ValoreLettoModulatoreAspFiltroNN, _
        100, _
        0, _
        MassimoPosAspPLC, _
        MinimoPosAspPLC _
        )

    'If Not ListaMotori(MotoreAspiratoreFiltro).uscita Then
    '   Se è spento il valore non è buono
    '    CP240.LblAriaFiltro(0).caption = "*0*"
    'Else
        CP240.LblAriaFiltro(0).caption = ModulatoreAspirazioneFiltro.posizione
    'End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-014", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub LetturaDepressioneBruciatore(tamburo As Integer, depressioneBruciatore As Long, plcInAnalogici_Fatta As Boolean)

    Dim Index As Integer
    Dim valoreLong As Long

    ListaTamburi(tamburo).NumeroLetturaDepressioneBruciatore = ListaTamburi(tamburo).NumeroLetturaDepressioneBruciatore + 1
    If NumeroLettureDepressione < 1 Or NumeroLettureDepressione > 10 Then
        NumeroLettureDepressione = 5
    End If
    If ListaTamburi(tamburo).NumeroLetturaDepressioneBruciatore > NumeroLettureDepressione * 3 Then
        ListaTamburi(tamburo).NumeroLetturaDepressioneBruciatore = 1
    End If
    ArrayLettureDepressioneBruciatore(tamburo, ListaTamburi(tamburo).NumeroLetturaDepressioneBruciatore) = ScalaturaUnitaAnalogIN(depressioneBruciatore, ListaTamburi(tamburo).MassimoFSDeprimometroTamburo, 0)

    valoreLong = 0
    For Index = 1 To NumeroLettureDepressione * 3
        valoreLong = valoreLong + ArrayLettureDepressioneBruciatore(tamburo, Index)
    Next Index
    valoreLong = CLng(valoreLong / (NumeroLettureDepressione * 3))

    If (LongModificato(ListaTamburi(tamburo).depressioneBruciatore, valoreLong, plcInAnalogici_Fatta)) Then
        Call ValoreLettoDepressioneBruc_change(tamburo)
    End If

End Sub


Public Sub LetturaScivoloTamburo(tamburo As Integer, temperaturaScivolo As Long, plcInAnalogici_Fatta As Boolean)

    Dim Index As Integer
    Dim valoreLong As Long

    ListaTamburi(tamburo).NumeroLetturaScivoloTamburo = ListaTamburi(tamburo).NumeroLetturaScivoloTamburo + 1
    If NumeroLettureScivolo < 1 Or NumeroLettureScivolo > 10 Then
        NumeroLettureScivolo = 5
    End If
    If ListaTamburi(tamburo).NumeroLetturaScivoloTamburo > NumeroLettureScivolo * 3 Then
        ListaTamburi(tamburo).NumeroLetturaScivoloTamburo = 1
    End If
     
    If tamburo = 0 Then
        If (ConversioneTemperatura(temperaturaScivolo, TempScivolo, plcInAnalogici_Fatta)) Then
        End If
        ListaTamburi(tamburo).ArrayLettureScivoloTamburo(ListaTamburi(tamburo).NumeroLetturaScivoloTamburo) = ListaTemperature(TempScivolo).valore
    
    Else
        If (ConversioneTemperatura(temperaturaScivolo, TempScivolo2, plcInAnalogici_Fatta)) Then
        End If
        ListaTamburi(tamburo).ArrayLettureScivoloTamburo(ListaTamburi(tamburo).NumeroLetturaScivoloTamburo) = ListaTemperature(TempScivolo2).valore
    End If

    valoreLong = 0
    For Index = 1 To NumeroLettureScivolo * 3
        valoreLong = valoreLong + ListaTamburi(tamburo).ArrayLettureScivoloTamburo(Index)
    Next Index

    If (LongModificato(ListaTamburi(tamburo).temperaturaScivolo, CLng(valoreLong / (NumeroLettureScivolo * 3)), plcInAnalogici_Fatta)) Then
        Call ValoreLettoTempScivolo_change(tamburo)
    End If

End Sub

Public Sub ModulatoreFumiTamburo_change(tamburo As Integer)

    Dim numLabel As Integer

    On Error GoTo Errore

    ListaTamburi(tamburo).ModulatoreFumiTamburo.posizione = NormalizzazioneA100( _
        ListaTamburi(tamburo).ValoreLettoModulatoreFumiTamburoNN, _
        100, _
        0, _
        ListaTamburi(tamburo).MassimoModulatoreTamburo, _
        ListaTamburi(tamburo).MinimoModulatoreTamburo _
        )

    numLabel = IIf(tamburo = 0, 2, 3)
    CP240.LblAriaFiltro(numLabel).caption = ListaTamburi(tamburo).ModulatoreFumiTamburo.posizione

    Exit Sub
Errore:
    LogInserisci True, "BRU-015", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub AllarmeCombustibile(tamburo As Integer, inizializza As Boolean)

    Dim allarme1 As Integer
    Dim allarme2 As Integer

    With ListaTamburi(tamburo)

        allarme1 = 59
        allarme2 = 60
        If (tamburo = 1) Then
            allarme1 = 41
            allarme2 = 42
        End If

        If (inizializza) Then

            If (.SelezioneCombustibile = CombustibileGas And .AllarmePerditaValvoleBruc) Then
                'GAS: perdita valvole

                CP240.Image1(allarme1).Picture = LoadResPicture("IDB_ALLARMEGAS", vbResBitmap)
                CP240.Image1(allarme1).Visible = True

            ElseIf (.SelezioneCombustibile = CombustibileGas And .AllarmePressioneBrucAlta) Then
                'GAS: blocco LDU

                CP240.Image1(allarme1).Picture = LoadResPicture("IDB_BLOCCOLDU", vbResBitmap)
                CP240.Image1(allarme1).Visible = True

            ElseIf (.SelezioneCombustibile <> CombustibileGas And .SicurezzaTempOlioComb) Then
                'Olio combustile: temperatura sicurezza

                CP240.Image1(allarme1).Picture = LoadResPicture("IDB_TEMPERATURASICUREZZA", vbResBitmap)
                CP240.Image1(allarme1).Visible = True

            ElseIf (.SelezioneCombustibile <> CombustibileGas And Not .OlioCombInTemperatura) Then
                'Olio combustile: temperatura bassa

                CP240.Image1(allarme1).Picture = LoadResPicture("IDB_TEMPERATURABASSA", vbResBitmap)
                CP240.Image1(allarme1).Visible = True

            ElseIf (.SelezioneCombustibile <> CombustibileGas And .AllarmePerditaValvoleBrucOC) Then
                'Olio combustile: perdita valvole

                CP240.Image1(allarme1).Picture = LoadResPicture("IDB_ALLARMEGAS", vbResBitmap)
                CP240.Image1(allarme1).Visible = True

            Else

                CP240.Image1(allarme1).Visible = False
                CP240.Image1(allarme2).Visible = False

            End If

        Else

            If (.SelezioneCombustibile = CombustibileGas And (.AllarmePerditaValvoleBruc Or .AllarmePressioneBrucAlta)) Then

                CP240.Image1(allarme2).Visible = (Not CP240.Image1(allarme2).Visible)

            ElseIf (.SelezioneCombustibile <> CombustibileGas And (.SicurezzaTempOlioComb Or Not .OlioCombInTemperatura Or .AllarmePerditaValvoleBrucOC)) Then

                CP240.Image1(allarme2).Visible = (Not CP240.Image1(allarme2).Visible)

            End If

        End If

    End With

End Sub

Public Sub AllarmePerditaValvoleBruc_change(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If (.SelezioneCombustibile = CombustibileGas) Then 'Se è stato SELEZIONATO il bruciatore a GAS.

            Call AllarmeCombustibile(tamburo, True)

            'devo spegnere il bruciatore
            If ((.BruciatoreInAccensione Or .FiammaBruciatorePresente) And .AllarmePerditaValvoleBruc) Then
                Call StopBruciatore(tamburo)
            End If

        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-016", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AllarmePerditaValvoleBrucOC_change(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If (.SelezioneCombustibile <> CombustibileGas) Then
            'Bruciatore Olio Combustibile

            Call AllarmeCombustibile(tamburo, True)

            'devo spegnere il bruciatore
            If ((.BruciatoreInAccensione Or .FiammaBruciatorePresente) And .AllarmePerditaValvoleBruc) Then
                Call StopBruciatore(tamburo)
            End If

        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-017", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AllarmePressioneBrucAlta_change(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If (.SelezioneCombustibile = CombustibileGas) Then 'Se è stato SELEZIONATO il bruciatore a GAS.

            Call AllarmeCombustibile(tamburo, True)

            'devo spegnere il bruciatore
            If ((.BruciatoreInAccensione Or .FiammaBruciatorePresente) And .AllarmePressioneBrucAlta) Then
                Call StopBruciatore(tamburo)
            End If

        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-018", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SicurezzaTempOlioComb_change(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If .SelezioneCombustibile <> CombustibileGas Then 'Se è stato SELEZIONATO il bruciatore a OLIO COMB.

            Call AllarmeCombustibile(tamburo, True)

            'devo spegnere il bruciatore
            If ((.BruciatoreInAccensione Or .FiammaBruciatorePresente) And .SicurezzaTempOlioComb) Then
                Call StopBruciatore(tamburo)
            End If

        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-019", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub OlioCombInTemperatura_change(tamburo As Integer)

    On Error GoTo Errore

    Call AllarmeCombustibile(tamburo, True)

    Exit Sub
Errore:
    LogInserisci True, "BRU-020", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub PosizioneModulatoreAriaFredda_change()

    CP240.LblAriaFiltro(1).caption = PosizioneModulatoreAriaFredda

End Sub


Public Sub StartBruciatoreDaPLC_change(tamburo As Integer)

    CP240.PctStartRicevuto(0).Visible = ListaTamburi(0).StartBruciatoreDaPLC
    CP240.PctStartRicevuto(1).Visible = ListaTamburi(1).StartBruciatoreDaPLC

End Sub


Public Sub ValoreLettoTempScivolo_change(tamburo As Integer)

    Dim label As Integer

    With ListaTamburi(tamburo)

        If (tamburo = 0) Then
            label = 1
        Else
            label = 6
        End If
        CP240.LblTempMateriale(label).caption = .temperaturaScivolo

        '20161230
        'If FormPIDBruc.Visible = True Then
        If (FormPIDBruc_Visible) Then
        '
            If TamburoAssociatoAlPID = tamburo Then
                FormPIDBruc.LblTempBruc.caption = .temperaturaScivolo
            End If
        End If

        If .temperaturaScivolo < MinTempEssicatore Then
            'Colora di grigio la casella della temperatura se e' inferiore al limite impostato
            Call ColoreCasellaTemperatura(CP240.LblTempMateriale(label), grigioblu)
        Else
            'Colora di azzurro la casella della temperatura se e' superiore al limite impostato
            Call ColoreCasellaTemperatura(CP240.LblTempMateriale(label), azzurroblu)
        End If

        If (tamburo = 0) Then
            CP240.Image1(33).Visible = (.temperaturaScivolo > MaxTempEssicatore)
        Else
            CP240.Image1(39).Visible = (.temperaturaScivolo > MaxTempEssicatore)
        End If

    End With

End Sub


Public Sub ValoreLettoDepressioneBruc_change(tamburo As Integer)

    Dim label As Integer

    If (tamburo = 0) Then
        label = 0
    Else
        label = 3
    End If

    'ValoreLettoDepressioneBruc = Lettura DEPRESSIONE BRUCIATORE.
    '   Visualizzazione in mBar
    CP240.LblDepressioneBruc(label).caption = ListaTamburi(tamburo).depressioneBruciatore

End Sub

Public Sub ControlliFiammaBruciatore(tamburo As Integer)

    On Error GoTo Errore

'Debug.Print "0 - UP = " + CStr(ListaTamburi(0).ModulatoreBrucOnUp)
'Debug.Print "0 - dn = " + CStr(ListaTamburi(0).ModulatoreBrucOnDown)
'Debug.Print "1 - UP = " + CStr(ListaTamburi(1).ModulatoreBrucOnUp)
'Debug.Print "1 - dn = " + CStr(ListaTamburi(1).ModulatoreBrucOnDown)

    With ListaTamburi(tamburo)

        Call AllarmeCombustibile(tamburo, False)

        If (.TempoArrestoBrucAttivo) And (.ConteggioSecondiSpegniBruciatore >= 0) Then
            If tamburo = 0 Then
                Call AllarmeTemporaneoFull(98, "XX098", True, True)

                CP240.LblMessaggioBruciatore(1).Visible = True
                CP240.Image1(29).Visible = True
                CP240.LblEtichetta(1).Visible = True
            Else
                Call AllarmeTemporaneoFull(125, "XX125", True, True)

                CP240.LblMessaggioBruciatore(0).Visible = True
                CP240.Image1(36).Visible = True
                CP240.LblEtichetta(85).Visible = True
            End If

            '20161230
            'Call BruciatoreInManuale(tamburo)
            '
        Else
            If tamburo = 0 Then
                Call AllarmeTemporaneoFull(98, "XX098", False, False)

                CP240.LblMessaggioBruciatore(1).Visible = False
                CP240.Image1(29).Visible = False
                CP240.LblEtichetta(1).Visible = False
            Else
                Call AllarmeTemporaneoFull(125, "XX125", False, False)

                CP240.LblMessaggioBruciatore(0).Visible = False
                CP240.Image1(36).Visible = False
                CP240.LblEtichetta(85).Visible = False
            End If
            
        End If

        'Controllo il blocco bruciatore.
        

Dim i As Integer
Dim PredRAPinRicetta As Integer
        
        'TAMBURO PARALLELO
        If tamburo = 1 Then
            For i = PrimoPredosatoreDelNastro(RiciclatoFreddo) To (NumeroPredosatoriRicInseriti - 1 - NumeroPredosatoriNastroC(RiciclatoJolly))
                PredRAPinRicetta = PredRAPinRicetta + ListaPredosatoriRic(i).setAttuale.set
            Next i
        End If

        If (Not .FiammaBruciatorePresente And Not AvvioPredosatoriSenzaBruciatore And StartPredosatori) And (tamburo = 1 And PredRAPinRicetta <> 0) Then
            Call PulsanteStopPred
            Call AllarmeTemporaneo("XX012", True)
            Call BruciatoreInManuale(tamburo)
        End If

        If .InPreriscaldo Then
            If (Not .BruciatorePosizioneAccensione) Then
                .ModulatoreBrucOnUp = False
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-021", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ArrestoBrucTempoX(tamburo As Integer)

    'ARRESTO BRUCIATORE DOPO UN TEMPO X.

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        If StopFiammaDopoNastri Then   'Attivazione Arresto bruciatore allo STOP DEL NASTRO COLLETTORE1.
            'If (.ConteggioSecondiSpegniBruciatore = 1) And .BruciatorePosizioneAccensione Then
            If (.ArrestaBrucFineConteggio And .BruciatorePosizioneAccensione) Then
                If (Not ListaMotori(MotoreNastroCollettore1).ritorno And Not ListaMotori(MotoreNastroCollettore2).ritorno) Then
                    If (.FiammaBruciatorePresente) Then
                        Call StopBruciatore(tamburo)
                    End If
                End If
            End If
        Else  'Attivazione Arresto bruciatore allo STOP PREDOSATORI.
            If .ArrestaBrucFineConteggio And .BruciatorePosizioneAccensione Then

                If ( _
                    (tamburo = 1 And Not AlmenoUnoAccesoPredRiciclatoFreddo) Or _
                    (tamburo = 0 And Not AlmenoUnoAccesoPredVergini) And _
                    .FiammaBruciatorePresente _
                ) Then
                    Call StopBruciatore(tamburo)
                End If
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-022", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub BruciatoreInManuale(tamburo As Integer)

    With CP240

        ListaTamburi(tamburo).BruciatoreAutomatico = False
        If tamburo = 0 Then
            .AniPushButtonDeflettore(5).Value = 1
        ElseIf tamburo = 1 Then
            .AniPushButtonDeflettore(25).Value = 1
        End If

        .TxtTemperaturaBruciatoreAutomatico(tamburo).Visible = False

        .TimerChiamataPID.enabled = False
        .TimerChiamataPID2.enabled = False

    End With

End Sub

Public Sub GestioneModulatoreBruc(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)

        'Sta finendo il conteggio dei secondi di arresto bruciatore devo fare la chiusura
        If (.ConteggioSecondiSpegniBruciatore = 1) And (Not .BruciatorePosizioneAccensione) Then
            .ModulatoreBrucOnDown = True
            .ModulatoreBrucOnUp = False
        ElseIf (.ConteggioSecondiSpegniBruciatore = 1) And .BruciatorePosizioneAccensione Then
            .ModulatoreBrucOnDown = False
            .ModulatoreBrucOnUp = False
            If (.FiammaBruciatorePresente) Then
                .ArrestaBrucFineConteggio = True
            End If
        End If
    
        CP240.CmdUpDownBruc(0 + (tamburo * 2)).enabled = (Not ListaTamburi(tamburo).BruciatoreAutomatico)
        CP240.CmdUpDownBruc(1 + (tamburo * 2)).enabled = (Not ListaTamburi(tamburo).BruciatoreAutomatico)

        'Se i Predosatori sono fermi, la temperatura filtro è ok per il lavoro,
        'si ha la partenza della chiusura del modulatore bruciatore.
        If (.ConteggioSecondiSpegniBruciatore = 1) And (Not .BruciatorePosizioneAccensione) Then
            If (.FiammaBruciatorePresente) Then
                .ModulatoreBrucOnDown = True
                .ModulatoreBrucOnUp = False
                .ArrestaBrucFineConteggio = True
            Else
                .ModulatoreBrucOnDown = False
                .ModulatoreBrucOnUp = False
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-023", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub RegolazioneAriaAspiratore()
	Dim TamburoAcceso As Integer
	Dim i As Integer

    If (ParallelDrum) Then
        '2 TAMBURI

        If (ListaMotori(MotoreAspiratoreFiltro).ritorno) Then
            If ListaMotori(MotoreRotazioneEssiccatore).ritorno And ListaMotori(MotoreRotazioneEssiccatore2).ritorno Then
                'Con entrambi i tamburi in moto il modulatore del filtro si regola in automatico
                'I modulatori fumi tamburo fanno l'autoregolazione in base alla depressione

'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'                'MODIFICA IPOTETICA SULLA GESTIONE DELLA DEPRESSIONE NEL CASO DI DOPPIO TAMBURO
'
'                'ipotizzo di avere una variabile sulla lettura della depressione all'interno del filtro
'                'per ora la chiamo DepressioneFiltro..... introduco anche DepressioneFiltro.min e DepressioneFiltro.max
'               If (DepressioneFiltro > DepressioneFiltro.min And DepressioneFiltro < DepressioneFiltro.max) Then
'               'se la depressione del filtro rimane all'interno della forchetta prestabilita eseguo il controllo automatico sulla
'               'depressione dei due bruciatori e il filtro lo lascio stare
'
'                   ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
'
'                   If (Not ListaTamburi(0).ModulatoreFumiTamburo.manuale) Then
'                    'Gestione automatica
'                        If (ListaTamburi(0).depressioneBruciatore < ListaTamburi(0).ModulatoreFumiTamburo.min) Then
'                            ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUp
'                        ElseIf (ListaTamburi(0).depressioneBruciatore > ListaTamburi(0).ModulatoreFumiTamburo.max) Then
'                            ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.modulatoredown
'                        Else
'                            ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
'                        End If
'                   End If
'
'                    If (Not ListaTamburi(1).ModulatoreFumiTamburo.manuale) Then
'                        'Gestione automatica
'                        If (ListaTamburi(1).depressioneBruciatore < ListaTamburi(1).ModulatoreFumiTamburo.min) Then
'                            ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUp
'                        ElseIf (ListaTamburi(1).depressioneBruciatore > ListaTamburi(1).ModulatoreFumiTamburo.max) Then
'                            ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.modulatoredown
'                        Else
'                            ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
'                        End If
'                    End If
'
'                Else
'                    'se la depressione del filtro esce dalla forchetta prestabilità mi disinteresso del controllo della depressione
'                    'dei due bruciatori e agisco sulla depressione del filtro per riportarla all'interno della forchetta
'
'                    ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
'                    ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
'
'                    If DepressioneFiltro <= DepressioneFiltro.min Then
'                                ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUp
'                    ElseIf DepressioneFiltro >= DepressioneFiltro.max Then
'                                ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.modulatoredown
'                    End If
'                End If
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                               
                
                If (Not ListaTamburi(0).ModulatoreFumiTamburo.manuale) Then
                    'Gestione automatica
                    If (ListaTamburi(0).depressioneBruciatore < ListaTamburi(0).ModulatoreFumiTamburo.min) Then
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
                    ElseIf (ListaTamburi(0).depressioneBruciatore > ListaTamburi(0).ModulatoreFumiTamburo.max) Then
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
                    Else
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                End If
            
                If (Not ListaTamburi(1).ModulatoreFumiTamburo.manuale) Then
                    'Gestione automatica
                    If (ListaTamburi(1).depressioneBruciatore < ListaTamburi(1).ModulatoreFumiTamburo.min) Then
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
                    ElseIf (ListaTamburi(1).depressioneBruciatore > ListaTamburi(1).ModulatoreFumiTamburo.max) Then
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
                    Else
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                End If
                
                '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                'VERIFICARE IN CANTIERE SE POSSIBILE FARE L'AUTOREGOLAZIONE DEL FILTRO
                'Suggerimento di Mariani Sante sempre da verificare:
                '   fare la correzione sulla differenza algebrica tra i valori delle depressioni dei due tamburi, es:
                '       Tamb1 --> 5-9 mmH20     ottimale = 7
                '       Tamb2 --> 6-10 mmH20    ottimale = 8
                '       Caso1: Tamb1=6 Tamb2=9 Differeneza =-1 + +1 = 0 non muovo nulla
                '       Caso1: Tamb1=6 Tamb2=7 Differeneza =-1 + -1 = -2 apro
                '       Caso1: Tamb1=8 Tamb2=9 Differeneza =+1 + +1 = +2 chiudo
                '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               If (Not ModulatoreAspirazioneFiltro.manuale) Then
                                        
                    If ModoRegolazAspirazFiltroConDeprimometroTamburo = True Then
                        Call ModoRegolazioneDepressioneFiltroConDepressTamburo
                    ElseIf ModoRegolazAspirazFiltroConDeprimometroFiltroIN = True Then
                        Call ModoRegolazioneDepressioneFiltroConDepressFiltroIN
                    End If

                End If
                '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            Else
                If ListaMotori(MotoreRotazioneEssiccatore).ritorno Then
                    TamburoAcceso = 0
                    'Il modulatore fumi tamburo 1 deve sempre essere aperto al massimo
                    If (ListaTamburi(0).ModulatoreFumiTamburo.posizione < 99) Then
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
                    Else
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                Else
                    If (ListaTamburi(0).ModulatoreFumiTamburo.posizione > 1) Then
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
                    Else
                        ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                End If
                If ListaMotori(MotoreRotazioneEssiccatore2).ritorno Then
                    TamburoAcceso = 1
                    'Il modulatore fumi tamburo 2 deve sempre essere aperto al massimo
                    If (ListaTamburi(1).ModulatoreFumiTamburo.posizione < 99) Then
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
                    Else
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                Else
                    If (ListaTamburi(1).ModulatoreFumiTamburo.posizione > 1) Then
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
                    Else
                        ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                End If
                
                'Se entrambi i tamburi sono spenti tengo i modulatori fumi tamburo aperti
                If Not ListaMotori(MotoreRotazioneEssiccatore2).ritorno And Not ListaMotori(MotoreRotazioneEssiccatore).ritorno Then
                    'Il modulatore fumi tamburo deve sempre essere aperto al massimo
                    For i = 0 To 1
                        If (ListaTamburi(i).ModulatoreFumiTamburo.posizione < 99) Then
                            ListaTamburi(i).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
                        Else
                            ListaTamburi(i).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
                        End If
                    Next i
                End If
                
                'Con solo un tamburo acceso il filtro fa la regolazione automatica sulla depressione del tamburo acceso
                If (Not ModulatoreAspirazioneFiltro.manuale) Then
                    'Gestione automatica
                    If (ListaTamburi(TamburoAcceso).depressioneBruciatore < ListaTamburi(TamburoAcceso).ModulatoreFumiTamburo.min) Then
                        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
                    ElseIf (ListaTamburi(TamburoAcceso).depressioneBruciatore > ListaTamburi(TamburoAcceso).ModulatoreFumiTamburo.max) Then
                        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
                    Else
                        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
                    End If
                End If
            End If

        Else
            'Motore aspiratore fumi fermo, valvola aperta oltre un certo valore:
            'chiusura automatica.
            If (ListaTamburi(0).ModulatoreFumiTamburo.posizione > 1) Then
                'Chiusura Automatica dell'aria aspirazione.
                ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
            Else
                ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
            End If

            If (ListaTamburi(1).ModulatoreFumiTamburo.posizione > 1) Then
                'Chiusura Automatica dell'aria aspirazione.
                ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
            Else
                ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
            End If
        End If
    Else
        '1 SOLO TAMBURO

        'REGOLAZIONE ARIA ASPIRATORE FUMI.
        'Regolazione Aria Aspiratore Fumi rispettando il valore minimo e massimo del deprimometro.
        If (ListaMotori(MotoreAspiratoreFiltro).ritorno) Then
            If (Not ModulatoreAspirazioneFiltro.manuale) Then
                'Gestione automatica
                If (ListaTamburi(0).depressioneBruciatore < ListaTamburi(0).ModulatoreFumiTamburo.min) Then
                    ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
                ElseIf (ListaTamburi(0).depressioneBruciatore > ListaTamburi(0).ModulatoreFumiTamburo.max) Then
                    ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
                Else
                    ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
                End If
            End If
        Else
            'Motore aspiratore fumi fermo, valvola aperta oltre un certo valore:
            'chiusura automatica.
            If (ModulatoreAspirazioneFiltro.posizione > 1) Then
                'Chiusura Automatica dell'aria aspirazione.
                ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
            Else
                ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
            End If
        End If
    End If
End Sub


Public Sub ModoRegolazioneDepressioneFiltroConDepressTamburo()

	'Gestione automatica
    Dim DifferenzaAlgebricaDepressioni As Integer
                    
        DifferenzaAlgebricaDepressioni = (ListaTamburi(0).depressioneBruciatore - (ListaTamburi(0).ModulatoreFumiTamburo.max + ListaTamburi(0).ModulatoreFumiTamburo.min) \ 2) + (ListaTamburi(1).depressioneBruciatore - (ListaTamburi(1).ModulatoreFumiTamburo.max + ListaTamburi(1).ModulatoreFumiTamburo.min) \ 2)

        If DifferenzaAlgebricaDepressioni <= -2 Then
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
        ElseIf DifferenzaAlgebricaDepressioni >= 2 Then
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
        Else
            ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
        End If

End Sub

Public Sub ModoRegolazioneDepressioneFiltroConDepressFiltroIN()
    
    If ( _
        (DepressioneFiltroIN > DepressioneFiltroRegolazione.min And DepressioneFiltroIN < DepressioneFiltroRegolazione.max) Or _
        (ModulatoreAspirazioneFiltro.posizione <> 0 And ListaTamburi(0).depressioneBruciatore = 0 And ListaTamburi(1).depressioneBruciatore = 0) _
    ) Then

        'se la depressione del filtro rimane all'interno della forchetta prestabilita eseguo il controllo automatico sulla
        'depressione dei due bruciatori e il filtro lo lascio stare

        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
        
        If (Not ListaTamburi(0).ModulatoreFumiTamburo.manuale) Then

         'Gestione automatica

             If (ListaTamburi(0).depressioneBruciatore < ListaTamburi(0).ModulatoreFumiTamburo.min) Then
                 ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
             ElseIf (ListaTamburi(0).depressioneBruciatore > ListaTamburi(0).ModulatoreFumiTamburo.max) Then
                 ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
             Else
                 ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
             End If

        End If

         If (Not ListaTamburi(1).ModulatoreFumiTamburo.manuale) Then

             'Gestione automatica

             If (ListaTamburi(1).depressioneBruciatore < ListaTamburi(1).ModulatoreFumiTamburo.min) Then
                 ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreUP
             ElseIf (ListaTamburi(1).depressioneBruciatore > ListaTamburi(1).ModulatoreFumiTamburo.max) Then
                 ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.Modulatoredown
             Else
                 ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
             End If
         End If

     Else

         'se la depressione del filtro esce dalla forchetta prestabilita mi disinteresso del controllo della depressione
         'dei due bruciatori e agisco sulla depressione del filtro per riportarla all'interno della forchetta

         ListaTamburi(0).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone
         ListaTamburi(1).ModulatoreFumiTamburo.Stato = ModulatoreStatusEnum.ModulatoreNone

         If DepressioneFiltroIN <= DepressioneFiltroRegolazione.min Then
                     ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
         ElseIf DepressioneFiltroIN >= DepressioneFiltroRegolazione.max Then
                     ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
         End If

     End If

'
End Sub

Public Sub RegolazioneAriaFredda()
    If Not InclusioneAriaFredda Then
        Exit Sub
    End If

    If FrmGestioneTimer.TimerAttesaRegolazioneAriaFredda.Interval <> TempoCampAriaFredda * 1000 Then
        FrmGestioneTimer.TimerAttesaRegolazioneAriaFredda.Interval = TempoCampAriaFredda * 1000
    End If

    If (ListaMotori(MotoreAspiratoreFiltro).ritorno And Not ManualeAriaFredda) Then
        If (ListaTemperature(TempEntrataFiltro).valore <= ValoreMaxAriaFredda And ListaTemperature(TempEntrataFiltro).valore >= ValoreMinAriaFredda) Then
            ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
        Else
            If (ListaTemperature(TempEntrataFiltro).valore > ValoreMinAriaFredda - DeltaAriaFredda) Then
                If (ListaTemperature(TempEntrataFiltro).valore > ValoreMaxAriaFredda + DeltaAriaFredda) Then
                    ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
                Else
                    Call RegolazioneImpulsoAriaFredda(1, Abs(ListaTemperature(TempEntrataFiltro).valore - ValoreMaxAriaFredda + DeltaAriaFredda))
                End If
            End If
            If (ListaTemperature(TempEntrataFiltro).valore < ValoreMinAriaFredda - DeltaAriaFredda) Then
                If (ListaTemperature(TempEntrataFiltro).valore < ValoreMinAriaFredda - DeltaAriaFredda * 2) Then
                    ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
                Else
                    Call RegolazioneImpulsoAriaFredda(2, Abs(ListaTemperature(TempEntrataFiltro).valore - ValoreMaxAriaFredda + DeltaAriaFredda))
                End If
            End If
        End If
    End If

    'Se il motore aspiratore fumi è fermo e la valvola è aperta oltre un certo valore,
    'si ha la chiusura automatica.
    'Chiusura Automatica dell'aria fredda
    If Not ListaMotori(MotoreAspiratoreFiltro).ritorno Then
        If ListaTemperature(TempEntrataFiltro).valore > 0 Then
            ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
        Else
            ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
        End If
    End If
End Sub

Public Function DurataImpulsoAriaFredda(DeltaTemperatura As Integer) As Integer
	'DeltaTemperatua=differenza tra setpoint e attuale
	'Faccio una specie di regolazione PID per l'aria fredda
	'Controllo ogni 5 secondi la temperatura di entrata del filtro "TimerAttesaRegolazioneAriaFredda"
	'Più sono vicino al setpoint e minore sarà la durata dell'impulso di apertura o chiusura
	'Limpulso non può durare più di 2 secondi e non meno di 0,2 secondi
	Dim EscursioneSetPoint As Integer

    EscursioneSetPoint = (ValoreMaxAriaFredda + DeltaAriaFredda) - (ValoreMinAriaFredda - DeltaAriaFredda)
    DurataImpulsoAriaFredda = CInt(TempoCorrAriaFredda * 1000 / EscursioneSetPoint * DeltaTemperatura)
    If DurataImpulsoAriaFredda > TempoCorrAriaFredda * 1000 Then
        DurataImpulsoAriaFredda = TempoCorrAriaFredda * 1000
    End If

    If DurataImpulsoAriaFredda < TempoCorrAriaFredda * 100 Then
        DurataImpulsoAriaFredda = TempoCorrAriaFredda * 100
    End If

End Function

Public Sub RegolazioneImpulsoAriaFredda(UpDown As Integer, DeltaTemperatura As Integer)

	'Up=1  ;  Down=2
	'Se sono già arrivato in fondo al modulatore dell'aria fredda non faccio più la regolazione
    If AbilitaControlloAriaFredda Then
        AbilitaControlloAriaFredda = False
    Else
        Exit Sub
    End If

    If PosizioneModulatoreAriaFredda = 0 Then
        If UpDown = 2 Then
            Exit Sub
        End If
    End If

    If PosizioneModulatoreAriaFredda >= 100 Then
        If UpDown = 1 Then
            Exit Sub
        End If
    End If
    
    If UpDown = 1 Then
        ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP

        FrmGestioneTimer.TimerImpulsoRegolazioneAriaFredda.Interval = DurataImpulsoAriaFredda(DeltaTemperatura)
        FrmGestioneTimer.TimerImpulsoRegolazioneAriaFredda.enabled = False
        FrmGestioneTimer.TimerImpulsoRegolazioneAriaFredda.enabled = True
    End If
    If UpDown = 2 Then
        ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.Modulatoredown

        FrmGestioneTimer.TimerImpulsoRegolazioneAriaFredda.Interval = DurataImpulsoAriaFredda(DeltaTemperatura)
        FrmGestioneTimer.TimerImpulsoRegolazioneAriaFredda.enabled = False
        FrmGestioneTimer.TimerImpulsoRegolazioneAriaFredda.enabled = True
    End If
    
End Sub


Public Sub BruciatoreModulatore_change(tamburo As Integer)

    On Error GoTo Errore

    With CP240

        If (tamburo = 0) Then
            .ImgModulatore(0).Visible = ListaTamburi(tamburo).BruciatoreModulatoreApertura
            .ImgModulatore(1).Visible = ListaTamburi(tamburo).BruciatoreModulatoreChiusura
        Else
            .ImgModulatore(2).Visible = ListaTamburi(tamburo).BruciatoreModulatoreApertura
            .ImgModulatore(3).Visible = ListaTamburi(tamburo).BruciatoreModulatoreChiusura
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-024", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub FiltroModulatore_change()

    On Error GoTo Errore

    With CP240
        .ImgModulatore(4).Visible = ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
        .ImgModulatore(5).Visible = ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-025", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AriaTamburoModulatore_change(tamburo As Integer, apre As Boolean, chiude As Boolean)

    On Error GoTo Errore
    
    With CP240
        .ImgModulatore(6 + tamburo * 2).Visible = chiude
        .ImgModulatore(7 + tamburo * 2).Visible = apre
    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-026", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AriaFreddaFiltroModulatore_change()

    On Error GoTo Errore
    
    With CP240
        .ImgModulatore(10).Visible = ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.Modulatoredown
        .ImgModulatore(11).Visible = ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreUP
    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-027", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub GestioneFunzAutomaticoBruc(tamburo As Integer)

    On Error GoTo Errore

    '20161230
    Call GestRegolazioneBruciatore(tamburo)
    '

    '20161230
    'With ListaTamburi(tamburo)
    '
    '    If (.BruciatoreAutomatico) And (.FiammaBruciatorePresente) Then
    '        If (ListaTamburi(tamburo).OkCorrezionePID) And (Not .PassaggioSingolo) Then
    '
    '            .PassaggioSingolo = True
    '
    '            If SelezioneRegPid1 Then    'Consigliato per bruciatore gas.
    '                Call RegolatorePID_1(ResetPID, CDbl(FattoreDiCorrezioneKp), CDbl(FattoreDiCorrezioneKi), _
    '                                CDbl(FattoreDiCorrezioneKd), CDbl(.setTemperaturaScivolo), CDbl(.temperaturaScivolo), _
    '                                CDbl(TInterventoCampionamento) * 2#, TempoDurataCorr, ErrorePID)
    '            ElseIf SelezioneRegPid2 Then
    '                Call RegolatorePID_2(ResetPID, CDbl(FattoreDiCorrezioneKp), CDbl(FattoreDiCorrezioneKi), _
    '                                CDbl(FattoreDiCorrezioneKd), CDbl(.setTemperaturaScivolo), CDbl(.temperaturaScivolo), _
    '                                CDbl(TInterventoCampionamento) * 2#, TempoDurataCorr, ErrorePID)
    '            End If
    '
    '            If (ErrorePID) And (Not AllarmeTemporaneoGiaVisualizzato(20)) Then
    '                Call AllarmeTemporaneoFull(20, "XX020", True, False)
    '            ElseIf (Not ErrorePID) Then
    '                Call AllarmeTemporaneoFull(20, "XX020", False, False)
    '            End If
    '
    '            If (TempoDurataCorr < -1) Then
    '                .ChiusuraModulatore = True
    '                .ImpulsoStartCorrModulatore = True
    '            ElseIf (TempoDurataCorr > 1) Then
    '                .ChiusuraModulatore = False
    '                .ImpulsoStartCorrModulatore = True
    '            ElseIf (TempoDurataCorr = 0) Then
    '                .ChiusuraModulatore = False
    '                .ImpulsoStartCorrModulatore = False
    '            End If
    '
    '            ListaTamburi(tamburo).OkCorrezionePID = False
    '
    '            CP240.TimerImpulsoCorr.enabled = True
    '            CP240.TimerChiamataPID2.Interval = TInterventoCampionamento
    '            CP240.TimerChiamataPID2.enabled = True
    '        Else
    '            .PassaggioSingolo = False
    '        End If
    '    End If
    '
    'End With
    '

    Exit Sub
Errore:
    LogInserisci True, "BRU-028", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub StopBruciatoreTamburo(tamburo As Integer)
    Dim PredosatoriAutomaticoAccesi As Boolean
    Dim BruciatoreConteggioSpegnimento As Boolean
    Dim i As Integer
    Dim motore As Integer

    With ListaTamburi(tamburo)

        If (tamburo = 0) Then
            motore = MotoreRotazioneEssiccatore

            If OraStopPredosatori > 0 And OraStartPredosatori > 0 Then
                If ConvertiTimer() < OraStopPredosatori + .TempoStopBruciatore Then
                    If (.TempoArrestoBrucAttivo) And (.ConteggioSecondiSpegniBruciatore >= 0) Then
                        BruciatoreConteggioSpegnimento = True
                    End If
                End If
            End If
            
            'Memorizzo lo stato dei predosatori
            If AutomaticoPredosatori Then
                If ParallelDrum Then
                    For i = 0 To (PrimoPredosatoreDelNastro(RiciclatoFreddo) - 1)
                        If ListaPredosatori(i).motore.ritorno Then
                            PredosatoriAutomaticoAccesi = True
                            If OraStartPredosatori = 0 Then
                                OraStartPredosatori = ConvertiTimer()
                            End If
                        End If
                    Next i
                Else
                    For i = 0 To NumeroPredosatoriInseriti - 1
                        If ListaPredosatori(i).motore.ritorno Then
                            PredosatoriAutomaticoAccesi = True
                            If OraStartPredosatori = 0 Then
                                OraStartPredosatori = ConvertiTimer()
                            End If
                        End If
                    Next i
                End If
                
            End If
    
            If Not PredosatoriAutomaticoAccesi Then
                OraStartPredosatori = 0
            End If

            If .MemoriaAccensioneBruciatore And (PredosatoriAutomaticoAccesi Or (BruciatoreConteggioSpegnimento And Not .BruciatorePosizioneAccensione)) Then
                Call PredosatoriArrestoImmediato(False, -1)
                Call PredosatoriArrestoImmediato(True, -1)

                CP240.OPCData.items(PLCTAG_NM_TamburoArrestoImmediato).Value = True
            Else
                If .MemoriaAccensioneBruciatore Then
                    Call StopBruciatore(tamburo)
                End If
            End If


        Else    'Tamburo 2
        
            motore = MotoreRotazioneEssiccatore2
        
            If OraStopPredosatoriRic > 0 And OraStartPredosatoriRic > 0 Then
                If ConvertiTimer() < OraStopPredosatoriRic + .TempoStopBruciatore Then
                    If (.TempoArrestoBrucAttivo) And (.ConteggioSecondiSpegniBruciatore >= 0) Then
                        BruciatoreConteggioSpegnimento = True
                    End If
                End If
            End If
            
            'Memorizzo lo stato dei predosatori
            If AutomaticoPredosatori Then
                For i = PrimoPredosatoreDelNastro(RiciclatoFreddo) To (NumeroPredosatoriRicInseriti - 1 - NumeroPredosatoriNastroC(RiciclatoJolly))
                    If ListaPredosatoriRic(i).motore.ritorno Then
                        PredosatoriAutomaticoAccesi = True
                        If OraStartPredosatoriRic = 0 Then
                            OraStartPredosatoriRic = ConvertiTimer()
                        End If
                    End If
                Next i
            End If
    
            If Not PredosatoriAutomaticoAccesi Then
                OraStartPredosatoriRic = 0
            End If

            If .MemoriaAccensioneBruciatore And (PredosatoriAutomaticoAccesi Or (BruciatoreConteggioSpegnimento And Not .BruciatorePosizioneAccensione)) Then
                Call PredosatoriArrestoImmediato(False, -1)
                Call PredosatoriArrestoImmediato(True, -1)

                CP240.OPCData.items(PLCTAG_NM_Tamburo2ArrestoImmediato).Value = True
            Else
                If .MemoriaAccensioneBruciatore Then
                    Call StopBruciatore(tamburo)
                End If
            End If

        End If

    End With

End Sub


Public Sub ControlloBloccoBruciatore(tamburo As Integer)
    'Dim i As Integer
    Dim ventolaBruciatore As Integer
    Dim imageLec1 As Integer
    Dim ModulatoreBruciatoreAperto As Boolean

On Error GoTo Errore

    With ListaTamburi(tamburo)

        If (tamburo = 0) Then
            ventolaBruciatore = MotoreVentolaBruciatore
            imageLec1 = 1
        Else
            ventolaBruciatore = MotoreVentolaBruciatore2
            imageLec1 = 38
        End If

        'Memorizzo lo stato del bruciatore
        ModulatoreBruciatoreAperto = (Not .BruciatorePosizioneAccensione)

        'Asservimento bruciatore con filtro
        If .FiammaBruciatorePresente And Not ListaMotori(MotoreAspiratoreFiltro).ritorno Then
            If (ListaTamburi(tamburo).EsclusioneAvviamentoCaldo) Then
                Call StopBruciatore(tamburo)
            Else
                Call StopBruciatoreTamburo(tamburo)
            End If
        End If

        '20150319
        'Se la ventola non si accende non si forma depressione nel tamburo
        'Se non c'è sufficiente depressione nel tamburo, l'apparecchiatura (LEC1) va in blocco
        'ERGO: il test fatto da Cyb non serve a niente anzi, potrebbe essere dannoso se l'apparecchiatura ha un tempo di avviamento o
        'un comportamento della "posizione per accensione" leggermente diverso da quello ipotizzato (magari i 2 secondi non sono sufficienti...)
        ''La ventola del bruciatore non viene comandata del PC, testo solo il ritorno
        'If ( _
        '    (.BruciatoreInAccensione And Not ListaMotori(ventolaBruciatore).ritorno And Not ListaTamburi(tamburo).BruciatorePosizioneAccensione) And _
        '   (ConvertiTimer() > ListaTamburi(tamburo).OraStartVentolaBruciatore + 2) _
        ') Then
        '    Call SetAllarmePresente("AM0" + CStr(ventolaBruciatore), True)
        '    Call StopBruciatore(tamburo)
        'Else
        '    Call SetAllarmePresente("AM0" + CStr(ventolaBruciatore), False)
        'End If
        '

        If (.BloccoFiammaBruciatore) And Not .BruciatoreInAccensione And .StartBruciatoreDaPLC Then
            Call StopBruciatore(tamburo)
        End If
        If (.BloccoFiammaBruciatore) And .BruciatoreInAccensione And ModulatoreBruciatoreAperto Then
            Call StopBruciatore(tamburo)
        End If

        If (.BruciatoreInAccensione And ListaMotori(ventolaBruciatore).ritorno And .BloccoFiammaBruciatore) Then
            Call StopBruciatore(tamburo)
        End If

        If (.StartBruciatoreDaPLC And .BloccoFiammaBruciatore) Then
            FrmGestioneTimer.TimerRitardoSbloccoBruciatore.Interval = 7500
            FrmGestioneTimer.TimerRitardoSbloccoBruciatore.enabled = True
        End If

        CP240.Image1(imageLec1).Visible = .StartBruciatoreDaPLC And Not ListaMotori(ventolaBruciatore).ritorno And Not FrmGestioneTimer.TimerApparecchiaturaLEC1.enabled

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-029", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub StopBruciatore(tamburo As Integer)

    With ListaTamburi(tamburo)

        If EsclusioneGestioneBruciatore Then
            Exit Sub
        End If

        If (tamburo = 0) Then
            If (Not AvvioPredosatoriSenzaBruciatore) Then
                Call PredosatoriArrestoImmediato(False, -1)
                Call PredosatoriArrestoImmediato(True, 0)
            End If
        Else
            If (Not AvvioPredosatoriSenzaBruciatore) Then
                Call PredosatoriArrestoImmediato(True, 1)
            End If
        End If

        'Simulo il pulsante di STOP bruciatore
        .AvviamentoBruciatoreCaldo = False
        .ComandoAccensioneBruciatore = False   'Stop accensione bruciatore.
        Call BrucInAccensione(tamburo)

        .ArrestaBrucFineConteggio = False
        .MemoriaAccensioneBruciatore = False
        
    End With

End Sub

Public Sub StartBruciatore(tamburo As Integer)

    With ListaTamburi(tamburo)

        .ComandoAccensioneBruciatore = True   'Start accensione bruciatore.
        Call BrucInAccensione(tamburo)

        Call MotoreUscita_change(MotoreRotazioneEssiccatore)
        Call MotoreUscita_change(MotoreRotazioneEssiccatore2)

        FrmGestioneTimer.TimerApparecchiaturaLEC1.enabled = False
        FrmGestioneTimer.TimerApparecchiaturaLEC1.Interval = 1500
        FrmGestioneTimer.TimerApparecchiaturaLEC1.enabled = True

        FrmGestioneTimer.TmrCmdBruciatore.enabled = False
        FrmGestioneTimer.TmrCmdBruciatore.Interval = 500
        FrmGestioneTimer.TmrCmdBruciatore.enabled = True

    End With

End Sub


Public Function BrucInAccensione(tamburo As Integer) As Boolean

    With ListaTamburi(tamburo)
        .BruciatoreInAccensione = (.ComandoAccensioneBruciatore And Not .FiammaBruciatorePresente)
        
        If ( _
            .BruciatoreInAccensione And _
            ((tamburo = 0 And Not ListaMotori(MotoreVentolaBruciatore).presente) Or _
            (tamburo = 1 And Not ListaMotori(MotoreVentolaBruciatore2).presente)) _
        ) Then
            ListaTamburi(tamburo).OraStartVentolaBruciatore = ConvertiTimer()
        End If

        If (tamburo = 0) Then
            Call MotoreAggiornaGrafica(MotoreRotazioneEssiccatore)
        Else
            Call MotoreAggiornaGrafica(MotoreRotazioneEssiccatore2)
        End If

    End With

End Function

Public Sub ControlloCadutaTamburoFiamma(tamburo As Integer)

    On Error GoTo Errore

    With ListaTamburi(tamburo)
        If (Not .AvviamentoBruciatoreCaldo And .FiammaBruciatorePresente And ((tamburo = 0 And Not ListaMotori(MotoreRotazioneEssiccatore).ritorno) Or (tamburo = 1 And Not ListaMotori(MotoreRotazioneEssiccatore2).ritorno))) Then
            Call StopBruciatore(tamburo)
        End If
    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-030", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ConteggioTempoArrestoBruciatore(tamburo As Integer)
	'Se ho tutti i predosatori "normali" spenti e il bruciatore acceso deve partire il tempo di arresto

    Dim predosatore As Integer
    Dim almenoUnoAcceso As Boolean

    On Error GoTo Errore

    With ListaTamburi(tamburo)
        
        If tamburo = 0 Then
            If ParallelDrum Then
                For predosatore = 0 To (PrimoPredosatoreDelNastro(RiciclatoFreddo) - 1)
                'For predosatore = 0 To NumeroPredosatoriInseriti - 1
                    If (ListaPredosatori(predosatore).motore.uscita) Then
                        almenoUnoAcceso = True
                        OraStopPredosatori = 0
                        Exit For
                    End If
                Next predosatore
            Else
                For predosatore = 0 To NumeroPredosatoriInseriti - 1
                    If (ListaPredosatori(predosatore).motore.uscita) Then
                        almenoUnoAcceso = True
                        OraStopPredosatori = 0
                        Exit For
                    End If
                Next predosatore
            End If

            'Cambio di data attorno alla mezzanotte altrimenti non va il conteggio spegnimento
            If .OraStartBruciatore > 0 Then
                If ConvertiTimer() <= 1 Then    'tra mezzanotte in punto e mezzanotte e 1 secondo
                    .OraStartBruciatore = ConvertiTimer()
                End If
            End If
    
            If .OraStartBruciatore > OraStopPredosatori Or Not TemperaturaLavoroFiltroOK Then
                OraStopPredosatori = 0
            End If

            If (Not almenoUnoAcceso And TemperaturaLavoroFiltroOK And ListaTamburi(0).FiammaBruciatorePresente And (OraStopPredosatori = 0)) Then
                OraStopPredosatori = ConvertiTimer()
            End If

            If almenoUnoAcceso Then
                .ConteggioSecondiSpegniBruciatore = .TempoStopBruciatore
            End If
            
            If almenoUnoAcceso And ListaTamburi(0).MemPortaModBrucASetAvvCaldo Then
                Call PortaModASetAvvioCaldo(0)
            End If

            If OraStopPredosatori <> 0 And TemperaturaLavoroFiltroOK Then
                .TempoArrestoBrucAttivo = TemperaturaLavoroFiltroOK And .FiammaBruciatorePresente And (.ConteggioSecondiSpegniBruciatore > 1)

                .ConteggioSecondiSpegniBruciatore = .TempoStopBruciatore - (ConvertiTimer() - OraStopPredosatori)
                CP240.LblMessaggioBruciatore(1).caption = .ConteggioSecondiSpegniBruciatore
            End If
                                       
        Else
            For predosatore = PrimoPredosatoreDelNastro(RiciclatoFreddo) To (NumeroPredosatoriRicInseriti - 1 - NumeroPredosatoriNastroC(RiciclatoJolly))
                If (ListaPredosatoriRic(predosatore).motore.uscita) Then
                    almenoUnoAcceso = True
                    OraStopPredosatoriRic = 0
                    Exit For
                End If
            Next predosatore
            
            'Cambio di data attorno alla mezzanotte altrimenti non va il conteggio spegnimento
            If .OraStartBruciatore > 0 Then
                If ConvertiTimer() <= 1 Then    'tra mezzanotte in punto e mezzanotte e 1 secondo
                    .OraStartBruciatore = ConvertiTimer()
                End If
            End If
    
            If .OraStartBruciatore > OraStopPredosatoriRic Then
                OraStopPredosatoriRic = 0
            End If
    
            If almenoUnoAcceso Then
                .ConteggioSecondiSpegniBruciatore = .TempoStopBruciatore
            End If
    
            If (Not almenoUnoAcceso) And TemperaturaLavoroFiltroOK And ListaTamburi(1).FiammaBruciatorePresente And (OraStopPredosatoriRic = 0) Then
                OraStopPredosatoriRic = ConvertiTimer()
            End If
    
            If OraStopPredosatoriRic <> 0 Then
                .ConteggioSecondiSpegniBruciatore = .TempoStopBruciatore - (ConvertiTimer() - OraStopPredosatoriRic)
                CP240.LblMessaggioBruciatore(0).caption = .ConteggioSecondiSpegniBruciatore
            End If
        
            If almenoUnoAcceso And ListaTamburi(1).MemPortaModBrucASetAvvCaldo Then
                Call PortaModASetAvvioCaldo(1)
            End If
        End If
        '

        FaseSpegnimentoBruciatore = (.FiammaBruciatorePresente And (.ConteggioSecondiSpegniBruciatore >= 0) And (.ConteggioSecondiSpegniBruciatore <= 20))

    End With

    Exit Sub
Errore:
    LogInserisci True, "BRU-031", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Function ValoreForchetta(valore As Double, min As Double, max As Double, SoloPositivo As Boolean) As Double

    If valore < min Then
        valore = min
    End If
    If valore > max Then
        valore = max
    End If
    If SoloPositivo Then
        valore = Abs(valore)
    End If
    ValoreForchetta = valore
    
End Function

Public Function VerificaCondizioniAvviamentoBruciatore(tamburo As Integer, aCaldo As Boolean) As Long

    Dim NumMotore As Integer

    With ListaTamburi(tamburo)

        VerificaCondizioniAvviamentoBruciatore = 160 'No operazione: un po' generico
        
        If tamburo = 0 Then
            NumMotore = 18
        Else
            NumMotore = 40
        End If
' 20160718
'        If (.PressioneInsufficienteOlioCombustibile And .SelezioneCombustibile <> CombustibileGas And ListaMotori(NumMotore).presente) Then
'            VerificaCondizioniAvviamentoBruciatore = 876
'            Exit Function
'        End If
'
'        If (.SelezioneCombustibile <> CombustibileGas And ListaMotori(NumMotore).presente And Not ListaMotori(NumMotore).ritorno) Then
'            'Controllo aggiuntivo in caso di bruciatori in cui la pressione olio viene "controllata"
'            'solo con pompa combustibile accesa
'            Exit Function
'        End If
      If (Not ((MotorManagement = AutomaticMotor Or ListaTamburi(0).AvviamentoBruciatoreCaldo) And (ListaTamburi(0).SelezioneCombustibile = CombustibileGasolio))) Then
            If (.PressioneInsufficienteOlioCombustibile And .SelezioneCombustibile <> CombustibileGas And ListaMotori(NumMotore).presente) Then
                VerificaCondizioniAvviamentoBruciatore = 876
                Exit Function
            End If
       End If
       If (Not ((MotorManagement = AutomaticMotor Or ListaTamburi(0).AvviamentoBruciatoreCaldo) And (ListaTamburi(0).SelezioneCombustibile = CombustibileGasolio))) Then
            If (.SelezioneCombustibile <> CombustibileGas And ListaMotori(NumMotore).presente And Not ListaMotori(NumMotore).ritorno) Then
                'Controllo aggiuntivo in caso di bruciatori in cui la pressione olio viene "controllata"
                'solo con pompa combustibile accesa
                VerificaCondizioniAvviamentoBruciatore = 1539 '20170208 1536 '20161212
                Exit Function
            End If
        End If
' 20160718

        If (ListaTemperature(TempEntrataFiltro).valore >= ValoreTempMaxFiltro) Then
            VerificaCondizioniAvviamentoBruciatore = 192
            Exit Function
        End If

        If tamburo = 0 Then
            If (Not ListaMotori(MotoreNastroElevatoreFreddo).ritorno) And Not .AvviamentoBruciatoreCaldo Then
                VerificaCondizioniAvviamentoBruciatore = 187
                Exit Function
            End If
            If (Not ListaMotori(MotoreElevatoreCaldo).ritorno) Then
                VerificaCondizioniAvviamentoBruciatore = 205
                Exit Function
            End If
        End If

        If (Not ListaMotori(MotoreAspiratoreFiltro).ritorno) Then
            VerificaCondizioniAvviamentoBruciatore = 201
            Exit Function
        End If
        
        If (Not .BruciatorePosizioneAccensione) Then
            VerificaCondizioniAvviamentoBruciatore = 612
            Exit Function
        End If

        'Bruciatore Olio: Temperatura Olio Bassa o Sicurezza Temperatura Olio
        If (.SelezioneCombustibile <> CombustibileGas And (Not .OlioCombInTemperatura Or .SicurezzaTempOlioComb)) Then
            VerificaCondizioniAvviamentoBruciatore = 160
            Exit Function
        End If

        'Bruciatore Gas: Allarme Pressione Gas o blocco LDU
        'AllarmePerditaValvoleBruc può causare anche il blocco del bruciatore che per essere
        'ripristinato ha bisogno di un successivo start
        If (.SelezioneCombustibile = CombustibileGas And .AllarmePressioneBrucAlta) Then
            VerificaCondizioniAvviamentoBruciatore = 160
            Exit Function
        End If

        If (.SelezioneCombustibile = CombustibileGas And .AllarmePerditaValvoleBruc) Then
            VerificaCondizioniAvviamentoBruciatore = 160
            Exit Function
        End If
        If (tamburo = 0) And ListaMotori(MotoreVentolaBruciatore).AllarmeTermica Then
            VerificaCondizioniAvviamentoBruciatore = 160
            Exit Function
        ElseIf (tamburo = 1) And ListaMotori(MotoreVentolaBruciatore2).AllarmeTermica Then
            VerificaCondizioniAvviamentoBruciatore = 160
            Exit Function
        End If

        If ListaTamburi(tamburo).SicurezzaTemperaturaFumiTamburoOUT Then
            VerificaCondizioniAvviamentoBruciatore = 160
            Exit Function
        End If

        '20160412
        'If (Not aCaldo) Then
        If (aCaldo) Then

            If (BassaTempBitume(False)) Then
                VerificaCondizioniAvviamentoBruciatore = 384
                Exit Function
            End If

        Else       'Not aCaldo
        '

            If ( _
                (tamburo = 0 And Not ListaMotori(MotoreRotazioneEssiccatore).ritorno) Or _
                (tamburo = 1 And Not ListaMotori(MotoreRotazioneEssiccatore2).ritorno) _
            ) Then
                VerificaCondizioniAvviamentoBruciatore = 214
                Exit Function
            End If

        End If

        VerificaCondizioniAvviamentoBruciatore = 0

    End With

End Function

Public Sub BruciatorePosizioneAccensione_change(tamburo As Integer)

    On Error GoTo Errore

    CP240.PctModulatoreOkAcc(tamburo).Visible = ListaTamburi(tamburo).BruciatorePosizioneAccensione

    Exit Sub
Errore:
    LogInserisci True, "BRU-032", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CompressoreBruciatorePressioneInsuff_change()

    On Error GoTo Errore

    CP240.Image1(9).Visible = CompressoreBruciatorePressioneInsuff

    Call IngressoAllarmePresente( _
        DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "DB342", "IdDescrizione"), _
        CompressoreBruciatorePressioneInsuff _
        )

    Call IngressoAllarmePresente( _
        DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "DB343", "IdDescrizione"), _
        (ListaMotori(MotoreCompressoreBruciatore2).presente And CompressoreBruciatore2PressioneInsuff) _
        )
    CP240.Image1(37).Visible = (ListaMotori(MotoreCompressoreBruciatore2).presente And CompressoreBruciatore2PressioneInsuff)

    Exit Sub
Errore:
    LogInserisci True, "BRU-033", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TempFumiTamburo_change(tamburo As Integer)

    On Error GoTo Errore
    
    
    Select Case tamburo
        
        Case 0
        
        Case 1
            CP240.LblTempMateriale(7).caption = ListaTemperature(TempFumiTamburo2).valore
                   
            ListaTamburi(tamburo).SuperamentoSogliaAllarmeFumiTamburo = ListaTemperature(TempFumiTamburo2).valore >= ListaTamburi(tamburo).TemperatCriticaFumiTamburoOUT
            
            If ListaTamburi(tamburo).SuperamentoSogliaAllarmeFumiTamburo Then
                Call ColoreCasellaTemperatura(CP240.LblTempMateriale(7), gialloblu)
            Else
                Call ColoreCasellaTemperatura(CP240.LblTempMateriale(7), azzurroblu)
            End If
                
    End Select

    Exit Sub
Errore:
    LogInserisci True, "BRU-034", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AltaTemperaturaFumiTamburo(tamburo As Integer)

    On Error GoTo Errore

    Select Case tamburo
    
        Case 1
                
            'Allarme termocoppia all'uscita dei fumi del tamburo
            If ListaTamburi(tamburo).SicurezzaTemperaturaFumiTamburoOUT Then
                CP240.Image1(70).Visible = (Not CP240.Image1(70).Visible)
            Else
                CP240.Image1(70).Visible = False
            End If
        
    End Select

    If ListaTamburi(tamburo).SuperamentoSogliaAllarmeFumiTamburo Then
        
        If ListaTamburi(tamburo).OraSicurezzaTemperaturaFumiTamburoOUT = 0 Then
            ListaTamburi(tamburo).OraSicurezzaTemperaturaFumiTamburoOUT = ConvertiTimer()
        End If
        
        If (ListaTamburi(tamburo).FiammaBruciatorePresente And _
            (ConvertiTimer() > ListaTamburi(tamburo).OraSicurezzaTemperaturaFumiTamburoOUT + ListaTamburi(tamburo).TempoAllTemperatCriticaFumiTamburoOUT) _
        ) Then
            Call PredosatoriInManuale
            Call BruciatoreInManuale(tamburo)
            Call StopBruciatore(tamburo)
            ListaTamburi(tamburo).SicurezzaTemperaturaFumiTamburoOUT = True
        End If
    
    Else
        ListaTamburi(tamburo).SicurezzaTemperaturaFumiTamburoOUT = False
        ListaTamburi(tamburo).OraSicurezzaTemperaturaFumiTamburoOUT = 0
    End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-035", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub DeflettoreAntincendioTamburo_change(tamburo As Integer)

    On Error GoTo Errore

    Select Case tamburo
    
        Case 1
            'Deflettore antincendio (grafica)
            If CP240.OPCData.items.item(PLCTAG_DO_Flap_Antincendio_Tamb2).Value Then
                CP240.AniPushButtonDeflettore(34).Value = 2 'orizzontale
            Else
                CP240.AniPushButtonDeflettore(34).Value = 1 'verticale
            End If
        
    End Select

    Exit Sub
Errore:
    LogInserisci True, "BRU-036", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ArrestoBrucITT()

    'Al momento, strano ma vero, non era controllato lo stato dell'ingresso dell'ITT. E' meglio farlo...

    On Error GoTo Errore
        
        If (ListaTamburi(0).FiammaBruciatorePresente Or ListaTamburi(1).FiammaBruciatorePresente) And SicurezzaTemperaturaFiltro Then
            
            If (Not ListaTamburi(0).EsclusioneAvviamentoCaldo) Then
                Call StopBruciatoreTamburo(0)
            Else
                Call StopBruciatore(0)
            End If

            If (Not ListaTamburi(1).EsclusioneAvviamentoCaldo) Then
                Call StopBruciatoreTamburo(1)
            Else
                Call StopBruciatore(1)
            End If
        End If

    Exit Sub
Errore:
    LogInserisci True, "BRU-037", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub PortaModASetAvvioCaldo(tamburo As Integer)

    Dim appoggio As ModulatoreStatusEnum
    Dim fatto As Boolean

    If ListaTamburi(tamburo).FiammaBruciatorePresente And ListaTamburi(tamburo).MemPortaModBrucASetAvvCaldo Then
        appoggio = PortaModulatoreASet(CLng(ListaTamburi(tamburo).MemPosModulatoreAvvioCaldo), ListaTamburi(tamburo).posizioneModulatoreBruciatore, 1, fatto)
        ListaTamburi(tamburo).ModulatoreBrucOnDown = (appoggio = ModulatoreStatusEnum.Modulatoredown)
        ListaTamburi(tamburo).ModulatoreBrucOnUp = (appoggio = ModulatoreStatusEnum.ModulatoreUP)
    End If

    If fatto Then
        ListaTamburi(tamburo).MemPosModulatoreAvvioCaldo = 0
        ListaTamburi(tamburo).MemPortaModBrucASetAvvCaldo = False
    End If
'
End Sub

Public Function PortaModulatoreASet(target As Long, letturaposizione As Long, Tolleranza As Integer, ByRef fatto As Boolean) As ModulatoreStatusEnum

    'considero una zona di non intervento di +- la tolleranza (espressa in unita' di posizione) per evitare il pendolamento apri/chiudi

    If letturaposizione > (target + Tolleranza) Then
        PortaModulatoreASet = Modulatoredown
        fatto = False
    ElseIf letturaposizione < (target - Tolleranza) Then
        PortaModulatoreASet = ModulatoreUP
        fatto = False
    Else
        PortaModulatoreASet = ModulatoreNone
        fatto = True
    End If

End Function

'Visualizzazione Temperatura Combustibile
Public Sub TempScambComb_change()
    On Error GoTo Errore

    CP240.LblTempScambComb.caption = ListaTemperature(TempScambComb).valore

    Exit Sub
Errore:
    LogInserisci True, "BRU-038", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'Abilitazione Avviamento a Caldo
Public Sub AbilitaAvvCaldo()
    Dim abilita As Boolean
    
    '20160909
    'abilita = MotorPrenotaAvvCaldo '20150511    And MotoriInAutomatico
    abilita = MotorPrenotaAvvCaldo And ListaMotori(MotoreElevatoreCaldo).ritorno
    MotorPrenotaAvvCaldo = abilita
    '
    CP240.CmdAvviamentoBruciatoreCaldo(0).enabled = abilita
End Sub

Public Sub AggiornaGraficaValvolaCombustibile_Change()

    Dim aperta As Boolean
    Dim visibile As Boolean
    
    Select Case ListaTamburi(0).SelezioneCombustibile

        Case CombustibileOlioCombustibile
            visibile = ValvolaOlioCombPresente
            aperta = ValvolaOlioCombAperta

        Case CombustibileGasolio
            visibile = ValvolaDieselPresente
            aperta = ValvolaDieselAperta

        Case Else
            visibile = False
            aperta = False

    End Select

    CP240.Image1(49).Visible = visibile

    If (visibile) Then

        CP240.Image1(49).Picture = LoadResPicture(IIf(aperta, "IDB_VALVOLAON", "IDB_VALVOLA"), vbResBitmap)

    End If

End Sub
'
