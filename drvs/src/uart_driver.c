#include "stm32f4xx_hal_rcc.h"
#include "stm32f4xx_hal_uart.h"
#include <stm32f4xx_hal.h>
// Hàm khởi tạo UART
void
UART_Init (uint32_t baud_rate)
{
    // Mã cấu hình ở đây (cài đặt tốc độ baud, số bit dữ liệu, bit dừng, v.v.)
}

// Hàm truyền UART
void
UART_Transmit (uint8_t data)
{
    while ()
        ;
    // Chờ cho đến khi sẵn sàng truyền
    HAL_UART_Transmit = data;
}

// Hàm nhận UART
uint8_t
UART_Receive (void)
{
    while ()
        ;   // Chờ cho đến khi dữ liệu được nhận
    return HAL_UART_Receive = data;
}

// Trình xử lý ngắt UART
void
UART_InterruptHandler (void)
{
    if (UART_STATUS_REGISTER & RECEIVE_INTERRUPT)
        {
            uint8_t received_data = UART_DATA_REGISTER;
            // Xử lý dữ liệu nhận được
        }
}
