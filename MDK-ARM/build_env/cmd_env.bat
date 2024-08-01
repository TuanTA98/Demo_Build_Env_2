@echo off

call local_config.bat

SETLOCAL

REM Check the first argument - command
if "%~1"=="" (
    echo Wrong syntax. Please add the command.
    exit /b
)

SET cmd=%~1

if %cmd% == build (
    REM Check the second argument - TS
    if "%~2"=="" (
        echo Wrong syntax. Please add test suite want to build.
        exit /b
    )
    set "TS=%~2"
    call cmd_build.bat
) else if %cmd% == clean (
    call cmd_clean.bat

) else if %cmd% == ts_list (
    call cmd_ts_list.bat

) else (
    echo The command is not correct!
)

ENDLOCAL