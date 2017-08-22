/*
 * Project name:
     BEE Click Receiver (Using mikroE's BEE click Board)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20120521:
       - initial release (JK and DO)
 * Description:
     This project is a simple demonstration of working with the BEE click board.
     The transmitter sends the data and the receiver displays it on the TFT.
     The on-board MRF24J40MA is a 2.4 GHz IEEE 802.15.4 radio transceiver module
     and operates in the 2.4GHz frequency band.
     Detailed information about MRF24J40 module is availabe here:
     http://ww1.microchip.com/downloads/en/DeviceDoc/DS-39776b.pdf
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00220364.pdf
     Dev.Board:       EasyMx PRO v7 for STM32
                      http://www.mikroe.com/eng/products/view/852/easymx-pro-v7-for-stm32/
     Oscillator:      HS-PLL 72.0000 MHz, internal 8.0000 MHz RC
     Ext. Modules:    BEE Click Board  - ac:BEE_Click
                      http://www.mikroe.com/eng/products/view/810/bee-click/
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Place microSD click board in the mikroBUS socket 1.
 */

#include "resources.h"
#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"
#include "Init_Routines.h"

// BEE Click Board connections
sbit CS at GPIOD_ODR.B13;                // CS pin
sbit RST at GPIOC_ODR.B2;                // RST pin
sbit INT at GPIOD_ODR.B10;               // INT pin
sbit WAKE_ at GPIOA_ODR.B4;              // WAKE pin

extern short int DATA_RX[];
short int temp1;
char txt[4];

#define NULL 0

#define STATE_UNDEFINED -1
#define STATE_IDLE 0
#define STATE_RUNNING 1

typedef struct Worker {
    short int state;
    short int ticks;
    short int address[2];
} Worker;

// State

#define NUM_WORKERS 5
#define MAX_NUM_TICKS 6

Worker workers[NUM_WORKERS];

// short int states[NUM_WORKERS];
// short int ticks[NUM_WORKERS];
// short int addresses[NUM_WORKERS][2];

// End-State

void DrawFrame(){
  TFT_Init_ILI9341_8bit(320,240);
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_BLACK, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("BEE  Click  Board  Demo", 50, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMx PRO v7", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("Received data : ", 90, 80);
}

void Timer2_interrupt() iv IVT_INT_TIM2 {        // iv-> hendler za tajmerski prekid
    int i;
    TIM2_SR.UIF = 0;                                //Kada se prekid desi, postavlja se fleg TIM2_SR.UIF
    // On every tick increment the ticks of all the workers:
    //        * If a worker exceeds the maximum number of ticks, remove it from the worker array

    for (i = 0; i < NUM_WORKERS; i++) {
       if (workers[i]->state == STATE_UNDEFINED) {
           continue;
       }
       if (workers[i]->ticks > MAX_NUM_TICKS) {
           workers[i]->state = STATE_UNDEFINED;
       } else {
           workers[i]->ticks++;
       }
    }
}

void start_timer() {
    RCC_APB1ENR.TIM2EN = 1;       // koristimo TIM2
    TIM2_CR1.CEN = 0;             // privremeno iskljuèujemo TIM2
    TIM2_PSC = 1098;              // podesavamo preskaler(tj dvobajtnu vrednost sa kojom se deli frekvencija tajmera(tj TIM2_ARR) )
    TIM2_ARR = 65514;                // granica brojaèa  ili broj od kojeg se kreæe, pa se dekrementira,ili do kog treba da se doðe inkrementiranjem.
                                        //   65514/ 1098 = 59,66667 (tj 1 sekunda)
    NVIC_IntEnable(IVT_INT_TIM2); // omoguæavamo prekid IVT_INT_TIM2
    TIM2_DIER.UIE = 1;            // omoguæavamo update prekidza TIM2
    TIM2_CR1.CEN = 1;             // ponovo ukljuèujemo TIM2
}

void heart_beat(short int addressA, short int addressB) {
    int i;
    int free_spot = -1;
    for (i = 0; i < NUM_WORKERS; i++) {
        if (workers[i]->state != STATE_UNDEFINED && free_spot == -1) {
            free_spot = i;
        }
        if (workers[i]->state != STATE_UNDEFINED && workers[i]->address[0] == addressA && workers[i]->address[1] == addressB) {
            workers[i]->ticks = 0;
            return;
        }
    }
    
    if (free_spot == -1) {
       return; // No more free spots
    }
    
    workers[free_spot]->state = STATE_IDLE;
    workers[free_spot]->ticks = 0;
    workers[free_spot]->address[0] = addressA;
    workers[free_spot]->address[1] = addressB;
}

void print_result(char *result) {
    //@TODO(bogdan)
}

void finish_work(char *result, short int addressA, short int addressB) {
    int i;
    for (i = 0; i < NUM_WORKERS; i++) {
        if (workers[i]->state != STATE_UNDEFINED && workers[i]->address[0] == addressA && workers[i]->address[1] == addressB) {
            workers[i]->ticks = 0;
            workers[i]->state = STATE_IDLE;
            print_result(result);
            //@TODO(bogdan): Reply with ack
            return;
        }
    }
}

Worker* undefined_worker() {
    struct Worker *w;

    w->state = STATE_UNDEFINED;
    w->ticks = 0;
    w->address[0] = 0;
    w->address[1] = 0;
    
    return w;
}

void checkout(short int sensorAddressA, short int sensorAddressB) {
    int i;

    for (i = 0; i < NUM_WORKERS; i++) {
        if (workers[i]->state == STATE_IDLE) {
            workers[i]->state = STATE_RUNNING;
            //@TODO(bogdan): Reply with worker address
        }
    }
}

void InitializeWorkers() {
    int i;
    // workers = malloc(NUM_WORKERS * sizeof(struct Worker));
    for (i = 0; i < NUM_WORKERS; i++) {
        workers[i] = *undefined_worker();
    }
}

void main() {
  GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);

  Initialize();                           // Initialize MCU and Bee click board
  InitializeWorkers();
  start_timer();
  
  while(1) {                               // Infinite loop
    if(Debounce_INT() == 0 ){             // Debounce line INT
      temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
      read_RX_FIFO();                     // Read receive data
      ByteToStr(DATA_RX[0],&txt);         // Convert third byte to string
      TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
      TFT_Write_Text(txt, 195, 80);       // Display string on TFT
      delay_ms(1000);
      TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
      TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
      
      GPIOD_ODR = DATA_RX[0];
    }
  }
}
