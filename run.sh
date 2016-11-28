#!/bin/sh
nvidia-docker run --name "usd" --rm -it -e "DISPLAY=unix:0.0" -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v="$HOME:/home/usd:rw" "aloys/usd" "$@"
