rem =================================================================
:FEATURE_PULL_FILE
cls
echo PULL FILE

echo.
echo Please specify the file to be copied locally.
echo Example: /system/app/Calc.apk
echo Example: /sdcard/Pictures/*.png
set PULL_FILE_PATH=
set /p PULL_FILE_PATH="File location: "

if not defined PULL_FILE_PATH (
    echo Invalid file location.
    pause
    exit /b
)

rem Create a folder to store files
if not exist %PULL_FILE_BASE_PATH% (
    md %PULL_FILE_BASE_PATH%
)

echo Collecting file...
%ADB_SHELL% mkdir -p %REMOTE_PULL_FILE_BASE_PATH%
%ADB_SHELL% "cp `find %PULL_FILE_PATH%` %REMOTE_PULL_FILE_BASE_PATH%"
echo Pulling file...
%ADB_SHELL% "find %PULL_FILE_PATH%"
%ADB_PULL% %REMOTE_PULL_FILE_BASE_PATH% %HOME_BASE_PATH%
%ADB_SHELL% rm -rf %REMOTE_PULL_FILE_BASE_PATH%

echo.
echo The copied file was saved to [%PULL_FILE_BASE_PATH%].
echo.
pause
exit /b