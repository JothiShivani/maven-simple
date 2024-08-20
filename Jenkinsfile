// pipeline{
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 // Checkout code from version control
//                 git 'https://github.com/JothiShivani/maven-simple.git'
//             }
//         }
//         stage('Clean') {
//             steps {
//                 // Clean the project
//                 bat 'mvn clean'
//             }
//         }
//         stage('Compile') {
//             steps {
//                 // Compile the source code
//                 bat 'mvn compile'
//             }
//         }
//         stage('Test') {
//             steps {
//                 // Run tests
//                 bat 'mvn test'
//             }
//         }
//         stage('Package') {
//             steps {
//                 // Package the application
//                 bat 'mvn package'
//             }
//         }
//         stage('Install') {
//             steps {
//                 // Install the package into the local Maven repository
//                 bat 'mvn verify'
//                 bat 'mvn install'
//             }
//         }

        
//     }


//     post {
//         success {
//             // Actions to take if the pipeline succeeds
//             echo 'Pipeline completed successfully!'
//         }
//         failure {
//             // Actions to take if the pipeline fails
//             echo 'Pipeline failed!'
//         }
//     }
// }

pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your version control system
                git 'https://github.com/JothiShivani/maven-simple.git'
            }
        }
        
        stage('Build Maven Project') {
            steps {
                // Run the Maven build
                bat 'mvn clean install'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    def image = docker.build("${env.DOCKER_HUB_CREDENTIALS_USR}/hello-app:latest")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        def image = docker.build("${env.DOCKER_HUB_CREDENTIALS_USR}/hello-app:latest")
                        image.push()
                    }
                }
            }
        }
    }
}
