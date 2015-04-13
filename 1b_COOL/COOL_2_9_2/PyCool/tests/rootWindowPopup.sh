#! /bin/bash

# The ROOT window does popup
#export ROOTSYS="\\\\afs\\all\\cern.ch\\sw\\lcg\\external\\root\\5.10.00d\\win32_vc71\\root"

# The ROOT window does NOT popup
export ROOTSYS="\\\\afs\\all\\cern.ch\\sw\\lcg\\external\\root\\5.11.02\\win32_vc71\\root"

export PATH="${ROOTSYS}\\bin"

export PYTHONPATH="${ROOTSYS}\\bin"

/afs/cern.ch/sw/lcg/external/Python/2.4.2/win32_vc71/python -c 'import PyCintex'
