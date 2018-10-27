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

RUN yum install -y --setopt=tsflags=nodocs wget make && yum clean all -y

COPY scripts/build_vfx.sh scripts/build_vfx_base.sh scripts/download_vfx.sh /tmp/

# RUN /tmp/download_vfx.sh && \
#     /tmp/build_vfx_base.sh && \
#     /tmp/build_vfx.sh && \
#     rm -Rf $DOWNLOADS_DIR/*

RUN /tmp/download_vfx.sh

# @TODO MERGE IN ONE BUILD COMMAND!
RUN yum install -y perl
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
# build and install Qt
#----------------------------------------------
RUN cd $TMP_DIR && \
    tar -zxf $DOWNLOADS_DIR/Maya-Qt5.6.1-2018.3.tgz && \
    cd $TMP_DIR/src && \
    ./configure \
        -prefix $BUILD_DIR \
        -opensource \
        -confirm-license \
        -no-rpath \
        -nomake examples \
        -I $BUILD_DIR/include \
        -L $BUILD_DIR/lib
RUN cd $TMP_DIR/src && make -j ${BUILD_PROCS}
RUN cd $TMP_DIR/src && make install

# #----------------------------------------------
# # build and install PySide
# #----------------------------------------------
RUN yum install -y cmake python-pip python-setuptools python-devel libxml2-devel libxslt-devel

RUN cd $TMP_DIR &&\
    unzip $DOWNLOADS_DIR/pyside2-maya2018.4.zip &&\
    cd pyside-setup &&\
    python setup.py build &&\
    python setup.py install

CMD bash
