"""
PyCool internal module. Contains definitions like typedefs, enums etc.
"""

########################################################################
## cool::StorageType aliases
## + some aliases useful for CORAL too
def _guess_cool_type_aliases():
    """Automatic discovery of the type aliases from the special dedicated helper.
    The cool::PyCool::Helpers::Typedefs class contains one templated member
    function per COOL StorageType typedef, templated only with the same typedef.
    In this way I'll have a mapping between the COOL typedef and the type used
    internally by Cint/Cintex/Reflex/GccXML/ROOT/...
    
    This is needed as a work-around for:
     -> bug #39020: 'string' used since ROOT 5.21.02
        (this patch also needs the fix for a ROOT bug fixed in ROOT 5.21.02)
     -> bug #42441: 'unsigned int' used by gccxml 0.9.0_20081002
        (this was picked up by LCGCMT after the ROOT 5.21.02 release: it can be
        used also in ROOT 5.21.02 because it overrides the default value there)
    """
    import re, PyCintex
    
    # Helper function to extract from a list the groups that are obtained
    # matching a regular expression
    extract_matches = lambda rexp, lst: \
                [ m.groups()
                  for m in [ rexp.match(n)
                             for n in lst ]
                  if m ]
    
    cool_type_aliases = {}
    ### This is the wanted implementation, but it does not work with ROOT 5.18 :(
    # for k, v in extract_matches(re.compile(r"function_(\w*)<(.*)>"),
    #                             dir(PyCintex.gbl.cool.PyCool.Helpers.Typedefs)):
    #     cool_type_aliases[k] = v
    #     cool_type_aliases["cool::" + k] = v
    
    ### This implementation relies on a set of functions mapping the typedef to
    ### a lowercase id
    id2typedef = {}
    
    # Workaround for ROOT-5469 and ROOT-5603 (together leading to bug #102996)
    ###dirTypedefs = dir(PyCintex.gbl.cool.PyCool.Helpers.Typedefs)
    dirTypedefs = dir(getattr(PyCintex.gbl,"cool::PyCool::Helpers::Typedefs"))
    ###print dirTypedefs
    for k, v in extract_matches(re.compile(r"type_id_([a-z]*)__(\w*)"),
                                dirTypedefs):
        id2typedef[k] = v
    for k, v in extract_matches(re.compile(r"function([a-z]+)<(.*)>"),
                                dirTypedefs):
        k = id2typedef[k]
        cool_type_aliases[k] = v
        cool_type_aliases["cool::" + k] = v
    
    # other useful aliases (for coral)
    cool_type_aliases["string"] = cool_type_aliases["std::string"] = cool_type_aliases["String255"]
    cool_type_aliases["unsigned"] = cool_type_aliases["unsigned int"] = cool_type_aliases["UInt32"]
    cool_type_aliases["blob"] = cool_type_aliases["Blob64k"]
    return cool_type_aliases

cool_type_aliases = _guess_cool_type_aliases()

########################################################################
## Mapping to define typedefs for C++ basic types
basic_types_mapping = {# C++: Python
                       "unsigned":           "long",   # (none)
                       "unsigned int":       "long",   # UInt32, ChannelId
                       "unsigned long long": "long",   # UInt64, UInt63, ValidityKey
                       "bool":               "bool",   # Bool
                       "unsigned char":      "int",    # UChar
                       "short":              "int",    # Int16
                       "unsigned short":     "int",    # UInt16
                       "int":                "int",    # Int32
                       "long long":          "long",   # Int64
                       "float":              "float",  # Float
                       "double":             "float",  # Double
                       }
