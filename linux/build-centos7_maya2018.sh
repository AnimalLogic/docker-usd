#!/usr/bin/env bash
set -e

echo "Copy local root certificates for corporate networks"
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

echo "Build base: base centos packages and gcc"
docker build -t "usd-docker/base:centos7-usd-0.7" -f centos7/base/Dockerfile .

echo "Build VFX packages"
docker build -t "usd-docker/vfx:centos7-usd-0.7" -f centos7/vfx/Dockerfile .

echo "Build Maya2018"
if [ -f ../apps/maya2018/Maya_PR79_Linux_64bit.tgz -a -f ../apps/maya2018/Maya_PR79_Linux_64bit_DEVKIT.tgz ]; then
  echo "Found Maya2018 tarball"
  mkdir apps
  cp -R ../apps/maya2018/* apps
  docker build -t "usd-docker/maya2018:centos7-usd-0.7" -f centos7/dcc/Dockerfile_maya2018 .
  rm -Rf apps
else
  echo "Could not find Maya2018 tarball. Please place mayas tarball and the devkit's tarball into ../apps"
fi

echo "Build USD"
docker build -t "usd-docker/usd:centos7-usd-0.7.5" -f centos7/usd/Dockerfile_maya2018 .
