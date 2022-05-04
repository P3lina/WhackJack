CSEG AT 0H
init:
MOV R0,#0EAH
SETB P0.0
LJMP Anfang
Anfang:
JNB P0.0,weiter
DJNZ R0,Anfang
LJMP init
weiter:
JB P0.1,weiter
NOP;R0:x|x|x|x|X|X|X|X => x: to determine the playing cards of the bank, X: to determine the playing cards of the player