############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/base:centos7-7.1

MAINTAINER Aloys Baillet - Animal Logic

ENV PYTHON_SITE_PACKAGES=/usr/lib64/python2.7/site-packages
ENV PYTHON_EXECUTABLE=/usr/bin/python
ENV PYTHONPATH=$PYTHONPATH:$BUILD_DIR/lib/python:$BUILD_DIR/lib/python/site-packages:$BUILD_DIR/lib64/python2.7/site-packages

COPY scripts/download_vfx.sh /tmp/
RUN /tmp/download_vfx.sh

COPY scripts/build_vfx_base.sh /tmp/
RUN /tmp/build_vfx_base.sh

COPY scripts/build_vfx.sh /tmp/
RUN /tmp/build_vfx.sh

CMD bash
