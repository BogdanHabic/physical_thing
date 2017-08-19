#line 1 "C:/Users/lazar/Desktop/physical_thing-master/master/screen.c"
#line 34 "C:/Users/lazar/Desktop/physical_thing-master/master/screen.c"
int seconds = 0;
char readbuff[64];
int writebuff[32];
int curr_state =  2 ;

void USB0Interrupt() iv IVT_INT_OTG_FS{
 USB_Interrupt_Proc();
}

void Timer2_interrupt() iv IVT_INT_TIM2 {
 TIM2_SR.UIF = 0;
 if(curr_state ==  1 ) {
 seconds++;
 }
}

void Initialize() {
 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = 1098;
 TIM2_ARR = 65514;

 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;
 HID_Enable(&readbuff,&writebuff);
}

void main(void) {
 char cnt;
 Initialize();
 while (1) {

 if (!HID_Read() && curr_state ==  1 ) {
 writebuff[0] = seconds;
 while(!HID_Write(&writebuff,64))
 ;
 continue;
 }
 cnt = readbuff[0];

 if(cnt ==  'S' ) {
 curr_state =  1 ;
 } else if (cnt ==  'R' ) {
 seconds = 0;
 } else if (cnt ==  'P' ) {
 curr_state =  2 ;
 }
 }
}
