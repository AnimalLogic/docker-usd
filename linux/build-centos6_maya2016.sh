#!/usr/bin/env bash

set -e

echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

# Start a local server to serve files needed during the build.
cd $1 && python -m SimpleHTTPServer && cd - &
httpServerPID=$!
function finish {
  kill $httpServerPID
}
trap finish EXIT

echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:1-centos6" -f centos6/base/Dockerfile .
docker tag -f "usd-docker/base:1-centos6" "usd-docker/base:latest-centos6"

echo "Build VFX packages"
docker build -t "usd-docker/vfx:1-centos6" -f centos6/vfx/Dockerfile .
docker tag -f "usd-docker/vfx:1-centos6" "usd-docker/vfx:latest-centos6"

echo "Build Maya2016"
docker build -t "usd-docker/maya2016:1-centos6" -f centos6/dcc/Dockerfile_maya2016 .
docker tag -f "usd-docker/maya2016:1-centos6" "usd-docker/maya2016:latest-centos6"

echo "Build USD"
docker build -t "usd-docker/usd:0.8.0-centos6-maya2016" -f centos6/usd/Dockerfile_maya2016 .
docker tag -f "usd-docker/usd:0.8.0-centos6-maya2016" "usd-docker/usd:0.8.0-centos6-maya2016"
docker tag -f "usd-docker/usd:0.8.0-centos6-maya2016" "usd-docker/usd:latest-centos6-maya2016"
docker tag -f "usd-docker/usd:0.8.0-centos6-maya2016" "usd-docker/usd:latest-centos6-mayalatest"