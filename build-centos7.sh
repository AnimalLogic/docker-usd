#!/usr/bin/env bash
set -e

# Copy local root certificates for corporate networks
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

# Build base: base centos packages and gcc
docker build -t "usd-docker/base:centos7-7.1" -f centos7/base/Dockerfile .

# Build VFX packages
docker build -t "usd-docker/vfx:centos7-7.1" -f centos7/vfx/Dockerfile .

# Build USD
docker build -t "usd-docker/usd:centos7-7.1" -f centos7/usd/Dockerfile .
