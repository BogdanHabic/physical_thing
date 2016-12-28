_USB0Interrupt:
;screen.c,55 :: 		void USB0Interrupt() iv IVT_INT_OTG_FS{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,56 :: 		USB_Interrupt_Proc();
BL	_USB_Interrupt_Proc+0
;screen.c,57 :: 		}
L_end_USB0Interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB0Interrupt
_set_brush_for_draw:
;screen.c,59 :: 		void set_brush_for_draw() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,60 :: 		TFT_Set_Brush(1, CL_FUCHSIA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
MOVW	R1, #4095
MOVW	R0, #4095
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #0
MOVW	R1, #63519
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;screen.c,61 :: 		}
L_end_set_brush_for_draw:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_brush_for_draw
_set_brush_for_fake_draw:
;screen.c,63 :: 		void set_brush_for_fake_draw() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,64 :: 		TFT_Set_Brush(1, CL_BLACK, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
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
;screen.c,65 :: 		}
L_end_set_brush_for_fake_draw:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_brush_for_fake_draw
_set_brush_for_delete:
;screen.c,67 :: 		void set_brush_for_delete() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,68 :: 		TFT_Set_Brush(1, CL_AQUA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
MOVW	R1, #4095
MOVW	R0, #4095
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #0
MOVW	R1, #4095
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;screen.c,69 :: 		}
L_end_set_brush_for_delete:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_brush_for_delete
_draw_target:
;screen.c,71 :: 		void draw_target() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,74 :: 		x    = readbuff[0];
MOVW	R1, #lo_addr(_readbuff+0)
MOVT	R1, #hi_addr(_readbuff+0)
; x start address is: 28 (R7)
LDRSH	R7, [R1, #0]
;screen.c,75 :: 		y    = readbuff[1];
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
; y start address is: 32 (R8)
LDRSH	R8, [R0, #0]
;screen.c,76 :: 		del  = readbuff[2];
MOVW	R0, #lo_addr(_readbuff+4)
MOVT	R0, #hi_addr(_readbuff+4)
; del start address is: 8 (R2)
LDRSH	R2, [R0, #0]
;screen.c,77 :: 		fake = readbuff[3];
MOVW	R0, #lo_addr(_readbuff+6)
MOVT	R0, #hi_addr(_readbuff+6)
; fake start address is: 12 (R3)
LDRSH	R3, [R0, #0]
;screen.c,79 :: 		if(x == -1 || y == - 1 || del == 1) {
MOV	R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, #-1
IT	EQ
BEQ	L__draw_target35
CMP	R8, #-1
IT	EQ
BEQ	L__draw_target34
CMP	R2, #1
IT	EQ
BEQ	L__draw_target33
; del end address is: 8 (R2)
IT	AL
BAL	L_draw_target2
; x end address is: 28 (R7)
; y end address is: 32 (R8)
; fake end address is: 12 (R3)
L__draw_target35:
L__draw_target34:
L__draw_target33:
;screen.c,80 :: 		return;
IT	AL
BAL	L_end_draw_target
;screen.c,81 :: 		}
L_draw_target2:
;screen.c,83 :: 		if (!fake) {
; fake start address is: 12 (R3)
; y start address is: 32 (R8)
; x start address is: 28 (R7)
CMP	R3, #0
IT	NE
BNE	L_draw_target3
; fake end address is: 12 (R3)
;screen.c,84 :: 		set_brush_for_draw();
BL	_set_brush_for_draw+0
;screen.c,85 :: 		} else {
IT	AL
BAL	L_draw_target4
L_draw_target3:
;screen.c,86 :: 		set_brush_for_fake_draw();
BL	_set_brush_for_fake_draw+0
;screen.c,87 :: 		}
L_draw_target4:
;screen.c,89 :: 		TFT_Circle(x, y, CIRCLE_RADIUS);
MOVS	R2, #40
SXTH	R2, R2
SXTH	R1, R8
; y end address is: 32 (R8)
SXTH	R0, R7
; x end address is: 28 (R7)
BL	_TFT_Circle+0
;screen.c,90 :: 		}
L_end_draw_target:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_target
_delete_target:
;screen.c,92 :: 		void delete_target() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,95 :: 		x   = readbuff[0];
MOVW	R1, #lo_addr(_readbuff+0)
MOVT	R1, #hi_addr(_readbuff+0)
; x start address is: 28 (R7)
LDRSH	R7, [R1, #0]
;screen.c,96 :: 		y   = readbuff[1];
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
; y start address is: 32 (R8)
LDRSH	R8, [R0, #0]
;screen.c,97 :: 		del = readbuff[2];
MOVW	R0, #lo_addr(_readbuff+4)
MOVT	R0, #hi_addr(_readbuff+4)
; del start address is: 8 (R2)
LDRSH	R2, [R0, #0]
;screen.c,99 :: 		if(x == -1 || y == - 1 || del == 0) {
MOV	R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, #-1
IT	EQ
BEQ	L__delete_target39
CMP	R8, #-1
IT	EQ
BEQ	L__delete_target38
CMP	R2, #0
IT	EQ
BEQ	L__delete_target37
; del end address is: 8 (R2)
IT	AL
BAL	L_delete_target7
; x end address is: 28 (R7)
; y end address is: 32 (R8)
L__delete_target39:
L__delete_target38:
L__delete_target37:
;screen.c,100 :: 		return;
IT	AL
BAL	L_end_delete_target
;screen.c,101 :: 		}
L_delete_target7:
;screen.c,103 :: 		set_brush_for_delete();
; y start address is: 32 (R8)
; x start address is: 28 (R7)
BL	_set_brush_for_delete+0
;screen.c,104 :: 		TFT_Circle(x, y, CIRCLE_RADIUS);
MOVS	R2, #40
SXTH	R2, R2
SXTH	R1, R8
; y end address is: 32 (R8)
SXTH	R0, R7
; x end address is: 28 (R7)
BL	_TFT_Circle+0
;screen.c,105 :: 		}
L_end_delete_target:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _delete_target
_send_touch:
;screen.c,107 :: 		void send_touch(int x, int y) {
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
;screen.c,108 :: 		writebuff[0] = x;
MOVW	R2, #lo_addr(_writebuff+0)
MOVT	R2, #hi_addr(_writebuff+0)
STRB	R0, [R2, #0]
; x end address is: 0 (R0)
;screen.c,109 :: 		writebuff[1] = y;
MOVW	R2, #lo_addr(_writebuff+1)
MOVT	R2, #hi_addr(_writebuff+1)
STRB	R1, [R2, #0]
; y end address is: 4 (R1)
;screen.c,111 :: 		while(!HID_Write(&writebuff,64)); // Send the message
L_send_touch8:
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
CMP	R0, #0
IT	NE
BNE	L_send_touch9
IT	AL
BAL	L_send_touch8
L_send_touch9:
;screen.c,112 :: 		}
L_end_send_touch:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _send_touch
_Calibrate:
;screen.c,114 :: 		void Calibrate() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,115 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;screen.c,116 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;screen.c,117 :: 		TFT_Write_Text("Touch selected corners for calibration", 50, 80);
MOVW	R0, #lo_addr(?lstr1_screen+0)
MOVT	R0, #hi_addr(?lstr1_screen+0)
MOVS	R2, #80
MOVS	R1, #50
BL	_TFT_Write_Text+0
;screen.c,118 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,119 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,120 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,121 :: 		TFT_Write_Text("first here",235,220);
MOVW	R0, #lo_addr(?lstr2_screen+0)
MOVT	R0, #hi_addr(?lstr2_screen+0)
MOVS	R2, #220
MOVS	R1, #235
BL	_TFT_Write_Text+0
;screen.c,123 :: 		TP_TFT_Calibrate_Min();                      // Calibration of bottom left corner
BL	_TP_TFT_Calibrate_Min+0
;screen.c,124 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_Calibrate10:
SUBS	R7, R7, #1
BNE	L_Calibrate10
NOP
NOP
NOP
;screen.c,126 :: 		TFT_Set_Pen(CL_BLACK, 3);
MOVS	R1, #3
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;screen.c,127 :: 		TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;screen.c,128 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,129 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,130 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,131 :: 		TFT_Write_Text("first here",235,220);
MOVW	R0, #lo_addr(?lstr3_screen+0)
MOVT	R0, #hi_addr(?lstr3_screen+0)
MOVS	R2, #220
MOVS	R1, #235
BL	_TFT_Write_Text+0
;screen.c,133 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;screen.c,134 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;screen.c,135 :: 		TFT_Write_Text("now here ", 20, 5);
MOVW	R0, #lo_addr(?lstr4_screen+0)
MOVT	R0, #hi_addr(?lstr4_screen+0)
MOVS	R2, #5
MOVS	R1, #20
BL	_TFT_Write_Text+0
;screen.c,136 :: 		TFT_Line(0, 0, 5, 0);
MOVS	R3, #0
SXTH	R3, R3
MOVS	R2, #5
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,137 :: 		TFT_Line(0, 0, 0, 5);
MOVS	R3, #5
SXTH	R3, R3
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,138 :: 		TFT_Line(0, 0, 10, 10);
MOVS	R3, #10
SXTH	R3, R3
MOVS	R2, #10
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;screen.c,140 :: 		TP_TFT_Calibrate_Max();                      // Calibration of bottom left corner
BL	_TP_TFT_Calibrate_Max+0
;screen.c,141 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_Calibrate12:
SUBS	R7, R7, #1
BNE	L_Calibrate12
NOP
NOP
NOP
;screen.c,142 :: 		}
L_end_Calibrate:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Calibrate
_Init_ADC:
;screen.c,145 :: 		void Init_ADC() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,146 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
MOVW	R0, #768
BL	_ADC_Set_Input_Channel+0
;screen.c,147 :: 		ADC1_Init();
BL	_ADC1_Init+0
;screen.c,148 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_Init_ADC14:
SUBS	R7, R7, #1
BNE	L_Init_ADC14
NOP
NOP
NOP
;screen.c,149 :: 		}
L_end_Init_ADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ADC
screen_InitializeTouchPanel:
;screen.c,151 :: 		static void InitializeTouchPanel() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,152 :: 		Init_ADC();
BL	_Init_ADC+0
;screen.c,153 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;screen.c,155 :: 		TP_TFT_Init(320, 240, 8, 9);                 // Initialize touch panel
MOVS	R3, #9
MOVS	R2, #8
MOVS	R1, #240
MOVW	R0, #320
BL	_TP_TFT_Init+0
;screen.c,156 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);     // Set touch panel ADC threshold
MOVW	R0, #750
SXTH	R0, R0
BL	_TP_TFT_Set_ADC_Threshold+0
;screen.c,158 :: 		PenDown = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;screen.c,159 :: 		}
L_end_InitializeTouchPanel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of screen_InitializeTouchPanel
_Init_MCU:
;screen.c,161 :: 		void Init_MCU() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,162 :: 		GPIO_Config(&GPIOE_BASE, _GPIO_PINMASK_9, _GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Config+0
;screen.c,163 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;screen.c,164 :: 		TFT_Set_Default_Mode();
BL	_TFT_Set_Default_Mode+0
;screen.c,165 :: 		TP_TFT_Set_Default_Mode();
BL	_TP_TFT_Set_Default_Mode+0
;screen.c,166 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_Start_TP:
;screen.c,168 :: 		void Start_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,169 :: 		Init_MCU();
BL	_Init_MCU+0
;screen.c,171 :: 		InitializeTouchPanel();
BL	screen_InitializeTouchPanel+0
;screen.c,173 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_Start_TP16:
SUBS	R7, R7, #1
BNE	L_Start_TP16
NOP
NOP
NOP
;screen.c,174 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;screen.c,175 :: 		Calibrate();
BL	_Calibrate+0
;screen.c,176 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;screen.c,182 :: 		}
L_end_Start_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Start_TP
_Initialize:
;screen.c,184 :: 		void Initialize() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,185 :: 		Xcoord = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
STRH	R1, [R0, #0]
;screen.c,186 :: 		Ycoord = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
STRH	R1, [R0, #0]
;screen.c,187 :: 		Start_TP(); // Initialize touch panel
BL	_Start_TP+0
;screen.c,189 :: 		TFT_Set_Pen(CL_AQUA, 3);
MOVS	R1, #3
MOVW	R0, #4095
BL	_TFT_Set_Pen+0
;screen.c,190 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;screen.c,191 :: 		TFT_Fill_Screen(CL_AQUA);
MOVW	R0, #4095
BL	_TFT_Fill_Screen+0
;screen.c,192 :: 		TFT_Set_Brush(1, CL_AQUA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
MOVW	R1, #4095
MOVW	R0, #4095
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #0
MOVW	R1, #4095
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;screen.c,194 :: 		HID_Enable(&readbuff,&writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;screen.c,195 :: 		}
L_end_Initialize:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Initialize
_write_coords:
;screen.c,197 :: 		void write_coords(int x, int y) {
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
;screen.c,198 :: 		int i = 0;
;screen.c,199 :: 		for(i = 0; i < 64; i++) {
; i start address is: 16 (R4)
MOVS	R4, #0
SXTH	R4, R4
; x end address is: 0 (R0)
; y end address is: 4 (R1)
; i end address is: 16 (R4)
STRH	R1, [SP, #4]
SXTH	R1, R0
LDRSH	R0, [SP, #4]
L_write_coords18:
; i start address is: 16 (R4)
; y start address is: 0 (R0)
; x start address is: 4 (R1)
CMP	R4, #64
IT	GE
BGE	L_write_coords19
;screen.c,200 :: 		writebuff[i] = '\0';
MOVW	R2, #lo_addr(_writebuff+0)
MOVT	R2, #hi_addr(_writebuff+0)
ADDS	R3, R2, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
;screen.c,199 :: 		for(i = 0; i < 64; i++) {
ADDS	R4, R4, #1
SXTH	R4, R4
;screen.c,201 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_write_coords18
L_write_coords19:
;screen.c,202 :: 		sprintf(writebuff, "%d=%d", x, y);
MOVW	R3, #lo_addr(?lstr_5_screen+0)
MOVT	R3, #hi_addr(?lstr_5_screen+0)
MOVW	R2, #lo_addr(_writebuff+0)
MOVT	R2, #hi_addr(_writebuff+0)
PUSH	(R0)
; y end address is: 0 (R0)
PUSH	(R1)
; x end address is: 4 (R1)
PUSH	(R3)
PUSH	(R2)
BL	_sprintf+0
ADD	SP, SP, #16
;screen.c,203 :: 		while(!HID_Write(&writebuff,64));
L_write_coords21:
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
CMP	R0, #0
IT	NE
BNE	L_write_coords22
IT	AL
BAL	L_write_coords21
L_write_coords22:
;screen.c,204 :: 		}
L_end_write_coords:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _write_coords
_Process_TP_Up:
;screen.c,206 :: 		void Process_TP_Up(unsigned int x, unsigned int y) {
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 0 (R0)
; y start address is: 4 (R1)
;screen.c,207 :: 		write_coords((int)x, (int)y);
SXTH	R1, R1
; y end address is: 4 (R1)
SXTH	R0, R0
; x end address is: 0 (R0)
BL	_write_coords+0
;screen.c,208 :: 		}
L_end_Process_TP_Up:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Process_TP_Up
_Process_TP_Down:
;screen.c,210 :: 		void Process_TP_Down(unsigned int x, unsigned int y) {
;screen.c,212 :: 		}
L_end_Process_TP_Down:
BX	LR
; end of _Process_TP_Down
_Check_TP:
;screen.c,214 :: 		void Check_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,215 :: 		if (TP_TFT_Press_Detect()) {
BL	_TP_TFT_Press_Detect+0
CMP	R0, #0
IT	EQ
BEQ	L_Check_TP23
;screen.c,217 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
MOVW	R1, #lo_addr(_Ycoord+0)
MOVT	R1, #hi_addr(_Ycoord+0)
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
BL	_TP_TFT_Get_Coordinates+0
CMP	R0, #0
IT	NE
BNE	L_Check_TP24
;screen.c,218 :: 		if (PenDown == 0) {
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Check_TP25
;screen.c,219 :: 		PenDown = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;screen.c,220 :: 		Process_TP_Down(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Down+0
;screen.c,221 :: 		}
L_Check_TP25:
;screen.c,222 :: 		}
L_Check_TP24:
;screen.c,223 :: 		} else if (PenDown == 1) {
IT	AL
BAL	L_Check_TP26
L_Check_TP23:
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_Check_TP27
;screen.c,224 :: 		PenDown = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;screen.c,225 :: 		Process_TP_Up(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Up+0
;screen.c,226 :: 		}
L_Check_TP27:
L_Check_TP26:
;screen.c,227 :: 		}
L_end_Check_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Check_TP
_main:
;screen.c,229 :: 		void main(void) {
;screen.c,230 :: 		Initialize();
BL	_Initialize+0
;screen.c,232 :: 		while (1) {
L_main28:
;screen.c,233 :: 		if (HID_Read()) { // this won't hang because we are using async interrupts
BL	_HID_Read+0
CMP	R0, #0
IT	EQ
BEQ	L_main30
;screen.c,234 :: 		draw_target();
BL	_draw_target+0
;screen.c,235 :: 		delete_target();
BL	_delete_target+0
;screen.c,236 :: 		} else {
IT	AL
BAL	L_main31
L_main30:
;screen.c,237 :: 		Check_TP();
BL	_Check_TP+0
;screen.c,238 :: 		}
L_main31:
;screen.c,239 :: 		}
IT	AL
BAL	L_main28
;screen.c,240 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
