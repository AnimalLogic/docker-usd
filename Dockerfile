############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM nvidia/cuda:devel-centos6
MAINTAINER Aloys Baillet

ENV OUT_FOLDER /opt/usd
ENV BUILD_PROCS 7
ENV BUILD_DIR /opt/usd
ENV TMP_DIR /tmp/usd-build
ENV DOWNLOADS_DIR /tmp/usd-downloads

ENV PATH $BUILD_DIR/bin:$PATH
ENV PKG_CONFIG_PATH=$BUILD_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH=$BUILD_DIR/lib64:$BUILD_DIR/lib:$LD_LIBRARY_PATH

COPY build/download.sh /tmp/
RUN /tmp/download.sh

COPY build/build_gcc.sh /tmp/
RUN /tmp/build_gcc.sh

ENV CC=$BUILD_DIR/bin/gcc
ENV CXX=$BUILD_DIR/bin/g++
ENV PYTHON_VERSION 2.7

COPY build/build_vfx_base.sh /tmp/
RUN /tmp/build_vfx_base.sh

COPY build/build_vfx.sh /tmp/
RUN /tmp/build_vfx.sh

COPY build/build_usd.sh /tmp/
RUN /tmp/build_usd.sh

ENV PYTHONPATH=$PYTHONPATH:/opt/usd/lib/python
ENV HOME=/home/usd
ENV LOGNAME=usd
ENV HOSTNAME=usd

CMD bash
