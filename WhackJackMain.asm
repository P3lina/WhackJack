CSEG AT 0H
PLAYER:
CALL displayNumbers
JNB P0.0,PLAYER
PLAYERINIT:
MOV A,#00BH ; intialisiere R0 mit 11
LJMP PLAYERSTEP
PLAYERSTEP:
CALL displayNumbers
JNB P0.0,PLAYERSAFE
JNB P0.1,ENDGAME
DJNZ A,PLAYERSTEP ; schleife die Input prüft und dekrementiert
LJMP PLAYERINIT
PLAYERSAFE:
ADD A,R0
MOV R0, A
CALL CHECKPLAYERLOSE
LJMP BANK

BANK:
CALL displayNumbers
JB P0.0,BANK
CALL CHECKBANKWIN
BANKINIT:
MOV A,#00BH
LJMP BANKSTEP
BANKSTEP:
CALL displayNumbers
JB P0.0,BANKSAFE
DJNZ A,BANKSTEP
LJMP BANKINIT
BANKSAFE:
ADD A,R1
MOV R1, A
CALL CHECKBANKLOSE
LJMP PLAYERINIT

ENDGAME:
CALL displayNumbers
JNB P0.0,INITENDGAME
INITENDGAME:
MOV A,#00BH
LJMP ENDGAMESTEP
ENDGAMESTEP:
JB P0.0,ENDGAMESAFE
DJNZ A,ENDGAMESTEP
LJMP INITENDGAME
ENDGAMESAFE:
ADD A,R1
MOV R1, A
CALL CHECKBANKLOSE
CALL CHECKENDGAME
LJMP ENDGAME

CHECKENDGAME:
CLR C 
MOV A, R0
MOV B, R1
SUBB A,B
JB C, LOSE

CHECKPLAYERLOSE:
CLR C 
SUBB A, #015H
JNB C, LOSE
CLR C 
ret

CHECKBANKLOSE:
CLR C 
SUBB A, #015H
JNB C, WIN
CLR C 
ret

CHECKBANKWIN:
CLR C 
MOV A, R0
MOV B, R1
SUBB A,B
JB C, PLAYERINIT
ret

WIN:
CALL displayNumbers

CALL winmessage

LOSE:
CALL displayNumbers

CALL losemessage










;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Stellen Port = p2
;bit 0 v Ziffer 0, 1 fuer 1, 2 fuer 2 und 3 fuer 3
;Port p3 um Ziffer zu zeigen
; A = bit 0, B = bit 1, usw...

;Zahl der Bank in r1 
;Zahl des Spielers in r0

;-------------------------------------
;  Disassembles the Numbers of the Bank and the Player 
;  and displays them in the LED Display
;-------------------------------------
displayNumbers:
MOV R7,A
MOV R6,B
;Disassembly Number of Bank
mov a, r1
mov b,#10
div ab
;Display Number of Bank
call disPositionZB
call disPositionEB

;Display Point as separation
call disPoint

;Disassembly Number of Player
mov a, r0
mov b,#10
div ab
;Display Number of Player
call disPositionZS
call disPositionES

MOV A,R7
MOV B,R6
ret
;-------------------------------------

;-------------------------------------
;  Display functions
;-------------------------------------
;Zehnerstelle Bank
disPositionZB:
setb p2.3
mov DPTR, #table
movc a,@a+dptr
mov p3, a

call setPort
ret

;Einerstelle Bank
disPositionEB:
setb p2.2
mov DPTR, #table
mov a, b
movc a,@a+dptr
mov p3, a

call setPort
ret

;Zehnerstelle Spieler
disPositionZS:
setb p2.1
mov DPTR, #table
movc a,@a+dptr
mov p3, a

call setPort
ret

;Einerstelle Spieler
disPositionES:
setb p2.0
mov DPTR, #table
mov a, b
movc a,@a+dptr
mov p3, a

call setPort
ret

;Punkt zum trennen der Bank und des Spielers
disPoint:
setb p2.2
mov p3, #10000000b
call setPort
ret

;-------------------------------------
;Reset ports to switch segment
setPort:
mov p3, #00000000b
mov p2, #00000000b
ret

;-------------------------------------
table:
db 00111111b ;0
db 00000110b, 01011011b, 01001111b ;1, 2, 3
db 01100110b, 01101101b, 01111101b ;4, 5, 6 
db 00000111b, 01111111b, 01101111b ;7, 8, 9














;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



initmessage:
RS	bit	P3.0
RW	bit	P3.1
E	bit	P3.2
D	equ	P1

cmd	macro	cmd_code
	setb	E
	mov	D, cmd_code
	clr	E
endm
RET





losemessage:
; * press F2,
; * press F6,
; * press F2 to end.

	jmp	startl

CALL initmessage

stringl:	db	'Pech gehabt, hehe!\0'

startl:	mov	D, #0
	clr	RW
	mov	DPTR, #stringl

mainl:	clr	RS
	cmd	#00000001b	; Clear display
	cmd	#00000010b	; Cursor home
	cmd	#00000110b	; Entry mode set
	cmd	#00001111b	; Display ON/OFF control
	cmd	#00011110b	; Cursor/display shift
	cmd	#00111100b	; Function set
	cmd	#10000001b	; Set DDRAM address

	; Print the string ...
	setb	RS
	mov	R0, #0
printl:	mov	A, R0
	inc	R0
	movc	A, @A+DPTR
	cmd	A
	cjne	A, #0, printl
	sjmp	mainl




winmessage:

; * press F2,
; * press F6,
; * press F2 to end.

	jmp	startw

CALL initmessage

stringw: db	'Glueck gehabt!\0'

startw:	mov	D, #0
	clr	RW
	mov	DPTR, #stringw

mainw:	clr	RS
	cmd	#00000001b	; Clear display
	cmd	#00000010b	; Cursor home
	cmd	#00000110b	; Entry mode set
	cmd	#00001111b	; Display ON/OFF control
	cmd	#00011110b	; Cursor/display shift
	cmd	#00111100b	; Function set
	cmd	#10000001b	; Set DDRAM address

	; Print the string ...
	setb	RS
	mov	R0, #0
printw:	mov	A, R0
	inc	R0
	movc	A, @A+DPTR
	cmd	A
	cjne	A, #0, printw
	sjmp	mainw






	end