#!/usr/bin/env bash
set -e

mkdir -p $TMP_DIR

mkdir -p $MAYA_INSTALL_LOCATION

#----------------------------------------------
# Checkout, build and install USD
#----------------------------------------------
yum install tcsh libXp libXpm libXcomposite fam libpng12 libjpeg

cd $TMP_DIR && \
    mkdir Maya2018devkit && \
    cd Maya2018devkit && \
      tar -xvzf $MAYA_DOCKER_PATH && \
      tar xf $MAYA_DEVKIT_DOCKER_PATH
cd $MAYA_INSTALL_LOCATION && \
      rpm2cpio $TMP_DIR/Maya2018devkit/Maya2018_64-2018.0-5661.x86_64.rpm | cpio -idmv && \
      ln -s $MAYA_LOCATION/bin/maya2018 $MAYA_LOCATION/bin/maya
      cp -R $TMP_DIR/Maya2018devkit/devkitBase/devkit $MAYA_LOCATION

# Make mayapy the default Python
alias hpython="\"$MAYA_LOCATION/bin/mayapy\"" >> ~/.bashrc
alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

rm -rf $TMP_DIR
