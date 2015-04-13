#Mon Feb 16 20:14:57 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class AppMgrRunable( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'EvtMax' : -17974594, # int
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(AppMgrRunable, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'AppMgrRunable'
  pass # class AppMgrRunable

class ApplicationMgr( ConfigurableService ) :
  __slots__ = { 
    'Go' : 0, # int
    'Exit' : 0, # int
    'Dlls' : [  ], # list
    'ExtSvc' : [  ], # list
    'CreateSvc' : [  ], # list
    'ExtSvcCreates' : True, # bool
    'SvcMapping' : [ 'EvtDataSvc/EventDataSvc' , 'DetDataSvc/DetectorDataSvc' , 'HistogramSvc/HistogramDataSvc' , 'HbookCnv::PersSvc/HbookHistSvc' , 'RootHistCnv::PersSvc/RootHistSvc' , 'EvtPersistencySvc/EventPersistencySvc' , 'DetPersistencySvc/DetectorPersistencySvc' , 'HistogramPersistencySvc/HistogramPersistencySvc' ], # list
    'SvcOptMapping' : [  ], # list
    'TopAlg' : [  ], # list
    'OutStream' : [  ], # list
    'OutStreamType' : 'OutputStream', # str
    'MessageSvcType' : 'MessageSvc', # str
    'JobOptionsSvcType' : 'JobOptionsSvc', # str
    'Runable' : 'AppMgrRunable', # str
    'EventLoop' : 'EventLoopMgr', # str
    'HistogramPersistency' : 'NONE', # str
    'JobOptionsType' : 'FILE', # str
    'JobOptionsPath' : '', # str
    'EvtMax' : -1, # int
    'EvtSel' : '', # str
    'OutputLevel' : 3, # int
    'MultiThreadExtSvc' : [  ], # list
    'NoOfThreads' : 0, # int
    'AppName' : 'ApplicationMgr', # str
    'AppVersion' : '', # str
    'AuditTools' : False, # bool
    'AuditServices' : False, # bool
    'AuditAlgorithms' : False, # bool
    'ActivateHistory' : False, # bool
    'StatusCodeCheck' : False, # bool
    'Environment' : {  }, # list
    'InitializationLoopCheck' : True, # bool
    'PropertiesPrint' : False, # bool
    'PluginDebugLevel' : 0, # int
    'StopOnSignal' : False, # bool
    'StalledEventMonitoring' : False, # bool
    'ReturnCode' : 0, # int
    'AlgTypeAliases' : {  }, # list
  }
  _propertyDocDct = { 
    'StalledEventMonitoring' : """ Flag to enable/disable the monitoring and reporting of stalled events """,
    'StopOnSignal' : """ Flag to enable/disable the signal handler that schedule a stop of the event loop """,
    'AlgTypeAliases' : """ Aliases of algorithm types, to replace an algorithm type for every instance """,
    'PropertiesPrint' : """ Flag to activate the printout of properties """,
    'ReturnCode' : """ Return code of the application. Set internally in case of error conditions. """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ApplicationMgr, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'ApplicationMgr'
  pass # class ApplicationMgr

class DODBasicMapper( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 0, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'Nodes' : {  }, # list
    'Algorithms' : {  }, # list
  }
  _propertyDocDct = { 
    'Algorithms' : """ Map of algorithms to be used to produce entries (path -> alg_name). """,
    'Nodes' : """ Map of the type of nodes to be associated to paths (path -> data_type). """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(DODBasicMapper, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'DODBasicMapper'
  pass # class DODBasicMapper

class DataOnDemandSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'IncidentName' : 'DataFault', # str
    'DataSvc' : 'EventDataSvc', # str
    'UsePreceedingPath' : True, # bool
    'Dump' : False, # bool
    'PreInitialize' : False, # bool
    'AllowPreInitializeFailure' : False, # bool
    'Algorithms' : [  ], # list
    'Nodes' : [  ], # list
    'AlgMap' : {  }, # list
    'NodeMap' : {  }, # list
    'Prefix' : '/Event/', # str
    'NodeMappingTools' : [  ], # list
    'AlgMappingTools' : [  ], # list
  }
  _propertyDocDct = { 
    'Dump' : """ Dump the configuration and stastics """,
    'AllowPreInitializeFailure' : """ Allow (pre)initialization of algorithms to fail without stopping the application """,
    'PreInitialize' : """ Flag to (pre)initialize all algorithms """,
    'NodeMappingTools' : """ List of tools of type IDODNodeMapper """,
    'IncidentName' : """ The type of handled Incident """,
    'AlgMappingTools' : """ List of tools of type IDODAlgMapper """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(DataOnDemandSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'DataOnDemandSvc'
  pass # class DataOnDemandSvc

class DataStreamTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 0, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(DataStreamTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'DataStreamTool'
  pass # class DataStreamTool

class EventCollectionSelector( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'CnvService' : 'EvtTupleSvc', # str
    'Authentication' : '', # str
    'Container' : 'B2PiPi', # str
    'Item' : 'Address', # str
    'Criteria' : '', # str
    'DB' : '', # str
    'DbType' : '', # str
    'DbService' : '', # str
    'Function' : 'NTuple::Selector', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EventCollectionSelector, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'EventCollectionSelector'
  pass # class EventCollectionSelector

class EventLoopMgr( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'TopAlg' : [  ], # list
    'OutStream' : [  ], # list
    'OutStreamType' : 'OutputStream', # str
    'HistogramPersistency' : '', # str
    'EvtSel' : '', # str
    'Warnings' : True, # bool
  }
  _propertyDocDct = { 
    'Warnings' : """ Set this property to false to suppress warning messages """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EventLoopMgr, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'EventLoopMgr'
  pass # class EventLoopMgr

class EventSelector( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Input' : [  ], # list
    'FirstEvent' : 0, # int
    'EvtMax' : 2147483647, # int
    'PrintFreq' : 10, # int
    'StreamManager' : 'DataStreamTool', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EventSelector, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'EventSelector'
  pass # class EventSelector

class IncidentSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
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
      super(IncidentSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'IncidentSvc'
  pass # class IncidentSvc

class JobOptionsSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
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
      super(JobOptionsSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'JobOptionsSvc'
  pass # class JobOptionsSvc

class MessageSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Format' : '% F%18W%S%7W%R%T %0W%M', # str
    'timeFormat' : '%Y-%m-%d %H:%M:%S,%f', # str
    'showStats' : False, # bool
    'statLevel' : 0, # int
    'setVerbose' : [  ], # list
    'setDebug' : [  ], # list
    'setInfo' : [  ], # list
    'setWarning' : [  ], # list
    'setError' : [  ], # list
    'setFatal' : [  ], # list
    'setAlways' : [  ], # list
    'useColors' : False, # bool
    'fatalColorCode' : [  ], # list
    'errorColorCode' : [  ], # list
    'warningColorCode' : [  ], # list
    'infoColorCode' : [  ], # list
    'debugColorCode' : [  ], # list
    'verboseColorCode' : [  ], # list
    'alwaysColorCode' : [  ], # list
    'fatalLimit' : 500, # int
    'errorLimit' : 500, # int
    'warningLimit' : 500, # int
    'infoLimit' : 500, # int
    'debugLimit' : 500, # int
    'verboseLimit' : 500, # int
    'alwaysLimit' : 0, # int
    'defaultLimit' : 500, # int
    'enableSuppression' : False, # bool
    'countInactive' : False, # bool
    'loggedStreams' : {  }, # list
  }
  _propertyDocDct = { 
    'loggedStreams' : """ MessageStream sources we want to dump into a logfile """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MessageSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'MessageSvc'
  pass # class MessageSvc

class MinimalEventLoopMgr( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'TopAlg' : [  ], # list
    'OutStream' : [  ], # list
    'OutStreamType' : 'OutputStream', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MinimalEventLoopMgr, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'MinimalEventLoopMgr'
  pass # class MinimalEventLoopMgr

class ToolSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
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
      super(ToolSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCoreSvc'
  def getType( self ):
      return 'ToolSvc'
  pass # class ToolSvc
