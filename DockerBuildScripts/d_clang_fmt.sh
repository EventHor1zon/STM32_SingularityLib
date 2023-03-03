#!/bin/bash
USAGE="d_clang_fmt.sh [FILE]"
SRC_DIRECTORY="/src"
USERUID=$(id -u $USER)
USERGID=$(id -g $USER)
DOCKER_COMMAND="docker run -t \
                           -u $USERUID:$USERGID \
                           --mount type=bind,src="$(pwd)",target="$SRC_DIRECTORY" \
                           stm32a1 \
                           clang-format-9 -i \
                           "$SRC_DIRECTORY"/"



if [ ! $# -gt 0 ]; then
    echo $USAGE
else
    CMD=$DOCKER_COMMAND$1
    echo "running "$CMD
    $CMD
fi
