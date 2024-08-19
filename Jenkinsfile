pipeline{
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from version control
                git 'https://github.com/JothiShivani/maven-simple.git'
            }
        }
        stage('Clean') {
            steps {
                // Clean the project
                bat 'mvn clean'
            }
        }
        stage('Compile') {
            steps {
                // Compile the source code
                bat 'mvn compile'
            }
        }
        stage('Test') {
            steps {
                // Run tests
                bat 'mvn test'
            }
        }
        stage('Package') {
            steps {
                // Package the application
                bat 'mvn package'
            }
        }
        stage('Install') {
            steps {
                // Install the package into the local Maven repository
                sh 'mvn install'
            }
        }

        
    }


    post {
        success {
            // Actions to take if the pipeline succeeds
            echo 'Pipeline completed successfully!'
        }
        failure {
            // Actions to take if the pipeline fails
            echo 'Pipeline failed!'
        }
    }
}
