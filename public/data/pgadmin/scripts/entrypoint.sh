#!/bin/sh

echo "[pgAdmin Entrypoint] Copying Docker secret to /tmp..."

if [ ! -f /run/secrets/ADMIN_PASSWORD_BASIC ]; then
  echo "[pgAdmin Entrypoint] ERROR: Docker secret not found: /run/secrets/ADMIN_PASSWORD_BASIC"
  exit 1
fi

cp /run/secrets/ADMIN_PASSWORD_BASIC /tmp/pgadmin_pwd
chmod 644 /tmp/pgadmin_pwd
export PGADMIN_DEFAULT_PASSWORD_FILE=/tmp/pgadmin_pwd

echo "[pgAdmin Entrypoint] Launching pgAdmin..."
exec /entrypoint.sh "$@"
