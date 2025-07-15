# Traefik Middleware & Chain Reference

All dynamic config is stored in `/compose/traefik/dynamic/`

## Chain Files (`chain-*.yml`)

- `chain-authelia.yml`
- `chain-basic-auth.yml`
- `chain-compreface-authelia-noauth.yml`
- `chain-compreface-bypass.yml`
- `chain-frigate-auth.yml`
- `chain-gotify-authelia-noauth.yml`
- `chain-gotify-bypass.yml`
- `chain-hass-bypass.yml`
- `chain-no-auth.yml`

## Middleware Files (`middlewares-*.yml`)

- `middlewares-authelia.yml`: Authelia authentication
- `middlewares-basic-auth.yml`: Basic auth for restricted access
- `middlewares-compreface-authelia-noauth.yml`: Compreface hybrid auth
- `middlewares-cors-headers.yml`: CORS headers for APIs
- `middlewares-frigate-auth.yml`: Frigate-specific auth
- `middlewares-gotify-authelia-noauth.yml`: Gotify hybrid auth
- `middlewares-hass-bypass.yml`: Home Assistant auth bypass
- `middlewares-internal-only.yml`: Restricts access to internal subnet only
- `middlewares-rate-limit.yml`: Global rate limiting
- `middlewares-secure-headers.yml`: Enforces HTTPS/security headers

## TLS Options File

- `tls-opts.yml`: Enforces TLS 1.2+, strict ciphers, SNI

---

### Design & Usage Policy

- Middleware is defined centrally, not per-app.
- Chains combine middleware for reuse on routers.
- App services only *reference* chain names in their labels—do not redefine logic.
