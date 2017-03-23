rem =================================================================
:FEATURE_UNINSTALL_APK
cls
echo UNINSTALL APK

echo.
echo # Please specify the package name to be uninstall.
echo #   Example: ninja.lbs.sample
echo # Uninstalls the application while retaining the data/cache.
echo #   Example: -k ninja.lbs.sample
echo #--------------
set UNINSTALL_APK_PATH=
set /p UNINSTALL_APK_PATH="# Package name: "

if not defined UNINSTALL_APK_PATH (
    echo Invalid package name.
    pause
    exit /b
)

echo Uninstalling...
%ADB_TARGET% uninstall %UNINSTALL_APK_PATH%

echo.
echo The uninstallation process is completed.
echo.
pause
exit /b