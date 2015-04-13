lcgcmt_installarea=without_installarea
CMTPATH=/home/jwsmith/HDD/Gaudi:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
CMT_tag=$(tag)
CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
CMT_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
CMTVERSION=v1r26p20140131
CMT_offset=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt
cmt_hardware_query_command=uname -m
cmt_hardware=`$(cmt_hardware_query_command)`
cmt_system_version_query_command=${CMTROOT}/mgr/cmt_linux_version.sh | ${CMTROOT}/mgr/cmt_filter_version.sh
cmt_system_version=`$(cmt_system_version_query_command)`
cmt_compiler_version_query_command=${CMTROOT}/mgr/cmt_gcc_version.sh | ${CMTROOT}/mgr/cmt_filter3_version.sh
cmt_compiler_version=`$(cmt_compiler_version_query_command)`
PATH=/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/scripts:/home/jwsmith/HDD/Gaudi/InstallArea/${CMTCONFIG}/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gccxml/0.9.0_20131026/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../tcmalloc/1.7p3/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Python/2.7.6/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gcc/4.9.1/UnknownArch-fc21/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../pytools/1.8_python2.7/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../mysql/5.5.27/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../XercesC/3.1.1p1/armv7l-fc21-gcc49-opt/bin:/usr/lib/ccache:/usr/bin:/usr/sbin:/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131/${CMTBIN}
CLASSPATH=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131/java
debug_option=-g
cc=$(cc_name)
cdebugflags=$(coptimized_s)
cflags= -std=c11 -fmessage-length=0 -fPIC 
pp_cflags= $(CppSpecificFlags) -DHAVE_GAUDI_PLUGINSVC 
ccomp=$(cc) -c $(includes) $(cdebugflags) $(cflags) $(pp_cflags)
clink=$(cc) $(clinkflags) $(cdebugflags)
cdepflags=-MMD -MP -MF $*.d -MQ $@
vsCONFIG=Release
vsOptimize=2
ppcmd=-I
preproc=c++ -MD -c 
cpp=$(cpp_name)
cppdebugflags=$(cppoptimized_s)
cppflags= -fmessage-length=0 -Df2cFortran -fPIC -D_GNU_SOURCE -Dlinux -Dunix -pipe -ansi -Wall -Wextra -Werror=return-type -pthread  -std=c++11 -Wno-deprecated -Wno-unused-local-typedefs -pedantic -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -Wno-long-long 
pp_cppflags=-D_GNU_SOURCE -DGAUDI_V20_COMPAT  -DBOOST_FILESYSTEM_VERSION=3  -DBOOST_SPIRIT_USE_PHOENIX_V3  $(CppSpecificFlags) -DHAVE_GAUDI_PLUGINSVC 
cppcomp=$(cpp) -c $(cppdebugflags) $(cppflags) $(pp_cppflags) $(includes)
cpplinkflags=-Wl,-Bdynamic $(linkdebugflags) -ldl -Wl,--as-needed 
cpplink=$(cpp) $(cpplinkflags)
cppdepflags=-MMD -MP -MF $*.d -MQ $@
for=$(for_name)
fflags=-fmessage-length=0 -O2 -fdollar-ok -w -fPIC
fcomp=$(for) -c $(fincludes) $(fdebugflags) $(fflags) $(pp_fflags)
flink=$(for) $(flinkflags)
javacomp=javac -classpath $(src):$(CLASSPATH) 
javacopy=cp
jar=jar
X11_cflags=-I/usr/include
Xm_cflags=-I/usr/include
X_linkopts=-L/usr/X11R6/lib -lXm -lXt -lXext -lX11 -lm
lex=lex $(lexflags)
yaccflags= -l -d 
yacc=yacc $(yaccflags)
ar=ar cr
ranlib=ranlib
make_shlib=${CMTROOT}/mgr/cmt_make_shlib_common.sh extract
shlibsuffix=so
shlibbuilder=$(cpp_name) $(cmt_installarea_linkopts) 
shlibflags=-shared
symlink=/bin/ln -fs 
symunlink=/bin/rm -f 
library_install_command=python $(GaudiPolicy_root)/scripts/install.py -xCVS -x*~ -x*.stamp -x*.bak -x.* -x*.pyc -x*.pyo -s --log=./install.$(tag).history 
build_library_links=$(cmtexe) build library_links -tag=$(tags)
remove_library_links=$(cmtexe) remove library_links -tag=$(tags)
cmtexe=${CMTROOT}/${CMTBIN}/cmt.exe
build_prototype=$(cmtexe) build prototype
build_dependencies=$(cmtexe) -tag=$(tags) build dependencies
build_triggers=$(cmtexe) build triggers
format_dependencies=${CMTROOT}/mgr/cmt_format_deps.sh
implied_library_prefix=-l
SHELL=/bin/sh
q="
src=../src/
doc=../doc/
inc=../src/
mgr=../cmt/
application_suffix=.exe
library_prefix=lib
unlock_command=rm -rf 
lock_name=cmt
lock_suffix=.lock
lock_file=${lock_name}${lock_suffix}
svn_checkout_command=python ${CMTROOT}/mgr/cmt_svn_checkout.py 
gmake_hosts=lx1 rsplus lxtest as7 dxplus ax7 hp2 aleph hp1 hpplus papou1-fe atlas
make_hosts=virgo-control1 rio0a vmpc38a
everywhere=hosts
GUID_all={8BC9CEB8-8B4A-11D0-8D11-00A0C91BC955}
package_GUID={8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}
install_command=python $(GaudiPolicy_root)/scripts/install.py -xCVS -x*~ -x*.stamp -x*.bak -x.* -x*.pyc -x*.pyo --log=./install.$(tag).history 
uninstall_command=python $(GaudiPolicy_root)/scripts/install.py -u --log=./install.$(tag).history 
cmt_installarea_command=python $(GaudiPolicy_root)/scripts/install.py -xCVS -x*~ -x*.stamp -x*.bak -x.* -x*.pyc -x*.pyo -s --log=./install.$(tag).history 
cmt_uninstallarea_command=/bin/rm -f 
cmt_install_area_command=$(cmt_installarea_command)
cmt_uninstall_area_command=$(cmt_uninstallarea_command)
cmt_install_action=$(CMTROOT)/mgr/cmt_install_action.sh
cmt_installdir_action=$(CMTROOT)/mgr/cmt_installdir_action.sh
cmt_uninstall_action=$(CMTROOT)/mgr/cmt_uninstall_action.sh
cmt_uninstalldir_action=$(CMTROOT)/mgr/cmt_uninstalldir_action.sh
mkdir=mkdir
cmt_cvs_protocol_level=v1r1
cmt_installarea_prefix=InstallArea
CMT_PATH_remove_regexp=/[^/]*/
CMT_PATH_remove_share_regexp=/share/
NEWCMTCONFIG=armv7l-fedora21-gcc492
GaudiSvc_tag=$(tag)
GAUDISVCROOT=/home/jwsmith/HDD/Gaudi/GaudiSvc
GaudiSvc_root=/home/jwsmith/HDD/Gaudi/GaudiSvc
GAUDISVCVERSION=v21r3
GaudiSvc_cmtpath=/home/jwsmith/HDD/Gaudi
GaudiSvc_project=GAUDI
GaudiSvc_project_release=Gaudi
GaudiKernel_tag=$(tag)
GAUDIKERNELROOT=/home/jwsmith/HDD/Gaudi/GaudiKernel
GaudiKernel_root=/home/jwsmith/HDD/Gaudi/GaudiKernel
GAUDIKERNELVERSION=v31r0
GaudiKernel_cmtpath=/home/jwsmith/HDD/Gaudi
GaudiKernel_project=GAUDI
GaudiKernel_project_release=Gaudi
GaudiPolicy_tag=$(tag)
GAUDIPOLICYROOT=/home/jwsmith/HDD/Gaudi/GaudiPolicy
GaudiPolicy_root=/home/jwsmith/HDD/Gaudi/GaudiPolicy
GAUDIPOLICYVERSION=v15r0
GaudiPolicy_cmtpath=/home/jwsmith/HDD/Gaudi
GaudiPolicy_project=GAUDI
GaudiPolicy_project_release=Gaudi
LCG_Settings_tag=$(tag)
LCG_SETTINGSROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings
LCG_Settings_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings
LCG_SETTINGSVERSION=v1
LCG_Settings_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
LCG_Settings_project=LCGCMT
LCG_Settings_project_release=LCGCMT_71
LCG_releases=$(LCG_Settings_root)/../../..
LCG_external=$(LCG_Settings_root)/../../..
unixdirname=lib
gcc_config_version=4.9.1
gcc_native_version=$(gcc_config_version)
gcc_home=$(LCG_external)/gcc/$(gcc_native_version)/$(LCG_hostos)
clang_native_version=$(clang_config_version)
clang_home=$(LCG_external)/llvm/$(clang_native_version)/$(LCG_hostos)
icc_native_version=$(icc_config_version)
cc_name=lcg-gcc-$(gcc_config_version)
cpp_name=lcg-g++-$(gcc_config_version)
cpplinkname=$(cpp_name)
for_name=lcg-gfortran-$(gcc_config_version)
COMPILER_PATH=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gcc/4.9.1/UnknownArch-fc21/lib/gcc/UnknownArch-unknown-linux-gnu/4.9.1
LD_LIBRARY_PATH=/home/jwsmith/HDD/Gaudi/InstallArea/${CMTCONFIG}/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../clhep/1.9.4.7/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Boost/1.55.0_python2.7/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../tcmalloc/1.7p3/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../libunwind/5c2cade/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gcc/4.9.1/UnknownArch-fc21/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../HepPDT/2.06.01/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../RELAX/RELAX_1_3_0p/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../GSL/1.10/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../pytools/1.8_python2.7/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../mysql/5.5.27/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../XercesC/3.1.1p1/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../uuid/1.42/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CppUnit/1.12.1_p1/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Python/2.7.6/armv7l-fc21-gcc49-opt/lib
Python_tag=$(tag)
PYTHONROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Python
Python_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Python
PYTHONVERSION=v1
Python_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
Python_offset=LCG_Interfaces
Python_project=LCGCMT
Python_project_release=LCGCMT_71
LCG_Configuration_tag=$(tag)
LCG_CONFIGURATIONROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Configuration
LCG_Configuration_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Configuration
LCG_CONFIGURATIONVERSION=v1
LCG_Configuration_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
LCG_Configuration_project=LCGCMT
LCG_Configuration_project_release=LCGCMT_71
LCG_Platforms_tag=$(tag)
LCG_PLATFORMSROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Platforms
LCG_Platforms_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Platforms
LCG_PLATFORMSVERSION=v1
LCG_Platforms_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
LCG_Platforms_project=LCGCMT
LCG_Platforms_project_release=LCGCMT_71
LCG_arch=armv7l
LCG_os=fc21
LCG_compiler=gcc49
LCG_mode=opt
LCG_basesystem=$(LCG_arch)-$(LCG_os)-$(LCG_compiler)
LCG_system=$(LCG_basesystem)-$(LCG_mode)
LCG_platform=$(LCG_basesystem)-$(LCG_mode)
ATLAS_TAGS_MAP=none
host_arch=UnknownArch
host_os=linux
host_cmtconfig=UnknownArch-linux-${host_compiler}-opt
LCG_hostos=$(host_arch)-$(LCG_os)
LCG_hostarch=$(host_arch)
LCG_config_version=71
uuid_config_version=1.42
4suite_config_version=1.0.2p1
AIDA_config_version=3.2.1
Boost_config_version=1.55.0
Boost_file_version=1_55
CASTOR_config_version=2.1.13-6
CLHEP_config_version=1.9.4.7
COOL_config_version=COOL_2_9_4
CORAL_config_version=CORAL_2_4_4
CppUnit_config_version=1.12.1_p1
Davix_config_version=0.3.1
Expat_config_version=2.0.1
FTS_config_version=2.2.8emi2
Frontier_Client_config_version=2.8.10
GCCXML_config_version=0.9.0_20131026
GSL_config_version=1.10
HepMC_config_version=2.06.09
HepPDT_config_version=2.06.01
LCGCMT_config_version=LCGCMT_71
Python_config_version=2.7.6
Python_config_version_twodigit=2.7
QMtest_config_version=2.4.1
Qt_config_version=4.8.4
RELAX_config_version=RELAX_1_3_0p
ROOT_config_version=v5-34-21
WMS_config_version=3.4.0
XercesC_config_version=3.1.1p1
blas_config_version=20110419
cmaketools_config_version=1.1
cmt_config_version=v1r26p20140131
coin3d_config_version=3.1.3p2
coverage_config_version=3.5.2
cream_config_version=1.14.0-4
cx_oracle_config_version=5.1.1
dcap_config_version=2.47.7-1
dm-util_config_version=1.15.0-0
doxygen_config_version=1.8.2
dpm_config_version=1.8.5-1
epel_config_version=20130408
fastjet_config_version=3.1.0
fftw_config_version=3.1.2
genshi_config_version=0.6
gfal2_config_version=2.2.0-1
gfal_config_version=1.13.0-0
graphviz_config_version=2.28.0
gridftp_ifce_config_version=2.3.1-0
gridsite_config_version=1.7.25-1.emi2
igprof_config_version=5.9.11
ipython_config_version=0.12.1
is_ifce_config_version=1.15.0-0
json_config_version=2.5.2
lapack_config_version=3.5.0
lb_config_version=3.2.9
lcgdmcommon_config_version=1.8.5-1
lcginfosites_config_version=3.1.0-3
lcov_config_version=1.9
lfc_config_version=1.8.5-1
libsvm_config_version=2.86
libtool_config_version=1.5.26
libunwind_config_version=5c2cade
lxml_config_version=2.3
matplotlib_config_version=1.3.1
minuit_config_version=5.27.02
mock_config_version=0.8.0
mpich2_config_version=1.5
multiprocessing_config_version=2.6.2.1
mysql_config_version=5.5.27
mysql_python_config_version=1.2.3
neurobayes_config_version=3.7.0
neurobayes_expert_config_version=3.7.0
nose_config_version=1.1.2
numpy_config_version=1.8.0
oracle_config_version=11.2.0.3.0
pacparser_config_version=1.3.1
pcre_config_version=8.34
processing_config_version=0.52
py2neo_config_version=1.4.6
py_config_version=1.4.8
pyanalysis_config_version=1.4
pydot_config_version=1.0.28
pygraphics_config_version=1.4
pygsi_config_version=0.5
pylint_config_version=1.2.1
pyminuit_config_version=0.0.1
pyparsing_config_version=1.5.6
pyqt_config_version=4.9.5
pytest_config_version=2.2.4
pytools_config_version=1.8
pyxml_config_version=0.8.4p1
qwt_config_version=6.0.1
scipy_config_version=0.10.0
setuptools_config_version=0.6c11
sip_config_version=4.14
soqt_config_version=1.5.0
sqlalchemy_config_version=0.7.7
sqlite_config_version=3070900
srm_ifce_config_version=1.13.0-0
stomppy_config_version=3.1.3
storm_config_version=0.19
swig_config_version=2.0.11
sympy_config_version=0.7.1
tbb_config_version=42_20140122
tcmalloc_config_version=1.7p3
valgrind_config_version=3.10.0
vdt_config_version=0.3.6
voms_config_version=2.0.9-1
xqilla_config_version=2.2.4p1
xrootd_config_version=3.3.6
xrootd_python_config_version=0.1.3
Python_native_version=$(Python_config_version)
Python_home=${LCG_external}/Python/$(Python_native_version)/$(LCG_system)
Python_inc=$(Python_home)/include/python$(Python_version)
Python_version=$(Python_config_version_twodigit)
Python_libversion_cmd=python -c "print ''.join('$(Python_config_version)'.split('.')[:2])"
Python_libversion=$(Python_config_version_twodigit)
Python_linkopts= -L$(Python_home)/lib -lpython$(Python_libversion) -lutil -lpthread 
Python_export_paths=$(Python_home)
MANPATH=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gccxml/0.9.0_20131026/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../tcmalloc/1.7p3/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../libunwind/5c2cade/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Python/2.7.6/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../GSL/1.10/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../mysql/5.5.27/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../uuid/1.42/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CppUnit/1.12.1_p1/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/src/root/man
tcmalloc_tag=$(tag)
TCMALLOCROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/tcmalloc
tcmalloc_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/tcmalloc
TCMALLOCVERSION=v1
tcmalloc_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
tcmalloc_offset=LCG_Interfaces
tcmalloc_project=LCGCMT
tcmalloc_project_release=LCGCMT_71
libunwind_tag=$(tag)
LIBUNWINDROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/libunwind
libunwind_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/libunwind
LIBUNWINDVERSION=v1
libunwind_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
libunwind_offset=LCG_Interfaces
libunwind_project=LCGCMT
libunwind_project_release=LCGCMT_71
libunwind_native_version=$(libunwind_config_version)
libunwind_home=$(LCG_external)/libunwind/$(libunwind_native_version)/$(LCG_system)
libunwind_linkopts=-L$(libunwind_home)/lib -lunwind -lunwind-x86
libunwind_cppflags=-I $(libunwind_home)/include
libunwind_export_paths= $(libunwind_home)/include $(libunwind_home)/lib 
tcmalloc_native_version=$(tcmalloc_config_version)
tcmalloc_home=$(LCG_external)/tcmalloc/$(tcmalloc_native_version)/$(LCG_system)
copyInclude=cp -Rup 
python_bin_module_dir=$(tag)/python/lib-dynload
cmt_actions_constituents=         
cmt_actions_constituentsclean= QMTestGUIclean QMTestTestsDatabaseclean new_rootsysclean TestProjectclean TestPackageclean qmtest_summarizeclean qmtest_runclean makeclean 
remove_command=$(cmt_uninstallarea_command)
dq="
BINDIR=$(tag)
vsDebug=2
merge_componentslist_cmd=python $(GaudiPolicy_root)/scripts/merge_files.py
merge_rootmap_cmd=python $(GaudiPolicy_root)/scripts/merge_files.py
libdirname=lib
bindirname=bin
cppdebugflags_s=-Og -g
cppoptimized_s=-O2 -DNDEBUG
cppprofiled_s=-pg
cdebugflags_s=-Og -g
coptimized_s=-O2 -DNDEBUG
fdebugflags= $(foptimized_s)
fdebugflags_s=-Og -g
foptimized_s=-O2 -DNDEBUG
fprofiled_s=-pg
GaudiKernel_linkopts= -lGaudiKernel 
makeLinkMap=-Wl,-Map,Linux.map
componentshr_linkopts=-fPIC -ldl -Wl,--as-needed -pthread 
libraryshr_linkopts=-fPIC -ldl -Wl,--as-needed -pthread 
application_linkopts=-Wl,--export-dynamic 
shared_install_subdir=/$(tag)
genconfDir=$(shared_install_subdir)/genConf/
merge_genconfDb_cmd=python $(GaudiPolicy_root)/scripts/merge_files.py
genconfig_configurableModuleName=GaudiKernel.Proxy
genconfig_configurableDefaultName=Configurable.DefaultName
genconfig_configurableAlgorithm=ConfigurableAlgorithm
genconfig_configurableAlgTool=ConfigurableAlgTool
genconfig_configurableAuditor=ConfigurableAuditor
genconfig_configurableService=ConfigurableService
use_GaudiCoreSvc=GaudiCoreSvc * -no_auto_imports
strip_script=$(GAUDIPOLICYROOT)/scripts/StripPath
GenConfUser_script=genconfuser.py
Reflex_tag=$(tag)
REFLEXROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Reflex
Reflex_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Reflex
REFLEXVERSION=v1
Reflex_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
Reflex_offset=LCG_Interfaces
Reflex_project=LCGCMT
Reflex_project_release=LCGCMT_71
ROOT_tag=$(tag)
ROOTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/ROOT
ROOT_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/ROOT
ROOTVERSION=v1
ROOT_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
ROOT_offset=LCG_Interfaces
ROOT_project=LCGCMT
ROOT_project_release=LCGCMT_71
GCCXML_tag=$(tag)
GCCXMLROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/GCCXML
GCCXML_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/GCCXML
GCCXMLVERSION=v1
GCCXML_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
GCCXML_offset=LCG_Interfaces
GCCXML_project=LCGCMT
GCCXML_project_release=LCGCMT_71
GCCXML_native_version=$(GCCXML_config_version)
GCCXML_home=$(LCG_external)/gccxml/$(GCCXML_native_version)/$(LCG_system)
GCCXML_name=gccxml
GCCXML_export_paths=$(GCCXML_home)/bin $(GCCXML_home)/share 
xrootd_tag=$(tag)
XROOTDROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/xrootd
xrootd_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/xrootd
XROOTDVERSION=v1
xrootd_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
xrootd_offset=LCG_Interfaces
xrootd_project=LCGCMT
xrootd_project_release=LCGCMT_71
xrootd_native_version=$(xrootd_config_version)
xrootd_home=$(LCG_external)/xrootd/$(xrootd_native_version)/$(LCG_system)
xrootd_linkopts=-L$(xrootd_home)/$(unixdirname) 
xrootd_export_paths= $(xrootd_home)/bin $(xrootd_home)/include $(xrootd_home)/$(unixdirname)   $(xrootd_home)/share
ROOT_native_version=$(ROOT_config_version)
ROOT_base=$(LCG_releases)/ROOT/$(ROOT_native_version)
ROOT_home=$(ROOT_base)/$(LCG_platform)
ROOT_linkopts=-L$(ROOT_home)/lib -lCore -lCint -lTree -lpthread  -lRIO -lHist -lMatrix -lGraf -lNet
ROOT_Reflex_linkopts=-L$(ROOT_home)/lib -lReflex
ROOTSYS=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt
ROOT_name=root
ROOT_header_file_filter=$(ROOT_home)/include
ROOT_header_file_stamp=$(ROOT_home)/include/Type.h
PYTHONPATH=/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload:/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python.zip:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../pytools/1.8_python2.7/armv7l-fc21-gcc49-opt/lib/python2.7/site-packages
rootcint="$(ROOT_home)/bin/rootcint"
genmap_cmd=$(ROOTSYS)/bin/genmap
ROOT_export_paths= $(ROOT_home) 
Reflex_linkopts=$(ROOT_Reflex_linkopts)
genreflex_cmd=$(ROOT_home)/bin/genreflex
gccxmloptsval=--gccxml-compiler $(cpp_name) 
gccxmlopts=--gccxmlopt='$(gccxmloptsval)'
COOLVERS=COOL_2_9_4
CORALVERS=CORAL_2_4_4
ROOTVERS=v5-34-21
BoostVERS=1.55.0
uuidVERS=1.42
GCCXMLVERS=0.9.0_20131026
AIDAVERS=3.2.1
XercesCVERS=3.1.1p1
GSLVERS=1.10
PythonVERS=2.7.6
HepMCVERS=2.06.09
QMtestVERS=2.4.1
LCGCMTVERS=71
GAUDI_DOXY_HOME=/home/jwsmith/HDD/Gaudi/GaudiRelease/doc
GaudiPluginService_tag=$(tag)
GAUDIPLUGINSERVICEROOT=/home/jwsmith/HDD/Gaudi/GaudiPluginService
GaudiPluginService_root=/home/jwsmith/HDD/Gaudi/GaudiPluginService
GAUDIPLUGINSERVICEVERSION=v1r2
GaudiPluginService_cmtpath=/home/jwsmith/HDD/Gaudi
GaudiPluginService_project=GAUDI
GaudiPluginService_project_release=Gaudi
includes= $(ppcmd)"/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/include" $(use_includes)
GaudiPluginService_linkopts= -lGaudiPluginService 
GaudiPluginService_stamps=${GAUDIPLUGINSERVICEROOT}/${BINDIR}/GaudiPluginService.stamp 
GaudiPluginService_linker_library=GaudiPluginService
zip_GaudiPluginService_python_modules_dependencies= GaudiPluginService_python_init 
GaudiPluginService_python_init_dependencies= GaudiPluginService_python 
listcomponents_dependencies= GaudiPluginService 
listcomponentslinkopts= -ldl 
listcomponents_cmd=listcomponents.exe
Boost_tag=$(tag)
BOOSTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Boost
Boost_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Boost
BOOSTVERSION=v1
Boost_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
Boost_offset=LCG_Interfaces
Boost_project=LCGCMT
Boost_project_release=LCGCMT_71
Boost_native_version=$(Boost_config_version)_python$(Python_config_version_twodigit)
Boost_home=$(LCG_external)/Boost/$(Boost_native_version)/$(LCG_system)
Boost_compiler_version=$(LCG_compiler)
Boost_linkopts=-L$(Boost_home)/lib  $(Boost_linkopts_system) $(Boost_linkopts_filesystem) $(Boost_linkopts_thread) 
Boost_linkopts_python= -lboost_python-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_system= -lboost_system-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_filesystem= -lboost_filesystem-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_filesystem_mt= -lboost_filesystem-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_iostreams= -lboost_iostreams-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_regex= -lboost_regex-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_thread= -lboost_thread-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_program_options= -lboost_program_options-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_serialization= -lboost_serialization-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_date_time= -lboost_date_time-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_linkopts_graph= -lboost_graph-$(Boost_compiler_version)-mt-$(Boost_debug)$(Boost_file_version) 
Boost_header_file_filter=$(Boost_home)/include/boost-$(Boost_file_version)
Boost_header_file_stamp=$(Boost_home)/include/boost-$(Boost_file_version)/boost/any.hpp
Boost_export_paths=$(Boost_home)
GaudiKernel_stamps=${GAUDIKERNELROOT}/${BINDIR}/GaudiKernel.stamp 
GaudiKernel_linker_library=GaudiKernel
zip_GaudiKernel_python_modules_dependencies= GaudiKernel_python_init 
GaudiKernel_python_init_dependencies= GaudiKernel_python 
GaudiKernelDict_use_linkopts=$(use_linkopts)
GaudiKernelGen_dependencies=install_more_includes
genconfig_cmd=genconf.exe
CLHEP_tag=$(tag)
CLHEPROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/CLHEP
CLHEP_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/CLHEP
CLHEPVERSION=v1
CLHEP_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
CLHEP_offset=LCG_Interfaces
CLHEP_project=LCGCMT
CLHEP_project_release=LCGCMT_71
CLHEP_native_version=1.9.4.7
CLHEP_home=$(LCG_external)/clhep/$(CLHEP_native_version)/$(LCG_system)
CLHEP_linkopts=-L$(CLHEP_home)/lib         -lCLHEP-Cast-$(CLHEP_native_version)        -lCLHEP-Evaluator-$(CLHEP_native_version)        -lCLHEP-Exceptions-$(CLHEP_native_version)        -lCLHEP-GenericFunctions-$(CLHEP_native_version)        -lCLHEP-Geometry-$(CLHEP_native_version)        -lCLHEP-Random-$(CLHEP_native_version)        -lCLHEP-RandomObjects-$(CLHEP_native_version)        -lCLHEP-RefCount-$(CLHEP_native_version)         -lCLHEP-Vector-$(CLHEP_native_version)        -lCLHEP-Matrix-$(CLHEP_native_version)  
CLHEP_name=clhep
CLHEP_export_paths=$(CLHEP_home)/include $(CLHEP_home)/lib
GaudiSvc_shlibflags=$(componentshr_linkopts) $(cmt_installarea_linkopts) $(GaudiSvc_use_linkopts)  
GaudiSvc_dependencies=$(GaudiSvc_linker_library) 
GaudiSvcComponentsList_dependencies= GaudiSvc 
merge_componentslist_tag=--do-merge
GaudiSvcMergeComponentsList_dependencies= GaudiSvcComponentsList 
GaudiCoreSvc_tag=$(tag)
GAUDICORESVCROOT=/home/jwsmith/HDD/Gaudi/GaudiCoreSvc
GaudiCoreSvc_root=/home/jwsmith/HDD/Gaudi/GaudiCoreSvc
GAUDICORESVCVERSION=v3r1
GaudiCoreSvc_cmtpath=/home/jwsmith/HDD/Gaudi
GaudiCoreSvc_project=GAUDI
GaudiCoreSvc_project_release=Gaudi
GaudiCoreSvcComponentsList_dependencies= GaudiCoreSvc 
run_genconfig_cmd=do_real_genconfig
GaudiSvcConf_dependencies= GaudiSvc 
zip_GaudiSvc_python_modules_output=$(CMTINSTALLAREA)$(shared_install_subdir)/python.zip
zip_GaudiSvc_python_modules_deps=FORCE
zip_GaudiSvc_python_modules_command=test -d $(CMTINSTALLAREA)$(shared_install_subdir)/python && python $(GaudiPolicy_root)/scripts/ZipPythonDir.py $(CMTINSTALLAREA)$(shared_install_subdir)/python || echo Nothing to zip.
zip_GaudiSvc_python_modules_pattern_applied=CallCommand
zip_GaudiSvc_python_modules_dependencies= GaudiSvc_python_init  GaudiSvcConfDbMerge  GaudiSvc_python_init  GaudiSvcTestConfDbMerge  GaudiSvc_python_init 
GaudiSvc_python_init_dependencies= GaudiSvcConf  GaudiSvcTestConf  GaudiSvcGenConfUser  GaudiSvc_python 
merge_genconfDb_tag=--do-merge
GaudiSvcConfDbMerge_dependencies= GaudiSvcConf 
GaudiSvcTest_shlibflags=$(componentshr_linkopts) $(cmt_installarea_linkopts) $(GaudiSvcTest_use_linkopts)  
GaudiSvcTest_dependencies=$(GaudiSvc_linker_library) 
GaudiSvcTestComponentsList_dependencies= GaudiSvcTest 
GaudiSvcTestMergeComponentsList_dependencies= GaudiSvcTestComponentsList 
GaudiSvcTestConf_dependencies= GaudiSvcTest 
GaudiSvcTestConfDbMerge_dependencies= GaudiSvcTestConf 
do_genconfuser=real_genconfuser
GaudiSvcGenConfUser_output=$(GaudiSvc_root)$(genconfDir)GaudiSvc/GaudiSvc_user.confdb
GaudiSvcGenConfUser_python=$(GaudiSvc_root)/python
GaudiSvcGenConfUser_deps=FORCE
GaudiSvcGenConfUser_command=$(GenConfUser_script) --lockerpath $(GaudiPolicy_root)/scripts -r $(GaudiSvcGenConfUser_python) -o $(GaudiSvcGenConfUser_output) GaudiSvc $(GaudiSvcConfUserModules)
GaudiSvcConfUserDbMerge_dependencies= GaudiSvcGenConfUser GaudiSvc_python 
qmtest_local_dir=../tests/qmtest
qmtest_run_dependencies= tests 
GaudiPolicyDir=${GAUDIPOLICYROOT}/${BINDIR}
GaudiPluginServiceDir=${GAUDIPLUGINSERVICEROOT}/${BINDIR}
GaudiKernelDir=${GAUDIKERNELROOT}/${BINDIR}
GaudiCoreSvcDir=${GAUDICORESVCROOT}/${BINDIR}
GaudiSvcDir=${GAUDISVCROOT}/${BINDIR}
generate_manifest_file_output=$(CMTINSTALLAREA)/$(tag)/manifest.xml
generate_manifest_file_deps=FORCE
generate_manifest_file_command=python $(GaudiPolicy_root)/scripts/project_manifest.py -o $(generate_manifest_file_output) $(GaudiSvc_cmtpath)/CMakeLists.txt $(LCG_config_version) $(tag)
generate_manifest_file_applied=NullCommand
dummy_for_NullCommand=generate_manifest_file 
tag=armv7l-fc21-gcc49-opt
package=GaudiSvc
version=v21r3
PACKAGE_ROOT=$(GAUDISVCROOT)
srcdir=../src
bin=../$(GaudiSvc_tag)/
javabin=../classes/
mgrdir=cmt
BIN=/home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/
project=GAUDI
cmt_installarea_paths= $(cmt_installarea_prefix)/$(CMTCONFIG)/bin $(GAUDI_installarea_prefix)/$(CMTCONFIG)/lib $(GAUDI_installarea_prefix)/share/lib $(GAUDI_installarea_prefix)/share/bin
use_linkopts= $(cmt_installarea_linkopts)   $(GaudiSvc_linkopts)  $(GaudiKernel_linkopts)  $(GaudiPluginService_linkopts)  $(GaudiPolicy_linkopts)  $(Reflex_linkopts)  $(Boost_linkopts)  $(LCG_Settings_linkopts)  $(LCG_Configuration_linkopts)  $(LCG_Platforms_linkopts) 
LCGCMT_installarea_prefix=$(cmt_installarea_prefix)
LCGCMT_installarea_prefix_remove=$(LCGCMT_installarea_prefix)
GAUDI_installarea_prefix=$(cmt_installarea_prefix)
GAUDI_installarea_prefix_remove=$(GAUDI_installarea_prefix)
cmt_installarea_linkopts= -L/home/jwsmith/HDD/Gaudi/$(GAUDI_installarea_prefix)/$(CMTCONFIG)/lib 
LCGCMT_home=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
GAUDI_home=/home/jwsmith/HDD/Gaudi
GAUDI_install_include=/home/jwsmith/HDD/Gaudi/$(GAUDI_installarea_prefix)$(shared_install_subdir)/include
ROOT_INCLUDE_PATH=/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/include
GAUDI_install_python=/home/jwsmith/HDD/Gaudi/$(GAUDI_installarea_prefix)$(shared_install_subdir)/python.zip
GAUDI_install_pyd_module=/home/jwsmith/HDD/Gaudi/$(GAUDI_installarea_prefix)/$(python_bin_module_dir)
scripts_offset=.
scripts_maindir=scripts
scripts_dir=$(scripts_maindir)
GAUDI_install_scripts=/home/jwsmith/HDD/Gaudi/$(GAUDI_installarea_prefix)$(shared_install_subdir)/$(scripts_dir)
genconfInstallDir=$(CMTINSTALLAREA)$(shared_install_subdir)/python
CMTINSTALLAREA=/home/jwsmith/HDD/Gaudi/$(cmt_installarea_prefix)
use_requirements=requirements $(CMT_root)/mgr/requirements $(GaudiCoreSvc_root)/cmt/requirements $(GaudiKernel_root)/cmt/requirements $(GaudiPluginService_root)/cmt/requirements $(GaudiPolicy_root)/cmt/requirements $(Reflex_root)/cmt/requirements $(ROOT_root)/cmt/requirements $(Boost_root)/cmt/requirements $(Python_root)/cmt/requirements $(tcmalloc_root)/cmt/requirements $(libunwind_root)/cmt/requirements $(GCCXML_root)/cmt/requirements $(xrootd_root)/cmt/requirements $(CLHEP_root)/cmt/requirements $(LCG_Settings_root)/cmt/requirements $(LCG_Configuration_root)/cmt/requirements $(LCG_Platforms_root)/cmt/requirements 
use_includes= $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/include" $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Boost/1.55.0_python2.7/armv7l-fc21-gcc49-opt/include/boost-1_55" $(ppcmd)"$(LCG_Platforms_root)/src" 
use_fincludes= $(use_includes)
use_stamps=  $(GaudiSvc_stamps)  $(GaudiKernel_stamps)  $(GaudiPluginService_stamps)  $(GaudiPolicy_stamps)  $(Reflex_stamps)  $(Boost_stamps)  $(LCG_Settings_stamps)  $(LCG_Configuration_stamps)  $(LCG_Platforms_stamps) 
use_cflags=  $(GaudiSvc_cflags)  $(GaudiKernel_cflags)  $(GaudiPluginService_cflags)  $(GaudiPolicy_cflags)  $(Reflex_cflags)  $(Boost_cflags)  $(LCG_Settings_cflags)  $(LCG_Configuration_cflags)  $(LCG_Platforms_cflags) 
use_pp_cflags=  $(GaudiSvc_pp_cflags)  $(GaudiKernel_pp_cflags)  $(GaudiPluginService_pp_cflags)  $(GaudiPolicy_pp_cflags)  $(Reflex_pp_cflags)  $(Boost_pp_cflags)  $(LCG_Settings_pp_cflags)  $(LCG_Configuration_pp_cflags)  $(LCG_Platforms_pp_cflags) 
use_cppflags=  $(GaudiSvc_cppflags)  $(GaudiKernel_cppflags)  $(GaudiPluginService_cppflags)  $(GaudiPolicy_cppflags)  $(Reflex_cppflags)  $(Boost_cppflags)  $(LCG_Settings_cppflags)  $(LCG_Configuration_cppflags)  $(LCG_Platforms_cppflags) 
use_pp_cppflags=  $(GaudiSvc_pp_cppflags)  $(GaudiKernel_pp_cppflags)  $(GaudiPluginService_pp_cppflags)  $(GaudiPolicy_pp_cppflags)  $(Reflex_pp_cppflags)  $(Boost_pp_cppflags)  $(LCG_Settings_pp_cppflags)  $(LCG_Configuration_pp_cppflags)  $(LCG_Platforms_pp_cppflags) 
use_fflags=  $(GaudiSvc_fflags)  $(GaudiKernel_fflags)  $(GaudiPluginService_fflags)  $(GaudiPolicy_fflags)  $(Reflex_fflags)  $(Boost_fflags)  $(LCG_Settings_fflags)  $(LCG_Configuration_fflags)  $(LCG_Platforms_fflags) 
use_pp_fflags=  $(GaudiSvc_pp_fflags)  $(GaudiKernel_pp_fflags)  $(GaudiPluginService_pp_fflags)  $(GaudiPolicy_pp_fflags)  $(Reflex_pp_fflags)  $(Boost_pp_fflags)  $(LCG_Settings_pp_fflags)  $(LCG_Configuration_pp_fflags)  $(LCG_Platforms_pp_fflags) 
use_libraries= $(GaudiCoreSvc_libraries)  $(GaudiKernel_libraries)  $(GaudiPluginService_libraries)  $(GaudiPolicy_libraries)  $(Reflex_libraries)  $(ROOT_libraries)  $(Boost_libraries)  $(Python_libraries)  $(tcmalloc_libraries)  $(libunwind_libraries)  $(GCCXML_libraries)  $(xrootd_libraries)  $(CLHEP_libraries)  $(LCG_Settings_libraries)  $(LCG_Configuration_libraries)  $(LCG_Platforms_libraries) 
fincludes= $(includes)
GaudiSvc_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvc_use_linkopts=  $(GaudiSvc_linkopts)  $(GaudiKernel_linkopts)  $(GaudiPluginService_linkopts)  $(GaudiPolicy_linkopts)  $(Reflex_linkopts)  $(ROOT_linkopts)  $(Boost_linkopts)  $(xrootd_linkopts)  $(CLHEP_linkopts)  $(LCG_Settings_linkopts)  $(LCG_Configuration_linkopts)  $(LCG_Platforms_linkopts) 
lib_GaudiSvc_cflags= $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/include"  $(ROOT_cflags) $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/include"  $(xrootd_cflags) $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../clhep/1.9.4.7/armv7l-fc21-gcc49-opt/include"  $(CLHEP_cflags) 
lib_GaudiSvc_pp_cflags=  $(ROOT_pp_cflags)  $(xrootd_pp_cflags)  $(CLHEP_pp_cflags) 
lib_GaudiSvc_cppflags= $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/include"  $(ROOT_cppflags) $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/include"  $(xrootd_cppflags) $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../clhep/1.9.4.7/armv7l-fc21-gcc49-opt/include"  $(CLHEP_cppflags) 
lib_GaudiSvc_pp_cppflags=  $(ROOT_pp_cppflags)  $(xrootd_pp_cppflags)  $(CLHEP_pp_cppflags) 
lib_GaudiSvc_fflags= $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/v5-34-21/armv7l-fc21-gcc49-opt/include"  $(ROOT_fflags) $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/include"  $(xrootd_fflags) $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../clhep/1.9.4.7/armv7l-fc21-gcc49-opt/include"  $(CLHEP_fflags) 
lib_GaudiSvc_pp_fflags=  $(ROOT_pp_fflags)  $(xrootd_pp_fflags)  $(CLHEP_pp_fflags) 
GaudiSvc_stamps=  $(ROOT_stamps)  $(xrootd_stamps)  $(CLHEP_stamps) 
GaudiSvcTest_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcTest_use_linkopts=  $(GaudiSvc_linkopts)  $(GaudiKernel_linkopts)  $(GaudiPluginService_linkopts)  $(GaudiPolicy_linkopts)  $(Reflex_linkopts)  $(Boost_linkopts)  $(LCG_Settings_linkopts)  $(LCG_Configuration_linkopts)  $(LCG_Platforms_linkopts) 
GaudiSvcComponentsList_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcMergeComponentsList_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcConf_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvc_python_init_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
zip_GaudiSvc_python_modules_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcConfDbMerge_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcTestComponentsList_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcTestMergeComponentsList_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcTestConf_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcTestConfDbMerge_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvc_python_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcGenConfUser_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
GaudiSvcConfUserDbMerge_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
make_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
CompilePython_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
qmtest_run_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
qmtest_summarize_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
TestPackage_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
TestProject_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
new_rootsys_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
QMTestTestsDatabase_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
QMTestGUI_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
constituents= GaudiSvc GaudiSvcComponentsList GaudiSvcMergeComponentsList GaudiSvcConf GaudiSvc_python_init zip_GaudiSvc_python_modules GaudiSvcConfDbMerge GaudiSvcTestComponentsList GaudiSvcTestMergeComponentsList GaudiSvcTestConf GaudiSvcTestConfDbMerge GaudiSvc_python GaudiSvcGenConfUser GaudiSvcConfUserDbMerge 
all_constituents= $(constituents)
constituentsclean= GaudiSvcConfUserDbMergeclean GaudiSvcGenConfUserclean GaudiSvc_pythonclean GaudiSvcTestConfDbMergeclean GaudiSvcTestConfclean GaudiSvcTestMergeComponentsListclean GaudiSvcTestComponentsListclean GaudiSvcConfDbMergeclean zip_GaudiSvc_python_modulesclean GaudiSvc_python_initclean GaudiSvcConfclean GaudiSvcMergeComponentsListclean GaudiSvcComponentsListclean GaudiSvcclean 
all_constituentsclean= $(constituentsclean)
tests_constituents= GaudiSvcTest 
tests_constituentsclean= GaudiSvcTestclean 
GaudiSvcprototype_dependencies= $(GaudiSvccompile_dependencies)
GaudiSvcTestprototype_dependencies= $(GaudiSvcTestcompile_dependencies)
