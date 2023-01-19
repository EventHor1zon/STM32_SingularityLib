# STM32_SingularityLib
Attempt at writing some RTOS based STM32 interface drivers.


## Goals

- Write a FreeRTOS based object-oriented bare-metal STM32 library
- Asynchronous interrupt/event-driven interface drivers
- Common interface drivers, gpio, i2c, basic SPI, ring buffer, watchdogs, etc
- Write connection layer utilising dma to enable rapid data transfer between peripherals


## Architecture

Ideally heirarchical state machine. First focus on getting an interrupt/event-driven 
freertos drivers for common interfaces. Build more heirarchical structure as things evolve.