#!/bin/bash
wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-11.4.0/gcc-11.4.0.tar.gz
tar xzvf gcc-11.4.0.tar.gz
cd gcc-11.4.0
./contrib/download_prerequisites
cd ..
mkdir objdir
cd objdir
$PWD/../gcc-11.4.0/configure --disable-multilib --enable-languages=c,c++
make -j $(nproc)
make install
