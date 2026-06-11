````md id="userdoc1"
# USER DOCUMENTATION

## 1. Overview

This project is a Docker-based infrastructure that deploys a web stack composed of:

- NGINX (web server with HTTPS access)
- WordPress (website and administration panel)
- MariaDB (database for WordPress)

All services run inside Docker containers and communicate through a private internal network.

---

## 2. What This Stack Provides

- A working WordPress website
- Secure HTTPS access
- WordPress admin dashboard
- Persistent database storage (data is not lost on restart)

---

## 3. How to Start the Project

From the root of the project:

```bash
make up
````

This command will:

* Build all Docker images
* Create and configure containers
* Start the full infrastructure

---

## 4. How to Stop the Project

Stop all running containers:

```bash id="stop1"
make down
```

Remove containers:

```bash id="stop2"
make clean
```

Full cleanup (containers + volumes):

```bash id="stop3"
make fclean
```

---

## 5. Access the Website

Once the project is running:

* Website:

```id="url1"
https://localhost
```

* WordPress Admin Panel:

```id="url2"
https://localhost/wp-admin
```

---

## 6. Credentials

All credentials are stored securely:

* `.env` file:

  * Database name
  * Database user
  * Database password

* `/secrets` directory (if used):

  * Sensitive credentials (admin password, etc.)

⚠️ These files must NOT be pushed to Git.

---

## 7. Check if Services Are Running

To check running containers:

```bash id="check1"
docker ps
```

Or using Makefile:

```bash id="check2"
make ps
```

To view logs:

```bash id="logs1"
make logs
```

---

## 8. Data Persistence

Data is stored using Docker volumes:

* MariaDB data is persisted in a volume
* WordPress files (uploads/themes/plugins) are persisted

This ensures data is not lost when containers stop or restart.

