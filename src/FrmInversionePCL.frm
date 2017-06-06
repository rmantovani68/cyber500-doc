VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmInversionePCL 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   " MARINI"
   ClientHeight    =   4875
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4470
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "FrmInversionePCL.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmInversionePCL.frx":030A
   ScaleHeight     =   4875
   ScaleWidth      =   4470
   StartUpPosition =   1  'CenterOwner
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   1920
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":11E0
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":183E
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":1E85
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":24DB
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":2B31
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":30F9
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":36AE
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmInversionePCL.frx":3C6E
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   780
      Index           =   5
      Left            =   0
      TabIndex        =   20
      Top             =   4080
      Width           =   4455
      Begin VB.TextBox TxtTempo 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   5
         Left            =   3720
         TabIndex        =   21
         Text            =   "0"
         Top             =   120
         Width           =   615
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   5
         Left            =   120
         TabIndex        =   22
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "FrmInversionePCL.frx":422E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCountDown 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0000FF00&
         Caption         =   "-999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   3720
         TabIndex        =   24
         Top             =   480
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "P. Additivo Bacinella"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   5
         Left            =   1095
         TabIndex        =   23
         Top             =   165
         Width           =   2610
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   780
      Index           =   4
      Left            =   0
      TabIndex        =   15
      Top             =   3300
      Width           =   4455
      Begin VB.TextBox TxtTempo 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   4
         Left            =   3720
         TabIndex        =   16
         Text            =   "0"
         Top             =   120
         Width           =   615
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   4
         Left            =   120
         TabIndex        =   17
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "FrmInversionePCL.frx":6BA6
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCountDown 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0000FF00&
         Caption         =   "-999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   4
         Left            =   3720
         TabIndex        =   19
         Top             =   480
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "P. C. Emulsione"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   4
         Left            =   1095
         TabIndex        =   18
         Top             =   165
         Width           =   2610
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Timer TimerControllo 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   0
      Top             =   0
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   780
      Index           =   3
      Left            =   0
      TabIndex        =   6
      Top             =   2520
      Width           =   4455
      Begin VB.TextBox TxtTempo 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   3
         Left            =   3720
         TabIndex        =   11
         Text            =   "0"
         Top             =   120
         Width           =   615
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   7
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "FrmInversionePCL.frx":951E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCountDown 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0000FF00&
         Caption         =   "-999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   3720
         TabIndex        =   14
         Top             =   480
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "P. C. Legante 3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   480
         Index           =   3
         Left            =   1095
         TabIndex        =   8
         Top             =   165
         Width           =   2610
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   780
      Index           =   1
      Left            =   0
      TabIndex        =   3
      Top             =   960
      Width           =   4455
      Begin VB.TextBox TxtTempo 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   1
         Left            =   3720
         TabIndex        =   9
         Text            =   "0"
         Top             =   120
         Width           =   615
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   4
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         Picture         =   "FrmInversionePCL.frx":BE96
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCountDown 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0000FF00&
         Caption         =   "-999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   3720
         TabIndex        =   12
         Top             =   480
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "P. C. Legante 1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   480
         Index           =   1
         Left            =   1095
         TabIndex        =   5
         Top             =   165
         Width           =   2610
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   780
      Index           =   2
      Left            =   0
      TabIndex        =   0
      Top             =   1740
      Width           =   4455
      Begin VB.TextBox TxtTempo 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   2
         Left            =   3720
         TabIndex        =   10
         Text            =   "0"
         Top             =   120
         Width           =   615
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   1
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "FrmInversionePCL.frx":E80E
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblCountDown 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0000FF00&
         Caption         =   "-999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   3720
         TabIndex        =   13
         Top             =   480
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "P. C. Legante 2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   480
         Index           =   2
         Left            =   1095
         TabIndex        =   2
         Top             =   165
         Width           =   2610
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   2280
      Picture         =   "FrmInversionePCL.frx":11186
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   3405
      Picture         =   "FrmInversionePCL.frx":117D4
      Top             =   0
      Width           =   1125
   End
End
Attribute VB_Name = "FrmInversionePCL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

'SPECIFICHE TECNICHE CANTIERISTICHE
'   Invio il comando alla valvola e alla pompa nello stesso momento
'   Non controllo la temperatura, l'allarme viene comunque generato
'   Non controlliamo le valvole
'   Controllo solo che entro X secondi la PCL si accenda


