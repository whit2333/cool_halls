Cool (A/C) Halls software super build
=====================================

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/1189)
[![Docker ](https://img.shields.io/badge/hosted-docker--hub-blue.svg)](https://hub.docker.com/r/whit2333/cool_halls/)


```
git clone  https://github.com/whit2333/cool_halls.git
mkdir cool_halls/build && cd cool_halls/build
cmake ../. -DCMAKE_INSTALL_PREFIX=$HOME -DUSE_CONTAIENRS=ON
make
```
Note `make install` is not needed



