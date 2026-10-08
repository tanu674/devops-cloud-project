pipeline {

    agent any

    environment {
        IMAGE_NAME = "ghcr.io/tanu674/devops-cloud-project:latest"
    }

    stages {

        stage('Build and Push Docker Image') {

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

                        echo "===================================="
                        echo "BUILDING LINUX AMD64 IMAGE"
                        echo "===================================="

                        docker buildx build \
                            --platform linux/amd64 \
                            -t "$IMAGE_NAME" \
                            --push \
                            .

                        echo "===================================="
                        echo "IMAGE PUSHED TO GHCR"
                        echo "===================================="
                    '''
                }
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
