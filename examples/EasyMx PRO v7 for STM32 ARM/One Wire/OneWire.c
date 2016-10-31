
/*
 * Project name:
     OneWire (Interfacing the DS1820 temperature sensor - all versions)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
       - initial release;
 * Description:
     This code demonstrates one-wire communication with temperature sensor
     DS18x20 connected to PB10 pin.
     MCU reads temperature from the sensor and prints it on the TFT.
     The display format of the temperature is 'xxx.xxxx°C'. To obtain correct
     results, the 18x20's temperature resolution has to be adjusted (constant
     TEMP_RESOLUTION).
* Test configuration:
     Device:          STM32F105VB
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:temperature_sensor                      
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    EasyTFT
                      http://www.mikroe.com/add-on-boards/display/easytft/
                      ac:EasyTFT                      
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Place DS1820 sensor on board. Turn DS1820 switch at SW14.5. Turn on TFT backlight at SW11 switch.
 */

// TFT module connections
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;
// End TFT module connections

//  Set TEMP_RESOLUTION to the corresponding resolution of used DS18x20 sensor:
//  18S20: 9  (default setting; can be 9,10,11,or 12)
//  18B20: 12
#include "Resources.h"
const unsigned short TEMP_RESOLUTION = 9;

char *text = "000.0000  C";
unsigned temp;

void DrawScr() {
  TFT_Init_ILI9341_8bit(320, 240);
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("Temperature Sensor (One Wire)", 10, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMx PRO v7 for STM32", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}

void Display_Temperature(unsigned int temp2write) {
  const unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
  char temp_whole;
  unsigned int temp_fraction;

  // Check if temperature is negative
  if (temp2write & 0x8000) {
    text[0] = '-';
    temp2write = ~temp2write + 1;
  }

  // Extract temp_whole
  temp_whole = temp2write >> RES_SHIFT ;

  // Convert temp_whole to characters
  if (temp_whole/100)
    text[0] = temp_whole/100  + 48;
  else
    text[0] = '0';

  text[1] = (temp_whole/10)%10 + 48;             // Extract tens digit
  text[2] =  temp_whole%10     + 48;             // Extract ones digit

  // Extract temp_fraction and convert it to unsigned int
  temp_fraction  = temp2write << (4-RES_SHIFT);
  temp_fraction &= 0x000F;
  temp_fraction *= 625;

  // Convert temp_fraction to characters
  text[4] =  temp_fraction/1000    + 48;         // Extract thousands digit
  text[5] = (temp_fraction/100)%10 + 48;         // Extract hundreds digit
  text[6] = (temp_fraction/10)%10  + 48;         // Extract tens digit
  text[7] =  temp_fraction%10      + 48;         // Extract ones digit
  text[9] = 176;

  // Print temperature on TFT
   TFT_Set_Brush(1,CL_WHITE,0,0,0,0);
   TFT_Set_Pen(CL_WHITE,1);
   TFT_Rectangle(85,100,150,140);
   TFT_Set_Font(&tahoma29x29_Bold, CL_RED, FO_HORIZONTAL);
   TFT_Write_Text(text, 85, 100);
}

void main() {

  TFT_Set_Default_Mode();
  DrawScr();

  TFT_Set_Font(&tahoma29x29_Bold, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("Temperature:  ", 75, 65);

  // Main loop
  do {
    // Perform temperature reading
    Ow_Reset(&GPIOB_BASE, 10);                         // Onewire reset signal
    Ow_Write(&GPIOB_BASE, 10, 0xCC);                   // Issue command SKIP_ROM
    Ow_Write(&GPIOB_BASE, 10, 0x44);                   // Issue command CONVERT_T
    Delay_ms(750);

    Ow_Reset(&GPIOB_BASE, 10);
    Ow_Write(&GPIOB_BASE, 10, 0xCC);                   // Issue command SKIP_ROM
    Ow_Write(&GPIOB_BASE, 10, 0xBE);                   // Issue command READ_SCRATCHPAD

    temp =  Ow_Read(&GPIOB_BASE, 10);
    temp = (Ow_Read(&GPIOB_BASE, 10) << 8) + temp;

    // Format and display result on TFT
    Display_Temperature(temp);

  } while (1);

}