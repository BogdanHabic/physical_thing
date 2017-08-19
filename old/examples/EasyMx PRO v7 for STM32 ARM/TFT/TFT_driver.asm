TFT_driver_InitializeTouchPanel:
;TFT_driver.c,30 :: 		static void InitializeTouchPanel() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TFT_driver.c,31 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;TFT_driver.c,32 :: 		}
L_end_InitializeTouchPanel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of TFT_driver_InitializeTouchPanel
TFT_driver_InitializeObjects:
;TFT_driver.c,45 :: 		static void InitializeObjects() {
;TFT_driver.c,46 :: 		Screen1.Color                     = 0x8410;
MOVW	R1, #33808
MOVW	R0, #lo_addr(_Screen1+0)
MOVT	R0, #hi_addr(_Screen1+0)
STRH	R1, [R0, #0]
;TFT_driver.c,47 :: 		Screen1.Width                     = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_Screen1+2)
MOVT	R0, #hi_addr(_Screen1+2)
STRH	R1, [R0, #0]
;TFT_driver.c,48 :: 		Screen1.Height                    = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_Screen1+4)
MOVT	R0, #hi_addr(_Screen1+4)
STRH	R1, [R0, #0]
;TFT_driver.c,49 :: 		Screen1.ImagesCount               = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Screen1+8)
MOVT	R0, #hi_addr(_Screen1+8)
STRH	R1, [R0, #0]
;TFT_driver.c,50 :: 		Screen1.Images                    = Screen1_Images;
MOVW	R1, #lo_addr(_Screen1_Images+0)
MOVT	R1, #hi_addr(_Screen1_Images+0)
MOVW	R0, #lo_addr(_Screen1+12)
MOVT	R0, #hi_addr(_Screen1+12)
STR	R1, [R0, #0]
;TFT_driver.c,51 :: 		Screen1.ObjectsCount              = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Screen1+6)
MOVT	R0, #hi_addr(_Screen1+6)
STRB	R1, [R0, #0]
;TFT_driver.c,54 :: 		Image1.OwnerScreen     = &Screen1;
MOVW	R1, #lo_addr(_Screen1+0)
MOVT	R1, #hi_addr(_Screen1+0)
MOVW	R0, #lo_addr(_Image1+0)
MOVT	R0, #hi_addr(_Image1+0)
STR	R1, [R0, #0]
;TFT_driver.c,55 :: 		Image1.Order          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+4)
MOVT	R0, #hi_addr(_Image1+4)
STRB	R1, [R0, #0]
;TFT_driver.c,56 :: 		Image1.Left           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+6)
MOVT	R0, #hi_addr(_Image1+6)
STRH	R1, [R0, #0]
;TFT_driver.c,57 :: 		Image1.Top            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+8)
MOVT	R0, #hi_addr(_Image1+8)
STRH	R1, [R0, #0]
;TFT_driver.c,58 :: 		Image1.Width          = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_Image1+10)
MOVT	R0, #hi_addr(_Image1+10)
STRH	R1, [R0, #0]
;TFT_driver.c,59 :: 		Image1.Height         = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_Image1+12)
MOVT	R0, #hi_addr(_Image1+12)
STRH	R1, [R0, #0]
;TFT_driver.c,60 :: 		Image1.Picture_Type   = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image1+22)
MOVT	R0, #hi_addr(_Image1+22)
STRB	R1, [R0, #0]
;TFT_driver.c,61 :: 		Image1.Picture_Ratio  = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image1+23)
MOVT	R0, #hi_addr(_Image1+23)
STRB	R1, [R0, #0]
;TFT_driver.c,62 :: 		Image1.Picture_Name   = easymx_pro_v7_stm32_jpg;
MOVW	R1, #lo_addr(_easymx_pro_v7_stm32_jpg+0)
MOVT	R1, #hi_addr(_easymx_pro_v7_stm32_jpg+0)
MOVW	R0, #lo_addr(_Image1+16)
MOVT	R0, #hi_addr(_Image1+16)
STR	R1, [R0, #0]
;TFT_driver.c,63 :: 		Image1.Visible        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image1+20)
MOVT	R0, #hi_addr(_Image1+20)
STRB	R1, [R0, #0]
;TFT_driver.c,64 :: 		Image1.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image1+21)
MOVT	R0, #hi_addr(_Image1+21)
STRB	R1, [R0, #0]
;TFT_driver.c,65 :: 		Image1.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+24)
MOVT	R0, #hi_addr(_Image1+24)
STR	R1, [R0, #0]
;TFT_driver.c,66 :: 		Image1.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+28)
MOVT	R0, #hi_addr(_Image1+28)
STR	R1, [R0, #0]
;TFT_driver.c,67 :: 		Image1.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+32)
MOVT	R0, #hi_addr(_Image1+32)
STR	R1, [R0, #0]
;TFT_driver.c,68 :: 		Image1.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+36)
MOVT	R0, #hi_addr(_Image1+36)
STR	R1, [R0, #0]
;TFT_driver.c,69 :: 		}
L_end_InitializeObjects:
BX	LR
; end of TFT_driver_InitializeObjects
TFT_driver_IsInsideObject:
;TFT_driver.c,71 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
; Top start address is: 12 (R3)
; Left start address is: 8 (R2)
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
; Top end address is: 12 (R3)
; Left end address is: 8 (R2)
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
; Left start address is: 8 (R2)
; Top start address is: 12 (R3)
; Width start address is: 20 (R5)
LDRH	R5, [SP, #0]
; Height start address is: 24 (R6)
LDRH	R6, [SP, #4]
;TFT_driver.c,72 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
CMP	R2, R0
IT	HI
BHI	L_TFT_driver_IsInsideObject17
ADDS	R4, R2, R5
UXTH	R4, R4
; Left end address is: 8 (R2)
; Width end address is: 20 (R5)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R0
IT	CC
BCC	L_TFT_driver_IsInsideObject16
; X end address is: 0 (R0)
;TFT_driver.c,73 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
CMP	R3, R1
IT	HI
BHI	L_TFT_driver_IsInsideObject15
ADDS	R4, R3, R6
UXTH	R4, R4
; Top end address is: 12 (R3)
; Height end address is: 24 (R6)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R1
IT	CC
BCC	L_TFT_driver_IsInsideObject14
; Y end address is: 4 (R1)
L_TFT_driver_IsInsideObject13:
;TFT_driver.c,74 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_IsInsideObject
;TFT_driver.c,72 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_TFT_driver_IsInsideObject17:
L_TFT_driver_IsInsideObject16:
;TFT_driver.c,73 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_TFT_driver_IsInsideObject15:
L_TFT_driver_IsInsideObject14:
;TFT_driver.c,76 :: 		return 0;
MOVS	R0, #0
;TFT_driver.c,77 :: 		}
L_end_IsInsideObject:
BX	LR
; end of TFT_driver_IsInsideObject
_DrawImage:
;TFT_driver.c,83 :: 		void DrawImage(TImage *AImage) {
; AImage start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; AImage end address is: 0 (R0)
; AImage start address is: 0 (R0)
;TFT_driver.c,84 :: 		if (AImage->Visible) {
ADDW	R1, R0, #20
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_DrawImage4
;TFT_driver.c,85 :: 		TFT_Image_Jpeg(AImage->Left, AImage->Top, AImage->Picture_Name);
ADDW	R1, R0, #16
LDR	R1, [R1, #0]
MOV	R3, R1
ADDW	R1, R0, #8
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDS	R1, R0, #6
; AImage end address is: 0 (R0)
LDRH	R1, [R1, #0]
UXTH	R0, R1
UXTH	R1, R2
MOV	R2, R3
BL	_TFT_Image_Jpeg+0
;TFT_driver.c,86 :: 		}
L_DrawImage4:
;TFT_driver.c,87 :: 		}
L_end_DrawImage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawImage
_DrawScreen:
;TFT_driver.c,89 :: 		void DrawScreen(TScreen *aScreen) {
; aScreen start address is: 0 (R0)
SUB	SP, SP, #32
STR	LR, [SP, #0]
; aScreen end address is: 0 (R0)
; aScreen start address is: 0 (R0)
;TFT_driver.c,95 :: 		object_pressed = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
STRB	R2, [R1, #0]
;TFT_driver.c,96 :: 		order = 0;
MOVS	R1, #0
STRB	R1, [SP, #4]
;TFT_driver.c,97 :: 		image_idx = 0;
MOVS	R1, #0
STRB	R1, [SP, #5]
;TFT_driver.c,98 :: 		CurrentScreen = aScreen;
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
STR	R0, [R1, #0]
;TFT_driver.c,100 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
ADDS	R1, R0, #2
; aScreen end address is: 0 (R0)
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen20
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen19
IT	AL
BAL	L_DrawScreen7
L__DrawScreen20:
L__DrawScreen19:
;TFT_driver.c,101 :: 		save_bled = TFT_BLED;
MOVW	R2, #lo_addr(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
STR	R2, [SP, #28]
LDR	R1, [R2, #0]
STRB	R1, [SP, #12]
;TFT_driver.c,104 :: 		TFT_BLED           = 0;
MOVS	R1, #0
SXTB	R1, R1
STR	R1, [R2, #0]
;TFT_driver.c,105 :: 		TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
MOVW	R3, #lo_addr(_CurrentScreen+0)
MOVT	R3, #hi_addr(_CurrentScreen+0)
STR	R3, [SP, #24]
LDR	R1, [R3, #0]
ADDS	R1, R1, #4
LDRH	R1, [R1, #0]
UXTH	R2, R1
MOV	R1, R3
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRH	R1, [R1, #0]
UXTH	R0, R1
UXTH	R1, R2
BL	_TFT_Init_ILI9341_8bit+0
;TFT_driver.c,106 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
;TFT_driver.c,107 :: 		display_width = CurrentScreen->Width;
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
STRH	R2, [R1, #0]
;TFT_driver.c,108 :: 		display_height = CurrentScreen->Height;
LDR	R1, [SP, #24]
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
STRH	R2, [R1, #0]
;TFT_driver.c,109 :: 		TFT_BLED           = save_bled;
LDRB	R2, [SP, #12]
LDR	R1, [SP, #28]
STR	R2, [R1, #0]
;TFT_driver.c,111 :: 		}
IT	AL
BAL	L_DrawScreen8
L_DrawScreen7:
;TFT_driver.c,113 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
L_DrawScreen8:
;TFT_driver.c,116 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen9:
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #6
LDRB	R2, [R1, #0]
LDRB	R1, [SP, #4]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen10
;TFT_driver.c,117 :: 		if (image_idx  < CurrentScreen->ImagesCount) {
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #8
LDRH	R2, [R1, #0]
LDRB	R1, [SP, #5]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen11
;TFT_driver.c,118 :: 		local_image = GetImage(image_idx);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #12
LDR	R2, [R1, #0]
LDRB	R1, [SP, #5]
LSLS	R1, R1, #2
ADDS	R1, R2, R1
LDR	R1, [R1, #0]
STR	R1, [SP, #8]
;TFT_driver.c,119 :: 		if (order == local_image->Order) {
ADDS	R1, R1, #4
LDRB	R2, [R1, #0]
LDRB	R1, [SP, #4]
CMP	R1, R2
IT	NE
BNE	L_DrawScreen12
;TFT_driver.c,120 :: 		image_idx++;
LDRB	R1, [SP, #5]
ADDS	R1, R1, #1
STRB	R1, [SP, #5]
;TFT_driver.c,121 :: 		order++;
LDRB	R1, [SP, #4]
ADDS	R1, R1, #1
STRB	R1, [SP, #4]
;TFT_driver.c,122 :: 		DrawImage(local_image);
LDR	R0, [SP, #8]
BL	_DrawImage+0
;TFT_driver.c,123 :: 		}
L_DrawScreen12:
;TFT_driver.c,124 :: 		}
L_DrawScreen11:
;TFT_driver.c,126 :: 		}
IT	AL
BAL	L_DrawScreen9
L_DrawScreen10:
;TFT_driver.c,127 :: 		}
L_end_DrawScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _DrawScreen
_Init_MCU:
;TFT_driver.c,129 :: 		void Init_MCU(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TFT_driver.c,130 :: 		GPIO_Config(&GPIOE_BASE, _GPIO_PINMASK_9, _GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Config+0
;TFT_driver.c,131 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;TFT_driver.c,132 :: 		TFT_Set_Default_Mode();
BL	_TFT_Set_Default_Mode+0
;TFT_driver.c,133 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_Start_TP:
;TFT_driver.c,135 :: 		void Start_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TFT_driver.c,136 :: 		Init_MCU();
BL	_Init_MCU+0
;TFT_driver.c,138 :: 		InitializeTouchPanel();
BL	TFT_driver_InitializeTouchPanel+0
;TFT_driver.c,140 :: 		InitializeObjects();
BL	TFT_driver_InitializeObjects+0
;TFT_driver.c,141 :: 		display_width = Screen1.Width;
MOVW	R0, #lo_addr(_Screen1+2)
MOVT	R0, #hi_addr(_Screen1+2)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_width+0)
MOVT	R0, #hi_addr(_display_width+0)
STRH	R1, [R0, #0]
;TFT_driver.c,142 :: 		display_height = Screen1.Height;
MOVW	R0, #lo_addr(_Screen1+4)
MOVT	R0, #hi_addr(_Screen1+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_height+0)
MOVT	R0, #hi_addr(_display_height+0)
STRH	R1, [R0, #0]
;TFT_driver.c,143 :: 		DrawScreen(&Screen1);
MOVW	R0, #lo_addr(_Screen1+0)
MOVT	R0, #hi_addr(_Screen1+0)
BL	_DrawScreen+0
;TFT_driver.c,144 :: 		}
L_end_Start_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Start_TP
TFT_driver____?ag:
L_end_TFT_driver___?ag:
BX	LR
; end of TFT_driver____?ag
