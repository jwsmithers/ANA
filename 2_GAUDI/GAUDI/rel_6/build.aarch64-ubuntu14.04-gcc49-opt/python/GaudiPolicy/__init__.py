
import os, sys
__path__ = [d for d in [os.path.join(d, 'GaudiPolicy') for d in sys.path if d]
            if (d.startswith('/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1/build.aarch64-ubuntu14.04-gcc49-opt') or
                d.startswith('/home/jwsmith/ANA/2_GAUDI/Gaudi-26r1')) and
               (os.path.exists(d) or 'python.zip' in d)]
