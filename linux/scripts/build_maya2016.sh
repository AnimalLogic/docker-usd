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

# Make mayapy the default Python
alias hpython="$MAYA_LOCATION\"/bin/mayapy\"" >> ~/.bashrc
alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
export PATH=$MAYA_LOCATION/bin:$PATH

# Workaround for "Segmentation fault (core dumped)"
# See https://forums.autodesk.com/t5/maya-general/render-crash-on-linux/m-p/5608552/highlight/true
export MAYA_DISABLE_CIP=1

# Checkout the devkit from github.
git clone https://github.com/autodesk-adn/Maya-devkit
cp -R Maya-devkit/linux/devkit/. $MAYA_LOCATION/
cp -R Maya-devkit/linux/include/. $MAYA_LOCATION/include/
cp -R Maya-devkit/linux/mkspecs/. $MAYA_LOCATION/mkspecs/
rm -Rf Maya-devkit