Attribute VB_Name = "GestioneAllarmi"

Option Explicit

Public Const MAXNUMALLARMI = 3000
Type CampiAllarmi
  presente As Boolean
  Visto As Byte
End Type
Public IngressoAllarme(0 To MAXNUMALLARMI - 1) As CampiAllarmi

Public AbilitaControlloAllarmi As Integer

Public Sec10BassaScivolo As Boolean
Public Sec10AltaScivolo As Boolean
Public Sec10BassaScivolo2 As Boolean
Public Sec10AltaScivolo2 As Boolean

'   Oltre tempo X fermo anche i predosatori
Public BloccoSpruzzaturaAltaTemp As Boolean
Public OraAltaTemperaturaScivolo As Long
Public TempoPermanenza_AllarmeTemperaturaScivolo As Integer

Public OraErrorePortinaMixer As Long
Public OraErrorePortinaAggregati As Long
Public OraErrorePortinaFiller As Long
Public OraErroreDeflettoreVaglio As Long

Public Type AllarmiDosaggioType
    ValorePLC As Boolean
    TimeOut As Integer
    messaggio As String
    OraErrore As Long
End Type
Public AllarmiDosaggio(20) As AllarmiDosaggioType

Public AllarmeTemporaneoGiaVisualizzato(500) As Boolean

Public BilanciaInertiPortinaAperta As Boolean
Public BilanciaInertiPortinaChiusa As Boolean
Public BilanciaFillerPortinaChiusa As Boolean
Public ComandoScaricoFiller As Boolean
Public ComandoScaricoAggregati As Boolean
Public ComandoScaricoMixer As Boolean
Public ComandoScaricoBitume As Boolean
Public ValoreAltoTroppoPieno As Boolean
Public AllarmeCicalino As Boolean
Public ProgrammaAvviato As Boolean
Public PressioneAriaInsufficente As Boolean

Public CompressoreBruciatorePressioneInsuff As Boolean
Public CompressoreBruciatore2PressioneInsuff As Boolean

Public OraAllarmeTemperaturaBitume As Long
Public OraAllarmeTemperaturaIngressoFiltro As Long
Public OraAllarmeDepressioneFiltro As Long

'
'


Public Sub ControlloAllarmi()
    Dim i As Integer

'IngressoAllarme.Visto(i)=2 --> ho un allarme non ancora accettato dall'operatore
'IngressoAllarme.Visto(i)=1 --> l'operatore ha accettato l'allarme
'IngressoAllarme.Visto(i)=0 --> non ho più l'allarme
    
    On Error GoTo Errore

    For i = 0 To MAXNUMALLARMI - 1
        If IngressoAllarme(i).Visto = 2 Then
            'Al primo allarme non accettato vado in lampeggio
            If CP240.AdoGridAllarmi.BackColor = &HFFFFFF Then
                CP240.AdoGridAllarmi.BackColor = &HFF& ' Rosso
            Else
                CP240.AdoGridAllarmi.BackColor = &HFFFFFF ' Bianco
            End If
            Exit Sub
        End If
    Next i

    CP240.AdoGridAllarmi.BackColor = &HFFFFFF ' Bianco

    Exit Sub
Errore:
    LogInserisci True, "ALL-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ControllaTemperatureAllarmi(ByRef IdDescrizione As Integer, ByRef IndirizzoPLC As String)
Dim valore As Integer
Dim Soglia As Integer
Dim appoggio As Integer
Dim boolTmp As Boolean

    Select Case IndirizzoPLC

        Case "TA148"    'Alta Temp. Ingresso Filtro
            valore = ListaTemperature(TempEntrataFiltro).valore
            Soglia = ValoreTempMaxFiltro
            If SogliaSuperata(valore, Soglia, "A") = 1 Then
                If OraAllarmeTemperaturaIngressoFiltro = 0 Then
                    OraAllarmeTemperaturaIngressoFiltro = ConvertiTimer()
                Else
                    If ConvertiTimer() > OraAllarmeTemperaturaIngressoFiltro + 3 Then
                        IngressoAllarmePresente IdDescrizione, True
                        AltaTemperaturaFiltro = True
                        Call AltaTemperaturaFiltro_change
                    End If
                End If
            Else
                IngressoAllarmePresente IdDescrizione, False
                OraAllarmeTemperaturaIngressoFiltro = 0
                AltaTemperaturaFiltro = False
                Call AltaTemperaturaFiltro_change
            End If
            
        Case "TA134"    'Alta Temp. Scivolo
            valore = ListaTamburi(0).temperaturaScivolo
            Soglia = MaxTempEssicatore
            If (SogliaSuperata(valore, Soglia, "A") = 1) And (ListaTamburi(0).FiammaBruciatorePresente) Then
                If (ConvertiTimer() - ListaTamburi(0).OraStartBruciatore) > 360 Then
                    If Not FrmGestioneTimer.TimerAltaTemperaturaScivolo(0).enabled Then
                        FrmGestioneTimer.TimerAltaTemperaturaScivolo(0).enabled = True
                    End If
                    If Sec10AltaScivolo Then
                        IngressoAllarmePresente IdDescrizione, True
                        Sec10AltaScivolo = False
                    End If
                End If
            Else
                FrmGestioneTimer.TimerAltaTemperaturaScivolo(0).enabled = False
                IngressoAllarmePresente IdDescrizione, False
            End If
        Case "TA136"    'Alta Temp. Scivolo tamburo 2
            valore = ListaTamburi(1).temperaturaScivolo
            Soglia = MaxTempEssicatore2
            If (SogliaSuperata(valore, Soglia, "A") = 1) And (ListaTamburi(1).FiammaBruciatorePresente) Then
                If (ConvertiTimer() - ListaTamburi(1).OraStartBruciatore) > 360 Then
                    If Not FrmGestioneTimer.TimerAltaTemperaturaScivolo(1).enabled Then
                        FrmGestioneTimer.TimerAltaTemperaturaScivolo(1).enabled = True
                    End If
                    If Sec10AltaScivolo2 Then
                        IngressoAllarmePresente IdDescrizione, True
                        Sec10AltaScivolo2 = False
                    End If
                End If
            Else
                FrmGestioneTimer.TimerAltaTemperaturaScivolo(1).enabled = False
                IngressoAllarmePresente IdDescrizione, False
            End If
        Case "TA135"
            IngressoAllarmePresente IdDescrizione, ListaTamburi(1).SicurezzaTemperaturaFumiTamburoOUT
             
        Case "TB156"    'Bassa Temp. Bitume
            If BassaTempBitume(False) Then
                If OraAllarmeTemperaturaBitume = 0 Then
                    OraAllarmeTemperaturaBitume = ConvertiTimer()
                Else
                    If ConvertiTimer() > OraAllarmeTemperaturaBitume + 5 Then
                        IngressoAllarmePresente IdDescrizione, True
                    End If
                End If
            Else
                IngressoAllarmePresente IdDescrizione, False
                OraAllarmeTemperaturaBitume = 0
            End If
            
        Case "TB134"    'Bassa Temp. Scivolo
            valore = ListaTamburi(0).temperaturaScivolo
            Soglia = MinTempEssicatore
            If (SogliaSuperata(valore, Soglia, "B") = 1) And (ListaTamburi(0).FiammaBruciatorePresente) Then
                If (ConvertiTimer() - ListaTamburi(0).OraStartBruciatore) > 360 Then
                    If Not FrmGestioneTimer.TimerBassaTemperaturaScivolo(0).enabled Then
                        FrmGestioneTimer.TimerBassaTemperaturaScivolo(0).enabled = True
                    End If
                    If Sec10BassaScivolo Then
                        IngressoAllarmePresente IdDescrizione, True
                        Sec10BassaScivolo = False
                    End If
                End If
            Else
                FrmGestioneTimer.TimerBassaTemperaturaScivolo(0).enabled = False
                IngressoAllarmePresente IdDescrizione, False
            End If
        Case "TB136"    'Bassa Temp. Scivolo tamburo 2
            valore = ListaTamburi(1).temperaturaScivolo
            Soglia = MinTempEssicatore2
            If (SogliaSuperata(valore, Soglia, "B") = 1) And (ListaTamburi(1).FiammaBruciatorePresente) Then
                If (ConvertiTimer() - ListaTamburi(1).OraStartBruciatore) > 360 Then
                    If Not FrmGestioneTimer.TimerBassaTemperaturaScivolo(1).enabled Then
                        FrmGestioneTimer.TimerBassaTemperaturaScivolo(1).enabled = True
                    End If
                    If Sec10BassaScivolo2 Then
                        IngressoAllarmePresente IdDescrizione, True
                        Sec10BassaScivolo2 = False
                    End If
                End If
            Else
                FrmGestioneTimer.TimerBassaTemperaturaScivolo(1).enabled = False
                IngressoAllarmePresente IdDescrizione, False
            End If
        Case "TB150"    'Bassa Temp. Uscita Filtro
            'Libero
            
        Case "TA154"    'Blocco Spruzz. Bitume per Alta Temp. Materiale Scivolo o Vaglio
            valore = ListaTamburi(0).temperaturaScivolo
            Soglia = MaxTempSpruzzatura
            appoggio = SogliaSuperata(valore, Soglia, "A")
            valore = TemperaturaTorre
            Soglia = MaxTempSpruzzatura
            appoggio = appoggio + SogliaSuperata(valore, Soglia, "A")
            If appoggio > 0 Then
                If OraAltaTemperaturaScivolo = 0 Then
                    OraAltaTemperaturaScivolo = ConvertiTimer()
                End If
                If ConvertiTimer() > OraAltaTemperaturaScivolo + TempoPermanenza_AllarmeTemperaturaScivolo Then
                    boolTmp = True
                    If DosaggioInCorso Then
                        'Arresto con urgenza del dosaggio
                        Call ArrestoEmergenzaDosaggio
                    End If
                End If
            Else
                boolTmp = False
                OraAltaTemperaturaScivolo = 0
            End If

            If (BloccoSpruzzaturaAltaTemp <> boolTmp) Then
                BloccoSpruzzaturaAltaTemp = boolTmp
                BloccoSpruzzaturaAltaTemp_change
            End If
    
    End Select

