#!/usr/bin/env bash
# Copyright (C) Animal Logic Pty Ltd. All rights reserved.


set -e

export DOWNLOADS_DIR="`pwd`/../downloads"
export USD_VERSION="20.08"
export CUDA_VERSION="10.2"
export CI_COMMON_VERSION=1
export VFXPLATFORM_VERSION=2020

echo "Downloads folder: ${DOWNLOADS_DIR}"
echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

export LOCAL_IP=`hostname -I|cut -d' ' -f1`

scripts/download_usd.sh

# Start a local server to serve files needed during the build.
cd ${DOWNLOADS_DIR} && python3 -m http.server && cd - &

httpServerPID=$(ps -ef | grep http.server | grep -v grep | awk '{print $2}')
function finish {
  kill $httpServerPID
}
trap finish EXIT

echo "Build USD v${USD_VERSION}"
docker build --build-arg current_host_ip_address=${LOCAL_IP} \
             --build-arg usd_version=${USD_VERSION} \
             --build-arg CI_COMMON_VERSION=${CI_COMMON_VERSION} \
             --build-arg VFXPLATFORM_VERSION=${VFXPLATFORM_VERSION} \
             -t "usd-docker/usd-lite:${USD_VERSION}-centos7" \
             -f centos7/usd-lite/Dockerfile .
docker tag "usd-docker/usd-lite:${USD_VERSION}-centos7" "usd-docker/usd-lite:${USD_VERSION}-centos7"
docker tag "usd-docker/usd-lite:${USD_VERSION}-centos7" "usd-docker/usd-lite:latest-centos7"
