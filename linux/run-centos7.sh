#!/bin/sh

nvidia-docker run --name "centos7-usd-0.7.2" --rm -it -e "DISPLAY=unix:0.0" -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v="$HOME:/home/usd:rw" "usd-docker/usd:centos7-usd-0.7.2" "$@"
