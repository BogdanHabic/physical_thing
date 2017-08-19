_write_ZIGBEE_short:
;ReadWrite_Routines.c,25 :: 		void write_ZIGBEE_short(short int address, short int data_r) {
; data_r start address is: 4 (R1)
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTB	R4, R1
; data_r end address is: 4 (R1)
; address end address is: 0 (R0)
; address start address is: 0 (R0)
; data_r start address is: 16 (R4)
;ReadWrite_Routines.c,26 :: 		CS = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(CS+0)
MOVT	R2, #hi_addr(CS+0)
STR	R3, [R2, #0]
;ReadWrite_Routines.c,28 :: 		address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
LSLS	R2, R0, #1
SXTH	R2, R2
; address end address is: 0 (R0)
AND	R2, R2, #127
SXTH	R2, R2
ORR	R2, R2, #1
;ReadWrite_Routines.c,29 :: 		SPI3_Read(address);                             // addressing register
SXTB	R0, R2
UXTH	R0, R0
BL	_SPI3_Read+0
;ReadWrite_Routines.c,30 :: 		SPI3_Write(data_r);                             // write data in register
SXTB	R0, R4
UXTH	R0, R0
; data_r end address is: 16 (R4)
BL	_SPI3_Write+0
;ReadWrite_Routines.c,32 :: 		CS = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(CS+0)
MOVT	R2, #hi_addr(CS+0)
STR	R3, [R2, #0]
;ReadWrite_Routines.c,33 :: 		}
L_end_write_ZIGBEE_short:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_ZIGBEE_short
_read_ZIGBEE_short:
;ReadWrite_Routines.c,36 :: 		short int read_ZIGBEE_short(short int address) {
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; address end address is: 0 (R0)
; address start address is: 0 (R0)
;ReadWrite_Routines.c,37 :: 		short int data_r = 0, dummy_data_r = 0;
; dummy_data_r start address is: 16 (R4)
MOVS	R4, #0
SXTB	R4, R4
;ReadWrite_Routines.c,39 :: 		CS = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(CS+0)
MOVT	R1, #hi_addr(CS+0)
STR	R2, [R1, #0]
;ReadWrite_Routines.c,41 :: 		address = (address << 1) & 0b01111110;      // calculating addressing mode
LSLS	R1, R0, #1
SXTH	R1, R1
; address end address is: 0 (R0)
AND	R1, R1, #126
;ReadWrite_Routines.c,42 :: 		SPI3_Write(address);                        // addressing register
SXTB	R0, R1
UXTH	R0, R0
BL	_SPI3_Write+0
;ReadWrite_Routines.c,43 :: 		data_r = SPI3_Read(dummy_data_r);           // read data from register
SXTB	R0, R4
UXTH	R0, R0
; dummy_data_r end address is: 16 (R4)
BL	_SPI3_Read+0
;ReadWrite_Routines.c,45 :: 		CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(CS+0)
MOVT	R1, #hi_addr(CS+0)
STR	R2, [R1, #0]
;ReadWrite_Routines.c,46 :: 		return data_r;
SXTB	R0, R0
;ReadWrite_Routines.c,47 :: 		}
L_end_read_ZIGBEE_short:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_ZIGBEE_short
_write_ZIGBEE_long:
;ReadWrite_Routines.c,53 :: 		void write_ZIGBEE_long(int address, short int data_r) {
; data_r start address is: 4 (R1)
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTB	R4, R1
; data_r end address is: 4 (R1)
; address end address is: 0 (R0)
; address start address is: 0 (R0)
; data_r start address is: 16 (R4)
;ReadWrite_Routines.c,54 :: 		short int address_high = 0, address_low = 0;
;ReadWrite_Routines.c,56 :: 		CS = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(CS+0)
MOVT	R2, #hi_addr(CS+0)
STR	R3, [R2, #0]
;ReadWrite_Routines.c,58 :: 		address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
ASRS	R2, R0, #3
SXTB	R2, R2
AND	R2, R2, #127
SXTB	R2, R2
ORR	R3, R2, #128
;ReadWrite_Routines.c,59 :: 		address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
LSLS	R2, R0, #5
; address end address is: 0 (R0)
SXTB	R2, R2
AND	R2, R2, #224
SXTH	R2, R2
ORR	R2, R2, #16
; address_low start address is: 20 (R5)
SXTB	R5, R2
;ReadWrite_Routines.c,60 :: 		SPI3_Write(address_high);           // addressing register
SXTB	R0, R3
UXTH	R0, R0
BL	_SPI3_Write+0
;ReadWrite_Routines.c,61 :: 		SPI3_Write(address_low);            // addressing register
SXTB	R0, R5
UXTH	R0, R0
; address_low end address is: 20 (R5)
BL	_SPI3_Write+0
;ReadWrite_Routines.c,62 :: 		SPI3_Write(data_r);                 // write data in registerr
SXTB	R0, R4
UXTH	R0, R0
; data_r end address is: 16 (R4)
BL	_SPI3_Write+0
;ReadWrite_Routines.c,64 :: 		CS = 1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(CS+0)
MOVT	R2, #hi_addr(CS+0)
STR	R3, [R2, #0]
;ReadWrite_Routines.c,65 :: 		}
L_end_write_ZIGBEE_long:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_ZIGBEE_long
_read_ZIGBEE_long:
;ReadWrite_Routines.c,68 :: 		short int read_ZIGBEE_long(int address) {
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; address end address is: 0 (R0)
; address start address is: 0 (R0)
;ReadWrite_Routines.c,69 :: 		short int data_r = 0, dummy_data_r = 0;
; dummy_data_r start address is: 16 (R4)
MOVS	R4, #0
SXTB	R4, R4
;ReadWrite_Routines.c,70 :: 		short int address_high = 0, address_low = 0;
;ReadWrite_Routines.c,72 :: 		CS = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(CS+0)
MOVT	R1, #hi_addr(CS+0)
STR	R2, [R1, #0]
;ReadWrite_Routines.c,74 :: 		address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
ASRS	R1, R0, #3
SXTB	R1, R1
AND	R1, R1, #127
SXTB	R1, R1
ORR	R2, R1, #128
;ReadWrite_Routines.c,75 :: 		address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
LSLS	R1, R0, #5
; address end address is: 0 (R0)
SXTB	R1, R1
AND	R1, R1, #224
; address_low start address is: 20 (R5)
SXTB	R5, R1
;ReadWrite_Routines.c,76 :: 		SPI3_Write(address_high);            // addressing register
SXTB	R0, R2
UXTH	R0, R0
BL	_SPI3_Write+0
;ReadWrite_Routines.c,77 :: 		SPI3_Write(address_low);             // addressing register
SXTB	R0, R5
UXTH	R0, R0
; address_low end address is: 20 (R5)
BL	_SPI3_Write+0
;ReadWrite_Routines.c,78 :: 		data_r = SPI3_Read(dummy_data_r);    // read data from register
SXTB	R0, R4
UXTH	R0, R0
; dummy_data_r end address is: 16 (R4)
BL	_SPI3_Read+0
;ReadWrite_Routines.c,80 :: 		CS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(CS+0)
MOVT	R1, #hi_addr(CS+0)
STR	R2, [R1, #0]
;ReadWrite_Routines.c,81 :: 		return data_r;
SXTB	R0, R0
;ReadWrite_Routines.c,82 :: 		}
L_end_read_ZIGBEE_long:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_ZIGBEE_long
_start_transmit:
;ReadWrite_Routines.c,87 :: 		void start_transmit() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;ReadWrite_Routines.c,88 :: 		short int temp = 0;
;ReadWrite_Routines.c,90 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;ReadWrite_Routines.c,91 :: 		temp = temp | 0x01;                     // mask for start transmit
ORR	R0, R0, #1
;ReadWrite_Routines.c,92 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;ReadWrite_Routines.c,93 :: 		}
L_end_start_transmit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _start_transmit
_read_RX_FIFO:
;ReadWrite_Routines.c,98 :: 		void read_RX_FIFO() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;ReadWrite_Routines.c,99 :: 		unsigned short int temp = 0;
;ReadWrite_Routines.c,100 :: 		int i = 0;
;ReadWrite_Routines.c,102 :: 		temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
MOVS	R0, #57
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;ReadWrite_Routines.c,103 :: 		temp = temp | 0x04;                    // mask for disable receiving packets
UXTB	R0, R0
ORR	R0, R0, #4
;ReadWrite_Routines.c,104 :: 		write_ZIGBEE_short(BBREG1, temp);
SXTB	R1, R0
MOVS	R0, #57
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;ReadWrite_Routines.c,106 :: 		for(i=0; i<128; i++) {
; i start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
; i end address is: 24 (R6)
L_read_RX_FIFO0:
; i start address is: 24 (R6)
CMP	R6, #128
IT	GE
BGE	L_read_RX_FIFO1
;ReadWrite_Routines.c,107 :: 		if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
CMP	R6, #17
IT	GE
BGE	L_read_RX_FIFO3
;ReadWrite_Routines.c,108 :: 		data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
MOVW	R0, #lo_addr(_data_RX_FIFO+0)
MOVT	R0, #hi_addr(_data_RX_FIFO+0)
ADDS	R0, R0, R6
STR	R0, [SP, #4]
MOVW	R0, #lo_addr(_address_RX_FIFO+0)
MOVT	R0, #hi_addr(_address_RX_FIFO+0)
LDRSH	R0, [R0, #0]
ADDS	R0, R0, R6
BL	_read_ZIGBEE_long+0
LDR	R1, [SP, #4]
STRB	R0, [R1, #0]
L_read_RX_FIFO3:
;ReadWrite_Routines.c,109 :: 		if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
CMP	R6, #17
IT	LT
BLT	L_read_RX_FIFO4
;ReadWrite_Routines.c,110 :: 		lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
MOVW	R0, #lo_addr(_address_RX_FIFO+0)
MOVT	R0, #hi_addr(_address_RX_FIFO+0)
LDRSH	R0, [R0, #0]
ADDS	R0, R0, R6
BL	_read_ZIGBEE_long+0
MOVW	R1, #lo_addr(_lost_data+0)
MOVT	R1, #hi_addr(_lost_data+0)
STRB	R0, [R1, #0]
L_read_RX_FIFO4:
;ReadWrite_Routines.c,106 :: 		for(i=0; i<128; i++) {
ADDS	R6, R6, #1
SXTH	R6, R6
;ReadWrite_Routines.c,111 :: 		}
; i end address is: 24 (R6)
IT	AL
BAL	L_read_RX_FIFO0
L_read_RX_FIFO1:
;ReadWrite_Routines.c,113 :: 		DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
MOVW	R0, #lo_addr(_data_RX_FIFO+12)
MOVT	R0, #hi_addr(_data_RX_FIFO+12)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,114 :: 		DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];               // coping valid data
MOVW	R0, #lo_addr(_data_RX_FIFO+13)
MOVT	R0, #hi_addr(_data_RX_FIFO+13)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,115 :: 		DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];               // coping valid data
MOVW	R0, #lo_addr(_data_RX_FIFO+14)
MOVT	R0, #hi_addr(_data_RX_FIFO+14)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,116 :: 		LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
MOVW	R0, #lo_addr(_data_RX_FIFO+15)
MOVT	R0, #hi_addr(_data_RX_FIFO+15)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_LQI+0)
MOVT	R0, #hi_addr(_LQI+0)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,117 :: 		RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data
MOVW	R0, #lo_addr(_data_RX_FIFO+16)
MOVT	R0, #hi_addr(_data_RX_FIFO+16)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_RSSI2+0)
MOVT	R0, #hi_addr(_RSSI2+0)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,119 :: 		temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
MOVS	R0, #57
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;ReadWrite_Routines.c,120 :: 		temp = temp & (!0x04);                 // mask for enable receiving
UXTB	R0, R0
AND	R0, R0, #0
;ReadWrite_Routines.c,121 :: 		write_ZIGBEE_short(BBREG1, temp);
SXTB	R1, R0
MOVS	R0, #57
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;ReadWrite_Routines.c,122 :: 		}
L_end_read_RX_FIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _read_RX_FIFO
_write_TX_normal_FIFO:
;ReadWrite_Routines.c,124 :: 		void write_TX_normal_FIFO() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;ReadWrite_Routines.c,125 :: 		int i = 0;
;ReadWrite_Routines.c,127 :: 		data_TX_normal_FIFO[0]  = HEADER_LENGHT;
MOVS	R1, #11
SXTB	R1, R1
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+0)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+0)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,128 :: 		data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
MOVS	R1, #12
SXTB	R1, R1
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+1)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+1)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,129 :: 		data_TX_normal_FIFO[2]  = 0x01;                        // control frame
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+2)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+2)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,130 :: 		data_TX_normal_FIFO[3]  = 0x88;
MOVS	R1, #136
SXTB	R1, R1
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+3)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+3)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,131 :: 		data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
MOVW	R0, #lo_addr(_SEQ_NUMBER+0)
MOVT	R0, #hi_addr(_SEQ_NUMBER+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+4)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+4)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,132 :: 		data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
MOVW	R0, #lo_addr(_PAN_ID_2+1)
MOVT	R0, #hi_addr(_PAN_ID_2+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+5)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+5)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,133 :: 		data_TX_normal_FIFO[6]  = PAN_ID_2[0];
MOVW	R0, #lo_addr(_PAN_ID_2+0)
MOVT	R0, #hi_addr(_PAN_ID_2+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+6)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+6)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,134 :: 		data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
MOVW	R0, #lo_addr(_ADDRESS_short_2+0)
MOVT	R0, #hi_addr(_ADDRESS_short_2+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+7)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+7)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,135 :: 		data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
MOVW	R0, #lo_addr(_ADDRESS_short_2+1)
MOVT	R0, #hi_addr(_ADDRESS_short_2+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+8)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+8)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,136 :: 		data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
MOVW	R0, #lo_addr(_PAN_ID_1+0)
MOVT	R0, #hi_addr(_PAN_ID_1+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+9)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+9)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,137 :: 		data_TX_normal_FIFO[10] = PAN_ID_1[1];
MOVW	R0, #lo_addr(_PAN_ID_1+1)
MOVT	R0, #hi_addr(_PAN_ID_1+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+10)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+10)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,138 :: 		data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
MOVW	R0, #lo_addr(_ADDRESS_short_1+0)
MOVT	R0, #hi_addr(_ADDRESS_short_1+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+11)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+11)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,139 :: 		data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
MOVW	R0, #lo_addr(_ADDRESS_short_1+1)
MOVT	R0, #hi_addr(_ADDRESS_short_1+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+12)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+12)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,140 :: 		data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+13)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+13)
STRB	R1, [R0, #0]
;ReadWrite_Routines.c,142 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
; i start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
; i end address is: 24 (R6)
L_write_TX_normal_FIFO5:
; i start address is: 24 (R6)
CMP	R6, #14
IT	GE
BGE	L_write_TX_normal_FIFO6
;ReadWrite_Routines.c,143 :: 		write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
MOVW	R0, #lo_addr(_data_TX_normal_FIFO+0)
MOVT	R0, #hi_addr(_data_TX_normal_FIFO+0)
ADDS	R0, R0, R6
LDRSB	R0, [R0, #0]
SXTB	R1, R0
MOVW	R0, #lo_addr(_address_TX_normal_FIFO+0)
MOVT	R0, #hi_addr(_address_TX_normal_FIFO+0)
LDRSH	R0, [R0, #0]
ADDS	R0, R0, R6
BL	_write_ZIGBEE_long+0
;ReadWrite_Routines.c,142 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
ADDS	R6, R6, #1
SXTH	R6, R6
;ReadWrite_Routines.c,144 :: 		}
; i end address is: 24 (R6)
IT	AL
BAL	L_write_TX_normal_FIFO5
L_write_TX_normal_FIFO6:
;ReadWrite_Routines.c,146 :: 		set_not_ACK();
BL	_set_not_ACK+0
;ReadWrite_Routines.c,147 :: 		set_not_encrypt();
BL	_set_not_encrypt+0
;ReadWrite_Routines.c,148 :: 		start_transmit();
BL	_start_transmit+0
;ReadWrite_Routines.c,149 :: 		}
L_end_write_TX_normal_FIFO:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_TX_normal_FIFO
