# Spring Boot JPA Application with Docker & Jenkins CI/CD

A containerized Spring Boot JPA application with MySQL database, orchestrated using Docker Compose and automated with Jenkins CI/CD pipeline.

## Architecture Diagram
<img width="649" height="423" alt="image" src="https://github.com/user-attachments/assets/8312eab0-5e03-44fa-9f4f-7f70e6c3deb5" />

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Local Development](#local-development)
- [Jenkins CI/CD Setup & Pipeline](#jenkins-cicd-setup--pipeline)
-  [Application API Endpoints](#application-api-endpoints)
- [Troubleshooting](#troubleshooting)
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
---

## ⚙️ Jenkins CI/CD Setup & Pipeline

This section explains how to configure Jenkins and run the CI/CD pipeline for the Spring Boot application.


#### 🚀 1. Access Jenkins

Open Jenkins in your browser:

http://<your-server-ip>:8080

Example:
- EC2 Public IP or local VM IP

---

#### 🔌 2. Install Required Plugins

Ensure the following plugins are installed:

- Git Plugin  
- Maven Integration Plugin  
- Docker Plugin  
- Pipeline Plugin  

---

#### 🛠️ 3. Configure Jenkins Tools

Go to:

Manage Jenkins → Tools

Configure:

- JDK (Java 11+)  
- Maven (3.9+)  

---

#### 📦 4. Create Pipeline Job

- Go to Jenkins Dashboard  
- Click New Item  
- Enter name: `spring_app`  
- Select Pipeline  
- Click OK  

---

#### 🔗 5. Configure GitHub Repository

**In General:**
- Enable GitHub project  
- Add repository URL:  
https://github.com/munnavuyyuru/spring-boot-jpa-app.git  

**In Build Triggers:**
- Enable:
  - GitHub hook trigger for GITScm polling ✅  

---

#### 🔐 6. Configure Credentials in Jenkins

**Docker Hub Credentials**

Go to:

Manage Jenkins → Credentials → Global

Add credentials:

- ID: `dockerhubCred`  
- Username: `<your-dockerhub-username>`  
- Password: `<your-dockerhub-personal-access-token>`  

---

#### 🔗 7. Configure GitHub Webhook

In your GitHub repository:

- Go to Settings → Webhooks → Add Webhook  

Payload URL:
`http://<your-ec2-ip>:8080/github-webhook/`

Content Type:
`application/json`

Events:
- Just the push event (recommended)
- (or “Send me everything” if needed)

Click Add webhook

Note:
- If you are not using HTTPS, select the non-SSL option.

---

#### 🔄 8. Jenkins Pipeline Execution

Pipeline stages:

```groovy
1. Code Checkout       → Clone repository from GitHub  
2. Build Jar           → Maven clean package  
3. Build Docker Image  → Create Docker image  
4. Run Containers      → Deploy using docker compose  
5. Push to Docker Hub  → Push latest image
```

Pipeline script is defined in the Jenkinsfile.

---

#### ▶️ 9. Trigger the Pipeline

Automatic Trigger (Recommended):
- Push code to GitHub → Jenkins runs automatically via webhook  

Manual Trigger:
- Open Jenkins Dashboard  
- Select `spring_app` job  
- Click Build Now  

---

## 📊 10. Pipeline Execution Output
---
### Jenkins Pipeline View
<img width="970" height="385" alt="jenkins pipeline" src="https://github.com/user-attachments/assets/56b44b9e-7cab-4214-836e-dc41c708882a" />

---

### Docker Hub Image Repository
<img width="1318" height="516" alt="dockerhub" src="https://github.com/user-attachments/assets/11f8fd58-b07b-4540-9bd0-c726c3d047d3" />

---

### Running Containers (docker ps)
<img width="1040" height="130" alt="image" src="https://github.com/user-attachments/assets/11bcc2e9-209b-4af7-999d-8043375b42f5" />

---

#### ✅ Final Outcome

- Code pushed to GitHub  
- Jenkins automatically builds the application  
- Docker image created and pushed to Docker Hub  
- Containers deployed successfully using Docker Compose

## 🌐 Application API Endpoints

After successful deployment, the Spring Boot application exposes the following REST APIs.

```groovy
🔗 Base URL
http://<ec2-ip>:8080/spring-boot-jenkins

📥 Add Student
POST /addStudent

Full URL:
http://<ec2-ip>:8080/spring-boot-jenkins/addStudent

Description:
- Adds a new student record into the database.

📄 Get All Students
GET /findAllStudent

Full URL:
http://<ec2-ip>:8080/spring-boot-jenkins/findAllStudent

Description:
- Retrieves all student records from the database.

 🔍 Get Student By ID
GET /findById/{id}

Example URL:
http://<ec2-ip>:8080/spring-boot-jenkins/findById/1

Description:
- Fetches a specific student record using its ID.
```

## ⚠️ Troubleshooting

```groovy
### Jenkins build fails
- Check Maven installation
- Verify JDK configuration

### Docker container not starting
- Check port conflicts
- Run `docker logs <container-id>`

### Webhook not triggering
- Verify GitHub webhook URL
- Check Jenkins public accessibility
```
