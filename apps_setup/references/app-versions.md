# NVR Server - Running Apps Version Reference

| App Name       | Container Name | Image Repo              | Image Name        | Version Tag            | Notes                       |
| -------------- | -------------- | ----------------------- | ----------------- | ---------------------- | --------------------------- |
| Authelia       | authelia       | authelia                | authelia          | 4.39.4                 | Authentication System       |
| Beszel         | beszel         | henrygd                 | beszel            | 0.11.1                 | Metrics Visualization       |
| Beszel Agent   | beszel-agent   | henrygd                 | beszel            | 0.11.1                 | Metrics Scraper             |
| Compreface     | compreface     | exadel                  | compreface        | 1.2.0-arcface-r100-gpu | Face Recognition Service    |
| Double-Take    | dt             | skrashevich             | double-take       | sha-0227b0c            | Face Detection Service      |
| Frigate NVR    | frigate        | ghcr.io/blakeblackshear | frigate           | 0.15.1                 | A.I. NVR System             |
| Gotify         | gotify         | gotify                  | server            | 2.6.3                  | Notificiation System        |
| Home Assistant | hass           | lscr.io/linuxserver     | homeassistant     | 2025.6.2               | Automation Platform         |
| Uptime-Kuma    | kuma           | louislam                | uptime-kuma       | 2.0.0-beta.3           | Container Uptime Monitoring |
| MQTT Broker    | mqtt           | (N/A)                   | eclipse-mosquitto | 2.0.21                 | Device Messaging System     |
| pgAdmin        | pgadmin        | dpage                   | pgadmin4          | 9.4.0                  | Database Web UI             |
| Portainer-CE   | portainer      | portainer               | portainer-ce      | 2.30.1-alpine          | Container Management        |
| PostgreSQL     | postgresql     | (N/A)                   | postgres          | 17.5                   | Database Server             |
| Socket-Proxy   | socket         | wollomatic              | socket-proxy      | 1                      | Docker Socket Protection    |
| Traefik        | traefik        | (N/A)                   | traefik           | 3.4.1                  | Contaneer Reverse-Proxy     |
| Vaultwarden    | vault          | vaultwarden             | server            | 1.34.1                 | Password Manager            |