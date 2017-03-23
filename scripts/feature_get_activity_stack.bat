rem =================================================================
:FEATURE_GET_ACTIVITY_STACK
cls
echo GET ACTIVITY STACK

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set ACTIVITY_STACK_NAME=%YYYYMMDDHHMMSS%.stack
set ACTIVITY_STACK_TOP_NAME=%YYYYMMDDHHMMSS%.stacktop
set ACTIVITY_STACK_PATH_NAME=%STACK_BASE_PATH%\%ACTIVITY_STACK_NAME%
set ACTIVITY_STACK_TOP_PATH_NAME=%STACK_BASE_PATH%\%ACTIVITY_STACK_TOP_NAME%

rem Create a folder to store stack logs
if not exist %STACK_BASE_PATH% (
    md %STACK_BASE_PATH%
)

echo Dumming list activities system data...
%ADB_SHELL% dumpsys activity activities > "%ACTIVITY_STACK_PATH_NAME%"
%ADB_SHELL% dumpsys activity activities
echo.
echo Dumming list top system data...
%ADB_SHELL% dumpsys activity top > "%ACTIVITY_STACK_TOP_PATH_NAME%"
%ADB_SHELL% dumpsys activity top

rem Remove multiple newlines
if exist "%SCRIPT_DELETE_OVERLAP_CRLF%" (
    call %SCRIPT_DELETE_OVERLAP_CRLF% "%ACTIVITY_STACK_PATH_NAME%"
    call %SCRIPT_DELETE_OVERLAP_CRLF% "%ACTIVITY_STACK_TOP_PATH_NAME%"
) else (
    echo Could not find "%SCRIPT_DELETE_OVERLAP_CRLF%" script.
)

echo.
echo #----------------------------------------------------
echo List stack activities was stored at [%ACTIVITY_STACK_NAME%] of [%STACK_BASE_PATH%].
echo List stack top was stored at [%ACTIVITY_STACK_TOP_NAME%] of [%STACK_BASE_PATH%].
echo.
pause
exit /b