*NAME: PRACHI CHACHONDIA
*ECE 242 ASSIGNMENT #8
*DATE: 03/08/2012
*Purpose: Generate and add all even numbers from 1 to 200
*
 ORG $900           ; PROGRAM STARTS AT ADDRESS $900
 MOVEM.L D0/D6,-(SP)   ; SAVE REGISTER D0
DES EQU $800        ; SET DES EQUAL TO $900 FOR DESTINATION
*
 CLR.L D0           ; CLEAR D0
 CLR.L D6           ; CLEAR D6 FOR COUNTER
 MOVE.L #200,D6     ; MOVE HIGHEST VALUE TO D6
 MOVE.L #0,D0       ; MOVE DECIMAL 1 TO D0
AddEvens
 ADD.L D6,D0        ; STORE SUM IN D0
 SUB.L #2,D6        ; DECREMENT COUNTER D6
 BEQ AddEvens       ; GO TO LABEL AddEvens IF D6=0

 MOVE.L D0,DES      ; MOVE SUM TO ADDRESS $900
 MOVEM.L (SP)+,D0/D6 ; RESTORE REGISTER D0
*END PROGRAM - RETURN CONTROL TO MONITOR
 MOVE.B #228,D7
 TRAP #14
 END