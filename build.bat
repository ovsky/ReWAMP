@ECHO OFF
ECHO If you are trying to build the project for the first time, you probably should use build_initialize.bat or the README instruction.
ECHO ---
ECHO Building REWAMP:
ECHO Creating REWAMP.exe
go build -ldflags="-H windowsgui"
ECHO Finished!
pause