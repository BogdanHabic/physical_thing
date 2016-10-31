#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Led Blinking/LedBlinking.c"
#line 22 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Led Blinking/LedBlinking.c"
 int a = 0;
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


 while(1) {
 if(a == 0){
 GPIOA_ODR = ~GPIOB_ODR;
 GPIOB_ODR = ~GPIOB_ODR;
 GPIOC_ODR = ~GPIOC_ODR;
 GPIOD_ODR = ~GPIOD_ODR;
 GPIOE_ODR = ~GPIOE_ODR;
 a == 1;
 }else{
 GPIOA_ODR = 3;
 GPIOB_ODR = 3;
 GPIOC_ODR = 3;
 GPIOD_ODR = 3;
 GPIOE_ODR = 3;
 }
 Delay_ms(1000);
 }
}
