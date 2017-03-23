@echo off
setlocal


rem =================================================================
:MODE_CONFIGURATION
rem %~n0 is the file name
title %~n0 - %cd%

rem Get adb target configuration
set TARGET_DEVICE=%1
set TARGET_DEVICE_SERIAL=%2

rem Folder path to output the file. %~dp0 is the current batch file's folder
set HOME_BASE_PATH=%~dp0
if %cd%\ == %HOME_BASE_PATH% (
    set DEFAULT_WORKING_SPACE=%userprofile%\downloads\
) else (
    if %cd% == %userprofile% (
        set DEFAULT_WORKING_SPACE=%userprofile%\downloads\
    ) else (
        set DEFAULT_WORKING_SPACE=%cd%\
    )
)

set PULL_FILE_BASE_NAME=pulled_files

set SCRIPT_BASE_PATH=%HOME_BASE_PATH%scripts\
set OUTPUT_BASE_PATH=%DEFAULT_WORKING_SPACE%outputs\
set PACKAGE_LIST_BASE_PATH=%DEFAULT_WORKING_SPACE%packages_list\
set LOGCAT_BASE_PATH=%DEFAULT_WORKING_SPACE%logcats\
set SCREEN_SHOOT_BASE_PATH=%DEFAULT_WORKING_SPACE%screenshots\
set SCREEN_RECORD_BASE_PATH=%DEFAULT_WORKING_SPACE%screenrecords\
set PULL_FILE_BASE_PATH=%DEFAULT_WORKING_SPACE%%PULL_FILE_BASE_NAME%\
set STACK_BASE_PATH=%DEFAULT_WORKING_SPACE%stacks\

set REMOTE_PULL_FILE_BASE_PATH=/sdcard/%PULL_FILE_BASE_NAME%/

set SCRIPT_CHANGE_DENSITY=%SCRIPT_BASE_PATH%feature_change_pro-density.bat
set SCRIPT_CLEAR_APP_DATA=%SCRIPT_BASE_PATH%feature_clear_app_data.bat
set SCRIPT_CONNECTED_DEVICE=%SCRIPT_BASE_PATH%feature_connected_devices.bat
set SCRIPT_DEVICE_INFO=%SCRIPT_BASE_PATH%feature_device_info.bat
set SCRIPT_GET_ACTIVITY_STACK=%SCRIPT_BASE_PATH%feature_get_activity_stack.bat
set SCRIPT_IF_CONFIG=%SCRIPT_BASE_PATH%feature_ifconfig.bat
set SCRIPT_INPUT_TEXT=%SCRIPT_BASE_PATH%feature_input_text.bat
set SCRIPT_INSTALL_APK=%SCRIPT_BASE_PATH%feature_install_apk.bat
set SCRIPT_IP_INFO=%SCRIPT_BASE_PATH%feature_ip.bat
set SCRIPT_LOGCAT=%SCRIPT_BASE_PATH%feature_logcat.bat
set SCRIPT_NETSTAT=%SCRIPT_BASE_PATH%feature_net_stat.bat
set SCRIPT_PULL_FILE=%SCRIPT_BASE_PATH%feature_pull_file.bat
set SCRIPT_REBOOT=%SCRIPT_BASE_PATH%feature_reboot_device.bat
set SCRIPT_REBOOT_DEVICE-REBOOT_EMULATOR=%SCRIPT_BASE_PATH%feature_reboot_device-reboot_emulator.bat
set SCRIPT_REMOUNT=%SCRIPT_BASE_PATH%feature_remount.bat
set SCRIPT_RESTART_ADB=%SCRIPT_BASE_PATH%feature_restart_adb.bat
set SCRIPT_SCREEN_RECORD=%SCRIPT_BASE_PATH%feature_screen_record.bat
set SCRIPT_SCREEN_SHOOT=%SCRIPT_BASE_PATH%feature_screen_shoot.bat
set SCRIPT_START_ACTIVITY=%SCRIPT_BASE_PATH%feature_start_activity.bat
set SCRIPT_STOP_APPLICATION=%SCRIPT_BASE_PATH%feature_stop_application.bat
set SCRIPT_UNINSTALL_APK=%SCRIPT_BASE_PATH%feature_uninstall_apk.bat

