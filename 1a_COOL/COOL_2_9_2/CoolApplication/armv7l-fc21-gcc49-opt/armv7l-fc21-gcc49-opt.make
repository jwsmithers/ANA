lcgcmt_installarea=without_installarea
CMTPATH=/home/jwsmith/HDD:/home/jwsmith/HDD/COOL/COOL_2_9_2:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
CMT_tag=$(tag)
CMTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
CMT_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131
CMTVERSION=v1r26p20140131
CMT_cmtpath=/home/jwsmith/HDD
CMT_offset=lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt
CMT_project=jwsmith
CMT_project_release=HDD
cmt_hardware_query_command=uname -m
cmt_hardware=`$(cmt_hardware_query_command)`
cmt_system_version_query_command=${CMTROOT}/mgr/cmt_linux_version.sh | ${CMTROOT}/mgr/cmt_filter_version.sh
cmt_system_version=`$(cmt_system_version_query_command)`
cmt_compiler_version_query_command=${CMTROOT}/mgr/cmt_gcc_version.sh | ${CMTROOT}/mgr/cmt_filter3_version.sh
cmt_compiler_version=`$(cmt_compiler_version_query_command)`
PATH=/home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/examples/bin:/home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/examples/bin:/home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/tests/bin:/home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/tests/bin:/home/jwsmith/HDD/../${CMTCONFIG}/bin:/home/jwsmith/HDD/COOL/COOL_2_9_2/../${CMTCONFIG}/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CORAL/CORAL_2_4_4/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Python/2.7.6/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gcc/4.9.1/UnknownArch-fc21/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../valgrind/3.10.0/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../QMtest/2.4.1_python2.7/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../XercesC/3.1.1p1/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../frontier_client/2.8.10/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../sqlite/3070900/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../mysql/5.5.27/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../oracle/11.2.0.3.0/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/COOL/COOL_2_9_2/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../qt/4.8.4/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/5.34.24/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gccxml/0.9.0_20131026/armv7l-fc21-gcc49-opt/bin:/usr/lib/ccache:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/jwsmith/.local/bin:/home/jwsmith/bin:/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131/${CMTBIN}
CLASSPATH=/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt/CMT/v1r26p20140131/java
debug_option=-g
cc=$(cc_name)
cflags=$(cppflags) -std=c11 
ccomp=$(cc) -c $(includes) $(cdebugflags) $(cflags) $(pp_cflags)
clink=$(cc) $(clinkflags) $(cdebugflags)
vsCONFIG=Release
vsOptimize=2
ppcmd=-I
preproc=c++ -MD -c 
cpp=$(cpp_name)
cppdebugflags=$(cppoptimized_s)
cppflags= $(cppmacros) -fPIC -pipe -ansi -Wall -W -pthread  -std=c++11 
pp_cppflags=-D_GNU_SOURCE
cppcomp=$(cpp) -c $(includes) $(cppdebugflags) $(cppflags) $(pp_cppflags)
cpplinkflags= -ldl -fpic -pthread -Wl,-E 
cpplink=$(cpplinkname) $(cpplinkflags)
for=$(for_name)
fflags=-O -fno-automatic -fdollar-ok -ff90 -w
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
library_install_command=${symlink}
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
install_command=cp 
uninstall_command=/bin/rm -f 
cmt_installarea_command=cp 
cmt_uninstallarea_command=/bin/rm -f 
cmt_install_area_command=$(cmt_installarea_command)
cmt_uninstall_area_command=$(cmt_uninstallarea_command)
cmt_install_action=$(CMTROOT)/mgr/cmt_install_action.sh
cmt_installdir_action=$(CMTROOT)/mgr/cmt_installdir_action.sh
cmt_uninstall_action=$(CMTROOT)/mgr/cmt_uninstall_action.sh
cmt_uninstalldir_action=$(CMTROOT)/mgr/cmt_uninstalldir_action.sh
mkdir=mkdir
cmt_cvs_protocol_level=v1r1
cmt_installarea_prefix=..
CMT_PATH_remove_regexp=/[^/]*/
CMT_PATH_remove_share_regexp=/share/
NEWCMTCONFIG=armv7l-fedora21-gcc492
CoolApplication_tag=$(tag)
COOLAPPLICATIONROOT=/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolApplication
CoolApplication_root=/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolApplication
COOLAPPLICATIONVERSION=v1
CoolApplication_cmtpath=/home/jwsmith/HDD
CoolApplication_offset=COOL/COOL_2_9_2
CoolApplication_project=jwsmith
CoolApplication_project_release=HDD
CoolKernel_tag=$(tag)
COOLKERNELROOT=/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolKernel
CoolKernel_root=/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolKernel
COOLKERNELVERSION=v1
CoolKernel_cmtpath=/home/jwsmith/HDD/COOL/COOL_2_9_2
CoolKernel_project=COOL
CoolKernel_project_release=COOL_2_9_2
LCG_Policy_tag=$(tag)
LCG_POLICYROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Policy
LCG_Policy_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Policy
LCG_POLICYVERSION=v1
LCG_Policy_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
LCG_Policy_project=LCGCMT
LCG_Policy_project_release=LCGCMT_71
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
cc_name=gcc
cpp_name=g++
cpplinkname=$(cpp_name)
for_name=gfortran
COMPILER_PATH=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gcc/4.9.1/UnknownArch-fc21/lib/gcc/UnknownArch-unknown-linux-gnu/4.9.1
LD_LIBRARY_PATH=/home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/tests/lib:/home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/tests/lib:/home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/examples/lib:/home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/examples/lib:/home/jwsmith/HDD/../${CMTCONFIG}/lib:/home/jwsmith/HDD/COOL/COOL_2_9_2/../${CMTCONFIG}/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CORAL/CORAL_2_4_4/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../uuid/1.42/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Boost/1.55.0_python2.7/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gcc/4.9.1/UnknownArch-fc21/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../XercesC/3.1.1p1/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../frontier_client/2.8.10/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../expat/2.0.1/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../sqlite/3070900/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../mysql/5.5.27/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../oracle/11.2.0.3.0/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/COOL/COOL_2_9_2/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../qt/4.8.4/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/5.34.24/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../xrootd/3.3.6/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CppUnit/1.12.1_p1/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Python/2.7.6/armv7l-fc21-gcc49-opt/lib
merge_rootmap_cmd=$(LCG_Policy_root)/cmt/fragments/merge_files.py
vsDebug=2
cppdebugflags_s=-g
cppoptimized_s=-O2
cppprofiled_s=-pg
cdebugflags_s=-g
fdebugflags= $(foptimized_s)
fdebugflags_s=-g
foptimized_s=-O2
fprofiled_s=-pg
cppmacros= -Df2cFortran -fPIC -D_GNU_SOURCE -Dlinux -Dunix 
gcov_cppflags=-fprofile-arcs -ftest-coverage
makeLinkMap=-Wl,-Map,Linux.map
componentshr_linkopts= -shared -fPIC -Wl,-s -ldl -pthread 
libraryshr_linkopts= -shared -fPIC -ldl -pthread 
application_linkopts=-Wl,--export-dynamic 
libdirname=lib
bindirname=bin
Boost_tag=$(tag)
BOOSTROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Boost
Boost_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Boost
BOOSTVERSION=v1
Boost_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
Boost_offset=LCG_Interfaces
Boost_project=LCGCMT
Boost_project_release=LCGCMT_71
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
ROOT_config_version=5.34.24
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
Python_tag=$(tag)
PYTHONROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Python
Python_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/Python
PYTHONVERSION=v1
Python_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
Python_offset=LCG_Interfaces
Python_project=LCGCMT
Python_project_release=LCGCMT_71
Python_native_version=$(Python_config_version)
Python_home=${LCG_external}/Python/$(Python_native_version)/$(LCG_system)
Python_inc=$(Python_home)/include/python$(Python_version)
Python_version=$(Python_config_version_twodigit)
Python_libversion_cmd=python -c "print ''.join('$(Python_config_version)'.split('.')[:2])"
Python_libversion=$(Python_config_version_twodigit)
Python_linkopts= -L$(Python_home)/lib -lpython$(Python_libversion) -lutil -lpthread 
Python_export_paths=$(Python_home)
MANPATH=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../uuid/1.42/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Python/2.7.6/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../expat/2.0.1/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../mysql/5.5.27/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/5.34.24/armv7l-fc21-gcc49-opt/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../gccxml/0.9.0_20131026/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CppUnit/1.12.1_p1/armv7l-fc21-gcc49-opt/share/man:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/5.34.24/src/root/man
Boost_native_version=$(Boost_config_version)_python$(Python_config_version_twodigit)
Boost_home=$(LCG_external)/Boost/$(Boost_native_version)/$(LCG_system)
Boost_compiler_version=$(LCG_compiler)
Boost_linkopts=-L$(Boost_home)/lib 
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
CORAL_tag=$(tag)
CORALROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/CORAL
CORAL_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/CORAL
CORALVERSION=v1
CORAL_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
CORAL_offset=LCG_Interfaces
CORAL_project=LCGCMT
CORAL_project_release=LCGCMT_71
uuid_tag=$(tag)
UUIDROOT=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/uuid
uuid_root=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Interfaces/uuid
UUIDVERSION=v1
uuid_cmtpath=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
uuid_offset=LCG_Interfaces
uuid_project=LCGCMT
uuid_project_release=LCGCMT_71
uuid_native_version=$(uuid_config_version)
uuid_home=$(LCG_external)/uuid/$(uuid_native_version)/$(LCG_system)
uuid_includes=$(uuid_home)/include
uuid_linkopts=-L$(uuid_home)/lib -luuid
uuid_export_paths= $(uuid_home)/include $(uuid_home)/lib
CORAL_native_version=$(CORAL_config_version)
CORAL_base=$(LCG_releases)/CORAL/$(CORAL_native_version)
CORAL_home=$(CORAL_base)/$(LCG_platform)
CORAL_libs=-L$(CORAL_home)/lib -llcg_CoralBase 
CORAL_relacc_libs=-llcg_CoralKernel -llcg_RelationalAccess 
CORAL_linkopts=$(CORAL_libs)
PYTHONPATH=/home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/python:/home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/python:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CORAL/CORAL_2_4_4/armv7l-fc21-gcc49-opt/python:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CORAL/CORAL_2_4_4/armv7l-fc21-gcc49-opt/lib:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../QMtest/2.4.1_python2.7/armv7l-fc21-gcc49-opt/lib/python2.7/site-packages:/home/jwsmith/HDD/COOL/COOL_2_9_2/python:/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../ROOT/5.34.24/armv7l-fc21-gcc49-opt/lib
CORAL_export_paths= $(CORAL_home)/lib $(CORAL_home)/include $(CORAL_home)/python
CoolKernel_linkopts= -llcg_CoolKernel  $(Boost_linkopts) $(Boost_linkopts_filesystem) $(Boost_linkopts_date_time) $(Boost_linkopts_system) $(Boost_linkopts_thread)
cmt_actions_constituents= make    
use_cppflags=  $(CoolApplication_cppflags)  $(RelationalCool_cppflags)  $(CoolKernel_cppflags)  $(LCG_Policy_cppflags)  $(CORAL_cppflags)  $(Boost_cppflags)  $(LCG_Settings_cppflags)  $(LCG_Configuration_cppflags)  $(LCG_Platforms_cppflags) 
lcg_CoolKernel_shlibflags= $(Boost_linkopts) $(Boost_linkopts_filesystem) $(Boost_linkopts_date_time) $(Boost_linkopts_system) $(Boost_linkopts_thread)
RelationalCool_tag=$(tag)
RELATIONALCOOLROOT=/home/jwsmith/HDD/COOL/COOL_2_9_2/RelationalCool
RelationalCool_root=/home/jwsmith/HDD/COOL/COOL_2_9_2/RelationalCool
RELATIONALCOOLVERSION=v1
RelationalCool_cmtpath=/home/jwsmith/HDD/COOL/COOL_2_9_2
RelationalCool_project=COOL
RelationalCool_project_release=COOL_2_9_2
RelationalCool_linkopts= -llcg_RelationalCool 
CoolApplication_linkopts= -llcg_CoolApplication 
lcg_CoolApplication_shlibflags=$(libraryshr_linkopts) $(cmt_installarea_linkopts) $(lcg_CoolApplication_use_linkopts) 
lcg_CoolApplication_use_linkopts=    $(RelationalCool_linkopts)  $(CoolKernel_linkopts)  $(LCG_Policy_linkopts)  $(CORAL_linkopts)  $(Boost_linkopts)  $(LCG_Settings_linkopts)  $(LCG_Configuration_linkopts)  $(LCG_Platforms_linkopts) 
run_install_pythonmods=do_install_pythonmods
tag=armv7l-fc21-gcc49-opt
package=CoolApplication
version=v1
PACKAGE_ROOT=$(COOLAPPLICATIONROOT)
srcdir=../src
bin=../$(CoolApplication_tag)/
javabin=../classes/
mgrdir=cmt
BIN=/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolApplication/armv7l-fc21-gcc49-opt/
project=jwsmith
cmt_installarea_paths= $(cmt_installarea_prefix)/$(CMTCONFIG)/bin $(COOL_installarea_prefix)/$(CMTCONFIG)/lib $(COOL_installarea_prefix)/share/lib $(COOL_installarea_prefix)/share/bin $(jwsmith_installarea_prefix)/$(CMTCONFIG)/lib $(jwsmith_installarea_prefix)/share/lib $(jwsmith_installarea_prefix)/share/bin
use_linkopts= $(cmt_installarea_linkopts)   $(CoolApplication_linkopts)  $(RelationalCool_linkopts)  $(CoolKernel_linkopts)  $(LCG_Policy_linkopts)  $(CORAL_linkopts)  $(Boost_linkopts)  $(LCG_Settings_linkopts)  $(LCG_Configuration_linkopts)  $(LCG_Platforms_linkopts) 
LCGCMT_installarea_prefix=$(cmt_installarea_prefix)
LCGCMT_installarea_prefix_remove=[.][.]
lcgcmake-install-gcc49_installarea_prefix=$(cmt_installarea_prefix)
lcgcmake-install-gcc49_installarea_prefix_remove=[.][.]
COOL_installarea_prefix=$(cmt_installarea_prefix)
COOL_installarea_prefix_remove=[.][.]
jwsmith_installarea_prefix=$(cmt_installarea_prefix)
jwsmith_installarea_prefix_remove=[.][.]
cmt_installarea_linkopts= -L/home/jwsmith/HDD/$(jwsmith_installarea_prefix)/$(CMTCONFIG)/lib  -L/home/jwsmith/HDD/COOL/COOL_2_9_2/$(COOL_installarea_prefix)/$(CMTCONFIG)/lib 
LCGCMT_home=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71
lcgcmake-install-gcc49_home=/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT
COOL_home=/home/jwsmith/HDD/COOL/COOL_2_9_2
jwsmith_home=/home/jwsmith/HDD
CMTINSTALLAREA=/home/jwsmith/HDD/COOL/COOL_2_9_2/$(cmt_installarea_prefix)
use_requirements=requirements $(CMT_root)/mgr/requirements $(RelationalCool_root)/cmt/requirements $(CoolKernel_root)/cmt/requirements $(LCG_Policy_root)/cmt/requirements $(CORAL_root)/cmt/requirements $(Boost_root)/cmt/requirements $(Python_root)/cmt/requirements $(uuid_root)/cmt/requirements $(LCG_Settings_root)/cmt/requirements $(LCG_Configuration_root)/cmt/requirements $(LCG_Platforms_root)/cmt/requirements 
use_includes= $(ppcmd)"/home/jwsmith/HDD/COOL/COOL_2_9_2/RelationalCool" $(ppcmd)"/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolKernel" $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../CORAL/CORAL_2_4_4/armv7l-fc21-gcc49-opt/include" $(ppcmd)"/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71/LCG_Settings/../../../Boost/1.55.0_python2.7/armv7l-fc21-gcc49-opt/include/boost-1_55" $(ppcmd)"$(LCG_Platforms_root)/src" 
use_fincludes= $(use_includes)
use_stamps=  $(CoolApplication_stamps)  $(RelationalCool_stamps)  $(CoolKernel_stamps)  $(LCG_Policy_stamps)  $(CORAL_stamps)  $(Boost_stamps)  $(LCG_Settings_stamps)  $(LCG_Configuration_stamps)  $(LCG_Platforms_stamps) 
use_cflags=  $(CoolApplication_cflags)  $(RelationalCool_cflags)  $(CoolKernel_cflags)  $(LCG_Policy_cflags)  $(CORAL_cflags)  $(Boost_cflags)  $(LCG_Settings_cflags)  $(LCG_Configuration_cflags)  $(LCG_Platforms_cflags) 
use_pp_cflags=  $(CoolApplication_pp_cflags)  $(RelationalCool_pp_cflags)  $(CoolKernel_pp_cflags)  $(LCG_Policy_pp_cflags)  $(CORAL_pp_cflags)  $(Boost_pp_cflags)  $(LCG_Settings_pp_cflags)  $(LCG_Configuration_pp_cflags)  $(LCG_Platforms_pp_cflags) 
use_pp_cppflags=  $(CoolApplication_pp_cppflags)  $(RelationalCool_pp_cppflags)  $(CoolKernel_pp_cppflags)  $(LCG_Policy_pp_cppflags)  $(CORAL_pp_cppflags)  $(Boost_pp_cppflags)  $(LCG_Settings_pp_cppflags)  $(LCG_Configuration_pp_cppflags)  $(LCG_Platforms_pp_cppflags) 
use_fflags=  $(CoolApplication_fflags)  $(RelationalCool_fflags)  $(CoolKernel_fflags)  $(LCG_Policy_fflags)  $(CORAL_fflags)  $(Boost_fflags)  $(LCG_Settings_fflags)  $(LCG_Configuration_fflags)  $(LCG_Platforms_fflags) 
use_pp_fflags=  $(CoolApplication_pp_fflags)  $(RelationalCool_pp_fflags)  $(CoolKernel_pp_fflags)  $(LCG_Policy_pp_fflags)  $(CORAL_pp_fflags)  $(Boost_pp_fflags)  $(LCG_Settings_pp_fflags)  $(LCG_Configuration_pp_fflags)  $(LCG_Platforms_pp_fflags) 
use_libraries= $(RelationalCool_libraries)  $(CoolKernel_libraries)  $(LCG_Policy_libraries)  $(CORAL_libraries)  $(Boost_libraries)  $(Python_libraries)  $(uuid_libraries)  $(LCG_Settings_libraries)  $(LCG_Configuration_libraries)  $(LCG_Platforms_libraries) 
includes= $(ppcmd)"/home/jwsmith/HDD/COOL/COOL_2_9_2/CoolApplication" $(use_includes)
fincludes= $(includes)
lcg_CoolApplication_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
install_includes_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
install_pythonmods_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
make_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
tests_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
utilities_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
examples_GUID={88BF15AB-5A2D-4bea-B64F-02752C2A1F4F}
constituents= lcg_CoolApplication install_includes install_pythonmods 
all_constituents= $(constituents)
constituentsclean= install_pythonmodsclean install_includesclean lcg_CoolApplicationclean 
all_constituentsclean= $(constituentsclean)
cmt_actions_constituentsclean= examplesclean utilitiesclean testsclean makeclean 
