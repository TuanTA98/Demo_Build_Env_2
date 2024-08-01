@SETLOCAL

@REM Definition of directory
@SET OUTPUT_DIR=..\output

@if exist "%OUTPUT_DIR%" (
    echo Cleaning...
    del /Q %OUTPUT_DIR%\*
    echo Done!
) else (
    echo The folder output is not exist!
)

@ENDLOCAL