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
#define INITIAL_POS_Y 0
#define STOPWATCH_BUFFER_SIZE 10
#define STATE_STOP 0
#define STATE_RUNNING 1
#define STATE_PAUSE 2

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

bit          write_erase;
char         pen_size;
char start_msg[] = "S";
char reset_msg[] = "R";
char lap_msg[] = "L";
char pause_msg[] = "P";
int readbuff[32];
char writebuff[64];
int curr_state = STATE_STOP;

int times[COUNTERS];
unsigned int x_coord, y_coord;

void USB0Interrupt() iv IVT_INT_OTG_FS{
  USB_Interrupt_Proc();
}

void Initialize() {
	int i;

    HID_Enable(&readbuff,&writebuff);

	Glcd_Init();                                     // Initialize GLCD
	Glcd_Fill(0);                                    // Clear GLCD

	for(i = 0; i < COUNTERS; i++) {
		times[i] = 0;
	}
}

void delay2S() {                                    // 2 seconds delay function
  Delay_ms(2000);
}

void delay1S() {                                    // 2 seconds delay function
  Delay_ms(1000);
}

void delay10ms() {                                    // 2 seconds delay function
  Delay_ms(10);
}

void main() {
	Initialize();

	Glcd_Write_Text("CALIBRATION",32,3,1);
	Delay_ms(1000);
	Glcd_Fill(0);                                    // Clear GLCD

  // Glcd_Write_Text(clear_msg,1,0,0);

}

void main(void){
  char cnt;
  HID_Enable(&readbuff,&writebuff);

    while(1) {
        // call print_timers() inside this loop.
        if(HID_Read()) { // this won't hang because we are using async interrupts
            if(curr_state == STATE_RUNNING) { // If we are not in a running state we just drop the messsage. @TODO: Check if we can skip HID_Read() all together.
                update_time(); // check state or drop message
            }
        } else {
            if(curr_state == STATE_RUNNING) {
                // Here we can stop, lap or pause.
            } else if (curr_state == STATE_STOP) {
                // Here we can start
            } else if (curr_state == STATE_PAUSE) {
                // Here we can either start, lap or reset.
            }
            // Check state and then check for valid button clicks
            // Check for button clicks
        }
    }
}

void start_timer() {
    writebuff[0] = start_msg[0];
    while(!HID_Write(&writebuff,64)); // Send the message
    print_timers();
}

void pause_timer() {
    writebuff[0] = pause_msg[0];
    while(!HID_Write(&writebuff,64));
}

void reset_timer() {
    writebuff[0] = stop_msg[0];
    shift_timers();
    while(!HID_Write(&writebuff,64));
}

void update_time() {
    times[0] = readbuff[0];
}

void lap_timer() {
    reset_timer();
    start_timer();
}

void shift_timers() {
    int i, temp, t;
    t = times[0];

    for(i = 1; i < COUNTERS; i++) {
        temp = times[i];
        times[i] = t;
        t = temp;
    }

    times[0] = 0;
}

void print_timers() {
	int i, h, m, s, temp;
	int pos_y = INITIAL_POS_Y;
	char str[STOPWATCH_BUFFER_SIZE];

	Glcd_Fill(0);                                    // Clear GLCD
	delay10ms();

	for(i = 0; i < COUNTERS; i++) {
		temp = times[i];

		h = temp / 3600;
		temp %= 3600;

		m = temp / 60;
		temp %= 60;

		s = temp;

		sprintf(str, "%02d:%02d:%02d", h, m, s);
		Glcd_Write_Text(str, INITIAL_POS_X, pos_y, 1);
		delay10ms();
		pos_y += 2;
	}
}
