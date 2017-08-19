/* Project name:
     Calculator 
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
       - initial release;
 * Description:
     Simple calculator example demostrates usage of TFT and Touch Panel
 * Test configuration:
     Device:          STM32F107VC 
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE, 72.000MHz
     Ext. Modules:    EasyTFT
                      http://www.mikroe.com/add-on-boards/display/easytft/
                      ac:easyTFT                      
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn ON SW11.3 to SW11.8 (board specific).
 */

#include "calculator_objects.h"

void main() {
  Start_TP();
  while (1) {
    Check_TP();
  }
}