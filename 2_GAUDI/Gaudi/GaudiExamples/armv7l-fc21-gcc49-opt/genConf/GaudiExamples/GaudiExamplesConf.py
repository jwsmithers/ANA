#Mon Feb 16 20:58:31 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.GaudiHandles import *
from GaudiKernel.Proxy.Configurable import *

class AbortEventAlg( ConfigurableAlgorithm ) :
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
    'AbortedEventNumber' : 3, # int
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
    'AbortedEventNumber' : """ At which event to trigger an abort """,
    'StatPrint' : """ Print the table of counters """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(AbortEventAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'AbortEventAlg'
  pass # class AbortEventAlg

class Aida2Root( ConfigurableAlgorithm ) :
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
    'PropertiesPrint' : True, # bool
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'Histos1D' : [ 'SimpleHistos/Gaussian mean=0, sigma=1' , 'SimpleHistos/101' , 'SimpleHistos/102' , 'SimpleHistos/1111' , 'SimpleHistos/test1' , 'SimpleHistos/subdir2/bino' , 'SimpleHistos/subdir1/bino' , 'SimpleHistos/poisson' ], # list
    'Histos2D' : [ 'SimpleHistos/Gaussian V Flat' , 'SimpleHistos/Exponential V Flat' , 'SimpleHistos/binVpois' , 'SimpleHistos/expoVpois' ], # list
    'Histos3D' : [ 'SimpleHistos/3D plot AutoID' , 'SimpleHistos/3d' ], # list
    'Profs1D' : [ 'SimpleHistos/Expo V Gauss 1DProf' ], # list
    'Profs2D' : [ 'SimpleHistos/321' , 'SimpleHistos/2dprof' ], # list
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Aida2Root, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Aida2Root'
  pass # class Aida2Root

class AuditorTestAlg( ConfigurableAlgorithm ) :
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
      super(AuditorTestAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'AuditorTestAlg'
  pass # class AuditorTestAlg

class ColorMsgAlg( ConfigurableAlgorithm ) :
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
      super(ColorMsgAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ColorMsgAlg'
  pass # class ColorMsgAlg

class CounterAlg( ConfigurableAlgorithm ) :
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
      super(CounterAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'CounterAlg'
  pass # class CounterAlg

class CpuHungryAlg( ConfigurableAlgorithm ) :
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
    'Loops' : 1000000, # int
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
      super(CpuHungryAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'CpuHungryAlg'
  pass # class CpuHungryAlg

class DataCreator( ConfigurableAlgorithm ) :
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
    'Data' : '/Event/Unknown', # str
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
      super(DataCreator, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'DataCreator'
  pass # class DataCreator

class EqSolverGenAlg( ConfigurableAlgorithm ) :
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
      super(EqSolverGenAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'EqSolverGenAlg'
  pass # class EqSolverGenAlg

class EqSolverIAlg( ConfigurableAlgorithm ) :
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
      super(EqSolverIAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'EqSolverIAlg'
  pass # class EqSolverIAlg

class EqSolverPAlg( ConfigurableAlgorithm ) :
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
      super(EqSolverPAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'EqSolverPAlg'
  pass # class EqSolverPAlg

class ErrorLogTest( ConfigurableAlgorithm ) :
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
      super(ErrorLogTest, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ErrorLogTest'
  pass # class ErrorLogTest

class EvtCollectionWrite( ConfigurableAlgorithm ) :
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
    'NumMcTracks' : 50, # int
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(EvtCollectionWrite, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'EvtCollectionWrite'
  pass # class EvtCollectionWrite

class ExtendedProperties( ConfigurableAlgorithm ) :
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
    'PropertiesPrint' : True, # bool
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
    'PairDD' : ( 0.00000000 , 0.00000000 ), # list
    'VectorOfPairsDD' : [  ], # list
    'VectorOfVectorsString' : [  ], # list
    'VectorOfVectorsDouble' : [  ], # list
    'MapIntDouble' : {  }, # list
    'MapStringString' : {  }, # list
    'MapStringInt' : {  }, # list
    'MapStringDouble' : {  }, # list
    'MapStringVectorOfStrings' : {  }, # list
    'PairII' : ( 0 , 0 ), # list
    'MapStringVectorOfDoubles' : {  }, # list
    'MapStringVectorOfInts' : {  }, # list
    'MapIntInt' : {  }, # list
    'VectorOfPairsII' : [  ], # list
    'MapIntString' : {  }, # list
    'MapUIntString' : {  }, # list
    'EmptyMap' : { 'key' : 'value' }, # list
    'EmptyVector' : [ 123 ], # list
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
      super(ExtendedProperties, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ExtendedProperties'
  pass # class ExtendedProperties

class FileMgrTest( ConfigurableAlgorithm ) :
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
      super(FileMgrTest, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'FileMgrTest'
  pass # class FileMgrTest

class FuncMinimumGenAlg( ConfigurableAlgorithm ) :
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
      super(FuncMinimumGenAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'FuncMinimumGenAlg'
  pass # class FuncMinimumGenAlg

class FuncMinimumIAlg( ConfigurableAlgorithm ) :
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
      super(FuncMinimumIAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'FuncMinimumIAlg'
  pass # class FuncMinimumIAlg

class FuncMinimumPAlg( ConfigurableAlgorithm ) :
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
      super(FuncMinimumPAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'FuncMinimumPAlg'
  pass # class FuncMinimumPAlg

class Gaudi__Examples__ArrayProperties( ConfigurableAlgorithm ) :
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
    'Doubles' : ( -10.00000000 , -10.00000000 , -10.00000000 , -10.00000000 , -10.00000000 ), # list
    'Strings' : ( 'blah-blah-blah' , 'blah-blah-blah' , 'blah-blah-blah' , 'blah-blah-blah' ), # list
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
    'Strings' : """ C-array of strings """,
    'Doubles' : """ C-array of doubles """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__ArrayProperties, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::ArrayProperties'
  pass # class Gaudi__Examples__ArrayProperties

class Gaudi__Examples__BoostArrayProperties( ConfigurableAlgorithm ) :
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
    'Doubles' : ( -1.00000000 , -1.00000000 , -1.00000000 , -1.00000000 , -1.00000000 ), # list
    'Strings' : ( 'bla-bla' , 'bla-bla' , 'bla-bla' , 'bla-bla' ), # list
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
    'Strings' : """ Boost-array of strings """,
    'Doubles' : """ Boost-array of doubles """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__BoostArrayProperties, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::BoostArrayProperties'
  pass # class Gaudi__Examples__BoostArrayProperties

class Gaudi__Examples__EvtColAlg( ConfigurableAlgorithm ) :
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
    'PropertiesPrint' : True, # bool
    'StatPrint' : True, # bool
    'TypePrint' : False, # bool
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'NTupleProduce' : False, # bool
    'NTuplePrint' : False, # bool
    'NTupleSplitDir' : False, # bool
    'NTupleOffSet' : 0, # int
    'NTupleLUN' : 'FILE1', # str
    'NTupleTopDir' : '', # str
    'NTupleDir' : 'DefaultName', # str
    'EvtColsProduce' : True, # bool
    'EvtColsPrint' : True, # bool
    'EvtColSplitDir' : False, # bool
    'EvtColOffSet' : 0, # int
    'EvtColLUN' : 'EVTCOL', # str
    'EvtColTopDir' : '', # str
    'EvtColDir' : 'DefaultName', # str
  }
  _propertyDocDct = { 
    'NTuplePrint' : """ Print N-tuple statistics """,
    'NTupleProduce' : """ General switch to enable/disable N-tuples """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'EvtColLUN' : """ Logical File Unit for Event Tag Collections """,
    'EvtColOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
    'NTupleSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__EvtColAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::EvtColAlg'
  pass # class Gaudi__Examples__EvtColAlg

class Gaudi__Examples__ExtendedEvtCol( ConfigurableAlgorithm ) :
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
    'PropertiesPrint' : True, # bool
    'StatPrint' : True, # bool
    'TypePrint' : False, # bool
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'NTupleProduce' : False, # bool
    'NTuplePrint' : False, # bool
    'NTupleSplitDir' : False, # bool
    'NTupleOffSet' : 0, # int
    'NTupleLUN' : 'FILE1', # str
    'NTupleTopDir' : '', # str
    'NTupleDir' : 'DefaultName', # str
    'EvtColsProduce' : True, # bool
    'EvtColsPrint' : True, # bool
    'EvtColSplitDir' : False, # bool
    'EvtColOffSet' : 0, # int
    'EvtColLUN' : 'EVTCOL', # str
    'EvtColTopDir' : '', # str
    'EvtColDir' : 'DefaultName', # str
    'Tracks' : 'MyTracks', # str
  }
  _propertyDocDct = { 
    'NTuplePrint' : """ Print N-tuple statistics """,
    'NTupleProduce' : """ General switch to enable/disable N-tuples """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'EvtColLUN' : """ Logical File Unit for Event Tag Collections """,
    'EvtColOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
    'NTupleSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__ExtendedEvtCol, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::ExtendedEvtCol'
  pass # class Gaudi__Examples__ExtendedEvtCol

class Gaudi__Examples__ExtendedProperties2( ConfigurableAlgorithm ) :
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
    'PropertiesPrint' : True, # bool
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
    'Point3D' : ( 0.00000000 , 1.00000000 , 2.00000000 ), # list
    'Vector3D' : ( 1.00000000 , 2.00000000 , 3.00000000 ), # list
    'Vector4D' : ( 1.000000000000 , 2.000000000000 , 3.0000000000000 , 4.00000000000000 ), # list
    'SVector5' : ( 0.000000 , 0.000000 , 0.000000 , 0.000000 , 0.000000 ), # list
    'Points3D' : [  ], # list
    'Vectors3D' : [  ], # list
    'Vectors4D' : [  ], # list
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'Points3D' : """ Vector of 3D-points """,
    'Vectors4D' : """ Vector of 4D-vectors """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'Vector3D' : """ 3D-vector """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'Vectors3D' : """ Vector of 3D-vectors """,
    'StatPrint' : """ Print the table of counters """,
    'Point3D' : """ 3D-point """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'SVector5' : """ Generic-vector """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'Vector4D' : """ Lorentz-vector """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__ExtendedProperties2, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::ExtendedProperties2'
  pass # class Gaudi__Examples__ExtendedProperties2

class Gaudi__Examples__HistoProps( ConfigurableAlgorithm ) :
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
    'PropertiesPrint' : True, # bool
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
    'HistoProduce' : True, # bool
    'HistoPrint' : True, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'Histo1' : ('Histogram1',-3.000000,3.000000,200), # list
    'Histo2' : ('Histogram2',-5.000000,5.000000,200), # list
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'Histo2' : """ The parameters for the second histogram """,
    'Histo1' : """ The parameters for the first  histogram """,
    'HistoOffSet' : """ OffSet for automatically assigned histogram numerical identifiers  """,
    'HistoCheckForNaN' : """ Switch on/off the checks for NaN and Infinity for histogram fill """,
    'ShortFormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'HeaderFor1DHistoTable' : """ The table header for printout of 1D histograms  """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__HistoProps, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::HistoProps'
  pass # class Gaudi__Examples__HistoProps

class Gaudi__Examples__MultiInput__DumpAddress( ConfigurableAlgorithm ) :
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
    'OutputFile' : '', # str
    'ObjectPath' : '', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'ObjectPath' : """ Path to the object in the transient store """,
    'OutputFile' : """ Name of the output file """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__MultiInput__DumpAddress, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::MultiInput::DumpAddress'
  pass # class Gaudi__Examples__MultiInput__DumpAddress

class Gaudi__Examples__MultiInput__ReadAlg( ConfigurableAlgorithm ) :
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
    'AddressesFile' : '', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'AddressesFile' : """ File containing the address details of the extra data. """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__MultiInput__ReadAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::MultiInput::ReadAlg'
  pass # class Gaudi__Examples__MultiInput__ReadAlg

class Gaudi__Examples__MultiInput__WriteAlg( ConfigurableAlgorithm ) :
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
    'RandomSeeds' : [  ], # list
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'RandomSeeds' : """ Seeds to be used in the random number generation """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__MultiInput__WriteAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::MultiInput::WriteAlg'
  pass # class Gaudi__Examples__MultiInput__WriteAlg

class Gaudi__Examples__SelCreate( ConfigurableAlgorithm ) :
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
      super(Gaudi__Examples__SelCreate, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::SelCreate'
  pass # class Gaudi__Examples__SelCreate

class Gaudi__Examples__SelFilter( ConfigurableAlgorithm ) :
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
    'Input' : '', # str
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
    'Input' : """ TES location of input container """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__SelFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::SelFilter'
  pass # class Gaudi__Examples__SelFilter

class Gaudi__Examples__StringKeyEx( ConfigurableAlgorithm ) :
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
    'Key' : '', # list
    'Keys' : [  ], # list
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
    'Key' : """ The string key """,
    'StatPrint' : """ Print the table of counters """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'Keys' : """ The vector of keys """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__Examples__StringKeyEx, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Gaudi::Examples::StringKeyEx'
  pass # class Gaudi__Examples__StringKeyEx

class GaudiCommonTests( ConfigurableAlgorithm ) :
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
      super(GaudiCommonTests, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiCommonTests'
  pass # class GaudiCommonTests

class GaudiEx__QotdAlg( ConfigurableAlgorithm ) :
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
      super(GaudiEx__QotdAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiEx::QotdAlg'
  pass # class GaudiEx__QotdAlg

class GaudiExamples__CounterSvcAlg( ConfigurableAlgorithm ) :
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
    'CounterBaseName' : 'CounterTest', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiExamples__CounterSvcAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiExamples::CounterSvcAlg'
  pass # class GaudiExamples__CounterSvcAlg

class GaudiExamples__GaudiPPS( ConfigurableAlgorithm ) :
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
      super(GaudiExamples__GaudiPPS, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiExamples::GaudiPPS'
  pass # class GaudiExamples__GaudiPPS

class GaudiExamples__LoggingAuditor( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiExamples__LoggingAuditor, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiExamples::LoggingAuditor'
  pass # class GaudiExamples__LoggingAuditor

class GaudiExamples__StatSvcAlg( ConfigurableAlgorithm ) :
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
      super(GaudiExamples__StatSvcAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiExamples::StatSvcAlg'
  pass # class GaudiExamples__StatSvcAlg

class GaudiExamples__TimingAlg( ConfigurableAlgorithm ) :
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
    'Cycles' : 10000, # int
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'Cycles' : """ The number of cycles """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'StatPrint' : """ Print the table of counters """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiExamples__TimingAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiExamples::TimingAlg'
  pass # class GaudiExamples__TimingAlg

class GaudiHistoAlgorithm( ConfigurableAlgorithm ) :
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
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
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiHistoAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiHistoAlgorithm'
  pass # class GaudiHistoAlgorithm

class GaudiTesting__CustomIncidentAlg( ConfigurableAlgorithm ) :
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
    'EventCount' : 3, # int
    'Incident' : '', # str
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
    'Incident' : """ Type of incident to fire. """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'EventCount' : """ Number of events to let go before firing the incident. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__CustomIncidentAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::CustomIncidentAlg'
  pass # class GaudiTesting__CustomIncidentAlg

class GaudiTesting__DestructorCheckAlg( ConfigurableAlgorithm ) :
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
      super(GaudiTesting__DestructorCheckAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::DestructorCheckAlg'
  pass # class GaudiTesting__DestructorCheckAlg

class GaudiTesting__EvenEventsFilter( ConfigurableAlgorithm ) :
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
      super(GaudiTesting__EvenEventsFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::EvenEventsFilter'
  pass # class GaudiTesting__EvenEventsFilter

class GaudiTesting__FailingSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Transition' : '', # str
    'Mode' : 'failure', # str
  }
  _propertyDocDct = { 
    'Transition' : """ In which transition to fail ['initialize', 'start', 'stop', 'finalize'] """,
    'Mode' : """ Type of failure ['failure', 'exception'] """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__FailingSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::FailingSvc'
  pass # class GaudiTesting__FailingSvc

class GaudiTesting__GetDataObjectAlg( ConfigurableAlgorithm ) :
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
    'Paths' : [  ], # list
    'DataSvc' : 'EventDataSvc', # str
    'IgnoreMissing' : False, # bool
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'IgnoreMissing' : """ if True, missing objects will not beconsidered an error """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
    'RegularRowFormat' : """ The format for the regular row in the output Stat-table """,
    'UseEfficiencyRowFormat' : """ Use the special format for printout of efficiency counters """,
    'StatTableHeader' : """ The header row for the output Stat-table """,
    'TypePrint' : """ Add the actal C++ component type into the messages """,
    'StatPrint' : """ Print the table of counters """,
    'DataSvc' : """ Name of the data service to use """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'Paths' : """ List of paths in the transient store to load """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__GetDataObjectAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::GetDataObjectAlg'
  pass # class GaudiTesting__GetDataObjectAlg

class GaudiTesting__OddEventsFilter( ConfigurableAlgorithm ) :
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
      super(GaudiTesting__OddEventsFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::OddEventsFilter'
  pass # class GaudiTesting__OddEventsFilter

class GaudiTesting__PluginService__Algorithm1( ConfigurableAlgorithm ) :
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
      super(GaudiTesting__PluginService__Algorithm1, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::PluginService::Algorithm1'
  pass # class GaudiTesting__PluginService__Algorithm1

class GaudiTesting__PutDataObjectAlg( ConfigurableAlgorithm ) :
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
    'Paths' : [  ], # list
    'DataSvc' : 'EventDataSvc', # str
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
    'DataSvc' : """ Name of the data service to use """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'Paths' : """ List of paths in the transient store to load """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__PutDataObjectAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::PutDataObjectAlg'
  pass # class GaudiTesting__PutDataObjectAlg

class GaudiTesting__SignallingAlg( ConfigurableAlgorithm ) :
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
    'EventCount' : 3, # int
    'Signal' : 2, # int
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
    'Signal' : """ Signal to raise """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'EventCount' : """ Number of events to let go before raising the signal """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__SignallingAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::SignallingAlg'
  pass # class GaudiTesting__SignallingAlg

class GaudiTesting__SleepyAlg( ConfigurableAlgorithm ) :
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
    'SleepTime' : 10, # int
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
    'SleepTime' : """ Seconds to sleep during the execute """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__SleepyAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::SleepyAlg'
  pass # class GaudiTesting__SleepyAlg

class GaudiTesting__StopLoopAlg( ConfigurableAlgorithm ) :
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
    'EventCount' : 3, # int
    'Mode' : 'failure', # str
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
    'Mode' : """ Type of interruption ['exception', 'stopRun', 'failure'] """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'EventCount' : """ Number of events to let go before breaking the event loop """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(GaudiTesting__StopLoopAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'GaudiTesting::StopLoopAlg'
  pass # class GaudiTesting__StopLoopAlg

class HelloWorld( ConfigurableAlgorithm ) :
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
      super(HelloWorld, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'HelloWorld'
  pass # class HelloWorld

class HistoAlgorithm( ConfigurableAlgorithm ) :
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
      super(HistoAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'HistoAlgorithm'
  pass # class HistoAlgorithm

class HistoTimingAlg( ConfigurableAlgorithm ) :
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
    'FullDetail' : False, # bool
    'MonitorHistograms' : True, # bool
    'FormatFor1DHistoTable' : '| %2$-45.45s | %3$=7d |%8$11.5g | %10$-11.5g|%12$11.5g |%14$11.5g |', # str
    'ShortFormatFor1DHistoTable' : ' | %1$-25.25s %2%', # str
    'HeaderFor1DHistoTable' : '|   Title                                       |    #    |     Mean   |    RMS     |  Skewness  |  Kurtosis  |', # str
    'UseSequencialNumericAutoIDs' : False, # bool
    'AutoStringIDPurgeMap' : { '/' : '=SLASH=' }, # list
    'UseLookup' : False, # bool
    'NumHistos' : 20, # int
    'NumTracks' : 30, # int
  }
  _propertyDocDct = { 
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HistoTimingAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'HistoTimingAlg'
  pass # class HistoTimingAlg

class History( ConfigurableAlgorithm ) :
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
      super(History, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'History'
  pass # class History

class IncidentListenerTestAlg( ConfigurableAlgorithm ) :
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
      super(IncidentListenerTestAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'IncidentListenerTestAlg'
  pass # class IncidentListenerTestAlg

class LoopAlg( ConfigurableAlgorithm ) :
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
      super(LoopAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'LoopAlg'
  pass # class LoopAlg

class MapAlg( ConfigurableAlgorithm ) :
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
      super(MapAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MapAlg'
  pass # class MapAlg

class MyAlgorithm( ConfigurableAlgorithm ) :
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
    'ToolWithName' : 'MyTool', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'ToolWithName' : """ Type of the tool to use (internal name is ToolWithName) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MyAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyAlgorithm'
  pass # class MyAlgorithm

class MyAudAlgorithm( ConfigurableAlgorithm ) :
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
      super(MyAudAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyAudAlgorithm'
  pass # class MyAudAlgorithm

class MyAudTool( ConfigurableAlgTool ) :
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
      super(MyAudTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyAudTool'
  pass # class MyAudTool

class MyDataAlgorithm( ConfigurableAlgorithm ) :
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
      super(MyDataAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyDataAlgorithm'
  pass # class MyDataAlgorithm

class MyGaudiAlgorithm( ConfigurableAlgorithm ) :
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
    'ToolWithName' : 'MyTool', # str
    'PrivToolHandle' : PrivateToolHandle('MyTool/PrivToolHandle'), # GaudiHandle
    'PubToolHandle' : PublicToolHandle('MyTool/PubToolHandle'), # GaudiHandle
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
    'ToolWithName' : """ Type of the tool to use (internal name is ToolWithName) """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MyGaudiAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyGaudiAlgorithm'
  pass # class MyGaudiAlgorithm

class MyGaudiTool( ConfigurableAlgTool ) :
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
    'Int' : 100, # int
    'Double' : 100.00000, # float
    'String' : 'hundred', # str
    'Bool' : True, # bool
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
      super(MyGaudiTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyGaudiTool'
  pass # class MyGaudiTool

class MyTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'Int' : 100, # int
    'Double' : 100.00000, # float
    'String' : 'hundred', # str
    'Bool' : True, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(MyTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'MyTool'
  pass # class MyTool

class NTupleAlgorithm( ConfigurableAlgorithm ) :
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
      super(NTupleAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'NTupleAlgorithm'
  pass # class NTupleAlgorithm

class Named1( ConfigurableAlgorithm ) :
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
      super(Named1, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'Named1'
  pass # class Named1

class ParentAlg( ConfigurableAlgorithm ) :
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
      super(ParentAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ParentAlg'
  pass # class ParentAlg

class PartPropExa( ConfigurableAlgorithm ) :
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
      super(PartPropExa, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'PartPropExa'
  pass # class PartPropExa

class PluginServiceTest__MyAlg( ConfigurableAlgorithm ) :
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
      super(PluginServiceTest__MyAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'PluginServiceTest::MyAlg'
  pass # class PluginServiceTest__MyAlg

class PluginServiceTest__MyTemplatedAlg_intr_doublep_( ConfigurableAlgorithm ) :
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
      super(PluginServiceTest__MyTemplatedAlg_intr_doublep_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'PluginServiceTest::MyTemplatedAlg<int&, double*>'
  pass # class PluginServiceTest__MyTemplatedAlg_intr_doublep_

class PropertyAlg( ConfigurableAlgorithm ) :
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
    'Int' : 100, # int
    'Int64' : 100L, # long
    'UInt64' : 100L, # long
    'Double' : 100.00000, # float
    'String' : 'hundred', # str
    'Bool' : True, # bool
    'IntArray' : [  ], # list
    'Int64Array' : [  ], # list
    'UInt64Array' : [  ], # list
    'DoubleArray' : [  ], # list
    'StringArray' : [  ], # list
    'BoolArray' : [  ], # list
    'EmptyArray' : [  ], # list
    'IntPairArray' : [  ], # list
    'DoublePairArray' : [  ], # list
    'PInt' : 100, # int
    'PDouble' : 100.00000, # float
    'PString' : 'hundred', # str
    'PBool' : False, # bool
    'PIntArray' : [  ], # list
    'PDoubleArray' : [  ], # list
    'PStringArray' : [  ], # list
    'PBoolArray' : [  ], # list
    'DoubleArrayWithUnits' : [  ], # list
    'DoubleArrayWithoutUnits' : [  ], # list
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(PropertyAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'PropertyAlg'
  pass # class PropertyAlg

class PropertyProxy( ConfigurableAlgorithm ) :
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
      super(PropertyProxy, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'PropertyProxy'
  pass # class PropertyProxy

class RandomNumberAlg( ConfigurableAlgorithm ) :
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
      super(RandomNumberAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'RandomNumberAlg'
  pass # class RandomNumberAlg

class ReadAlg( ConfigurableAlgorithm ) :
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
    'IncidentName' : '', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ReadAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ReadAlg'
  pass # class ReadAlg

class ReadTES( ConfigurableAlgorithm ) :
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
    'Locations' : [  ], # list
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
    'Locations' : """ Locations to read """,
    'EfficiencyRowFormat' : """ The format for the regular row in the output Stat-table """,
    'PropertiesPrint' : """ Print the properties of the component  """,
    'CounterList' : """ RegEx list, of simple integer counters for CounterSummary. """,
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(ReadTES, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ReadTES'
  pass # class ReadTES

class SCSAlg( ConfigurableAlgorithm ) :
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
      super(SCSAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'SCSAlg'
  pass # class SCSAlg

class ServiceA( ConfigurableService ) :
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
      super(ServiceA, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ServiceA'
  pass # class ServiceA

class ServiceB( ConfigurableService ) :
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
      super(ServiceB, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'ServiceB'
  pass # class ServiceB

class StopperAlg( ConfigurableAlgorithm ) :
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
    'StopCount' : 0, # int
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
      super(StopperAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'StopperAlg'
  pass # class StopperAlg

class SubAlg( ConfigurableAlgorithm ) :
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
      super(SubAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'SubAlg'
  pass # class SubAlg

class TAlgDB( ConfigurableAlgorithm ) :
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
    'TProperty' : 0.0000000, # float
    'RProperty' : False, # bool
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
      super(TAlgDB, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TAlgDB'
  pass # class TAlgDB

class TAlgIS( ConfigurableAlgorithm ) :
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
    'TProperty' : 0, # int
    'RProperty' : [  ], # list
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
      super(TAlgIS, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TAlgIS'
  pass # class TAlgIS

class THistRead( ConfigurableAlgorithm ) :
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
      super(THistRead, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'THistRead'
  pass # class THistRead

class THistWrite( ConfigurableAlgorithm ) :
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
      super(THistWrite, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'THistWrite'
  pass # class THistWrite

class TemplatedAlg_double_bool_( ConfigurableAlgorithm ) :
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
    'TProperty' : 0.0000000, # float
    'RProperty' : False, # bool
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
      super(TemplatedAlg_double_bool_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TemplatedAlg<double, bool>'
  pass # class TemplatedAlg_double_bool_

class TemplatedAlg_int_std__vector_std__string_std__allocator_std__string_s_s_( ConfigurableAlgorithm ) :
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
    'TProperty' : 0, # int
    'RProperty' : [  ], # list
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
      super(TemplatedAlg_int_std__vector_std__string_std__allocator_std__string_s_s_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TemplatedAlg<int, std::vector<std::string, std::allocator<std::string> > >'
  pass # class TemplatedAlg_int_std__vector_std__string_std__allocator_std__string_s_s_

class TestTool( ConfigurableAlgTool ) :
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
    'Tools' : [  ], # list
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
      super(TestTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TestTool'
  pass # class TestTool

class TestToolAlg( ConfigurableAlgorithm ) :
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
    'Tools' : [  ], # list
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
      super(TestToolAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TestToolAlg'
  pass # class TestToolAlg

class TestToolAlgFailure( ConfigurableAlgorithm ) :
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
    'Tools' : [  ], # list
    'IgnoreFailure' : False, # bool
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
      super(TestToolAlgFailure, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TestToolAlgFailure'
  pass # class TestToolAlgFailure

class TestToolFailing( ConfigurableAlgTool ) :
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
      super(TestToolFailing, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TestToolFailing'
  pass # class TestToolFailing

class TupleAlg( ConfigurableAlgorithm ) :
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
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
    'NTupleDir' : 'DefaultName', # str
    'EvtColsProduce' : False, # bool
    'EvtColsPrint' : False, # bool
    'EvtColSplitDir' : False, # bool
    'EvtColOffSet' : 0, # int
    'EvtColLUN' : 'EVTCOL', # str
    'EvtColTopDir' : '', # str
    'EvtColDir' : 'DefaultName', # str
  }
  _propertyDocDct = { 
    'NTuplePrint' : """ Print N-tuple statistics """,
    'NTupleProduce' : """ General switch to enable/disable N-tuples """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'EvtColLUN' : """ Logical File Unit for Event Tag Collections """,
    'EvtColOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
    'NTupleSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TupleAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TupleAlg'
  pass # class TupleAlg

class TupleAlg2( ConfigurableAlgorithm ) :
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
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
    'NTupleDir' : 'DefaultName', # str
    'EvtColsProduce' : False, # bool
    'EvtColsPrint' : False, # bool
    'EvtColSplitDir' : False, # bool
    'EvtColOffSet' : 0, # int
    'EvtColLUN' : 'EVTCOL', # str
    'EvtColTopDir' : '', # str
    'EvtColDir' : 'DefaultName', # str
  }
  _propertyDocDct = { 
    'NTuplePrint' : """ Print N-tuple statistics """,
    'NTupleProduce' : """ General switch to enable/disable N-tuples """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'EvtColLUN' : """ Logical File Unit for Event Tag Collections """,
    'EvtColOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
    'NTupleSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TupleAlg2, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TupleAlg2'
  pass # class TupleAlg2

class TupleAlg3( ConfigurableAlgorithm ) :
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
    'HistoProduce' : True, # bool
    'HistoPrint' : False, # bool
    'HistoCountersPrint' : True, # bool
    'HistoCheckForNaN' : True, # bool
    'HistoSplitDir' : False, # bool
    'HistoOffSet' : 0, # int
    'HistoTopDir' : '', # str
    'HistoDir' : 'DefaultName', # str
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
    'NTupleDir' : 'DefaultName', # str
    'EvtColsProduce' : False, # bool
    'EvtColsPrint' : False, # bool
    'EvtColSplitDir' : False, # bool
    'EvtColOffSet' : 0, # int
    'EvtColLUN' : 'EVTCOL', # str
    'EvtColTopDir' : '', # str
    'EvtColDir' : 'DefaultName', # str
  }
  _propertyDocDct = { 
    'NTuplePrint' : """ Print N-tuple statistics """,
    'NTupleProduce' : """ General switch to enable/disable N-tuples """,
    'StatEntityList' : """ RegEx list, of StatEntity counters for CounterSummary. """,
    'HistoTopDir' : """ Top level histogram directory (take care that it ends with '/') """,
    'UseSequencialNumericAutoIDs' : """ Flag to allow users to switch back to the old style of creating numerical automatic IDs """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'FormatFor1DHistoTable' : """ Format string for printout of 1D histograms """,
    'ErrorsPrint' : """ Print the statistics of errors/warnings/exceptions """,
    'EvtColLUN' : """ Logical File Unit for Event Tag Collections """,
    'EvtColOffSet' : """ Offset for numerical N-tuple ID """,
    'HistoProduce' : """ Switch on/off the production of histograms """,
    'HistoSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
    'VetoObjects' : """ Skip execute if one or more of these TES objects exists """,
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
    'RequireObjects' : """ Execute only if one or more of these TES objects exists """,
    'NTupleSplitDir' : """ Split long directory names into short pieces (suitable for HBOOK) """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TupleAlg3, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'TupleAlg3'
  pass # class TupleAlg3

class WriteAlg( ConfigurableAlgorithm ) :
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
      super(WriteAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'WriteAlg'
  pass # class WriteAlg

class bug_34121__MyAlgorithm( ConfigurableAlgorithm ) :
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
    'Tool' : 'bug_34121::Tool', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'Tool' : """ Type of the tool to use """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(bug_34121__MyAlgorithm, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'bug_34121::MyAlgorithm'
  pass # class bug_34121__MyAlgorithm

class bug_34121__Tool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'Double' : 100.00000, # float
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(bug_34121__Tool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiExamples'
  def getType( self ):
      return 'bug_34121::Tool'
  pass # class bug_34121__Tool
