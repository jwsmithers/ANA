----------> uses
# use CoralKernel v*  (no_version_directory)
#   use CoralBase v*  (no_version_directory)
#     use LCG_Policy v*  (no_version_directory)
#       use LCG_Settings *  (no_version_directory)
#     use Boost v* LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#       use LCG_Configuration v*  (no_version_directory)
#         use LCG_Platforms *  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#       use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
# use RelationalAccess v*  (no_version_directory)
#   use CoralBase v*  (no_version_directory)
# use CppUnit v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.12.1_p1)
#   use LCG_Configuration v*  (no_version_directory)
#   use LCG_Settings v*  (no_version_directory)
#
# Selection :
use CMT v1r26p20140131 (/home/jwsmith/HDD/lcgcmake-install-gcc49/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt)
use LCG_Platforms v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use LCG_Configuration v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use LCG_Settings v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use CppUnit v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use Python v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71) (no_auto_imports)
use Boost v1 LCG_Interfaces (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use LCG_Policy v1  (/home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71)
use CoralBase CoralBase-1-9-0  (/home/jwsmith/HDD/CORAL/CORAL-2-4-2)
use RelationalAccess RelationalAccess-1-8-1  (/home/jwsmith/HDD/CORAL/CORAL-2-4-2)
use CoralKernel CoralKernel-0-0-5  (/home/jwsmith/HDD/CORAL/CORAL-2-4-2)
----------> tags
armv7l-fc21-gcc49-opt (from CMTCONFIG) package [LCG_Platforms] implies [target-armv7l target-fc21 target-gcc49 target-opt]
CMTv1 (from CMTVERSION)
CMTr26 (from CMTVERSION)
CMTp20140131 (from CMTVERSION)
Linux (from uname) package [CMT LCG_Platforms] implies [Unix host-linux]
STANDALONE (from CMTSITE)
CORAL_no_config (from PROJECT) excludes [CORAL_config]
CORAL_no_root (from PROJECT) excludes [CORAL_root]
CORAL_cleanup (from PROJECT) excludes [CORAL_no_cleanup]
CORAL_scripts (from PROJECT) excludes [CORAL_no_scripts]
CORAL_prototypes (from PROJECT) excludes [CORAL_no_prototypes]
CORAL_with_installarea (from PROJECT) excludes [CORAL_without_installarea]
CORAL_without_version_directory (from PROJECT) excludes [CORAL_with_version_directory]
LCGCMT_no_config (from PROJECT) excludes [LCGCMT_config]
LCGCMT_no_root (from PROJECT) excludes [LCGCMT_root]
LCGCMT_cleanup (from PROJECT) excludes [LCGCMT_no_cleanup]
LCGCMT_scripts (from PROJECT) excludes [LCGCMT_no_scripts]
LCGCMT_prototypes (from PROJECT) excludes [LCGCMT_no_prototypes]
LCGCMT_without_installarea (from PROJECT) excludes [LCGCMT_with_installarea]
LCGCMT_without_version_directory (from PROJECT) excludes [LCGCMT_with_version_directory]
CORAL (from PROJECT)
jwsmith_no_config (from PROJECT) excludes [jwsmith_config]
jwsmith_no_root (from PROJECT) excludes [jwsmith_root]
jwsmith_cleanup (from PROJECT) excludes [jwsmith_no_cleanup]
jwsmith_scripts (from PROJECT) excludes [jwsmith_no_scripts]
jwsmith_prototypes (from PROJECT) excludes [jwsmith_no_prototypes]
jwsmith_with_installarea (from PROJECT) excludes [jwsmith_without_installarea]
jwsmith_without_version_directory (from PROJECT) excludes [jwsmith_with_version_directory]
jwsmith (from PROJECT)
lcgcmake-install-gcc49_no_config (from PROJECT) excludes [lcgcmake-install-gcc49_config]
lcgcmake-install-gcc49_no_root (from PROJECT) excludes [lcgcmake-install-gcc49_root]
lcgcmake-install-gcc49_cleanup (from PROJECT) excludes [lcgcmake-install-gcc49_no_cleanup]
lcgcmake-install-gcc49_scripts (from PROJECT) excludes [lcgcmake-install-gcc49_no_scripts]
lcgcmake-install-gcc49_prototypes (from PROJECT) excludes [lcgcmake-install-gcc49_no_prototypes]
lcgcmake-install-gcc49_without_installarea (from PROJECT) excludes [lcgcmake-install-gcc49_with_installarea]
lcgcmake-install-gcc49_without_version_directory (from PROJECT) excludes [lcgcmake-install-gcc49_with_version_directory]
armv7l (from package CMT) applied [CMT]
fedora21 (from package CMT) applied [CMT]
gcc492 (from package CMT) package [LCG_Platforms] implies [host-gcc49] applied [CMT]
Unix (from package CMT) package [LCG_Platforms] implies [host-unix] excludes [WIN32 Win32]
experimental (from package LCG_Settings) activated LCG_Platforms
target-unix (from package LCG_Settings) activated LCG_Platforms
target-gcc49 (from package LCG_Settings) package [LCG_Platforms] implies [target-gcc4 target-lcg-compiler lcg-compiler target-c11 experimental] activated LCG_Platforms
target-gcc (from package LCG_Settings) activated LCG_Platforms
target-gcc4 (from package LCG_Settings) package [LCG_Platforms] implies [target-gcc] activated LCG_Platforms
target-lcg-compiler (from package LCG_Settings) activated LCG_Platforms
target-opt (from package LCG_Policy) activated LCG_Platforms
target-c11 (from package LCG_Policy) excludes [RELAX] activated LCG_Platforms
target-linux (from package LCG_Policy) package [LCG_Platforms] implies [target-unix] activated LCG_Platforms
host-gcc49 (from package LCG_Platforms) package [LCG_Platforms] implies [host-gcc49]
host-linux (from package LCG_Platforms) package [LCG_Platforms] implies [host-unix]
host-unix (from package LCG_Platforms)
target-armv7l (from package LCG_Platforms)
target-fc21 (from package LCG_Platforms) package [LCG_Platforms] implies [target-linux]
lcg-compiler (from package LCG_Platforms)
ROOT_GE_5_15 (from package LCG_Configuration) applied [LCG_Configuration]
ROOT_GE_5_19 (from package LCG_Configuration) applied [LCG_Configuration]
----------> CMTPATH
# Add path /home/jwsmith/HDD from initialization
# Add path /home/jwsmith/HDD/CORAL/CORAL-2-4-2 from initialization
# Add path /home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT from initialization
# Add path /home/jwsmith/HDD/lcgcmake-install-gcc49/LCGCMT/LCGCMT_71 from ProjectPath
