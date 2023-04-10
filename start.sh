#!/bin/bash

backend_status=""
db_status=""

backend_status=$(docker ps -f "name=soundfield-django-1" --format "{{.Status}}" | awk '{print $2}')
db_status=$(docker ps -f "name=soundfield-db-1" --format "{{.Status}}" | awk '{print $2}')

if [[ $backend_status != "Up" && $db_status != "Up" ]]; then
  echo "Containers are not running, starting docker-compose..."
  open -a Terminal.app "docker-compose up"
fi

open -a Terminal.app "local/dataIngest.sh"

cd frontend/soundfield_app
npm run electron-dev &
cd ..
cd ..