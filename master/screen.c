/*
 * Project name:
      TouchPanelCalibrationAndWrite
 * Copyright:
      (c) mikroElektronika, 2012
 * Revision History:
      20120904
      - Initial release
 * Description:
           This code works with TouchPanel and GLCD. Two digital output and
           two analog input signals are used for communication with TouchPanel.
           This example shows how to calibrate touch panel and how to write on the screen.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev. Board:      EasyMx PRO v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                   nel
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/

 * NOTES:
      - Turn ON Touch Panel controller switches at SW11.
      - Turn ON Back Light switches at SW11.
*/

#define STATE_RUNNING 1
#define STATE_PAUSE 2

#define MSG_START 'S'
#define MSG_RESET 'R'
#define MSG_PAUSE 'P'

int seconds = 0;
char readbuff[64];
int writebuff[32];
int curr_state = STATE_PAUSE;

void USB0Interrupt() iv IVT_INT_OTG_FS{
  USB_Interrupt_Proc();
}

void Timer2_interrupt() iv IVT_INT_TIM2 {        // iv-> hendler za tajmerski prekid
  TIM2_SR.UIF = 0;                                //Kada se prekid desi, postavlja se fleg TIM2_SR.UIF
  if(curr_state == STATE_RUNNING) {
      seconds++;
  }
}

void Initialize() {
    RCC_APB1ENR.TIM2EN = 1;       // koristimo TIM2
    TIM2_CR1.CEN = 0;             // privremeno iskljuèujemo TIM2
    TIM2_PSC = 1098;              // podesavamo preskaler(tj dvobajtnu vrednost sa kojom se deli frekvencija tajmera(tj TIM2_ARR) )
    TIM2_ARR = 65514;                // granica brojaèa – ili broj od kojeg se kreæe, pa se dekrementira,ili do kog treba da se doðe inkrementiranjem.
                                        //   65514/ 1098 = 59,66667 (tj 1 sekunda)
    NVIC_IntEnable(IVT_INT_TIM2); // omoguæavamo prekid IVT_INT_TIM2
    TIM2_DIER.UIE = 1;            // omoguæavamo update prekidza TIM2
    TIM2_CR1.CEN = 1;             // ponovo ukljuèujemo TIM2
    HID_Enable(&readbuff,&writebuff);
}

void main(void) {
  char cnt;
  Initialize();
    while (1) {
        // call print_timers() inside this loop.
        if (!HID_Read() && curr_state == STATE_RUNNING) {
           writebuff[0] = seconds;
           while(!HID_Write(&writebuff,64))
           ;
           continue;
        }
        cnt = readbuff[0];
        
        if(cnt == MSG_START) {
            curr_state = STATE_RUNNING;
        } else if (cnt == MSG_RESET) {
            seconds = 0;
        } else if (cnt == MSG_PAUSE) {
            curr_state = STATE_PAUSE;
        }
    }
}