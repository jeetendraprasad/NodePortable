SET WORKING_FOLDER1=%~dp0%

IF "%WORKING_FOLDER1:~-1%"=="\" SET "WORKING_FOLDER1=%WORKING_FOLDER1:~0,-1%"

ECHO %WORKING_FOLDER1%

SET NODE_FOLDER=node-v22.17.0-win-x64
SET NODE_FOLDER_ZIP=node-v22.17.0-win-x64.zip



IF NOT EXIST "%WORKING_FOLDER1%\%NODE_FOLDER%\" (
	powershell -noprofile -executionpolicy remotesigned -command " Expand-Archive -Path '%WORKING_FOLDER1%\%NODE_FOLDER_ZIP%' -DestinationPath '%WORKING_FOLDER1%\' "
)

SET PATH="%WORKING_FOLDER1%\%NODE_FOLDER%\"
SET PATH="%WORKING_FOLDER1%\node_modules\.bin";%PATH%
@REM SET PATH=%PATH%;%SystemRoot%\System32\WindowsPowerShell\v1.0\;

MKDIR "%WORKING_FOLDER1%\USERHOME"
@REM NOTE NO double quotes in USERHOME
SET HOME=%WORKING_FOLDER1%\USERHOME

%ComSpec% /C npm config get cache
MKDIR "%WORKING_FOLDER1%\USERCACHE\"
%ComSpec% /C npm config set cache "%WORKING_FOLDER1%\USERCACHE"

MKDIR "%WORKING_FOLDER1%\USER-PREFIX"
%ComSpec% /C npm config set prefix "%WORKING_FOLDER1%\USER-PREFIX"

%ComSpec% /C node -v
%ComSpec% /C npm -v
%ComSpec% /C npm config list
%ComSpec% /C npm config ls -l


PAUSE
START "Node Portable" %ComSpec%

EXIT

npm install json-server
SET PATH="%WORKING_FOLDER1%\node_modules\.bin";%PATH%
# assume that db.json exists
json-server db.json
Ctrl+C