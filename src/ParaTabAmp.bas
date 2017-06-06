Attribute VB_Name = "ParaTabAmp"
'
'   Gestione dei parametri degli amperometri
'
'   2007 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE As String = "Motori"


'   Lettura del file
Public Function ParaTabAmp_ReadFile() As Boolean

    Dim indice As Integer
    Dim ListaPara(0 To MAXMOTORI + MAXAMPEROMETRI) As String


    ParaTabAmp_ReadFile = False

    'Deve essere codificata per il PLC
    For indice = 0 To MAXNEWMOTORS - 1
        ListaPara(indice) = "Motore" + CStr(indice + 1)
    Next indice
    ListaPara(MAXNEWMOTORS) = "Motore5"
    ListaPara(MAXNEWMOTORS + 1) = "Motore17"
    ListaPara(MAXNEWMOTORS + 2) = "Motore17"
    ListaPara(MAXNEWMOTORS + 3) = "Motore17"
    ListaPara(MAXNEWMOTORS + 4) = "Motore7"
    ListaPara(MAXNEWMOTORS + 5) = "Motore39"
    ListaPara(MAXNEWMOTORS + 6) = "Motore39"
    ListaPara(MAXNEWMOTORS + 7) = "Motore39"

    'TODO le due righe seguenti sono state commentate perchè nel file XML mancano i parametri relativi. Aggiungerli e scommentare le righe
    'AbilitaConsumoEnergia = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "ConsumoEnergia", "", "AbilitaConsumoEnergia"))
    'TempoCampionamentoConsumi = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ConsumoEnergia", "", "TempoCampionamentoConsumi"))
    
    'Andrea - Gli amperometri ora sono all'interno della sezione motori e non tutti i motori al momento hanno un amperometro ma nell'XML è predisposto per tutti
    'Ogni motore prevede un amperometro
    For indice = 0 To MAXMOTORI - 1
        ListaAmperometri(indice).Inclusione = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro", "Presente", "0")) '20160218
        ListaAmperometri(indice).max = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro", "ValoreMax"))
        ListaAmperometri(indice).sogliaMin = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro", "ValoreSogliaMin"))
        ListaAmperometri(indice).sogliaMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro", "ValoreSogliaMax"))
        '20160512
        ListaAmperometri(indice).filtroIncluso = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro", "AmperometerFilterEnable"))
        '
        '20160915
        ListaAmperometri(indice).XTUA = CInt(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro", "XTUA"))
        '
    Next indice
    'Amperometri 2,3,4
    For indice = MAXNEWMOTORS To MAXAMPEROMETRI - 1
    
        If (indice = MAXNEWMOTORS Or indice = MAXNEWMOTORS + 1 Or indice = MAXNEWMOTORS + 4 Or indice = MAXNEWMOTORS + 5) Then

            ListaAmperometri(indice).Inclusione = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro2", "Presente"))
            ListaAmperometri(indice).max = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro2", "ValoreMax"))
            ListaAmperometri(indice).sogliaMin = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro2", "ValoreSogliaMin"))
            ListaAmperometri(indice).sogliaMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro2", "ValoreSogliaMax"))
            '20160512
            ListaAmperometri(indice).filtroIncluso = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro2", "AmperometerFilterEnable"))
            '

        ElseIf (indice = MAXNEWMOTORS + 2 Or indice = MAXNEWMOTORS + 6) Then

            ListaAmperometri(indice).Inclusione = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro3", "Presente"))
            ListaAmperometri(indice).max = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro3", "ValoreMax"))
            ListaAmperometri(indice).sogliaMin = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro3", "ValoreSogliaMin"))
            ListaAmperometri(indice).sogliaMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro3", "ValoreSogliaMax"))
            '20160512
            ListaAmperometri(indice).filtroIncluso = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro3", "AmperometerFilterEnable"))
            '

        ElseIf (indice = MAXNEWMOTORS + 3 Or indice = MAXNEWMOTORS + 7) Then

            ListaAmperometri(indice).Inclusione = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro4", "Presente"))
            ListaAmperometri(indice).max = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro4", "ValoreMax"))
            ListaAmperometri(indice).sogliaMin = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro4", "ValoreSogliaMin"))
            ListaAmperometri(indice).sogliaMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro4", "ValoreSogliaMax"))
            '20160512
            ListaAmperometri(indice).filtroIncluso = CBool(ParameterPlus.GetParameterValue(SEZIONE, ListaPara(indice), "Amperometro4", "AmperometerFilterEnable"))
            '

        End If

    Next indice

    '20161212
    'ListaMotori(MotoreMescolatore).amperometro = ListaAmperometri(MotoreMescolatore - 1).Inclusione
    ''ListaMotori(MotoreMescolatore).Amperometro = ListaAmperometri(AmperometroMescolatore_2).inclusione TODO NEW PARA
    'ListaMotori(MotoreElevatoreCaldo).amperometro = ListaAmperometri(MotoreElevatoreCaldo - 1).Inclusione
    'ListaMotori(MotoreVentolaBruciatore).amperometro = ListaAmperometri(MotoreVentolaBruciatore - 1).Inclusione
    'ListaMotori(MotoreAspiratoreFiltro).amperometro = ListaAmperometri(MotoreAspiratoreFiltro - 1).Inclusione
    'ListaMotori(MotoreArganoBenna).amperometro = ListaAmperometri(MotoreArganoBenna - 1).Inclusione
    'ListaMotori(MotoreRotazioneEssiccatore).amperometro = ListaAmperometri(MotoreRotazioneEssiccatore - 1).Inclusione
    ''ListaMotori(MotoreRotazioneEssiccatore).Amperometro = ListaAmperometri(AmperometroEssicatore_2).inclusione
    ''ListaMotori(MotoreRotazioneEssiccatore).Amperometro = ListaAmperometri(AmperometroEssicatore_3).inclusione
    ''ListaMotori(MotoreRotazioneEssiccatore).Amperometro = ListaAmperometri(AmperometroEssicatore_4).inclusione
    'ListaMotori(MotoreVaglio).amperometro = ListaAmperometri(MotoreVaglio - 1).Inclusione
    ''ListaMotori(MotoreVaglio).Amperometro = ListaAmperometri(AmperometroVaglio_2).inclusione
    'ListaMotori(MotoreRotazioneEssiccatore2).amperometro = ListaAmperometri(MotoreRotazioneEssiccatore2 - 1).Inclusione
    ''ListaMotori(MotoreRotazioneEssiccatore2).Amperometro = ListaAmperometri(AmperometroEssicatore2_2).inclusione
    ''ListaMotori(MotoreRotazioneEssiccatore2).Amperometro = ListaAmperometri(AmperometroEssicatore2_3).inclusione
    ''ListaMotori(MotoreRotazioneEssiccatore2).Amperometro = ListaAmperometri(AmperometroEssicatore2_4).inclusione
    'ListaMotori(MotoreVentolaBruciatore2).amperometro = ListaAmperometri(MotoreVentolaBruciatore2 - 1).Inclusione
    'ListaMotori(MotoreElevatoreF1).amperometro = ListaAmperometri(MotoreElevatoreF1 - 1).Inclusione
    'ListaMotori(MotoreElevatoreRiciclato).amperometro = ListaAmperometri(MotoreElevatoreRiciclato - 1).Inclusione
    ListaMotori(MotoreMescolatore).amperometro = ListaAmperometri(AmperometroMescolatore_1).Inclusione
    'ListaMotori(MotoreMescolatore_2).Amperometro = ListaAmperometri(AmperometroMescolatore_2).inclusione TODO NEW PARA
    ListaMotori(MotoreElevatoreCaldo).amperometro = ListaAmperometri(AmperometroElevatoreCaldo).Inclusione
    ListaMotori(MotoreVentolaBruciatore).amperometro = ListaAmperometri(AmperometroVentolaBruciatore).Inclusione
    ListaMotori(MotoreAspiratoreFiltro).amperometro = ListaAmperometri(AmperometroAspiratoreFiltro).Inclusione
    ListaMotori(MotoreArganoBenna).amperometro = ListaAmperometri(AmperometroArganoBenna).Inclusione
    ListaMotori(MotoreRotazioneEssiccatore).amperometro = ListaAmperometri(AmperometroEssicatore_1).Inclusione
    'ListaMotori(MotoreRotazioneEssiccatore_2).Amperometro = ListaAmperometri(AmperometroEssicatore_2).inclusione
    'ListaMotori(MotoreRotazioneEssiccatore_3).Amperometro = ListaAmperometri(AmperometroEssicatore_3).inclusione
    'ListaMotori(MotoreRotazioneEssiccatore_4).Amperometro = ListaAmperometri(AmperometroEssicatore_4).inclusione
    ListaMotori(MotoreVaglio).amperometro = ListaAmperometri(AmperometroVaglio_1).Inclusione
    'ListaMotori(MotoreVaglio).Amperometro = ListaAmperometri(AmperometroVaglio_2).inclusione
    ListaMotori(MotoreRotazioneEssiccatore2).amperometro = ListaAmperometri(AmperometroEssicatore2_1).Inclusione
    'ListaMotori(MotoreRotazioneEssiccatore2_2).Amperometro = ListaAmperometri(AmperometroEssicatore2_2).inclusione
    'ListaMotori(MotoreRotazioneEssiccatore2_3).Amperometro = ListaAmperometri(AmperometroEssicatore2_3).inclusione
    'ListaMotori(MotoreRotazioneEssiccatore2_4).Amperometro = ListaAmperometri(AmperometroEssicatore2_4).inclusione
    ListaMotori(MotoreVentolaBruciatore2).amperometro = ListaAmperometri(AmperometroVentolaBruciatore2).Inclusione
    ListaMotori(MotoreElevatoreF1).amperometro = ListaAmperometri(AmperometroElevatoreFiller).Inclusione
    ListaMotori(MotoreElevatoreRiciclato).amperometro = ListaAmperometri(AmperometroElevatoreRiciclato).Inclusione
    '


    ParaTabAmp_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabAmp_Apply()

    Dim indice As Integer

    With CP240

        VerificaValoriParAmperometri

        For indice = 0 To MAXAMPEROMETRI - 1

            Select Case indice
                Case 50 'AmperometroMescolatore_1
                    .Image1(indice).Visible = ListaAmperometri(AmperometroMescolatore_1).Inclusione
                Case 51 'AmperometroElevatoreCaldo
                    .Image1(indice).Visible = ListaAmperometri(AmperometroElevatoreCaldo).Inclusione
                Case 52 'AmperometroEssicatore_1
                    .Image1(indice).Visible = ListaAmperometri(AmperometroEssicatore_1).Inclusione
                Case 53 'AmperometroVentolaBruciatore
                    .Image1(indice).Visible = ListaAmperometri(AmperometroVentolaBruciatore).Inclusione
                Case 54 'AmperometroAspiratoreFiltro
                    .Image1(indice).Visible = ListaAmperometri(AmperometroAspiratoreFiltro).Inclusione
                Case 55 'AmperometroArganoBenna
                    .Image1(indice).Visible = ListaAmperometri(AmperometroArganoBenna).Inclusione
                Case 56 'AmperometroMescolatore_2
                Case 57 'AmperometroEssicatore_2
                Case 58 'AmperometroEssicatore_3
                Case 59 'AmperometroEssicatore_4
                Case 16 'AmperometroVentolaBruciatore2
                    .Image1(indice).Visible = ListaAmperometri(AmperometroVentolaBruciatore2).Inclusione
                Case 17 'AmperometroEssicatore2_1
                    .Image1(indice).Visible = ListaAmperometri(AmperometroEssicatore2_1).Inclusione
                Case 10, 11 'AmperometroVaglio_1, AmperometroVaglio_2
                    .Image1(indice).Visible = (ListaAmperometri(AmperometroVaglio_1).Inclusione Or ListaAmperometri(AmperometroVaglio_2).Inclusione)
                Case 62 'AmperometroElevatoreFiller
                    .Image1(indice).Visible = ListaAmperometri(AmperometroElevatoreFiller).Inclusione
                Case 72 'AmperometroElevatoreRiciclato
                    .Image1(indice).Visible = ListaAmperometri(AmperometroElevatoreRiciclato).Inclusione
            End Select

            '.ProgressAmp(indice + 1).Visible = ListaAmperometri(indice).inclusione
            .LblAmp(indice + 1).Visible = ListaAmperometri(indice).Inclusione
            .ProgressAmp(indice + 1).Visible = ListaAmperometri(indice).Inclusione

        Next indice

        '20160412
        '.imgPulsanteForm(TBB_ENERGIA).Visible = AbilitaConsumoEnergia
        .imgPulsanteForm(TBB_ENERGIA).Visible = (AbilitaConsumoEnergia And Not Plus2Monitor)
        '

    End With

End Sub


Private Sub VerificaValoriParAmperometri()

    Dim indice As Integer
    
    For indice = 0 To MAXAMPEROMETRI - 1

        Select Case indice

            Case 0, 5   'aggiungere qui gli amperometri che hanno una soglia minima da controllare
                If ListaAmperometri(indice).sogliaMax = 0 Then
                    ListaAmperometri(indice).sogliaMax = CInt(ListaAmperometri(indice).max / 100 * 80)
                End If

                If ListaAmperometri(indice).sogliaMin = 0 Then
                    ListaAmperometri(indice).sogliaMin = CInt(ListaAmperometri(indice).max / 100 * 20)
                End If

            Case Else
                If ListaAmperometri(indice).sogliaMax = 0 Then
                    ListaAmperometri(indice).sogliaMax = CInt(ListaAmperometri(indice).max / 100 * 80)
                End If

        End Select

    Next indice

End Sub

