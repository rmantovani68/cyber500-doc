VERSION 5.00
Begin VB.Form FrmGestioneTimer 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "  MARINI"
   ClientHeight    =   9210
   ClientLeft      =   45
   ClientTop       =   210
   ClientWidth     =   8400
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9210
   ScaleWidth      =   8400
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrImpulsoRegBruc 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   500
      Left            =   4320
      Top             =   4080
   End
   Begin VB.Timer tmrImpulsoRegBruc 
      Enabled         =   0   'False
      Index           =   0
      Interval        =   500
      Left            =   3840
      Top             =   4080
   End
   Begin VB.Timer TimerResetTrasfVelDef 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   6960
      Top             =   0
   End
   Begin VB.Timer DeodoranteSili 
      Interval        =   700
      Left            =   4200
      Top             =   8520
   End
   Begin VB.Timer TimerParametriDaPlc 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   6960
      Top             =   8640
   End
   Begin VB.Timer RitardoStartBruc 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   3240
      Top             =   4080
   End
   Begin VB.Timer TmrKeyPressAndMouseMove 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   7680
      Top             =   3240
   End
   Begin VB.Timer TmoutSemaforoSili 
      Interval        =   4000
      Left            =   3480
      Top             =   8520
   End
   Begin VB.Timer TmoutSemaforoBenna 
      Interval        =   4000
      Left            =   2640
      Top             =   8520
   End
   Begin VB.Timer TimerViatopScarMixer1Man 
      Enabled         =   0   'False
      Left            =   3840
      Top             =   1320
   End
   Begin VB.Timer TimerViatopScarMixer2Man 
      Enabled         =   0   'False
      Left            =   4320
      Top             =   1320
   End
   Begin VB.Timer TmrAttesaFiltrofreddo 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   6240
      Top             =   0
   End
   Begin VB.Timer TimerAbilitaSiliDeposito 
      Enabled         =   0   'False
      Interval        =   6000
      Left            =   1680
      Top             =   8520
   End
   Begin VB.Timer TmrSyncroCmdSiloS7 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   1920
      Top             =   4560
   End
   Begin VB.Timer TimerFillerMan 
      Enabled         =   0   'False
      Left            =   1920
      Top             =   1320
   End
   Begin VB.Timer RitardoRitrasmPar 
      Interval        =   3000
      Left            =   5520
      Top             =   1320
   End
   Begin VB.Timer EmergenzaMotori 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   7800
      Top             =   600
   End
   Begin VB.Timer PlusForcingStop 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   6960
      Top             =   600
   End
   Begin VB.Timer AttesaSpegnimento 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   6240
      Top             =   600
   End
   Begin VB.Timer TimerComunicazionePLUS 
      Interval        =   500
      Left            =   5520
      Top             =   600
   End
   Begin VB.Timer tmrRitControlloPred 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   7680
      Top             =   2760
   End
   Begin VB.Timer FiltraCmd 
      Left            =   5520
      Top             =   0
   End
   Begin VB.Timer TmrCmdBruciatore 
      Left            =   2640
      Top             =   4080
   End
   Begin VB.Timer TimerViatopMan 
      Enabled         =   0   'False
      Left            =   3360
      Top             =   1320
   End
   Begin VB.Timer TimerRiciclatoMan 
      Enabled         =   0   'False
      Left            =   2880
      Top             =   1320
   End
   Begin VB.Timer TmrSoffioPredVuoto 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7080
      Top             =   2760
   End
   Begin VB.Timer TimerArrestoFilleriz 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   4320
      Top             =   7920
   End
   Begin VB.Timer TimerDeflettoreBypassRap 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   5280
      Top             =   2760
   End
   Begin VB.Timer TimerCompresFilleriz 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   3840
      Top             =   7920
   End
   Begin VB.Timer TimerBassaTemperaturaScivolo 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   10000
      Left            =   5280
      Top             =   5040
   End
   Begin VB.Timer TimerAltaTemperaturaScivolo 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   10000
      Left            =   4320
      Top             =   5040
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   7
      Interval        =   500
      Left            =   4800
      Top             =   6960
   End
   Begin VB.Timer TmrBindicatorRecupero 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   1440
      Top             =   3720
   End
   Begin VB.Timer TmrBindicatorApporto 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   1920
      Top             =   3720
   End
   Begin VB.Timer TimerErrMsgQuit 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7800
      Top             =   6960
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   11
      Interval        =   3000
      Left            =   7320
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   10
      Interval        =   3000
      Left            =   6960
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   9
      Interval        =   3000
      Left            =   6600
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   8
      Interval        =   3000
      Left            =   6240
      Top             =   4560
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   6
      Interval        =   500
      Left            =   4320
      Top             =   6960
   End
   Begin VB.Timer TimerApparecchiaturaLEC1 
      Left            =   1440
      Top             =   960
   End
   Begin VB.Timer timerBruciatoreSblocco 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   5760
      Top             =   3240
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   5
      Interval        =   500
      Left            =   3840
      Top             =   6960
   End
   Begin VB.Timer TimerRitardoChiusuraPortinaSIWA 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   7320
      Top             =   6960
   End
   Begin VB.Timer TimerAbortBatch 
      Enabled         =   0   'False
      Interval        =   250
      Left            =   6840
      Top             =   6960
   End
   Begin VB.Timer TimerStopDosaggioBatchManuale 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   6360
      Top             =   6960
   End
   Begin VB.Timer TimerTaraturaSIWA 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   5880
      Top             =   6960
   End
   Begin VB.Timer TimerAckAllarmiSiloS7 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2880
      Top             =   6480
   End
   Begin VB.Timer timerSiwarexPesoRAP 
      Enabled         =   0   'False
      Interval        =   2500
      Left            =   5400
      Top             =   6960
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   4
      Interval        =   500
      Left            =   3360
      Top             =   6960
   End
   Begin VB.Timer TimerSpegniNastroAuxRiciclato 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   4800
      Top             =   2280
   End
   Begin VB.Timer TimerAzzeraStartDosaggio 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   1440
      Top             =   480
   End
   Begin VB.Timer TimerMixerPieno 
      Enabled         =   0   'False
      Interval        =   1500
      Left            =   1920
      Top             =   5040
   End
   Begin VB.Timer TimerVariazioneGrandezzaDosaggio 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2400
      Top             =   6480
   End
   Begin VB.Timer TmrSchiumato 
      Enabled         =   0   'False
      Interval        =   250
      Left            =   6840
      Top             =   7920
   End
   Begin VB.Timer TmrCodaMateriale 
      Enabled         =   0   'False
      Interval        =   250
      Left            =   1440
      Top             =   0
   End
   Begin VB.Timer TimerStartBennaS7 
      Enabled         =   0   'False
      Left            =   1440
      Top             =   4560
   End
   Begin VB.Timer TimerVibrCaricoFApp2 
      Enabled         =   0   'False
      Left            =   1920
      Top             =   7560
   End
   Begin VB.Timer TimerAckAllarmiDB61 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1920
      Top             =   6480
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   3
      Interval        =   500
      Left            =   2880
      Top             =   6960
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   2
      Interval        =   500
      Left            =   2400
      Top             =   6960
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   500
      Left            =   1920
      Top             =   6960
   End
   Begin VB.Timer TimerSiwa_Refresh 
      Enabled         =   0   'False
      Index           =   0
      Interval        =   500
      Left            =   1440
      Top             =   6960
   End
   Begin VB.Timer TrmNastroDeflettoreAnello 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   4320
      Top             =   2760
   End
   Begin VB.Timer TimerFuoriTollBitume 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7680
      Top             =   5040
   End
   Begin VB.Timer TimerFuoriToll_Agg_Fil_Ric_Via 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7200
      Top             =   5040
   End
   Begin VB.Timer TimerTagCambioVolo 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1440
      Top             =   6480
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   7
      Interval        =   3000
      Left            =   5760
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   6
      Interval        =   3000
      Left            =   5280
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   5
      Interval        =   3000
      Left            =   4800
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   4
      Interval        =   3000
      Left            =   4320
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   3
      Interval        =   3000
      Left            =   3840
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   2
      Interval        =   3000
      Left            =   3360
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   3000
      Left            =   2880
      Top             =   4560
   End
   Begin VB.Timer TimerLivelloAltoSilo 
      Enabled         =   0   'False
      Index           =   0
      Interval        =   3000
      Left            =   2400
      Top             =   4560
   End
   Begin VB.Timer TmrSetPredosatori 
      Interval        =   250
      Left            =   3840
      Top             =   2760
   End
   Begin VB.Timer TmrVibratorePredVuoto 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3360
      Top             =   2760
   End
   Begin VB.Timer TimerRitornoComandi 
      Index           =   0
      Interval        =   250
      Left            =   6360
      Top             =   5040
   End
   Begin VB.Timer TimerTrend 
      Interval        =   1000
      Left            =   1440
      Top             =   6000
   End
   Begin VB.Timer TimerDeflettoreRiciclato 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   2880
      Top             =   2760
   End
   Begin VB.Timer TimerLCPC1sec 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1920
      Top             =   5520
   End
   Begin VB.Timer TimerLCPC 
      Interval        =   1000
      Left            =   2400
      Top             =   5520
   End
   Begin VB.Timer TimerLCPC5sec 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   1440
      Top             =   5520
   End
   Begin VB.Timer TimerRitardoLCPC5 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2880
      Top             =   5520
   End
   Begin VB.Timer TimerRitardoLCPC1 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3360
      Top             =   5520
   End
   Begin VB.Timer TimerRitardoLCPCmixer 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3840
      Top             =   5520
   End
   Begin VB.Timer TimerBassaTemperaturaScivolo 
      Enabled         =   0   'False
      Index           =   0
      Interval        =   10000
      Left            =   4800
      Top             =   5040
   End
   Begin VB.Timer TimerAltaTemperaturaScivolo 
      Enabled         =   0   'False
      Index           =   0
      Interval        =   10000
      Left            =   3840
      Top             =   5040
   End
   Begin VB.Timer TimerImpulsoRegolazioneAriaFredda 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3360
      Top             =   5040
   End
   Begin VB.Timer TimerAttesaRegolazioneAriaFredda 
      Interval        =   5000
      Left            =   2880
      Top             =   5040
   End
   Begin VB.Timer TimerBennaPiena 
      Enabled         =   0   'False
      Interval        =   4000
      Left            =   1440
      Top             =   5040
   End
   Begin VB.Timer TimerRitardoSbloccoBruciatore 
      Enabled         =   0   'False
      Left            =   5280
      Top             =   3240
   End
   Begin VB.Timer TimerVibrCaricoFApp 
      Enabled         =   0   'False
      Left            =   1440
      Top             =   7560
   End
   Begin VB.Timer TimerAbilitaControlloAllarmi 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   2400
      Top             =   5040
   End
   Begin VB.Timer TimerAllarmeErroreScambioVaglio 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   4800
      Top             =   3240
   End
   Begin VB.Timer TimerArrestoUrgenza 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   3360
      Top             =   3240
   End
   Begin VB.Timer TimerErroreScambioVaglio 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   1920
      Top             =   3240
   End
   Begin VB.Timer TimerArrestoPredosatori 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   1440
      Top             =   2760
   End
   Begin VB.Timer TimerAggregatiMan 
      Enabled         =   0   'False
      Left            =   1440
      Top             =   1320
   End
   Begin VB.Timer TimerBitumeMan 
      Enabled         =   0   'False
      Left            =   2400
      Top             =   1320
   End
   Begin VB.Timer TimerGestioneFiltro 
      Enabled         =   0   'False
      Interval        =   30000
      Left            =   2880
      Top             =   3240
   End
   Begin VB.Timer TimerSpegniNC 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   1440
      Top             =   2280
   End
   Begin VB.Label LabeParametriDaPlc 
      BackColor       =   &H8000000A&
      Caption         =   "ParametriDaPlc"
      Height          =   255
      Left            =   4680
      TabIndex        =   16
      Top             =   8640
      Width           =   1095
   End
   Begin VB.Label Label3 
      BackColor       =   &H8000000A&
      Caption         =   "Sili Deposito"
      Height          =   255
      Left            =   0
      TabIndex        =   15
      Top             =   8640
      Width           =   1335
   End
   Begin VB.Label ComunicazionePLUS 
      BackColor       =   &H8000000A&
      Caption         =   "ComunicazionePLUS"
      Height          =   255
      Left            =   3720
      TabIndex        =   14
      Top             =   720
      Width           =   1575
   End
   Begin VB.Label NuovaGestMot 
      BackColor       =   &H8000000A&
      Caption         =   "GestMotori"
      Height          =   255
      Left            =   3720
      TabIndex        =   13
      Top             =   120
      Width           =   1575
   End
   Begin VB.Label Label7 
      BackColor       =   &H8000000A&
      Caption         =   "Timer Bruciatore"
      Height          =   255
      Left            =   0
      TabIndex        =   12
      Top             =   4200
      Width           =   1575
   End
   Begin VB.Label Label14 
      BackColor       =   &H8000000A&
      Caption         =   "Dosaggio"
      Height          =   255
      Left            =   0
      TabIndex        =   11
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label1 
      BackColor       =   &H8000000A&
      Caption         =   "Coda materiale"
      Height          =   255
      Left            =   0
      TabIndex        =   10
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label13 
      BackColor       =   &H8000000A&
      Caption         =   "Timer SIWAREX"
      Height          =   255
      Left            =   0
      TabIndex        =   9
      Top             =   7080
      Width           =   1335
   End
   Begin VB.Label Label12 
      BackColor       =   &H8000000A&
      Caption         =   "Timer TAG"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   6600
      Width           =   1335
   End
   Begin VB.Label Label11 
      BackColor       =   &H8000000A&
      Caption         =   "Timer TREND"
      Height          =   255
      Left            =   0
      TabIndex        =   7
      Top             =   6120
      Width           =   1335
   End
   Begin VB.Label Label10 
      BackColor       =   &H8000000A&
      Caption         =   "Timer LCPC"
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   5640
      Width           =   1335
   End
   Begin VB.Label Label9 
      BackColor       =   &H8000000A&
      Caption         =   "Timer Controlli"
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   5160
      Width           =   1335
   End
   Begin VB.Label Label8 
      BackColor       =   &H8000000A&
      Caption         =   "Timer Silo"
      Height          =   255
      Left            =   0
      TabIndex        =   4
      Top             =   4680
      Width           =   1335
   End
   Begin VB.Label Label6 
      BackColor       =   &H8000000A&
      Caption         =   "Timer Generali"
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   3360
      Width           =   1095
   End
   Begin VB.Label Label5 
      BackColor       =   &H8000000A&
      Caption         =   "Predosatori"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   2880
      Width           =   1095
   End
   Begin VB.Label Label4 
      BackColor       =   &H8000000A&
      Caption         =   "Arresti Auto."
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Label Label2 
      BackColor       =   &H8000000A&
      Caption         =   "Impasti Manuali"
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   1440
      Width           =   1095
   End
