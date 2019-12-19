pipeline {
    agent {
        label 'docker'
    }
    
    environment {
        SOURCE_REPO = 'https://github.com/MaksGrishaev/devpro-hw4.git'
        ECR_URL = '391941030095.dkr.ecr.us-east-1.amazonaws.com/'
        ECR_USER = 'ecr:us-east-1:jenkins'
        IMAGE_NAME = "${ECR_URL}hw4-jenkins-nodejs:latest"
        CONTAINER_NAME = 'HW_4'
        EMAIL = 'gm.grishaev@gmail.com'
    }
    
    tools {
        nodejs "NodeJS"
    }
    
    stages {
        stage('Checkout from GitHub') {
            steps {
                git "${SOURCE_REPO}"
            }
        }

        stage('Build image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
//        stage('Push image') {
//            steps {
//                script {
//                    docker.withRegistry('https://${IMAGE_NAME}', '${ECR_USER}') {
//                        sh "docker push ${IMAGE_NAME}"
//                    }
//                }
//            }
//        }
        stage('Docker rm') {
            steps {
                script {
                    try {
                        sh "docker rm -f ${CONTAINER_NAME}"       
                    }
                    catch (Exception e) { 
                    }
                }
            }
        }
        stage('Docker run'){
            
            steps{
                sh "docker run -d --name ${CONTAINER_NAME} -p 5000:5000 ${IMAGE_NAME}"
            }
        }
    }
    
    post {
        failure {
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
            recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
            subject: "Jenkins - UNSUCCESSFULL Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
            to: "${EMAIL}"
        }
        changed {
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
            recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
            subject: "Jenkins - SUCCESSFULL Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
            to: "${EMAIL}"
        }   
    }
}
