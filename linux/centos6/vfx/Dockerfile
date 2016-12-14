############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/base:centos6-usd-0.7

MAINTAINER Aloys Baillet - Animal Logic

ENV PYTHON_SITE_PACKAGES=$BUILD_DIR/lib/python2.7/site-packages
ENV PYTHON_EXECUTABLE=$BUILD_DIR/bin/python
ENV PYTHONPATH=$PYTHONPATH:/opt/usd/lib/python:/opt/usd/lib/python/site-packages:/opt/usd/lib64/python/site-packages

COPY scripts/download_vfx.sh /tmp/
RUN /tmp/download_vfx.sh

COPY scripts/build_vfx_base.sh /tmp/
RUN /tmp/build_vfx_base.sh

COPY scripts/build_vfx.sh /tmp/
RUN /tmp/build_vfx.sh

CMD bash
