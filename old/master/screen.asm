_USB0Interrupt:
;screen.c,39 :: 		void USB0Interrupt() iv IVT_INT_OTG_FS{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,40 :: 		USB_Interrupt_Proc();
BL	_USB_Interrupt_Proc+0
;screen.c,41 :: 		}
L_end_USB0Interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB0Interrupt
_Timer2_interrupt:
;screen.c,43 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {        // iv-> hendler za tajmerski prekid
;screen.c,44 :: 		TIM2_SR.UIF = 0;                                //Kada se prekid desi, postavlja se fleg TIM2_SR.UIF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;screen.c,45 :: 		if(curr_state == STATE_RUNNING) {
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_Timer2_interrupt0
;screen.c,46 :: 		seconds++;
MOVW	R1, #lo_addr(_seconds+0)
MOVT	R1, #hi_addr(_seconds+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;screen.c,47 :: 		}
L_Timer2_interrupt0:
;screen.c,48 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_Initialize:
;screen.c,50 :: 		void Initialize() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;screen.c,51 :: 		RCC_APB1ENR.TIM2EN = 1;       // koristimo TIM2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;screen.c,52 :: 		TIM2_CR1.CEN = 0;             // privremeno iskljuèujemo TIM2
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;screen.c,53 :: 		TIM2_PSC = 1098;              // podesavamo preskaler(tj dvobajtnu vrednost sa kojom se deli frekvencija tajmera(tj TIM2_ARR) )
MOVW	R1, #1098
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;screen.c,54 :: 		TIM2_ARR = 65514;                // granica brojaèa – ili broj od kojeg se kreæe, pa se dekrementira,ili do kog treba da se doðe inkrementiranjem.
MOVW	R1, #65514
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;screen.c,56 :: 		NVIC_IntEnable(IVT_INT_TIM2); // omoguæavamo prekid IVT_INT_TIM2
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;screen.c,57 :: 		TIM2_DIER.UIE = 1;            // omoguæavamo update prekidza TIM2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;screen.c,58 :: 		TIM2_CR1.CEN = 1;             // ponovo ukljuèujemo TIM2
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;screen.c,59 :: 		HID_Enable(&readbuff,&writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;screen.c,60 :: 		}
L_end_Initialize:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Initialize
_main:
;screen.c,62 :: 		void main(void) {
;screen.c,64 :: 		Initialize();
BL	_Initialize+0
;screen.c,65 :: 		while (1) {
L_main1:
;screen.c,67 :: 		if (!HID_Read() && curr_state == STATE_RUNNING) {
BL	_HID_Read+0
CMP	R0, #0
IT	NE
BNE	L__main15
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__main14
L__main13:
;screen.c,68 :: 		writebuff[0] = seconds;
MOVW	R0, #lo_addr(_seconds+0)
MOVT	R0, #hi_addr(_seconds+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRH	R1, [R0, #0]
;screen.c,69 :: 		while(!HID_Write(&writebuff,64))
L_main6:
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
CMP	R0, #0
IT	NE
BNE	L_main7
;screen.c,70 :: 		;
IT	AL
BAL	L_main6
L_main7:
;screen.c,71 :: 		continue;
IT	AL
BAL	L_main1
;screen.c,67 :: 		if (!HID_Read() && curr_state == STATE_RUNNING) {
L__main15:
L__main14:
;screen.c,73 :: 		cnt = readbuff[0];
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
; cnt start address is: 4 (R1)
LDRB	R1, [R0, #0]
;screen.c,75 :: 		if(cnt == MSG_START) {
LDRB	R0, [R0, #0]
CMP	R0, #83
IT	NE
BNE	L_main8
; cnt end address is: 4 (R1)
;screen.c,76 :: 		curr_state = STATE_RUNNING;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
STRH	R1, [R0, #0]
;screen.c,77 :: 		} else if (cnt == MSG_RESET) {
IT	AL
BAL	L_main9
L_main8:
; cnt start address is: 4 (R1)
CMP	R1, #82
IT	NE
BNE	L_main10
; cnt end address is: 4 (R1)
;screen.c,78 :: 		seconds = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_seconds+0)
MOVT	R0, #hi_addr(_seconds+0)
STRH	R1, [R0, #0]
;screen.c,79 :: 		} else if (cnt == MSG_PAUSE) {
IT	AL
BAL	L_main11
L_main10:
; cnt start address is: 4 (R1)
CMP	R1, #80
IT	NE
BNE	L_main12
; cnt end address is: 4 (R1)
;screen.c,80 :: 		curr_state = STATE_PAUSE;
MOVS	R1, #2
SXTH	R1, R1
MOVW	R0, #lo_addr(_curr_state+0)
MOVT	R0, #hi_addr(_curr_state+0)
STRH	R1, [R0, #0]
;screen.c,81 :: 		}
L_main12:
L_main11:
L_main9:
;screen.c,82 :: 		}
IT	AL
BAL	L_main1
;screen.c,83 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
