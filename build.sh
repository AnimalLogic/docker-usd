#!/usr/bin/env bash
set -e

# Copy local CentOS root certificates for wget to work behind corporate firewalls
[ -e /etc/pki/ca-trust/source/anchors ] && cp -u /etc/pki/ca-trust/source/anchors/* cert/

# Build base: base centos packages and gcc
docker build -t "usd-docker/base:7.1" -f centos-6/base/Dockerfile .

# Build VFX packages
docker build -t "usd-docker/vfx:7.1" -f centos-6/vfx/Dockerfile .

# Build USD
docker build -t "usd-docker/usd:7.1" -f centos-6/usd/Dockerfile .
