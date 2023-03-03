#syntax=docker/dockerfile:1
#
# Attempt at a docker container for cleaning, checking, compiling 
# arm programs
#
# Utilities: 
#	gcc-arm-none-eabi   -   arm toolchain version 10.2.1 (2020-q4-major)
#	cppcheck            -   cpp check for checking MISRA-C compliance
#	clangd-12	        -   clang server to provide linting/code completion etc
#                           support dependent on editor, can bind fornat scripts 
#                           if editor support not available. Remember to open port!


FROM ubuntu:20.04
WORKDIR /tools

# arm gcc toolchain download path
ENV GCC_ARM_DOWNLOAD_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
ENV GCC_ARM_FILENAME=gcc-arm-none-eabi-10-2020-q4-major

RUN apt-get update
# default build-essential fails w. 404 error so use specific focal version of libcurl4
RUN apt-get install -y libcurl4=7.68.0-1ubuntu2 wget gcc g++ cppcheck cmake clangd-12

# download & unzip toolchain
RUN wget $GCC_ARM_DOWNLOAD_URL
RUN tar -xjf ./$GCC_ARM_FILENAME*
ENV PATH=${PATH}:/tools/$GCC_ARM_FILENAME/bin:/tools/$GCC_ARM_FILENAME/arm-none-eabi/bin

# check versions
RUN echo "Installed gcc-arm-none-eabi version "$(arm-none-eabi-gcc --version)
RUN echo "Installed ccpcheck version "$(cppcheck --version)
RUN echo "Installed ccpcheck version "$(clang-format-9 --version)

RUN echo "Tool install complete"

WORKDIR /src
