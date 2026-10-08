pipeline {

    agent any

    environment {
        IMAGE_NAME = "ghcr.io/tanu674/devops-cloud-project:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                    echo "===== BUILDING DOCKER IMAGE ====="

                    docker build -t devops-cloud-project:latest .
                '''
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                    export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                    echo "===== TAGGING IMAGE FOR GHCR ====="

                    docker tag devops-cloud-project:latest \
                    ghcr.io/tanu674/devops-cloud-project:latest
                '''
            }
        }

        stage('Login to GHCR') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'GitHub GHCR Credentials',
                        usernameVariable: 'GHCR_USERNAME',
                        passwordVariable: 'GHCR_TOKEN'
                    )
                ]) {
                    sh '''
                        export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                        echo "===== LOGGING IN TO GHCR ====="

                        echo "$GHCR_TOKEN" | docker login ghcr.io \
                            -u "$GHCR_USERNAME" \
                            --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                    echo "===== PUSHING IMAGE TO GHCR ====="

                    docker push ghcr.io/tanu674/devops-cloud-project:latest
                '''
            }
        }
    }

    post {
        success {
            echo '===== JENKINS BUILD SUCCESSFUL ====='
        }

        failure {
            echo '===== JENKINS BUILD FAILED ====='
        }
    }
}