End
Attribute VB_Name = "FrmGestioneTimer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

'Spegnimento dopo alcuni secondi per scambiare un ultime messaggio di Close col Plus
Private Sub AttesaSpegnimento_Timer()
    AttesaSpegnimento.enabled = False
    
    CP240.uscita
End Sub
'20161214
Private Sub DeodoranteSili_Timer()
  DeodoranteSili.enabled = False
  Deodorante.CmdStart = False
  Deodorante.CmdStop = False
End Sub
'20161214

'Reset di sicurezza del comando di emergenza motori
Private Sub EmergenzaMotori_Timer()
    ArrestoMotoriEmergenza = False
    EmergenzaMotori.enabled = False
End Sub


Private Sub FiltraCmd_Timer()
    FiltraCmd.enabled = False
End Sub


Private Sub PlusForcingStop_Timer()
    PlusForcingStop.enabled = (Not PlusForceStopFinish)

    If (PlusForceStopFinish) Then
        'chiudi programma dopo aver mandato un messaggio al PLUS
        Call SendMessagetoPlus(PlusSendClose, 0)
        FrmGestioneTimer.AttesaSpegnimento.enabled = True
    End If

End Sub


Private Sub RitardoRitrasmPar_Timer()
    primotrasferimentoparametri = False
    PlcInviaParametri
    RitardoRitrasmPar.enabled = False
End Sub


'20160718
Private Sub RitardoStartBruc_Timer()
    Dim tamburo As Integer
    tamburo = 0
    If (ListaTamburi(0).PressioneInsufficienteOlioCombustibile And ListaTamburi(tamburo).SelezioneCombustibile <> CombustibileGas And ListaMotori(MotorePompaCombustibile).presente) Then
        AllarmeCicalino = True
        Call ShowMsgBox(LoadXLSString(876), vbOKOnly, vbExclamation, -1, -1, True)  '20150109
        AllarmeCicalino = False
        RitardoStartBruc.enabled = False
        Exit Sub
    End If
    '20161230 ResetPID = True
    Call StartBruciatore(tamburo)
    If (ListaTamburi(tamburo).AvviamentoBruciatoreCaldo) Then
        If (tamburo = 0) Then
            CP240.OPCData.items(PLCTAG_NM_IN_START_RID_BRUC1).Value = True
        Else
            CP240.OPCData.items(PLCTAG_NM_IN_START_RID_BRUC2).Value = True
        End If
    Else
        If (tamburo = 0) Then
            CP240.OPCData.items(PLCTAG_NM_IN_START_BRUC1).Value = True
        Else
            CP240.OPCData.items(PLCTAG_NM_IN_START_BRUC2).Value = True
        End If
    End If
    FrmGestioneTimer.TmrCmdBruciatore.enabled = False
    FrmGestioneTimer.TmrCmdBruciatore.Interval = 500
    FrmGestioneTimer.TmrCmdBruciatore.enabled = True
    RitardoStartBruc.enabled = False
