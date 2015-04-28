# Author: Marco Clemencic (with a few changes by Andrea Valassi)

"""
PyCool internal module. Defines the functions used to instrument special
C++ classes and namespaces.
"""

import PyCintex
PyCintex.gbl.cool.IDatabase # force the load of the dictionary (to stay on the safe side)
from PyCintex import gbl, getAllClasses

def all():
    coral_Attribute()
    coral_AttributeList()
    coral_Blob()
    cool_IRecordSpecification()
    cool_IField()
    cool_IRecord()
    cool_Record()
    cool_namespace() # must be called before cool_ChannelSelection() but after cool_Record()
    cool_Time()
    cool_ChannelSelection()
    cool_IObject()
    cool_IObjectIterator()
    cool_IRecordIterator()
    cool_IDatabaseSvc()
    cool_IDatabase()
    if PyCintex.gbl.gROOT.GetVersion()[0] == '6' and PyCintex.gbl.gROOT.GetVersion()[3] < '3' : # Workaround only needed for 6.00 <= ROOT <= 6.02 (old JIT)
        cool_IDatabaseSvc_root6()
        cool_IHvsNode_root6()
        cool_IDatabase_root6()
        cool_IFolder_root6()
        cool_FolderSpecification_root6()
    ###cool_FieldSelection()
    filterwarnings()
    boost_shared_ptr() # this is better at the end
    std_shared_ptr() # this is better at the end

#######################################################################
#                                                                     #
# Instrument namespaces                                               #
#                                                                     #
#######################################################################
def cool_typedefs():
    from definitions import basic_types_mapping
    # use gROOT.GetVersion() to distinguish between ROOT5/6 (CORALCOOL-2732)
    # ["is Reflex in PyCintex?" is no good, as ATLAS adds it back in ROOT6!]
    # [note also that PyCool has a getRootVersion() method since ages!...]
    if PyCintex.gbl.gROOT.GetVersion()[0] != '5' :
    # 2. NEW ROOT6 IMPLEMENTATION (workaround for bug #102768)
        cool_basic_types_mapping = {# COOL C++: basic C++
            "Bool":               "bool",
            "UChar":              "unsigned char",
            "Int16":              "short",
            "UInt16":             "unsigned short",
            "Int32":              "int",
            "UInt32":             "unsigned int",
            "Int64":              "long long",
            "UInt64":             "unsigned long long",
            "UInt63":             "unsigned long long",
            "ChannelId":          "unsigned int",
            "ValidityKey":        "unsigned long long",
            "Float":              "float",
            "Double":             "double",
            }
        for t in cool_basic_types_mapping:
            #print 'PyCintex.gbl.cool.%s = %s (%s)'%(t, basic_types_mapping[cool_basic_types_mapping[t]], cool_basic_types_mapping[t]) # debug bug #102768 for ROOT6
            exec 'PyCintex.gbl.cool.%s = %s'%(t, basic_types_mapping[cool_basic_types_mapping[t]])
        return # Reflex does not exist in ROOT6 (see bug #102651)
    # 1. OLD ROOT5 IMPLEMENTATION
    # get the cool namespace from Reflex
    sc = PyCintex.gbl.Reflex.Scope.ByName("cool")
    # loop over the known types of the cool namespace
    for i in xrange(sc.SubTypeSize()):
        t = sc.SubTypeAt(i)
        if t.IsTypedef():
            td = t
            # fully qualified C++ name
            typedef_name = td.Name(4)
            # fully qualified Python name
            typedef_pyname = 'PyCintex.gbl.' + typedef_name.replace('::','.')
            # resolve recursive typedefs
            while t.IsTypedef() and not t.Name() == "string": t = t.ToType()
            if True or not hasattr(PyCintex.gbl,typedef_name):
                # Marco: In principle we should not need to override already existing typedef, but it seems that they do not work as expected
                if not t.IsFundamental(): # typedef to non-basic types
                    #print '%s = getattr(PyCintex.gbl,%r)'%(typedef_pyname, t.Name(4))
                    exec '%s = getattr(PyCintex.gbl,%r)'%(typedef_pyname, t.Name(4))
                else:
                    # typedef to basic types
                    if t.Name(4) not in basic_types_mapping:
                        print "Warning: cannot make typedef '%s' to basic type '%s'" % (td.Name(4), t.Name(4))
                    else:
                        #print '%s = %s (%s)'%(typedef_pyname, basic_types_mapping[t.Name(4)], t.Name(4)) # debug bug #102768 for ROOT6
                        exec '%s = %s'%(typedef_pyname, basic_types_mapping[t.Name(4)])

