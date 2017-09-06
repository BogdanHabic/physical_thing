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

extern short int DATA_TX[], ADDRESS_short_2[], data_RX_FIFO[], DATA_RX[];
char txt[4];
short int temp1;
short int worker_addr;
short int job_done;

// HB  -> heartbeat
// CW  -> checkout worker
// FW  -> finished work
// ACK -> generic ack message

#define MSG_TYPE_HB 0
#define MSG_TYPE_CW 1
#define MSG_TYPE_FW 2
#define MSG_TYPE_ACK 3

#define POLL_INTERVAL 500
#define MAX_WAIT_TIME 3000

#define MY_ADDR 3
#define INTERFACE_ADDR 1

int numer = 0;

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

void read() {

if(Debounce_INT() == 0 ){
     
    temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
    read_RX_FIFO();

    // GPIOD_ODR = DATA_RX[0];       // Display string on TFT
    if (data_RX_FIFO[7] != MY_ADDR) {
        delay_ms(100);
        return; // Ignore messages that aren't meant for me
    }
    
        ByteToStr(data_RX_FIFO[11], &txt);         // Convert third byte to string
    TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
    TFT_Write_Text(txt, 195, 80);       // Display string on TFT

    delay_ms(100);
     TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
     TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
    
    switch (DATA_RX[0]) {
        case MSG_TYPE_HB:
            break;
        case MSG_TYPE_CW:
            worker_addr = DATA_RX[2];
            break;
        case MSG_TYPE_FW:
            break;
        case MSG_TYPE_ACK:
            job_done = 1;
            break;
    }

}
    delay_ms(100);
}

void do_work() {
    int time = MAX_WAIT_TIME;
    int retries = 0;
    job_done = 0;

    while (!job_done) { // This might make a problem
        if (time >= MAX_WAIT_TIME) {
            time = 0;
            worker_addr = -1;

            while (worker_addr == -1) {
                retries = 0;
                DATA_TX[0] = MSG_TYPE_CW;

                ADDRESS_short_2[0] = INTERFACE_ADDR;
                ADDRESS_short_2[1] = INTERFACE_ADDR;

                write_TX_normal_FIFO();
                while (worker_addr == -1 && retries < 5) {
                    read();
                    retries++;
                }
            }
        }

        DATA_TX[0] = MSG_TYPE_CW;
        DATA_TX[1] = numer++;
        
        ADDRESS_short_2[0] = worker_addr;
        ADDRESS_short_2[1] = worker_addr;
        
        write_TX_normal_FIFO();
        while (!job_done && retries < 30) {
            read();
            retries++;
        }
        time = MAX_WAIT_TIME;
    }
    
    //    ByteToStr("sent", &txt);         // Convert third byte to string
    TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
    TFT_Write_Text("JOB DONE", 195, 80);       // Display string on TFT

    delay_ms(100);
     TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
     TFT_Write_Text("JOB DONE", 195, 80);       // Delete string from TFT
}

void main() {
  int oldstate;
  numer = 1;
  
  GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0);         // Set PA0 as digital input
  GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);
  
  Initialize();                      // Initialize MCU and Bee click board
  DrawFrame();

  oldstate = 0;

  do {
    if (Button(&GPIOA_IDR, 0, 1, 1))                      // detect logical one on PA0 pin
      oldstate = 1;
    if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {        // detect one-to-zero transition on PA0 pin
      oldstate = 0;

      do_work();
    }
  } while(1);
}