End Sub

Public Sub BloccoSpruzzaturaAltaTemp_change()

    If (BloccoSpruzzaturaAltaTemp) Then
        If DosaggioInCorso Then
            'Arresto con urgenza del dosaggio
            Call ArrestoEmergenzaDosaggio
        End If
    End If

    Call CP240.AbilitaDosaggioManuale(True)

    Call SetAllarmePresente("TA154", BloccoSpruzzaturaAltaTemp)

    CP240.Image1(25).Visible = BloccoSpruzzaturaAltaTemp

End Sub

Public Function SogliaSuperata(valore As Integer, Soglia As Integer, AoB As String) As Integer
'AoB indica se testo superamento soglia Alta o Bassa
'Restituisce 1 se Valore oltrepassa la Soglia nel verso indicato da AoB
    
    SogliaSuperata = 0
    Select Case AoB
        Case "A"
            If valore > Soglia Then
                SogliaSuperata = 1
            End If
        Case "B"
            If valore < Soglia Then
                SogliaSuperata = 1
            End If
    End Select
    
End Function

'routine probabilmente inutile perchè esistono già gli allarmi nel PLC
Public Sub ControllaPortineAllarmi(ByRef IdDescrizione As Integer, ByRef IndirizzoPLC As String)

    Dim appoggio(8) As Boolean

    'Controllo Deflettore Vaglio
    If _
        (DeflettoreSuVagliato And VaglioIncluso And Not VaglioEscluso) Or _
        (Not DeflettoreSuVagliato And Not VaglioIncluso And VaglioEscluso) _
    Then
        OraErroreDeflettoreVaglio = 0
    Else
        If OraErroreDeflettoreVaglio = 0 Then
            OraErroreDeflettoreVaglio = ConvertiTimer()
        End If
    End If
    If OraErroreDeflettoreVaglio <> 0 Then
        If ConvertiTimer() > OraErroreDeflettoreVaglio + 5 Then
            appoggio(3) = True
        End If
    End If

    'Controllo portina mescolatore
    If ( _
        ComandoScaricoMixer And Not BloccoScaricoMescolatore And MescolatoreAperto And Not MescolatoreChiuso) Or _
        (Not ComandoScaricoMixer And Not MescolatoreAperto And MescolatoreChiuso) _
    Then
        OraErrorePortinaMixer = 0
    Else
        If OraErrorePortinaMixer = 0 Then
            OraErrorePortinaMixer = ConvertiTimer()
        End If
    End If
    If OraErrorePortinaMixer <> 0 Then
        If ConvertiTimer() > OraErrorePortinaMixer + 10 Then
            If MescolatoreAperto And MescolatoreChiuso Or _
                Not MescolatoreAperto And Not MescolatoreChiuso Then
                    appoggio(4) = True    'Mixer chiuso
                    appoggio(2) = True    'Mixer aperto
            End If
            If ComandoScaricoMixer Then
                If Not MescolatoreAperto And MescolatoreChiuso Then
                    appoggio(4) = True    'Mixer chiuso
                End If
            Else
                If MescolatoreAperto And Not MescolatoreChiuso Then
                    appoggio(2) = True    'Mixer aperto
                End If
            End If
            '
        End If
    End If
    
    'Controllo portina aggregati
    If ( _
        (ComandoScaricoAggregati And BilanciaInertiPortinaAperta And Not BilanciaInertiPortinaChiusa) Or _
        (Not ComandoScaricoAggregati And Not BilanciaInertiPortinaAperta And BilanciaInertiPortinaChiusa) _
    ) Then
        OraErrorePortinaAggregati = 0
    Else
        If OraErrorePortinaAggregati = 0 Then
            OraErrorePortinaAggregati = ConvertiTimer()
        End If
    End If
    If OraErrorePortinaAggregati <> 0 Then
        If ConvertiTimer() > OraErrorePortinaAggregati + 10 Then
            appoggio(1) = True
        End If
    End If
    
    'Controllo portina filler
    If ((ComandoPesataFiller(0) Or ComandoPesataFiller(1) Or ComandoPesataFiller(2)) And BilanciaFillerPortinaChiusa) Or _
        (ComandoScaricoFiller And Not BilanciaFillerPortinaChiusa) Or _
        (Not ComandoScaricoFiller And BilanciaFillerPortinaChiusa) Then
            OraErrorePortinaFiller = 0
    Else
        If OraErrorePortinaFiller = 0 Then
            OraErrorePortinaFiller = ConvertiTimer()
        End If
    End If
    If OraErrorePortinaFiller <> 0 Then
        If ConvertiTimer() > OraErrorePortinaFiller + 10 Then
            appoggio(6) = True
        End If
    End If
    
    If (AbilitaTuboTroppoPienoF1 And AbilitaValvolaTroppoPienoF1) Then
        'Controllo scambio filler da recupero in apporto
        If (ScambioFillerRecuperoInApporto And Not ScambioFillerRecuperoInApporto_CH) Or _
            (Not ScambioFillerRecuperoInApporto And ScambioFillerRecuperoInApporto_CH) Then
            OraErroreScambioFillerRecuperoInApporto = 0
        Else
            If OraErroreScambioFillerRecuperoInApporto = 0 Then
                OraErroreScambioFillerRecuperoInApporto = ConvertiTimer()
            End If
        End If
        If OraErroreScambioFillerRecuperoInApporto <> 0 Then
            If ConvertiTimer() > OraErroreScambioFillerRecuperoInApporto + 5 Then
                appoggio(7) = True
            End If
        End If
    End If
 
    If (GestioneScambioTuboTroppoPieno = ScambioF1F2) Then
        'Controllo scambio filler da recupero in apporto
        If (ScambioTuboTroppoPienoF1F2 And RitornoTuboTroppoPienoNonSuF2) Or (Not ScambioTuboTroppoPienoF1F2 And Not RitornoTuboTroppoPienoNonSuF2) Then
            OraErroreScambioTuboTroppoPienoF1F2 = 0
        Else
            If OraErroreScambioTuboTroppoPienoF1F2 = 0 Then
                OraErroreScambioTuboTroppoPienoF1F2 = ConvertiTimer()
            End If
        End If
        If OraErroreScambioTuboTroppoPienoF1F2 <> 0 Then
            If ConvertiTimer() > OraErroreScambioTuboTroppoPienoF1F2 + 5 Then
                appoggio(8) = True
            End If
        End If
    End If
    
    Select Case IndirizzoPLC
        Case "PO001"    'Err. F.C. Scarico Aggregati
            IngressoAllarmePresente IdDescrizione, appoggio(1)
        Case "PO002"    'Portina Filler Chiusa
            IngressoAllarmePresente IdDescrizione, appoggio(6)
        Case "PO003"    'Err. Deflettore Vaglio
            'IngressoAllarmePresente IdDescrizione, Appoggio(3)
        Case "PO004"    'Manca Consenso Scarico Mixer
            IngressoAllarmePresente IdDescrizione, appoggio(5)
        Case "PO005"    'Scarico Mixer Aperto
            IngressoAllarmePresente IdDescrizione, appoggio(2)
        Case "PO006"    'Scarico Mixer Chiuso
            IngressoAllarmePresente IdDescrizione, appoggio(4)
        Case "PO007"    'Errore scambio filler recupero in apporto
            IngressoAllarmePresente IdDescrizione, appoggio(7)
        Case "PO008"    'Errore scambio tubo troppo pieno F1 F2
            IngressoAllarmePresente IdDescrizione, appoggio(8)
