 ORG $1400
 CLR.L D0
 CLR.L D2
 CLR.L D5
 CLR.W $500
 MOVE.B #$75,D2
 MOVE.B #$AC,D5
 MOVE.B D5,$501
 ADD.B D2,D5
 ADD.W D2,$500
 MOVE.W $500,D0
 TRAP #14
 END