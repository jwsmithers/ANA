#!/bin/sh

# run this script inside PyCool/doc

PyCool_dir=../python/PyCool

pydoc -w PyCool

for pyfile in $PyCool_dir/*.py; do
    base=${pyfile##*/}
    pydoc -w PyCool.${base/.py}
done

