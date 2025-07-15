#!/bin/bash
set -e

echo "[INFO] Running cleanup script..."

# Remove temporary secrets (already chown'd for UID 999)
rm -f /tmp/postgres_root.secret /tmp/postgres_user.secret

# Optionally nuke the SQL init files so they don't rerun (if any were created manually)
find /init-scripts -maxdepth 1 -type f -name "*.sql" -exec rm -f {} \;

echo "[INFO] Cleanup complete."
