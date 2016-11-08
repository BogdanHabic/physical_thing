#line 1 "C:/Users/lazar/Desktop/physical_thing-master/slave/screen.c"
#line 42 "C:/Users/lazar/Desktop/physical_thing-master/slave/screen.c"
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;


bit write_erase;
char pen_size;
char start_msg[] = "S";
char reset_msg[] = "R";
char pause_msg[] = "P";
int readbuff[32];
char writebuff[64];
int curr_state =  2 ;
int prev_b = 0;
int timers_shifted = 0;

int times[ 4 ];
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

 for(i = 1; i <  4 ; i++) {
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
 int pos_y =  30 ;
 char str[ 10 ];

 if(timers_shifted) {
 TFT_Fill_Screen(CL_AQUA);
 timers_shifted = 0;
 }

 TFT_Rectangle(20, 30, 219, 50);

 for(i = 0; i <  4 ; i++) {
 temp = times[i];

 h = temp / 3600;
 temp %= 3600;

 m = temp / 60;
 temp %= 60;

 s = temp;

 sprintf(str, "%02d:%02d:%02d", h, m, s);
 TFT_Write_Text(str,  32 , pos_y);
 delay10ms();
 pos_y += 20;
 }
}

void Initialize() {
 int i;
 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_0);
 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_1);
 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_2);
 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_3);
 GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_4);

 TFT_Init_ILI9341_8bit(320, 240);
 TFT_Set_Pen(CL_AQUA, 3);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Fill_Screen(CL_AQUA);
 TFT_Set_Brush(1, CL_BLACK, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);

 HID_Enable(&readbuff,&writebuff);

 for(i = 0; i <  4 ; i++) {
 times[i] = 0;
 }

 print_timers();
}

int check_start() {
 int val;
 if (prev_b ==  1 ) {
 return 0;
 }

 val = Button(&GPIOA_IDR, 0, 1, 1);
 if(val) prev_b =  1 ;

 return val;
}

int check_lap() {
 int val;
 if (prev_b ==  2 ) {
 return 0;
 }

 val = Button(&GPIOA_IDR, 1, 1, 1);
 if(val) prev_b =  2 ;

 return val;
}

int check_reset() {
 int val;
 if (prev_b ==  3 ) {
 return 0;
 }

 val = Button(&GPIOA_IDR, 2, 1, 1);
 if(val) prev_b =  3 ;

 return val;
}

int check_pause() {
 int val;
 if (prev_b ==  4 ) {
 return 0;
 }

 val = Button(&GPIOA_IDR, 3, 1, 1);
 if(val) prev_b =  4 ;

 return val;
}

int check_save() {
 int val;
 if (prev_b ==  5 ) {
 return 0;
 }

 val = Button(&GPIOA_IDR, 4, 1, 1);
 if(val) prev_b =  5 ;

 return val;
}

void start_timer() {
 writebuff[0] = start_msg[0];
 while(!HID_Write(&writebuff,64));
 curr_state =  1 ;
}

void pause_timer() {
 writebuff[0] = pause_msg[0];
 while(!HID_Write(&writebuff,64));
}

void save_timer() {
 shift_timers(1);
}

void reset_timer() {
 writebuff[0] = reset_msg[0];
 while(!HID_Write(&writebuff,64));
}

void update_time() {
 times[0] = readbuff[0];
}

void lap_timer() {
 reset_timer();
 shift_timers(0);
 start_timer();
}

void main(void) {
 char cnt;
 Initialize();

 while (1) {



 if (curr_state ==  1 ) {
 if (HID_Read()) {

 TFT_Write_Text(readbuff, 200, 200);
 update_time();
 print_timers();
 }
 } else {
 if (curr_state ==  1 ) {
 if (check_pause()) {
 pause_timer();
 } else if (check_lap()) {
 lap_timer();
 print_timers();
 } else if (check_save()) {
 save_timer();
 print_timers();
 }
 } else if (curr_state ==  2 ) {
 if (check_start()) {
 start_timer();
 } else if (check_lap()) {
 lap_timer();
 print_timers();
 } else if (check_save()) {
 save_timer();
 print_timers();
 }
 }
 }
 }
}
