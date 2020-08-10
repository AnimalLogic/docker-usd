# USD in a Docker Container

This repository contains build scripts for minimal linux docker container with USD.

## usd-lite

### To run:
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

It can be used as a provider for `usdcat` and `usdresolve` for the `AL_usd_vscode_extension` VSCode extension, just use these settings:
```
# usdcat which exposes the whole $HOME folder to the docker container
docker run --rm -v ${HOME}:${HOME} usd-docker/usd-lite:20.08-centos7 usdcat --usdFormat usda "{inputPath}"
# usdresolve which exposes the whole $HOME folder to the docker container
docker run --rm -v ${HOME}:${HOME} usd-docker/usd-lite:20.08-centos7 usdresolve --anchorPath "{anchorPath}" "{inputPath}"
```

### To build locally:
```bash
cd linux
./build-centos7-lite.sh
```

## usd-jupyter
### To run:
First place the USD files you wish to inspect in a folder called `work` in your home directory.

```bash
docker run -it --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v ~/work:/home/jovyan/work dockerusd/usd-jupyter
# Then click on the printed url in the console to open the Jupyter notebook in your browser
```
See this example Jupyter notebook file: [USDBasics.ipynb](./USDBasics.ipynb) which can open the Pixar Kitchen Set USD file and
inspect the content interactively. To try this download the [Pixar Kitchen Set](http://graphics.pixar.com/usd/downloads.html) in the `work` folder, copy the `USDBasics.ipynb` in the folder alongside the `Kitchen_set.usd` file and open that notebook.

### To build locally:
```bash
cd linux
./build-jupyter.sh
```
# Goals
Most of the previously available docker images are now available in the newer and more regularly maintained [ASWF docker images](https://github.com/AcademySoftwareFoundation/aswf-docker).

This repository now contains minimal images that can help running USD inside VSCode or in Jupyter notebooks.

# Build requirements
For easiest build you need a recent version of linux with Docker-1.9, navigate to the "linux" folder and run the `build-XYZ.sh` scripts.

# Credits:
* For USD: http://openusd.org
* For Docker: https://www.docker.com/
* For ASWF docker packages: https://github.com/AcademySoftwareFoundation/aswf-docker
