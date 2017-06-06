Attribute VB_Name = "CodaCircolare"
'
'   Gestione della coda circolare
'
'   2008 - MARINI - Fayat group
'
'   Via Roma, 50 - 48011 Alfonsine (RA)
'


Option Explicit


Public CodaInerti As CqType
Public CodaTamburoParallelo As CqType

'   Lunghezza della coda
Public Const MAXFIFO = 720
'

'   Struttura contenente un singolo elemento
Public Type FifoMaterialeType

    '   Kg rilevati dalla bilancia
    Kg As Double

    '   Ora del deposito
    orario As Long

    '   Nome della ricetta
    ricetta As String

End Type

'   Struttura della coda circolare
Public Type CqType

    '   Numero di elementi da considerare (<= MAXFIFO)
    maxItems As Integer

    '   Inizio e fine coda
    startPos As Integer
    endPos As Integer

    '   Lista di elementi
    list(0 To MAXFIFO - 1) As FifoMaterialeType

End Type


'   Inizializzazione della coda
Public Function CqInit(ByRef cq As CqType, maxItems As Integer) As Boolean

    CqInit = False

    If (maxItems > MAXFIFO) Then
        Exit Function
    End If

    cq.maxItems = maxItems

    cq.startPos = 0
    cq.endPos = 0

    CqInit = True

End Function


'   Aggiunge un nuovo elemento in coda
Public Function CqAdd(ByRef cq As CqType, ByRef materiale As FifoMaterialeType) As Boolean

    CqAdd = False

    If (cq.endPos = cq.startPos - 1 Or (cq.endPos = cq.maxItems - 1 And cq.startPos = 0)) Then
        Exit Function
    End If

    cq.list(cq.endPos) = materiale

    '   Elemento in più
    cq.endPos = cq.endPos + 1

    '   Se sono in fondo torno a 0
    If (cq.endPos > cq.maxItems - 1) Then
        cq.endPos = 0
    End If

    CqAdd = True

End Function


'   Rimuove l'ultimo elemento dalla coda
Public Function CqRemove(ByRef cq As CqType, ByRef materiale As FifoMaterialeType) As Boolean

    CqRemove = False

    If (cq.endPos = cq.startPos) Then
        '   Vuoto
        Exit Function
    End If

    materiale = cq.list(cq.startPos)

    '   Elemento in meno
    cq.startPos = cq.startPos + 1

    '   Se sono in fondo torno a 0
    If (cq.startPos > cq.maxItems - 1) Then
        cq.startPos = 0
    End If

    CqRemove = True

End Function


'   Rimuove l'ultimo elemento dalla coda se il numero di elementi memorizzati equivale a maxItems
Public Function CqRemoveIf(ByRef cq As CqType, ByRef materiale As FifoMaterialeType) As Boolean

    CqRemoveIf = False

    If (cq.endPos = cq.startPos - 1 Or (cq.endPos = cq.maxItems - 1 And cq.startPos = 0)) Then
        CqRemoveIf = CqRemove(cq, materiale)
    End If

End Function


'   Verifica se ci sono elementi in coda
Public Function CqEmpty(ByRef cq As CqType) As Boolean

    Dim index As Integer

    CqEmpty = (cq.endPos = cq.startPos)

    If (Not CqEmpty) Then
        If (cq.endPos > cq.startPos) Then
            For index = cq.startPos To cq.endPos
                If (cq.list(index).ricetta <> "") Then
                    CqEmpty = False
                    Exit Function
                End If
            Next index
        Else
            For index = 0 To cq.endPos
                If (cq.list(index).ricetta <> "") Then
                    CqEmpty = False
                    Exit Function
                End If
            Next index
            For index = cq.startPos To cq.maxItems - 1
                If (cq.list(index).ricetta <> "") Then
                    CqEmpty = False
                    Exit Function
                End If
            Next index
        End If
        CqEmpty = True
    End If

End Function


'   Calcola i Kg in movimento
Public Function CqAmount(ByRef cq As CqType) As Double

    Dim index As Integer
    Dim isEmpty As Boolean

    isEmpty = (cq.endPos = cq.startPos)

    If (Not isEmpty) Then
        If (cq.endPos > cq.startPos) Then
            For index = cq.startPos To cq.endPos
                If (cq.list(index).ricetta <> "") Then
                    CqAmount = CqAmount + cq.list(index).Kg
                End If
            Next index
        Else
            For index = 0 To cq.endPos
                If (cq.list(index).ricetta <> "") Then
                    CqAmount = CqAmount + cq.list(index).Kg
                End If
            Next index
            For index = cq.startPos To cq.maxItems - 1
                If (cq.list(index).ricetta <> "") Then
                    CqAmount = CqAmount + cq.list(index).Kg
                End If
            Next index
        End If
    End If

End Function


