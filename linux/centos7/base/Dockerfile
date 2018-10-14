############################################################
# Dockerfile to build USD on VFX Platform 2016
# Based on nvidia/cuda:devel-centos6
ARG cuda_version=latest
FROM nvidia/cudagl:${cuda_version}-devel-centos7

LABEL maintainer="Aloys.Baillet - Animal Logic"

ENV BUILD_PROCS 7
ENV BUILD_DIR /opt/usd
ENV TMP_DIR /tmp/usd-build
ENV DOWNLOADS_DIR /tmp/usd-downloads

ENV PATH $BUILD_DIR/bin:$PATH
ENV PKG_CONFIG_PATH=$BUILD_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH=$BUILD_DIR/lib64:$BUILD_DIR/lib:$LD_LIBRARY_PATH

RUN yum -y groupinstall "Development Tools"
RUN yum install -y epel-release && sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
RUN yum install -y  \
    wget \
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
    cmake \
    bzip2 \
    bzip2-devel \
    glibc-devel.x86_64 \
    glibc-devel.i686 \
    zlib-devel.x86_64 \
    texinfo.x86_64 \
    libXext-devel \
    openssl-devel \
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
    python-devel \
    qt-devel \
    gstreamer-plugins-base \
    libXp \
    libXpm \
    gamin-devel \
    tcsh \
    libXp \
    libXpm \
    fam \
    libpng12 \
    libXcomposite \
    libjpeg \
    python-pip \
    qt-devel.x86_64 \
    python-pyside-devel.x86_64 \
    pyside-tools.x86_64

COPY cert/* /etc/pki/ca-trust/source/anchors/

RUN update-ca-trust force-enable && \
    update-ca-trust extract

CMD bash
