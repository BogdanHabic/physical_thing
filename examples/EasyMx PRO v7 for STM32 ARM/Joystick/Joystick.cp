#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Joystick/Joystick.c"
#line 27 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Joystick/Joystick.c"
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;


unsigned int oldstate_press, oldstate_right, oldstate_left, oldstate_up, oldstate_down;
unsigned int state;
int a = 0;

void Init_MCU() {
 GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_2 |_GPIO_PINMASK_4);
 GPIO_Digital_Input(&GPIOB_IDR, _GPIO_PINMASK_5);
 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6);
 GPIO_Digital_Input(&GPIOC_IDR, _GPIO_PINMASK_13);

 Delay_100ms();
 TFT_Init_ILI9341_8bit(320, 240);
}

void main() {

 GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);

 GPIOA_ODR = 0;
 GPIOB_ODR = 0;
 GPIOC_ODR = 0;
 GPIOD_ODR = 0;
 GPIOE_ODR = 0;

 oldstate_press = 0;
 oldstate_right = 0;
 oldstate_left = 0;
 oldstate_up = 0;
 oldstate_down = 0;
 state = 1;

 while(1){

 if (Button(&GPIOC_IDR, 13, 1, 1))
 oldstate_press = 1;
 if (oldstate_press && Button(&GPIOC_IDR, 13, 1, 0)) {
 TFT_Fill_Screen(CL_TEAL);
 TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
 TFT_Circle(160, 114, 40);
 TFT_Write_Text("Pressed", 136, 106);
 Delay_ms(300);
 TFT_Fill_Screen(CL_TEAL);
 oldstate_press = 0;
 state = 1;
 }

 if (Button(&GPIOA_IDR, 6, 1, 1))
 oldstate_right = 1;
 if (oldstate_right && Button(&GPIOA_IDR, 6, 1, 0)) {
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
 if (oldstate_left && Button(&GPIOD_IDR, 2, 1, 0)) {
 TFT_Fill_Screen(CL_TEAL);
 TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
 TFT_Circle(28, 114, 20);
 TFT_Write_Text("Left", 16, 106);
 Delay_ms(300);
 TFT_Fill_Screen(CL_TEAL);
 oldstate_left = 0;
 state = 3;
 }

 if (Button(&GPIOD_IDR, 4, 1, 1))
 oldstate_up = 1;
 if (oldstate_up && Button(&GPIOD_IDR, 4, 1, 0)) {
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
 if (oldstate_down && Button(&GPIOB_IDR, 5, 1, 0)) {
 TFT_Fill_Screen(CL_TEAL);
 TFT_Set_Brush(1, CL_RED, 0, 0, 0, 0);
 TFT_Circle(154, 216, 20);
 TFT_Write_Text("Down", 138, 207);
 Delay_ms(300);
 TFT_Fill_Screen(CL_TEAL);
 oldstate_down = 0;
 state = 5;
 }

 GPIOA_ODR = ~GPIOB_ODR;
 GPIOB_ODR = ~GPIOB_ODR;
 GPIOC_ODR = ~GPIOC_ODR;
 GPIOD_ODR = ~GPIOD_ODR;
 GPIOE_ODR = ~GPIOE_ODR;
 Delay_ms(1000);
 }
}
