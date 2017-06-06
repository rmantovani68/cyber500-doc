Attribute VB_Name = "GestioneViatop"

Option Explicit


Public InclusioneViatop As Boolean
Public ScaricoBilanciaViatopChiuso As Boolean
Public LivelloMinViatop As Boolean
Public CicloneMinViatop As Boolean
Public ScaricoCicloneViatopChiuso As Boolean
Public ComandoVentolaViatop As Boolean
Public ComandoPesataViatop As Boolean
Public ComandoScaricoBilanciaViatop As Boolean
Public ComandoScaricoCicloneViatop As Boolean
Public AutomaticoViatop As Boolean
Public NettoViatop As Double
Public NettoViatopBuffer(0 To 1) As Double 'Netto Viatop 1° scarico e 2° scarico
Public PermanenzaScaricoBilanciaViatop As Integer
Public PermanenzaScaricoCicloneViatop As Integer
'


Public Sub BilanciaViatopPeso_change()

    On Error GoTo Errore

    With CP240

        .ProgressBil(4).Value = BilanciaViatop.Peso
        .ProgressBil(4).caption = Format(BilanciaViatop.Peso, "##0.0")
        .ProgressBil(4).max = BilanciaViatop.FondoScala

    Call GestioneSicurezzaViatop

'20170224
    If PesaturaManuale And BilanciaViatop.CompAttivo >= 0 Then
        '20170302
        'Call PbarNettoPesata(DosaggioViatop, BilanciaViatop.Peso, ScManualeViatop(BilanciaViatop.CompAttivo).Peso, True)
        Call PbarNettoPesata(DosaggioViatop, BilanciaViatop.Peso, ScManualeViatop.Peso, True)
    ElseIf BilanciaViatop.CompAttivo >= 0 Then
        Call PbarNettoPesata(DosaggioViatop, BilanciaViatop.Peso)
    End If
    '

    End With

    Exit Sub
Errore:
    LogInserisci True, "VTP-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub GestioneSicurezzaViatop()

    If (BilanciaViatop.Peso > BilanciaViatop.Sicurezza) Then
        If DosaggioInCorso Then
            Call ArrestoEmergenzaDosaggio
        End If
        If (AutomaticoViatop) Then
            AutomaticoViatop = False
            ComandoScaricoBilanciaViatop = False
            ComandoPesataViatop = False
        End If
        CP240.ProgressBil(4).FillColor = vbRed
    Else
        CP240.ProgressBil(4).FillColor = vbBlue
    End If

End Sub


Public Sub ValoreLivelloMinViatop_change()
'Livello minimo del Big Bag.

    On Error GoTo Errore

    With CP240
        If (LivelloMinViatop) Then
            .PrbTrLivello(16).Value = 10
            .PrbTrLivello(16).Visible = True
        Else
            .PrbTrLivello(16).Visible = False
        End If
    End With
    
    Exit Sub
Errore:
    LogInserisci True, "VTP-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub SegnalazioneLivelloMinViatop(attivo As Boolean)
'Livello minimo del Big Bag.

    On Error GoTo Errore

    If attivo Then
        CP240.PctTrLivello(16).Visible = Not CP240.PctTrLivello(16).Visible
    Else
        CP240.PctTrLivello(16).Visible = False
    End If
    
    Exit Sub