Private OraStartPCL(1 To 5) As Long

Private Enum TopBarButtonEnum
    uscita
    Help
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'



Private Sub StartInversione(Index As Integer, start As Boolean)
    
    If (start) Then
        APButtonStartStopMotore(Index).Value = 2

        TimerControllo.enabled = False
        TimerControllo.enabled = True

        APButtonStartStopMotore(1).enabled = (Index = 1)
        APButtonStartStopMotore(2).enabled = (Index = 2)
        APButtonStartStopMotore(3).enabled = (Index = 3)
        APButtonStartStopMotore(4).enabled = (Index = 4)
        APButtonStartStopMotore(5).enabled = (Index = 5)

        LblCountDown(Index).Visible = True
        LblCountDown(Index).caption = TxtTempo(Index).text

        OraStartPCL(1) = IIf(Index = 1, ConvertiTimer(), 0)
        OraStartPCL(2) = IIf(Index = 2, ConvertiTimer(), 0)
        OraStartPCL(3) = IIf(Index = 3, ConvertiTimer(), 0)
        OraStartPCL(4) = IIf(Index = 4, ConvertiTimer(), 0)
        OraStartPCL(5) = IIf(Index = 5, ConvertiTimer(), 0)

        Select Case Index

            Case 1
                If (ListaMotori(MotorePCL).SoloVisualizzazione Or ListaMotori(MotorePCL).AllarmeTermica) Then
                    APButtonStartStopMotore(Index).Value = 1
                    Exit Sub
                End If

                ManualePesaturaComponenti = CompLegante1
                
                Call NMSetMotoreUscitaInv(MotorePCL, True)

            Case 2
                If (ListaMotori(MotorePCL2).SoloVisualizzazione Or ListaMotori(MotorePCL2).AllarmeTermica) Then
                    APButtonStartStopMotore(Index).Value = 1
                    Exit Sub
                End If

                ManualePesaturaComponenti = CompLegante2
'20151107
'                CP240.OPCData.items(PLCTAG_DO_InvMotore03).Value = True
                Call NMSetMotoreUscitaInv(MotorePCL2, True)
'
            Case 3
                If (ListaMotori(MotorePCL3).SoloVisualizzazione Or ListaMotori(MotorePCL3).AllarmeTermica) Then
                    Exit Sub
                End If

                CP240.OPCData.items(PLCTAG_DO_InvMotore23).Value = True

                If PlcSchiumato.Abilitazione Then
                    With CP240.OPCDataSchiumato
                        If .IsConnected Then
                            .items(DO_Pompa_Soft_Comando_Inversione_idx).Value = True
                        End If
                    End With
                End If

                'Call SetMotoreUscita(MotorePCL3, True)

                CP240.OPCData.items(PLCTAG_DO_ContalitriPesataManuale).Value = True

            Case 4
                ManualePesaturaComponenti = CompLegante2
                CP240.OPCData.items(PLCTAG_DO_InvMotore36).Value = True
                'Call SetMotoreUscita(MotorePompaEmulsione, True)

            Case 5
                InversioneAdditivi(2) = True
                ManualeAdditivi(2) = True
                Call AdditivoNellaBacinella(True)

        End Select
    Else
        APButtonStartStopMotore(Index).Value = 1

        'TimerControllo.enabled = False

        OraStartPCL(Index) = 0
        LblCountDown(Index).Visible = False

        APButtonStartStopMotore(1).enabled = True
        APButtonStartStopMotore(2).enabled = True
        APButtonStartStopMotore(3).enabled = True
        APButtonStartStopMotore(4).enabled = True
        APButtonStartStopMotore(5).enabled = True

        ManualePesaturaComponenti = compMax
        
        Select Case Index

            Case 1
                Call NMSetMotoreUscitaInv(MotorePCL, False)
            Case 2
                Call NMSetMotoreUscitaInv(MotorePCL2, False)
            Case 3
                Call NMSetMotoreUscitaInv(MotorePCL3, False)
                CP240.OPCData.items(PLCTAG_DO_ContalitriPesataManuale).Value = False
                If PlcSchiumato.Abilitazione Then
                    With CP240.OPCDataSchiumato
                        If .IsConnected Then
                            .items(DO_Pompa_Soft_Comando_Inversione_idx).Value = False
                        End If
                    End With
                End If

            Case 4
                'Call SetMotoreUscita(MotorePompaEmulsione, False)
                CP240.OPCData.items(PLCTAG_DO_InvMotore36).Value = False

            Case 5
                ManualeAdditivi(2) = False
                Call AdditivoNellaBacinella(False)

        End Select

    End If

