@echo off
rem =================================================================
:FEATURE_REBOOT_DEVICE-REBOOT_EMULATOR
cls
echo REBOOT DEVICE - REBOOT EMULATOR
echo You can close this window after you have finished throwing the broadcast.
%ADB_SHELL% am broadcast -a android.intent.action.BOOT_COMPLETED
echo.
pause
exit /b