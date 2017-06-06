VERSION 5.00
Object = "{F72CC888-5ADC-101B-A56C-00AA003668DC}#1.0#0"; "ANIBTN32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Begin VB.Form FormProgRiscaldamentiCaldaie 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form1"
   ClientHeight    =   5865
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7440
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FormProgRiscaldamentiCaldaie.frx":0000
   ScaleHeight     =   5865
   ScaleWidth      =   7440
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ImageList PlusImageList 
      Left            =   3480
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   75
      ImageHeight     =   50
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   12
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":0F2E
            Key             =   "PLUS_IMG_SAVE"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":1558
            Key             =   "PLUS_IMG_SAVE_GRAY"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":1B9D
            Key             =   "PLUS_IMG_SAVE_PRESS"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":21FC
            Key             =   "PLUS_IMG_SAVE_SELECTED"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":2859
            Key             =   "PLUS_IMG_EXIT"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":2E21
            Key             =   "PLUS_IMG_EXIT_GRAY"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":33D6
            Key             =   "PLUS_IMG_EXIT_PRESS"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":3996
            Key             =   "PLUS_IMG_EXIT_SELECTED"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":3F56
            Key             =   "PLUS_IMG_HELP"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":45B4
            Key             =   "PLUS_IMG_HELP_GRAY"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":4BFB
            Key             =   "PLUS_IMG_HELP_PRESS"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FormProgRiscaldamentiCaldaie.frx":5251
            Key             =   "PLUS_IMG_HELP_SELECTED"
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton CmdAbilitaProg 
      BackColor       =   &H000000FF&
      Caption         =   "PROGRAMMAZIONE DISABILITATA"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   1560
      Style           =   1  'Graphical
      TabIndex        =   84
      Top             =   120
      Visible         =   0   'False
      Width           =   1635
   End
   Begin VB.CommandButton CmdSalva 
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   40
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.CommandButton CmdEsci 
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   550
      Left            =   960
      Style           =   1  'Graphical
      TabIndex        =   39
      Top             =   120
      Visible         =   0   'False
      Width           =   550
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00FFFFFF&
      Height          =   4095
      Left            =   120
      TabIndex        =   1
      Top             =   1680
      Width           =   7215
      Begin VB.ComboBox ComboTipoProg 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   360
         Style           =   2  'Dropdown List
         TabIndex        =   83
         Top             =   240
         Width           =   2895
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   6360
         TabIndex        =   82
         Text            =   "00"
         Top             =   3600
         Width           =   495
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   6360
         TabIndex        =   81
         Text            =   "00"
         Top             =   3120
         Width           =   495
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   6360
         TabIndex        =   80
         Text            =   "00"
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   6360
         TabIndex        =   79
         Text            =   "00"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   6360
         TabIndex        =   78
         Text            =   "00"
         Top             =   1680
         Width           =   495
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   6360
         TabIndex        =   77
         Text            =   "00"
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox TextSecOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   6360
         TabIndex        =   76
         Text            =   "00"
         Top             =   720
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   5760
         TabIndex        =   75
         Text            =   "00"
         Top             =   3600
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   5760
         TabIndex        =   74
         Text            =   "00"
         Top             =   3120
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   5760
         TabIndex        =   73
         Text            =   "00"
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   5760
         TabIndex        =   72
         Text            =   "00"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   5760
         TabIndex        =   71
         Text            =   "00"
         Top             =   1680
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   5760
         TabIndex        =   70
         Text            =   "00"
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox TextMinOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   5760
         TabIndex        =   69
         Text            =   "00"
         Top             =   720
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   5160
         TabIndex        =   68
         Text            =   "00"
         Top             =   3600
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   5160
         TabIndex        =   67
         Text            =   "00"
         Top             =   3120
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   5160
         TabIndex        =   66
         Text            =   "00"
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   5160
         TabIndex        =   65
         Text            =   "00"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   5160
         TabIndex        =   64
         Text            =   "00"
         Top             =   1680
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   5160
         TabIndex        =   63
         Text            =   "00"
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox TextOraOFF 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   5160
         TabIndex        =   62
         Text            =   "00"
         Top             =   720
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   4560
         TabIndex        =   61
         Text            =   "00"
         Top             =   3600
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   4560
         TabIndex        =   60
         Text            =   "00"
         Top             =   3120
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   4560
         TabIndex        =   59
         Text            =   "00"
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   4560
         TabIndex        =   58
         Text            =   "00"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   4560
         TabIndex        =   57
         Text            =   "00"
         Top             =   1680
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   4560
         TabIndex        =   56
         Text            =   "00"
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox TextSecON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   4560
         TabIndex        =   55
         Text            =   "00"
         Top             =   720
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   3960
         TabIndex        =   54
         Text            =   "00"
         Top             =   3600
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   3960
         TabIndex        =   53
         Text            =   "00"
         Top             =   3120
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   3960
         TabIndex        =   52
         Text            =   "00"
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   3960
         TabIndex        =   51
         Text            =   "00"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   3960
         TabIndex        =   50
         Text            =   "00"
         Top             =   1680
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   3960
         TabIndex        =   49
         Text            =   "00"
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox TextMinON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   3960
         TabIndex        =   48
         Text            =   "00"
         Top             =   720
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   3360
         TabIndex        =   47
         Text            =   "00"
         Top             =   3600
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   3360
         TabIndex        =   46
         Text            =   "00"
         Top             =   3120
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   3360
         TabIndex        =   45
         Text            =   "00"
         Top             =   2640
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   3360
         TabIndex        =   44
         Text            =   "00"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   3360
         TabIndex        =   43
         Text            =   "00"
         Top             =   1680
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   3360
         TabIndex        =   42
         Text            =   "00"
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox TextOraON 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   3360
         TabIndex        =   41
         Text            =   "00"
         Top             =   720
         Width           =   495
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   82
         Left            =   6240
         TabIndex        =   38
         Top             =   3600
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   81
         Left            =   5640
         TabIndex        =   37
         Top             =   3600
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   80
         Left            =   4440
         TabIndex        =   36
         Top             =   3600
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   79
         Left            =   3840
         TabIndex        =   35
         Top             =   3600
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   78
         Left            =   6240
         TabIndex        =   34
         Top             =   3120
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   77
         Left            =   5640
         TabIndex        =   33
         Top             =   3120
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   76
         Left            =   4440
         TabIndex        =   32
         Top             =   3120
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   75
         Left            =   3840
         TabIndex        =   31
         Top             =   3120
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   74
         Left            =   6240
         TabIndex        =   30
         Top             =   2640
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   73
         Left            =   5640
         TabIndex        =   29
         Top             =   2640
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   72
         Left            =   4440
         TabIndex        =   28
         Top             =   2640
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   71
         Left            =   3840
         TabIndex        =   27
         Top             =   2640
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   70
         Left            =   6240
         TabIndex        =   26
         Top             =   2160
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   69
         Left            =   5640
         TabIndex        =   25
         Top             =   2160
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   68
         Left            =   4440
         TabIndex        =   24
         Top             =   2160
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   67
         Left            =   3840
         TabIndex        =   23
         Top             =   2160
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   66
         Left            =   6240
         TabIndex        =   22
         Top             =   1680
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   65
         Left            =   5640
         TabIndex        =   21
         Top             =   1680
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   64
         Left            =   4440
         TabIndex        =   20
         Top             =   1680
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   63
         Left            =   3840
         TabIndex        =   19
         Top             =   1680
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   62
         Left            =   6240
         TabIndex        =   18
         Top             =   1200
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   61
         Left            =   5640
         TabIndex        =   17
         Top             =   1200
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   60
         Left            =   4440
         TabIndex        =   16
         Top             =   1200
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   59
         Left            =   3840
         TabIndex        =   15
         Top             =   1200
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   58
         Left            =   6240
         TabIndex        =   14
         Top             =   720
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   57
         Left            =   5640
         TabIndex        =   13
         Top             =   720
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   56
         Left            =   4440
         TabIndex        =   12
         Top             =   720
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   ":"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   55
         Left            =   3840
         TabIndex        =   11
         Top             =   720
         Width           =   135
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "SABATO"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   12
         Left            =   360
         TabIndex        =   10
         Top             =   3600
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "VENERDI"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   11
         Left            =   360
         TabIndex        =   9
         Top             =   3120
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "GIOVEDI"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   10
         Left            =   360
         TabIndex        =   8
         Top             =   2640
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "MERCOLEDI"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   9
         Left            =   360
         TabIndex        =   7
         Top             =   2160
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "MARTEDI"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   8
         Left            =   360
         TabIndex        =   6
         Top             =   1680
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "LUNEDI"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   7
         Left            =   360
         TabIndex        =   5
         Top             =   1200
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "DOMENICA"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   6
         Left            =   360
         TabIndex        =   4
         Top             =   720
         Width           =   2895
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "STOP"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   5
         Left            =   5160
         TabIndex        =   3
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label LblProgRiscCald 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "START"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   4
         Left            =   3360
         TabIndex        =   2
         Top             =   240
         Width           =   1695
      End
   End
   Begin AniBtn.AniPushButton APButtonInclusioneProg 
      Height          =   615
      Left            =   6480
      TabIndex        =   85
      Top             =   960
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1085
      _StockProps     =   111
      BackColor       =   12632256
      Picture         =   "FormProgRiscaldamentiCaldaie.frx":58A7
      Cycle           =   1
      ButtonVersion   =   1024
   End
   Begin VB.Image imgPulsanteForm 
      Appearance      =   0  'Flat
      Height          =   750
      Index           =   0
      Left            =   6450
      Picture         =   "FormProgRiscaldamentiCaldaie.frx":A9C5
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   1
      Left            =   5325
      Picture         =   "FormProgRiscaldamentiCaldaie.frx":AF7D
      Top             =   0
      Width           =   1125
   End
   Begin VB.Image imgPulsanteForm 
      Height          =   750
      Index           =   2
      Left            =   4200
      Picture         =   "FormProgRiscaldamentiCaldaie.frx":B5CB
      Top             =   0
      Width           =   1125
   End
   Begin VB.Label LblProgRiscCald 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "PROGRAMMA RISCALDAMENTI"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   6375
   End
