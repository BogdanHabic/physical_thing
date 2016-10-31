#include "mapping_objects.h"
#include "mapping_resources.h"

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
TLabel *local_label;
TLabel *exec_label;
short label_order;
TImage *local_image;
TImage *exec_image;
short image_order;
TBox *local_box;
TBox *exec_box;
short box_order;


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
  PressedObject = 0;
  PressedObjectType = -1;
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


/////////////////////////
  TScreen*  CurrentScreen;

  TScreen                Screen1;
  TImage               Image1;
  TBox                   Box1;
  TBox                   Box2;
  TBox                   Box3;
  TBox                   Box4;
  TBox                   Box5;
  TBox                   Box6;
  TBox                   Box7;
  TBox                   Box9;
  TLabel                 Label1;
char Label1_Caption[76] = "       Click on the area to diplay info about it.                         ";

  TLabel                 * const code Screen1_Labels[1]=
         {
         &Label1               
         };
  TImage                 * const code Screen1_Images[1]=
         {
         &Image1               
         };
  TBox                   * const code Screen1_Boxes[8]=
         {
         &Box1,                
         &Box2,                
         &Box3,                
         &Box4,                
         &Box5,                
         &Box6,                
         &Box7,                
         &Box9                 
         };




static void InitializeObjects() {
  Screen1.Color                     = 0xFFFF;
  Screen1.Width                     = 320;
  Screen1.Height                    = 240;
  Screen1.LabelsCount               = 1;
  Screen1.Labels                    = Screen1_Labels;
  Screen1.ImagesCount               = 1;
  Screen1.Images                    = Screen1_Images;
  Screen1.BoxesCount                = 8;
  Screen1.Boxes                     = Screen1_Boxes;
  Screen1.ObjectsCount              = 10;


  Image1.OwnerScreen     = &Screen1;
  Image1.Order          = 0;
  Image1.Left           = 4;
  Image1.Top            = 34;
  Image1.Width          = 314;
  Image1.Height         = 202;
  Image1.Picture_Type        = 1;
  Image1.Picture_Ratio  = 1;
  Image1.Picture_Name   = world_map_jpg;
  Image1.Visible        = 1;
  Image1.Active         = 1;
  Image1.OnUpPtr         = 0;
  Image1.OnDownPtr       = 0;
  Image1.OnClickPtr      = 0;
  Image1.OnPressPtr      = 0;

  Box1.OwnerScreen     = &Screen1;
  Box1.Order           = 1;
  Box1.Left            = 156;
  Box1.Top             = 93;
  Box1.Width           = 39;
  Box1.Height          = 25;
  Box1.Pen_Width       = 1;
  Box1.Pen_Color       = 0x0000;
  Box1.Visible         = 0;
  Box1.Active          = 1;
  Box1.Transparent     = 1;
  Box1.Gradient        = 1;
  Box1.Gradient_Orientation    = 0;
  Box1.Gradient_Start_Color    = 0xFFFF;
  Box1.Gradient_End_Color      = 0xC618;
  Box1.Color           = 0xC618;
  Box1.PressColEnabled     = 0;
  Box1.Press_Color     = 0x8410;
  Box1.OnUpPtr         = 0;
  Box1.OnDownPtr       = 0;
  Box1.OnClickPtr      = Box1Click;
  Box1.OnPressPtr      = 0;

  Box2.OwnerScreen     = &Screen1;
  Box2.Order           = 2;
  Box2.Left            = 180;
  Box2.Top             = 127;
  Box2.Width           = 22;
  Box2.Height          = 18;
  Box2.Pen_Width       = 1;
  Box2.Pen_Color       = 0x0000;
  Box2.Visible         = 0;
  Box2.Active          = 1;
  Box2.Transparent     = 1;
  Box2.Gradient        = 1;
  Box2.Gradient_Orientation    = 0;
  Box2.Gradient_Start_Color    = 0xFFFF;
  Box2.Gradient_End_Color      = 0xC618;
  Box2.Color           = 0xC618;
  Box2.PressColEnabled     = 0;
  Box2.Press_Color     = 0x8410;
  Box2.OnUpPtr         = 0;
  Box2.OnDownPtr       = 0;
  Box2.OnClickPtr      = Box2Click;
  Box2.OnPressPtr      = 0;

  Box3.OwnerScreen     = &Screen1;
  Box3.Order           = 3;
  Box3.Left            = 233;
  Box3.Top             = 158;
  Box3.Width           = 46;
  Box3.Height          = 40;
  Box3.Pen_Width       = 1;
  Box3.Pen_Color       = 0x0000;
  Box3.Visible         = 0;
  Box3.Active          = 1;
  Box3.Transparent     = 1;
  Box3.Gradient        = 1;
  Box3.Gradient_Orientation    = 0;
  Box3.Gradient_Start_Color    = 0xFFFF;
  Box3.Gradient_End_Color      = 0xC618;
  Box3.Color           = 0xC618;
  Box3.PressColEnabled     = 0;
  Box3.Press_Color     = 0x8410;
  Box3.OnUpPtr         = 0;
  Box3.OnDownPtr       = 0;
  Box3.OnClickPtr      = Box3Click;
  Box3.OnPressPtr      = 0;

  Box4.OwnerScreen     = &Screen1;
  Box4.Order           = 4;
  Box4.Left            = 140;
  Box4.Top             = 135;
  Box4.Width           = 37;
  Box4.Height          = 55;
  Box4.Pen_Width       = 1;
  Box4.Pen_Color       = 0x0000;
  Box4.Visible         = 0;
  Box4.Active          = 1;
  Box4.Transparent     = 1;
  Box4.Gradient        = 1;
  Box4.Gradient_Orientation    = 0;
  Box4.Gradient_Start_Color    = 0xFFFF;
  Box4.Gradient_End_Color      = 0xC618;
  Box4.Color           = 0xC618;
  Box4.PressColEnabled     = 0;
  Box4.Press_Color     = 0x8410;
  Box4.OnUpPtr         = 0;
  Box4.OnDownPtr       = 0;
  Box4.OnClickPtr      = Box4Click;
  Box4.OnPressPtr      = 0;

  Box5.OwnerScreen     = &Screen1;
  Box5.Order           = 5;
  Box5.Left            = 88;
  Box5.Top             = 152;
  Box5.Width           = 43;
  Box5.Height          = 56;
  Box5.Pen_Width       = 1;
  Box5.Pen_Color       = 0x0000;
  Box5.Visible         = 0;
  Box5.Active          = 1;
  Box5.Transparent     = 1;
  Box5.Gradient        = 1;
  Box5.Gradient_Orientation    = 0;
  Box5.Gradient_Start_Color    = 0xFFFF;
  Box5.Gradient_End_Color      = 0xC618;
  Box5.Color           = 0xC618;
  Box5.PressColEnabled     = 0;
  Box5.Press_Color     = 0x8410;
  Box5.OnUpPtr         = 0;
  Box5.OnDownPtr       = 0;
  Box5.OnClickPtr      = Box5Click;
  Box5.OnPressPtr      = 0;

  Box6.OwnerScreen     = &Screen1;
  Box6.Order           = 6;
  Box6.Left            = 18;
  Box6.Top             = 72;
  Box6.Width           = 95;
  Box6.Height          = 53;
  Box6.Pen_Width       = 1;
  Box6.Pen_Color       = 0x0000;
  Box6.Visible         = 0;
  Box6.Active          = 1;
  Box6.Transparent     = 1;
  Box6.Gradient        = 1;
  Box6.Gradient_Orientation    = 0;
  Box6.Gradient_Start_Color    = 0xFFFF;
  Box6.Gradient_End_Color      = 0xC618;
  Box6.Color           = 0xC618;
  Box6.PressColEnabled     = 0;
  Box6.Press_Color     = 0x8410;
  Box6.OnUpPtr         = 0;
  Box6.OnDownPtr       = 0;
  Box6.OnClickPtr      = Box6Click;
  Box6.OnPressPtr      = 0;

  Box7.OwnerScreen     = &Screen1;
  Box7.Order           = 7;
  Box7.Left            = 209;
  Box7.Top             = 77;
  Box7.Width           = 76;
  Box7.Height          = 61;
  Box7.Pen_Width       = 1;
  Box7.Pen_Color       = 0x0000;
  Box7.Visible         = 0;
  Box7.Active          = 1;
  Box7.Transparent     = 1;
  Box7.Gradient        = 1;
  Box7.Gradient_Orientation    = 0;
  Box7.Gradient_Start_Color    = 0xFFFF;
  Box7.Gradient_End_Color      = 0xC618;
  Box7.Color           = 0xC618;
  Box7.PressColEnabled     = 0;
  Box7.Press_Color     = 0x8410;
  Box7.OnUpPtr         = 0;
  Box7.OnDownPtr       = 0;
  Box7.OnClickPtr      = Box7Click;
  Box7.OnPressPtr      = 0;

  Box9.OwnerScreen     = &Screen1;
  Box9.Order           = 8;
  Box9.Left            = 5;
  Box9.Top             = 5;
  Box9.Width           = 308;
  Box9.Height          = 25;
  Box9.Pen_Width       = 1;
  Box9.Pen_Color       = 0x0000;
  Box9.Visible         = 1;
  Box9.Active          = 1;
  Box9.Transparent     = 0;
  Box9.Gradient        = 0;
  Box9.Gradient_Orientation    = 0;
  Box9.Gradient_Start_Color    = 0xFFFF;
  Box9.Gradient_End_Color      = 0xC618;
  Box9.Color           = 0xC618;
  Box9.PressColEnabled     = 1;
  Box9.Press_Color     = 0x8410;
  Box9.OnUpPtr         = 0;
  Box9.OnDownPtr       = 0;
  Box9.OnClickPtr      = 0;
  Box9.OnPressPtr      = 0;

  Label1.OwnerScreen     = &Screen1;
  Label1.Order          = 9;
  Label1.Left           = 7;
  Label1.Top            = 12;
  Label1.Width          = 305;
  Label1.Height         = 12;
  Label1.Visible        = 1;
  Label1.Active         = 1;
  Label1.Caption        = Label1_Caption;
  Label1.FontName       = Tahoma11x13_Regular;
  Label1.Font_Color     = 0x0000;
  Label1.OnUpPtr         = 0;
  Label1.OnDownPtr       = 0;
  Label1.OnClickPtr      = 0;
  Label1.OnPressPtr      = 0;
}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
  if ( (Left<= X) && (Left+ Width - 1 >= X) &&
       (Top <= Y)  && (Top + Height - 1 >= Y) )
    return 1;
  else
    return 0;
}


