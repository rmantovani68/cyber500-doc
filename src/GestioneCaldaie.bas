Attribute VB_Name = "GestioneCaldaie"

Option Explicit

Public Type OggettoCaldaia
'-------------------------------------------------------------------------------------------------
'Parametri generali
'-------------------------------------------------------------------------------------------------
    AbilitazioneCaldaia As Boolean      'indica se la caldaia è stata abilitata o meno dai parametri
    InclusioneValvole As Boolean        'Indica se la valvola di mandata e di ritorno automatiche sono incluse o ci sono solo le manuali
    BruciatoreOn As Boolean             'Indica se la caldaia e accesa o meno
    BloccoBruciatore As Boolean         'Indica se il bruciatore è in blocco o meno
    SecondaFiammaOn As Boolean          'Indica se è accesa anche la seconda fiamma della caldaia
    AckAllarmi As Boolean               'Accetta gli allarmi
    StartCaldaia As Boolean             'Indica se la caldaia è accesa o meno
    StopEmergenza As Boolean            'Arresta immediatamente tutti gli elementi controllati della caldaia
    CaricamentoOlioCirc As Boolean      'Attiva il caricamento dell'olio nel circuito
   ' CodificaAllarmeCaldaia As Long     'allarme caldaia codificato in binario
    ErroriValvoleIN As Boolean          'Indica la presenza di errori sulle valvole di ritorno
    ErroriValvoleOUT As Boolean         'Indica la presenza di errori sulle valvole di mandata
    StatoLedCaldaia As Boolean          'Indica se la caldaia è a riposo o sta eseguendo il ciclo
'-------------------------------------------------------------------------------------------------
'valvola di ritorno
'-------------------------------------------------------------------------------------------------
    ValvolaApertaRitorno As Boolean     'lettura filtrata del fincorsa di aperto
    ValvolaChiusaRitorno As Boolean     'lettura filtrata del fincorsa di chiuso
    CodiceAllRitorno As Long            'allarme valvola codificato in binario
'-------------------------------------------------------------------------------------------------
'valvola di mandata
'-------------------------------------------------------------------------------------------------
    ValvolaApertaMandata As Boolean     'lettura filtrata del fincorsa di aperto
    ValvolaChiusaMandata As Boolean     'lettura filtrata del fincorsa di chiuso
    CodiceAllMandata As Long            'allarme valvola codificato in binario
'-------------------------------------------------------------------------------------------------
'Pompa di circolazione
'-------------------------------------------------------------------------------------------------
    PompaCircOn As Boolean              'indica se la pompa di circolazione è accesa
    PompaCircScattoTermica As Boolean   'Indica se è attiva la termica della pompa
    TimerSpegnimentoPompa As Integer    'indica il tempo che deve passare dallo spegnimento della caldaia per spegnere la pompa
    TimeoutAvvioPompaCirc As Integer    'Allarme che indica il superamento del massimo tempo per l'avvio della pompa
    TimeoutArrestoPompaCirc As Integer  'Allarme che indica il superamento del massimo tempo per l'arresto della pompa
'-------------------------------------------------------------------------------------------------
'Gestione temperatura
'-------------------------------------------------------------------------------------------------
    ValTemperatura As Integer           'Indica il valore della temperatura del circuito
    SetTemperatura As Integer           'Indica il set di temperatura del fluido da scaldare
    DeltaTemperatura As Integer         'Indica la differenza di temperatura per l'accensione della seconda fiamma
    SicurezzaTemperaturaOlio As Boolean 'Indica che la temperatura dell'olio ha superato la soglia di sicurezza
    lckset As Boolean                   'blocco della lettura del set da plc (true quando si sta modificandone il valore da pc)
    
End Type

Public Type ProgrammazioneRiscaldamentiGiornalieri

    OraON As Integer
    OraOFF As Integer
    MinON As Integer
    MinOFF As Integer
    SecON As Integer
    SecOFF As Integer

End Type

Public Type OggettoPompaAuxCald

    start As Boolean
    ritorno As Boolean
    erroriPresenti As Integer
    
End Type
'

Private offset As Integer       'è l'intervallo fra lo stesso tag delle due caldaie diverse nella db14
Private Offset2 As Integer      'è l'intervallo fra lo stesso tag delle due caldaie diverse nella db40
Private Offset3 As Integer      'è l'intervallo fra lo stesso tag delle due caldaie diverse nella db23

Private OffsetCaldAux As Integer       'intervallo fra lo stesso tag delle pompe ausiliarie delle caldaie nella db199

Public Caldaia(0 To 1) As OggettoCaldaia
'Public ScattoTermicaCaldaie As Boolean
Public NumeroCaldaiePresenti As Integer
Public InizializzazioneCaldaieFinita As Boolean
'Il giorno 1 è la domenica!
Public TimerProg(0 To 6) As ProgrammazioneRiscaldamentiGiornalieri
Public InclusioneOrologio As Boolean
Public TipoDiProgrammazioneRiscaldamenti As Byte

