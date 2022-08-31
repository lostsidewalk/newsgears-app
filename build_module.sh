#!/bin/bash 
# 
# suggested usage: 
# 
# alias ng-api='./build_module.sh api'
# alias ng-rss='./build_module.sh rss'
# alias ng='cd ${SRC}/newsgears-app && ng-api && ng-rss && docker-compose up'
# 
CURRENT_DIR=$(basename `pwd`)
if [ ! "${CURRENT_DIR}" = "newsgears-app" ]
then
	echo "Wrong dir: ${CURRENT_DIR}";
	return;
fi
echo "Current dir: ${CURRENT_DIR}"

MODULE_NAME=$@;
echo "Building module: ${MODULE_NAME}";

# change to the module dir 
cd newsgears-${MODULE_NAME}

# build the artifacts via gradle 
./gradlew clean build 

# build the docker image with the updated artifacts 
docker build --build-arg JAR_FILE=build/libs/*.jar -t lostsidewalk/newsgears-${MODULE_NAME} .

# return to parent dir (newsgears-app) 
cd ..
