rem =================================================================
:FEATURE_CLEAR_APP
cls
echo CLEAR APPLICATION DATA

echo.
echo Please specify the package name of the application to clear.
echo Example: ninja.lbs.sample
set CLEAR_APP_PATH=
set /p CLEAR_APP_PATH="Package name: "

if not defined CLEAR_APP_PATH (
    echo Invalid package name.
    pause
    exit /b
)

echo Clearing application data...
%ADB_SHELL% pm clear %CLEAR_APP_PATH%

echo.
echo The clear application data process is completed.
echo.
pause
exit /b