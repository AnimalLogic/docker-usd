#!/usr/bin/env bash
set -e

# create build dir
mkdir -p $DOWNLOADS_DIR

wget https://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz -P $DOWNLOADS_DIR -nc
wget http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.gz -P $DOWNLOADS_DIR -nc
wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2 -P $DOWNLOADS_DIR -nc
wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz -P $DOWNLOADS_DIR -nc
wget https://ftp.gnu.org/gnu/gcc/gcc-4.8.3/gcc-4.8.3.tar.gz -P $DOWNLOADS_DIR -nc
