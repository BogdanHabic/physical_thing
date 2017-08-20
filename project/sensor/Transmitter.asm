_DrawFrame:
;Transmitter.c,50 :: 		void DrawFrame(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,51 :: 		TFT_Init(320,240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init+0
;Transmitter.c,52 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Transmitter.c,53 :: 		TFT_Set_Pen(CL_BLACK, 1);
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;Transmitter.c,54 :: 		TFT_Line(20, 220, 300, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Transmitter.c,55 :: 		TFT_LIne(20,  46, 300,  46);
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Transmitter.c,56 :: 		TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;Transmitter.c,57 :: 		TFT_Write_Text("BEE  Click  Board  Demo", 55, 14);
MOVW	R0, #lo_addr(?lstr1_Transmitter+0)
MOVT	R0, #hi_addr(?lstr1_Transmitter+0)
MOVS	R2, #14
MOVS	R1, #55
BL	_TFT_Write_Text+0
;Transmitter.c,58 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Transmitter.c,59 :: 		TFT_Write_Text("EasyMx PRO v7", 19, 223);
MOVW	R0, #lo_addr(?lstr2_Transmitter+0)
MOVT	R0, #hi_addr(?lstr2_Transmitter+0)
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;Transmitter.c,60 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Transmitter.c,61 :: 		TFT_Write_Text("www.mikroe.com", 200, 223);
MOVW	R0, #lo_addr(?lstr3_Transmitter+0)
MOVT	R0, #hi_addr(?lstr3_Transmitter+0)
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;Transmitter.c,62 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,63 :: 		TFT_Write_Text("Transmitted data : ", 90, 80);
MOVW	R0, #lo_addr(?lstr4_Transmitter+0)
MOVT	R0, #hi_addr(?lstr4_Transmitter+0)
MOVS	R2, #80
MOVS	R1, #90
BL	_TFT_Write_Text+0
;Transmitter.c,64 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_main:
;Transmitter.c,66 :: 		void main() {
SUB	SP, SP, #4
;Transmitter.c,67 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Transmitter.c,68 :: 		DrawFrame();
BL	_DrawFrame+0
;Transmitter.c,70 :: 		while(1) {                         // Infinite loop
L_main0:
;Transmitter.c,71 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Transmitter.c,72 :: 		ByteToStr(DATA_TX[0],&txt);      // Convert byte to string
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,73 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,74 :: 		TFT_Write_Text(txt, 215, 80);    // Display string on TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,75 :: 		delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
;Transmitter.c,76 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,77 :: 		TFT_Write_Text(txt, 215, 80);    // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,78 :: 		DATA_TX[0]++;                    // Incremeting value
MOVW	R1, #lo_addr(_DATA_TX+0)
MOVT	R1, #hi_addr(_DATA_TX+0)
LDRSB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;Transmitter.c,79 :: 		}
IT	AL
BAL	L_main0
;Transmitter.c,80 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
