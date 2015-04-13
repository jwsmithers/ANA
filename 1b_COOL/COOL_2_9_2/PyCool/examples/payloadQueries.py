from PyCool import *

###print dir(gbl.cool.PyCool.Helpers)

spec = cool.RecordSpecification()
spec.extend( 'i', cool.StorageType.Int32 )
spec.extend( 'b', cool.StorageType.Bool )
spec.extend( 's', cool.StorageType.String255 )

print "\nCreate Record testData"
data = cool.Record( spec )
data['i'] = 3
data['b'] = True
data['s'] = "Hallo"
print "Created testData:", data

print "\nCreate FieldSelection: 'i(Int32) is NOT NULL'"
fs = cool.FieldSelection('i',cool.StorageType.Int32,cool.FieldSelection.IS_NOT_NULL)
print "Can apply selection to testData:", fs.canSelect(data.specification())
print "Apply selection to testData:", fs.select(data)

print "\nCreate FieldSelection: 'b(Bool) is NULL'"
fs = cool.FieldSelection('b',cool.StorageType.Bool,cool.FieldSelection.IS_NULL)
print "Can apply selection to testData:", fs.canSelect(data.specification())
print "Apply selection to testData:", fs.select(data)

print "\nCreate FieldSelection: 'f(Float) is NULL'"
fs = cool.FieldSelection('f',cool.StorageType.Float,cool.FieldSelection.IS_NULL)
print "Can apply selection to testData:", fs.canSelect(data.specification())

print "\nCreate FieldSelection: 'b(Bool) == True'"
fs = cool.FieldSelection("b",cool.StorageType.Bool,cool.FieldSelection.EQ,True)
print "Can apply selection to testData:", fs.canSelect(data.specification())
print "Apply selection to testData:", fs.select(data)

print "\nCreate FieldSelection: 'i(Int32) > 10'"
fs = cool.FieldSelection("i",cool.StorageType.Int32,cool.FieldSelection.GT,10)
print "Can apply selection to testData:", fs.canSelect(data.specification())
print "Apply selection to testData:", fs.select(data)

try:
    print "\nTry to create FieldSelection: 'b(Bool) == 1.1'"
    fs = cool.FieldSelection("b",cool.StorageType.Bool,cool.FieldSelection.EQ,1.1)
except Exception, e:
    print "Exception caught"
    ###print e

try:
    print "\nTry to create FieldSelection: 'b(Bool) > True'"
    fs = cool.FieldSelection("b",cool.StorageType.Bool,cool.FieldSelection.GT,True)
except Exception, e:
    print "Exception caught"
    ###print e
