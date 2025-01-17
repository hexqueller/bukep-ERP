Remove-Item -Path ".\pgdata" -Recurse -Force
docker compose -f .\dev-docker-compose-windows.yml down -v
