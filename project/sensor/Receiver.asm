_DrawFrame:
;Receiver.c,67 :: 		void DrawFrame(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Receiver.c,68 :: 		TFT_Init_ILI9341_8bit(320,240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Receiver.c,69 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Receiver.c,70 :: 		TFT_Set_Pen(CL_BLACK, 1);
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;Receiver.c,71 :: 		TFT_Line(20, 220, 300, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Receiver.c,72 :: 		TFT_LIne(20,  46, 300,  46);
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Receiver.c,73 :: 		TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;Receiver.c,74 :: 		TFT_Write_Text("BEE  Click  Board  Demo", 50, 14);
MOVW	R0, #lo_addr(?lstr1_Receiver+0)
MOVT	R0, #hi_addr(?lstr1_Receiver+0)
MOVS	R2, #14
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Receiver.c,75 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Receiver.c,76 :: 		TFT_Write_Text("EasyMx PRO v7", 19, 223);
MOVW	R0, #lo_addr(?lstr2_Receiver+0)
MOVT	R0, #hi_addr(?lstr2_Receiver+0)
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;Receiver.c,77 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Receiver.c,78 :: 		TFT_Write_Text("www.mikroe.com", 200, 223);
MOVW	R0, #lo_addr(?lstr3_Receiver+0)
MOVT	R0, #hi_addr(?lstr3_Receiver+0)
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;Receiver.c,79 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,80 :: 		TFT_Write_Text("Received data : ", 90, 80);
MOVW	R0, #lo_addr(?lstr4_Receiver+0)
MOVT	R0, #hi_addr(?lstr4_Receiver+0)
MOVS	R2, #80
MOVS	R1, #90
BL	_TFT_Write_Text+0
;Receiver.c,81 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_read:
;Receiver.c,83 :: 		void read() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Receiver.c,85 :: 		if(Debounce_INT() == 0 ){
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_read0
;Receiver.c,87 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Receiver.c,88 :: 		read_RX_FIFO();
BL	_read_RX_FIFO+0
;Receiver.c,91 :: 		if (data_RX_FIFO[7] != MY_ADDR) {
MOVW	R0, #lo_addr(_data_RX_FIFO+7)
MOVT	R0, #hi_addr(_data_RX_FIFO+7)
LDRSB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_read1
;Receiver.c,92 :: 		delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_read2:
SUBS	R7, R7, #1
BNE	L_read2
NOP
NOP
NOP
;Receiver.c,93 :: 		return; // Ignore messages that aren't meant for me
IT	AL
BAL	L_end_read
;Receiver.c,94 :: 		}
L_read1:
;Receiver.c,96 :: 		ByteToStr(data_RX_FIFO[11], &txt);         // Convert third byte to string
MOVW	R0, #lo_addr(_data_RX_FIFO+11)
MOVT	R0, #hi_addr(_data_RX_FIFO+11)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Receiver.c,97 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,98 :: 		TFT_Write_Text(txt, 195, 80);       // Display string on TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Receiver.c,100 :: 		delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_read4:
SUBS	R7, R7, #1
BNE	L_read4
NOP
NOP
NOP
;Receiver.c,101 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,102 :: 		TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Receiver.c,104 :: 		switch (DATA_RX[0]) {
IT	AL
BAL	L_read6
;Receiver.c,105 :: 		case MSG_TYPE_HB:
L_read8:
;Receiver.c,106 :: 		break;
IT	AL
BAL	L_read7
;Receiver.c,107 :: 		case MSG_TYPE_CW:
L_read9:
;Receiver.c,108 :: 		worker_addr = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_worker_addr+0)
MOVT	R0, #hi_addr(_worker_addr+0)
STRB	R1, [R0, #0]
;Receiver.c,109 :: 		break;
IT	AL
BAL	L_read7
;Receiver.c,110 :: 		case MSG_TYPE_FW:
L_read10:
;Receiver.c,111 :: 		break;
IT	AL
BAL	L_read7
;Receiver.c,112 :: 		case MSG_TYPE_ACK:
L_read11:
;Receiver.c,113 :: 		job_done = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_job_done+0)
MOVT	R0, #hi_addr(_job_done+0)
STRB	R1, [R0, #0]
;Receiver.c,114 :: 		break;
IT	AL
BAL	L_read7
;Receiver.c,115 :: 		}
L_read6:
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_read8
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_read9
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_read10
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_read11
L_read7:
;Receiver.c,117 :: 		}
L_read0:
;Receiver.c,118 :: 		delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_read12:
SUBS	R7, R7, #1
BNE	L_read12
NOP
NOP
NOP
;Receiver.c,119 :: 		}
L_end_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read
_do_work:
;Receiver.c,121 :: 		void do_work() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Receiver.c,122 :: 		int time = MAX_WAIT_TIME;
MOVW	R0, #3000
STRH	R0, [SP, #4]
MOVW	R0, #0
STRH	R0, [SP, #6]
;Receiver.c,123 :: 		int retries = 0;
;Receiver.c,124 :: 		job_done = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_job_done+0)
MOVT	R0, #hi_addr(_job_done+0)
STRB	R1, [R0, #0]
;Receiver.c,126 :: 		while (!job_done) { // This might make a problem
L_do_work14:
MOVW	R0, #lo_addr(_job_done+0)
MOVT	R0, #hi_addr(_job_done+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_do_work15
;Receiver.c,127 :: 		if (time >= MAX_WAIT_TIME) {
LDRSH	R1, [SP, #4]
MOVW	R0, #3000
CMP	R1, R0
IT	LT
BLT	L_do_work16
;Receiver.c,129 :: 		worker_addr = -1;
MOVS	R1, #-1
SXTB	R1, R1
MOVW	R0, #lo_addr(_worker_addr+0)
MOVT	R0, #hi_addr(_worker_addr+0)
STRB	R1, [R0, #0]
;Receiver.c,131 :: 		while (worker_addr == -1) {
L_do_work17:
MOVW	R0, #lo_addr(_worker_addr+0)
MOVT	R0, #hi_addr(_worker_addr+0)
LDRSB	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L_do_work18
;Receiver.c,132 :: 		retries = 0;
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #6]
;Receiver.c,133 :: 		DATA_TX[0] = MSG_TYPE_CW;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Receiver.c,135 :: 		ADDRESS_short_2[0] = INTERFACE_ADDR;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_ADDRESS_short_2+0)
MOVT	R0, #hi_addr(_ADDRESS_short_2+0)
STRB	R1, [R0, #0]
;Receiver.c,136 :: 		ADDRESS_short_2[1] = INTERFACE_ADDR;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_ADDRESS_short_2+1)
MOVT	R0, #hi_addr(_ADDRESS_short_2+1)
STRB	R1, [R0, #0]
;Receiver.c,138 :: 		write_TX_normal_FIFO();
BL	_write_TX_normal_FIFO+0
;Receiver.c,139 :: 		while (worker_addr == -1 && retries < 5) {
L_do_work19:
MOVW	R0, #lo_addr(_worker_addr+0)
MOVT	R0, #hi_addr(_worker_addr+0)
LDRSB	R0, [R0, #0]
CMP	R0, #-1
IT	NE
BNE	L__do_work39
LDRSH	R0, [SP, #6]
CMP	R0, #5
IT	GE
BGE	L__do_work38
L__do_work37:
;Receiver.c,140 :: 		read();
BL	_read+0
;Receiver.c,141 :: 		retries++;
LDRSH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;Receiver.c,142 :: 		}
IT	AL
BAL	L_do_work19
;Receiver.c,139 :: 		while (worker_addr == -1 && retries < 5) {
L__do_work39:
L__do_work38:
;Receiver.c,143 :: 		}
IT	AL
BAL	L_do_work17
L_do_work18:
;Receiver.c,144 :: 		}
L_do_work16:
;Receiver.c,146 :: 		DATA_TX[0] = MSG_TYPE_CW;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Receiver.c,147 :: 		DATA_TX[1] = numer++;
MOVW	R2, #lo_addr(_numer+0)
MOVT	R2, #hi_addr(_numer+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;Receiver.c,149 :: 		ADDRESS_short_2[0] = worker_addr;
MOVW	R2, #lo_addr(_worker_addr+0)
MOVT	R2, #hi_addr(_worker_addr+0)
LDRSB	R1, [R2, #0]
MOVW	R0, #lo_addr(_ADDRESS_short_2+0)
MOVT	R0, #hi_addr(_ADDRESS_short_2+0)
STRB	R1, [R0, #0]
;Receiver.c,150 :: 		ADDRESS_short_2[1] = worker_addr;
MOV	R0, R2
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ADDRESS_short_2+1)
MOVT	R0, #hi_addr(_ADDRESS_short_2+1)
STRB	R1, [R0, #0]
;Receiver.c,152 :: 		write_TX_normal_FIFO();
BL	_write_TX_normal_FIFO+0
;Receiver.c,153 :: 		while (!job_done && retries < 30) {
L_do_work23:
MOVW	R0, #lo_addr(_job_done+0)
MOVT	R0, #hi_addr(_job_done+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__do_work41
LDRSH	R0, [SP, #6]
CMP	R0, #30
IT	GE
BGE	L__do_work40
L__do_work36:
;Receiver.c,154 :: 		read();
BL	_read+0
;Receiver.c,155 :: 		retries++;
LDRSH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;Receiver.c,156 :: 		}
IT	AL
BAL	L_do_work23
;Receiver.c,153 :: 		while (!job_done && retries < 30) {
L__do_work41:
L__do_work40:
;Receiver.c,157 :: 		time = MAX_WAIT_TIME;
MOVW	R0, #3000
SXTH	R0, R0
STRH	R0, [SP, #4]
;Receiver.c,158 :: 		}
IT	AL
BAL	L_do_work14
L_do_work15:
;Receiver.c,161 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,162 :: 		TFT_Write_Text("JOB DONE", 195, 80);       // Display string on TFT
MOVW	R0, #lo_addr(?lstr5_Receiver+0)
MOVT	R0, #hi_addr(?lstr5_Receiver+0)
MOVS	R2, #80
MOVS	R1, #195
BL	_TFT_Write_Text+0
;Receiver.c,164 :: 		delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_do_work27:
SUBS	R7, R7, #1
BNE	L_do_work27
NOP
NOP
NOP
;Receiver.c,165 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,166 :: 		TFT_Write_Text("JOB DONE", 195, 80);       // Delete string from TFT
MOVW	R0, #lo_addr(?lstr6_Receiver+0)
MOVT	R0, #hi_addr(?lstr6_Receiver+0)
MOVS	R2, #80
MOVS	R1, #195
BL	_TFT_Write_Text+0
;Receiver.c,167 :: 		}
L_end_do_work:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _do_work
_main:
;Receiver.c,169 :: 		void main() {
SUB	SP, SP, #4
;Receiver.c,171 :: 		numer = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_numer+0)
MOVT	R0, #hi_addr(_numer+0)
STRH	R1, [R0, #0]
;Receiver.c,173 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0);         // Set PA0 as digital input
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;Receiver.c,174 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Receiver.c,176 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Receiver.c,177 :: 		DrawFrame();
BL	_DrawFrame+0
;Receiver.c,179 :: 		oldstate = 0;
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #0]
;Receiver.c,181 :: 		do {
L_main29:
;Receiver.c,182 :: 		if (Button(&GPIOA_IDR, 0, 1, 1))                      // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main32
;Receiver.c,183 :: 		oldstate = 1;
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [SP, #0]
L_main32:
;Receiver.c,184 :: 		if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {        // detect one-to-zero transition on PA0 pin
LDRSH	R0, [SP, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main44
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main43
L__main42:
;Receiver.c,185 :: 		oldstate = 0;
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #0]
;Receiver.c,187 :: 		do_work();
BL	_do_work+0
;Receiver.c,184 :: 		if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {        // detect one-to-zero transition on PA0 pin
L__main44:
L__main43:
;Receiver.c,189 :: 		} while(1);
IT	AL
BAL	L_main29
;Receiver.c,190 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
