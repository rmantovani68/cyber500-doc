	VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Begin VB.Form AvvMotori 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   " MARINI"
   ClientHeight    =   11355
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   22500
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "AvviamentoMotori.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "AvviamentoMotori.frx":030A
   ScaleHeight     =   11355
   ScaleWidth      =   22500
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   56
      Left            =   18000
      TabIndex        =   387
      Top             =   6510
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   55
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   388
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   55
         Left            =   480
         TabIndex        =   389
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":8A04C
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Estr. Filler App.2"
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
         Index           =   55
         Left            =   1455
         TabIndex        =   393
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "56"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   55
         Left            =   180
         TabIndex        =   392
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   55
         Left            =   3480
         TabIndex        =   391
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   55
         Left            =   3480
         TabIndex        =   390
         Top             =   480
         Width           =   855
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   55
      Left            =   13500
      TabIndex        =   373
      Top             =   9750
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   54
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   386
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   54
         Left            =   480
         TabIndex        =   374
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":900EC
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Preseparatore 5"
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
         Index           =   54
         Left            =   1440
         TabIndex        =   378
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "55"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   54
         Left            =   135
         TabIndex        =   377
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   54
         Left            =   3480
         TabIndex        =   376
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   54
         Left            =   3480
         TabIndex        =   375
         Top             =   480
         Width           =   855
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   54
      Left            =   9000
      TabIndex        =   367
      Top             =   9750
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   53
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   385
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   53
         Left            =   480
         TabIndex        =   368
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":9618C
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   53
         Left            =   3480
         TabIndex        =   372
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   53
         Left            =   3480
         TabIndex        =   371
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "54"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   53
         Left            =   135
         TabIndex        =   370
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Preseparatore 4"
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
         Index           =   53
         Left            =   1455
         TabIndex        =   369
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   53
      Left            =   4500
      TabIndex        =   361
      Top             =   9750
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   52
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   384
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   52
         Left            =   480
         TabIndex        =   362
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":9C22C
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Preseparatore 3"
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
         Index           =   52
         Left            =   1455
         TabIndex        =   366
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "53"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   52
         Left            =   135
         TabIndex        =   365
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   52
         Left            =   3480
         TabIndex        =   364
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   52
         Left            =   3480
         TabIndex        =   363
         Top             =   480
         Width           =   855
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   51
      Left            =   13500
      TabIndex        =   349
      Top             =   8940
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   50
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   382
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   50
         Left            =   480
         TabIndex        =   350
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":A22CC
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   50
         Left            =   3480
         TabIndex        =   354
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   50
         Left            =   3480
         TabIndex        =   353
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "51"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   50
         Left            =   135
         TabIndex        =   352
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclee5 1-2-3 "
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
         Index           =   50
         Left            =   1440
         TabIndex        =   351
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   50
      Left            =   9000
      TabIndex        =   343
      Top             =   8940
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   49
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   381
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   49
         Left            =   480
         TabIndex        =   344
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":A836C
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclee4 1-2-3 "
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
         Index           =   49
         Left            =   1455
         TabIndex        =   348
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "50"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   49
         Left            =   135
         TabIndex        =   347
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   49
         Left            =   3480
         TabIndex        =   346
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   49
         Left            =   3480
         TabIndex        =   345
         Top             =   480
         Width           =   855
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   49
      Left            =   4500
      TabIndex        =   337
      Top             =   8940
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   48
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   380
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   48
         Left            =   480
         TabIndex        =   338
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":AE40C
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   48
         Left            =   3480
         TabIndex        =   342
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   48
         Left            =   3480
         TabIndex        =   341
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "49"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   48
         Left            =   135
         TabIndex        =   340
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclee3 1-2-3 "
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
         Index           =   48
         Left            =   1455
         TabIndex        =   339
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   12480
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   32
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B44AC
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B4B0A
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B5151
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B57A7
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B5DFD
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B63C5
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B697A
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B6F3A
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B74FA
            Key             =   "PLUS_IMG_LOGIN"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B7B31
            Key             =   "PLUS_IMG_LOGIN_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B819B
            Key             =   "PLUS_IMG_LOGIN_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B89D5
            Key             =   "PLUS_IMG_LOGIN_SELECTED"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B903D
            Key             =   "PLUS_IMG_COCLEA"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B9630
            Key             =   "PLUS_IMG_COCLEA_GRAY"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":B9C19
            Key             =   "PLUS_IMG_COCLEA_PRESS"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BA204
            Key             =   "PLUS_IMG_COCLEA_SELECTED"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BA7E2
            Key             =   "PLUS_IMG_AUTOMATICO"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BAE5D
            Key             =   "PLUS_IMG_AUTOMATICO_GRAY"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BB4CA
            Key             =   "PLUS_IMG_AUTOMATICO_PRESS"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BBB60
            Key             =   "PLUS_IMG_AUTOMATICO_SELECTED"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BC1F1
            Key             =   "PLUS_IMG_MANUALE"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BC84E
            Key             =   "PLUS_IMG_MANUALE_GRAY"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BCEAB
            Key             =   "PLUS_IMG_MANUALE_PRESS"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BD59E
            Key             =   "PLUS_IMG_MANUALE_SELECTED"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BDC14
            Key             =   "PLUS_IMG_MANUTENZMOT"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BE1A4
            Key             =   "PLUS_IMG_MANUTENZMOT_GRAY"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BE731
            Key             =   "PLUS_IMG_MANUTENZMOT_PRESS"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BECC1
            Key             =   "PLUS_IMG_MANUTENZMOT_SELECTED"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BF251
            Key             =   "PLUS_IMG_MOTORSTART"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BF939
            Key             =   "PLUS_IMG_MOTORSTART_GRAY"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":BFFE7
            Key             =   "PLUS_IMG_MOTORSTART_PRESS"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "AvviamentoMotori.frx":C06CF
            Key             =   "PLUS_IMG_MOTORSTART_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   47
      Left            =   18000
      TabIndex        =   187
      Top             =   5700
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   46
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   188
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   46
         Left            =   480
         TabIndex        =   330
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":C0DB0
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   46
         Left            =   3480
         TabIndex        =   284
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   46
         Left            =   3480
         TabIndex        =   283
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "47"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   46
         Left            =   135
         TabIndex        =   190
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Fillerizz. filtro con F2"
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
         Index           =   46
         Left            =   1455
         TabIndex        =   189
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   46
      Left            =   18000
      TabIndex        =   183
      Top             =   4890
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   45
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   184
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   45
         Left            =   480
         TabIndex        =   329
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":C6E50
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   45
         Left            =   3480
         TabIndex        =   282
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   45
         Left            =   3480
         TabIndex        =   281
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "46"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   45
         Left            =   135
         TabIndex        =   186
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Fillerizz. filtro con F1"
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
         Index           =   45
         Left            =   1455
         TabIndex        =   185
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   45
      Left            =   18000
      TabIndex        =   179
      Top             =   4080
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   44
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   180
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   44
         Left            =   480
         TabIndex        =   328
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":CCEF0
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   44
         Left            =   3480
         TabIndex        =   280
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   44
         Left            =   3480
         TabIndex        =   279
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Trasporto fillerizz. filtro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   510
         Index           =   44
         Left            =   1455
         TabIndex        =   182
         Top             =   165
         Width           =   1845
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "45"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   44
         Left            =   135
         TabIndex        =   181
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   44
      Left            =   18000
      TabIndex        =   175
      Top             =   3270
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   43
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   176
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   43
         Left            =   480
         TabIndex        =   327
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":D2F90
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   43
         Left            =   3480
         TabIndex        =   278
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   43
         Left            =   3480
         TabIndex        =   277
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "44"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   43
         Left            =   135
         TabIndex        =   178
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro bypass essiccatore riciclato"
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
         Index           =   43
         Left            =   1455
         TabIndex        =   177
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   43
      Left            =   18000
      TabIndex        =   171
      Top             =   2460
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   42
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   172
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   42
         Left            =   480
         TabIndex        =   326
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":D9030
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   42
         Left            =   3480
         TabIndex        =   276
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   42
         Left            =   3480
         TabIndex        =   275
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Compressore bruciatore 2"
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
         Index           =   42
         Left            =   1455
         TabIndex        =   174
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "43"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   42
         Left            =   135
         TabIndex        =   173
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   42
      Left            =   18000
      TabIndex        =   167
      Top             =   1650
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   41
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   168
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   41
         Left            =   480
         TabIndex        =   325
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":DF0D0
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   41
         Left            =   3480
         TabIndex        =   274
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   41
         Left            =   3480
         TabIndex        =   273
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Pompa alta pressione 2"
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
         Index           =   41
         Left            =   1455
         TabIndex        =   170
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "42"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   41
         Left            =   135
         TabIndex        =   169
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   41
      Left            =   18000
      TabIndex        =   163
      Top             =   840
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   40
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   164
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   40
         Left            =   480
         TabIndex        =   324
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":E5170
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   40
         Left            =   3480
         TabIndex        =   272
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   40
         Left            =   3480
         TabIndex        =   271
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Ventola bruciatore 2"
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
         Index           =   40
         Left            =   1455
         TabIndex        =   166
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "41"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   40
         Left            =   135
         TabIndex        =   165
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   40
      Left            =   13500
      TabIndex        =   159
      Top             =   8130
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   39
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   160
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   39
         Left            =   480
         TabIndex        =   323
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":EB210
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   39
         Left            =   3480
         TabIndex        =   270
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   39
         Left            =   3480
         TabIndex        =   269
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "40"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   39
         Left            =   135
         TabIndex        =   162
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Pompa combustibile 2"
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
         Index           =   39
         Left            =   1455
         TabIndex        =   161
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   39
      Left            =   13500
      TabIndex        =   155
      Top             =   7320
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   38
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   156
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   38
         Left            =   480
         TabIndex        =   322
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":F12B0
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   38
         Left            =   3480
         TabIndex        =   268
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   38
         Left            =   3480
         TabIndex        =   267
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Rotazione essiccatore 2"
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
         Index           =   38
         Left            =   1455
         TabIndex        =   158
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "39"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   38
         Left            =   135
         TabIndex        =   157
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   26
      Left            =   9000
      TabIndex        =   151
      Top             =   7320
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   25
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   152
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   25
         Left            =   480
         TabIndex        =   312
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":F7350
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   25
         Left            =   3480
         TabIndex        =   248
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   25
         Left            =   3480
         TabIndex        =   247
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Argano Benna"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   25
         Left            =   1455
         TabIndex        =   154
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "26"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   25
         Left            =   135
         TabIndex        =   153
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   17
      Left            =   4500
      TabIndex        =   147
      Top             =   7320
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   16
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   148
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   16
         Left            =   480
         TabIndex        =   302
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":FD3F0
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   16
         Left            =   3480
         TabIndex        =   228
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   16
         Left            =   3480
         TabIndex        =   227
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Rotazione essiccatore"
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
         Index           =   16
         Left            =   1455
         TabIndex        =   150
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "17"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   16
         Left            =   180
         TabIndex        =   149
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   7
      Left            =   0
      TabIndex        =   143
      Top             =   7320
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   6
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   144
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   6
         Left            =   480
         TabIndex        =   292
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":103490
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   6
         Left            =   3480
         TabIndex        =   208
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   6
         Left            =   3480
         TabIndex        =   207
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Vaglio"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   6
         Left            =   1455
         TabIndex        =   146
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "07"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   6
         Left            =   180
         TabIndex        =   145
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   1
      Left            =   0
      TabIndex        =   1
      Top             =   840
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   0
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   96
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   0
         Left            =   480
         TabIndex        =   0
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":109530
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   0
         Left            =   3480
         TabIndex        =   192
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   0
         Left            =   3480
         TabIndex        =   191
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "01"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   43
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Compressore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   0
         Left            =   1455
         TabIndex        =   19
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   2
      Left            =   0
      TabIndex        =   4
      Top             =   1650
      Width           =   4455
      Begin VB.CheckBox ChkAvvForzatoPCL 
         BackColor       =   &H00C0C0C0&
         Caption         =   "ForzaPCL"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   250
         Left            =   2985
         TabIndex        =   84
         Top             =   480
         Width           =   220
      End
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   1
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   97
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   1
         Left            =   480
         TabIndex        =   285
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":10F5D0
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   1
         Left            =   3480
         TabIndex        =   194
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   1
         Left            =   3480
         TabIndex        =   193
         Top             =   120
         Width           =   855
      End
      Begin VB.Image Image1 
         Height          =   240
         Left            =   2450
         Picture         =   "AvviamentoMotori.frx":115670
         Top             =   480
         Width           =   480
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "02"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   44
         Top             =   120
         Width           =   180
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
         Height          =   570
         Index           =   1
         Left            =   1455
         TabIndex        =   20
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   3
      Left            =   0
      TabIndex        =   40
      Top             =   2460
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   2
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   98
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   2
         Left            =   480
         TabIndex        =   286
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":115CFA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   2
         Left            =   3480
         TabIndex        =   196
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   2
         Left            =   3480
         TabIndex        =   195
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "03"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   2
         Left            =   195
         TabIndex        =   56
         Top             =   120
         Width           =   180
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
         Height          =   570
         Index           =   2
         Left            =   1455
         TabIndex        =   41
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   23
      Left            =   0
      TabIndex        =   42
      Top             =   3270
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   22
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   113
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   22
         Left            =   480
         TabIndex        =   287
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":11BD9A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   22
         Left            =   3480
         TabIndex        =   198
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   22
         Left            =   3480
         TabIndex        =   197
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "P.C. Legante 3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   22
         Left            =   1455
         TabIndex        =   71
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "23"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   22
         Left            =   180
         TabIndex        =   63
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   36
      Left            =   0
      TabIndex        =   131
      Top             =   4080
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   35
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   132
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   35
         Left            =   480
         TabIndex        =   288
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":121E3A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   35
         Left            =   3480
         TabIndex        =   200
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   35
         Left            =   3480
         TabIndex        =   199
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "36"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   35
         Left            =   180
         TabIndex        =   134
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Pompa Emulsione"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   35
         Left            =   1455
         TabIndex        =   133
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   4
      Left            =   0
      TabIndex        =   18
      Top             =   4890
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   3
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   99
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   3
         Left            =   480
         TabIndex        =   289
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":127EDA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   3
         Left            =   3480
         TabIndex        =   202
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   3
         Left            =   3480
         TabIndex        =   201
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "04"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   3
         Left            =   180
         TabIndex        =   48
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Aspiratore Filtro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   3
         Left            =   1455
         TabIndex        =   24
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   5
      Left            =   0
      TabIndex        =   6
      Top             =   5700
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   4
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   95
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   4
         Left            =   480
         TabIndex        =   290
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":12DF7A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   4
         Left            =   3480
         TabIndex        =   204
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   4
         Left            =   3480
         TabIndex        =   203
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "05"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   4
         Left            =   195
         TabIndex        =   59
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Mescolatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   4
         Left            =   1455
         TabIndex        =   32
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   6
      Left            =   0
      TabIndex        =   3
      Top             =   6510
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   5
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   100
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   5
         Left            =   480
         TabIndex        =   291
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":13401A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   5
         Left            =   3480
         TabIndex        =   206
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   5
         Left            =   3480
         TabIndex        =   205
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "06"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   5
         Left            =   180
         TabIndex        =   58
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Aspiratore Vaglio"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   5
         Left            =   1455
         TabIndex        =   31
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   8
      Left            =   0
      TabIndex        =   16
      Top             =   8130
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   7
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   101
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   7
         Left            =   480
         TabIndex        =   293
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":13A0BA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   7
         Left            =   3480
         TabIndex        =   210
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   7
         Left            =   3480
         TabIndex        =   209
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "08"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   7
         Left            =   195
         TabIndex        =   57
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Elevatore Caldo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   7
         Left            =   1455
         TabIndex        =   25
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   9
      Left            =   4500
      TabIndex        =   11
      Top             =   840
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   8
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   102
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   8
         Left            =   480
         TabIndex        =   294
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":14015A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   8
         Left            =   3480
         TabIndex        =   212
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   8
         Left            =   3480
         TabIndex        =   211
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "09"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   8
         Left            =   195
         TabIndex        =   52
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Ritorno"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   8
         Left            =   1455
         TabIndex        =   27
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   10
      Left            =   4500
      TabIndex        =   14
      Top             =   1650
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   9
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   103
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   9
         Left            =   480
         TabIndex        =   295
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1461FA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   9
         Left            =   3480
         TabIndex        =   214
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   9
         Left            =   3480
         TabIndex        =   213
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "10"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   9
         Left            =   195
         TabIndex        =   53
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Elevatore Filler1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   9
         Left            =   1455
         TabIndex        =   26
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   11
      Left            =   4500
      TabIndex        =   9
      Top             =   2460
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   10
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   104
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   10
         Left            =   480
         TabIndex        =   296
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":14C29A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   10
         Left            =   3480
         TabIndex        =   216
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   10
         Left            =   3480
         TabIndex        =   215
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "11"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   10
         Left            =   180
         TabIndex        =   60
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclee 1-2-3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   10
         Left            =   1455
         TabIndex        =   33
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   12
      Left            =   4500
      TabIndex        =   8
      Top             =   3270
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   11
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   105
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   11
         Left            =   480
         TabIndex        =   297
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":15233A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   11
         Left            =   3480
         TabIndex        =   218
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   11
         Left            =   3480
         TabIndex        =   217
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "12"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   11
         Left            =   195
         TabIndex        =   51
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Estr. Filler Rec."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   11
         Left            =   1455
         TabIndex        =   28
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   13
      Left            =   4500
      TabIndex        =   38
      Top             =   4080
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   12
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   106
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   12
         Left            =   480
         TabIndex        =   298
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1583DA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   12
         Left            =   3480
         TabIndex        =   220
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   12
         Left            =   3480
         TabIndex        =   219
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "13"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   12
         Left            =   195
         TabIndex        =   55
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Preseparatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   12
         Left            =   1455
         TabIndex        =   39
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   14
      Left            =   4500
      TabIndex        =   36
      Top             =   4890
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   13
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   107
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   13
         Left            =   480
         TabIndex        =   299
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":15E47A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   13
         Left            =   3480
         TabIndex        =   222
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   13
         Left            =   3480
         TabIndex        =   221
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "14"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   13
         Left            =   195
         TabIndex        =   54
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Elevatore Filler2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   13
         Left            =   1455
         TabIndex        =   37
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   15
      Left            =   4500
      TabIndex        =   12
      Top             =   5700
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   14
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   108
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   14
         Left            =   480
         TabIndex        =   300
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":16451A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   14
         Left            =   3480
         TabIndex        =   224
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   14
         Left            =   3480
         TabIndex        =   223
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "15"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   14
         Left            =   180
         TabIndex        =   61
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Estr. Filler App."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   14
         Left            =   1455
         TabIndex        =   34
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   16
      Left            =   4500
      TabIndex        =   5
      Top             =   6510
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   15
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   109
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   15
         Left            =   480
         TabIndex        =   301
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":16A5BA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   15
         Left            =   3480
         TabIndex        =   226
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   15
         Left            =   3480
         TabIndex        =   225
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "16"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   15
         Left            =   180
         TabIndex        =   50
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Filtro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   15
         Left            =   1455
         TabIndex        =   29
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   18
      Left            =   4500
      TabIndex        =   15
      Top             =   8130
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   17
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   124
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   17
         Left            =   480
         TabIndex        =   303
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":17065A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   17
         Left            =   3480
         TabIndex        =   230
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   17
         Left            =   3480
         TabIndex        =   229
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "18"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   17
         Left            =   180
         TabIndex        =   62
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Pompa Alim. Combustibile"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   17
         Left            =   1455
         TabIndex        =   35
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   32
      Left            =   9000
      TabIndex        =   88
      Top             =   840
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   31
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   121
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   31
         Left            =   480
         TabIndex        =   304
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1766FA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   31
         Left            =   3480
         TabIndex        =   232
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   31
         Left            =   3480
         TabIndex        =   231
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "32"
         DataMember      =   "datab"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   31
         Left            =   120
         TabIndex        =   90
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro lanciatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   31
         Left            =   1455
         TabIndex        =   89
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   31
      Left            =   9000
      TabIndex        =   85
      Top             =   1650
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   30
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   120
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   30
         Left            =   480
         TabIndex        =   305
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":17C79A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   30
         Left            =   3480
         TabIndex        =   234
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   30
         Left            =   3480
         TabIndex        =   233
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "31"
         DataMember      =   "datab"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   30
         Left            =   120
         TabIndex        =   87
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Vaglio inerti"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   30
         Left            =   1455
         TabIndex        =   86
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   20
      Left            =   9000
      TabIndex        =   13
      Top             =   2460
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   19
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   110
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   19
         Left            =   480
         TabIndex        =   306
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":18283A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   19
         Left            =   3480
         TabIndex        =   236
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   19
         Left            =   3480
         TabIndex        =   235
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "20"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   19
         Left            =   180
         TabIndex        =   47
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro Elev. Freddo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   19
         Left            =   1455
         TabIndex        =   23
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   21
      Left            =   9000
      TabIndex        =   7
      Top             =   3270
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   20
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   111
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   20
         Left            =   480
         TabIndex        =   307
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1888DA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   20
         Left            =   3480
         TabIndex        =   238
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   20
         Left            =   3480
         TabIndex        =   237
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "21"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   20
         Left            =   180
         TabIndex        =   45
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro Collettore1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   20
         Left            =   1455
         TabIndex        =   21
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   22
      Left            =   9000
      TabIndex        =   10
      Top             =   4080
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   21
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   112
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   21
         Left            =   480
         TabIndex        =   308
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":18E97A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   21
         Left            =   3480
         TabIndex        =   240
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   21
         Left            =   3480
         TabIndex        =   239
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "22"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   21
         Left            =   180
         TabIndex        =   46
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro Collettore2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   21
         Left            =   1455
         TabIndex        =   22
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   37
      Left            =   9000
      TabIndex        =   135
      Top             =   4890
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   36
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   136
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   36
         Left            =   480
         TabIndex        =   309
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":194A1A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   36
         Left            =   3480
         TabIndex        =   242
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   36
         Left            =   3480
         TabIndex        =   241
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro Collettore3"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   36
         Left            =   1455
         TabIndex        =   138
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "37"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   36
         Left            =   180
         TabIndex        =   137
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   24
      Left            =   9000
      TabIndex        =   68
      Top             =   5700
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   23
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   114
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   23
         Left            =   480
         TabIndex        =   310
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":19AABA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   23
         Left            =   3480
         TabIndex        =   244
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   23
         Left            =   3480
         TabIndex        =   243
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro Trasp. Riciclato"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   23
         Left            =   1455
         TabIndex        =   74
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "24"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   23
         Left            =   120
         TabIndex        =   72
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   25
      Left            =   9000
      TabIndex        =   67
      Top             =   6510
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   24
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   115
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   24
         Left            =   480
         TabIndex        =   311
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1A0B5A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   24
         Left            =   3480
         TabIndex        =   246
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   24
         Left            =   3480
         TabIndex        =   245
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Vaglio Sgros. Riciclato"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   24
         Left            =   1455
         TabIndex        =   75
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "25"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   24
         Left            =   195
         TabIndex        =   73
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   28
      Left            =   9000
      TabIndex        =   66
      Top             =   8130
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   27
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   117
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   27
         Left            =   480
         TabIndex        =   313
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1A6BFA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   27
         Left            =   3480
         TabIndex        =   250
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   27
         Left            =   3480
         TabIndex        =   249
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "28"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   27
         Left            =   135
         TabIndex        =   79
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Elevatore Riciclato"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   27
         Left            =   1455
         TabIndex        =   77
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   29
      Left            =   13500
      TabIndex        =   64
      Top             =   840
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   28
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   118
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   28
         Left            =   480
         TabIndex        =   314
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1ACC9A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   28
         Left            =   3480
         TabIndex        =   252
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   28
         Left            =   3480
         TabIndex        =   251
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro Col. Ric. Freddo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   28
         Left            =   1455
         TabIndex        =   82
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "29"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   28
         Left            =   135
         TabIndex        =   80
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   30
      Left            =   13500
      TabIndex        =   69
      Top             =   1650
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   29
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   119
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   29
         Left            =   480
         TabIndex        =   315
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1B2D3A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   29
         Left            =   3480
         TabIndex        =   254
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   29
         Left            =   3480
         TabIndex        =   253
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Vaglio Sgros. Ric. Freddo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   29
         Left            =   1455
         TabIndex        =   83
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "30"
         DataMember      =   "datab"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   29
         Left            =   120
         TabIndex        =   81
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      HelpContextID   =   20
      Index           =   27
      Left            =   13500
      TabIndex        =   17
      Top             =   2460
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   26
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   116
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   26
         Left            =   480
         TabIndex        =   316
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1B8DDA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   26
         Left            =   3480
         TabIndex        =   256
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   26
         Left            =   3480
         TabIndex        =   255
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "27"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   26
         Left            =   135
         TabIndex        =   78
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Ventola Viatop"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   26
         Left            =   1455
         TabIndex        =   76
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   19
      Left            =   13500
      TabIndex        =   2
      Top             =   3270
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   18
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   123
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   18
         Left            =   480
         TabIndex        =   317
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1BEE7A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   18
         Left            =   3480
         TabIndex        =   258
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   18
         Left            =   3480
         TabIndex        =   257
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "19"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   18
         Left            =   180
         TabIndex        =   49
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Ventola Bruciatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   18
         Left            =   1455
         TabIndex        =   30
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   33
      Left            =   13500
      TabIndex        =   91
      Top             =   4080
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   32
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   122
         Text            =   "100"
         Top             =   350
         Width           =   425
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   32
         Left            =   480
         TabIndex        =   318
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1C4F1A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   32
         Left            =   3480
         TabIndex        =   260
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   32
         Left            =   3480
         TabIndex        =   259
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro trasp. 2 Riciclato"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   32
         Left            =   1455
         TabIndex        =   94
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "33"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   32
         Left            =   180
         TabIndex        =   93
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      ClipControls    =   0   'False
      Height          =   810
      Index           =   34
      Left            =   13500
      TabIndex        =   65
      Top             =   4890
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   33
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   125
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   33
         Left            =   480
         TabIndex        =   319
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1CAFBA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   33
         Left            =   3480
         TabIndex        =   262
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   33
         Left            =   3480
         TabIndex        =   261
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "34"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   33
         Left            =   135
         TabIndex        =   127
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Compressore bruciatore"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   33
         Left            =   1455
         TabIndex        =   126
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   35
      Left            =   13500
      TabIndex        =   70
      Top             =   5700
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   34
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   128
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   34
         Left            =   480
         TabIndex        =   320
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1D105A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   34
         Left            =   3480
         TabIndex        =   264
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   34
         Left            =   3480
         TabIndex        =   263
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Pompa alta pressione"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   34
         Left            =   1455
         TabIndex        =   130
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "35"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   34
         Left            =   135
         TabIndex        =   129
         Top             =   120
         Width           =   180
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   38
      Left            =   13500
      TabIndex        =   139
      Top             =   6510
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   37
         Left            =   40
         Locked          =   -1  'True
         TabIndex        =   140
         Text            =   "100"
         Top             =   350
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   37
         Left            =   480
         TabIndex        =   321
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1D70FA
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   37
         Left            =   3480
         TabIndex        =   266
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   37
         Left            =   3480
         TabIndex        =   265
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "38"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   37
         Left            =   135
         TabIndex        =   142
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H000080FF&
         BackStyle       =   0  'Transparent
         Caption         =   "Nastro riciclato ""Jolly"""
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Index           =   37
         Left            =   1455
         TabIndex        =   141
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00C0C0C0&
      Caption         =   "0"
      Height          =   345
      Index           =   0
      Left            =   18120
      TabIndex        =   92
      Top             =   8520
      Width           =   495
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   48
      Left            =   0
      TabIndex        =   331
      Top             =   8940
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   47
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   379
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   47
         Left            =   480
         TabIndex        =   332
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1DD19A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclee2 1-2-3 "
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
         Index           =   47
         Left            =   1455
         TabIndex        =   336
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "48"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   47
         Left            =   135
         TabIndex        =   335
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   47
         Left            =   3480
         TabIndex        =   334
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   47
         Left            =   3480
         TabIndex        =   333
         Top             =   480
         Width           =   855
      End
   End
   Begin VB.Frame FrameAvvMotori 
      BackColor       =   &H00FFFFFF&
      Height          =   810
      Index           =   52
      Left            =   0
      TabIndex        =   355
      Top             =   9750
      Width           =   4455
      Begin VB.TextBox txtVelMot 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Index           =   51
         Left            =   0
         Locked          =   -1  'True
         TabIndex        =   383
         Text            =   "100"
         Top             =   360
         Width           =   390
      End
      Begin AniBtn.AniPushButton APButtonStartStopMotore 
         Height          =   615
         Index           =   51
         Left            =   480
         TabIndex        =   356
         Top             =   120
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   1085
         _StockProps     =   111
         BackColor       =   12632256
         Picture         =   "AvviamentoMotori.frx":1E323A
         Cycle           =   1
         ButtonVersion   =   1024
      End
      Begin VB.Label LblOreTot 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   51
         Left            =   3480
         TabIndex        =   360
         Top             =   480
         Width           =   855
      End
      Begin VB.Label LblOreParz 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "9999999"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   51
         Left            =   3480
         TabIndex        =   359
         Top             =   120
         Width           =   855
      End
      Begin VB.Label LblNumeroMotore 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "52"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   51
         Left            =   135
         TabIndex        =   358
         Top             =   120
         Width           =   180
      End
      Begin VB.Label LabelMotori 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Coclea Preseparatore 2"
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
         Index           =   51
         Left            =   1455
         TabIndex        =   357
         Top             =   165
         Width           =   1890
         WordWrap        =   -1  'True
      End
   End
   Begin VB.Image ImgMotorManagement 
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      Height          =   810
      Left            =   0
      Picture         =   "AvviamentoMotori.frx":1E92DA
      Top             =   10680
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   5
      Left            =   2250
      Picture         =   "AvviamentoMotori.frx":1E9945
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   4
      Left            =   1125
      Picture         =   "AvviamentoMotori.frx":1E9EC5
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   3
      Left            =   0
      Picture         =   "AvviamentoMotori.frx":1EA512
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   5520
      Picture         =   "AvviamentoMotori.frx":1EABEA
      Top             =   0
      Visible         =   0   'False
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   20340
      Picture         =   "AvviamentoMotori.frx":1EB211
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   21465
      Picture         =   "AvviamentoMotori.frx":1EB85F
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image StatusBarPlus 
      Height          =   675
      Left            =   0
      Picture         =   "AvviamentoMotori.frx":1EBE17
      Top             =   10680
      Width           =   57600
   End
