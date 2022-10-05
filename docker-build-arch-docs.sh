#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -rf ${DIR}/generated/*

docker-compose -f ${DIR}/docker-compose.yml up --remove-orphans --renew-anon-volumes
