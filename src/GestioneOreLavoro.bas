Attribute VB_Name = "GestioneOreLavoro"
'
'   Gestione delle ore di lvoro dei motori
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Private Const FileOreLavoro = "OreMotori.ini"
Private Const SEZIONE As String = "Motore"


Public Sub AzzeraOreLavoroMotori(motore As Integer, totale As Boolean)

    With ListaMotori(motore)

        .MinutiLavoroParz = 0

        If (totale) Then

            .MinutiLavoroTot = 0

        End If

        ScriveFileOreLavoro motore
    
    End With

End Sub


Public Sub CalcolaOreLavoroMotori()

    Dim motore As Integer
    Dim incrementoMinutiLavoro As Boolean


    incrementoMinutiLavoro = False

    For motore = 1 To MAXMOTORI

        With ListaMotori(motore)

            If .presente And .ritorno Then
                'Motore acceso

                If .pausaLavoro.abilitato Then

                    If .SecondiLavoroAppoggio >= 60 Then
                        .MinutiLavoroParz = .MinutiLavoroParz + 1
                        .MinutiLavoroTot = .MinutiLavoroTot + 1
                        incrementoMinutiLavoro = True
                        .SecondiLavoroAppoggio = 0
                    End If

                ElseIf .MinutiLavoroUltimoControllo = 0 Then

                    .MinutiLavoroUltimoControllo = ConvertiTimer()

                ElseIf ConvertiTimer() >= .MinutiLavoroUltimoControllo + 60 Then

                    .MinutiLavoroParz = .MinutiLavoroParz + 1
                    .MinutiLavoroTot = .MinutiLavoroTot + 1

                    ScriveFileOreLavoro motore

                    .MinutiLavoroUltimoControllo = ConvertiTimer()

                    incrementoMinutiLavoro = True

                End If

            Else
                .MinutiLavoroUltimoControllo = 0
            End If

        End With

    Next motore
    
    If (incrementoMinutiLavoro) Then
        
        If (FrmMotoriVisibile) Then
            AvvMotori.AggiornaOreMotori
        End If
    End If
    
End Sub

Public Sub LeggeFileOreLavoro()

    Dim motore As Integer
    Dim Nomefile As String
    Dim nomeSezione As String


    '   Legge i dati dal file

    Nomefile = UserDataPath + FileOreLavoro

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    For motore = 1 To MAXMOTORI

        nomeSezione = SEZIONE + CStr(motore)

        With ListaMotori(motore)

            .MinutiLavoroParz = CLng(FileGetValue(Nomefile, nomeSezione, "LavoroParz", "0"))
            .MinutiLavoroTot = CLng(FileGetValue(Nomefile, nomeSezione, "LavoroTot", "0"))

        End With

    Next motore

End Sub


Private Sub ScriveFileOreLavoro(motore As Integer)
    Dim Nomefile As String
    Dim nomeSezione As String


    Nomefile = UserDataPath + FileOreLavoro

    'Continua a leggere e scrivere su file .ini e non su XML (versione Caronte)

    nomeSezione = SEZIONE + CStr(motore)

    With ListaMotori(motore)

        FileSetValue Nomefile, nomeSezione, "LavoroParz", CStr(.MinutiLavoroParz)
        FileSetValue Nomefile, nomeSezione, "LavoroTot", CStr(.MinutiLavoroTot)

    End With

End Sub


