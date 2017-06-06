Attribute VB_Name = "ParaTabAdd"
'
'   Gestione dei parametri degli addittivi
'
'   2006 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const SEZIONE As String = "Addittivi"


'   Lettura del file
Public Function ParaTabAdd_ReadFile() As Boolean

    ParaTabAdd_ReadFile = False


    'CYBERTRONIC_PLUS

    '<Paragraph Code="Acqua">
    InclusioneAcqua = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Acqua", "", "Presente"))
    PortataAcqua = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Acqua", "", "PortataAcqua"))
    PercConsensoFiller = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Acqua", "", "PercConsensoFiller"))
    PercConsensoAcqua = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Acqua", "", "PercConsensoAcqua"))

    '<Paragraph Code="AdditivoBacinella">
    InclusioneAddBacinella = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "Presente"))
    PortataAddBacinella = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "PortAddBacinella"))
    InclusioneAgitatore = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "InclusioneAgitatore"))
    AbilitaInversioneAdditivoBacinella = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "AbilitaInversioneAdditivoBacinella"))

    AdditivoBacinella.densita = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "DensAdditivoBacinella"))
    AdditivoBacinella.impulsiLitro = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "ImpLitroAdditivoBacinella"))
    AdditivoBacinella.rampaFrenatura = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "RampaFrenAAdditivoBacinella"))
    AdditivoBacinella.tempoSicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "TempoSicAdditivoBacinella"))
    AdditivoBacinella.modoContalitri = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "InclContalAdditivoBacinella"))
    AdditivoBacinella.presenzaValvola = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "InclValvAdditivoBacinella"))

    '<Paragraph Code="AdditivoMescolatore">
    InclusioneAddMescolatore = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoMescolatore", "", "Presente"))
    PortataAddMescolatore = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoMescolatore", "", "PortAddMixer"))
    DensAddMixer = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoMescolatore", "", "DensAddMixer"))
    InclMinFlussoAddBacinella = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "InclMinFlussoAddBacinella")) '20150924
    TempoMinFlussoAddBacinella = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "AdditivoBacinella", "", "TempoMinFlussoAddBacinella")) '20150924
    
    '<Paragraph Code="Contalitri">
    InclusioneAddContalitri = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Contalitri", "", "Presente"))
    VoltMaxContalitri = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Contalitri", "", "VoltMaxContalitri"))
    VoltMinContalitri = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Contalitri", "", "VoltMinContalitri"))
    DensitaContalitri = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Contalitri", "", "DensitaContalitri"))
    ContalitriImpulsiLitro = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Contalitri", "", "ContalitriImpulsiLitro"))
    ContalitriTempoMaxSpruzzatura = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Contalitri", "", "ContalitriTempoMaxSpruzzatura"))

    '<Paragraph Code="Flomac">
    InclusioneAddFlomac = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Flomac", "", "Presente"))

    '<Paragraph Code="Sacchi">
    InclusioneAddSacchi = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Sacchi", "", "Presente"))
    GestionePesoSacchi = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Sacchi", "", "GestionePesoSacchi"))

    '<Paragraph Code="Viatop">
    InclusioneViatop = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "Presente"))
    BilanciaViatop.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "PresenzaBilPNet")) '20161024
    BilanciaViatop.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "NumDecBilPNet")) '20161024
    BilanciaViatop.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "PortataMaxBilViatop"))
    BilanciaViatop.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "TaraViatop"))
    BilanciaViatop.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "SicurezzaViatop"))
    PermanenzaScaricoBilanciaViatop = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "PermanenzaScaricoBilanciaViatop"))
    PermanenzaScaricoCicloneViatop = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Viatop", "", "PermanenzaScaricoCicloneViatop"))
    
    '20160419
    '<Paragraph Code="ViatopScarMixer1">
    BilanciaViatopScarMixer1.Presenza = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "Presente"))
    BilanciaViatopScarMixer1.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "PresenzaBilPNet")) '20161024
    BilanciaViatopScarMixer1.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "NumDecBilPNet")) '20161024
    BilanciaViatopScarMixer1.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "FondoScalaViatop"))
    BilanciaViatopScarMixer1.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "TaraViatop"))
    BilanciaViatopScarMixer1.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "SicurezzaViatop"))
    BilanciaViatopScarMixer1.PermanenzaScarico = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "PermanenzaScaricoBilanciaViatop")) * 1000
    BilanciaViatopScarMixer1.TimeoutScarico = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "TimeoutScaricoBilancia")) * 1000
    BilanciaViatopScarMixer1.AnticipoCompressore = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "AnticipoCompressore")) * 1000
    BilanciaViatopScarMixer1.RitardoCompressore = String2Long(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer1", "", "RitardoCompressore")) * 1000
    
    '<Paragraph Code="ViatopScarMixer2">
    BilanciaViatopScarMixer2.Presenza = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "Presente"))
    BilanciaViatopScarMixer2.ProfiNet = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "PresenzaBilPNet")) '20161024
    BilanciaViatopScarMixer2.NumeroDecimali = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "NumDecBilPNet")) '20161024
    BilanciaViatopScarMixer2.FondoScala = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "FondoScalaViatop"))
    BilanciaViatopScarMixer2.Tara = String2Double(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "TaraViatop"))
    BilanciaViatopScarMixer2.Sicurezza = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "SicurezzaViatop"))
    BilanciaViatopScarMixer2.PermanenzaScarico = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "PermanenzaScaricoBilanciaViatop")) * 1000
    BilanciaViatopScarMixer2.TimeoutScarico = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "TimeoutScaricoBilancia")) * 1000
    BilanciaViatopScarMixer2.AnticipoCompressore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "AnticipoCompressore")) * 1000
    BilanciaViatopScarMixer2.RitardoCompressore = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "ViatopScarMixer2", "", "RitardoCompressore")) * 1000
    '<Paragraph Code="Aquablack">
    '20160419
    
    InclusioneAquablack = String2Bool(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "Presente"))
    MaxValKgAquablack = String2Int(ParameterPlus.GetParameterValue(SEZIONE, "Aquablack", "", "MaxValKgAquablack"))
    

    ParaTabAdd_ReadFile = True

