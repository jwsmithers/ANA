#Mon Feb 16 20:15:47 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class Gaudi__RootCnvSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'IOPerfStats' : '', # str
    'ShareFiles' : 'NO', # str
    'EnableIncident' : True, # bool
    'RecordsName' : '/FileRecords', # str
    'LoadSection' : 'Event', # str
    'AutoFlush' : 100, # int
    'BasketSize' : 2097152, # int
    'BufferSize' : 2048, # int
    'SplitLevel' : 0, # int
    'GlobalCompression' : '', # str
    'CacheSize' : 10485760, # int
    'LearnEntries' : 10, # int
    'CacheBranches' : [ '*' ], # list
    'VetoBranches' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__RootCnvSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'RootCnv'
  def getType( self ):
      return 'Gaudi::RootCnvSvc'
  pass # class Gaudi__RootCnvSvc

class Gaudi__RootEvtSelector( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'EvtPersistencySvc' : 'EventPersistencySvc', # str
    'DbType' : '', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__RootEvtSelector, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'RootCnv'
  def getType( self ):
      return 'Gaudi::RootEvtSelector'
  pass # class Gaudi__RootEvtSelector

class Gaudi__RootPerfMonSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'IOPerfStats' : '', # str
    'Streams' : '', # str
    'BasketSize' : '', # str
    'BufferSize' : '', # str
    'SplitLevel' : '', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__RootPerfMonSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'RootCnv'
  def getType( self ):
      return 'Gaudi::RootPerfMonSvc'
  pass # class Gaudi__RootPerfMonSvc