End Sub
'

Private Sub APButtonStartStopMotore_Click(Index As Integer)
    Call StartInversione(Index, (APButtonStartStopMotore(Index).Value = 2))
End Sub

Public Sub ShowMe(Modo As Integer, ByRef parent As Form)

    Call AbilitaPulsFormInversione
    
    FrmInversionePCLVisibile = True

    Me.Show Modo, parent

End Sub


Private Sub Form_Load()
Dim i As Integer

    Call CarattereOccidentale(Me)

    Me.caption = CaptionStart + LoadXLSString(35)
    '20160428
    'Frame1(1).Visible = (AbilitaInversionePCL And ListaMotori(MotorePCL).presente)
    '20160428
    Frame1(2).Visible = (AbilitaInversionePCL And ListaMotori(MotorePCL2).presente)
    Frame1(3).Visible = (AbilitaInversionePCL And ListaMotori(MotorePCL3).presente)
    Frame1(4).Visible = (AbilitaInversionePCL And ListaMotori(MotorePompaEmulsione).presente)
    Frame1(5).Visible = AbilitaInversioneAdditivoBacinella
    
    imgPulsanteForm(0).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(1).ToolTipText = LoadXLSString(110)
    
    LabelMotori(1).caption = ListaMotori(MotorePCL).Descrizione
    LabelMotori(2).caption = ListaMotori(MotorePCL2).Descrizione
    LabelMotori(3).caption = ListaMotori(MotorePCL3).Descrizione
    LabelMotori(4).caption = ListaMotori(MotorePompaEmulsione).Descrizione
    LabelMotori(5).caption = LoadXLSString(803)

    For i = 1 To 5
        TxtTempo(i).text = 300

        APButtonStartStopMotore(i).Frame = 1
        'APButtonStartStopMotore(i).Picture = LoadPicture(PlusGraficPath + "Switch_off.bmp")
        APButtonStartStopMotore(i).Picture = LoadResPicture("IDB_MOT_SWITCH_OFF", vbResBitmap)
        APButtonStartStopMotore(i).Frame = 2
        'APButtonStartStopMotore(i).Picture = LoadPicture(PlusGraficPath + "Switch_on.bmp")
        APButtonStartStopMotore(i).Picture = LoadResPicture("IDB_MOT_SWITCH_ON", vbResBitmap)
        APButtonStartStopMotore(i).Frame = 3
        'APButtonStartStopMotore(i).Picture = LoadPicture(PlusGraficPath + "Switch_err.bmp")
        APButtonStartStopMotore(i).Picture = LoadResPicture("IDB_MOT_SWITCH_ERR", vbResBitmap)
    Next i

    Call UpdatePulsantiForm

End Sub


Private Sub imgPulsanteForm_Click(Index As Integer)
    
Dim indice As Integer
    
    Select Case Index
        Case TopBarButtonEnum.uscita
            
            For indice = 1 To 5
            
                OraStartPCL(indice) = 0
        
                If indice <= 3 Then
                    InversioneAdditivi(indice - 1) = False
                End If
                
            Next indice
        
            Call NMSetMotoreUscitaInv(MotorePCL, False)
            Call NMSetMotoreUscitaInv(MotorePCL2, False)
            Call NMSetMotoreUscitaInv(MotorePCL3, False)
            
            'Call SetMotoreUscita(MotorePompaEmulsione, False)
            ManualeAdditivi(2) = False
            Call AdditivoNellaBacinella(False)
        
            CP240.OPCData.items(PLCTAG_DO_InvMotore02).Value = False
            CP240.OPCData.items(PLCTAG_DO_InvMotore03).Value = False
            CP240.OPCData.items(PLCTAG_DO_InvMotore23).Value = False
            CP240.OPCData.items(PLCTAG_DO_InvMotore36).Value = False
                
            If PlcSchiumato.Abilitazione Then
                With CP240.OPCDataSchiumato
                    If .IsConnected Then
                        .items(DO_Pompa_Soft_Comando_Inversione_idx).Value = False
                    End If
                End With
            End If
        
            CP240.OPCData.items(PLCTAG_DO_ContalitriPesataManuale).Value = False
        
            ManualePesaturaComponenti = compMax
            
            Me.Hide
            Unload Me
        
            FrmInversionePCLVisibile = False
        
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_INIZIO
    End Select
    
