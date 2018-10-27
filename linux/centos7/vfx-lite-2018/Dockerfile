############################################################
# Dockerfile to build a VFX Platform docker image

FROM centos/devtoolset-7-toolchain-centos7

LABEL maintainer="Aloys.Baillet - Animal Logic"

ARG current_host_ip_address

ENV BUILD_PROCS 7
ENV BUILD_DIR /opt/vfx
ENV TMP_DIR /tmp/vfx-build
ENV DOWNLOADS_DIR /tmp/vfx-downloads
ENV PATH $BUILD_DIR/bin:$PATH
ENV PKG_CONFIG_PATH=$BUILD_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH=$BUILD_DIR/lib64:$BUILD_DIR/lib:$LD_LIBRARY_PATH
ENV PYTHON_SITE_PACKAGES=$BUILD_DIR/lib/python2.7/site-packages
ENV PYTHON_EXECUTABLE=python
ENV PYTHONPATH=$PYTHONPATH:/opt/usd/lib/python:/opt/usd/lib/python/site-packages:/opt/usd/lib64/python/site-packages
ENV HTTP_HOSTNAME=$current_host_ip_address

USER root

RUN yum install -y --setopt=tsflags=nodocs make wget bzip2 which python-devel zlib-devel bzip2-devel && yum clean all -y

COPY scripts/download_vfx-lite-2018.sh /tmp/

RUN /tmp/download_vfx-lite-2018.sh

RUN mkdir -p $TMP_DIR

#----------------------------------------------
# build and install cmake
#----------------------------------------------
RUN cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/cmake-3.12.3.tar.gz &&\
    cd $TMP_DIR/cmake-3.12.3 && \
    ./bootstrap --prefix=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install boost
#----------------------------------------------
RUN cd $TMP_DIR &&\
    tar -jxf $DOWNLOADS_DIR/boost_1_61_0.tar.bz2 &&\
    cd $TMP_DIR/boost_1_61_0 &&\
    ./bootstrap.sh \
        --prefix=$BUILD_DIR &&\
    ./bjam \
        variant=release \
        link=shared \
        threading=multi \
        install

#----------------------------------------------
# build and install TBB
#----------------------------------------------
RUN cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/tbb2017_U6.tar.gz && \
    cd $TMP_DIR/tbb-2017_U6 && \
    make -j ${BUILD_PROCS} && \
    #make tbb_cpf=1 -j ${BUILD_PROCS} && \
    cp build/*_release/*.so* $BUILD_DIR/lib &&\
    cp -R include/* $BUILD_DIR/include/

#----------------------------------------------
# build and install ilmbase
#----------------------------------------------
RUN cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/ilmbase-2.2.0.tar.gz &&\
    cd $TMP_DIR/ilmbase-2.2.0 && \
    ./configure --prefix=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install openexr
#----------------------------------------------
RUN cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/openexr-2.2.0.tar.gz &&\
    cd $TMP_DIR/openexr-2.2.0 && \
    ./configure --prefix=$BUILD_DIR --disable-ilmbasetest && \
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install jemalloc
#----------------------------------------------
RUN cd $TMP_DIR &&\
   tar -xjf $DOWNLOADS_DIR/jemalloc-5.1.0.tar.bz2 &&\
   cd $TMP_DIR/jemalloc-5.1.0 &&\
   ./configure \
      --prefix=$BUILD_DIR && \
    make -j ${BUILD_PROCS} && \
    make install

#----------------------------------------------
# build and install OpenSubdiv
#----------------------------------------------
RUN cd $TMP_DIR &&\
   tar -zxf $DOWNLOADS_DIR/OpenSubdiv-3_3_3.tar.gz && \
   cd $TMP_DIR/OpenSubdiv-3_3_3 && \
   mkdir build && \
   cd build && \
   cmake .. \
      -DCMAKE_INSTALL_PREFIX=$BUILD_DIR \
      -DTBB_LOCATION=$BUILD_DIR \
      -DNO_EXAMPLES=1 \
      -DNO_REGRESSION=1 \
      -DNO_PTEX=1 \
      -DNO_OMP=1 \
      -DNO_OPENCL=1 \
      -DNO_OPENGL=1 \
      -DNO_CLEW=1 \
      -DNO_CUDA=1 \
      -DNO_TUTORIALS=1 && \
    make -j ${BUILD_PROCS} VERBOSE=1 && \
    make install

RUN rm -rf $TMP_DIR

CMD bash