End
Attribute VB_Name = "AvvMotori"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private MotoriEranoInAutomaticoAperturaForm As Boolean

Private Enum TopBarButtonEnum
    uscita
    Help
    Login
    'coclee
    Auto
    Semi
    Forz
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer
'


'Update Motor Mode
Public Sub UpdateManagement(managemode As MotorManagementEnum)
    Select Case managemode
        Case MotorManagementEnum.AutomaticMotor
            ImgMotorManagement.Picture = CP240.PlusImageList(0).ListImages("PLUS_IMG_AUTOMATICO").Picture
        Case MotorManagementEnum.SemiAutomaticMotor
            ImgMotorManagement.Picture = CP240.PlusImageList(0).ListImages("PLUS_IMG_MANUALE").Picture
        Case MotorManagementEnum.ForcingMotor
            ImgMotorManagement.Picture = CP240.PlusImageList(0).ListImages("PLUS_IMG_MANUTENZMOT").Picture
    End Select
End Sub

Private Sub APButtonStartStopMotore_Click(Index As Integer)
    
    If (Not FrmGestioneTimer.FiltraCmd.enabled = True) Then
        Dim motore As Integer

        motore = Index + 1

        '20160419
        'If (motore = MotoreMescolatore And DosaggioInCorso) Or (motore = MotorePCL And DosaggioInCorso) Or (motore = MotoreCompressore And DosaggioInCorso) Then
        'Se il motore è acceso con il dosaggio in corso, segnalo l'eventualità che si arresti tutto il dosaggio
        If (ListaMotori(motore).ComandoManuale And DosaggioInCorso) Then
            If (motore = MotoreMescolatore Or motore = MotorePCL Or motore = MotoreCompressore) Then
        '
                If (ShowMsgBox(LoadXLSString(136), vbOKCancel, vbExclamation, -1, -1, True) = vbCancel) Then
                    Call VisualizzaMotoreAcceso(motore)
                    Exit Sub
                End If
            End If
        End If
        
        If motore = MotoreFillerizzazioneFiltroRecupero Or motore = MotoreFillerizzazioneFiltroApporto Then
            Call ChkAvvioMotoriFillerizzazione(motore, (APButtonStartStopMotore(Index).Value = 2))
            Exit Sub
        End If
        
        
        '20161212
        If (motore <> MotoreNastroRapJolly) Then
            Call NMSetMotoreUscita(motore, Not ListaMotori(motore).ComandoManuale)
        Else
            If (NastroRapJollyVersoFreddo) Then
                Call NMSetMotoreUscita(motore, Not ListaMotori(motore).ComandoInversione)
            Else
                Call NMSetMotoreUscita(motore, Not ListaMotori(motore).ComandoManuale)
            End If
        End If
        '20161212
        'Call NMSetMotoreUscita(motore, Not ListaMotori(motore).ComandoManuale) '20161212
        'Call NMSetMotoreUscita(motore, (IIf(motore = MotoreNastroRapJolly And NastroRapJollyVersoFreddo, Not ListaMotori(motore).ComandoInversione, Not ListaMotori(motore).ComandoManuale))) '20161212

        If (APButtonStartStopMotore(Index).Value = 2) Then
            Call NMSetMotoreForzato(motore)
        Else
            Call NMSetMotoreForzato(0)
        End If
        
         Call MotoreAggiornaGrafica(motore)
         FrmGestioneTimer.FiltraCmd.Interval = 800
         FrmGestioneTimer.FiltraCmd.enabled = False
         FrmGestioneTimer.FiltraCmd.enabled = True

    Else
        If (APButtonStartStopMotore(Index).Value = 1) Then
            APButtonStartStopMotore(Index).Value = 2
        Else
            APButtonStartStopMotore(Index).Value = 1
        End If
    End If

