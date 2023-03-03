#!/bin/bash

USAGE="d_cmake_prep.sh [DIR]"
USERUID=$(id -u $USER)
USERGID=$(id -g $USER)
SRC_DIRECTORY="/src"

if [ ! $# -gt 0 ]; then
    echo $USAGE
else
    DOCKER_COMMAND="docker run -t \
                    -u $USERUID:$USERGID \
                    --mount type=bind,src="$1",target="$SRC_DIRECTORY" \
                    stm32a1 \
                    cmake -DCMAKE_BUILD_TYPE=Debug $SRC_DIRECTORY"

    echo "running "$DOCKER_COMMAND
    $DOCKER_COMMAND
fi