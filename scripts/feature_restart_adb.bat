@echo off
rem =================================================================
:FEATURE_RESTART_ADB
cls
echo RESTART ADB
%ADB_KILL_SERVER%&%ADB_START_SERVER%
echo.
pause
exit /b