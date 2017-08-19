/**************************************************************************************************
* File: Serial_Flash.c
* File Type: C - Source Code File
* Company: (c) mikroElektronika, 2011
* Revision History:
*       - initial release;
* Description:
*     This module contains a set of functions that are used for communication with
*     Serial Flash.
* Test configuration:
*     MCU:             STM32F107VC
*                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
*     Dev.Board:       EasyMx PRO v7 for STM32(R) ARM(R)
*                      http://www.mikroe.com/easymx-pro/stm32/
*                      ac:tft_touchpanel
*                      ac:serial-flash
*     Oscillator:      HSE-PLL, 72.000MHz
*     SW:              mikroC PRO for ARM
*                      http://www.mikroe.com/mikroc/arm/
* NOTES:
*     Serial Flash use SPI bus to communicate with MCU.
*     Turn on TFT backlight on SW11.3
*     Turn on SPI lines at SW13.1, SW13.2, sw13.3 and Serial Flash CS at SW13.8
**************************************************************************************************/
#define _DATA_ARRAY_SIZE 16
#include <built_in.h>
#include "Serial_Flash.h"
#include "resources.h"

// TFT module connections
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;
// End TFT module connections

/**************************************************************************************************
* Serial Flash Chip Select connection
**************************************************************************************************/

char cSF_test_status;
/*************************************************************************************************
* Init MCU function
**************************************************************************************************/
void InitMCU(){
// SPI config
  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);
}
/*********************************************************************************************/
void DrawSFScr(){
  TFT_Init_ILI9341_8bit(320,240);
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("SERIAL  FLASH", 95, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMxv7s", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}
/**************************************************************************************************
* Function SF_Start()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize SPI bus and serial flash
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void SF_Start() {
  SPI3_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI3_PC10_11_12);
  TFT_BLED = 1;
  TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Set_Pen(CL_WHITE, 1);
  TFT_Set_Brush(1, CL_WHITE, 0, 0, 0, 0);
  SerialFlash_init();
  SerialFlash_WriteEnable();
  Delay_ms(500);
}

/**************************************************************************************************
* Function SF_Test()
* -------------------------------------------------------------------------------------------------
* Overview: Function run the serial flash test
* Input: Nothing
* Output: test status: 0 - skiped; 1 - pass; 2 - fail
**************************************************************************************************/
void SF_Test(char *test)
{
  unsigned char temp, SerialFlashID, txt[12];
  unsigned char i, success;

  // Reset error flag
  *test = 0;

  // Erase entire flash
  TFT_Write_Text("1. Erasing chip... ", 90, 65);
  SerialFlash_ChipErase();
  TFT_Write_Text("Done!", 200, 65);

  // Read Flash ID
  SerialFlashID = SerialFlash_ReadID();
  ByteToStr(SerialFlashID, txt);
  TFT_Write_Text("2. Flash ID:", 90, 85);
  TFT_Write_Text(txt, 170, 85);
  Delay_ms(500);

  // Write and read back a single byte
  temp = 221;
  TFT_Write_Text("3. Writting:", 90, 105);
  ByteToStr(temp, txt);
  TFT_Write_Text(txt, 170, 105);
  SerialFlash_WriteByte(temp, 0x123456);

  TFT_Write_Text("4. Reading: ", 90, 125);
  temp = SerialFlash_ReadByte(0x123456);
  ByteToStr(temp, txt);
  TFT_Write_Text(txt, 170, 125);
  Delay_ms(500);

  // Write the repetitive pattern of data to fill the first 4K of memory
  // and then read the entire flash again and check the data correctness
  TFT_Write_Text("5. Writing array...", 90, 145);
  SerialFlash_WriteArray(0x0000, &write_array, _DATA_ARRAY_SIZE);
  Delay_ms(500);

  TFT_Write_Text("6. Reading array...", 90, 165);
  SerialFlash_ReadArray(0x0000, &read_array, _DATA_ARRAY_SIZE);
  Delay_ms(500);
  success = 1;

  for (i = 0; i<_DATA_ARRAY_SIZE; i++)
  {
    if (read_array[i] != write_array[i])
    {
      success = 0;
      break;
    }
  }

  if (success)
  {
    TFT_Write_Text("7. Success - Full match!", 90, 185);
    *test = 1;
  }
  else
  {
    TFT_Write_Text("7. Failed", 90, 185);
    *test = 2;
  }
}

/**************************************************************************************************
* main function
**************************************************************************************************/

void main(){
  InitMCU();
  DrawSFScr();
  SF_Start();
  SF_Test(&cSF_test_status);
}