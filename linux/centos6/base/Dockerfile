############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6

FROM nvidia/cuda:7.5-devel-centos6

LABEL base.version="1" maintainer="Aloys Baillet - Animal Logic"

ENV BUILD_PROCS=16 \
    BUILD_DIR=/opt/usd \
    TMP_DIR=/tmp/usd-build \
    DOWNLOADS_DIR=/tmp/usd-downloads

ENV PATH=$BUILD_DIR/bin:$PATH \
    PKG_CONFIG_PATH=$BUILD_DIR/lib/pkgconfig:$PKG_CONFIG_PATH \
    LD_LIBRARY_PATH=$BUILD_DIR/lib64:$BUILD_DIR/lib:$LD_LIBRARY_PATH

RUN yum -y groupinstall "Development Tools" \
    && yum -y install \
    wget \
    cmake \
    openssl-devel \
    openssl \
    sqlite-devel \
    sqlite \
    glibc-devel.x86_64 \
    libicu-devel\
    libicu \
    wget \
    git \
    tar \
    bzip2 \
    bzip2-devel \
    glibc-devel.x86_64 \
    glibc-devel.i686 \
    zlib-devel.x86_64 \
    texinfo.x86_64 \
    libXext-devel \
    libXt-devel \
    libicu-devel \
    sqlite-devel \
    tk-devel \
    ncurses \
    ncurses-devel \
    freetype-devel.x86_64 \
    libxml2-devel.x86_64 \
    libxslt-devel.x86_64 \
    mesa-libGL-devel.x86_64 \
    libXrandr-devel.x86_64 \
    libXinerama-devel.x86_64 \
    libXcursor-devel.x86_64 \
    glut-devel \
    libXmu-devel \
    libXi-devel \
    pulseaudio-libs-devel.x86_64 \
    xorg-x11-fonts-Type1 \
    ca-certificates \
    libXpm-devel \
    libXp-devel \
    cppunit-devel \
    tcsh \
    && yum clean all

COPY cert/*.pem /etc/pki/ca-trust/source/anchors/
COPY scripts/build_base.sh scripts/download_base.sh /tmp/

RUN update-ca-trust force-enable && \
    update-ca-trust extract && \
    /tmp/download_base.sh && \
    /tmp/build_base.sh

ENV CC=$BUILD_DIR/bin/gcc  \
    CXX=$BUILD_DIR/bin/g++

CMD bash
