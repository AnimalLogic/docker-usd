############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/base:latest-centos7

LABEL maintainer="Aloys.Baillet - Animal Logic"

ARG current_host_ip_address

ENV PYTHON_SITE_PACKAGES=$BUILD_DIR/lib/python2.7/site-packages
ENV PYTHON_EXECUTABLE=python
ENV PYTHONPATH=$PYTHONPATH:/opt/usd/lib/python:/opt/usd/lib/python/site-packages:/opt/usd/lib64/python/site-packages
ENV HTTP_HOSTNAME=$current_host_ip_address

COPY scripts/build_vfx.sh scripts/build_vfx_base.sh scripts/download_vfx.sh /tmp/

RUN /tmp/download_vfx.sh && \
    /tmp/build_vfx_base.sh && \
    /tmp/build_vfx.sh && \
    rm -Rf $DOWNLOADS_DIR/*
