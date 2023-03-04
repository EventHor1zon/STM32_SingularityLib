USAGE="d_clang_build.sh [DIR]"
SRC_DIRECTORY="/src"
USERUID=$(id -u $USER)
USERGID=$(id -g $USER)


if [ ! $# -gt 0 ]; then
    echo $USAGE
else
    DOCKER_COMMAND="docker run -t \
                    -u $USERUID:$USERGID \
                    --mount type=bind,src="$1",target="$SRC_DIRECTORY" \
                    stm32a1 \
                    cmake --build /src -v"

    echo "running "$DOCKER_COMMAND
    $DOCKER_COMMAND
fi