set SCRIPT_CALL_NEW_WINDOWS=%SCRIPT_BASE_PATH%call_new_windows.bat
set SCRIPT_DELETE_OVERLAP_CRLF=%SCRIPT_BASE_PATH%delete_overlap_crlf.vbs
set SCRIPT_GET_LOGCAT=%SCRIPT_BASE_PATH%get_logcat.bat
set SCRIPT_RECORD_SCREEN=%SCRIPT_BASE_PATH%record_screen.bat
set SCRIPT_SEARCH_STRING_FROM_FILE=%SCRIPT_BASE_PATH%search_string_from_file.vbs
set SCRIPT_SLEEP=%SCRIPT_BASE_PATH%sleep.vbs
set SCRIPT_WAIT_UNTIL_DONE=%SCRIPT_BASE_PATH%wait_until_done.bat
rem Note: If you change the path, add \ to the end

rem Define default adb command
set ADB_VERSION=%SCRIPT_BASE_PATH%adb.exe version
set ADB_TARGET=%SCRIPT_BASE_PATH%adb.exe %TARGET_DEVICE% %TARGET_DEVICE_SERIAL%
set ADB_KILL_SERVER=%ADB_TARGET% kill-server
set ADB_START_SERVER=%ADB_TARGET% start-server
set ADB_PULL=%ADB_TARGET% pull
set ADB_INSTALL=%ADB_TARGET% install
set ADB_SHELL=%ADB_TARGET% shell
set ADB_GETPROP=%ADB_SHELL% getprop
set ADB_REMOVE=%ADB_SHELL% rm -rf

rem Setting Commands
set COMMAND_GET_ATTACHED_DEVICE_INFO=00
set COMMAND_GET_ATTACHED_DEVICE_INFO_ALIAS=devices
set COMMAND_GET_LOGCAT=01
set COMMAND_GET_LOGCAT_ALIAS=logcat
set COMMAND_VIEW_DEVICE_INFO=02
set COMMAND_VIEW_DEVICE_INFO_ALIAS=info
set COMMAND_GET_ACTIVITY_STACK=03
set COMMAND_GET_ACTIVITY_STACK_ALIAS=stacks
set COMMAND_GET_PACKAGE_LIST=04
set COMMAND_GET_PACKAGE_LIST_ALIAS=package
set COMMAND_GET_PACKAGE_LIST_FULL=05
set COMMAND_GET_PACKAGE_LIST_FULL_ALIAS=packages
set COMMAND_NETSTAT=06
set COMMAND_NETSTAT_ALIAS=netstat
set COMMAND_IP=07
set COMMAND_IP_ALIAS=netstat
set COMMAND_IF_CONFIG=08
set COMMAND_IF_CONFIG_ALIAS=netstat
rem -
set COMMAND_INSTALL_APK=30
set COMMAND_INSTALL_APK_ALIAS=install
set COMMAND_START_ACTIVITY=31
set COMMAND_START_ACTIVITY_ALIAS=start
set COMMAND_CLEAR_APP=31
set COMMAND_CLEAR_APP_ALIAS=clear
set COMMAND_UNINSTALL_APK=33
set COMMAND_UNINSTALL_APK_ALIAS=uninstall
set COMMAND_STOP_APP=34
set COMMAND_STOP_APP_ALIAS=stop
rem -
set COMMAND_PULL_FILE=50
set COMMAND_PULL_FILE_ALIAS=pull
set COMMAND_INPUT_TEXT=51
set COMMAND_INPUT_TEXT_ALIAS=input
set COMMAND_GET_SCREENSHOT=52
set COMMAND_GET_SCREENSHOT_ALIAS=shoot
set COMMAND_GET_MOVIE=53
set COMMAND_GET_MOVIE_ALIAS=record
set COMMAND_CHANGE_DENSITY=54
set COMMAND_CHANGE_DENSITY_ALIAS=density
rem -
set COMMAND_SHELL_REMOUNT=80
set COMMAND_SHELL_REMOUNT_ALIAS=remount
set COMMAND_RESTART_ADB=81
set COMMAND_RESTART_ADB_ALIAS=restart
set COMMAND_REBOOT_DEVICE=82
set COMMAND_REBOOT_DEVICE_ALIAS=reboot
rem -
set COMMAND_OPEN_OUTPUT_DIR=98
set COMMAND_OPEN_OUTPUT_DIR_ALIAS=output
set COMMAND_ADB_DEVICE_SELECT=99
set COMMAND_ADB_DEVICE_SELECT_ALIAS=connect
rem -
set COMMAND_QUIT=exit


