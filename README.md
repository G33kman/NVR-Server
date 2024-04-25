# Ubuntu-NVR-Server `PROJECT`

## TL;DR
  > This repository provides configuration files for setting up a robust and secure Network Video Recorder (NVR) server using an Ubuntu server and Docker containers with the following features Remote Access, Reverse Proxy, Object Detection using Tensor Cores, Automation Tasks and Secure SSH Access.

---

## Introduction
> This project aims to offer a self-hosted NVR solution with the following benefits:

* Reduced Maintenance: Leverages a headless Ubuntu server for low-maintenance operation.
* Machine Learning Integration: Integrates TensorFlow (Tensorrt) for facial and license plate recognition.
* Open-Source Alternative: Provides an open-source alternative to proprietary NVR systems.

---

## About the Project
  Traditional NVR systems can be expensive and closed-source.
  
  This project utilizes open-source software and Docker containers for a customizable and scalable NVR solution.

---

## Advantages to using Docker Containers:
  * **Streamlined Management**:
    - Each software component runs in its own container, simplifying management and reducing the risk of system-wide failures.
  * **Isolation**:
    - Applications are isolated from each other, enhancing security and stability.


## Project Features:
  * **Robust Security**:
    - Utilizes Authentik for Multi-Factor Authentication (MFA).
  * **Streamlined Management**:
    - Docker containers ensure isolated and manageable software components.
  * **Machine Learning Integration**:
    - Integrates TensorFlow for AI-powered features.
  * **IoT Device Integration**:
    - Offers potential integration with other "internet of things" (IoT) devices through Home Assistant and Mosquitto broker.
  * **Remote Access**:
    - Enables secure remote access for authorized users.
  * **Upgradable Storage**:
    - Designed for easy storage upgrades for futureproofing.

---

## Supported Technologies
  * [Ubuntu Server](https://ubuntu.com/server) (Headless Server Operating System)
  * [Docker Containers](https://www.docker.com/) (Container Software)
  * [Portainer](https://www.portainer.io/) (Container Management)
  * [Authentik](https://goauthentik.io/) (Multi-Factor Authentication)
  * [Traefik](https://traefik.io/) (Reverse Proxy)
  * [Home Assistant](https://www.home-assistant.io/) (Automation Software)
  * [Mosquitto](https://mosquitto.org/) (MQTT Broker)
  * [TensorFlow](https://www.tensorflow.org/) (Machine Learning Software)
  * [TensorRT](https://github.com/tensorflow/tensorrt) (AI Object Detection Utilizing Tensor Cores)
  * [Frigate NVR](https://frigate.video/) (Security Camera Recording Software)

---

  ## Documentation:
  * [Ubuntu Server Documentation](https://ubuntu.com/server/docs)
  * [Docker Documentation](https://doc.traefik.io/traefik/)
  * [Traefik Documentation](https://doc.traefik.io/traefik/)
  * [Authentik Documentation](https://docs.goauthentik.io/docs/)
  * [Portainer Documentation](https://docs.portainer.io/)
  * [Home Assistant Documentation](https://www.home-assistant.io/docs/)
  * [Mosquitto Documentation](https://mosquitto.org/documentation/)
  * [TensorFlow Documentation](https://www.tensorflow.org/api_docs)
  * [Frigate Documentation](https://docs.frigate.video/)

---

## Contributions
  While I don't want direct modifications to the core files, I highly encourage contributions in the following ways:

  Forking: Feel free to fork this project for your own use and modifications.
  Feedback and Issues: Raise issues or provide feedback on potential improvements through GitHub.

---

## Conclusion
  Thank you for your interest in this Ubuntu-NVR-Server project! I welcome constructive feedback to improve this project further.

---

## License
  This project is licensed under the [MIT License](https://opensource.org/licenses/MIT "Link to the Open Source MIT License Information"). See the [LICENSE](/LICENSE) file for details.