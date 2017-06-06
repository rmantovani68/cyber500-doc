VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FrmCalcolaImpasti 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " MARINI"
   ClientHeight    =   3015
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6195
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmCalcolaImpasti.frx":0000
   ScaleHeight     =   3015
   ScaleWidth      =   6195
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   2760
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   16
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":0ED6
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":1534
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":1B7B
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":21D1
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":2827
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":2DEF
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":33A4
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":3964
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":3F24
            Key             =   "PLUS_IMG_OK"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":446F
            Key             =   "PLUS_IMG_OK_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":4A0E
            Key             =   "PLUS_IMG_OK_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":4FB8
            Key             =   "PLUS_IMG_OK_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":5538
            Key             =   "PLUS_IMG_CALCOLA"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":5A29
            Key             =   "PLUS_IMG_CALCOLA_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":5F37
            Key             =   "PLUS_IMG_CALCOLA_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCalcolaImpasti.frx":6442
            Key             =   "PLUS_IMG_CALCOLA_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   480
      Index           =   4
      Left            =   1680
      Locked          =   -1  'True
      TabIndex        =   13
      Text            =   "80"
      Top             =   2325
      Visible         =   0   'False
      Width           =   840
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
      BackColor       =   &H0000FFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Index           =   3
      Left            =   5040
      Locked          =   -1  'True
      TabIndex        =   10
      Text            =   "10,5"
      Top             =   1500
      Width           =   840
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Index           =   2
      Left            =   3495
      Locked          =   -1  'True
      TabIndex        =   5
      Text            =   "40"
      Top             =   1500
      Width           =   840
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
      BackColor       =   &H00FF0000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   480
      Index           =   1
      Left            =   1680
      Locked          =   -1  'True
      TabIndex        =   3
      Text            =   "2500"
      Top             =   1500
      Width           =   825
   End
   Begin VB.TextBox TxtCalcolo 
      Alignment       =   2  'Center
      BackColor       =   &H000080FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Index           =   0
      Left            =   255
      TabIndex        =   1
      Text            =   "10,5"
      Top             =   1500
      Width           =   840
   End
   Begin MSComCtl2.UpDown UpDownCalcolo 
      Height          =   480
      Left            =   2505
      TabIndex        =   8
      Top             =   1500
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   847
      _Version        =   393216
      Value           =   500
      BuddyControl    =   "TxtCalcolo(1)"
      BuddyDispid     =   196609
      BuddyIndex      =   1
      OrigLeft        =   2520
      OrigTop         =   405
      OrigRight       =   2775
      OrigBottom      =   1725
      Increment       =   5
      Max             =   5000
      Min             =   500
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   3
      Left            =   0
      Picture         =   "FrmCalcolaImpasti.frx":6949
      Top             =   0
      Width           =   1050
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   2
      Left            =   1080
      Picture         =   "FrmCalcolaImpasti.frx":6E2A
      Top             =   0
      Width           =   1050
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   5040
      Picture         =   "FrmCalcolaImpasti.frx":7365
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   1
      Left            =   3960
      Picture         =   "FrmCalcolaImpasti.frx":791D
      Top             =   0
      Width           =   1125
   End
   Begin VB.Label LblCalcolo 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "~"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Index           =   8
      Left            =   4560
      TabIndex        =   12
      Top             =   1575
      Width           =   315
   End
   Begin VB.Label LblCalcolo 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Ton"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Index           =   7
      Left            =   5175
      TabIndex        =   11
      Top             =   1140
      Width           =   570
   End
   Begin VB.Label LblCalcolo 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Index           =   6
      Left            =   1965
      TabIndex        =   9
      Top             =   1980
      Visible         =   0   'False
      Width           =   270
   End
   Begin VB.Label LblCalcolo 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Index           =   4
      Left            =   2970
      TabIndex        =   7
      Top             =   1440
      Width           =   315
   End
   Begin VB.Label LblCalcolo 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "/"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Index           =   3
      Left            =   1305
      TabIndex        =   6
      Top             =   1470
      Width           =   165
   End
   Begin VB.Label LblCalcolo 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cicli"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Index           =   2
      Left            =   3615
      TabIndex        =   4
      Top             =   1140
      Width           =   615
   End
   Begin VB.Label LblCalcolo 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Kg"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Index           =   1
      Left            =   1905
      TabIndex        =   2
      Top             =   1140
      Width           =   390
   End
   Begin VB.Label LblCalcolo 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Ton"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Index           =   0
      Left            =   390
      TabIndex        =   0
      Top             =   1140
      Width           =   570
   End
End
Attribute VB_Name = "FrmCalcolaImpasti"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


Dim ImpastoPrecedente As Integer
Dim AperturaForm As Boolean


