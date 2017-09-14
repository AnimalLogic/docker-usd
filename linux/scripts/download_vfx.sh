#!/usr/bin/env bash
set -e

# create build dir
mkdir -p $DOWNLOADS_DIR

function getFileWithFallback() {
  # $1 local path to the file on the HTTP server
  # $2 path which will be used in the wget call if the file couldn't be found in the local HTTP server
  # $3 the name that the file will be written out as once pulled from wget

  local filepath="$1"
  local wgetPath="$2"
  local renamedTarget="$3"
  if [ ! -f $DOWNLOADS_DIR/$renamedTarget ]; then
    wget -q http://${HTTP_HOSTNAME}:8000/${filepath} -P "$DOWNLOADS_DIR" ||
    if [[ $? -ne 0 ]]; then
      if [ ! -z "$renamedTarget" ]; then
        wget $wgetPath -P "$DOWNLOADS_DIR" -O "$DOWNLOADS_DIR/$renamedTarget" -nc
        if [[ $? -ne 0 ]]; then
          echo "Failed to get file $wgetPath and rename to '$DOWNLOADS_DIR/$renamedTarget'"
          exit 1
        fi
      else
        wget $wgetPath -P "$DOWNLOADS_DIR" -nc
        if [[ $? -ne 0 ]]; then
          echo "Failed to get file $wgetPath"
          exit 1
        fi
      fi
    fi
  fi
}

getFileWithFallback readline-6.2.4.1.tar.gz https://pypi.python.org/packages/source/r/readline/readline-6.2.4.1.tar.gz

getFileWithFallback boost_1_55_0.tar.bz2 https://svwh.dl.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.bz2

getFileWithFallback jpegsrc.v8c.tar.gz http://www.ijg.org/files/jpegsrc.v8c.tar.gz

getFileWithFallback tiff-3.8.2.tar.gz http://pkgs.fedoraproject.org/repo/pkgs/libtiff/tiff-3.8.2.tar.gz/fbb6f446ea4ed18955e2714934e5b698/tiff-3.8.2.tar.gz

getFileWithFallback libpng-1.6.26.tar.gz \
  "https://downloads.sourceforge.net/project/libpng/libpng16/older-releases/1.6.26/libpng-1.6.26.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flibpng%2Ffiles%2Flibpng16%2Folder-releases%2F1.6.26%2Flibpng-1.6.26.tar.gz%2Fdownload%3Fuse_mirror%3Dfreefr&ts=1501043258&use_mirror=svwh" \
  libpng-1.6.26.tar.gz

getFileWithFallback freetype-2.4.12.tar.gz \
  "https://downloads.sourceforge.net/project/freetype/freetype2/2.4.12/freetype-2.4.12.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Ffreetype%2Ffiles%2Ffreetype2%2F2.4.12%2Ffreetype-2.4.12.tar.gz%2Fdownload&ts=1501048824&use_mirror=svwh" \
  freetype-2.4.12.tar.gz

getFileWithFallback PyOpenGL-3.0.2.tar.gz https://pypi.python.org/packages/source/P/PyOpenGL/PyOpenGL-3.0.2.tar.gz

getFileWithFallback qt-everywhere-opensource-src-5.6.1.tar.gz http://mirrors.ocf.berkeley.edu/qt/archive/qt/5.6/5.6.1/single/qt-everywhere-opensource-src-5.6.1.tar.gz

getFileWithFallback pyside-qt4.8+1.2.2.tar.bz2 http://download.qt-project.org/official_releases/pyside/pyside-qt4.8+1.2.2.tar.bz2

getFileWithFallback shiboken-1.2.2.tar.bz2 http://download.qt-project.org/official_releases/pyside/shiboken-1.2.2.tar.bz2

getFileWithFallback pysidetools-0.2.15.tar.gz \
  https://github.com/PySide/Tools/archive/0.2.15.tar.gz \
  pysidetools-0.2.15.tar.gz

getFileWithFallback tbb43_20150611oss_src.tgz https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb43_20150611oss_src.tgz

getFileWithFallback openexr-2.2.0.tar.gz http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz

getFileWithFallback ilmbase-2.2.0.tar.gz http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz

getFileWithFallback ttf-bitstream-vera_1.10.orig.tar.gz http://archive.ubuntu.com/ubuntu/pool/universe/t/ttf-bitstream-vera/ttf-bitstream-vera_1.10.orig.tar.gz

getFileWithFallback glew-1.10.0.tgz \
  "https://downloads.sourceforge.net/project/glew/glew/1.10.0/glew-1.10.0.tgz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fglew%2Ffiles%2Fglew%2F1.10.0%2Fglew-1.10.0.tgz%2Fdownload&ts=1501043354&use_mirror=svwh" \
  glew-1.10.0.tgz

getFileWithFallback OpenColorIO-1.0.9.tar.gz \
  https://github.com/imageworks/OpenColorIO/archive/v1.0.9.tar.gz \
  OpenColorIO-1.0.9.tar.gz

getFileWithFallback OpenColorIO-Configs-1.0_r2.tar.gz \
  http://github.com/imageworks/OpenColorIO-Configs/archive/v1.0_r2.tar.gz \
  OpenColorIO-Configs-1.0_r2.tar.gz

getFileWithFallback oiio-1.5.11.tar.gz \
  https://github.com/OpenImageIO/oiio/archive/Release-1.5.11.tar.gz \
  oiio-1.5.11.tar.gz

getFileWithFallback hdf5-1.8.11.tar.gz https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.11/src/hdf5-1.8.11.tar.gz

getFileWithFallback numpy-1.9.2.tar.gz \
  "https://downloads.sourceforge.net/project/numpy/NumPy/1.9.2/numpy-1.9.2.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fnumpy%2Ffiles%2FNumPy%2F1.9.2%2Fnumpy-1.9.2.tar.gz%2Fdownload&ts=1501045534&use_mirror=svwh" \
  numpy-1.9.2.tar.gz

getFileWithFallback pyilmbase-2.2.0.tar.gz http://download.savannah.nongnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz

getFileWithFallback alembic-1.5.8.zip https://github.com/alembic/alembic/archive/1.5.8.zip alembic-1.5.8.zip

getFileWithFallback double-conversion-1.1.5.tar.gz https://github.com/google/double-conversion/archive/v1.1.5.tar.gz double-conversion-1.1.5.tar.gz

getFileWithFallback ptex-2.0.41.tar.gz \
  http://github.com/wdas/ptex/archive/v2.0.41.tar.gz \
  ptex-2.0.41.tar.gz

getFileWithFallback glfw-3.2.1.zip https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip

getFileWithFallback OpenSubdiv-3_1_0.tar.gz \
  https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_1_0.tar.gz \
  OpenSubdiv-3_1_0.tar.gz

getFileWithFallback jemalloc-4.3.1.tar.bz2 \
  https://github.com/jemalloc/jemalloc/releases/download/4.3.1/jemalloc-4.3.1.tar.bz2 \
  jemalloc-4.3.1.tar.bz2

getFileWithFallback MarkupSafe-0.23.tar.gz https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.23.tar.gz

getFileWithFallback Jinja2-2.8.tar.gz https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.8.tar.gz