#define GetLabel(index)               CurrentScreen->Labels[index]
#define GetImage(index)               CurrentScreen->Images[index]
#define GetBox(index)                 CurrentScreen->Boxes[index]


void DrawLabel(TLabel *ALabel) {
int x_pos, y_pos;
  x_pos = 0;
  y_pos = 0;
  if (ALabel->Visible == 1) {
    TFT_Set_Font(ALabel->FontName, ALabel->Font_Color, FO_HORIZONTAL);
    TFT_Write_Text_Return_Pos(ALabel->Caption, ALabel->Left, ALabel->Top);
    x_pos = ALabel->Left + ((int)(ALabel->Width - caption_length) / 2);
    y_pos = ALabel->Top + ((int)(ALabel->Height - caption_height) / 2);
    if (x_pos > ALabel->Left) {
      TFT_Write_Text(ALabel->Caption, x_pos, y_pos);
    }
    else {
      TFT_Write_Text(ALabel->Caption, ALabel->Left, ALabel->Top);
    }
  }
}

void DrawImage(TImage *AImage) {
  if (AImage->Visible) {
    TFT_Image_Jpeg(AImage->Left, AImage->Top, AImage->Picture_Name);
  }
}

void DrawBox(TBox *ABox) {
  if (ABox->Visible == 1) {
    if (object_pressed == 1) {
      object_pressed = 0;
      TFT_Set_Brush(ABox->Transparent, ABox->Press_Color, ABox->Gradient, ABox->Gradient_Orientation, ABox->Gradient_End_Color, ABox->Gradient_Start_Color);
    }
    else {
      TFT_Set_Brush(ABox->Transparent, ABox->Color, ABox->Gradient, ABox->Gradient_Orientation, ABox->Gradient_Start_Color, ABox->Gradient_End_Color);
    }
    TFT_Set_Pen(ABox->Pen_Color, ABox->Pen_Width);
    TFT_Rectangle(ABox->Left, ABox->Top, ABox->Left + ABox->Width - 1, ABox->Top + ABox->Height - 1);
  }
}

