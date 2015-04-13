#!/bin/csh -f
if ( "$1" == "" ) then
  echo "Usage: $0 directory"
  exit 1
endif
if ( ! -d "$1" ) then
  echo "ERROR! Directory $1 does not exist!"
  exit 1
endif
cd $1

# Exceptions to handle individually in CoolKernel
# (all these exception should not be modified, unless otherwise stated):
# - types.h has 'const UInt32 Uint32Min'
# - SealBaseTime.h has 'static const int XXX'
# - ChannelSelection.h has 'const Order&' and 'const int&'
# - Exception.h has 'const ChannelId&'
###set files=`ls *.h *.cpp | grep -v types.h | grep -v ChannelSelection.h | grep -v SealBaseTime.h | grep -v Exception.h`

# Exceptions to handle individually in RelationalCool
# (all these exception should not be modified, unless otherwise stated):
# - ConstRelationalObjectAdapter.h has 'const unsigned int& m_objectId;'
# - ObjectId.h has 'const int XXX'
# - ProcMemory.h has 'const int XXX'
# - RelationalObjectTable.cpp has 'const int XXX' that is referenced
# - RelationalSequence.h has 'static const int XXX'
# - SealBase_TimeInfo.h/cpp have 'static const int XXX'
# - SealUtil_TimingItem.h has 'static const int XXX'
###set files=`ls *.h *.cpp | grep -v SealUtil_TimingItem.h`
set files=`ls *.h *.cpp | grep -v SealBase_TimeInfo | grep -v SealUtil_TimingItem.h | grep -v ConstRelationalObjectAdapter.h | grep -v RelationalSequence.h | grep -v RelationalObjectTable.cpp | grep -v ObjectId.h | grep -v ProcMemory.h`

# Exceptions to handle individually:
# -> 'const bool&' should not become 'bool &'
# -> should remove 'const' in 'const bool' that are split over two lines
foreach file ( $files )
  if ( -e $file ) then
    cat ${file} \
      | sed 's/const bool/bool/' \
      | sed 's/const int/int/' \
      | sed 's/const unsigned int\*/INTSTAR/' \
      | sed 's/const unsigned int\&/INTREF/' \
      | sed 's/const unsigned/unsigned/' \
      | sed 's/INTSTAR/const unsigned int\*/' \
      | sed 's/INTREF/const unsigned int\&/' \
      | sed 's/const long/long/' \
      | sed 's/const size_t/size_t/' \
      | sed 's/const UInt32/UInt32/' \
      | sed 's/const ChannelId\&/const __CHANNELIDREF__/' \
      | sed 's/const ChannelIdVal/const __CHANNELIDVAL__/' \
      | sed 's/const ChannelId/ChannelId/' \
      | sed 's/const __CHANNELIDREF__/const ChannelId\&/' \
      | sed 's/const __CHANNELIDVAL__/const ChannelIdVal/' \
      | sed 's/const ObjectId\&/const __OBJECTIDREF__/' \
      | sed 's/const ObjectIdIncr/const __OBJECTIDINCR__/' \
      | sed 's/const ObjectId/ObjectId/' \
      | sed 's/const __OBJECTIDREF__/const ObjectId\&/' \
      | sed 's/const __OBJECTIDINCR__/const ObjectIdIncr/' \
      | sed 's/const FolderVersioning::Mode/FolderVersioning::Mode/' \
      | sed 's/const HvsTagLock::Status/HvsTagLock::Status/' \
      | sed 's/const IHvsNode::Type/IHvsNode::Type/' \
      | sed 's/const MSG::Level/MSG::Level/' \
      | sed 's/const Order/Order/' \
      | sed 's/const Nullness/Nullness/' \
      | sed 's/const FieldSelection::Nullness/FieldSelection::Nullness/' \
      | sed 's/const Relational/const RELATIONAL/' \
      | sed 's/const Relation/Relation/' \
      | sed 's/const RELATIONAL/const Relational/' \
      | sed 's/const FieldSelection::Relation/FieldSelection::Relation/' \
      | sed 's/const Connective/Connective/' \
      | sed 's/const CompositeSelection::Connective/CompositeSelection::Connective/' \
      > ${file}.new
    \mv ${file}.new ${file}
  endif
end
