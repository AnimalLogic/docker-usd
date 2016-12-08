#!/usr/bin/env bash
set -e

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install ilmbase
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/ilmbase-2.2.0.tar.gz &&\
    cd $TMP_DIR/ilmbase-2.2.0 && \
    ./configure --prefix=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install;

#----------------------------------------------
# build and install openexr
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/openexr-2.2.0.tar.gz &&\
    cd $TMP_DIR/openexr-2.2.0 && \
    ./configure --prefix=$BUILD_DIR --disable-ilmbasetest && \
    make -j ${BUILD_PROCS} && \
    make install;

#----------------------------------------------
# build and install OCIO
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/OpenColorIO-1.0.9.tar.gz &&\
    cd $TMP_DIR/OpenColorIO-1.0.9 &&\
    cmake \
        -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
        -DOCIO_BUILD_TRUELIGHT=OFF \
        -DOCIO_BUILD_APPS=OFF \
        -DCMAKE_C_COMPILER=gcc \
        -DCMAKE_CXX_COMPILER=g++ \
        -DOCIO_BUILD_NUKE=OFF &&\
    make -j ${BUILD_PROCS} && \
    make install;

mkdir -p $BUILD_DIR/openColorIO &&\
    cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/OpenColorIO-Configs-1.0_r2.tar.gz &&\
    cd $TMP_DIR/OpenColorIO-Configs-1.0_r2 &&\
    cp nuke-default/config.ocio $BUILD_DIR/openColorIO &&\
    cp -r nuke-default/luts $BUILD_DIR/openColorIO;

#----------------------------------------------
# build and install OIIO
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/oiio-1.5.11.tar.gz &&\
    cd oiio-Release-1.5.11 &&\
    mkdir -p build &&\
    cd build &&\
    cmake .. \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DPYTHON_SITE_PACKAGES=$BUILD_DIR/lib/python2.7/site-packages \
      -DCMAKE_PREFIX_PATH=$BUILD_DIR \
      -DPYTHON_EXECUTABLE=$BUILD_DIR/bin/python &&\
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install MarkupSafe (Jinja2 dependency)
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/MarkupSafe-0.23.tar.gz &&\
    cd $TMP_DIR/MarkupSafe-0.23 && \
    python setup.py build && \
    python setup.py install --prefix=$BUILD_DIR

#----------------------------------------------
# build and install Jinja2 (USD Dependency)
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/Jinja2-2.8.tar.gz &&\
    cd $TMP_DIR/Jinja2-2.8 && \
    python setup.py build && \
    python setup.py install --prefix=$BUILD_DIR

#----------------------------------------------
# build and install pyIlmBase
#----------------------------------------------
cd $TMP_DIR &&\
   tar -zxf $DOWNLOADS_DIR/pyilmbase-2.2.0.tar.gz &&\
   cd $TMP_DIR/pyilmbase-2.2.0 && \
   ./configure --prefix=$BUILD_DIR && \
   make -j ${BUILD_PROCS} && \
   make install;

#----------------------------------------------
# build and install alembic
#----------------------------------------------
cd $TMP_DIR &&\
    unzip $DOWNLOADS_DIR/alembic-1.5.8.zip -d $TMP_DIR &&\
    cd $TMP_DIR/alembic-1.5.8 &&\
    sed -i '/SET( Boost_USE_STATIC_LIBS TRUE )/d' build/AlembicBoost.cmake &&\
    sed -i 's/SET( ALEMBIC_GL_LIBS GLEW ${GLUT_LIBRARY} ${OPENGL_LIBRARIES} )/FIND_PACKAGE( GLEW )\n SET( ALEMBIC_GL_LIBS ${GLEW_LIBRARY} ${GLUT_LIBRARY} ${OPENGL_LIBRARIES} )/g' CMakeLists.txt &&\
    cmake \
        -D CMAKE_INSTALL_PREFIX=$BUILD_DIR \
        -D CMAKE_PREFIX_PATH=$BUILD_DIR \
        -D Boost_NO_SYSTEM_PATHS=TRUE \
        -D Boost_NO_BOOST_CMAKE=TRUE \
        -D BOOST_ROOT=$BUILD_DIR \
        -D ILMBASE_ROOT=$BUILD_DIR \
        -D USE_PYILMBASE=FALSE \
        -D USE_PYALEMBIC=FALSE \
        -D USE_ARNOLD=FALSE \
        -D USE_PRMAN=FALSE \
        -D USE_MAYA=FALSE \
        . &&\
    make -j ${BUILD_PROCS} &&\
    make install &&\
    mv $BUILD_DIR/alembic-*/include/* $BUILD_DIR/include &&\
    mv $BUILD_DIR/alembic-*/lib/static/* $BUILD_DIR/lib

#----------------------------------------------
# build and install Ptex
#----------------------------------------------
cd $TMP_DIR &&\
   tar -zxf $DOWNLOADS_DIR/ptex-2.0.41.tar.gz &&\
   cd $TMP_DIR/ptex-2.0.41/src && \
    cmake -DCMAKE_INSTALL_PREFIX=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    cp ptex/libPtex.so $BUILD_DIR/lib/ && \
    mkdir $BUILD_DIR/include/ptex && \
    cp ../src/ptex/*.h $BUILD_DIR/include/ptex

#----------------------------------------------
# build and install OpenSubdiv
#----------------------------------------------
cd $TMP_DIR &&\
   tar -zxf $DOWNLOADS_DIR/OpenSubdiv-3_0_5.tar.gz && \
   cd $TMP_DIR/OpenSubdiv-3_0_5 && \
   sed -i 's/compute_11/compute_20/g' opensubdiv/CMakeLists.txt &&\
    cmake \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DTBB_INCLUDE_DIR=$BUILD_DIR/include \
      -DTBB_LIBRARIES=dl \
      -DPTEX_INCLUDE_DIR=$BUILD_DIR/include/ptex \
      -DPTEX_LIBRARY=$BUILD_DIR/lib/libPtex.so \
      -DGLFW_INCLUDE_DIR=$BUILD_DIR/include \
      -DGLFW_LIBRARIES=dl \
      -DGLEW_INCLUDE_DIR=$BUILD_DIR/include \
      -DGLEW_LIBRARY=$BUILD_DIR/lib/libGLEW.so \
      -DOPENCL_INCLUDE_DIRS=/usr/local/cuda/include \
      -DNO_EXAMPLES=ON \
      -DNO_TUTORIALS=ON && \
    make -j ${BUILD_PROCS} VERBOSE=1 && \
    make install

rm -rf $TMP_DIR