def cool_constants():
    # New Reflex-free implementation (bug #102630) for both ROOT5 and ROOT6
    # But in ROOT6 this is not needed at all (bug #102651): hence coolMinMax
    # was omitted for ROOT6 (in COOL C++) and this code will not be executed
    if hasattr(PyCintex.gbl.cool.PyCool.Helpers, 'coolMinMax'):
        mm = PyCintex.gbl.cool.PyCool.Helpers.coolMinMax()
        for i in xrange( mm.size() ) :
            exec "PyCintex.gbl.cool.%s = %r" %( mm.specification()[i].name(), mm[i] )
        PyCintex.gbl.cool.UInt64Max = PyCintex.gbl.cool.Int64Max*2 + 1

def cool_namespace():
    cool_typedefs()
    cool_constants()

#######################################################################
#                                                                     #
# Common helpers                                                      #
#                                                                     #
#######################################################################
#class TemplatedMemberFunctionProxy(object):
#    from definitions import cool_type_aliases
#    def __init__(self, function):
#        self.function = "%s<%%s>" % function
#    def __call__(self, other, typeName):
#        if typeName in self.aliases:
#            typeName = self.aliases[typeName]
#        return getattr(other, self.function % typeName)
from definitions import cool_type_aliases
def TemplatedMemberFunctionProxy(self, typeName):
    if typeName in cool_type_aliases:
        typeName = cool_type_aliases[typeName]
    return getattr(self, "data<%s>" % typeName)
#def TemplatedMemberFunctionProxy2(self, typeName):
#    #if typeName in cool_type_aliases:
#    #    typeName = cool_type_aliases[typeName]
#    return getattr(self, "FieldSelection<%s>" % typeName)

#######################################################################
#                                                                     #
# Instrument classes                                                  #
#                                                                     #
#######################################################################
### boost::shared_ptr
def boost_shared_ptr():
    """
    Instrument boost::shared_ptr<T>.
    This function find all the classes starting with 'boost::shared_ptr<'.
    The added function allows to emulate the 'smart pointer ' behaviour.
    """
    # add the new function to all boost::shared_ptr<> classes
    for c in getAllClasses():
        if c.startswith("boost::shared_ptr"):
            cls = getattr(gbl,c)
            # use the conversion to string of the wrapped object.
            cls.__str__     = lambda self: str(self.get())
            # do not overload the __repr__ operator (will show the true type)

########################################################################
### std::shared_ptr
def std_shared_ptr():
    """
    Instrument std::shared_ptr<T>.
    This function find all the classes starting with 'std::shared_ptr<'.
    The added function allows to emulate the 'smart pointer ' behaviour.
    """
    # 1. Dynamic implementation - but getAllClasses is no good (bug #103318)
    # add the new function to all std::shared_ptr<> classes
    #for c in getAllClasses():
    #    if c.startswith("std::shared_ptr"):
    #        cls = getattr(gbl,c)
    #        # use the conversion to string of the wrapped object.
    #        cls.__str__     = lambda self: str(self.get())
    #        # do not overload the __repr__ operator (will show the true type)
    # 2. Static implementation - workaround for bug #103318
    for c in ['IDatabase','IFolder','IFolderSet','IObject','IObjectIterator','IObjectVector ','IRecord','IRecordVector','ITransaction']:
        if hasattr(gbl,"std::shared_ptr<cool::"+c+">"):
            cls = getattr(gbl,"std::shared_ptr<cool::"+c+">")
            # use the conversion to string of the wrapped object.
            cls.__str__     = lambda self: str(self.get())
            # do not overload the __repr__ operator (will show the true type)

########################################################################
### cool::Time
def cool_Time():
    """
    Instrument cool::Time adding to-string conversion.
    """
    cls = getattr(gbl,"cool::Time")
    cls.__str__ = lambda self : "%4.4d-%2.2d-%2.2d_%2.2d:%2.2d:%2.2d.%9.9ld GMT" % ( self.year(), self.month(), self.day(), self.hour(), self.minute(), self.second(), self.nanosecond() )

