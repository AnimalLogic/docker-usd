#!/usr/bin/env bash
set -e

mkdir -p $TMP_DIR

mkdir -p $MAYA_INSTALL_LOCATION

#----------------------------------------------
# Checkout, build and install USD
#----------------------------------------------

cd $TMP_DIR && \
    mkdir Maya2017devkit && \
    cd Maya2017devkit && \
      wget http://${HTTP_HOSTNAME}:8000/Autodesk_Maya_2017_Update4_EN_Linux_64bit.tgz -P "$DOWNLOADS_DIR" && \
      wget http://${HTTP_HOSTNAME}:8000/Maya2017_Update3_DEVKIT_Linux.tgz -P "$DOWNLOADS_DIR" && \
      tar -xvzf $DOWNLOADS_DIR/Autodesk_Maya_2017_Update4_EN_Linux_64bit.tgz && \
      tar xf $DOWNLOADS_DIR/Maya2017_Update3_DEVKIT_Linux.tgz
cd / && \
      rpm2cpio $TMP_DIR/Maya2017devkit/Maya2017_64-2017.0-2743.x86_64.rpm | cpio -idmv && \
      ln -s $MAYA_LOCATION/bin/maya2017 $MAYA_LOCATION/bin/maya && \
      cp -R $TMP_DIR/Maya2017devkit/devkitBase/devkit $MAYA_LOCATION

# Make mayapy the default Python
alias hpython="\"$MAYA_LOCATION/bin/mayapy\"" >> ~/.bashrc
alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Extract Maya's QT libraries
cd $MAYA_LOCATION/include
tar xvf qt-5.6.1-include.tar.gz

cd $MAYA_LOCATION/lib/cmake
tar xvf qt-5.6.1-cmake.tar.gz

cd $MAYA_LOCATION/mkspecs
tar xvf qt-5.6.1-mkspecs.tar.gz

cd $MAYA_LOCATION
ln -s qt-plugins plugins

rm -rf $TMP_DIR