End Sub
'20160718

Private Sub TimerAbilitaSiliDeposito_Timer()  '20151218 Dopo 6 secondi dal
    TimerAbilitaSiliDeposito.enabled = False
    AbilitaLetturaSiliDeposito = True
    RinfrescoLetturaSiliDeposito = True
End Sub

Private Sub TimerArrestoFilleriz_Timer()
    contatoreFillerizzazione = contatoreFillerizzazione - 1
    CP240.LblMessaggioFilleriz.caption = contatoreFillerizzazione
End Sub

'20150831
'Private Sub TimerArrestoPredLivelliAltiFiller_Timer()
'    If LivelloMaxSiloFiller(1) Or LivelloMaxSiloFiller(2) Or LivelloMaxSiloFiller(3) Or PredosaggioArrestoLivelliTSF Then
'        Call ErroreLivelloAltoFiller
'    End If
'    FrmGestioneTimer.TimerArrestoPredLivelliAltiFiller.enabled = False
'End Sub
'

Private Sub TimerCompresFilleriz_Timer()

    Call SetMotoreUscita(MotoreTrasportoFillerizzazioneFiltro, False)

    TimerCompresFilleriz.enabled = False
    TimerArrestoFilleriz.enabled = False
    CP240.CmdStartStopGenerale(2).enabled = True
    CP240.CmdStartStopGenerale(3).enabled = True
    CP240.AniPushButtonDeflettore(36).enabled = True
    CP240.FrameArrestoFilleriz.Visible = False
    contatoreFillerizzazione = RitardoSpegnimentoCompressoreF1F2
    
End Sub

'Timeout Socket comunicazione con Cybertronic Plus
Private Sub TimerComunicazionePLUS_Timer()
    CP240.Client.Close
    
    CP240.Client.Connect
End Sub

Private Sub TimerDeflettoreBypassRap_Timer()
     
    If DeflettoreByPassTamburoParalleloFCNastro And Not DeflettoreByPassTamburoParalleloFCTamburo Then
        If DeflettoreByPassTamburoParalleloVersoNastro Then
            CP240.AniPushButtonDeflettore(30).Value = 1 'nastro
        Else
             CP240.AniPushButtonDeflettore(30).Value = 3
             Call AllarmeTemporaneo("XX021", True)
        End If
    ElseIf Not DeflettoreByPassTamburoParalleloFCNastro And DeflettoreByPassTamburoParalleloFCTamburo Then
        If Not DeflettoreByPassTamburoParalleloVersoNastro Then
            CP240.AniPushButtonDeflettore(30).Value = 2 'tamburo
        Else
            CP240.AniPushButtonDeflettore(30).Value = 3
            Call AllarmeTemporaneo("XX021", True)
        End If
    Else
        CP240.AniPushButtonDeflettore(30).Value = 3
        Call AllarmeTemporaneo("XX022", True)
    End If
    
    FrmGestioneTimer.TimerDeflettoreBypassRap.enabled = False
    
End Sub

'20161024 no usato
Private Sub TimerParametriDaPlc_Timer()
    TimerParametriDaPlc.enabled = False
    Call SendParametersFromPLC
End Sub
'20161024

'20170202
Private Sub TimerResetTrasfVelDef_Timer()
    TimerResetTrasfVelDef.enabled = False
    CP240.OPCData.items(PLCTAG_GEST_VEL_TAMB_Trasf_DefaultVal).Value = False
End Sub
'20170202

Private Sub TimerRiciclatoMan_Timer()

    TimerRiciclatoMan.enabled = False
    
    'ripristina pulsanti pesata
    Call AbilitaPulsantiPortineMan(True)
 
    ScManualeRiciclato(CodiceCompScManuale).Peso = ScManualeRiciclato(CodiceCompScManuale).Peso + CDbl(BilanciaRAP.Peso) - PesoRiciclatoManuale
    PesoRiciclatoManuale = 0
        
End Sub

Private Sub TimerViatopMan_Timer()

    TimerViatopMan.enabled = False
    
    'ripristina pulsanti pesata
    
'20170301
'    Call AbilitaPulsantiPortineMan(True)
'
'    ScManualeViatop(CodiceCompScManuale).Peso = ScManualeViatop(CodiceCompScManuale).Peso + CDbl(BilanciaViatop.Peso) - PesoViatopManuale
'    PesoViatopManuale = 0
    If BilanciaViatop.MemFronteDosaEmergPbarNetti And BilanciaViatop.CompAttivo >= 0 Then
        ScManualeViatop.Peso = ScManualeViatop.Peso + CDbl(BilanciaViatop.Peso) - PesoViatopManuale
        DosaggioViatop.memTaraPesoNetto = CDbl(BilanciaViatop.Peso)
        PesoViatopManuale = 0
        Call PbarNettoPesata(DosaggioViatop, 0, ScManualeViatop.Peso, True)
        BilanciaViatop.MemFronteDosaEmergPbarNetti = False
        BilanciaViatop.CompAttivo = -1
    ElseIf Not BilanciaViatop.MemFronteDosaEmergPbarNetti Then
        ScManualeViatop.Peso = ScManualeViatop.Peso + CDbl(BilanciaViatop.Peso) - PesoViatopManuale
        Call PbarNettoPesata(DosaggioViatop, 0, ScManualeViatop.Peso, True)
        PesoViatopManuale = 0
        Call AbilitaPulsantiPortineMan(True)
    End If
'
        
'    BilanciaViatop.CompAttivo = -1 '20170223
    
End Sub
'20160421
Private Sub TimerViatopScarMixer1Man_Timer()
    TimerViatopScarMixer1Man.enabled = False
    
    'ripristina pulsanti pesata
    Call AbilitaPulsantiPortineMan(True)
    
    ScManualeViatopScarMixer1.Peso = ScManualeViatopScarMixer1.Peso + CDbl(BilanciaViatopScarMixer1.Peso) - PesoViatopScarMixer1Manuale
    PesoViatopScarMixer1Manuale = 0

    BilanciaViatopScarMixer1.CompAttivo = -1 '20170223

End Sub

Private Sub TimerViatopScarMixer2Man_Timer()
    TimerViatopScarMixer2Man.enabled = False
    
    'ripristina pulsanti pesata
    Call AbilitaPulsantiPortineMan(True)
    
    ScManualeViatopScarMixer2.Peso = ScManualeViatopScarMixer2.Peso + CDbl(BilanciaViatopScarMixer2.Peso) - PesoViatopScarMixer2Manuale
    PesoViatopScarMixer2Manuale = 0

    BilanciaViatopScarMixer2.CompAttivo = -1 '20170223

End Sub
'20160421

'20160226
Private Sub TmrAttesaFiltrofreddo_Timer()

    If (MotorManagement = AutomaticMotor And ListaTemperature(TempEntrataFiltro).valore > TemperaturaFiltroFreddo) Then
        AttesaFiltrofreddoFlipFlop = (Not AttesaFiltrofreddoFlipFlop)
        CP240.StatusBar1.Panels(STB_STATOMOTORI).text = IIf(AttesaFiltrofreddoFlipFlop, LoadXLSString(1514), "")
        CP240.LblEtichetta(129).BackColor = IIf(AttesaFiltrofreddoFlipFlop, vbRed, CP240.Frame1(20).BackColor)
    Else
        Call FineAttesaStopAutomaticoMotori

        Call AvvioStopAutomaticoMotori
    End If

End Sub

Private Sub TmrBindicatorApporto_Timer()

    On Error GoTo Errore

    TmrBindicatorApporto.enabled = False

'20150624
'    If (Not InclusioneF2 Or Not InclusioneTramoggiaTamponeF2) Then
    If (Not InclusioneF2 Or Not InclusioneTramoggiaTamponeF2) And (GestioneFiller2 <> FillerSoloTramTamp) Then
'
        Exit Sub
    End If

'20150624
    If (GestioneFiller2 <> FillerSoloTramTamp) Then