########################################################################
## coral::Attribute
def coral_Attribute():
    """
    Instruments coral::Attribute allowing to emulate the behavior of
    coral::Attribute::data<T>() with coral.Attribute.data('T')().
    """
    # add the wrapper
    cls = getattr(gbl,"coral::Attribute")
    cls.data = TemplatedMemberFunctionProxy

########################################################################
## coral::AttributeList
def coral_AttributeList():
    """
    Instruments coral::AttributeList to make it more Python-friendly.
    It can be used both as a list or as a dictionary.
    Added functions:
        * attribute ( access to attributes. like the original __getitem__ )
        * __setitem__
        * __getitem__
        * __len__
        * keys
        * __contains__
        * typeNames
        * typeName
        * __str__
    """
    def coral_AttributeList_attribute(self, key):
        if type(key) is str:
            try:
                a = self.__getitem_orig__(key)
            except:
                raise KeyError(key)
        else:
            if key >= self.size():
                raise IndexError(key)
            a = self.__getitem_orig__(key)
        return a
    # new setter
    def coral_AttributeList_setitem(self, key, value):
        if value is None:
            self.attribute(key).setNull(True)
        else:
            self.attribute(key).setNull(False)
            # Aborts on c++ exceptions during overload resolution (bug #102767)
            ###self.attribute(key).setValue(value)
            # Wim's workaround to avoid multiple match of overload (bug #103304)
            ###self.attribute(key).setValue(type(value))(value)
            # Improved workaround for non-python C types (e.g. unsigned)
            cpptype=self.attribute(key).specification().typeName()
            if cpptype == "string" : self.attribute(key).setValue(str)(value)
            else : self.attribute(key).setValue(cpptype)(value)
    # new getter
    def coral_AttributeList_getitem(self, key):
        if self.attribute(key).isNull():
            return None
        else:
            return self.attribute(key).data(self.typeName(key))()
    # get all the keys
    def coral_AttributeList_keys(self):
        keys = []
        i = self.begin()
        while i != self.end():
            keys.append(i.__deref__().specification().name())
            i.__preinc__() # ++i
        # for i in range(len(self)):
        #     keys.append(self.attribute(i).specification().name())
        return keys
    def coral_AttributeList_str(self):
        # # it should be:
        # outstr = getattr(gbl,"std::ostringstream")()
        # self.toOutputStream(outstr)
        # return outstr.str()
        # # but there is a bug in coral :-\
        s = ''
        first = True
        for k in self.keys():
            if not first:
                s += ', '
            first = False
            s += '[%s (%s) : %s]'%(k,self.typeName(k),str(self[k]))
        return s
    # implement the python-style iterator
    class pyIterator:
        def __init__(self,attrList):
            self.iterator = attrList.begin()
            self.attrList = attrList
        def __iter__(self):
            return self
        def next(self):
            if self.iterator != self.attrList.end():
                k = self.iterator.__deref__().specification().name()
                self.iterator.__preinc__()
                return k
            else:
                raise StopIteration
    # add the new functions
    cls = getattr(gbl,"coral::AttributeList")
    cls.__getitem_orig__ = cls.__getitem__
    cls.attribute    = coral_AttributeList_attribute
    cls.__setitem__  = coral_AttributeList_setitem
    cls.__getitem__  = coral_AttributeList_getitem
    cls.keys         = coral_AttributeList_keys
    cls.__contains__ = lambda self,key : key in self.keys()
    cls.typeNames    = lambda self : \
                       [ self.typeName(key) for key in self.keys() ]
    cls.typeName     = lambda self,key : \
                       str(self.attribute(key).specification().typeName())
    cls.__str__      = coral_AttributeList_str
    cls.pyIterator   = pyIterator
    cls.__iter__     = lambda self : cls.pyIterator(self)
    cls.iterkeys     = cls.__iter__

