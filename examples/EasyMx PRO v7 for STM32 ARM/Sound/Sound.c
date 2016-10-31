/*
 * Project name:
     Sound (Usage of Sound library)
 * Copyright:
     (c) Mikroelektronika, 2011.
 * Revision History:
     20111125:
       - initial release;
 * Description:
     This project is a simple demonstration of how to
     
     use sound library for playing tones on a piezo speaker.
 * Test configuration:
     Device:          STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:Buzzer                      
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Pull down on PD7 - PD3 (board specific).
     - Button press level in Vcc position on PORTD on SW10 (board specific)
     - Turn on Buzzer at SW17.8.
*/

void Tone1() {
  Sound_Play(659, 250);   // Frequency = 659Hz, duration = 250ms
}

void Tone2() {
  Sound_Play(698, 250);   // Frequency = 698Hz, duration = 250ms
}

void Tone3() {
  Sound_Play(784, 250);   // Frequency = 784Hz, duration = 250ms
}


void Tone4() {
  Sound_Play(27.5, 250);   // Frequency = 784Hz, duration = 250ms
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

void Melody() {           // Plays the melody "Yellow house"
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
  Sound_Play(880, 1000);            // Play sound at 880Hz for 1 second

  while (1) {
    if (Button(&GPIOD_IDR,7,1,1))       // RB7 plays Tone1
      Tone1();
    while (GPIOD_IDR.B7);                // Wait for button to be released

    if (Button(&GPIOD_IDR,6,1,1))       // RB6 plays Tone2
      Tone2();
    while (GPIOD_IDR.B6);                // Wait for button to be released

    if (Button(&GPIOD_IDR,5,1,1))       // RB5 plays Tone3
      Tone3();
    while (GPIOD_IDR.B5);                // Wait for button to be released

    if (Button(&GPIOD_IDR,4,1,1))       // RB4 plays Melody2
      Melody2();
    while (GPIOD_IDR.B4);                // Wait for button to be released

    if (Button(&GPIOD_IDR,3,1,1))       // RB3 plays Melody
      Melody();
    while (GPIOD_IDR.B3);                // Wait for button to be released
  }
}