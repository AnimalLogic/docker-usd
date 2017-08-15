#!/usr/bin/env bash

# Referenced from https://github.com/mottosso/docker-maya/blob/2016sp1/Dockerfile
# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
#Location of where maya is. Currently it is in the rpm install default location.
wget http://download.autodesk.com/us/support/files/maya_2016_service_pack_1/Autodesk_Maya_2016_SP1_EN_Linux_64bit.tgz -O maya.tgz 
mkdir /maya
tar -xvf maya.tgz -C /maya
rm maya.tgz
rpm -Uvh /maya/Maya*.rpm
rm -r /maya

# Checkout the devkit from github.
echo "This takes awhile..."
git clone --progress https://github.com/autodesk-adn/Maya-devkit
cp -R Maya-devkit/linux/devkit/. $MAYA_LOCATION/
cp -R Maya-devkit/linux/include/. $MAYA_LOCATION/include/
cp -R Maya-devkit/linux/mkspecs/. $MAYA_LOCATION/mkspecs/
rm -Rf Maya-devkit

# Extract Maya's QT tar's
cd $MAYA_LOCATION/include
tar xvf qt-4.8.6-include.tar.gz

cd $MAYA_LOCATION/mkspecs
tar xvf qt-4.8.6-mkspecs.tar.gz

cd $MAYA_LOCATION
ln -s qt-plugins plugins
