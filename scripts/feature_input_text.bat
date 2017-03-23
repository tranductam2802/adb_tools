rem =================================================================
:FEATURE_INPUT_TEXT
cls
echo INPUT TEXT

echo.
echo # Enter the character string you want to enter on the echo terminal and press enter.
echo #------------------
set INPUT_TEXT=
set /p INPUT_TEXT="# Input: "

if not defined INPUT_TEXT (
    echo Invalid text.
    goto LOOP
)

echo Sending...
%ADB_SHELL% input text "'%INPUT_TEXT%'"
echo Send '%INPUT_TEXT%' complete!

:LOOP
set INPUT_TEXT=
set /p INPUT_TEXT="Input again? [y/n]: "
if "%INPUT_TEXT%"=="n" (
    exit /b
) else (
    if "%INPUT_TEXT%"=="no" (
        exit /b
    ) else (
        goto FEATURE_INPUT_TEXT
    )
)