# rmgateway-elastel

Script and toolchain file to build macchina.io REMOTE Gateway for Elastel devices.

## Prerequisites

  - The Elastel toolchain (`gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar`)
  - Ubuntu 20.04 (or newer)
  - [CMake](https://cmake.org)
  - [Ninja](https://ninja-build.org)
  - Git


## Install Required Packages

```
sudo apt update && sudo apt install -y git cmake ninja-build
```

## Extract Elastel Toolchain

```
tar xf gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar
```

## Clone this Repository

```
git clone https://github.com/obiltschnig/rmgateway-elastel.git
```

NOTE: the `rmgateway-elastel` and `gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu`
directories must be next to each other in the same directory.

## Download and Build 

The `build-gateway.sh` script will download the OpenSSL sources, as well as
the macchina.io REMOTE SDK and macchina.io REMOTE Gateway sources and then
build everything using the cross-compiling toolchain.

```
cd rmgateway-elastel
./build-gateway.sh
```

The `rmgateway` executable will be in the `cmake-build/gateway` directory.
