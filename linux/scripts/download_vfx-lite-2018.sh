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

getFileWithFallback cmake-3.12.3.tar.gz https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz

getFileWithFallback boost_1_61_0.tar.bz2 https://svwh.dl.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2

getFileWithFallback tbb2017_U6.tar.gz https://github.com/01org/tbb/archive/2017_U6.tar.gz

getFileWithFallback openexr-2.2.0.tar.gz http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz

getFileWithFallback ilmbase-2.2.0.tar.gz http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz

getFileWithFallback OpenSubdiv-3_3_3.tar.gz https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_3_3.tar.gz

getFileWithFallback jemalloc-5.1.0.tar.bz2 https://github.com/jemalloc/jemalloc/releases/download/5.1.0/jemalloc-5.1.0.tar.bz2

getFileWithFallback cmake-3.11.4-Linux-x86_64.tar.gz https://cmake.org/files/v3.11/cmake-3.11.4-Linux-x86_64.tar.gz
