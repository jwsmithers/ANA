#!/bin/bash
cd /usr/bin; sudo ln -s gcc lcg-gcc-4.9.2; sudo ln -s g++ lcg-g++-4.9.2
goHome
cd /usr/lib; sudo ln -s $LCG_install/clhep/1.9.4.7/$CMTCONFIG/lib/* .
goHome

##Boost ln of librariess should be in here?