'M-P15017
        Case "PO010"
            IngressoAllarmePresente IdDescrizione, (CP240.OPCData.items(PLCTAG_NM_CountDown_NV).Value > 0)
        Case "PO011"
            '20170331
            'IngressoAllarmePresente IdDescrizione, (CP240.OPCData.items(PLCTAG_NM_CountDown_Rifiuti).Value > 0)
            IngressoAllarmePresente IdDescrizione, (ValoreAltoTroppoPieno And CP240.OPCData.items(PLCTAG_NM_CountDown_Rifiuti).Value > 0)
            '
'
    End Select

End Sub

Public Sub GestioneSicurezzeBilance(ByRef IdDescrizione As Integer, ByRef IndirizzoPLC As String)

    If (DEMO_VERSION) Then
        Exit Sub
    End If

    Select Case IndirizzoPLC

        Case "DB003"    'Sicurezza Aggregati
            If Not DEMO_VERSION And (CP240.OPCData.items(PLCTAG_All_Aggregati_Sicurezza).Value) Then
                CP240.Frame1(12).Visible = Not CP240.Frame1(12).Visible
            Else
                CP240.Frame1(12).Visible = False
            End If

        Case "DB023"    'Sicurezza Filler
            If Not DEMO_VERSION And (CP240.OPCData.items(PLCTAG_All_Filler_Sicurezza).Value) Then
                CP240.Frame1(11).Visible = Not CP240.Frame1(11).Visible
            Else
                CP240.Frame1(11).Visible = False
            End If

        Case "DB043"    'Sicurezza Bitume
            If (Not BitumeGravita) Then
                If Not DEMO_VERSION And (CP240.OPCData.items(PLCTAG_All_Bitume_Sicurezza).Value) Then
                    CP240.Frame1(13).Visible = Not CP240.Frame1(13).Visible
                Else
                    CP240.Frame1(13).Visible = False
                End If
            End If
            
        Case "DB193"    'Sicurezza Bitume Gravità
            If (BitumeGravita) Then
                If Not DEMO_VERSION And (CP240.OPCData.items(PLCTAG_All_BitumeGR_Sicurezza).Value) Then
                    CP240.Frame1(13).Visible = Not CP240.Frame1(13).Visible
                Else
                    CP240.Frame1(13).Visible = False
                End If
            End If

        Case "DB133"    'Sicurezza Viatop
            If Not DEMO_VERSION And (InclusioneViatop And (CP240.OPCData.items(PLCTAG_All_Viatop_Sicurezza).Value)) Then
                CP240.Frame1(14).Visible = Not CP240.Frame1(14).Visible
            Else
                CP240.Frame1(14).Visible = False
            End If

        Case "DB153"    'Sicurezza Bilancia RAP
            If AbilitaRAP And (CP240.OPCData.items(PLCTAG_All_RAP_Sicurezza).Value) Then
                CP240.Frame1(54).Visible = Not CP240.Frame1(54).Visible
            Else
                CP240.Frame1(54).Visible = False
            End If

        Case "DB203"    'Sicurezza Contalitri (tempo troppo lungo di spruzzatura)
            If InclusioneAddContalitri And (CP240.OPCData.items(PLCTAG_All_Contalitri_Sicurezza).Value) Then
                CP240.Frame1(29).Visible = Not CP240.Frame1(29).Visible
            Else
                CP240.Frame1(29).Visible = False
            End If

       Case "DB160"
            If Not DEMO_VERSION And ((CP240.OPCData.items(PLCTAG_DI_SicurezzaTamponeRiciclatoCaldo).Value) Or _
                BilanciaTamponeRiciclato.Peso > BilanciaTamponeRiciclato.Sicurezza) Then
                IngressoAllarmePresente IdDescrizione, True
                CP240.Frame1(44).Visible = Not CP240.Frame1(44).Visible
            Else
                CP240.Frame1(44).Visible = False
                IngressoAllarmePresente IdDescrizione, False
            End If
            
    End Select

End Sub

Public Sub AzzeraAllarmiSospesi()
    Dim rs As New adodb.Recordset
    
    With rs
        Set .ActiveConnection = DBcon
        .Source = "Select * From StoricoAllarmi Where DataOraFine Is Null OR DataOraVisto Is Null;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With
    
    Do While Not rs.EOF
        If IsNull(rs!DataOraFine) Then
            rs!DataOraFine = Now
        End If
        If IsNull(rs!DataOraVisto) Then
            rs!DataOraVisto = Now
        End If
        rs.Update
        rs.MoveNext
    Loop
    
End Sub

Public Sub AllarmeTemporaneoFull(codiceNumerico As Integer, Codice As String, presente As Boolean, controlla As Boolean)

    If (presente) Then

        If (Not controlla Or (controlla And Not AllarmeTemporaneoGiaVisualizzato(codiceNumerico))) Then
            Call SetAllarmePresente(Codice, presente)
        End If
        AllarmeTemporaneoGiaVisualizzato(codiceNumerico) = True

    Else

        If (Not controlla Or (controlla And AllarmeTemporaneoGiaVisualizzato(codiceNumerico))) Then
            Call SetAllarmePresente(Codice, presente)
        End If
        AllarmeTemporaneoGiaVisualizzato(codiceNumerico) = False

    End If

End Sub

Public Sub AllarmeTemporaneo(Codice As String, presente As Boolean)

    Dim codiceNumerico As Integer

    codiceNumerico = CInt(Right(Codice, 3))

    If (presente) Then
        AllarmeTemporaneoGiaVisualizzato(codiceNumerico) = True
    End If

    Call SetAllarmePresente(Codice, presente)

End Sub

Public Sub ControllaIngressiAllarmi()
    Dim i As Integer
    Dim allarmePresente As Boolean
    Dim rs As New adodb.Recordset

    On Error GoTo Errore

    With rs
        Set .ActiveConnection = DBcon
        .Source = "SELECT * From CodificaAllarmi Order By IdDescrizione;"
        .LockType = adLockOptimistic
        .CursorLocation = adUseClient
        .CursorType = adOpenStatic
        .Open , DBcon
    End With

    Do While Not rs.EOF
        i = rs!IdDescrizione
        If Not IsNull(rs!IndirizzoPLC) Then
            If (UCase(left(rs!IndirizzoPLC, 2)) = "SI") Then
                Select Case rs!IndirizzoPLC
                    Case "SI000" 'SCATTO TERMICA VIBRATORI PREDOSATORI
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermVibratoriPred).Value
                    Case "SI001" 'SCATTO TERMICA ADDITIVO MESCOLATORE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermPompaAddMixer).Value
                    Case "SI002" 'SCATTO TERMICA ADDITIVO BACINELLA LEGANTE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermPompaAddLegante).Value
                    Case "SI003" 'SCATTO TERMICA POMPA SPRUZZATURA LEGANTE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermPompaSpruzzLegante).Value
                        'ERA L'UNICO CODIFICATO CON SB QUINDI è STATO PORTATO QUI
                    Case "SI004" 'Livello alto Silo Filler DMR
                        
                        allarmePresente = False '20150729
                                                                                                                                                                                                                       
                        If InclusioneDMR And LivelloMaxCameraEspansioneFillerRecupero Then
                            allarmePresente = True
                            CP240.Frame1(31).Visible = Not CP240.Frame1(31).Visible
                        Else
                            CP240.Frame1(31).Visible = False
                        End If
