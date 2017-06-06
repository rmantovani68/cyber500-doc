Attribute VB_Name = "ModPID"
Option Explicit

Global dblPrevErr As Double     'errore precedente
Global dblPrevVal As Double     'lettura precedente del segnale di retroazione
Global dblIntegrale As Double   'integrale del segnale errore

'******************************************************************************
'**                                                                          **
'**     Parametri in ingresso al regolatore PID                              **
'**         - blnResetPID: reset del controllore            (I/O)            **
'**         - dblKp: costante proporzionale                 (I)              **
'**         - dblTi: tempo integrativo                      (I)              **
'**         - dblTd: tempo derivativo                       (I)              **
'**         - dblRef: livello di riferimento                (I)              **
'**         - dblRealVal: indicazione reale dello stato     (I)              **
'**         - dblTc: tempo di campionamento                 (I)              **
'**     Parametro di uscita                                                  **
'**         - dblPID: correzione del regolatore             (O)              **
'**         - blnErrore: controllo su dblTi <> 0            (O)              **
'**                                                                          **
'**     RegolatorePID_1                                                      **
'**     - l'azione derivativa è applicata al segnale errore                  **
'**                                                                          **
'**     RegolatorePID_2                                                      **
'**     - l'azione derivativa è applicata al segnale di retroazione          **
'**                                                                          **
'******************************************************************************

'PID modificato in CINA 20120606 FUNZIONA in simulazione!!

Public Sub RegolatorePID_1(ByRef blnResetPID As Boolean, ByVal dblKp As Double, _
                           ByVal dblKi As Double, ByVal dblKd As Double, _
                           ByVal dblRef As Double, ByVal dblRealVal As Double, _
                           ByVal dblTc As Double, ByRef dblPID As Double, _
                           ByRef blnErrore As Boolean)
    Dim dblProporzionale As Double
    Dim dblDerivata As Double       'derivata del segnale errore
    Dim dblCurrErr As Double        'errore corrente
        
    dblCurrErr = dblRef - dblRealVal

    On Error GoTo OverflowError
    If (blnResetPID = True) Then
        blnResetPID = False
        dblProporzionale = 0
        dblIntegrale = 0
        dblDerivata = 0
    Else
        dblProporzionale = dblKp * dblCurrErr
        If dblPID > -500 And dblPID < 500 Then
            dblIntegrale = dblIntegrale + dblCurrErr * (dblTc / 1000)
        End If
        dblDerivata = (dblCurrErr - dblPrevErr) / (dblTc / 1000)
    End If
    
    dblPID = dblProporzionale + dblKi * dblIntegrale + dblKd * dblDerivata
    Call Limitatore(dblPID)
    dblPrevErr = dblCurrErr
    Exit Sub
OverflowError:
    blnErrore = True
End Sub


Public Sub RegolatorePID_2(ByRef blnResetPID As Boolean, ByVal dblKp As Double, _
                           ByVal dblTi As Double, ByVal dblTd As Double, _
                           ByVal dblRef As Double, ByVal dblRealVal As Double, _
                           ByVal dblTc As Double, ByRef dblPID As Double, _
                           ByRef blnErrore As Boolean)
    Dim dblDerivata As Double   'derivata del segnale errore
    Dim dblCurrErr As Double       'errore corrente
    dblCurrErr = dblRef - dblRealVal
    If dblTi = 0 Then
        blnErrore = True
        Exit Sub
    Else
        blnErrore = False
    End If
    On Error GoTo OverflowError
    If (blnResetPID = True) Then
        blnResetPID = False
        dblIntegrale = 0
        dblDerivata = 0
    Else
        dblIntegrale = dblIntegrale + (dblPrevErr + dblCurrErr) * dblTc / CDbl(2)
        dblDerivata = (dblRealVal - dblPrevVal) / dblTc
    End If
    dblPID = dblKp * (dblCurrErr + dblIntegrale / dblTi + dblTd * dblDerivata)
    Call Limitatore(dblPID)
    dblPrevErr = dblCurrErr
    dblPrevVal = dblRealVal
    Exit Sub
OverflowError:
    blnErrore = True
End Sub

Private Sub Limitatore(ByRef dblPID As Double)
    dblPID = dblPID / 10
    If dblPID > 999 Then
        dblPID = 999
    ElseIf dblPID < -999 Then
        dblPID = -999
    End If
End Sub


Public Sub RegolatorePID_3(ByRef blnResetPID As Boolean, ByVal dblKp As Double, _
                           ByVal dblKi As Double, ByVal dblKd As Double, _
                           ByVal dblRef As Double, ByVal dblRealVal As Double, _
                           ByVal dblTc As Double, ByRef dblPID As Double, _
                           ByRef blnErrore As Boolean)
    Dim dblProporzionale As Double
    Dim dblDerivata As Double       'derivata del segnale errore
    Dim dblCurrErr As Double        'errore corrente
    
    dblCurrErr = dblRef - dblRealVal

    On Error GoTo OverflowError
    
    If (blnResetPID = True) Then
        blnResetPID = False
        dblProporzionale = 0
        dblIntegrale = 0
        dblDerivata = 0
    Else
        dblProporzionale = (dblKp * dblCurrErr) / 10
                        
        dblIntegrale = (dblIntegrale + dblCurrErr * (dblTc / 1000))
                                
        dblDerivata = (dblCurrErr - dblPrevErr) / (dblTc)
    
    End If
    
    dblPID = dblProporzionale + dblKi * dblIntegrale + dblKd * dblDerivata
    
    Call Limitatore(dblPID)
    
    dblPrevErr = dblCurrErr
    
    Exit Sub
OverflowError:
    blnErrore = True
End Sub

