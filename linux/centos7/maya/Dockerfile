############################################################
# Dockerfile to install maya2018
# Based on nvidia/base:centos7-usd-0.8

FROM usd-docker/vfx:latest-centos7

ARG current_host_ip_address
ARG maya_version

LABEL maya.version="${maya_version}.0" maintainer="Animal Logic"

ENV MAYA_LOCATION=$BUILD_DIR/maya{maya_version}DevKit
ENV HTTP_HOSTNAME=$current_host_ip_address
ENV MAYA_EXECUTABLE=$MAYA_LOCATION/bin/maya
ENV MAYA_MAJOR_VERSION="${maya_version}"

COPY scripts/build_maya.sh scripts/download_maya.sh /tmp/

RUN /tmp/download_maya.sh && \
    /tmp/build_maya.sh
