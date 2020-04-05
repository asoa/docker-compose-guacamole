#!/bin/bash

# This script builds the dir structure and configuration files (initdb.sql)
# run docker-compose up to build/start guacamole server

SERVICES=("guacamole/guacd" "guacamole/guacamole" "mysql")
DIRS=("guacamole" "guacd" "mysql")
WORKDIR=$(pwd)

log() {
  echo "LOG - $1"
}

error() {
  echo "** ERROR - $1 **"
}

download() {
  echo "Downloading $1"
  docker pull $1
}

createFileTree() {
  for dir in "${DIRS[@]}"; do
    if [[ -d $WORKDIR/$dir ]] && [[ -f $WORKDIR/$dir/Dockerfile ]]; then
      echo "~/$dir/Dockerfile already exists"
      continue
    else
      mkdir $WORKDIR/$dir && touch $WORKDIR/$dir/Dockerfile
    fi
  done
}

checkImageExist() {
  for service in "${SERVICES[@]}"; do
    if [[ "$(docker images -q $service 2> /dev/null)" == "" ]]; then
      log "downloading $service"
      download $service
    else
      echo "$service already downloaded"
    fi
  done
}

buildSqlConfig() {
  docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > \
  initdb-1.sql
}

main() {
  createFileTree
  checkImageExist
  buildSqlConfig
}

"$@"
