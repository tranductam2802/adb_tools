title Getting logcat...
echo GETTING LOGCAT...
echo Please press "ctrl+C" to finish showing logcat.
%ADB_TARGET% logcat
echo Please press "ctrl+C" to get time log.
%ADB_TARGET% logcat -v time>"%LOGCAT_PATH_NAME_TIME%"
echo Please press "ctrl+C" to get long log.
%ADB_TARGET% logcat -v long>"%LOGCAT_PATH_NAME_LONG%"
echo Please press "ctrl+C" to get full log.
%ADB_TARGET% logcat -v threadtime -b main -b system -b events>"%LOGCAT_PATH_NAME_FULL%"
echo.
pause
exit