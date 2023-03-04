# STM32_SingularityLib

Attempt at writing some RTOS based STM32 interface drivers.


## Goals

This is a learning project to develop my architecture, bare-metal, embedded development skills. The goals below are aspirations to remember when writing this code rather than hard and fast rules.

- Write a FreeRTOS based object-oriented bare-metal STM32 library
- Asynchronous interrupt/event-driven interface drivers
- Common interface drivers, gpio, i2c, basic SPI, ring buffer, watchdogs, etc
- Write connection layer utilising dma to enable rapid data transfer between peripherals
- Develop a stable and portable build environment using docker
- Write Unit Tests for core drivers - investigate/learn some unity 
- Use index and static analysis provided by cpptools and/or clangd
- Create scripts to enable easier hardware/software debugging
- Remember the essentials:
    - Gitflow - core/bugfix/feature/etc
    - Format code with clang
    - Naming convention - keep it consistent!


## Architecture

Ideally heirarchical state machine. First focus on getting an interrupt/event-driven 
freertos drivers for common interfaces. Build more heirarchical structure as things evolve.


## Things to do

- Create a basic portable CMake based docker build system
- Try to deploy clangd in a docker container to provide IDE compiler assistance/autocomplete
- Write some bare-metal interfaces
    - GPIO
    - I2C
    - UART
    - CAN ?
    - SPI ?
    - Power Control
    - System settings
    - Cortex M3 interface
- Write object-oriented RTOS heirarchical state drivers for common interfaces
    - GPIO
    - I2C
    - UART
    - CAN ?
    - SPI ?