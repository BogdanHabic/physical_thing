_USB0Interrupt:
;screen.c,65 :: 		void USB0Interrupt() iv IVT_INT_OTG_FS{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,66 :: 		USB_Interrupt_Proc();
BL	_USB_Interrupt_Proc+0
;screen.c,67 :: 		}
L_end_USB0Interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB0Interrupt
_delay10ms:
;screen.c,69 :: 		void delay10ms() {
;screen.c,70 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_delay10ms0:
SUBS	R7, R7, #1
BNE	L_delay10ms0
NOP
NOP
NOP
;screen.c,71 :: 		}
L_end_delay10ms:
BX	LR
; end of _delay10ms
_shift_timers:
;screen.c,73 :: 		void shift_timers(int keep_curr) {
; keep_curr start address is: 0 (R0)
; keep_curr end address is: 0 (R0)
; keep_curr start address is: 0 (R0)
;screen.c,75 :: 		t = times[0];
MOVW	R1, #lo_addr(_times+0)
MOVT	R1, #hi_addr(_times+0)
; t start address is: 16 (R4)
LDRSH	R4, [R1, #0]
;screen.c,77 :: 		for(i = 1; i < COUNTERS; i++) {
; i start address is: 12 (R3)
MOVS	R3, #1
SXTH	R3, R3
; keep_curr end address is: 0 (R0)
; t end address is: 16 (R4)
; i end address is: 12 (R3)
L_shift_timers2:
; i start address is: 12 (R3)
; t start address is: 16 (R4)
; keep_curr start address is: 0 (R0)
CMP	R3, #4
IT	GE
BGE	L_shift_timers3
;screen.c,78 :: 		temp = times[i];
LSLS	R2, R3, #1
MOVW	R1, #lo_addr(_times+0)
MOVT	R1, #hi_addr(_times+0)
ADDS	R2, R1, R2
LDRSH	R1, [R2, #0]
; temp start address is: 4 (R1)
;screen.c,79 :: 		times[i] = t;
STRH	R4, [R2, #0]
;screen.c,80 :: 		t = temp;
SXTH	R4, R1
; temp end address is: 4 (R1)
;screen.c,77 :: 		for(i = 1; i < COUNTERS; i++) {
ADDS	R3, R3, #1
SXTH	R3, R3
;screen.c,81 :: 		}
; t end address is: 16 (R4)
; i end address is: 12 (R3)
IT	AL
BAL	L_shift_timers2
L_shift_timers3:
;screen.c,83 :: 		if (!keep_curr) {
CMP	R0, #0
IT	NE
BNE	L_shift_timers5
; keep_curr end address is: 0 (R0)
;screen.c,84 :: 		times[0] = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_times+0)
MOVT	R1, #hi_addr(_times+0)
STRH	R2, [R1, #0]
;screen.c,85 :: 		}
L_shift_timers5:
;screen.c,87 :: 		timers_shifted = 1;
MOVS	R2, #1
SXTH	R2, R2
MOVW	R1, #lo_addr(_timers_shifted+0)
MOVT	R1, #hi_addr(_timers_shifted+0)
STRH	R2, [R1, #0]
;screen.c,88 :: 		}
L_end_shift_timers:
BX	LR
; end of _shift_timers
_print_timers:
;screen.c,90 :: 		void print_timers() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;screen.c,92 :: 		int pos_y = INITIAL_POS_Y;
MOVW	R0, #30
STRH	R0, [SP, #16]
;screen.c,95 :: 		if(timers_shifted) {
MOVW	R0, #lo_addr(_timers_shifted+0)
MOVT	R0, #hi_addr(_timers_shifted+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_print_timers6
;screen.c,96 :: 		TFT_Fill_Screen(CL_AQUA); // Clear TFT
MOVW	R0, #4095
BL	_TFT_Fill_Screen+0
;screen.c,97 :: 		timers_shifted = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_timers_shifted+0)
MOVT	R0, #hi_addr(_timers_shifted+0)
STRH	R1, [R0, #0]
;screen.c,98 :: 		}
L_print_timers6:
;screen.c,100 :: 		TFT_Rectangle(20, 30, 219, 50);
MOVS	R3, #50
SXTH	R3, R3
MOVS	R2, #219
SXTH	R2, R2
MOVS	R1, #30
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Rectangle+0
;screen.c,102 :: 		for(i = 0; i < COUNTERS; i++) {
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #4]
L_print_timers7:
LDRSH	R0, [SP, #4]
CMP	R0, #4
IT	GE
BGE	L_print_timers8
;screen.c,103 :: 		temp = times[i];
LDRSH	R0, [SP, #4]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_times+0)
MOVT	R0, #hi_addr(_times+0)
ADDS	R0, R0, R1
LDRSH	R1, [R0, #0]
;screen.c,105 :: 		h = temp / 3600;
MOVW	R0, #3600
SXTH	R0, R0
SDIV	R5, R1, R0
;screen.c,106 :: 		temp %= 3600;
MOVW	R0, #3600
SXTH	R0, R0
SDIV	R3, R1, R0
MLS	R3, R0, R3, R1
SXTH	R3, R3
;screen.c,108 :: 		m = temp / 60;
MOVS	R0, #60
SXTH	R0, R0
SDIV	R2, R3, R0
;screen.c,109 :: 		temp %= 60;
MOVS	R1, #60
SXTH	R1, R1
SDIV	R0, R3, R1
MLS	R0, R1, R0, R3
;screen.c,113 :: 		sprintf(str, "%02d:%02d:%02d", h, m, s);
SXTH	R4, R0
SXTH	R3, R2
SXTH	R2, R5
MOVW	R1, #lo_addr(?lstr_1_screen+0)
MOVT	R1, #hi_addr(?lstr_1_screen+0)
ADD	R0, SP, #6
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #20
;screen.c,114 :: 		TFT_Write_Text(str, INITIAL_POS_X, pos_y);
ADD	R0, SP, #6
LDRSH	R2, [SP, #16]
MOVS	R1, #32
BL	_TFT_Write_Text+0
;screen.c,115 :: 		delay10ms();
BL	_delay10ms+0
;screen.c,116 :: 		pos_y += 20;
LDRSH	R0, [SP, #16]
ADDS	R0, #20
STRH	R0, [SP, #16]
;screen.c,102 :: 		for(i = 0; i < COUNTERS; i++) {
LDRSH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;screen.c,117 :: 		}
IT	AL
BAL	L_print_timers7
L_print_timers8:
;screen.c,118 :: 		}
L_end_print_timers:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _print_timers
_Initialize:
;screen.c,120 :: 		void Initialize() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,122 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0); // Set PA0 as start
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;screen.c,123 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6); // Set PA6 as lap
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;screen.c,124 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_4); // Set PD4 as reset
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;screen.c,125 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_5); // Set PA5 as pause
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;screen.c,126 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_4); // Set PA4 as save
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;screen.c,128 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;screen.c,129 :: 		TFT_Set_Pen(CL_AQUA, 3);
MOVS	R1, #3
MOVW	R0, #4095
BL	_TFT_Set_Pen+0
;screen.c,130 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;screen.c,131 :: 		TFT_Fill_Screen(CL_AQUA);
MOVW	R0, #4095
BL	_TFT_Fill_Screen+0
;screen.c,132 :: 		TFT_Set_Brush(1, CL_BLACK, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
MOVW	R1, #4095
MOVW	R0, #4095
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #0
MOVW	R1, #0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;screen.c,134 :: 		HID_Enable(&readbuff,&writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;screen.c,136 :: 		for(i = 0; i < COUNTERS; i++) {
; i start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
; i end address is: 8 (R2)
L_Initialize10:
; i start address is: 8 (R2)
CMP	R2, #4
IT	GE
BGE	L_Initialize11
;screen.c,137 :: 		times[i] = 0;
LSLS	R1, R2, #1
MOVW	R0, #lo_addr(_times+0)
MOVT	R0, #hi_addr(_times+0)
ADDS	R1, R0, R1
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [R1, #0]
;screen.c,136 :: 		for(i = 0; i < COUNTERS; i++) {
ADDS	R2, R2, #1
SXTH	R2, R2
;screen.c,138 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_Initialize10
L_Initialize11:
;screen.c,140 :: 		print_timers();
BL	_print_timers+0
;screen.c,141 :: 		}
L_end_Initialize:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Initialize
_check_start:
;screen.c,143 :: 		int check_start() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,145 :: 		if (prev_b == B_START) {
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_check_start13
;screen.c,146 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_check_start
;screen.c,147 :: 		}
L_check_start13:
;screen.c,149 :: 		val = Button(&GPIOA_IDR, 0, 1, 1);
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
; val start address is: 8 (R2)
SXTH	R2, R0
;screen.c,150 :: 		if(val) prev_b = B_START;
SXTH	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_check_start14
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
STRH	R1, [R0, #0]
L_check_start14:
;screen.c,152 :: 		return val;
SXTH	R0, R2
; val end address is: 8 (R2)
;screen.c,153 :: 		}
L_end_check_start:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_start
_check_lap:
;screen.c,155 :: 		int check_lap() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,157 :: 		if (prev_b == B_LAP) {
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_check_lap15
;screen.c,158 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_check_lap
;screen.c,159 :: 		}
L_check_lap15:
;screen.c,161 :: 		val = Button(&GPIOA_IDR, 6, 1, 1);
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #6
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
; val start address is: 8 (R2)
SXTH	R2, R0
;screen.c,162 :: 		if(val) prev_b = B_LAP;
SXTH	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_check_lap16
MOVS	R1, #2
SXTH	R1, R1
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
STRH	R1, [R0, #0]
L_check_lap16:
;screen.c,164 :: 		return val;
SXTH	R0, R2
; val end address is: 8 (R2)
;screen.c,165 :: 		}
L_end_check_lap:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_lap
_check_reset:
;screen.c,167 :: 		int check_reset() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,169 :: 		if (prev_b == B_RESET) {
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_check_reset17
;screen.c,170 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_check_reset
;screen.c,171 :: 		}
L_check_reset17:
;screen.c,173 :: 		val = Button(&GPIOD_IDR, 4, 1, 1);
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
; val start address is: 8 (R2)
SXTH	R2, R0
;screen.c,174 :: 		if(val) prev_b = B_RESET;
SXTH	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_check_reset18
MOVS	R1, #3
SXTH	R1, R1
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
STRH	R1, [R0, #0]
L_check_reset18:
;screen.c,176 :: 		return val;
SXTH	R0, R2
; val end address is: 8 (R2)
;screen.c,177 :: 		}
L_end_check_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_reset
_check_pause:
;screen.c,179 :: 		int check_pause() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,181 :: 		if (prev_b == B_PAUSE) {
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
LDRSH	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_check_pause19
;screen.c,182 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_check_pause
;screen.c,183 :: 		}
L_check_pause19:
;screen.c,185 :: 		val = Button(&GPIOA_IDR, 5, 1, 1);
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
; val start address is: 8 (R2)
SXTH	R2, R0
;screen.c,186 :: 		if(val) prev_b = B_PAUSE;
SXTH	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_check_pause20
MOVS	R1, #4
SXTH	R1, R1
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
STRH	R1, [R0, #0]
L_check_pause20:
;screen.c,188 :: 		return val;
SXTH	R0, R2
; val end address is: 8 (R2)
;screen.c,189 :: 		}
L_end_check_pause:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_pause
_check_save:
;screen.c,191 :: 		int check_save() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,193 :: 		if (prev_b == B_SAVE) {
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
LDRSH	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_check_save21
;screen.c,194 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_check_save
;screen.c,195 :: 		}
L_check_save21:
;screen.c,197 :: 		val = Button(&GPIOA_IDR, 4, 1, 1);
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
; val start address is: 8 (R2)
SXTH	R2, R0
;screen.c,198 :: 		if(val) prev_b = B_SAVE;
SXTH	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_check_save22
MOVS	R1, #5
SXTH	R1, R1
MOVW	R0, #lo_addr(_prev_b+0)
MOVT	R0, #hi_addr(_prev_b+0)
STRH	R1, [R0, #0]
L_check_save22:
;screen.c,200 :: 		return val;
SXTH	R0, R2
; val end address is: 8 (R2)
;screen.c,201 :: 		}
L_end_check_save:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_save
_start_timer:
;screen.c,203 :: 		void start_timer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,204 :: 		writebuff[0] = start_msg[0];
MOVW	R0, #lo_addr(_start_msg+0)
MOVT	R0, #hi_addr(_start_msg+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;screen.c,205 :: 		TFT_Write_Text("START", 100, 100);
MOVW	R0, #lo_addr(?lstr2_screen+0)
MOVT	R0, #hi_addr(?lstr2_screen+0)
MOVS	R2, #100
MOVS	R1, #100
BL	_TFT_Write_Text+0
;screen.c,206 :: 		while(!HID_Write(&writebuff,64)); // Send the message
L_start_timer23:
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
CMP	R0, #0
IT	NE
BNE	L_start_timer24
IT	AL
BAL	L_start_timer23
L_start_timer24:
;screen.c,207 :: 		curr_state = STATE_RUNNING;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
STRH	R1, [R0, #0]
;screen.c,208 :: 		}
L_end_start_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _start_timer
_pause_timer:
;screen.c,210 :: 		void pause_timer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,212 :: 		writebuff[0] = pause_msg[0];
MOVW	R0, #lo_addr(_pause_msg+0)
MOVT	R0, #hi_addr(_pause_msg+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;screen.c,214 :: 		TFT_Write_Text("PAUSE", 120, 120);
MOVW	R0, #lo_addr(?lstr3_screen+0)
MOVT	R0, #hi_addr(?lstr3_screen+0)
MOVS	R2, #120
MOVS	R1, #120
BL	_TFT_Write_Text+0
;screen.c,215 :: 		while(!HID_Write(&writebuff,64));
L_pause_timer25:
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
CMP	R0, #0
IT	NE
BNE	L_pause_timer26
IT	AL
BAL	L_pause_timer25
L_pause_timer26:
;screen.c,216 :: 		curr_state = STATE_PAUSE;
MOVS	R1, #2
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
STRH	R1, [R0, #0]
;screen.c,217 :: 		}
L_end_pause_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _pause_timer
_save_timer:
;screen.c,219 :: 		void save_timer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,220 :: 		shift_timers(1);
MOVS	R0, #1
SXTH	R0, R0
BL	_shift_timers+0
;screen.c,221 :: 		}
L_end_save_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _save_timer
_reset_timer:
;screen.c,223 :: 		void reset_timer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,224 :: 		writebuff[0] = reset_msg[0];
MOVW	R0, #lo_addr(_reset_msg+0)
MOVT	R0, #hi_addr(_reset_msg+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;screen.c,225 :: 		TFT_Write_Text("RESET", 100, 140);
MOVW	R0, #lo_addr(?lstr4_screen+0)
MOVT	R0, #hi_addr(?lstr4_screen+0)
MOVS	R2, #140
MOVS	R1, #100
BL	_TFT_Write_Text+0
;screen.c,226 :: 		while(!HID_Write(&writebuff,64));
L_reset_timer27:
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
CMP	R0, #0
IT	NE
BNE	L_reset_timer28
IT	AL
BAL	L_reset_timer27
L_reset_timer28:
;screen.c,227 :: 		}
L_end_reset_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _reset_timer
_update_time:
;screen.c,229 :: 		void update_time() {
;screen.c,230 :: 		times[0] = readbuff[0];
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_times+0)
MOVT	R0, #hi_addr(_times+0)
STRH	R1, [R0, #0]
;screen.c,231 :: 		}
L_end_update_time:
BX	LR
; end of _update_time
_lap_timer:
;screen.c,233 :: 		void lap_timer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,235 :: 		TFT_Write_Text("LAP", 100, 160);
MOVW	R0, #lo_addr(?lstr5_screen+0)
MOVT	R0, #hi_addr(?lstr5_screen+0)
MOVS	R2, #160
MOVS	R1, #100
BL	_TFT_Write_Text+0
;screen.c,236 :: 		reset_timer();
BL	_reset_timer+0
;screen.c,237 :: 		shift_timers(0);
MOVS	R0, #0
SXTH	R0, R0
BL	_shift_timers+0
;screen.c,238 :: 		start_timer();
BL	_start_timer+0
;screen.c,239 :: 		}
L_end_lap_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _lap_timer
_main:
;screen.c,241 :: 		void main(void) {
;screen.c,243 :: 		Initialize();
BL	_Initialize+0
;screen.c,245 :: 		while (1) {
L_main29:
;screen.c,248 :: 		if (HID_Read()) { // this won't hang because we are using async interrupts
BL	_HID_Read+0
CMP	R0, #0
IT	EQ
BEQ	L_main31
;screen.c,249 :: 		if (curr_state == STATE_RUNNING) {
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main32
;screen.c,251 :: 		update_time(); // check state or drop message
BL	_update_time+0
;screen.c,252 :: 		print_timers();
BL	_print_timers+0
;screen.c,253 :: 		}
L_main32:
;screen.c,254 :: 		} else {
IT	AL
BAL	L_main33
L_main31:
;screen.c,255 :: 		if (curr_state == STATE_RUNNING) {
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main34
;screen.c,256 :: 		if (check_pause()) {
BL	_check_pause+0
CMP	R0, #0
IT	EQ
BEQ	L_main35
;screen.c,257 :: 		pause_timer();
BL	_pause_timer+0
;screen.c,258 :: 		} else if (check_lap()) {
IT	AL
BAL	L_main36
L_main35:
BL	_check_lap+0
CMP	R0, #0
IT	EQ
BEQ	L_main37
;screen.c,259 :: 		lap_timer();
BL	_lap_timer+0
;screen.c,260 :: 		print_timers();
BL	_print_timers+0
;screen.c,261 :: 		} else if (check_save()) {
IT	AL
BAL	L_main38
L_main37:
BL	_check_save+0
CMP	R0, #0
IT	EQ
BEQ	L_main39
;screen.c,262 :: 		save_timer();
BL	_save_timer+0
;screen.c,263 :: 		print_timers();
BL	_print_timers+0
;screen.c,264 :: 		} // Here we can stop, lap, save or pause.
L_main39:
L_main38:
L_main36:
;screen.c,265 :: 		} else if (curr_state == STATE_PAUSE) {
IT	AL
BAL	L_main40
L_main34:
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main41
;screen.c,266 :: 		if (check_start()) {
BL	_check_start+0
CMP	R0, #0
IT	EQ
BEQ	L_main42
;screen.c,267 :: 		start_timer();
BL	_start_timer+0
;screen.c,268 :: 		} else if (check_lap()) {
IT	AL
BAL	L_main43
L_main42:
BL	_check_lap+0
CMP	R0, #0
IT	EQ
BEQ	L_main44
;screen.c,269 :: 		lap_timer();
BL	_lap_timer+0
;screen.c,270 :: 		print_timers();
BL	_print_timers+0
;screen.c,271 :: 		} else if (check_save()) {
IT	AL
BAL	L_main45
L_main44:
BL	_check_save+0
CMP	R0, #0
IT	EQ
BEQ	L_main46
;screen.c,272 :: 		save_timer();
BL	_save_timer+0
;screen.c,273 :: 		print_timers();
BL	_print_timers+0
;screen.c,274 :: 		} else if (check_reset()) {
IT	AL
BAL	L_main47
L_main46:
BL	_check_reset+0
CMP	R0, #0
IT	EQ
BEQ	L_main48
;screen.c,275 :: 		TFT_Write_Text("USAO", 150, 100);
MOVW	R0, #lo_addr(?lstr6_screen+0)
MOVT	R0, #hi_addr(?lstr6_screen+0)
MOVS	R2, #100
MOVS	R1, #150
BL	_TFT_Write_Text+0
;screen.c,276 :: 		reset_timer();
BL	_reset_timer+0
;screen.c,277 :: 		times[0] = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_times+0)
MOVT	R0, #hi_addr(_times+0)
STRH	R1, [R0, #0]
;screen.c,278 :: 		print_timers();
BL	_print_timers+0
;screen.c,279 :: 		}// Here we can start, save
L_main48:
L_main47:
L_main45:
L_main43:
;screen.c,280 :: 		}
L_main41:
L_main40:
;screen.c,281 :: 		}
L_main33:
;screen.c,282 :: 		}
IT	AL
BAL	L_main29
;screen.c,283 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
