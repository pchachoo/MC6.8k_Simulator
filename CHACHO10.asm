*NAME: PRACHI CHACHONDIA
*ECE 242 ASSIGNMENT #10
*DATE: 03/29/2012
*Purpose: Write a progrma which examines a list of test scores stored as BCD numbers in memory.  
*Transfer passing and failing scores to different tables. Keep count of each.
*Computer average of passing scores, failing scores and all scores combined.
*
Start_Addr EQU $800    	  	   ; Set Start_Addr EQUAL TO $800
DataMem EQU $5000       	   ; Data starts at $5000
COUNT EQU 20            	   ; Number of data points - 10
CLR_COUNT EQU 20        	   ; Number of data points
PassAddr EQU $5100      	   ; 
FailAddr EQU $5500      	   ; 
Pass_Count EQU 0        	   ; Save count of passing scores
Fail_Count EQU 0        	   ; Save count of failing scores
*Pass_Sum EQU 0         	   ; Save sum of passing scores
*Fail_Sum EQU 0         	   ; Save sum of failing scores
PSumAddr EQU $4000       	   ;
FSumAddr EQU $4100       	   ;

 ORG DataMem - 17
*
* Assigning label to all test scores:
*
DATA	DS.W	20         	   ; Save 20 continuous bytes in memory under label DATA - 25
*
*	 
	 ORG Start_Addr            ; PROGRAM STARTS AT ADDRESS $800
	 MOVEM.L D0-D7,-(SP)       ; Save used registers 
 
	 CLR.L PSumAddr            ;
	 CLR.L FSumAddr            ; Line 32

CLEAR_TABLES
	 CLR.w PassAddr            ; CLEAR 20 BYTES STARTING AT $5100
	 CLR.w FailAddr            ; CLEAR 20 BYTES STARTING AT $5500
	 SUBQ.W #1,CLR_COUNT       ; Decrement COUNT
	 BNE LOOP                  ; Branch to CLEAR_TABLES if COUNT is not zero
 
	 MOVE.L DataMem,D2         ; 
	 MOVE.L PassAddr,D3        ;
	 MOVE.L FailAddr,D4        ; 

LOOP
	 MOVE.W D2,D5              ; Save score in D5 - line 45
	 ADD.W $1,D2               ; INCREMENT DataMem TO GET NEXT 
	 CMPI.W #50,D5             ; COMPARE CONTECTS OF D5 AND 50 AND SET CCR BIT N FOR POSTITIVE OR NEGATIVE
	 BGE PASS                  ; BRANCH TO PASS IF RESULT IS GREATER THAN 0, WHICH IMPLIES PASSING SCORE
	 BLT FAIL                  ; BRANCH TO FAIL IF RESULT IS LESS THAN 0, WHICH IMPLIES FAILING SCORE

PASS 
	 MOVE.W D5,D3              ; MOVE CONTENTS OF D5 TO TABLE FOR PASSING SCORES AND INCREMENT Pass_Addr AFTER THAT
	 ADD.W D3,PSumAddr        ; line 53
*	 ADD.W $1,PassAddr         ; 
 	 ADDI.W #1,Pass_Count      ; Increment Counter
	 BRA ENDLOOP               ; Always branch to end of loop

FAIL 
	 MOVE.W D5,D4              ; MOVE CONTENTS OF D5 TO TABLE FOR FAILING SCORES
	 ADD.W D4,FSumAddr        ; line 60
*	 ADD.W $1,FailAddr         ;
	 ADDI.W #1,Fail_Count      ; Increment Counter

ENDLOOP
	 SUBQ.W #1,COUNT           ; Decrement COUNT
	 BNE LOOP                  ; Branch to LOOP if COUNT is not zero

*Moving the counts to respective registers
	 MOVE.w Pass_Count,D2      ;
	 MOVE.w Fail_Count,D3      ; line 70

*Moving sums to respective registers
	 MOVE.L PSumAddr,D4       ; 
	 MOVE.L FSumAddr,D6       ;
 
*Finding sum of all scores
	 ADD.L D4,FSumAddr        ; Adding passing and failing scores and storing in memory
	 MOVE.L FSumAddr,D7       ; Moving result to D7

	 DIVU.W Pass_Count,D4      ; Calculate average of Passing scores
	 DIVU.W Fail_Count,D6      ; Calculate average of failing scores
	 DIVU.W #20,D7             ; Calculate average of all scores

BCD
	 MOVEM.L D1-D2,-(SP)
 	 MOVE.W #7,D2
	 CLR.L D0
NXTDIG
	 DIVU #10,D1
	 SWAP D1
	 OR.B D1,D0
	 ROR.L #4,D0
	 CLR.B D1
	 SWAP D1
	 DBRA D2,NXTDIG
	 MOVEM.L (SP)+,D1-D2
	 RTS



*END PROGRAM - RECALL USED REGISTERS AND RETURN CONTROL TO MONITOR
	 MOVEM.L (SP)+,D0-D7 
	 MOVE.B #228,D7
	 TRAP #14
	 END