#include "TFT_objects.h"
#include "TFT_resources.h"


// TFT module connections
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;
// End TFT module connections

// Global variables
unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 750;
char PenDown;
void *PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;
TImage *local_image;
TImage *exec_image;
short image_order;

static void InitializeTouchPanel() {
  TFT_Init_ILI9341_8bit(320, 240);
}


/////////////////////////
  TScreen*  CurrentScreen;

  TScreen                Screen1;
  TImage               Image1;
  TImage                 * const code Screen1_Images[1]=
         {
         &Image1               
         };

static void InitializeObjects() {
  Screen1.Color                     = 0x8410;
  Screen1.Width                     = 240;
  Screen1.Height                    = 320;
  Screen1.ImagesCount               = 1;
  Screen1.Images                    = Screen1_Images;
  Screen1.ObjectsCount              = 1;


  Image1.OwnerScreen     = &Screen1;
  Image1.Order          = 0;
  Image1.Left           = 0;
  Image1.Top            = 0;
  Image1.Width          = 240;
  Image1.Height         = 320;
  Image1.Picture_Type   = 1;
  Image1.Picture_Ratio  = 1;
  Image1.Picture_Name   = easymx_pro_v7_stm32_jpg;
  Image1.Visible        = 1;
  Image1.Active         = 1;
  Image1.OnUpPtr         = 0;
  Image1.OnDownPtr       = 0;
  Image1.OnClickPtr      = 0;
  Image1.OnPressPtr      = 0;
}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
  if ( (Left<= X) && (Left+ Width - 1 >= X) &&
       (Top <= Y)  && (Top + Height - 1 >= Y) )
    return 1;
  else
    return 0;
}


#define GetImage(index)               CurrentScreen->Images[index]


void DrawImage(TImage *AImage) {
  if (AImage->Visible) {
    TFT_Image_Jpeg(AImage->Left, AImage->Top, AImage->Picture_Name);
  }
}

void DrawScreen(TScreen *aScreen) {
  unsigned short order;
  unsigned short image_idx;
  TImage *local_image;
  char save_bled, save_bled_direction;

  object_pressed = 0;
  order = 0;
  image_idx = 0;
  CurrentScreen = aScreen;

  if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
    save_bled = TFT_BLED;
//    save_bled_direction = TFT_BLED_Direction;
//    TFT_BLED_Direction = 1;
    TFT_BLED           = 0;
    TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
    TFT_Fill_Screen(CurrentScreen->Color);
    display_width = CurrentScreen->Width;
    display_height = CurrentScreen->Height;
    TFT_BLED           = save_bled;
//    TFT_BLED_Direction = save_bled_direction;
  }
  else
    TFT_Fill_Screen(CurrentScreen->Color);


  while (order < CurrentScreen->ObjectsCount) {
    if (image_idx  < CurrentScreen->ImagesCount) {
      local_image = GetImage(image_idx);
      if (order == local_image->Order) {
        image_idx++;
        order++;
        DrawImage(local_image);
      }
    }

  }
}

void Init_MCU(){
  GPIO_Config(&GPIOE_BASE, _GPIO_PINMASK_9, _GPIO_CFG_DIGITAL_OUTPUT);
  TFT_BLED = 1;
  TFT_Set_Default_Mode();
}

void Start_TP() {
  Init_MCU();

  InitializeTouchPanel();

  InitializeObjects();
  display_width = Screen1.Width;
  display_height = Screen1.Height;
  DrawScreen(&Screen1);
}