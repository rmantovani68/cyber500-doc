Attribute VB_Name = "GestioneAdditivi"

Option Explicit

Public AgitatoreBacinella As Boolean

Public InclusioneAgitatore As Boolean
Public AbilitaInversioneAdditivoBacinella As Boolean

Public VoltMaxContalitri As Integer
Public VoltMinContalitri As Integer
Public DensitaContalitri As Double
Public ContalitriImpulsiLitro As Double
Public ContalitriTempoMaxSpruzzatura As Integer
Public InclusioneAquablack As Boolean
Public MaxValKgAquablack As Double


'

Public Sub AdditivoAcqua(inMoto As Boolean)
    If (inMoto) Then
        CP240.ImgAdditivo(0).Picture = LoadResPicture("IDB_ACQUA_ON", vbResBitmap)
    Else
        CP240.ImgAdditivo(0).Picture = LoadResPicture("IDB_ACQUA", vbResBitmap)
    End If
End Sub

Public Sub AdditivoSacchi(inMoto As Boolean)
    If (inMoto) Then
        CP240.ImgAdditivo(30).Picture = LoadResPicture("IDB_ADDITIVOSACCHION", vbResBitmap)
    Else
        CP240.ImgAdditivo(30).Picture = LoadResPicture("IDB_ADDITIVOSACCHI", vbResBitmap)
    End If
End Sub

Public Sub AdditivoNelMixer(inMoto As Boolean)
    If (inMoto) Then
        CP240.ImgAdditivo(12).Picture = LoadResPicture("IDB_ADD_MIXER_ON", vbResBitmap)
    Else
        CP240.ImgAdditivo(12).Picture = LoadResPicture("IDB_ADD_MIXER", vbResBitmap)
    End If
End Sub

Public Sub AdditivoNellaBacinella(inMoto As Boolean)
    If (inMoto) Then
        CP240.ImgAdditivo(22).Picture = LoadResPicture("IDB_ADD_BACINELLA_ON", vbResBitmap)
    Else
        CP240.ImgAdditivo(22).Picture = LoadResPicture("IDB_ADD_BACINELLA", vbResBitmap)
    End If
End Sub

Public Sub ScaricoAcqua_change()
    Call AdditivoAcqua(ScaricoAcqua)
End Sub


Public Sub ScaricoAdditivo_change(additivo As Integer)

    On Error GoTo Errore

    'è il PLC che mi dice se sta funzionando
    Select Case additivo

        Case 0
            Call AdditivoNelMixer(ScaricoAdditivo(additivo))

        Case 1
            If (ScaricoAdditivo(additivo)) Then
                If InclusioneAgitatore Then
                    AgitatoreBacinella = True
                End If
            End If
            Call AdditivoNellaBacinella(ScaricoAdditivo(additivo))
            
    End Select

    Exit Sub
Errore:
    LogInserisci True, "ADD-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub GestioneAdditivoSacchi()

On Error GoTo Errore

    If InclusioneAddSacchi Then
        Call AdditivoSacchi(ScaricoAddSacchi)
    End If

    Exit Sub
Errore:
    LogInserisci True, "ADD-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub AntiadesivoScivoloScaricoBilanciaRAP_change()

    Call AntiadesivoScivoloScaricoBilanciaRAP(AntiadesivoScivoloScarBilRAP.spruzzatura_on)

End Sub

Public Sub AntiadesivoScivoloScaricoBilanciaRAP(inMoto As Boolean)

    If (inMoto) Then
        CP240.ImgAdditivo(40).Picture = LoadResPicture("IDB_ACQUA_ON", vbResBitmap)
    Else
        CP240.ImgAdditivo(40).Picture = LoadResPicture("IDB_ACQUA", vbResBitmap)
    End If

End Sub

'20160421
Public Sub PesataViatopScarMixer_change(Index As Integer)
    On Errore GoTo Errore
    If (Index = 0) Then
        ComponenteInPesata DosaggioViatopScarMixer1, BilanciaViatopScarMixer1.OutPesata
    Else
        ComponenteInPesata DosaggioViatopScarMixer2, BilanciaViatopScarMixer2.OutPesata
    End If
    Exit Sub
Errore:
    LogInserisci True, "DOS-020", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
