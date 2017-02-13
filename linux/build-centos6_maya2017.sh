#!/usr/bin/env bash
set -e

echo "Copy local root certificates for corporate networks"
cp -u /etc/pki/ca-trust/source/anchors/* cert/

echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:centos6-usd-0.7" -f centos6/base/Dockerfile .

echo "Build VFX packages"
docker build -t "usd-docker/vfx-maya2017:centos6-usd-0.7" -f centos6/vfx/Dockerfile .

echo "Build Maya2017"
if [ -f ../apps/maya2017/Autodesk_Maya_2017_Update1_P01.tgz -a -f ../apps/maya2017/Maya2017_DEVKIT_Linux.tgz ]; then
  mkdir apps
  cp -R ../apps/maya2017/* apps
  docker build -t "usd-docker/maya2017:centos6-usd-0.7" -f centos6/dcc/Dockerfile_maya2017 .
  rm -Rf apps
fi

echo "Build USD"
docker build -t "usd-docker/usd:centos6-usd-0.7.2" -f centos6/usd/Dockerfile_maya2017 .