End Sub



'Con la nuova Gestione Motori i controlli sui ritorni non ci devono più essere
'Sul fronte dell'allarme del motore si stacca la giusta PCL (1=PCL, 2=PCL2, 3=PCL3)
Public Sub ControllaPCL(Index)
    Dim conteggio As Long
    Dim allarmeDB101 As Integer
    Dim allarmeDB102 As Integer
    Dim allarmeSI002 As Integer
    Dim i As Integer
    
    conteggio = (CLng(TxtTempo(Index).text) - (ConvertiTimer() - OraStartPCL(Index)))
    LblCountDown(Index).caption = conteggio
    If (conteggio >= 0) Then
        i = Index
        Call StartInversione(i, False)
    End If
End Sub


'Il timer ora esegue solo l'aggiornamento del tempo residuo
Private Sub TimerControllo_Timer()

    Dim i As Integer
    Dim conteggio As Long
    Dim allarmeDB101 As Integer
    Dim allarmeDB102 As Integer
    Dim allarmeSI002 As Integer

    For i = 1 To 5
        If (OraStartPCL(i) <> 0) Then

            conteggio = (CLng(TxtTempo(i).text) - (ConvertiTimer() - OraStartPCL(i)))
            LblCountDown(i).caption = conteggio
            If (conteggio >= 0) Then
                TimerControllo.enabled = False
                TimerControllo.enabled = True
            Else
                TimerControllo.enabled = False
                Call StartInversione(i, False)
            End If

        End If
    Next i
End Sub
'


Private Sub TxtTempo_Change(Index As Integer)

    TxtTempo(Index).text = DatoCorretto(TxtTempo(Index), 0, 0, 999, 300)
    ErroreDatoParametri = False
    
End Sub

Private Sub TxtTempo_LostFocus(Index As Integer)

    TxtTempo(Index).text = DatoCorretto(TxtTempo(Index), 0, 0, 999, 300, 1)
    If ErroreDatoParametri Then
        ErroreDatoParametri = False
    End If

End Sub

Private Sub imgPulsanteForm_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    'Colora pulsante
        
    If selectedButtonIndex <> Index Then
        Call Form_MouseMove(Button, Shift, x, Y)
    End If
    
    If Not PulsanteUpd(Index) Then
        If imgPulsanteForm(Index).enabled Then
            Call LoadImmaginiPulsantePlus(Index, StatoPulsantePlus.Selected)
        Else
            Call LoadImmaginiPulsantePlus(Index, StatoPulsantePlus.Disabled)
        End If
        PulsanteUpd(Index) = True
        selectedButtonIndex = Index
    End If
    
    PulsanteUpdForm = False
    
End Sub

Private Sub imgPulsanteForm_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    'Colora pulsante

    Call LoadImmaginiPulsantePlus(Index, pressed)

End Sub

Private Sub imgPulsanteForm_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    'Colora pulsante
    
    Call LoadImmaginiPulsantePlus(Index, Selected)

End Sub


Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    
Dim indice As Integer
    
    If Not PulsanteUpdForm Then

        For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
            If PulsanteUpd(indice) Then
                If imgPulsanteForm(indice).enabled Then
                    Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
                Else
                    Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.Disabled)
                End If
                PulsanteUpd(indice) = False
            End If
        Next indice
    
        PulsanteUpdForm = True
    
    End If

End Sub


Private Sub LoadImmaginiPulsantePlus(Index As Integer, stato As StatoPulsantePlus)
Dim prefisso As String
    
    On Error GoTo Errore
                                                                   
'selezione prefisso nome immagine
                                                                                                                                                                                                     
    Select Case Index
        Case TopBarButtonEnum.uscita
            prefisso = "PLUS_IMG_EXIT"
        Case TopBarButtonEnum.Help
            prefisso = "PLUS_IMG_HELP"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FIP-001", CStr(Err.Number) + " [" + Err.description + "]"
End Sub


Public Sub UpdatePulsantiForm()
        
Dim indice As Integer
        
    For indice = 0 To (TopBarButtonEnum.TBB_LAST - 1)
        If imgPulsanteForm(indice).enabled Then
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.default)
        Else
            Call LoadImmaginiPulsantePlus(indice, StatoPulsantePlus.Disabled)
        End If
    Next indice

End Sub

