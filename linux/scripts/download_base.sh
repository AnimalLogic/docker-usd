#!/usr/bin/env bash
set -e

# create build dir
mkdir -p $DOWNLOADS_DIR

wget https://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz -P $DOWNLOADS_DIR -nc
wget http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.gz -P $DOWNLOADS_DIR -nc
wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2 -P $DOWNLOADS_DIR -nc
wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz -P $DOWNLOADS_DIR -nc
wget https://ftp.gnu.org/gnu/gcc/gcc-4.8.3/gcc-4.8.3.tar.gz -P $DOWNLOADS_DIR -nc
wget https://www.python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2 -P $DOWNLOADS_DIR -nc
yum install -y gstreamer-plugins-base
yum install libXp
yum install libXpm
yum install gamin-devel
yum install libpng
yum install libpng12
yum install libXcomposite
yum install libjpeg