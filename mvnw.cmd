@echo off
setlocal

set "WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain"
set "WRAPPER_JAR=%~dp0\.mvn\wrapper\maven-wrapper.jar"
set "WRAPPER_PROPERTIES=%~dp0\.mvn\wrapper\maven-wrapper.properties"

rem Determine Java executable
if not "%JAVA_HOME%"=="" (
  set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
 ) else (
  set "JAVA_EXE=java.exe"
)

rem Download wrapper jar if missing
if not exist "%WRAPPER_JAR%" (
  echo Downloading Maven Wrapper JAR...
  set "DOWNLOAD_URL="
  for /F "usebackq tokens=1,2 delims==" %%A in ("%WRAPPER_PROPERTIES%") do (
    if "%%A"=="wrapperUrl" set "DOWNLOAD_URL=%%B"
  )
  if "%DOWNLOAD_URL%"=="" set "DOWNLOAD_URL=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri '%DOWNLOAD_URL%' -OutFile '%WRAPPER_JAR%'" || (
    where curl >NUL 2>&1 && curl -L -o "%WRAPPER_JAR%" "%DOWNLOAD_URL%"
  )
)

rem Establish project base directory and normalize trailing slash
set "MAVEN_PROJECTBASEDIR=%~dp0"
if "%MAVEN_PROJECTBASEDIR:~-1%"=="\" set "MAVEN_PROJECTBASEDIR=%MAVEN_PROJECTBASEDIR:~0,-1%"

"%JAVA_EXE%" ^
  -Dmaven.multiModuleProjectDirectory="%MAVEN_PROJECTBASEDIR%" ^
  -cp "%WRAPPER_JAR%" ^
  %WRAPPER_LAUNCHER% %*

endlocal
