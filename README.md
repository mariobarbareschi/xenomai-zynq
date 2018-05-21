[![](https://images.microbadger.com/badges/image/mariobarbareschi/xenomai-zynq.svg)](https://microbadger.com/images/mariobarbareschi/xenomai-zynq "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/mariobarbareschi/xenomai-zynq.svg?branch=master)](https://travis-ci.org/mariobarbareschi/xenomai-zynq)
# Xenomai-Zynq
This is a script automation project for compiling Xenomai on a Zynq-7000 FPGA that makes use of a Docker image

## Getting started
Be sure to have installed the last [Docker]. This project will give to you an uncompressed Xenomai and an u-boot images intended to be load onto a Zynq-7000 device.
Clone this repo by executing:
```sh
$ git clone https://github.com/darkiaspis/linux-switch-docker.git
```

## X-Compiling
Actually, the docker image is used for compiling by arm-gcc toolchains. The whole commands you need are included in run_compilation.sh file. So just be sure that the current repository is cloned onto your pc host, then:
```sh
$ cd xenomai-zynq
$ docker pull dark1asp1s/linux-switch-docker
$ docker run -it -v $PWD:/opt mariobarbareschi/xenomai-zynq /bin/bash -c "cd /opt; ./run_compilation.sh"
```

If you don't want to pull the image from the [Docker] hub, you can get it by your own:

```sh
$ cd linux-switch-docker
$ docker build -t <image-name> .
```

---------
### LICENSE
* [GPLV3.0](https://www.gnu.org/licenses/licenses.html)
### Contributing
Github is for social coding.
If you want to write code, I encourage contributions through pull requests from forks of this repository.

#### Acknowledgment
The main contribution is due to [Salvatore Barone] work.

   [Docker]: <https://docker.com>
   [Salvatore Barone]: <https://github.com/SalvatoreBarone>

