@echo off

rem Go to the qmtest directory
%~d0
pushd %~p0

rem Workaround for problems with CMTINSTALLAREA
rem set CMTINSTALLAREA=..\..\..

rem Go to the cmt directory and setup cmt
cd ..\cmt
call CMT_env.bat
call setup.bat

rem Echo QMTEST_CLASS_PATH
echo Using QMTEST_CLASS_PATH='%QMTEST_CLASS_PATH%'

rem Set a few additional environment variables
rem set SEAL_CONFIGURATION_FILE=%LOCALRT%\src\RelationalCool\tests\seal.opts.error
rem set CORAL_AUTH_PATH=%AFSHOME%\private
rem set CORAL_DBLOOKUP_PATH=%LOCALRT%\src\RelationalCool\tests

rem Go back to the qmtest directory
cd ..\qmtest

rem Define the qmtest results file
set theQmr=%CMTCONFIG%.qmr

rem Print out some examples
echo *** EXAMPLES ***********************************************************"
echo qmtest run cool
echo qmtest run relationalcool.oracle.raldatabasesvc
echo qmtest run pycoolutilities.sqlite.evolution_130
rem echo qmtest run -o pycoolutilities.frontier
echo qmtest run pycool.import_root
echo qmtest run pycool.import_pycool
