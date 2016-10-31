
/*
 * Project name:
     GLCD_Test (Demonstration of the GLCD library routines)
 * Copyright:
     (c) mikroElektronika, 2012.
 * Revision History:
     20091030:
       - Initial release;
 * Description:
     This is a simple demonstration of the GLCD library routines:
     - Init and Clear (pattern fill)
     - Image display
     - Basic geometry - lines, circles, boxes and rectangles
     - Text display and handling
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx PRO v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    ac:GLCD
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - None.
 */

//Declarations------------------------------------------------------------------
const code char truck_bmp[1024];
//--------------------------------------------------------------end-declarations

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

void delay2S(){                                  // 2 seconds delay function
  Delay_ms(2000);
}

void main() {
  char counter;
  char *someText;

  Glcd_Init();                                     // Initialize GLCD
  Glcd_Fill(0x00);                                 // Clear GLCD

  while(1) {
    Glcd_Image(truck_bmp);                         // Draw image
    Delay2s(); Delay2s();
    Glcd_fill(0x00);                               // Clear GLCD
    Glcd_PartialImage(0,0,68,30,128,64,truck_bmp); // Partial image
    Delay_ms(500);
    Glcd_PartialImage(24,16,68,30,128,64,truck_bmp);
    Delay_ms(500);
    Glcd_PartialImage(56,34,68,30,128,64,truck_bmp);
    Delay2s(); Delay2s();
    Glcd_Fill(0x00);                               // Clear GLCD

    Glcd_Box(62,40,124,56,1);                      // Draw box
    Glcd_Rectangle(5,5,84,35,1);                   // Draw rectangle
    Delay_ms(1000);
    Glcd_Rectangle_Round_Edges(2,2,87,38,7,1);
    Delay_ms(1000);
    Glcd_Rectangle_Round_Edges_Fill(8,8,81,32,12,1);
    Delay_ms(1000);
    Glcd_Line(0, 0, 127, 63, 1);                   // Draw line
    Delay2s();

    for(counter = 5; counter < 60; counter+=5 ){   // Draw horizontal and vertical lines
      Delay_ms(250);
      Glcd_V_Line(2, 54, counter, 1);
      Glcd_H_Line(2, 120, counter, 1);
    }
    Delay2s();

    Glcd_Fill(0x00);                             // Clear Glcd
    Glcd_Set_Font(Character8x7, 8, 7, 32);       // Choose font, see __Lib_GLCDFonts.c in Uses folder
    Glcd_Write_Text("mikroE", 5, 7, 2);          // Write string

    for (counter = 1; counter <= 10; counter++)  // Draw circles
      Glcd_Circle(63,32, 3*counter, 1);
    Delay2s();

    Glcd_Circle_Fill(63,32, 30, 1);              // Draw circles
    Delay2s();

    Glcd_Box(12,20, 70,57, 2);                   // Draw box
    Delay2s();

    Glcd_Fill(0xFF);                             // Fill Glcd

    Glcd_Set_Font(Font_Glcd_Character8x7, 8, 7, 32);  // Change font
    someText = "8x7 Font";
    Glcd_Write_Text(someText, 5, 0, 2);               // Write string
    Delay2s();

    Glcd_Set_Font(Font_Glcd_System3x5, 3, 5, 32);     // Change font
    someText = "3X5 CAPITALS ONLY";
    Glcd_Write_Text(someText, 60, 2, 2);              // Write string
    Delay2s();

    Glcd_Set_Font(Font_Glcd_5x7, 5, 7, 32);           // Change font
    someText = "5x7 Font";
    Glcd_Write_Text(someText, 5, 4, 2);               // Write string
    Delay2s();

    Glcd_Set_Font(Font_Glcd_System5x7, 5, 7, 32);     // Change font
    someText = "5x7 Font (v2)";
    Glcd_Write_Text(someText, 50, 6, 2);              // Write string
    Delay2s();
  }
}