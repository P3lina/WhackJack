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
;Beispiel Zahlen
mov r1, #8
mov r0, #20

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

jmp displaynumbers
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

end 