'20151228
                        If InclusioneDMR And LivelloMax3CameraEspansioneFillerRecupero And Inclusione3LivDMR Then
                            allarmePresente = True
                            CP240.Frame1(64).Visible = Not CP240.Frame1(64).Visible
                        Else
                            CP240.Frame1(64).Visible = False
                        End If
'
                        If InclusioneDMR And LivelloMax2CameraEspansioneFillerRecupero Then
                            allarmePresente = True
                            CP240.Frame1(32).Visible = Not CP240.Frame1(32).Visible
                        Else
                            CP240.Frame1(32).Visible = False
                        End If

                        If (TmrArrestoLivelliAltiTSF > 0) Then
                            If (TmrArrestoLivelliAltiTSF + TimeoutArrestoLivelliTSF < ConvertiTimer()) Then
                                If (PredosaggioArrestoLivelliTSF) Then
                                    Call ErroreLivelloAltoFiller
                                End If
                                TmrArrestoLivelliAltiTSF = 0
                            End If
                        End If
                        
                    Case "SI005" 'SICUREZZA GALLEGGIANTE B2
                        allarmePresente = ( _
                            InclusioneBitume2 And AbilitaSicurezzaGalleggianteB2 And _
                            CP240.OPCData.items(PLCTAG_DI_SicurezzaGalleggianteB2).Value _
                            )
                    Case "SI006" 'SICUREZZA GALLEGGIANTE B3
                        allarmePresente = ( _
                            InclusioneBitume3 And AbilitaSicurezzaGalleggianteB3 And _
                            CP240.OPCData.items(PLCTAG_DI_SicurezzaGalleggianteB3).Value _
                            )
                    Case "SI007" 'SCATTO TERMICA COMUNE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermicaComune).Value
                    Case "SI008" 'LIVELLO ALTO TROPPO PIENO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TorLivMaxNP).Value
                    Case "SI009" 'ALLARME INVERTER TAMBURO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermInverterTamburo).Value
                    Case "SI011" 'SCATTO TERMICA COCLEA DOSAGGIO FILLER APPORTO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermCocleaPesataF2).Value
                    Case "SI012" 'SCATTO TERMICA COCLEA DOSAGGIO FILLER RECUPERO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermCocleaPesataF1).Value
                    Case "SI013" 'SCATTO TERMICA VIBRATORE PULIZIA FILTRO SILO FILLER APP.
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_SiloFilVibrTerm02).Value
                    Case "SI014" 'SCATTO TERMICA VENTOLA PULIZIA PIROMETRO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermVentPulizPirom).Value
                    Case "SI015" 'SCATTO TERMICA COCLEA INTRODUZIONE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermIntroFillerMix).Value
                    Case "SI016" 'SCATTO TERMICA VIBRATORE SCARICO FILLER
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermVibrScarBilFil).Value
                    Case "SI017" 'SICUREZZA TEMPERATURA INGRESSO FILTRO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_FiltSictempITT).Value
                    Case "SI018" 'SICUREZZA TEMPERATURA OLIO COMBUSTIBILE
                        'Bruciatore Diesel
                        allarmePresente = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And CP240.OPCData.items(PLCTAG_DI_BrucSicTempcomb).Value)
                    Case "SI019" 'BASSA TEMPERATURA OLIO COMBUSTIBILE
                        'Bruciatore Diesel
                        allarmePresente = (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas And Not CP240.OPCData.items(PLCTAG_DI_BrucTempCombOK).Value)
                    Case "SI020" 'Fine corsa valvola 3-vie per carico spruzzatrice bitume
                        allarmePresente = (AbilitaValv3VieSpruzzatriceBitume And CP240.OPCData.items(PLCTAG_DI_Valv3VieSpruzzatriceVersoTorre).Value)
                    Case "SI021" 'Libero
                        '??
                        allarmePresente = False
                    Case "SI022" 'SCATTO TERMICA VENTOLA CENTRALINA IDRAULICA
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermVentCentrIdr).Value
                    Case "SI023" 'SCATTO TERMICA ARGANO BINARIO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_BinarioTermica).Value
                    Case "SI024" 'SCATTO TERMICA BENNA TRASLATA
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermBennaTraslata).Value
                    Case "SI025" 'SCATTO TERMICA MODULATORE BRUCIATORE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_BrucTermModulatore).Value
                    Case "SI026" 'SCATTO TERMICA MODULATORE FILTRO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_FiltTermModulatore).Value
                    Case "SI027" 'SCATTO TERMICA PREDOSATORI O GUASTO APPARECCHIATURA
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_PredosatoriTermica).Value
                    Case "SI028" 'SCATTO TERMICA LINEA RIFRANTUMAZIONE RICICLATO
                        '??
                        allarmePresente = False
                    Case "SI029" 'SCATTO TERMICA COCLEA DOSAGGIO VIATOP
                        allarmePresente = (InclusioneViatop And CP240.OPCData.items(PLCTAG_DI_TermMotTrasport).Value)
                    Case "SI030" 'SCATTO TERMICA VIBRATORE VIATOP
                        allarmePresente = (InclusioneViatop And CP240.OPCData.items(PLCTAG_DI_Term_Vibr_Viatop).Value)
                    Case "SI031" 'BLOCCO BRUCIATORE
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_BrucBlocco).Value
                    Case "SI032" 'ALLARME INVERTER ASPIRAZIONE FILTRO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermInverterFiltro).Value
                    Case "SI033" 'ALLARME PRESSIONE GAS
                        allarmePresente = (ListaTamburi(0).SelezioneCombustibile = CombustibileGas And Not CP240.OPCData.items(PLCTAG_DI_BrucPressGasOK).Value)
                    Case "SI034" 'BLOCCO LDU
                        allarmePresente = (ListaTamburi(0).SelezioneCombustibile = CombustibileGas And CP240.OPCData.items(PLCTAG_DI_BrucBloccoLDU).Value)
                    Case "SI035" 'libero
                        '
                    Case "SI036" 'PRESSIONE COMBUSTIBILE INSUFFICIENTE
                        allarmePresente = False
                        If (ListaMotori(MotorePompaCombustibile).ritorno And ListaTamburi(0).SelezioneCombustibile <> CombustibileGas) Then
                            If (CP240.OPCData.items(PLCTAG_DI_BrucPressCombBass).Value) Then
                                If (ConvertiTimer() > ListaTamburi(0).OraStartPompaCombustibile + 10) Then
                                    allarmePresente = True
                                End If
                            End If
                        End If

                    Case "SI037" 'SCATTO TERMICA MODULATORE ARIA FREDDA
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_FiltTermModAriaFr).Value
                    Case "SI045" 'Scatto termica coclea dosaggio filler 3
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermCocleaPesataF3).Value
                    Case "SI046" 'SCATTO TERMICA VIBRATORI/SOFFI ARIA PREDOSATORI RICICLATO
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermVibratoriPRic).Value
                    Case "SI047" 'SCATTO TERMICA GRIGLIE VIBRANTI
                        allarmePresente = False
                        If (NumeroPredosatoriRicInseriti > 0) Then
                            Dim spread As Integer
                            spread = PLCTAG_DI_TermGrigliaVibrante_Ric2 - PLCTAG_DI_TermGrigliaVibrante_Ric1
                            For i = 0 To NumeroPredosatoriRicInseriti - 1
                                If (Not allarmePresente And ListaPredosatoriRic(i).GrigliaVibrantePresente) Then
                                    allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermGrigliaVibrante_Ric1 + (i * spread)).Value
                                End If
                            Next i
                        End If
                    Case "SI050" 'SCATTO TERMICA ARMADIO PREDOSATORI
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOPREDOSATORI).Value
                    Case "SI051" 'SICUREZZA ARMADIO PREDOSATORI
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOPREDOSATORI).Value
                    Case "SI052" 'SCATTO TERMICA ARMADIO BRUCIATORE
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOBRUCIATORE).Value
                    Case "SI053" 'SICUREZZA ARMADIO BRUCIATORE
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOBRUCIATORE).Value
                    Case "SI054" 'SCATTO TERMICA ARMADIO TAMBURO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOTAMBURO).Value
                    Case "SI055" 'SICUREZZA ARMADIO TAMBURO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOTAMBURO).Value
                    Case "SI056" 'SCATTO TERMICA ARMADIO FILTRO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOFILTRO).Value
                    Case "SI057" 'SICUREZZA ARMADIO FILTRO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOFILTRO).Value
                    Case "SI058" 'SCATTO TERMICA ARMADIO VAGLIO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOVAGLIO).Value
                    Case "SI059" 'SICUREZZA ARMADIO VAGLIO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOVAGLIO).Value
                    Case "SI060" 'SCATTO TERMICA ARMADIO DOSAGGIO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIODOSAGGIO).Value
                    Case "SI061" 'SICUREZZA ARMADIO DOSAGGIO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIODOSAGGIO).Value
                    Case "SI062" 'SCATTO TERMICA ARMADIO SILO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOSILO).Value
                    Case "SI063" 'SICUREZZA ARMADIO SILO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOSILO).Value
                    Case "SI064" 'SCATTO TERMICA ARMADIO VIATOP
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOVIATOP).Value
                    Case "SI065" 'SICUREZZA ARMADIO VIATOP
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOVIATOP).Value
                    Case "SI066" 'SCATTO TERMICA ARMADIO RICICLATO FREDDO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIORICFREDDO).Value
                    Case "SI067" 'SICUREZZA ARMADIO RICICLATO FREDDO
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIORICFREDDO).Value
                    Case "SI068" 'SCATTO TERMICA ARMADIO LEGANTE
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_TERM_ARMADIOLEGANTE).Value
                    Case "SI069" 'SICUREZZA ARMADIO LEGANTE
                        allarmePresente = CP240.OPCData.items(PLCTAG_BS_ALL_SICU_ARMADIOLEGANTE).Value

                    Case "SI070"    'Slittamento elevatore caldo
