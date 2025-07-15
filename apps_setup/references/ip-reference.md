# Reserved IP Reference

## Network Subnets

| Network    | Subnet Range  | Description                               |
| ---------- | ------------- | ----------------------------------------- |
| internal   | 10.2.0.0/24   | Docker socket access only                 |
| private    | 10.2.1.0/24   | Backend communication (Traefik, APIs, etc)|
| public     | 10.2.2.0/24   | User-facing services                      |

---

## Container IP Allocation Table

| Container      | Internal IP | Private IP | Public IP  |
| -------------- | ----------- | ---------- | ---------- |
| traefik        | 10.2.0.2    | 10.2.1.2   | 10.2.2.2   |
| portainer      | 10.2.0.3    | 10.2.1.3   | 10.2.2.3   |
| postgresql     | —           | 10.2.1.4   | —          |
| dt             | —           | 10.2.1.5   | 10.2.2.5   |
| kuma           | 10.2.0.6    | 10.2.1.6   | 10.2.2.6   |
| homepage       | 10.2.0.7    | 10.2.1.7   | 10.2.2.7   |
| pgadmin        | —           | 10.2.1.8   | 10.2.2.8   |
| hass           | —           | 10.2.1.9   | 10.2.2.9   |
| beszel         | —           | 10.2.1.10  | 10.2.2.10  |
| beszel-agent   | 10.2.0.11   | —          | —          |
| vaultwarden    |             | 10.2.1.12  | 10.2.2.12  |
| insightface    | —           | 10.2.1.13  | 10.2.2.13  |
| loki           | —           | 10.2.1.14  | —          |
| mqtt           | —           | 10.2.1.15  | —          |
| frigate        | —           | 10.2.1.16  | 10.2.2.16  |
| node           | —           | 10.2.1.17  | —          |
| gotify         | —           | 10.2.1.18  | 10.2.2.18  |
| alloy          | —           | 10.2.1.19  | 10.2.2.19  |
| authelia       | —           | 10.2.1.253 | 10.2.2.253 |
| socket-proxy   | 10.2.0.254  | —          | —          |

---

- All IPs declared per container in `.env` files as `IP_INTERNAL`, `IP_PRIVATE`, `IP_PUBLIC`
- Predictability and network-level segmentation is enforced.
- Leave unused network slots as blank (`—`).
