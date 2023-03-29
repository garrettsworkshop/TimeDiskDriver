LINE0      = $0400
LINE1      = $0480
LINE2      = $0500
LINE3      = $0580
LINE4      = $0600
LINE5      = $0680
LINE6      = $0700
LINE7      = $0680
LINE8      = $0428
LINE9      = $04A8
LINE10     = $0528
LINE11     = $05A8
LINE12     = $0628
LINE13     = $06A8
LINE14     = $0728
LINE15     = $07A8
LINE16     = $0450
LINE17     = $04D0
LINE18     = $0550
LINE19     = $05D0
LINE20     = $0650
LINE21     = $06D0
LINE22     = $0750
LINE23     = $07D0
KBD        = $C000
IOCLR      = $CFFF

BANK_PROG  = $04
BANK_UTIL  = $04
BANK_MAP   = $05
BANK_END   = $04
BANK_DATA  = $06

PTR_SRC    = $80
PTR_SRC_H  = $81
PTR_DST    = $82
PTR_DST_H  = $83
PTR_CTAB   = $84
PTR_CTAB_H = $85

PTR_C800   = $90
PTR_C800_H = $91
PTR_C900   = $92
PTR_C900_H = $93
PTR_CA00   = $94
PTR_CA00_H = $95
PTR_CB00   = $96
PTR_CB00_H = $97
PTR_CC00   = $98
PTR_CC00_H = $99
PTR_CD00   = $9A
PTR_CD00_H = $9B
PTR_CE00   = $9C
PTR_CE00_H = $9D
PTR_CF00   = $9E
PTR_CF00_H = $9F

;---------------------------------------
.segment "IOSEL"
.org $C000
;---------------------------------------

.include "header.s"

.scope iosel1
.align 256
SLOTNUM = 1
SLOTNUM_TEXT = '1'
REG_ADDRL = $C090
REG_ADDRM = $C091
REG_ADDRH = $C092
REG_DATA  = $C093
REG_BANK  = $C09F
.include "iosel.s"
.endscope

.scope iosel2
.align 256
SLOTNUM = 2
SLOTNUM_TEXT = '2'
REG_ADDRL = $C0A0
REG_ADDRM = $C0A1
REG_ADDRH = $C0A2
REG_DATA  = $C0A3
REG_BANK  = $C0AF
.include "iosel.s"
.endscope

.scope iosel3
.align 256
SLOTNUM = 3
SLOTNUM_TEXT = '3'
REG_ADDRL = $C0A0
REG_ADDRM = $C0A1
REG_ADDRH = $C0A2
REG_DATA  = $C0A3
REG_BANK  = $C0AF
.include "iosel.s"
.endscope

.scope iosel4
.align 256
SLOTNUM = 4
SLOTNUM_TEXT = '4'
REG_ADDRL = $C0A0
REG_ADDRM = $C0A1
REG_ADDRH = $C0A2
REG_DATA  = $C0A3
REG_BANK  = $C0AF
.include "iosel.s"
.endscope

.scope iosel5
.align 256
SLOTNUM = 5
SLOTNUM_TEXT = '5'
REG_ADDRL = $C0A0
REG_ADDRM = $C0A1
REG_ADDRH = $C0A2
REG_DATA  = $C0A3
REG_BANK  = $C0AF
.include "iosel.s"
.endscope

.scope iosel6
.align 256
SLOTNUM_TEXT = '6'
REG_ADDRL = $C0A0
REG_ADDRM = $C0A1
REG_ADDRH = $C0A2
REG_DATA  = $C0A3
REG_BANK  = $C0AF
.include "iosel.s"
.endscope

.scope iosel7
.align 256
SLOTNUM_TEXT = '7'
REG_ADDRL = $C0A0
REG_ADDRM = $C0A1
REG_ADDRH = $C0A2
REG_DATA  = $C0A3
REG_BANK  = $C0AF
.include "iosel.s"
.endscope

.res $C800-*


;---------------------------------------
.segment "IOSTRB"
.org $C800
;---------------------------------------

.include "prog.s"
.include "util.s"
.include "screens.s"
.res $CF00-*
.res 255