rem =================================================================
:MODE_CHECK_ADMINISTRATOR
rem Confirm whether it's started with administrator's privilege (comment out unless used this time)
rem for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
rem if /i not "%LEVEL%"=="high" (
rem     rem If you are not running with administrator privileges run itself as administrator
rem     powershell start-process -verb runas '"%~0"'
rem     exit
rem )

rem Just to be sure, change the working directory to its own position
cd /d "%HOME_BASE_PATH%"


rem =================================================================
:MODE_INPUT_WAIT
cls
echo  .: TAM NINJA STUDIO - ADB TOOLS for ANDROID :.
echo ================================================

rem Confirm that adb settings include of the system variable
%ADB_VERSION%>nul 2>&1
if not %ERRORLEVEL%==0 (
    echo The path does not go to adb.
    echo Install Android SDK and register the path of the Android SDK to path of environment variable.
    echo Please press any key to finish...
    pause > nul
    exit
)

echo.
if "%TARGET_DEVICE%"=="-d" (
    echo The adb target's a real machine...
) else if "%TARGET_DEVICE%"=="-e" (
    echo The adb target's the emulator...
) else if "%TARGET_DEVICE%"=="-s" (
    echo The adb target's [%TARGET_DEVICE_SERIAL%]...
) else if "%TARGET_DEVICE%"=="" (
    echo The adb target's not fixed...
) else (
    echo The adb target's illegal [%TARGET_DEVICE%] [%TARGET_DEVICE_SERIAL%]...
)

echo.
echo Enter the action you want to execute and press enter.
echo #----------------------------------------------------
echo # [%COMMAND_GET_ATTACHED_DEVICE_INFO%]: Get list attached devices                    [%COMMAND_PULL_FILE%]: Pull file to device
echo # [%COMMAND_GET_LOGCAT%]: Get logcat and save to logs                  [%COMMAND_INPUT_TEXT%]: Send text input to device
echo # [%COMMAND_VIEW_DEVICE_INFO%]: Display device information                   [%COMMAND_GET_SCREENSHOT%]: Take screenshot
echo # [%COMMAND_GET_ACTIVITY_STACK%]: Get current activity stack                   [%COMMAND_GET_MOVIE%]: Take screenrecord
echo # [%COMMAND_GET_PACKAGE_LIST%]: Get list installed packages                  [%COMMAND_CHANGE_DENSITY%]: Change device density
echo # [%COMMAND_GET_PACKAGE_LIST_FULL%]: Get list installed packages (full)           [%COMMAND_SHELL_REMOUNT%]: Remount device
echo # [%COMMAND_NETSTAT%]: Get device's netstat                         [%COMMAND_RESTART_ADB%]: Restart adb connection
echo # [%COMMAND_IP%]: Get device's ip information                  [%COMMAND_REBOOT_DEVICE%]: Reboot device
echo # [%COMMAND_IF_CONFIG%]: Get device's ifconfig                        [%COMMAND_OPEN_OUTPUT_DIR%]: Open outputs location
echo # [%COMMAND_INSTALL_APK%]: Install apk file                             [%COMMAND_ADB_DEVICE_SELECT%]: Change adb connection
echo # [%COMMAND_START_ACTIVITY%]: Start activity
echo # [%COMMAND_CLEAR_APP%]: Clear application data and cache
echo # [%COMMAND_UNINSTALL_APK%]: Uninstall apk file
echo # [%COMMAND_STOP_APP%]: Force stop application
echo # [%COMMAND_QUIT%]: Exit this tool
echo #---------

rem Clear previous user input (Abadon user clicked enter only)
set USER_INPUT=
set /p USER_INPUT="# Command: "

rem If user do not enter valid input, return without confirming
If not DEFINED USER_INPUT (
    echo.
    goto MODE_INPUT_WAIT
)

