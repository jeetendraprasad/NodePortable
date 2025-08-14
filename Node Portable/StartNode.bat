SET WORKING_FOLDER1=%~dp0%

IF "%WORKING_FOLDER1:~-1%"=="\" SET "WORKING_FOLDER1=%WORKING_FOLDER1:~0,-1%"

ECHO %WORKING_FOLDER1%

SET NODE_FOLDER=node-v22.17.0-win-x64
SET NODE_FOLDER_ZIP=node-v22.17.0-win-x64.zip

@REM UNUSED
@REM SET NODE_EXE_PATH=%WORKING_FOLDER1%\%NODE_FOLDER%\node.exe

IF NOT EXIST "%WORKING_FOLDER1%\%NODE_FOLDER%\" (
	powershell -noprofile -executionpolicy remotesigned -command " Expand-Archive -Path '%WORKING_FOLDER1%\%NODE_FOLDER_ZIP%' -DestinationPath '%WORKING_FOLDER1%\' "
)

SET PATH=%WORKING_FOLDER1%\%NODE_FOLDER%\
@REM SET PATH=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\;%PATH%
SET PATH=%WORKING_FOLDER1%\node_modules\.bin;%PATH%
@REM SET PATH=C:\Program Files\dotnet;%PATH%
@REM SET PATH=%LOCALAPPDATA%\Programs\Git\cmd\;%PATH%
@REM SET PATH=%SystemRoot%\System32\WindowsPowerShell\v1.0\;%PATH%

MKDIR "%WORKING_FOLDER1%\USERHOME"
@REM NOTE NO double quotes in USERHOME
SET HOME=%WORKING_FOLDER1%\USERHOME

MKDIR "%WORKING_FOLDER1%\PREFIX"
@REM %ComSpec% /C npm config set prefix "%WORKING_FOLDER1%\PREFIX"
@REM NOTE NO double quotes
SET NPM_CONFIG_PREFIX=%WORKING_FOLDER1%\PREFIX
SET PATH=%WORKING_FOLDER1%\PREFIX;%PATH%

MKDIR "%WORKING_FOLDER1%\GLOBALCONFIG\"
SET NPM_CONFIG_GLOBALCONFIG=%WORKING_FOLDER1%\GLOBALCONFIG\.npmrc

MKDIR "%WORKING_FOLDER1%\CACHE\"
%ComSpec% /C npm config --global set cache "%WORKING_FOLDER1%\CACHE"

%ComSpec% /C node -v
%ComSpec% /C npm -v
%ComSpec% /C npm config ls -l
%ComSpec% /C npm config list

@ECHO.
@ECHO.
@ECHO Press any key to start Node Portable . . .
@ECHO.
@ECHO.
@pause >nul


@REM START "Node Portable" %ComSpec%
START "Node Portable" %ComSpec% /k echo Remember for local node packages installations: SET PATH=local_folder\node_modules\.bin;ORIG_PATH
@REM SET PATH=%CD%\node_modules\.bin;%PATH%


EXIT

@REM example code
npm install json-server
SET PATH=%WORKING_FOLDER1%\node_modules\.bin;%PATH%
# assume that db.json exists
json-server db.json
Ctrl+C