'20150422
'                        allarmePresente = ListaMotori(MotoreElevatoreCaldo).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore08_Slittamento_PrimaSoglia).Value  '20150302
                        allarmePresente = FuncAllarmeSlittamentoMotore(ListaMotori(MotoreElevatoreCaldo).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore08_Slittamento_PrimaSoglia).Value, _
                            ListaMotori(MotoreElevatoreCaldo).ritorno, _
                            ListaMotori(MotoreElevatoreCaldo).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreElevatoreCaldo).tempoRitAllSlittamento)
'
                    Case "SI073"    'Pressione aria insufficente compressore bruciatore 2
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_CompressoreBruciatore2_PressioneInsufficiente).Value And ListaTamburi(1).SelezioneCombustibile <> CombustibileGas And ParallelDrum
                    Case "SI074"    'Blocco bruciatore 2
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_Bruciatore2Blocco).Value And ParallelDrum
                    Case "SI075"    'Blocco LDU 2
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_BloccoLdu2).Value And ListaTamburi(1).SelezioneCombustibile = CombustibileGas And ParallelDrum
                    Case "SI076"    'Allarme pressione gas 2 (0 = allarme)
                        allarmePresente = Not CP240.OPCData.items(PLCTAG_DI_PressioneGasOK2).Value And ListaTamburi(1).SelezioneCombustibile = CombustibileGas And ParallelDrum
                    Case "SI077"    'Sicurezza temperatura combustibile 2
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_OlioCombustibile2_SicurezzaTemp).Value And ParallelDrum
                   Case "SI078"    'Pressione insufficente combustibile 2
                        allarmePresente = False
                        If (ListaMotori(MotorePompaCombustibile2).ritorno And ListaTamburi(1).SelezioneCombustibile <> CombustibileGas And ParallelDrum) Then
                            If (CP240.OPCData.items(PLCTAG_DI_OlioCombustibile2_PressioneInsufficiente).Value) Then
                                If (ConvertiTimer() > ListaTamburi(1).OraStartPompaCombustibile + 10) Then
                                    allarmePresente = True
                                End If
                            End If
                        End If
                        '
                    Case "SI079"    'Allarme tenuta valvole olio combustibile 2
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_OlioCombustibile2_AllarmeTenutaValvole).Value And ParallelDrum
                    Case "SI080"
'20150422
'                        allarmePresente = ListaMotori(MotoreElevatoreRiciclato).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore28_Slittamento_PrimaSoglia).Value  '20150302
                        '20170208
                        'allarmePresente = ListaMotori(MotoreElevatoreRiciclato).AllarmeSlittamentoMotore Or FuncAllarmeSlittamentoMotore(CP240.OPCData.items(PLCTAG_Motore28_Slittamento_PrimaSoglia).Value, _
                        '    ListaMotori(MotoreElevatoreRiciclato).ritorno, _
                        '    ListaMotori(MotoreElevatoreRiciclato).OraStartAllSlittamentoMotore, _
                        '    ListaMotori(MotoreElevatoreRiciclato).tempoRitAllSlittamento)
                        allarmePresente = FuncAllarmeSlittamentoMotore( _
                            ListaMotori(MotoreElevatoreRiciclato).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore28_Slittamento_PrimaSoglia).Value, _
                            ListaMotori(MotoreElevatoreRiciclato).ritorno, _
                            ListaMotori(MotoreElevatoreRiciclato).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreElevatoreRiciclato).tempoRitAllSlittamento)
                        '
'
'20161129
                    Case "SI094"
                        Dim alarmslit As Boolean  '20161205
                        alarmslit = ListaMotori(MotoreNastroCollettore1).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore21_Slittamento_PrimaSoglia).Value  '20161205
                        allarmePresente = FuncAllarmeSlittamentoMotore(alarmslit, _
                            ListaMotori(MotoreNastroCollettore1).ritorno, _
                            ListaMotori(MotoreNastroCollettore1).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreNastroCollettore1).tempoRitAllSlittamento)
                     Case "SI095"
                        alarmslit = ListaMotori(MotoreNastroCollettoreRiciclato).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore25_Slittamento_PrimaSoglia).Value  '20161205
                        allarmePresente = FuncAllarmeSlittamentoMotore(alarmslit, _
                            ListaMotori(MotoreNastroCollettoreRiciclato).ritorno, _
                            ListaMotori(MotoreNastroCollettoreRiciclato).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreNastroCollettoreRiciclato).tempoRitAllSlittamento)
                     Case "SI096"
                        alarmslit = ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore29_Slittamento_PrimaSoglia).Value  '20161205
                        allarmePresente = FuncAllarmeSlittamentoMotore(alarmslit, _
                            ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno, _
                            ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).tempoRitAllSlittamento)
                     Case "SI097"
                        alarmslit = ListaMotori(MotoreNastroRapJolly).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore38_Slittamento_PrimaSoglia).Value  '20161205
                        allarmePresente = FuncAllarmeSlittamentoMotore(alarmslit, _
                            ListaMotori(MotoreNastroRapJolly).ritorno, _
                            ListaMotori(MotoreNastroRapJolly).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreNastroRapJolly).tempoRitAllSlittamento)
                      Case "SI098"
                        alarmslit = ListaMotori(MotoreNastroBypassEssicatore).AllarmeSlittamentoMotore Or CP240.OPCData.items(PLCTAG_Motore44_Slittamento_PrimaSoglia).Value  '20161205
                        allarmePresente = FuncAllarmeSlittamentoMotore(alarmslit, _
                            ListaMotori(MotoreNastroBypassEssicatore).ritorno, _
                            ListaMotori(MotoreNastroBypassEssicatore).OraStartAllSlittamentoMotore, _
                            ListaMotori(MotoreNastroBypassEssicatore).tempoRitAllSlittamento)
 '20161129
                    '20150818
                    Case "SI081"
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TorTermFrenoVaglio).Value
                    '
                    Case "SI086"    'Bassa temperatura combustibile tamburo 2
                        allarmePresente = Not CP240.OPCData.items(PLCTAG_DI_OlioCombustibile2_TemperaturaOK).Value And ListaTamburi(1).SelezioneCombustibile <> CombustibileGas And ParallelDrum
                    Case "SI087"    'Aria insufficiente compressore bruciatore
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_PressInsufComprBruc).Value And ListaTamburi(1).SelezioneCombustibile <> CombustibileGas And ParallelDrum
                    Case "SI088"    'Allarme perdita valvole olio combustibile
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_AllTenutaValvoleOC).Value And ListaTamburi(1).SelezioneCombustibile <> CombustibileGas And ParallelDrum
                    Case "SI089"    'Allarme perdita scatto termica modulatore bruciatore 2
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_BrucModRicTerm).Value And ParallelDrum
                    Case "SI090"
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_Term_Modul_Aspiraz_Bruc1).Value And ParallelDrum
                    Case "SI091"
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_Term_Modul_Aspiraz_Bruc2).Value And ParallelDrum
                    Case "SI092"
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_TermicaModulatoreBruc2).Value And ParallelDrum
                    Case "SI093"