End Sub


Private Sub ChkAvvForzatoPCL_Click()
    ForzaturaPCL = (ChkAvvForzatoPCL.Value = 1)
End Sub


Public Sub VisualizzaMotoreAcceso(motore As Integer)

	'    Debug.Print "VisualizzaMotoreAcceso - " + CStr(motore) + " / "; CStr(MotoreAcceso(motore))

    Dim eccecocleerec As Boolean
    Dim ecccoclepresep As Boolean

    'Se ho più coclee rec/presep al click della prima in semiautomatico (l'unica cliccabile) diventano verdi tutte anche durante la sirena
    'perchè il plc, una volta terminata la sirena. le accenderà tutte insieme
    eccecocleerec = (ListaMotori(MotoreCoclea123_2).presente Or ListaMotori(MotoreCoclea123_3).presente Or ListaMotori(MotoreCoclea123_4).presente Or ListaMotori(MotoreCoclea123_5).presente) And (MotorManagement = SemiAutomaticMotor) And SirenaInCorso
    eccecocleerec = eccecocleerec And (motore = MotoreCoclea123 Or motore = MotoreCoclea123_2 Or motore = MotoreCoclea123_3 Or motore = MotoreCoclea123_4 Or motore = MotoreCoclea123_5) And (ListaMotori(MotoreCoclea123).ComandoManuale Or ListaMotori(MotoreCoclea123_2).ComandoManuale Or ListaMotori(MotoreCoclea123_3).ComandoManuale Or ListaMotori(MotoreCoclea123_4).ComandoManuale Or ListaMotori(MotoreCoclea123_5).ComandoManuale)
    ecccoclepresep = (ListaMotori(MotoreCocleaPreseparatrice_2).presente Or ListaMotori(MotoreCocleaPreseparatrice_3).presente Or ListaMotori(MotoreCocleaPreseparatrice_4).presente Or ListaMotori(MotoreCocleaPreseparatrice_5).presente) And (MotorManagement = SemiAutomaticMotor) And SirenaInCorso
    ecccoclepresep = ecccoclepresep And (motore = MotoreCocleaPreseparatrice Or motore = MotoreCocleaPreseparatrice_2 Or motore = MotoreCocleaPreseparatrice_3 Or motore = MotoreCocleaPreseparatrice_4 Or motore = MotoreCocleaPreseparatrice_5) And (ListaMotori(MotoreCocleaPreseparatrice).ComandoManuale Or ListaMotori(MotoreCocleaPreseparatrice_2).ComandoManuale Or ListaMotori(MotoreCocleaPreseparatrice_3).ComandoManuale Or ListaMotori(MotoreCocleaPreseparatrice_4).ComandoManuale Or ListaMotori(MotoreCocleaPreseparatrice_5).ComandoManuale)

    If (ListaMotori(motore).SoloVisualizzazione) And (ListaMotori(motore).ritorno) Then
        APButtonStartStopMotore(motore - 1).Value = 4   'Solo visualizzato con ritorno
    ElseIf (ListaMotori(motore).SoloVisualizzazione) And (Not ListaMotori(motore).ritorno) Then
        APButtonStartStopMotore(motore - 1).Value = 3   'Solo visualizzato senza ritorno
    ElseIf (motore = MotoreNastroRapJolly And (ListaMotori(motore).ComandoManuale Or ListaMotori(motore).ComandoInversione)) Then  '20161212
        APButtonStartStopMotore(motore - 1).Value = 2   'Ritorno                 '20161212
    ElseIf ((MotorManagement <> AutomaticMotor And ((ListaMotori(motore).ComandoManuale And Not eccecocleerec And Not ecccoclepresep) Or eccecocleerec Or ecccoclepresep) Or ListaMotori(motore).ritorno)) Then '21401009
        APButtonStartStopMotore(motore - 1).Value = 2   'Ritorno
    Else
        APButtonStartStopMotore(motore - 1).Value = 1   'Spento
    End If

    If ListaMotori(motore).AllarmeTermica Then
        AvvMotori.APButtonStartStopMotore(motore - 1).Value = 6
    End If

    If Not ListaMotori(motore).ritorno And ListaMotori(motore).ComandoManuale Then
        AvvMotori.APButtonStartStopMotore(motore - 1).Value = 7
    End If

    If ListaMotori(motore).ForzatoDarwin Then
        If ListaMotori(motore).RitornoReale Then
            AvvMotori.APButtonStartStopMotore(motore - 1).Value = 9
        Else
            AvvMotori.APButtonStartStopMotore(motore - 1).Value = 8
        End If
    End If


    'Eccezione coclee in semi
    If (ListaMotori(MotoreCoclea123_2).presente Or ListaMotori(MotoreCoclea123_3).presente Or ListaMotori(MotoreCoclea123_4).presente Or ListaMotori(MotoreCoclea123_5).presente) Then
        If ((motore = MotoreCoclea123 Or motore = MotoreCoclea123_2 Or motore = MotoreCoclea123_3 Or motore = MotoreCoclea123_4 Or motore = MotoreCoclea123_5) And MotorManagement = SemiAutomaticMotor) Then
            APButtonStartStopMotore(MotoreCoclea123_2 - 1) = APButtonStartStopMotore(MotoreCoclea123 - 1)
            APButtonStartStopMotore(MotoreCoclea123_3 - 1) = APButtonStartStopMotore(MotoreCoclea123 - 1)
            APButtonStartStopMotore(MotoreCoclea123_4 - 1) = APButtonStartStopMotore(MotoreCoclea123 - 1)
            APButtonStartStopMotore(MotoreCoclea123_5 - 1) = APButtonStartStopMotore(MotoreCoclea123 - 1)
        End If
    End If
