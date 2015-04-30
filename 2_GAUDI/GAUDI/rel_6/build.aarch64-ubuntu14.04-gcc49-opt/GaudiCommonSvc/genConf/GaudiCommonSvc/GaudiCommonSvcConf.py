#Wed Apr 29 15:55:19 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class AlgContextSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Check' : True, # bool
  }
  _propertyDocDct = { 
    'Check' : """ Flag to perform more checks """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(AlgContextSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'AlgContextSvc'
  pass # class AlgContextSvc

class AuditorSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Auditors' : [  ], # list
    'Enable' : True, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(AuditorSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'AuditorSvc'
  pass # class AuditorSvc

class ChronoStatSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'ChronoPrintOutTable' : True, # bool
    'ChronoDestinationCout' : False, # bool
    'ChronoPrintLevel' : 3, # int
    'ChronoTableToBeOrdered' : True, # bool
    'PrintUserTime' : True, # bool
    'PrintSystemTime' : False, # bool
    'PrintEllapsedTime' : False, # bool
    'StatPrintOutTable' : True, # bool
    'StatDestinationCout' : False, # bool
    'StatPrintLevel' : 3, # int
    'StatTableToBeOrdered' : True, # bool
    'NumberOfSkippedEventsForMemStat' : -1, # int
    'AsciiStatsOutputFile' : '', # str
    'StatTableHeader' : '     Counter     |     #     |    sum     | mean/eff^* | rms/err^*  |     min     |     max     |', # str
    'RegularRowFormat' : ' %|-15.15s|%|17t||%|10d| |%|11.7g| |%|#11.5g| |%|#11.5g| |%|#12.5g| |%|#12.5g| |', # str
    'EfficiencyRowFormat' : '*%|-15.15s|%|17t||%|10d| |%|11.5g| |(%|#9.7g| +- %|-#9.7g|)%%|   -------   |   -------   |', # str
    'UseEfficiencyRowFormat' : True, # bool
    'PerEventFile' : '', # str
  }
  _propertyDocDct = { 
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'AsciiStatsOutputFile' : """ Name of the output file storing the stats. If empty, no statistics will be saved (default) """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PerEventFile' : """ File name for per-event deltas """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ChronoStatSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'ChronoStatSvc'
  pass # class ChronoStatSvc

class CounterSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'PrintStat' : True, # bool
    'StatTableHeader' : '       Counter :: Group         |     #     |    sum     | mean/eff^* | rms/err^*  |     min     |     max     |', # str
    'RegularRowFormat' : ' %|15.15s|%|-15.15s|%|32t||%|10d| |%|11.7g| |%|#11.5g| |%|#11.5g| |%|#12.5g| |%|#12.5g| |', # str
    'EfficiencyRowFormat' : '*%|15.15s|%|-15.15s|%|32t||%|10d| |%|11.5g| |(%|#9.7g| +- %|-#9.7g|)%%|   -------   |   -------   |', # str
    'UseEfficiencyRowFormat' : True, # bool
  }
  _propertyDocDct = { 
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'EfficiencyRowFormat' : """ The format for the regular row in the outptu Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(CounterSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'CounterSvc'
  pass # class CounterSvc

class DataSvcFileEntriesTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'DataService' : 'EventDataSvc', # str
    'Root' : '', # str
    'ScanOnBeginEvent' : False, # bool
    'IgnoreOriginChange' : False, # bool
  }
  _propertyDocDct = { 
    'IgnoreOriginChange' : """ Disable the detection of the change in the origin of object between the BeginEvent and the scan """,
    'DataService' : """ Name of the data service to use """,
    'Root' : """ Path to the element from which to start the scan """,
    'ScanOnBeginEvent' : """ If the scan has to be started during the BeginEvent incident (true) or on demand (false, default) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(DataSvcFileEntriesTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'DataSvcFileEntriesTool'
  pass # class DataSvcFileEntriesTool

class DetPersistencySvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'CnvServices' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(DetPersistencySvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'DetPersistencySvc'
  pass # class DetPersistencySvc

class EvtCollectionStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'EvtDataSvc' : 'TagCollectionSvc', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EvtCollectionStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'EvtCollectionStream'
  pass # class EvtCollectionStream

class EvtDataSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 110, # int
    'RootName' : '/Event', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EvtDataSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'EvtDataSvc'
  pass # class EvtDataSvc

class EvtPersistencySvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'CnvServices' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EvtPersistencySvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'EvtPersistencySvc'
  pass # class EvtPersistencySvc

class FileRecordDataSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 110, # int
    'RootName' : '/FileRecords', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'AutoLoad' : True, # bool
    'IncidentName' : 'NEW_FILE_RECORD', # str
    'SaveIncident' : 'SAVE_FILE_RECORD', # str
    'PersistencySvc' : 'PersistencySvc/FileRecordPersistencySvc', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(FileRecordDataSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'FileRecordDataSvc'
  pass # class FileRecordDataSvc

class HistogramPersistencySvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'CnvServices' : [ 'RootHistSvc' ], # list
    'HistogramPersistency' : '', # str
    'OutputFile' : '', # str
    'ConvertHistos' : [  ], # list
    'ExcludeHistos' : [  ], # list
    'Warnings' : True, # bool
  }
  _propertyDocDct = { 
    'ConvertHistos' : """ The list of patterns to be accepted for conversion """,
    'Warnings' : """ Set this property to false to suppress warning messages """,
    'ExcludeHistos' : """ The list of patterns to be excluded for conversion """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HistogramPersistencySvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'HistogramPersistencySvc'
  pass # class HistogramPersistencySvc

class HistogramSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 1, # int
    'RootName' : '/stat', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'Input' : [  ], # list
    'Predefined1DHistos' : {  }, # list
  }
  _propertyDocDct = { 
    'Predefined1DHistos' : """ Histograms with predefined parameters """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HistogramSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'HistogramSvc'
  pass # class HistogramSvc

class InputCopyStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'OptItemList' : [  ], # list
    'AlgDependentItemList' : {  }, # list
    'Preload' : False, # bool
    'PreloadOptItems' : False, # bool
    'Output' : '', # str
    'OutputFile' : '', # str
    'EvtDataSvc' : 'EventDataSvc', # str
    'EvtConversionSvc' : 'EventPersistencySvc', # str
    'AcceptAlgs' : [  ], # list
    'RequireAlgs' : [  ], # list
    'VetoAlgs' : [  ], # list
    'VerifyItems' : True, # bool
    'TESVetoList' : [  ], # list
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(InputCopyStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'InputCopyStream'
  pass # class InputCopyStream

class MultiStoreSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 110, # int
    'RootName' : '/Event', # str
    'Partitions' : [  ], # list
    'DataLoader' : 'EventPersistencySvc', # str
    'DefaultPartition' : 'Default', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MultiStoreSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'MultiStoreSvc'
  pass # class MultiStoreSvc

class OutputStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'OptItemList' : [  ], # list
    'AlgDependentItemList' : {  }, # list
    'Preload' : True, # bool
    'PreloadOptItems' : False, # bool
    'Output' : '', # str
    'OutputFile' : '', # str
    'EvtDataSvc' : 'EventDataSvc', # str
    'EvtConversionSvc' : 'EventPersistencySvc', # str
    'AcceptAlgs' : [  ], # list
    'RequireAlgs' : [  ], # list
    'VetoAlgs' : [  ], # list
    'VerifyItems' : True, # bool
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(OutputStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'OutputStream'
  pass # class OutputStream

class PartitionSwitchAlg( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'Partition' : '', # str
    'Tool' : 'PartitionSwitchTool', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(PartitionSwitchAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'PartitionSwitchAlg'
  pass # class PartitionSwitchAlg

class PartitionSwitchTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'Actor' : 'EventDataService', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(PartitionSwitchTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'PartitionSwitchTool'
  pass # class PartitionSwitchTool

class PersistencySvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'CnvServices' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(PersistencySvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'PersistencySvc'
  pass # class PersistencySvc

class RecordDataSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 110, # int
    'RootName' : '/Records', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'AutoLoad' : True, # bool
    'IncidentName' : '', # str
    'SaveIncident' : 'SAVE_RECORD', # str
    'PersistencySvc' : 'PersistencySvc/RecordPersistencySvc', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RecordDataSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'RecordDataSvc'
  pass # class RecordDataSvc

class RecordStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'OptItemList' : [  ], # list
    'AlgDependentItemList' : {  }, # list
    'Preload' : True, # bool
    'PreloadOptItems' : False, # bool
    'Output' : '', # str
    'OutputFile' : '', # str
    'EvtDataSvc' : 'EventDataSvc', # str
    'EvtConversionSvc' : 'EventPersistencySvc', # str
    'AcceptAlgs' : [  ], # list
    'RequireAlgs' : [  ], # list
    'VetoAlgs' : [  ], # list
    'VerifyItems' : True, # bool
    'FireIncidents' : False, # bool
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RecordStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'RecordStream'
  pass # class RecordStream

class RunRecordDataSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 110, # int
    'RootName' : '/RunRecords', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'AutoLoad' : True, # bool
    'IncidentName' : 'NEW_RUN_RECORD', # str
    'SaveIncident' : 'SAVE_RUN_RECORD', # str
    'PersistencySvc' : 'PersistencySvc/RecordPersistencySvc', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RunRecordDataSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'RunRecordDataSvc'
  pass # class RunRecordDataSvc

class RunRecordStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'OptItemList' : [  ], # list
    'AlgDependentItemList' : {  }, # list
    'Preload' : True, # bool
    'PreloadOptItems' : False, # bool
    'Output' : '', # str
    'OutputFile' : '', # str
    'EvtDataSvc' : 'EventDataSvc', # str
    'EvtConversionSvc' : 'EventPersistencySvc', # str
    'AcceptAlgs' : [  ], # list
    'RequireAlgs' : [  ], # list
    'VetoAlgs' : [  ], # list
    'VerifyItems' : True, # bool
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RunRecordStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'RunRecordStream'
  pass # class RunRecordStream

class SequentialOutputStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'OptItemList' : [  ], # list
    'AlgDependentItemList' : {  }, # list
    'Preload' : True, # bool
    'PreloadOptItems' : False, # bool
    'Output' : '', # str
    'OutputFile' : '', # str
    'EvtDataSvc' : 'EventDataSvc', # str
    'EvtConversionSvc' : 'EventPersistencySvc', # str
    'AcceptAlgs' : [  ], # list
    'RequireAlgs' : [  ], # list
    'VetoAlgs' : [  ], # list
    'VerifyItems' : True, # bool
    'EventsPerFile' : 4294967295, # int
    'NumericFilename' : False, # bool
    'NumbersAdded' : 6, # int
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(SequentialOutputStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'SequentialOutputStream'
  pass # class SequentialOutputStream

class StatusCodeSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Filter' : [  ], # list
    'AbortOnError' : False, # bool
    'SuppressCheck' : False, # bool
    'IgnoreDicts' : True, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(StatusCodeSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'StatusCodeSvc'
  pass # class StatusCodeSvc

class StoreExplorerAlg( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'Load' : False, # bool
    'PrintEvt' : 1, # int
    'PrintMissing' : 0, # int
    'PrintFreq' : 0.0000000, # float
    'ExploreRelations' : False, # bool
    'DataSvc' : 'EventDataSvc', # str
    'TestAccess' : False, # bool
    'AccessForeign' : False, # bool
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(StoreExplorerAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'StoreExplorerAlg'
  pass # class StoreExplorerAlg

class StoreSnifferAlg( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(StoreSnifferAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'StoreSnifferAlg'
  pass # class StoreSnifferAlg

class TagCollectionStream( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'ItemList' : [  ], # list
    'OptItemList' : [  ], # list
    'AlgDependentItemList' : {  }, # list
    'Preload' : True, # bool
    'PreloadOptItems' : False, # bool
    'Output' : '', # str
    'OutputFile' : '', # str
    'EvtDataSvc' : 'EventDataSvc', # str
    'EvtConversionSvc' : 'EventPersistencySvc', # str
    'AcceptAlgs' : [  ], # list
    'RequireAlgs' : [  ], # list
    'VetoAlgs' : [  ], # list
    'VerifyItems' : True, # bool
    'AddressLeaf' : '/Event', # str
    'AddressColumn' : 'Address', # str
    'TagCollectionSvc' : 'NTupleSvc', # str
    'ObjectsFirst' : True, # bool
    'Collection' : '', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TagCollectionStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiCommonSvc'
  def getType( self ):
      return 'TagCollectionStream'
  pass # class TagCollectionStream
