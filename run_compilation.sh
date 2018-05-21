#!/bin/bash

export WORKING_DIR=$PWD
export LINARO_GZ=$WORKING_DIR/linaro.tar.gz
export LINARO_BINARY=$WORKING_DIR/binary

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=$WORKING_DIR/u-boot-xlnx/tools/:$PATH

# Download repos
git submodule init
wget -O $LINARO_GZ https://releases.linaro.org/debian/images/developer-armhf/latest/linaro-stretch-developer-20170706-43.tar.gz

# Working directories for outputs
mkdir -p xeno3_build
mkdir -p xeno3_zynq_stage
mkdir -p zynq_modules
mkdir -p SDCard

#export dei percorsi directory
export UBOOT=$PWD/u-boot-xlnx
export XENO_HOME=$PWD/xenomai-3
export LINUX_HOME=$PWD/ipipe-arm
export XIL_LINUX=$PWD/linux-xlnx
export XENO_BUILD=$PWD/xeno3_build
export XENO_ZYNQ_STAGE=$PWD/xeno3_zynq_stage
export ZYNQ_MODULES=$PWD/zynq_modules
export SDCARD=$PWD/SDCard

echo "Going to compile u-boot..."
# compilazione di u-boot
cd $UBOOT
git apply ../u-boot-no-ramdisk-sdcard.patch
make zynq_zybo_config
make -j 2 u-boot.elf
cp u-boot.elf $SDCARD
cd $WORKING_DIR

echo "Going to patch the Kernel source code and compile it..."

# patching del kernel
cp $XIL_LINUX/arch/arm/configs/xilinx_zynq_defconfig $LINUX_HOME/arch/arm/configs/
$XENO_HOME/scripts/prepare-kernel.sh --linux=$LINUX_HOME --arch=arm --verbose
cd $LINUX_HOME
make xilinx_zynq_defconfig
cp ../.config ./
make
make UIMAGE_LOADADDR=0x8000 uImage modules
make modules_install INSTALL_MOD_PATH=$ZYNQ_MODULES
cp $LINUX_HOME/arch/arm/boot/uImage $SDCARD

echo "Going to configure Xenomai libraries..."
# compilazione della libreria XENOMAI
cd $XENO_HOME
git checkout tags/v3.0.6 -b xenomai_3.0.6
./scripts/bootstrap
cd $XENO_BUILD
$XENO_HOME/configure CFLAGS="-march=armv7-a -mfpu=vfp3 -mfloat-abi=hard" LDFLAGS="-march=armv7-a" --build=x86_64-pc-linux-gnu --host=arm-none-linux-gnueabi --with-core=cobalt --enable-smp --enable-tls CC=arm-linux-gnueabihf-gcc LD=arm-linux-gnueabihf-ld
make DESTDIR=$XENO_ZYNQ_STAGE install

echo "Going to extract the Linaro filesystem..."

# preparazione del filesystem
cd $WORKING_DIR
sudo tar -xzf $LINARO_GZ

echo "Compilation succeeds"

