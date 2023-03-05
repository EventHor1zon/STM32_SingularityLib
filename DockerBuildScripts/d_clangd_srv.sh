#!/bin/bash
USAGE="d_clang_fmt.sh [DIR]"
USERUID=$(id -u $USER)
USERGID=$(id -g $USER)




if [ ! $# -gt 0 ]; then
    echo $USAGE
else
DOCKER_COMMAND="docker run -t \
                -u $USERUID:$USERGID \
                --mount type=bind,src="$1",target="$1" \
                -p 50505:50505 \
                -w $(pwd) \
                -d \
                stm32a2 \
                socat tcp-listen:50505,reuseaddr exec:clangd-12"
echo "Running "$DOCKER_COMMAND 
$DOCKER_COMMAND
fi
