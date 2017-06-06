Attribute VB_Name = "ParaTabLeg"
'
'   Gestione dei parametri del legante
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE_PLUS As String = "Bitume"


'   Lettura del file
Public Function ParaTabLeg_ReadFile() As Boolean

    ParaTabLeg_ReadFile = False

    VoltPompaLegante = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "VoltPompaLegante"))
    TempMinimaBitume = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "TempMinimaBitume"))
    TempMinimaEmulsione = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "TempMinimaEmulsione"))
    MaggiorazionePesataBitume = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "MaggiorazionePesataBitume"))
    BitumeGravita = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "BitumeGravita"))
    BitumeKgFinali = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "BitumeKgFinali"))
    AbilitaInversionePCL = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaInversionePCL"))
    AbilitaValv3VieSpruzzatriceBitume = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaValv3VieSpruzzatriceBitume"))
    AbilitaValvolaConsensoBitumeNeutro = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaValvolaConsensoBitumeNeutro"))

    AbilitaValvolaBitumeEmulsione = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaValvolaEmulsioneBitume"))
    ParamCheckBitumenDosage = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "ParamCheckBitumenDosage"))

    Pcl1AutoOn = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "Pcl1AutoOn"))
    Pcl2AutoOn = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "Pcl2AutoOn"))
    Pcl1Inverter = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "Pcl1Inverter"))
    Pcl2Inverter = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "Pcl2Inverter"))
    SetPcl1 = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "SetPcl1"))
    SetPcl2 = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "SetPcl2"))
    AbilitaSelettoreBitume1 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaSelettoreBitume1"))
    AbilitaSelettoreBitume2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaSelettoreBitume2"))
    InclusioneBitume3 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "InclusioneBitume3"))
    InclusioneBitume2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "InclusioneBitume2"))
    InclusioneBacinella2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "InclusioneBacinella2"))
    InclusioneBitumeEsterno = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "InclusioneBitumeEsterno"))

    AbilitaTemperaturaLeganteBacinella = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "TemperaturaLeganteBacinella"))
    InclusioneTemperaturaLineaCaricoBitume = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "InclusioneTemperaturaLineaCaricoBitume"))

    AbilitaSicurezzaGalleggianteB2 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaSicurezzaGalleggianteB2"))
    AbilitaSicurezzaGalleggianteB3 = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaSicurezzaGalleggianteB3"))

    AbilitaInverterSpruzzaturaLegante = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "AbilitaInverterSpruzzaturaLegante"))
    Bitume2InBlending = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "Bitume2InBlending"))
    'Contalitri.inclusione = String2Bool(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "InclusioneContalitri")) '20161128
    'Contalitri.RapportoImpulsi = String2Int(ParameterPlus.GetParameterValue(SEZIONE_PLUS, "", "", "RapportoImpulsi"))'20161128

    ParaTabLeg_ReadFile = True
        

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabLeg_Apply()

    With CP240

        'Se ho la seconda bacinella devo far vedere il pulsante per lo scambio
        .AniPushButtonDeflettore(6).Visible = AbilitaSelettoreBitume1
        .AniPushButtonDeflettore(19).Visible = AbilitaSelettoreBitume2

        If BitumeInSpruzzatura Then
            CP240.ProgressBil(2).BackColor = vbGreen
        Else
            CP240.ProgressBil(2).BackColor = &H80FFFF
        End If

        .imgValvolaCisterne(cstIndiceImmagineValvola3VieBitumeEsterno).Visible = InclusioneBitumeEsterno

        '   Abilita la rilevazione della temperatura legante in bacinella
        .Image10(6).Visible = AbilitaTemperaturaLeganteBacinella
        .LblTempBitume(1).Visible = AbilitaTemperaturaLeganteBacinella
        .LblEtichetta(197).Visible = AbilitaTemperaturaLeganteBacinella

        .Frame1(42).Visible = AbilitaValv3VieSpruzzatriceBitume
        If AbilitaValv3VieSpruzzatriceBitume Then
            .CmdNettiSiloStoricoSommaSalva(8).Picture = LoadResPicture("IDI_MARCIA", vbResIcon)
            .CmdNettiSiloStoricoSommaSalva(9).Picture = LoadResPicture("IDI_ARRESTO", vbResIcon)
            .imgValvolaCisterne(1).Picture = LoadResPicture("IDB_CAMIONSPRUZZATRICE_OFF", vbResBitmap)
        End If
        .imgValvolaCisterne(2).Visible = AbilitaValvolaConsensoBitumeNeutro

        .TxtMaggiorazioneBitume.text = MaggiorazionePesataBitume

        .imgValvolaCisterne(4).Visible = (AbilitaValvolaBitumeEmulsione = 1 Or AbilitaValvolaBitumeEmulsione = 2)
        .LblEtichetta(72).Visible = (AbilitaValvolaBitumeEmulsione = 1 Or AbilitaValvolaBitumeEmulsione = 2)

    End With

End Sub

