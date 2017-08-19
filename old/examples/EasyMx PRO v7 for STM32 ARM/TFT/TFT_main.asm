_main:
;TFT_main.c,25 :: 		void main() {
;TFT_main.c,27 :: 		Start_TP();
BL	_Start_TP+0
;TFT_main.c,29 :: 		while (1) {
L_main0:
;TFT_main.c,31 :: 		}
IT	AL
BAL	L_main0
;TFT_main.c,33 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
