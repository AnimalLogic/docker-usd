# USD in a Docker Container

This repository contains a build script for a minimal linux docker container with USD.

To build locally:
```bash
cd linux
./build-centos7-lite.sh
```

To run:
```bash
docker run --rm -v $HOME:$HOME dockerusd/usd-lite:20.08-centos7 usdtree $HOME/Downloads/Kitchen_set/Kitchen_set.usd

# ->
#/
# `--Kitchen_set [def Xform] (kind = assembly)
#     |--Arch_grp [def Xform] (kind = group)
#     |   `--Kitchen_1 [def]
#     `--Props_grp [def Xform] (kind = group)
#...
```

## Goals
Most of the previously available docker images are now available in the newer and more regularly maintained [ASWF docker images](https://github.com/AcademySoftwareFoundation/aswf-docker).

This repository now contains minimal images that can help running USD inside VSCode or in Jupyter notebooks.

## Build requirements
For easiest build you need a recent version of linux with Docker-1.9.

## Credits:
* For USD: http://openusd.org
* For Docker: https://www.docker.com/
* For ASWF docker packages: https://github.com/AcademySoftwareFoundation/aswf-docker
