#Mon Feb 16 20:15:23 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class Gaudi__ParticlePropertySvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'ParticlePropertiesFile' : 'ParticleTable.txt', # str
    'OtherFiles' : [  ], # list
    'Particles' : [  ], # list
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(Gaudi__ParticlePropertySvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiPartProp'
  def getType( self ):
      return 'Gaudi::ParticlePropertySvc'
  pass # class Gaudi__ParticlePropertySvc
