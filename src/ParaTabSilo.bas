Attribute VB_Name = "ParaTabSilo"
'
'   Gestione dei parametri dei sili
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const FileSili As String = "Sili.ini"
Private Const SEZIONE As String = "Sili"


'   Lettura del file
Public Function ParaTabSilo_ReadFile() As Boolean

    Dim Index As Integer


    ParaTabSilo_ReadFile = False

    Index = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "VisualizzaBennaNavetta"))
    
    Select Case Index
        Case 0
            VisualizzaBenna = False
            InclusioneBenna = False
        Case 1
            VisualizzaBenna = True
            InclusioneBenna = True
        Case 2
            VisualizzaBenna = False
            InclusioneBenna = True
'
    End Select
    ConfigSilo = ParameterPlus.GetParameterValue(SEZIONE, "", "", "ConfigSilo")
    AbilitaTemperaturaSilo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaTemperaturaSilo"))
    NumeroPirometriSilo = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumeroPirometriSilo"))
    AbilitaCelleCaricoSilo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaCelleCaricoSilo"))
    CelleSiloTaraBilancia = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "CelleSiloTaraBilancia"))
    CelleSiloTolleranzaBilancia = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "CelleSiloTolleranzaBilancia"))
    CelleSiloStabilizzazioneBilancia = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "CelleSiloStabilizzazioneBilancia"))
    CelleSiloConfigurazioneSilo = ParameterPlus.GetParameterValue(SEZIONE, "", "", "CelleSiloConfigurazioneSilo")
    ConfigurazioneTemperatureSilo = ParameterPlus.GetParameterValue(SEZIONE, "", "", "ConfigurazioneTemperatureSilo") '20151215
    AbilitazioneSemaforoBenna = ParameterPlus.GetParameterValue(SEZIONE, "", "", "VisualizzaSemaforoBenna") '20160503
    AbilitazioneSemaforoSili = ParameterPlus.GetParameterValue(SEZIONE, "", "", "VisualizzaSemaforoSili") '20160503
