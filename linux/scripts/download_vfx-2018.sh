#!/usr/bin/env bash
# Copyright (C) Animal Logic Pty Ltd. All rights reserved.

set -e

# create build dir
mkdir -p $DOWNLOADS_DIR

function getFileWithFallback() {
  # $1 local path to the file on the HTTP server
  # $2 path which will be used in the wget call if the file couldn't be found in the local HTTP server
  # $3 the name that the file will be written out as once pulled from wget

  local filepath="$1"
  local wgetPath="$2"
  if [ ! -f $DOWNLOADS_DIR/$filepath ]; then
    if [[ -z "${HTTP_HOSTNAME}" ]]; then
      wget $wgetPath -P "$DOWNLOADS_DIR" -O "$DOWNLOADS_DIR/$filepath" -nc
      if [[ $? -ne 0 ]]; then
        echo "Failed to get file $wgetPath and rename to '$DOWNLOADS_DIR/$filepath'"
        exit 1
      fi
    else
      echo "Downloading from proxy http: http://${HTTP_HOSTNAME}:8000/${filepath}"
      wget -q http://${HTTP_HOSTNAME}:8000/${filepath} -P "$DOWNLOADS_DIR"
    fi
  fi
}

getFileWithFallback Maya-Qt5.6.1-2018.3.tgz https://www.autodesk.com/content/dam/autodesk/www/Company/files/Maya-Qt5.6.1-2018.3.tgz

getFileWithFallback pyside2-maya2018.4.zip https://www.autodesk.com/content/dam/autodesk/www/Company/files/pyside2-maya2018.4.zip

getFileWithFallback jpegsrc.v8c.tar.gz http://www.ijg.org/files/jpegsrc.v8c.tar.gz

getFileWithFallback tiff-3.8.2.tar.gz http://pkgs.fedoraproject.org/repo/pkgs/libtiff/tiff-3.8.2.tar.gz/fbb6f446ea4ed18955e2714934e5b698/tiff-3.8.2.tar.gz

getFileWithFallback libpng-1.6.26.tar.gz "https://downloads.sourceforge.net/project/libpng/libpng16/older-releases/1.6.26/libpng-1.6.26.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flibpng%2Ffiles%2Flibpng16%2Folder-releases%2F1.6.26%2Flibpng-1.6.26.tar.gz%2Fdownload%3Fuse_mirror%3Dfreefr&ts=1501043258&use_mirror=svwh"

getFileWithFallback PyOpenGL-3.0.2.tar.gz https://pypi.python.org/packages/source/P/PyOpenGL/PyOpenGL-3.0.2.tar.gz

getFileWithFallback glew-1.10.0.tgz "https://downloads.sourceforge.net/project/glew/glew/1.10.0/glew-1.10.0.tgz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fglew%2Ffiles%2Fglew%2F1.10.0%2Fglew-1.10.0.tgz%2Fdownload&ts=1501043354&use_mirror=svwh"

getFileWithFallback OpenColorIO-1.0.9.tar.gz https://github.com/imageworks/OpenColorIO/archive/v1.0.9.tar.gz

getFileWithFallback OpenColorIO-Configs-1.0_r2.tar.gz http://github.com/imageworks/OpenColorIO-Configs/archive/v1.0_r2.tar.gz

getFileWithFallback oiio-1.5.11.tar.gz https://github.com/OpenImageIO/oiio/archive/Release-1.5.11.tar.gz

getFileWithFallback hdf5-1.8.11.tar.gz https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.11/src/hdf5-1.8.11.tar.gz

getFileWithFallback numpy-1.9.2.tar.gz "https://downloads.sourceforge.net/project/numpy/NumPy/1.9.2/numpy-1.9.2.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fnumpy%2Ffiles%2FNumPy%2F1.9.2%2Fnumpy-1.9.2.tar.gz%2Fdownload&ts=1501045534&use_mirror=svwh"

getFileWithFallback pyilmbase-2.2.0.tar.gz http://download.savannah.nongnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz

getFileWithFallback alembic-1.5.8.zip https://github.com/alembic/alembic/archive/1.5.8.zip alembic-1.5.8.zip

getFileWithFallback ptex-2.0.41.tar.gz http://github.com/wdas/ptex/archive/v2.0.41.tar.gz

getFileWithFallback glfw-3.2.1.zip https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip

getFileWithFallback jemalloc-5.1.0.tar.bz2 https://github.com/jemalloc/jemalloc/releases/download/5.1.0/jemalloc-5.1.0.tar.bz2

getFileWithFallback googletest-1.8.1.tar.gz https://github.com/google/googletest/archive/release-1.8.1.tar.gz
