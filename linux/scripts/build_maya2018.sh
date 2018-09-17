#!/usr/bin/env bash
set -e

mkdir -p $TMP_DIR

mkdir -p $MAYA_LOCATION

#----------------------------------------------
# Install Maya DevKit
#----------------------------------------------

cd $TMP_DIR && \
    mkdir Maya2018devkit && \
    cd Maya2018devkit && \
      tar -xvzf $DOWNLOADS_DIR/Maya2018u4_DEVKIT_Linux.tgz
cd / && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/cmake $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/devkit $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/include $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/mkspecs $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/lib $MAYA_LOCATION

# Extract Maya's QT libraries
cd $MAYA_LOCATION/include
tar xvf qt-5.6.1-include.tar.gz

cd $MAYA_LOCATION/cmake
tar xvf qt-5.6.1-cmake.tar.gz

cd $MAYA_LOCATION/mkspecs
tar xvf qt-5.6.1-mkspecs.tar.gz

rm -rf $TMP_DIR
