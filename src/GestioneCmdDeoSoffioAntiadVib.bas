Attribute VB_Name = "GestioneComandiVari"
Option Explicit

'   Struttura contenente tutte le informazioni di un comando
Public Type ComandoType
    
    presente As Boolean             'Indica se il comando è stato incluso nel FrmParametri
    
    Descrizione As String           'Contiene la descrizione del comando
    
    attivato As Boolean             'Indica se il comando è attivo, cioè se il controllo nel form avvio comandi è girato verso l'inclusione
    
    uscita As Boolean               'Indica se il comando da l'uscita
    
    ritornoComAux As Boolean              'Indica se il comando ha il ritorno
    
    termica As Boolean              'Indica se c'è la termica attiva
    
    oraStart As Long                'Ora in cui è stato dato lo start al motore
    
    tempoAttesaRitorno As Long      'Secondi di attesa del ritorno
    
    tempoStart As Long              'Secondi di start
    
    tempoStop As Long               'Secondi di stop
    
    AutoON As Boolean               'Flag per accendere il motore all'avvio automatico
    
    onStop As Boolean               'Flag per non spegnere il motore allo spegnimento automatico

End Type

Public Enum ComandiVariEnum

    ComandoSpruzzAntiadBenna = 0
    ComandoSpruzzAntiadNavetta              'al momento non è gestito -> sarebbe utile solo nel caso di doppia spruzzatura in un impianto con benna + navetta
    ComandoSiloFillerSoffioAriaRecupero
    ComandoSiloFillerSoffioAriaApporto
    ComandoSiloFillerSoffioAriaApporto2
    ComandoVibratoreSiloFillerApporto       '5
    ComandoVibratoreSiloFillerApporto2
    ComandoSiloFillerDeumid01
    ComandoSiloFillerDeumid02
    ComandoSiloFillerDeumid03
    ComandoFiller2Sacchi                   '10  '20151110  Filler2 RompiSacchi
    ComandoDisponibile11
    ComandoDisponibile12
    ComandoDisponibile13
    ComandoDisponibile14
    ComandoDisponibile15                    '15
    ComandoDisponibile16
    ComandoDisponibile17
    ComandoDisponibile18
    ComandoDisponibile19
    ComandoDisponibile20                    '20
    ComandoDisponibile21
    ComandoDisponibile22
    ComandoDisponibile23
    ComandoDisponibile24
    ComandoDisponibile25                    '25
    ComandoDisponibile26
    ComandoDisponibile27
    ComandoDisponibile28
    ComandoDisponibile29
        
    NumComandiVari

End Enum

Public ListaComandi(0 To NumComandiVari - 1) As ComandoType

Public ConteggioVibrCaricoFApp As Integer
Public SetVibrCaricoFApp As Integer
Public AbilitaTempoVibrCaricoFApp As Boolean
Public ConteggioVibrCaricoFApp2 As Integer
Public SetVibrCaricoFApp2 As Integer
Public AbilitaTempoVibrCaricoFApp2 As Boolean


Public ProcediRidotto As Boolean


Public Sub RitornoOkComandi()

    Dim i As ComandiVariEnum

    For i = 0 To NumComandiVari - 1
        If (ListaComandi(i).presente) Then
            VerificaComando i
        End If

    Next i

End Sub



Public Sub GestioneBottoniCmdVari(ByVal Index As ComandiVariEnum, alarmReset As Boolean)

    Dim Criterio As String
    Dim posizione As Integer
