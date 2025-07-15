# App Templates Reference

## App Compose File Template (`<APP_NAME>-compose.yml`)

```yaml
services:
  ${APP_NAME}:
    container_name: ${APP_NAME}
    image: ${REPO}/${NAME}:${TAG}
    hostname: ${APP_NAME}
    environment:
      - TZ=${TZ}
      - PUID=${PUID}
      - PGID=${PGID}
      # App-specific variables below
    env_file:
      - ${DIR_COMPOSE}/${APP_NAME}/${APP_NAME}.env
    volumes:
      - ${DIR_DATA}/${APP_NAME}:${DIR_INT_DATA}
      - ${DIR_LOGS}/${APP_NAME}:/logs
      # Add config or other volumes if needed
    secrets:
      - SECRET_NAME_HERE
    networks:
      internal:
        ipv4_address: ${IP_INTERNAL}
      private:
        ipv4_address: ${IP_PRIVATE}
      public:
        ipv4_address: ${IP_PUBLIC}
    healthcheck:
      test: ["CMD", "${HC_CMD}"]
      interval: ${HC_INTERVAL}
      timeout: ${HC_TIMEOUT}
      retries: ${HC_RETRIES}
      start_period: ${HC_START_PERIOD}
      start_interval: ${HC_START_INTERVAL}
    deploy:
      resources:
        limits:
          cpus: ${CPU_LIMIT}
          memory: ${RAM_LIMIT}
        reservations:
          cpus: ${CPU_RESERVE}
          memory: ${RAM_RESERVE}
    restart: ${RESTART_NORMAL}
    read_only: true
    tmpfs:
      - /tmp
    # logging: handled globally; only add here if needed
```
---

## App Environment File Template (`<APP_NAME>.env`)

```dotenv
APP_NAME=<APP_NAME>

### IMAGE INFORMATION
REPO=<REPO_NAME>
NAME=<IMAGE_NAME>
TAG=<IMAGE_TAG_VERSION>

### SYSTEM VARIABLES
TZ=${SYS_TZ}
PUID=${SYS_PUID}
PGID=${SYS_PGID}

### APP DIRECTORIES
DIR_INT_BASE=<BASE_DIRECTORY_INSIDE_CONTAINER>
DIR_INT_CONFIG=${DIR_INT_BASE}/<CONFIG_LOCATION>
DIR_INT_DATA=${DIR_INT_BASE}/<DATA_LOCATION>

### APP VARIABLES
<OTHER_APP_SPECIFIC_VARIABLES>

### Resource Limits
CPU_LIMIT=<MAX_CPU_ALLOWED>
RAM_LIMIT=<MAX_RAM_ALLOWED>
CPU_RESERVE=<STARTING_CPU_ALLOWED>
RAM_RESERVE=<STARTING_RAM_ALLOWED>

### APP FILES
<VAR_NAME>=${DIR_COMPOSE}/path/to/file/<OTHER_APP_FILES>

### IP LIST
IP_INTERNAL=${IP_INTERNAL_BASE}
IP_PRIVATE=${IP_PRIVATE_BASE}
IP_PUBLIC=${IP_PUBLIC_BASE}

### PORTS LIST
PORT_HTTP=

### SECRET FILES
SECRET_NAME_HERE=${DIR_CONTAINER_SECRETS}/<PATH_TO_SECRET_FILE>

### LABEL SHORTENING
TR_RTR=traefik.http.routers.${APP_NAME}-rtr
TR_RTR_KUMA=traefik.http.routers.${APP_NAME}-kuma-rtr
TR_SVC=traefik.http.services.${APP_NAME}-svc
```

---

**Notes:**
- Don’t define volumes/networks/secrets in app files—reference only.
- All placeholders must be replaced per application.
- App-specific .env files reference global `.env` values wherever possible.