'        AbilitaVisPesoSili = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaVisPesoSili"))
    NumeroVisPesoSili = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumeroVisPesoSili"))
    FondoScalaPesoSilo = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FondoScalaPesoSilo"))
    InclusioneBennaApribile = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "InclusioneBennaApribile"))
    VisualizzaCamionPerSiloDiretto = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "VisualizzaCamionPerSiloDiretto"))
    SiloSottoDeflettori1D2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "SiloSottoDeflettori1D2"))
    AbilitazioneSpruzzaturaBennaTemporizzata = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitazioneSpruzzaturaBennaTemporizzata"))
    TempoColpettiTelesc = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FiltroColpettiTele")) * 1000
    MaxTara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "MaxTara")) * 1000
    InclusioneTempiAnticipo = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AnticipoBlocco"))
    AbilitaResetCelle = AbilitaCelleCaricoSilo
    AbilitaBilanciaCamion = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaBilanciaCamion"))  '20151209
    BilanciaPesaCamion.PesaCamionScalingKgMax = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "", "", "FondoScalaBilanciaCamion"))  '20151209
    BilanciaPesaCamion.PesaCamionEnFiltro = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaFiltroBilanciaCamion"))  '20151209
    BilanciaPesaCamion.PesaCamionSampleNr = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "NumCampioniBilanciaCamion"))   '20151209
    BilanciaPesaCamion.PesaCamionSampleTime = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "TempoCampioniBilanciaCamion"))  '20151209
    '20161214
    Deodorante.Inclusione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AbilitaDeodorante"))
    Deodorante.RitStart = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RitardoStartDeodorante"))
    Deodorante.RitStop = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "", "", "RitardoStopDeodorante"))
    Deodorante.DurataMax = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "DurataMaxDeodorante"))
    '20161214
    Dim i As Integer
    For i = 1 To MAXNUMSILI
        TempiCelleSilo(i) = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "", "", "AnticipoTempo" + CStr(i))) * 1000
    Next i
    'TempiCelleSilo

    'ASSE 1

    InclusioneSiloS7 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "InclusioneSiloS7"))

    SiloS7ZerosetMoveSpeed = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7ZerosetMoveSpeed"))
    SiloS7ZerosetSearchSpeed = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7ZerosetSearchSpeed"))
    SiloS7ZerosetZeroSpeed = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7ZerosetZeroSpeed"))
    SiloS7RapportoImpulsiUnitaMisura = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7RapportoImpulsiUnitaMisura"))
    SiloS7PosisetVeloxMax = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosisetVeloxMax"))
    SiloS7PosisetVeloxMin = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosisetVeloxMin"))
    SiloS7PosisetRampaUP = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosisetRampaUP"))
    SiloS7PosisetRampaDOWN = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosisetRampaDOWN"))
    SiloS7PosisetTolleranza = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosisetTolleranza"))
    SiloS7RitPosiPT = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7RitPosiPT"))
    SiloS7TempoSpruzzaAntiadesivo = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7TempoSpruzzaAntiadesivo"))
    SiloS7TempoScaricoPT = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7TempoScaricoPT"))
    SiloS7VelManualeJog = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7VelManualeJog"))
    SiloS7RitardoPosizionaSottoMixer = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7RitardoPosizionaSottoMixer"))
    SiloS7FwLocked = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7FwLocked"))
    SiloS7BwLocked = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7BwLocked"))

    InvertiQuoteXGraficoBennaS7 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "InvertiQuoteXGraficoBennaS7")) And InclusioneSiloS7

    'ASSE 2
    InclusioneSilo2S7 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "InclusioneSilo2S7"))
    Silo2S7ZerosetMoveSpeed = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7ZerosetMoveSpeed"))
    Silo2S7ZerosetSearchSpeed = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7ZerosetSearchSpeed"))
    Silo2S7ZerosetZeroSpeed = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7ZerosetZeroSpeed"))
    Silo2S7RapportoImpulsiUnitaMisura = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7RapportoImpulsiUnitaMisura"))
    Silo2S7PosisetVeloxMax = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosisetVeloxMax"))
    Silo2S7PosisetVeloxMin = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosisetVeloxMin"))
    Silo2S7PosisetRampaUP = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosisetRampaUP"))
    Silo2S7PosisetRampaDOWN = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosisetRampaDOWN"))
    Silo2S7PosisetTolleranza = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosisetTolleranza"))
    Silo2S7RitPosiPT = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7RitPosiPT"))
    Silo2S7TempoSpruzzaAntiadesivo = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7TempoSpruzzaAntiadesivo"))
    Silo2S7TempoScaricoPT = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7TempoScaricoPT"))
    Silo2S7VelManualeJog = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7VelManualeJog"))
    Silo2S7FwLocked = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7FwLocked"))
    Silo2S7BwLocked = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7BwLocked"))

    InvertiQuoteYGraficoBennaS7 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "GestioneAsseXY", "", "InvertiQuoteYGraficoBennaS7")) And InclusioneSilo2S7
    
    Call ReadPositioneSiloFromXml

    ParaTabSilo_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabSilo_Apply()

    Dim i As Integer
    Dim Stringa As String
    Dim numeropirometro As Integer
    Dim labeletichetta As String

    With CP240

        '20150820
        '.imgPulsanteForm(TBB_SILO).Visible = (ConfigSilo <> "D")
        .imgPulsanteForm(TBB_SILO).Visible = (ConfigSilo <> "D" And ConfigSilo <> "1")  'Unico scomparto!
        '

        '   Visualizzazione del primo peso dei sili
'        .lblEtichetta(120).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 1)
'        .lblEtichetta(121).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 1)
        .LblEtichetta(120).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 1)
        .LblEtichetta(121).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 1)
        .CmdResetProdotto(3).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 1)

        '   Visualizzazione del secondo peso dei sili
'        .lblEtichetta(194).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 2)
        .LblEtichetta(194).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 2)
        .CmdResetProdotto(4).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 2)
        
        '   Visualizzazione del terzo peso dei sili
