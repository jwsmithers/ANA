@echo off

rem ping -n 3600 localhost 
 
rem Go to the qmtest directory
%~d0
pushd %~p0

rem Workaround for problems with CMTINSTALLAREA
rem set CMTINSTALLAREA=..\..\..

rem Go to the cmt directory and setup cmt
cd ..\cmt
rem echo Set up the CMT runtime environment
call CMT_env.bat
rem echo Set up the COOL runtime environment
call setup.bat

rem Echo QMTEST_CLASS_PATH
echo Using QMTEST_CLASS_PATH='%QMTEST_CLASS_PATH%'

rem Set a few additional environment variables
rem set SEAL_CONFIGURATION_FILE=%LOCALRT%\src\RelationalCool\tests\seal.opts.error
rem set CORAL_AUTH_PATH=%AFSHOME%\private
rem set CORAL_DBLOOKUP_PATH=%LOCALRT%\src\RelationalCool\tests

rem Define the qmtest results file
rem set theQmr=..\..\logs\qmtest\%CMTCONFIG%.qmr
set theQmr=%~d0%~p0..\..\logs\qmtest\%CMTCONFIG%.qmr

rem Ignore QMTEST timeouts for COOL
set COOL_IGNORE_TIMEOUT=yes

rem Go to the qmtest directory and run the tests
echo Launch tests - results will be in '%theQmr%'

cd ..\qmtest
qmtest run -o %theQmr% cool
rem qmtest run -o %theQmr% --rerun win32_vc71_dbg.xml
rem qmtest run -o %theQmr% coolkernel.record
rem qmtest run -o %theQmr% no_db
rem qmtest run -o %theQmr% sqlite
rem qmtest run -o %theQmr% relationalcool.oracle.raldatabasesvc
rem qmtest run -o %theQmr% relationalcool.oracle.raldatabase
rem qmtest run -o %theQmr% relationalcool.mysql.raldatabasesvc
rem qmtest run -o %theQmr% relationalcool.mysql.raldatabase
rem qmtest run -o %theQmr% relationalcool.sqlite.raldatabasesvc
rem qmtest run -o %theQmr% relationalcool.sqlite.raldatabase
rem qmtest run -o %theQmr% pycool.import_pycool
rem qmtest run -o %theQmr% pycoolutilities.sqlite.evolution_130

rem Do not attempt to 'qmtest report/summarize' as it would not be executed?

rem Go back to the original directory
popd
