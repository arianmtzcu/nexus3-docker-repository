@echo off
setlocal EnableDelayedExpansion

REM === CONFIGURATION ===
set "USERNAME=admin"
set "PASSWORD=nexus"
set "GROUP_ID=com.example"
set "ARTIFACT_ID=demo"
set "VERSION=1.0.0-SNAPSHOT"


REM === DETECT REPOSITORY BASED ON VERSION ===
echo %VERSION% | findstr /I /C:"-SNAPSHOT" >nul
if %errorlevel%==0 (
    set "REPO_ID=nexus-snapshots"
    set "REPO_URL=http://localhost:8081/repository/nexus-snapshots"
) else (
    set "REPO_ID=nexus-releases"
    set "REPO_URL=http://localhost:8081/repository/nexus-releases"
)

REM === SET PROJECT AND ARTIFACT PATHS ===
set "SCRIPT_DIR=%~dp0"
set "PROJECT_DIR=%SCRIPT_DIR%.."
set "BASE_PATH=%PROJECT_DIR%\build\libs"
set "POM_FILE=%PROJECT_DIR%\pom.xml"

REM === CONVERT GROUP_ID TO PATH ===
set "GROUP_PATH=%GROUP_ID:.=/%"
set "REMOTE_PATH=%REPO_URL%/%GROUP_PATH%/%ARTIFACT_ID%/%VERSION%"

echo ^>^>^> Publishing artifacts to: %REMOTE_PATH%

REM === UPLOAD ARTIFACTS ===
call :upload_file "%BASE_PATH%\%ARTIFACT_ID%-%VERSION%.jar" "%ARTIFACT_ID%-%VERSION%.jar"
call :upload_file "%POM_FILE%" "%ARTIFACT_ID%-%VERSION%.pom"
call :upload_file "%BASE_PATH%\%ARTIFACT_ID%-%VERSION%-sources.jar" "%ARTIFACT_ID%-%VERSION%-sources.jar"
call :upload_file "%BASE_PATH%\%ARTIFACT_ID%-%VERSION%-javadoc.jar" "%ARTIFACT_ID%-%VERSION%-javadoc.jar"

goto :eof

REM === FUNCTION: UPLOAD FILE ===
:upload_file
if exist %~1 (
    echo + Uploading %~2...
    curl -v --user %USERNAME%:%PASSWORD% --upload-file %~1 %REMOTE_PATH%/%~2
) else (
    echo + File not found: %~1
)
goto :eof
