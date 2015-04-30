#Wed Apr 29 15:55:19 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class RootHistCnv__PersSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'OutputFile' : 'UndefinedROOTOutputFileName', # str
    'ForceAlphaIds' : False, # bool
    'OutputEnabled' : True, # bool
  }
  _propertyDocDct = { 
    'OutputEnabled' : """ Flag to enable/disable the output to file. """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(RootHistCnv__PersSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'RootHistCnv'
  def getType( self ):
      return 'RootHistCnv::PersSvc'
  pass # class RootHistCnv__PersSvc
