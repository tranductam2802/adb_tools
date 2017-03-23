rem =================================================================
:FEATURE_GET_SCREENSHOT
cls
echo GET SCREENSHOOT

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set SCREENSHOT_FILE_NAME=%YYYYMMDDHHMMSS%.png

set REMOTE_SCREENSHOT_PATH_NAME=/sdcard/%SCREENSHOT_FILE_NAME%
set LOCAL_SCREENSHOT_PATH_NAME=%SCREEN_SHOOT_BASE_PATH%%SCREENSHOT_FILE_NAME%

echo Taking screenshot...
%ADB_SHELL% "screencap -p %REMOTE_SCREENSHOT_PATH_NAME%"

rem Create a folder to store screenshots
if not exist %SCREEN_SHOOT_BASE_PATH% (
    md %SCREEN_SHOOT_BASE_PATH%
)

echo Saving screenshot...
%ADB_PULL% %REMOTE_SCREENSHOT_PATH_NAME% %SCREEN_SHOOT_BASE_PATH%
%ADB_REMOVE% %REMOTE_SCREENSHOT_PATH_NAME%

echo.
echo New screen shot [%SCREENSHOT_FILE_NAME%] has been output at [%SCREEN_SHOOT_BASE_PATH%].
echo.
pause
exit /b