'
        Call CocleaFillerApportoDaAccendere(True)
    End If
    
    If (LivelloMaxF2) Then  'se il livello mi fa da livello massimo
        If (LivelloFillerApporto) Then      'se sono in presenza del livello
            ComponenteLivello DosaggioFiller(1), 100
        Else
            ComponenteLivello DosaggioFiller(1), 50
        End If
    Else                        'se il livello mi fa da livello minimo
        If (LivelloFillerApporto) Then
            ComponenteLivello DosaggioFiller(1), 0      'se sono in presenza del livello
        Else
            ComponenteLivello DosaggioFiller(1), 50
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "TMR-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub TmrBindicatorRecupero_Timer()

    On Error GoTo Errore

    TmrBindicatorRecupero.enabled = False

    Call CocleaFillerRecuperoDaAccendere(True)

    If (LivelloMaxF1) Then
        If (LivelloFillerRecupero) Then
            ComponenteLivello DosaggioFiller(0), 100
        Else
            ComponenteLivello DosaggioFiller(0), 50
        End If
    Else
        If (LivelloFillerRecupero) Then
            ComponenteLivello DosaggioFiller(0), 0
        Else
            ComponenteLivello DosaggioFiller(0), 50
        End If
    End If

    Exit Sub
Errore:
    LogInserisci True, "TMR-002", CStr(Err.Number) + " [" + Err.description + "]"
End Sub

Private Sub TmrCmdBruciatore_Timer()
    If (CP240.OPCData.items(PLCTAG_NM_IN_START_BRUC1).Value) Then
        CP240.OPCData.items(PLCTAG_NM_IN_START_BRUC1).Value = False
    End If
    If (CP240.OPCData.items(PLCTAG_NM_IN_START_BRUC2).Value) Then
        CP240.OPCData.items(PLCTAG_NM_IN_START_BRUC2).Value = False
    End If
    If (CP240.OPCData.items(PLCTAG_NM_IN_START_RID_BRUC1).Value) Then
        CP240.OPCData.items(PLCTAG_NM_IN_START_RID_BRUC1).Value = False
    End If
    If (CP240.OPCData.items(PLCTAG_NM_IN_START_RID_BRUC2).Value) Then
        CP240.OPCData.items(PLCTAG_NM_IN_START_RID_BRUC2).Value = False
    End If
    '20150820
    'If (CP240.OPCData.items(PLCTAG_NM_INOUT_STOPBRUC1).Value) Then
    '    CP240.OPCData.items(PLCTAG_NM_INOUT_STOPBRUC1).Value = False
    'End If
    'If (CP240.OPCData.items(PLCTAG_NM_INOUT_STOPBRUC2).Value) Then
    '    CP240.OPCData.items(PLCTAG_NM_INOUT_STOPBRUC2).Value = False
    'End If
    If (CP240.OPCData.items(PLCTAG_NM_IN_START_STOPBRUC1).Value) Then
        CP240.OPCData.items(PLCTAG_NM_IN_START_STOPBRUC1).Value = False
    End If
    If (CP240.OPCData.items(PLCTAG_NM_IN_START_STOPBRUC2).Value) Then
        CP240.OPCData.items(PLCTAG_NM_IN_START_STOPBRUC2).Value = False
    End If
    '

    TmrCmdBruciatore.enabled = False
End Sub

Private Sub TimerAbilitaControlloAllarmi_Timer()

    If (Not CP240.OPCData.IsConnected) Then
        If (DEMO_VERSION) Then
            AbilitaControlloAllarmi = AbilitaControlloAllarmi + 1
            If AbilitaControlloAllarmi >= 2 Then
                TimerAbilitaControlloAllarmi.enabled = False
            End If
        End If
        Exit Sub
    End If

    If (GetQuality(CP240.OPCData.items.item(0).quality) = STATOOK) Then
        AbilitaControlloAllarmi = AbilitaControlloAllarmi + 1
        If AbilitaControlloAllarmi >= 2 Then
            TimerAbilitaControlloAllarmi.enabled = False
            Call PlcInviaParametri
        End If
    End If

    If (CP240.OPCDataCisterne.IsConnected) Then
        If (GetQuality(CP240.OPCDataCisterne.items.item(0).quality) = STATOOK) Then
            If AbilitaControlloAllarmi >= 2 Then
                Call CisterneInviaParametri
            End If
        End If
    End If

'    If (AbilitaControlloAllarmi = 1) Then
'        If AbilitaCelleCaricoSilo Then
'            Call CelleSiloInizializza
'        End If
'    End If

    'SAREBBE MEGLIO AVERE UN TIMER PER OGNI PLC...VISTO CHE POSSONO ESSERE ATTIVI IN MODO DIVERSO RISPETTO AL MAIN
    '20160915
    If (InclusioneAquablack) Then
        If (CP240.OPCDataAquablack.IsConnected) Then
            If (GetQuality(CP240.OPCDataAquablack.items.item(0).quality) = STATOOK) Then
                If AbilitaControlloAllarmi >= 2 Then
                    Call PLCAquablack_InviaParametri
                End If
            End If
        End If
    End If

End Sub

Private Sub TimerAbortBatch_Timer()
    TimerAbortBatch.enabled = False
    CodiceComandoSiwarex = 101
    Call AttivaComandoSiwarex(SiwarexRiciclatoFreddo)
End Sub

Private Sub TimerAckAllarmiDB61_Timer()
    TimerAckAllarmiDB61.enabled = False

    If (CP240.OPCData.IsConnected) Then
        CP240.OPCData.items(PLCTAG_AckAllarmiAggregati).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiFiller).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiBitume).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiBitumeGravita).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiContalitri).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiRiciclato).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiViatop).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiAddMixer).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiAddLegante).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiAddSacchi).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiMixer).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiBenna).Value = False
        CP240.OPCData.items(PLCTAG_AckAllarmiSiwaBatch).Value = False
    End If
End Sub

Private Sub TimerAckAllarmiSiloS7_Timer()
    TimerAckAllarmiSiloS7.enabled = False

    If (CP240.OPCData.IsConnected) Then
        CP240.OPCData.items(PLCTAG_DB322_AckAllarme).Value = False
    End If
End Sub

Private Sub TimerAggregatiMan_Timer()

    Dim indice As Integer

    TimerAggregatiMan.enabled = False
    
    'ripristina pulsanti pesata
    
'20170301
'    Call AbilitaPulsantiPortineMan(True)
'    ScManualeAggregati(CodiceCompScManuale).Peso = ScManualeAggregati(CodiceCompScManuale).Peso + CDbl(BilanciaAggregati.Peso) - PesoAggregatiManuale
'    PesoAggregatiManuale = 0
    
    If BilanciaAggregati.MemFronteDosaEmergPbarNetti And BilanciaAggregati.CompAttivo >= 0 Then
    'passaggio di consegna del netto fra automatico e manuale
        ScManualeAggregati(BilanciaAggregati.CompAttivo).Peso = ScManualeAggregati(BilanciaAggregati.CompAttivo).Peso + CDbl(BilanciaAggregati.Peso) - PesoAggregatiManuale
        DosaggioAggregati(BilanciaAggregati.CompAttivo).memTaraPesoNetto = CDbl(BilanciaAggregati.Peso)
        PesoAggregatiManuale = 0
        Call PbarNettoPesata(DosaggioAggregati(BilanciaAggregati.CompAttivo), 0, ScManualeAggregati(BilanciaAggregati.CompAttivo).Peso, True)
        BilanciaAggregati.MemFronteDosaEmergPbarNetti = False
        BilanciaAggregati.CompAttivo = -1
    ElseIf Not BilanciaAggregati.MemFronteDosaEmergPbarNetti Then
        ScManualeAggregati(CodiceCompScManuale).Peso = ScManualeAggregati(CodiceCompScManuale).Peso + CDbl(BilanciaAggregati.Peso) - PesoAggregatiManuale
        Call PbarNettoPesata(DosaggioAggregati(CodiceCompScManuale), 0, ScManualeAggregati(CodiceCompScManuale).Peso, True)
        PesoAggregatiManuale = 0
        Call AbilitaPulsantiPortineMan(True)
    End If

'

'    BilanciaAggregati.CompAttivo = -1 '20170223

End Sub


Private Sub TimerAltaTemperaturaScivolo_Timer(Index As Integer)

    Select Case Index
        Case 0
            TimerAltaTemperaturaScivolo(0).enabled = False
            Sec10AltaScivolo = True
        Case 1
            TimerAltaTemperaturaScivolo(1).enabled = False
            Sec10AltaScivolo2 = True
    End Select

End Sub

Private Sub timerApparecchiaturaLEC1_Timer()
    CP240.Image1(1).Visible = ListaTamburi(0).StartBruciatoreDaPLC And Not ListaMotori(MotoreVentolaBruciatore).ritorno
    CP240.Image1(38).Visible = ListaTamburi(1).StartBruciatoreDaPLC And Not ListaMotori(MotoreVentolaBruciatore2).ritorno

    TimerApparecchiaturaLEC1.enabled = False
End Sub

