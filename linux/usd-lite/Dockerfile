# Copyright (C) Animal Logic Pty Ltd. All rights reserved.

############################################################
ARG ASWF_ORG=aswf
ARG ASWF_PKG_ORG=aswf
ARG CI_COMMON_VERSION=1
ARG VFXPLATFORM_VERSION=2020

FROM ${ASWF_PKG_ORG}/ci-package-python:${VFXPLATFORM_VERSION} as ci-package-python
FROM ${ASWF_PKG_ORG}/ci-package-tbb:${VFXPLATFORM_VERSION} as ci-package-tbb
FROM ${ASWF_PKG_ORG}/ci-package-boost:${VFXPLATFORM_VERSION} as ci-package-boost

FROM centos/devtoolset-7-toolchain-centos7 as builder

ARG current_host_ip_address
ARG usd_version

ENV BUILD_PROCS 7
ENV BUILD_DIR /usr/local/
ENV TMP_DIR /tmp/vfx-build
ENV DOWNLOADS_DIR /tmp/vfx-downloads
ENV PKG_CONFIG_PATH=$BUILD_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV PYTHON_EXECUTABLE=/usr/local/bin/python3
ENV PYTHON_SITE_PACKAGES=$BUILD_DIR/lib/python2.7/site-packages
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib/python:/usr/local/lib/python/site-packages:/usr/local/lib64/python/site-packages
ENV HTTP_HOSTNAME=$current_host_ip_address
ENV USD_VERSION=$usd_version

USER root

RUN yum install -y --setopt=tsflags=nodocs make wget bzip2 which zlib-devel bzip2-devel && yum clean all -y

RUN wget https://cmake.org/files/v3.17/cmake-3.17.4-Linux-x86_64.sh -P $DOWNLOADS_DIR -nc && \
    chmod u+x $DOWNLOADS_DIR/cmake-3.17.4-Linux-x86_64.sh && \
    $DOWNLOADS_DIR/cmake-3.17.4-Linux-x86_64.sh --skip-license --prefix=$BUILD_DIR

COPY --from=ci-package-python /. /usr/local/
COPY --from=ci-package-tbb /. /usr/local/
COPY --from=ci-package-boost /. /usr/local/

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:${LD_LIBRARY_PATH} \
    PATH=/usr/local/bin:${PATH} \
    CI_COMMON_VERSION=${CI_COMMON_VERSION} \
    VFXPLATFORM_VERSION=${VFXPLATFORM_VERSION} \
    TMP_DIR=/tmp/vfx-build \
    DOWNLOADS_DIR=/tmp/vfx-downloads 

COPY scripts/download_usd.sh /tmp/
RUN /tmp/download_usd.sh
RUN pip3 install jinja2
RUN mkdir -p $TMP_DIR
RUN cd $TMP_DIR && \
   tar -zxf $DOWNLOADS_DIR/USD-v${USD_VERSION}.tar.gz && \
   cd $TMP_DIR/USD-${USD_VERSION} && \
    mkdir build && \
    cd build && \
    cmake \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPXR_BUILD_TESTS=OFF \
      -DPXR_BUILD_IMAGING=OFF \
      -DTBB_ROOT_DIR=$BUILD_DIR \
      -DPXR_ENABLE_GL_SUPPORT=FALSE \
      -DPXR_ENABLE_PTEX_SUPPORT=FALSE \
      -DPXR_BUILD_ALEMBIC_PLUGIN=OFF \
      -DPXR_BUILD_USD_IMAGING=FALSE \
      -DPXR_USE_PYTHON_3=ON \
      ..

RUN cd $TMP_DIR/USD-${USD_VERSION}/build && \
    make -j 6

RUN cd $TMP_DIR/USD-${USD_VERSION}/build && \
    make install

# RUNTIME IMAGE
FROM centos:7
ARG usd_version

RUN yum install -y --setopt=tsflags=nodocs centos-release-scl-rh &&\
    yum install -y --setopt=tsflags=nodocs devtoolset-7-runtime &&\
    yum clean all -y

COPY --from=builder /usr/local /usr/local

ENV USD_VERSION=$usd_version

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:${LD_LIBRARY_PATH} \
    PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin \
    PYTHONPATH=$PYTHONPATH:/usr/local/lib/python:/usr/local/lib/python/site-packages:/usr/local/lib64/python/site-packages \
    CI_COMMON_VERSION=${CI_COMMON_VERSION} \
    VFXPLATFORM_VERSION=${VFXPLATFORM_VERSION}
