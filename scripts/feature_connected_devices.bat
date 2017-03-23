rem =================================================================
:FEATURE_GET_ATTACHED_DEVICE_INFO
cls
echo GET ATTACHED DEVICEs INFO
echo.
%ADB_TARGET% devices
pause
exit /b