/* Project name:
     Mmc_Test (MMC Library Example)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20111125:
       - initial release;
 * Description:
     MMC library test. Upon flashing, insert a MMC/SD card into the
     module, when you should receive the "Init-OK" message.
     Then, you can experiment with MMC read and write functions,
     and observe the results through the Usart Terminal.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx PRO v7 for STM32(R) ARM(R) - ac:MMC
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Connect USB cable and turn ON USB UARTA switches at SW12 (board specific).
     - Turn ON SPI switches at SW13 and MMC CS switch at SW14 (board specific).
     - This is NOT an example for working with FILES on a MMC/SD memory module.
     - This example should work both for MMC and SD media types.
 */

// MMC module connections
sbit Mmc_Chip_Select           at GPIOD_ODR.B3;
// eof MMC module connections

// Variables for MMC routines
unsigned char SectorData[512];        // Buffer for MMC sector reading/writing
unsigned char data_for_registers[16]; // buffer for CID and CSD registers

const char   FILL_CHAR = 'm';
unsigned int i, SectorNo;
char         mmc_error;
bit          data_ok;

// UART1 write text and new line (carriage return + line feed)
void UART1_Write_Line(char *uart_text) {
  UART1_Write_Text(uart_text);
  UART1_Write(13);
  UART1_Write(10);
}

// Display byte in hex
void PrintHex(unsigned char i) {
  unsigned char hi,lo;

  hi = i & 0xF0;               // High nibble
  hi = hi >> 4;
  hi = hi + '0';
  if (hi>'9') hi=hi+7;
  lo = (i & 0x0F) + '0';       // Low nibble
  if (lo>'9') lo=lo+7;

  UART1_Write(hi);
  UART1_Write(lo);
}

void main() {
  UART1_Init(19200);           // Initialize UART module at 19200 bps
  UART1_Write_Text("Start");
  UART1_Write(13);
  UART1_Write(10);
  Delay_ms(100);               // Wait for UART module to stabilize

  //--- initialize SPI3
  SPI3_Init_Advanced(_SPI_FPCLK_DIV4, _SPI_MASTER | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI3_PC10_11_12);

  // initialize a MMC card
  mmc_error = Mmc_Init();
  if(mmc_error == 0)
    UART1_Write_Line("MMC Init-OK");    // If MMC present report
  else
    UART1_Write_Line("MMC Init-error"); // If error report

  // Fill MMC buffer with same characters
  for(i=0; i<=511; i++)
    SectorData[i] = FILL_CHAR;

  // Choose sector
  SectorNo = 590;

  // Write sector
  mmc_error = Mmc_Write_Sector(SectorNo, SectorData);
  if(mmc_error == 0)
    UART1_Write_Line("Write-OK");
  else  // if there are errors.....
    UART1_Write_Line("Write-Error");

  // Reading of CID register
  mmc_error = Mmc_Read_Cid(data_for_registers);
  if(mmc_error == 0) {
    UART1_Write_Text("CID : ");
    for(i=0; i<=15; i++)
      PrintHex(data_for_registers[i]);
    UART1_Write_Line("");
  }
  else
    UART1_Write_Line("CID-error");

  // Reading of CSD register
  mmc_error = Mmc_Read_Csd(data_for_registers);
  if(mmc_error == 0) {
    UART1_Write_Text("CSD : ");
    for(i=0; i<=15; i++)
      PrintHex(data_for_registers[i]);
    UART1_Write_Line("");
  }
  else
    UART1_Write_Line("CSD-error");
  // Read sector
  mmc_error = Mmc_Read_Sector(SectorNo, SectorData);
  if(mmc_error == 0) {
    UART1_Write_Line("Read-OK");
    // Chech data match
    data_ok = 1;
    for(i=0; i<=511; i++) {
      UART1_Write(SectorData[i]);
      if (SectorData[i] != FILL_CHAR) {
        data_ok = 0;
        break;
      }
    }
    UART1_Write_Line("");
    if (data_ok)
      UART1_Write_Line("Content-OK");
    else
      UART1_Write_Line("Content-Error");
  }
  else  // if there are errors.....
    UART1_Write_Line("Read-Error");

  // Signal test end
  UART1_Write_Line("Test End.");
}