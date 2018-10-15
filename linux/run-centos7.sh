#!/bin/sh

docker run --runtime=nvidia --name "usd-docker" --rm -it --env DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --env QT_X11_NO_MITSHM=1 -v="$HOME:/home/usd:rw" "usd-docker/usd:latest-centos7" "$@"
