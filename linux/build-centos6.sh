#!/usr/bin/env bash
set -e

echo "Copy local root certificates for corporate networks"
cp -u /etc/pki/ca-trust/source/anchors/* cert/

echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:centos6-usd-0.7" -f centos6/base/Dockerfile .

echo "Build Maya2017"
mkdir -p apps/tmp
cp --remove-destination `readlink apps/Autodesk_Maya_2017_Update1_P01.tgz` "apps/tmp/Autodesk_Maya_2017_Update1_P01.tgz"
cp --remove-destination `readlink apps/Maya2017_DEVKIT_Linux.tgz` "apps/tmp/Maya2017_DEVKIT_Linux.tgz"
# Build Maya2017
docker build -t "usd-docker/maya2017:centos6-usd-0.7" -f centos6/dcc/Dockerfile_maya2017 .
rm -Rf apps/tmp

echo "Build VFX packages"
docker build -t "usd-docker/vfx:centos6-usd-0.7" -f centos6/vfx/Dockerfile .

echo "Build USD"
docker build -t "usd-docker/usd:centos6-usd-0.7.2" -f centos6/usd/Dockerfile .

echo "Build AL_USDMaya"
docker build -t "usd-docker/alusdmaya:centos6-usd-0.7" -f centos6/usd/dependants/Dockerfile .