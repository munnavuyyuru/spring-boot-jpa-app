# Spring Boot JPA Application with Docker & Jenkins CI/CD

A containerized Spring Boot JPA application with MySQL database, orchestrated using Docker Compose and automated with Jenkins CI/CD pipeline.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Architecture Diagram](#architecture-diagram)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Local Development](#local-development)
- [Docker Build & Deployment](#docker-build--deployment)
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)
- [Environment Variables](#environment-variables)
- [API Endpoints](#api-endpoints)
- [Troubleshooting](#troubleshooting)

---

## 🏗️ Project Overview

This project demonstrates a complete DevOps workflow for a Spring Boot application:
- **Application**: Spring Boot 2.5.2 with JPA and MySQL
- **Containerization**: Docker with multi-stage optimization
- **Orchestration**: Docker Compose for multi-container deployment
- **CI/CD**: Jenkins pipeline for automated build and deployment
- **Database**: MySQL 8.0 with persistent storage

### Tech Stack

| Component | Technology |
|-----------|-----------|
| Framework | Spring Boot 2.5.2 |
| Language | Java 11 (Eclipse Temurin) |
| Database | MySQL 8.0 |
| ORM | Spring Data JPA |
| Container | Docker |
| Orchestration | Docker Compose |
| CI/CD | Jenkins |
| Build Tool | Maven 3.9 |

---

## 📊 Architecture Diagram

Below is the architecture diagram showing the complete flow from code to deployment:

```
┌─────────────────────────────────────────────────────────────────┐
│                         CI/CD PIPELINE                          │
│                                                                 │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐ │
│  │   Code   │───▶│  Build   │───▶│  Docker  │───▶│ Deploy   │ │
│  │  Checkout│    │   JAR    │    │   Image  │    │          │ │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘ │
│       │               │               │               │        │
│       ▼               ▼               ▼               ▼        │
│    GitHub          Maven          Docker         Docker       │
│                     │            Registry       Compose       │
│                     │               │               │         │
└─────────────────────┼───────────────┼───────────────┼─────────┘
                      │               │               │
                      ▼               ▼               ▼
                ┌──────────────────────────────────────────┐
                │           RUNTIME ENVIRONMENT            │
                │                                          │
                │  ┌─────────────────┐    ┌─────────────┐ │
                │  │   Spring Boot   │◀───│    MySQL    │ │
                │  │      App        │    │  Database   │ │
                │  │   (Port 8080)   │    │  (Port 3306)│ │
                │  └─────────────────┘    └─────────────┘ │
                │         │                      │         │
                │         └──────────────────────┘         │
                │              Internal Network            │
                └──────────────────────────────────────────┘
```

### 📍 Where to Attach Detailed Diagram Files

For detailed architecture diagrams, attach them in the following locations:

1. **High-Level Architecture**: `docs/architecture/high-level-architecture.png`
2. **CI/CD Pipeline Flow**: `docs/architecture/cicd-pipeline.png`
3. **Container Network Topology**: `docs/architecture/network-topology.png`
4. **Database Schema**: `docs/architecture/database-schema.png`

**Recommended Tools for Creating Diagrams:**
- Draw.io / diagrams.net
- Lucidchart
- Microsoft Visio
- PlantUML (for code-based diagrams)

**Diagram File Naming Convention:**
```
docs/
├── architecture/
│   ├── high-level-architecture.png
│   ├── cicd-pipeline.png
│   ├── network-topology.png
│   └── database-schema.png
```

---

## ✅ Prerequisites

Ensure you have the following installed before running the application:

| Tool | Version | Installation Link |
|------|---------|------------------|
| Java JDK | 11+ | [Adoptium](https://adoptium.net/) |
| Maven | 3.9+ | [Maven Download](https://maven.apache.org/download.cgi) |
| Docker | 20.10+ | [Docker Install](https://docs.docker.com/get-docker/) |
| Docker Compose | 2.0+ | Included with Docker Desktop |
| Jenkins | 2.400+ | [Jenkins Download](https://www.jenkins.io/download/) |

### Required Jenkins Plugins
- Git Plugin
- Maven Integration Plugin
- Docker Plugin
- Pipeline Plugin

---

## 📁 Project Structure

```
spring-boot-jpa-app/
├── src/                          # Source code
│   ├── main/
│   │   ├── java/                 # Java source files
│   │   └── resources/            # Application properties
│   └── test/                     # Test files
├── .mvn/                         # Maven wrapper
├── target/                       # Build output (generated)
├── docs/                         # Documentation & diagrams
│   └── architecture/             # Architecture diagrams
├── Dockerfile                    # Docker image configuration
├── docker-compose.yml            # Multi-container orchestration
├── Jenkinsfile                   # Jenkins pipeline definition
├── pom.xml                       # Maven dependencies
├── .dockerignore                 # Docker ignore rules
└── README.md                     # This file
```

---

## 💻 Local Development

### 1. Clone the Repository

```bash
git clone https://github.com/munnavuyyuru/spring-boot-jpa-app.git
cd spring-boot-jpa-app
```

### 2. Build the Application

```bash
./mvnw clean package -DskipTests
```

### 3. Run Locally (Without Docker)

```bash
# Ensure MySQL is running locally
java -jar target/spring-boot-jpa-docker-jenkins-pipeline.jar
```

---

## 🐳 Docker Build & Deployment

### Build Docker Image

The Docker image has been built successfully using the following command:

```bash
docker build -t spring_app .
```

**Dockerfile Details:**
- Base Image: `eclipse-temurin:11-jre-alpine` (lightweight Java runtime)
- Working Directory: `/opt/app`
- Application JAR: `target/spring-boot-jpa-docker-jenkins-pipeline.jar`
- Entry Point: `java -jar app.jar`

### Push to Docker Hub ✅

The Docker image has been successfully pushed to Docker Hub:

```bash
# Login to Docker Hub
docker login -u <your-dockerhub-username>

# Tag the image
docker tag spring_app <your-dockerhub-username>/spring_app:latest
docker tag spring_app <your-dockerhub-username>/spring_app:1.0.0

# Push to Docker Hub
docker push <your-dockerhub-username>/spring_app:latest
docker push <your-dockerhub-username>/spring_app:1.0.0
```

**Docker Hub Repository:** `<your-dockerhub-username>/spring_app`

Available tags:
- `latest` - Most recent build
- `1.0.0` - Versioned release

### Run with Docker Compose

Start all services (MySQL + Application):

```bash
docker compose up -d --build
```

**Services:**
| Service | Container Name | Port | Description |
|---------|---------------|------|-------------|
| MySQL | `yw_mysql` | 3306 | Database server |
| App | `spring_app` | 8080 | Spring Boot application |

### Verify Deployment

```bash
# Check running containers
docker compose ps

# View application logs
docker logs -f spring_app

# View MySQL logs
docker logs -f yw_mysql

# Access the application
curl http://localhost:8080
```

### Stop Services

```bash
docker compose down

# Remove volumes (caution: deletes data)
docker compose down -v
```

---

## 🔄 Jenkins CI/CD Pipeline

The Jenkins pipeline automates the entire build and deployment process.

### Pipeline Stages

```groovy
1. Code Checkout     → Clone repository from GitHub
2. Build Jar         → Maven clean package (skip tests)
3. Build Docker Image → Create Docker image
4. Run Containers    → Deploy with docker compose
```

### Jenkins Configuration

**Agent Label:** `agent-bhargav`

**Tools Configured:**
- JDK: `jdk11`
- Maven: `Maven-3.9`

**Pipeline Script:** See `Jenkinsfile`

### Manual Pipeline Trigger

1. Open Jenkins Dashboard
2. Select your pipeline job
3. Click "Build Now"
4. Monitor console output for each stage

### Pipeline Visualization

```
┌─────────────────────────────────────────────────────────┐
│                    JENKINS PIPELINE                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  [Checkout] ──▶ [Build JAR] ──▶ [Docker Build] ──▶ [Deploy]
│      │              │                  │                │
│      ▼              ▼                  ▼                ▼
│   GitHub        Maven              Docker          Docker
│   (main)      Package             Build           Compose
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🔧 Environment Variables

### Application Configuration

| Variable | Value | Description |
|----------|-------|-------------|
| `SPRING_DATASOURCE_URL` | `jdbc:mysql://mysql:3306/spring_boot_jpa_docker_jenkins_pipeline` | Database connection URL |
| `SPRING_DATASOURCE_USERNAME` | `root` | Database username |
| `SPRING_DATASOURCE_PASSWORD` | `root` | Database password |

### MySQL Configuration

| Variable | Value | Description |
|----------|-------|-------------|
| `MYSQL_ROOT_PASSWORD` | `root` | MySQL root password |
| `MYSQL_DATABASE` | `spring_boot_jpa_docker_jenkins_pipeline` | Initial database name |

---

## 🌐 API Endpoints

Once deployed, access the application at:

- **Base URL**: `http://localhost:8080`
- **Health Check**: `http://localhost:8080/actuator/health` (if actuator enabled)
- **API Documentation**: `http://localhost:8080/swagger-ui.html` (if Swagger enabled)

---

## 🔍 Troubleshooting

### Common Issues

#### 1. Application Won't Start
```bash
# Check container logs
docker logs spring_app

# Verify MySQL is healthy
docker inspect --format='{{.State.Health.Status}}' yw_mysql
```

#### 2. Database Connection Failed
```bash
# Ensure MySQL is running first
docker compose up mysql -d

# Wait for health check to pass
docker compose ps
```

#### 3. Port Already in Use
```bash
# Find process using port 8080
lsof -i :8080

# Change port in docker-compose.yml
ports:
  - "8081:8080"  # Use different host port
```

#### 4. Docker Build Fails
```bash
# Clean Maven build
./mvnw clean

# Rebuild JAR
./mvnw package -DskipTests

# Rebuild Docker image
docker build --no-cache -t spring_app .
```

### Useful Commands

```bash
# View all containers
docker ps -a

# Remove stopped containers
docker container prune

# Remove unused images
docker image prune

# Reset Docker Compose environment
docker compose down -v --remove-orphans
```

---

## 📝 License

This project is created for demonstration purposes.

---

## 👥 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📞 Support

For issues and questions:
- Create an issue on GitHub
- Check existing documentation in `docs/` folder

---

**Last Updated**: 2024
**Version**: 1.0.0
