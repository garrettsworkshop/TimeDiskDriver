;     0123456789012345678901234567890123456789 
;     ________________________________________ 
; 00 | -------------------------------------- |   00* W
; 01 |           GARRETT'S WORKSHOP           |   01* W
; 02 |         GR8RAM PRODOS INSTALLER        |   02* W
; 03 | -------------------------------------- |   00  W
; 04 |                                        |   B
; 05 |                SLOT: N                 |   03* W
; 06 |                                        |   B
; 07 | PRESS [Y] TO INSTALL PRODOS IMAGE ON   |   04* W
; 08 | GR8RAM IN SLOT N.                      |   05* W
; 09 |                                        |   B
; 10 | PRESS [N] TO KEEP GR8RAM BLANK AND     |   06* W
; 11 | ENTER RAMFACTOR MODE.                  |   07* W
; 12 |                                        |   B
; 13 |                                        |   B
; 14 |                                        |   B
; 15 |                                        |   B
; 16 |                                        |   B
; 17 |                                        |   B
; 18 |                                        |   B
; 19 |                                        |   B
; 20 |                                        |   B
; 21 |                                        |   B
; 22 |                                        |   B
; 23 |                                        |   B
;     ---------------------------------------- 
;     0123456789012345678901234567890123456789 
;     ________________________________________ 
; 00 | -------------------------------------- |   00
; 01 |           GARRETT'S WORKSHOP           |   01
; 02 |         GR8RAM PRODOS INSTALLER        |   02
; 03 | -------------------------------------- |   00
; 04 |                                        |   B
; 05 |                SLOT: N                 |   04
; 06 |                                        |   B
; 07 |              INSTALLING...             |   08* W
; 08 |                                        |   B   W
; 09 |                                        |   B
; 10 |                                        |   B   W
; 11 |                                        |   B   W
; 12 |                                        |   B
; 13 |                                        |   B
; 14 |                                        |   B
; 15 |                                        |   B
; 16 |                                        |   B
; 17 |                                        |   B
; 18 |                                        |   B
; 19 |                                        |   B
; 20 |                                        |   B
; 21 |                                        |   B
; 22 |                                        |   B
; 23 |                                        |   B
;     ---------------------------------------- 
;     0123456789012345678901234567890123456789 
;     ________________________________________ 
; 00 | -------------------------------------- |   00
; 01 |           GARRETT'S WORKSHOP           |   01
; 02 |         GR8RAM PRODOS INSTALLER        |   02
; 03 | -------------------------------------- |   00
; 04 |                                        |   B
; 05 |                SLOT: N                 |   04
; 06 |                                        |   B
; 07 |            INSTALL COMPLETE            |   09* W
; 08 |   TO USE GR8RAM, RESET YOUR APPLE II.  |   10* W
; 09 |                                        |   B
; 10 |                                        |   B
; 11 |                                        |   B
; 12 |                                        |   B
; 13 |                                        |   B
; 14 |                                        |   B
; 15 |                                        |   B
; 16 |                                        |   B
; 17 |                                        |   B
; 18 |                                        |   B
; 19 |                                        |   B
; 20 |                                        |   B
; 21 |                                        |   B
; 22 |                                        |   B
; 23 |                                        |   B
;     ---------------------------------------- 
;     0123456789012345678901234567890123456789 

blank_line:
; Set loop count to 40
LDY #40
JMP blank_loop

blank_3lines:
; Set loop count to 120
LDY #120
JMP blank_loop

copy_line:
; Set loop count to 40
LDY #40
; do {
copy_line_loop:
DEY
LDA (PTR_SRC),Y
ORA #$80
STA (PTR_DST),Y
TYA
; } while (y > 0)
BNE copy_line_loop
; Return
RTS

.align 256
SRC0:
.asciiz " -------------------------------------- "
SRC1:
.asciiz "           GARRETT'S WORKSHOP           "
SRC2:
.asciiz "         GR8RAM PRODOS INSTALLER        "
SRC3:
.asciiz "                SLOT: N                 "
SRC4:
.asciiz " PRESS [Y] TO INSTALL PRODOS IMAGE ON   "
SRC5:
.asciiz " GR8RAM IN SLOT N.                      "

; do {
blank_loop:
DEY
LDA #$A0 ; $A0 is space
STA (PTR_DST),Y
TYA
; } while (y > 0)
BNE blank_loop
; Return
RTS

.align 256
SRC6:
.asciiz " PRESS [N] TO KEEP GR8RAM BLANK AND     "
SRC7:
.asciiz " ENTER RAMFACTOR MODE.                  "
SRC8:
.asciiz "              INSTALLING...             "
SRC9:
.asciiz "            INSTALL COMPLETE            "
SRC10:
.asciiz "   TO USE GR8RAM, RESET YOUR APPLE II.  "
