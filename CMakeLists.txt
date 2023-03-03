#######
#   Attempt at writing a cmake file for STM32 Arm development
#   
#
#
######

# minimum version - TODO: research this! 
cmake_minimum_required(VERSION 3.5)

# create the project with version
# TODO - make the version command-line input
project("Singularity" VERSION 0.1)

enable_language(C ASM)

# set the cmake std c++11
set(CMAKE_CXX_STANDARD "c++11")
set(EXECUTABLE ${PROJECT_NAME}_${PROJECT_VERSION}.out)
set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CORE_SOURCE_FILES     # add basic files here
    ${PROJECT_SOURCE_DIR}/Src/main.c
)

# add main executable TODO: make this a variable
add_executable(${EXECUTABLE} ${CORE_SOURCE_FILES})

# configure the version file
configure_file("./version.config" "./Version.h")

# include the primary Include dir
target_include_directories(${EXECUTABLE} BEFORE PUBLIC ${PROJECT_SOURCE_DIR}/Inc)

# target compile defines 
target_compile_definitions(${EXECUTABLE} PRIVATE 
                            -DSTM32F103
                        )

# compiler options 

target_compile_options(${EXECUTABLE} PRIVATE
                        -mcpu=cortex-m3 
                        -mfloat-abi=soft 
                        -mthumb 
                        -static
                        
                        -fdata-sections
                        -ffunction-sections

                        -Wall
                        -Wl,-Map,${PROJECT_NAME}.map
                        -Wl,--gc-sections
                        -Wl,--start-group,-lc,-lm
                        -Wl,--end-group
                        $<$<CONFIG:Debug>:-Og>
                        )

# link options
target_link_options(${EXECUTABLE} PRIVATE
                        -T${CMAKE_SOURCE_DIR}/build_files/Linker/STM32F103C8TX_FLASH.ld
                        -mcpu=cortex-m3
                        -mthumb
                        -mfloat-abi=soft
                        -specs=nano.specs 
                        -lnosys
                        )

# print executable informations
add_custom_command(TARGET ${EXECUTABLE}
                    POST_BUILD
                    COMMAND ${TOOLCHAIN_PREFIX}size ${EXECUTABLE}
)


# Create hex file
add_custom_command(TARGET ${EXECUTABLE}
                    POST_BUILD
                    COMMAND arm-none-eabi-objcopy -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
                    COMMAND arm-none-eabi-objcopy -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin
)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX arm-none-eabi-)

execute_process(
  COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc
  OUTPUT_VARIABLE BINUTILS_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
  COMMAND ${TOOLCHAIN_PREFIX}gcc --version
)

get_filename_component(ARM_TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)

set(CMAKE_OBJCOPY ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