void DrawScreen(TScreen *aScreen) {
  unsigned short order;
  unsigned short label_idx;
  TLabel *local_label;
  unsigned short image_idx;
  TImage *local_image;
  unsigned short box_idx;
  TBox *local_box;
  char save_bled, save_bled_direction;

  object_pressed = 0;
  order = 0;
  label_idx = 0;
  image_idx = 0;
  box_idx = 0;
  CurrentScreen = aScreen;

  if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
    save_bled = TFT_BLED;
    TFT_BLED           = 0;
    TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
    TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 8, 9);   // Initialize touch panel
    TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                          // Set touch panel ADC threshold
    TFT_Fill_Screen(CurrentScreen->Color);
    display_width = CurrentScreen->Width;
    display_height = CurrentScreen->Height;
    TFT_BLED           = save_bled;
  }
  else
    TFT_Fill_Screen(CurrentScreen->Color);


  while (order < CurrentScreen->ObjectsCount) {
    if (label_idx < CurrentScreen->LabelsCount) {
      local_label = GetLabel(label_idx);
      if (order == local_label->Order) {
        label_idx++;
        order++;
        DrawLabel(local_label);
      }
    }

    if (box_idx < CurrentScreen->BoxesCount) {
      local_box = GetBox(box_idx);
      if (order == local_box->Order) {
        box_idx++;
        order++;
        DrawBox(local_box);
      }
    }

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

void Get_Object(unsigned int X, unsigned int Y) {
  label_order         = -1;
  image_order         = -1;
  box_order           = -1;
  //  Labels
  for ( _object_count = 0 ; _object_count < CurrentScreen->LabelsCount ; _object_count++ ) {
    local_label = GetLabel(_object_count);
    if (local_label->Active == 1) {
      if (IsInsideObject(X, Y, local_label->Left, local_label->Top,
                         local_label->Width, local_label->Height) == 1) {
        label_order = local_label->Order;
        exec_label = local_label;
      }
    }
  }

  //  Images
  for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
    local_image = GetImage(_object_count);
    if (local_image->Active == 1) {
      if (IsInsideObject(X, Y, local_image->Left, local_image->Top,
                         local_image->Width, local_image->Height) == 1) {
        image_order = local_image->Order;
        exec_image = local_image;
      }
    }
  }

  //  Boxes
  for ( _object_count = 0 ; _object_count < CurrentScreen->BoxesCount ; _object_count++ ) {
    local_box = GetBox(_object_count);
    if (local_box->Active == 1) {
      if (IsInsideObject(X, Y, local_box->Left, local_box->Top,
                         local_box->Width, local_box->Height) == 1) {
        box_order = local_box->Order;
        exec_box = local_box;
      }
    }
  }

  _object_count = -1;
  if (label_order >  _object_count )
    _object_count = label_order;
  if (image_order >  _object_count )
    _object_count = image_order;
  if (box_order >  _object_count )
    _object_count = box_order;
}


