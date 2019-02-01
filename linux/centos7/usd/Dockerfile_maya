############################################################
# Dockerfile to build USD Maya
ARG maya_version
FROM usd-docker/maya${maya_version}:latest-centos7

ARG usd_version
ARG maya_version
ARG current_host_ip_address

LABEL pxr.usd.version="${usd_version}" maintainer="Aloys.Baillet - Animal Logic"

ENV USD_VERSION="${usd_version}"
ENV MAYA_MAJOR_VERSION="${maya_version}"
ENV HTTP_HOSTNAME="${current_host_ip_address}"

COPY scripts/download_usd.sh scripts/build_usd.sh /tmp/
RUN /tmp/download_usd.sh && \
    /tmp/build_usd.sh

ENV USD_INSTALL_ROOT=$BUILD_DIR/usd/${usd_version}
ENV USD_CONFIG_FILE=$USD_INSTALL_ROOT/pxrConfig.cmake
ENV PATH=$PATH:$USD_INSTALL_ROOT/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$USD_INSTALL_ROOT/lib
ENV PYTHONPATH=$PYTHONPATH:$USD_INSTALL_ROOT/lib/python
