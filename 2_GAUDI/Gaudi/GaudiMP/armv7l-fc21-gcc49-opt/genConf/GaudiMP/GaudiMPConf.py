#Mon Feb 16 20:49:53 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class IoComponentMgr( ConfigurableService ) :
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
      super(IoComponentMgr, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiMP'
  def getType( self ):
      return 'IoComponentMgr'
  pass # class IoComponentMgr

class RecordOutputStream( ConfigurableAlgorithm ) :
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
    'RegisterForContextService' : True, # bool
    'ErrorsPrint' : True, # bool
    'PropertiesPrint' : False, # bool
    'StatPrint' : True, # bool
    'TypePrint' : True, # bool
    'Context' : '', # str
    'RootInTES' : '', # str
    'RootOnTES' : '', # str
    'GlobalTimeOffset' : 0.0000000, # float
    'StatTableHeader' : ' |    Counter                                      |     #     |    sum     | mean/eff^* | rms/err^*  |     min     |     max     |', # str
    'RegularRowFormat' : ' | %|-48.48s|%|50t||%|10d| |%|11.7g| |%|#11.5g| |%|#11.5g| |%|#12.5g| |%|#12.5g| |', # str
    'EfficiencyRowFormat' : ' |*%|-48.48s|%|50t||%|10d| |%|11.5g| |(%|#9.6g| +- %|-#9.6g|)%%|   -------   |   -------   |', # str
    'UseEfficiencyRowFormat' : True, # bool
    'CounterList' : [ '.*' ], # list
    'StatEntityList' : [  ], # list
    'VetoObjects' : [  ], # list
    'RequireObjects' : [  ], # list
    'OutputStreamName' : '', # str
  }
  _propertyDocDct = { 
    'OutputStreamName' : """ Name of the OutputStream instance should be triggered. """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'StatPrint' : """ Print the table of counters """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RecordOutputStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiMP'
  def getType( self ):
      return 'RecordOutputStream'
  pass # class RecordOutputStream

class ReplayOutputStream( ConfigurableAlgorithm ) :
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
    'RegisterForContextService' : True, # bool
    'ErrorsPrint' : True, # bool
    'PropertiesPrint' : False, # bool
    'StatPrint' : True, # bool
    'TypePrint' : True, # bool
    'Context' : '', # str
    'RootInTES' : '', # str
    'RootOnTES' : '', # str
    'GlobalTimeOffset' : 0.0000000, # float
    'StatTableHeader' : ' |    Counter                                      |     #     |    sum     | mean/eff^* | rms/err^*  |     min     |     max     |', # str
    'RegularRowFormat' : ' | %|-48.48s|%|50t||%|10d| |%|11.7g| |%|#11.5g| |%|#11.5g| |%|#12.5g| |%|#12.5g| |', # str
    'EfficiencyRowFormat' : ' |*%|-48.48s|%|50t||%|10d| |%|11.5g| |(%|#9.6g| +- %|-#9.6g|)%%|   -------   |   -------   |', # str
    'UseEfficiencyRowFormat' : True, # bool
    'CounterList' : [ '.*' ], # list
    'StatEntityList' : [  ], # list
    'VetoObjects' : [  ], # list
    'RequireObjects' : [  ], # list
    'OutputStreams' : [  ], # list
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'StatPrint' : """ Print the table of counters """,
    'OutputStreams' : """ OutputStream instances that can be called. """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ReplayOutputStream, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiMP'
  def getType( self ):
      return 'ReplayOutputStream'
  pass # class ReplayOutputStream