Private Sub TimerArrestoPredosatori_Timer()

    Dim AppoggioRicAccesi As Boolean
    Dim i As Integer
    Dim AppoggioSetRic As Integer

    TimerArrestoPredosatori.enabled = False

    If (ListaPredosatoriRic(0).motore.ritorno Or ListaPredosatoriRic(1).motore.ritorno Or ListaPredosatoriRic(2).motore.ritorno) Then
        AppoggioRicAccesi = True
    Else
        AppoggioRicAccesi = False
    End If

    If AutomaticoPredosatori And (StartPredosatori Or Not PredosatoriAutomaticoOn Or AppoggioRicAccesi) And Not tmrRitControlloPred.enabled Then

        If (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) > 0) Then
            AppoggioSetRic = 0
            For i = 0 To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) - 1
                AppoggioSetRic = AppoggioSetRic + val(CP240.TxtPredRicSet(i).text)
            Next i
            If AppoggioSetRic > 0 Then
                If ((ListaMotori(MotoreNastroTrasportatoreRiciclato).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno) Or (ListaMotori(MotoreNastroCollettoreRiciclato).presente And Not ListaMotori(MotoreNastroCollettoreRiciclato).ritorno)) Then
                    'Call PredosatoriArrestoImmediato(True, 0)
                End If
            End If
        End If

        If (NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) > 0) Then
            AppoggioSetRic = 0
            For i = NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) To NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoCaldo) + NumeroPredosatoriNastroC(NastriPredosatori.RiciclatoFreddo) - 1
                AppoggioSetRic = AppoggioSetRic + val(CP240.TxtPredRicSet(i).text)
            Next i
            If AppoggioSetRic > 0 Then
                If ((ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroCollettoreRiciclatoFreddo).ritorno) Or (ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).presente And Not ListaMotori(MotoreNastroTrasportatoreRiciclatoFreddo).ritorno)) Then
                    'Call PredosatoriArrestoImmediato(True, 1)
                End If
            End If
        End If

    End If

End Sub

Private Sub TimerArrestoUrgenza_Timer()
    
    TimerArrestoUrgenza.enabled = False
    ArrestoUrgenza = False

End Sub

Private Sub TimerAttesaRegolazioneAriaFredda_Timer()
    AbilitaControlloAriaFredda = True
End Sub

Private Sub TimerAzzeraStartDosaggio_Timer()
    TimerAzzeraStartDosaggio.enabled = False
    CP240.OPCData.items(PLCTAG_StartDosaggio).Value = False
End Sub

Private Sub TimerBassaTemperaturaScivolo_Timer(Index As Integer)

    Select Case Index
        Case 0
            TimerBassaTemperaturaScivolo(0).enabled = False
            Sec10BassaScivolo = True
        Case 1
            TimerBassaTemperaturaScivolo(1).enabled = False
            Sec10BassaScivolo2 = True
        End Select
'
End Sub

Private Sub TimerBennaPiena_Timer()

    TimerBennaPiena.enabled = False
            
    If ( _
        Not BennaPiena And (Not ListaAmperometri(AmperometroArganoBenna).inclusione Or _
        (ListaAmperometri(AmperometroArganoBenna).valore > ListaAmperometri(AmperometroArganoBenna).sogliaMin)) _
    ) Then
        BennaPiena = True
    End If

End Sub

Private Sub TimerErrMsgQuit_Timer()
    'Metto il timer nella pagina dei timer globali
    FrmGestioneTimer.TimerErrMsgQuit.enabled = False
End Sub

Private Sub TimerMixerPieno_Timer()

    TimerMixerPieno.enabled = False

    If ( _
        (Not ListaAmperometri(AmperometroMescolatore_1).inclusione Or _
        (ListaAmperometri(AmperometroMescolatore_1).valore < ListaAmperometri(AmperometroMescolatore_1).sogliaMin)) And _
        (Not ListaAmperometri(AmperometroMescolatore_2).inclusione Or _
        (ListaAmperometri(AmperometroMescolatore_2).inclusione And ListaAmperometri(AmperometroMescolatore_2).valore < ListaAmperometri(AmperometroMescolatore_2).sogliaMin)) _
    ) Then
        MixerCaricoPerBenna = False
    Else
        MixerCaricoPerBenna = True
    End If
    
End Sub

Private Sub TimerDeflettoreRiciclato_Timer()

    If AbilitaDeflettoreAnello Then
        Call AggiornaDeflettoreRiciclato
    ElseIf AbilitaDeflettoreAnelloElevatoreRic Then
        Call AggiornaDeflettoreRiciclatoAnelloElevRic
    End If

    TimerDeflettoreRiciclato.enabled = False

End Sub

Private Sub TimerLivelloAltoSilo_Timer(Index As Integer)

    'Allarme Silo Alto dopo 3 sec di permanenza
    Dim sirena As Boolean
    Dim Criterio As String
    Dim posizione As Integer

    Select Case Index + 1
        Case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
            Criterio = "GS01" + CStr(Index)
        Case 11
            Criterio = "GS020"
    End Select

    TimerLivelloAltoSilo(Index).enabled = False

    sirena = (DestinazioneSilo = CStr(Index + 1))

    If (sirena) Then
        If (Not ListaSili(Index + 1).AccettaAllarmeLivelloAlto) Then
            ListaSili(Index + 1).AccettaAllarmeLivelloAlto = True
        End If
        If (Not SirenaSiloAttiva) Then
            AllarmeCicalino = True
            Call AttivazioneSirena(True)
        Else
            Call AttivazioneSirena(False)
        End If
    Else
        Call AttivazioneSirena(False)
    End If
    
    posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", Criterio, "IdDescrizione")
    IngressoAllarmePresente posizione, True
        
End Sub

Private Sub TimerRitardoChiusuraPortinaSIWA_Timer()
    If (DEMO_VERSION) Then
        Exit Sub
    End If

    CP240.OPCData.items(PLCTAG_DB80_ComandoDirettoPortina).Value = False
    CP240.OPCData.items(PLCTAG_DO_SIWA_Batch_ModalitaTaratura).Value = False
    FrmGestioneTimer.TimerRitardoChiusuraPortinaSIWA.enabled = False
End Sub

Private Sub TimerRitornoComandi_Timer(Index As Integer)
    Select Case Index
        Case 0
            Call RitornoOkComandi
            TimerRitornoComandi(Index).enabled = False
            TimerRitornoComandi(Index).Interval = 2500
            TimerRitornoComandi(Index).enabled = True
    End Select
End Sub

Private Sub TimerImpulsoRegolazioneAriaFredda_Timer()
    ModulatoreAriaFreddaFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone

    TimerImpulsoRegolazioneAriaFredda.enabled = False
End Sub

Private Sub TimerLCPC_Timer()
    Call AttivaTimerLCPC
End Sub

Private Sub TimerLCPC1sec_Timer()
'    Call ScriviLogWindQual(CreaPacchetto1sec, "PC")
'
'    VisualizzaStatoLCPC (CP240.LCPC.WritePort(CreaPacchetto1sec))
'    CP240.LCPC.ClearBuffer
End Sub

Private Sub TimerLCPC5sec_Timer()
'    Call ScriviLogWindQual(CreaPacchetto5sec, "P")
'
'    VisualizzaStatoLCPC (CP240.LCPC.WritePort(CreaPacchetto5sec))
'    CP240.LCPC.ClearBuffer
End Sub


Private Sub TimerBitumeMan_Timer()

    TimerBitumeMan.enabled = False
    
'20170301
    'Call AbilitaPulsantiPortineMan(True)

'    ScManualeBitume(CodiceCompScManuale).Peso = ScManualeBitume(CodiceCompScManuale).Peso + CDbl(BilanciaLegante.Peso) - PesoBitumeManuale
'    PesoBitumeManuale = 0

    If BilanciaLegante.MemFronteDosaEmergPbarNetti And BilanciaLegante.CompAttivo >= 0 Then
        ScManualeBitume(BilanciaLegante.CompAttivo + LBound(ScManualeBitume)).Peso = ScManualeBitume(BilanciaLegante.CompAttivo + LBound(ScManualeBitume)).Peso + CDbl(BilanciaLegante.Peso) - PesoBitumeManuale
        DosaggioLeganti(BilanciaLegante.CompAttivo).memTaraPesoNetto = CDbl(BilanciaLegante.Peso)
        PesoBitumeManuale = 0
        Call PbarNettoPesata(DosaggioLeganti(BilanciaLegante.CompAttivo), 0, ScManualeBitume(BilanciaLegante.CompAttivo + LBound(ScManualeBitume)).Peso, True)
        BilanciaLegante.MemFronteDosaEmergPbarNetti = False
        BilanciaLegante.CompAttivo = -1
    ElseIf Not BilanciaLegante.MemFronteDosaEmergPbarNetti Then
        ScManualeBitume(CodiceCompScManuale).Peso = ScManualeBitume(CodiceCompScManuale).Peso + CDbl(BilanciaLegante.Peso) - PesoBitumeManuale
        Call PbarNettoPesata(DosaggioLeganti(CodiceCompScManuale - LBound(ScManualeBitume)), 0, ScManualeBitume(CodiceCompScManuale).Peso, True)
        PesoBitumeManuale = 0
        Call AbilitaPulsantiPortineMan(True)
    End If

