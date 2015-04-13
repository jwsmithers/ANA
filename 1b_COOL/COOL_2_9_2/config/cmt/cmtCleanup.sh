#! /bin/bash
relTop=`dirname $0`
relTop=`cd ${relTop}/../../..; pwd`
#echo "Release top is ${relTop}"
if [ "$1" == "build" ]; then
    echo "Remove all build directories"
    set -x
    cd ${relTop}
    \rm -rf slc* osx* win*
    cd ${relTop}/src
    \rm -rf */slc* */osx* */win*
    cd ${relTop}/src/Utilities
    \rm -rf */slc* */osx* */win*
    if [ -d ${relTop}/src/CoralServerPrototype ]; then
        cd ${relTop}/src/CoralServerPrototype
        \rm -rf */slc* */osx* */win*
    fi
elif [ "$1" == "config" ]; then
    echo "Remove all makefile fragments"
    set -x
    cd ${relTop}/src
    \rm -rf */cmt/*make*
    \rm -rf */*/cmt/*make*
else
    echo "Usage: `basename $0` config|build"
    exit 1
fi