'        .lblEtichetta(27).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 3)
        .LblEtichetta(27).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 3)
        .CmdResetProdotto(6).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 3)
        
        '   Visualizzazione del quarto peso dei sili
'        .lblEtichetta(44).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 4)
        .LblEtichetta(44).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 4)
        .CmdResetProdotto(7).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 4)
        
        '   Visualizzazione del quinto peso dei sili
'        .lblEtichetta(42).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 5)
        .LblEtichetta(42).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 5)
        .CmdResetProdotto(2).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 5)
        
        '   Visualizzazione del sesto peso dei sili
'        .lblEtichetta(64).Visible = (AbilitaVisPesoSili And NumeroVisPesoSili >= 6)
        .LblEtichetta(64).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 6)
        .CmdResetProdotto(8).Visible = (AbilitaCelleCaricoSilo And NumeroVisPesoSili >= 6)
        
        'Visualizzazione del peso scaricato dal silo (vecchia etichetta di gestione peso su camion non piu' usata)
'20151216
'        .lblEtichetta(26).Visible = AbilitaCelleCaricoSilo
'        .LblEtichetta(26).Visible = False
'        .lblEtichetta(21).Visible = AbilitaCelleCaricoSilo
'        .CmdResetProdotto(5).Visible = AbilitaCelleCaricoSilo
'20170221
'        .LblEtichetta(21).Visible = False
'        .CmdResetProdotto(5).Visible = False

'
        .LblEtichetta(123).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo > 0)
        
        .Image10(16).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo > 0)
        .LblEtichetta(124).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 2)
        .Image10(17).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 2)
        
        .LblEtichetta(125).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 3)
        .LblEtichetta(126).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 4)
        .LblEtichetta(127).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 5)
        .LblEtichetta(128).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 6) '20151214
        .Image10(18).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 3)
        .Image10(19).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 4)
        .Image10(20).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 5)
        .Image10(20).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 5)
        .Image10(21).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 6) '20151214
'20151216
        .LblEtichetta(140).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo > 0)
        .LblEtichetta(141).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 2)
        .LblEtichetta(142).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 3)
        .LblEtichetta(143).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 4)
        .LblEtichetta(144).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 5)
        .LblEtichetta(145).Visible = (AbilitaTemperaturaSilo And NumeroPirometriSilo >= 6)

        numeropirometro = 0
        labeletichetta = ""
                
        For i = 1 To Len(ConfigurazioneTemperatureSilo)
            Stringa = Mid(ConfigurazioneTemperatureSilo, i, 1)
            If labeletichetta = "" Then
                labeletichetta = LoadXLSString(332)
            ElseIf Stringa <> "+" Then
                labeletichetta = labeletichetta & "-"
            End If
            
            If Stringa <> "+" And (i < Len(ConfigurazioneTemperatureSilo)) Then
                labeletichetta = labeletichetta & Stringa
            ElseIf (i = Len(ConfigurazioneTemperatureSilo)) Then
                labeletichetta = labeletichetta & Stringa
                .LblEtichetta(140 + numeropirometro).caption = labeletichetta
            Else
                .LblEtichetta(140 + numeropirometro).caption = labeletichetta
                numeropirometro = numeropirometro + 1
                labeletichetta = ""
            End If
        Next i
'



        '   Sceglie se visualizzare benna o navetta in scarico e pronta
        If (VisualizzaBenna) Then
            .ImgBenna(1).Picture = LoadResPicture("IDB_BENNASCARICO", vbResBitmap)
        Else
            .ImgBenna(1).Picture = LoadResPicture("IDB_NAVETTASCARICO", vbResBitmap)
        End If
        .ImgBenna(2).Picture = LoadResPicture("IDI_CONFERMA", vbResIcon)
        
        .ImgBenna(3).Picture = LoadResPicture("IDI_CONFERMA", vbResIcon)
        If (VisualizzaBenna) Then
            .ImgBenna(4).Picture = LoadResPicture("IDB_BENNASCARICO", vbResBitmap)
        Else
            .ImgBenna(4).Picture = LoadResPicture("IDB_NAVETTASCARICO", vbResBitmap)
        End If

        Call PosizionaSiliCP240

        If (FrmSiloGeneraleVisibile) Then
            Call FrmSiloGenerale.PosizionaSili
        End If

        If InclusioneSiloS7 Then
            Call CalcoloQuotePosGraficaSiloS7
        End If

        .Frame1(63).Visible = AbilitaBilanciaCamion Or AbilitaCelleCaricoSilo '20151202

        '20160412
        If (VisualizzaCamionPerSiloDiretto) Then
            .LblEtichetta(31).Visible = (ConfigSilo <> "D") 'Unico scomparto "D"!

            If (ConfigSilo = "D") Then
                .ImgBenna(0).Picture = LoadResPicture("IDB_CAMION", vbResBitmap)
                .ImgBenna(0).Visible = True
            End If
        End If
        '

    End With

