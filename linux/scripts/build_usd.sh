#!/usr/bin/env bash
# Copyright (C) Animal Logic Pty Ltd. All rights reserved.

set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install USD
#----------------------------------------------
if [ -n "${MAYA_MAJOR_VERSION}" ]; then
  echo "Build USD with Maya ${MAYA_MAJOR_VERSION}"
  export MAYA_EXECUTABLE=
  export MAYA_OPS="-DPXR_BUILD_MAYA_PLUGIN=TRUE -DMAYA_LOCATION=/opt/usd/maya${MAYA_MAJOR_VERSION}DevKit -DMAYA_EXECUTABLE=/opt/usd/maya${MAYA_MAJOR_VERSION}DevKit/bin/mayald"
else
  export MAYA_OPS="-DPXR_BUILD_MAYA_PLUGIN=FALSE"
fi

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
      -DPXR_MALLOC_LIBRARY:path=$BUILD_DIR/lib/libjemalloc.so \
      -DPXR_BUILD_ALEMBIC_PLUGIN=ON \
      ${MAYA_OPS} \
      ..

cd $TMP_DIR/USD-${USD_VERSION}/build && \
  make -j ${BUILD_PROCS}

cd $TMP_DIR/USD-${USD_VERSION}/build && \
    make install

#mkdir -p $BUILD_DIR/usd/${USD_VERSION}/extras/usdObj
#cp $TMP_DIR/USD-$USD_VERSION/build/extras/usd/examples/usdObj/plugInfo.json $BUILD_DIR/usd/${USD_VERSION}/extras/usdObj
#cp $TMP_DIR/USD-$USD_VERSION/build/extras/usd/examples/usdObj/usdObj.so $BUILD_DIR/usd/${USD_VERSION}/extras/usdObj

rm -rf $TMP_DIR
