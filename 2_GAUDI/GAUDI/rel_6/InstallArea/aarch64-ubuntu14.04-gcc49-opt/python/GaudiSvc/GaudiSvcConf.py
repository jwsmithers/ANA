#Wed Apr 29 15:55:16 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class CollectionCloneAlg( ConfigurableAlgorithm ) :
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
    'EvtTupleSvc' : 'EvtTupleSvc', # str
    'Input' : [  ], # list
    'Output' : '', # str
  }
  _propertyDocDct = { 
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(CollectionCloneAlg, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'CollectionCloneAlg'
  pass # class CollectionCloneAlg

class DetDataSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'RootCLID' : 3, # int
    'RootName' : '/dd', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'DetStorageType' : 7, # int
    'DetDbLocation' : 'empty', # str
    'DetDbRootName' : 'dd', # str
    'UsePersistency' : False, # bool
    'PersistencySvc' : 'DetectorPersistencySvc', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(DetDataSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'DetDataSvc'
  pass # class DetDataSvc

class FileMgr( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'LogFile' : '', # str
    'PrintSummary' : False, # bool
    'LoadROOTHandler' : True, # bool
    'LoadPOSIXHandler' : True, # bool
    'TSSL_UserProxy' : 'X509', # str
    'TSSL_CertDir' : 'X509', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(FileMgr, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'FileMgr'
  pass # class FileMgr

class HepRndm__Engine_CLHEP__DRand48Engine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__DRand48Engine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::DRand48Engine>'
  pass # class HepRndm__Engine_CLHEP__DRand48Engine_

class HepRndm__Engine_CLHEP__DualRand_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__DualRand_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::DualRand>'
  pass # class HepRndm__Engine_CLHEP__DualRand_

class HepRndm__Engine_CLHEP__HepJamesRandom_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__HepJamesRandom_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::HepJamesRandom>'
  pass # class HepRndm__Engine_CLHEP__HepJamesRandom_

class HepRndm__Engine_CLHEP__Hurd160Engine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__Hurd160Engine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::Hurd160Engine>'
  pass # class HepRndm__Engine_CLHEP__Hurd160Engine_

class HepRndm__Engine_CLHEP__Hurd288Engine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__Hurd288Engine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::Hurd288Engine>'
  pass # class HepRndm__Engine_CLHEP__Hurd288Engine_

class HepRndm__Engine_CLHEP__MTwistEngine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__MTwistEngine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::MTwistEngine>'
  pass # class HepRndm__Engine_CLHEP__MTwistEngine_

class HepRndm__Engine_CLHEP__RanecuEngine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__RanecuEngine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::RanecuEngine>'
  pass # class HepRndm__Engine_CLHEP__RanecuEngine_

class HepRndm__Engine_CLHEP__Ranlux64Engine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__Ranlux64Engine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::Ranlux64Engine>'
  pass # class HepRndm__Engine_CLHEP__Ranlux64Engine_

class HepRndm__Engine_CLHEP__RanluxEngine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__RanluxEngine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::RanluxEngine>'
  pass # class HepRndm__Engine_CLHEP__RanluxEngine_

class HepRndm__Engine_CLHEP__RanshiEngine_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__RanshiEngine_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::RanshiEngine>'
  pass # class HepRndm__Engine_CLHEP__RanshiEngine_

class HepRndm__Engine_CLHEP__TripleRand_( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Seeds' : [  ], # list
    'Column' : 0, # int
    'Row' : 1, # int
    'Luxury' : 3, # int
    'UseTable' : False, # bool
    'SetSingleton' : False, # bool
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(HepRndm__Engine_CLHEP__TripleRand_, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'HepRndm::Engine<CLHEP::TripleRand>'
  pass # class HepRndm__Engine_CLHEP__TripleRand_

class NTupleSvc( ConfigurableService ) :
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
    'RootName' : '/NTUPLES', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'Input' : [  ], # list
    'Output' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(NTupleSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'NTupleSvc'
  pass # class NTupleSvc

class RndmGenSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'Engine' : 'HepRndm::Engine<CLHEP::RanluxEngine>', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RndmGenSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'RndmGenSvc'
  pass # class RndmGenSvc

class THistSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'AutoSave' : 0, # int
    'AutoFlush' : 0, # int
    'PrintAll' : False, # bool
    'MaxFileSize' : 10240, # int
    'CompressionLevel' : 1, # int
    'Output' : [  ], # list
    'Input' : [  ], # list
  }
  _propertyDocDct = { 
    'MaxFileSize' : """ maximum file size in MB. if exceeded, will cause an abort. -1 to never check. """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(THistSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'THistSvc'
  pass # class THistSvc

class TagCollectionSvc( ConfigurableService ) :
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
    'RootName' : '/NTUPLES', # str
    'ForceLeaves' : False, # bool
    'InhibitPathes' : [  ], # list
    'DataFaultName' : 'DataFault', # str
    'DataAccessName' : 'DataAccess', # str
    'EnableFaultHandler' : False, # bool
    'EnableAccessHandler' : False, # bool
    'Input' : [  ], # list
    'Output' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TagCollectionSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiSvc'
  def getType( self ):
      return 'TagCollectionSvc'
  pass # class TagCollectionSvc
