@ECHO OFF
SETLOCAL

REM Determine Java executable
SET JAVA_EXE=java.exe
IF NOT "%JAVA_HOME%"=="" SET JAVA_EXE=%JAVA_HOME%\bin\java.exe

REM Wrapper locations (unquoted variables; quote upon use)
SET WRAPPER_JAR=%~dp0\.mvn\wrapper\maven-wrapper.jar
SET PROPS_FILE=%~dp0\.mvn\wrapper\maven-wrapper.properties
SET WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

IF EXIST "%WRAPPER_JAR%" GOTO runWrapper

ECHO Downloading Maven Wrapper JAR...
SET WRAPPER_URL=
FOR /F "usebackq tokens=1,2 delims==" %%A IN ("%PROPS_FILE%") DO (
  IF "%%A"=="wrapperUrl" SET WRAPPER_URL=%%B
)
IF "%WRAPPER_URL%"=="" SET WRAPPER_URL=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar

REM Use PowerShell to download with proper quoting; fall back to curl if available
POWERSHELL -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri '%WRAPPER_URL%' -OutFile '%WRAPPER_JAR%'" || (
  where curl >NUL 2>&1 && curl -L -o "%WRAPPER_JAR%" "%WRAPPER_URL%"
)

:runWrapper
REM Establish project base directory for multi-module support
SET MAVEN_PROJECTBASEDIR=%CD%
IF EXIST "%~dp0\.mvn" SET MAVEN_PROJECTBASEDIR=%~dp0

"%JAVA_EXE%" -Dmaven.multiModuleProjectDirectory="%MAVEN_PROJECTBASEDIR%" -classpath "%WRAPPER_JAR%" %WRAPPER_LAUNCHER% %*
ENDLOCAL
