#!/usr/bin/env bash
set -e

cd $MAYA_LOCATION/include
tar xvf qt-4.8.6-include.tar.gz

cd $MAYA_LOCATION/mkspecs
tar xvf qt-4.8.6-mkspecs.tar.gz

cd $MAYA_LOCATION
ln -s qt-plugins plugins
