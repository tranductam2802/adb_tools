rem =================================================================
:FEATURE_START_ACTIVITY
cls
echo START ACTIVITY

echo.
echo Please specify the package name and the activity name to be start.
echo Example: ninja.lbs.sample/ninja.lbs.sample.activity.MainActivity
echo            ↑ Package name                       ↑ Activity class

set START_ACTIVITY_PACKAGE_CLASS=
set /p START_ACTIVITY_PACKAGE_CLASS="Full name: "

if not defined START_ACTIVITY_PACKAGE_CLASS (
    echo Invalid Activity class name.
    pause
    exit /b
)

echo Starting activity...
%ADB_SHELL% am start -a android.intent.action.LAUNCHER -n %START_ACTIVITY_PACKAGE_CLASS%

echo.
echo The start activity process is completed.
echo.
pause
exit /b