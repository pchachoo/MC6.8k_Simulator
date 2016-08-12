* TTL 'Add six values'
* LLEN 100
 ORG $2000
* OPT P=M68000
* Prachi Chachondia, ECE 242 Assignment #5, 02/16/2012
* Purpose: Write assembly language program to add 6 unsigned values
 CLR.L D1 ; Clear temporary destination address and make all bits 0
 MOVE.W A2,D1 ; Move first value to register D1
 ADD.W D3,D1 ; Add second value to D1, result is stored in D1
 ADD.W #$500,D1 ; result is stored in D1
 ADD.W #$502,D1 ; result is stored in D1
 ADD.W #$530,D1 ; result is stored in D1
 ADD.W #$536,D1 ; result is stored in D1
 MOVE.W D1,$400 ; Move sum to required location
* MOVE.B #228, D7
 TRAP #14
 END