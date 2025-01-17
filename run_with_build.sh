#!/bin/bash
mkdir pgdata
docker-compose -f ./dev-docker-compose-linux.yml up --build -d