rem First, check if incorrect input has been done. Otheride move to MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_ATTACHED_DEVICE_INFO%"          goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_ATTACHED_DEVICE_INFO_ALIAS%"    goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_LOGCAT%"                        goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_LOGCAT_ALIAS%"                  goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_SCREENSHOT%"                    goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_SCREENSHOT_ALIAS%"              goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_MOVIE%"                         goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_MOVIE_ALIAS%"                   goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_VIEW_DEVICE_INFO%"                  goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_VIEW_DEVICE_INFO_ALIAS%"            goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_ACTIVITY_STACK%"                goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_ACTIVITY_STACK_ALIAS%"          goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST%"                  goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST_ALIAS%"            goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST_FULL%"             goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST_FULL_ALIAS%"       goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_NETSTAT%"                           goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_NETSTAT_ALIAS%"                     goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_IP%"                                goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_IP_ALIAS%"                          goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_IF_CONFIG%"                         goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_IF_CONFIG_ALIAS%"                   goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_INSTALL_APK%"                       goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_INSTALL_APK_ALIAS%"                 goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_START_ACTIVITY%"                    goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_START_ACTIVITY_ALIAS%"              goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_CLEAR_APP%"                         goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_CLEAR_APP_ALIAS%"                   goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_UNINSTALL_APK%"                     goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_UNINSTALL_APK_ALIAS%"               goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_STOP_APP%"                          goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_STOP_APP_ALIAS%"                    goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_PULL_FILE%"                         goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_PULL_FILE_ALIAS%"                   goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_INPUT_TEXT%"                        goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_INPUT_TEXT_ALIAS%"                  goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_CHANGE_DENSITY%"                    goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_CHANGE_DENSITY_ALIAS%"              goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_SHELL_REMOUNT%"                     goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_SHELL_REMOUNT_ALIAS%"               goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_RESTART_ADB%"                       goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_RESTART_ADB_ALIAS%"                 goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_REBOOT_DEVICE%"                     goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_REBOOT_DEVICE_ALIAS%"               goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_OPEN_OUTPUT_DIR%"                   goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_OPEN_OUTPUT_DIR_ALIAS%"             goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_ADB_DEVICE_SELECT%"                 goto MODE_CORRECT_INPUT
If /i "%USER_INPUT%"=="\%COMMAND_ADB_DEVICE_SELECT_ALIAS%"           goto MODE_CORRECT_INPUT
rem Exit script exit command only
If /i %USER_INPUT%==%COMMAND_QUIT% exit
rem Otheride go back command input screen
goto MODE_INPUT_WAIT


rem =================================================================
:MODE_CORRECT_INPUT
rem Commands which can be executed without connected terminal
If /i "%USER_INPUT%"=="\%COMMAND_RESTART_ADB%"                       call %SCRIPT_RESTART_ADB%
If /i "%USER_INPUT%"=="\%COMMAND_RESTART_ADB_ALIAS%"                 call %SCRIPT_RESTART_ADB%
If /i "%USER_INPUT%"=="\%COMMAND_OPEN_OUTPUT_DIR%"                   goto FEATURE_OPEN_OUTPUT_DIR
If /i "%USER_INPUT%"=="\%COMMAND_OPEN_OUTPUT_DIR_ALIAS%"             goto FEATURE_OPEN_OUTPUT_DIR

rem Confirm that the terminal is connected
call :CHECK_DEVICE_CONNECT
If /i not %CONNECT_RESULT%==true (
    echo The terminal can not check the connection.
    echo.
    pause
    goto MODE_INPUT_WAIT
)

