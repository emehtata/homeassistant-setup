#!/bin/bash

. ./secrets

NAME="homeassistant"

OPT=$1
IMAGE="ghcr.io/home-assistant/raspberrypi3-homeassistant:stable"

case $OPT in
  status)
    echo -n "$NAME is "
    docker ps |grep $IMAGE > /dev/null || echo -n "NOT "
    echo "running"
  ;;
  stop)
    echo "Stopping $NAME"
    docker stop $NAME && echo "Stopped" || echo "Failed"
  ;;
  rm)
    echo "Removing $NAME"
    docker rm $NAME && echo "Removed" || echo "Failed"
  ;;
  start)
    echo "Starting $NAME"
    docker start $NAME && echo "Started" || echo "Failed"
  ;;
  run)
    echo "Starting new $NAME"
    docker run -d \
     --name $NAME \
     --privileged \
     --restart=unless-stopped \
     -e TZ=Europe/Helsinki \
     -v /opt/homeassistant/config:/config \
     --network=host \
     $IMAGE && echo "Started" || echo "Failed"
  ;;
update)
  newver=$(curl -s -X GET -H "$AUTH" $MY_HA_API/api/states/sensor.docker_hub | jq '.state')
  curver=$(curl -s -X GET -H "$AUTH" $MY_HA_API/api/states/sensor.current_version | jq '.state')
  echo "Current version - new version: $curver - $newver"
  [ "$newver" == "$curver" ] && echo "Image is up to date" && exit
  sudo ./backup.sh
  echo "Now updating $IMAGE"
  docker pull $IMAGE && echo "Updated" || echo "Failed"
  $0 stop || exit 1
  $0 rm || exit 1
  $0 run || exit 1
  ;;
restart)
  echo "Restarting $NAME"
  docker restart $NAME && echo "Restarted" || echo "Failed"
  ;;
*)
  echo "$(basename $0) start|stop|restart|rm|update"
  ;;
esac
