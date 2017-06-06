Attribute VB_Name = "GestioneLCPC"
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&                &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&      LCPC      &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&                &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


Option Explicit

Public Const LCPCmsg As String = "LCPC"
Public PortaComLCPC As Integer
Public InclusioneLCPC As Boolean
Public InclusioneWindQual As Boolean
Public FuoriTolleranza As Integer
Public TempoTotaleCiclo As Long
Public TempoMixSecca(1) As Double
Public TempoMixUmida(1) As Double
Public TempoMescolazUmida As String
Public TempoMixTotale(1) As Double
'Public MixerChiuso As Boolean


'------- FRANCIA -------
Private TrameRecu As String
Private Pacchetto5sec As String
Private FlagAmman As Boolean
Private gFlagTypeDeCRC As Integer
Private gDebutTrame As Boolean
Private Pos_Pacchetto5sec As Integer
'------- FRANCIA -------



Public Function CambiaChar(Stringa As String, CharOLD As String, CharNEW As String) As String
'Sostituisce all'interno della Stringa il CharOLD con CharNEW
Dim i As Integer
    
    For i = 1 To Len(Stringa)
        If Mid(Stringa, i, 1) = CharOLD Then
            CambiaChar = CambiaChar + CharNEW
        Else
            CambiaChar = CambiaChar + Mid(Stringa, i, 1)
        End If
    Next i

End Function


Public Function CreaCRC(Pacchetto As String) As String
    
    CreaCRC = Format(CRC16(Pacchetto), "00000")

End Function

Function CRC16(s As String) As Long
Dim i As Integer
Dim j As Integer
    
    CRC16 = 65535
    For i = 1 To Len(s)
        CRC16 = CRC16 Xor Asc(Mid(s, i, 1))
        For j = 0 To 7
            If (CRC16 And 1) Then
                CRC16 = CRC16 \ 2
                CRC16 = CRC16 Xor 40961
            Else
                CRC16 = CRC16 \ 2
            End If
        Next j
    Next i

End Function

Public Sub AttivaTimerLCPC()
    
'    If Not InclusioneLCPC Then
'        FrmGestioneTimer.TimerLCPC5sec.enabled = False
'        FrmGestioneTimer.TimerLCPC1sec.enabled = False
'        CP240.StatusBar1.Panels(STB_LCPC).text = ""
'        Exit Sub
'    End If
'
'    CP240.LCPC.CommPort = PortaComLCPC
'    If Not CP240.LCPC.IsPortOpen Then
'        CP240.LCPC.OpenPort
'    End If
'
'
'    If Not FrmGestioneTimer.TimerLCPC5sec.enabled Then
'        FrmGestioneTimer.TimerLCPC5sec.enabled = True
'    End If
'
'    If DosaggioInCorso Then
'        If Not FrmGestioneTimer.TimerLCPC1sec.enabled Then
'            FrmGestioneTimer.TimerLCPC1sec.enabled = True
'        End If
'    Else
'        If FrmGestioneTimer.TimerLCPC1sec.enabled Then
'            FrmGestioneTimer.TimerLCPC1sec.enabled = False
'        End If
'    End If
    
    
    
End Sub

Public Sub VisualizzaStatoLCPC(stato As Boolean)

'20161018
'    If (stato) Then
'        CP240.StatusBar1.Panels(STB_LCPC).text = LCPCmsg + " " + LoadXLSString(801)
'    Else
'        CP240.StatusBar1.Panels(STB_LCPC).text = LCPCmsg + " " + LoadXLSString(805)
'    End If
    Call CP240StatusBar_Change(STB_LCPC, IIf(InclusioneLCPC, stato, 99))
'

End Sub

Public Function LCPC_ZERO(s As String) As String

    If s = "000.0" Or s = "000,0" Then
        LCPC_ZERO = "00000"
    Else
        LCPC_ZERO = CambiaChar(s, ",", ".")
    End If
    
End Function

