#!/bin/bash

# File Description: Check status of Docker Compose services
# TIP: Make sure to 'chmod +x path/to/file.sh'

set -euo pipefail

COMPOSE_FILE="../public/compose/docker-compose.yml"

echo "🔍 Checking Docker Compose services status..."

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "❌ Compose file not found at $COMPOSE_FILE"
  exit 1
fi

docker compose -f "$COMPOSE_FILE" ps

echo "✅ All services queried successfully."

