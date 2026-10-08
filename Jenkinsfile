pipeline {

    agent any

    environment {
        IMAGE_NAME = "ghcr.io/tanu674/devops-cloud-project:latest"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh '''
                    export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                    echo "===================================="
                    echo "BUILDING DOCKER IMAGE"
                    echo "===================================="

                    docker build -t devops-cloud-project:latest .
                '''
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                    export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                    echo "===================================="
                    echo "TAGGING IMAGE FOR GHCR"
                    echo "===================================="

                    docker tag devops-cloud-project:latest \
                    ghcr.io/tanu674/devops-cloud-project:latest
                '''
            }
        }

        stage('Login to GHCR') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'github-ghcr',
                        usernameVariable: 'GHCR_USERNAME',
                        passwordVariable: 'GHCR_TOKEN'
                    )
                ]) {
                    sh '''
                        export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                        echo "===================================="
                        echo "LOGGING IN TO GHCR"
                        echo "===================================="

                        echo "$GHCR_TOKEN" | docker login ghcr.io \
                            -u "$GHCR_USERNAME" \
                            --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to GHCR') {
            steps {
                sh '''
                    export PATH="/Users/almaanusiya/.docker/bin:$PATH"

                    echo "===================================="
                    echo "PUSHING IMAGE TO GHCR"
                    echo "===================================="

                    docker push ghcr.io/tanu674/devops-cloud-project:latest
                '''
            }
        }
    }

    post {

        success {
            echo "===================================="
            echo "JENKINS BUILD SUCCESSFUL"
            echo "DOCKER IMAGE PUSHED TO GHCR"
            echo "===================================="
        }

        failure {
            echo "===================================="
            echo "JENKINS BUILD FAILED"
            echo "===================================="
        }
    }
}