' &HFFFFFF, &H80FF&

    If (ListaMotori(motore).AllarmeTermica) Then
        LabelMotori(motore - 1).BackColor = &H80FF&     ' vbRed
    Else
        LabelMotori(motore - 1).BackColor = &HFFFFFF    ' FrameAvvMotori(motore - 1).BackColor
    End If

End Sub


Public Sub ShowMe(ByRef parente As Form)

    FrmMotoriVisibile = True
    
    Call Me.Show(vbModeless, parente)

End Sub

Private Sub Form_Activate()
    If (Me.Visible) Then
        Call VisualizzaBarraPulsantiCP240(False)
    End If
End Sub

Private Sub Form_Load()
    Dim motore As Integer
    Dim indiceLabel As Integer

    Call CarattereOccidentale(Me)
    
    Me.caption = CaptionStart + LoadXLSString(62)

    'Forzatura PCL
    ChkAvvForzatoPCL.Value = BoolToCheck(ForzaturaPCL)

    imgPulsanteForm(0).ToolTipText = LoadXLSString(568)
    imgPulsanteForm(1).ToolTipText = LoadXLSString(110)
    imgPulsanteForm(2).ToolTipText = LoadXLSString(1100)


    Call AggiornaOreMotori

    'Impostazione in Off dei led di avviamento motori in automatico
    'riguardante il form "AvvMotori".
    For motore = 1 To MAXMOTORI
        indiceLabel = motore - 1

        LabelMotori(indiceLabel).caption = ListaMotori(motore).Descrizione

        'Call VisualizzaMotoreAcceso(motore)

        txtVelMot(indiceLabel).text = CStr(ListaMotori(motore).uscitaAnalogica)
        txtVelMot(indiceLabel).Visible = (ListaMotori(motore).InverterPresente)
        LabelMotori(indiceLabel).BackStyle = 1 'stile opaco
        LabelMotori(indiceLabel).BackColor = &HFFFFFF  'stile opaco

        APButtonStartStopMotore(indiceLabel).enabled = (Not ListaMotori(motore).blocco)
        APButtonStartStopMotore(indiceLabel).Frame = 8
        APButtonStartStopMotore(indiceLabel).Picture = LoadResPicture("IDB_MOT_FORCE_OFF", vbResBitmap)
        APButtonStartStopMotore(indiceLabel).Frame = 9
        APButtonStartStopMotore(indiceLabel).Picture = LoadResPicture("IDB_MOT_FORCE_ON", vbResBitmap)

        Call VisualizzaMotoreAcceso(motore)

    Next motore

    Call MotoriInAutomatico_change

    Call MergeAvvMotori

    AvvMotori.imgPulsanteForm(3).enabled = Not MotorManagementPlcAutomatic
    AvvMotori.imgPulsanteForm(4).enabled = Not MotorManagementPlcSemiAutomatic
    AvvMotori.imgPulsanteForm(5).enabled = Not MotorManagementPlcForcing
