// VS1053E constants
const char WRITE_CODE           = 0x02;
const char READ_CODE            = 0x03;

const char SCI_BASE_ADDR        = 0x00;
const char SCI_MODE_ADDR        = 0x00;
const char SCI_STATUS_ADDR      = 0x01;
const char SCI_BASS_ADDR        = 0x02;
const char SCI_CLOCKF_ADDR      = 0x03;
const char SCI_DECODE_TIME_ADDR = 0x04;
const char SCI_AUDATA_ADDR      = 0x05;
const char SCI_WRAM_ADDR        = 0x06;
const char SCI_WRAMADDR_ADDR    = 0x07;
const char SCI_HDAT0_ADDR       = 0x08;
const char SCI_HDAT1_ADDR       = 0x09;
const char SCI_AIADDR_ADDR      = 0x0A;
const char SCI_VOL_ADDR         = 0x0B;
const char SCI_AICTRL0_ADDR     = 0x0C;
const char SCI_AICTRL1_ADDR     = 0x0D;
const char SCI_AICTRL2_ADDR     = 0x0E;
const char SCI_AICTRL3_ADDR     = 0x0F;

// Writes one byte to MP3 SCI
void MP3_SCI_Write(char address, unsigned int data_in);
// Reads words_count words from MP3 SCI
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);
// Write one byte to MP3 SDI
void MP3_SDI_Write(char data_);
// Write 32 bytes to MP3 SDI
void MP3_SDI_Write_32(char *data_);
// Set volume
void MP3_Set_Volume(char left, char right);

/**************************************************************************************************
* End of File
**************************************************************************************************/