'    BilanciaLegante.CompAttivo = -1 '20170223

End Sub


Private Sub TimerFillerMan_Timer()

    Dim indice As Integer

    TimerFillerMan.enabled = False
    
'20170301
    'Call AbilitaPulsantiPortineMan(True)

'    ScManualeFiller(CodiceCompScManuale).Peso = ScManualeFiller(CodiceCompScManuale).Peso + CDbl(BilanciaFiller.Peso) - PesoFillerManuale
'    PesoFillerManuale = 0

    If BilanciaFiller.MemFronteDosaEmergPbarNetti And BilanciaFiller.CompAttivo >= 0 Then
        ScManualeFiller(BilanciaFiller.CompAttivo + LBound(ScManualeFiller)).Peso = ScManualeFiller(BilanciaFiller.CompAttivo + LBound(ScManualeFiller)).Peso + CDbl(BilanciaFiller.Peso) - PesoFillerManuale
        DosaggioFiller(BilanciaFiller.CompAttivo).memTaraPesoNetto = CDbl(BilanciaFiller.Peso)
        PesoFillerManuale = 0
        Call PbarNettoPesata(DosaggioFiller(BilanciaFiller.CompAttivo), 0, ScManualeFiller(BilanciaFiller.CompAttivo + LBound(ScManualeFiller)).Peso, True)
        BilanciaFiller.MemFronteDosaEmergPbarNetti = False
        BilanciaFiller.CompAttivo = -1
    ElseIf Not BilanciaFiller.MemFronteDosaEmergPbarNetti Then
        ScManualeFiller(CodiceCompScManuale).Peso = ScManualeFiller(CodiceCompScManuale).Peso + CDbl(BilanciaFiller.Peso) - PesoFillerManuale
        Call PbarNettoPesata(DosaggioFiller(CodiceCompScManuale - LBound(ScManualeFiller)), 0, ScManualeFiller(CodiceCompScManuale).Peso, True)
        PesoFillerManuale = 0
        Call AbilitaPulsantiPortineMan(True)
    End If

'    BilanciaFiller.CompAttivo = -1 '20170223

End Sub

Private Sub TimerGestioneFiltro_Timer()
    TimerGestioneFiltro.enabled = False
    If Not TempoAttesaFiltro Then
        TempoAttesaFiltro = True
        Call AutomaticoFiltroManiche
        '********************************
        ModulatoreAspirazioneFiltro.Stato = ModulatoreStatusEnum.ModulatoreNone
        '********************************
    End If
End Sub


Private Sub TimerRitardoSbloccoBruciatore_Timer()
    If (ListaTamburi(0).StartBruciatoreDaPLC And ListaTamburi(0).BloccoFiammaBruciatore) Then
        Call StopBruciatore(0)
    End If

    If (ListaTamburi(1).StartBruciatoreDaPLC And ListaTamburi(1).BloccoFiammaBruciatore) Then
        Call StopBruciatore(1)
    End If

    TimerRitardoSbloccoBruciatore.enabled = False
End Sub