Private Enum TopBarButtonEnum
    uscita
    Help
    OK
    Calcola
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


Private Sub Form_Load()

    'Dim numeroSacchi As Integer

    Me.top = 3650
    Me.left = 150

    AperturaForm = True

    Call CarattereOccidentale(Me)
    
    Me.caption = CAPTIONSTARTSIMPLE

    UpDownCalcolo.max = ImpastoPeso()
    UpDownCalcolo.min = ImpastoPeso() * 40 / 100
   
    If TonnellateImpostate = 0 Then
        '20170123
        'TonnellateImpostate = RoundNumber(CicliDosaggioDaEseguire * DimensioneImpastoKg / 1000, 1)
        TonnellateImpostate = CDbl(FormatNumber(CicliDosaggioDaEseguire * DimensioneImpastoKg / 1000, 1))
    End If
    
    If (TonnellateImpostate > 0) Then
        TxtCalcolo(0).text = TonnellateImpostate
    Else
        TxtCalcolo(0).text = 30
        TonnellateImpostate = 30
    End If
    TxtCalcolo(4).text = CStr(RiduzioneImpasto)
    'TxtCalcolo(1).text = CStr(DimensioneImpastoKg)
    TxtCalcolo(1).text = CStr(ImpastoPeso)
    TxtCalcolo(2).text = NumeroImpastiCalcolato(TxtCalcolo(0).text, TxtCalcolo(1).text)
    LblCalcolo(2).caption = LoadXLSString(675)
    
    ImpastoPrecedente = CStr(ImpastoPeso)
    
    AperturaForm = False

    Call UpdatePulsantiForm

End Sub

Private Function NumeroImpastiCalcolato(totale As Double, Impasto As Integer) As Double

    If Impasto = 0 Then
        Impasto = CInt(GrandezzaImpasto(0) * 8 / 10)
        If Impasto = 0 Then
            NumeroImpastiCalcolato = 0
            Exit Function
        End If
    End If

    NumeroImpastiCalcolato = RoundNumber((totale * 1000) / Impasto, 0)

End Function

Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index
        Case TopBarButtonEnum.uscita
            Me.Hide
            Unload Me
            
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_DOSAGGIO_CALCOLO_PRODUZIONE
            
        Case TopBarButtonEnum.OK
        
            Call SetRiduzioneImpasto(TxtCalcolo(4).text)

            Call SetCicliDosaggioDaEseguire(val(TxtCalcolo(2).text))
        
            CambioPercentualeDosaggio = True
        
            Me.Hide
            Unload Me
            
        Case TopBarButtonEnum.Calcola
            Dim ParteIntera As Integer
            Dim ParteDecimale As Integer
            '20151105
            'Dim QuantitaScaricata As Long
            'Dim QuantitaInCorso As Long
            Dim QuantitaScaricata As Double
            Dim QuantitaInCorso As Double
            '
            Dim QuantitaRimanente As Double
            Dim CicliDaAggiungere As Long
            
            If Not DosaggioInCorso Then
                ParteDecimale = (CDbl(TxtCalcolo(0).text) * 1000) Mod (CDbl(TxtCalcolo(1).text))
                ParteIntera = (CDbl(TxtCalcolo(0).text) * 1000) \ (CDbl(TxtCalcolo(1).text))
                If ParteDecimale <> 0 Then
                    ParteIntera = ParteIntera + 1
                End If
                TxtCalcolo(1).text = CLng((CDbl(TxtCalcolo(0).text) * 1000) / ParteIntera)
                
                TxtCalcolo(4).text = RoundNumber(CLng(TxtCalcolo(1).text) / ImpastoPeso() * 100, 1) '20170302
            Else
                QuantitaScaricata = QuantitaImpastoProdotto
                CicliDaAggiungere = 1
                If val(CP240.LblKgDosaggio(2).caption) > 0 Then
                    '20151105
                    'QuantitaInCorso = CDbl(GrandezzaImpasto(0) + DimensioneImpastoKg)
                    QuantitaInCorso = GrandezzaImpasto(0) + DimensioneImpastoKg
                    '
                Else
                    '20151105
                    'QuantitaInCorso = DimensioneImpastoKg
                    QuantitaInCorso = CDbl(DimensioneImpastoKg)
                    '
                End If
                QuantitaRimanente = RoundNumber((CDbl(TxtCalcolo(0).text) * 1000 - QuantitaScaricata - QuantitaInCorso) / 1000, 1)
                If QuantitaRimanente < (CLng(ImpastoPeso()) * 40 / 100 / 1000) Then
                    Call ShowMsgBox(LoadXLSString(301), vbOKOnly, vbExclamation, -1, -1, False)
                    Exit Sub
                End If
                TxtCalcolo(0).text = QuantitaRimanente
                
                ParteDecimale = (CDbl(TxtCalcolo(0).text) * 1000) Mod (CDbl(TxtCalcolo(1).text))
                ParteIntera = (CDbl(TxtCalcolo(0).text) * 1000) \ (CDbl(TxtCalcolo(1).text))
                If ParteDecimale <> 0 Then
                    ParteIntera = ParteIntera + 1
                End If
                TxtCalcolo(1).text = CLng((CDbl(TxtCalcolo(0).text) * 1000) / ParteIntera)
                
                TxtCalcolo(2).text = CInt(TxtCalcolo(2).text) + CicliDaAggiungere + CicliDosaggioEseguiti
                    
                Call imgPulsanteForm_Click(2)
            End If
    End Select
