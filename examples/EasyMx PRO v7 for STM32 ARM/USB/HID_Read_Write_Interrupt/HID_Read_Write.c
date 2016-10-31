/* Project name:
     HID_Read_Write (USB HID Read & Write Test)
 * Copyright:
     (c) Mikroelektronika, 2011.
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
 * NOTES:  -  Turn on USB switches on SW12
*/

char readbuff[64];
char writebuff[64];

void USB0Interrupt() iv IVT_INT_OTG_FS{
  USB_Interrupt_Proc();
}

void main(void){
  char cnt;
  HID_Enable(&readbuff,&writebuff);

  while(1){
    while(!HID_Read())
      ;

    for(cnt=0;cnt<64;cnt++)
      writebuff[cnt]=readbuff[cnt];

    while(!HID_Write(&writebuff,64))
      ;
  }
}