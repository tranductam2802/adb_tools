rem =================================================================
:FEATURE_VIEW_DEVICE_INFO
cls
echo .:DEVICE INFORMATION:.

rem Retrieve unique value for new temporary file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set TEMP_FILE_PATH_NAME=%TEMP%\%~n0_view-device-info_%YYYYMMDDHHMMSS%.txt

rem Create a folder to store device info reports
set OUTPUT_FILE_PATH_NAME=%OUTPUT_BASE_PATH%device_info.log
if not exist %OUTPUT_BASE_PATH% (
    md %OUTPUT_BASE_PATH%
)
echo .:DEVICE INFORMATION:.>"%OUTPUT_FILE_PATH_NAME%"
echo.>>"%OUTPUT_FILE_PATH_NAME%"
echo.
echo # Basic information:>>"%OUTPUT_FILE_PATH_NAME%"
echo # Basic information:
echo #===================>>"%OUTPUT_FILE_PATH_NAME%"
echo #===================
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.product.manufacturer`) do @set MANUFACTURER_NAME=%%i
echo Manufacturing company : [%MANUFACTURER_NAME%]>>"%OUTPUT_FILE_PATH_NAME%"
echo Manufacturing company : [%MANUFACTURER_NAME%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.product.brand`) do @set PRODUCT_BRAND=%%i
echo         Product brand : [%PRODUCT_BRAND%]>>"%OUTPUT_FILE_PATH_NAME%"
echo         Product brand : [%PRODUCT_BRAND%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.product.model`) do @set DEVICE_MODEL=%%i
echo          Device model : [%DEVICE_MODEL%]>>"%OUTPUT_FILE_PATH_NAME%"
echo          Device model : [%DEVICE_MODEL%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.product.name`) do @set DEVICE_NAME=%%i
echo           Device name : [%DEVICE_NAME%]>>"%OUTPUT_FILE_PATH_NAME%"
echo           Device name : [%DEVICE_NAME%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.build.version.release`) do @set DEVICE_ANDROID_OS_VERSION=%%i
echo            OS Version : [%DEVICE_ANDROID_OS_VERSION%]>>"%OUTPUT_FILE_PATH_NAME%"
echo            OS Version : [%DEVICE_ANDROID_OS_VERSION%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.build.version.sdk`) do @set API_LEVEL=%%i
echo             API level : [%API_LEVEL%]>>"%OUTPUT_FILE_PATH_NAME%"
echo             API level : [%API_LEVEL%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.build.id`) do @set DEVICE_BUILD_NUMBER=%%i
echo          Build number : [%DEVICE_BUILD_NUMBER%]>>"%OUTPUT_FILE_PATH_NAME%"
echo          Build number : [%DEVICE_BUILD_NUMBER%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.boot.serialno`) do @set SERIAL_NO=%%i
echo         Serial number : [%SERIAL_NO%]>>"%OUTPUT_FILE_PATH_NAME%"
echo         Serial number : [%SERIAL_NO%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.product.cpu.abilist`) do @set CPU_ABI_LIST=%%i
echo          CPU ABI list : [%CPU_ABI_LIST%]>>"%OUTPUT_FILE_PATH_NAME%"
echo          CPU ABI list : [%CPU_ABI_LIST%]
for /f "usebackq tokens=*" %%i in (`%ADB_SHELL% wm size`) do @set DISPLAY_SIZE=%%i
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.sf.lcd_density`) do @set DISPLAY_DENSITY=%%i
echo          Display size : [%DISPLAY_SIZE%]>>"%OUTPUT_FILE_PATH_NAME%"
echo          Display size : [%DISPLAY_SIZE%]
echo       Display density : [%DISPLAY_DENSITY%dpi]>>"%OUTPUT_FILE_PATH_NAME%"
echo       Display density : [%DISPLAY_DENSITY%dpi]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.product.locale`) do @set PRODUCT_LOCATE=%%i
echo        Default locate : [%PRODUCT_LOCATE%]>>"%OUTPUT_FILE_PATH_NAME%"
echo        Default locate : [%PRODUCT_LOCATE%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% persist.sys.locale`) do @set CURRENT_LOCATE=%%i
echo        Current locate : [%CURRENT_LOCATE%]>>"%OUTPUT_FILE_PATH_NAME%"
echo        Current locate : [%CURRENT_LOCATE%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% persist.sys.timezone`) do @set TIMEZONE=%%i
echo              Timezone : [%TIMEZONE%]>>"%OUTPUT_FILE_PATH_NAME%"
echo              Timezone : [%TIMEZONE%]
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% gsm.sim.operator.alpha`) do @set SIM_OPERATOR_NAME=%%i
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% gsm.sim.operator.iso-country`) do @set SIM_OPERATOR_COUNTRY=%%i
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% gsm.network.type`) do @set SIM_OPERATOR_GSM_TYPE=%%i
echo       Sim information : [%SIM_OPERATOR_NAME%/%SIM_OPERATOR_COUNTRY%/%SIM_OPERATOR_GSM_TYPE%]>>"%OUTPUT_FILE_PATH_NAME%"
echo       Sim information : [%SIM_OPERATOR_NAME%/%SIM_OPERATOR_COUNTRY%/%SIM_OPERATOR_GSM_TYPE%]

