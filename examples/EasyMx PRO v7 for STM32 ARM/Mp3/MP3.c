/**************************************************************************************************
* File: MP3_Test.c
* File Type: C - Source Code File
* (C) mikroElektronika, 2010-2012
* Revision History:
*  - Initial version
* Description:
*     This project demonstrates communication with VS1053B mp3 codec.
*     Program reads one mp3 file from MMC and sends it to VS1053B for decoding
*     and playing.
*     MMC and MP3_SCI share Hardware SPI module.
* Test configuration:
*      MCU:              STM32F107VC
                         http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
       Dev.Board:        EasyMx v7 for STM32 ® ARM ®
                         http://www.mikroe.com/easymx-pro/stm32/
*       Modules:         MP3 VS1053B on-board module
*                        ac:MP3_Codec
*                        EasyTFT
                         ac:easyTFT
*       Oscillator:      HSE-PLL, 72.0000 MHz
*       SW:              mikroC PRO for ARM
*                        http://www.mikroe.com/mikroc/arm/
* NOTES:
*     - Make sure that MMC card is properly formatted (to FAT16 or just FAT)
*       before testing it on this example.
*     - Make sure that MMC card contains appropriate mp3 file ( sound.mp3 ).
*     - Turn on SPI and audio switches SW13.1 to SW13.7 and turn on microSD card
*       switches SW14.3 and SW14.4
**************************************************************************************************/
#include <built_in.h>
#include "MP3_Test.h"
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
* MMC Chip Select connection
**************************************************************************************************/
sbit Mmc_Chip_Select           at GPIOD_ODR.B3;
/**************************************************************************************************
* CODEC V1053E connections
**************************************************************************************************/
sbit MP3_CS                    at GPIOC_ODR.B8;
sbit MP3_RST                   at GPIOC_ODR.B7;
sbit BSYNC                     at GPIOC_ODR.B9;
sbit DREQ                      at GPIOC_IDR.B6;

/**************************************************************************************************
* Function MCU_Init()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize MCU
* Input: Nothing
* Output: Nothing
**************************************************************************************************/

void InitMCU(){

  // MP3 config
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_7);    // RST
  GPIO_Digital_Input (&GPIOC_BASE, _GPIO_PINMASK_6);    // DREQ
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_8);    // CS
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);    // DCS

  // Init TFT
  TFT_Init_ILI9341_8bit(320, 240);
  Delay_ms(1000);
  TFT_BLED = 1;
}
/*********************************************************************************************/
void DrawMP3Scr(){
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("MP3  TEST", 95, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("easzM3PROv7", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}
/**************************************************************************************************
* Function MC3_Init()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize MP3 VS1053B codec
* Input: Nothing
* Output: Nothing
**************************************************************************************************/

void MP3_Init(void)
{
  BSYNC = 1;
  MP3_CS = 1;

  // Hardware reset
  MP3_RST = 0;
  Delay_ms(10);
  MP3_RST = 1;

  while (DREQ == 0);

  MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
  MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
  MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz

  // Maximum volume is 0x00 and total silence is 0xFE.
  volume_left  = 0; //0x3F;
  volume_right = 0; //0x3F;
  MP3_Set_Volume(volume_left, volume_right);
}

/**************************************************************************************************
* Function MP3_Start()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize SPI to communicate with MP3 codec
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void MP3_Start(void)
{

  MP3_CS            = 1;               // Deselect MP3_CS
  MP3_RST           = 1;               // Set MP3_RST pin

  BSYNC             = 0;               // Clear BSYNC
  BSYNC             = 1;               // Clear BSYNC

  // Initialize SPIC module
  SPI3_Init_Advanced(_SPI_FPCLK_DIV16, _SPI_MASTER  | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI3_PC10_11_12);

  TFT_BLED = 1;

  TFT_Set_Pen(CL_WHITE, 1);
  TFT_Set_Brush(1, CL_WHITE, 0, 0, 0, 0);

  TFT_Write_Text("1. Initializing VS1053B decoder interface", 30, 80);

  MP3_Init();
  Delay_ms(1000);
}

/**************************************************************************************************
* Function MP3_Test()
* -------------------------------------------------------------------------------------------------
* Overview: Function run the MP3 test
* Input: Nothing
* Output: test status: 0 - skiped; 1 - pass; 2 - fail
**************************************************************************************************/
void MP3_Test(char *test)
{
  unsigned long i;

  // Reset error flag
  *test = 0;

  TFT_Write_Text("2. Initializing MMC_FAT", 30, 100);
  if (Mmc_Fat_Init() == 0) {
    if (Mmc_Fat_Assign(&mp3_filename, 0) ) {
      TFT_Write_Text("3. File Assigned", 30, 120);
      Mmc_Fat_Reset(&file_size);          // Call Reset before file reading,
                                          //   procedure returns size of the file

      TFT_Write_Text("4. Play audio... :)", 30, 140);
      // send file blocks to MP3 SDI
      while (file_size > BUFFER_SIZE)
      {
        for (i=0; i<BUFFER_SIZE; i++)
        {
          Mmc_Fat_Read(mp3_buffer + i);
        }
        for (i=0; i<BUFFER_SIZE/BYTES_2_WRITE; i++) {
          MP3_SDI_Write_32(mp3_buffer + i*BYTES_2_WRITE);
        }

        file_size -= BUFFER_SIZE;

//        Check_TP();
//        if (ucMP3_run_test == 0)return;
     }

      // send the rest of the file to MP3 SDI
      for (i=0; i<file_size; i++)
      {
        Mmc_Fat_Read(mp3_buffer + i);
      }

      for (i=0; i<file_size; i++)
      {
        MP3_SDI_Write(mp3_buffer[i]);
      }

      TFT_Write_Text("5. Finish!", 30, 160);
    }
    else {

      TFT_Write_Text("3. File not assigned", 30, 120);
      *test = 2;
    }
  }
  else {
    TFT_Write_Text("3. MMC FAT not initialized", 30, 120);
    *test = 2;
  }
}

/**************************************************************************************************
* main function
**************************************************************************************************/

void main(){
  InitMCU();
  DrawMP3Scr();

  MP3_Start();
  MP3_Test(&ucMP3_run_test);
}