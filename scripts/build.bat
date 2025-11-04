@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM ReWAMP Build Script
REM Modern batch build script with error handling

ECHO [INFO] Building ReWAMP...

REM Check if Go is installed
go version >nul 2>&1
IF ERRORLEVEL 1 (
    ECHO [ERROR] Go is not installed or not in PATH
    ECHO [INFO] Please install Go from https://golang.org/downloads/
    PAUSE
    EXIT /B 1
)

REM Get version info
FOR /F "tokens=*" %%i IN ('git describe --tags --always --dirty 2^>nul') DO SET VERSION=%%i
IF "%VERSION%"=="" SET VERSION=dev

REM Get current timestamp
FOR /F "tokens=*" %%i IN ('powershell -Command "Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz'"') DO SET BUILD_TIME=%%i

ECHO [INFO] Version: %VERSION%
ECHO [INFO] Build Time: %BUILD_TIME%

REM Set build flags
SET LDFLAGS=-ldflags="-H windowsgui -s -w -X main.version=%VERSION% -X main.buildTime=%BUILD_TIME%"

REM Build the application
ECHO [INFO] Compiling...
go build %LDFLAGS% -o ..\rewamp.exe ..\cmd\rewamp

IF ERRORLEVEL 1 (
    ECHO [ERROR] Build failed
    PAUSE
    EXIT /B 1
)

REM Get file size
FOR %%F IN (..\rewamp.exe) DO (
    SET /A SIZE=%%~zF/1024
    ECHO [SUCCESS] Build completed: rewamp.exe ^(!SIZE! KB^)
)

ECHO [INFO] Build process completed successfully!
