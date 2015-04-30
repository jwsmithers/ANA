#Wed Apr 29 16:00:13 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.Proxy.Configurable import *

class PythonScriptingSvc( ConfigurableService ) :
  __slots__ = { 
    'OutputLevel' : 7, # int
    'AuditServices' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditReInitialize' : False, # bool
    'AuditReStart' : False, # bool
    'StartupScript' : '', # str
  }
  _propertyDocDct = { 
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(PythonScriptingSvc, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'GaudiPython'
  def getType( self ):
      return 'PythonScriptingSvc'
  pass # class PythonScriptingSvc
