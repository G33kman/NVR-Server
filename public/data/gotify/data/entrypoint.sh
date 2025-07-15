#!/bin/sh

echo "[Entrypoint] Setting GOTIFY_DEFAULTUSER_PASS from secret..."
export GOTIFY_DEFAULTUSER_PASS=$(cat /run/secrets/GOTIFY_ADMIN_PASSWORD)
echo "[Entrypoint] GOTIFY_DEFAULTUSER_PASS is set to: $GOTIFY_DEFAULTUSER_PASS"

exec /app/gotify-app