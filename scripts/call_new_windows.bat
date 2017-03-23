@echo off
rem =================================================================
rem %1 : File name to call and wait
start /wait "" %SCRIPT_WAIT_UNTIL_DONE% %1
exit /b