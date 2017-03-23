@echo off
rem =================================================================
rem %1 : File name to call and wait
call %1 < %SCRIPT_BASE_PATH%no.answer
exit /b