End
Attribute VB_Name = "FormProgRiscaldamentiCaldaie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
'
Private Enum TopBarButtonEnum
    uscita
    Help
    Salva
    TBB_LAST
End Enum

Private PulsanteUpd(0 To (TopBarButtonEnum.TBB_LAST - 1)) As Boolean
Private PulsanteUpdForm As Boolean

Private selectedButtonIndex As Integer

Private Sub APButtonInclusioneProg_Click()

    InclusioneOrologio = (Not InclusioneOrologio)

    APButtonInclusioneProg.Value = IIf(InclusioneOrologio, 2, 1)

    SetInclusioneOrologio

End Sub


Private Sub ComboTipoProg_Click()
    AggiornaGraficaProgrammazione
End Sub

Public Sub AggiornaGraficaProgrammazione()
    
    Dim i As Integer
    
    If ComboTipoProg.ListIndex = 0 Then     'settimanale
        LblProgRiscCald(6).caption = LoadXLSString(1377)
        For i = 1 To 6
            LblProgRiscCald(i + 6).Visible = True
            TextOraON(i).Visible = True
            TextMinON(i).Visible = True
            TextSecON(i).Visible = True
            TextOraOFF(i).Visible = True
            TextMinOFF(i).Visible = True
            TextSecOFF(i).Visible = True
        Next
        For i = 59 To 82
            LblProgRiscCald(i).Visible = True
        Next i
    End If
    
    If ComboTipoProg.ListIndex = 1 Then     'giornaliera
        LblProgRiscCald(6).caption = LoadXLSString(1368)
        For i = 1 To 6
            LblProgRiscCald(i + 6).Visible = False
            TextOraON(i).Visible = False
            TextMinON(i).Visible = False
            TextSecON(i).Visible = False
            TextOraOFF(i).Visible = False
            TextMinOFF(i).Visible = False
            TextSecOFF(i).Visible = False
        Next
        For i = 59 To 82
            LblProgRiscCald(i).Visible = False
        Next i
    End If
    
    If ComboTipoProg.ListIndex = 2 Then     'feriale
        LblProgRiscCald(6).caption = LoadXLSString(1378)
        For i = 1 To 6
            LblProgRiscCald(i + 6).Visible = False
            TextOraON(i).Visible = False
            TextMinON(i).Visible = False
            TextSecON(i).Visible = False
            TextOraOFF(i).Visible = False
            TextMinOFF(i).Visible = False
            TextSecOFF(i).Visible = False
        Next
        For i = 59 To 82
            LblProgRiscCald(i).Visible = False
        Next i
    End If
    
    APButtonInclusioneProg.Value = IIf(InclusioneOrologio, 2, 1)
    
