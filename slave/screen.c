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

// Touch Panel module connections
sbit DriveX_Left at GPIOB_ODR.B1;
sbit DriveX_Right at GPIOB_ODR.B8;
sbit DriveY_Up at GPIOB_ODR.B9;
sbit DriveY_Down at GPIOB_ODR.B0;
// End Touch Panel module connections

bit          write_erase;
char         pen_size;
int readbuff[32];
int writebuff[32];

unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 750;
char PenDown;

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

void Calibrate() {
  TFT_Set_Pen(CL_WHITE, 3);
  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Write_Text("Touch selected corners for calibration", 50, 80);
  TFT_Line(315, 239, 319, 239);
  TFT_Line(309, 229, 319, 239);
  TFT_Line(319, 234, 319, 239);
  TFT_Write_Text("first here",235,220);

  TP_TFT_Calibrate_Min();                      // Calibration of bottom left corner
  Delay_ms(500);

  TFT_Set_Pen(CL_BLACK, 3);
  TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Line(315, 239, 319, 239);
  TFT_Line(309, 229, 319, 239);
  TFT_Line(319, 234, 319, 239);
  TFT_Write_Text("first here",235,220);

  TFT_Set_Pen(CL_WHITE, 3);
  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Write_Text("now here ", 20, 5);
  TFT_Line(0, 0, 5, 0);
  TFT_Line(0, 0, 0, 5);
  TFT_Line(0, 0, 10, 10);

  TP_TFT_Calibrate_Max();                      // Calibration of bottom left corner
  Delay_ms(500);
}


void Init_ADC() {
  ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
  ADC1_Init();
  Delay_ms(100);
}

static void InitializeTouchPanel() {
  Init_ADC();
  TFT_Init_ILI9341_8bit(320, 240);

  TP_TFT_Init(320, 240, 8, 9);                 // Initialize touch panel
  TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);     // Set touch panel ADC threshold

  PenDown = 0;
}

void Init_MCU() {
  GPIO_Config(&GPIOE_BASE, _GPIO_PINMASK_9, _GPIO_CFG_DIGITAL_OUTPUT);
  TFT_BLED = 1;
  TFT_Set_Default_Mode();
  TP_TFT_Set_Default_Mode();
}

void Start_TP() {
  Init_MCU();

  InitializeTouchPanel();

  Delay_ms(1000);
  TFT_Fill_Screen(0);
  Calibrate();
  TFT_Fill_Screen(0);

//  InitializeObjects();
//  display_width = Screen2.Width;
//  display_height = Screen2.Height;
//  DrawScreen(&Screen2);
}

void Initialize() {
    Xcoord = 0;
    Ycoord = 0;
    Start_TP(); // Initialize touch panel

    TFT_Set_Pen(CL_AQUA, 3);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
    TFT_Fill_Screen(CL_AQUA);
    TFT_Set_Brush(1, CL_AQUA, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);

    HID_Enable(&readbuff,&writebuff);
}

void write_coords(int x, int y) {
    int i = 0;
    writebuff[0] = x;
    writebuff[1] = y;
    while(!HID_Write(&writebuff,64));
}

void Process_TP_Up(unsigned int x, unsigned int y) {
     write_coords((int)x, (int)y);
}

void Process_TP_Down(unsigned int x, unsigned int y) {
    //@TODO: Handle down
}

void Check_TP() {
    if (TP_TFT_Press_Detect()) {
        // After a PRESS is detected read X-Y and convert it to Display dimensions space
        if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
            if (PenDown == 0) {
                PenDown = 1;
                Process_TP_Down(Xcoord, Ycoord);
            }
        }
    } else if (PenDown == 1) {
        PenDown = 0;
        Process_TP_Up(Xcoord, Ycoord);
    }
}

void main(void) {
  Initialize();

    while (1) {
        if (HID_Read()) { // this won't hang because we are using async interrupts
            draw_target();
            delete_target();
        } else {
            Check_TP();
        }
    }
}