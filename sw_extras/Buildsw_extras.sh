#!/bin/sh
setuptools=setuptools-15.1
eigen=Eigen-3.2.4
geant4=geant4.9.6.p04
readline=readline-6.2.4.1

# Eigen install- all that's required is an untar.
#cd $SW_Extras
#tar -xvf ${eigen}.tar.gz
#mv eigen-eigen-10219c95fe65 eigen
#
## Python Install
#cd $SW_Extras
#tar -xvf ${setuptools}.tar.gz
#mv setuptools-15.1 setuptools
#cd setuptools
#$LCG_install/Python/2.7.6/$CMTCONFIG/bin/python setup.py install
#
## Needs a python install
#cd $SW_Extras
#tar -xvf ${readline}.tar.gz
#mv readline-6.2.4.1 readline
#cd readline
#$LCG_install/Python/2.7.6/$CMTCONFIG/bin/python setup.py install

# Installs using cmake
cd $SW_Extras
#tar -xvf ${geant4}.tar.gz
#mv geant4.9.6.p04 geant4
#mkdir geant4_build
#mkdir geant4_install
#cd geant4_build
#cmake -DCMAKE_INSTALL_PREFIX=../geant4_install ../geant4

# yampl
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$LCG_install/uuid/1.42/$CMTCONFIG/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LCG_install/uuid/1.42/$CMTCONFIG/lib
cd $SW_Extras/yampl
mkdir ../yampl_install
./configure --prefix=$SW_Extras/yampl_install
make 
make install


