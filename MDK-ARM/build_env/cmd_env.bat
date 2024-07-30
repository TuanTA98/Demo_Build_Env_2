@call local_config.bat

@SET cmd=%1

@if %cmd% == build (
    set "TS=%2"
    call cmd_build.bat
)

@if %cmd% == clean (
    call cmd_clean.bat
)