########################################################################
## coral::Blob
def coral_Blob():
    """
    Instruments coral::Blob to make it usable in Python.
    """
    # implement the python-style iterator
    class pyIterator:
        def __init__(self,spec):
            self.index = 0
            self.spec = spec
            #self.size = self.spec.size()
        def __iter__(self):
            return self
        def next(self):
            if self.index < self.spec.size() :
                k = self.spec[self.index]
                self.index += 1
                return k
            else:
                raise StopIteration
    # these provide a limited file-like interface
    def blob_seek(self, offset, whence=0):
        if whence == 0:
            self.pos = offset
        elif whence == 1:
            self.pos = self.pos + offset
        elif whence == 2:
            self.pos = self.size() + offset
        if self.size() < self.pos:
            self.resize(self.pos)
    def blob_write(self, str):
        if self.pos + len(str) > self.size():
            self.resize(self.pos + len(str))
        for i in range(len(str)):
            self[self.pos+i] = ord(str[i])
        self.pos = self.pos + len(str)
    def blob_read(self, size = -1):
        res = ""
        if size < 0:
            endpos = self.size()
        else:
            endpos = self.pos + size
        buf = self.startingAddress()
        startpos = self.pos
        self.pos = endpos
        # Fix ATCONDDB-17 (work around different behaviour of ROOT6 over ROOT5)
        if buf:
            buf.SetSize(self.size())
            return buf[startpos:endpos]
        else:
            return ""
    def blob_tell(self):
        return self.pos
    # add the new functions
    ###for cls in [ gbl.coral.Blob ]: # possible workaround for bug #102769?
    for cls in [ getattr(gbl,"coral::Blob") ]:
        cls.__len__      = lambda self : self.size()
        cls.pyIterator   = pyIterator
        cls.__iter__     = lambda self : cls.pyIterator(self)
        cls.__setitem__  = lambda self, key, value: \
                           gbl.cool.PyCool.Helpers.setBlobByte(self,key,value)
        cls.__getitem__  = lambda self, key: \
                           ord(gbl.cool.PyCool.Helpers.getBlobByte(self,key))
        cls.seek         = blob_seek
        cls.read         = blob_read
        cls.write        = blob_write
        cls.tell         = blob_tell
        cls.pos          = 0
        ###print cls, dir(cls) # debug bug #102769
    ###for cls in [ gbl.coral.Blob ]: print cls, dir(cls) # debug bug #102769

########################################################################
## cool::IRecordSpecification
def cool_IRecordSpecification():
    """
    Instruments cool::IRecordSpecification to make it usable as a dictionary.
    """
    # implement the python-style iterator
    class pyIterator:
        def __init__(self,spec):
            self.index = 0
            self.spec = spec
            #self.size = self.spec.size()
        def __iter__(self):
            return self
        def next(self):
            if self.index < self.spec.size() :
                k = self.spec[self.index]
                self.index += 1
                return k
            else:
                raise StopIteration
    # get all the keys
    def cool_IRecordSpecification_keys(self):
        keys = []
        i = 0
        while i < self.size():
            keys.append(self[i].name())
            i += 1
        return keys
    cls = getattr(gbl,"cool::IRecordSpecification")
    cls.pyIterator   = pyIterator
    cls.__iter__     = lambda self : cls.pyIterator(self)
    cls.iterkeys     = cls.__iter__
    cls.keys         = cool_IRecordSpecification_keys
    cls.__contains__ = lambda self,key : key in self.keys()
    cls.typeName     = lambda self,key : self[key].storageType().name()
    cls.typeNames    = lambda self : \
                       [ self.typeName(key) for key in self.keys() ]

########################################################################
## cool::IField
def cool_IField():
    """
    Instruments cool::IField allowing to emulate the behavior of
    cool::IField::data<T>() with cool.IField.data('T')(), where
    'T' is the name of COOL storage type.
    """
    # add the wrapper
    cls = getattr(gbl,"cool::IField")
    cls.data = TemplatedMemberFunctionProxy

