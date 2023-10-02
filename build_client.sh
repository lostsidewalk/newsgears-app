#!/bin/bash

CURRENT_DIR=$(basename `pwd`)
if [ ! "${CURRENT_DIR}" = "newsgears-app" ]
then
	echo "Wrong dir: ${CURRENT_DIR}";
	exit;
fi
echo "Current dir: ${CURRENT_DIR}"

# change to the client dir
cd newsgears-client

# build the artifacts via gradle
npm run devbuild

# build the docker image with the updated artifacts
docker build \
  -t feedgears/newsgears-client:latest-local \
  .

# return to parent dir (newsgears-app)
cd ..
