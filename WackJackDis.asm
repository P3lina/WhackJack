;Stellen Port = p2
; bit 0 v Ziffer 0, 1 fuer 1, 2 fuer 2 und 3 fuer 3
;Port p3 um Ziffer zu zeigen
; A = bit 0, B = bit 1, usw...
start: 

;Stelle 0 ansprechen
Mov p2, #00000001b

; Ziffer 3 aus db holen und in anzeige port schreiben
mov DPTR, #table
mov a, #3
movc a,@a+dptr
mov r3, a
mov p3, r3

call setPort

;Stelle 1 ansprechen
Mov p2, #00000010b
; Ziffer 1 aus db holen und in anzeige port schreiben
mov DPTR, #table
mov a, #1
movc a,@a+dptr
mov r3, a
mov p3, r3

call setPort

jmp start

;Reset ports to switch segment
setPort:
mov p3, #00000000b
mov p2, #00000000b
ret

table:
db 00111111b ;0
db 00000110b, 01011011b, 01001111b ;1, 2, 3
db 01100110b, 01101101b, 01111101b ;4, 5, 6 
db 00000111b, 01111111b, 01101111b ;7, 8, 9

end 