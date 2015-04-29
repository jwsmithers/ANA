
import os, sys
__path__ = [d for d in [os.path.join(d, 'GaudiMP') for d in sys.path if d]
            if os.path.exists(d) or 'python.zip' in d]
# File: GaudiMP/__init__.py
# Author: the gaudi-mp team

"""
   GaudiMP main module.
   It makes available a number of APIs and classes to be used by end user scripts

   Usage:
      import GaudiMP
"""