Public Function CreaPacchetto5sec() As String
Dim AppPredON As String
Dim AppPred_Kg_m As String
Dim AppPred_m_min As String
Dim AppUmidita As String
Dim AppPortata As String
Dim i As Integer

    For i = 0 To MAXPREDOSATORI - 1
        If ListaPredosatori(i).motore.ritorno Then
            AppPredON = AppPredON + Format(i + 1, "00")
            AppPred_Kg_m = AppPred_Kg_m + Calcola_Kg_m(i)
            AppPred_m_min = AppPred_m_min + Calcola_m_min(i)
            AppUmidita = AppUmidita + CambiaChar(Format(ListaPredosatori(i).Umidita, "000.0"), ",", ".")
            If ListaPredosatori(i).bilanciaPresente Then
                'Hanno la siwarex
                AppPortata = AppPortata + CambiaChar(Format((ListaPredosatori(i).portataBilancia), "000.0"), ",", ".")
            Else
                'Calcolo volumetrico
                AppPortata = AppPortata + CalcolaTh(PredosatoreOttieniSet(False, i), RoundNumber(PesoBilanciaInerti, 0))
            End If
            '
        End If
    Next i
    For i = 1 To ((40 - Len(AppPortata)) / 5)
        AppPredON = AppPredON + "00"
        AppPred_Kg_m = AppPred_Kg_m + "000.0"
        AppPred_m_min = AppPred_m_min + "000.0"
        AppUmidita = AppUmidita + "00000"
        AppPortata = AppPortata + "000.0"
    Next i
    For i = 0 To MAXPREDOSATORIRICICLATO - 1
        If ListaPredosatoriRic(i).motore.ritorno Then
            AppPredON = AppPredON + Format(i + 1, "00")
            AppPred_Kg_m = AppPred_Kg_m + Calcola_Kg_m(i + 100)
            AppPred_m_min = AppPred_m_min + Calcola_m_min(i + 100)
            AppUmidita = AppUmidita + Format(ListaPredosatoriRic(i).Umidita, "00000")
            AppPortata = AppPortata + Format(CalcolaTh(PredosatoreOttieniSet(True, i), RoundNumber(PesoBilanciaRiciclato, 0)), "00000")
        End If
    Next i
    For i = 1 To ((55 - Len(AppPortata)) / 5)
        AppPredON = AppPredON + "00"
        AppPred_Kg_m = AppPred_Kg_m + "000.0"
        AppPred_m_min = AppPred_m_min + "000.0"
        AppUmidita = AppUmidita + "00000"
        AppPortata = AppPortata + "000.0"
    Next i
    
    CreaPacchetto5sec = ""
    
    '01
    CreaPacchetto5sec = CreaPacchetto5sec + "P" + ","      'Fisso
    '02
    CreaPacchetto5sec = CreaPacchetto5sec + Format(Null2zero(CP240.LblNumRicPred.caption), "0000") + ","    'N° ricetta
    '03-04-05
    CreaPacchetto5sec = CreaPacchetto5sec + Format(time, "hh,mm,ss") + ","      'Ora
    '06-07
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 1, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 1, 5)) + ","
    '08-09
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 3, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 6, 5)) + ","
    '10-11
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 5, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 11, 5)) + ","
    '12-13
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 7, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 16, 5)) + ","
    '14-15
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 9, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 21, 5)) + ","
    '16-17
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 11, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 26, 5)) + ","
    '18-19
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 13, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 31, 5)) + ","
    '20-21
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 15, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 36, 5)) + ","
    '22-23
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 17, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 41, 5)) + ","
    '24-25
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 19, 2) + "," + LCPC_ZERO(Mid(AppPred_Kg_m, 46, 5)) + ","
    '26
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '27
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '28
    CreaPacchetto5sec = CreaPacchetto5sec + LCPC_ZERO(ConvertiTh2Kgm(RoundNumber(PesoBilanciaInerti, 0))) + ","
    '29
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '30-31
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 1, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 1, 5)) + ","
    '32-33
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 3, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 6, 5)) + ","
    '34-35
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 5, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 11, 5)) + ","
    '36-37
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 7, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 16, 5)) + ","
    '38-39
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 9, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 21, 5)) + ","
    '40-41
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 11, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 26, 5)) + ","
    '42-43
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 13, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 31, 5)) + ","
    '44-45
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 15, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 36, 5)) + ","
    '46-47
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 17, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 41, 5)) + ","
    '48-49
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 19, 2) + "," + LCPC_ZERO(Mid(AppPred_m_min, 46, 5)) + ","
    '50
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '51
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '52
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '53
    If ListaMotori(MotoreNastroCollettore1).ritorno Then
        CreaPacchetto5sec = CreaPacchetto5sec + "129.3" + ","      'Velocità m/min del nastro el. freddo
    Else
        CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","      'Velocità m/min del nastro el. freddo
    End If
    '54
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '55
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '56
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '57
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '58
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '59
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '60-61
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 1, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 1, 5)) + ","
    '62-63
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 3, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 6, 5)) + ","
    '64-65
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 5, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 11, 5)) + ","
    '66-67
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 7, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 16, 5)) + ","
    '68-69
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 9, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 21, 5)) + ","
    '70-71
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 11, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 26, 5)) + ","
    '72-73
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 13, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 31, 5)) + ","
    '74-75
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 15, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 36, 5)) + ","
    '76-77
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 17, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 41, 5)) + ","
    '78-79
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 19, 2) + "," + LCPC_ZERO(Mid(AppUmidita, 46, 5)) + ","
    '80
    CreaPacchetto5sec = CreaPacchetto5sec + CambiaChar(Format(PredosatoriCalcoloUmiditaTotale(True), "000.0"), ",", ".") + ","    'Umidita media
    '81
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '82
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '83
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '84
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '85
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '86
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '87
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '88
    CreaPacchetto5sec = CreaPacchetto5sec + CambiaChar(Format(CInt(LimitaValore(ListaTamburi(0).temperaturaScivolo, 0, 300)), "000.0"), ",", ".") + "," 'Temp. Scivolo
    '89-90-91
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 1, 2) + "," + LCPC_ZERO(Mid(AppPortata, 1, 5)) + ",230" + ","
    '92-93-94
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 3, 2) + "," + LCPC_ZERO(Mid(AppPortata, 6, 5)) + ",230" + ","
    '95-96-97
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 5, 2) + "," + LCPC_ZERO(Mid(AppPortata, 11, 5)) + ",230" + ","
    '98-99-100
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 7, 2) + "," + LCPC_ZERO(Mid(AppPortata, 16, 5)) + ",230" + ","
    '101-102-103
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 9, 2) + "," + LCPC_ZERO(Mid(AppPortata, 21, 5)) + ",230" + ","
    '104-105-106
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 11, 2) + "," + LCPC_ZERO(Mid(AppPortata, 26, 5)) + ",180" + ","
    '107-108-109
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 13, 2) + "," + LCPC_ZERO(Mid(AppPortata, 31, 5)) + ",180" + ","
    '110-111-112
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 15, 2) + "," + LCPC_ZERO(Mid(AppPortata, 36, 5)) + ",180" + ","
    '113-114-115
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 17, 2) + "," + LCPC_ZERO(Mid(AppPortata, 41, 5)) + ",180" + ","
    '116-117-118
    CreaPacchetto5sec = CreaPacchetto5sec + Mid(AppPredON, 19, 2) + "," + LCPC_ZERO(Mid(AppPortata, 46, 5)) + ",180" + ","
    '119
    CreaPacchetto5sec = CreaPacchetto5sec + "00120" + ","       'Tempo percorrenza riciclato
    '120
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '121
    CreaPacchetto5sec = CreaPacchetto5sec + CambiaChar(Format(PesoBilanciaInerti, "000.0"), ",", ".") + "," 'Ramsey Inerti
    '122
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '123
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '124
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '125
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '126
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '127
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '128
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '129
    CreaPacchetto5sec = CreaPacchetto5sec + CambiaChar(Format(val(CP240.LblTonOrarie.caption), "000.0"), ",", ".") + ","   'Ramsey Inerti
    '130
    CreaPacchetto5sec = CreaPacchetto5sec + CambiaChar(Format(TonOrarieAttualiImpianto, "000.0"), ",", ".") + "," 'Ramsey Inerti
    '131
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '132
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '133
    If StartPredosatori Then
        CreaPacchetto5sec = CreaPacchetto5sec + "1" + ","
    Else
        CreaPacchetto5sec = CreaPacchetto5sec + "0" + ","
    End If
    '134
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '135
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '136
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '137
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '138
    CreaPacchetto5sec = CreaPacchetto5sec + "0" + ","       'Formula Vagliata -NO MARINI
    '139
    CreaPacchetto5sec = CreaPacchetto5sec + "0" + ","       'Silo Stoccaggio -NO MARINI
    '140
    CreaPacchetto5sec = CreaPacchetto5sec + "00000" + ","       'RISERVATO
    '141-142-143
    CreaPacchetto5sec = CreaPacchetto5sec + Format(Date, "dd,mm,yyyy") + ","        'Data
    '144
    CreaPacchetto5sec = CreaPacchetto5sec + CreaCRC(CreaPacchetto5sec) + vbCrLf       'CRC
    
    'Debug.Print CreaPacchetto5sec
    'CreaPacchetto5sec = "P,0000,09,41,50,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00000,00000,00000,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00000,00000,00000,102.0,00000,00000,00000,00000,00000,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00,00000,000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,0,00000,00000,00000,00000,0,0,00000,19,01,2007,55239" + vbCr
    
    '------- FRANCIA -------
    TrameRecu = ""
    Pacchetto5sec = CreaPacchetto5sec
    FlagAmman = False
    gFlagTypeDeCRC = 1
    Pos_Pacchetto5sec = 0
    gDebutTrame = True
    '------- FRANCIA -------
    
