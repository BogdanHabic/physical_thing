// Global Variables
char mp3_filename[14] = "sound.mp3";   // MP3 file name
unsigned long file_size;
const BYTES_2_WRITE = 32;
const BUFFER_SIZE = 512;
char mp3_buffer[BUFFER_SIZE];
char volume_left, volume_right;

// Functions
void MP3_Init(void);
void MP3_Start(void);
void MP3_Test(char *test);

//- Imported from MP3_DRIVER.H --------------------------------------------------------------------
extern const char WRITE_CODE;
extern const char READ_CODE;

extern const char SCI_BASE_ADDR;
extern const char SCI_MODE_ADDR;
extern const char SCI_STATUS_ADDR;
extern const char SCI_BASS_ADDR;
extern const char SCI_CLOCKF_ADDR;
extern const char SCI_DECODE_TIME_ADDR;
extern const char SCI_AUDATA_ADDR;
extern const char SCI_WRAM_ADDR;
extern const char SCI_WRAMADDR_ADDR;
extern const char SCI_HDAT0_ADDR;
extern const char SCI_HDAT1_ADDR;
extern const char SCI_AIADDR_ADDR;
extern const char SCI_VOL_ADDR;
extern const char SCI_AICTRL0_ADDR;
extern const char SCI_AICTRL1_ADDR;
extern const char SCI_AICTRL2_ADDR;
extern const char SCI_AICTRL3_ADDR;

extern void MP3_SCI_Write(char address, unsigned int data_in);
extern void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);
extern void MP3_SDI_Write(char data_);
extern void MP3_SDI_Write_32(char *data_);
extern void MP3_SDI_Write_256(char *data_);
extern void MP3_Set_Volume(char left,char right);

// !!!! This is only for testing proposes, remove for normal use !!!!
unsigned char ucMP3_run_test;
// !!!! This is only for testing proposes, remove for normal use !!!!

/**************************************************************************************************
* End of File
**************************************************************************************************/