````md
*This project has been created as part of the 42 curriculum by sabderra.*

# Inception

## Description

Inception is a System Administration project from the 42 curriculum that introduces containerization using Docker and Docker Compose.

The goal of the project is to build a secure and modular web infrastructure composed of multiple services running in isolated containers. The infrastructure is deployed using Docker Compose and follows the principle of one service per container.

The mandatory part includes:
- NGINX with TLS/SSL support
- WordPress with PHP-FPM
- MariaDB
- Docker Volumes for persistent storage
- Docker Networks for service communication

The project focuses on containerization, networking, data persistence, security, and service orchestration.

---

# Project Description

This project is based on Docker to virtualize and isolate multiple services inside containers. Each service runs independently and communicates through a Docker network.

## Docker Usage in this Project
Docker is used to:
- Create isolated environments for each service
- Ensure reproducibility of the infrastructure
- Simplify deployment and management
- Separate concerns between web server, application, and database

## Main Design Choices

### One Service per Container
Each container has a single responsibility:
- NGINX → Web server and TLS termination
- WordPress → Application logic (CMS)
- MariaDB → Database storage

This improves modularity, debugging, and scalability.

---

### Virtual Machines vs Docker
- Virtual Machines run full operating systems and are heavy in resources.
- Docker containers share the host system kernel and are lightweight.
- Docker is faster, more efficient, and easier to deploy.

---

### Secrets vs Environment Variables
- Environment variables are simple to use but less secure if exposed.
- Secrets are designed to securely store sensitive data.
- This project uses environment variables as required by the subject.

---

### Docker Network vs Host Network
- Host network gives containers direct access to the host network but reduces isolation.
- Docker network provides secure isolated communication between containers.
- This project uses a dedicated Docker network for security and service discovery.

---

### Docker Volumes vs Bind Mounts
- Bind mounts depend on host file system structure.
- Docker volumes are managed by Docker and are more portable and reliable.
- This project uses Docker volumes for persistent data storage.

---

# Request Flow

Browser → NGINX → PHP-FPM → WordPress → MariaDB

1. User connects via HTTPS.
2. NGINX receives the request on port 443.
3. NGINX forwards PHP requests to PHP-FPM.
4. PHP-FPM executes WordPress code.
5. WordPress queries MariaDB.
6. MariaDB returns data.
7. PHP-FPM generates the response.
8. NGINX sends the final page to the browser.

---

# Services Overview

## NGINX
- Handles HTTPS (TLS encryption)
- Acts as reverse proxy
- Forwards requests to PHP-FPM

## WordPress
- CMS for managing website content
- Generates dynamic pages
- Communicates with database

## PHP-FPM
- Executes PHP code
- Processes WordPress logic
- Returns generated content to NGINX

## MariaDB
- Stores all website data
- Users, posts, pages, comments
- Provides SQL database service

---

# Docker in this Project

Docker is used to containerize each service.

Key concepts:
- One service per container
- Communication through Docker network
- Reproducible and isolated environment
- Easy deployment and management

---

# Persistence

Persistence is ensured using Docker volumes.

Stored data:
- WordPress files
- MariaDB database

Verification:
1. Create content in WordPress
2. Restart containers
3. Reboot system
4. Relaunch infrastructure
5. Data must still be present

---

# Instructions

## Requirements
- Docker
- Docker Compose
- Linux environment

## Build and Run

```bash
make
````

or

```bash
docker compose -f srcs/docker-compose.yml up --build
```

## Stop Services

```bash
docker compose -f srcs/docker-compose.yml down
```

## Remove Everything (including volumes)

```bash
docker compose -f srcs/docker-compose.yml down -v
```

---

# Useful Commands

## Containers

```bash
docker ps
```

## Images

```bash
docker images
```

## Volumes

```bash
docker volume ls
```

## Networks

```bash
docker network ls
```

## Logs

```bash
docker logs <container_name>
```

## Access Container

```bash
docker exec -it <container_name> sh
```

---

# Resources

## Official Documentation

* [https://docs.docker.com/reference/cli/docker/](https://docs.docker.com/reference/cli/docker/)
* [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
* [https://nginx.org/en/docs/](https://nginx.org/en/docs/)
* [https://wordpress.org/documentation/](https://wordpress.org/documentation/)
* [https://mariadb.org/documentation/](https://mariadb.org/documentation/)

## Tutorials / Guides

* [https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)

## AI Usage

Artificial intelligence tools were used as a learning assistant during the development of this project.

AI was used for:

* Understanding Docker and Docker Compose concepts
* Structuring and simplifying explanations
* Helping write and improve documentation clarity

```
```
