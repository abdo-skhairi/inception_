````md id="devdoc1"
# DEVELOPER DOCUMENTATION

## 1. Overview

This project is a Docker-based infrastructure composed of:

- NGINX (reverse proxy with HTTPS)
- WordPress (PHP application)
- MariaDB (database server)

All services are managed using Docker Compose and run inside isolated containers connected through a private network.

---

## 2. Requirements

Before setting up the project, ensure the following are installed:

- Docker
- Docker Compose
- Make
- Linux environment (recommended by 42 Inception subject)

---

## 3. Project Setup (From Scratch)

Clone the repository:

```bash
git clone <repository_url>
cd inception
````

---

## 4. Environment Configuration

Create a `.env` file at the root of the project containing:

* Database name
* Database user
* Database password
* Any required environment variables for services

---

## 5. Secrets (if used)

If the project uses sensitive data:

```bash id="sec1"
mkdir secrets
```

This directory stores credentials such as admin passwords.

⚠️ Must NOT be committed to Git.

---

## 6. Build and Run

To build and start the full stack:

```bash id="run1"
make up
```

Or manually:

```bash id="run2"
docker-compose -f srcs/docker-compose.yml up -d --build
```

---

## 7. Makefile Commands

```bash id="mk1"
make up       # Build and start containers
make down     # Stop containers
make clean    # Remove containers and network
make fclean   # Full cleanup including volumes
make logs     # Show container logs
make ps       # Show running containers
```

---

## 8. Volumes and Data Persistence

This project uses Docker volumes for persistence:

* MariaDB volume → stores database data permanently
* WordPress volume → stores website files and uploads

Data remains available even after container restart or rebuild.

---

## 9. Network Architecture

* Only NGINX is exposed externally (HTTPS port 443)
* WordPress and MariaDB are internal services only
* All communication happens inside a private Docker network

---

## 10. Notes

* Containers are isolated for security
* Database is never exposed to the host machine
* HTTPS is enforced via NGINX