Public PompaAuxCald(0 To 2) As OggettoPompaAuxCald      'Pompe ausiliarie delle caldaie
'


Public Sub CaldaieCaricaImmagini()

    With CP240
        .FrameCaldaie.top = .FrameCisterne(2).top - 20
        .Image2(0).Picture = LoadResPicture("IDI_LEDROSSO", vbResIcon)
        .Image2(1).Picture = LoadResPicture("IDI_LEDROSSO", vbResIcon)
        .ImgCaldLedOlio(0).Picture = LoadResPicture("IDI_LEDROSSO", vbResIcon)
        .ImgCaldLedOlio(1).Picture = LoadResPicture("IDI_LEDROSSO", vbResIcon)
        .ImgCaldValvolaEntrata(0).Picture = LoadResPicture("IDI_VALVOLAFRECCIAGIU", vbResIcon)
        .ImgCaldValvolaEntrata(1).Picture = LoadResPicture("IDI_VALVOLAFRECCIAGIU", vbResIcon)
        .ImgCaldValvolaUscita(0).Picture = LoadResPicture("IDI_VALVOLAFRECCIASU", vbResIcon)
        .ImgCaldValvolaUscita(1).Picture = LoadResPicture("IDI_VALVOLAFRECCIASU", vbResIcon)
        .PctCaldTemperatura(0).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
        .PctCaldTemperatura(1).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
        .ImgBoiler(0).Picture = LoadResPicture("IDB_CALDAIA", vbResBitmap)
        .ImgBoiler(1).Picture = LoadResPicture("IDB_CALDAIA", vbResBitmap)
        .CmdProgRisc.Picture = LoadResPicture("IDB_PROGRISCOFF", vbResBitmap)
    End With
    
End Sub

Public Sub LeggiDatiDaCaldaie()

On Error GoTo Errore
    
Dim i As Integer

Dim test As Variant
    
    If (Not Caldaia(0).AbilitazioneCaldaia) Then
        Exit Sub
    End If
    
    If CP240.OPCDataCisterne.IsConnected And CP240.OPCDataCisterne.items.Count <> 0 Then
        test = (GetQuality(CP240.OPCDataCisterne.items(0).quality) = STATOOK)
        If test = False Then Exit Sub
    Else
        Exit Sub
    End If


'    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.Items.count = 0 Then
'        Exit Sub
'    End If

    offset = CistTAG_CALDAIA2_ABILITAZIONE - CistTAG_CALDAIA1_ABILITAZIONE
    Offset2 = CistTAG_ALM_CALDAIA2_BloccoBruciatore - CistTAG_ALM_CALDAIA1_BloccoBruciatore
    Offset3 = CistTAG_CALDAIA2_VALVOLA_APERTA_RITORNO - CistTAG_CALDAIA1_VALVOLA_APERTA_RITORNO
    OffsetCaldAux = CistTAG_PUMPAUX2_Start - CistTAG_PUMPAUX1_Start

    NumeroCaldaiePresenti = 0

    For i = 0 To 1
        If Caldaia(i).AbilitazioneCaldaia Then
            NumeroCaldaiePresenti = NumeroCaldaiePresenti + 1
        End If
    Next i
    
    If (NumeroCaldaiePresenti = 0) Then
        Exit Sub
    End If

    With CP240.OPCDataCisterne.items
      
        'Inizializzazione per sincronizzare i parametri presenti nel PC con quelli del PLC
        If Not InizializzazioneCaldaieFinita Then
            Call InizializzaCaldaie
            InizializzazioneCaldaieFinita = True
        End If

        For i = 0 To NumeroCaldaiePresenti - 1
    
