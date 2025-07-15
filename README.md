# NVR-Server: Docker-Based AI-Powered NVR System

![NVR-Server Hero Image](assets/images/repo-hero-image.jpg)

Welcome to the **NVR-Server** project! This repository houses the Docker Compose configurations and associated files for a robust, AI-powered Network Video Recorder (NVR) system. Designed for self-hosting enthusiasts, this setup leverages Docker to create a scalable and manageable surveillance solution with advanced features like AI-based object detection and face recognition.

---

## 🌟 Features

* **AI-Powered Surveillance:** Integrates with Frigate NVR for real-time object detection and Double-Take/Compreface for advanced face detection and recognition.
* **Containerized Architecture:** All services run as Docker containers, ensuring isolation, portability, and easy management.
* **Centralized Configuration:** A structured approach to Docker Compose files and environment variables for consistent deployment.
* **Secure Networking:** Utilizes Traefik as a reverse proxy with defined internal, private, and public networks for secure communication and exposure.
* **Comprehensive Monitoring:** Includes Uptime-Kuma for service monitoring and Beszel for metrics visualization.
* **Authentication & Access Control:** Integrates with Authelia for robust authentication.
* **Persistent Data:** Clearly defined volume and secret management for data persistence and security.

---

## 🏗️ Project Structure

The core of this project resides in the `/compose` directory, which serves as the root for all Docker-related configurations.

```
/compose
├── compose.yml               # Global Docker Compose file (defines networks, volumes, secrets)
├── .env                      # Global environment variables
├── public/
│   ├── compose/              # Per-application Docker Compose files and environment variables
│   │   ├── <APP_NAME>/
│   │   │   ├── <APP_NAME>-compose.yml
│   │   │   └── <APP_NAME>.env
│   │   └── traefik/
│   │       ├── traefik-compose.yml
│   │       └── traefik.env
│   └── rules/                # Traefik dynamic configuration rules (middlewares, chains, TLS options)
│       ├── chain-authelia.yml
│       ├── middlewares-secure-headers.yml
│       └── tls-opts.yml
└── template-compose.yml      # Template for app-specific Docker Compose files
└── template.env              # Template for app-specific environment files
```

---

## 🚀 Getting Started

### Prerequisites

* Docker and Docker Compose installed on your Linux host.
* Basic understanding of Docker, Docker Compose, and networking concepts.
* (Optional but recommended) NVIDIA GPU with drivers for AI acceleration (Frigate, Compreface).
* (Optional) Coral TPU for enhanced AI inference.

### Installation

1.  **Clone this repository:**
    ```bash
    git clone [https://github.com/G33kman/NVR-Server.git](https://github.com/G33kman/NVR-Server.git)
    cd NVR-Server/compose
    ```
2.  **Configure Global Environment Variables:**
    * Edit the `.env` file in the `/compose` directory.
    * Populate the system identity, paths, device mounts, and network base IPs according to your environment. Refer to `global-env-reference.md` for details.
3.  **Configure Application-Specific Environment Variables:**
    * Navigate to `public/compose/<APP_NAME>/` for each application.
    * Edit the `<APP_NAME>.env` file, replacing placeholders with your specific values (e.g., image tags, internal directories, resource limits). Refer to `app-templates-reference.md` for template details.
4.  **Review Traefik Configuration:**
    * Ensure `traefik.env` and the dynamic rule files in `public/rules/` are configured to your needs, especially for domain names, TLS, and authentication chains. Refer to `traefik-middleware-reference.md` for details.
5.  **Deploy the Stack:**
    * From the `/compose` directory, run:
        ```bash
        docker compose up -d
        ```
    * This will bring up all defined services. You can monitor the deployment using `docker compose ps` or Uptime-Kuma once it's accessible.

---

## ⚙️ Core Components & Services

This NVR server stack includes a variety of applications, each serving a specific purpose:

| App Name         | Container Name | Version Tag            | Notes                                   |
| :--------------- | :------------- | :--------------------- | :-------------------------------------- |
| Authelia         | authelia       | 4.39.4                 | Authentication System                   |
| Beszel           | beszel         | 0.11.1                 | Metrics Visualization                   |
| Beszel Agent     | beszel-agent   | 0.11.1                 | Metrics Scraper                         |
| Compreface       | compreface     | 1.2.0-arcface-r100-gpu | Face Recognition Service                |
| Double-Take      | dt             | sha-0227b0c            | Face Detection Service                  |
| Frigate NVR      | frigate        | 0.15.1                 | A.I. NVR System                         |
| Gotify           | gotify         | 2.6.3                  | Notification System                     |
| Home Assistant   | hass           | 2025.6.2               | Automation Platform                     |
| Uptime-Kuma      | kuma           | 2.0.0-beta.3           | Container Uptime Monitoring             |
| MQTT Broker      | mqtt           | 2.0.21                 | Device Messaging System                 |
| pgAdmin          | pgadmin        | 9.4.0                  | Database Web UI                         |
| Portainer-CE     | portainer      | 2.30.1-alpine          | Container Management                    |
| PostgreSQL       | postgres       | 17.5                   | Database Server                         |
| Socket-Proxy     | socket         | 1                      | Docker Socket Protection                |
| Traefik          | traefik        | 3.4.1                  | Container Reverse-Proxy & Load Balancer |
| Vaultwarden      | vault          | 1.34.1                 | Password Manager                        |

*(For the most up-to-date versions, refer to `app-versions.md`)*

---

## 🌐 Networking

The Docker stack utilizes three distinct networks for robust segmentation and secure communication:

* **`internal` (10.2.0.0/24):** Dedicated for Docker socket access only, used by `socket-proxy`.
* **`private` (10.2.1.0/24):** For backend communication between services (e.g., databases, APIs, and Traefik routing).
* **`public` (10.2.2.0/24):** Exposes user-facing services via Traefik.

Each container is assigned specific IP addresses within these subnets for predictability and network-level segmentation. Refer to `ip-reference.md` for the detailed IP allocation table.

---

## 🔒 Security & Best Practices

This project adheres to several security and operational best practices:

* **No Direct Docker Socket Access:** All Docker API access is routed through `socket-proxy` over the `internal` network, preventing direct bind mounts of `/var/run/docker.sock`.
* **Centralized Secrets Management:** Secrets are defined globally in the main `compose.yml` and stored as files under `${DIR_SECRETS}/<APP_NAME>/`, referenced by individual app configurations.
* **Read-Only Containers:** Most containers are configured with `read_only: true` where possible to enhance security.
* **Healthchecks:** Robust healthcheck configurations ensure services are running and responsive before being considered "healthy."
* **Traefik Middlewares:** Extensive use of Traefik middlewares for secure headers, rate limiting, and authentication enforcement.
* **Resource Limits:** Docker `deploy` configurations include CPU and memory limits to prevent resource exhaustion.

---

## 🤝 Contributing

Contributions are welcome! If you have suggestions for improvements, new features, or bug fixes, please feel free to:

1.  Fork the repository.
2.  Create a new branch (`git checkout -b feature/your-feature`).
3.  Make your changes.
4.  Commit your changes (`git commit -m 'Add new feature'`).
5.  Push to the branch (`git push origin feature/your-feature`).
6.  Open a Pull Request.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).