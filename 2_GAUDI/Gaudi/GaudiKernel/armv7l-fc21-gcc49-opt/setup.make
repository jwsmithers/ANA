----------> uses
# use GaudiPolicy *  (no_version_directory)
#   use LCG_Settings *  (no_version_directory)
#   use Python * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#     use LCG_Configuration v*  (no_version_directory)
#     use LCG_Settings v*  (no_version_directory)
#   use tcmalloc * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.7p3)
#     use LCG_Configuration v*  (no_version_directory)
#     use LCG_Settings v*  (no_version_directory)
#     use libunwind v* LCG_Interfaces (no_version_directory) (native_version=5c2cade)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#   use Reflex v* LCG_Interfaces (no_auto_imports) (no_version_directory)
# use GaudiPluginService *  (no_version_directory)
#   use GaudiPolicy *  (no_version_directory)
# use Reflex * LCG_Interfaces (no_version_directory)
#   use LCG_Configuration v*  (no_version_directory)
#     use LCG_Platforms *  (no_version_directory)
#   use LCG_Settings v*  (no_version_directory)
#   use ROOT v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=v5-34-21)
#     use LCG_Configuration v*  (no_version_directory)
#     use LCG_Settings v*  (no_version_directory)
#     use GCCXML v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=0.9.0_20131026)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#     use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#     use xrootd v* LCG_Interfaces (no_version_directory) (native_version=3.3.6)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
# use Boost * LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#   use LCG_Configuration v*  (no_version_directory)
#   use LCG_Settings v*  (no_version_directory)
#   use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
# use CppUnit * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.12.1_p1)
#   use LCG_Configuration v*  (no_version_directory)
#   use LCG_Settings v*  (no_version_directory)
#
# Selection :
use CMT v1r26p20140131 (/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt)
use LCG_Platforms v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use LCG_Configuration v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use LCG_Settings v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use CppUnit v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use xrootd v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use GCCXML v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use libunwind v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use tcmalloc v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use Python v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use Boost v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use ROOT v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use Reflex v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use GaudiPolicy v15r0  (/home/jwsmith/HDD/Gaudi)
use GaudiPluginService v1r2  (/home/jwsmith/HDD/Gaudi)
----------> tags
armv7l-fc21-gcc49-opt (from CMTCONFIG) package [LCG_Platforms] implies [target-armv7l target-fc21 target-gcc49 target-opt]
CMTv1 (from CMTVERSION)
CMTr26 (from CMTVERSION)
CMTp20140131 (from CMTVERSION)
Linux (from uname) package [CMT LCG_Platforms] implies [Unix host-linux]
GAUDI_no_config (from PROJECT) excludes [GAUDI_config]
GAUDI_root (from PROJECT) excludes [GAUDI_no_root]
GAUDI_cleanup (from PROJECT) excludes [GAUDI_no_cleanup]
GAUDI_scripts (from PROJECT) excludes [GAUDI_no_scripts]
GAUDI_prototypes (from PROJECT) excludes [GAUDI_no_prototypes]
GAUDI_with_installarea (from PROJECT) excludes [GAUDI_without_installarea]
GAUDI_without_version_directory (from PROJECT) excludes [GAUDI_with_version_directory]
LCGCMT_no_config (from PROJECT) excludes [LCGCMT_config]
LCGCMT_no_root (from PROJECT) excludes [LCGCMT_root]
LCGCMT_cleanup (from PROJECT) excludes [LCGCMT_no_cleanup]
LCGCMT_scripts (from PROJECT) excludes [LCGCMT_no_scripts]
LCGCMT_prototypes (from PROJECT) excludes [LCGCMT_no_prototypes]
LCGCMT_without_installarea (from PROJECT) excludes [LCGCMT_with_installarea]
LCGCMT_without_version_directory (from PROJECT) excludes [LCGCMT_with_version_directory]
GAUDI (from PROJECT)
armv7l (from package CMT) applied [CMT]
fedora21 (from package CMT) applied [CMT]
gcc492 (from package CMT) package [LCG_Platforms] implies [host-gcc49] applied [CMT]
Unix (from package CMT) package [LCG_Platforms] implies [host-unix] excludes [WIN32 Win32]
c_native_dependencies (from package CMT) activated GaudiPolicy
cpp_native_dependencies (from package CMT) activated GaudiPolicy
skip_genconfuser (from package GaudiKernel) applied [GaudiKernel]
experimental (from package LCG_Settings) activated LCG_Platforms
target-unix (from package LCG_Settings) activated LCG_Platforms
target-gcc49 (from package LCG_Settings) package [LCG_Platforms] implies [target-gcc4 target-lcg-compiler lcg-compiler target-c11 experimental] activated LCG_Platforms
target-gcc (from package LCG_Settings) activated LCG_Platforms
target-gcc4 (from package LCG_Settings) package [LCG_Platforms] implies [target-gcc] activated LCG_Platforms
target-lcg-compiler (from package LCG_Settings) activated LCG_Platforms
host-gcc49 (from package LCG_Platforms) package [LCG_Platforms] implies [host-gcc49]
host-linux (from package LCG_Platforms) package [LCG_Platforms] implies [host-unix]
host-unix (from package LCG_Platforms)
target-opt (from package LCG_Platforms)
target-armv7l (from package LCG_Platforms)
target-fc21 (from package LCG_Platforms) package [LCG_Platforms] implies [target-linux]
target-linux (from package LCG_Platforms) package [LCG_Platforms] implies [target-unix]
lcg-compiler (from package LCG_Platforms)
target-c11 (from package LCG_Platforms)
ROOT_GE_5_15 (from package LCG_Configuration) applied [LCG_Configuration]
ROOT_GE_5_19 (from package LCG_Configuration) applied [LCG_Configuration]
HAVE_GAUDI_PLUGINSVC (from package GaudiPluginService) applied [GaudiPluginService]
----------> CMTPATH
# Add path /home/jwsmith/HDD/Gaudi from initialization
# Add path /home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71 from ProjectPath
