#!/usr/bin/env bash
set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install USD
#----------------------------------------------
wget https://github.com/PixarAnimationStudios/USD/archive/v0.7.2.tar.gz -O $DOWNLOADS_DIR/USD-0.7.2.tar.gz -nc

cd $TMP_DIR && \
   tar -zxf $DOWNLOADS_DIR/USD-0.7.2.tar.gz && \
   cd $TMP_DIR/USD-0.7.2 && \
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
    make -j ${BUILD_PROCS} install && \
   cd - && \
    echo "</Workaround: Manually installing the following:" && \
    cp pxr/usd/lib/usd/schema.usda $BUILD_DIR/share/usd/plugins/usd/resources && echo "pxr/usd/lib/usd/schema.usda -> $BUILD_DIR/share/usd/plugins/usd/resources" && \
    cp -R pxr/usd/lib/usd/codegenTemplates $BUILD_DIR/bin/codegenTemplates && echo "pxr/usd/lib/usd/codegenTemplates-> $BUILD_DIR/bin/codegenTemplates" && \
    echo "Workaround/>"

rm -rf $TMP_DIR
