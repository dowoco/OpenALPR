#!/bin/bash

set -e

# Create a log file of the build as well as displaying the build on the tty as it runs
exec &> >(tee build_alpr_pi.log)
exec 2>&1

#Install the dependencies
apt-get update
apt-get install -y autoconf automake libtool libleptonica-dev libicu-dev libpango1.0-dev 
apt-get install -y libcairo2-dev cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev
apt-get install -y libswscale-dev python-dev python-numpy python3-numpy libpng-dev libtiff-dev libdc1394-22-dev
apt-get install -y virtualenvwrapper liblog4cplus-dev libcurl4-openssl-dev unzip oracle-java8-jdk python-pip make gcc

#Install the Dependancies for Tesseract
apt-get install -y ca-certificates git
apt-get install -y autoconf automake libtool
apt-get install -y autoconf-archive

#Install Libraries for Tesseract Training
apt-get install -y libicu-dev
apt-get install -y libpango1.0-dev

#Install the Dependancies for Leptonica
apt-get install -y libjpeg-dev libtiff5-dev libpng-dev

apt-get update

#set the environment JAVA_HOME variable
export JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/

#Install Leptonica
cd /usr/src
wget http://www.leptonica.org/source/leptonica-1.75.3.tar.gz
tar xf leptonica-1.75.3.tar.gz
cd /usr/src/leptonica-1.75.3
./configure
make
make install

#Install Tesseract
cd /usr/src
git clone https://github.com/tesseract-ocr/tesseract.git
echo **"MSG**: Trying to tesseract...."
sleep 3
cd /usr/src/tesseract
git tag
git checkout 3.05.00
./autogen.sh
./configure --enable-debug
make
make install
ldconfig

#Install OpenCV
cd /usr/src
wget https://github.com/opencv/opencv/archive/3.4.0.zip
unzip 3.4.0.zip
echo **"MSG**: Trying to opencv-3.4.0...."
sleep 5
cd /usr/src/opencv-3.4.0
mkdir release
cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D JAVA_INCLUDE_PATH2=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/include -D JAVA_AWT_INCLUDE_PATH=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/jre/lib/arm/libawt.so -D JAVA_JVM_LIBRARY=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/jre/lib/arm/server/libjvm.so ..
make  
make install

#Install OpenALPR
cd /usr/src
git clone https://github.com/openalpr/openalpr.git
cd openalpr/src
mkdir build  
cd /usr/src/openalpr/src/build  
cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr -D CMAKE_INSTALL_SYSCONFDIR:PATH=/etc -D OpenCV_DIR=/usr/src/opencv-3.4.0/release ..  
make  
make install
ldconfig

wget http://plates.openalpr.com/h786poj.jpg -O lp.jpg
alpr lp.jpg
