FROM maven:latest AS builder
WORKDIR /temp
COPY pom.xml .
COPY src ./src
RUN mvn clean install

FROM openjdk:21-slim
EXPOSE 8081
WORKDIR /temp
COPY --from=builder /temp/target/*.jar helloApp.jar
ENTRYPOINT ["java", "-jar","helloApp.jar"]


# pipeline {
#     agent any
    
#     environment {
#         DOCKER_IMAGE= "my-maven-app"
#         DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
#     }

#     stages {
#         stage('Checkout') {
#             steps {
#                 // Checkout the code from your version control system
#                 git 'https://github.com/JothiShivani/maven-simple.git'
#             }
#         }
        
#         stage('Build Maven Project') {
#             steps {
#                 // Run the Maven build
#                 bat 'mvn clean install'
#             }
#         }
        
#         stage('Build Docker Image') {
#             steps {
#                 script {
#                     // Build the Docker image using the Dockerfile
#                 //   --> //def image = docker.build("${env.DOCKER_HUB_CREDENTIALS_USR}/hello-app:latest")
#                     bat 'docker build -t %DOCKER_IMAGE% .'
#                 }
#             }
#         }
        
#         // stage('Push Docker Image') {
#         //     steps {
#         //         script {
#         //             docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
#         //                 def image = docker.build("${env.DOCKER_HUB_CREDENTIALS_USR}/hello-app:latest")
#         //                 image.push()
#         //             }
#         //         }
#         //     }
#         // }
#         stage('Push Docker Image') {
#             steps {
#                 script{
#                     withDockerRegistry([url: "https://index.docker.io/v1/", credentialsId:DOCKER_HUB_CREDENTIALS ]){
#                         bat 'docker tag %DOCKER_IMAGE% jothishivani/%DOCKER_IMAGE%'
#                         bat 'docker push jothishivani/%DOCKER_IMAGE%'
#                     }
#                 }
#             }
#         }
#     }
# }