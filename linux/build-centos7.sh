#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Please pass a path to a folder that will contain downloaded source tarballs (../apps is our default)"
  exit 1
fi

export DOWNLOADS_DIR=$1

echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

export LOCAL_IP=`ip route get 8.8.8.8 | head -1 | cut -d' ' -f8`

scripts/download_vfx.sh

# Start a local server to serve files needed during the build.
cd $1 && python -m SimpleHTTPServer && cd - &

httpServerPID=$(ps -ef | grep SimpleHTTPServer | grep -v grep | awk '{print $2}')
function finish {
  kill $httpServerPID
}
trap finish EXIT


echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:1-centos7" -f centos7/base/Dockerfile .
docker tag "usd-docker/base:1-centos7" "usd-docker/base:latest-centos7"

echo "Build VFX packages"
docker build --build-arg current_host_ip_address=$LOCAL_IP -t "usd-docker/vfx:1-centos7" -f centos7/vfx/Dockerfile .
docker tag "usd-docker/vfx:1-centos7" "usd-docker/vfx:latest-centos7"

echo "Build USD"
docker build -t "usd-docker/usd:0.8.0-centos7" -f centos7/usd/Dockerfile .
docker tag "usd-docker/usd:0.8.0-centos7" "usd-docker/usd:0.8.0-centos7"
docker tag "usd-docker/usd:0.8.0-centos7" "usd-docker/usd:latest-centos7"
docker tag "usd-docker/usd:0.8.0-centos7" "usd-docker/usd:latest-centos7"
