from PyCool import cool
spec = cool.RecordSpecification()
spec.extend( "A_UCHAR", cool.StorageType.UChar )
spec.extend( "A_STRING1", cool.StorageType.String255 )
data = cool.Record(spec)
data['A_UCHAR']=0
data['A_STRING1'] = data['A_UCHAR'].__str__()
print data
data['A_UCHAR']=None
data['A_STRING1'] = data['A_UCHAR'].__str__()
print data