End Sub


Private Sub TxtCalcolo_Change(Index As Integer)
    
    Dim numeroSacchi As Integer
    
    If AperturaForm Then
        Exit Sub
    End If

    Select Case Index
        Case 0
            '20151110
            'TxtCalcolo(Index).text = DatoCorretto(TxtCalcolo(Index).text, 1, 0, 9999, 30)
            TxtCalcolo(Index).text = DatoCorretto(Null2Qualcosa(TxtCalcolo(Index).text), 1, 0, 9999, 30)
            '
            TxtCalcolo(Index).SelStart = Len(TxtCalcolo(Index).text) '20160826
            
            If ErroreDatoParametri Then
                ErroreDatoParametri = False
            End If
            TxtCalcolo(2).text = NumeroImpastiCalcolato(TxtCalcolo(0).text, TxtCalcolo(1).text)
            TxtCalcolo(3).text = RoundNumber(TxtCalcolo(1).text * TxtCalcolo(2).text / 1000, 1)

        Case 1
            With CP240.AdoDosaggioNext.Recordset
                If (Not .EOF) Then
                    If (.Fields("AdditivoSacchi").Value = 1 And GestionePesoSacchi) Then
                        numeroSacchi = .Fields("NumSacchi").Value

                        If TxtCalcolo(1).text <= ImpastoPrecedente Then
                            If (ImpastoPrecedente - CInt((ImpastoPeso / numeroSacchi))) < UpDownCalcolo.min Then
                                TxtCalcolo(1).text = ImpastoPrecedente
                                Exit Sub
                            Else
                                TxtCalcolo(1).text = ImpastoPrecedente - CInt((ImpastoPeso / numeroSacchi))
                            End If
                        Else
                            TxtCalcolo(1).text = ImpastoPrecedente + CInt((ImpastoPeso / numeroSacchi))
                        End If
                    End If
                    ImpastoPrecedente = TxtCalcolo(1).text
                    '
                    TxtCalcolo(2).text = NumeroImpastiCalcolato(TxtCalcolo(0).text, TxtCalcolo(1).text)
                    TxtCalcolo(3).text = RoundNumber(TxtCalcolo(1).text * TxtCalcolo(2).text / 1000, 1)
                    TxtCalcolo(4).text = RoundNumber(CLng(TxtCalcolo(1).text) / ImpastoPeso() * 100, 1)
                End If
            End With
    End Select

End Sub


Private Sub TxtCalcolo_DblClick(Index As Integer)

    Dim min As Long
    Dim max As Long

    If Index = 1 Then
        min = ImpastoPeso() * 40 / 100
        max = ImpastoPeso()
        TxtCalcolo(Index).text = CStr(FrmNewValue.InputLongValue(Me, val(TxtCalcolo(Index).text), min, max))
    End If

End Sub

Private Sub TxtCalcolo_LostFocus(Index As Integer)

    If Index = 0 Then
        TxtCalcolo(Index).text = DatoCorretto(TxtCalcolo(Index).text, 1, 1, 9999, 30, 1)
        If ErroreDatoParametri Then
            ErroreDatoParametri = False
        End If
        TxtCalcolo(2).text = NumeroImpastiCalcolato(TxtCalcolo(0).text, TxtCalcolo(1).text)
        TxtCalcolo(3).text = RoundNumber(TxtCalcolo(1).text * TxtCalcolo(2).text / 1000, 1)
        TonnellateImpostate = TxtCalcolo(Index).text
    End If
    
End Sub

Private Sub imgPulsanteForm_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

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

    Call LoadImmaginiPulsantePlus(Index, pressed)

End Sub

Private Sub imgPulsanteForm_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

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
            
        Case TopBarButtonEnum.OK
            
            prefisso = "PLUS_IMG_OK"
            
        Case TopBarButtonEnum.Calcola
            
            prefisso = "PLUS_IMG_CALCOLA"
        Case Else
            Exit Sub
            
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FCI-001", CStr(Err.Number) + " [" + Err.description + "]"
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
