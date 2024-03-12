pipeline {
    agent any
    tools {
        maven 'MAVEN'
        jdk 'JDK'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('4f77f113-9f49-46ef-95e5-3bcf16b6c1d5')
    }
    stages {
        stage('Checkout') {
            steps {
                // Check out the code from your version control system
                git 'https://github.com/NhatPhucNguyen/maven-project.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                // Run Maven build
                bat 'mvn clean install'
            }
        }

        stage('Code Coverage') {
            steps {
                // Add code coverage using Jacoco
                bat 'mvn jacoco:report'
            }
        }

        stage('Docker Build') {
            steps {
                // Build Docker image
                bat 'docker build -t phucnhat2111/maven-project .'
            }
        }

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub using credentials
                withCredentials([usernamePassword(credentialsId: '4f77f113-9f49-46ef-95e5-3bcf16b6c1d5', passwordVariable: 'DOCKERHUB_CREDENTIALS_PASSWORD', usernameVariable: 'DOCKERHUB_CREDENTIALS_USERNAME')]) {
                    bat """ docker login --username ${DOCKERHUB_CREDENTIALS_USERNAME} --password ${DOCKERHUB_CREDENTIALS_PASSWORD} """
                }
            }
        }

        stage('Docker Push') {
            steps {
                // Push Docker image to Docker Hub
                bat 'docker push phucnhat2111/maven-project'
            }
        }
    }
}