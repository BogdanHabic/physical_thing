_InitMCU:
;MP3.c,63 :: 		void InitMCU(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3.c,66 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_7);    // RST
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;MP3.c,67 :: 		GPIO_Digital_Input (&GPIOC_BASE, _GPIO_PINMASK_6);    // DREQ
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Input+0
;MP3.c,68 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_8);    // CS
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;MP3.c,69 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);    // DCS
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;MP3.c,72 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;MP3.c,73 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_InitMCU0:
SUBS	R7, R7, #1
BNE	L_InitMCU0
NOP
NOP
NOP
;MP3.c,74 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;MP3.c,75 :: 		}
L_end_InitMCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitMCU
_DrawMP3Scr:
;MP3.c,77 :: 		void DrawMP3Scr(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3.c,78 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;MP3.c,79 :: 		TFT_Set_Pen(CL_Black, 1);
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;MP3.c,80 :: 		TFT_Line(20, 220, 300, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;MP3.c,81 :: 		TFT_LIne(20,  46, 300,  46);
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;MP3.c,82 :: 		TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;MP3.c,83 :: 		TFT_Write_Text("MP3  TEST", 95, 14);
MOVW	R0, #lo_addr(?lstr1_MP3+0)
MOVT	R0, #hi_addr(?lstr1_MP3+0)
MOVS	R2, #14
MOVS	R1, #95
BL	_TFT_Write_Text+0
;MP3.c,84 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;MP3.c,85 :: 		TFT_Write_Text("easzM3PROv7", 19, 223);
MOVW	R0, #lo_addr(?lstr2_MP3+0)
MOVT	R0, #hi_addr(?lstr2_MP3+0)
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;MP3.c,86 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;MP3.c,87 :: 		TFT_Write_Text("www.mikroe.com", 200, 223);
MOVW	R0, #lo_addr(?lstr3_MP3+0)
MOVT	R0, #hi_addr(?lstr3_MP3+0)
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;MP3.c,88 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;MP3.c,89 :: 		}
L_end_DrawMP3Scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawMP3Scr
_MP3_Init:
;MP3.c,98 :: 		void MP3_Init(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3.c,100 :: 		BSYNC = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;MP3.c,101 :: 		MP3_CS = 1;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;MP3.c,104 :: 		MP3_RST = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;MP3.c,105 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_MP3_Init2:
SUBS	R7, R7, #1
BNE	L_MP3_Init2
NOP
NOP
NOP
;MP3.c,106 :: 		MP3_RST = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;MP3.c,108 :: 		while (DREQ == 0);
L_MP3_Init4:
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_MP3_Init5
IT	AL
BAL	L_MP3_Init4
L_MP3_Init5:
;MP3.c,110 :: 		MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
MOVW	R1, #2048
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,111 :: 		MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
MOVW	R1, #31232
MOVS	R0, _SCI_BASS_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,112 :: 		MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz
MOVW	R1, #8192
MOVS	R0, _SCI_CLOCKF_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,115 :: 		volume_left  = 0; //0x3F;
MOVS	R1, #0
MOVW	R0, #lo_addr(_volume_left+0)
MOVT	R0, #hi_addr(_volume_left+0)
STRB	R1, [R0, #0]
;MP3.c,116 :: 		volume_right = 0; //0x3F;
MOVS	R1, #0
MOVW	R0, #lo_addr(_volume_right+0)
MOVT	R0, #hi_addr(_volume_right+0)
STRB	R1, [R0, #0]
;MP3.c,117 :: 		MP3_Set_Volume(volume_left, volume_right);
MOVS	R1, #0
MOVS	R0, #0
BL	_MP3_Set_Volume+0
;MP3.c,118 :: 		}
L_end_MP3_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_Init
_MP3_Start:
;MP3.c,127 :: 		void MP3_Start(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3.c,130 :: 		MP3_CS            = 1;               // Deselect MP3_CS
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;MP3.c,131 :: 		MP3_RST           = 1;               // Set MP3_RST pin
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;MP3.c,133 :: 		BSYNC             = 0;               // Clear BSYNC
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;MP3.c,134 :: 		BSYNC             = 1;               // Clear BSYNC
STR	R2, [R0, #0]
;MP3.c,140 :: 		&_GPIO_MODULE_SPI3_PC10_11_12);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
;MP3.c,139 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;MP3.c,137 :: 		SPI3_Init_Advanced(_SPI_FPCLK_DIV16, _SPI_MASTER  | _SPI_8_BIT |
MOVS	R0, #3
;MP3.c,140 :: 		&_GPIO_MODULE_SPI3_PC10_11_12);
BL	_SPI3_Init_Advanced+0
;MP3.c,142 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;MP3.c,144 :: 		TFT_Set_Pen(CL_WHITE, 1);
MOVS	R1, #1
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;MP3.c,145 :: 		TFT_Set_Brush(1, CL_WHITE, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #65535
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;MP3.c,147 :: 		TFT_Write_Text("1. Initializing VS1053B decoder interface", 30, 80);
MOVW	R0, #lo_addr(?lstr4_MP3+0)
MOVT	R0, #hi_addr(?lstr4_MP3+0)
MOVS	R2, #80
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,149 :: 		MP3_Init();
BL	_MP3_Init+0
;MP3.c,150 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_MP3_Start6:
SUBS	R7, R7, #1
BNE	L_MP3_Start6
NOP
NOP
NOP
;MP3.c,151 :: 		}
L_end_MP3_Start:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_Start
_MP3_Test:
;MP3.c,160 :: 		void MP3_Test(char *test)
SUB	SP, SP, #12
STR	LR, [SP, #0]
STR	R0, [SP, #8]
;MP3.c,165 :: 		*test = 0;
MOVS	R2, #0
LDR	R1, [SP, #8]
STRB	R2, [R1, #0]
;MP3.c,167 :: 		TFT_Write_Text("2. Initializing MMC_FAT", 30, 100);
MOVW	R1, #lo_addr(?lstr5_MP3+0)
MOVT	R1, #hi_addr(?lstr5_MP3+0)
MOVS	R2, #100
MOV	R0, R1
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,168 :: 		if (Mmc_Fat_Init() == 0) {
BL	_Mmc_Fat_Init+0
CMP	R0, #0
IT	NE
BNE	L_MP3_Test8
;MP3.c,169 :: 		if (Mmc_Fat_Assign(&mp3_filename, 0) ) {
MOVS	R1, #0
MOVW	R0, #lo_addr(_mp3_filename+0)
MOVT	R0, #hi_addr(_mp3_filename+0)
BL	_Mmc_Fat_Assign+0
CMP	R0, #0
IT	EQ
BEQ	L_MP3_Test9
;MP3.c,170 :: 		TFT_Write_Text("3. File Assigned", 30, 120);
MOVW	R1, #lo_addr(?lstr6_MP3+0)
MOVT	R1, #hi_addr(?lstr6_MP3+0)
MOVS	R2, #120
MOV	R0, R1
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,171 :: 		Mmc_Fat_Reset(&file_size);          // Call Reset before file reading,
MOVW	R0, #lo_addr(_file_size+0)
MOVT	R0, #hi_addr(_file_size+0)
BL	_Mmc_Fat_Reset+0
;MP3.c,174 :: 		TFT_Write_Text("4. Play audio... :)", 30, 140);
MOVW	R1, #lo_addr(?lstr7_MP3+0)
MOVT	R1, #hi_addr(?lstr7_MP3+0)
MOVS	R2, #140
MOV	R0, R1
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,176 :: 		while (file_size > BUFFER_SIZE)
L_MP3_Test10:
MOVW	R1, #lo_addr(_file_size+0)
MOVT	R1, #hi_addr(_file_size+0)
LDR	R1, [R1, #0]
CMP	R1, #512
IT	LS
BLS	L_MP3_Test11
;MP3.c,178 :: 		for (i=0; i<BUFFER_SIZE; i++)
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
L_MP3_Test12:
; i start address is: 0 (R0)
CMP	R0, #512
IT	CS
BCS	L_MP3_Test13
;MP3.c,180 :: 		Mmc_Fat_Read(mp3_buffer + i);
MOVW	R1, #lo_addr(_mp3_buffer+0)
MOVT	R1, #hi_addr(_mp3_buffer+0)
ADDS	R1, R1, R0
STR	R0, [SP, #4]
MOV	R0, R1
BL	_Mmc_Fat_Read+0
LDR	R0, [SP, #4]
;MP3.c,178 :: 		for (i=0; i<BUFFER_SIZE; i++)
ADDS	R1, R0, #1
; i end address is: 0 (R0)
; i start address is: 4 (R1)
;MP3.c,181 :: 		}
MOV	R0, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_MP3_Test12
L_MP3_Test13:
;MP3.c,182 :: 		for (i=0; i<BUFFER_SIZE/BYTES_2_WRITE; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
L_MP3_Test15:
; i start address is: 0 (R0)
CMP	R0, #16
IT	CS
BCS	L_MP3_Test16
;MP3.c,183 :: 		MP3_SDI_Write_32(mp3_buffer + i*BYTES_2_WRITE);
LSLS	R2, R0, #5
MOVW	R1, #lo_addr(_mp3_buffer+0)
MOVT	R1, #hi_addr(_mp3_buffer+0)
ADDS	R1, R1, R2
STR	R0, [SP, #4]
MOV	R0, R1
BL	_MP3_SDI_Write_32+0
LDR	R0, [SP, #4]
;MP3.c,182 :: 		for (i=0; i<BUFFER_SIZE/BYTES_2_WRITE; i++) {
ADDS	R1, R0, #1
; i end address is: 0 (R0)
; i start address is: 4 (R1)
;MP3.c,184 :: 		}
MOV	R0, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_MP3_Test15
L_MP3_Test16:
;MP3.c,186 :: 		file_size -= BUFFER_SIZE;
MOVW	R2, #lo_addr(_file_size+0)
MOVT	R2, #hi_addr(_file_size+0)
LDR	R1, [R2, #0]
SUB	R1, R1, #512
STR	R1, [R2, #0]
;MP3.c,190 :: 		}
IT	AL
BAL	L_MP3_Test10
L_MP3_Test11:
;MP3.c,193 :: 		for (i=0; i<file_size; i++)
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
L_MP3_Test18:
; i start address is: 0 (R0)
MOVW	R1, #lo_addr(_file_size+0)
MOVT	R1, #hi_addr(_file_size+0)
LDR	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_MP3_Test19
;MP3.c,195 :: 		Mmc_Fat_Read(mp3_buffer + i);
MOVW	R1, #lo_addr(_mp3_buffer+0)
MOVT	R1, #hi_addr(_mp3_buffer+0)
ADDS	R1, R1, R0
STR	R0, [SP, #4]
MOV	R0, R1
BL	_Mmc_Fat_Read+0
LDR	R0, [SP, #4]
;MP3.c,193 :: 		for (i=0; i<file_size; i++)
ADDS	R1, R0, #1
; i end address is: 0 (R0)
; i start address is: 4 (R1)
;MP3.c,196 :: 		}
MOV	R0, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_MP3_Test18
L_MP3_Test19:
;MP3.c,198 :: 		for (i=0; i<file_size; i++)
; i start address is: 0 (R0)
MOVS	R0, #0
; i end address is: 0 (R0)
L_MP3_Test21:
; i start address is: 0 (R0)
MOVW	R1, #lo_addr(_file_size+0)
MOVT	R1, #hi_addr(_file_size+0)
LDR	R1, [R1, #0]
CMP	R0, R1
IT	CS
BCS	L_MP3_Test22
;MP3.c,200 :: 		MP3_SDI_Write(mp3_buffer[i]);
MOVW	R1, #lo_addr(_mp3_buffer+0)
MOVT	R1, #hi_addr(_mp3_buffer+0)
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
STR	R0, [SP, #4]
UXTB	R0, R1
BL	_MP3_SDI_Write+0
LDR	R0, [SP, #4]
;MP3.c,198 :: 		for (i=0; i<file_size; i++)
ADDS	R1, R0, #1
; i end address is: 0 (R0)
; i start address is: 4 (R1)
;MP3.c,201 :: 		}
MOV	R0, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_MP3_Test21
L_MP3_Test22:
;MP3.c,203 :: 		TFT_Write_Text("5. Finish!", 30, 160);
MOVW	R1, #lo_addr(?lstr8_MP3+0)
MOVT	R1, #hi_addr(?lstr8_MP3+0)
MOVS	R2, #160
MOV	R0, R1
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,204 :: 		}
IT	AL
BAL	L_MP3_Test24
L_MP3_Test9:
;MP3.c,207 :: 		TFT_Write_Text("3. File not assigned", 30, 120);
MOVW	R1, #lo_addr(?lstr9_MP3+0)
MOVT	R1, #hi_addr(?lstr9_MP3+0)
MOVS	R2, #120
MOV	R0, R1
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,208 :: 		*test = 2;
MOVS	R2, #2
LDR	R1, [SP, #8]
STRB	R2, [R1, #0]
;MP3.c,209 :: 		}
L_MP3_Test24:
;MP3.c,210 :: 		}
IT	AL
BAL	L_MP3_Test25
L_MP3_Test8:
;MP3.c,212 :: 		TFT_Write_Text("3. MMC FAT not initialized", 30, 120);
MOVW	R1, #lo_addr(?lstr10_MP3+0)
MOVT	R1, #hi_addr(?lstr10_MP3+0)
MOVS	R2, #120
MOV	R0, R1
MOVS	R1, #30
BL	_TFT_Write_Text+0
;MP3.c,213 :: 		*test = 2;
MOVS	R2, #2
LDR	R1, [SP, #8]
STRB	R2, [R1, #0]
;MP3.c,214 :: 		}
L_MP3_Test25:
;MP3.c,215 :: 		}
L_end_MP3_Test:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MP3_Test
_main:
;MP3.c,221 :: 		void main(){
;MP3.c,222 :: 		InitMCU();
BL	_InitMCU+0
;MP3.c,223 :: 		DrawMP3Scr();
BL	_DrawMP3Scr+0
;MP3.c,225 :: 		MP3_Start();
BL	_MP3_Start+0
;MP3.c,226 :: 		MP3_Test(&ucMP3_run_test);
MOVW	R0, #lo_addr(_ucMP3_run_test+0)
MOVT	R0, #hi_addr(_ucMP3_run_test+0)
BL	_MP3_Test+0
;MP3.c,227 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
