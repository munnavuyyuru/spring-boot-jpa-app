FROM eclipse-temurin:11-jre-alpine

WORKDIR /opt/app

COPY target/spring-boot-jpa-docker-jenkins-pipeline.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
