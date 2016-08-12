*NAME: PRACHI CHACHONDIA
*ECE 242 ASSIGNMENT #7
*DATE: 03/15/2012
*Purpose: Write a progrma which computes the average of twenty data points in memory.
*
*
Start_Addr EQU $800        ; SET Start_Addr EQUAL TO $800
Start_Mem EQU $500         ; SAVE DATA BYTES STARTING AT $500
COUNT EQU 20               ; Number of data points - SYNTAX ERROR IF #20 USED
Int_Addr EQU $750          ; Save integer at address $750
Frac_Addr EQU $751         ; Save fraction at address $751
CARRY EQU $100             ; carry bit
FractionMul EQU 10         ; multiply remainder by 10 - SYNTAX ERROR IF #10 USED

 ORG Start_Mem
*
* Assigning labels to all data points:
*
DATA01		DS.B	1
DATA02		DS.B	1
DATA03		DS.B	1
DATA04		DS.B	1
DATA05		DS.B	1
DATA06		DS.B	1
DATA07		DS.B	1
DATA08		DS.B	1
DATA09		DS.B	1
DATA10		DS.B	1
DATA11		DS.B	1
DATA12		DS.B	1
DATA13		DS.B	1
DATA14		DS.B	1
DATA15		DS.B	1
DATA16		DS.B	1
DATA17		DS.B	1
DATA18		DS.B	1
DATA19		DS.B	1
DATA20		DS.B	1
*
*
 ORG Start_Addr            ; PROGRAM STARTS AT ADDRESS $800
 MOVEM.L D0,-(SP)          ; SAVE REGISTER D0
 CLR.L D0                  ; CLEAR D0


* Perform bit additions taking carry into consideration:
ADD1		ADD.B	DATA01,D0
		BCS	CARRY1          ; if carry bit is set, go to label CARRY1
		BCC	ADD2		; if carry bit is 0, skip carry instruction and continue bit add
CARRY1		ADD.W	CARRY,D0	; add CARRY to D0

ADD2		ADD.B	DATA02,D0
		BCS	CARRY2
		BCC	ADD3
CARRY2		ADD.W	CARRY,D0	

ADD3		ADD.B	DATA03,D0
		BCS	CARRY3
		BCC	ADD4
CARRY3		ADD.W	CARRY,D0	

ADD4		ADD.B	DATA04,D0
		BCS	CARRY4
		BCC	ADD5
CARRY4		ADD.W	CARRY,D0	

ADD5		ADD.B	DATA05,D0
		BCS	CARRY5
		BCC	ADD6
CARRY5		ADD.W	CARRY,D0	

ADD6		ADD.B	DATA06,D0
		BCS	CARRY6
		BCC	ADD7
CARRY6		ADD.W	CARRY,D0	

ADD7		ADD.B	DATA07,D0
		BCS	CARRY7
		BCC	ADD8
CARRY7		ADD.W	CARRY,D0	

ADD8		ADD.B	DATA08,D0
		BCS	CARRY8
		BCC	ADD9
CARRY8		ADD.W	CARRY,D0	

ADD9		ADD.B	DATA09,D0
		BCS	CARRY9
		BCC	ADD10
CARRY9		ADD.W	CARRY,D0	

ADD10		ADD.B	DATA10,D0
		BCS	CARRY10
		BCC	ADD11
CARRY10		ADD.W	CARRY,D0	

ADD11		ADD.B	DATA11,D0
		BCS	CARRY11
		BCC	ADD12
CARRY11		ADD.W	CARRY,D0	

ADD12		ADD.B	DATA12,D0
		BCS	CARRY12
		BCC	ADD13
CARRY12		ADD.W	CARRY,D0	

ADD13		ADD.B	DATA13,D0
		BCS	CARRY13
		BCC	ADD14
CARRY13		ADD.W	CARRY,D0

ADD14		ADD.B	DATA14,D0
		BCS	CARRY14
		BCC	ADD15
CARRY14		ADD.W	CARRY,D0

ADD15		ADD.B	DATA15,D0
		BCS	CARRY15
		BCC	ADD16
CARRY15		ADD.W	CARRY,D0

ADD16		ADD.B	DATA16,D0
		BCS	CARRY16
		BCC	ADD17
CARRY16		ADD.W	CARRY,D0

ADD17		ADD.B	DATA17,D0
		BCS	CARRY17
		BCC	ADD18
CARRY17		ADD.W	CARRY,D0	

ADD18		ADD.B	DATA18,D0
		BCS	CARRY18
		BCC	ADD19
CARRY18		ADD.W	CARRY,D0	

ADD19		ADD.B	DATA19,D0
		BCS	CARRY19
		BCC	ADD20
CARRY19		ADD.W	CARRY,D0	

ADD20		ADD.B	DATA20,D0
		BCS	CARRY20
		BCC	AvgCalc
CARRY20		ADD.W	CARRY,D0	


AvgCalc
* Calculate average and move integer part to specified destination
 DIVU.W	#COUNT,D0		
 MOVE.B	D0,Int_Addr

* Swap to get remainder in lower word size and move to speficied destination for fraction
 SWAP.W	D0	
	
* Multiply fraction by 10 and move to specified destination		
 MULU.W	#FractionMul,D0
 MOVE.B	D0,Frac_Addr

*END PROGRAM - RECALL USED REGISTERS AND RETURN CONTROL TO MONITOR
 MOVEM.L (SP)+,D0 
 MOVE.B #228,D7
 TRAP #14
 END