End Function


'   Applica i valori modificati a chi li utilizza
Public Sub ParaTabAdd_Apply()

    With CP240

        '--------------------------------------------------------------------------
        'CONTROLLO INSERIMENTO ADDITIVO A TEMPO NEL MESCOLATORE.
        .LblAdd(0).Visible = InclusioneAddMescolatore
        .LblAdd(0).enabled = InclusioneAddMescolatore
        .ImgAdditivo(12).Visible = InclusioneAddMescolatore
        .FrameAdd(1).Visible = InclusioneAddMescolatore
        .ImgAdditivo(12).Picture = LoadResPicture("IDB_ADD_MIXER", vbResBitmap)
        .LblAdd(2).Visible = InclusioneAddMescolatore
        '.lblEtichetta(42).Visible = InclusioneAddMescolatore
        Call AdditivoNelMixer(False)

        '--------------------------------------------------------------------------
        'CONTROLLO INSERIMENTO ADDITIVO A TEMPO NELLA PESATURA LEGANTE.
        .LblAdd(1).Visible = InclusioneAddBacinella And (Not AdditivoBacinella.modoContalitri)
        .LblAdd(1).enabled = InclusioneAddBacinella

        .ImgAdditivo(22).Visible = InclusioneAddBacinella
        .FrameAdd(2).Visible = InclusioneAddBacinella
        .ImgAdditivo(22).Picture = LoadResPicture("IDB_ADD_BACINELLA", vbResBitmap)
        .LblAdd(3).Visible = InclusioneAddBacinella And (Not AdditivoBacinella.modoContalitri)
        .LblAdd(6).Visible = InclusioneAddBacinella And AdditivoBacinella.modoContalitri
        .LblAdd(7).Visible = InclusioneAddBacinella And AdditivoBacinella.modoContalitri
        .LblAdd(8).Visible = InclusioneAddBacinella And AdditivoBacinella.modoContalitri
        .TextTempiRitardoSc(18).Visible = InclusioneAddBacinella And AdditivoBacinella.modoContalitri

        Call AdditivoNellaBacinella(False)
        .LblAddSacchi(0).Visible = InclusioneAddSacchi And Not GestionePesoSacchi
        .LblAddSacchi(1).Visible = False
        '20160428
        '.Frame1(35).Visible = (InclusioneAddMescolatore Or InclusioneAddBacinella Or InclusioneAddSacchi Or InclusioneAddContalitri Or InclusioneAcqua)
        '20160428
        .LblAddSacchi(0).enabled = InclusioneAddSacchi
        .ImgAdditivo(30).Visible = InclusioneAddSacchi

        .FrameAdd(3).Visible = InclusioneAddSacchi

        '20161024
        .FrameAdd(4).Visible = InclusioneAquablack
        '

        Call AdditivoSacchi(False)

        .LblAdd(4).Visible = InclusioneAcqua
        .LblAdd(4).enabled = InclusioneAcqua
        .LblAdd(5).Visible = InclusioneAcqua
        .ImgAdditivo(0).Visible = InclusioneAcqua
        .FrameAdd(0).Visible = InclusioneAcqua
        .TextTempiRitardoSc(7).Visible = InclusioneAcqua
        Call AdditivoAcqua(False)
        .TextTempiRitardoSc(8).Visible = InclusioneAddContalitri
        .Frame1(14).Visible = InclusioneViatop
        '20160428
        '.Frame1(1).Visible = InclusioneViatop
        '20160428
        .ProgressBil(4).Visible = InclusioneViatop

        .Frame1(16).Visible = InclusioneAddFlomac
        .Frame1(16).BackColor = &H808080

        .ImgAdditivo(40).Visible = AntiadesivoScivoloScarBilRAP.presente
        .AniPushGenerico(1).Visible = AntiadesivoScivoloScarBilRAP.presente
        .TextTempiRitardoSc(15).Visible = AntiadesivoScivoloScarBilRAP.presente
        .LblKgAddSacchi.Visible = GestionePesoSacchi

    End With
    
End Sub

