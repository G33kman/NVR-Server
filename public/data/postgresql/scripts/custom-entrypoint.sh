#!/bin/bash
set -e

echo "[INFO] Starting PostgreSQL container with custom entrypoint"

# Copy secrets to temp location for UID 999 access
echo "[INFO] Preparing secrets..."
cp /run/secrets/POSTGRES_PASSWORD /tmp/postgres_root.secret
cp /run/secrets/POSTGRES_USER_PASSWORD /tmp/postgres_user.secret
chmod 0400 /tmp/postgres_*.secret
chown 999:999 /tmp/postgres_*.secret

# Retrieve password values for script
POSTGRES_USER_PASSWORD=$(cat /tmp/postgres_user.secret)

# Run your database creation script with scoped secret vars
echo "[INFO] Executing DB init script"
POSTGRES_PASSWORD="$POSTGRES_PASSWORD" POSTGRES_USER_PASSWORD="$POSTGRES_USER_PASSWORD" \
  /init-scripts/01-init-dbs.sh || echo "[WARN] DB init script failed or not needed"

# Cleanup optional script
/init-scripts/02-cleanup.sh || echo "[INFO] Cleanup script skipped or not required"

# Drop privileges and exec the real PostgreSQL entrypoint
echo "[INFO] Switching to UID 999 to launch postgres"
exec /usr/local/bin/docker-entrypoint.sh "$@"