########################################################################
## cool::IRecord
def cool_IRecord():
    """
    Instruments cool::IRecord to make it more Python-friendly.
    It can be used both as a list or as a dictionary.
    Added functions:
        * field ( access to fields. like the original __getitem__ )
        * __getitem__
        * __len__
        * keys
        * __contains__
        * typeNames
        * typeName
        * __str__
    """
    def cool_IRecord_field(self, key):
        if type(key) is str:
            try:
                a = self.__getitem_orig__(key)
            except:
                raise KeyError(key)
        else:
            if key >= self.size():
                raise IndexError(key)
            a = self.__getitem_orig__(key)
        return a
    # new getter
    def cool_IRecord_getitem(self, key):
        f = self.field(key)
        if f.isNull():
            return None
        else:
            return f.data(f.storageType().name())()
    # implement the python-style iterator
    class pyIterator:
        def __init__(self,record):
            self.index = 0
            self.record = record
        def __iter__(self):
            return self
        def next(self):
            if self.index < len(self.record):
                k = self.record.field(self.index).name()
                self.index += 1
                return k
            else:
                raise StopIteration
    # add the new functions
    cls = getattr(gbl,"cool::IRecord")
    cls.__getitem_orig__ = cls.__getitem__
    cls.field        = cool_IRecord_field
    cls.__getitem__  = cool_IRecord_getitem
    cls.keys         = lambda self : self.specification().keys()
    cls.__contains__ = lambda self,key : key in self.keys()
    cls.typeName     = lambda self,key : self.specification().typeName(key)
    cls.typeNames    = lambda self : self.specification().typeNames()
    cls.__str__      = lambda self : gbl.cool.PyCool.Helpers.toString(self)
    cls.pyIterator   = pyIterator
    cls.__iter__     = lambda self : cls.pyIterator(self)
    cls.iterkeys     = cls.__iter__

########################################################################
## cool::Record
def cool_Record():
    """
    Instruments cool::Record to make it more Python-friendly.
    It can be used both as a list or as a dictionary.
    Added functions:
        * __setitem__
    """
    # new getter
    def cool_Record_getitem(self, key):
        f = self.field(key)
        if f.isNull():
            return None
        else:
            return f.data(f.storageType().name())()
    # new setter
    def cool_Record_setitem(self, key, value):
        f = self.field(key)
        if value is None:
            f.setNull()
        else:
            # Aborts on c++ exceptions during overload resolution (bug #102767)
            ###f.setValue(value)
            # Wim's workaround to avoid multiple match of overload (bug #103304)
            ###f.setValue(type(value))(value)
            # Improved workaround for non-python C types (e.g. unsigned)
            cool_basic_types_mapping2 = {# COOL C++: basic C++
                "Bool":               "bool",
                "UChar":              "unsigned char",
                "Int16":              "short",
                "UInt16":             "unsigned short",
                "Int32":              "int",
                "UInt32":             "unsigned int",
                "UInt63":             "unsigned long long",
                "Int64":              "long long",
                "Float":              "float",
                "Double":             "double",
                "String255":          "std::string",
                "String4k":           "std::string",
                "String64k":          "std::string",
                "String16M":          "std::string",
                "Blob64k":            "coral::Blob",
                "Blob16M":            "coral::Blob",
                }
            cpptype=cool_basic_types_mapping2[f.storageType().name()]
            if cpptype == "std::string" : f.setValue(str)(value)
            else : f.setValue(cpptype)(value)
    # add the new functions
    cls = getattr(gbl,"cool::Record")
    cls.__getitem_orig__ = cls.__getitem__
    cls.__getitem__  = cool_Record_getitem
    cls.__setitem__  = cool_Record_setitem

########################################################################
## cool::ChannelSelection
def cool_ChannelSelection():
    """
    Instruments cool::ChannelSelection by replacing the constructor because
    the two signatures
        * cool::ChannelSelection(const int& order = channelBeforeSince)
        * cool::ChannelSelection(const unsigned int& channel)
    are conflicting.
    Now a single argument means the second form. The first one can be obtained by
    explicitely setting the parameter 'order'.
    """
    # new constructor
    def cool_ChannelSelection_init(self,
                                   firstChannel = None,
                                   lastChannel  = None,
                                   order        = gbl.cool.ChannelSelection.channelBeforeSince):
        if firstChannel is None:
            #all channels
            self.__init_orig__(order)
            return
        elif lastChannel is None:
            # single channel selection
            lastChannel = firstChannel
        self.__init_orig__(firstChannel,lastChannel,order)
    def cool_ChannelSelection_str(self):
        if self.lastChannel() == gbl.cool.ChannelSelection.all().lastChannel():
            s = "(%s,+inf)" % self.firstChannel()
        else:
            s = "(%s,%s)" % (self.firstChannel(), self.lastChannel())
        return s
    # add the new function
    cls = getattr(gbl,"cool::ChannelSelection")
    cls.__init_orig__ = cls.__init__
    cls.__init__ = cool_ChannelSelection_init
    cls.__str__  = cool_ChannelSelection_str