Public Sub ScaricoViatopScarMixer_change(Index As Integer)
    On Error GoTo Errore
    If (Index = 0) Then
        CP240.ProgressBil(31).BackColor = IIf(BilanciaViatopScarMixer1.OutScarico, vbGreen, &H80FFFF)
    Else
        CP240.ProgressBil(32).BackColor = IIf(BilanciaViatopScarMixer2.OutScarico, vbGreen, &H80FFFF)
    End If
    If (BilanciaViatopScarMixer1.OutScarico Or BilanciaViatopScarMixer2.OutScarico) Then
        Call RiempiBufferViatopScarMixer
        Debug.Print ("scrivi netti")
    End If
                
    Exit Sub
Errore:
    LogInserisci True, "DOS-023", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
Public Sub BilanciaViatopScarMixerPeso_change(Index As Integer)
    On Error GoTo Errore

    With CP240
        If (Index = 0) Then
            .ProgressBil(31).Value = BilanciaViatopScarMixer1.Peso
            .ProgressBil(31).caption = Format(BilanciaViatopScarMixer1.Peso, "##0.0")
            .ProgressBil(31).max = BilanciaViatopScarMixer1.FondoScala
            '20161104
            If FrmTaraBilancePN.Visible And BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP Then
                FrmTaraBilancePN.lblValore.caption = Format(BilanciaViatopScarMixer1.Peso, "#,##0.0")
            End If
            '
            '20170222
            If DosaggioViatopScarMixer1.pesataAttiva Then
                Call PbarNettoPesata(DosaggioViatopScarMixer1, BilanciaViatopScarMixer1.Peso)
            End If
            '
        
        Else
            .ProgressBil(32).Value = BilanciaViatopScarMixer2.Peso
            .ProgressBil(32).caption = Format(BilanciaViatopScarMixer2.Peso, "##0.0")
            .ProgressBil(32).max = BilanciaViatopScarMixer2.FondoScala
            '20161104
            If FrmTaraBilancePN.Visible And BilanciaPnAttiva = BilancePnTypeEnum.BILANCIA_PN_VIATOP2 Then
                FrmTaraBilancePN.lblValore.caption = Format(BilanciaViatopScarMixer2.Peso, "#,##0.0")
            End If
            '
            '20170222
            If DosaggioViatopScarMixer2.pesataAttiva Then
                Call PbarNettoPesata(DosaggioViatopScarMixer2, BilanciaViatopScarMixer2.Peso)
            End If
            '
        
        End If
    Call GestioneSicurezzaViatopScarMixer(Index)

    End With

    Exit Sub
Errore:
    LogInserisci True, "VTP-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub
Public Sub GestioneSicurezzaViatopScarMixer(Index As Integer)
    If (Index = 0) Then
        If (BilanciaViatopScarMixer1.Peso > BilanciaViatopScarMixer1.Sicurezza) Then
            If DosaggioInCorso Then
                Call ArrestoEmergenzaDosaggio
            End If
            If (AutomaticoViatop) Then
                AutomaticoViatop = False
                BilanciaViatopScarMixer1.OutPesata = False
                BilanciaViatopScarMixer1.OutScarico = False
            End If
            CP240.ProgressBil(31).FillColor = vbRed
        Else
            CP240.ProgressBil(31).FillColor = vbBlue
        End If
    Else
        If (BilanciaViatopScarMixer1.Peso > BilanciaViatopScarMixer1.Sicurezza) Then
            If DosaggioInCorso Then
                Call ArrestoEmergenzaDosaggio
            End If
            If (AutomaticoViatop) Then
                AutomaticoViatop = False
                BilanciaViatopScarMixer1.OutPesata = False
                BilanciaViatopScarMixer1.OutScarico = False
            End If
            CP240.ProgressBil(31).FillColor = vbRed
        Else
            CP240.ProgressBil(31).FillColor = vbBlue
        End If
    End If
End Sub

Public Sub GestioneImmagineCompressoreViatopScarMixer(Index As Integer)
    If (Index = 0) Then
        If (BilanciaViatopScarMixer1.RitCompressore) Then
            CP240.CmdComprViatop(31).Picture = LoadResPicture("IDB_VIATOPSCARMIX_COMPON", vbResBitmap)
        Else
            CP240.CmdComprViatop(31).Picture = LoadResPicture("IDB_VIATOPSCARMIX_COMPOFF", vbResBitmap)
        End If
    Else
        If (BilanciaViatopScarMixer2.RitCompressore) Then
            CP240.CmdComprViatop(32).Picture = LoadResPicture("IDB_VIATOPSCARMIX_COMPON", vbResBitmap)
        Else
            CP240.CmdComprViatop(32).Picture = LoadResPicture("IDB_VIATOPSCARMIX_COMPOFF", vbResBitmap)
        End If
    End If
End Sub
'20160421