rem Command processing that can not be executed with terminal not connected
If /i "%USER_INPUT%"=="\%COMMAND_GET_ATTACHED_DEVICE_INFO%"          call %SCRIPT_CONNECTED_DEVICE%
If /i "%USER_INPUT%"=="\%COMMAND_GET_ATTACHED_DEVICE_INFO_ALIAS%"    call %SCRIPT_CONNECTED_DEVICE%
If /i "%USER_INPUT%"=="\%COMMAND_GET_LOGCAT%"                        call %SCRIPT_LOGCAT%
If /i "%USER_INPUT%"=="\%COMMAND_GET_LOGCAT_ALIAS%"                  call %SCRIPT_LOGCAT%
If /i "%USER_INPUT%"=="\%COMMAND_GET_SCREENSHOT%"                    call %SCRIPT_SCREEN_SHOOT%
If /i "%USER_INPUT%"=="\%COMMAND_GET_SCREENSHOT_ALIAS%"              call %SCRIPT_SCREEN_SHOOT%
If /i "%USER_INPUT%"=="\%COMMAND_GET_MOVIE%"                         call %SCRIPT_SCREEN_RECORD%
If /i "%USER_INPUT%"=="\%COMMAND_GET_MOVIE_ALIAS%"                   call %SCRIPT_SCREEN_RECORD%
If /i "%USER_INPUT%"=="\%COMMAND_VIEW_DEVICE_INFO%"                  call %SCRIPT_DEVICE_INFO%
If /i "%USER_INPUT%"=="\%COMMAND_VIEW_DEVICE_INFO_ALIAS%"            call %SCRIPT_DEVICE_INFO%
If /i "%USER_INPUT%"=="\%COMMAND_GET_ACTIVITY_STACK%"                call %SCRIPT_GET_ACTIVITY_STACK%
If /i "%USER_INPUT%"=="\%COMMAND_GET_ACTIVITY_STACK_ALIAS%"          call %SCRIPT_GET_ACTIVITY_STACK%
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST%"                  goto FEATURE_GET_DEVICE_APK_LIST
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST_ALIAS%"            goto FEATURE_GET_DEVICE_APK_LIST
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST_FULL%"             goto FEATURE_GET_DEVICE_APK_LIST_FULL
If /i "%USER_INPUT%"=="\%COMMAND_GET_PACKAGE_LIST_FULL_ALIAS%"       goto FEATURE_GET_DEVICE_APK_LIST_FULL
If /i "%USER_INPUT%"=="\%COMMAND_NETSTAT%"                           call %SCRIPT_NETSTAT%
If /i "%USER_INPUT%"=="\%COMMAND_NETSTAT_ALIAS%"                     call %SCRIPT_NETSTAT%
If /i "%USER_INPUT%"=="\%COMMAND_IP%"                                call %SCRIPT_IP_INFO%
If /i "%USER_INPUT%"=="\%COMMAND_IP_ALIAS%"                          call %SCRIPT_IP_INFO%
If /i "%USER_INPUT%"=="\%COMMAND_IF_CONFIG%"                         call %SCRIPT_IF_CONFIG%
If /i "%USER_INPUT%"=="\%COMMAND_IF_CONFIG_ALIAS%"                   call %SCRIPT_IF_CONFIG%
If /i "%USER_INPUT%"=="\%COMMAND_INSTALL_APK%"                       call %SCRIPT_INSTALL_APK%
If /i "%USER_INPUT%"=="\%COMMAND_INSTALL_APK_ALIAS%"                 call %SCRIPT_INSTALL_APK%
If /i "%USER_INPUT%"=="\%COMMAND_START_ACTIVITY%"                    call %SCRIPT_START_ACTIVITY%
If /i "%USER_INPUT%"=="\%COMMAND_START_ACTIVITY_ALIAS%"              call %SCRIPT_START_ACTIVITY%
If /i "%USER_INPUT%"=="\%COMMAND_CLEAR_APP%"                         call %SCRIPT_CLEAR_APP_DATA%
If /i "%USER_INPUT%"=="\%COMMAND_CLEAR_APP_ALIAS%"                   call %SCRIPT_CLEAR_APP_DATA%
If /i "%USER_INPUT%"=="\%COMMAND_UNINSTALL_APK%"                     call %SCRIPT_UNINSTALL_APK%
If /i "%USER_INPUT%"=="\%COMMAND_UNINSTALL_APK_ALIAS%"               call %SCRIPT_UNINSTALL_APK%
If /i "%USER_INPUT%"=="\%COMMAND_STOP_APP%"                          call %SCRIPT_STOP_APPLICATION%
If /i "%USER_INPUT%"=="\%COMMAND_STOP_APP_ALIAS%"                    call %SCRIPT_STOP_APPLICATION%
If /i "%USER_INPUT%"=="\%COMMAND_PULL_FILE%"                         call %SCRIPT_PULL_FILE%
If /i "%USER_INPUT%"=="\%COMMAND_PULL_FILE_ALIAS%"                   call %SCRIPT_PULL_FILE%
If /i "%USER_INPUT%"=="\%COMMAND_INPUT_TEXT%"                        call %SCRIPT_INPUT_TEXT%
If /i "%USER_INPUT%"=="\%COMMAND_INPUT_TEXT_ALIAS%"                  call %SCRIPT_INPUT_TEXT%
If /i "%USER_INPUT%"=="\%COMMAND_CHANGE_DENSITY%"                    call %SCRIPT_CHANGE_DENSITY%
If /i "%USER_INPUT%"=="\%COMMAND_CHANGE_DENSITY_ALIAS%"              call %SCRIPT_CHANGE_DENSITY%
If /i "%USER_INPUT%"=="\%COMMAND_SHELL_REMOUNT%"                     call %SCRIPT_REMOUNT%
If /i "%USER_INPUT%"=="\%COMMAND_SHELL_REMOUNT_ALIAS%"               call %SCRIPT_REMOUNT%
If /i "%USER_INPUT%"=="\%COMMAND_REBOOT_DEVICE%"                     call %SCRIPT_REBOOT%
If /i "%USER_INPUT%"=="\%COMMAND_REBOOT_DEVICE_ALIAS%"               call %SCRIPT_REBOOT%
If /i "%USER_INPUT%"=="\%COMMAND_ADB_DEVICE_SELECT%"                 goto FEATURE_ADB_DEVICE_SELECT
If /i "%USER_INPUT%"=="\%COMMAND_ADB_DEVICE_SELECT_ALIAS%"           goto FEATURE_ADB_DEVICE_SELECT
goto MODE_INPUT_WAIT










