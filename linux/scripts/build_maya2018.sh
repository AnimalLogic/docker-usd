#!/usr/bin/env bash
set -e

mkdir -p $TMP_DIR

mkdir -p $MAYA_INSTALL_LOCATION

#----------------------------------------------
# Checkout, build and install USD
#----------------------------------------------

cd $TMP_DIR && \
    mkdir Maya2018devkit && \
    cd Maya2018devkit && \
      wget http://${HTTP_HOSTNAME}:8000/Autodesk_Maya_2018_EN_Linux_64bit.tgz -P "$DOWNLOADS_DIR" && \
      wget http://${HTTP_HOSTNAME}:8000/Maya2018_DEVKIT_Linux.tgz -P "$DOWNLOADS_DIR" && \
      tar -xvzf $DOWNLOADS_DIR/Autodesk_Maya_2018_EN_Linux_64bit.tgz && \
      tar xf $DOWNLOADS_DIR/Maya2018_DEVKIT_Linux.tgz
cd / && \
      rpm2cpio $TMP_DIR/Maya2018devkit/Maya2018_64-2018.0-5870.x86_64.rpm | cpio -idmv && \
      ln -s $MAYA_LOCATION/bin/maya2018 $MAYA_LOCATION/bin/maya && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/cmake $MAYA_LOCATION/lib && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/devkit $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/include $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/mkspecs $MAYA_LOCATION

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