'---------------------------------------------------------
'parametri generali
'---------------------------------------------------------
 
            Caldaia(i).InclusioneValvole = .item(CistTAG_CALDAIA1_EN_VALV_IN_OUT + i * offset).Value
            Caldaia(i).AbilitazioneCaldaia = .item(CistTAG_CALDAIA1_ABILITAZIONE + i * offset).Value
            If Caldaia(i).StatoLedCaldaia <> .item(CistTAG_Stato_LED_CALDAIA1 + i).Value Then
                Caldaia(i).StatoLedCaldaia = .item(CistTAG_Stato_LED_CALDAIA1 + i).Value
                Call CaldVisualizzaStatoLED(i)
            End If
            
            If Caldaia(i).StartCaldaia <> .item(CistTAG_CALDAIA1_START + i * offset).Value Then
                Caldaia(i).StartCaldaia = .item(CistTAG_CALDAIA1_START + i * offset).Value
                Call CaldVisualizzaStart(i)
            End If
            
            
            Caldaia(i).StopEmergenza = .item(CistTAG_CALDAIA1_STOP_EMERGENZA + i * offset).Value
            Caldaia(i).CaricamentoOlioCirc = .item(CistTAG_CALDAIA1_CARICAMENTO_OLIO_CIRC + i * offset).Value
            'caldaia(i).CodificaAllarmeCaldaia = .Item( + i * offset).value
        
            If ( _
                Caldaia(i).BruciatoreOn <> .item(CistTAG_CALDAIA1_BRUC_ON_CALDAIA_1 + i * offset).Value Or _
                Caldaia(i).SecondaFiammaOn <> .item(CistTAG_CALDAIA1_BRUC_2A_FIAMMA_ON + i * offset).Value Or _
                Caldaia(i).BloccoBruciatore <> .item(CistTAG_ALM_CALDAIA1_BloccoBruciatore + i * Offset2).Value _
            ) Then
                Caldaia(i).BruciatoreOn = .item(CistTAG_CALDAIA1_BRUC_ON_CALDAIA_1 + i * offset).Value
                Caldaia(i).SecondaFiammaOn = .item(CistTAG_CALDAIA1_BRUC_2A_FIAMMA_ON + i * offset).Value
                Caldaia(i).BloccoBruciatore = .item(CistTAG_ALM_CALDAIA1_BloccoBruciatore + i * Offset2).Value
                
                Call CaldVisualizzaFiamma(i, Caldaia(i).BloccoBruciatore, Caldaia(i).BruciatoreOn, Caldaia(i).SecondaFiammaOn)
            End If
            
'---------------------------------------------------------
'parametri Valvole
'---------------------------------------------------------
        
            'Valvola Entrata
            If ( _
                Caldaia(i).ErroriValvoleIN <> .item(CistTAG_ALM_CALDAIA1_ErroriValvoleIN + i * Offset2).Value Or _
                Caldaia(i).ErroriValvoleOUT <> .item(CistTAG_ALM_CALDAIA1_ErroriValvoleOUT + i * Offset2).Value _
            ) Then
                Caldaia(i).ErroriValvoleIN = .item(CistTAG_ALM_CALDAIA1_ErroriValvoleIN + i * Offset2).Value
                Caldaia(i).ErroriValvoleOUT = .item(CistTAG_ALM_CALDAIA1_ErroriValvoleOUT + i * Offset2).Value
                
                Call CaldVisualizzaErroriValvole(i, Caldaia(i).ErroriValvoleIN, Caldaia(i).ErroriValvoleOUT)
            End If
            
            If ( _
                Caldaia(i).ValvolaApertaRitorno <> .item(CistTAG_CALDAIA1_VALVOLA_APERTA_RITORNO + i * Offset3).Value Or _
                Caldaia(i).ValvolaChiusaRitorno <> .item(CistTAG_CALDAIA1_VALVOLA_CHIUSA_RITORNO + i * Offset3).Value Or _
                Caldaia(i).CodiceAllRitorno <> CLng(.item(CistTAG_ALM_CALDAIA1_ErroriValvoleIN + i * Offset2).Value) _
            ) Then
                Caldaia(i).ValvolaApertaRitorno = .item(CistTAG_CALDAIA1_VALVOLA_APERTA_RITORNO + i * Offset3).Value
                Caldaia(i).ValvolaChiusaRitorno = .item(CistTAG_CALDAIA1_VALVOLA_CHIUSA_RITORNO + i * Offset3).Value
                Caldaia(i).CodiceAllRitorno = .item(CistTAG_ALM_CALDAIA1_ErroriValvoleIN + i * Offset2).Value
    
                Call CaldVisualizzaValvolaEntrata( _
                    i, _
                    Caldaia(i).ValvolaApertaRitorno, _
                    Caldaia(i).ValvolaChiusaRitorno, _
                    Caldaia(i).CodiceAllRitorno <> 0 _
                    )
            End If

            'Valvola Uscita
            
            Caldaia(i).ErroriValvoleOUT = .item(CistTAG_ALM_CALDAIA1_ErroriValvoleOUT + i * Offset2).Value
            
            If ( _
                Caldaia(i).ValvolaApertaMandata <> .item(CistTAG_CALDAIA1_VALVOLA_APERTA_MANDATA + i * Offset3).Value Or _
                Caldaia(i).ValvolaChiusaMandata <> .item(CistTAG_CALDAIA1_VALVOLA_CHIUSA_MANDATA + i * Offset3).Value Or _
                Caldaia(i).CodiceAllMandata <> CLng(.item(CistTAG_ALM_CALDAIA1_ErroriValvoleOUT + i * Offset2).Value) _
            ) Then
                Caldaia(i).ValvolaApertaMandata = .item(CistTAG_CALDAIA1_VALVOLA_APERTA_MANDATA + i * Offset3).Value
                Caldaia(i).ValvolaChiusaMandata = .item(CistTAG_CALDAIA1_VALVOLA_CHIUSA_MANDATA + i * Offset3).Value
                Caldaia(i).CodiceAllRitorno = .item(CistTAG_ALM_CALDAIA1_ErroriValvoleOUT + i * Offset2).Value
    
                Call CaldVisualizzaValvolaUscita( _
                    i, _
                    Caldaia(i).ValvolaApertaMandata, _
                    Caldaia(i).ValvolaChiusaMandata, _
                    Caldaia(i).CodiceAllMandata <> 0 _
                    )
            End If
            
