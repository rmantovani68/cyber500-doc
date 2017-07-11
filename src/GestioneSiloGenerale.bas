Attribute VB_Name = "GestioneSiloGenerale"

Option Explicit


Public Const MAXNUMSILI As Integer = 12
Public Type SiloType
    RitornoSelezionato As Boolean
    'TotaleKg As Long                   '20151125 NUOVA GESTIONE SILI DEPOSITO
    LivelloAlto As Boolean
    FcPortina As Boolean
    AccettaAllarmeLivelloAlto As Boolean
    Peso As Double
    materiale As String
    idMateriale As String
    Telescarico As Boolean
End Type
Public ListaSili(1 To MAXNUMSILI) As SiloType

'DestinazioneSilo
'   1 --> silo 1
'   2 --> silo 2
'   ...
'   10--> silo 10
'   11--> silo D
'   12--> silo R
Public DestinazioneSilo As Integer

Public DestinazioneSiloPrenotata As Integer
Public MemDestinazioneSiloPrenotata As Integer  '20160218
Public PesoImpastoPerSilo_InAttesa As Long
Public PesoImpastoPerSilo_InViaggio As Long
Public AbilitaCelleCaricoSilo As Boolean
Public CelleSiloTaraBilancia As Double
Public CelleSiloTolleranzaBilancia As Double
Public CelleSiloStabilizzazioneBilancia As Double
Public CelleSiloConfigurazioneSilo As String
Public ConfigurazioneTemperatureSilo As String '20151215
Public CelleSiloDetrarreTara(5) As Double                   '20151203 NUOVA GESTIONE SILI DEPOSITO
'Public CelleSiloScaricatoCamion As Double
'Public TaraCamion As Double                                 '20151202 NUOVA GESTIONE SILI DEPOSITO
Public CelleSiloValoreLetto(5) As Double
Public CelleSiloConsensoCarico_IN(3) As Boolean
Public CelleSiloConsensoScarico_OUT(3) As Boolean
Public CelleSiloUltimoStabile(5) As Double
Public CelleSiloUltimoScaricoAperto As Integer   '1=1, 2=2, ... 10=10, 11=D, 12=R
Public CelleSiloNomeFile As String
Public AbilitaVisPesoSili As Boolean
Public NumeroVisPesoSili As Integer
Public CelleSiloNavettaInScarico As Boolean
Public NumeroSili As Integer                                '20151124 NUOVA GESTIONE SILI DEPOSITO
Public TempoColpettiTelesc As Double                        '20151124 NUOVA GESTIONE SILI DEPOSITO
Public MaxTara As Double                                    '20151124 NUOVA GESTIONE SILI DEPOSITO
Public Const SILI_Diretto_PLC = 0                           '20151124 NUOVA GESTIONE SILI DEPOSITO
Public Const SILI_Diretto_PC = 11                           '20151124 NUOVA GESTIONE SILI DEPOSITO
Public Const SILI_Rifiuti_PLC = 21                          '20151124 NUOVA GESTIONE SILI DEPOSITO
Public Const SILI_Rifiuti_PC = 12                           '20151124 NUOVA GESTIONE SILI DEPOSITO
Public Const SILI_MAXPLC = 21                               '20151124 NUOVA GESTIONE SILI DEPOSITO
Public PresenzaSiloDiretto As Boolean                       '20151124 NUOVA GESTIONE SILI DEPOSITO
Public PresenzaSiloDirettoConPeso As Boolean                '20151124 NUOVA GESTIONE SILI DEPOSITO
Public PresenzaSiloRifiuti As Boolean                       '20151124 NUOVA GESTIONE SILI DEPOSITO
Public PresenzaSiloRifiutiConPeso As Boolean                '20151124 NUOVA GESTIONE SILI DEPOSITO
Public InclusioneTempiAnticipo As Boolean                   '20151124 NUOVA GESTIONE SILI DEPOSITO
Public TempiCelleSilo(1 To MAXNUMSILI) As Integer           '20151124 NUOVA GESTIONE SILI DEPOSITO
Public EventoCaricoSilo As Boolean                          '20151124 NUOVA GESTIONE SILI DEPOSITO
Public EventoTelescarico As Boolean                         '20151124 NUOVA GESTIONE SILI DEPOSITO
Public SiloCar_Tele As Integer                              '20151124 NUOVA GESTIONE SILI DEPOSITO
Public AbilitaResetCelle As Boolean                         '20151124 NUOVA GESTIONE SILI DEPOSITO
Public AbilitaLetturaSiliDeposito As Boolean                '20151124 NUOVA GESTIONE SILI DEPOSITO
Public SiliParOk As Boolean                                 '20151202 NUOVA GESTIONE SILI DEPOSITO
Public RinfrescoLetturaSiliDeposito As Boolean              '20151202 NUOVA GESTIONE SILI DEPOSITO
Public SiliDepositoTrasfPar As Boolean                      '20151130 NUOVA GESTIONE SILI DEPOSITO
Public DopoPrimoTrasferimentoSiliDeposito As Boolean        '20151130 NUOVA GESTIONE SILI DEPOSITO
Public AbilitaBilanciaCamion As Boolean                     '20151209 NUOVA GESTIONE SILI DEPOSITO
Public FondoScalaBilanciaCamion As Double                   '20151209 NUOVA GESTIONE SILI DEPOSITO
Public AbilitaFiltroBilanciaCamion As Boolean               '20151209 NUOVA GESTIONE SILI DEPOSITO
Public NumCampioniBilanciaCamion As Integer                 '20151209 NUOVA GESTIONE SILI DEPOSITO
Public TempoCampioniBilanciaCamion As Long                  '20151209 NUOVA GESTIONE SILI DEPOSITO
Public CamionPresente As Boolean                            '20160127 MR16202 NUOVA GESTIONE SILI DEPOSITO
Public IdClienteScaricoSilo As Integer                      '20151210
Public IdTargaCamionScaricoSilo As Integer                  '20151210

'Stringa di configurazione sili (sia ordine che abilitazione).
'Si utilizza notazione esadec. per silo 10 (A). Diretto 'D', Rifiuti 'R'
Public ConfigSilo As String
Public InclusioneBenna As Boolean
Public InclusioneBennaApribile As Boolean
Public VisualizzaCamionPerSiloDiretto As Boolean
Public SiloSottoDeflettori1D2 As Boolean
Public AbilitaTemperaturaSilo As Boolean
Public NumeroPirometriSilo As Integer
Public NavettaInScarico As Boolean
Public BennaPronta As Boolean
Public BennaSu As Boolean
Public FondoScalaPesoSilo As Double
Public VerificareBenna As Boolean
Public FrmSiloGeneraleVisibile As Boolean
Public BennaFineCorsaInf As Boolean
Public BennaFineCorsaInfAsse2 As Boolean
Public BinarioOkScaricoDir As Boolean
Public NavettaPosizioneCarico As Boolean
Public SirenaSiloAttiva As Boolean
Public LetturaTemperaturaSilo As Boolean
Public NumeroSiloLetturaTemperatura As Integer
'Public MaxPirometroSilo(0 To 4) As Integer
Public MaxPirometroSilo(0 To 5) As Integer '20151214
Public ScompartoScaricoSiloNoCelle As Integer
Public VisualizzaBenna As Boolean   'Se true visualizza la benna al posto della navetta
'BennaVisualizzata = -1 -> forza rivisualizzazione
'BennaVisualizzata = 00 -> benna/navetta scarica
'BennaVisualizzata = 01 -> benna/navetta carica
'BennaVisualizzata = 02 -> camion scarico
'BennaVisualizzata = 03 -> camion carico
Public BennaVisualizzata As Integer

Public AbilitazioneSpruzzaturaBennaTemporizzata As Boolean

Public InvertiQuoteXGraficoBennaS7 As Boolean
Public InvertiQuoteYGraficoBennaS7 As Boolean


Public Type DatoSiloMsgPlusType
    DatoPlusNumeroSilo As String
    DatoPlusPesoSilo As Single
    DatoPlusRicetta As String
    DatoPlusIdRicetta As Long
    DatoPlusTemperatura As Integer
End Type

Public DatoSiloMsgPlus As DatoSiloMsgPlusType

