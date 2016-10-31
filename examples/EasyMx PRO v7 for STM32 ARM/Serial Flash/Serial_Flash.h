/**************************************************************************************************
* File: SF_Test.h
* File Type: C - Header File
* Company: (c) mikroElektronika, 2011
* Revision History:
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

// Global Variables
unsigned char Refresh_Cmd_Menu = 1;
unsigned char write_array[_DATA_ARRAY_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
unsigned char read_array[_DATA_ARRAY_SIZE] = {0};

// Functions
void SF_Start(void);
void SF_Test(char *err);

//- Imported from SF_DRIVER.H ---------------------------------------------------------------------
extern void SerialFlash_init();
extern void SerialFlash_WriteEnable();
extern unsigned char SerialFlash_IsWriteBusy();
extern void SerialFlash_WriteByte(unsigned char _data, unsigned long address);
extern void SerialFlash_WriteWord(unsigned int _data, unsigned long address);
extern unsigned char SerialFlash_ReadID(void);
extern unsigned char SerialFlash_ReadByte(unsigned long address);
extern unsigned int SerialFlash_ReadWord(unsigned long address);
extern unsigned char SerialFlash_WriteArray(unsigned long address, unsigned char* pData, unsigned int nCount);
extern void SerialFlash_ReadArray(unsigned long address, unsigned char* pData, unsigned int nCount);
extern void SerialFlash_ChipErase(void);
extern void SerialFlash_ResetWriteProtection();
extern void SerialFlash_SectorErase(unsigned long address);

/**************************************************************************************************
* End of File
**************************************************************************************************/