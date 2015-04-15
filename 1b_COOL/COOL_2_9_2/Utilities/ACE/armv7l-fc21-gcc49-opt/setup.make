----------> uses
# use CoolApplication v*  (no_version_directory)
#   use CoolKernel v*  (no_version_directory)
#     use LCG_Policy v*  (no_version_directory)
#       use LCG_Settings *  (no_version_directory)
#     use Boost v* LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#       use LCG_Configuration v*  (no_version_directory)
#         use LCG_Platforms *  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#       use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#     use CORAL v* LCG_Interfaces (no_version_directory) (native_version=)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#       use Boost v* LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#   use RelationalCool v*  (no_version_directory)
#     use CoolKernel v*  (no_version_directory)
# use Qt v* LCG_Interfaces (no_version_directory) (native_version=4.8.4)
#   use LCG_Configuration v*  (no_version_directory)
#   use LCG_Settings v*  (no_version_directory)
#
# Selection :
use CMT v1r26p20140131 (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/cmt/v1r26p20140131/armv7l-fc21-gcc49-opt)
use LCG_Platforms v1  (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use LCG_Configuration v1  (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use LCG_Settings v1  (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use Qt v* LCG_Interfaces (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use Python v1 LCG_Interfaces (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71) (no_auto_imports)
use Boost v1 LCG_Interfaces (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use CORAL v1 LCG_Interfaces (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use LCG_Policy v1  (/home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71)
use CoolKernel v1  (/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2)
use RelationalCool v1  (/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2)
use CoolApplication v1  (/home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2)
----------> tags
armv7l-fc21-gcc49-opt (from CMTCONFIG) package [LCG_Platforms] implies [target-armv7l target-fc21 target-gcc49 target-opt]
CMTv1 (from CMTVERSION)
CMTr26 (from CMTVERSION)
CMTp20140131 (from CMTVERSION)
Linux (from uname) package [CMT LCG_Platforms] implies [Unix host-linux]
STANDALONE (from CMTSITE)
COOL_no_config (from PROJECT) excludes [COOL_config]
COOL_no_root (from PROJECT) excludes [COOL_root]
COOL_cleanup (from PROJECT) excludes [COOL_no_cleanup]
COOL_scripts (from PROJECT) excludes [COOL_no_scripts]
COOL_prototypes (from PROJECT) excludes [COOL_no_prototypes]
COOL_with_installarea (from PROJECT) excludes [COOL_without_installarea]
COOL_without_version_directory (from PROJECT) excludes [COOL_with_version_directory]
LCGCMT_no_config (from PROJECT) excludes [LCGCMT_config]
LCGCMT_no_root (from PROJECT) excludes [LCGCMT_root]
LCGCMT_cleanup (from PROJECT) excludes [LCGCMT_no_cleanup]
LCGCMT_scripts (from PROJECT) excludes [LCGCMT_no_scripts]
LCGCMT_prototypes (from PROJECT) excludes [LCGCMT_no_prototypes]
LCGCMT_without_installarea (from PROJECT) excludes [LCGCMT_with_installarea]
LCGCMT_without_version_directory (from PROJECT) excludes [LCGCMT_with_version_directory]
COOL (from PROJECT)
ANA_no_config (from PROJECT) excludes [ANA_config]
ANA_no_root (from PROJECT) excludes [ANA_root]
ANA_cleanup (from PROJECT) excludes [ANA_no_cleanup]
ANA_scripts (from PROJECT) excludes [ANA_no_scripts]
ANA_prototypes (from PROJECT) excludes [ANA_no_prototypes]
ANA_with_installarea (from PROJECT) excludes [ANA_without_installarea]
ANA_without_version_directory (from PROJECT) excludes [ANA_with_version_directory]
ANA (from PROJECT)
lcgcmake_install-armv7l-fc21-gcc49-opt-71_no_config (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_config]
lcgcmake_install-armv7l-fc21-gcc49-opt-71_no_root (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_root]
lcgcmake_install-armv7l-fc21-gcc49-opt-71_cleanup (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_no_cleanup]
lcgcmake_install-armv7l-fc21-gcc49-opt-71_scripts (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_no_scripts]
lcgcmake_install-armv7l-fc21-gcc49-opt-71_prototypes (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_no_prototypes]
lcgcmake_install-armv7l-fc21-gcc49-opt-71_without_installarea (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_with_installarea]
lcgcmake_install-armv7l-fc21-gcc49-opt-71_without_version_directory (from PROJECT) excludes [lcgcmake_install-armv7l-fc21-gcc49-opt-71_with_version_directory]
armv7l (from package CMT) applied [CMT]
fedora21 (from package CMT) applied [CMT]
gcc492 (from package CMT) package [LCG_Platforms] implies [host-gcc49] applied [CMT]
Unix (from package CMT) package [LCG_Platforms] implies [host-unix] excludes [WIN32 Win32]
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
experimental (from package LCG_Platforms)
ROOT_GE_5_15 (from package LCG_Configuration) applied [LCG_Configuration]
ROOT_GE_5_19 (from package LCG_Configuration) applied [LCG_Configuration]
----------> CMTPATH
# Add path /home/jwsmith/HDD/ANA/ANA from initialization
# Add path /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2 from initialization
# Add path /home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT from initialization
# Add path /home/jwsmith/HDD/ANA/ANA/1_LCGSoftware/lcgcmake_install-armv7l-fc21-gcc49-opt-71/LCGCMT/LCGCMT_71 from ProjectPath