'---------------------------------------------------------
'Gestione pompa
'---------------------------------------------------------

'            Caldaia(i).TimerSpegnimentoPompa = .Item(CistTAG_CALDAIA1_TEMPO_ARR_P_CIRC + i * offset).value
            Caldaia(i).TimeoutAvvioPompaCirc = .item(CistTAG_ALM_CALDAIA1_TimeoutAvvioPompaCircolazione + i * Offset2).Value
            Caldaia(i).TimeoutArrestoPompaCirc = .item(CistTAG_ALM_CALDAIA1_TimeoutArrestoPompaCircolazione + i * Offset2).Value
            
            If (Caldaia(i).PompaCircOn <> (.item(CistTAG_CALDAIA1_POMPA_CIRC_ON + i * offset).Value) Or _
                Caldaia(i).PompaCircScattoTermica <> (.item(CistTAG_ALM_CALDAIA1_ScattoTermicaPompaCircolazione + i * Offset2).Value = 1) _
            ) Then
                Caldaia(i).PompaCircOn = .item(CistTAG_CALDAIA1_POMPA_CIRC_ON + i * offset).Value
                Caldaia(i).PompaCircScattoTermica = .item(CistTAG_ALM_CALDAIA1_ScattoTermicaPompaCircolazione + i * Offset2).Value
                
                Call CaldVisualizzaPompaCirc(i, Caldaia(i).PompaCircOn, Caldaia(i).PompaCircScattoTermica)
            End If
        
'---------------------------------------------------------
'Gestione temperatura
'---------------------------------------------------------

            If Caldaia(i).SicurezzaTemperaturaOlio <> .item(CistTAG_ALM_CALDAIA1_TemperaturaOlioOltreSicurezza + i * Offset2).Value Then
                Caldaia(i).SicurezzaTemperaturaOlio = .item(CistTAG_ALM_CALDAIA1_TemperaturaOlioOltreSicurezza + i * Offset2).Value
                Call VisualizzaSicurezzaTemperaturaOlio(i, Caldaia(i).SicurezzaTemperaturaOlio)
            End If
            
                
            If Caldaia(i).lckset = False Then
                Caldaia(i).SetTemperatura = .item(CistTAG_CALDAIA1_TEMPERATURA_SET + i * offset).Value
                CP240.LblCaldTempSet(i).caption = Caldaia(i).SetTemperatura
            End If
    
            If (Caldaia(i).ValTemperatura <> .item(CistTAG_CALDAIA1_TEMPERATURA_CIRCUITO + i * offset).Value) Then
                Caldaia(i).ValTemperatura = .item(CistTAG_CALDAIA1_TEMPERATURA_CIRCUITO + i * offset).Value
                Call CaldVisualizzaTemperatura(i, Caldaia(i).ValTemperatura)
            End If
    
'            If (Caldaia(i).DeltaTemperatura <> .Item(CistTAG_CALDAIA1_DELTA_TEMPERATURA + i * offset).value) Then
'                Caldaia(i).DeltaTemperatura = .Item(CistTAG_CALDAIA1_DELTA_TEMPERATURA + i * offset).value
'            End If
        
        Next
'---------------------------------------------------------
'Programmazione riscaldamenti
'---------------------------------------------------------

        TipoDiProgrammazioneRiscaldamenti = CP240.OPCDataCisterne.items.item(CistTAG_Sel_turni_settim_giorn).Value
        If InclusioneOrologio <> CP240.OPCDataCisterne.items.item(CistTAG_Inclusione_Orologio_Caldaie).Value Then
            InclusioneOrologio = CP240.OPCDataCisterne.items.item(CistTAG_Inclusione_Orologio_Caldaie).Value

            If FormProgRiscaldamentiCaldaie.Visible Then
                Call FormProgRiscaldamentiCaldaie.AggiornaGraficaProgrammazione
            End If
        
        End If
            
        For i = 0 To 6
            TimerProg(i).OraON = CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_ORA_SET + i * 6).Value
            TimerProg(i).MinON = CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_MINUTI_SET + i * 6).Value
            TimerProg(i).SecON = CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_SECONDI_SET + i * 6).Value
            TimerProg(i).OraOFF = CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_ORA_RESET + i * 6).Value
            TimerProg(i).MinOFF = CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_MINUTI_RESET + i * 6).Value
            TimerProg(i).SecOFF = CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_SECONDI_RESET + i * 6).Value
        Next i
                    

