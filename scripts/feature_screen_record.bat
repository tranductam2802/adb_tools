rem =================================================================
:FEATURE_GET_MOVIE
cls
echo GET SCREEN RECORD

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set SCREEN_RECORD_FILE_NAME=%YYYYMMDDHHMMSS%.mp4

set REMOTE_SCREEN_RECORD_PATH_NAME=/sdcard/%SCREEN_RECORD_FILE_NAME%
set SCREEN_RECORD_PATH_NAME=%SCREEN_RECORD_BASE_PATH%%SCREEN_RECORD_FILE_NAME%

echo.
echo Recording...
call %SCRIPT_CALL_NEW_WINDOWS% %SCRIPT_RECORD_SCREEN% < %SCRIPT_BASE_PATH%no.answer

rem Create a folder to store screen records
if not exist %SCREEN_RECORD_BASE_PATH% (
    md %SCREEN_RECORD_BASE_PATH%
)

echo Saving screen record...
%ADB_PULL% %REMOTE_SCREEN_RECORD_PATH_NAME% %SCREEN_RECORD_PATH_NAME%
%ADB_REMOVE% %REMOTE_SCREEN_RECORD_PATH_NAME%

echo.
echo New screen record [%SCREEN_RECORD_FILE_NAME%] has been output at [%SCREEN_RECORD_BASE_PATH%].
echo.
pause
exit /b