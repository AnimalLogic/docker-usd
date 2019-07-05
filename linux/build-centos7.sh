#!/usr/bin/env bash
# Copyright (C) Animal Logic Pty Ltd. All rights reserved.


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

echo "Build base: base centos packages and gcc"
docker build --build-arg current_host_ip_address=${LOCAL_IP} \
             --build-arg cuda_version=${CUDA_VERSION} \
             -t "usd-docker/base:1-centos7" -f centos7/base/Dockerfile .
docker tag "usd-docker/base:1-centos7" "usd-docker/base:latest-centos7"

echo "Build VFX packages"
docker build --build-arg current_host_ip_address=${LOCAL_IP} \
             -t "usd-docker/vfx:1-centos7" \
             -f centos7/vfx/Dockerfile .
docker tag "usd-docker/vfx:1-centos7" "usd-docker/vfx:latest-centos7"

echo "Build USD v${USD_VERSION}"
docker build --build-arg current_host_ip_address=${LOCAL_IP} \
             --build-arg usd_version=${USD_VERSION} \
             -t "usd-docker/usd:${USD_VERSION}-centos7" \
             -f centos7/usd/Dockerfile .
docker tag "usd-docker/usd:${USD_VERSION}-centos7" "usd-docker/usd:${USD_VERSION}-centos7"
docker tag "usd-docker/usd:${USD_VERSION}-centos7" "usd-docker/usd:latest-centos7"
