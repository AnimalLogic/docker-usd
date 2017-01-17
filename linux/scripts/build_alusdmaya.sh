#!/usr/bin/env bash

#What is this?
set -e

mkdir -p $TMP_DIR

#----------------------------------------------
# Checkout, build and install USD
# TODO: use a zipped version of AL_USDMaya to have a more consistant run
#----------------------------------------------

cd $TMP_DIR &&\
  git clone http://github.al.com.au/rnd/AL_USDMaya.git &&\
  cd AL_USDMaya &&\
    git checkout danielbar_removeRezAndDependencies &&\
    mkdir build &&\
    cd build  &&\
      cmake -Wno-dev \
            -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
            -DCMAKE_MODULE_PATH=$BUILD_DIR \
            -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DBOOST_ROOT=$BUILD_DIR \
            -DMAYA_LOCATION=$MAYA_LOCATION \
            -DNO_TESTS=true \
            ..
    make -j ${BUILD_PROCS}
  make install