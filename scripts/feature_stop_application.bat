rem =================================================================
:FEATURE_STOP_APP
cls
echo STOP APPLICATION

echo.
echo Please specify the package name of the application to stop.
echo Example: ninja.lbs.sample
set STOP_APP_PATH=
set /p STOP_APP_PATH="Package name: "

if not defined STOP_APP_PATH (
    echo Invalid package name.
    pause
    exit /b
)

echo Stopping application...
%ADB_SHELL% am force-stop %STOP_APP_PATH%

echo.
echo The stop application process is completed.
echo.
pause
exit /b