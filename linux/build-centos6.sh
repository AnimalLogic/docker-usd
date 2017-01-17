#!/usr/bin/env bash
set -e

echo "Copy local root certificates for corporate networks"
cp -u /etc/pki/ca-trust/source/anchors/* cert/

echo "Build base: base centos packages and gcc"
docker build --cpuset-cpus=0-23 -t "usd-docker/base:centos6-usd-0.7" -f centos6/base/Dockerfile .

echo "Build Maya2017"
# Build Maya2017
docker build --cpuset-cpus=0-23 -t "usd-docker/maya2017:centos6-usd-0.7" -f centos6/dcc/Dockerfile_maya2017 .

echo "Build VFX packages"
docker build --cpuset-cpus=0-23 -t "usd-docker/vfx:centos6-usd-0.7" -f centos6/vfx/Dockerfile .

echo "Build USD"
docker build --cpuset-cpus=0-23 -t "usd-docker/usd:centos6-usd-0.7.2" -f centos6/usd/Dockerfile .

echo "Build AL_USDMaya"
# Build AL USD Maya
docker build --cpuset-cpus=0-23 -t "usd-docker/alusdmaya:centos6-usd-0.7" -f centos6/usd/dependants/Dockerfile .