End Function

Public Function CreaPacchetto1sec() As String
Dim AppoggioB1 As Double
Dim AppoggioB2 As Double
Dim TotaleInertiWQ As Long
Dim i As Integer

    If DosaggioLeganti(0).set > 0 Then
        AppoggioB1 = RoundNumber((CDbl(BilanciaLegante.Peso) / (DosaggioLeganti(0).set + DosaggioLeganti(1).set) * DosaggioLeganti(0).set), 1)
    Else
        AppoggioB1 = 0
    End If
    If DosaggioLeganti(1).set > 0 Then
        AppoggioB2 = RoundNumber((CDbl(BilanciaLegante.Peso) / (DosaggioLeganti(0).set + DosaggioLeganti(1).set) * DosaggioLeganti(1).set), 1)
    Else
        AppoggioB2 = 0
    End If
    If AppoggioB1 < 0 Then
        AppoggioB1 = 0
    End If
    If AppoggioB2 < 0 Then
        AppoggioB2 = 0
    End If
    
    CreaPacchetto1sec = ""
    
    '01
    CreaPacchetto1sec = CreaPacchetto1sec + "PC" + ","      'Fisso
    '02
    CreaPacchetto1sec = CreaPacchetto1sec + Format(Null2zero(CP240.AdoDosaggioScarico.Recordset.Fields("IdDosaggio").Value), "0000") + ","    'N° ricetta
    '03-04-05
    CreaPacchetto1sec = CreaPacchetto1sec + Format(time, "hh,mm,ss") + ","      'Ora
    For i = 0 To 8
        TotaleInertiWQ = TotaleInertiWQ + NettoAgg(i)
    Next i
    TotaleInertiWQ = TotaleInertiWQ - NettoAgg(6)
        If DeflettoreSuVagliato Then
            CreaPacchetto1sec = CreaPacchetto1sec + "01," + Format(NettoAgg(5), "00000") + ","    'Netto tramoggia NV o sabbia
        Else
            CreaPacchetto1sec = CreaPacchetto1sec + "01," + Format(NettoAgg(7), "00000") + ","    'Netto tramoggia NV o sabbia
        End If
        CreaPacchetto1sec = CreaPacchetto1sec + "02," + Format(NettoAgg(4), "00000") + ","     'Netto tramoggia fine 1
        CreaPacchetto1sec = CreaPacchetto1sec + "03," + Format(NettoAgg(3), "00000") + ","     'Netto tramoggia fine 2
        CreaPacchetto1sec = CreaPacchetto1sec + "04," + Format(NettoAgg(2), "00000") + ","     'Netto tramoggia medio 1
        CreaPacchetto1sec = CreaPacchetto1sec + "05," + Format(NettoAgg(1), "00000") + ","     'Netto tramoggia medio 2
        CreaPacchetto1sec = CreaPacchetto1sec + "06," + Format(NettoAgg(0), "00000") + ","     'Netto tramoggia grosso
    'End If
    '18
    CreaPacchetto1sec = CreaPacchetto1sec + Format(CInt(LimitaValore(CLng(BilanciaAggregati.Peso), 0, 5000)), "00000") + ","   'Bilancia Aggregati
    '19
    CreaPacchetto1sec = CreaPacchetto1sec + Format(CInt(LimitaValore(CLng(BilanciaRAPSiwa.Peso), 0, 5000)), "00000") + ","   'Bilancia RAPSiwa
    '20-21
    CreaPacchetto1sec = CreaPacchetto1sec + "00000,000" + ","    'Bilancia fresato caldo - NO MARINI
    '22
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(NettoFiller(0), "000.0"), ",", ".") + ","     'Netto F1
    '23
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(NettoFiller(1), "000.0"), ",", ".") + ","     'Netto F2
    '24
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(NettoFiller(2), "000.0"), ",", ".") + ","     'Netto F3
    '25
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(CInt(LimitaValore(CLng(BilanciaFiller.Peso), 0, 1000)), "000.0"), ",", ".") + "," 'Bilancia Filler
    '26-27
    CreaPacchetto1sec = CreaPacchetto1sec + "01," + left(Format(DosaggioLeganti(0).setCalcolato, "000.0"), 3) + "." + Right(Format(DosaggioLeganti(0).setCalcolato, "000.0"), 1) + ","  'Set Bitume 1
    '28-29
    CreaPacchetto1sec = CreaPacchetto1sec + "02," + left(Format(DosaggioLeganti(1).setCalcolato, "000.0"), 3) + "." + Right(Format(DosaggioLeganti(1).setCalcolato, "000.0"), 1) + "," 'Set Bitume 2
    '30-31
    CreaPacchetto1sec = CreaPacchetto1sec + "01,00000" + ","    'Peso additivo solido 01-99
    '32-33
    CreaPacchetto1sec = CreaPacchetto1sec + "02,00000" + ","    'Peso additivo solido 01-99
    '34
    CreaPacchetto1sec = CreaPacchetto1sec + "01" + ","
    '35
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(CInt(LimitaValore(CLng(BilanciaLegante.Peso), 0, 1000)), "000.0"), ",", ".") + "," 'Peso Bilacia Legante 1
    '36-37
    CreaPacchetto1sec = CreaPacchetto1sec + "02,00000" + ","    'Peso legante 2
    '38-39-40
    CreaPacchetto1sec = CreaPacchetto1sec + Format(CInt(CP240.LblAddSacchi(0).caption), "00") + ",01," + Format(CInt(CP240.LblAddSacchi(0).caption), "00") + ","    'Add. Sacchi 1
    '41-42-43
    CreaPacchetto1sec = CreaPacchetto1sec + "00,00,00" + ","    'NO MARINI
    '44
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(CP240.LblAdd(2).caption, "00.00"), ",", ".") + ","      'Peso additivo liquido 1 mixer
    '45
    CreaPacchetto1sec = CreaPacchetto1sec + CambiaChar(Format(CP240.LblAdd(3).caption, "00.00"), ",", ".") + ","      'Peso additivo liquido 2 bacinella
    '46-47
    CreaPacchetto1sec = CreaPacchetto1sec + Format(DBScambioDatiCisterneBitume.CisternaSelezioneAttuale, "00") + "," + Format(ListaTemperature(TempLegante1Pompa).valore, "00000") + ","    'Temperatura Bitume 1
    '48-49
    CreaPacchetto1sec = CreaPacchetto1sec + "09," + Format(ListaTemperature(TempLegante2Pompa).valore, "00000") + "," 'Temperatura Bitume 2
    '50
    CreaPacchetto1sec = CreaPacchetto1sec + Format(TotaleProdotto, "00000") + ","       'Kg Impasto Mixer
    '51
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'Impulsi Contalitri Bitume - NO MARINI
    '52
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '53
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '54
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '55
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '56
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '57
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '58
    CreaPacchetto1sec = CreaPacchetto1sec + "00000" + ","       'RISERVATO
    '59-60-61
    CreaPacchetto1sec = CreaPacchetto1sec + Format(Date, "dd,mm,yyyy") + ","        'Data
    '62
    CreaPacchetto1sec = CreaPacchetto1sec + CreaCRC(CreaPacchetto1sec) + vbCrLf        'CRC
    
