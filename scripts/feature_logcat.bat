rem =================================================================
:FEATURE_GET_LOGCAT
cls
echo GET LOGCAT

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set LOGCAT_NAME_TIME=%YYYYMMDDHHMMSS%-time.logcat
set LOGCAT_NAME_LONG=%YYYYMMDDHHMMSS%-long.logcat
set LOGCAT_NAME_FULL=%YYYYMMDDHHMMSS%-full.logcat

set LOGCAT_PATH_NAME_TIME=%LOGCAT_BASE_PATH%%LOGCAT_NAME_TIME%
set LOGCAT_PATH_NAME_LONG=%LOGCAT_BASE_PATH%%LOGCAT_NAME_LONG%
set LOGCAT_PATH_NAME_FULL=%LOGCAT_BASE_PATH%%LOGCAT_NAME_FULL%

rem Create a folder to store logcat's logs
if not exist %LOGCAT_BASE_PATH% (
    md %LOGCAT_BASE_PATH%
)

echo.
echo Getting...

call %SCRIPT_CALL_NEW_WINDOWS% %SCRIPT_GET_LOGCAT% < %SCRIPT_BASE_PATH%no.answer

rem Remove multiple newlines
if exist "%SCRIPT_DELETE_OVERLAP_CRLF%" (
    if exist "%LOGCAT_PATH_NAME_TIME%" (
        call %SCRIPT_DELETE_OVERLAP_CRLF% "%LOGCAT_PATH_NAME_TIME%"
    )
    if exist "%LOGCAT_PATH_NAME_LONG%" (
        call %SCRIPT_DELETE_OVERLAP_CRLF% "%LOGCAT_PATH_NAME_LONG%"
    )
    if exist "%LOGCAT_PATH_NAME_FULL%" (
        call %SCRIPT_DELETE_OVERLAP_CRLF% "%LOGCAT_PATH_NAME_FULL%"
    )
) else (
    echo Could not find "%SCRIPT_DELETE_OVERLAP_CRLF%" script.
)

echo.
if exist "%LOGCAT_PATH_NAME_TIME%" (
    if exist "%LOGCAT_PATH_NAME_LONG%" (
        if exist "%LOGCAT_PATH_NAME_FULL%" (
            echo Logcat in [%LOGCAT_NAME_TIME%], [%LOGCAT_NAME_LONG%] and [%LOGCAT_NAME_FULL%] of [%LOGCAT_BASE_PATH%] has been output.
        ) else (
            echo Logcat in [%LOGCAT_NAME_TIME%] and [%LOGCAT_NAME_LONG%] of [%LOGCAT_BASE_PATH%] has been output.
        )
    ) else (
        echo Logcat in [%LOGCAT_NAME_TIME%] of [%LOGCAT_BASE_PATH%] has been output.
    )
)
echo.
pause
exit /b