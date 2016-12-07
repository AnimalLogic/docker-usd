############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM nvidia/cuda:devel-centos6

MAINTAINER Aloys Baillet

LABEL pxr.usd.version="7.1.0"

COPY scripts/build_usd.sh /tmp/
RUN /tmp/build_usd.sh

CMD bash
