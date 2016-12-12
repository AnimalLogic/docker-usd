#!/usr/bin/env bash
set -e

# Build script to be from a single in Dockerfile to minimise image size
mkdir -p $TMP_DIR

cd $TMP_DIR && \
    tar xf $DOWNLOADS_DIR/gmp-5.1.2.tar.bz2 && \
    cd gmp-5.1.2 && CFLAGS=-m64 ./configure --prefix=$BUILD_DIR && \
    CFLAGS=-m64 LDFLAGS=-L$BUILD_DIR/lib64 make -j $BUILD_PROCS && make install
cd $TMP_DIR && \
    tar xf $DOWNLOADS_DIR/mpfr-3.1.2.tar.gz && \
    cd mpfr-3.1.2 && CFLAGS=-m64 ./configure --with-gmp=$BUILD_DIR --prefix=$BUILD_DIR && \
    CFLAGS=-m64 LDFLAGS=-L$BUILD_DIR/lib64 make -j $BUILD_PROCS && make install
cd $TMP_DIR && \
    tar xf $DOWNLOADS_DIR/mpc-1.0.1.tar.gz && \
    cd mpc-1.0.1 && CFLAGS=-m64 ./configure --with-gmp=$BUILD_DIR --prefix=$BUILD_DIR && \
    CFLAGS=-m64 LDFLAGS=-L$BUILD_DIR/lib64 make -j $BUILD_PROCS && make install
cd $TMP_DIR && \
    tar xf $DOWNLOADS_DIR/gcc-4.8.3.tar.gz && \
    cd gcc-4.8.3 && \
    LD_LIBRARY_PATH=$BUILD_DIR/lib64 LIBRARY_PATH="" CFLAGS=-m64 ./configure \
      -disable-multilib \
      --enable-languages=c,c++,fortran --enable-shared \
      --enable-threads=posix --enable-checkin=release \
      --with-gmp=$BUILD_DIR --with-mpc=$BUILD_DIR --with-mpfr=$BUILD_DIR \
      --prefix=$BUILD_DIR && \
    LD_LIBRARY_PATH=$BUILD_DIR/lib LIBRARY_PATH="" CFLAGS=-m64 LDFLAGS=-L$BUILD_DIR/lib64 make bootstrap -j $BUILD_PROCS && \
    make install
cd $TMP_DIR && \
    tar xf $DOWNLOADS_DIR/binutils-2.24.tar.gz && \
    cd binutils-2.24 && CFLAGS=-m64 ./configure --prefix=$BUILD_DIR && \
    CFLAGS=-m64 LDFLAGS=-L$BUILD_DIR/lib64 make -j $BUILD_PROCS && make install

ln -s $BUILD_DIR/lib64/lib* $BUILD_DIR/lib/

#----------------------------------------------
# build and install PYTHON
#----------------------------------------------
cd $TMP_DIR && \
    tar -jxf $DOWNLOADS_DIR/Python-2.7.5.tar.bz2 && \
    cd $TMP_DIR/Python-2.7.5 && \
    ./configure \
         --prefix=$BUILD_DIR \
         --enable-unicode=ucs4 \
         --enable-shared && \
    make -j $BUILD_PROCS && \
    make install

rm -rf $TMP_DIR
