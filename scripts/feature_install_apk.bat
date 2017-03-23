rem =================================================================
:FEATURE_INSTALL_APK
cls
echo INSTALL APK

echo.
echo # Drag and drop apk file to this windows for installation.
echo #------------------
set INSTALL_APK_PATH=
set /p INSTALL_APK_PATH="# APK location: "

if not defined INSTALL_APK_PATH (
    echo Invalid apk file location.
    pause
    exit /b
)

if not exist %INSTALL_APK_PATH% (
    echo APK file not exist.
    pause
    exit /b
)

echo Installing...
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.build.version.sdk`) do @set ANDROID_API_LEVEL=%%i
rem API level 19 or more (including 19, 20, 21, 22 ...) have to defined -d flag to enable downgrade installation
if "%ANDROID_API_LEVEL%" GEQ "19" (
    %ADB_INSTALL% -r -d %INSTALL_APK_PATH%
) else (
    %ADB_INSTALL% -r %INSTALL_APK_PATH%
)

echo.
echo The installation process is completed.
echo.
pause
exit /b