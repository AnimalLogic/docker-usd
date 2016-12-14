# USD in a Docker Container!

In this repository you will find a set of docker build scripts which will
download all the Open Source packages required to build Pixar's
Universal Scene Description, as well as USD itself.

If you are running a linux supported by nvidia-docker you can also run usdview
interactively using the run.sh script, including CUDA acceleration for OpenSubdiv.
Otherwise you can still use most tools such as usdcat.

The image tagged "usd-docker/vfx:centos7-usd-0.7" will be very similar to a VFX Platform 2016
except for the Qt version still being at 4.8 as USD doesn't support Qt-5 just yet.

The image tagged "usd-docker/usd:centos7-usd-0.7.2" is built from the vfx one and adds
USD 0.7.2.

The centos-6 image takes about one hour to build and creates a 5GB image, the
centos-7 image is faster to build and is about 4GB.

We will not release pre-built images on Docker Hub for now as they are big and
will contain dozens of OSS packages with very different licenses.


To build locally:
```bash
cd linux
./build-centos7.sh
```

To run usdview once built:
```bash
./run.sh  usdview /opt/usd/share/usd/tutorials/authoringProperties/HelloWorld.usda
```

## Roadmap
At this stage this repository is just a prototype and we are sharing it
because it might help others when building USD.

This repository can also help evaluate USD as it makes all USD tools available
within the docker container, these include usdview (with full GL and CUDA acceleration)
and usdcat with Alembic support.

## Goals
The main goal of this work at this stage is technology exploration, it is good to
see the progress done by docker and nvidia on supporting GPU acceleration in
containers.

One potential future goal could be to provide standard ways to build VFX Platform packages.

## Build requirements
For easiest build you need a recent version of linux with Docker-1.9 and
nvidia-docker.
If you are on a platform not supported by docker-1.9 (such as CentOS-6) you can
still build the images but running them is a lot trickier as nvidia-docker is
not available and you have to manually create the volume containing the NVidia driver.

The builds have been tested on CentOS-6 and Ubuntu-14-10.

## Credits:
* For USD: http://openusd.org
* For Docker: https://www.docker.com/
* For the GPU-enabled docker base images: https://github.com/NVIDIA/nvidia-docker
* For the VFX Platform docker build inspiration: https://github.com/EfestoLab/docker-buildGaffer
