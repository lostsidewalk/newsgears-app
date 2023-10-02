#!/bin/bash

CURRENT_DIR=$(basename `pwd`)
if [ ! "${CURRENT_DIR}" = "newsgears-app" ]
then
	echo "Wrong dir: ${CURRENT_DIR}";
	exit;
fi
echo "Current dir: ${CURRENT_DIR}"

DEBUG="false"
DEBUG_PORT=

while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--debug)
      if [[ $# -lt 2 || $2 == -* ]]; then
        echo "Error: Missing debug port number after --debug"
        echo "Usage: $0 <module_name> [--debug <port_number>]"
        exit 1
      fi

      DEBUG="true"
      DEBUG_PORT="$2"
      shift 2
      ;;
    *)
      if [ ! -z "${MODULE_NAME}" ]; then
        echo "Usage: $0 <module_name> [--debug <port_number>]"
        echo "   <module_name>: Name of the module (required)"
        echo "   --debug <port_number>: Enable debugging with the specified port number (optional)"
        exit 1
      fi
      MODULE_NAME="$1"
      shift
      ;;
  esac
done

if [ "${DEBUG}" == "true" ]
then
  AGENT_ARG="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:${DEBUG_PORT}";
  TAG_NAME="latest-debug"
else
  AGENT_ARG=
  TAG_NAME="latest-local"
fi
echo "Building module: ${MODULE_NAME}, tag name: ${TAG_NAME}, isDebug: ${DEBUG}, agent args: ${AGENT_ARG}"

# change to the module dir
cd ${MODULE_NAME}

# build the artifacts via gradle
./gradlew clean build

# build the docker image with the updated artifacts
docker build \
  --build-arg JAR_FILE=build/libs/*.jar \
  --build-arg AGENT_ARG=${AGENT_ARG} \
  -t feedgears/${MODULE_NAME}:${TAG_NAME} \
  .

# return to parent dir (newsgears-app)
cd ..