rem =================================================================
rem =================================================================
rem =================================================================










rem =================================================================
:FEATURE_GET_DEVICE_APK_LIST
cls
echo LIST INSTALLED APKs

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set APK_LIST_NAME=device-apk-list_%YYYYMMDDHHMMSS%.packages
set APK_LIST_PATH_NAME=%PACKAGE_LIST_BASE_PATH%%APK_LIST_NAME%

set SEARCH_INPUT=""
set /p SEARCH_INPUT="Seach: "

rem Create a folder to store packages list reports
if not exist %PACKAGE_LIST_BASE_PATH% (
    md %PACKAGE_LIST_BASE_PATH%
)

if %SEARCH_INPUT% == "" (
    echo Search all packages
    %ADB_SHELL% pm list packages>"%APK_LIST_PATH_NAME%"
) else (
    echo Search all packages have "%SEARCH_INPUT%"
    %ADB_SHELL% pm list packages ^| grep %SEARCH_INPUT%>"%APK_LIST_PATH_NAME%"
)

rem Remove multiple newlines
if exist "%SCRIPT_DELETE_OVERLAP_CRLF%" (
    call %SCRIPT_DELETE_OVERLAP_CRLF% "%APK_LIST_PATH_NAME%"
) else (
    echo Could not find "%SCRIPT_DELETE_OVERLAP_CRLF%" script.
)

type "%APK_LIST_PATH_NAME%"
echo.
echo A list of APKs installed in [%APK_LIST_NAME%] of [%PACKAGE_LIST_BASE_PATH%] has been output.
pause
goto MODE_INPUT_WAIT










rem =================================================================
:FEATURE_GET_DEVICE_APK_LIST_FULL
cls
echo LIST INSTALLED APKs (Full information)

rem Retrieve unique value for new file name
set time_tmp=%time: =0%
set YYYYMMDDHHMMSS=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set APK_LIST_NAME=device-apk-list_%YYYYMMDDHHMMSS%.packages
set APK_LIST_PATH_NAME=%PACKAGE_LIST_BASE_PATH%%APK_LIST_NAME%

echo.
echo # Prints all packages, optionally only those whose package name with defined mode bellow.
echo # [f]: See their associated file.
echo # [d]: Filter to only show disabled packages.
echo # [e]: Filter to only show enabled packages.
echo # [s]: Filter to only show system packages.
echo # [3]: Filter to only show third party packages.
echo # [i]: See the installer for the packages.
echo # [u]: Also include uninstalled packages.
echo #-------

set SEARCH_INPUT=""
set /p SEARCH_INPUT="# Seach: "

rem Create a folder to store packages list reports
if not exist %PACKAGE_LIST_BASE_PATH% (
    md %PACKAGE_LIST_BASE_PATH%
)

if not defined %SEARCH_INPUT% (
    echo Please insert mode and try it again.
    echo.
    pause
    goto MODE_INPUT_WAIT
) else (
    echo Search all packages have "%SEARCH_INPUT%"
    %ADB_SHELL% pm list packages -"%APK_LIST_PATH_NAME%"
)

