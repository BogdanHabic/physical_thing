/* Project name:
     Joystick
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20111125:
       - initial release;
 * Description:
     This example presents features of the joystick input device.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:Joystick
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    EasyTFT.
                      ac:easyTFT     
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Pull Up on PA6, PB5, PC13, PD2 and PD4 (board specific).
     - Turn ON TFT control switches at SW11 (board specific)
*/

// TFT module connections
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;
// End TFT module connections

unsigned int oldstate_press, oldstate_right, oldstate_left, oldstate_up, oldstate_down;
unsigned int state;
int a = 0;

void Init_MCU() {
  GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_2 |_GPIO_PINMASK_4);  // Set Up and Left as digital input
  GPIO_Digital_Input(&GPIOB_IDR, _GPIO_PINMASK_5);                    // Set Down as digital input
  GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6);                    // Set Right as digital input
  GPIO_Digital_Input(&GPIOC_IDR, _GPIO_PINMASK_13);                   // Set Center as digital input

  Delay_100ms();
  TFT_Init_ILI9341_8bit(320, 240);
}

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

  oldstate_press = 0;
  oldstate_right = 0;
  oldstate_left  = 0;
  oldstate_up    = 0;
  oldstate_down  = 0;
  state = 1;

  while(1){

    if (Button(&GPIOC_IDR, 13, 1, 1))                     // detect logical one state
      oldstate_press = 1;
    if (oldstate_press && Button(&GPIOC_IDR, 13, 1, 0)) { // detect logical one to logical zero transition
      TFT_Fill_Screen(CL_TEAL);
      TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
      TFT_Circle(160, 114, 40);
      TFT_Write_Text("Pressed", 136, 106);
      Delay_ms(300);
      TFT_Fill_Screen(CL_TEAL);
      oldstate_press = 0;
      state = 1;
    }

    if (Button(&GPIOA_IDR, 6, 1, 1))                     // detect logical one state
      oldstate_right = 1;
    if (oldstate_right && Button(&GPIOA_IDR, 6, 1, 0)) { // detect logical one to logical zero transition
      TFT_Fill_Screen(CL_TEAL);
      TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
      TFT_Circle(282, 114, 20);
      TFT_Write_Text("Right", 266, 106);
      Delay_ms(300);
      TFT_Fill_Screen(CL_TEAL);
      oldstate_right = 0;
      state = 2;
    }
    
    if (Button(&GPIOD_IDR, 2, 1, 1))
      oldstate_left = 1;
    if (oldstate_left && Button(&GPIOD_IDR, 2, 1, 0)) { // detect logical one to logical zero transition
      TFT_Fill_Screen(CL_TEAL);
      TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
      TFT_Circle(28, 114, 20);
      TFT_Write_Text("Left", 16, 106);
      Delay_ms(300);
      TFT_Fill_Screen(CL_TEAL);
      oldstate_left = 0;
      state = 3;
    }
    
    if (Button(&GPIOD_IDR, 4, 1, 1))                  // detect logical one state
      oldstate_up = 1;
    if (oldstate_up && Button(&GPIOD_IDR, 4, 1, 0)) { // detect logical one to logical zero transition
      TFT_Fill_Screen(CL_TEAL);
      TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
      TFT_Circle(154, 24, 20);
      TFT_Write_Text("Up", 146, 16);
      Delay_ms(300);
      TFT_Fill_Screen(CL_TEAL);
      oldstate_up = 0;
      state = 4;
    }
    
    if (Button(&GPIOB_IDR, 5, 1, 1))
      oldstate_down = 1;
    if (oldstate_down && Button(&GPIOB_IDR, 5, 1, 0)) { // detect logical one to logical zero transition
      TFT_Fill_Screen(CL_TEAL);
      TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
      TFT_Circle(154, 216, 20);
      TFT_Write_Text("Down", 138, 207);
      Delay_ms(300);
      TFT_Fill_Screen(CL_TEAL);
      oldstate_down = 0;
      state = 5;
    }
    
    GPIOA_ODR = ~GPIOB_ODR; // Toggle PORTA
    GPIOB_ODR = ~GPIOB_ODR; // Toggle PORTB
    GPIOC_ODR = ~GPIOC_ODR; // Toggle PORTC
    GPIOD_ODR = ~GPIOD_ODR; // Toggle PORTD
    GPIOE_ODR = ~GPIOE_ODR; // Toggle PORTE
    Delay_ms(1000);
  }
}