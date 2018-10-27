############################################################
# Dockerfile to build USD Maya
FROM usd-docker/vfx-lite:latest-centos7 as builder

ARG current_host_ip_address
ARG usd_version

LABEL pxr.usd.version="$usd_version" maintainer="Aloys.Baillet - Animal Logic"

ENV USD_VERSION=$usd_version
ENV HTTP_HOSTNAME=$current_host_ip_address

COPY scripts/download_usd.sh /tmp/
RUN /tmp/download_usd.sh
RUN yum install -y python-jinja2
RUN mkdir -p $TMP_DIR
RUN cd $TMP_DIR && \
   tar -zxf $DOWNLOADS_DIR/USD-v${USD_VERSION}.tar.gz && \
   cd $TMP_DIR/USD-${USD_VERSION} && \
    mkdir build && \
    cd build && \
    cmake \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/usd/${USD_VERSION} \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPXR_BUILD_TESTS=OFF \
      -DTBB_ROOT_DIR=$BUILD_DIR \
      -DPXR_ENABLE_GL_SUPPORT=FALSE \
      -DPXR_ENABLE_PTEX_SUPPORT=FALSE \
      -DPXR_MALLOC_LIBRARY:path=$BUILD_DIR/lib/libjemalloc.so \
      -DPXR_BUILD_USD_IMAGING=FALSE \
      ..

RUN cd $TMP_DIR/USD-${USD_VERSION}/build && \
    make -j 4

RUN cd $TMP_DIR/USD-${USD_VERSION}/build && \
    make install


ENV USD_INSTALL_ROOT=$BUILD_DIR/usd/${USD_VERSION}
ENV USD_CONFIG_FILE=$USD_INSTALL_ROOT/pxrConfig.cmake
ENV PATH=$PATH:$USD_INSTALL_ROOT/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$USD_INSTALL_ROOT/lib
ENV PYTHONPATH=$PYTHONPATH:$USD_INSTALL_ROOT/lib/python


# RUNTIME IMAGE
FROM centos:7
ARG usd_version

RUN yum install -y --setopt=tsflags=nodocs centos-release-scl-rh &&\
    yum install -y --setopt=tsflags=nodocs devtoolset-7-runtime &&\
    yum clean all -y

COPY --from=0 $BUILD_DIR $BUILD_DIR

ENV USD_VERSION=$usd_version
ENV USD_INSTALL_ROOT=/opt/vfx/usd/${USD_VERSION}
ENV USD_CONFIG_FILE=$USD_INSTALL_ROOT/pxrConfig.cmake
ENV PATH=$PATH:$USD_INSTALL_ROOT/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$USD_INSTALL_ROOT/lib
ENV PYTHONPATH=$PYTHONPATH:$USD_INSTALL_ROOT/lib/python
ENV LD_PRELOAD=/opt/vfx/lib/libjemalloc.so.2
