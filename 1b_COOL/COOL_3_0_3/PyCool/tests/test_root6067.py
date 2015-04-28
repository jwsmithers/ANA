from PyCool import coral
al=coral.AttributeList()
al.extend( "i", "int" )
al.extend( "s", "string" )
al.extend( "uc", "unsigned char" )
al.extend( "b", "bool" )
print "AL is", al
print "AL[b] is", al["b"]
al["i"] = 1
al["s"] = '1'
al["uc"] = '1'
al["b"] = True
print "AL is", al
print "AL[b] is", al["b"]

