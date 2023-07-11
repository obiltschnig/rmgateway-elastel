#! /bin/bash

OPENSSL_VERSION=1.1.1u
TOOLCHAIN_DIR=../gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu
CMAKE_TOOLCHAIN_FILE=aarch64-none-linux-gnu.toolchain
CROSS_COMPILE=aarch64-none-linux-gnu-

basedir=`pwd`

# Toolchain
export PATH=$PATH:$basedir/$TOOLCHAIN_DIR/bin

# Get OpenSSL
curl https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz >openssl-$OPENSSL_VERSION.tar.gz
tar xfz openssl-$OPENSSL_VERSION.tar.gz

# Build OpenSSL
cd openssl-$OPENSSL_VERSION
./Configure linux-aarch64 --prefix=$basedir/build/openssl --openssldir=$basedir/build/openssl
make CROSS_COMPILE=$CROSS_COMPILE
make install
cd $basedir


# Get macchina.io REMOTE SDK
git clone https://github.com/my-devices/sdk.git

# Build SDK
mkdir -p cmake-build/sdk && cd cmake-build/sdk
cmake ../../sdk \
	-G Ninja \
	-DCMAKE_TOOLCHAIN_FILE=$basedir/$CMAKE_TOOLCHAIN_FILE \
	-DOPENSSL_ROOT_DIR=$basedir/build/openssl \
	-DOPENSSL_USE_STATIC_LIBS=ON \
	-DENABLE_JSON=ON \
	-DENABLE_PAGECOMPILER=ON \
	-DENABLE_PAGECOMPILER_FILE2PAGE=ON \
	-DENABLE_WEBTUNNELAGENT=OFF \
	-DENABLE_WEBTUNNELCLIENT=OFF \
	-DENABLE_WEBTUNNELSSH=OFF \
	-DENABLE_WEBTUNNELVNC=OFF \
	-DENABLE_WEBTUNNELRDP=OFF \
	-DCMAKE_INSTALL_PREFIX=$basedir/build/sdk
cmake --build . --config Release --target install
cd $basedir

# Get Gateway
git clone https://github.com/my-devices/gateway.git

# Build Gateway
mkdir -p cmake-build/gateway && cd cmake-build/gateway
cmake ../../gateway \
	-G Ninja \
	-DCMAKE_TOOLCHAIN_FILE=$basedir/$CMAKE_TOOLCHAIN_FILE \
	-DOPENSSL_ROOT_DIR=$basedir/build/openssl \
	-DOPENSSL_USE_STATIC_LIBS=ON \
	-DCMAKE_PREFIX_PATH=$basedir/build/sdk
cmake --build . --config Release
${CROSS_COMPILE}strip rmgateway
cd $basedir