'20160503
Public Type Semaforo_Type
    Comando_Verde As Boolean
    Rit_Verde As Boolean
End Type

Public AbilitazioneSemaforoBenna As Boolean
Public AbilitazioneSemaforoSili As Boolean

Public SemaforoBenna As Semaforo_Type
Public SemaforoSili As Semaforo_Type

Public Const Semaforo_benna_index = 200
Public Const Semaforo_sili_index = 201
'20160503
'
Public MemIdDosaggioLogScarico As Double '20160217

'20161214
Public Type DeodoranteSilo
    Inclusione As Boolean
    RitStart As Long
    RitStop As Long
    DurataMax As Integer
    CmdStart As Boolean
    CmdStop As Boolean
    StopMaxDurata As Boolean
End Type
Public Deodorante As DeodoranteSilo
'20161214



'20151125 NUOVA GESTIONE SILI DEPOSITO
Public Sub CelleSiloValoreLetto_change(silo As Integer)

    On Error GoTo Errore

    If (NumeroVisPesoSili > 0 And AbilitaCelleCaricoSilo) Then
        Select Case silo
        Case 1
            CP240.lblEtichetta(121).caption = CStr(Round(CelleSiloValoreLetto(silo), 1))
        Case 2
            CP240.lblEtichetta(194).caption = CStr(Round(CelleSiloValoreLetto(silo), 1))
        Case 3
             CP240.lblEtichetta(27).caption = CStr(Round(CelleSiloValoreLetto(silo), 1))
        Case 4
            CP240.lblEtichetta(44).caption = CStr(Round(CelleSiloValoreLetto(silo), 1))
        End Select

    End If
'
'    If (AbilitaVisPesoSili And Not AbilitaCelleCaricoSilo) Then
'        'Secondo caso molto simile al primo lasciato solo per maggiore chiarezza (nessuna gestione di CelleSiloDetrarreTara)
'
'        If (silo = 0) Then
'            CP240.lblEtichetta(121).caption = CelleSiloValoreLetto(silo)
'        ElseIf (silo = 1) Then
'            CP240.lblEtichetta(194).caption = CelleSiloValoreLetto(silo)
'        End If
'    End If
'
	Exit Sub
	Errore:
    LogInserisci True, "SIL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'fine
Public Sub VisualizzaSiloPieno(silo As Integer)
    
    If FrmSiloGenerale.Visible Then '20150423
        FrmSiloGenerale.imgLivAlto(silo).Visible = ListaSili(silo).LivelloAlto
    End If
    
    CP240.imgLivAlto(silo).Visible = ListaSili(silo).LivelloAlto

    CP240.CmdSelezioneSilo(silo).enabled = (Not ListaSili(silo).LivelloAlto)

End Sub

Public Sub AttivazioneSilo(silo As Integer, siloAttivo As Boolean, ritornoSilo As Boolean)

    With CP240

        If (ritornoSilo) Then
            'VERDE
            If DestinazioneSilo = silo Then
                'VERDE
                .ImageSilo(silo).Picture = LoadResPicture("IDB_SILOON", vbResBitmap)
                
                Call .ShowBenna(BennaVisualizzata = 1 Or BennaVisualizzata = 3)
            Else
                'ROSSO
                .ImageSilo(silo).Picture = LoadResPicture("IDB_SILOERRORE", vbResBitmap)
            End If
        ElseIf (siloAttivo) Then
            'GIALLO
            .ImageSilo(silo).Picture = LoadResPicture("IDB_SILOSELEZIONATO", vbResBitmap)
            Call .ShowBenna(BennaVisualizzata = 1 Or BennaVisualizzata = 3)
        Else
            'BLU
            .ImageSilo(silo).Picture = LoadResPicture("IDB_SILO", vbResBitmap)
        End If

    End With

End Sub

Public Sub VisualizzaSiloAttivo(usaFrmSilo As Boolean)

    Dim silo As Integer
    'Dim numSilo As Integer
    Dim siloAttivo As Boolean

    On Error GoTo Errore

    For silo = 1 To MAXNUMSILI
        siloAttivo = (DestinazioneSiloPrenotata = silo)
        AttivazioneSilo silo, siloAttivo, (ListaSili(silo).RitornoSelezionato)
        If (usaFrmSilo) Then
            FrmSiloGenerale.ColoraSilo silo, siloAttivo, (ListaSili(silo).RitornoSelezionato)
        End If
    Next silo

    Exit Sub
	Errore:
    LogInserisci True, "SIL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'CONTROLLO TEMPERATURA SILO
Public Sub ValoreTempSilo_change(silo As Integer, temperatura As Long)

    On Error GoTo Errore

    If (FrmSiloGeneraleVisibile) Then
        FrmSiloGenerale.LblTempSilo(silo + 1).caption = temperatura
    End If

    If temperatura > MaxPirometroSilo(silo) Then
        MaxPirometroSilo(silo) = temperatura
    End If

    Select Case silo
        Case 0
            CP240.lblEtichetta(123).caption = temperatura
        Case 1
            CP240.lblEtichetta(124).caption = temperatura
        Case 2
            CP240.lblEtichetta(125).caption = temperatura
        Case 3
            CP240.lblEtichetta(126).caption = temperatura
        Case 4
            CP240.lblEtichetta(127).caption = temperatura
'20151214
        Case 5
            CP240.lblEtichetta(128).caption = temperatura
'
    End Select

    Exit Sub
	Errore:
    LogInserisci True, "SIL-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SiloGenerale()

    On Error GoTo Errore

    If Not ProgrammaAvviato Then
        Exit Sub
    End If


    If ( _
        (BennaFineCorsaInf And (Not InclusioneSilo2S7 Or (InclusioneSilo2S7 And BennaFineCorsaInfAsse2))) Or _
        (BinarioOkScaricoDir And InclusioneBenna) Or _
        (BinarioOkScaricoDir And (ConfigSilo = "D")) _
    ) Then
        If (Not SiloSottoDeflettori1D2) Then
            If (DestinazioneSilo <> DestinazioneSiloPrenotata And Not (SiloSottoDeflettori1D2 And ComandoScaricoMixer)) Then
                DestinazioneSilo = DestinazioneSiloPrenotata
                VisualizzaSiloAttivo FrmSiloGeneraleVisibile
            End If
        Else   '20150622
            If (DestinazioneSilo <> DestinazioneSiloPrenotata And MescolatoreChiuso) Then
                DestinazioneSilo = DestinazioneSiloPrenotata
                VisualizzaSiloAttivo FrmSiloGeneraleVisibile
            End If
        End If
    End If
    
    'Se è selezionato il silo Diretto devo segnalarlo all'operatore
    If (DestinazioneSilo = 11) And ListaSili(11).RitornoSelezionato Then
        If ConfigSilo <> "D" Then
                        
            If (CP240.ImageSilo(11).Picture = LoadResPicture("IDB_SILOON", vbResBitmap)) Then
                CP240.ImageSilo(11).Picture = LoadResPicture("IDB_SILOSELEZIONATO", vbResBitmap)
            Else
                CP240.ImageSilo(11).Picture = LoadResPicture("IDB_SILOON", vbResBitmap)
            End If
'
            If FrmSiloGenerale.Visible Then '20150423
                If (FrmSiloGenerale.ImageSilo(11).Picture = FrmSiloGenerale.PctSilo(1).Picture) Then
                    FrmSiloGenerale.ImageSilo(11).Picture = FrmSiloGenerale.PctSilo(2).Picture
                Else
                    FrmSiloGenerale.ImageSilo(11).Picture = FrmSiloGenerale.PctSilo(1).Picture
                End If
            
            End If
        End If
    End If

    Exit Sub
	Errore:
    LogInserisci True, "SIL-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Function ShowConfermaCambioSilo() As Boolean

    Dim buttonPressed As Integer

    If Len(ConfigSilo) > 1 Then
        buttonPressed = ShowMsgBox(LoadXLSString(224), vbOKCancel, vbExclamation, 12000, 13000, True)
        ShowConfermaCambioSilo = (buttonPressed = vbOK)
        
        '20170124
        If JobAttivo.StatusVB <> EnumStatoJobVB.Idle Then
            MemSelSiloJobMan = True
        End If
        '
        
        
    Else
        ShowConfermaCambioSilo = True
    End If

End Function


