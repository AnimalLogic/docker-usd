#!/usr/bin/env bash

set -e

export DOWNLOADS_DIR="`pwd`/../downloads"
export USD_VERSION="18.11"
export CUDA_VERSION="9.0"

echo "Downloads folder: ${DOWNLOADS_DIR}"
echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

export LOCAL_IP=`hostname -I|cut -d' ' -f1`

scripts/download_vfx.sh
scripts/download_usd.sh

# Start a local server to serve files needed during the build.
cd ${DOWNLOADS_DIR} && python -m SimpleHTTPServer && cd - &

httpServerPID=$(ps -ef | grep SimpleHTTPServer | grep -v grep | awk '{print $2}')
function finish {
  kill $httpServerPID
}
trap finish EXIT

echo "Build VFX packages"
docker build --build-arg current_host_ip_address=${LOCAL_IP} \
             -t "docker-usd/vfx-lite:2018-centos7" \
             -f centos7/vfx-lite-2018/Dockerfile .
docker tag "docker-usd/vfx-lite:2018-centos7" "docker-usd/vfx-lite:latest-centos7"
docker tag "docker-usd/vfx-lite:2018-centos7" "docker-usd/vfx-lite:latest-centos7"

echo "Build USD v${USD_VERSION}"
docker build --build-arg current_host_ip_address=${LOCAL_IP} \
             --build-arg usd_version=${USD_VERSION} \
             -t "docker-usd/usd-lite:${USD_VERSION}-centos7" \
             -f centos7/usd-lite/Dockerfile .
docker tag "docker-usd/usd-lite:${USD_VERSION}-centos7" "docker-usd/usd-lite:${USD_VERSION}-centos7"
docker tag "docker-usd/usd-lite:${USD_VERSION}-centos7" "docker-usd/usd-lite:latest-centos7"