End Function

Public Function CalcolaTh(Ramsey As Integer, SetPerc As Integer) As String
    
    CalcolaTh = Format(Ramsey * SetPerc \ 100, "000") + "." + left(Ramsey * SetPerc Mod 100, 1)

End Function

Public Function Calcola_Kg_m(NumPred As Integer) As String
Dim AppRamsey As Double
Dim AppSet As Double
Dim AppPortata As Double
Dim Estrazione As Double
Dim Calcolo1 As Double
Dim Calcolo2 As Double
            
    If NumPred < 99 Then
        AppRamsey = PesoBilanciaInerti
        AppSet = PredosatoreOttieniSet(False, NumPred)
        AppPortata = ListaPredosatori(NumPred).PortataMax
    Else
        AppRamsey = PesoBilanciaRiciclato
        AppSet = CP240.TxtPredRicSet(NumPred - 100).text
        AppPortata = ListaPredosatoriRic(NumPred - 100).PortataMax
    End If
    Estrazione = 20 * 0.685     '20 giri al minuto del rullo di testa del predosatore * 0,685 metri di nastro ogni giro
    
    If AppPortata = 0 Then
        Calcola_Kg_m = "000.0"
    Else
        Calcolo1 = AppRamsey * AppSet * 10
        Calcolo2 = (AppRamsey * AppSet * Estrazione * 60) / (AppPortata * 100)
        If Calcolo2 = 0 Then
            Calcola_Kg_m = "000.0"
        Else
            Calcola_Kg_m = Format(Calcolo1 \ Calcolo2, "000") + "." + left(Calcolo1 Mod Calcolo2, 1)
        End If
    End If

