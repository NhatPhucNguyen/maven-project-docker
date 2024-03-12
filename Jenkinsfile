pipeline {
    agent any
    tools {
        maven 'MAVEN'
        jdk 'JDK'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('ea053cf7-3e47-4233-b6cb-289b6a93e8f0')
    }
    stages {
        stage('Checkout') {
            steps {
                // Check out the code from your version control system
                git branch: 'main',url: 'https://github.com/NhatPhucNguyen/maven-project-docker.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                // Run Maven build
                bat 'mvn clean package'
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
                withCredentials([usernamePassword(credentialsId: 'ea053cf7-3e47-4233-b6cb-289b6a93e8f0', passwordVariable: 'DOCKERHUB_CREDENTIALS_PASSWORD', usernameVariable: 'DOCKERHUB_CREDENTIALS_USERNAME')]) {
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