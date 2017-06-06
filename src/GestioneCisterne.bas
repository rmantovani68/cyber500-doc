Attribute VB_Name = "GestioneCisterneSingole"
'
'   Gestione semplificata delle cisterne
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit



Public Sub CisterneLeggiDatiPLC()

    Call LeggiDatiPLCCisterneBitume
    Call LeggiDatiPLCCisterneEmulsione
    Call LeggiDatiPLCCisterneCombustibile
    
    Call LeggiDatiDaCaldaie
    'Call LeggiDatiContalitri   '20161128

    If CistGestione.RegolazioneTemperatura Then
        Call LeggiDatiRegolazioneTempCisterne
    End If
    
    Call LeggiDatiPidComandiCisterne(0) 'Regolazione riscaldamento mixer
    
End Sub


Public Sub CisterneScriviDatiPLC()

    Call ScriviDatiPLCCisterne

    Call ScriviDatiPLCCisterneRid '20150505
    
End Sub


Public Sub CistInizializza()

    Dim indice As Integer
    
    Call CaricaParametriCisterne
    
    With CP240
        
 '20150505
        If CistGestione.Gestione = GestioneSemplificata Then
                        
            .cmbGestioneCisterne(14).Clear 'PCL1
            .cmbGestioneCisterne(6).Clear 'PCL2
                                 
            .cmbGestioneCisterne(14).AddItem "0"
            .cmbGestioneCisterne(6).AddItem "0"
                        
            If (CistGestione.NumCisterneBitume <> CistGestione.NumeroCistBitSuPCL1) And ListaMotori(MotorePCL2).presente Then
                'caso 2 pompe circolazione presenti con cisterne assegnate a due circuiti indipendenti
                .Frame1(61).Visible = True
                                                                      
                For indice = 1 To (CistGestione.NumCisterneBitume)
                    If indice <= CistGestione.NumeroCistBitSuPCL1 Then
                       .cmbGestioneCisterne(14).AddItem CStr(indice)
                    Else
'20151027
'                       .cmbGestioneCisterne(6).AddItem CStr(indice - CistGestione.NumeroCistBitSuPCL1)
                       .cmbGestioneCisterne(6).AddItem CStr(indice)
'
                    End If
                Next indice
            Else
                'caso 1 o 2 pompe circolazione presenti con cisterne assegnate ad un solo circuito
                .Frame1(61).Visible = False
                                                                      
                For indice = 1 To (CistGestione.NumCisterneBitume)
                    .cmbGestioneCisterne(14).AddItem CStr(indice)
                Next indice
            End If
                                       
            For indice = 0 To 5
                .PctCistLivello(indice).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
                .PctCistTemperatura(indice).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
            Next indice
            
            Exit Sub
        End If
'
        .CmdTipoPesate(6).Visible = CistGestione.InclusioneComandi
        
        For indice = 0 To 5
            .PctCistLivello(indice).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
            .PctCistTemperatura(indice).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
        Next indice
        
        .PctCistLivello(200).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)
        .PctCistTemperatura(200).Picture = LoadResPicture("IDI_ESCLAMA", vbResIcon)

        .cmbGestioneCisterne(0).Clear
        .cmbGestioneCisterne(1).Clear
        .cmbGestioneCisterne(2).Clear
        .cmbGestioneCisterne(3).Clear
        .cmbGestioneCisterne(4).Clear
        .cmbGestioneCisterne(11).Clear
        .cmbGestioneCisterne(12).Clear
        .cmbGestioneCisterne(13).Clear
        .cmbGestioneCisterne(21).Clear
        .cmbGestioneCisterne(22).Clear
        .cmbGestioneCisterne(23).Clear

        For indice = 0 To 3
            .cmbGestioneCisterne(0).AddItem LoadXLSString(1214 + indice)
        Next indice
        
        For indice = 0 To 2
            .cmbGestioneCisterne(5).AddItem LoadXLSString(1214 + indice)
        Next indice
        
        For indice = 0 To 1
            .cmbGestioneCisterne(5).AddItem LoadXLSString(1218 + indice)
        Next indice
        
        .cmbGestioneCisterne(5).AddItem LoadXLSString(1470)

        For indice = 0 To 4
            If CistGestione.ListaOperazioniEmulsione(indice) Then
                .cmbGestioneCisterne(10).AddItem LoadXLSString(1214 + indice)
            End If
        Next indice
                   
        For indice = 0 To CistGestione.NumCisterneBitume - 1
            .cmbGestioneCisterne(1).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(2).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(3).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(4).AddItem CStr(indice + 1)
        Next indice
        
        For indice = 0 To CistGestione.NumCisterneEmulsione - 1
            .cmbGestioneCisterne(11).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(12).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(13).AddItem CStr(indice + 1)
        Next indice
        
        For indice = 0 To CistGestione.NumCisterneCombustibile - 1
            .cmbGestioneCisterne(21).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(22).AddItem CStr(indice + 1)
            .cmbGestioneCisterne(23).AddItem CStr(indice + 1)
        Next indice
        
    End With

End Sub

Public Sub CistVisualizzaValvolaUscita1(cisterna As Integer, aperta As Boolean, chiusa As Boolean, allarme As Boolean)

    With CP240

        If (allarme Or aperta = chiusa) Then

            .ImgCistValvolaUscita1(cisterna).Picture = LoadResPicture("IDI_VALVOLAERROREFRECCIASU", vbResIcon)
