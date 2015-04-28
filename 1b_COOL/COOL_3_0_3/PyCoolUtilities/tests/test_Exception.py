from PyCool import coral
alist = coral.AttributeList()
alist.extend( "i", "int" )
try:
    alist['bad'] # C++ exception raised: no attribute with name 'bad'
except:
    print 'Exception caught'
