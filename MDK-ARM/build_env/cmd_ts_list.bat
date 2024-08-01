@SETLOCAL

@REM Definition of directory
@SET TestSuite_DIR=..\TestSuite

@ for /d %%D in (%TestSuite_DIR%\*) do @echo %%~nxD

@ENDLOCAL