## NVR Server Project Reference

This document defines the persistent structure of your NVR Server Docker environment for consistent reference during future conversations. It includes global variable conventions, file structures, static/dynamic configuration rules, and application template practices.

---

### 🔧 Project Structure Overview

Root: `/compose`

* **Global Compose File:** `compose.yml`
* **Global Environment File:** `.env`
* **App Templates:**

  * `template-compose.yml`
  * `template.env`
* **Traefik Dynamic Rules:** Located in `/compose/public/rules`
* **Per-App Configuration:** Each app has its own directory in `/compose/public/compose/<APP_NAME>/`

  * Contains:

    * `<APP_NAME>-compose.yml`
    * `<APP_NAME>.env`

---

### 🌐 Networks

* **internal** – For Docker socket-only traffic
* **private** – Backend plumbing and Traefik routing
* **public** – User-facing UIs

These are defined in the main `compose.yml` and referenced in app-specific files.

---

### 📦 Volumes & Secrets

* All volumes use the format `<APP_NAME>_data`
* All secrets are files ending in `.secret`, stored under `${DIR_SECRETS}/<APP_NAME>/`
* Defined only in the global `compose.yml`, not in individual app files

---

### 📁 Global Environment Variables (`.env`)

Includes:

* Hostname & system-level vars
* Mounts for devices (Intel GPU, RTX GPU, Coral TPU)
* Admin identity info
* Directory mapping (e.g., `DIR_COMPOSE`, `DIR_SECRETS`)
* Docker Compose behavioral settings
* Health check config
* Cloudflare DNS/IP
* Network bases: `IP_INTERNAL_BASE`, `IP_PRIVATE_BASE`, `IP_PUBLIC_BASE`

Values are not often changed.

---

### 📜 App Template Guidelines

#### Compose File (`<APP_NAME>-compose.yml`)

* Should **only reference** shared resources (`volumes`, `secrets`, `networks`)
* Uses env file `${DIR_COMPOSE}/<APP_NAME>/<APP_NAME>.env`
* Includes:

  * Healthcheck block
  * Deploy resource limits using env vars
  * Traefik shorthand label vars (`TR_RTR`, `TR_SVC`, etc.)

#### Env File (`<APP_NAME>.env`)

* Specifies image info (`REPO`, `NAME`, `TAG`)
* System vars, IP assignments, ports
* Resource limits
* Label shortening vars

---

### 🔐 Secret File References

All secrets are defined globally and referenced in app files. For example:

* `ADMIN_USER`
* `BASIC_AUTH_CREDENTIALS`
* `CF_DNS_API_TOKEN`

Defined once in global `compose.yml`:

```yaml
secrets:
  ADMIN_USER:
    file: ${DIR_SECRETS}/common/ADMIN_USER.secret
```

---

### 📎 Traefik Configuration

#### Static Config

* All TLS/entrypoint/security/resolver info is defined in `traefik.env`
* Uses variables for settings like ports, resolvers, domain
* Traefik dashboard and metrics exposed on `websecure`

#### Dynamic Rules

* Files include `middlewares-*` and `chain-*`
* Also includes `tls-opts.yml`, `ignorecert.yml`
* Stored in `${DIR_COMPOSE}/public/rules`
* Examples:

  * `chain-frigate-auth.yml`
  * `middlewares-authelia.yml`
  * `tls-opts.yml`

---

### 📌 Compose File Standards & Gotchas

#### 1. Variable Handling & Block Placement

* Do NOT use `environment:` blocks in app-specific compose files. All environment variables are set via env files (`.env`), referenced with `env_file:` (both global and app-specific).

#### 2. Service Names

* Hardcode the service name in the compose file (e.g., `nextcloud:`). Do NOT try to interpolate with `${APP_NAME}` or any variable for the service name.

#### 3. Named Volumes in App Files

* NEVER define the `volumes:` top-level section in an app-specific compose file. Just reference named volumes in the `volumes:` list—they are declared only in the global/root compose file.

#### 4. Docker Socket Bind Mount

* NEVER add a Docker socket bind mount (`/var/run/docker.sock`) to any container. All Docker API access must use the Socket-Proxy over the `internal` network.

#### 5. Config File Bind Mounts

* If an app requires a config file, always add a bind mount for it. Do NOT bind a config directory unless the app actually requires a directory. Make sure the config file exists before starting the container.

#### 6. Healthcheck Block

* Always use your default healthcheck test command (from your reference files). Only change the healthcheck command if required by that container. Always use variables for intervals, timeouts, retries, etc.—never hardcode.

#### 7. Entrypoint/Command

* Only add `command:` or `entrypoint:` if the container specifically requires it. If not needed, omit it from the compose file.

#### 8. Security and Restart Options

* Always include `security_opt`, `privileged`, `restart`, and `depends_on` blocks in every service, using your preferred order.

#### 9. Named Volumes vs. Bind Mounts

* If both a named volume and a bind mount are used for a path, include BOTH in the `volumes:` list. Follow your convention exactly for persistent data or migration.

#### 10. Traefik, Kuma, and Portainer Labels

* Always provide complete, production-grade Traefik labels, Kuma monitor labels, Portainer labels, and your custom label block as shown in your templates. Chain/order and label names matter—copy your block exactly.

#### 11. Port Mapping

* ONLY specify ports in the Traefik compose file. No other app compose files should have a `ports:` section.

#### 12. Capabilities & AppArmor

* Include `cap_add` and AppArmor security options in the compose file if the container requires them. If not needed, omit them.

#### 13. Extra Hosts

* Include `extra_hosts:` ONLY if specifically required by that container.

#### 14. Service Dependencies

* Always include all actual dependencies in the `depends_on:` block. Use `condition: service_healthy` for each dependency.

#### 15. Custom Label Shortening

* Always include the custom label with comment (e.g., `## Custom Labels` then `- "${LABEL_DOMAIN}=${APP_NAME}"`) at the top of the label block.

#### 16. Secrets

* Handle secrets on a per-file basis, depending on whether the app requires them or not. Include or comment out only as needed.

---

Now that this is captured in a markdown-style document, you can use this as your persistent "You already know this" cheat sheet.

Just say the word — "I'm working on the NVR Server" — and we'll pick up exactly where you left off 😎
