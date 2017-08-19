_Init_MCU:
;Joystick.c,40 :: 		void Init_MCU() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Joystick.c,41 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_2 |_GPIO_PINMASK_4);  // Set Up and Left as digital input
MOVS	R1, #20
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Joystick.c,42 :: 		GPIO_Digital_Input(&GPIOB_IDR, _GPIO_PINMASK_5);                    // Set Down as digital input
MOVW	R1, #32
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
BL	_GPIO_Digital_Input+0
;Joystick.c,43 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6);                    // Set Right as digital input
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;Joystick.c,44 :: 		GPIO_Digital_Input(&GPIOC_IDR, _GPIO_PINMASK_13);                   // Set Center as digital input
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
BL	_GPIO_Digital_Input+0
;Joystick.c,46 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Joystick.c,47 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Joystick.c,48 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_main:
;Joystick.c,50 :: 		void main() {
;Joystick.c,52 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_ALL); // Set PORTA as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;Joystick.c,53 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL); // Set PORTB as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Joystick.c,54 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL); // Set PORTC as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Joystick.c,55 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL); // Set PORTD as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;Joystick.c,56 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL); // Set PORTE as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;Joystick.c,58 :: 		GPIOA_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,59 :: 		GPIOB_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,60 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,61 :: 		GPIOD_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,62 :: 		GPIOE_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,64 :: 		oldstate_press = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
STRH	R1, [R0, #0]
;Joystick.c,65 :: 		oldstate_right = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
STRH	R1, [R0, #0]
;Joystick.c,66 :: 		oldstate_left  = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_left+0)
MOVT	R0, #hi_addr(_oldstate_left+0)
STRH	R1, [R0, #0]
;Joystick.c,67 :: 		oldstate_up    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
STRH	R1, [R0, #0]
;Joystick.c,68 :: 		oldstate_down  = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
STRH	R1, [R0, #0]
;Joystick.c,69 :: 		state = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
STRH	R1, [R0, #0]
;Joystick.c,71 :: 		while(1){
L_main0:
;Joystick.c,73 :: 		if (Button(&GPIOC_IDR, 13, 1, 1))                     // detect logical one state
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #13
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main2
;Joystick.c,74 :: 		oldstate_press = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
STRH	R1, [R0, #0]
L_main2:
;Joystick.c,75 :: 		if (oldstate_press && Button(&GPIOC_IDR, 13, 1, 0)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main40
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #13
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main39
L__main38:
;Joystick.c,76 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,77 :: 		TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Joystick.c,78 :: 		TFT_Circle(160, 114, 40);
MOVS	R2, #40
SXTH	R2, R2
MOVS	R1, #114
SXTH	R1, R1
MOVS	R0, #160
SXTH	R0, R0
BL	_TFT_Circle+0
;Joystick.c,79 :: 		TFT_Write_Text("Pressed", 136, 106);
MOVW	R0, #lo_addr(?lstr1_Joystick+0)
MOVT	R0, #hi_addr(?lstr1_Joystick+0)
MOVS	R2, #106
MOVS	R1, #136
BL	_TFT_Write_Text+0
;Joystick.c,80 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
;Joystick.c,81 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,82 :: 		oldstate_press = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
STRH	R1, [R0, #0]
;Joystick.c,83 :: 		state = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
STRH	R1, [R0, #0]
;Joystick.c,75 :: 		if (oldstate_press && Button(&GPIOC_IDR, 13, 1, 0)) { // detect logical one to logical zero transition
L__main40:
L__main39:
;Joystick.c,86 :: 		if (Button(&GPIOA_IDR, 6, 1, 1))                     // detect logical one state
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #6
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main8
;Joystick.c,87 :: 		oldstate_right = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
STRH	R1, [R0, #0]
L_main8:
;Joystick.c,88 :: 		if (oldstate_right && Button(&GPIOA_IDR, 6, 1, 0)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main42
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #6
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main41
L__main37:
;Joystick.c,89 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,90 :: 		TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Joystick.c,91 :: 		TFT_Circle(282, 114, 20);
MOVS	R2, #20
SXTH	R2, R2
MOVS	R1, #114
SXTH	R1, R1
MOVW	R0, #282
SXTH	R0, R0
BL	_TFT_Circle+0
;Joystick.c,92 :: 		TFT_Write_Text("Right", 266, 106);
MOVW	R0, #lo_addr(?lstr2_Joystick+0)
MOVT	R0, #hi_addr(?lstr2_Joystick+0)
MOVS	R2, #106
MOVW	R1, #266
BL	_TFT_Write_Text+0
;Joystick.c,93 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_main12:
SUBS	R7, R7, #1
BNE	L_main12
NOP
NOP
NOP
;Joystick.c,94 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,95 :: 		oldstate_right = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
STRH	R1, [R0, #0]
;Joystick.c,96 :: 		state = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
STRH	R1, [R0, #0]
;Joystick.c,88 :: 		if (oldstate_right && Button(&GPIOA_IDR, 6, 1, 0)) { // detect logical one to logical zero transition
L__main42:
L__main41:
;Joystick.c,99 :: 		if (Button(&GPIOD_IDR, 2, 1, 1))
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #2
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main14
;Joystick.c,100 :: 		oldstate_left = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_left+0)
MOVT	R0, #hi_addr(_oldstate_left+0)
STRH	R1, [R0, #0]
L_main14:
;Joystick.c,101 :: 		if (oldstate_left && Button(&GPIOD_IDR, 2, 1, 0)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_left+0)
MOVT	R0, #hi_addr(_oldstate_left+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main44
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #2
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main43
L__main36:
;Joystick.c,102 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,103 :: 		TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Joystick.c,104 :: 		TFT_Circle(28, 114, 20);
MOVS	R2, #20
SXTH	R2, R2
MOVS	R1, #114
SXTH	R1, R1
MOVS	R0, #28
SXTH	R0, R0
BL	_TFT_Circle+0
;Joystick.c,105 :: 		TFT_Write_Text("Left", 16, 106);
MOVW	R0, #lo_addr(?lstr3_Joystick+0)
MOVT	R0, #hi_addr(?lstr3_Joystick+0)
MOVS	R2, #106
MOVS	R1, #16
BL	_TFT_Write_Text+0
;Joystick.c,106 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_main18:
SUBS	R7, R7, #1
BNE	L_main18
NOP
NOP
NOP
;Joystick.c,107 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,108 :: 		oldstate_left = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_left+0)
MOVT	R0, #hi_addr(_oldstate_left+0)
STRH	R1, [R0, #0]
;Joystick.c,109 :: 		state = 3;
MOVS	R1, #3
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
STRH	R1, [R0, #0]
;Joystick.c,101 :: 		if (oldstate_left && Button(&GPIOD_IDR, 2, 1, 0)) { // detect logical one to logical zero transition
L__main44:
L__main43:
;Joystick.c,112 :: 		if (Button(&GPIOD_IDR, 4, 1, 1))                  // detect logical one state
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main20
;Joystick.c,113 :: 		oldstate_up = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
STRH	R1, [R0, #0]
L_main20:
;Joystick.c,114 :: 		if (oldstate_up && Button(&GPIOD_IDR, 4, 1, 0)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main46
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main45
L__main35:
;Joystick.c,115 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,116 :: 		TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Joystick.c,117 :: 		TFT_Circle(154, 24, 20);
MOVS	R2, #20
SXTH	R2, R2
MOVS	R1, #24
SXTH	R1, R1
MOVS	R0, #154
SXTH	R0, R0
BL	_TFT_Circle+0
;Joystick.c,118 :: 		TFT_Write_Text("Up", 146, 16);
MOVW	R0, #lo_addr(?lstr4_Joystick+0)
MOVT	R0, #hi_addr(?lstr4_Joystick+0)
MOVS	R2, #16
MOVS	R1, #146
BL	_TFT_Write_Text+0
;Joystick.c,119 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_main24:
SUBS	R7, R7, #1
BNE	L_main24
NOP
NOP
NOP
;Joystick.c,120 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,121 :: 		oldstate_up = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
STRH	R1, [R0, #0]
;Joystick.c,122 :: 		state = 4;
MOVS	R1, #4
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
STRH	R1, [R0, #0]
;Joystick.c,114 :: 		if (oldstate_up && Button(&GPIOD_IDR, 4, 1, 0)) { // detect logical one to logical zero transition
L__main46:
L__main45:
;Joystick.c,125 :: 		if (Button(&GPIOB_IDR, 5, 1, 1))
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main26
;Joystick.c,126 :: 		oldstate_down = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
STRH	R1, [R0, #0]
L_main26:
;Joystick.c,127 :: 		if (oldstate_down && Button(&GPIOB_IDR, 5, 1, 0)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main48
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main47
L__main34:
;Joystick.c,128 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,129 :: 		TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Joystick.c,130 :: 		TFT_Circle(154, 216, 20);
MOVS	R2, #20
SXTH	R2, R2
MOVS	R1, #216
SXTH	R1, R1
MOVS	R0, #154
SXTH	R0, R0
BL	_TFT_Circle+0
;Joystick.c,131 :: 		TFT_Write_Text("Down", 138, 207);
MOVW	R0, #lo_addr(?lstr5_Joystick+0)
MOVT	R0, #hi_addr(?lstr5_Joystick+0)
MOVS	R2, #207
MOVS	R1, #138
BL	_TFT_Write_Text+0
;Joystick.c,132 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_main30:
SUBS	R7, R7, #1
BNE	L_main30
NOP
NOP
NOP
;Joystick.c,133 :: 		TFT_Fill_Screen(CL_TEAL);
MOVW	R0, #1040
BL	_TFT_Fill_Screen+0
;Joystick.c,134 :: 		oldstate_down = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
STRH	R1, [R0, #0]
;Joystick.c,135 :: 		state = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
STRH	R1, [R0, #0]
;Joystick.c,127 :: 		if (oldstate_down && Button(&GPIOB_IDR, 5, 1, 0)) { // detect logical one to logical zero transition
L__main48:
L__main47:
;Joystick.c,138 :: 		GPIOA_ODR = ~GPIOB_ODR; // Toggle PORTA
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,139 :: 		GPIOB_ODR = ~GPIOB_ODR; // Toggle PORTB
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,140 :: 		GPIOC_ODR = ~GPIOC_ODR; // Toggle PORTC
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,141 :: 		GPIOD_ODR = ~GPIOD_ODR; // Toggle PORTD
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,142 :: 		GPIOE_ODR = ~GPIOE_ODR; // Toggle PORTE
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;Joystick.c,143 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main32:
SUBS	R7, R7, #1
BNE	L_main32
NOP
NOP
NOP
;Joystick.c,144 :: 		}
IT	AL
BAL	L_main0
;Joystick.c,145 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