End Function

Public Function Calcola_m_min(NumPred As Integer) As String
Dim AppRamsey As Double
Dim AppSet As Double
Dim AppPortata As Double
Dim Estrazione As Double
Dim Calcolo1 As Double
Dim Calcolo2 As Double
            
    If NumPred < 99 Then
        AppRamsey = PesoBilanciaInerti
        AppSet = PredosatoreOttieniSet(False, NumPred)
        AppPortata = ListaPredosatori(NumPred).PortataMax
    Else
        AppRamsey = PesoBilanciaRiciclato
        AppSet = CP240.TxtPredRicSet(NumPred - 100).text
        AppPortata = ListaPredosatoriRic(NumPred - 100).PortataMax
    End If
    Estrazione = 20 * 0.685     '20 giri al minuto del rullo di testa del predosatore * 0,685 metri di nastro ogni giro
    
    If AppPortata = 0 Then
        Calcola_m_min = "000.0"
    Else
        Calcolo1 = AppRamsey * AppSet * Estrazione
        Calcolo2 = AppPortata * 100
        If Calcolo2 = 0 Then
            Calcola_m_min = "000.0"
        Else
            Calcola_m_min = Format(Calcolo1 \ Calcolo2, "000") + "." + left(Calcolo1 Mod Calcolo2, 1)
        End If
    End If
    
