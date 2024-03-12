pipeline {
    agent any
    tools {
        maven 'MAVEN'
        jdk 'JDK'
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
                bat 'docker build -t maven-project .'
            }
        }

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub using credentials
                withCredentials([usernamePassword(credentialsId: 'test', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    bat "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
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