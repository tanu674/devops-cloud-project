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

                        echo "IMAGE PUSHED TO GHCR"
                    '''
                }
            }
        }

        stage('Deploy to Server 1') {
            steps {

                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'ec2-ssh',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    )
                ]) {

                    sh '''
                        echo "===================================="
                        echo "DEPLOYING TO SERVER 1"
                        echo "===================================="

                        ssh -i "$SSH_KEY" \
                            -o StrictHostKeyChecking=no \
                            "$SSH_USER@34.221.216.79" \
                            "sudo docker pull $IMAGE_NAME && \
                             sudo docker stop devops-cloud-container || true; \
                             sudo docker rm devops-cloud-container || true; \
                             sudo docker run -d \
                             --name devops-cloud-container \
                             -p 80:80 \
                             $IMAGE_NAME"
                    '''
                }
            }
        }

        stage('Deploy to Server 2') {
            steps {

                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'ec2-ssh',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    )
                ]) {

                    sh '''
                        echo "===================================="
                        echo "DEPLOYING TO SERVER 2"
                        echo "===================================="

                        ssh -i "$SSH_KEY" \
                            -o StrictHostKeyChecking=no \
                            "$SSH_USER@54.186.90.185" \
                            "sudo docker pull $IMAGE_NAME && \
                             sudo docker stop devops-cloud-container || true; \
                             sudo docker rm devops-cloud-container || true; \
                             sudo docker run -d \
                             --name devops-cloud-container \
                             -p 80:80 \
                             $IMAGE_NAME"
                    '''
                }
            }
        }
    }

    post {

        success {
            echo "===================================="
            echo "FULL CI/CD DEPLOYMENT SUCCESSFUL"
            echo "===================================="
            echo "Docker image pushed to GHCR"
            echo "Server 1 updated"
            echo "Server 2 updated"
        }

        failure {
            echo "===================================="
            echo "CI/CD DEPLOYMENT FAILED"
            echo "===================================="
        }
    }
}
