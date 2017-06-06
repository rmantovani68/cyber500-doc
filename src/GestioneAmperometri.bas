Attribute VB_Name = "GestioneAmperometri"
Option Explicit


Public Enum AmperometroEnum
    AmperometroMotore1
    AmperometroMotore2
    AmperometroMotore3
    AmperometroAspiratoreFiltro
    AmperometroMescolatore_1
    AmperometroMotore6
    AmperometroVaglio_1
    AmperometroElevatoreCaldo
    AmperometroMotore9
    AmperometroElevatoreFiller
    AmperometroMotore11
    AmperometroMotore12
    AmperometroMotore13
    AmperometroMotore14
    AmperometroMotore15
    AmperometroMotore16
    AmperometroEssicatore_1
    AmperometroMotore18
    AmperometroVentolaBruciatore
    AmperometroMotore20
    AmperometroMotore21
    AmperometroMotore22
    AmperometroMotore23
    AmperometroMotore24
    AmperometroMotore25
    AmperometroArganoBenna
    AmperometroMotore27
    AmperometroElevatoreRiciclato
    AmperometroMotore29
    AmperometroMotore30
    AmperometroMotore31
    AmperometroMotore32
    AmperometroMotore33
    AmperometroMotore34
    AmperometroMotore35
    AmperometroMotore36
    AmperometroMotore37
    AmperometroMotore38
    AmperometroEssicatore2_1
    AmperometroMotore40
    AmperometroMotore41
    AmperometroMotore42
    AmperometroMotore43
    AmperometroMotore44
    AmperometroMotore45
    AmperometroMotore46
    AmperometroMotore47
    AmperometroMotore48
    AmperometroMotore49
    AmperometroMotore50
    AmperometroMotore51
    AmperometroMotore52
    AmperometroMotore53
    AmperometroMotore54
    AmperometroMotore55
    AmperometroMotore56
    AmperometroMotore57
    AmperometroMotore58
    AmperometroMotore59
    AmperometroMotore60
    AmperometroMotore61
    AmperometroMotore62
    AmperometroMotore63
    AmperometroMotore64
    AmperometroMotore65
    AmperometroMotore66
    AmperometroMotore67
    AmperometroMotore68
    AmperometroMotore69
    AmperometroMotore70
    AmperometroMotore71
    AmperometroMotore72
    AmperometroMotore73
    AmperometroMotore74
    AmperometroMotore75
    AmperometroMotore76
    AmperometroMotore77
    AmperometroMotore78
    AmperometroMotore79
    AmperometroMotore80
    AmperometroMotore81
    AmperometroMotore82
    AmperometroMotore83
    AmperometroMotore84
    AmperometroMotore85
    AmperometroMotore86
    AmperometroMotore87
    AmperometroMotore88
    AmperometroMotore89
    AmperometroMotore90
    AmperometroMotore91
    AmperometroMotore92
    AmperometroMotore93
    AmperometroMotore94
    AmperometroMotore95
    AmperometroMotore96
    AmperometroMotore97
    AmperometroMotore98
    AmperometroMotore99
    'ausiliari
    AmperometroMescolatore_2
    AmperometroEssicatore_2
    AmperometroEssicatore_3
    AmperometroEssicatore_4
    AmperometroVaglio_2
    AmperometroEssicatore2_2
    AmperometroEssicatore2_3
    AmperometroEssicatore2_4
    AmperometroVentolaBruciatore2
    MAXAMPEROMETRI

End Enum

'20160411
Private Const MAXFILTROAMPEROMETRI As Integer = 5
'

Public Type AmperometroType

    inclusione As Boolean
    valore As Integer
    max As Double  '2141013
    sogliaMax As Double  '2141013
    sogliaMin As Double  '2141013

    '20160412
    filtroIncluso As Boolean
    letturaAttivaFiltro As Integer
    arrayFiltro(0 To MAXFILTROAMPEROMETRI - 1) As Integer
    '

    '20160915
    'Configura il tipo di amperometro per Darwin
    XTUA As Integer
    '

End Type

Public ListaAmperometri(0 To (MAXAMPEROMETRI - 1)) As AmperometroType


