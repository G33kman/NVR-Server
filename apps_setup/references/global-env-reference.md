# Global Environment Variable Reference

## System Identity & Access

- `SYS_HOSTNAME`, `SYS_PUID`, `SYS_PGID`, `SYS_TZ`

## System Paths & Devices

- `DIR_OS_ROOT`, `DIR_ROOT`, `DIR_COMPOSE`, `DIR_DATA`, `DIR_LOGS`, `DIR_SECRETS`, `DIR_PRIVATE`, `DIR_PUBLIC`, `DIR_SSL`, `DIR_SCRIPTS`
- `SYS_DEV_INTEL`, `SYS_DEV_RTX`, `SYS_DEV_TPU`

## Video Storage

- `VOL_VIDEOS_CURRENT`, `VOL_VIDEOS_ARCHIVES`

## Secrets Mount

- `DIR_CONTAINER_SECRETS`

## Compose Defaults

- `PRIVILEGES_DEFAULT`, `PRIVILEGES_SPECIAL`, `READ_ONLY`, `RESTART_NORMAL`, `RESTART_IMPORTANT`, `LABEL_DOMAIN`

## Ulimits

- `UL_SOFT`, `UL_HARD`

## Health Check Defaults

- `HC_CMD`, `HC_INTERVAL`, `HC_TIMEOUT`, `HC_RETRIES`, `HC_START_PERIOD`, `HC_START_INTERVAL`

## Host Network Info

- `DOMAIN_NAME`, `DOCKER_HOST`, `LOCAL_IP`, `LOCAL_HOST`, `LOCAL_NETWORK`, `LOCAL_NETWORKS`

## Cloudflare Ranges

- `CF_IPS_1`, `CF_IPS_2`, `CF_IPS_3`, `CF_IPS`

## Docker Network Definitions

- `NET_INTERNAL`, `IP_INTERNAL_BASE`
- `NET_PRIVATE`, `IP_PRIVATE_BASE`
- `NET_PUBLIC`, `IP_PUBLIC_BASE`

---

**Guidelines:**
- All global values are referenced, never duplicated, in per-app configs.
- App `.env` files use these with `${}` substitution.
