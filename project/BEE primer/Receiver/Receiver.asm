_DrawFrame:
;Receiver.c,47 :: 		void DrawFrame(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Receiver.c,48 :: 		TFT_Init(320,240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init+0
;Receiver.c,49 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Receiver.c,50 :: 		TFT_Set_Pen(CL_BLACK, 1);
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;Receiver.c,51 :: 		TFT_Line(20, 220, 300, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Receiver.c,52 :: 		TFT_LIne(20,  46, 300,  46);
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Receiver.c,53 :: 		TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;Receiver.c,54 :: 		TFT_Write_Text("BEE  Click  Board  Demo", 50, 14);
MOVW	R0, #lo_addr(?lstr1_Receiver+0)
MOVT	R0, #hi_addr(?lstr1_Receiver+0)
MOVS	R2, #14
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Receiver.c,55 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Receiver.c,56 :: 		TFT_Write_Text("EasyMx PRO v7", 19, 223);
MOVW	R0, #lo_addr(?lstr2_Receiver+0)
MOVT	R0, #hi_addr(?lstr2_Receiver+0)
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;Receiver.c,57 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Receiver.c,58 :: 		TFT_Write_Text("www.mikroe.com", 200, 223);
MOVW	R0, #lo_addr(?lstr3_Receiver+0)
MOVT	R0, #hi_addr(?lstr3_Receiver+0)
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;Receiver.c,59 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,60 :: 		TFT_Write_Text("Received data : ", 90, 80);
MOVW	R0, #lo_addr(?lstr4_Receiver+0)
MOVT	R0, #hi_addr(?lstr4_Receiver+0)
MOVS	R2, #80
MOVS	R1, #90
BL	_TFT_Write_Text+0
;Receiver.c,61 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_main:
;Receiver.c,63 :: 		void main() {
;Receiver.c,64 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Receiver.c,66 :: 		Initialize();                           // Initialize MCU and Bee click board
BL	_Initialize+0
;Receiver.c,67 :: 		DrawFrame();
BL	_DrawFrame+0
;Receiver.c,69 :: 		while(1){                               // Infinite loop
L_main0:
;Receiver.c,70 :: 		if(Debounce_INT() == 0 ){             // Debounce line INT
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_main2
;Receiver.c,71 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Receiver.c,72 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Receiver.c,73 :: 		ByteToStr(DATA_RX[0],&txt);         // Convert third byte to string
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Receiver.c,74 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,75 :: 		TFT_Write_Text(txt, 195, 80);       // Display string on TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Receiver.c,76 :: 		delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main3:
SUBS	R7, R7, #1
BNE	L_main3
NOP
NOP
NOP
;Receiver.c,77 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Receiver.c,78 :: 		TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Receiver.c,80 :: 		GPIOD_ODR = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Receiver.c,81 :: 		}
L_main2:
;Receiver.c,82 :: 		}
IT	AL
BAL	L_main0
;Receiver.c,83 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
