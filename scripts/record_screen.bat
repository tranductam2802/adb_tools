@echo off
title Screen recording...
echo SCREEN RECORDING...
echo Please close this window or press "ctrl+C" to finish record.
echo.
%ADB_SHELL% screenrecord --verbose %REMOTE_SCREEN_RECORD_PATH_NAME%
echo.
pause>nul
exit