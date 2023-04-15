spi_cs_enable:
PHA
LDA #$FF
STA $(PTR_BANK)
PLA
RTS

spi_cs_disable:
PHA
LDA #$00
STA $(PTR_BANK)
PLA
RTS

spi_txbyte:
PHA
TXA
PHA
TYA
PHA
LDX #8              ; X = 8
; do {
spi_txbyte_loop:
PHA                 ; Push remainder of byte
AND #$01            ; Get low bit to put on MOSI
TAY                 ; Get MOSI bit in Y
LDA $(PTR_XFER),Y   ; Transfer one bit on SPI
PLA                 ; Get rest of byte back
LSR                 ; Shift right to discard bit just sent
; } while (--x > 0);
DEX                 
BNE spi_txbyte_loop
; Return
RTS

spi_rxbyte:
TXA
PHA
LDX #8              ; X = 8
; do {
spi_rxbyte_loop:
; Get partial byte from previous iteration
TYA                 ; Get from last time
; Make room for new bit
ASL                 ; Move up one position
; Get MISO in low bit of accumulator
LDA $(PTR_BANK)
AND #1
; Save partial byte in Y
TAY
LDA $(PTR_XFER)     ; Transfer one bit on SPI
; } while (--x > 0);
DEX                 
BNE spi_rxbyte_loop
; Return
PLA
TAX
TYA
RTS
