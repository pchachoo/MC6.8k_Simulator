*-----------------------------------------------------------
* Program    : Assignment #11
* Written by : Prachi Chachondia
* Date       : 04/03/2012
* Description: Write a program that to examine twenty test scores input by the user. 
* Store passing(>= 50) and failing scores in tables in memory. Record and display counts.
* Calculate and display averages for all 3 sets of scores.
*-----------------------------------------------------------
 		ORG	$5000	
Pass_Addr	DS.W	20
		ORG	$5100
Fail_Addr	DS.W	20

Start_Addr EQU $1000        ; Set Start_Addr
COUNT1 EQU 20               ; Number of data points
COUNT2 EQU 20               ; Number of data points
COUNT3 EQU 20               ; Number of data points
Pass_COUNT EQU 0            ; Save count of passing scores
Fail_COUNT EQU 0            ; Save count of failing scores
Pass_Sum EQU $4000
Fail_Sum EQU $4100
Total_Sum EQU $4200

.INCHE EQU 247
.OUTCH EQU 246
.OUTPUT EQU 243
.OUT1CR EQU 227
.RETURN EQU 228
.PORTIN1 EQU 241

START		ORG	$1000
		MOVEM.L	D0-D7/A0-A7,-(SP)	;save the context of used registers.

SYSCALL MACRO
	MOVE.B #\1,D7
	TRAP #14
	ENDM


INPUT_NUM DC.B 'NEXT SCORE? : '
EINPUT_NUM DC.B $00

STUDENT_COUNT DC.B 'TOTAL NUMBER OF STUDENTS : '
ESTUDENT_COUNT DC.B $00

STUDENT_AVG DC.B 'AVERAGE OF ALL SCORES : '
ESTUDENT_AVG DC.B $00

PASSING_COUNT DC.B 'NUMBER OF PASSING SCORES : '
EPASSING_COUNT DC.B $00

PASSING_AVG DC.B 'AVERAGE OF ALL PASSING SCORES : '
EPASSING_AVG DC.B $00

FAILING_COUNT DC.B 'NUMBER OF FAILING SCORES : '
EFAILING_COUNT DC.B $00

FAILING_AVG DC.B 'AVERAGE OF ALL FAILING SCORES : '
EFAILING_AVG DC.B $00


 CLR.L Pass_Sum
 CLR.L Fail_Sum
 CLR.L Total_Sum

*GET 20 VALUES AS INPUT

	MOVE.L $4500,A4           ; STARTING ADDRESS TO STORE SCORES AT

INPUT	LEA INPUT_NUM,A5
	LEA EINPUT_NUM,A6
	SYSCALL .OUTPUT
	MOVE.L (A4)+,A5
	SYSCALL .PORTIN1
	SUBQ.W #1,COUNT1        
	BNE INPUT 
	

LOOP
	 MOVE.W (A4)+,D5           ; Save score in D5
	 ADD.W D5,Total_Sum        ; 
	 CMPI.W #50,D5             ; COMPARE CONTECTS OF D5 AND 50 AND SET CCR BIT N FOR POSTITIVE OR NEGATIVE
	 BGE PASS                  ; BRANCH TO PASS IF RESULT IS GREATER THAN 0, WHICH IMPLIES PASSING SCORE
	 BLT FAIL                  ; BRANCH TO FAIL IF RESULT IS LESS THAN 0, WHICH IMPLIES FAILING SCORE

PASS 
	 MOVE.W D5,D3              ; MOVE CONTENTS OF D5 TO TABLE FOR PASSING SCORES 
	 ADD.W D3,Pass_Sum         ; 
 	 ADDI.W #1,Pass_Count      ; Increment Counter
	 BRA ENDLOOP               ; Always branch to end of loop

FAIL 
	 MOVE.W D5,D4              ; MOVE CONTENTS OF D5 TO TABLE FOR FAILING SCORES
	 ADD.W D4,Fail_Sum         ; 
	 ADDI.W #1,Fail_Count      ; Increment Counter

ENDLOOP
	 SUBQ.W #1,COUNT2          ; Decrement COUNT
	 BNE LOOP                  ; Branch to LOOP if COUNT is not zero

*Moving the counts to respective registers
	 MOVE.W Pass_Count,D2      ; D2 = NUMBER OF PASSING SCORES
	 MOVE.W Fail_Count,D3      ; D3 = NUMBER OF FAILING SCORES

*Moving sums to respective registers
	 MOVE.L Pass_Sum,D4        ; 
	 MOVE.L Fail_Sum,D5        ;
	 MOVE.L Total_Sum,D6       ; 
 
	 DIVU.W Pass_Count,D4      ; D4 =  average of Passing scores
	 DIVU.W Fail_Count,D5      ; D5 =  average of failing scores
	 DIVU.W #20,D6             ; D6 =  average of all scores

 	 LEA STUDENT_COUNT,A5
	 LEA ESTUDENT_COUNT,A6
*	 SYSCALL .OUTPUT            ; PRINT COMMENT
*	 SYSCALL .OUT1CR            ; PRINT VALUE

	 LEA PASSING_COUNT,A5
	 LEA EPASSING_COUNT,A6
*	 SYSCALL .OUTPUT            ; PRINT COMMENT
*	 SYSCALL .OUT1CR            ; PRINT VALUE
	
	 LEA FAILING_COUNT,A5
	 LEA EFAILING_COUNT,A6
*	 SYSCALL .OUTPUT            ; PRINT COMMENT
*	 SYSCALL .OUT1CR            ; PRINT VALUE
	
	 LEA STUDENT_AVG,A5
	 LEA ESTUDENT_AVG,A6
*	 SYSCALL .OUTPUT            ; PRINT COMMENT
*	 SYSCALL .OUT1CR            ; PRINT VALUE
	
	 LEA PASSING_AVG,A5
	 LEA EPASSING_AVG,A6
*	 SYSCALL .OUTPUT            ; PRINT COMMENT
*	 SYSCALL .OUT1CR            ; PRINT VALUE
	
	 LEA FAILING_AVG,A5
	 LEA EFAILING_AVG,A6
*	 SYSCALL .OUTPUT            ; PRINT COMMENT
*	 SYSCALL .OUT1CR            ; PRINT VALUE
	


DONE	 MOVEM.L (SP)+,D0-D7/A0-A7
	 MOVE.L #228,D7
	 TRAP	#14
	 END
