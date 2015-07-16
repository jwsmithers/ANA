#!/bin/sh
cd ~/ANA/$VERSION/AtlasReconstruction/$VERSION/External/AtlasShowerDeconstruction
mv src src~
mkdir src ; cd src
mkdir lib ; mkdir include
cd lib ; cp /home/seuster/SD-tosvn/.libs/*.so .
cd ../include ; cp /home/seuster/SD-tosvn/*.h . 
