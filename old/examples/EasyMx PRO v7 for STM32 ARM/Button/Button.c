/* Project name:
     Button_Test (Sample usage of Button() function)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Description:
     Simple demonstration on usage of the Button() function.

 * Test configuration:
     Device:          STM32F107VC    
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:Buttons
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
'                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn on LEDs on PORTD at SW15. Pull down on PORTA pin 0(board specific).
     - Button press level enabled SW10 PORTA.
     - Pressing PA0 button should togle LEDs on PORTD.
 */
 
unsigned int oldstate;

void main() {

  GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0);         // Set PA0 as digital input
  GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_ALL);      // Set PORTD as digital output
  oldstate = 0;
  
  do {
    if (Button(&GPIOA_IDR, 0, 1, 1))                      // detect logical one on PA0 pin
      oldstate = 1;
    if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {        // detect one-to-zero transition on PA0 pin
      GPIOD_ODR = ~GPIOD_ODR;                             // invert PORTD value
      oldstate = 0;
    }
  } while(1);                                             // endless loop
}