Errore:
    LogInserisci True, "VTP-003", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub CicloneMinViatop_Change()
    'Livello minimo ciclone

    On Error GoTo Errore

    With CP240
        If (CicloneMinViatop) Then
            .PrbTrLivello(30).Value = 10
        Else
            .PrbTrLivello(30).Value = 75
        End If
    End With
    
    If CicloneMinViatop And Not FronteScCicloneViatopManuale And PesaturaManuale Then
        '20170302
        'PesoTotaleViatopManuale = PesoTotaleViatopManuale + ScManualeViatop(CompViatop).PesoBuffer
        'ScManualeViatop(CompViatop).PesoBuffer = 0
        PesoTotaleViatopManuale = PesoTotaleViatopManuale + ScManualeViatop.PesoBuffer
        ScManualeViatop.PesoBuffer = 0

        '20160421
        'TotaleKgMescImpastoMan = Round(PesoTotaleAggregatiManuale + PesoTotaleFillerManuale + PesoTotaleBitumeManuale + PesoTotaleRiciclatoManuale + PesoTotaleViatopManuale + ScManualeAcqua.Peso + ScManualeAddMesc.Peso, 0)
        TotaleKgMescImpastoMan = Round(PesoTotaleAggregatiManuale + PesoTotaleFillerManuale + PesoTotaleBitumeManuale + PesoTotaleRiciclatoManuale + PesoTotaleViatopManuale + PesoTotaleViatopScarMixer1Manuale + PesoTotaleViatopScarMixer2Manuale + ScManualeAcqua.Peso + ScManualeAddMesc.Peso, 0)
        CP240.LblKgDosaggio(2).caption = TotaleKgMescImpastoMan
        '20160421
    
    End If
    FronteScCicloneViatopManuale = CicloneMinViatop
    
    Exit Sub
Errore:
    LogInserisci True, "VTP-004", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ScaricoBilanciaViatopChiuso_change()

    On Error GoTo Errore

    With CP240

    End With
    
    Exit Sub
Errore:
    LogInserisci True, "VTP-005", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ScaricoCicloneViatopChiuso_Change()

    On Error GoTo Errore

    With CP240

        If ScaricoCicloneViatopChiuso Then
            .ImageViatop(2).Picture = LoadResPicture("IDB_TRAMOGGIAVIATOPOFF", vbResBitmap)
        Else
            .ImageViatop(2).Picture = LoadResPicture("IDB_TRAMOGGIAVIATOPON", vbResBitmap)

            If (AutomaticoViatop) Then
                NettoViatopBuffer(1) = NettoViatopBuffer(0)
            End If
        End If

    End With

    Exit Sub
Errore:
    LogInserisci True, "VTP-006", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ComandoVentolaViatop_Change()

    On Error GoTo Errore

    With CP240


    End With
        
    Exit Sub
Errore:
    LogInserisci True, "VTP-007", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ComandoPesataViatop_Change()

    On Error GoTo Errore

    With CP240
    
        If ComandoPesataViatop Then
            .ImageViatop(1).Picture = LoadResPicture("IDB_TRAMOGGIAVIATOPON", vbResBitmap)
    
            '201700224
            BilanciaViatop.CompAttivo = ComponenteEnum.CompViatop
                            
            If Not SospensionePesatura Then
                DosaggioViatop.memTaraPesoNetto = BilanciaViatop.Peso
            End If
            '
        Else
            .ImageViatop(1).Picture = LoadResPicture("IDB_TRAMOGGIAVIATOPOFF", vbResBitmap)
        End If
    
    End With
    
    
    
    Exit Sub
Errore:
    LogInserisci True, "VTP-008", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ComandoScaricoBilanciaViatop_Change()
    
    On Error GoTo Errore

    With CP240
        If ComandoScaricoBilanciaViatop Then
            .ProgressBil(4).BackColor = vbGreen
'20170224
            BilanciaViatop.CompAttivo = -1 '20170223
            If Not PesaturaManuale Then Call InitPbarNettoPesata(CompGrafViatop, CompGrafViatop)
'
        Else
            .ProgressBil(4).BackColor = &H80FFFF
            
            NettoViatopBuffer(0) = NettoViatop
            If (AutomaticoViatop) Then
                Call ComponentePesoOut(DosaggioViatop, NettoViatopBuffer(0))
            End If
        End If
    
    End With
    
    Exit Sub
Errore:
    LogInserisci True, "VTP-009", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Public Sub ComandoScaricoCicloneViatop_Change()

    On Error GoTo Errore

    With CP240


    End With

    Exit Sub
Errore:
    LogInserisci True, "VTP-010", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

