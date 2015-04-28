#!/usr/bin/env python
import sys

# import C++ <-> Python interface: 
# - PyCintex exists in ROOT5, but not in ROOT6
# - cppyy exists in ROOT6 and also in ROOT >= 5.34.11, but not in <= 5.34.10
# NB in both cases, use PyCintex (by redefining "PyCintex = cppyy" if missing)
# NB 'import PyCintex' is also used in other PyCool files (e.g. definitions.py)
try:
    # this should succeed on ROOT5; but this will also succeed on ROOT6
    # if PyCintex has already been defined as cppyy (e.g. by ATLAS python)
    import PyCintex
except ImportError:
    try:
        # possibly ROOT6 (or a broken ROOT5 with missing PyCintex?)
        import cppyy
        # ok this is ROOT6: redefine PyCintex in any case so that you can use
        # it here below and import it elsewhere in PyCool (e.g. definitions.py)
        sys.modules['PyCintex'] = PyCintex = cppyy
        # NB if someone else (ATLAS?) has defined PyCintex elsewhere, the
        # 'import cppyy' above will not be executed: hence always use PyCintex 
        # and do not attempt to import cppyy and redefine PyCintex yourself...
    except:
        raise RuntimeError("ERROR! neither PyCintex nor cppyy were found")

# use gROOT.GetVersion() to distinguish between ROOT5/6 (CORALCOOL-2732)
# [eventually move to cppyy.get_version() if cppyy.gbl.gROOT is removed]
if PyCintex.gbl.gROOT.GetVersion()[0] == '5' :
    # this is ROOT5: auto-load PyCoolDict.so using ROOT5 rootmaps
    PyCintex.gbl.cool.IDatabase
else:
    # this is ROOT6: manually load COOL libraries and headers
    # (use PyCintex instead of cppyy to fix the ATLAS use case CORALCOOL-2731)
    PyCintex.gbl.gSystem.Load('liblcg_CoolApplication.so')
    import os
    include_line = '#include "%s"' % os.path.join(os.path.dirname(__file__), '_internal', 'PyCool_headers_and_helpers.h')
    if not PyCintex.gbl.gInterpreter.Declare(include_line): # see ROOT-5698
        raise RuntimeError("ERROR! Could not include PyCool headers")

# expose only few symbols when loaded with "import *"
__all__ = [ 'coral', 'cool', 'walk' ]

# expose namespaces
cool  = PyCintex.gbl.cool
coral = PyCintex.gbl.coral

# special operations
from _internal import instrumentation
instrumentation.all()

# import platform utilities
from _internal.utilities import is_64bits, getRootVersion

# delete temporary names that should not be seen by users
del instrumentation
del _internal
del sys

class walk:
    """
    Iterator to walk through the hierarchy of a COOL database.
    It mimics the function os.walk, but the navigation cannot
    be modified changing in place the returned directories.

    Example:
        for root, foldersets, folders in PyCool.walk(db,'/'):
            ...
    """
    def __init__(self,db,top="/"):
        """
        Construct a new iterator instance.
        db has to be a COOL database instance, and top is the FolderSet
        path where to start the navigation.
        """
        self.db = db
        self.dirs = [ top ]
    def __iter__(self):
        return self
    def next(self):
        if self.dirs:
            # get next folderset to process
            root = self.dirs.pop()
            fs = self.db.getFolderSet(root)
            # get list of contained foldersets in reversed alfabetical order
            dirs = [ f for f in fs.listFolderSets(False) ]
            # prepend the found foldersets to the list of foldersets to process
            self.dirs = dirs + self.dirs

            # get the legnth of the part of the name to strip
            if root == '/':
                to_remove = 1
            else:
                to_remove = len(root)+1
            # sort alfabetically the foldersets and leave the FolderSet name
            dirs.sort()
            dirs = [  d[to_remove:] for d in dirs ]
            # get the list of folders and leave only the Folder name
            files = [ f[to_remove:] for f in fs.listFolders() ]
            return (root, dirs, files)
        else:
            # we do not have any other folderset to process
            raise StopIteration()
