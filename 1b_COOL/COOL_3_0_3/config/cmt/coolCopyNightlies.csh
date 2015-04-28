#!/bin/csh -f

echo "coolCopyNightlies.csh - You must comment out this line!"; exit 1

# Choose the slot
###set slot="dev"
###set slot="dev1"
set slot="dev2"
###set slot="dev3"
###set slot="dev4"
###set slot="release"

# Choose the projects
set projects=""
set projects="${projects} LCGCMT"
#set projects="${projects} ROOT"
#set projects="${projects} CORAL"

# Choose the platforms to copy (for CORAL and ROOT)
set copyPlatforms=""
###set copyPlatforms="${copyPlatforms} x86_64-mac106-gcc42-opt"
###set copyPlatforms="${copyPlatforms} i686-slc5-gcc43-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc5-gcc43-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc5-gccmax-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc5-icc11-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc5-icc13-opt"
###set copyPlatforms="${copyPlatforms} x86_64-slc5-gcc47-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc5-gcc47-opt"
###set copyPlatforms="${copyPlatforms} x86_64-slc6-gcc46-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc6-gcc47-dbg"
###set copyPlatforms="${copyPlatforms} x86_64-slc6-gcc47-opt"
set copyPlatforms="${copyPlatforms} x86_64-slc6-gcc48-opt"
###set copyPlatforms="${copyPlatforms} x86_64-slc6-clang32-opt"
###set copyPlatforms="${copyPlatforms} x86_64-slc6-clang33-opt"
###set copyPlatforms="${copyPlatforms} x86_64-slc6-icc13-opt"
###set copyPlatforms="${copyPlatforms} win32_vc71_dbg"
###set copyPlatforms="${copyPlatforms} i686-winxp-vc9-dbg"

# Choose to copy ALL platforms (for CORAL and ROOT)
###set copyPlatforms="all"
 
# --- do not modify ---

set lcgNightliesRoot=/afs/cern.ch/sw/lcg/app/nightlies
###set ourNightliesRoot=/afs/cern.ch/sw/lcg/app/releases/COOL/internal/nightlies
set ourNightliesRoot=/home/avalassi/nightlies

set lcgNightlies=${lcgNightliesRoot}/${slot}/`date -d20130926 +%a`
set ourNightlies=${ourNightliesRoot}/${slot}/`date -d20130926 +%Y%m%d%a`
#set lcgNightlies=${lcgNightliesRoot}/${slot}/`date +%a`
#set ourNightlies=${ourNightliesRoot}/${slot}/`date +%Y%m%d%a`

echo "Copy nightlies from ${lcgNightlies} to ${ourNightlies}"
if ( -d ${ourNightlies} ) then
  echo "WARNING! Directory already exists: ${ourNightlies}"
endif

