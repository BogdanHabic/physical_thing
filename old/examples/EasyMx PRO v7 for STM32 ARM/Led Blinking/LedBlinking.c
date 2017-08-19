/* Project name:
     Led_Blinking (The simplest simple example)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
       - initial release;
 * Description:
     Simple "Hello world" example for the world of ARM MCUs;
 * Test configuration:
     Device:          STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:LEDs
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn ON PORTA, PORTB, PORTC, PORTD, PORTE at SW15 (board specific).
 */
 int a = 0;
void main() {
  GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_ALL); // Set PORTA as digital output
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL); // Set PORTB as digital output
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL); // Set PORTC as digital output
  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL); // Set PORTD as digital output
  GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL); // Set PORTE as digital output

  GPIOA_ODR = 0;
  GPIOB_ODR = 0;
  GPIOC_ODR = 0;
  GPIOD_ODR = 0;
  GPIOE_ODR = 0;
  
  Init_MCU();
  TFT_Fill_Screen(CL_TEAL);
  TFT_Write_Text("Press joystik on board", 75, 80);
  TFT_Write_Text("and MCU will detect direction.", 75, 110);

  oldstate_press = 0;
  oldstate_right = 0;
  oldstate_left  = 0;
  oldstate_up    = 0;
  oldstate_down  = 0;
  state = 1;


  while(1) {
    GPIOA_ODR = ~GPIOB_ODR; // Toggle PORTA
    GPIOB_ODR = ~GPIOB_ODR; // Toggle PORTB
    GPIOC_ODR = ~GPIOC_ODR; // Toggle PORTC
    GPIOD_ODR = ~GPIOD_ODR; // Toggle PORTD
    GPIOE_ODR = ~GPIOE_ODR; // Toggle PORTE
    Delay_ms(1000);
    
  }
  
  unsigned int oldstate_press, oldstate_right, oldstate_left, oldstate_up, oldstate_down;
unsigned int state;

void Init_MCU() {
  TFT_BLED = 1;
  GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_2 |_GPIO_PINMASK_4);  // Set Up and Left as digital input
  GPIO_Digital_Input(&GPIOB_IDR, _GPIO_PINMASK_5);                    // Set Down as digital input
  GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6);                    // Set Right as digital input
  GPIO_Digital_Input(&GPIOC_IDR, _GPIO_PINMASK_13);                   // Set Center as digital input

  Delay_100ms();
  TFT_Init_ILI9341_8bit(320, 240);
}


}