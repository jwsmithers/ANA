#!/bin/bash
cd /usr/bin; sudo ln -s gcc lcg-gcc-4.9.2; sudo ln -s g++ lcg-g++-4.9.2
goHome
cd /usr/lib; sudo ln -s $LCG_install/clhep/1.9.4.7/$CMTCONFIG/lib/* .
goHome
cd /usr/bin; sudo ln -s gfortan lcg-gfortran-4.9.0;sudo ln -s gfortan lcg-gfortran-4.9.1;sudo ln -s gfortan lcg-gfortran-4.9.2
##Boost ln of librariess should be in here?
