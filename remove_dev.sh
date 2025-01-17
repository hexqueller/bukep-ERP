#!/bin/bash
rm -rf pgdata
docker-compose -f ./dev-docker-compose-linux.yml down -v
