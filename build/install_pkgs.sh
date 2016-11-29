#!/usr/bin/env bash
set -e

yum -y groupinstall "Development Tools"
yum -y install \
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
    cmake \
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
    xorg-x11-fonts-Type1
