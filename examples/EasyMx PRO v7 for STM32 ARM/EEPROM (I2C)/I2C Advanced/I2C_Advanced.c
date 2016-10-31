/* Project name:
     I2C_Advanced (Advanced I2C Example)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20110511(TL):
       - initial release
 * Description:
     This example features the advanced communication with the 24C02 EEPROM chip
     by introducing its own library of functions for this task: init, single
     write, single and sequential read. It performs write of a sequence of bytes
     (characters) into the EEPROM and writes this out to the UART.
     Then, data read from EEPROM is performed and the result is written to the UART.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    On-board ac:EEPROM module
                      on-board ac:USB_UART1 module
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn ON I2C EEPROM-SCL and EEPROM-SDA switches at SW14. (board specific)
     - Turn ON USB UART A (PA9 & PA10) switches at SW12. (board specific)
     - Turn OFF all PORT LEDs. (board specific)
*/

#include "EEPROM_24C02.h"

char someData[] = "I2C_Advanced Test by mikroE";
char rData[28];
char i ,tmpdata;

//  Main
void main() {
  EEPROM_24C02_Init();                      // performs I2C initialization

  UART1_Init(56000);
  UART1_Write_Text("Start");
  UART1_Write(13);
  UART1_Write(10);

  UART1_Write_Text("Write data to EEPROM:                         ");
  // Example for single-byte write
  i = 0;
  tmpdata = 1;
  while ((tmpdata = someData[i]) != 0) {
    i++;
    EEPROM_24C02_WrSingle(i, tmpdata);      // writes data, char by char, in the EEPROM
    UART1_Write(tmpdata);
    Delay_ms(20);
  }
  EEPROM_24C02_WrSingle(i+1, 0);            // writes string termination
  Delay_ms(20);

  UART1_Write(13);
  UART1_Write(10);
  
  UART1_Write_Text("Read data from EEPROM (single receive mode):  ");
  // Example for single-byte read
  i = 1;
  tmpdata = 1;
  while ((tmpdata = EEPROM_24C02_RdSingle(i)) != 0) {
    UART1_Write(tmpdata);
    Delay_ms(20);
    i++ ;
  }
  UART1_Write(13);
  UART1_Write(10);

  // Example for burst read
  UART1_Write_Text("Read data from EEPROM (burst receive mode):   ");
  EEPROM_24C02_RdSeq(1, rData, strlen(someData));
  UART1_Write_Text(rData);
  
  UART1_Write(13);
  UART1_Write(10);
  UART1_Write(13);
  UART1_Write(10);

}