'20150624
    Call PasswordLevel
'
    Call UpdatePulsantiForm

    '20170223
    'Call CambioMod(MotorManagement)
    Call CambioMod
    '
    
    Call UpdateManagement(MotorManagement)

    MotoriEranoInAutomaticoAperturaForm = MotoriInAutomatico

End Sub

Private Sub CmdPassword_Click()
    Call SendMessagetoPlus(PlusSendShowPASSWORD, 0)
End Sub


Public Sub AggiornaOreMotori()
    
    Dim motore As Integer

    For motore = 1 To MAXMOTORI
    
        With ListaMotori(motore)
        
            If (.presente) Then
                'OreLavoroParz e Tot sono minuti per cui divido per 60 per ottenere ore reali
                LblOreParz(motore - 1).caption = Format(.MinutiLavoroParz / 60, "0.0")
                LblOreTot(motore - 1).caption = Format(.MinutiLavoroTot / 60, "0.0")
        
            End If

        End With
        
    Next motore

End Sub
'

Private Sub MergeAvvMotori()

    '20150923
    Dim TotMotori As Long
    '
    Dim ContaMotori As Long
    Dim i As Integer
    Dim motore As Integer
    Dim Altezza As Long
    Dim Larghezza As Long
    Dim Righe As Long
    Dim CalcolaColonna As Long

    '20150923
    TotMotori = 0
    '
    For i = 1 To MAXMOTORI
        FrameAvvMotori(i).Visible = False

        '20150923
        motore = OrdineAvviamentoMotori(i)
        If ((motore = MotorePompaAltaPressione Or motore = MotorePompaAltaPressione2 Or motore = MotorePompaCombustibile) And ListaTamburi(0).SelezioneCombustibile = CombustibileGas) Then
        ElseIf (ListaMotori(motore).presente) Then
            TotMotori = TotMotori + 1
        End If
        '
    Next i

    'Disponibili
    FrameAvvMotori(0).Visible = False
    FrameAvvMotori(33).Visible = False
    FrameAvvMotori(34).Visible = False
    FrameAvvMotori(35).Visible = False

    Altezza = FrameAvvMotori(1).Height
    Larghezza = FrameAvvMotori(1).width + 45
    Righe = 12
    '20150923
    If (TotMotori <= 18) Then
        'Ci sono meno di 18 motori...in questo modo evito che venga una finestra troppo stretta e alta
        Righe = 6
    End If
    '

    ContaMotori = 0
    For i = 1 To MAXMOTORI
        motore = OrdineAvviamentoMotori(i)

        If (motore = MotorePompaAltaPressione Or motore = MotorePompaAltaPressione2 Or motore = MotorePompaCombustibile) And ListaTamburi(0).SelezioneCombustibile = CombustibileGas Then
            FrameAvvMotori(motore).Visible = False
        Else
            If ListaMotori(motore).presente Then
                FrameAvvMotori(motore).Visible = True
                CalcolaColonna = ContaMotori \ Righe
                FrameAvvMotori(motore).top = ContaMotori * Altezza - (CalcolaColonna * Altezza * Righe) + imgPulsanteForm(0).Height + 75

                FrameAvvMotori(motore).left = Larghezza * CalcolaColonna
                ContaMotori = ContaMotori + 1
            Else
                FrameAvvMotori(motore).Visible = False
            End If
        End If
       
    Next i

    If (ContaMotori Mod Righe > 0) Then
        Me.width = ((1 + ContaMotori \ Righe) * Larghezza) + 45
    Else
        Me.width = ((ContaMotori \ Righe) * Larghezza) + 45
    End If
    
    For i = (TopBarButtonEnum.TBB_LAST - 1) To 0 Step -1
        Select Case i
            Case TopBarButtonEnum.Help, TopBarButtonEnum.uscita
            'qui i pulsanti da allineare a destra
                imgPulsanteForm(i).left = Me.width - (imgPulsanteForm(i).width * (i + 1))
        End Select
    Next i
    'inizializza immagini
    Call LoadImmaginiPulsantePlus(TopBarButtonEnum.Auto, default)
    Call LoadImmaginiPulsantePlus(TopBarButtonEnum.Semi, default)
    Call LoadImmaginiPulsantePlus(TopBarButtonEnum.Forz, default)

    '20150923
    'Ridimensiono in base alle righe
    Me.Height = FrameAvvMotori(1).top + (FrameAvvMotori(1).Height * Righe) + StatusBarPlus.Height + 500 ' 500 = empirico!
    StatusBarPlus.top = Me.Height - StatusBarPlus.Height - 430 ' 430 = empirico!
    ImgMotorManagement.top = StatusBarPlus.top
    '

    'Posizionamento al centro del 1 monitor
    Call SetStartUpPosition(Me)

