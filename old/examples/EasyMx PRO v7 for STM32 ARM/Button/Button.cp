#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Button/Button.c"
#line 24 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Button/Button.c"
unsigned int oldstate;

void main() {

 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0);
 GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_ALL);
 oldstate = 0;

 do {
 if (Button(&GPIOA_IDR, 0, 1, 1))
 oldstate = 1;
 if (oldstate && Button(&GPIOA_IDR, 0, 1, 0)) {
 GPIOD_ODR = ~GPIOD_ODR;
 oldstate = 0;
 }
 } while(1);
}
