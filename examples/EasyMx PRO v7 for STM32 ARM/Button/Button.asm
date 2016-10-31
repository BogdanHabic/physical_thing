_main:
;Button.c,26 :: 		void main() {
;Button.c,28 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0);         // Set PA0 as digital input
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;Button.c,29 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_ALL);      // Set PORTD as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Button.c,30 :: 		oldstate = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
STRH	R1, [R0, #0]
;Button.c,32 :: 		do {
L_main0:
;Button.c,33 :: 		if (Button(&GPIOA_IDR, 0, 1, 1))                      // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main3
;Button.c,34 :: 		oldstate = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
STRH	R1, [R0, #0]
L_main3:
;Button.c,35 :: 		if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {        // detect one-to-zero transition on PA0 pin
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main9
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main8
L__main7:
;Button.c,36 :: 		GPIOD_ODR = ~GPIOD_ODR;                             // invert PORTD value
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Button.c,37 :: 		oldstate = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate+0)
MOVT	R0, #hi_addr(_oldstate+0)
STRH	R1, [R0, #0]
;Button.c,35 :: 		if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {        // detect one-to-zero transition on PA0 pin
L__main9:
L__main8:
;Button.c,39 :: 		} while(1);                                             // endless loop
IT	AL
BAL	L_main0
;Button.c,40 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
