#!/usr/bin/env bash
set -e

cd $MAYA_LOCATION/include
tar xvf qt-5.6.1-include.tar.gz

cd $MAYA_LOCATION/lib/cmake
tar xvf qt-5.6.1-cmake.tar.gz

cd $MAYA_LOCATION/mkspecs
tar xvf qt-5.6.1-mkspecs.tar.gz

cd $MAYA_LOCATION
ln -s qt-plugins plugins
