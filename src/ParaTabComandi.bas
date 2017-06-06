Attribute VB_Name = "ParaTabComandi"
'
'   Gestione dei comandi
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'

Option Explicit

Private Const SEZIONE As String = "Comandi"


'   Lettura del file
Public Function ParaTabComandi_ReadFile() As Boolean

    Dim Index As Integer


    ParaTabComandi_ReadFile = False

    'CYBERTRONIC_PLUS

    For Index = 0 To NumComandiVari - 1
        ListaComandi(Index).presente = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Comando" + CStr(Index), "", "Presente"))
        ListaComandi(Index).AutoON = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Comando" + CStr(Index), "", "AutoON"))
    Next Index

''20150422
    ListaComandi(ComandoSiloFillerSoffioAriaRecupero).tempoStart = 2
    ListaComandi(ComandoSiloFillerSoffioAriaRecupero).tempoStop = 7
''
    '20151110
    ListaComandi(ComandoFiller2Sacchi).AutoON = False
    
    
    AbilitaTempoVibrCaricoFApp = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Comando5", "", "AbilitaTempoVibrCaricoFApp"))
    SetVibrCaricoFApp = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Comando5", "", "SetVibrCaricoFApp"))

    If (SetVibrCaricoFApp <= 0) Then
        SetVibrCaricoFApp = 30
    End If

    AbilitaTempoVibrCaricoFApp2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Comando6", "", "AbilitaTempoVibrCaricoFApp2"))
    SetVibrCaricoFApp2 = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Comando6", "", "SetVibrCaricoFApp2"))

    If (SetVibrCaricoFApp2 <= 0) Then
        SetVibrCaricoFApp2 = 30
    End If

    ParaTabComandi_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabComandi_Apply()

    Dim Index As Integer
    Dim numComandiAbilitati As Integer


    Call CaricaTestiComandi

    For Index = 0 To NumComandiVari - 1
        If (ListaComandi(Index).presente) Then
            numComandiAbilitati = numComandiAbilitati + 1
        End If
    Next Index
    CP240.CmdAvvMotori(2).Visible = (numComandiAbilitati > 0)

End Sub


Public Sub CaricaTestiComandi()

    ListaComandi(0).Descrizione = LoadXLSString(625)
    ListaComandi(1).Descrizione = LoadXLSString(624)
    ListaComandi(2).Descrizione = LoadXLSString(628)
    ListaComandi(3).Descrizione = LoadXLSString(629)
    ListaComandi(4).Descrizione = LoadXLSString(630)
    ListaComandi(5).Descrizione = LoadXLSString(626)
    ListaComandi(6).Descrizione = LoadXLSString(626) + " 2"
    ListaComandi(7).Descrizione = LoadXLSString(633)
    ListaComandi(8).Descrizione = SostituisciCaratteri(LoadXLSString(634), "1", "2")
    ListaComandi(9).Descrizione = SostituisciCaratteri(LoadXLSString(634), "2", "3")
    ListaComandi(10).Descrizione = LoadXLSString(1509)  '20150616 Filler 2 RompiSacchi
End Sub