Public Sub LetturaTemperaturaSilo_change()
        
    Dim rs As New adodb.Recordset
    Dim indicepirometro As Integer

    On Error GoTo Errore

    If (Not AbilitaTemperaturaSilo) Then
        Exit Sub
    End If
    
    If (LetturaTemperaturaSilo And (CP240.LblNomeRicDos(1).caption <> "")) Then
        'TemperaturaSilo
        With rs
            Set .ActiveConnection = DBcon
            .Source = "Select * From TemperaturaSilo;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With
        rs.AddNew

        rs!DataOra = Now()

        Select Case NumeroSiloLetturaTemperatura
            Case 0
                NumeroSiloLetturaTemperatura = 1
                rs!numSilo = NumeroSiloLetturaTemperatura
            Case 1 To 10
                rs!numSilo = NumeroSiloLetturaTemperatura
            Case 11
                rs!numSilo = "D"
            Case 12
                rs!numSilo = "R"
            Case Else
                rs.CancelUpdate
                rs.Close
                LogInserisci True, "SIL-005-A", " NumeroSiloLetturaTemperatura = " + CStr(NumeroSiloLetturaTemperatura) + " caso non gestito"
                Exit Sub
        End Select

        Select Case NumeroSiloLetturaTemperatura
            Case 1, 2
                indicepirometro = 0
            Case 3, 4
                indicepirometro = 1
            Case 5, 6
                indicepirometro = 2
            Case 7, 8
                indicepirometro = 3
            Case 9, 10
                indicepirometro = 4
            Case 11
                indicepirometro = 5
            Case Else
                indicepirometro = 0
        End Select

        rs!temperatura = MaxPirometroSilo(indicepirometro)
        DatoSiloMsgPlus.DatoPlusTemperatura = MaxPirometroSilo(indicepirometro)
                        
        If ListaSili(NumeroSiloLetturaTemperatura).materiale <> "" Then
            rs!IdDosaggioLOG = DlookUpExt("Descrizione", "Dosaggio", ListaSili(NumeroSiloLetturaTemperatura).materiale, "IdLOG")
        Else
            rs!IdDosaggioLOG = DlookUpExt("Descrizione", "Dosaggio", CP240.LblNomeRicDos(1).caption, "IdLOG")
        End If

        rs.Update

        If (Not AbilitaCelleCaricoSilo) Then
            Call MessaggioSiloToPlus(DatoSiloMsgPlus)
        End If

        MaxPirometroSilo(indicepirometro) = 0
    
    End If


    Exit Sub
	Errore:
    LogInserisci True, "SIL-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub MessaggioSiloToPlus(DatoSilo As DatoSiloMsgPlusType, Optional NumeroTelescarico As Integer)

    Dim separatore As String
    Dim messaggio As String
    
    On Error GoTo Errore
    
    separatore = "|"

    With DatoSilo
        'conversione da numero scomparto a identificatore
        If Not AbilitaCelleCaricoSilo Then
            .DatoPlusNumeroSilo = ScompartoScaricoSiloNoCelle
        Else
            Select Case CelleSiloUltimoScaricoAperto
                Case 0
                    .DatoPlusNumeroSilo = "1"
                Case 11
                    .DatoPlusNumeroSilo = "D"
                Case 12
                    .DatoPlusNumeroSilo = "R"
                Case Else
                    .DatoPlusNumeroSilo = CStr(CelleSiloUltimoScaricoAperto)
            End Select
        End If
                
        If (Not AbilitaTemperaturaSilo) Then
            .DatoPlusTemperatura = 0
        End If
        
        If NumeroTelescarico <> 0 Then
            NumeroSiloLetturaTemperatura = NumeroTelescarico
        ElseIf NumeroSiloLetturaTemperatura = 0 Then
            NumeroSiloLetturaTemperatura = .DatoPlusNumeroSilo
        End If
        
        
        If (ListaSili(NumeroSiloLetturaTemperatura).materiale <> "") And (Not AbilitaCelleCaricoSilo) Then
            .DatoPlusRicetta = ListaSili(NumeroTelescarico).materiale
            .DatoPlusIdRicetta = 0
        ElseIf (ListaSili(NumeroSiloLetturaTemperatura).materiale <> "") And (CelleSiloUltimoScaricoAperto > 0) And (CelleSiloUltimoScaricoAperto <= MAXNUMSILI) Then
            .DatoPlusRicetta = ListaSili(CelleSiloUltimoScaricoAperto).materiale
'            .DatoPlusIdRicetta = ListaSili(CelleSiloUltimoScaricoAperto).idMateriale
            .DatoPlusIdRicetta = 0
        Else
            .DatoPlusRicetta = CP240.LblNomeRicDos(1).caption
            If (CP240.LblNomeRicDos(2).caption <> "") Then  '20150921
                .DatoPlusIdRicetta = CLng(CP240.LblNomeRicDos(2).caption)
            Else  '20150921
                .DatoPlusIdRicetta = 0  '20150921
            End If  '20150921
        End If

        '20161221
        .DatoPlusPesoSilo = 0
        If (AbilitaBilanciaCamion Or AbilitaCelleCaricoSilo) Then
        '
            .DatoPlusPesoSilo = BilanciaPesaCamion.Peso  ' per prendere i decimali
        End If

        'Formato stringa: Numero Silo-Valore Temperatura-ID Ricetta-Nome Ricetta-Peso silo
        messaggio = ""
        messaggio = messaggio + .DatoPlusNumeroSilo + separatore
        messaggio = messaggio + CStr(.DatoPlusTemperatura) + separatore
        messaggio = messaggio + CStr(.DatoPlusIdRicetta) + separatore
        messaggio = messaggio + .DatoPlusRicetta + separatore
        '20161221
        'messaggio = messaggio + CStr(.DatoPlusPesoSilo)
        messaggio = messaggio + CStr(RoundNumber(.DatoPlusPesoSilo * 1000, 0))
        '

    End With

    Call SendMessagetoPlus(PlusSendShowSILODISCHARGEMANAGER, messaggio)

    Exit Sub
	Errore:
    LogInserisci True, "SIL-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub NavettaPosizioneCarico_change()
    
    CP240.ImgBenna(3).Visible = NavettaPosizioneCarico

End Sub

Public Function VerificaEsistenzaSilo(silo As Integer) As Boolean

    Dim indice As Integer
    Dim siloStr As String

    VerificaEsistenzaSilo = False

    siloStr = GetSiloString(silo)

    For indice = 1 To Len(ConfigSilo)
        If GetSiloFromConfigSilo(indice) = siloStr Then
            VerificaEsistenzaSilo = True
            Exit Function
        End If
    Next indice

End Function

Public Function GetSiloFromConfigSilo(Index As Integer) As String

    GetSiloFromConfigSilo = UCase(Mid(ConfigSilo, Index, 1))

End Function
'20160215
Public Function PlcToSiloVB(indice As Integer) As Integer
   
    Select Case indice
        Case 0
            PlcToSiloVB = 11
        Case 21
            PlcToSiloVB = 12
        Case 1 To 10
            PlcToSiloVB = indice
        Case Else
            PlcToSiloVB = -1
    End Select

End Function
'
'20160218
Public Function SiloVBToPlc(indice As Integer) As Integer
   
    Select Case indice
        Case 11
            SiloVBToPlc = 0
        Case 12
            SiloVBToPlc = 21
        Case 1 To 10
            SiloVBToPlc = indice
        Case Else
            SiloVBToPlc = -1
    End Select

End Function
'

' GetSiloIndex: restituisce l'indice del silo(integer)
' NB. si utilizza notazione esadecimale per silo nr. 10 (A)
' Silo Diretto index 11 e Rifiuti 12
Public Function GetSiloIndex(silo As String) As Integer
    If IsNumeric(silo) Then
        GetSiloIndex = CInt(silo)
    Else
        Select Case UCase(silo)
            Case "A"
                GetSiloIndex = 10
            Case "D"
                GetSiloIndex = 11
            Case "R"
                GetSiloIndex = 12
        End Select
    End If
End Function