'---------------------------------------------------------
'Gestione pompe ausiliarie
'---------------------------------------------------------
            
        For i = 0 To 2

            If PompaAuxCald(i).start <> .item(CistTAG_PUMPAUX1_Start + i * OffsetCaldAux).Value Then
                PompaAuxCald(i).start = .item(CistTAG_PUMPAUX1_Start + i * OffsetCaldAux).Value
                Call VisualizzaStarPumpAuxCAld(i)
            End If

            If (PompaAuxCald(i).ritorno <> .item(CistTAG_PUMPAUX1_Ritorno + i * OffsetCaldAux).Value Or _
               PompaAuxCald(i).erroriPresenti <> (CInt(.item(CistTAG_PUMPAUX1_ErroriPresenti + i * OffsetCaldAux).Value) <> 0) _
            ) Then
                PompaAuxCald(i).ritorno = .item(CistTAG_PUMPAUX1_Ritorno + i * OffsetCaldAux).Value
                
                PompaAuxCald(i).erroriPresenti = (CInt(.item(CistTAG_PUMPAUX1_ErroriPresenti + i * OffsetCaldAux).Value) <> 0)
                Call VisualizzaGraficaPumpAuxCAld(i, PompaAuxCald(i).ritorno, PompaAuxCald(i).erroriPresenti)
                
            End If
            
        Next i

    End With
    
    Exit Sub

Errore:
    LogInserisci True, "CLD-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub InizializzaCaldaie()
    Dim i As Integer
    
    Call ReadFileRiscaldamenti
    Call SetProgrammazioneRiscaldamenti
    
    For i = 0 To NumeroCaldaiePresenti - 1
        CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_ABILITAZIONE + i * offset).Value = Caldaia(i).AbilitazioneCaldaia
        CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_EN_VALV_IN_OUT + i * offset).Value = Caldaia(i).InclusioneValvole
        CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_DELTA_TEMPERATURA + i * offset).Value = Caldaia(i).DeltaTemperatura
        CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_TEMPO_ARR_P_CIRC + i * offset).Value = Caldaia(i).TimerSpegnimentoPompa
    Next
                
End Sub

Public Sub CaldVisualizzaErroriValvole(indice As Integer, ErroriIn As Boolean, ErroriOut As Boolean)

    With CP240
    
        If ErroriIn Then
            .ImgErrorValvolaEntrata(indice).Visible = Not .ImgErrorValvolaEntrata(indice).Visible
        ElseIf ErroriOut Then
            .ImgErrorValvolaUscita(indice).Visible = Not .ImgErrorValvolaUscita(indice).Visible
        Else
            .ImgErrorValvolaEntrata(indice).Visible = False
            .ImgErrorValvolaUscita(indice).Visible = False
        End If
        
    End With

End Sub

Public Sub CaldVisualizzaFiamma(indice As Integer, blocco As Boolean, BruciatoreOn As Boolean, SecondaFiammaOn As Boolean)

    If Not blocco Then
        CP240.ImageFiamma(indice).Visible = BruciatoreOn
        CP240.ImageFiamma(indice + 2).Visible = BruciatoreOn And SecondaFiammaOn
        CP240.ImageFiammaBlocco(indice).Visible = False
    Else
        CP240.ImageFiamma(indice).Visible = False
        CP240.ImageFiamma(indice + 2).Visible = False
        CP240.ImageFiammaBlocco(indice).Visible = True
    End If
    
End Sub

Public Sub CaldVisualizzaStatoLED(indice As Integer)
    If Caldaia(indice).StatoLedCaldaia = True Then
        CP240.Image2(indice).Picture = LoadResPicture("IDI_LEDVERDE", vbResIcon)
    Else
        CP240.Image2(indice).Picture = LoadResPicture("IDI_LEDROSSO", vbResIcon)
    End If
End Sub

Public Sub CaldVisualizzaStart(indice As Integer)
    With CP240

        If Caldaia(indice).StartCaldaia = True Then
            .CmdCaldaiaOn(indice).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
            .CmdCircOlio(indice).enabled = False
        Else
            .CmdCaldaiaOn(indice).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
            .CmdCircOlio(indice).enabled = True
        End If

    End With
End Sub


Public Sub CaldVisualizzaCircOlio(indice As Integer)
    With CP240
        
        If Caldaia(indice).CaricamentoOlioCirc = True Then
            .CmdCircOlio(indice).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
            .CmdCaldaiaOn(indice).enabled = False
        Else
            .CmdCircOlio(indice).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
            .CmdCaldaiaOn(indice).enabled = True
        End If
        '
    End With
End Sub

Public Sub VisualizzaSicurezzaTemperaturaOlio(indice As Integer, SicurezzaTemperaturaOlio As Boolean)

    If SicurezzaTemperaturaOlio Then
        CP240.PctCaldTemperatura(indice).Visible = Not CP240.PctCaldTemperatura(indice).Visible
    Else
        CP240.PctCaldTemperatura(indice).Visible = False
    End If

End Sub