rem Remove multiple newlines
if exist "%SCRIPT_DELETE_OVERLAP_CRLF%" (
    call %SCRIPT_DELETE_OVERLAP_CRLF% "%APK_LIST_PATH_NAME%"
) else (
    echo Could not find "%SCRIPT_DELETE_OVERLAP_CRLF%" script.
)

type "%APK_LIST_PATH_NAME%"
echo.
echo A list of APKs installed in [%APK_LIST_NAME%] of [%PACKAGE_LIST_BASE_PATH%] has been output.
pause
goto MODE_INPUT_WAIT










rem =================================================================
:FEATURE_ADB_DEVICE_SELECT
cls
echo RESELECT THE DEVICE

echo.
echo # Please specify the adb connection destination.
echo #  [d]: change adb connection to real machine
echo #  [e]: change adb connection to emulator
echo #  [s]: specify the serial number of the adb connection destination
echo #  [ ]: do not pin the adb connection to a specific device
echo #-------

set TARGET_DEVICE_INPUT=
set /p TARGET_DEVICE_INPUT="# Mode: "

rem Started using delay variable
setlocal enabledelayedexpansion
if not defined TARGET_DEVICE_INPUT (
    %ADB_TARGET% kill-server>nul

    rem Reset adb connection information
    set TARGET_DEVICE=
    set TARGET_DEVICE_SERIAL=

    rem Start adb on new connection
    adb !TARGET_DEVICE! !TARGET_DEVICE_SERIAL! start-server
    echo Changed to not fix adb target equipment.
) else If /i "%TARGET_DEVICE_INPUT%"=="d" (
    %ADB_TARGET% kill-server>nul

    rem Reset adb connection information
    set TARGET_DEVICE=-d
    set TARGET_DEVICE_SERIAL=

    rem Start adb on new connection
    adb !TARGET_DEVICE! !TARGET_DEVICE_SERIAL! start-server
    echo Changed the equipment targeted for adb to actual machine.
) else If /i "%TARGET_DEVICE_INPUT%"=="e" (
    %ADB_TARGET% kill-server>nul

    rem Reset adb connection information
    set TARGET_DEVICE=-e
    set TARGET_DEVICE_SERIAL=

    rem Start adb on new connection
    adb !TARGET_DEVICE! !TARGET_DEVICE_SERIAL! start-server
    echo Changed the equipment targeted for adb to emulator.
) else If /i "%TARGET_DEVICE_INPUT%"=="s" (
    echo.
    echo # Enter the serial number for adb connecting destination.
    echo # The value described in the file acquired by attache is serial number.
    echo #----------------

    set TARGET_DEVICE_SERIAL_INPUT=
    set /p TARGET_DEVICE_SERIAL_INPUT="# Serial number: "

    if not defined TARGET_DEVICE_SERIAL_INPUT (
        echo The serial number is invalid.
        echo.
        pause
        goto MODE_INPUT_WAIT
    )

    %ADB_TARGET% kill-server>nul

    rem Set the adb connection destination to a serial No terminal
    set TARGET_DEVICE=-s
    set TARGET_DEVICE_SERIAL=!TARGET_DEVICE_SERIAL_INPUT!

    rem Start adb on new connection
    %ADB_TARGET% start-server

    echo The target adb device has been changed to [!TARGET_DEVICE_SERIAL!].
) else (
    echo The input is invalid.
)

rem End use of delay variable
setlocal disabledelayedexpansion

echo.
pause
goto MODE_INPUT_WAIT










rem =================================================================
:FEATURE_OPEN_OUTPUT_DIR
explorer "%DEFAULT_WORKING_SPACE%"
goto MODE_INPUT_WAIT










rem =================================================================
rem Confirm that the terminal is connected
rem %CONNECT_RESULT%: connection state
rem                   true  : connected
rem                   false : not connected
rem ===================================
:CHECK_DEVICE_CONNECT

set ANDROID_API_LEVEL=
for /f "usebackq tokens=*" %%i in (`%ADB_GETPROP% ro.build.version.sdk`) do @set ANDROID_API_LEVEL=%%i

rem Once could be get the API level connected
If DEFINED ANDROID_API_LEVEL (
    set CONNECT_RESULT=true
) else (
    set CONNECT_RESULT=false
)

exit /b
