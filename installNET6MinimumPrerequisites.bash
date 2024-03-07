#!/bin/bash
IsMinimumGCCVersionInstalled () {
version=$(gcc --version | awk '/gcc/ && ($3+0)>=(4.8){print "ok"}')
if [ $version == "ok" ]; then
        return 0 #true
else
        return 1 #false
fi
}
#glibc 2.17
glibcversion=$(strings /lib64/libc.so.6 | grep GLIBC_2.17)
if [[ ! $glibcversion == *"GLIBC_2.17"* ]]; then
	echo "Installing 2.17"
	mkdir ~/tmp/glibc
	cd ~/tmp/glibc
	wget --no-check-certificate https://ftp.gnu.org/gnu/glibc/glibc-2.17.tar.gz
	tar -xvf glibc-2.17.tar.gz
	cd glibc-2.17
	mkdir build && cd build
	../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin
	make && make install
else
	echo "Minimum req GLIBC 2.17 or greater = ok"
fi
#minimum GCC 4.8.0: GLIBCXX_3.4.18, CXXABI_1.3.7
if ! IsMinimumGCCVersionInstalled; then 
	wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-4.8.3/gcc-4.8.3.tar.gz
	tar xzf gcc-4.8.3.tar.gz
	cd gcc-4.8.3
	./contrib/download_prerequisites
	cd ..
	mkdir objdir
	cd objdir
	$PWD/../gcc-4.8.3/configure --enable-languages=c,c++ --disable-multilib
	make
	make install
else
	echo "Minimum req GCC version of 4.8.0 or greater = ok"
fi
#also
#export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/usr/local/lib64:/usr/lib64
#export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1