Public Sub CaldVisualizzaValvolaUscita(indice As Integer, aperta As Boolean, chiusa As Boolean, allarme As Boolean)

    With CP240

        If (allarme Or aperta = chiusa) Then
            .ImgCaldValvolaUscita(indice).Picture = LoadResPicture("IDI_VALVOLAERROREFRECCIAGIU", vbResIcon)
        ElseIf (aperta) Then
            .ImgCaldValvolaUscita(indice).Picture = LoadResPicture("IDI_VALVOLAONFRECCIAGIU", vbResIcon)
        Else
            .ImgCaldValvolaUscita(indice).Picture = LoadResPicture("IDI_VALVOLAFRECCIAGIU", vbResIcon)
        End If

    End With

End Sub

Public Sub CaldVisualizzaValvolaEntrata(indice As Integer, aperta As Boolean, chiusa As Boolean, allarme As Boolean)

    With CP240

        If (allarme Or aperta = chiusa) Then
            .ImgCaldValvolaEntrata(indice).Picture = LoadResPicture("IDI_VALVOLAERROREFRECCIASU", vbResIcon)
        ElseIf (aperta) Then
            .ImgCaldValvolaEntrata(indice).Picture = LoadResPicture("IDI_VALVOLAONFRECCIASU", vbResIcon)
        Else
            .ImgCaldValvolaEntrata(indice).Picture = LoadResPicture("IDI_VALVOLAFRECCIASU", vbResIcon)
        End If

    End With

End Sub

Public Sub CaldVisualizzaPompaCirc(indice As Integer, PompaCircOn As Boolean, PompaCircScattoTermica As Boolean)
                        
With CP240
    If Not PompaCircScattoTermica Then
    
        If PompaCircOn Then
            .ImgPumpCAld(indice).Visible = False         'grigia
            .ImgPumpCAld(indice + 2).Visible = True      'verde
            .ImgPumpCAld(indice + 4).Visible = False      'rossa
        Else
            .ImgPumpCAld(indice).Visible = True          'grigia
            .ImgPumpCAld(indice + 2).Visible = False     'verde
            .ImgPumpCAld(indice + 4).Visible = False      'rossa
        End If
        
    Else
        .ImgPumpCAld(indice).Visible = False     'grigia
        .ImgPumpCAld(indice + 2).Visible = False     'verde
        .ImgPumpCAld(indice + 4).Visible = True      'rossa
    End If
End With

End Sub

Public Sub CaldVisualizzaTemperatura(indice As Integer, ByVal Value As Double)

    With CP240

        .LblCaldTemp(indice).caption = Format(Value, "0")

    End With

End Sub


Public Sub VisualizzaStarPumpAuxCAld(indice As Integer)

    With CP240
    
        If PompaAuxCald(indice).start = True Then
            .CmdStartPumpAuxCald(indice).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
        Else
            .CmdStartPumpAuxCald(indice).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
        End If
        
    End With

End Sub


Public Sub VisualizzaGraficaPumpAuxCAld(indice As Integer, ritorno As Boolean, erroriPresenti As Integer)

    With CP240
    
        If erroriPresenti = 0 Then
            If ritorno = True Then
                .ImgPumpAuxCald(indice).Visible = False
                .ImgPumpAuxCald(indice + 3).Visible = True
                .ImgPumpAuxCald(indice + 6).Visible = False
            Else
                .ImgPumpAuxCald(indice).Visible = True
                .ImgPumpAuxCald(indice + 3).Visible = False
                .ImgPumpAuxCald(indice + 6).Visible = False
            End If
        Else
            .ImgPumpAuxCald(indice).Visible = False
            .ImgPumpAuxCald(indice + 3).Visible = False
            .ImgPumpAuxCald(indice + 6).Visible = True
        End If
        
    End With

End Sub
'

Public Sub LoopGraficaCaldaie()
Dim indice As Integer
    For indice = 0 To NumeroCaldaiePresenti - 1
        Call VisualizzaSicurezzaTemperaturaOlio(indice, Caldaia(indice).SicurezzaTemperaturaOlio)
        Call CaldVisualizzaErroriValvole(indice, Caldaia(indice).ErroriValvoleIN, Caldaia(indice).ErroriValvoleOUT)
    Next
End Sub

Public Sub CaldSetTemperatura(Index As Integer)
Dim valore As Long

On Error GoTo Errore
    
    Caldaia(Index).lckset = True
    valore = FrmNewValue.InputLongValue(CP240, CLng(Caldaia(Index).SetTemperatura), 0, 250)
    
    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.Count = 0 Then
        Exit Sub
    End If
    
    Caldaia(Index).SetTemperatura = valore
    CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_TEMPERATURA_SET + Index * offset).Value = Caldaia(Index).SetTemperatura
    
    Caldaia(Index).lckset = False
        
    Exit Sub

Errore:
    LogInserisci True, "CLD-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CaldSetDeltaTemperatura()
Dim Index
    On Error GoTo Errore

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.Count = 0 Then
        Exit Sub
    End If
    For Index = 0 To NumeroCaldaiePresenti - 1
        Caldaia(Index).lckset = True
        CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_DELTA_TEMPERATURA + Index * offset).Value = Caldaia(Index).DeltaTemperatura
        Caldaia(Index).lckset = False
    Next
    
    Exit Sub

