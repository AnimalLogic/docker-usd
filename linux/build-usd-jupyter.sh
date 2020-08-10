#!/usr/bin/env bash

set -e

export DOWNLOADS_DIR="`pwd`/../downloads"
export USD_VERSION="20.08"
export CUDA_VERSION="10.2"

echo "Downloads folder: ${DOWNLOADS_DIR}"

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
             -t "dockerusd/usd-jupyter:${USD_VERSION}-centos7" \
             -f usd-jupyter/Dockerfile .
docker tag "dockerusd/usd-jupyter:${USD_VERSION}-centos7" "dockerusd/usd-jupyter:${USD_VERSION}-centos7"
docker tag "dockerusd/usd-jupyter:${USD_VERSION}-centos7" "dockerusd/usd-jupyter:latest-centos7"
docker tag "dockerusd/usd-jupyter:${USD_VERSION}-centos7" "dockerusd/usd-jupyter:latest"