Private Sub TimerSiwa_Refresh_Timer(Index As Integer)

    Dim offset As Integer
    Dim appoggio As Double

    If (Not CP240.OPCData.IsConnected) Then
        Exit Sub
    End If

    offset = Index * (PLCTAG_BILANCIA_1 - PLCTAG_BILANCIA_0) 'PLCTAG_BILANCIA_1 - PLCTAG_BILANCIA_0 sono i tag di ogni Siwarex
    
    With Siwarex(Index)
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        'Esecuzione del comando se necessario
        If (CodiceComandoSiwarex <> 999) And (NumeroSiwarex = Index) Then
            .SIWA_CMD_INPUT = CodiceComandoSiwarex
            .SIWA_CMD_ENABLED = True
            CP240.OPCData.items(PLCTAG_SIWA0_COMANDO1_CODICE + offset).Value = CodiceComandoSiwarex
            CP240.OPCData.items(PLCTAG_SIWA0_COMANDO1_ESEGUI + offset).Value = Not .SIWA_ERR_MSG_QUIT
        End If
        CP240.OPCData.items(PLCTAG_SIWA0_ERR_MSG_QUIT + offset).Value = .SIWA_ERR_MSG_QUIT
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        'Diagnostica Bilancia letta dalla FB1043
        .SIWA_CMD_IN_PROGRESS = CP240.OPCData.items(PLCTAG_SIWA0_CMD_IN_PROGRESS + offset).Value
        .SIWA_CMD_FINISHED_OK = CP240.OPCData.items(PLCTAG_SIWA0_FINISHED_OK + offset).Value
        .SIWA_CMD_ERR = CP240.OPCData.items(PLCTAG_SIWA0_CMD_ERR + offset).Value
        .SIWA_CMD_ERR_CODE = CP240.OPCData.items(PLCTAG_SIWA0_CMD_ERR_CODE + offset).Value
        .SIWA_SIM_VALUE = CP240.OPCData.items(PLCTAG_SIWA0_SIM_VALUE + offset).Value
        .SIWA_ANALOG_OUT_VALUE = CP240.OPCData.items(PLCTAG_SIWA0_ANALOG_OUT_VALUE + offset).Value
        .SIWA_RESERVE_18 = CP240.OPCData.items(PLCTAG_SIWA0_RESERVE_18 + offset).Value
        .SIWA_DIG_OUT_FORCE = CP240.OPCData.items(PLCTAG_SIWA0_DIG_OUT_FORCE + offset).Value
        .SIWA_INFO_REFRESH_COUNT = CP240.OPCData.items(PLCTAG_SIWA0_INFO_REFRESH_COUNT + offset).Value
        .SIWA_PROCESS_VALUE1 = CP240.OPCData.items(PLCTAG_SIWA0_PROCESS_VALUE1 + offset).Value
        .SIWA_PROCESS_VALUE2 = CP240.OPCData.items(PLCTAG_SIWA0_PROCESS_VALUE2 + offset).Value
        .SIWA_SCALE_STATUS = CP240.OPCData.items(PLCTAG_SIWA0_SCALE_STATUS + offset).Value
        .SIWA_ERR_MSG = CP240.OPCData.items(PLCTAG_SIWA0_ERR_MSG + offset).Value
        .SIWA_ERR_MSG_TYPE = CP240.OPCData.items(PLCTAG_SIWA0_ERR_MSG_TYPE + offset).Value
        .SIWA_ERR_MSG_CODE = CP240.OPCData.items(PLCTAG_SIWA0_ERR_MSG_CODE + offset).Value
        .SIWA_FB_ERR = CP240.OPCData.items(PLCTAG_SIWA0_FB_ERR + offset).Value
        .SIWA_FB_ERR_CODE = CP240.OPCData.items(PLCTAG_SIWA0_FB_ERR_CODE + offset).Value
        'Accetto in automatico gli errori:
        '                                   17 = valore letto celle carico sopra il max (P1 e P2 hanno le celle troppo piccole)
        '                                   43 e 45 (carico e flusso basso) dato che nemmeno Beati capisce perchè me li da!
        '                                   145 e 151 sono allarmi non gestiti
        If .SIWA_ERR_MSG_CODE = 43 Or .SIWA_ERR_MSG_CODE = 45 Or .SIWA_ERR_MSG_CODE = 17 Or .SIWA_ERR_MSG_CODE = 145 Or .SIWA_ERR_MSG_CODE = 151 Then
            .SIWA_ERR_MSG_QUIT = True
            FrmGestioneTimer.TimerErrMsgQuit.enabled = False
            FrmGestioneTimer.TimerErrMsgQuit.Interval = 500
            FrmGestioneTimer.TimerErrMsgQuit.enabled = True
        End If
        If Not FrmGestioneTimer.TimerErrMsgQuit.enabled And .SIWA_ERR_MSG_QUIT Then
            'Ho già accettato l'allarme
            .SIWA_ERR_MSG_QUIT = False
        End If

        'DR30
        .SIWA_STATUS_SERVICE_ON = CBool(CP240.OPCData.items(PLCTAG_SIWA0_STATUS_SERVICE_ON + offset).Value)
        .SIWA_CALIBRAZIONE_ON = CBool(CP240.OPCData.items(PLCTAG_SIWA0_CALIBRAZIONE_ON + offset).Value)
        .SIWA_PESO_NASTRO = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_PESO_NASTRO + offset).Value, 2)
        .SIWA_VELOX_NASTRO = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_VELOX_NASTRO + offset).Value, 2)
        .SIWA_PORTATA_NASTRO = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_PORTATA_NASTRO + offset).Value, 1)
        
        'DR31
        .SIWA_AD_DIGIT_FILTERED = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_AD_DIGIT_FILTERED + offset).Value, 1)
        '
        
        Select Case CodiceComandoSiwarex
            Case 203
                'DR3
                .SIWA_DIGIT_ZERO = CDbl(CP240.OPCData.items(PLCTAG_SIWA0_DIGIT_ZERO + offset).Value)
                .SIWA_DIGIT_TARATURA = CDbl(CP240.OPCData.items(PLCTAG_SIWA0_DIGIT_TARATURA + offset).Value)
                .SIWA_PESO_TARATURA = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_PESO_TARATURA + offset).Value, 2)
                .SIWA_MILLIVOLT = CInt(CP240.OPCData.items(PLCTAG_SIWA0_MILLIVOLT + offset).Value)
                .SIWA_FILTRO_FREQ = CInt(CP240.OPCData.items(PLCTAG_SIWA0_FILTRO_FREQ + offset).Value)
                .SIWA_FILTRO_MEDIA = CInt(CP240.OPCData.items(PLCTAG_SIWA0_FILTRO_MEDIA + offset).Value)
                .SIWA_AUTOZERO = CBool(CP240.OPCData.items(PLCTAG_SIWA0_AUTOZERO + offset).Value)
                .SIWA_PERC_SOTTO_ZERO = CInt(CP240.OPCData.items(PLCTAG_SIWA0_PERC_SOTTO_ZERO + offset).Value)
                .SIWA_PERC_SOPRA_ZERO = CInt(CP240.OPCData.items(PLCTAG_SIWA0_PERC_SOPRA_ZERO + offset).Value)
                .SIWA_TEMPO_CALIBRAZIONE = ConvertiTempoS7toSEC(CP240.OPCData.items(PLCTAG_SIWA0_TEMPO_CALIBRAZIONE + offset).Value)

            Case 205
                'DR5
                .SIWA_IMPULSI_METRO = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_IMPULSI_METRO + offset).Value, 2)
                .SIWA_LUNGHEZZA = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_LUNGHEZZA + offset).Value, 2)
                .SIWA_CORREZIONE = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_CORREZIONE + offset).Value, 2)
                .SIWA_MIN_TOTALIZING = CInt(CP240.OPCData.items(PLCTAG_SIWA0_MIN_TOTALIZING + offset).Value)
            Case 230

            Case 233
                'DR33
                .SIWA_TOTALIZER_5 = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_TOTALIZER_5 + offset).Value, 1)
                .SIWA_TOTALIZER_6 = RoundNumber(CP240.OPCData.items(PLCTAG_SIWA0_TOTALIZER_6 + offset).Value, 1)
        End Select
        
        If (FrmSiwarexParaVisibile) Then
            If (FrmSiwarexPara.BilanciaAttiva() = Index) Then
                
                FrmSiwarexPara.TxtCmdSiwa(0).text = CStr(.SIWA_CMD_INPUT)
                FrmSiwarexPara.TxtCmdSiwa(1).text = CStr(.SIWA_CMD_ENABLED)
                If .SIWA_CMD_ENABLED Then
                    FrmSiwarexPara.ShapeCMD(1).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeCMD(1).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtCmdSiwa(2).text = CStr(.SIWA_CMD_IN_PROGRESS)
                If .SIWA_CMD_IN_PROGRESS Then
                    FrmSiwarexPara.ShapeCMD(2).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeCMD(2).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtCmdSiwa(3).text = CStr(.SIWA_CMD_FINISHED_OK)
                If .SIWA_CMD_FINISHED_OK Then
                    FrmSiwarexPara.ShapeCMD(3).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeCMD(3).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtCmdSiwa(4).text = CStr(.SIWA_CMD_ERR)
                If .SIWA_CMD_ERR Then
                    FrmSiwarexPara.ShapeCMD(4).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeCMD(4).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtCmdSiwa(5).text = CStr(.SIWA_CMD_ERR_CODE)
                FrmSiwarexPara.TxtCmdSiwa(6).text = RoundNumber(.SIWA_SCALE_STATUS, 1)
                FrmSiwarexPara.TxtCmdSiwa(7).text = CStr(.SIWA_ERR_MSG)
                If .SIWA_ERR_MSG Then
                    FrmSiwarexPara.LblDescrErr.caption = ""
                    FrmSiwarexPara.ShapeCMD(7).BackColor = vbGreen
                '20170208
                'Else
                '
                    '.SIWA_ERR_MSG_TYPE = tipo -> foglio
                    '.SIWA_ERR_MSG = codice numerico
                    Dim errorCode As SiwarexErrorCode
                    If (SiwarexGetError(.SIWA_ERR_MSG_TYPE, .SIWA_ERR_MSG_CODE, errorCode)) Then
                        FrmSiwarexPara.LblDescrErr.ToolTipText = errorCode.explanation
                        FrmSiwarexPara.LblDescrErr.caption = errorCode.description
                    Else
                        FrmSiwarexPara.LblDescrErr.ToolTipText = ""
                        FrmSiwarexPara.LblDescrErr.caption = "Error = " + CStr(.SIWA_ERR_MSG)
                    End If
                '20170208
                Else
                    FrmSiwarexPara.LblDescrErr.caption = ""
                '
                    FrmSiwarexPara.ShapeCMD(7).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtCmdSiwa(8).text = CStr(.SIWA_ERR_MSG_TYPE)
                FrmSiwarexPara.TxtCmdSiwa(9).text = CStr(.SIWA_ERR_MSG_CODE)
                FrmSiwarexPara.TxtCmdSiwa(10).text = CStr(.SIWA_FB_ERR)
                If .SIWA_FB_ERR Then
                    FrmSiwarexPara.ShapeCMD(10).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeCMD(10).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtCmdSiwa(11).text = CStr(.SIWA_FB_ERR_CODE)
                
                FrmSiwarexPara.TxtCmdSiwa(13).text = CStr(.SIWA_ERR_MSG_QUIT)
                If .SIWA_ERR_MSG_QUIT Then
                    FrmSiwarexPara.ShapeCMD(13).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeCMD(13).BackColor = &H808080
                End If

                'DR30
                If .SIWA_STATUS_SERVICE_ON Then
                    FrmSiwarexPara.ShapeDR30(4).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeDR30(4).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtDR30(4).text = CStr(.SIWA_STATUS_SERVICE_ON)
                If .SIWA_CALIBRAZIONE_ON Then
                    FrmSiwarexPara.ShapeDR30(0).BackColor = vbGreen
                Else
                    FrmSiwarexPara.ShapeDR30(0).BackColor = &H808080
                End If
                FrmSiwarexPara.TxtDR30(0).text = CStr(.SIWA_CALIBRAZIONE_ON)
                FrmSiwarexPara.LblDR30Siwa(1).caption = CStr(.SIWA_PESO_NASTRO)
                FrmSiwarexPara.LblDR30Siwa(2).caption = CStr(.SIWA_VELOX_NASTRO)
                FrmSiwarexPara.LblDR30Siwa(3).caption = CStr(.SIWA_PORTATA_NASTRO)
                
                appoggio = RoundNumber((CStr(.SIWA_AD_DIGIT_FILTERED) * 1.43 / 1000000) - 2, 2)
                If appoggio < 0 Then
                    appoggio = 0
                End If
                FrmSiwarexPara.LblDR31Siwa.caption = appoggio
                
                If FrmSiwarexPara.ProgressBarInvia.Value = 0 Then   'aggiunta questa condizione all'aggiornamento altrimenti le etichette del form si aggiornavamo con valori momentanei
                    Select Case CodiceComandoSiwarex
                        Case 203
                            'DR3
                            FrmSiwarexPara.LblDR3Siwa(0).caption = CStr(.SIWA_DIGIT_ZERO)
                            FrmSiwarexPara.LblDR3Siwa(1).caption = CStr(.SIWA_DIGIT_TARATURA)
                            FrmSiwarexPara.LblDR3Siwa(2).caption = CStr(.SIWA_PESO_TARATURA)
                            FrmSiwarexPara.LblDR3Siwa(3).caption = CStr(.SIWA_MILLIVOLT)
                            FrmSiwarexPara.LblDR3Siwa(4).caption = FrmSiwarexPara.CmbFiltroSiwa.list(.SIWA_FILTRO_FREQ)
                            FrmSiwarexPara.LblDR3Siwa(5).caption = CStr(.SIWA_FILTRO_MEDIA)
                            
                            If .SIWA_AUTOZERO Then
                                FrmSiwarexPara.ShapeDR3(6).BackColor = vbGreen
                                FrmSiwarexPara.CmdAutozero.BackColor = &H808080
                            Else
                                FrmSiwarexPara.ShapeDR3(6).BackColor = &H808080
                                FrmSiwarexPara.CmdAutozero.BackColor = vbGreen
                            End If
                            
                            FrmSiwarexPara.LblDR3Siwa(7).caption = CStr(.SIWA_PERC_SOTTO_ZERO)
                            FrmSiwarexPara.LblDR3Siwa(8).caption = CStr(.SIWA_PERC_SOPRA_ZERO)
                            FrmSiwarexPara.LblDR3Siwa(9).caption = CStr(.SIWA_TEMPO_CALIBRAZIONE)
                        
                        Case 205
                            'DR5
                            FrmSiwarexPara.LblDR5Siwa(0).caption = CStr(.SIWA_IMPULSI_METRO)
                            FrmSiwarexPara.LblDR5Siwa(1).caption = CStr(.SIWA_LUNGHEZZA)
                            FrmSiwarexPara.LblDR5Siwa(2).caption = CStr(.SIWA_CORREZIONE)
                            FrmSiwarexPara.LblDR5Siwa(3).caption = CStr(.SIWA_MIN_TOTALIZING)
                        
                        Case 230
    
                        Case 233
                            'DR33
                            FrmSiwarexPara.TxtDR33(5).text = CStr(.SIWA_TOTALIZER_5)
                            FrmSiwarexPara.TxtDR33(6).text = CStr(.SIWA_TOTALIZER_6)
                            
                    End Select
                End If
                '
            End If
        End If
        
        'Azzero il numero di comando e resetto cmd_enabled
        If (CodiceComandoSiwarex <> 999) And (NumeroSiwarex = Index) Then
            CodiceComandoSiwarex = 999
            CP240.OPCData.SOUpdate
        End If
        .SIWA_CMD_ENABLED = False
        
    End With

