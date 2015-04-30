
import os, sys
__path__ = [d for d in [os.path.join(d, 'GaudiPython') for d in sys.path if d]
            if (d.startswith('/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt') or
                d.startswith('/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1')) and
               (os.path.exists(d) or 'python.zip' in d)]
# File: GaudiPython/__init__.py
# Author: Pere Mato (pere.mato@cern.ch)

"""
   GaudiPython main module.
   It makes available a number of APIs and classes to be used by end user scripts

   Usage:
      import GaudiPython
"""

# ensure that we (and the subprocesses) use the C standard localization
import os
if os.environ.get('LC_ALL') != 'C':
    print '# setting LC_ALL to "C"'
    os.environ['LC_ALL'] = 'C'

from Bindings import *
from Pythonizations import *