Errore:
    LogInserisci True, "CLD-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CaldSetTimerPompa()
Dim Index
On Error GoTo Errore

    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.Count = 0 Then
        Exit Sub
    End If
    For Index = 0 To NumeroCaldaiePresenti - 1
        Caldaia(Index).lckset = True
        CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_TEMPO_ARR_P_CIRC + Index * offset).Value = Caldaia(Index).TimerSpegnimentoPompa
        Caldaia(Index).lckset = False
    Next
    
    Exit Sub

Errore:
    LogInserisci True, "CLD-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CaldAccettaErrore(accetta As Boolean)

    Caldaia(0).AckAllarmi = accetta
    Caldaia(1).AckAllarmi = accetta
    CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA1_ACK_ALLARMI) = Caldaia(0).AckAllarmi
    CP240.OPCDataCisterne.items.item(CistTAG_CALDAIA2_ACK_ALLARMI) = Caldaia(1).AckAllarmi
    
End Sub

Public Function ControllaCaldaieAllarmi(ByRef IdDescrizione As Integer, ByRef CodiceAllarme As String)

    Dim i As Integer
    Dim allarmePresente As Boolean
    
    If (Not CP240.OPCDataCisterne.IsConnected) Then Exit Function
    
    If (NumeroCaldaiePresenti = 0) Then
        Exit Function
    End If

    Offset2 = CistTAG_ALM_CALDAIA2_BloccoBruciatore - CistTAG_ALM_CALDAIA1_BloccoBruciatore
    
    For i = 0 To NumeroCaldaiePresenti - 1
    
        Select Case CodiceAllarme
        
            Case "BM" & Format(1 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_BloccoBruciatore + i * Offset2).Value
            
            Case "BM" & Format(2 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_TemperaturaOlioOltreSicurezza + i * Offset2).Value
            
            Case "BM" & Format(3 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_ScattoTermicaPompaCircolazione + i * Offset2).Value
            
            Case "BM" & Format(4 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_ErrorePressostatoDifferenziale + i * Offset2).Value
            
            Case "BM" & Format(5 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_ErroriValvoleIN + i * Offset2).Value
            
            Case "BM" & Format(6 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_ErroriValvoleOUT + i * Offset2).Value
            
            Case "BM" & Format(7 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_TimeoutAvvioPompaCircolazione + i * Offset2).Value
            
            Case "BM" & Format(8 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_TimeoutArrestoPompaCircolazione + i * Offset2).Value
            
            Case "BM" & Format(9 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_MancatoRitornoPompaCircDuranteFunzionamento + i * Offset2).Value
            
            Case "BM" & Format(10 + offset * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_LivelloMinimoOlio + i * Offset2).Value
            
            Case "BM" & Format(11 + Offset2 * i, "000")
                allarmePresente = CP240.OPCDataCisterne.items(CistTAG_ALM_CALDAIA1_ValvoleChiuseConPompaCircInMoto + i * Offset2).Value
            
            Case "BM" & Format(12 + Offset2 * i, "000")
                'LIBERO
            
            Case "BM" & Format(13 + Offset2 * i, "000")
                'LIBERO
            
            Case "BM" & Format(14 + Offset2 * i, "000")
                'LIBERO
            
            Case "BM" & Format(15 + Offset2 * i, "000")
                'LIBERO
            
            Case "BM" & Format(16 + Offset2 * i, "000")
                'LIBERO
        End Select
        
    Next i
    
    Select Case CodiceAllarme
        
        Case "BM" & Format(33, "000")
            allarmePresente = CP240.OPCDataCisterne.items(CistTAG_SCATTO_TERMICA_GEN).Value
    
    End Select
        
    IngressoAllarmePresente IdDescrizione, allarmePresente
    
End Function



'---------------------------------PARTE PROGRAMMAZIONE RISCALDAMENTI---------------------------------------

Public Sub SalvaFileRiscaldamenti()
Debug.Print "CYBERTRONIC_PLUS SalvaFileRiscaldamenti"
'    Dim i As Integer
'
'    With FormProgRiscaldamentiCaldaie
'        For i = 0 To 6
'
'            TimerProg(i).OraON = .TextOraON(i)
'            TimerProg(i).MinON = .TextMinON(i)
'            TimerProg(i).SecON = .TextSecON(i)
'            TimerProg(i).OraOFF = .TextOraOFF(i)
'            TimerProg(i).MinOFF = .TextMinOFF(i)
'            TimerProg(i).SecOFF = .TextSecOFF(i)
'        Next i
'
'        TipoDiProgrammazioneRiscaldamenti = .ComboTipoProg.ListIndex
'
'    End With
'
'    WriteFileRiscaldamenti
'    SetProgrammazioneRiscaldamenti

End Sub

