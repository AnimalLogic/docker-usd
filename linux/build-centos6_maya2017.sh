#!/usr/bin/env bash

set -e
if [ -z "$1" ]; then
  echo "Please pass a path to a folder that contains Autodesk_Maya_2017_Update4_EN_Linux_64bit.tgz and Maya2017_DEVKIT_Linux.tgz"
  exit 1
fi

if [ ! -f "$1/Autodesk_Maya_2017_Update4_EN_Linux_64bit.tgz" ]; then
  echo "Couldn't find file $1/Autodesk_Maya_2017_Update4_EN_Linux_64bit.tgz"
  exit 1
fi

if [ ! -f "$1/Maya2017_DEVKIT_Linux.tgz" ]; then
  echo "Couldn't find file $1/Maya2017_DEVKIT_Linux.tgz"
  exit 1
fi

echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

# Start a local server to serve files needed during the build.
cd $1 && python -m SimpleHTTPServer && cd - &

httpServerPID=$(ps -ef | grep SimpleHTTPServer | grep -v grep | awk '{print $2}')
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

echo "Build Maya2017"
docker build -t "usd-docker/maya2017:1-centos6" -f centos6/dcc/Dockerfile_maya2017 .
docker tag -f "usd-docker/maya2017:1-centos6" "usd-docker/maya2017:latest-centos6"

echo "Build USD"
docker build -t "usd-docker/usd:0.8.0-centos6-maya2017" -f centos6/usd/Dockerfile_maya2017 .
docker tag -f "usd-docker/usd:0.8.0-centos6-maya2017" "usd-docker/usd:0.8.0-centos6-maya2017"
docker tag -f "usd-docker/usd:0.8.0-centos6-maya2017" "usd-docker/usd:latest-centos6-maya2017"
docker tag -f "usd-docker/usd:0.8.0-centos6-maya2017" "usd-docker/usd:latest-centos6-mayalatest"
