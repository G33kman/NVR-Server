#!/bin/sh

echo "[Homepage Entrypoint] Starting..."

# Make sure directories exist and copy the (needed) files to their correct locations
if [ ! -f /app/config/settings.yaml ]; then
  echo "[Homepage Entrypoint] No config detected. Bootstrapping from /bootstrap..."

  mkdir -p /app/config /app/public/images

  cp -r /bootstrap/config/* /app/config/
  cp -r /bootstrap/public/images/* /app/public/images/

  chown -R ${PUID}:${PGID} /app/config /app/public/images
else
  echo "[Homepage Entrypoint] Existing config found — skipping bootstrap."
fi

echo "[Homepage Entrypoint] Launching application..."
exec npx next start

