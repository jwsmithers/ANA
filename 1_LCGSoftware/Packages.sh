#!/bin/sh

op_system=$CMTCONFIG
if [[ $op_system =~ .*fc.* ]]
then 
	echo "Fedora operating system identified... checking out using yum package manager"
		sudo yum install libcurl-devel cppunit cmake ant vim html2text python-devel gcc git make gcc-c++ gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel gcc-gfortran openssl-devel pcre-devel mesa-libGL-devel glew-devel ftgl-devel mysql-devel fftw-devel cfitsio-devel graphviz-devel avahi-compat-libdns_sd-devel libldap-dev libxml2-devel gsl-static gcc-plugin-devel qt-devel boost-devel subversion oracle java procmail binutils-arm-linux-gnu gcc-arm-linux-gnu gcc-c++-arm-linux-gnu patch ncurses-devel bzip2-devel libxslt-devel boxes libunwind-devel binutils-devel readline-devel log4j dSFMT-devel

fi

if [[ $op_system =~ .*ubuntu.* ]]
then	
	echo "Ubuntu operating system identified... checking out using apt-get package manager"
	sudo apg-get install libcurl-dev libcppunit-dev cmake ant vim html2text python-dev gcc git make gcc-c++ gcc binutils libX11-dev libXpm-dev libXft-dev libXext-dev gcc-gfortran openssl-dev pcre-dev mesa-libGL-dev glew-dev ftgl-dev mysql-dev fftw-dev cfitsio-dev graphviz-dev avahi-compat-libdns_sd-dev libldap-dev libxml2-dev gsl-static gcc-plugin-dev qt-dev boost-dev subversion oracle java procmail binutils-arm-linux-gnu gcc-arm-linux-gnu gcc-c++-arm-linux-gnu patch ncurses-dev bzip2-dev libxslt-dev boxes libunwind-dev binutils-dev readline-dev log4j dSFMT-dev
	
fi	
	
