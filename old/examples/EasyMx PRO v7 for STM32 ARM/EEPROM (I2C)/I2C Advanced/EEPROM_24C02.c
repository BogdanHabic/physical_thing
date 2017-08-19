//EEPROM 24C02 read/write library

char data_[256];

//--------------- Performs 24C02 Init
void EEPROM_24C02_Init() {
  I2C1_Init();
}//~

//--------------- Writes data to 24C02 EEPROM - signle location
void EEPROM_24C02_WrSingle(unsigned short wAddr, unsigned short wData) {
  data_[0] = wAddr;
  data_[1] = wData;
  I2C1_Start();
  // issue I2C start signal
  I2C1_Write(0x50,data_,2,END_MODE_STOP);
}//~

//--------------- Reads data from 24C02 EEPROM - single location (random)
unsigned short EEPROM_24C02_RdSingle(unsigned short rAddr) {
  data_[0] = rAddr;
  I2C1_Start();              // issue I2C start signal
  I2C1_Write(0x50,data_,1,END_MODE_RESTART);
  I2C1_Read(0x50,data_,1,END_MODE_STOP);

  return data_[0];
}//~

//--------------- Reads data from 24C02 EEPROM - sequential read

void EEPROM_24C02_RdSeq(unsigned short rAddr,
                        unsigned char *rdData,
                        unsigned long rLen) {
  data_[0] = rAddr;
  I2C1_Start();              // issue I2C start signal
  I2C1_Write(0x50,data_,1,END_MODE_RESTART);
  I2C1_Read(0x50,rdData,rLen,END_MODE_STOP);
}//~

