/* Project name:
     HID_Read_Write_Polling (USB HID Read & Write Test)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20111223:
       - initial release;
 * Description:
     This example establishes connection with the HID terminal that is active
     on the PC. Upon connection establishment, the HID Device Name will appear
     in the respective window. The character that user sends to ARM from the HID
     terminal will be re-sent back to user.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx PRO v7 for STM32(R) ARM(R) - ac:USB
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    -
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:  - Turn on USB switches on SW12
*/

char cnt;
char kk;
char readbuff[64];
char writebuff[64];

unsigned long int i = 0;
void main(void){

  HID_Enable(&readbuff,&writebuff);

  while(1){
    USB_Polling_Proc();               // Call this routine periodically
    kk = HID_Read();
    if(kk != 0){
      for(cnt=0;cnt<64;cnt++)
        writebuff[cnt]=readbuff[cnt];
      HID_Write(&writebuff,64);
    }
  }
}