End Sub


Public Sub ReadPositioneSiloFromXml()

    Dim result As Boolean
    Dim nomeFile As String

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)
    nomeFile = UserDataPath + FileSili

    'Asse 1
    SiloS7PosizioneSiloD = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSiloD", "0"))
    SiloS7PosizioneSiloR = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSiloR", "0"))
    SiloS7PosizioneSilo(1) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo1", "0"))
    SiloS7PosizioneSilo(2) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo2", "0"))
    SiloS7PosizioneSilo(3) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo3", "0"))
    SiloS7PosizioneSilo(4) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo4", "0"))
    SiloS7PosizioneSilo(5) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo5", "0"))
    SiloS7PosizioneSilo(6) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo6", "0"))
    SiloS7PosizioneSilo(7) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo7", "0"))
    SiloS7PosizioneSilo(8) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo8", "0"))
    SiloS7PosizioneSilo(9) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo9", "0"))
    SiloS7PosizioneSilo(10) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo10", "0"))
    SiloS7Posizione1AntiadesivoMain = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione1AntiadesivoMain", "0"))
    SiloS7Posizione2AntiadesivoMain = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione2AntiadesivoMain", "0"))

    SiloS7PosizioneSilo(11) = SiloS7PosizioneSiloD
    SiloS7PosizioneSilo(12) = SiloS7PosizioneSiloR

    'Asse 2
    Silo2S7PosizioneSiloD = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSiloD", "0"))
    Silo2S7PosizioneSiloR = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSiloR", "0"))
    Silo2S7PosizioneSilo(1) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo1", "0"))
    Silo2S7PosizioneSilo(2) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo2", "0"))
    Silo2S7PosizioneSilo(3) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo3", "0"))
    Silo2S7PosizioneSilo(4) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo4", "0"))
    Silo2S7PosizioneSilo(5) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo5", "0"))
    Silo2S7PosizioneSilo(6) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo6", "0"))
    Silo2S7PosizioneSilo(7) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo7", "0"))
    Silo2S7PosizioneSilo(8) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo8", "0"))
    Silo2S7PosizioneSilo(9) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo9", "0"))
    Silo2S7PosizioneSilo(10) = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo10", "0"))
    SiloS7Posizione1AntiadesivoAux = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione1AntiadesivoAux", "0"))
    SiloS7Posizione2AntiadesivoAux = CDbl(FileGetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione2AntiadesivoAux", "0"))
    
    Silo2S7PosizioneSilo(11) = Silo2S7PosizioneSiloD
    Silo2S7PosizioneSilo(12) = Silo2S7PosizioneSiloR

End Sub

Public Sub WritePositioneSiloToXml()

    Dim result As Boolean
    Dim nomeFile As String

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)
    nomeFile = UserDataPath + FileSili

    'Asse 1
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSiloD", CStr(SiloS7PosizioneSiloD))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSiloR", CStr(SiloS7PosizioneSiloR))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo1", CStr(SiloS7PosizioneSilo(1)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo2", CStr(SiloS7PosizioneSilo(2)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo3", CStr(SiloS7PosizioneSilo(3)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo4", CStr(SiloS7PosizioneSilo(4)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo5", CStr(SiloS7PosizioneSilo(5)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo6", CStr(SiloS7PosizioneSilo(6)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo7", CStr(SiloS7PosizioneSilo(7)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo8", CStr(SiloS7PosizioneSilo(8)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo9", CStr(SiloS7PosizioneSilo(9)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7PosizioneSilo10", CStr(SiloS7PosizioneSilo(10)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7Posizione1AntiadesivoMain", CStr(SiloS7Posizione1AntiadesivoMain))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7Posizione2AntiadesivoMain", CStr(SiloS7Posizione2AntiadesivoMain))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSiloD", CStr(SiloS7PosizioneSiloD))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSiloR", CStr(SiloS7PosizioneSiloR))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo1", CStr(SiloS7PosizioneSilo(1)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo2", CStr(SiloS7PosizioneSilo(2)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo3", CStr(SiloS7PosizioneSilo(3)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo4", CStr(SiloS7PosizioneSilo(4)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo5", CStr(SiloS7PosizioneSilo(5)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo6", CStr(SiloS7PosizioneSilo(6)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo7", CStr(SiloS7PosizioneSilo(7)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo8", CStr(SiloS7PosizioneSilo(8)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo9", CStr(SiloS7PosizioneSilo(9)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7PosizioneSilo10", CStr(SiloS7PosizioneSilo(10)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione1AntiadesivoMain", CStr(SiloS7Posizione1AntiadesivoMain))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione2AntiadesivoMain", CStr(SiloS7Posizione2AntiadesivoMain))

    SiloS7PosizioneSilo(11) = SiloS7PosizioneSiloD
    SiloS7PosizioneSilo(12) = SiloS7PosizioneSiloR

    'Asse 2
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSiloD", CStr(Silo2S7PosizioneSiloD))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSiloR", CStr(Silo2S7PosizioneSiloR))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo1", CStr(Silo2S7PosizioneSilo(1)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo2", CStr(Silo2S7PosizioneSilo(2)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo3", CStr(Silo2S7PosizioneSilo(3)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo4", CStr(Silo2S7PosizioneSilo(4)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo5", CStr(Silo2S7PosizioneSilo(5)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo6", CStr(Silo2S7PosizioneSilo(6)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo7", CStr(Silo2S7PosizioneSilo(7)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo8", CStr(Silo2S7PosizioneSilo(8)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo9", CStr(Silo2S7PosizioneSilo(9)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "Silo2S7PosizioneSilo10", CStr(Silo2S7PosizioneSilo(10)))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7Posizione1AntiadesivoAux", CStr(SiloS7Posizione1AntiadesivoAux))
    'result = ParameterPlus.SetParameterValue(SEZIONE, "GestioneAsseXY", "", "SiloS7Posizione2AntiadesivoAux", CStr(SiloS7Posizione2AntiadesivoAux))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSiloD", CStr(Silo2S7PosizioneSiloD))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSiloR", CStr(Silo2S7PosizioneSiloR))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo1", CStr(Silo2S7PosizioneSilo(1)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo2", CStr(Silo2S7PosizioneSilo(2)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo3", CStr(Silo2S7PosizioneSilo(3)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo4", CStr(Silo2S7PosizioneSilo(4)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo5", CStr(Silo2S7PosizioneSilo(5)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo6", CStr(Silo2S7PosizioneSilo(6)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo7", CStr(Silo2S7PosizioneSilo(7)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo8", CStr(Silo2S7PosizioneSilo(8)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo9", CStr(Silo2S7PosizioneSilo(9)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "Silo2S7PosizioneSilo10", CStr(Silo2S7PosizioneSilo(10)))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione1AntiadesivoAux", CStr(SiloS7Posizione1AntiadesivoAux))
    Call FileSetValue(nomeFile, "GestioneAsseXY", "SiloS7Posizione2AntiadesivoAux", CStr(SiloS7Posizione2AntiadesivoAux))
    
    Silo2S7PosizioneSilo(11) = Silo2S7PosizioneSiloD
    Silo2S7PosizioneSilo(12) = Silo2S7PosizioneSiloR

End Sub

