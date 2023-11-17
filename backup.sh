#!/bin/bash

if ! git status; then
  echo "No backup done because of git error."
  exit
fi

. ./secrets

IMAGE="ghcr.io/home-assistant/homeassistant:stable"
curver=$(curl -s -X GET -H "$AUTH" $MY_HA_API/api/states/sensor.current_version | jq '.state')

cd $(dirname $0) || exit
git add .
git commit -m\
"Homeassistant image id $(docker images $IMAGE -q)
$IMAGE $curver
$(date)"
git push origin
