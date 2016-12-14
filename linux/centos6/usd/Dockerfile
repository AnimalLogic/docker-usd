############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/vfx:centos6-usd-0.7

MAINTAINER Aloys Baillet - Animal Logic

LABEL pxr.usd.version="0.7.2"

COPY scripts/build_usd.sh /tmp/
RUN /tmp/build_usd.sh

CMD bash
