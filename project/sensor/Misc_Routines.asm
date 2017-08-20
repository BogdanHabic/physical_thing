_enable_interrupt:
;Misc_Routines.c,10 :: 		void enable_interrupt() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,11 :: 		write_ZIGBEE_short(INTCON_M, 0x00);   // 0x00  all interrupts are enable
MOVS	R1, #0
SXTB	R1, R1
MOVS	R0, #50
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,12 :: 		}
L_end_enable_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _enable_interrupt
_set_channel:
;Misc_Routines.c,17 :: 		void set_channel(short int channel_number) {               // 11-26 possible channels
; channel_number start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; channel_number end address is: 0 (R0)
; channel_number start address is: 0 (R0)
;Misc_Routines.c,18 :: 		if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
CMP	R0, #26
IT	GT
BGT	L__set_channel51
CMP	R0, #11
IT	LT
BLT	L__set_channel50
; channel_number end address is: 0 (R0)
IT	AL
BAL	L_set_channel2
L__set_channel51:
L__set_channel50:
; channel_number start address is: 0 (R0)
MOVS	R0, #11
SXTB	R0, R0
; channel_number end address is: 0 (R0)
L_set_channel2:
;Misc_Routines.c,19 :: 		switch(channel_number) {
; channel_number start address is: 0 (R0)
IT	AL
BAL	L_set_channel3
; channel_number end address is: 0 (R0)
;Misc_Routines.c,20 :: 		case 11:
L_set_channel5:
;Misc_Routines.c,21 :: 		write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
MOVS	R1, #2
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,22 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,23 :: 		case 12:
L_set_channel6:
;Misc_Routines.c,24 :: 		write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
MOVS	R1, #18
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,25 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,26 :: 		case 13:
L_set_channel7:
;Misc_Routines.c,27 :: 		write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
MOVS	R1, #34
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,28 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,29 :: 		case 14:
L_set_channel8:
;Misc_Routines.c,30 :: 		write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
MOVS	R1, #50
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,31 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,32 :: 		case 15:
L_set_channel9:
;Misc_Routines.c,33 :: 		write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
MOVS	R1, #66
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,34 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,35 :: 		case 16:
L_set_channel10:
;Misc_Routines.c,36 :: 		write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
MOVS	R1, #82
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,37 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,38 :: 		case 17:
L_set_channel11:
;Misc_Routines.c,39 :: 		write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
MOVS	R1, #98
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,40 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,41 :: 		case 18:
L_set_channel12:
;Misc_Routines.c,42 :: 		write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
MOVS	R1, #114
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,43 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,44 :: 		case 19:
L_set_channel13:
;Misc_Routines.c,45 :: 		write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
MOVS	R1, #130
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,46 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,47 :: 		case 20:
L_set_channel14:
;Misc_Routines.c,48 :: 		write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
MOVS	R1, #146
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,49 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,50 :: 		case 21:
L_set_channel15:
;Misc_Routines.c,51 :: 		write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
MOVS	R1, #162
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,52 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,53 :: 		case 22:
L_set_channel16:
;Misc_Routines.c,54 :: 		write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
MOVS	R1, #178
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,55 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,56 :: 		case 23:
L_set_channel17:
;Misc_Routines.c,57 :: 		write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
MOVS	R1, #194
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,58 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,59 :: 		case 24:
L_set_channel18:
;Misc_Routines.c,60 :: 		write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
MOVS	R1, #210
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,61 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,62 :: 		case 25:
L_set_channel19:
;Misc_Routines.c,63 :: 		write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
MOVS	R1, #226
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,64 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,65 :: 		case 26:
L_set_channel20:
;Misc_Routines.c,66 :: 		write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
MOVS	R1, #242
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,67 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,68 :: 		}
L_set_channel3:
; channel_number start address is: 0 (R0)
CMP	R0, #11
IT	EQ
BEQ	L_set_channel5
CMP	R0, #12
IT	EQ
BEQ	L_set_channel6
CMP	R0, #13
IT	EQ
BEQ	L_set_channel7
CMP	R0, #14
IT	EQ
BEQ	L_set_channel8
CMP	R0, #15
IT	EQ
BEQ	L_set_channel9
CMP	R0, #16
IT	EQ
BEQ	L_set_channel10
CMP	R0, #17
IT	EQ
BEQ	L_set_channel11
CMP	R0, #18
IT	EQ
BEQ	L_set_channel12
CMP	R0, #19
IT	EQ
BEQ	L_set_channel13
CMP	R0, #20
IT	EQ
BEQ	L_set_channel14
CMP	R0, #21
IT	EQ
BEQ	L_set_channel15
CMP	R0, #22
IT	EQ
BEQ	L_set_channel16
CMP	R0, #23
IT	EQ
BEQ	L_set_channel17
CMP	R0, #24
IT	EQ
BEQ	L_set_channel18
CMP	R0, #25
IT	EQ
BEQ	L_set_channel19
CMP	R0, #26
IT	EQ
BEQ	L_set_channel20
; channel_number end address is: 0 (R0)
L_set_channel4:
;Misc_Routines.c,69 :: 		RF_reset();
BL	_RF_reset+0
;Misc_Routines.c,70 :: 		}
L_end_set_channel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_channel
_set_CCA_mode:
;Misc_Routines.c,75 :: 		void set_CCA_mode(short int CCA_mode) {
; CCA_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; CCA_mode end address is: 0 (R0)
; CCA_mode start address is: 0 (R0)
;Misc_Routines.c,76 :: 		short int temp = 0;
;Misc_Routines.c,77 :: 		switch(CCA_mode) {
IT	AL
BAL	L_set_CCA_mode21
; CCA_mode end address is: 0 (R0)
;Misc_Routines.c,78 :: 		case 1: {                               // ENERGY ABOVE THRESHOLD
L_set_CCA_mode23:
;Misc_Routines.c,79 :: 		temp = read_ZIGBEE_short(BBREG2);
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,80 :: 		temp = temp | 0x80;                   // 0x80 mask
ORR	R1, R0, #128
;Misc_Routines.c,81 :: 		temp = temp & 0xDF;                   // 0xDF mask
SXTB	R1, R1
AND	R1, R1, #223
;Misc_Routines.c,82 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,83 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
MOVS	R1, #96
SXTB	R1, R1
MOVS	R0, #63
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,85 :: 		break;
IT	AL
BAL	L_set_CCA_mode22
;Misc_Routines.c,87 :: 		case 2: {                               // CARRIER SENSE ONLY
L_set_CCA_mode24:
;Misc_Routines.c,88 :: 		temp = read_ZIGBEE_short(BBREG2);
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,89 :: 		temp = temp | 0x40;                   // 0x40 mask
ORR	R1, R0, #64
SXTB	R1, R1
;Misc_Routines.c,90 :: 		temp = temp & 0x7F;                   // 0x7F mask
AND	R1, R1, #127
;Misc_Routines.c,91 :: 		write_ZIGBEE_short(BBREG2, temp);
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,93 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,94 :: 		temp = temp | 0x38;
ORR	R1, R0, #56
SXTB	R1, R1
;Misc_Routines.c,95 :: 		temp = temp & 0xFB;
AND	R1, R1, #251
;Misc_Routines.c,96 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,98 :: 		break;
IT	AL
BAL	L_set_CCA_mode22
;Misc_Routines.c,100 :: 		case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
L_set_CCA_mode25:
;Misc_Routines.c,101 :: 		temp = read_ZIGBEE_short(BBREG2);
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,102 :: 		temp = temp | 0xC0;                   // 0xC0 mask
ORR	R1, R0, #192
;Misc_Routines.c,103 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,105 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,106 :: 		temp = temp | 0x38;                   // 0x38 mask
ORR	R1, R0, #56
SXTB	R1, R1
;Misc_Routines.c,107 :: 		temp = temp & 0xFB;                   // 0xFB mask
AND	R1, R1, #251
;Misc_Routines.c,108 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,110 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
MOVS	R1, #96
SXTB	R1, R1
MOVS	R0, #63
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,112 :: 		break;
IT	AL
BAL	L_set_CCA_mode22
;Misc_Routines.c,113 :: 		}
L_set_CCA_mode21:
; CCA_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_CCA_mode23
CMP	R0, #2
IT	EQ
BEQ	L_set_CCA_mode24
CMP	R0, #3
IT	EQ
BEQ	L_set_CCA_mode25
; CCA_mode end address is: 0 (R0)
L_set_CCA_mode22:
;Misc_Routines.c,114 :: 		}
L_end_set_CCA_mode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_CCA_mode
_set_RSSI_mode:
;Misc_Routines.c,119 :: 		void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
; RSSI_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; RSSI_mode end address is: 0 (R0)
; RSSI_mode start address is: 0 (R0)
;Misc_Routines.c,120 :: 		short int temp = 0;
;Misc_Routines.c,122 :: 		switch(RSSI_mode) {
IT	AL
BAL	L_set_RSSI_mode26
; RSSI_mode end address is: 0 (R0)
;Misc_Routines.c,123 :: 		case 1: {
L_set_RSSI_mode28:
;Misc_Routines.c,124 :: 		temp = read_ZIGBEE_short(BBREG6);
MOVS	R0, #62
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,125 :: 		temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
ORR	R1, R0, #128
;Misc_Routines.c,126 :: 		write_ZIGBEE_short(BBREG6, temp);
SXTB	R1, R1
MOVS	R0, #62
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,128 :: 		break;
IT	AL
BAL	L_set_RSSI_mode27
;Misc_Routines.c,130 :: 		case 2:
L_set_RSSI_mode29:
;Misc_Routines.c,131 :: 		write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
MOVS	R1, #64
SXTB	R1, R1
MOVS	R0, #62
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,132 :: 		break;
IT	AL
BAL	L_set_RSSI_mode27
;Misc_Routines.c,133 :: 		}
L_set_RSSI_mode26:
; RSSI_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_RSSI_mode28
CMP	R0, #2
IT	EQ
BEQ	L_set_RSSI_mode29
; RSSI_mode end address is: 0 (R0)
L_set_RSSI_mode27:
;Misc_Routines.c,134 :: 		}
L_end_set_RSSI_mode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_RSSI_mode
_nonbeacon_PAN_coordinator_device:
;Misc_Routines.c,139 :: 		void nonbeacon_PAN_coordinator_device() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,140 :: 		short int temp = 0;
;Misc_Routines.c,142 :: 		temp = read_ZIGBEE_short(RXMCR);
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,143 :: 		temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
ORR	R0, R0, #8
;Misc_Routines.c,144 :: 		write_ZIGBEE_short(RXMCR, temp);
SXTB	R1, R0
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,146 :: 		temp = read_ZIGBEE_short(TXMCR);
MOVS	R0, #17
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,147 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
AND	R0, R0, #223
;Misc_Routines.c,148 :: 		write_ZIGBEE_short(TXMCR, temp);
SXTB	R1, R0
MOVS	R0, #17
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,150 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
MOVS	R1, #255
SXTB	R1, R1
MOVS	R0, #16
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,151 :: 		}
L_end_nonbeacon_PAN_coordinator_device:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nonbeacon_PAN_coordinator_device
_nonbeacon_coordinator_device:
;Misc_Routines.c,153 :: 		void nonbeacon_coordinator_device() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,154 :: 		short int temp = 0;
;Misc_Routines.c,156 :: 		temp = read_ZIGBEE_short(RXMCR);
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,157 :: 		temp = temp | 0x04;                 // 0x04 mask for coordinator
ORR	R0, R0, #4
;Misc_Routines.c,158 :: 		write_ZIGBEE_short(RXMCR, temp);
SXTB	R1, R0
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,160 :: 		temp = read_ZIGBEE_short(TXMCR);
MOVS	R0, #17
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,161 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
AND	R0, R0, #223
;Misc_Routines.c,162 :: 		write_ZIGBEE_short(TXMCR, temp);
SXTB	R1, R0
MOVS	R0, #17
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,164 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
MOVS	R1, #255
SXTB	R1, R1
MOVS	R0, #16
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,165 :: 		}
L_end_nonbeacon_coordinator_device:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nonbeacon_coordinator_device
_nonbeacon_device:
;Misc_Routines.c,167 :: 		void nonbeacon_device() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,168 :: 		short int temp = 0;
;Misc_Routines.c,170 :: 		temp = read_ZIGBEE_short(RXMCR);
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,171 :: 		temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
AND	R0, R0, #243
;Misc_Routines.c,172 :: 		write_ZIGBEE_short(RXMCR, temp);
SXTB	R1, R0
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,174 :: 		temp = read_ZIGBEE_short(TXMCR);
MOVS	R0, #17
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,175 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
AND	R0, R0, #223
;Misc_Routines.c,176 :: 		write_ZIGBEE_short(TXMCR, temp);
SXTB	R1, R0
MOVS	R0, #17
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,177 :: 		}
L_end_nonbeacon_device:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nonbeacon_device
_set_ACK:
;Misc_Routines.c,182 :: 		void set_ACK() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,183 :: 		short int temp = 0;
;Misc_Routines.c,185 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,186 :: 		temp = temp | 0x04;                   // 0x04 mask for set ACK
ORR	R0, R0, #4
;Misc_Routines.c,187 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,188 :: 		}
L_end_set_ACK:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_ACK
_set_not_ACK:
;Misc_Routines.c,190 :: 		void set_not_ACK() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,191 :: 		short int temp = 0;
;Misc_Routines.c,193 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,194 :: 		temp = temp & (!0x04);                // 0x04 mask for set not ACK
AND	R0, R0, #0
;Misc_Routines.c,195 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,196 :: 		}
L_end_set_not_ACK:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_not_ACK
_set_encrypt:
;Misc_Routines.c,201 :: 		void set_encrypt() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,202 :: 		short int temp = 0;
;Misc_Routines.c,204 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,205 :: 		temp = temp | 0x02;                   // mask for set encrypt
ORR	R0, R0, #2
;Misc_Routines.c,206 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,207 :: 		}
L_end_set_encrypt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_encrypt
_set_not_encrypt:
;Misc_Routines.c,209 :: 		void set_not_encrypt(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,210 :: 		short int temp = 0;
;Misc_Routines.c,212 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,213 :: 		temp = temp & (!0x02);                // mask for set not encrypt
AND	R0, R0, #0
;Misc_Routines.c,214 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,215 :: 		}
L_end_set_not_encrypt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_not_encrypt
_set_IFS_recomended:
;Misc_Routines.c,220 :: 		void set_IFS_recomended() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,221 :: 		short int temp = 0;
;Misc_Routines.c,223 :: 		write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period
MOVS	R1, #147
SXTB	R1, R1
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,225 :: 		temp = read_ZIGBEE_short(TXPEND);
MOVS	R0, #33
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,226 :: 		temp = temp | 0x7C;                 // MinLIFSPeriod
ORR	R0, R0, #124
;Misc_Routines.c,227 :: 		write_ZIGBEE_short(TXPEND, temp);
SXTB	R1, R0
MOVS	R0, #33
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,229 :: 		temp = read_ZIGBEE_short(TXSTBL);
MOVS	R0, #46
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,230 :: 		temp = temp | 0x90;                 // MinLIFSPeriod
ORR	R0, R0, #144
;Misc_Routines.c,231 :: 		write_ZIGBEE_short(TXSTBL, temp);
SXTB	R1, R0
MOVS	R0, #46
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,233 :: 		temp = read_ZIGBEE_short(TXTIME);
MOVS	R0, #39
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,234 :: 		temp = temp | 0x31;                 // TurnaroundTime
ORR	R0, R0, #49
;Misc_Routines.c,235 :: 		write_ZIGBEE_short(TXTIME, temp);
SXTB	R1, R0
MOVS	R0, #39
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,236 :: 		}
L_end_set_IFS_recomended:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_IFS_recomended
_set_IFS_default:
;Misc_Routines.c,238 :: 		void set_IFS_default() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,239 :: 		short int temp = 0;
;Misc_Routines.c,241 :: 		write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period
MOVS	R1, #117
SXTB	R1, R1
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,243 :: 		temp = read_ZIGBEE_short(TXPEND);
MOVS	R0, #33
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,244 :: 		temp = temp | 0x84;                 // Min LIFS Period
ORR	R0, R0, #132
;Misc_Routines.c,245 :: 		write_ZIGBEE_short(TXPEND, temp);
SXTB	R1, R0
MOVS	R0, #33
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,247 :: 		temp = read_ZIGBEE_short(TXSTBL);
MOVS	R0, #46
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,248 :: 		temp = temp | 0x50;                 // Min LIFS Period
ORR	R0, R0, #80
;Misc_Routines.c,249 :: 		write_ZIGBEE_short(TXSTBL, temp);
SXTB	R1, R0
MOVS	R0, #46
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,251 :: 		temp = read_ZIGBEE_short(TXTIME);
MOVS	R0, #39
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,252 :: 		temp = temp | 0x41;                 // Turnaround Time
ORR	R0, R0, #65
;Misc_Routines.c,253 :: 		write_ZIGBEE_short(TXTIME, temp);
SXTB	R1, R0
MOVS	R0, #39
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,254 :: 		}
L_end_set_IFS_default:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_IFS_default
_set_reception_mode:
;Misc_Routines.c,259 :: 		void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
; r_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; r_mode end address is: 0 (R0)
; r_mode start address is: 0 (R0)
;Misc_Routines.c,260 :: 		short int temp = 0;
;Misc_Routines.c,262 :: 		switch(r_mode) {
IT	AL
BAL	L_set_reception_mode30
; r_mode end address is: 0 (R0)
;Misc_Routines.c,263 :: 		case 1: {
L_set_reception_mode32:
;Misc_Routines.c,264 :: 		temp = read_ZIGBEE_short(RXMCR);      // normal mode
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,265 :: 		temp = temp & (!0x03);                // mask for normal mode
AND	R1, R0, #0
;Misc_Routines.c,266 :: 		write_ZIGBEE_short(RXMCR, temp);
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,268 :: 		break;
IT	AL
BAL	L_set_reception_mode31
;Misc_Routines.c,270 :: 		case 2: {
L_set_reception_mode33:
;Misc_Routines.c,271 :: 		temp = read_ZIGBEE_short(RXMCR);      // error mode
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,272 :: 		temp = temp & (!0x01);                // mask for error mode
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,273 :: 		temp = temp | 0x02;                   // mask for error mode
ORR	R1, R1, #2
;Misc_Routines.c,274 :: 		write_ZIGBEE_short(RXMCR, temp);
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,276 :: 		break;
IT	AL
BAL	L_set_reception_mode31
;Misc_Routines.c,278 :: 		case 3: {
L_set_reception_mode34:
;Misc_Routines.c,279 :: 		temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,280 :: 		temp = temp & (!0x02);                // mask for promiscuous mode
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,281 :: 		temp = temp | 0x01;                   // mask for promiscuous mode
ORR	R1, R1, #1
;Misc_Routines.c,282 :: 		write_ZIGBEE_short(RXMCR, temp);
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,284 :: 		break;
IT	AL
BAL	L_set_reception_mode31
;Misc_Routines.c,285 :: 		}
L_set_reception_mode30:
; r_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_reception_mode32
CMP	R0, #2
IT	EQ
BEQ	L_set_reception_mode33
CMP	R0, #3
IT	EQ
BEQ	L_set_reception_mode34
; r_mode end address is: 0 (R0)
L_set_reception_mode31:
;Misc_Routines.c,286 :: 		}
L_end_set_reception_mode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_reception_mode
_set_frame_format_filter:
;Misc_Routines.c,291 :: 		void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
; fff_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; fff_mode end address is: 0 (R0)
; fff_mode start address is: 0 (R0)
;Misc_Routines.c,292 :: 		short int temp = 0;
;Misc_Routines.c,294 :: 		switch(fff_mode) {
IT	AL
BAL	L_set_frame_format_filter35
; fff_mode end address is: 0 (R0)
;Misc_Routines.c,295 :: 		case 1: {
L_set_frame_format_filter37:
;Misc_Routines.c,296 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // all frames
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,297 :: 		temp = temp & (!0x0E);                  // mask for all frames
AND	R1, R0, #0
;Misc_Routines.c,298 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,300 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,302 :: 		case 2: {
L_set_frame_format_filter38:
;Misc_Routines.c,303 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // command only
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,304 :: 		temp = temp & (!0x06);                  // mask for command only
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,305 :: 		temp = temp | 0x08;                     // mask for command only
ORR	R1, R1, #8
;Misc_Routines.c,306 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,308 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,310 :: 		case 3: {
L_set_frame_format_filter39:
;Misc_Routines.c,311 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // data only
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,312 :: 		temp = temp & (!0x0A);                  // mask for data only
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,313 :: 		temp = temp | 0x04;                     // mask for data only
ORR	R1, R1, #4
;Misc_Routines.c,314 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,316 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,318 :: 		case 4: {
L_set_frame_format_filter40:
;Misc_Routines.c,319 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,320 :: 		temp = temp & (!0x0C);                  // mask for beacon only
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,321 :: 		temp = temp | 0x02;                     // mask for beacon only
ORR	R1, R1, #2
;Misc_Routines.c,322 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,324 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,325 :: 		}
L_set_frame_format_filter35:
; fff_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_frame_format_filter37
CMP	R0, #2
IT	EQ
BEQ	L_set_frame_format_filter38
CMP	R0, #3
IT	EQ
BEQ	L_set_frame_format_filter39
CMP	R0, #4
IT	EQ
BEQ	L_set_frame_format_filter40
; fff_mode end address is: 0 (R0)
L_set_frame_format_filter36:
;Misc_Routines.c,326 :: 		}
L_end_set_frame_format_filter:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_frame_format_filter
_flush_RX_FIFO_pointer:
;Misc_Routines.c,331 :: 		void flush_RX_FIFO_pointer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,334 :: 		temp = read_ZIGBEE_short(RXFLUSH);
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,335 :: 		temp = temp | 0x01;                        // mask for flush RX FIFO
ORR	R0, R0, #1
;Misc_Routines.c,336 :: 		write_ZIGBEE_short(RXFLUSH, temp);
SXTB	R1, R0
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,337 :: 		}
L_end_flush_RX_FIFO_pointer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _flush_RX_FIFO_pointer
_set_short_address:
;Misc_Routines.c,342 :: 		void set_short_address(short int * address) {
; address start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; address end address is: 0 (R0)
; address start address is: 0 (R0)
;Misc_Routines.c,343 :: 		write_ZIGBEE_short(SADRL, address[0]);
LDRSB	R1, [R0, #0]
STR	R0, [SP, #4]
MOVS	R0, #3
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
LDR	R0, [SP, #4]
;Misc_Routines.c,344 :: 		write_ZIGBEE_short(SADRH, address[1]);
ADDS	R1, R0, #1
; address end address is: 0 (R0)
LDRSB	R1, [R1, #0]
MOVS	R0, #4
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,345 :: 		}
L_end_set_short_address:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_short_address
_set_long_address:
;Misc_Routines.c,347 :: 		void set_long_address(short int * address) {
; i start address is: 12 (R3)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Misc_Routines.c,350 :: 		for(i = 0; i < 8; i++) {
;Misc_Routines.c,347 :: 		void set_long_address(short int * address) {
;Misc_Routines.c,350 :: 		for(i = 0; i < 8; i++) {
;Misc_Routines.c,347 :: 		void set_long_address(short int * address) {
STR	R0, [SP, #8]
; i end address is: 12 (R3)
;Misc_Routines.c,348 :: 		short int i = 0;
;Misc_Routines.c,350 :: 		for(i = 0; i < 8; i++) {
; i start address is: 12 (R3)
MOVS	R3, #0
SXTB	R3, R3
; i end address is: 12 (R3)
SXTB	R0, R3
L_set_long_address41:
; i start address is: 0 (R0)
CMP	R0, #8
IT	GE
BGE	L_set_long_address42
;Misc_Routines.c,351 :: 		write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
LDR	R1, [SP, #8]
ADDS	R1, R1, R0
LDRSB	R1, [R1, #0]
SXTB	R2, R1
ADDS	R1, R0, #5
STRB	R0, [SP, #4]
SXTB	R0, R1
SXTB	R1, R2
BL	_write_ZIGBEE_short+0
LDRSB	R0, [SP, #4]
;Misc_Routines.c,350 :: 		for(i = 0; i < 8; i++) {
ADDS	R1, R0, #1
; i end address is: 0 (R0)
; i start address is: 12 (R3)
SXTB	R3, R1
;Misc_Routines.c,352 :: 		}
SXTB	R0, R3
; i end address is: 12 (R3)
IT	AL
BAL	L_set_long_address41
L_set_long_address42:
;Misc_Routines.c,353 :: 		}
L_end_set_long_address:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _set_long_address
_set_PAN_ID:
;Misc_Routines.c,355 :: 		void set_PAN_ID(short int * address) {
; address start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; address end address is: 0 (R0)
; address start address is: 0 (R0)
;Misc_Routines.c,356 :: 		write_ZIGBEE_short(PANIDL, address[0]);
LDRSB	R1, [R0, #0]
STR	R0, [SP, #4]
MOVS	R0, #1
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
LDR	R0, [SP, #4]
;Misc_Routines.c,357 :: 		write_ZIGBEE_short(PANIDH, address[1]);
ADDS	R1, R0, #1
; address end address is: 0 (R0)
LDRSB	R1, [R1, #0]
MOVS	R0, #2
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,358 :: 		}
L_end_set_PAN_ID:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_PAN_ID
_set_wake_from_pin:
;Misc_Routines.c,363 :: 		void set_wake_from_pin() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,364 :: 		short int temp = 0;
;Misc_Routines.c,366 :: 		WAKE_ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(WAKE_+0)
MOVT	R0, #hi_addr(WAKE_+0)
STR	R1, [R0, #0]
;Misc_Routines.c,367 :: 		temp = read_ZIGBEE_short(RXFLUSH);
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,368 :: 		temp = temp | 0x60;                     // mask
ORR	R0, R0, #96
;Misc_Routines.c,369 :: 		write_ZIGBEE_short(RXFLUSH, temp);
SXTB	R1, R0
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,371 :: 		temp = read_ZIGBEE_short(WAKECON);
MOVS	R0, #34
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,372 :: 		temp = temp | 0x80;
ORR	R0, R0, #128
;Misc_Routines.c,373 :: 		write_ZIGBEE_short(WAKECON, temp);
SXTB	R1, R0
MOVS	R0, #34
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,374 :: 		}
L_end_set_wake_from_pin:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_wake_from_pin
_pin_wake:
;Misc_Routines.c,376 :: 		void pin_wake() {
SUB	SP, SP, #4
;Misc_Routines.c,377 :: 		WAKE_ = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(WAKE_+0)
MOVT	R0, #hi_addr(WAKE_+0)
STR	R1, [R0, #0]
;Misc_Routines.c,378 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_pin_wake44:
SUBS	R7, R7, #1
BNE	L_pin_wake44
NOP
NOP
NOP
;Misc_Routines.c,379 :: 		}
L_end_pin_wake:
ADD	SP, SP, #4
BX	LR
; end of _pin_wake
_enable_PLL:
;Misc_Routines.c,384 :: 		void enable_PLL() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,385 :: 		write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
MOVS	R1, #128
SXTB	R1, R1
MOVW	R0, #514
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,386 :: 		}
L_end_enable_PLL:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _enable_PLL
_disable_PLL:
;Misc_Routines.c,388 :: 		void disable_PLL() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,389 :: 		write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #514
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,390 :: 		}
L_end_disable_PLL:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _disable_PLL
_set_TX_power:
;Misc_Routines.c,395 :: 		void set_TX_power(unsigned short int power) {             // 0-31 possible variants
; power start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; power end address is: 0 (R0)
; power start address is: 0 (R0)
;Misc_Routines.c,396 :: 		if((power < 0) || (power > 31))
CMP	R0, #0
IT	CC
BCC	L__set_TX_power54
CMP	R0, #31
IT	HI
BHI	L__set_TX_power53
; power end address is: 0 (R0)
IT	AL
BAL	L_set_TX_power48
L__set_TX_power54:
L__set_TX_power53:
;Misc_Routines.c,397 :: 		power = 31;
; power start address is: 0 (R0)
MOVS	R0, #31
; power end address is: 0 (R0)
L_set_TX_power48:
;Misc_Routines.c,398 :: 		power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
; power start address is: 0 (R0)
RSB	R1, R0, #31
; power end address is: 0 (R0)
;Misc_Routines.c,399 :: 		power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
UXTB	R1, R1
AND	R1, R1, #31
UXTB	R1, R1
LSLS	R1, R1, #3
UXTH	R1, R1
AND	R1, R1, #248
;Misc_Routines.c,400 :: 		write_ZIGBEE_long(RFCON3, power);
SXTB	R1, R1
MOVW	R0, #515
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,401 :: 		}
L_end_set_TX_power:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_TX_power
_init_ZIGBEE_basic:
;Misc_Routines.c,406 :: 		void init_ZIGBEE_basic() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,407 :: 		write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
MOVS	R1, #152
SXTB	R1, R1
MOVS	R0, #24
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,408 :: 		write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
MOVS	R1, #149
SXTB	R1, R1
MOVS	R0, #46
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,409 :: 		write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #513
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,410 :: 		enable_PLL();                       // Enable PLL (PLLEN = 1)
BL	_enable_PLL+0
;Misc_Routines.c,411 :: 		write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
MOVS	R1, #144
SXTB	R1, R1
MOVW	R0, #518
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,412 :: 		write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
MOVS	R1, #128
SXTB	R1, R1
MOVW	R0, #519
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,413 :: 		write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
MOVS	R1, #16
SXTB	R1, R1
MOVW	R0, #520
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,414 :: 		write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
MOVS	R1, #33
SXTB	R1, R1
MOVW	R0, #544
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,415 :: 		}
L_end_init_ZIGBEE_basic:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_ZIGBEE_basic
_init_ZIGBEE_nonbeacon:
;Misc_Routines.c,417 :: 		void init_ZIGBEE_nonbeacon() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,418 :: 		init_ZIGBEE_basic();
BL	_init_ZIGBEE_basic+0
;Misc_Routines.c,419 :: 		set_CCA_mode(1);     // Set CCA mode to ED and set threshold
MOVS	R0, #1
SXTB	R0, R0
BL	_set_CCA_mode+0
;Misc_Routines.c,420 :: 		set_RSSI_mode(2);    // RSSI2 mode
MOVS	R0, #2
SXTB	R0, R0
BL	_set_RSSI_mode+0
;Misc_Routines.c,421 :: 		enable_interrupt();  // Enables all interrupts
BL	_enable_interrupt+0
;Misc_Routines.c,422 :: 		set_channel(11);     // Channel 11
MOVS	R0, #11
SXTB	R0, R0
BL	_set_channel+0
;Misc_Routines.c,423 :: 		RF_reset();
BL	_RF_reset+0
;Misc_Routines.c,424 :: 		}
L_end_init_ZIGBEE_nonbeacon:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_ZIGBEE_nonbeacon
