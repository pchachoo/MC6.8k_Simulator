*NAME: PRACHI CHACHONDIA
*ECE 242 ASSIGNMENT #9
*DATE: 03/27/2012
*Purpose: Write a progrma which examines a list of 20 test scores, 
*seperates them according to pass/fail and 
*keeps count of each.
*
Start_Addr EQU $800        ; Set Start_Addr EQUAL TO $800
DataMem EQU $5000          ; Data starts at $5000
COUNT EQU 20               ; Number of data points - 10
CLR_COUNT EQU 20           ; Number of data points
PassAddr EQU $5100         ; Save integer at address $750
FailAddr EQU $5200         ; Save fraction at address $751
Pass_COUNT EQU 0           ; Save count of passing scores
Fail_COUNT EQU 0           ; Save count of failing scores

 ORG DataMem - 17
*
* Assigning label to all test scores:
*
DATA		DS.W	20 ; Save 20 continuous bytes in memory under label DATA
*
*
 ORG Start_Addr            ; PROGRAM STARTS AT ADDRESS $800
 MOVEM.L D5,-(SP)          ; Save used registers - 25

CLEAR_TABLES
 CLR.w PassAddr            ; CLEAR 20 BYTES STARTING AT $5100
 CLR.w FailAddr            ; CLEAR 20 BYTES STARTING AT $5200
 SUBQ.W #1,CLR_COUNT       ; Decrement COUNT
 BNE LOOP                  ; Branch to CLEAR_TABLES if COUNT is not zero
 
 MOVE.L DataMem,D2         ; - 33
 MOVE.L PassAddr,D3        ;
 MOVE.L FailAddr,D4        ; 

LOOP
 MOVE.W D2,D5              ; Save score in D5 - LINE 38
 ADD.W $1,D2               ; INCREMENT DataMem TO GET NEXT 
 CMPI.W #50,D5             ; COMPARE CONTECTS OF D5 AND 50 AND SET CCR BIT N FOR POSTITIVE OR NEGATIVE
 BGE PASS                  ; BRANCH TO PASS IF RESULT IS GREATER THAN 0, WHICH IMPLIES PASSING SCORE
 BLT FAIL                  ; BRANCH TO FAIL IF RESULT IS LESS THAN 0, WHICH IMPLIES FAILING SCORE

PASS 
 MOVE.W D5,D3              ; MOVE CONTENTS OF D5 TO TABLE FOR PASSING SCORES AND INCREMENT Pass_Addr AFTER THAT - LINE 45
*ADD.W $1,PassAddr         ; 
 ADDI.W #1,Pass_Count      ; Increment Counter
 BRA ENDLOOP               ; Always branch to end of loop

FAIL 
 MOVE.W D5,D4              ; MOVE CONTENTS OF D5 TO TABLE FOR FAILING SCORES - LINE 50
*ADD.W $1,FailAddr         ;
 ADDI.W #1,Fail_Count      ; Increment Counter

ENDLOOP
 SUBQ.W #1,COUNT           ; Decrement COUNT
 BNE LOOP                  ; Branch to LOOP if COUNT is not zero


*END PROGRAM - RECALL USED REGISTERS AND RETURN CONTROL TO MONITOR
 MOVEM.L (SP)+,D5 
 MOVE.B #228,D7
 TRAP #14
 END