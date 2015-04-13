#Mon Feb 16 20:16:00 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class ErrorTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
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
    'ContextService' : 'AlgContextSvc', # str
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'StatPrint' : """ Print the table of counters """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'ContextService' : """ The name of Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ErrorTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'ErrorTool'
  pass # class ErrorTool

class EventCounter( ConfigurableAlgorithm ) :
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
    'Frequency' : 1, # int
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EventCounter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'EventCounter'
  pass # class EventCounter

class EventNodeKiller( ConfigurableAlgorithm ) :
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
    'Nodes' : [  ], # list
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
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EventNodeKiller, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'EventNodeKiller'
  pass # class EventNodeKiller

class GaudiAlgorithm( ConfigurableAlgorithm ) :
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
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'GaudiAlgorithm'
  pass # class GaudiAlgorithm

class GaudiSequencer( ConfigurableAlgorithm ) :
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
    'Members' : [  ], # list
    'ModeOR' : False, # bool
    'IgnoreFilterPassed' : False, # bool
    'MeasureTime' : False, # bool
    'ReturnOK' : False, # bool
    'ShortCircuit' : True, # bool
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
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiSequencer, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'GaudiSequencer'
  pass # class GaudiSequencer

class HistoTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
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
    'ContextService' : 'AlgContextSvc', # str
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'AlgTool', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'HistoDir' : """ Histogram Directory """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'HistoCountersPrint' : """ Switch on/off the printout of histogram counters at finalization """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'AutoStringIDPurgeMap' : """ Map of strings to search and replace when using the title as the basis of automatically generated literal IDs """,
    'StatPrint' : """ Print the table of counters """,
    'HistoPrint' : """ Switch on/off the printout of histograms at finalization """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'HistoOffSet' : """ OffSet for automatically assigned histogram numerical identifiers  """,
    'HistoCheckForNaN' : """ Switch on/off the checks for NaN and Infinity for histogram fill """,
    'ShortFormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'HeaderFor1DHistoTable' : """ The table header for printout of 1D histograms  """,
    'ContextService' : """ The name of Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HistoTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'HistoTool'
  pass # class HistoTool

class Prescaler( ConfigurableAlgorithm ) :
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
    'PercentPass' : 100.00000, # float
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
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Prescaler, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'Prescaler'
  pass # class Prescaler

class Sequencer( ConfigurableAlgorithm ) :
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
    'Members' : [  ], # list
    'BranchMembers' : [  ], # list
    'StopOverride' : False, # bool
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Sequencer, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'Sequencer'
  pass # class Sequencer

class SequencerTimerTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
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
    'ContextService' : 'AlgContextSvc', # str
    'HistoProduce' : False, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'AlgTool', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'shots' : 3500000, # int
    'Normalised' : False, # bool
    'GlobalTiming' : False, # bool
    'NameSize' : 30, # int
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'HistoDir' : """ Histogram Directory """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'HistoCountersPrint' : """ Switch on/off the printout of histogram counters at finalization """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'AutoStringIDPurgeMap' : """ Map of strings to search and replace when using the title as the basis of automatically generated literal IDs """,
    'StatPrint' : """ Print the table of counters """,
    'HistoPrint' : """ Switch on/off the printout of histograms at finalization """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'NameSize' : """ Number of characters to be used in algorithm name column """,
    'HistoOffSet' : """ OffSet for automatically assigned histogram numerical identifiers  """,
    'HistoCheckForNaN' : """ Switch on/off the checks for NaN and Infinity for histogram fill """,
    'ShortFormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'HeaderFor1DHistoTable' : """ The table header for printout of 1D histograms  """,
    'ContextService' : """ The name of Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(SequencerTimerTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'SequencerTimerTool'
  pass # class SequencerTimerTool

class TimingAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'OptimizedForDOD' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TimingAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'TimingAuditor'
  pass # class TimingAuditor

class TupleTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
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
    'ContextService' : 'AlgContextSvc', # str
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'AlgTool', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'NTupleProduce' : True, # bool
    'NTuplePrint' : True, # bool
    'NTupleSplitDir' : False, # bool
    'NTupleOffSet' : 0, # int
    'NTupleLUN' : 'FILE1', # str
    'NTupleTopDir' : '', # str
    'NTupleDir' : 'AlgTool', # str
    'EvtColsProduce' : False, # bool
    'EvtColsPrint' : False, # bool
    'EvtColSplitDir' : False, # bool
    'EvtColOffSet' : 0, # int
    'EvtColLUN' : 'EVTCOL', # str
    'EvtColTopDir' : '', # str
    'EvtColDir' : 'AlgTool', # str
  }
  _propertyDocDct = { 
    'NTuplePrint' : """ Print N-tuple statistics """,
    'NTupleProduce' : """ General switch to enable/disable N-tuples """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'EvtColLUN' : """ Logical File Unit for Event Tag Collections """,
    'EvtColOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'NTupleTopDir' : """ Top-level directory for N-Tuples """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'NTupleOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoDir' : """ Histogram Directory """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'HistoCountersPrint' : """ Switch on/off the printout of histogram counters at finalization """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'AutoStringIDPurgeMap' : """ Map of strings to search and replace when using the title as the basis of automatically generated literal IDs """,
    'StatPrint' : """ Print the table of counters """,
    'HistoPrint' : """ Switch on/off the printout of histograms at finalization """,
    'NTupleLUN' : """ Logical File Unit for N-tuples """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'NTupleDir' : """ Subdirectory for N-Tuples """,
    'EvtColDir' : """ Subdirectory for Event Tag Collections """,
    'EvtColTopDir' : """ Top-level directory for Event Tag Collections """,
    'EvtColSplitDir' : """ Split long directory names into short pieces """,
    'HistoOffSet' : """ OffSet for automatically assigned histogram numerical identifiers  """,
    'HistoCheckForNaN' : """ Switch on/off the checks for NaN and Infinity for histogram fill """,
    'EvtColsPrint' : """ Print statistics for Event Tag Collections  """,
    'EvtColsProduce' : """ General switch to enable/disable Event Tag Collections """,
    'ShortFormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'HeaderFor1DHistoTable' : """ The table header for printout of 1D histograms  """,
    'NTupleSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'ContextService' : """ The name of Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TupleTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiAlg'
  def getType( self ):
      return 'TupleTool'
  pass # class TupleTool
