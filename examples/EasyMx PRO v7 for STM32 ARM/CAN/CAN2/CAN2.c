/* Project name:
     CAN_2nd (CAN Network demonstration with mikroE's CAN-1 module)
 * Copyright:
     (c) MikroElektronika, 2012.
 * Revision History:
     20110511(TL):
       - initial release;
 * Description:
     This code demonstrates how to use CAN library functions and procedures.
     It is used together with the CAN_1st example (on second MCU), and it can
     be used to test the connection of MCU to the CAN network.
     With minor adjustments, it should work with any other MCU that has a CAN module.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00220364.pdf
     Dev.Board:       EasyMx PRO v7 for STM32(R) ARM(R)
                      http://www.mikroe.com/easymx-pro/stm32/
                      ac:CAN
     Oscillator:      HSE-PLL, 72.000MHz
     Ext. Modules:    None.
     SW:              mikroC PRO for ARM
'                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Turn on PORTE LEDs at SW10 and turn on CAN RX and TX switches at SW12.
 */
unsigned long Can_Init_Flags;
unsigned char Can_Send_Flags, Can_Rcv_Flags; // can flags
unsigned char Rx_Data_Len;                                   // received data length in bytes
char RxTx_Data[8];                                           // can rx/tx data buffer
char Msg_Rcvd;                                               // reception flag
const long ID_1st = 12111, ID_2nd = 3;                       // node IDs
long Rx_ID;

void main() {

  GPIO_Digital_Output(&GPIOE_BASE, 0xFF00);
  GPIOE_ODR = 0;
  
  Can_Init_Flags = 0;                                       //
  Can_Send_Flags = 0;                                       // clear flags
  Can_Rcv_Flags  = 0;                                       //

  Can_Send_Flags = _CAN_TX_XTD_FRAME &                      //     with CANWrite
                   _CAN_TX_NO_RTR_FRAME;

  Can_Init_Flags = _CAN_CONFIG_AUTOMATIC_RETRANSMISSION &          // form value to be used
                   _CAN_CONFIG_RX_FIFO_NOT_LOCKED_ON_OVERRUN &     // with CANInit
                   _CAN_CONFIG_TIME_TRIGGERED_MODE_DISABLED &
                   _CAN_CONFIG_TX_FIFO_PRIORITY_BY_IDINTIFIER &
                   _CAN_CONFIG_WAKE_UP;

  CAN1InitializeAdvanced(1,5,4,4,1,Can_Init_Flags, &_GPIO_MODULE_CAN1_PD01);  // Initialize CAN module
  CAN1SetOperationMode(_CAN_OperatingMode_Initialization);                    // set CONFIGURATION mode
  CANSetFilterScale32(0, _CAN_FILTER_ENABLED & _CAN_FILTER_ID_MASK_MODE & _CAN_FILTER_XTD_MSG, ID_1st, -1);

  CAN1SetOperationMode(_CAN_OperatingMode_Normal);               // set NORMAL mode

  while (1) {                                                                  // endless loop
    Msg_Rcvd = CAN1Read(0, &Rx_ID , RxTx_Data , &Rx_Data_Len, &Can_Rcv_Flags); // receive message
    if ((Rx_ID == ID_1st) && Msg_Rcvd) {                                       // if message received check id
      GPIOE_ODR  = RxTx_Data[0] << 8;                                          // id correct, output data at PORTE
      RxTx_Data[0]++ ;                                                         // increment received data
      CAN1Write(ID_2nd, RxTx_Data, 1, Can_Send_Flags);                         // send incremented data back
    }
  }
}