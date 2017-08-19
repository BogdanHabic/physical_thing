/* Project name:
     UART0
 * Copyright:
     (c) Mikroelektronika, 2011.
 * Revision History:
     20110511(TL):
       - initial release;
 * Description:
     This simple example demonstrates usage of mikroC's UART libraries, through
     a 'loopback' interface. The data being sent to ARM through UART
     and sent back.
 * Test configuration:
     Device:          STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     dev.board:       EasyMx v7 for STM32(R) ARM(R) ac:USB_UART1
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn ON USB UARTA switches (SW12.1 and SW12.2). (board specific)
 */

char uart_rd;

void main() {

  UART1_Init(56000);              // Initialize UART module at 56000 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(13);
  UART1_Write(10);

  while (1) {                     // Endless loop
    if (UART1_Data_Ready()) {     // If data is received
      uart_rd = UART1_Read();     // read the received data
      UART1_Write(uart_rd);       // and send data via UART
    }
  }
}