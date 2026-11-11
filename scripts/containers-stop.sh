#!/bin/bash

# --profile tools zodat pgadmin ook wordt gestopt wanneer deze lokaal is gestart
docker compose \
    -f .docker/db.yml \
    --profile tools \
    down
