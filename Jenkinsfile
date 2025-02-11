pipeline {
    agent any
    environment {
        REPO_URL = "git@github.com:PagiBharat/python-sample-app.git"
        APP_DIR = "/home/ubuntu/app"
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'ef31b9a9-64b5-49d9-8a79-e6f44d46b13d', url: "${REPO_URL}"
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh '''
                cd ${APP_DIR} || git clone ${REPO_URL} ${APP_DIR} && cd ${APP_DIR}
                git pull origin main
                sudo docker-compose down
                sudo docker-compose up -d --build
                '''
            }
        }
    }
}
