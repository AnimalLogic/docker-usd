############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/vfx:latest-centos7

MAINTAINER Aloys Baillet - Animal Logic

ENV USD_VERSION "0.8.0"
LABEL pxr.usd.version="${USD_VERSION}"

COPY scripts/build_usd.sh /tmp/
RUN /tmp/build_usd.sh

ENV USD_INSTALL_ROOT $BUILD_DIR/usd/$USD_VERSION
ENV USD_CONFIG_FILE $USD_INSTALL_ROOT/pxrConfig.cmake
ENV PATH $PATH:$USD_INSTALL_ROOT/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$USD_INSTALL_ROOT/lib
ENV PYTHONPATH $PYTHONPATH:$USD_INSTALL_ROOT/lib/python

RUN cd $TMP_DIR/USD-${USD_VERSION}/build && \
    ctest

CMD bash