'20150422
'                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_AltaPressione_PompaCombustibile).Value 'And ListaMotori(18).ritorno
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_AltaPressione_PompaCombustibile).Value And (ListaTamburi(0).SelezioneCombustibile <> CombustibileGas) And ListaMotori(MotorePompaCombustibile).ritorno
'
                    '20170110
                    Case "SI099"
                        allarmePresente = CP240.OPCData.items(PLCTAG_Darw_ScaRicFInMixer_Term).Value
                    '20170110
                End Select

                'Call IngressoAllarmePresente(i, allarmePresente)
                Select Case rs!IndirizzoPLC
                    Case "SI038", "SI039", "SI040", "SI041", "SI042", "SI043", "SI044", "SI010", "SI071", "SI072", "SI048"
                        'Non deve fare nulla qui
                    Case Else
                        Call IngressoAllarmePresente(i, allarmePresente)
                End Select

            ElseIf (UCase(left(rs!IndirizzoPLC, 2)) = "ST") Then
                '20150306
                Select Case rs!IndirizzoPLC
'20151222
'                    Case "ST056"
                    Case "ST101"
'                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_Term_Coclea_Evac).Value 'Termica Coclea Evacuazione Darwin
                        '20160321
                        allarmePresente = CP240.OPCData.items(PLCTAG_DI_Term_Coclea_Evac).Value 'Termica Coclea Evacuazione Darwin
                        '
                        Call IngressoAllarmePresente(i, allarmePresente)
'20151222
'                    Case "ST057"
                    Case "ST102"
                        allarmePresente = CP240.OPCData.items(PLCTAG_Termica_Alim_FCD).Value 'Termica Alimentazione Predosatori
                        Call IngressoAllarmePresente(i, allarmePresente)

                    '20160419
                    Case "ST103"
                        'Termica vibratori/soffi aria estrazione filler[s]
                        allarmePresente = CP240.OPCData.items(PLCTAG_TermicaVibrSoffioEstrazF).Value
                        Call IngressoAllarmePresente(i, allarmePresente)
                    '
'20160505
                    Case "ST104"
                        allarmePresente = CP240.OPCData.items(PLCTAG_Ter_Coclea_Da_EF_A_PesF1).Value 'M-P15029 COCLEA DA ELEV. FILLER A DOSAGGIO FILLER 1
                        Call IngressoAllarmePresente(i, allarmePresente)
                    Case "ST105"
                        allarmePresente = CP240.OPCData.items(PLCTAG_Ter_Coclea_Da_EF_A_PesF2).Value 'M-P15029 COCLEA DA ELEV. FILLER A DOSAGGIO FILLER 2
                        Call IngressoAllarmePresente(i, allarmePresente)
'
                    '20161213
                    Case "ST106"
                        allarmePresente = CP240.OPCData.items(PLCTAG_IN_DUSTFIX_TERM).Value
                        Call IngressoAllarmePresente(i, allarmePresente)
                    '
                End Select
                
                'fine
                ' Niente da fare qui -> gestione a evento
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "AM" Then
                  Dim Index As Integer
                  For Index = 1 To MAXMOTORI
                    If (Index < 10) Then
                        If (UCase(left(rs!IndirizzoPLC, 5)) = ("AM00" + CStr(Index))) Then
                            allarmePresente = ListaMotori(Index).AllarmeTimeoutArresto Or ListaMotori(Index).AllarmeTimeoutAvvio Or ListaMotori(Index).AllarmeNessunRitorno
                        End If
                    Else
                        If (UCase(left(rs!IndirizzoPLC, 5)) = ("AM0" + CStr(Index))) Then
                            allarmePresente = ListaMotori(Index).AllarmeTimeoutArresto Or ListaMotori(Index).AllarmeTimeoutAvvio Or ListaMotori(Index).AllarmeNessunRitorno
                        End If
                    End If
                  Next Index
                  Call IngressoAllarmePresente(i, allarmePresente)
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "TA" Or UCase(left(rs!IndirizzoPLC, 2)) = "TB" Then
                Call ControllaTemperatureAllarmi(i, rs!IndirizzoPLC)
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "PO" Then
                Call ControllaPortineAllarmi(i, rs!IndirizzoPLC)
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "CI" Or UCase(left(rs!IndirizzoPLC, 2)) = "PC" Then
                Call ControllaCisterneAllarmi(i, rs!IndirizzoPLC)
                Call ControllaCisterneAllarmiRidotto(i, rs!IndirizzoPLC) '20151028
'20160216
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "GA" Then
                allarmePresente = False
                Select Case rs!IndirizzoPLC
                    Case "GA001" To "GA016"
                        allarmePresente = CP240.OPCData.items(PLCTAG_SILI_HMI_Allarme1 + CInt(Mid(rs!IndirizzoPLC, 4, 2)) - 1).Value
                    Case Else
                        allarmePresente = False
                End Select
                Call IngressoAllarmePresente(i, allarmePresente)
'
            ElseIf UCase(left(rs!IndirizzoPLC, 1)) = "G" Then
                'GestioneSilo(S7)
                Call SiloS7GestioneAllarmi(i, rs!IndirizzoPLC)
            ElseIf (UCase(left(rs!IndirizzoPLC, 2)) = "DB") Or (UCase(left(rs!IndirizzoPLC, 2)) = "SB") Then
                Call DB61_GestioneAllarmi(i, rs!IndirizzoPLC)
                Call GestioneSicurezzeBilance(i, rs!IndirizzoPLC)
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "WF" Then
                'SCHIUMATO
                Call PlcSchiumatoAllarme(i, CLng(Right(rs!IndirizzoPLC, 3)))
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "BM" Then
                'CALDAIE
                Call ControllaCaldaieAllarmi(i, rs!IndirizzoPLC)
            ElseIf UCase(left(rs!IndirizzoPLC, 5)) = "AC010" Then
                'caso Filler 2 RompiSacchi: l'allarme è gestito nel PLC
                allarmePresente = CP240.OPCData.items(PLCTAG_ALARM_Filler2_RompiSacchi).Value
                Call IngressoAllarmePresente(i, allarmePresente)
'20160729
            ElseIf UCase(left(rs!IndirizzoPLC, 2)) = "AQ" And InclusioneAquablack Then
                'AQUABLACK
                Call ControllaAquablackAllarmi(i, rs!IndirizzoPLC)
'
            End If

        End If
        rs.MoveNext
    Loop

    Exit Sub
Errore:
    LogInserisci True, "ALL-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub IngressoAllarme_change(indice As Integer)

