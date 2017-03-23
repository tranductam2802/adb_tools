rem =================================================================
:FEATURE_SHELL_REMOUNT
cls
echo REMOUNT DEVICE
echo.
%ADB_SHELL% mount -o remount rw /
echo The remount process is completed.
pause
exit /b