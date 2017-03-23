rem =================================================================
:FEATURE_IP
cls
echo IP INFORMATION

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set OUTPUT_FILE_PATH_NAME=%OUTPUT_BASE_PATH%%YYYYMMDDHHMMSS%.ip

rem Create a folder to store device info reports
if not exist %OUTPUT_BASE_PATH% (
    md %OUTPUT_BASE_PATH%
)
echo.
%ADB_SHELL% ip -f inet addr show wlan0>"%OUTPUT_FILE_PATH_NAME%"
type "%OUTPUT_FILE_PATH_NAME%"

echo.
echo The ip information saved in [%OUTPUT_FILE_PATH_NAME%].
pause
exit /b