#!/usr/bin/env bash
set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install setuptools
#----------------------------------------------
wget https://pypi.io/packages/source/s/setuptools/setuptools-30.0.0.tar.gz -P $DOWNLOADS_DIR -nc --no-check-certificate
cd $TMP_DIR && \
 	tar -zxf $DOWNLOADS_DIR/setuptools-30.0.0.tar.gz && \
    cd $TMP_DIR/setuptools-30.0.0 && \
    $PYTHON_EXECUTABLE setup.py install

#----------------------------------------------
# build and install readline
#----------------------------------------------
cd $TMP_DIR && \
 	tar -zxf $DOWNLOADS_DIR/readline-6.2.4.1.tar.gz && \
    cd $TMP_DIR/readline-6.2.4.1 && \
    $PYTHON_EXECUTABLE setup.py install

#----------------------------------------------
# build and install boost
#----------------------------------------------
cd $TMP_DIR &&\
    tar -jxf $DOWNLOADS_DIR/boost_1_55_0.tar.bz2 &&\
    cd $TMP_DIR/boost_1_55_0 &&\
    ./bootstrap.sh \
        --prefix=$BUILD_DIR \
        --with-python=$BUILD_DIR/bin/$PYTHON_EXECUTABLE \
        --with-python-root=$BUILD_DIR && \
    ./bjam -j $BUILD_PROCS \
        -a \
        -d+2 \
        variant=release \
        link=shared \
        link=static \
        threading=multi \
        install

#----------------------------------------------
# build and install JPEG
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/jpegsrc.v8c.tar.gz && \
    cd $TMP_DIR/jpeg-8c && \
    ./configure \
        --prefix=$BUILD_DIR && \
    make && \
    make install

#----------------------------------------------
# build and install TIFF
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/tiff-3.8.2.tar.gz && \
    cd $TMP_DIR/tiff-3.8.2 && \
    ./configure \
        --prefix=$BUILD_DIR && \
        make && \
        make install

#----------------------------------------------
# build and install PNG
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/libpng-1.6.26.tar.gz && \
    cd $TMP_DIR/libpng-1.6.26 && \
    ./configure \
        --prefix=$BUILD_DIR && \
    make && \
    make install

#----------------------------------------------
# build and install Freetype
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/freetype-2.4.12.tar.gz && \
    cd $TMP_DIR/freetype-2.4.12 && \
    ./configure \
        --prefix=$BUILD_DIR && \
    make && \
    make install

#----------------------------------------------
# build and install PyOpenGL
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/PyOpenGL-3.0.2.tar.gz &&\
    cd $TMP_DIR/PyOpenGL-3.0.2 &&\
    $PYTHON_EXECUTABLE setup.py install

#----------------------------------------------
# build and install Qt
#----------------------------------------------
cd $TMP_DIR && \
    tar -zxf $DOWNLOADS_DIR/qt-everywhere-opensource-src-4.8.6.tar.gz && \
    cd $TMP_DIR/qt-everywhere-opensource-src-4.8.6 && \
    #unzip $DOWNLOADS_DIR/Qt-4_8_6_forMaya2016.zip -d $TMP_DIR  && \
    #tar -zxf $TMP_DIR/Qt/qt-adsk-4.8.6.tgz && \
    #cd qt-adsk-4.8.6 && \
    ./configure \
        -prefix $BUILD_DIR \
        -opensource \
        -confirm-license \
        -no-rpath \
        -no-qt3support \
        -xrender \
        -opengl desktop \
        -nomake examples \
        -nomake demos \
        -I $BUILD_DIR/include \
        -I $BUILD_DIR/include/freetype2 \
        -L $BUILD_DIR/lib &&\
    make -j ${BUILD_PROCS} && \
    make install

