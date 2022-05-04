CSEG AT 0H
init:
MOV R0,#01h
SETB P0.0
LJMP Anfang
Anfang:
JNB P0.0,weiter
DJNZ R0,Anfang
LJMP init
weiter:

;R0:00000001=>B:Ace,P:Ace;00000010=>B:Ace,P:2;00000011=>B:Ace,P:3
;Player has Ace: 1, 14, 27, 40, 53, 66, 79, 92, 105, 118, 131, 144, 157
;Player has 2: 2, 15, 28, 41, 54, 67, 80, 93, 106, 119, 132, 145, 158
;Player has 3: 3, 16, 29, 42, 55, 68, 81, 94, 107, 120, 133, 146, 159
;Player has 4: 4,
;Player has 5: 5,
;Player has 6: 6,
;Player has 7: 7,
;Player has 8: 8,
;Player has 9: 9,
;Player has 10: 10,
;Player has Jack: 11,
;Player has Queen: 12,
;Player has King: 13,

;Bank has Ace: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
;Bank has 2: 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26
;Bank has 3: 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
;Bank has 4: 40,
;Bank has 5: 53,
;Bank has 6: 66,
;Bank has 7: 79,
;Bank has 8: 92,
;Bank has 9: 105,
;Bank has 10: 118,
;Bank has Jack: 131,
;Bank has Queen: 144,
;Bank has King: 157,
test1_1:
CJNE R0, #001h, test1_2
CALL playerace
CALL bankace
LJMP continuegame
test1_2:
CJNE R0, #002h, test1_3
CALL player2
CALL bankace
LJMP continuegame
;...






playerace:
MOV R1, #001h ; Player has Ace
RET
player2:
MOV R1, #002h ; Player has 2
RET
player3:
MOV R1, #003h ; Player has 3
RET
player4:
MOV R1, #004h ; Player has 4
RET
player5:
MOV R1, #005h ; Player has 5
RET
player6:
MOV R1, #006h ; Player has 6
RET
player7:
MOV R1, #007h ; Player has 7
RET
player8:
MOV R1, #008h ; Player has 8
RET
player9:
MOV R1, #009h ; Player has 9
RET
player10:
MOV R1, #00Ah ; Player has 10
RET
playerjack:
MOV R1, #00Bh ; Player has Jack
RET
playerqueen:
MOV R1, #00Ch ; Player has Queen
RET
playerking:
MOV R1, #00Dh ; Player has King
RET


bankace:
MOV R2, #001h ; Bank has Ace
RET
bank2:
MOV R2, #002h ; Bank has 2
RET
bank3:
MOV R2, #003h ; Bank has 3
RET
bank4:
MOV R2, #004h ; Bank has 4
RET
bank5:
MOV R2, #005h ; Bank has 5
RET
bank6:
MOV R2, #006h ; Bank has 6
RET
bank7:
MOV R2, #007h ; Bank has 7
RET
bank8:
MOV R2, #008h ; Bank has 8
RET
bank9:
MOV R2, #009h ; Bank has 9
RET
bank10:
MOV R2, #00Ah ; Bank has 10
RET
bankjack:
MOV R2, #00Bh ; Bank has Jack
RET
bankqueen:
MOV R2, #00Ch ; Bank has Queen
RET
bankking:
MOV R2, #00Dh ; Bank has King
RET

continuegame:
NOP
