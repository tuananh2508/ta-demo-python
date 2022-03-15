#!/bin/bash

CONTAINER=demo-jenkins

RUNNING=$(docker inspect --format="{{ .State.Running }}" demo-jenkins 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "$CONTAINER doesn't exist"
else
  echo "$CONTAINER does existed, will remove the container"
  sudo docker rm -f $CONTAINER
fi

echo "Start deploying ..."
echo "Start new Container"
docker run -p 8081:5000 -d --name demo-jenkins ta2199/python-demo:$1
echo "Deployment success"
echo "Now you can access the service through localhost:8081"
