_Tone1:
;Sound.c,29 :: 		void Tone1() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,30 :: 		Sound_Play(659, 250);   // Frequency = 659Hz, duration = 250ms
MOVS	R1, #250
MOVW	R0, #659
BL	_Sound_Play+0
;Sound.c,31 :: 		}
L_end_Tone1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Tone1
_Tone2:
;Sound.c,33 :: 		void Tone2() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,34 :: 		Sound_Play(698, 250);   // Frequency = 698Hz, duration = 250ms
MOVS	R1, #250
MOVW	R0, #698
BL	_Sound_Play+0
;Sound.c,35 :: 		}
L_end_Tone2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Tone2
_Tone3:
;Sound.c,37 :: 		void Tone3() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,38 :: 		Sound_Play(784, 250);   // Frequency = 784Hz, duration = 250ms
MOVS	R1, #250
MOVW	R0, #784
BL	_Sound_Play+0
;Sound.c,39 :: 		}
L_end_Tone3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Tone3
_Tone4:
;Sound.c,42 :: 		void Tone4() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,43 :: 		Sound_Play(27.5, 250);   // Frequency = 784Hz, duration = 250ms
MOVS	R1, #250
MOVS	R0, #27
BL	_Sound_Play+0
;Sound.c,44 :: 		}
L_end_Tone4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Tone4
_ToneA:
;Sound.c,49 :: 		void ToneA() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,50 :: 		Sound_Play( 880, 50);
MOVS	R1, #50
MOVW	R0, #880
BL	_Sound_Play+0
;Sound.c,51 :: 		}
L_end_ToneA:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ToneA
_ToneC:
;Sound.c,52 :: 		void ToneC() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,53 :: 		Sound_Play(1046, 50);
MOVS	R1, #50
MOVW	R0, #1046
BL	_Sound_Play+0
;Sound.c,54 :: 		}
L_end_ToneC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ToneC
_ToneE:
;Sound.c,55 :: 		void ToneE() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,56 :: 		Sound_Play(1318, 50);
MOVS	R1, #50
MOVW	R0, #1318
BL	_Sound_Play+0
;Sound.c,57 :: 		}
L_end_ToneE:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ToneE
_Melody:
;Sound.c,59 :: 		void Melody() {           // Plays the melody "Yellow house"
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,60 :: 		ToneA();ToneA();ToneA();ToneA();ToneA();ToneA();ToneA();ToneA();
BL	_ToneA+0
BL	_ToneA+0
BL	_ToneA+0
BL	_ToneA+0
BL	_ToneA+0
BL	_ToneA+0
BL	_ToneA+0
BL	_ToneA+0
;Sound.c,61 :: 		}
L_end_Melody:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Melody
_Melody2:
;Sound.c,63 :: 		void Melody2() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Sound.c,65 :: 		for (i = 9; i > 0; i--) {
; i start address is: 24 (R6)
MOVS	R6, #9
; i end address is: 24 (R6)
L_Melody20:
; i start address is: 24 (R6)
CMP	R6, #0
IT	LS
BLS	L_Melody21
;Sound.c,66 :: 		ToneA(); ToneC(); ToneE();
BL	_ToneA+0
BL	_ToneC+0
BL	_ToneE+0
;Sound.c,65 :: 		for (i = 9; i > 0; i--) {
SUBS	R6, R6, #1
UXTB	R6, R6
;Sound.c,67 :: 		}
; i end address is: 24 (R6)
IT	AL
BAL	L_Melody20
L_Melody21:
;Sound.c,68 :: 		}
L_end_Melody2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Melody2
_main:
;Sound.c,70 :: 		void main() {
;Sound.c,71 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_LOW);
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Sound.c,72 :: 		Sound_Init(&GPIOE_ODR, 14);
MOVS	R1, #14
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
BL	_Sound_Init+0
;Sound.c,73 :: 		Sound_Play(880, 1000);            // Play sound at 880Hz for 1 second
MOVW	R1, #1000
MOVW	R0, #880
BL	_Sound_Play+0
;Sound.c,75 :: 		while (1) {
L_main3:
;Sound.c,76 :: 		if (Button(&GPIOD_IDR,7,1,1))       // RB7 plays Tone1
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #7
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main5
;Sound.c,77 :: 		Tone1();
BL	_Tone1+0
L_main5:
;Sound.c,78 :: 		while (GPIOD_IDR.B7);                // Wait for button to be released
L_main6:
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main7
IT	AL
BAL	L_main6
L_main7:
;Sound.c,80 :: 		if (Button(&GPIOD_IDR,6,1,1))       // RB6 plays Tone2
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #6
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main8
;Sound.c,81 :: 		Tone2();
BL	_Tone2+0
L_main8:
;Sound.c,82 :: 		while (GPIOD_IDR.B6);                // Wait for button to be released
L_main9:
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main10
IT	AL
BAL	L_main9
L_main10:
;Sound.c,84 :: 		if (Button(&GPIOD_IDR,5,1,1))       // RB5 plays Tone3
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main11
;Sound.c,85 :: 		Tone3();
BL	_Tone3+0
L_main11:
;Sound.c,86 :: 		while (GPIOD_IDR.B5);                // Wait for button to be released
L_main12:
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main13
IT	AL
BAL	L_main12
L_main13:
;Sound.c,88 :: 		if (Button(&GPIOD_IDR,4,1,1))       // RB4 plays Melody2
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main14
;Sound.c,89 :: 		Melody2();
BL	_Melody2+0
L_main14:
;Sound.c,90 :: 		while (GPIOD_IDR.B4);                // Wait for button to be released
L_main15:
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main16
IT	AL
BAL	L_main15
L_main16:
;Sound.c,92 :: 		if (Button(&GPIOD_IDR,3,1,1))       // RB3 plays Melody
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main17
;Sound.c,93 :: 		Melody();
BL	_Melody+0
L_main17:
;Sound.c,94 :: 		while (GPIOD_IDR.B3);                // Wait for button to be released
L_main18:
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main19
IT	AL
BAL	L_main18
L_main19:
;Sound.c,95 :: 		}
IT	AL
BAL	L_main3
;Sound.c,96 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