' GetSiloString: restituisce la lettera del silo
' NB. si utilizza notazione esadecimale per silo nr. 10 (A)
' Silo Diretto index 11 e Rifiuti 12
Public Function GetSiloString(silo As Integer) As String
    Select Case silo
        Case 10
            GetSiloString = "A"
        Case 11
            GetSiloString = "D"
        Case 12
            GetSiloString = "R"
        Case Else
            GetSiloString = CStr(silo)
    End Select
End Function

' GetSiloHexCode: restituisce il codice del silo
' 1,...9, A(hex per silo 10), R (Rifiuti), D (Diretto)
Public Function GetSiloHexCode(silo As String) As String
    GetSiloHexCode = IIf(silo = "10", "A", silo)
End Function

' SiloConfig2Combo: restituisce il numero del silo da visualizzare nel combo
' 1,...9, 10(per silo A Hex), R (Rifiuti), D (Diretto)
Public Function SiloConfig2Combo(silo As String) As String
    SiloConfig2Combo = IIf(silo = "A", "10", silo)
End Function

Public Sub PosizionaSiliCP240()
	'Posizionamento oggetti dei sili in CP240
	'1. Botte silo              --> ImageSilo(1..12)
	'2. Bottone cambio silo     --> CmdSelezioneSilo(1..12)
	'3. Livello alto            --> imgLivAlto(1..12)
	'4. Scarico silo            --> imageScaricoSilo(1..12)

	Dim i As Integer
	Dim numerosilo As Integer
	Dim Postop As Integer
	Dim PosLeft As Integer
	Dim Spaziatura As Integer

    With CP240
    
        'Nascondo tutte le parti grafiche dei sili
        For i = 1 To MAXNUMSILI
            .ImageSilo(i).Visible = False
            .CmdSelezioneSilo(i).Visible = False
            .LblTipoMaterialeS(i).Visible = False  '20160218
            .imgLivAlto(i).Visible = False
            Call VisualizzaSiloPieno(i) '20150423
            '.imageScaricoSilo(i).Visible = False
            .CmdResetScomparto(i).Visible = False
            .LblPesoSilo(i).Visible = False
        Next i
        
        'Posiziono le parti
        'Centro i sili sotto al mescolatore silo centrale left = 1160
        Postop = 750
        PosLeft = (CP240.ImgMotor(100 + MotoreMescolatore).left + CP240.ImgMotor(100 + MotoreMescolatore).width / 2) - (70 * (Len(ConfigSilo) - 1) + CP240.ImageSilo(1).width) / 2
        Spaziatura = 70
        For i = 1 To Len(ConfigSilo)
            numerosilo = GetSiloIndex(GetSiloFromConfigSilo(i))
            .ImageSilo(numerosilo).Visible = True
            .ImageSilo(numerosilo).top = Postop
            .ImageSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura)
            .CmdSelezioneSilo(numerosilo).Visible = True
            '20160218
            '.CmdSelezioneSilo(numerosilo).top = Postop + 53
            .CmdSelezioneSilo(numerosilo).top = Postop + 21
            '
            .CmdSelezioneSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + 19
'20160218
'            .imgLivAlto(numerosilo).top = Postop
            .imgLivAlto(numerosilo).top = Postop - 13
