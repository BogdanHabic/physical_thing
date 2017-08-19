#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for ARM/Examples/ST/Development Systems/EasyMx PRO v7 for STM32 ARM/TFT/TFT_events_code.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/examples/st/development systems/easymx pro v7 for stm32 arm/tft/tft_objects.h"
enum GlcdColor {_clClear, _clDraw, _clInvert};

typedef struct Screen TScreen;

typedef struct Image {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 const char *Picture_Name;
 char Visible;
 char Active;
 char Picture_Type;
 char Picture_Ratio;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TImage;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned short ObjectsCount;
 unsigned int ImagesCount;
 TImage * const code *Images;
};

extern TScreen Screen1;
extern TImage Image1;
extern TImage * const code Screen1_Images[1];
#line 46 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/examples/st/development systems/easymx pro v7 for stm32 arm/tft/tft_objects.h"
void DrawScreen(TScreen *aScreen);
void DrawImage(TImage *AImage);
void Check_TP();
void Start_TP();
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/examples/st/development systems/easymx pro v7 for stm32 arm/tft/tft_resources.h"
const code char easymx_pro_v7_stm32_jpg[61019];