End Sub

Private Sub imgPulsanteForm_Click(Index As Integer)

    Select Case Index

        Case TopBarButtonEnum.uscita
            FrmMotoriVisibile = False
            
            Me.Hide
            Unload Me

            Call VisualizzaBarraPulsantiCP240(True)
            
        Case TopBarButtonEnum.Help
            VisualizzaHelp Me, HELP_MOTORI_FRAME
            
        Case TopBarButtonEnum.Login
            Call SendMessagetoPlus(PlusSendShowPASSWORD, 0)
            
        Case TopBarButtonEnum.Auto
            If (Not (CP240.OPCData.items(PLCTAG_NM_OUT_Ciclo_Sirena).Value)) Then
                Call SetMotorManagement(MotorManagementEnum.AutomaticMotor)
            End If
            
            If (MotoriInAutomatico) Then
                CP240.CmdAvvMotori(2).enabled = True
                CP240.CmdAvvMotori(1).enabled = True
            End If

        Case TopBarButtonEnum.Semi
            If (Not (CP240.OPCData.items(PLCTAG_NM_OUT_Ciclo_Sirena).Value)) Then
                Call SetMotorManagement(MotorManagementEnum.SemiAutomaticMotor)
            End If
            
        Case TopBarButtonEnum.Forz
            Dim buttonPressed As Integer
            buttonPressed = ShowMsgBox(strSiNo, vbOKCancel, vbExclamation, -1, -1, True)
            If (buttonPressed = vbCancel) Then
                Exit Sub
            End If
            If (Not (CP240.OPCData.items(PLCTAG_NM_OUT_Ciclo_Sirena).Value)) Then
                Call SetMotorManagement(MotorManagementEnum.ForcingMotor)
            End If

    End Select

