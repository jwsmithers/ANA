
import os, sys
__path__ = [d for d in [os.path.join(d, 'GaudiProfiling') for d in sys.path if d]
            if os.path.exists(d) or 'python.zip' in d]
