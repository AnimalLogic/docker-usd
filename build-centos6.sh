#!/usr/bin/env bash
set -e

# Copy local root certificates for corporate networks
cp -u /etc/pki/ca-trust/source/anchors/* cert/

# Build base: base centos packages and gcc
docker build -t "usd-docker/base:centos6-7.1" -f centos6/base/Dockerfile .

# Build VFX packages
docker build -t "usd-docker/vfx:centos6-7.1" -f centos6/vfx/Dockerfile .

# Build USD
docker build -t "usd-docker/usd:centos6-7.1" -f centos6/usd/Dockerfile .
