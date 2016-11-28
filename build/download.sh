#!/usr/bin/env bash
set -e

yum -y groupinstall "Development Tools"
yum -y install \
    wget \
    cmake \
    openssl-devel \
    openssl \
    sqlite-devel \
    sqlite \
    glibc-devel.x86_64 \
    libicu-devel\
    libicu \
    wget \
    git \
    tar \
    bzip2 \
    bzip2-devel \
    glibc-devel.x86_64 \
    glibc-devel.i686 \
    zlib-devel.x86_64 \
    texinfo.x86_64 \
    libXext-devel \
    cmake \
    openssl-devel \
    libXext-devel \
    libXt-devel \
    libicu-devel \
    sqlite-devel \
    tk-devel \
    ncurses \
    ncurses-devel \
    freetype-devel.x86_64 \
    libxml2-devel.x86_64 \
    libxslt-devel.x86_64 \
    mesa-libGL-devel.x86_64 \
    libXrandr-devel.x86_64 \
    libXinerama-devel.x86_64 \
    libXcursor-devel.x86_64 \
    glut-devel \
    libXmu-devel \
    libXi-devel \
    pulseaudio-libs-devel.x86_64 \
    xorg-x11-fonts-Type1

# create build dir
mkdir -p $DOWNLOADS_DIR

wget https://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz -P $DOWNLOADS_DIR
wget http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.gz -P $DOWNLOADS_DIR
wget https://ftp.gnu.org/gnu/gmp/gmp-5.1.2.tar.bz2 -P $DOWNLOADS_DIR
wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz -P $DOWNLOADS_DIR
wget https://ftp.gnu.org/gnu/gcc/gcc-4.8.3/gcc-4.8.3.tar.gz -P $DOWNLOADS_DIR

wget https://www.python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2 -P $DOWNLOADS_DIR
wget https://pypi.python.org/packages/source/r/readline/readline-6.2.4.1.tar.gz -P $DOWNLOADS_DIR
wget http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.bz2 -P $DOWNLOADS_DIR
wget http://www.ijg.org/files/jpegsrc.v8c.tar.gz -P $DOWNLOADS_DIR
wget http://libtiff.maptools.org/dl/tiff-3.8.2.tar.gz -P $DOWNLOADS_DIR
wget ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng16/libpng-1.6.3.tar.gz -P $DOWNLOADS_DIR
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.gz -P $DOWNLOADS_DIR
wget https://pypi.python.org/packages/source/P/PyOpenGL/PyOpenGL-3.0.2.tar.gz -P $DOWNLOADS_DIR
wget http://download.qt.io/archive/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz -P $DOWNLOADS_DIR
wget http://download.qt-project.org/official_releases/pyside/pyside-qt4.8+1.2.2.tar.bz2 -P $DOWNLOADS_DIR
wget http://download.qt-project.org/official_releases/pyside/shiboken-1.2.2.tar.bz2 -P $DOWNLOADS_DIR
wget https://github.com/PySide/Tools/archive/0.2.15.tar.gz -O $DOWNLOADS_DIR/pysidetools-0.2.15.tar.gz
wget https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb43_20150611oss_src.tgz -P $DOWNLOADS_DIR
wget http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz -P $DOWNLOADS_DIR
wget http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz -P $DOWNLOADS_DIR
wget http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/ttf-bitstream-vera-1.10.tar.gz -P $DOWNLOADS_DIR
wget http://downloads.sourceforge.net/project/glew/glew/1.10.0/glew-1.10.0.tgz -P $DOWNLOADS_DIR
wget https://github.com/imageworks/OpenColorIO/archive/v1.0.9.tar.gz -O $DOWNLOADS_DIR/OpenColorIO-1.0.9.tar.gz
wget http://github.com/imageworks/OpenColorIO-Configs/archive/v1.0_r2.tar.gz -O $DOWNLOADS_DIR/OpenColorIO-Configs-1.0_r2.tar.gz
wget https://github.com/OpenImageIO/oiio/archive/Release-1.5.11.tar.gz -O $DOWNLOADS_DIR/oiio-1.5.11.tar.gz
wget https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.11/src/hdf5-1.8.11.tar.gz -P $DOWNLOADS_DIR
wget http://downloads.sourceforge.net/project/numpy/NumPy/1.9.2/numpy-1.9.2.tar.gz -P $DOWNLOADS_DIR
wget http://download.savannah.nongnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz -P $DOWNLOADS_DIR
wget https://github.com/alembic/alembic/archive/1.5.8.zip -O $DOWNLOADS_DIR/alembic-1.5.8.zip
wget https://github.com/google/double-conversion/archive/v1.1.5.tar.gz -O $DOWNLOADS_DIR/double-conversion-1.1.5.tar.gz
wget http://github.com/wdas/ptex/archive/v2.0.41.tar.gz -O $DOWNLOADS_DIR/ptex-2.0.41.tar.gz
wget https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip -P $DOWNLOADS_DIR
wget https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_0_5.tar.gz -O $DOWNLOADS_DIR/OpenSubdiv-3_0_5.tar.gz
wget https://github.com/jemalloc/jemalloc/releases/download/4.3.1/jemalloc-4.3.1.tar.bz2 -P $DOWNLOADS_DIR
wget https://github.com/PixarAnimationStudios/USD/archive/v0.7.1.tar.gz -O $DOWNLOADS_DIR/USD-0.7.1.tar.gz
