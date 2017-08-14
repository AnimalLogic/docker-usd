#!/usr/bin/env bash
set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install USD
#----------------------------------------------
wget https://github.com/PixarAnimationStudios/USD/archive/v${USD_VERSION}.tar.gz -O $DOWNLOADS_DIR/USD-${USD_VERSION}.tar.gz -nc

cd $TMP_DIR && \
   tar -zxf $DOWNLOADS_DIR/USD-${USD_VERSION}.tar.gz && \
   cd $TMP_DIR/USD-${USD_VERSION} && \
    mkdir build && \
    cd build && \
    cmake \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DOPENEXR_LOCATION=$BUILD_DIR \
      -DPTEX_INCLUDE_DIR=$BUILD_DIR/include/ptex \
      -DOIIO_BASE_DIR=$BUILD_DIR \
      -DOPENSUBDIV_ROOT_DIR=$BUILD_DIR \
      -DDOUBLE_CONVERSION_INCLUDE_DIR=$BUILD_DIR/include \
      -DDOUBLE_CONVERSION_LIBRARY=$BUILD_DIR/lib/libdouble-conversion.so \
      -DPTEX_LIBRARY=$BUILD_DIR/lib/libPtex.so \
      -DGLEW_INCLUDE_DIR=$BUILD_DIR/include/GL \
      -DGLEW_LIBRARY=$BUILD_DIR/lib/libGLEW.so \
      -DPXR_MALLOC_LIBRARY:path=$BUILD_DIR/lib/libjemalloc.so \
      .. && \
    make -j ${BUILD_PROCS} && \
    make install && \
   cd -
