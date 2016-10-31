#include "mapping_objects.h"
#include "mapping_resources.h"

//--------------------- User code ---------------------//
extern unsigned int caption_length, caption_height;


void Clear_Label() {
    TFT_Set_Font(Label1.FontName, Screen1.Color, FO_HORIZONTAL);
    TFT_Write_Text(Label1.Caption, Label1.Left + ((int)(Label1.Width - caption_length) / 2), Label1.Top + ((int)(Label1.Height - caption_height) / 2));
}

//----------------- End of User code ------------------//

// Event Handlers

void Box6Click() {
  // North America
  Clear_Label();
  strcpy(Label1_Caption, "It is the third largest continent in area, following Asia and Africa.");
  DrawLabel(&Label1);
}

void Box5Click() {
  // South America
  Clear_Label();
  strcpy(Label1_Caption, "South America ranks fourth in area, and fifth in population.");
  DrawLabel(&Label1);
}

void Box4Click() {
  // Africa
  Clear_Label();
  strcpy(Label1_Caption, "Africa is the second largest and second most populous continent.");
  DrawLabel(&Label1);
}

void Box1Click() {
  // Europe
  Clear_Label();
  strcpy(Label1_Caption, "Europe is the world second smallest continent by surface area.");
  DrawLabel(&Label1);
}

void Box2Click() {
  // Middle East
  Clear_Label();
  strcpy(Label1_Caption, "It is a region that encompasses Western Asia and North Africa.");
  DrawLabel(&Label1);
}

void Box7Click() {
  // Asia
  Clear_Label();
  strcpy(Label1_Caption, "Asia is the world largest and most populous continent.");
  DrawLabel(&Label1);
}

void Box3Click() {
  // Australia
  Clear_Label();
  strcpy(Label1_Caption, "Australia is the smallest of the geographic continents.");
  DrawLabel(&Label1);
}
