rem =================================================================
:FEATURE_REBOOT_DEVICE
cls
echo REBOOT DEVICE

rem For emulator, create a new batch file for restarting the emulator
if /i "%TARGET_DEVICE%"=="-e" (
    rem Create new bat file if not exist
    if exist "%SCRIPT_REBOOT_DEVICE-REBOOT_EMULATOR%" (
        rem Execute bat file for restarting the emulator
        call %SCRIPT_REBOOT_DEVICE-REBOOT_EMULATOR%
        rem Asynchronously comes through processing by wait a while until bat execution
        call %SCRIPT_SLEEP% 1000
    ) else (
        echo Could not find "%SCRIPT_REBOOT_DEVICE-REBOOT_EMULATOR%" script.
    )
) else (
    rem If not an emulator, throw the reboot command
    %ADB_TARGET% reboot
)

rem Display end process
echo.
echo The restart process is completed.
echo.
pause
exit /b