static void Process_TP_Press(unsigned int X, unsigned int Y) {
  exec_label          = 0;
  exec_image          = 0;
  exec_box            = 0;

  Get_Object(X, Y);


  if (_object_count != -1) {
    if (_object_count == label_order) {
      if (exec_label->Active == 1) {
        if (exec_label->OnPressPtr != 0) {
          exec_label->OnPressPtr();
          return;
        }
      }
    }

    if (_object_count == image_order) {
      if (exec_image->Active == 1) {
        if (exec_image->OnPressPtr != 0) {
          exec_image->OnPressPtr();
          return;
        }
      }
    }

    if (_object_count == box_order) {
      if (exec_box->Active == 1) {
        if (exec_box->OnPressPtr != 0) {
          exec_box->OnPressPtr();
          return;
        }
      }
    }

  }
}

static void Process_TP_Up(unsigned int X, unsigned int Y) {

  switch (PressedObjectType) {
    // Box
    case 6: {
      if (PressedObject != 0) {
        exec_box = (TBox*)PressedObject;
        if ((exec_box->PressColEnabled == 1) && (exec_box->OwnerScreen == CurrentScreen)) {
          DrawBox(exec_box);
        }
        break;
      }
      break;
    }
  }

  exec_label          = 0;
  exec_image          = 0;

  Get_Object(X, Y);


  if (_object_count != -1) {
  // Labels
    if (_object_count == label_order) {
      if (exec_label->Active == 1) {
        if (exec_label->OnUpPtr != 0)
          exec_label->OnUpPtr();
        if (PressedObject == (void *)exec_label)
          if (exec_label->OnClickPtr != 0)
            exec_label->OnClickPtr();
        PressedObject = 0;
        PressedObjectType = -1;
        return;
      }
    }

  // Images
    if (_object_count == image_order) {
      if (exec_image->Active == 1) {
        if (exec_image->OnUpPtr != 0)
          exec_image->OnUpPtr();
        if (PressedObject == (void *)exec_image)
          if (exec_image->OnClickPtr != 0)
            exec_image->OnClickPtr();
        PressedObject = 0;
        PressedObjectType = -1;
        return;
      }
    }

  // Boxes
    if (_object_count == box_order) {
      if (exec_box->Active == 1) {
        if (exec_box->OnUpPtr != 0)
          exec_box->OnUpPtr();
        if (PressedObject == (void *)exec_box)
          if (exec_box->OnClickPtr != 0)
            exec_box->OnClickPtr();
        PressedObject = 0;
        PressedObjectType = -1;
        return;
      }
    }

  }
  PressedObject = 0;
  PressedObjectType = -1;
}

