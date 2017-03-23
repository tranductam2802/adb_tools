rem =================================================================
:FEATURE_DENSITY_DISPLAY
cls
echo CHANGE DISPLAY DENSITY

echo.
echo  Android dpi had defined as follows:
echo # [120]:ldpi (low resolution)       [240]:hdpi (high resolution)           [480]:xxhdpi (super high resolution)
echo # [160]:mdpi (medium resolution)    [360]:xhdpi (super high resolution)    [640]:xxxhdpi (ultra super high resolution)
echo #
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.sf.lcd_density`) do @set DEFAULT_DENSITY=%%i
echo # Reset the resolution if it is not entered.
echo # If the resolution does not return even after resetting, please specify the default value [%DEFAULT_DENSITY%(dpi)].
echo #------------------

set /p DISPLAY_SIZE="# Density (number): "
if not defined DISPLAY_SIZE (
    %ADB_SHELL% wm density reset
    pause
    exit /b
)

rem As a result, when a character string is mixed in the input value, the same value disappears
set /a DISPLAY_SIZE2=%DISPLAY_SIZE%*1

rem Confirm whether input value and input value *1 are the same
if not "%DISPLAY_SIZE%"=="%DISPLAY_SIZE2%" (
    echo The input value is invalid.
    pause
    exit /b
)

%ADB_SHELL% wm density %DISPLAY_SIZE%

echo.
echo The screen resolution had changed.
echo.
pause
exit /b