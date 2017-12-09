#!/usr/bin/env bash

if [ $# != 2 ]; then
	echo "Provide image as first argument and tag as second"
	exit
fi

IMAGE=$1
TAG=$2

if [ ! -f ./$IMAGE/Dockerfile ]; then
	echo "$IMAGE/Dockerfile does not exists - cannot build"
	exit
fi

cd $IMAGE
docker build . -t everlutionsk/$IMAGE
docker tag everlutionsk/$IMAGE everlutionsk/$IMAGE:$TAG
docker push everlutionsk/$IMAGE:$TAG
