/* Project name:
     UART1
 * Copyright:
     (c) Mikroelektronika, 2011.
 * Revision History:
     20110511:
       - initial release;
 * Description:
     This simple example demonstrates usage of mikroC's UART libraries, through
     a 'loopback' interface. The data being sent to ARM through UART
     and sent back.
 * Test configuration:
     Device:          STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     dev.board:       EasyMx v7 for STM32(R) ARM(R) ac:USB_UART2
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn ON USB UARTB switches (SW12.3 and SW12.4). (board specific)
 */

char uart_rd;

void main() {

  // Initialize UART module at 56000 bps
  UART2_Init_Advanced(56000, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART2_PD56);
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART2_Write_Text("Start");
  UART2_Write(13);
  UART2_Write(10);

  while (1) {                     // Endless loop
    if (UART2_Data_Ready()) {     // If data is received
      uart_rd = UART2_Read();     // read the received data
      UART2_Write(uart_rd);       // and send data via UART
    }
  }
}