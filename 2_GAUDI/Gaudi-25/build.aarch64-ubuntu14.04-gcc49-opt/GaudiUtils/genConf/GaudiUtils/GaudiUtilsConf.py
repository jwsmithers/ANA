#Wed Apr 29 15:37:09 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class FileReadTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(FileReadTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'FileReadTool'
  pass # class FileReadTool

class Gaudi__IODataManager( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'CatalogType' : 'Gaudi::MultiFileCatalog/FileCatalog', # str
    'UseGFAL' : True, # bool
    'QuarantineFiles' : True, # bool
    'AgeLimit' : 2, # int
    'DisablePFNWarning' : False, # bool
  }
  _propertyDocDct = { 
    'DisablePFNWarning' : """ if set to True, we will not report when a file is opened by it's physical name """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__IODataManager, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'Gaudi::IODataManager'
  pass # class Gaudi__IODataManager

class Gaudi__MultiFileCatalog( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Catalogs' : [ 'xmlcatalog_file:test_catalog.xml' ], # list
  }
  _propertyDocDct = { 
    'Catalogs' : """ The list of Catalogs """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__MultiFileCatalog, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'Gaudi::MultiFileCatalog'
  pass # class Gaudi__MultiFileCatalog

class Gaudi__Utils__SignalMonitorSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Utils__SignalMonitorSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'Gaudi::Utils::SignalMonitorSvc'
  pass # class Gaudi__Utils__SignalMonitorSvc

class Gaudi__Utils__StopSignalHandler( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Signals' : [ 'SIGINT' , 'SIGXCPU' ], # list
  }
  _propertyDocDct = { 
    'Signals' : """ List of signal names or numbers to use to schedule a stop. If the signal is followed by a '+' the signal is propagated the previously registered handler (if any). """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Utils__StopSignalHandler, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'Gaudi::Utils::StopSignalHandler'
  pass # class Gaudi__Utils__StopSignalHandler

class StalledEventMonitor( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'EventTimeout' : 600, # int
    'MaxTimeoutCount' : 0, # int
    'StackTrace' : False, # bool
  }
  _propertyDocDct = { 
    'EventTimeout' : """ Number of seconds allowed to process a single event (0 to disable the check). """,
    'MaxTimeoutCount' : """ Number timeouts before aborting the execution (0 means never abort). """,
    'StackTrace' : """ Whether to print the stack-trace on timeout. """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(StalledEventMonitor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'StalledEventMonitor'
  pass # class StalledEventMonitor

class VFSSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'FileAccessTools' : [ 'FileReadTool' ], # list
    'FallBackProtocol' : 'file', # str
  }
  _propertyDocDct = { 
    'FallBackProtocol' : """ URL prefix to use if the prefix is not present. """,
    'FileAccessTools' : """ List of tools implementing the IFileAccess interface. """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(VFSSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiUtils'
  def getType( self ):
      return 'VFSSvc'
  pass # class VFSSvc
