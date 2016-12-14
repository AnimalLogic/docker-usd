#!/usr/bin/env bash
set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

wget https://cmake.org/files/v3.7/cmake-3.7.1.tar.gz -P $DOWNLOADS_DIR -nc

cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/cmake-3.7.1.tar.gz &&\
    cd $TMP_DIR/cmake-3.7.1 && \
    ./bootstrap --prefix=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install
