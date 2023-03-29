; Image restore UI program entry point
restore_ui_confirm:
; Push ASCII slot number argument
PHA

; Blank $0400
LDA #$00
STA PTR_DST
LDA #$04
STA PTR_DST_H
JSR blank_3lines
; Blank $0480
LDA #PTR_SRC
STA PTR_DST
JSR blank_3lines
; Blank $0580
LDA #$05
STA PTR_DST_H
JSR blank_3lines
; Blank $0500
LDA #$00
STA PTR_DST
JSR blank_3lines
; Blank $0600
LDA #$06
STA PTR_DST_H
JSR blank_3lines
; Blank $0680
LDA #PTR_SRC
STA PTR_DST
JSR blank_3lines
; Blank $0780
LDA #$07
STA PTR_DST_H
JSR blank_3lines
; Blank $0700
LDA #$00
STA PTR_DST
JSR blank_3lines

; Copy SRC0 (box header horizontal line) to LINE0,3
LDA #.lobyte(SRC0)
STA PTR_SRC
LDA #.hibyte(SRC0)
STA PTR_SRC_H
LDA #.lobyte(LINE0)
STA PTR_DST
LDA #.hibyte(LINE0)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(LINE3)
STA PTR_DST
LDA #.hibyte(LINE3)
STA PTR_DST_H
JSR copy_line

; Copy SRC1,2 to LINE1,2 (GW header text)
LDA #.lobyte(SRC1)
STA PTR_SRC
LDA #.hibyte(SRC1)
STA PTR_SRC_H
LDA #.lobyte(LINE1)
STA PTR_DST
LDA #.hibyte(LINE1)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC2)
STA PTR_SRC
LDA #.hibyte(SRC2)
STA PTR_SRC_H
LDA #.lobyte(LINE2)
STA PTR_DST
LDA #.hibyte(LINE2)
STA PTR_DST_H
JSR copy_line

; Copy SRC3 to LINE5 (slot number indication)
LDA #.lobyte(SRC3)
STA PTR_SRC
LDA #.hibyte(SRC3)
STA PTR_SRC_H
LDA #.lobyte(LINE5)
STA PTR_DST
LDA #.hibyte(LINE5)
STA PTR_DST_H
JSR copy_line


; Write text from SRC4,5 to LINE7,8
LDA #.lobyte(SRC4)
STA PTR_SRC
LDA #.hibyte(SRC4)
STA PTR_SRC_H
LDA #.lobyte(LINE7)
STA PTR_DST
LDA #.hibyte(LINE7)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC5)
STA PTR_SRC
LDA #.hibyte(SRC5)
STA PTR_SRC_H
LDA #.lobyte(LINE8)
STA PTR_DST
LDA #.hibyte(LINE8)
STA PTR_DST_H
JSR copy_line

; Write text from SRC6,7 to LINE10,11
LDA #.lobyte(SRC6)
STA PTR_SRC
LDA #.hibyte(SRC6)
STA PTR_SRC_H
LDA #.lobyte(LINE10)
STA PTR_DST
LDA #.hibyte(LINE10)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC7)
STA PTR_SRC
LDA #.hibyte(SRC7)
STA PTR_SRC_H
LDA #.lobyte(LINE11)
STA PTR_DST
LDA #.hibyte(LINE11)
STA PTR_DST_H
JSR copy_line

; Write text from SRC8,9,10 to LINE13,14,15
LDA #.lobyte(SRC8)
STA PTR_SRC
LDA #.hibyte(SRC8)
STA PTR_SRC_H
LDA #.lobyte(LINE13)
STA PTR_DST
LDA #.hibyte(LINE13)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC9)
STA PTR_SRC
LDA #.hibyte(SRC9)
STA PTR_SRC_H
LDA #.lobyte(LINE14)
STA PTR_DST
LDA #.hibyte(LINE14)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC10)
STA PTR_SRC
LDA #.hibyte(SRC10)
STA PTR_SRC_H
LDA #.lobyte(LINE15)
STA PTR_DST
LDA #.hibyte(LINE15)
STA PTR_DST_H
JSR copy_line

; Write slot number
PLA
LDX #22
STA LINE5,X
LDX #18
STA LINE8,X
LDX #30
STA LINE11,X

; Loop until Y pressed
restore_loop:
LDA $C000
BPL restore_loop
AND #($7F .bitand ((.bitnot ('Y' .bitxor 'y'))))
STA $C010
CMP #('Y' .bitand 'y')
BNE restore_loop
; Else if equal, fall through to write restore message

; Write "restoring" message from SRC11,12 to LINE7,8
LDA #.lobyte(SRC11)
STA PTR_SRC
LDA #.hibyte(SRC11)
STA PTR_SRC_H
LDA #.lobyte(LINE7)
STA PTR_DST
LDA #.hibyte(LINE7)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC12)
STA PTR_SRC
LDA #.hibyte(SRC12)
STA PTR_SRC_H
LDA #.lobyte(LINE8)
STA PTR_DST
LDA #.hibyte(LINE8)
STA PTR_DST_H
JSR copy_line

; Blank LINE10,11,13,14,15 with SRC3
LDA #.lobyte(LINE10)
STA PTR_DST
LDA #.hibyte(LINE10)
STA PTR_DST_H
JSR blank_line
LDA #.lobyte(LINE11)
STA PTR_DST
LDA #.hibyte(LINE11)
STA PTR_DST_H
JSR blank_line
LDA #.lobyte(LINE13)
STA PTR_DST
LDA #.hibyte(LINE13)
STA PTR_DST_H
JSR blank_line
LDA #.lobyte(LINE14)
STA PTR_DST
LDA #.hibyte(LINE14)
STA PTR_DST_H
JSR blank_line
LDA #.lobyte(LINE15)
STA PTR_DST
LDA #.hibyte(LINE15)
STA PTR_DST_H
rrrr:
JSR blank_line
JMP rrrr

; Return to restore image
RTS

; Write "complete" message from SRC13,14,15 to LINE7,8,9
restore_ui_complete:
LDA #.lobyte(SRC13)
STA PTR_SRC
LDA #.hibyte(SRC13)
STA PTR_SRC_H
LDA #.lobyte(LINE7)
STA PTR_DST
LDA #.hibyte(LINE7)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC14)
STA PTR_SRC
LDA #.hibyte(SRC14)
STA PTR_SRC_H
LDA #.lobyte(LINE8)
STA PTR_DST
LDA #.hibyte(LINE8)
STA PTR_DST_H
JSR copy_line
LDA #.lobyte(SRC15)
STA PTR_SRC
LDA #.hibyte(SRC15)
STA PTR_SRC_H
LDA #.lobyte(LINE9)
STA PTR_DST
LDA #.hibyte(LINE9)
STA PTR_DST_H
JSR copy_line
restore_ui_complete_loop:
JMP restore_ui_complete_loop
