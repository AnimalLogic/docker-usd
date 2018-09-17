#!/usr/bin/env bash
set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install USD
#----------------------------------------------

export MAYA_EXECUTABLE=
cd $TMP_DIR && \
   tar -zxf $DOWNLOADS_DIR/USD-v${USD_VERSION}.tar.gz && \
   cd $TMP_DIR/USD-${USD_VERSION} && \
    mkdir build && \
    cd build && \
    cmake \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/usd/${USD_VERSION} \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPXR_BUILD_TESTS=ON \
      -DOPENEXR_LOCATION=$BUILD_DIR \
      -DPTEX_INCLUDE_DIR=$BUILD_DIR/include/ptex \
      -DOPENSUBDIV_ROOT_DIR=$BUILD_DIR \
      -DPTEX_LIBRARY=$BUILD_DIR/lib/libPtex.so \
      -DGLEW_INCLUDE_DIR=$BUILD_DIR/include/GL \
      -DGLEW_LIBRARY=$BUILD_DIR/lib/libGLEW.so \
      -DPXR_BUILD_MAYA_PLUGIN=TRUE \
      -DMAYA_LOCATION=/opt/usd/maya${MAYA_MAJOR_VERSION}DevKit \
      -DMAYA_EXECUTABLE=/opt/usd/maya${MAYA_MAJOR_VERSION}DevKit/bin/mayald \
      -DPXR_MALLOC_LIBRARY:path=$BUILD_DIR/lib/libjemalloc.so \
      -DPXR_BUILD_ALEMBIC_PLUGIN=ON \
      .. && \
    make -j ${BUILD_PROCS} && \
    make install && \
  cd -
