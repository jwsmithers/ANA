#!/usr/bin/env python
import sys

# import C++ <-> Python interface
try:
    # ROOT5
    import PyCintex
    # Auto-load PyCoolDict.so using ROOT5 rootmaps
    PyCintex.gbl.cool.IDatabase
except ImportError:
    try:
        # ROOT6
        import cppyy as PyCintex
        sys.modules['PyCintex'] = PyCintex
    except:
        raise RuntimeError("ERROR! could not import PyCintex (ROOT5) nor cppyy (ROOT6)")
    # Manually load PyCoolDict.so in ROOT6 (bug #103298 - empty selection.xml)
    import ROOT
    ROOT.gSystem.Load("liblcg_PyCoolDict.so")
 
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
