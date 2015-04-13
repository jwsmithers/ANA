#Mon Feb 16 20:28:02 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class Google__CPUProfiler( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ActivateAt' : [ 'Initialize' , 'ReInitialize' , 'Execute' , 'BeginRun' , 'EndRun' , 'Finalize' ], # list
    'DisableFor' : [  ], # list
    'EnableFor' : [  ], # list
    'ProfileFreq' : -1, # int
    'DoFullEventProfile' : False, # bool
    'FullEventNSampleEvents' : 1L, # long
    'SkipEvents' : 0L, # long
    'SkipSequencers' : True, # bool
  }
  _propertyDocDct = { 
    'ProfileFreq' : """ The frequence to audit events. -1 means all events """,
    'SkipEvents' : """ Number of events to skip before activating the auditing """,
    'DisableFor' : """ List of component names to disable the auditing for """,
    'FullEventNSampleEvents' : """ The number of events to include in a full event audit, if enabled """,
    'DoFullEventProfile' : """ If true, instead of individually auditing components, the full event (or events) will be audited in one go """,
    'SkipSequencers' : """ If true, auditing will be skipped for Sequencer objects. """,
    'ActivateAt' : """ List of phases to activate the Auditoring during """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Google__CPUProfiler, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiGoogleProfiling'
  def getType( self ):
      return 'Google::CPUProfiler'
  pass # class Google__CPUProfiler

class Google__HeapChecker( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ActivateAt' : [ 'Initialize' , 'ReInitialize' , 'Execute' , 'BeginRun' , 'EndRun' , 'Finalize' ], # list
    'DisableFor' : [  ], # list
    'EnableFor' : [  ], # list
    'ProfileFreq' : -1, # int
    'DoFullEventProfile' : False, # bool
    'FullEventNSampleEvents' : 1L, # long
    'SkipEvents' : 0L, # long
    'SkipSequencers' : True, # bool
  }
  _propertyDocDct = { 
    'ProfileFreq' : """ The frequence to audit events. -1 means all events """,
    'SkipEvents' : """ Number of events to skip before activating the auditing """,
    'DisableFor' : """ List of component names to disable the auditing for """,
    'FullEventNSampleEvents' : """ The number of events to include in a full event audit, if enabled """,
    'DoFullEventProfile' : """ If true, instead of individually auditing components, the full event (or events) will be audited in one go """,
    'SkipSequencers' : """ If true, auditing will be skipped for Sequencer objects. """,
    'ActivateAt' : """ List of phases to activate the Auditoring during """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Google__HeapChecker, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiGoogleProfiling'
  def getType( self ):
      return 'Google::HeapChecker'
  pass # class Google__HeapChecker

class Google__HeapProfiler( ConfigurableAuditor ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ActivateAt' : [ 'Initialize' , 'ReInitialize' , 'Execute' , 'BeginRun' , 'EndRun' , 'Finalize' ], # list
    'DisableFor' : [  ], # list
    'EnableFor' : [  ], # list
    'ProfileFreq' : -1, # int
    'DoFullEventProfile' : False, # bool
    'FullEventNSampleEvents' : 1L, # long
    'SkipEvents' : 0L, # long
    'SkipSequencers' : True, # bool
    'DumpHeapProfiles' : True, # bool
    'PrintProfilesToLog' : False, # bool
  }
  _propertyDocDct = { 
    'ProfileFreq' : """ The frequence to audit events. -1 means all events """,
    'SkipEvents' : """ Number of events to skip before activating the auditing """,
    'DisableFor' : """ List of component names to disable the auditing for """,
    'FullEventNSampleEvents' : """ The number of events to include in a full event audit, if enabled """,
    'DoFullEventProfile' : """ If true, instead of individually auditing components, the full event (or events) will be audited in one go """,
    'SkipSequencers' : """ If true, auditing will be skipped for Sequencer objects. """,
    'ActivateAt' : """ List of phases to activate the Auditoring during """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Google__HeapProfiler, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiGoogleProfiling'
  def getType( self ):
      return 'Google::HeapProfiler'
  pass # class Google__HeapProfiler
