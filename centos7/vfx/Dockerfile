############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/base:centos7-7.1

MAINTAINER Aloys Baillet - Animal Logic

COPY scripts/download_vfx.sh /tmp/
RUN /tmp/download_vfx.sh

COPY scripts/build_vfx_base.sh /tmp/
RUN /tmp/build_vfx_base.sh

COPY scripts/build_vfx.sh /tmp/
RUN /tmp/build_vfx.sh

ENV PYTHONPATH=$PYTHONPATH:/opt/usd/lib/python

CMD bash