########################################################################
## cool::IObject
def cool_IObject():
    """
    Instruments cool::IObject.
    cool::IObject::insertionTime() returns a 'const cool::ITime&' which is not
    good for Python. I replace cool.IObject.insertionTime with a function
    creating a cool::Time copy of the cool::ITime&.
    """
    def cool_IObject_str(self):
        maxPayloadSize = 60
        ellipsis = '...'
        payloadStr = str(self.payload())
        if len(payloadStr) > maxPayloadSize + len(ellipsis):
            payloadStr = payloadStr[:maxPayloadSize] + ellipsis
        s = "[%s,%s[ (%s) %s %s" % ( self.since(), self.until(),
                                     self.channelId(),
                                     payloadStr,
                                     self.insertionTime()
                                     )
        return s
    # add the new functions
    cls = getattr(gbl,"cool::IObject")
    cls.insertionTime_orig = cls.insertionTime
    cls.insertionTime = lambda self : gbl.cool.Time(self.insertionTime_orig())
    cls.__str__       = cool_IObject_str

########################################################################
## cool::IObjectIterator
def cool_IObjectIterator():
    """
    Instruments cool::IObjectIterator to make it behave as a python iterator.
    """
    class BrowseObjectIterator:
        def __init__(self,objectIterator):
            self.objectIterator = objectIterator
        def __iter__(self):
            return self
        def next(self):
            if self.objectIterator.goToNext():
                return PyCintex.gbl.cool.PyCool.Helpers.IObjectPtr( self.objectIterator.currentRef().clone() )
            else:
                raise StopIteration()
    # add the new functions
    cls = getattr(gbl,"cool::IObjectIterator")
    cls.__iter__ = lambda self : BrowseObjectIterator(self)
    # this is needed because the construct "for x in iter:"
    # checks if the method __iter__ is available before trying it
    # and shared pointers do not have it
    if hasattr(gbl, "std::shared_ptr<cool::IObjectIterator>"):
        cls = getattr(gbl, "std::shared_ptr<cool::IObjectIterator>")
        cls.__iter__ = lambda self : self.get().__iter__()
    elif hasattr(gbl, "boost::shared_ptr<cool::IObjectIterator>"):
        cls = getattr(gbl, "boost::shared_ptr<cool::IObjectIterator>")
        cls.__iter__ = lambda self : self.get().__iter__()

########################################################################
## cool::IRecordIterator
def cool_IRecordIterator():
    """
    Instruments cool::IRecordIterator to make it behave as a python iterator.
    """
    # *** Workaround #ifndef COOL290VP (bug #71949) - start
    try: cls = getattr(gbl,"cool::IRecordIterator")
    except: return
    # *** Workaround #ifndef COOL290VP (bug #71949) - end
    class BrowseRecordIterator:
        def __init__(self,recordIterator):
            self.recordIterator = recordIterator
        def __iter__(self):
            return self
        def next(self):
            if self.recordIterator.goToNext():
                return PyCintex.gbl.cool.PyCool.Helpers.IRecordPtr( self.recordIterator.currentRef() )
            else:
                raise StopIteration()
    # add the new functions
    cls = getattr(gbl,"cool::IRecordIterator")
    cls.__iter__ = lambda self : BrowseRecordIterator(self)
    # this is needed because the construct "for x in iter:"
    # checks if the method __iter__ is available before trying it
    # and shared pointers do not have it
    if hasattr(gbl, "std::shared_ptr<cool::IRecordIterator>"):
        cls = getattr(gbl, "std::shared_ptr<cool::IRecordIterator>")
        cls.__iter__ = lambda self : self.get().__iter__()
    elif hasattr(gbl, "boost::shared_ptr<cool::IRecordIterator>"):
        cls = getattr(gbl, "boost::shared_ptr<cool::IRecordIterator>")
        cls.__iter__ = lambda self : self.get().__iter__()

########################################################################
## cool::IDatabaseSvc
def cool_IDatabaseSvc():
    """
    Instruments cool::IDatabaseSvc to add the refreshDatabase feature.
    """
    # add the new functions
    cls = getattr(gbl,"cool::IDatabaseSvc")
    cls.refreshDatabase = lambda self,url : gbl.cool.PyCool.Helpers.refreshDatabaseFromDbSvc(self,url)