End Sub

Private Sub Form_Load()
Dim i As Integer

    SetStartUpPosition Me, 1

    ReadFileRiscaldamenti

    ComboTipoProg.AddItem LoadXLSString(1377), 0
    ComboTipoProg.AddItem LoadXLSString(1368), 1
    ComboTipoProg.AddItem LoadXLSString(1378), 2
    
    ComboTipoProg.text = ComboTipoProg.list(TipoDiProgrammazioneRiscaldamenti)
    
    LblProgRiscCald(6).caption = LoadXLSString(1369)
    LblProgRiscCald(7).caption = LoadXLSString(1370)
    LblProgRiscCald(8).caption = LoadXLSString(1371)
    LblProgRiscCald(9).caption = LoadXLSString(1372)
    LblProgRiscCald(10).caption = LoadXLSString(1373)
    LblProgRiscCald(11).caption = LoadXLSString(1374)
    LblProgRiscCald(12).caption = LoadXLSString(1375)
    LblProgRiscCald(0).caption = LoadXLSString(1376)
    
    For i = 0 To 6
        TextOraON(i) = TimerProg(i).OraON
        TextMinON(i) = TimerProg(i).MinON
        TextSecON(i) = TimerProg(i).SecON
        TextOraOFF(i) = TimerProg(i).OraOFF
        TextMinOFF(i) = TimerProg(i).MinOFF
        TextSecOFF(i) = TimerProg(i).SecOFF
    Next i
    
    AggiornaGraficaProgrammazione
    
    Call UpdatePulsantiForm
        
