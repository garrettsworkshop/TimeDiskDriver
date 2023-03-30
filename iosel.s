; Reserved space for signature bytes
signature:
cmp #$00
cmp #$00
cmp #$00
cmp #$00
; Branch or fall through to boot
bcs boot

; Cn0A: diagnostics entry point (unused, just fall through to boot card)
diagnostics:
boot:
; Disable IRQ and clear decimal mode flag
SEI
CLD
; Set bank to call program
LDA #BANK_PROG
STA REG_BANK
; Clear other IOSTRB
LDA IOCLR
; Load slot number argument
LDA #SLOTNUM_TEXT
; Jump to display UI
JSR restore_ui_confirm

restore:
; Set bank to call program
LDA #BANK_PROG
STA REG_BANK
; Clear other IOSTRB
LDA IOCLR
; Call routine to setup CX00 pointers in $90-91, $92-93, ... $9E-$9F
JSR setup_pointers
; Clear Slinky address
LDA #0
STA REG_ADDRL
STA REG_ADDRM
STA REG_ADDRH
; Set loop counter to 0
LDY #0

; Iterate through chunks to restore
; do {
restore_loop:
; Set chunk table pointer high byte to restore even chunk in pair
LDA #$C8
STA PTR_CTAB_H
; Restore this chunk
JSR restore_dispatch
; Set chunk table pointer high byte to restore odd chunk in pair
LDA #$C9
STA PTR_CTAB_H
; Restore this chunk
JSR restore_dispatch
; } while (++Y != 0)
INY
BNE restore_loop
; Go back to prog bank
LDA #BANK_PROG
STA REG_BANK
; After restore loop go to restore complete screen
JMP restore_ui_complete

restore_dispatch:
; Set bank to data map
LDA #BANK_MAP
STA REG_BANK
; Get even bank index for even destination chunk into accumulator
LDA (PTR_CTAB),Y
; Switch to source bank
STA REG_BANK
; Transfer bank index from accumulator to X
TAX
; Push Y register to save chunk index
TYA
PHA
; Move bank index in X register bank to A to set flags
TXA
BRK
; If source bank index nonzero, restore from it
BNE restore_bank
; Else source bank index is zero so restore all zeros
; fall through to restore_blank

; Restore blank bank
restore_blank:
; Set loop counter to 0
LDY #0
; Loop to write 0's to RAM
; do {
restore_blank_loop:
; Store 7 consecutive zero bytes
LDA #$00
STA REG_DATA
STA REG_DATA
STA REG_DATA
STA REG_DATA
STA REG_DATA
STA REG_DATA
STA REG_DATA
STA REG_DATA
; } while (++Y != 0);
INY
BNE restore_blank_loop

restore_blank_end:
; Move bank index in X register to A register
TXA
; Pull clobbered chunk index into Y register
PLA
TAY
; Return
RTS


; Restore bank
restore_bank:
; Set loop counter to 0
LDY #0
; Loop to write bank data to RAM
; do {
restore_bank_loop:
; Copy 7 bytes
LDA (PTR_C800),Y
STA REG_DATA
LDA (PTR_C900),Y
STA REG_DATA
LDA (PTR_CA00),Y
STA REG_DATA
LDA (PTR_CB00),Y
STA REG_DATA
LDA (PTR_CC00),Y
STA REG_DATA
LDA (PTR_CD00),Y
STA REG_DATA
LDA (PTR_CE00),Y
STA REG_DATA
; if (Y == 0xFF) break;
CPY #$FF
BEQ restore_bank_end
; Else copy final byte of 8
LDA (PTR_CF00),Y
STA REG_DATA
; } while (++Y != 0);
INY
BNE restore_bank_loop

restore_bank_end:
; Pull and re-push bank index
PLA
PHA
; Subtract data bank index from bank index in accumulator
SEC
SBC #1
; Move last byte index into Y register
TAY
; Get final byte for bank just restored
LDA #BANK_END
STA REG_BANK
LDA (PTR_CF00),Y
STA REG_DATA
; Pull clobbered chunk index into Y register
PLA
TAY
; Return
RTS
