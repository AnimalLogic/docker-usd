#!/usr/bin/env bash
set -e

echo "Copy local root certificates for corporate networks"
cp -u /etc/pki/ca-trust/source/anchors/* cert/

echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:centos6-usd-0.7" -f centos6/base/Dockerfile .

echo "Build Maya2016"
docker build -t "usd-docker/maya2016:centos6-usd-0.7" -f centos6/dcc/Dockerfile_maya2016 .

echo "Build VFX packages"
docker build -t "usd-docker/vfx:centos6-usd-0.7" -f centos6/vfx/Dockerfile .

echo "Build USD"
docker build -t "usd-docker/usd:centos6-usd-0.7.2" -f centos6/usd/Dockerfile .

echo "Build AL_USDMaya"#TODO: Move to AL_USDMaya
docker build -t "usd-docker/alusdmaya:centos6-usd-0.7" -f centos6/usd/dependants/Dockerfile .