static void Process_TP_Down(unsigned int X, unsigned int Y) {

  object_pressed      = 0;
  exec_label          = 0;
  exec_image          = 0;
  exec_box            = 0;

  Get_Object(X, Y);

  if (_object_count != -1) {
    if (_object_count == label_order) {
      if (exec_label->Active == 1) {
        PressedObject = (void *)exec_label;
        PressedObjectType = 2;
        if (exec_label->OnDownPtr != 0) {
          exec_label->OnDownPtr();
          return;
        }
      }
    }

    if (_object_count == image_order) {
      if (exec_image->Active == 1) {
        PressedObject = (void *)exec_image;
        PressedObjectType = 3;
        if (exec_image->OnDownPtr != 0) {
          exec_image->OnDownPtr();
          return;
        }
      }
    }

    if (_object_count == box_order) {
      if (exec_box->Active == 1) {
        if (exec_box->PressColEnabled == 1) {
          object_pressed = 1;
          DrawBox(exec_box);
        }
        PressedObject = (void *)exec_box;
        PressedObjectType = 6;
        if (exec_box->OnDownPtr != 0) {
          exec_box->OnDownPtr();
          return;
        }
      }
    }

  }
}

void Check_TP() {
  if (TP_TFT_Press_Detect()) {
    // After a PRESS is detected read X-Y and convert it to Display dimensions space
    if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
      Process_TP_Press(Xcoord, Ycoord);
      if (PenDown == 0) {
        PenDown = 1;
        Process_TP_Down(Xcoord, Ycoord);
      }
    }
  }
  else if (PenDown == 1) {
    PenDown = 0;
    Process_TP_Up(Xcoord, Ycoord);
  }
}

void Init_MCU(){
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

  InitializeObjects();
  display_width = Screen1.Width;
  display_height = Screen1.Height;
  DrawScreen(&Screen1);
}