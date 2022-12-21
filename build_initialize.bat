@ECHO OFF
ECHO Building REWAMP:
ECHO ---
ECHO Installing 2goarray...
go install github.com/cratonica/2goarray@latest
ECHO Initializing MOD...
go mod init rewamp
ECHO Updating MOD...
go mod tidy
go get -u ./... all
ECHO Creating REWAMP.exe...
go build -ldflags="-H windowsgui"
ECHO Finished!
pause