'    Dim i As Integer
'    Dim predosatore As Integer
'    Dim riciclato As Boolean

    If AvvComandi.APButtonCmdVari(Index).Value = 2 Then
        SetComandoUscita Index, True

        Select Case Index
            Case ComandoVibratoreSiloFillerApporto
                If AbilitaTempoVibrCaricoFApp Then
                    If (Not FrmGestioneTimer.TimerVibrCaricoFApp.enabled) Then
                        ConteggioVibrCaricoFApp = 0
                        FrmGestioneTimer.TimerVibrCaricoFApp.Interval = 1000
                        FrmGestioneTimer.TimerVibrCaricoFApp.enabled = True
                        AvvComandi.TxtTempoVibrCaricoFApp.enabled = False
                    End If
                End If
            Case ComandoVibratoreSiloFillerApporto2
                If AbilitaTempoVibrCaricoFApp2 Then
                    If (Not FrmGestioneTimer.TimerVibrCaricoFApp2.enabled) Then
                        ConteggioVibrCaricoFApp2 = 0
                        FrmGestioneTimer.TimerVibrCaricoFApp2.Interval = 1000
                        FrmGestioneTimer.TimerVibrCaricoFApp2.enabled = True
                        AvvComandi.TxtTempoVibrCaricoFApp2.enabled = False
                    End If
                End If
            Case ComandoFiller2Sacchi  '20150616 Filler2 RompiSacchi
                    Dim buttonPressed As Integer
                    If (CP240.OPCData.items(PLCTAG_ErrCond_SpaccFiller_F2).Value) Then
                        'condizioni errate per lo start
                        buttonPressed = MsgBox(LoadXLSString(1508), vbExclamation, "MARINI")
                        If (buttonPressed = vbCancel) Or (buttonPressed = vbOK) Then
                            SetComandoUscita Index, False
                            AvvComandi.APButtonCmdVari(Index).Value = 1
                            Exit Sub
                        End If
'                    Else
'                        'Cmd Start
'                        buttonPressed = MsgBox(LoadXLSString(1507), vbOKCancel + vbExclamation, "MARINI")
'                        If (buttonPressed = vbOK) Then
'                            Exit Sub
'                        End If
'                        If (buttonPressed = vbCancel) Then
'                            SetComandoUscita Index, False
'                            AvvComandi.APButtonCmdVari(Index).Value = 1
'                            Exit Sub
'                        End If
                    End If
        
        End Select
    Else
        SetComandoUscita Index, False

        Select Case Index
            Case ComandoVibratoreSiloFillerApporto
                If AbilitaTempoVibrCaricoFApp Then
                    ConteggioVibrCaricoFApp = 0
                    FrmGestioneTimer.TimerVibrCaricoFApp.enabled = False
                    AvvComandi.LblTempoRimastoVibrCaricoFApp.Visible = False
                    AvvComandi.TxtTempoVibrCaricoFApp.enabled = True
                End If
            Case ComandoVibratoreSiloFillerApporto2
                If AbilitaTempoVibrCaricoFApp2 Then
                    ConteggioVibrCaricoFApp2 = 0
                    FrmGestioneTimer.TimerVibrCaricoFApp2.enabled = False
                    AvvComandi.LblTempoRimastoVibrCaricoFApp2.Visible = False
                    AvvComandi.TxtTempoVibrCaricoFApp2.enabled = True
                End If
                '
        End Select
    End If

    If (alarmReset) Then
        '////////////////////////////////////////////////////////////
        Criterio = "AC" + Format(Index, "000")
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
        IngressoAllarmePresente posizione, False
        '////////////////////////////////////////////////////////////
        
    End If

End Sub


Private Sub ComandoUscita_change(comando As ComandiVariEnum)

    Dim Criterio As String
    Dim posizione As Integer

    With ListaComandi(comando)

        If (Not .presente) Then
            Exit Sub
        End If
        
        .oraStart = ConvertiTimer()
        If (.uscita And Not .ritornoComAux) Then
            If (.tempoAttesaRitorno = 0) Then
                .tempoAttesaRitorno = 3
            End If

            Criterio = "AC" + Format(comando, "000")
            posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
            IngressoAllarmePresente posizione, False
        End If

        If (.uscita Or .attivato) Then
            AvvComandi.APButtonCmdVari(comando).Value = 2
        Else
            AvvComandi.APButtonCmdVari(comando).Value = 1
        End If

        If (DEMO_VERSION) Then
            Call SetComandoRitorno(comando, .uscita)
        End If

    End With

End Sub


Public Sub SetComandoUscita(comando As ComandiVariEnum, uscita As Boolean)

    If (ListaComandi(comando).uscita <> uscita) Then
        ListaComandi(comando).uscita = uscita
        ComandoUscita_change (comando)
    End If

End Sub


Public Sub RitornoComando_change(comando As ComandiVariEnum)

    If (Not ListaComandi(comando).ritornoComAux) Then
        AvvComandi.APButtonCmdVari(comando).Value = 1
    End If

End Sub


Public Sub SetComandoRitorno(comando As ComandiVariEnum, ritorno As Boolean)

    On Error GoTo Errore

    If (ListaComandi(comando).ritornoComAux <> ritorno) Then
        ListaComandi(comando).ritornoComAux = ritorno
    End If

    Exit Sub