End Function

Public Function ConvertiTh2Kgm(Ramsey As Integer) As String
    'Il nastro elevatore freddo va ad una velocità costante di 120 metri al minuto
    ConvertiTh2Kgm = Format((CLng(Ramsey) * 1000 / 60) \ 120, "000") + "." + left((CLng(Ramsey) * 1000 / 60) Mod 120, 1)

End Function


'------- FRANCIA -------

'----------------------------------------------------------------------------
'PROGRAMME DU WINDQUAL
'-----------------------------------------------------------------------

Function ControleCrc(ByVal Taille%, ByVal CRC_1&, ByVal CRC_2&, ByVal CRC_3&) As Boolean
    Dim CrcCal&, i%, j%, a$
    Dim CRC1&, CRC2&, CRC3&
    
    Dim CrcRecu As Long 'FRANCIA
    
    CrcCal = 65535
    For i = 1 To (Taille - 6)      ' 5 digits de CRC + CR
        CrcCal = CrcCal Xor Asc(Mid(TrameRecu, i, 1))
        For j = 0 To 7
            If (CrcCal And 1) Then
                CrcCal = CrcCal \ 2
                CrcCal = CrcCal Xor 40961
            Else
                CrcCal = CrcCal \ 2
            End If
        Next j
    Next i