End Sub


Public Sub CambioMod()
    If (ListaMotori(MotoreCoclea123_2).presente) Then
        APButtonStartStopMotore(MotoreCoclea123_2 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCoclea123_3).presente) Then
        APButtonStartStopMotore(MotoreCoclea123_3 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCoclea123_4).presente) Then
        APButtonStartStopMotore(MotoreCoclea123_4 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCoclea123_5).presente) Then
        APButtonStartStopMotore(MotoreCoclea123_5 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCocleaPreseparatrice_2).presente) Then
        APButtonStartStopMotore(MotoreCocleaPreseparatrice_2 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCocleaPreseparatrice_3).presente) Then
        APButtonStartStopMotore(MotoreCocleaPreseparatrice_3 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCocleaPreseparatrice_4).presente) Then
        APButtonStartStopMotore(MotoreCocleaPreseparatrice_4 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
    If (ListaMotori(MotoreCocleaPreseparatrice_5).presente) Then
        APButtonStartStopMotore(MotoreCocleaPreseparatrice_5 - 1).enabled = (MotorManagement = MotorManagementEnum.ForcingMotor)
    End If
End Sub


Private Sub LblOreParz_DblClick(Index As Integer)
    
    Dim motore As Integer

'20150309
    If ActiveUser < UsersEnum.OPERATOR Then
        Call MsgBox("More privileges are required", vbOKOnly + vbExclamation)
        Exit Sub
    End If

'

    If MsgBox(LoadXLSString(93), vbOKCancel + vbQuestion, "MARINI") = vbOK Then

        motore = Index + 1
    
        LblOreParz(Index).caption = 0
    
        Call AzzeraOreLavoroMotori(motore, False)
    End If

End Sub
'

Private Sub StatusBar1_PanelClick(ByVal Panel As MSComctlLib.Panel)

End Sub

Private Sub txtVelMot_DblClick(Index As Integer)
    ListaMotori(Index + 1).uscitaAnalogica = FrmNewValue.InputLongValue(Me, val(txtVelMot(Index).text), 0, 100)
    txtVelMot(Index).text = CStr(ListaMotori(Index + 1).uscitaAnalogica)
End Sub

Private Sub LblOreTot_DblClick(Index As Integer)

    Dim motore As Integer

    If ActiveUser < UsersEnum.ADMINISTRATOR Then
        Call MsgBox("More privileges are required", vbOKOnly + vbExclamation)
        Exit Sub
    End If

    motore = Index + 1

    If MsgBox(LoadXLSString(440) + vbCrLf + ListaMotori(motore).Descrizione, vbOKCancel + vbQuestion) = vbOK Then
        LblOreParz(Index).caption = 0
        LblOreTot(Index).caption = 0
        
        Call AzzeraOreLavoroMotori(motore, True)
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
        
        Case TopBarButtonEnum.Login
            prefisso = "PLUS_IMG_LOGIN"
        
        Case TopBarButtonEnum.Auto
            prefisso = "PLUS_IMG_MOTORSTART"

        Case TopBarButtonEnum.Semi
            prefisso = "PLUS_IMG_MANUALE"
        
        Case TopBarButtonEnum.Forz
            prefisso = "PLUS_IMG_MANUTENZMOT"
        
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FAM-001", CStr(Err.Number) + " [" + Err.description + "]"
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


Public Sub DebugMotore(motore As Integer)

    If (DEBUGGING) Then

        Dim debugString As String

        With ListaMotori(motore)

            If (.ComandoManuale) Then
                debugString = debugString + "ComandoManuale = " + CStr(.ComandoManuale) + " - "
            End If
            If (.ritorno) Then
                debugString = debugString + "Ritorno = " + CStr(.ritorno) + " - "
            End If
            If (.RitornoReale) Then
                debugString = debugString + "RitornoReale = " + CStr(.RitornoReale) + " - "
            End If
            If (.RitornoIndietro) Then
                debugString = debugString + "RitornoIndietro = " + CStr(.RitornoIndietro) + " - "
            End If
            If (.allarme > 0) Then
                debugString = debugString + "Allarme = " + CStr(.allarme) + " - "
            End If
            If (.blocco) Then
                debugString = debugString + "Blocco = " + CStr(.blocco) + " - "
            End If
            If (.ForzAccesoPLC) Then
                debugString = debugString + "Toggle = " + CStr(.ForzAccesoPLC) + " - "
            End If
            If (.ForzSpentoPLC) Then
                debugString = debugString + "Toggle = " + CStr(.ForzSpentoPLC) + " - "
            End If
            APButtonStartStopMotore(motore - 1).ToolTipText = debugString

        End With

    End If

End Sub

'Routine che mette in posizione corretta i Selettori per Forzatura da PLC
Public Sub ForzPLC(motore As Integer, valore As Boolean)
    'accensione forzata
    If (Not ListaMotori(motore).SoloVisualizzazione) Then
        If (valore) Then
            APButtonStartStopMotore(motore - 1).Value = 2
        Else
            APButtonStartStopMotore(motore - 1).Value = 1
        End If
    Else
         If (valore) Then
            APButtonStartStopMotore(motore - 1).Value = 4
        Else
            APButtonStartStopMotore(motore - 1).Value = 3
        End If
    End If
    Call NMSetMotoreUscita(motore, valore)
End Sub

'20150624
Private Sub PasswordLevel()

    Select Case ActiveUser
        Case UsersEnum.MANAGER To UsersEnum.SUPERUSER
            imgPulsanteForm(TopBarButtonEnum.Forz).enabled = True
        Case Else
            imgPulsanteForm(TopBarButtonEnum.Forz).enabled = False
    End Select

End Sub
