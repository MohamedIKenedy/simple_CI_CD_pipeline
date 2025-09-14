#!/bin/sh

set -e

JAVA_EXE="java"
[ -n "$JAVA_HOME" ] && JAVA_EXE="$JAVA_HOME/bin/java"

WRAPPER_JAR="$(dirname "$0")/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Downloading Maven Wrapper JAR..."
  PROPS_FILE="$(dirname "$0")/.mvn/wrapper/maven-wrapper.properties"
  WRAPPER_URL=$(grep -E "^wrapperUrl=" "$PROPS_FILE" | sed -e 's/wrapperUrl=//')
  [ -z "$WRAPPER_URL" ] && WRAPPER_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"
  curl -fsSL "$WRAPPER_URL" -o "$WRAPPER_JAR" || wget -q "$WRAPPER_URL" -O "$WRAPPER_JAR"
fi

exec "$JAVA_EXE" -classpath "$WRAPPER_JAR" "$WRAPPER_LAUNCHER" "$@"
