"""
PyCool internal module. Defines utility functions.
"""

#######################################################################
# 64 bit architecture discovery
from sys import platform
def is_64bits():
    """
    Tells if the current machine is a 64 bits machine.
    Windows and OSX are considered 'by definition' 32 bits.
    (On OSX the 'SC_LONG_BIT' variable is not defined)
    """
    if platform[:3] in [ 'win', 'dar' ]:
        return False
    else:
        from os import sysconf
        return sysconf('SC_LONG_BIT') == 64

def getRootVersion():
    """
    Returns the version of ROOT as tuple:
    5.18/00d -> (5,18,0,'d')
    5.20/01  -> (5,20,1,None)
    """
    import re
    import PyCintex
    v = PyCintex.gbl.gROOT.GetVersion()
    m = re.match(r"(\d+)\.(\d+)/(\d+)([a-z])?", v)
    if m:
        result = tuple(map(int,m.groups()[:3]) + [m.groups(4)])
    else:
        result = (0,0,0,None) # unknown
    return result