# #----------------------------------------------
# # build and install PySide
# #----------------------------------------------
cd $TMP_DIR &&\
    tar -jxf $DOWNLOADS_DIR/pyside-qt4.8+1.2.2.tar.bz2 &&\
    tar -jxf $DOWNLOADS_DIR/shiboken-1.2.2.tar.bz2 &&\
    tar -zxf $DOWNLOADS_DIR/pysidetools-0.2.15.tar.gz &&\
    cd $TMP_DIR/shiboken-1.2.2 &&\
    rm -f build &&\
    mkdir build &&\
    cd build &&\
    cmake .. \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DPYTHON_SITE_PACKAGES=$PYTHON_SITE_PACKAGES \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPYTHON_EXECUTABLE=$PYTHON_EXECUTABLE &&\
    make VERBOSE=1 -j ${BUILD_PROCS} &&\
    make install &&\
    cd $TMP_DIR/pyside-qt4.8+1.2.2 &&\
    rm -f build &&\
    mkdir build &&\
    cd build &&\
    cmake .. \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DPYTHON_SITE_PACKAGES=$PYTHON_SITE_PACKAGES \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPYTHON_EXECUTABLE=$PYTHON_EXECUTABLE &&\
    make VERBOSE=1 -j ${BUILD_PROCS} &&\
    make install &&\
    cd $TMP_DIR/Tools-0.2.15 &&\
    mkdir build &&\
    cd build &&\
    cmake .. \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DPYTHON_SITE_PACKAGES=$PYTHON_SITE_PACKAGES \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPYTHON_EXECUTABLE=$PYTHON_EXECUTABLE &&\
    make -j ${BUILD_PROCS} &&\
    make install

#----------------------------------------------
# build and install TBB
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/tbb43_20150611oss_src.tgz && \
    cd $TMP_DIR/tbb43_20150611oss && \
    make -j ${BUILD_PROCS} && \
    cp build/*_release/*.so* $BUILD_DIR/lib &&\
    cp -R include/* $BUILD_DIR/include/;

#----------------------------------------------
# build and install FONTS
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/ttf-bitstream-vera-1.10.tar.gz &&\
    cd $TMP_DIR/ttf-bitstream-vera-1.10 &&\
    mkdir -p $BUILD_DIR/fonts && \
    cp *.ttf $BUILD_DIR/fonts;

#----------------------------------------------
# build and install GLEW
#----------------------------------------------
mkdir -p $BUILD_DIR/lib64/pkgconfig &&\
    cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/glew-1.10.0.tgz &&\
    cd $TMP_DIR/glew-1.10.0 &&\
    make install GLEW_DEST=$BUILD_DIR LIBDIR=$BUILD_DIR/lib;

#----------------------------------------------
# build and install hdf5
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/hdf5-1.8.11.tar.gz &&\
    cd hdf5-1.8.11 &&\
    ./configure \
        --prefix=$BUILD_DIR \
        --enable-threadsafe \
        --with-pthread=/usr/include &&\
     make -j ${BUILD_PROCS} && \
     make install

#----------------------------------------------
# build and install numpy
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/numpy-1.9.2.tar.gz &&\
    cd $TMP_DIR/numpy-1.9.2 && \
    $PYTHON_EXECUTABLE setup.py install

#----------------------------------------------
# build and install google/double-conversion
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/double-conversion-1.1.5.tar.gz &&\
    cd $TMP_DIR/double-conversion-1.1.5 &&\
     cmake -DCMAKE_INSTALL_PREFIX=$BUILD_DIR -DBUILD_SHARED_LIBS=ON && \
     make -j ${BUILD_PROCS} && \
     make install

#----------------------------------------------
# build and install glfw
#----------------------------------------------
cd $TMP_DIR &&\
   unzip $DOWNLOADS_DIR/glfw-3.2.1.zip -d $TMP_DIR &&\
   cd $TMP_DIR/glfw-3.2.1 && \
    cmake \
    -DCMAKE_INSTALL_PREFIX=$BUILD_DIR -DGLFW_BUILD_DOCS=OFF && \
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install jemalloc
#----------------------------------------------
cd $TMP_DIR &&\
   tar -xjf $DOWNLOADS_DIR/jemalloc-4.3.1.tar.bz2 &&\
   cd $TMP_DIR/jemalloc-4.3.1 &&\
   ./configure \
      --prefix=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install

rm -rf $TMP_DIR
