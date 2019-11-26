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

if [ "$MAYA_VERSION" = "2018" ]; then
  getFileWithFallback Maya2018_DEVKIT_Linux.tgz https://s3-us-west-2.amazonaws.com/autodesk-adn-transfer/ADN+Extranet/M%26E/Maya/devkit+2018/Maya2018u4_DEVKIT_Linux.tgz ;
elif [ "$MAYA_VERSION" = "2019" ]; then
  getFileWithFallback Maya2019_DEVKIT_Linux.tgz https://autodesk-adn-transfer.s3-us-west-2.amazonaws.com/ADN+Extranet/M%26E/Maya/devkit+2019/Autodesk_Maya_2019_2_Update_DEVKIT_Linux.tgz ;
  getFileWithFallback Maya2019.x86_64.rpm https://bogus.com/Maya2019.x86_64.rpm ;  #Assumes you've manually copied the maya RPM into the downloads folder
else
  getFileWithFallback Maya2017_DEVKIT_Linux.tgz https://s3-us-west-2.amazonaws.com/autodesk-adn-transfer/ADN+Extranet/M%26E/Maya/devkit+2017/Maya2017u4_DEVKIT_Linux.tgz ;
fi


getFileWithFallback googletest-1.8.1.tar.gz https://github.com/google/googletest/archive/release-1.8.1.tar.gz 