foreach project ( ${projects} )
  echo "Copy ${project} to ${ourNightlies}/${project}"
  if ( -d ${ourNightlies}/${project} ) then
    echo "ERROR! Directory already exists: ${ourNightlies}/${project}"
    exit 1
  endif
  # Get the project version
  if ( "${project}" == "LCGCMT" && ( "${slot}" == "dev" ) ) then
    set version=`more ${lcgNightlies}/${project}/LCGCMT-preview/cmt/project.cmt | awk '{if ($1=="use" && $2=="LCGCMT") print $3}'`
  else if ( "${project}" == "LCGCMT" && ( "${slot}" == "dev1" ) ) then
    set version=`more ${lcgNightlies}/${project}/LCGCMT_61-patches/cmt/project.cmt | awk '{if ($1=="use" && $2=="LCGCMT") print $3}'`
  else if ( "${project}" == "LCGCMT" && ( "${slot}" == "dev2" ) ) then
    set version=`more ${lcgNightlies}/${project}/LCGCMT_root6/cmt/project.cmt | awk '{if ($1=="use" && $2=="LCGCMT") print $3}'`
  else if ( "${project}" == "LCGCMT" && ( "${slot}" == "dev3" ) ) then
    set version=`more ${lcgNightlies}/${project}/LCGCMT_65-patches/cmt/project.cmt | awk '{if ($1=="use" && $2=="LCGCMT") print $3}'`
  else 
    set version=`find ${lcgNightlies}/${project} -mindepth 1 -maxdepth 1 -type d`
    if ( `echo $version | wc -w` != "1" ) then
      echo "WARNING! More than one entry in directory ${lcgNightlies}/${project}:"
      echo $version
      set version=`\ls -1trd $version | tail -1`
      echo "WARNING! Will only copy the most recent one:"
      echo $version
    endif
    set version=`basename ${version}`
  endif
  # Copy LCGCMT
  if ( "${project}" == "LCGCMT" ) then
    echo "Copy ${project} from ${lcgNightlies}/${project}/${version}"
    mkdir -p ${ourNightlies}/${project}/
    cp -dpr ${lcgNightlies}/${project}/${version} ${ourNightlies}/${project}/
    set projectCmt=`dirname $0`/../../cmt
    set projectCmt=`cd ${projectCmt}; pwd`/project.cmt
    set lcgcmtVersion=`more ${projectCmt} | awk '{if ($1=="use" && $2=="LCGCMT") print $3}'`
    echo COOL uses ${lcgcmtVersion}
    if ( ${version} == ${lcgcmtVersion} ) then
      echo Directory ${project}/${lcgcmtVersion} already exists
    else
      echo Create ${project}/${lcgcmtVersion}
      pushd ${ourNightlies}/${project} >& /dev/null
      \rm -rf ${lcgcmtVersion}
      mkdir ${lcgcmtVersion}
      cd ${lcgcmtVersion}
      ln -sf ../${version}/* .
      \mv cmt cmt.old
      mkdir cmt
      cat cmt.old/project.cmt | sed "s/${version}/${lcgcmtVersion}/" > cmt/project.cmt
      \rm -f cmt.old
      popd >& /dev/null
    endif
  # Copy ROOT
  else if ( "${project}" == "ROOT" ) then
    echo "Copy ${project} from ${lcgNightlies}/${project}/${version}"
    if ( "${copyPlatforms}" == "all" ) then
      set platforms=`ls ${lcgNightlies}/${project}/${version} | grep -v logs`
    else
      set platforms="${copyPlatforms}"
    endif 
    foreach platform ( ${platforms} )
      echo "Copy ${project} for platform $platform"
      mkdir -p ${ourNightlies}/${project}/${version}/${platform}/root
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/include \
              ${ourNightlies}/${project}/${version}/${platform}/root/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/etc \
              ${ourNightlies}/${project}/${version}/${platform}/root/
      mkdir -p ${ourNightlies}/${project}/${version}/${platform}/root/lib
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libCore* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libCint* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libReflex* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libThread* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libPyROOT* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      if ( "${platform}" != "win32_vc71_dbg" && "${platform}" != "win32_vc9_dbg" ) then
        cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/*py \
                ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      endif
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/python \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      mkdir -p ${ourNightlies}/${project}/${version}/${platform}/root/bin
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/bin/* \
              ${ourNightlies}/${project}/${version}/${platform}/root/bin/
      # CINT headers are needed by rootcint, eg for POOL (bug #63170)
      mkdir -p ${ourNightlies}/${project}/${version}/${platform}/root/cint/cint/lib
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/cint/cint/lib/prec_stl \
              ${ourNightlies}/${project}/${version}/${platform}/root/cint/cint/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/cint/cint/include \
              ${ourNightlies}/${project}/${version}/${platform}/root/cint/cint/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/cint/cint/stl \
              ${ourNightlies}/${project}/${version}/${platform}/root/cint/cint/
      # These 9 libraries should disappear one day (Gpad, Graf, Graf3d, Hist, MathCore, Matrix, Net, RIO, Tree)
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libGpad* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libGraf* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libHist* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libMathCore* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libMatrix* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libMetaTCint.* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libNet* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libRIO* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libTree* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
      # These libraries are new in ROOT6
      cp -dpr ${lcgNightlies}/${project}/${version}/${platform}/root/lib/libCling* \
              ${ourNightlies}/${project}/${version}/${platform}/root/lib/
    end
  else
    echo "Copy ${project} from ${lcgNightlies}/${project}/${version}"
    if ( "${copyPlatforms}" == "all" ) then
      echo "Copy ${project} for all platforms"
      mkdir -p ${ourNightlies}/${project}/
      cp -dpr ${lcgNightlies}/${project}/${version} ${ourNightlies}/${project}/
    else
      echo "Copy ${project} include, logs, src"
      mkdir -p ${ourNightlies}/${project}/${version}/
      cp -dpr ${lcgNightlies}/${project}/${version}/include \
              ${ourNightlies}/${project}/${version}/
      cp -dpr ${lcgNightlies}/${project}/${version}/logs \
              ${ourNightlies}/${project}/${version}/
      cp -dpr ${lcgNightlies}/${project}/${version}/src \
              ${ourNightlies}/${project}/${version}/
      set platforms="${copyPlatforms}"
      foreach platform ( ${platforms} )
        echo "Copy ${project} for platform $platform"
        cp -dpr ${lcgNightlies}/${project}/${version}/${platform} \
                ${ourNightlies}/${project}/${version}/
      end
    endif
  endif
end

