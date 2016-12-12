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
      -DCMAKE_PREFIX_PATH=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install MarkupSafe (Jinja2 dependency)
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/MarkupSafe-0.23.tar.gz &&\
    cd $TMP_DIR/MarkupSafe-0.23 && \
    python setup.py install

#----------------------------------------------
# build and install Jinja2 (USD Dependency)
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/Jinja2-2.8.tar.gz &&\
    cd $TMP_DIR/Jinja2-2.8 && \
    python setup.py install

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
   tar -zxf $DOWNLOADS_DIR/OpenSubdiv-3_1_0.tar.gz && \
   cd $TMP_DIR/OpenSubdiv-3_1_0 && \
   mkdir build && \
   cd build && \
   /usr/bin/cmake .. \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
      -DOPENCL_INCLUDE_DIRS=/usr/local/cuda/include \
      -DOPENCL_LIBRARIES=/usr/local/cuda/lib64/libOpenCL.so \
      -DTBB_LOCATION=$BUILD_DIR \
      -DPTEX_INCLUDE_DIR=$BUILD_DIR/include \
      -DPTEX_LOCATION=$BUILD_DIR \
      -DGLFW_LOCATION=$BUILD_DIR \
      -DGLEW_INCLUDE_DIR=$BUILD_DIR/include \
      -DGLEW_LIBRARY=$BUILD_DIR/lib/libGLEW.so \
      -DNO_EXAMPLES=ON \
      -DNO_REGRESSION=1 \
      -DNO_TUTORIALS=ON && \
    make VERBOSE=1 && \
    make install

rm -rf $TMP_DIR
