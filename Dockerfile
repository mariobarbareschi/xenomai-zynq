FROM ubuntu:17.10

LABEL maintainer="Mario Barbareschi <mario.barbareschi@unina.it>"
LABEL maintainer="Salvatore Barone <salvator.barone@gmail.com>"

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install git build-essential gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf libssl-dev libncurses-dev bc
