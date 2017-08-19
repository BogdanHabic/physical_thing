/**************************************************************************************************
* File: MP3_driver.c
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
                         ac:EasyMx7

*       Modules:         MP3 VS1053B on-board module
*                        ac:MP3_Codec
*                        EasyTFT
                         ac:easyTFT
*       Oscillator:      Internal Clock, 72.0000 MHz
*       SW:              mikroC PRO for ARM
*                        http://www.mikroe.com/mikroc/arm/
* NOTES:
*     - Make sure that MMC card is properly formatted (to FAT16 or just FAT)
*       before testing it on this example.
*     - Make sure that MMC card contains appropriate mp3 file ( sound.mp3 ).
**************************************************************************************************/
#include <built_in.h>
#include "MP3_driver.h"

/**************************************************************************************************
* CODEC V1053E connections
**************************************************************************************************/
extern sfr sbit MP3_CS;
extern sfr sbit MP3_RST;
extern sfr sbit BSYNC;
extern sfr sbit DREQ;

/**************************************************************************************************
* Function MP3_SCI_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function writes one byte to MP3 SCI
* Input: register address in codec, data
* Output: Nothing
**************************************************************************************************/
void MP3_SCI_Write(char address, unsigned int data_in) {
  BSYNC = 1;

  MP3_CS = 0;                    // select MP3 SCI
  SPI3_Write(WRITE_CODE);
  SPI3_Write(address);
  SPI3_Write(Hi(data_in));       // high byte
  SPI3_Write(Lo(data_in));       // low byte
  MP3_CS = 1;                    // deselect MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
}

/**************************************************************************************************
* Function MP3_SCI_Read()
* -------------------------------------------------------------------------------------------------
* Overview: Function reads words_count words from MP3 SCI
* Input: start address, word count to be read
* Output: words are stored to data_buffer
**************************************************************************************************/
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
  unsigned int temp;

  MP3_CS = 0;                    // select MP3 SCI
  SPI3_Write(READ_CODE);
  SPI3_Write(start_address);

  while (words_count--) {        // read words_count words byte per byte
    temp = SPI3_Read(0);
    temp <<= 8;
    temp += SPI3_Read(0);
    *(data_buffer++) = temp;
  }
  MP3_CS = 1;                    // deselect MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
}

/**************************************************************************************************
* Function MP3_SDI_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function write one byte to MP3 SDI
* Input: data to be writed
* Output: Nothing
**************************************************************************************************/
void MP3_SDI_Write(char data_) {

  MP3_CS = 1;
  BSYNC = 0;

  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI

  SPI3_Write(data_);
  BSYNC = 1;
}

/**************************************************************************************************
* Function MP3_SDI_Write_32
* -------------------------------------------------------------------------------------------------
* Overview: Function Write 32 bytes to MP3 SDI
* Input: data buffer
* Output: Nothing
**************************************************************************************************/
void MP3_SDI_Write_32(char *data_) {
  char i;

  MP3_CS = 1;
  BSYNC = 0;

  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI

  for (i=0; i<32; i++)
  SPI3_Write(data_[i]);
  BSYNC = 1;
}

/**************************************************************************************************
* Function MP3_Set_Volume()
* -------------------------------------------------------------------------------------------------
* Overview: Function set volume on the left and right channel
* Input: left channel volume, right channel volume
* Output: Nothing
**************************************************************************************************/
void MP3_Set_Volume(char left, char right) {
  unsigned int volume;

  volume = (left<<8) + right;             // calculate value
  MP3_SCI_Write(SCI_VOL_ADDR, volume);    // Write value to VOL register
}

/**************************************************************************************************
* End of File
**************************************************************************************************/