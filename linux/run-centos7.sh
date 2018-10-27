#!/bin/sh

docker run --runtime=nvidia --name "docker-usd" --rm -it --env DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --env QT_X11_NO_MITSHM=1 -v="$HOME:/home/usd:rw" -v="$(dirname `pwd`)/data:/data:rw" "docker-usd/usd:latest-centos7" "$@"