'I limiti sono real mentre il valore è int ->serve un cast nel confronto
Public Sub ValoreAmperometri_change(amp As Integer)

    On Error GoTo Errore
    
    Dim amperometro As Integer
    amperometro = amp + 1

    With ListaAmperometri(amp)

        CP240.LblAmp(amperometro).caption = .valore

        If (.valore < CInt(.sogliaMax)) Then
            '   MINIMO
            CP240.LblAmp(amperometro).BackColor = &H80FFFF   'vbGreen
        Else
            '   MASSIMO
            CP240.LblAmp(amperometro).BackColor = vbRed
        End If

        '   INTERMEDIO
        Select Case amp
            Case AmperometroMescolatore_1, AmperometroMescolatore_2, AmperometroArganoBenna
                If (.valore >= CInt(.sogliaMin) And .valore < CInt(.sogliaMax)) Then
                    CP240.LblAmp(amperometro).BackColor = &H80FF&       'Arancio
                End If
        End Select

    End With

    Call ValoreAmperometriBar_change(amp)

'20151106
'    If ( _
'        Not BennaPiena And (Not ListaAmperometri(AmperometroArganoBenna).inclusione And _
'        (ListaAmperometri(AmperometroArganoBenna).valore > ListaAmperometri(AmperometroArganoBenna).sogliaMin)) _
'        ) Then
    If ( _
        Not BennaPiena And (ListaAmperometri(AmperometroArganoBenna).inclusione And _
        (ListaAmperometri(AmperometroArganoBenna).valore > ListaAmperometri(AmperometroArganoBenna).sogliaMin)) _
        ) Then
'
        FrmGestioneTimer.TimerBennaPiena.enabled = True
    End If
    '

    If ( _
        (Not ListaAmperometri(AmperometroMescolatore_1).inclusione Or _
        (ListaAmperometri(AmperometroMescolatore_1).valore < ListaAmperometri(AmperometroMescolatore_1).sogliaMin)) And _
        (Not ListaAmperometri(AmperometroMescolatore_2).inclusione Or _
        (ListaAmperometri(AmperometroMescolatore_2).inclusione And ListaAmperometri(AmperometroMescolatore_2).valore < ListaAmperometri(AmperometroMescolatore_2).sogliaMin)) _
    ) Then
    '
        FrmGestioneTimer.TimerMixerPieno.enabled = False
        MixerCaricoPerBenna = False
    Else
        FrmGestioneTimer.TimerMixerPieno.enabled = True
    End If

    Exit Sub
Errore:
    LogInserisci True, "AMP-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub ValoreAmperometriBar_change(amp As Integer)
    Dim amperometro As Integer
    amperometro = amp + 1
    On Error GoTo Errore

    With ListaAmperometri(amp)

        CP240.ProgressAmp(amperometro).min = 0
        CP240.ProgressAmp(amperometro).max = .max
'        CP240.ProgressAmp(amperometro).FillDirection = fdBottomUp
'        CP240.ProgressAmp(amperometro).Visible = .inclusione
        
        If (.valore >= .sogliaMin And .valore < .sogliaMax) And (.sogliaMin > 0) Then
            '   INTERMEDIO
            CP240.ProgressAmp(amperometro).FillColor = &H80FF&       'Arancio
        ElseIf (.valore < .sogliaMax) Then
            '   MINIMO
            CP240.ProgressAmp(amperometro).FillColor = &H8000&        'vbGreen
        Else
            '   MASSIMO
            CP240.ProgressAmp(amperometro).FillColor = vbRed
        End If
                
'        CP240.ProgressAmp(amperometro).caption = .valore
        CP240.ProgressAmp(amperometro).caption = ""
        CP240.ProgressAmp(amperometro).Value = .valore

    End With

    Exit Sub
Errore:
    LogInserisci True, "AMP-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


'20160412
Public Function FiltroAmperometro(amp As Integer, Value As Integer) As Integer

    Dim Index As Integer
    Dim sumValue As Integer

    On Error GoTo Errore

    With ListaAmperometri(amp)

        If (Not .filtroIncluso) Then
            FiltroAmperometro = Value
            Exit Function
        End If

        .arrayFiltro(.letturaAttivaFiltro) = Value

        .letturaAttivaFiltro = .letturaAttivaFiltro + 1
        If (.letturaAttivaFiltro > MAXFILTROAMPEROMETRI - 1) Then
            .letturaAttivaFiltro = 0
        End If

        sumValue = 0
        For Index = 0 To MAXFILTROAMPEROMETRI - 1
            sumValue = sumValue + .arrayFiltro(Index)
        Next Index
        FiltroAmperometro = CInt(sumValue / MAXFILTROAMPEROMETRI)

    End With

    Exit Function
Errore:
    LogInserisci True, "AMP-003", CStr(Err.Number) + " [" + Err.description + "]"
End Function