rem Write CPU information to a temporary file
%ADB_SHELL% cat /proc/cpuinfo>"%TEMP_FILE_PATH_NAME%"
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (`call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Hardware"`) do @set SEARCH_RESULT=%%i
set CPU_HARDWARE=%SEARCH_RESULT%
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (`call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Processor"`) do @set SEARCH_RESULT=%%i
set CPU_PROCESSOR=%SEARCH_RESULT%
echo              %CPU_HARDWARE%>>"%OUTPUT_FILE_PATH_NAME%"
echo              %CPU_HARDWARE%
echo             %CPU_PROCESSOR%>>"%OUTPUT_FILE_PATH_NAME%"
echo             %CPU_PROCESSOR%

rem Write memory information to a temporary file
%ADB_SHELL% dumpsys meminfo>"%TEMP_FILE_PATH_NAME%"
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (
    `call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Free RAM"`
) do @set SEARCH_RESULT=%%i
echo               %SEARCH_RESULT%>>"%OUTPUT_FILE_PATH_NAME%"
echo               %SEARCH_RESULT%
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (
    `call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Used RAM"`
) do @set SEARCH_RESULT=%%i
echo               %SEARCH_RESULT%>>"%OUTPUT_FILE_PATH_NAME%"
echo               %SEARCH_RESULT%
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (
    `call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Total RAM"`
) do @set SEARCH_RESULT=%%i
echo              %SEARCH_RESULT%>>"%OUTPUT_FILE_PATH_NAME%"
echo              %SEARCH_RESULT%

rem Write disk status information to a temporary file
%ADB_SHELL% dumpsys diskstats>"%TEMP_FILE_PATH_NAME%"
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (
    `call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Data-Free"`
) do @set SEARCH_RESULT=%%i
echo              %SEARCH_RESULT%>>"%OUTPUT_FILE_PATH_NAME%"
echo              %SEARCH_RESULT%
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (
    `call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "Cache-Free"`
) do @set SEARCH_RESULT=%%i
echo             %SEARCH_RESULT%>>"%OUTPUT_FILE_PATH_NAME%"
echo             %SEARCH_RESULT%
set SEARCH_RESULT=
for /f "usebackq tokens=*" %%i IN (
    `call cscript //nologo "%SCRIPT_SEARCH_STRING_FROM_FILE%" "%TEMP_FILE_PATH_NAME%" "System-Free"`
) do @set SEARCH_RESULT=%%i
echo            %SEARCH_RESULT%>>"%OUTPUT_FILE_PATH_NAME%"
echo            %SEARCH_RESULT%

echo.>>"%OUTPUT_FILE_PATH_NAME%"
echo.
echo # Battery information:>>"%OUTPUT_FILE_PATH_NAME%"
echo # Battery information:
echo #=====================>>"%OUTPUT_FILE_PATH_NAME%"
echo #=====================
%ADB_SHELL% dumpsys battery>"%TEMP_FILE_PATH_NAME%"
type "%TEMP_FILE_PATH_NAME%"

echo.>>"%OUTPUT_FILE_PATH_NAME%"
echo.
echo # Data information:>>"%OUTPUT_FILE_PATH_NAME%"
echo # Data information:
echo #==================>>"%OUTPUT_FILE_PATH_NAME%"
echo #==================
%ADB_SHELL% df /data>>"%OUTPUT_FILE_PATH_NAME%"
%ADB_SHELL% df /data
call :DELETE_FILE "%TEMP_FILE_PATH_NAME%"

echo.
pause
exit /b










rem =================================================================
rem %1 : File to delete
:DELETE_FILE

rem Recheck with loops to be sure to delete
:DELETE_FILE_LOOP
if exist "%~1" (
    del /f /q "%~1"
    call %SCRIPT_SLEEP% 100
    goto DELETE_FILE_LOOP
)
exit /b