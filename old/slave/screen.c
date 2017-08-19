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

#define COUNTERS 4
#define COUNTER_PADDING 10
#define INITIAL_POS_X 32
#define INITIAL_POS_Y 30
#define STOPWATCH_BUFFER_SIZE 10
#define STATE_RUNNING 1
#define STATE_PAUSE 2

#define B_START 1
#define B_LAP 2
#define B_RESET 3
#define B_PAUSE 4
#define B_SAVE 5

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
char start_msg[] = "S";
char reset_msg[] = "R";
char pause_msg[] = "P";
int readbuff[32];
char writebuff[64];
int curr_state = STATE_PAUSE;
int prev_b = 0;
int timers_shifted = 0;

int times[COUNTERS];
unsigned int x_coord, y_coord;

void USB0Interrupt() iv IVT_INT_OTG_FS{
  USB_Interrupt_Proc();
}

void delay10ms() {
  Delay_ms(10);
}

void shift_timers(int keep_curr) {
    int i, temp, t;
    t = times[0];

    for(i = 1; i < COUNTERS; i++) {
        temp = times[i];
        times[i] = t;
        t = temp;
    }

    if (!keep_curr) {
        times[0] = 0;
    }
    
    timers_shifted = 1;
}

void print_timers() {
        int i, h, m, s, temp;
        int pos_y = INITIAL_POS_Y;
        char str[STOPWATCH_BUFFER_SIZE];

        if(timers_shifted) {
            TFT_Fill_Screen(CL_AQUA); // Clear TFT
            timers_shifted = 0;
        }

        TFT_Rectangle(20, 30, 219, 50);

        for(i = 0; i < COUNTERS; i++) {
                temp = times[i];

                h = temp / 3600;
                temp %= 3600;

                m = temp / 60;
                temp %= 60;

                s = temp;

                sprintf(str, "%02d:%02d:%02d", h, m, s);
                TFT_Write_Text(str, INITIAL_POS_X, pos_y);
                delay10ms();
                pos_y += 20;
        }
}

void Initialize() {
    int i;
    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0); // Set PA0 as start
    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6); // Set PA6 as lap
    GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_4); // Set PD4 as reset
    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_5); // Set PA5 as pause
    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_4); // Set PA4 as save
    
    TFT_Init_ILI9341_8bit(320, 240);
    TFT_Set_Pen(CL_AQUA, 3);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
    TFT_Fill_Screen(CL_AQUA);
    TFT_Set_Brush(1, CL_BLACK, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);

    HID_Enable(&readbuff,&writebuff);

    for(i = 0; i < COUNTERS; i++) {
        times[i] = 0;
    }

    print_timers();
}

int check_start() {
    int val;
    if (prev_b == B_START) {
        return 0;
    }

    val = Button(&GPIOA_IDR, 0, 1, 1);
    if(val) prev_b = B_START;

    return val;
}

int check_lap() {
    int val;
    if (prev_b == B_LAP) {
        return 0;
    }
    
    val = Button(&GPIOA_IDR, 6, 1, 1);
    if(val) prev_b = B_LAP;

    return val;
}

int check_reset() {
    int val;
    if (prev_b == B_RESET) {
        return 0;
    }
    
    val = Button(&GPIOD_IDR, 4, 1, 1);
    if(val) prev_b = B_RESET;

    return val;
}

int check_pause() {
    int val;
    if (prev_b == B_PAUSE) {
        return 0;
    }

    val = Button(&GPIOA_IDR, 5, 1, 1);
    if(val) prev_b = B_PAUSE;

    return val;
}

int check_save() {
    int val;
    if (prev_b == B_SAVE) {
        return 0;
    }

    val = Button(&GPIOA_IDR, 4, 1, 1);
    if(val) prev_b = B_SAVE;

    return val;
}

void start_timer() {
    writebuff[0] = start_msg[0];
    TFT_Write_Text("START", 100, 100);
    while(!HID_Write(&writebuff,64)); // Send the message
    curr_state = STATE_RUNNING;
}

void pause_timer() {
//    TFT_Write_Text("USAO", 150, 100);
    writebuff[0] = pause_msg[0];

    TFT_Write_Text("PAUSE", 120, 120);
    while(!HID_Write(&writebuff,64));
    curr_state = STATE_PAUSE;
}

void save_timer() {
    shift_timers(1);
}

void reset_timer() {
    writebuff[0] = reset_msg[0];
    TFT_Write_Text("RESET", 100, 140);
    while(!HID_Write(&writebuff,64));
}

void update_time() {
    times[0] = readbuff[0];
}

void lap_timer() {

    TFT_Write_Text("LAP", 100, 160);
    reset_timer();
    shift_timers(0);
    start_timer();
}

void main(void) {
  char cnt;
  Initialize();

    while (1) {
        // call print_timers() inside this loop.

        if (HID_Read()) { // this won't hang because we are using async interrupts
            if (curr_state == STATE_RUNNING) {
             // If we are not in a running state we just drop the messsage. @TODO: Check if we can skip HID_Read() all together.
                update_time(); // check state or drop message
                print_timers();
            }
        } else {
            if (curr_state == STATE_RUNNING) {
                if (check_pause()) {
                    pause_timer();
                } else if (check_lap()) {
                    lap_timer();
                    print_timers();
                } else if (check_save()) {
                    save_timer();
                    print_timers();
                } // Here we can stop, lap, save or pause.
            } else if (curr_state == STATE_PAUSE) {
                if (check_start()) {
                    start_timer();
                } else if (check_lap()) {
                    lap_timer();
                    print_timers();
                } else if (check_save()) {
                    save_timer();
                    print_timers();
                } else if (check_reset()) {
                    TFT_Write_Text("USAO", 150, 100);
                    reset_timer();
                    times[0] = 0;
                    print_timers();
                }// Here we can start, save
            }
        }
    }
}