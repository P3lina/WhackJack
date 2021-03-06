; * press F2,
; * press F6,
; * press F2 to end.

	org	0
	jmp	start

RS	bit	P3.0
RW	bit	P3.1
E	bit	P3.2
D	equ	P1

cmd	macro	cmd_code
	setb	E
	mov	D, cmd_code
	clr	E
endm

;string:	db	'You loose try again!\0'
string: db	'You won, congratulation!\0'

start:	mov	D, #0
	clr	RW
	mov	DPTR, #string

main:	clr	RS
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
print:	mov	A, R0
	inc	R0
	movc	A, @A+DPTR
	cmd	A
	cjne	A, #0, print
	sjmp	main

	end