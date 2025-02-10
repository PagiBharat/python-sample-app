pipeline {
    agent any

    environment {
        REPO_URL = 'git@github.com:PagiBharat/python-sample-app.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: "${REPO_URL}"
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    sh 'docker-compose up --build -d'
                }
            }
        }
    }

    triggers {
        cron('H 14 * * *')
    }

    post {
        always {
            script {
                // Ensure Jenkins pulls the latest changes from the GitHub repository before deployment
                sh 'git pull origin main'
            }
        }
    }
}
