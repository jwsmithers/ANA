# Marcin's test for the way ATLAS uses PyCool in ROOT6 (CORALCOOL-2731)
import sys
try:
    import cppyy
    sys.modules['PyCintex'] = PyCintex = cppyy
except ImportError:
    # This test really only makes sense in ROOT6...
    print "WARNING! cppyy was not found, this is probably ROOT5..."
import PyCool
print "OK PyCool was succesfully imported"