Public Sub WriteFileRiscaldamenti()
Debug.Print "CYBERTRONIC_PLUS WriteFileRiscaldamenti"
'    Dim nomeFile As String
'    Dim i As Integer
'
'    nomeFile = UserDataPath + FileProgrammaRiscaldamenti
'
'    For i = 0 To 6
'        With TimerProg(i)
'            FileSetValue nomeFile, "GIORNO" + CStr(i + 1), "OraON" + CStr(i), CStr(.OraON)
'            FileSetValue nomeFile, "GIORNO" + CStr(i + 1), "MinON" + CStr(i), CStr(.MinON)
'            FileSetValue nomeFile, "GIORNO" + CStr(i + 1), "SecON" + CStr(i), CStr(.SecON)
'            FileSetValue nomeFile, "GIORNO" + CStr(i + 1), "OraOFF" + CStr(i), CStr(.OraOFF)
'            FileSetValue nomeFile, "GIORNO" + CStr(i + 1), "MinOFF" + CStr(i), CStr(.MinOFF)
'            FileSetValue nomeFile, "GIORNO" + CStr(i + 1), "SecOFF" + CStr(i), CStr(.SecOFF)
'        End With
'    Next i
'
'    FileSetValue nomeFile, "TIPO DI PROGRAMMAZIONE", "TIPO DI PROGRAMMAZIONE", TipoDiProgrammazioneRiscaldamenti
    
End Sub

Public Sub ReadFileRiscaldamenti()

    Dim i As Integer
    Dim giorno As String

    For i = 0 To 6
        giorno = "GIORNO" + CStr(i + 1)
        TimerProg(i).OraON = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", giorno, "OraON"))
        TimerProg(i).MinON = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", giorno, "MinON"))
        TimerProg(i).SecON = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", giorno, "SecON"))
        TimerProg(i).OraOFF = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", giorno, "OraOFF"))
        TimerProg(i).MinOFF = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", giorno, "MinOFF"))
        TimerProg(i).SecOFF = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", giorno, "SecOFF"))
    Next i

    TipoDiProgrammazioneRiscaldamenti = String2Int(ParameterPlus.GetParameterValue("ProgrammazioneRiscaldamenti", "", "TIPO_DI_PROGRAMMAZIONE", "TIPO_DI_PROGRAMMAZIONE"))
    
End Sub

Public Function IsModifiedRiscaldamenti() As Boolean
    Dim i As Integer
    'Dim ProgrammazioneModificata As Boolean
    'Dim numero As Integer
    
    IsModifiedRiscaldamenti = True
    
    With FormProgRiscaldamentiCaldaie
    
        For i = 0 To 6
            
            If TimerProg(i).OraON <> .TextOraON(i) Then
                Exit Function
            End If
            
            If TimerProg(i).MinON <> .TextMinON(i) Then
                Exit Function
            End If
            
            If TimerProg(i).SecON <> .TextSecON(i) Then
                Exit Function
            End If
            
            If TimerProg(i).OraOFF <> .TextOraOFF(i) Then
                Exit Function
            End If
            
            If TimerProg(i).MinOFF <> .TextMinOFF(i) Then
                Exit Function
            End If
            
            If TimerProg(i).SecOFF <> .TextSecOFF(i) Then
                Exit Function
            End If
            
        Next i
    
        If TipoDiProgrammazioneRiscaldamenti <> .ComboTipoProg.ListIndex Then
            Exit Function
        End If
    
    End With
    
    IsModifiedRiscaldamenti = False

End Function

Public Sub SetProgrammazioneRiscaldamenti()
Dim i As Integer

On Error GoTo Errore

    If (Not Caldaia(0).AbilitazioneCaldaia) Then
        Exit Sub
    End If


    If Not CP240.OPCDataCisterne.IsConnected Or CP240.OPCDataCisterne.items.Count = 0 Then
        Exit Sub
    End If
    
    CP240.OPCDataCisterne.items.item(CistTAG_Sel_turni_settim_giorn).Value = TipoDiProgrammazioneRiscaldamenti
    
    For i = 0 To 6
        CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_ORA_SET + i * 6).Value = TimerProg(i).OraON
        CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_MINUTI_SET + i * 6).Value = TimerProg(i).MinON
        CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_SECONDI_SET + i * 6).Value = TimerProg(i).SecON
        CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_ORA_RESET + i * 6).Value = TimerProg(i).OraOFF
        CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_MINUTI_RESET + i * 6).Value = TimerProg(i).MinOFF
        CP240.OPCDataCisterne.items.item(CistTAG_TURNO_1_SECONDI_RESET + i * 6).Value = TimerProg(i).SecOFF
    Next i


    Exit Sub
Errore:
    LogInserisci True, "CLD-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SetInclusioneOrologio()
    If (Not Caldaia(0).AbilitazioneCaldaia) Then
        Exit Sub
    End If

    CP240.OPCDataCisterne.items.item(CistTAG_Inclusione_Orologio_Caldaie).Value = InclusioneOrologio
End Sub
