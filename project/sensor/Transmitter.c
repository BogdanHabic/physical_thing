/*
 * Project name:
     BEE Click Transmitter (Using mikroE's BEE click Board)
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

#define POLL_INTERVAL 500
#define MAX_WAIT_TIME 3000

// BEE Click Board connections
sbit CS at GPIOD_ODR.B13;                // CS pin
sbit RST at GPIOC_ODR.B2;                // RST pin
sbit INT at GPIOD_ODR.B10;               // INT pin
sbit WAKE_ at GPIOA_ODR.B4;              // WAKE pin

// TFT module connections

// End TFT module connections

extern short int DATA_TX[];
char txt[4];
short int worker_addr[2];
short int job_done;

void read() {
    temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
    read_RX_FIFO();                     // Read receive data
    // ByteToStr(DATA_RX[0],&txt);         // Convert third byte to string
    // TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
    // TFT_Write_Text(txt, 195, 80);       // Display string on TFT
    // delay_ms(1000);
    // TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
    // TFT_Write_Text(txt, 195, 80);       // Delete string from TFT

    // GPIOD_ODR = DATA_RX[0];
    
    if (data_RX_FIFO[7] != MY_ADDR || data_RX_FIFO[8] != MY_ADDR) {
        return; // Ignore messages that aren't meant for me
    }

    switch (DATA_RX[0]) {
        case MSG_TYPE_HB:
            break;
        case MSG_TYPE_CW:
            worker_addr[0] = DATA_RX[2];
            worker_addr[1] = DATA_RX[3];
            break;
        case MSG_TYPE_FW:
            break;
        case MSG_TYPE_ACK:
            job_done = 1;
            break;
    }

    delay_ms(100);
}

void do_work() {
    int time = MAX_WAIT_TIME;
    job_done = 0;

    while (!job_done) { // This might make a problem
        if (time == MAX_WAIT_TIME) {
            time = 0;
            worker_addr[0] = -1;
            worker_addr[1] = -1;

            while (worker_addr[0] == -1 && worker_addr[1] == -1) {
                DATA_TX[0] = MSG_TYPE_CW;

                ADDRESS_short_2[0] = INTERFACE_ADDR;
                ADDRESS_short_2[1] = INTERFACE_ADDR;

                write_TX_normal_FIFO();

                read();
            }
        }

        DATA_TX[0] = MSG_TYPE_CW;
        DATA_TX[1] = 3;

        read();

        if (!job_done) {
            time += POLL_INTERVAL;
            delay_ms(POLL_INTERVAL);
        }
    }
}

void DrawFrame(){
  TFT_Init_ILI9341_8bit(320,240);
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_BLACK, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("BEE  Click  Board  Demo", 55, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMx PRO v7", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("Transmitted data : ", 90, 80);
}

void main() {
  Initialize();                      // Initialize MCU and Bee click board
  DrawFrame();
  
  while(1) {                         // Infinite loop
    //@TODO(bogdan): Check for button click
  }
}