End Sub

Private Sub TimerSpegniNastroAuxRiciclato_Timer()
    TimerSpegniNastroAuxRiciclato.enabled = False
End Sub

Private Sub TimerSpegniNC_Timer()
    TimerSpegniNC.enabled = False
End Sub

Private Sub TimerStopDosaggioBatchManuale_Timer()
    TimerStopDosaggioBatchManuale.enabled = False
    CP240.OPCData.items(PLCTAG_DB80_StopDosaggioManuale).Value = False
End Sub

Private Sub TimerTagCambioVolo_Timer()
    Call SegnalaCambioRicettaAlPlc
End Sub

Private Sub TimerTaraturaSIWA_Timer()

    TimerTaraturaSIWA.enabled = False
    If CP240.OPCData.items(PLCTAG_DB80_ComandoDirettoPortina).Value And CP240.OPCData.items(PLCTAG_DI_SIWA_Batch_PortinaAperta).Value Then
        CodiceComandoSiwarex = 100
        Call AttivaComandoSiwarex(SiwarexRiciclatoFreddo)
    Else
        CP240.OPCData.items(PLCTAG_DB80_ComandoDirettoPortina).Value = False
        CP240.OPCData.items(PLCTAG_DO_SIWA_Batch_ModalitaTaratura).Value = False
        FrmSiwarexPara.ImgMotorTest.Picture = LoadResPicture("IDB_NASTROERRORE", vbResBitmap)
    End If

End Sub

'   Timer per la gestione dei trend
Private Sub TimerTrend_Timer()

    If (AbilitaControlloAllarmi = 2) Then
        
        If (TimerTrend.Interval <> 250) Then
            TimerTrend.Interval = 250
        End If

        Call TrendCampionamento

    End If

End Sub

Private Sub TimerVariazioneGrandezzaDosaggio_Timer()
    
    TimerVariazioneGrandezzaDosaggio.enabled = False

    CambioPercentualeDosaggio = True

End Sub

Private Sub TimerVibrCaricoFApp_Timer()

    If Not AbilitaTempoVibrCaricoFApp Then
        TimerVibrCaricoFApp.enabled = False
        Exit Sub
    End If

    ConteggioVibrCaricoFApp = ConteggioVibrCaricoFApp + 1
    AvvComandi.LblTempoRimastoVibrCaricoFApp.caption = "-" & SetVibrCaricoFApp - ConteggioVibrCaricoFApp
    AvvComandi.LblTempoRimastoVibrCaricoFApp.Visible = True

    If ConteggioVibrCaricoFApp >= SetVibrCaricoFApp Then
        TimerVibrCaricoFApp.enabled = False
        AvvComandi.LblTempoRimastoVibrCaricoFApp.Visible = False
        AvvComandi.APButtonCmdVari(5).Value = 1
        Call GestioneBottoniCmdVari(5, True)
    End If
End Sub


Private Sub TmrCodaMateriale_Timer()

    Call GcmCodaInerti_timer
    Call GcmCodaRiciclato_timer
    Call GcmCodaTamburoParallelo_timer

End Sub
'20170323
Private Sub tmrImpulsoRegBruc_Timer(Index As Integer)

    ListaTamburi(Index).ModulatoreBrucOnUp = False
    ListaTamburi(Index).ModulatoreBrucOnDown = False
    tmrImpulsoRegBruc(Index).enabled = False

End Sub
'

'20160512
Private Sub TmrKeyPressAndMouseMove_Timer()
    TmrKeyPressAndMouseMove.enabled = False
    Call SendMessagetoPlus(PlusSendKeyPressAndMouseMove, 0)
End Sub

Private Sub TmrSchiumato_Timer()

    'SCHIUMATO
    Call PLCSchiumato_Timer

End Sub

Private Sub TmrSoffioPredVuoto_Timer()

    Call RitardoSoffioPredVuoto
    
End Sub
'20150420
Private Sub TmrSyncroCmdSiloS7_Timer()
    
    SiloStatusLock = False
    TmrSyncroCmdSiloS7.enabled = False

End Sub

'   Timer per abilitare/disabilitare il comando di vibratore
Private Sub TmrVibratorePredVuoto_Timer()

    Call RitardoVibratorePredVuoto

End Sub

Private Sub TmrSetPredosatori_Timer()

    'If ((DEMO_VERSION Or AbilitaControlloAllarmi <> 0) And Not attesastartplc) Then
    If ((DEMO_VERSION Or AbilitaControlloAllarmi <> 0)) Then
        Call PredosatoriSet_timer
    End If

End Sub

Private Sub TrmNastroDeflettoreAnello_Timer()

    Dim posizione As Integer

    If (Not CP240.OPCData.items(PLCTAG_DI_NastrinoRiciclatoAnello2Elevatore).Value And NastroDeflettoreAnelloAcceso) Then
        NastroDeflettoreAnelloAcceso = False
        'Allarme nastrino rap a elevatore
        posizione = DlookUpExt("IndirizzoPLC", "CodificaAllarmi", "AM099", "IdDescrizione")
        IngressoAllarmePresente posizione, True
'        If ListaMotori(MotoreNastroTrasportatoreRiciclato).ritorno Then
'            Call SetMotoreUscita(MotoreNastroTrasportatoreRiciclato, False)
'        End If
        VisualizzaNastroDeflettoreAnello
    End If
    
    TrmNastroDeflettoreAnello.enabled = False
    
    Call VerificaNastroDeflettoreAnello

End Sub

Private Sub TimerVibrCaricoFApp2_Timer()
    If Not AbilitaTempoVibrCaricoFApp2 Then
        TimerVibrCaricoFApp2.enabled = False
        Exit Sub
    End If

    ConteggioVibrCaricoFApp2 = ConteggioVibrCaricoFApp2 + 1
    AvvComandi.LblTempoRimastoVibrCaricoFApp2.caption = "-" & SetVibrCaricoFApp2 - ConteggioVibrCaricoFApp2
    AvvComandi.LblTempoRimastoVibrCaricoFApp2.Visible = True

    If ConteggioVibrCaricoFApp2 >= SetVibrCaricoFApp2 Then
        TimerVibrCaricoFApp2.enabled = False
        AvvComandi.LblTempoRimastoVibrCaricoFApp2.Visible = False
        AvvComandi.APButtonCmdVari(6).Value = 1
        Call GestioneBottoniCmdVari(6, True)
    End If
End Sub
'
'20160503 sul timeout c'è un taglio al verde del semaforo che deve tornare rosso
Private Sub TmoutSemaforoBenna_Timer()
    TmoutSemaforoBenna.enabled = False
    SemaforoBenna.Comando_Verde = SemaforoBenna.Rit_Verde
    Call AggiornaImgSemaforo(SemaforoBenna.Rit_Verde, False, False)
End Sub
Private Sub TmoutSemaforoSili_Timer()
    TmoutSemaforoSili.enabled = False
    SemaforoSili.Comando_Verde = SemaforoSili.Rit_Verde
    Call AggiornaImgSemaforo(SemaforoSili.Rit_Verde, False, True)
End Sub
'20160503
