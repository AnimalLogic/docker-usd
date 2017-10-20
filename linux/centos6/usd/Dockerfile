############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM usd-docker/vfx:latest-centos6

MAINTAINER Aloys Baillet - Animal Logic

ENV USD_VERSION "0.8.1"
LABEL pxr.usd.version="${USD_VERSION}"

COPY scripts/build_usd.sh /tmp/
RUN /tmp/build_usd.sh

#RUN cd $TMP_DIR/USD-${USD_VERSION}/build && \
#    ctest

CMD bash
