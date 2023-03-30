;     0123456789012345678901234567890123456789 
;     ________________________________________ 
; 00 | -------------------------------------- |   00* W
; 01 |           GARRETT'S WORKSHOP           |   01* W
; 02 |        TIMEDISK PRODOS INSTALLER       |   02* W
; 03 | -------------------------------------- |   00  W
; 04 |                                        |   B
; 05 |                SLOT: N                 |   03* W
; 06 |                                        |   B
; 07 | PRESS [Y] TO INSTALL PRODOS IMAGE ON   |   04* W
; 08 | TIMEDISK IN SLOT N.                    |   05* W
; 09 |                                        |   B
; 10 | WARNING! INSTALLING WILL ERASE         |   06* W
; 11 | ALL DATA ON TIMEDISK IN SLOT N.        |   07* W
; 12 |                                        |   B
; 13 | TO QUIT THIS PROGRAM AND LEAVE YOUR    |   08* W
; 14 | TIMEDISK UNCHANGED, RESET OR POWER OFF |   09* W
; 15 | YOUR APPLE.                            |   10* W
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
; 02 |        TIMEDISK PRODOS INSTALLER       |   02
; 03 | -------------------------------------- |   00
; 04 |                                        |   B
; 05 |                SLOT: N                 |   04
; 06 |                                        |   B
; 07 |              INSTALLING...             |   11* W
; 08 |  DO NOT TURN OFF OR RESET YOUR APPLE.  |   12* W
; 09 |                                        |   B
; 10 |                                        |   B   W
; 11 |                                        |   B   W
; 12 |                                        |   B
; 13 |                                        |   B   W
; 14 |                                        |   B   W
; 15 |                                        |   B   W
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
; 02 |        TIMEDISK PRODOS INSTALLER       |   02
; 03 | -------------------------------------- |   00
; 04 |                                        |   B
; 05 |                SLOT: N                 |   04
; 06 |                                        |   B
; 07 |            INSTALL COMPLETE            |   13* W
; 08 |  TO USE TIMEDISK, TURN OFF YOUR APPLE  |   14* W
; 09 |  AND REMOVE MODE JUMPER.               |   15* W
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

.align 256
SRC0:
.asciiz " -------------------------------------- "
SRC1:
.asciiz "           GARRETT'S WORKSHOP           "
SRC2:
.asciiz "        TIMEDISK PRODOS INSTALLER       "
SRC3:
.asciiz "                SLOT: N                 "
SRC4:
.asciiz " PRESS [Y] TO INSTALL PRODOS IMAGE ON   "
SRC5:
.asciiz " TIMEDISK IN SLOT N.                    "

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
.asciiz " WARNING! INSTALLING WILL ERASE         "
SRC7:
.asciiz " ALL DATA ON TIMEDISK IN SLOT N.        "
SRC8:
.asciiz " TO QUIT THIS PROGRAM AND LEAVE YOUR    "
SRC9:
.asciiz " TIMEDISK UNCHANGED, RESET OR POWER OFF "
SRC10:
.asciiz " YOUR APPLE.                            "
SRC11:
.asciiz "              INSTALLING...             "

blank_line:
; Set loop count to 40
LDY #40
JMP blank_loop

blank_3lines:
; Set loop count to 120
LDY #120
JMP blank_loop


.align 256
SRC12:
.asciiz "  DO NOT TURN OFF OR RESET YOUR APPLE.  "
SRC13:
.asciiz "            INSTALL COMPLETE            "
SRC14:
.asciiz "  TO USE TIMEDISK, TURN OFF YOUR APPLE  "
SRC15:
.asciiz "  AND REMOVE MODE JUMPER.               "

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
