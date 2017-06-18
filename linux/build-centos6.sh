#!/usr/bin/env bash
set -e

echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:centos6-usd-0.7" -f centos6/base/Dockerfile .

echo "Build VFX packages"
docker build -t "usd-docker/vfx:centos6-usd-0.7" -f centos6/vfx/Dockerfile .

echo "Build USD"
docker build -t "usd-docker/usd:centos6-usd-0.7.5" -f centos6/usd/Dockerfile .
