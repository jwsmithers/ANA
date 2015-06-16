#!/bin/sh
cd ~/ANA/rel_6/AtlasReconstruction/rel_6/External/AtlasShowerDeconstruction
mv src src~
mkdir src ; cd src
mkdir lib ; mkdir include
cd lib ; cp /home/seuster/SD-tosvn/.libs/*.so .
cd ../include ; cp /home/seuster/SD-tosvn/*.h . 
