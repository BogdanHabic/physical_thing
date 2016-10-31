/* Project name:
     I2C_Simple (Simple test of I2C library routines)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20110511(TL):
       - initial release;
 * Description:
     This program demonstrates usage of the I2C library routines. It
     establishes I2C bus communication with 24C02 EEPROM chip, writes one byte
     of data on some location, then reads it and displays it on PORTD.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     ext. modules:    On-board ac:EEPROM module
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn ON I2C EEPROM-SCL and EEPROM-SDA switches at SW14. (board specific)
     - Turn ON PORTD LEDs at SW15. (board specific)
*/


char data_[256];


//--------------- Writes data to 24C02 EEPROM - signle location
void EEPROM_24C02_WrSingle(unsigned short wAddr, unsigned short wData) {
  data_[0] = wAddr;
  data_[1] = wData;
  I2C1_Start();
  // issue I2C start signal
  I2C1_Write(0x50,data_,2,END_MODE_STOP);
}//~

//--------------- Reads data from 24C02 EEPROM - single location (random)
unsigned short EEPROM_24C02_RdSingle(unsigned short rAddr) {
  data_[0] = rAddr;
  I2C1_Start();              // issue I2C start signal
  I2C1_Write(0x50,data_,1,END_MODE_RESTART);
  I2C1_Read(0x50,data_,1,END_MODE_STOP);

  return data_[0];
}

void main(){
  unsigned short i;

  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);

  I2C1_Init();        // performs I2C initialization

  GPIOD_ODR = 0xFFFF;
  Delay_ms(1000);

  for(i = 0; i<0x80; i++) {
    EEPROM_24C02_WrSingle(i,i);
    GPIOD_ODR++;
    delay_ms(5);
  }

  Delay_ms(500);
  GPIOD_ODR = 0xFFFF;
  Delay_ms(1000);

  for(i = 0x00; i < 0x80; i++){
    GPIOD_ODR = EEPROM_24C02_RdSingle(i);
    delay_ms(100);
  }

}