Dim rs As New adodb.Recordset

    If IngressoAllarme(indice).presente Then

        'Ho un allarme che prima non avevo: metto nel DB la data-ora di inizio
        'devo fare suonare il cicalino e lampeggiare una campanella vicino alla DBGrid
        'Aggiungo nella DBGrid la riga dell'allarme
        With rs
            Set .ActiveConnection = DBcon
            .Source = "SELECT TOP 10 * From Vista_AllarmiAttivi;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With
        rs.AddNew
        rs!DataOraInizio = Now
        rs!IdDescrizione = indice
        rs.Update
        AllarmeCicalino = True
        IngressoAllarme(indice).Visto = 2

    Else

        'E' appena sparito l'allarme: metto nel DB la data-ora di fine allarme
        'Tolgo dalla DBGrid la riga dell'allarme
        With rs
            Set .ActiveConnection = DBcon
            '.Source = "SELECT * From Vista_AllarmiAttivi Where IdDescrizione = " & indice & " Order By VISTO, DataOraInizio DESC;"
            .Source = "SELECT TOP 50 * From StoricoAllarmi Where IdDescrizione = " & indice & " And DataOraFine IS NULL Order By DataOraInizio DESC;"
            .LockType = adLockOptimistic
            .CursorLocation = adUseClient
            .CursorType = adOpenStatic
            .Open , DBcon
        End With
        'Allarmi unificati
        'Gli avvisi temporanei li elimino fisicamente dal DB quando li accetto dal pulsante in CP240
        'Devo solo aggiornare l'array degli allarmi per far smettere di lampeggiare il DBGrig
        If Not rs.EOF Then
            rs!DataOraFine = Now
            rs.Update
        End If
        IngressoAllarme(indice).Visto = 0
    End If

    CP240.AdoAllarmi.Refresh
    CP240.AdoGridAllarmi.Refresh

End Sub

Public Sub IngressoAllarmePresente(indice As Integer, valore As Boolean)
    If (indice < 0) Then
        Exit Sub
    End If
        
    If (IngressoAllarme(indice).presente <> valore) Then
        IngressoAllarme(indice).presente = valore
        IngressoAllarme_change indice
    End If

End Sub

Public Sub SetAllarmePresente(Codice As String, presente As Boolean)

    On Error GoTo Errore

    Call IngressoAllarmePresente(DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Codice, "IdDescrizione"), presente)

    Exit Sub
Errore:
    LogInserisci True, "ALL-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub DB61_GestioneAllarmi(ByRef IdDescrizione As Integer, ByRef IndirizzoPLC As String)
Dim allarmePresente As Boolean

'20160613

    Dim i As Integer
    If (PresenzaRompiSacchiF2) Then
        For i = 0 To 7
            Select Case IndirizzoPLC
                Case "DB" & Format(i + 400, "0")
                    Call IngressoAllarmePresente(IdDescrizione, (CP240.OPCData.items(PLCTAG_VALV_F2_Rompisacchi_Codice_Allarme).Value And 2 ^ (i + 8)) <> 0)
            End Select
        Next i
    End If

'

    Select Case IndirizzoPLC
        Case "DB000"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_PortinaAperta).Value
        Case "DB001"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_PortinaChiusa).Value
        Case "DB002"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_NonTara).Value
        Case "DB003"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_Sicurezza).Value
        Case "DB004"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_FuoriTolleranza).Value
        Case "DB005"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_PerditaPeso).Value
        Case "DB006"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Aggregati_FineCorsaGenerico).Value
        Case "DB020"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_PortinaAperta).Value
        Case "DB021"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_PortinaChiusa).Value
        Case "DB022"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_NonTara).Value
        Case "DB023"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_Sicurezza).Value
        Case "DB024"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_FuoriTolleranza).Value
        Case "DB025"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_PerditaPeso).Value
        Case "DB026"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Filler_FineCorsaGenerico).Value
        Case "DB040"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_ValvolaAperta).Value
        Case "DB041"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_ValvolaChiusa).Value
        Case "DB042"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_NonTara).Value
        Case "DB043"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_Sicurezza).Value
        Case "DB044"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_FuoriTolleranza).Value
        Case "DB045"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_PerditaPeso).Value
        Case "DB046"
            'allarmePresente = CP240.OPCData.Items(PLCTAG_All_Bitume_PompaCircolazioneFerma).value
            allarmePresente = AllarmePompeCircolazioneLegante 'Gestione completa di tutte le pompe
        Case "DB047"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Bitume_FineCorsaGenerico).Value
        Case "DB060"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Mixer_PortinaApertura).Value
        Case "DB061"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Mixer_PortinaChiusa).Value
        Case "DB062"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Mixer_MotoreFermo).Value
        Case "DB063"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Mixer_FineCorsaGenerico).Value
        Case "DB080"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_InserireNumeroRicetta).Value
        Case "DB081"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_PressioneAria).Value
        Case "DB090"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoMixer_PompaAccesa).Value
        Case "DB091"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoMixer_PompaNoRitorno).Value
        Case "DB092"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoMixer_PompaTimeOutAvvio).Value
        Case "DB093"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoMixer_PompaTimeOutArresto).Value
        Case "DB100"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoBacinella_PompaAccesa).Value
        Case "DB101"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoBacinella_PompaNoRitorno).Value
        Case "DB102"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoBacinella_PompaTimeOutAvvio).Value
        Case "DB103"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoBacinella_PompaTimeOutArresto).Value
        Case "DB110"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RicettaNonCoerente).Value
        Case "DB111"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RicettaOrdinePortine).Value
        Case "DB120"
            If CP240.adoComboDosaggio.text <> "" Then
                allarmePresente = CP240.OPCData.items(PLCTAG_All_DeflettoreVaglio).Value
            End If
        Case "DB121"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AltaTemperaturaMateriale).Value
        Case "DB130"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_FineCorsaBilancia).Value
        Case "DB131"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_FineCorsaCiclone).Value
        Case "DB132"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_NonTara).Value
        Case "DB133"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_Sicurezza).Value
        Case "DB134"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_FuoriTolleranza).Value
        Case "DB135"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_LivelloMinimo).Value
        Case "DB136"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_CiclonePieno).Value
        Case "DB137"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_TrasportoViatopFermo).Value
        Case "DB141"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_ScaricoBilanciaAperto).Value
        Case "DB142"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_ScaricoBilanciaChiuso).Value
        Case "DB143"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_ScaricoCicloneAperto).Value
        Case "DB144"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_ScaricoCicloneChiuso).Value
'20170224
        Case "DB145"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_Perdita_Peso).Value
        Case "DB146"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_Timeout_Trasporto_Viatop).Value
        Case "DB147"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Viatop_Timeout_Scarico_Ciclone).Value
