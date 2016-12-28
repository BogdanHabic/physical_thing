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
           This example shows how to calibrate touch panel and how to write on the screen.
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

#define CIRCLE_RADIUS 40

// TFT module connections
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;
// End TFT module connections

bit          write_erase;
char         pen_size;
int readbuff[32];
int writebuff[32];

void USB0Interrupt() iv IVT_INT_OTG_FS{
  USB_Interrupt_Proc();
}

void set_brush_for_draw() {
    TFT_Set_Brush(1, CL_FUCHSIA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
}

void set_brush_for_fake_draw() {
    TFT_Set_Brush(1, CL_BLACK, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
}

void set_brush_for_delete() {
    TFT_Set_Brush(1, CL_AQUA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
}

void draw_target() {
    int x, y, del, fake;

    x    = readbuff[0];
    y    = readbuff[1];
    del  = readbuff[2];
    fake = readbuff[3];

    if(x == -1 || y == - 1 || del == 1) {
        return;
    }

    if (!fake) {
        set_brush_for_draw();
    } else {
        set_brush_for_fake_draw();
    }

    TFT_Circle(x, y, CIRCLE_RADIUS);
}

void delete_target() {
    int x, y, del;

    x   = readbuff[0];
    y   = readbuff[1];
    del = readbuff[2];

    if(x == -1 || y == - 1 || del == 0) {
        return;
    }

    set_brush_for_delete();
    TFT_Circle(x, y, CIRCLE_RADIUS);
}

void send_touch(int x, int y) {
    writebuff[0] = x;
    writebuff[1] = y;

    while(!HID_Write(&writebuff,64)); // Send the message
}

void Initialize() {
    int i;

    TFT_Init_ILI9341_8bit(320, 240);
    TFT_Set_Pen(CL_AQUA, 3);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
    TFT_Fill_Screen(CL_AQUA);
    TFT_Set_Brush(1, CL_AQUA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);

    HID_Enable(&readbuff,&writebuff);
}

void main(void) {
  Initialize();

    while (1) {
        if (HID_Read()) { // this won't hang because we are using async interrupts
            draw_target();
            delete_target();
        } else {
            //@TODO Check for a touch
        }
    }
}
