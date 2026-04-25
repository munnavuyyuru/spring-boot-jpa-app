pipeline {
    agent {label "agent-bhargav" }
    
    tools {
     jdk 'jdk11'
     maven 'Maven-3.9'
    }

    stages {
        stage('code checkout') {
            steps {
                echo 'this is clonig the code from github'
                git branch: 'main', url: 'https://github.com/munnavuyyuru/spring-boot-jpa-app.git'
            }
        }
        
        stage('Build Jar') {
            steps {
                echo "this is building the jar files"
                sh "mvn clean package -DskipTests"
            }
        }
        
         stage('Build Docker Image') {
            steps {
                echo "this is Containering the app"
                sh "docker build -t spring_app ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "DockerHubCred",
                    usernameVariable: "dockerHubUser",
                    passwordVariable: "dockerHubPass"
                )]) {
                    sh "docker tag spring_app:latest ${dockerHubUser}/spring_app:latest"
                    sh "docker login -u ${dockerHubUser} -p ${dockerHubPass}"
                    sh "docker push ${dockerHubUser}/spring_app:latest"
                }
            }
        }
        
        stage('Run Containers ') {
            steps {
                echo "this is deploying the app"
                sh "docker compose up -d --build --remove-orphans"
            }
        }
        
    }
}
