/**************************************************************************************************
* File: SF_driver.h
* File Type: C - Header File
* Company: (c) mikroElektronika, 2011
* Revision History:
*     20111115 (DA):
*       - initial release;
*     20111117 (JK);
*       - revision;
* Description:
*     This module contains a set of functions that are used for communication with
*     Serial Flash.
* Test configuration:
*     MCU:             STM32F107VC
*                      http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00220364.pdf
*     Dev.Board:       EasyMx PRO v7 for STM32(R) ARM(R)
*                      http://www.mikroe.com/easymx-pro/stm32/
*                      ac:tft_touchpanel
*                      ac:serial-flash
*
*     Oscillator:      HSE-PLL, 72.000MHz
*     SW:              mikroC PRO for ARM
*                      http://www.mikroe.com/mikroc/arm/
* NOTES:
*     Serial Flash use SPI bus to communicate with MCU.
*     Turn on TFT backlight on SW11.3
*     Turn on SPI lines at SW13.1, SW13.2, sw13.3 and Serial Flash CS at SW13.8
**************************************************************************************************/

/**************************************************************************************************
* Serial Flash Chip Select connection
**************************************************************************************************/
sbit CS_Serial_Flash_bit           at GPIOD_ODR.B7;
/*************************************************************************************************/
// Constans
static const unsigned short _SERIAL_FLASH_CMD_RDID  = 0x9F;    // 25P80
static const unsigned short _SERIAL_FLASH_CMD_READ  = 0x03;
static const unsigned short _SERIAL_FLASH_CMD_WRITE = 0x02;
static const unsigned short _SERIAL_FLASH_CMD_WREN  = 0x06;
static const unsigned short _SERIAL_FLASH_CMD_RDSR  = 0x05;
static const unsigned short _SERIAL_FLASH_CMD_ERASE = 0xC7;    // 25P80
static const unsigned short _SERIAL_FLASH_CMD_EWSR  = 0x06;    // 25P80
static const unsigned short _SERIAL_FLASH_CMD_WRSR  = 0x01;
static const unsigned short _SERIAL_FLASH_CMD_SER   = 0xD8;    //25P80

// Functions
void SerialFlash_init();
void SerialFlash_WriteEnable();
unsigned char SerialFlash_IsWriteBusy();
void SerialFlash_WriteByte(unsigned char _data, unsigned long address);
void SerialFlash_WriteWord(unsigned int _data, unsigned long address);
unsigned char SerialFlash_ReadID(void);
unsigned char SerialFlash_ReadByte(unsigned long address);
unsigned int SerialFlash_ReadWord(unsigned long address);
unsigned char SerialFlash_WriteArray(unsigned long address, unsigned char* pData, unsigned int nCount);
void SerialFlash_ReadArray(unsigned long address, unsigned char* pData, unsigned int nCount);
void SerialFlash_ChipErase(void);
void SerialFlash_ResetWriteProtection();
void SerialFlash_SectorErase(unsigned long address);

/**************************************************************************************************
* End of File
**************************************************************************************************/