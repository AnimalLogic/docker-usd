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
      tar -xvzf $MAYA_DOCKER_PATH && \
      tar xf $MAYA_DEVKIT_DOCKER_PATH
cd $MAYA_INSTALL_LOCATION && \
      rpm2cpio $TMP_DIR/Maya2017devkit/Maya2017_64-2017.0-28.x86_64.rpm | cpio -idmv && \
      ln -s $MAYA_LOCATION/bin/maya2017 $MAYA_LOCATION/bin/maya
      cp -R $TMP_DIR/Maya2017devkit/devkitBase/devkit $MAYA_LOCATION

# Make mayapy the default Python
alias hpython="\"$MAYA_LOCATION/bin/mayapy\"" >> ~/.bashrc
alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
export PATH=$MAYA_LOCATION/bin:$PATH

rm -rf $TMP_DIR