########################################################################
## cool::IDatabase
def cool_IDatabase():
    """
    Instruments cool::IDatabase to add the refreshDatabase feature.
    """
    # add the new functions
    cls = getattr(gbl,"cool::IDatabase")
    cls.refreshDatabase = lambda self : gbl.cool.PyCool.Helpers.refreshDatabaseFromDb(self)

########################################################################
## cool::IDatabaseSvc
def cool_IDatabaseSvc_root6():
    """
    Instruments cool::IDatabaseSvc to work around root6 issues.
    """
    def cool_IDatabaseSvc_createDatabase(self,dbId):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        db = gbl.cool.PyCool.Helpers.createDatabaseNoThrow(self,msg,dbId)
        if msg != "" : raise Exception( msg )
        else : return db
    def cool_IDatabaseSvc_openDatabase(self,dbId,readOnly=True):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        db = gbl.cool.PyCool.Helpers.openDatabaseNoThrow(self,msg,dbId,readOnly)
        if msg != "" : raise Exception( msg )
        else : return db
    # add the new functions
    cls = getattr(gbl,"cool::IDatabaseSvc")
    cls.createDatabase_orig = cls.createDatabase
    cls.createDatabase = cool_IDatabaseSvc_createDatabase
    cls.openDatabase_orig = cls.openDatabase
    cls.openDatabase = cool_IDatabaseSvc_openDatabase

########################################################################
## cool::IHvsNode
def cool_IHvsNode_root6():
    """
    Instruments cool::IHvsNode to work around root6 issues.
    """
    def cool_IHvsNode_resolveTag(self,ancestor):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        tag = gbl.cool.PyCool.Helpers.resolveTagNoThrow(self,msg,ancestor)
        if msg != "" : raise Exception( msg )
        else : return tag
    def cool_IHvsNode_createTagRelation(self,parent,tag):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        gbl.cool.PyCool.Helpers.createTagRelationNoThrow(self,msg,parent,tag)
        if msg != "" : raise Exception( msg )
        else : return
    def cool_IHvsNode_deleteTagRelation(self,parent):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        gbl.cool.PyCool.Helpers.deleteTagRelationNoThrow(self,msg,parent)
        if msg != "" : raise Exception( msg )
        else : return
    def cool_IHvsNode_findTagRelation(self,parent):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        tag = gbl.cool.PyCool.Helpers.findTagRelationNoThrow(self,msg,parent)
        if msg != "" : raise Exception( msg )
        else : return tag
    def cool_IHvsNode_setTagLockStatus(self,tag,status):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        gbl.cool.PyCool.Helpers.setTagLockStatusNoThrow(self,msg,tag,status)
        if msg != "" : raise Exception( msg )
        else : return
    # add the new functions
    cls = getattr(gbl,"cool::IHvsNode")
    cls.resolveTag_orig = cls.resolveTag
    cls.resolveTag = cool_IHvsNode_resolveTag
    cls.createTagRelation_orig = cls.createTagRelation
    cls.createTagRelation = cool_IHvsNode_createTagRelation
    cls.deleteTagRelation_orig = cls.deleteTagRelation
    cls.deleteTagRelation = cool_IHvsNode_deleteTagRelation
    cls.findTagRelation_orig = cls.findTagRelation
    cls.findTagRelation = cool_IHvsNode_findTagRelation
    cls.setTagLockStatus_orig = cls.setTagLockStatus
    cls.setTagLockStatus = cool_IHvsNode_setTagLockStatus

########################################################################
## cool::IDatabase
def cool_IDatabase_root6():
    """
    Instruments cool::IDatabase to work around root6 issues.
    """
    def cool_IDatabase_getFolderSet(self,fullPath):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        fl = gbl.cool.PyCool.Helpers.getFolderSetNoThrow(self,msg,fullPath)
        if msg != "" : raise Exception( msg )
        else : return fl
    def cool_IDatabase_getFolder(self,fullPath):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        fl = gbl.cool.PyCool.Helpers.getFolderNoThrow(self,msg,fullPath)
        if msg != "" : raise Exception( msg )
        else : return fl
    # add the new functions
    cls = getattr(gbl,"cool::IDatabase")
    cls.getFolderSet_orig = cls.getFolderSet
    cls.getFolderSet = cool_IDatabase_getFolderSet
    cls.getFolder_orig = cls.getFolder
    cls.getFolder = cool_IDatabase_getFolder

