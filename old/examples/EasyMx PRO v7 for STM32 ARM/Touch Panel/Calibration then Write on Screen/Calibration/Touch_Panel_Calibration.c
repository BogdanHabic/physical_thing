/*
 * Project name:
      TouchPanelCalibrationAndWrite
 * Copyright:
      (c) mikroElektronika, 2012
 * Revision History:
      20120904
      - Initial release
 * Description:
           This code works with TouchPanel and GLCD. Two digital output and
           two analog input signals are used for communication with TouchPanel.
           The example shows how to calibrate touch panel and prints aquired
           calibration constants on GLCD.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev. Board:      EasyMx PRO v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:Touch_Panel
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/

 * NOTES:
      - Turn ON Touch Panel controller switches at SW11.
      - Turn ON Back Light switches at SW11.
*/

// Glcd module connections
unsigned long GLCD_DataPort_Input  at GPIOE_IDR;
unsigned long GLCD_DataPort_Output at GPIOE_ODR;

sbit GLCD_CS1           at GPIOE_ODR.B10;
sbit GLCD_CS2           at GPIOE_ODR.B11;
sbit GLCD_RS            at GPIOE_ODR.B12;
sbit GLCD_RW            at GPIOE_ODR.B13;
sbit GLCD_EN            at GPIOE_ODR.B15;
sbit GLCD_RST           at GPIOE_ODR.B8;
// End Glcd module connections

// Touch Panel module connections
sbit DriveA at GPIOB_ODR.B8;
sbit DriveB at GPIOB_ODR.B9;
// End Touch Panel module connections

const char msg1[] = "TOUCH BOTTOM LEFT";
const char msg2[] = "                 ";
const char msg3[] = "TOUCH UPPER RIGHT";
const char msg4[] = "CALIBRATION";
const char msg5[] = "Calibration constants";
char msg[22];

unsigned int x_min, y_min, x_max, y_max;           // Calibration constants

char x_min_msg[] = "X min:";                       // GLCD text messages
char y_min_msg[] = "Y min:";
char x_max_msg[] = "X max:";
char y_max_msg[] = "Y max:";

char x_min_val[6];                                 // Calibration constants string values
char y_min_val[6];
char x_max_val[6];
char y_max_val[6];

// copy const to ram string
char * CopyConst2Ram(char * dest, const char * src){
  char * d ;
  d = dest;
  for(;*dest++ = *src++;)
    ;
  return d;
}

void Initialize() {
  Glcd_Init();                                     // Initialize GLCD
  Glcd_Fill(0);                                    // Clear GLCD
  
  ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
  ADC1_Init();
  
  TP_Init(128, 64, 8, 9);                          // Initialize touch panel
  TP_Set_ADC_Threshold(900);                       // Set touch panel ADC threshold
}

void Calibrate() {

  Glcd_Dot(0,63,1);                                // Draw bottom left dot
  Glcd_Write_Text(CopyConst2Ram(msg,msg1),12,3,1);
  TP_Calibrate_Bottom_Left();                      // Calibration of bottom left corner
  Delay_ms(1000);

  Glcd_Dot(0,63,0);                                // Clear bottom left dot
  Glcd_Dot(127,0,1);                               // Draw upper right dot
  Glcd_Write_Text(CopyConst2Ram(msg,msg2),12,3,1);
  Glcd_Write_Text(CopyConst2Ram(msg,msg3),12,4,1);
  TP_Calibrate_Upper_Right();                      // Calibration of upper right corner

  Delay_ms(1000);
}

void main() {

  Initialize();

  Glcd_Write_Text(CopyConst2Ram(msg,msg4),32,3,1);
  Delay_ms(1000);
  Glcd_Fill(0);                                    // Clear GLCD
  Calibrate();

  TP_Get_Calibration_Consts(&x_min, &x_max, &y_min, &y_max); // Get calibration constants

  WordToStr(x_min, x_min_val);                             // Convert calibration constants into string values
  WordToStr(x_max, x_max_val);
  WordToStr(y_min, y_min_val);
  WordToStr(y_max, y_max_val);

  // Display Calibration constants on GLCD
  
  Glcd_Fill(0);                                            // Clear GLCD
  Glcd_Write_Text(CopyConst2Ram(msg,msg5),1,1,1);
  Glcd_Write_Text(x_min_msg,1,3,1);                        // Write messages on GLCD
  Glcd_Write_Text(x_max_msg,1,4,1);
  Glcd_Write_Text(y_min_msg,1,5,1);
  Glcd_Write_Text(y_max_msg,1,6,1);

  Glcd_Write_Text(x_min_val,50,3,1);                       // Write calibration constants values on GLCD
  Glcd_Write_Text(x_max_val,50,4,1);
  Glcd_Write_Text(y_min_val,50,5,1);
  Glcd_Write_Text(y_max_val,50,6,1);

}