Errore:
    LogInserisci True, "CMD-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

'20150721
Public Sub VerificaTermicaComando(comando As ComandiVariEnum, valoretermica As Boolean)

    Dim Criterio As String
    Dim posizione As Integer
    
    If Not ListaComandi(comando).presente Then
        Exit Sub
    End If

    Criterio = "SA" + Format(comando, "000")
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")

    IngressoAllarmePresente posizione, valoretermica

    If valoretermica Then
        SetComandoUscita comando, False
        
        If comando = ComandoVibratoreSiloFillerApporto Then
            FrmGestioneTimer.TimerVibrCaricoFApp.enabled = False
            ConteggioVibrCaricoFApp = 0
        End If
        If comando = ComandoVibratoreSiloFillerApporto2 Then
            FrmGestioneTimer.TimerVibrCaricoFApp2.enabled = False
            ConteggioVibrCaricoFApp2 = 0
        End If
                    
        If AvvComandi.Visible Then
            AvvComandi.APButtonCmdVari(comando).Value = 3
        End If
    End If

End Sub
'

Public Function VerificaComando(comando As ComandiVariEnum) As Boolean

    Dim Criterio As String
    Dim posizione As Integer
    
    If Not ListaComandi(comando).presente Then
        Exit Function
    End If

    '20150616 Filler 2 Sacchi
    If (comando = ComandoFiller2Sacchi) Then
        If (CP240.OPCData.items(PLCTAG_ErrCond_SpaccFiller_F2).Value And ListaComandi(ComandoFiller2Sacchi).uscita) Then
            'se non ci sono le condizioni ed era acceso lo si spegne
            SetComandoUscita comando, False
        End If
        Exit Function
    End If
    'fine

    VerificaComando = True

    Criterio = "AC" + Format(comando, "000")
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")

    With ListaComandi(comando)

        If (.uscita And .ritornoComAux) Then

            .oraStart = 0
            IngressoAllarmePresente posizione, False

        ElseIf (Not .uscita And Not .ritornoComAux) Then

            .oraStart = 0

        ElseIf (.uscita And Not .ritornoComAux) Then

            If (ConvertiTimer() - .oraStart) > .tempoAttesaRitorno Then
                If (comando <> ComandoFiller2Sacchi) Then     '20151110
                    IngressoAllarmePresente posizione, True
                    VerificaComando = False
    
                     Call SetComandoUscita(comando, False)

                    If comando = ComandoVibratoreSiloFillerApporto Then
                        FrmGestioneTimer.TimerVibrCaricoFApp.enabled = False
                        ConteggioVibrCaricoFApp = 0
                    End If
                    If comando = ComandoVibratoreSiloFillerApporto2 Then
                        FrmGestioneTimer.TimerVibrCaricoFApp2.enabled = False
                        ConteggioVibrCaricoFApp2 = 0
                    End If

                End If          '20151110
            End If

        ElseIf (Not .uscita And .ritornoComAux) Then

            If (AvvComandi.APButtonCmdVari(comando).Value <> 3) Then
                AvvComandi.APButtonCmdVari(comando).Value = 3
            End If

        End If

    End With

End Function


Public Sub AvvioAutomaticoComandiAux()

Dim i As ComandiVariEnum
    
    For i = 0 To NumComandiVari - 1
        If ListaComandi(i).presente And ListaComandi(i).AutoON Then
            
            Select Case i
                Case ComandoVibratoreSiloFillerApporto
                    If AbilitaTempoVibrCaricoFApp Then
                        If (Not FrmGestioneTimer.TimerVibrCaricoFApp.enabled) Then
                            ConteggioVibrCaricoFApp = 0
                            FrmGestioneTimer.TimerVibrCaricoFApp.Interval = 1000
                            FrmGestioneTimer.TimerVibrCaricoFApp.enabled = True
                            AvvComandi.TxtTempoVibrCaricoFApp.enabled = False
                        End If
                    End If
                Case ComandoVibratoreSiloFillerApporto2
                    If AbilitaTempoVibrCaricoFApp2 Then
                        If (Not FrmGestioneTimer.TimerVibrCaricoFApp2.enabled) Then
                            ConteggioVibrCaricoFApp2 = 0
                            FrmGestioneTimer.TimerVibrCaricoFApp2.Interval = 1000
                            FrmGestioneTimer.TimerVibrCaricoFApp2.enabled = True
                            AvvComandi.TxtTempoVibrCaricoFApp2.enabled = False
                        End If
                    End If
            Case Else
                SetComandoUscita i, True
            End Select

        End If
    Next i

