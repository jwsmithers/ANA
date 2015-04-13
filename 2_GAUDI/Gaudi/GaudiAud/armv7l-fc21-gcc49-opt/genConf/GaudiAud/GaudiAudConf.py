#Mon Feb 16 20:29:32 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class AlgContextAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(AlgContextAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAud'
  def getType( self ):
      return 'AlgContextAuditor'
  pass # class AlgContextAuditor

class AlgErrorAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'Abort' : False, # bool
    'Throw' : False, # bool
  }
  _propertyDocDct = { 
    'Throw' : """ Throw GaudiException upon illegal Algorithm return code """,
    'Abort' : """ Abort job upon illegal Algorithm return code """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(AlgErrorAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAud'
  def getType( self ):
      return 'AlgErrorAuditor'
  pass # class AlgErrorAuditor

class ChronoAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'EventTypes' : [  ], # list
    'CustomEventTypes' : [  ], # list
  }
  _propertyDocDct = { 
    'CustomEventTypes' : """ OBSOLETE, use EventTypes instead """,
    'EventTypes' : """ List of event types to audit ([]=all, ['none']=none) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ChronoAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAud'
  def getType( self ):
      return 'ChronoAuditor'
  pass # class ChronoAuditor

class MemStatAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'EventTypes' : [  ], # list
    'CustomEventTypes' : [  ], # list
  }
  _propertyDocDct = { 
    'CustomEventTypes' : """ OBSOLETE, use EventTypes instead """,
    'EventTypes' : """ List of event types to audit ([]=all, ['none']=none) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MemStatAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAud'
  def getType( self ):
      return 'MemStatAuditor'
  pass # class MemStatAuditor

class MemoryAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'EventTypes' : [  ], # list
    'CustomEventTypes' : [  ], # list
  }
  _propertyDocDct = { 
    'CustomEventTypes' : """ OBSOLETE, use EventTypes instead """,
    'EventTypes' : """ List of event types to audit ([]=all, ['none']=none) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MemoryAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAud'
  def getType( self ):
      return 'MemoryAuditor'
  pass # class MemoryAuditor

class NameAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'EventTypes' : [  ], # list
    'CustomEventTypes' : [  ], # list
  }
  _propertyDocDct = { 
    'CustomEventTypes' : """ OBSOLETE, use EventTypes instead """,
    'EventTypes' : """ List of event types to audit ([]=all, ['none']=none) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(NameAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAud'
  def getType( self ):
      return 'NameAuditor'
  pass # class NameAuditor
