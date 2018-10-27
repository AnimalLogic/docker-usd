#!/bin/sh

docker run --name "usd-lite" --rm -it -v="$HOME:/home/usd:rw" -v="$(dirname `pwd`)/data:/data:rw" "usd-docker/usd-lite:latest-centos7" "$@"
