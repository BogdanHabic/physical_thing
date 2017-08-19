/*
 * Project name:
     LM35 Sensor (Temperature measurement)
 * Copyright:
     (c) Mikroelektronika, 2011.
 * Revision History:
     20110929:
       - initial release;
 * Description:
      A simple example of using the LM35 sensor.
      Temperature is displayed on TFT.
 * Test configuration:
     Device:          STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM(R) ARM(R) - ac:LM35
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    LM35 Sensor
                      http://www.mikroe.com/store/components/various/
                      EasyTFT
                      http://www.mikroe.com/add-on-boards/display/easytft/
                      ac:EasyTFT
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Put LM35 sensor in proper position and turn on LM35 switch at SW14.6
     - Turn on TFT backlight switch SW11.3 (board specific)
 */

#include "Resources.h"

// TFT module connections
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;
// End TFT module connections

const unsigned long VREF = 1800;   // Voltage reference in mV

char txt[15] = "000.0   C";

void DrawScr() {
  TFT_Init_ILI9341_8bit(320, 240);
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("Temperature  Sensor  (LM35)", 10, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMx PRO v7 for STM32", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}

void Display_Temperature(unsigned long temp_mV) {
  ByteToStr(temp_mV/10, txt);
  txt[3] = '.';
  txt[4] = temp_mV % 10 + 48;
  txt[7] = 176;

  // Print temperature on TFT
  TFT_Set_Brush(1,CL_WHITE,0,0,0,0);
  TFT_Set_Pen(CL_WHITE,1);
  TFT_Rectangle(85,100,200,140);
  TFT_Set_Font(&tahoma29x29_Bold, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text(txt, 85, 100);
}

void main() {
  unsigned long temp;
  
  TFT_Set_Default_Mode();
  DrawScr();

  TFT_Set_Font(&tahoma29x29_Bold, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("Temperature:  ", 75, 65);

  ADC_Set_Input_Channel(_ADC_CHANNEL_10);
  ADC1_Init();                        // Initialize ADC

  do {
    temp = ADC1_Get_Sample(10);
    temp = (temp * VREF) / 4095;
    Display_Temperature(temp);
    Delay_ms(1000);
  } while(1);
}