'            FormVistaCisterne.ImgValvCistOut(cisterna).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)

        ElseIf (aperta) Then

            .ImgCistValvolaUscita1(cisterna).Picture = LoadResPicture("IDI_VALVOLAONFRECCIASU", vbResIcon)
'            FormVistaCisterne.ImgValvCistOut(cisterna).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)

        Else

            .ImgCistValvolaUscita1(cisterna).Picture = LoadResPicture("IDI_VALVOLAFRECCIASU", vbResIcon)
'            FormVistaCisterne.ImgValvCistOut(cisterna).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)

        End If

    End With

End Sub

Public Sub CistVisualizzaValvolaUscita2(cisterna As Integer, aperta As Boolean, chiusa As Boolean, allarme As Boolean)

    With CP240

        If (allarme Or aperta = chiusa) Then

            .ImgCistValvolaUscita2(cisterna).Picture = LoadResPicture("IDI_VALVOLAERROREFRECCIAGIU", vbResIcon)
'            FormVistaCisterne.ImgValvCistOut2(cisterna).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)

        ElseIf (aperta) Then

            .ImgCistValvolaUscita2(cisterna).Picture = LoadResPicture("IDI_VALVOLAONFRECCIAGIU", vbResIcon)
'            FormVistaCisterne.ImgValvCistOut2(cisterna).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)

        Else

            .ImgCistValvolaUscita2(cisterna).Picture = LoadResPicture("IDI_VALVOLAFRECCIAGIU", vbResIcon)
'            FormVistaCisterne.ImgValvCistOut2(cisterna).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)

        End If

    End With

End Sub

Public Sub CistVisualizzaValvolaEntrata1(cisterna As Integer, aperta As Boolean, chiusa As Boolean, allarme As Boolean)

    With CP240

        If (allarme Or aperta = chiusa) Then

            .ImgCistValvolaEntrata1(cisterna).Picture = LoadResPicture("IDI_VALVOLAERROREFRECCIAGIU", vbResIcon)
'            FormVistaCisterne.ImgValvCistIn(cisterna).Picture = LoadResPicture("IDB_VALVOLAERRORE", vbResBitmap)

        ElseIf (aperta) Then

            .ImgCistValvolaEntrata1(cisterna).Picture = LoadResPicture("IDI_VALVOLAONFRECCIAGIU", vbResIcon)
'            FormVistaCisterne.ImgValvCistIn(cisterna).Picture = LoadResPicture("IDB_VALVOLAON", vbResBitmap)

        Else

            .ImgCistValvolaEntrata1(cisterna).Picture = LoadResPicture("IDI_VALVOLAFRECCIAGIU", vbResIcon)
'            FormVistaCisterne.ImgValvCistIn(cisterna).Picture = LoadResPicture("IDB_VALVOLA", vbResBitmap)

        End If

    End With

End Sub

Public Sub CistVisualizzaUscita(cisterna As Integer)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNACARICO", vbResBitmap)

    End With

End Sub

'20150505
Public Sub CistVisualizzaSelezione(cisterna As Integer)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNAON", vbResBitmap)

    End With

End Sub

Public Sub CistVisualizzaErrore(cisterna As Integer)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNAALLARME", vbResBitmap)

    End With

End Sub

Public Sub CistVisualizzaIdle(cisterna As Integer)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNA", vbResBitmap)

    End With

End Sub

Public Sub CistVisualizzaAttesa(cisterna As Integer)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNARICIRCOLO", vbResBitmap)

    End With

End Sub
'

Public Sub CistVisualizzaCarico(cisterna As Integer)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNARICARICO", vbResBitmap)

    End With

End Sub

Public Sub CistVisualizzaRicircolo(cisterna As Integer, aperta As Boolean, chiusa As Boolean, allarme As Boolean)

    With CP240

        .ImgCist(cisterna).Picture = LoadResPicture("IDB_CISTERNARICIRCOLO", vbResBitmap)

    End With

End Sub

Public Sub CistVisualizzaTravaso(cisternaSrc As Integer, cisternaDst As Integer)

    With CP240

        .ImgCist(cisternaSrc).Picture = LoadResPicture("IDB_CISTERNATRAVASOSRC", vbResBitmap)
        .ImgCist(cisternaDst).Picture = LoadResPicture("IDB_CISTERNATRAVASODST", vbResBitmap)

    End With

End Sub

Public Sub CistVisualizzaLivello(cisterna As Integer, ByVal percento As Integer, ByVal tons As Double)

    With CP240

        .PrbCistLivello(cisterna).Value = percento
        If (tons < 0) Then
            tons = 0
        End If
        .PrbCistLivello(cisterna).caption = CStr(tons)

    End With

End Sub

Public Sub CistVisualizzaTemperatura(cisterna As Integer, ByVal Value As Double)

    With CP240

        .LblCistTemp(cisterna).caption = Format(Value, "0")

    End With

End Sub

Public Sub VisualizzaAgitatoreCisterne(cisterna As Integer, acceso As Boolean)

    With CP240
    
        If (acceso) Then
            .ImgAgitatoreCist(cisterna).Visible = False
            .ImgAgitatoreCistON(cisterna).Visible = True
            FrmComandiCisterne.APButtonAgitatore(cisterna).Value = 2
        Else
            .ImgAgitatoreCist(cisterna).Visible = True
            .ImgAgitatoreCistON(cisterna).Visible = False
            FrmComandiCisterne.APButtonAgitatore(cisterna).Value = 1
        End If
        
    
    End With

End Sub

