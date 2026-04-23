# Spring Boot JPA Application with Docker & Jenkins CI/CD

A containerized Spring Boot JPA application with MySQL database, orchestrated using Docker Compose and automated with Jenkins CI/CD pipeline.

## Architecture Diagram
<img width="649" height="423" alt="image" src="https://github.com/user-attachments/assets/8312eab0-5e03-44fa-9f4f-7f70e6c3deb5" />

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Local Development](#local-development)


---

## 🏗️ Project Overview

This project demonstrates a simple DevOps workflow for a Spring Boot application:
- **Application**: Spring Boot 2.5.2 with JPA and MySQL
- **Containerization**: Docker with multi-stage optimization
- **Orchestration**: Docker Compose for multi-container deployment
- **CI/CD**: Jenkins pipeline for automated build and deployment
- **Database**: MySQL for persistent storage

---
## Prerequisites

Ensure you have the following installed before running the application:

| Tool | Version |
|------|---------|
| Java JDK | 11+ | 
| Maven | 3.9+ |
| Docker | 20.10+ | 
| Docker Compose | 2.0+ |
| Jenkins | 2.400+ |

### Required Jenkins Plugins
- Git Plugin
- Maven Integration Plugin
- Docker Plugin
- Pipeline Plugin

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