'=====(2)=== Contrôle du CRC reçu ==================================
    Select Case gFlagTypeDeCRC
        Case 0                      '*** CRC en Binaire ***
            CRC1 = CrcCal And 127
            CRC2 = (CrcCal And 16256) / 128
            CRC3 = (CrcCal And 49152) / 16384

            If ((CRC1 = CRC_1) And (CRC2 = CRC_2) And (CRC3 = CRC_3)) Then
                ControleCrc = True
            Else
                ControleCrc = False
            End If
        Case 1                      '*** CRC en Ascii
            a$ = Mid$(TrameRecu, (Taille - 5))      ' 5 digits de CRC + CR
            CrcRecu = val(a$)
            If (CrcCal = CrcRecu) Then
                ControleCrc = True
            Else
                ControleCrc = False
            End If
    End Select

End Function


'----------------------------------------------------------------------------
'PROGRAMME CALCUL CRC TENOR
'-----------------------------------------------------------------------

'/*----------------------------------------------------------------------*/
'/*          Calcul du CRC16                 */
'/*----------------------------------------------------------------------*/
'UWORD GetCrc(register char *p)
'   {register UWORD crc16=0xffff;
'   register short i;
'
'   while(*p!='\r')
'      {crc16^=(UWORD)*p++;      /* OU exclusif de la donnee */
'      for(i=8; i; i--)          /* Traitement de chaque bit */
'     {if(crc16 & 0x0001)
'        {crc16>>=1;
'        crc16^=0xa001;      /* (2^15)+(2^13)+1      */
'        }
'     else crc16>>=1;
'     }
'      }
'
'   crc16^=(UWORD)',';           /* OU exclusif de la donnee */
'      for(i=8; i; i--)          /* Traitement de chaque bit */
'     {if(crc16 & 0x0001)
'         {crc16>>=1;
'         crc16^=0xa001;     /* (2^15)+(2^13)+1      */
'         }
'      else crc16>>=1;
'     }
'   return (crc16 & 0xffff);
'   }

'------- FRANCIA -------

Public Sub ScriviLogWindQual(Trama As String, TipoTrama As String)

    Dim nomeFile As String

On Error GoTo Errore
    
    Select Case TipoTrama
        Case "P"
            nomeFile = "C:\FAYAT\CYBERTRONIC 500\WindQual_LOG\Log_Windqual_P_" & CambiaChar(CStr(Date), "/", "-") & ".txt"
        Case "PC"
            nomeFile = "C:\FAYAT\CYBERTRONIC 500\WindQual_LOG\Log_Windqual_PC_" & CambiaChar(CStr(Date), "/", "-") & ".txt"
        Case "T"
            nomeFile = "C:\FAYAT\CYBERTRONIC 500\WindQual_LOG\Log_Windqual_T_" & CambiaChar(CStr(Date), "/", "-") & ".txt"
    End Select
    
    If (Dir(nomeFile) = "") Then
        Open nomeFile For Output As #512
    Else
        Open nomeFile For Append As #512
    End If

    Write #512, Trama
    Close #512
    
    Exit Sub
Errore:
    LogInserisci True, "LCP-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

