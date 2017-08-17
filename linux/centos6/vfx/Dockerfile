############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/base:latest-centos6

LABEL vfx.version="1" maintainer="Aloys Baillet - Animal Logic"

ENV PYTHON_SITE_PACKAGES=$BUILD_DIR/lib/python2.7/site-packages \
    PYTHON_EXECUTABLE=$BUILD_DIR/bin/python2 \
    PYTHONPATH=$PYTHONPATH:/opt/usd/lib/python:/opt/usd/lib/python/site-packages:/opt/usd/lib64/python/site-packages
    #HTTP_HOSTNAME=<your_hostname_here>

COPY scripts/build_vfx.sh scripts/build_vfx_base.sh scripts/download_vfx.sh /tmp/

RUN /tmp/download_vfx.sh && \
    /tmp/build_vfx_base.sh && \
    /tmp/build_vfx.sh && \ 
    rm -Rf $DOWNLOADS_DIR/*
