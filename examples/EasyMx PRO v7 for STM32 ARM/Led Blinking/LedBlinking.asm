_main:
;LedBlinking.c,23 :: 		void main() {
;LedBlinking.c,24 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_ALL); // Set PORTA as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;LedBlinking.c,25 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL); // Set PORTB as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;LedBlinking.c,26 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL); // Set PORTC as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;LedBlinking.c,27 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL); // Set PORTD as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;LedBlinking.c,28 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL); // Set PORTE as digital output
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;LedBlinking.c,30 :: 		GPIOA_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,31 :: 		GPIOB_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,32 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,33 :: 		GPIOD_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,34 :: 		GPIOE_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,37 :: 		while(1) {
L_main0:
;LedBlinking.c,38 :: 		if(a ==  0){
MOVW	R0, #lo_addr(_a+0)
MOVT	R0, #hi_addr(_a+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main2
;LedBlinking.c,39 :: 		GPIOA_ODR = ~GPIOB_ODR; // Toggle PORTA
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,40 :: 		GPIOB_ODR = ~GPIOB_ODR; // Toggle PORTB
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,41 :: 		GPIOC_ODR = ~GPIOC_ODR; // Toggle PORTC
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,42 :: 		GPIOD_ODR = ~GPIOD_ODR; // Toggle PORTD
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,43 :: 		GPIOE_ODR = ~GPIOE_ODR; // Toggle PORTE
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,45 :: 		}else{
IT	AL
BAL	L_main3
L_main2:
;LedBlinking.c,46 :: 		GPIOA_ODR = 3; // Toggle PORTA
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,47 :: 		GPIOB_ODR = 3; // Toggle PORTB
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,48 :: 		GPIOC_ODR = 3; // Toggle PORTC
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,49 :: 		GPIOD_ODR = 3; // Toggle PORTD
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,50 :: 		GPIOE_ODR = 3; // Toggle PORTE
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;LedBlinking.c,51 :: 		}
L_main3:
;LedBlinking.c,52 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;LedBlinking.c,53 :: 		}
IT	AL
BAL	L_main0
;LedBlinking.c,54 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
