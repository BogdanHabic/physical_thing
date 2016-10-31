#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Sound/Sound.c"
#line 29 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/Sound/Sound.c"
void Tone1() {
 Sound_Play(659, 250);
}

void Tone2() {
 Sound_Play(698, 250);
}

void Tone3() {
 Sound_Play(784, 250);
}


void Tone4() {
 Sound_Play(27.5, 250);
}




void ToneA() {
 Sound_Play( 880, 50);
}
void ToneC() {
 Sound_Play(1046, 50);
}
void ToneE() {
 Sound_Play(1318, 50);
}

void Melody() {
 ToneA();ToneA();ToneA();ToneA();ToneA();ToneA();ToneA();ToneA();
}

void Melody2() {
 unsigned short i;
 for (i = 9; i > 0; i--) {
 ToneA(); ToneC(); ToneE();
 }
}

void main() {
 GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_LOW);
 Sound_Init(&GPIOE_ODR, 14);
 Sound_Play(880, 1000);

 while (1) {
 if (Button(&GPIOD_IDR,7,1,1))
 Tone1();
 while (GPIOD_IDR.B7);

 if (Button(&GPIOD_IDR,6,1,1))
 Tone2();
 while (GPIOD_IDR.B6);

 if (Button(&GPIOD_IDR,5,1,1))
 Tone3();
 while (GPIOD_IDR.B5);

 if (Button(&GPIOD_IDR,4,1,1))
 Melody2();
 while (GPIOD_IDR.B4);

 if (Button(&GPIOD_IDR,3,1,1))
 Melody();
 while (GPIOD_IDR.B3);
 }
}