'
        Case "DB150"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_PortinaAperta).Value
        Case "DB151"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_PortinaChiusa).Value
        Case "DB152"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_NonTara).Value
        Case "DB153"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_Sicurezza).Value
        Case "DB154"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_FuoriTolleranza).Value
        Case "DB155"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_PerditaPeso).Value
        Case "DB156"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_FineCorsaGenerico).Value
        Case "DB157"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_DeflScarScivAperto).Value
        Case "DB158"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_DeflScarScivChiuso).Value
        Case "DB159"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_RAP_FCDeflScarSciv).Value
        Case "DB170"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_NastroTimeOutAvvio).Value
        Case "DB171"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_NastroNoRitorno).Value
        Case "DB172"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_NastroTermica).Value
        Case "DB173"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_NastroTimeOutArresto).Value
        Case "DB180"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_PortinaAperta).Value
        Case "DB181"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_FineCorsa).Value
        Case "DB182"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_PortinaChiusa).Value
        Case "DB183"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_AdditivoSacchi_TimeOutIntroduzione).Value
        Case "DB190"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_ValvolaAperta).Value
        Case "DB191"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_ValvolaChiusa).Value
        Case "DB192"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_NonTara).Value
        Case "DB193"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_Sicurezza).Value
        Case "DB194"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_FuoriTolleranza).Value
        Case "DB195"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_PerditaPeso).Value
        Case "DB196"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_PompaCircolazioneFerma).Value
        Case "DB197"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_BitumeGR_FineCorsaGenerico).Value
            If ComandoScaricoBitume Then
                If Not allarmePresente Then
                    CP240.imgValvolaCisterne(218).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
                Else
                    CP240.imgValvolaCisterne(218).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                End If
            Else
                If Not allarmePresente Then
                    CP240.imgValvolaCisterne(218).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)
                Else
                    CP240.imgValvolaCisterne(218).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                End If
            End If
        Case "DB200"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_ValvolaAperta).Value
        Case "DB201"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_ValvolaChiusa).Value
        Case "DB202"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_FineCorsaGenerico).Value
            If CP240.OPCData.items(PLCTAG_DO_ContalitriPesata).Value Then
                If Not allarmePresente Then
                    CP240.imgValvolaCisterne(3).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)
                Else
                    CP240.imgValvolaCisterne(3).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                End If
            Else
                If Not allarmePresente Then
                    CP240.imgValvolaCisterne(3).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)
                Else
                    CP240.imgValvolaCisterne(3).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)
                End If
            End If
        Case "DB203"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_Sicurezza).Value
        Case "DB204"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_FuoriTolleranza).Value
        Case "DB205"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_PompaTimeOutAvvio).Value
        Case "DB206"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Contalitri_PompaTimeOutArresto).Value

        Case "DB220"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_NastroTimeOutAvvio).Value
        Case "DB221"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_NastroNoRitorno).Value
        Case "DB222"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_NastroTermica).Value
        Case "DB223"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_NastroTimeOutArresto).Value
        Case "DB230"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_PortinaTimeOutApertura).Value
        Case "DB231"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_PortinaTimeOutChiusura).Value
        Case "DB232"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_PortinaErroreFC_Generico).Value
        Case "DB233"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_PortinaErroreFC_Chiusa).Value
        Case "DB234"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_ErroreDatiDosaggioBilancia).Value
        Case "DB235"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_SiwaBatch_FuoriTolleranza).Value

        'Allarmi H20
        Case "DB240"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Acqua_PompaAccesaSenzaComando).Value
        Case "DB241"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Acqua_PompaErroreRitorno).Value
        Case "DB242"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Acqua_PompaTimeOutAvvio).Value
        Case "DB243"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Acqua_PompaTimeOutArresto).Value
        Case "DB244"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Acqua_PompaScattoTermica).Value
        Case "DB245"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_Acqua_SicurezzaLivelloMIN).Value

        Case "DB350"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA1).Value
        Case "DB351"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA2).Value
        Case "DB352"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA3).Value
        Case "DB353"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA4).Value
        Case "DB354"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA5).Value
        Case "DB355"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA6).Value
        Case "DB356"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineA7).Value
        Case "DB357"
            allarmePresente = CP240.OPCData.items(PLCTAG_All_FineCorsaIntermedioPesataFineNV).Value
       '20160422
        Case "DB360"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_FineCorsaBilancia).Value
        Case "DB361"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_NonTara).Value
        Case "DB362"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Sicurezza).Value
        Case "DB363"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_FuoriTolleranza).Value
        Case "DB364"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_LivelloMinimo).Value
        Case "DB365"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_CompressoreFermo).Value
        Case "DB366"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_TermicaCompressore).Value
        Case "DB367"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_ScaricoBilanciaAperto).Value
        '20161010
        'Case "DB367"
        '    allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_ScaricoBilanciaChiuso).Value
        'Case "DB369"
        '    allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_PerditaPeso).Value
        'Case "DB370"
        '    allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Tmout_Pesata).Value
        'Case "DB371"
        '    allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Tmout_Scarico).Value
        '20161010
        Case "DB368"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_ScaricoBilanciaChiuso).Value
        Case "DB369"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Termica_Dosaggio).Value
        Case "DB370"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Termica_Scarico).Value
        Case "DB371"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_PerditaPeso).Value
        Case "DB372"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Tmout_Pesata).Value
        Case "DB373"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer1_Tmout_Scarico).Value
        Case "DB374"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_FineCorsaBilancia).Value
        Case "DB375"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_NonTara).Value
        Case "DB376"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_Sicurezza).Value
        Case "DB377"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_FuoriTolleranza).Value
        Case "DB378"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_LivelloMinimo).Value
        Case "DB379"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_CompressoreFermo).Value
        Case "DB380"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_TermicaCompressore).Value
        Case "DB381"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_ScaricoBilanciaAperto).Value
        Case "DB382"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_ScaricoBilanciaChiuso).Value
        Case "DB383"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_Termica_Dosaggio).Value
        Case "DB384"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_Termica_Scarico).Value
        Case "DB385"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_PerditaPeso).Value
        Case "DB386"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_Tmout_Pesata).Value
        Case "DB387"
            allarmePresente = CP240.OPCData.items(PLCTAG_DB61_All_ViatopScarMixer2_Tmout_Scarico).Value
        '20161107
        Case "DB420"
            allarmePresente = BilanciaAggregati.Errore
        Case "DB421"
            allarmePresente = BilanciaFiller.Errore
        Case "DB422"
            allarmePresente = BilanciaLegante.Errore
        Case "DB423"
            allarmePresente = BilanciaRAP.Errore
        Case "DB424"
            allarmePresente = BilanciaViatop.Errore
        Case "DB425"
            allarmePresente = BilanciaViatopScarMixer1.Errore
        Case "DB426"
            allarmePresente = BilanciaViatopScarMixer2.Errore
        '
        '20161010
        '20160422
        Case Else
            Exit Sub

    End Select

    IngressoAllarmePresente IdDescrizione, allarmePresente

End Sub

Private Function AllarmePompeCircolazioneLegante() As Boolean
'Gestione allarme pompe circolazione legante tipo CONGLOBIT
'Per il PLC esiste solo il bitume 1 mentre il PC ne gestisce 3

    If CP240.AdoDosaggio.Recordset.EOF Or Not DosaggioInCorso Then
        Exit Function
    End If
    
    AllarmePompeCircolazioneLegante = True
    If CP240.AdoDosaggio.Recordset.Fields("Bitume1").Value > 0 Then
        If ValvolaBitumeEmulsioneSelezioneEmulsione Then
            If ListaMotori(MotorePompaEmulsione).ritorno Then
                AllarmePompeCircolazioneLegante = False
            End If
        Else
            If ListaMotori(MotorePCL).ritorno Or Pcl1AutoOn Then
                AllarmePompeCircolazioneLegante = False
            End If
        
        End If
        Exit Function
    End If

    If CP240.AdoDosaggio.Recordset.Fields("Bitume2").Value > 0 Then
        If ValvolaBitumeEmulsioneSelezioneEmulsione Then
            If ListaMotori(MotorePompaEmulsione).ritorno Then
                AllarmePompeCircolazioneLegante = False
            End If
        Else
            If ListaMotori(MotorePCL2).ritorno Or Pcl2AutoOn Then
                AllarmePompeCircolazioneLegante = False
            End If
        End If
        Exit Function
    End If
    If CP240.AdoDosaggio.Recordset.Fields("SetBitumeSoft").Value > 0 Then
        If ListaMotori(MotorePCL3).ritorno Then
            AllarmePompeCircolazioneLegante = False
        End If
        Exit Function
    End If
    
    AllarmePompeCircolazioneLegante = False

End Function

Public Function FuncAllarmeSlittamentoMotore(allsensore As Boolean, ritmotore As Boolean, ByRef orastartallarme As Long, temporitallarme As Long) As Boolean
'20150422

    '20170208
    ''If allsensore And ritmotore Then   '20161213
    'If allsensore Then   '20161213
    '    If orastartallarme = 0 Then
    '        orastartallarme = ConvertiTimer()
    '    End If
    '
    '    If ConvertiTimer() >= (orastartallarme + temporitallarme) Then
    '        'FuncAllarmeSlittamentoMotore = allsensore And ritmotore    '20161213
    '        FuncAllarmeSlittamentoMotore = allsensore    '20161213
    '    Else
    '        FuncAllarmeSlittamentoMotore = False
    '    End If
    'Else
    '    orastartallarme = 0
    '    FuncAllarmeSlittamentoMotore = False
    'End If
    If (allsensore And ritmotore) Then
        If orastartallarme = 0 Then
            orastartallarme = ConvertiTimer()
        End If

        If (ConvertiTimer() >= (orastartallarme + temporitallarme)) Then
            FuncAllarmeSlittamentoMotore = (allsensore And ritmotore)
        Else
            FuncAllarmeSlittamentoMotore = False
        End If
    Else
        orastartallarme = 0
        FuncAllarmeSlittamentoMotore = False
    End If
    '
    
End Function
