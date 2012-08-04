#!/bin/sh

# adapted from http://code.google.com/p/osx-launchpad/source/browse/build.sh
# to build using MacPorts and install via GNU Stow

set -e

# Force root
if [ $EUID -ne 0 ]; then
  echo "You must be root"
  exit 1
fi

: <<ENDREM
Use these to wrap around code you want to comment out, in case some
step failed and you want to resume execution at some point.
ENDREM

# Download mspgcc4 patches
wget http://sourceforge.net/projects/mspgcc/files/latest/download?source=files -O mspgcc.tar.bz2
tar xjf mspgcc.tar.bz2
TOOLCHAIN_VERSION=$(ls | grep mspgcc- | awk -F '-' '{print $2 }')
STOW_PREFIX=/stow
STOW_REPO=$STOW_PREFIX/repository
PREFIX=$STOW_REPO/mspgcc-$TOOLCHAIN_VERSION

if [ -d $PREFIX ]; then
	echo "[ERROR] $PREFIX already exists!"
	exit 1
fi

# Add new gcc to path
export PATH=$PREFIX/bin:$PATH

# Install binutils
BINUTILS_VERSION=$(ls mspgcc-$TOOLCHAIN_VERSION | grep binutils | sed -e 's/.patch$//g' | awk -F '-' '{print $3 }')
BINUTILS_DIR_VERSION=${BINUTILS_VERSION%[a-zA-Z]}
BINUTILS_TOOLCHAIN_VERSION=$(ls mspgcc-$TOOLCHAIN_VERSION | grep binutils | sed -e 's/.patch$//g' | awk -F '-' '{print $4 }')
wget ftp://ftp.gnu.org/pub/gnu/binutils/binutils-$BINUTILS_VERSION.tar.bz2
tar xjf binutils-$BINUTILS_VERSION.tar.bz2
cd binutils-$BINUTILS_DIR_VERSION
patch -p1 < ../mspgcc-$TOOLCHAIN_VERSION/msp430-binutils-$BINUTILS_VERSION-$BINUTILS_TOOLCHAIN_VERSION.patch
cd ..
mkdir -p BUILD/binutils
cd BUILD/binutils
../../binutils-$BINUTILS_DIR_VERSION/configure \
  --target=msp430 \
  --prefix=$PREFIX
make
make install
cd ../..

# Install gcc
GCC_VERSION=$(ls mspgcc-$TOOLCHAIN_VERSION | grep gcc | sed -e 's/.patch$//g' | awk -F '-' '{print $3 }')
GCC_DIR_VERSION=${GCC_VERSION%[a-zA-Z]}
GCC_TOOLCHAIN_VERSION=$(ls mspgcc-$TOOLCHAIN_VERSION | grep gcc | sed -e 's/.patch$//g' | awk -F '-' '{print $4 }')
wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2
tar xjf gcc-$GCC_VERSION.tar.bz2
cd gcc-$GCC_DIR_VERSION
patch -p1 < ../mspgcc-$TOOLCHAIN_VERSION/msp430-gcc-$GCC_VERSION-$GCC_TOOLCHAIN_VERSION.patch
cd ..
mkdir -p BUILD/gcc
cd BUILD/gcc
../../gcc-$GCC_DIR_VERSION/configure \
  --target=msp430 \
  --enable-languages=c,c++ \
  --prefix=$PREFIX \
  --with-mpc=/opt/local \
  --with-gmp=/opt/local \
  --with-mpfr=/opt/local
make
make install
cd ../..

# Install gdb
GDB_VERSION=$(ls mspgcc-$TOOLCHAIN_VERSION | grep gdb | sed -e 's/.patch$//g' | awk -F '-' '{print $3 }')
GDB_DIR_VERSION=${GDB_VERSION%[a-zA-Z]}
GDB_TOOLCHAIN_VERSION=$(ls mspgcc-$TOOLCHAIN_VERSION | grep gdb | sed -e 's/.patch$//g' | awk -F '-' '{print $4 }')
wget ftp://ftp.gnu.org/pub/gnu/gdb/gdb-$GDB_VERSION.tar.gz
tar xzf gdb-$GDB_VERSION.tar.gz
cd gdb-$GDB_DIR_VERSION
patch -p1 < ../mspgcc-$TOOLCHAIN_VERSION/msp430-gdb-$GDB_VERSION-$GDB_TOOLCHAIN_VERSION.patch
cd ..
mkdir -p BUILD/gdb
cd BUILD/gdb
../../gdb-$GDB_DIR_VERSION/configure \
  --target=msp430 \
  --prefix=$PREFIX
make
make install
cd ../..

# Install mcu
MCU_VERSION=`cat mspgcc-$TOOLCHAIN_VERSION/msp430mcu.version`
wget http://sourceforge.net/projects/mspgcc/files/msp430mcu/msp430mcu-$MCU_VERSION.tar.bz2
tar xjf msp430mcu-$MCU_VERSION.tar.bz2
cd msp430mcu-$MCU_VERSION
export MSP430MCU_ROOT=`pwd`
sh scripts/install.sh $PREFIX
cd ..

# Install libc
LIBC_VERSION=`cat mspgcc-$TOOLCHAIN_VERSION/msp430-libc.version`
wget http://sourceforge.net/projects/mspgcc/files/msp430-libc/msp430-libc-$LIBC_VERSION.tar.bz2
tar xjf msp430-libc-$LIBC_VERSION.tar.bz2
cd msp430-libc-$LIBC_VERSION
./configure --prefix=$PREFIX
cd ..
cd msp430-libc-$LIBC_VERSION/src
rm -rf Build
make
make install
cd ../..

# Install mspdebug
wget http://sourceforge.net/projects/mspdebug/files/latest/download?source=files -O mspdebug.tar.gz
tar xvf mspdebug.tar.gz
MSPDEBUG_VERSION=$(ls | grep mspdebug- | awk -F '-' '{print $2 }')
MSPDEBUG_DIR_VERSION=${MSPDEBUG_VERSION%[a-zA-Z]}
cd mspdebug-$MSPDEBUG_DIR_VERSION
make
make PREFIX=$PREFIX install
cd ..