########################################################################
## cool::IFolder
def cool_IFolder_root6():
    """
    Instruments cool::IFolder to work around root6 issues.
    """
    def cool_IFolder_findObject(self,pointInTime,channelId,tagName=""):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        ob = gbl.cool.PyCool.Helpers.findObjectNoThrow(self,msg,pointInTime,channelId,tagName)
        if msg != "" : raise Exception( msg )
        else : return ob
    def cool_IFolder_browseObjects(self,since,until,channels,tagName="",payloadQuery=0):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        it = gbl.cool.PyCool.Helpers.browseObjectsNoThrow(self,msg,since,until,channels,tagName,payloadQuery)
        if msg != "" : raise Exception( msg )
        else : return it
    def cool_IFolder_cloneTagAsUserTag(self,tag,clone,desc="",force=False):
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        gbl.cool.PyCool.Helpers.cloneTagAsUserTagNoThrow(self,msg,tag,clone,desc,force)
        if msg != "" : raise Exception( msg )
        else : return
    # add the new functions
    cls = getattr(gbl,"cool::IFolder")
    cls.findObject_orig = cls.findObject
    cls.findObject = cool_IFolder_findObject
    cls.browseObjects_orig = cls.browseObjects
    cls.browseObjects = cool_IFolder_browseObjects
    cls.cloneTagAsUserTag_orig = cls.cloneTagAsUserTag
    cls.cloneTagAsUserTag = cool_IFolder_cloneTagAsUserTag

########################################################################
## cool::FolderSpecification
def cool_FolderSpecification_root6() :
    """
    Instruments cool::FolderSpecification to work around root6 issues.
    """
    def cool_FolderSpecification_init(self,arg1,arg2=None,arg3=gbl.cool.PayloadMode.INLINEPAYLOAD) :
        if arg2 is None:
            self.__init_orig__(arg1)
            return
        msg = gbl.std.string() # NB This is a c++ "string", '' is a python "str"
        fs = gbl.cool.PyCool.Helpers.FolderSpecificationNoThrow(msg,arg1,arg2,arg3)
        if msg != "" : raise Exception( msg )
        else :
            self.__init_orig__(fs) # copy ctor
            return
    # add the new function
    cls = getattr(gbl,"cool::FolderSpecification")
    cls.__init_orig__ = cls.__init__
    cls.__init__ = cool_FolderSpecification_init

########################################################################
## cool::FieldSelection
#def cool_FieldSelection():
#    """
#    Instruments cool::FieldSelection allowing to emulate the behavior of
#    cool::FieldSelection::FieldSelection<T>() with cool.FieldSelection('T')(),
#    where 'T' is the name of COOL storage type.
#    """
#    # add the wrapper
#    cls = getattr(gbl,"cool::FieldSelection")
#    cls.__init_orig__ = cls.__init__
#    cls.__init__ = TemplatedMemberFunctionProxy2

########################################################################
## cool::FieldSelection
#def cool_FieldSelection():
#    """
#    Instruments cool::FieldSelection to make it more Python-friendly.
#    """
#    def cool_createFieldSelection(self,typeName):
#        if typeName in cool_type_aliases:
#            typeName = cool_type_aliases[typeName]
#        return getattr(self,"data<%s>"%typeName)
#    def cool_FieldSelection_init(self, *args):
#        ###print "Number of arguments:", len(args)
#        ###print "Arguments are: ", args
#        if len(args) == 4 :
#            # Here instead of calling createFieldSelection2, you should
#            # call createFieldSelection<typeName> using cool_type_aliases
#            # But createFieldSelection<...> are not in gbl.cool.PyCool.Helpers!
#            fs = gbl.cool.PyCool.Helpers.createFieldSelection2(*args)
#            return self.__init_orig__(fs)
#        else :
#            return self.__init_orig__(*args)
#    # add the new functions
#    cls = getattr(gbl,"cool::FieldSelection")
#    cls.__init_orig__ = cls.__init__
#    cls.__init__ = cool_FieldSelection_init

########################################################################

def filterwarnings():
    # Filter out warnings from Wim's workaround (bug #103304)
    # See http://root.cern.ch/phpBB3/viewtopic.php?f=14&t=14213#p61143
    import warnings
    warnings.filterwarnings( action='ignore', category=RuntimeWarning, message='creating converter.*' )

