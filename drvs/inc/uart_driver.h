#ifndef UART_DRIVER_H
#define UART_DRIVER_H

#include <stdint.h>

void UART_Init (uint32_t baud_rate);
void UART_Transmit (uint8_t data);
uint8_t UART_Receive (void);
void UART_Loopback (void);

#endif   // UART_DRIVER_H