End Sub


'questa routine di gestione dei vibratori viene chiamata quando si abilitano i vibratori, sul cambio del vuoto
Public Sub GestioneVibratoriESoffi(NumPred As Integer, riciclato As Boolean)
        
Dim predosatoreAppoggio As PredosatoreType  'predosatore fittizio a cui viene associato in un caso il predosatore normale e nell'altro quello del riciclato

    If riciclato Then
        predosatoreAppoggio = ListaPredosatoriRic(NumPred)
    Else
        predosatoreAppoggio = ListaPredosatori(NumPred)
    End If

    If predosatoreAppoggio.abilitazioneVibratore Then           'se ho l'abilitazione del vibratore effettuata tramite il pulsante da FrmStatoPredosatori procedo
        If predosatoreAppoggio.abilitaSuVuotoVibratore Then     'controllo la condizione di abilita su vuoto
        
            predosatoreAppoggio.tempoVuotoOnVibratore = 0
            predosatoreAppoggio.tempoVuotoOffVibratore = 0
            If (predosatoreAppoggio.vuoto And predosatoreAppoggio.motore.ritorno) Then       'se il predosatore ha il vuoto ed è acceso
                predosatoreAppoggio.tempoVuotoOnVibratore = ConvertiTimer()
            Else
                predosatoreAppoggio.tempoVuotoOffVibratore = ConvertiTimer()
            End If
    
            FrmGestioneTimer.TmrVibratorePredVuoto.enabled = True
            
            If riciclato Then   'riassegno al predosatore reale le proprietà del fittizio
                ListaPredosatoriRic(NumPred) = predosatoreAppoggio
            Else
                ListaPredosatori(NumPred) = predosatoreAppoggio
            End If
            
        Else    'in caso non ci sia la spunta di abilita su vuoto, alla pressione del pulsante abilito subito il vibratore
            If riciclato Then
                ListaPredosatoriRic(NumPred).vibratoreAbilitato = True
            Else
                ListaPredosatori(NumPred).vibratoreAbilitato = True
            End If
        End If
    End If
    If predosatoreAppoggio.abilitazioneSoffio Then      'se ho l'abilitazione del soffio effettuata tramite il pulsante da FrmStatoPredosatori procedo
        If predosatoreAppoggio.abilitaSuVuotoVibratore Then     'controllo la condizione di abilita su vuoto
            
            predosatoreAppoggio.tempoVuotoOnSoffio = 0
            predosatoreAppoggio.tempoVuotoOffSoffio = 0
            If (predosatoreAppoggio.vuoto And predosatoreAppoggio.motore.ritorno) Then       'se il predosatore ha il vuoto ed è acceso
                predosatoreAppoggio.tempoVuotoOnSoffio = ConvertiTimer()
            Else
                predosatoreAppoggio.tempoVuotoOffSoffio = ConvertiTimer()
            End If
            
            FrmGestioneTimer.TmrSoffioPredVuoto.enabled = True
            
            ListaPredosatoriRic(NumPred) = predosatoreAppoggio
            
        Else    'in caso non ci sia la spunta di abilita su vuoto, alla pressione del pulsante abilito subito il vibratore
            
            ListaPredosatoriRic(NumPred).soffioAbilitato = True
            
        End If
    End If
    
End Sub


'questa routine fa partire subito i vibratori in caso sia selezionata la spunta di AutoON
Public Sub AutoOnVibratoriPredosatori()
    
Dim i As Integer

    For i = 0 To NumeroPredosatoriInseriti - 1
        If ListaPredosatori(i).vibratorePresente And ListaPredosatori(i).autoOnVibratore Then
            ListaPredosatori(i).abilitazioneVibratore = True
        End If
    Next i
    For i = 0 To NumeroPredosatoriRicInseriti - 1
        If ListaPredosatoriRic(i).vibratorePresente And ListaPredosatoriRic(i).autoOnVibratore Then
            ListaPredosatoriRic(i).abilitazioneVibratore = True
        End If
        If ListaPredosatoriRic(i).soffioPresente And ListaPredosatoriRic(i).autoOnVibratore Then
            ListaPredosatoriRic(i).abilitazioneSoffio = True
        End If
    Next i
End Sub
'