End Sub

Private Sub imgPulsanteForm_Click(Index As Integer)

    Dim buttonPressed As String

    Select Case Index
    
        Case TopBarButtonEnum.uscita

            If IsModifiedRiscaldamenti = True Then
                buttonPressed = MsgBox(LoadXLSString(788), vbYesNoCancel + vbQuestion, "MARINI")
                
                Select Case buttonPressed
                    Case vbYes
                        SalvaFileRiscaldamenti
                    Case vbCancel
                        Exit Sub
                End Select
            End If
            
            Me.Hide
            Unload Me
                
            Call VisualizzaBarraPulsantiCP240(True)
        Case TopBarButtonEnum.Help
'            VisualizzaHelp Me, HELP_SILI_DETTAGLIO

        Case TopBarButtonEnum.Salva
            Call SalvaFileRiscaldamenti
    End Select

End Sub

Private Sub TextMinOFF_Change(Index As Integer)
    Dim valoreInserito As Integer
    
    valoreInserito = CInt(TextMinOFF(Index).text)
    If valoreInserito > 59 Then
        Call ShowMsgBox(LoadXLSString(1367), vbOKOnly, vbCritical, -1, -1, True)
        TextMinOFF(Index).text = "0"
        TextMinOFF(Index).SetFocus
    End If
End Sub

Private Sub TextMinON_LostFocus(Index As Integer)
    Dim valoreInserito As Integer
    
    valoreInserito = CInt(TextMinON(Index).text)
    If valoreInserito > 59 Then
        Call ShowMsgBox(LoadXLSString(1367), vbOKOnly, vbCritical, -1, -1, True)
        TextMinON(Index).text = "0"
        TextMinON(Index).SetFocus
    End If
End Sub

Private Sub TextOraOFF_LostFocus(Index As Integer)
    Dim valoreInserito As Integer
    
    valoreInserito = CInt(TextOraOFF(Index).text)
    If valoreInserito > 23 Then
        Call ShowMsgBox(LoadXLSString(1367), vbOKOnly, vbCritical, -1, -1, True)
        TextOraOFF(Index).text = "0"
        TextOraOFF(Index).SetFocus
    End If
End Sub

Private Sub TextOraON_LostFocus(Index As Integer)
    Dim valoreInserito As Integer
    
    valoreInserito = CInt(TextOraON(Index).text)
    If valoreInserito > 23 Then
        Call ShowMsgBox(LoadXLSString(1367), vbOKOnly, vbCritical, -1, -1, True)
        TextOraON(Index).text = "0"
        TextOraON(Index).SetFocus
    End If
End Sub

Private Sub TextSecOFF_Change(Index As Integer)
    Dim valoreInserito As Integer
    
    valoreInserito = CInt(TextSecOFF(Index).text)
    If valoreInserito > 59 Then
        Call ShowMsgBox(LoadXLSString(1367), vbOKOnly, vbCritical, -1, -1, True)
        TextSecOFF(Index).text = "0"
        TextSecOFF(Index).SetFocus
    End If
End Sub

Private Sub TextSecON_LostFocus(Index As Integer)
    Dim valoreInserito As Integer
    
    valoreInserito = CInt(TextSecON(Index).text)
    If valoreInserito > 59 Then
        Call ShowMsgBox(LoadXLSString(1367), vbOKOnly, vbCritical, -1, -1, True)
        TextSecON(Index).text = "0"
        TextSecON(Index).SetFocus
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
        Case TopBarButtonEnum.Salva
            prefisso = "PLUS_IMG_SAVE"
        Case Else
            Exit Sub
    End Select
                                                                                                                                                                                                          
    imgPulsanteForm(Index).Picture = PlusImageList.ListImages(prefisso + PlusSuffissoFileImgPulsanteForm(stato)).Picture
            
    Exit Sub
Errore:
    LogInserisci True, "FRC-001", CStr(Err.Number) + " [" + Err.description + "]"
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