'
            .imgLivAlto(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + 15
'20160218
'            .imageScaricoSilo(numerosilo).top = Postop + 98
'            .imageScaricoSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + 15
'
            .imgLivAlto(numerosilo).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
'            .imageScaricoSilo(numerosilo).Picture = LoadResPicture("IDI_DITOGIU", vbResIcon)
            
            .LblTipoMaterialeS(numerosilo).top = Postop + 58
            .LblTipoMaterialeS(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + 1
            .LblTipoMaterialeS(numerosilo).Visible = True
            
            .CmdResetScomparto(numerosilo).Visible = True
            .CmdResetScomparto(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) - (3)
            .LblPesoSilo(numerosilo).Visible = True
            .LblPesoSilo(numerosilo).left = PosLeft + ((i - 1) * Spaziatura) + (15)
        Next i
        NumeroSili = Len(ConfigSilo) '20151124 Nuova Gestione Sili Deposito
        PresenzaSiloDiretto = False
        PresenzaSiloRifiuti = False
        For i = 1 To Len(ConfigSilo)
            If Mid(ConfigSilo, i, 1) = "R" Then
                PresenzaSiloRifiuti = True
            End If
            If Mid(ConfigSilo, i, 1) = "D" Then
                PresenzaSiloDiretto = True
            End If
        Next i
        If (PresenzaSiloDiretto) Then
            NumeroSili = NumeroSili - 1
        End If
        If (PresenzaSiloRifiuti) Then
            NumeroSili = NumeroSili - 1
        End If

        .Frame1(4).left = PosLeft + (Len(ConfigSilo)) * 70
        .Frame1(18).left = PosLeft - 60
    End With
      
    Dim numSilo As Integer
    Dim progressivoSilo As Integer
    Dim indice As Integer
    Dim primoSilo As Integer

    primoSilo = val(Mid(ConfigSilo, 1, 1))
    If primoSilo = 1 Then
        'routine che ha problemi quando si usa anche il silo R
        For indice = 1 To Len(ConfigSilo) - 1
            numSilo = val(Mid(ConfigSilo, indice, 1))
            If numSilo <> 0 Then
                If numSilo Mod (2) <> 0 Then
                    CP240.lblEtichetta(123 + progressivoSilo).left = CP240.ImageSilo(progressivoSilo * 2 + 1).left + 40
                    CP240.Image10(16 + progressivoSilo).left = CP240.lblEtichetta(123 + progressivoSilo).left + 3
                    progressivoSilo = progressivoSilo + 1
                End If
            Else
                If (Mid(ConfigSilo, indice, 1) = "D" Or Mid(ConfigSilo, indice, 1) = "R") And numSilo = 0 Then
                    CP240.lblEtichetta(123 + progressivoSilo - 1).left = CP240.ImageSilo(11).left + 7
                    CP240.Image10(16 + progressivoSilo - 1).left = CP240.lblEtichetta(123 + progressivoSilo - 1).left + 3
                Else
                    CP240.lblEtichetta(123 + progressivoSilo - 1).left = CP240.ImageSilo(11).left + 7
                    CP240.Image10(16 + progressivoSilo - 1).left = CP240.lblEtichetta(123 + progressivoSilo - 1).left + 3
                End If
            End If
            For i = 0 To NumeroPirometriSilo - 1
                CP240.lblEtichetta(123 + i).top = 850
                CP240.Image10(16 + i).top = CP240.lblEtichetta(123 + i).top - 10
            Next i
        Next indice
    Else
        For i = 0 To NumeroPirometriSilo - 1
            CP240.lblEtichetta(123 + i).top = 745 + 32 * i
            If primoSilo = 0 Then
                If (Mid(ConfigSilo, 1, 1) = "D") Then
                    CP240.lblEtichetta(123 + i).left = CP240.ImageSilo(11).left - 120
                Else
                    CP240.lblEtichetta(123 + i).left = CP240.ImageSilo(12).left - 120
                End If
            Else
                CP240.lblEtichetta(123 + i).left = CP240.ImageSilo(primoSilo).left - 120
            End If
            CP240.Image10(16 + i).left = CP240.lblEtichetta(123 + i).left + 4
            CP240.Image10(16 + i).top = CP240.lblEtichetta(123 + i).top - 10
        Next
    End If
    
'20151216
    For i = 0 To NumeroPirometriSilo - 1
        CP240.lblEtichetta(140 + i).left = CP240.lblEtichetta(123 + i).left - CP240.lblEtichetta(140 + i).width - 20
        CP240.lblEtichetta(140 + i).top = CP240.lblEtichetta(123 + i).top + 5
    Next i
'
    
        
'20150703
    If InclusioneSiloS7 Then
        Call SiloS7IconStatusUpdate '20150423
    Else
        CP240.Image1(10).Visible = False
    End If
'
        
End Sub

Public Sub AggiornaPesoSilo(DestinazioneSilo As Integer)

    Dim i As Integer
    Dim rs As New adodb.Recordset '20151214
    
    'Uso un buffer a 2 posizioni per memorizzare il peso da mettere nel silo
    'Posizione 0 = PesoImpastoPerSilo_InViaggio
    'Posizione 1 = PesoImpastoPerSilo_InAttesa
    'Prima metto nella posizione 0 poi nella 1 se la 0 è già occupata, ovvero se ho la benna in giro per la consegna = benna + navetta
    'ListaSili(DestinazioneSilo).TotaleKg = ListaSili(DestinazioneSilo).TotaleKg + PesoScaricatoTemp
    'PesoScaricatoTemp = 0
    'ListaSili(DestinazioneSilo).TotaleKg = ListaSili(DestinazioneSilo).TotaleKg + PesoImpastoPerSilo_InViaggio         20151125 NUOVA GESTIONE SILI DEPOSITO
'    PesoImpastoPerSilo_InViaggio = IIf(PesoImpastoPerSilo_InAttesa > 0, PesoImpastoPerSilo_InAttesa, 0)
'    PesoImpastoPerSilo_InAttesa = 0
'    ListaSili(DestinazioneSilo).TotaleKg = ListaSili(DestinazioneSilo).peso                     '20151125 NUOVA GESTIONE SILI DEPOSITO
    i = DestinazioneSilo
    
'20160215
    If FrmSiloGenerale.Visible Then
        FrmSiloGenerale.LblTipoMaterialeS(i).caption = ListaSili(i).materiale
    End If
    CP240.LblTipoMaterialeS(i).caption = ListaSili(i).materiale
'
    
    CP240.ImageSilo(i).ToolTipText = ListaSili(i).materiale
    '20151125 NUOVA GESTIONE SILI DEPOSITO
'    If Not AbilitaCelleCaricoSilo Then
'        CP240.LblPesoSilo(i).caption = RoundNumber(ListaSili(i).TotaleKg / 1000, 2) '20150903
'        Call ScritturaPesoSili(i)
'        If (Not CP240.AdoDosaggioScarico.Recordset.EOF) Then
'            ListaSili(DestinazioneSilo).materiale = CP240.AdoDosaggioScarico.Recordset.Fields("Descrizione").Value
'            ListaSili(DestinazioneSilo).idMateriale = CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value
'        End If
'
'        FrmSiloGenerale.LblTipoMaterialeS(i).caption = ListaSili(DestinazioneSilo).materiale
'    Else
'        CP240.LblPesoSilo(i).caption = Round(ListaSili(i).peso, 2) '20150903
'    End If
        CP240.LblPesoSilo(i).caption = RoundNumber(ListaSili(i).Peso, 2) '20150903
        
'        If (Not CP240.AdoDosaggioScarico.Recordset.EOF) Then
'            ListaSili(DestinazioneSilo).materiale = CP240.AdoDosaggioScarico.Recordset.Fields("Descrizione").Value
''20151214
''            ListaSili(DestinazioneSilo).idMateriale = CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value
'            ListaSili(DestinazioneSilo).idMateriale = GetIdDosaggioLOGScarico(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value)
''
'        End If

End Sub

Public Sub PortinaScaricoSilo_Change(NumeroSiloScaricato As Integer)

    On Error GoTo Errore

    'FrmSiloGenerale.imageScaricoSilo(NumeroSiloScaricato).Visible = ListaSili(NumeroSiloScaricato).FcPortina
        
    If ListaSili(NumeroSiloScaricato).FcPortina Then
        NumeroSiloLetturaTemperatura = NumeroSiloScaricato
        CP240.LblPesoSilo(NumeroSiloScaricato).BackColor = vbGreen
    Else
        CP240.LblPesoSilo(NumeroSiloScaricato).BackColor = &HC0C0FF
    End If

    Exit Sub
	Errore:
    LogInserisci True, "SIL-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SegnalazioneScaricoBennaNavetta(InScarico As Boolean)
    Dim i As Integer
    Dim Postop As Integer
    Dim PosLeft As Integer
    Dim Spaziatura As Integer

    On Error GoTo Errore

    Spaziatura = 70
    Postop = 710

    PosLeft = (CP240.ImgMotor(100 + MotoreMescolatore).left + CP240.ImgMotor(100 + MotoreMescolatore).width / 2) - (70 * (Len(ConfigSilo) - 1) + CP240.ImageSilo(1).width) / 2 + (CP240.ImageSilo(1).width / 2) - CP240.ImgBenna(1).width / 2

'20150423
'    If InScarico Then
'    If InScarico Or DestinazioneSilo = 11 Then
    If InScarico Or (DestinazioneSilo = 11 And Not InclusioneSiloS7) Then
'

        BennaPiena = False
        'Con la benna a FC superiore azzero il timer di controllo benna piena
        FrmGestioneTimer.TimerBennaPiena.enabled = False
        '

        CP240.ShowBenna False

        For i = 1 To Len(ConfigSilo)
            If DestinazioneSilo = GetSiloIndex(GetSiloFromConfigSilo(i)) Then
                'Posiziono la benna in scarico sul silo
                CP240.ImgBenna(1).top = Postop
                CP240.ImgBenna(1).left = PosLeft + (i - 1) * Spaziatura
 '20160906
'                CP240.ImgBenna(1).Visible = InclusioneBenna
                CP240.ImgBenna(1).Visible = InclusioneBenna And InScarico
'

                'Aggiorno il peso nel silo
'                Call AggiornaPesoSilo(DestinazioneSilo)    '20151125 NUOVA GESTIONE SILI DEPOSITO
            End If
        Next i

    Else
        CP240.ImgBenna(1).Visible = False
    End If

    If DestinazioneSilo = 11 Then
        If BinarioOkScaricoDir Then
            CP240.ImgBenna(1).Visible = False
        End If
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "SIL-008", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SegnalazioneBennaSu(BennaSu As Boolean)
	'    Dim i As Integer
	'    Dim Postop As Integer
	'    Dim PosLeft As Integer
	'    Dim Spaziatura As Integer

    On Error GoTo Errore

    If BennaSu Then
        CP240.ShowBenna False
        CP240.ImgBenna(4).Visible = True

        'Uso un buffer a 2 posizioni per memorizzare il peso da mettere nel silo
        'Posizione 0 = PesoImpastoPerSilo_InViaggio
        'Posizione 1 = PesoImpastoPerSilo_InAttesa
        'If (DestinazioneSilo <> 11 Or Not BinarioOkScaricoDir) And (PesoContenutoInBenna > 0) Then
        '        PesoContenutoInNavetta = PesoContenutoInBenna
        '        PesoContenutoInBenna = 0
        '    End If
        'End If
        '
    Else
        CP240.ImgBenna(4).Visible = False
    End If
    If DestinazioneSilo = 11 Then
        If BinarioOkScaricoDir Then
            CP240.ImgBenna(4).Visible = False
        End If
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "SIL-009", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub VerificaSirenaLivelloAlto(indice As Integer)

    Dim Criterio As String
    Dim posizione As Integer

    If (Not VerificaEsistenzaSilo(indice)) Then
        Exit Sub
    End If

    Select Case indice
        Case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
            Criterio = "GS01" + CStr(indice - 1)
        Case 11
            Criterio = "GS020"
        Case 12
            'Rifiuti non previsto livello alto
            Exit Sub
    End Select

    If (ListaSili(indice).LivelloAlto) Then
        'Allarme Silo Alto dopo 3 sec di permanenza
        FrmGestioneTimer.TimerLivelloAltoSilo(indice - 1).enabled = True
    Else
        ListaSili(indice).AccettaAllarmeLivelloAlto = False
        'Allarme Silo Alto dopo 3 sec di permanenza
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        IngressoAllarmePresente posizione, False
        FrmGestioneTimer.TimerLivelloAltoSilo(indice - 1).enabled = False
        Call AttivazioneSirena(False)
    End If

End Sub

Public Sub LivelloAltoScomparto_change(indice As Integer)

    On Error GoTo Errore

    Call VerificaSirenaLivelloAlto(indice)
    Call VisualizzaSiloPieno(indice)

    Exit Sub
	Errore:
    LogInserisci True, "SIL-010", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub TelescarichiSilo_Change(silo As Integer)

    On Error GoTo Errore

    If ListaSili(silo).Telescarico Then
        CelleSiloUltimoScaricoAperto = silo
    End If
    
    Exit Sub
	Errore:
    LogInserisci True, "SIL-011", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
Public Sub CaricoSilo_change(silo As Integer)
    ListaSili(ScompartiSiliPLC_a_PC(silo)).materiale = CP240.AdoDosaggioScarico.Recordset.Fields("Descrizione").Value

'20151214
'    ListaSili(ScompartiSiliPLC_a_PC(silo)).idMateriale = CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value
    ListaSili(ScompartiSiliPLC_a_PC(silo)).idMateriale = GetIdDosaggioLOGScarico(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value)
'

End Sub
'20151124 NUOVA GESTIONE SILI DEPOSITO
Public Sub TelescaricoSilo_change(scomparto As Integer)
    Exit Sub
End Sub

Public Sub CelleSiloScriviTXT(NumeroModuloSilo As Integer)
	'Memorizzo nel file TXT:
	'   GEN.    Peso scaricato nel camion
	'   1.      Peso di ogni scomparto
	'   2.      Materiale di ogni scomparto
	'   3.      Tara modulo silo
	'   4.      Peso complessivo del modulo silo

	Dim i As Integer
	Dim appoggio As String

    '20151125 NUOVA GESTIONE SILI DEPOSITO
    If (NumeroModuloSilo >= 0) Then
        'CELLE
        Dim NumModuloSilo As Integer
        Dim presenza_diretto_silocorr As Boolean
        Dim presenza_rifiuti_silocorr As Boolean
        presenza_diretto_silocorr = False
        presenza_rifiuti_silocorr = False
        'fine
        '20151125 NuovaGestionePesiSilo: nell'accesso agli array CelleSiloDetrarreTara=Tare e CelleSiloValoreLetto=Valore celle carico si parte da 1 e non da 0
        NumModuloSilo = NumeroModuloSilo + 1
    
        'FileSetValue CelleSiloNomeFile, "SiloGEN", "CelleSiloScaricatoCamion", CelleSiloScaricatoCamion
        'fine
        appoggio = RicavaDestinazioniDaModuloSilo(NumeroModuloSilo, CelleSiloConfigurazioneSilo)
        For i = 1 To Len(appoggio)
            FileSetValue CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloScomparto" & Mid(appoggio, i, 1), ListaSili(GetSiloIndex(Mid(appoggio, i, 1))).Peso
            FileSetValue CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloMateriale" & Mid(appoggio, i, 1), ListaSili(GetSiloIndex(Mid(appoggio, i, 1))).materiale
        Next i
        
        'Salvo la tara
        '20151203 NUOVA GESTIONE SILI DEPOSITO
        If (NumeroModuloSilo <= 3) Then
            FileSetValue CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloDetrarreTara", CelleSiloDetrarreTara(NumModuloSilo)
        End If
        'fine
    End If
End Sub
Public Sub SiloScriviTXTSenzaCelle(scomparto As Integer) '20151202 NUOVA GESTIONE SILI DEPOSITO
    If (scomparto >= 0 And scomparto <= SILI_MAXPLC) Then
        If (ScompartiSiliPLC_a_PC(scomparto) > 0) Then
            FileSetValue CelleSiloNomeFile, "SiloSenzaCelle", "CelleSiloScomparto" & GetSiloString(ScompartiSiliPLC_a_PC(scomparto)), ListaSili(ScompartiSiliPLC_a_PC(scomparto)).Peso
            FileSetValue CelleSiloNomeFile, "SiloSenzaCelle", "CelleSiloMateriale" & GetSiloString(ScompartiSiliPLC_a_PC(scomparto)), ListaSili(ScompartiSiliPLC_a_PC(scomparto)).materiale
        End If
    End If
End Sub

Public Sub CelleSiloLeggiTXT(NumeroModuloSilo As Integer)
	'Leggo dal file TXT:
	'   GEN.    Peso scaricato nel camion
	'   1.      Peso di ogni scomparto
	'   2.      Materiale di ogni scomparto
	'   3.      Tara modulo silo
	'   4.      Peso complessivo del modulo silo

	Dim i As Integer
	Dim appoggio As String
	Dim PesoLettoBilancia As Double
    If (NumeroModuloSilo >= 0) Then
        Dim NumModuloSilo As Integer

        NumModuloSilo = NumeroModuloSilo + 1
    
        'CelleSiloScaricatoCamion = CDbl(FileGetValue(CelleSiloNomeFile, "SiloGEN", "CelleSiloScaricatoCamion", "0"))
        'fine
        appoggio = RicavaDestinazioniDaModuloSilo(NumeroModuloSilo, CelleSiloConfigurazioneSilo)
        For i = 1 To Len(appoggio)
            ListaSili(GetSiloIndex(Mid(appoggio, i, 1))).Peso = CDbl(FileGetValue(CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloScomparto" & Mid(appoggio, i, 1), 0))
	'20160215
	'            ListaSili(GetSiloIndex(Mid(appoggio, i, 1))).materiale = CStr(FileGetValue(CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloMateriale" & Mid(appoggio, i, 1), ""))
	'
        Next i

        '20151125 NUOVA GESTIONE SILI DEPOSITO
        If (NumModuloSilo <= 4) Then
            PesoLettoBilancia = CelleSiloValoreLetto(NumModuloSilo)
            CelleSiloDetrarreTara(NumModuloSilo) = CDbl(FileGetValue(CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloDetrarreTara", "0"))
            CelleSiloValoreLetto(NumModuloSilo) = CDbl(FileGetValue(CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloValoreLetto", "0"))
'            If (Abs(PesoLettoBilancia - CelleSiloValoreLetto(NumModuloSilo)) < CelleSiloTolleranzaBilancia) Or Not AbilitaLetturaSiliDeposito Then 20151210
'                'Tutto OK, non è cambiata la quantità di materiale contenuto nei sili
'            Else
'                CelleSiloScaricatoCamion = 0
'                For i = 1 To Len(appoggio)
'                    ListaSili(GetSiloIndex(Mid(appoggio, i, 1))).Peso = 0
'                    ListaSili(GetSiloIndex(Mid(appoggio, i, 1))).materiale = ""
'                Next i
'                CelleSiloValoreLetto(NumModuloSilo) = PesoLettoBilancia
'                CelleSiloDetrarreTara(NumModuloSilo) = 0
'                Call CelleSiloScriviTXT(NumModuloSilo)
'                Call CelleSiloScriviTXTCamion
'            End If
        End If
        
        'Tara
        If (NumeroModuloSilo <= 3) Then
            CelleSiloDetrarreTara(NumModuloSilo) = CDbl(FileGetValue(CelleSiloNomeFile, "Silo" & Format(NumeroModuloSilo, "00"), "CelleSiloDetrarreTara", "0"))
        End If
    End If

    For i = 1 To Len(appoggio)
        Call AggiornaPesoSilo(GetSiloIndex(Mid(appoggio, i, 1)))
    Next i
    'CelleSiloUltimoStabile(NumeroModuloSilo) = CelleSiloValoreLetto(NumeroModuloSilo) - CelleSiloDetrarreTara(NumeroModuloSilo)
	'20151216
	'    CP240.lblEtichetta(21).caption = RoundNumber(BilanciaPesaCamion.Peso, 1)
	'
End Sub
Public Sub SiloLeggiTXTSenzaCelle(scomparto As Integer) '20151202 NUOVA GESTIONE SILI DEPOSITO
    If (scomparto >= 0 And scomparto <= SILI_MAXPLC) Then
        If (ScompartiSiliPLC_a_PC(scomparto) > 0) Then
            ListaSili(ScompartiSiliPLC_a_PC(scomparto)).Peso = CDbl(FileGetValue(CelleSiloNomeFile, "SiloSenzaCelle", "CelleSiloScomparto" & GetSiloString(ScompartiSiliPLC_a_PC(scomparto)), 0))
	'20160215
	'            ListaSili(ScompartiSiliPLC_a_PC(scomparto)).materiale = CStr(FileGetValue(CelleSiloNomeFile, "SiloSenzaCelle", "CelleSiloMateriale" & GetSiloString(ScompartiSiliPLC_a_PC(scomparto)), ""))
	'
        End If
    End If
End Sub

'Nuova Gestione Celle
Public Sub CelleSiloLeggiTXTCamion()
    BilanciaPesaCamion.Peso = CDbl(FileGetValue(CelleSiloNomeFile, "SiloGEN", "BilanciaPesaCamion.Peso", "0"))
    BilanciaPesaCamion.Tara = CDbl(FileGetValue(CelleSiloNomeFile, "SiloGEN", "BilanciaPesaCamion.Tara", "0"))
End Sub
Public Sub CelleSiloScriviTXTCamion()
    FileSetValue CelleSiloNomeFile, "SiloGEN", "BilanciaPesaCamion.Peso", BilanciaPesaCamion.Peso
    FileSetValue CelleSiloNomeFile, "SiloGEN", "BilanciaPesaCamion.Tara", BilanciaPesaCamion.Tara
End Sub
Public Sub CelleSiloInizializza()

Dim i As Integer
Dim J As Integer
'    CelleSiloNomeFile = UserDataPath & "Silo_Load_Cells.txt"
    CelleSiloNomeFile = UserDataPath & "SiloDepositoPeso.ini"
    If Dir(UserDataPath & "SiloDepositoPeso.ini") = "" Then
        Open UserDataPath & "SiloDepositoPeso.ini" For Output As #512
        Close #512
    End If
    If Dir(UserDataPath & "PesaCamion.ini") = "" Then
        Open UserDataPath & "PesaCamion.ini" For Output As #512
        Close #512
    End If
    
    If (AbilitaCelleCaricoSilo) Then
        CelleSiloNomeFile = UserDataPath & "SiloDepositoPeso.ini"
        For i = 0 To CalcolaNumeroModuliSilo(CelleSiloConfigurazioneSilo) - 1
            Call CelleSiloLeggiTXT(i)
        Next i
    Else
        For i = 0 To SILI_MAXPLC
            J = ScompartiCompattaSalta(i)
            If (J >= 0) Then
                'leggo solo gli scomparti configurati
                Call SiloLeggiTXTSenzaCelle(i)
            End If
        Next i
    End If
    CelleSiloLeggiTXTCamion
End Sub

Public Function AzzeraSeNegativo(valore As Variant) As Variant

    AzzeraSeNegativo = valore
    If valore < 0 Then
        AzzeraSeNegativo = 0
    End If
    
End Function

Public Function CalcolaNumeroModuliSilo(Stringa) As Integer

	Dim i As Integer
    
    CalcolaNumeroModuliSilo = 1
    For i = 1 To Len(Stringa)
        If Mid(Stringa, i, 1) = "+" Then
            CalcolaNumeroModuliSilo = CalcolaNumeroModuliSilo + 1
        End If
    Next i

End Function

Public Function RicavaDestinazioniDaModuloSilo(NumeroModulo As Integer, StringaConfigurazione As String) As String

	Dim ContaPiu As Integer
	Dim i As Integer

    For i = 1 To Len(StringaConfigurazione)
        If Mid(StringaConfigurazione, i, 1) <> "+" Then
            If (NumeroModulo = ContaPiu) Then
                RicavaDestinazioniDaModuloSilo = RicavaDestinazioniDaModuloSilo + Mid(StringaConfigurazione, i, 1)
            End If
        Else
            ContaPiu = ContaPiu + 1
        End If
    Next i

End Function

Public Function ScompartiSiliPC_a_PLC(ByVal scomparto As Integer) As Integer   '20151202 NUOVA GESTIONE SILI DEPOSITO
    ScompartiSiliPC_a_PLC = -1
    Select Case scomparto
        Case SILI_Diretto_PC
            ScompartiSiliPC_a_PLC = SILI_Diretto_PLC
        Case SILI_Rifiuti_PC
            ScompartiSiliPC_a_PLC = SILI_Rifiuti_PLC
        Case 1 To 10
            ScompartiSiliPC_a_PLC = scomparto
    End Select
End Function
Public Function ScompartiSiliPLC_a_PC(ByVal scomparto As Integer) As Integer  '20151202 NUOVA GESTIONE SILI DEPOSITO
    ScompartiSiliPLC_a_PC = -1
    Select Case scomparto
        Case SILI_Diretto_PLC
            ScompartiSiliPLC_a_PC = SILI_Diretto_PC
        Case SILI_Rifiuti_PLC
            ScompartiSiliPLC_a_PC = SILI_Rifiuti_PC
        Case 1 To 10
            ScompartiSiliPLC_a_PC = scomparto
    End Select
End Function
Public Function ScompartiCompattaSalta(ByVal scomparto As Integer) As Integer  '20151202 NUOVA GESTIONE SILI DEPOSITO
    ScompartiCompattaSalta = -2
    Select Case scomparto
        Case SILI_Diretto_PLC To 10
            If (scomparto = SILI_Diretto_PLC) Then
                If (PresenzaSiloDiretto) Then
                    ScompartiCompattaSalta = SILI_Diretto_PLC
                Else
                    ScompartiCompattaSalta = -1  'non in configurazione
                End If
            Else
                If (scomparto <= NumeroSili) Then
                    ScompartiCompattaSalta = scomparto
                Else
                    ScompartiCompattaSalta = -1  'non in configurazione
                End If
            End If
        Case SILI_Rifiuti_PLC
            If (PresenzaSiloRifiuti) Then
                ScompartiCompattaSalta = 11
            Else
                ScompartiCompattaSalta = -1  'non in configurazione
            End If
        Case 11 To 20
            ScompartiCompattaSalta = -2  'valori da saltare
    End Select
End Function
Public Function ScompartiCompatta(ByVal scomparto As Integer) As Integer  '20151202 NUOVA GESTIONE SILI DEPOSITO
    ScompartiCompatta = -2
    Select Case scomparto
        Case SILI_Diretto_PLC To 10
            ScompartiCompatta = scomparto
        Case 11 To 20
            ScompartiCompatta = -2 'da saltare
        Case SILI_Rifiuti_PLC
            ScompartiCompatta = 11
    End Select
End Function


Public Function RicavaModuloSiloDaDestinazione(destinazione As Integer) As Integer

Dim i As Integer
    RicavaModuloSiloDaDestinazione = -1
    For i = 0 To 3
        If DestinazioneSiloAppartieneModuloSilo(destinazione, i) Then
            RicavaModuloSiloDaDestinazione = i
            Exit For
        End If
    Next i
End Function


Public Function DestinazioneSiloAppartieneModuloSilo(destinazione As Integer, NumeroModulo As Integer) As Boolean

Dim i As Integer
Dim DestAppoggio As String
    
    Select Case destinazione
        Case SILI_Diretto_PLC
            DestAppoggio = "D"
        Case SILI_Rifiuti_PLC
            DestAppoggio = "R"
        Case 1 To 10
            DestAppoggio = destinazione
        Case Else
    
    End Select
    DestinazioneSiloAppartieneModuloSilo = False
    For i = 1 To Len(RicavaDestinazioniDaModuloSilo(NumeroModulo, CelleSiloConfigurazioneSilo))
        If DestAppoggio = Mid(RicavaDestinazioniDaModuloSilo(NumeroModulo, CelleSiloConfigurazioneSilo), i, 1) Then
            DestinazioneSiloAppartieneModuloSilo = True
            Exit Function
        End If
    Next i
End Function


Public Sub ScaricoSiloSenzaCelleCarico(Peso As String)
    'Dim pesosilo As String
    Dim pesosilosplitted() As String
    Dim silo As Integer
    '20151120
    'Dim pesodasottr As Integer
    'Dim TonDaSottrarre As Double
    Dim KgDaSottrarre As Double
    '

    pesosilosplitted = Split(Peso, "|")

    '20151120
    'pesodasottr = CInt(pesosilosplitted(0))
    KgDaSottrarre = String2Double(pesosilosplitted(0))
    '
    
    silo = pesosilosplitted(1)
    'indice = CInt(InStr(Peso, "|"))

    'silo = CInt(Mid(Peso, indice + 1, Len(Peso) - indice + 1))

    'TonDaSottrarre = String2Double(Mid(peso, 1, pesodasottr - 1))
    '20151120
    'TonDaSottrarre = pesodasottr
    '
    If (silo > 0 And silo <= MAXNUMSILI) Then  '20150921
        '20151120
        'ListaSili(silo).TotaleKg = ListaSili(silo).TotaleKg - (TonDaSottrarre * 1000)
        'ListaSili(silo).TotaleKg = ListaSili(silo).TotaleKg - KgDaSottrarre
        '20151125 NUOVA GESTIONE SILI DEPOSITO (TotaleKg -> Peso)
        Dim appreal As Double
        appreal = ListaSili(silo).Peso - KgDaSottrarre / 1000
        '
        If (appreal > 0) Then
            'Detrazione peso abilitata nel caso senza celle oppure con celle ma scomparto non a lato
            CP240.OPCData.items(PLCTAG_SILI_HMI_ScriviScomparto).Value = True
            CP240.OPCData.items(PLCTAG_SILI_HMI_NumeroScomparto).Value = ScompartiSiliPC_a_PLC(silo)
            CP240.OPCData.items(PLCTAG_SILI_HMI_ValorePesoScomparto).Value = appreal
        End If

    Else    '20150929
        pesosilosplitted = Split(silo, CStr(PlusRecvWindowVisible))
        silo = pesosilosplitted(0)
        Call VisualizzaBarraPulsantiCP240(True)
    End If '20150921

End Sub

'20151103
Public Sub PesoCamion_change()
    
    Dim pesoton As Double '20170224
    
    pesoton = BilanciaPesaCamion.Peso / CDbl(1000) '20170224
    
    With CP240.ProgressBil(3)
        .Value = pesoton '20170224
        If BilanciaPesaCamion.Peso > 0 Then
            '20170224
            '.caption = Format(Round(BilanciaPesaCamion.Peso / CDbl(1000), 2), "##0.00") & "T"
            .caption = Format(Round(pesoton, 2), "##0.00") & "T"
        Else
            .caption = "-0.00"
        End If
    
        .FillColor = IIf(pesoton > BilanciaPesaCamion.Sicurezza, vbRed, vbBlue) '20170224
    End With

    With CP240.ProgressBil(9)
        .Value = Round(pesoton, 0) '20170221
        .FillColor = IIf(pesoton > BilanciaPesaCamion.Sicurezza, vbRed, vbBlack) '20170224
    End With

End Sub
'
'20151111
Public Sub AggiornaAnalogicaPesaCamion_change()
    
    If FrmCalibBilCamion.Visible Then
        FrmCalibBilCamion.lblUnitaAnalogiche = BilanciaPesaCamion.ValoreAnalogico
    End If
    
End Sub
'


'20151210
Public Sub RegistraScaricoSiloDB()

    Dim rs As New adodb.Recordset
    Dim indice As Integer
    Dim ora As Variant
    Dim modificato As Boolean

    On Error GoTo Errore

    ora = Now

    With rs
        Set .ActiveConnection = DBcon
        .Source = "Select * From StoricoScarichiSili;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With

    '20170223
    'For indice = 0 To MAXNUMSILI - 1
    For indice = 1 To MAXNUMSILI
        '20170221
        If Not (IsNull(ListaSili(indice).idMateriale)) And (ListaSili(indice).idMateriale <> "") Then

    '20160217
    '        If (AbilitaBilanciaCamion Or AbilitaCelleCaricoSilo) Then
            If PlcToSiloVB(indice) > 0 Then  '20160217
    '
                '20170221
                If CP240.OPCData.items(PLCTAG_SILI_HMI_Storico_ScarichiPesi0 + indice).Value > 0 Then  '20160127 MR16202
                '
                    rs.AddNew
                    rs!DataOra = ora
                    rs!numerosilo = indice
                    rs!IdDosaggioLOG = ListaSili(indice).idMateriale
                    rs!temperatura = CP240.OPCData.items(PLCTAG_SILI_HMI_Storico_ScarichiTemperature0 + indice).Value
                    rs!Peso = CP240.OPCData.items(PLCTAG_SILI_HMI_Storico_ScarichiPesi0 + indice).Value
                    If IdClienteScaricoSilo <> 0 Then
                        rs!IdClienteLOG = IdClienteScaricoSilo
                    End If
                    If IdTargaCamionScaricoSilo <> 0 Then
                        rs!IdCamionLog = IdTargaCamionScaricoSilo
                    End If
                    modificato = True
                    Exit For '20170223
                End If
            Else
            '20160127 MR16202
                If CP240.OPCData.items(PLCTAG_SILI_HMI_Storico_ScarichiTemperature0 + indice).Value > 0 Then  '20160127 MR16202
                    rs.AddNew
                    rs!DataOra = ora
                    rs!numerosilo = indice
                    rs!IdDosaggioLOG = ListaSili(indice).idMateriale
                    rs!temperatura = CP240.OPCData.items(PLCTAG_SILI_HMI_Storico_ScarichiTemperature0 + indice).Value
                    modificato = True
                    Exit For '20170223
                End If
            '20160127 MR16202
            End If
        End If
    Next indice
    'x debug
    'Debug.Print "PassaStoricoSili"
    '

    If modificato Then
        rs.Update
    End If
    rs.Close
        
    Exit Sub

Errore:
    LogInserisci True, "SIL-014", CStr(Err.Number) + " [" + Err.description + "]"

End Sub

'20151214
Public Function GetIdDosaggioLOGScarico(IdDosaggioAct As Integer) As Integer
    Dim rs As New adodb.Recordset

    On Error GoTo Errore

    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT [IdDosaggioLOG], [IdDosaggio] FROM DosaggioLOG WHERE IdDosaggio=" & IdDosaggioAct & " ORDER BY IdDosaggioLOG DESC;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    
        If Not .BOF Then
            .MoveFirst
            GetIdDosaggioLOGScarico = .Fields("IdDosaggioLOG")
        End If
        
        .Close
    
    End With
        
    Exit Function
	Errore:
    rs.Close
    GetIdDosaggioLOGScarico = -1
End Function

'20160503
Public Sub AggiornaImgSemaforo(verde As Boolean, attesa As Boolean, semaforo As Boolean)
    Dim semaforo_img As Integer
    semaforo_img = IIf(Not semaforo, Semaforo_benna_index, Semaforo_sili_index)  '=0 semaforo benna =1 semaforo sili
    If (Not attesa) Then
        CP240.ImgTr(semaforo_img).Picture = LoadResPicture(IIf(verde, "IDB_SEMAFORO_VERDE", "IDB_SEMAFORO_ROSSO"), vbResBitmap)
    Else
        CP240.ImgTr(semaforo_img).Picture = LoadResPicture("IDB_SEMAFORO_GIALLO", vbResBitmap)
    End If
End Sub
'20160503

'20160215
Public Function GetDescrFromIdDosaggioLOG(IdDosaggioAct As Double) As String
    Dim rs As New adodb.Recordset

    On Error GoTo Errore

    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT [IdDosaggioLOG], [IdDosaggio],[Descrizione] FROM DosaggioLOG WHERE IdDosaggioLOG=" & IdDosaggioAct & " ORDER BY IdDosaggioLOG DESC;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    
        If Not .BOF Then
            .MoveFirst
            GetDescrFromIdDosaggioLOG = .Fields("Descrizione")
        End If
        
        .Close
    
    End With
        
    Exit Function
	Errore:
    rs.Close
    GetDescrFromIdDosaggioLOG = LoadXLSString(1523)
End Function

'20160217
Public Function GetIdDosaggioLogFromIdDosaggio(IdDosaggioAct As Double) As Integer
    Dim rs As New adodb.Recordset

    On Error GoTo Errore

    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT [IdDosaggioLOG], [IdDosaggio],[Descrizione] FROM DosaggioLOG WHERE IdDosaggio=" & IdDosaggioAct & " ORDER BY IdDosaggioLOG DESC;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    
        If Not .BOF Then
            .MoveFirst
            GetIdDosaggioLogFromIdDosaggio = .Fields("IdDosaggioLOG")
        End If
        
        .Close
    
    End With
        
    Exit Function
	Errore:
    rs.Close
    
End Function
'
'20161241
Public Sub PosizioneDeodorante()
    Dim maxleft As Integer
    Dim i As Integer
    maxleft = 0
    With CP240
        For i = 1 To MAXNUMSILI
            If (.ImageSilo(i).Visible) Then
                If (.ImageSilo(i).left > maxleft) Then
                    maxleft = .ImageSilo(i).left
                End If
            End If
        Next i
        maxleft = maxleft + (.ImageSilo(1).width / 2) + (.AniPushButtonDeflettore(37) / 2) + 30
        .AniPushButtonDeflettore(37).left = maxleft
    End With
End Sub
'20161214
