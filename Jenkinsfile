pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "iniyacloud03/trend:latest"
        DOCKER_TAG = "iniyacloud03/trend:${BUILD_NUMBER}"
        KUBECONFIG = "/home/ubuntu_iniya/.kube/config"
        AWS_REGION = "us-east-1"
        EKS_CLUSTER = "trend-eks-cluster"
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 30, unit: 'MINUTES')
        timestamps()
    }
    
    stages {
        stage('🔍 Checkout Code') {
            steps {
                echo "📦 Checking out code from GitHub..."
                checkout scm
                sh 'echo "Branch: $(git rev-parse --abbrev-ref HEAD)"'
                sh 'echo "Commit: $(git rev-parse --short HEAD)"'
            }
        }
        
        stage('🐳 Build Docker Image') {
            steps {
                echo "🔨 Building Docker image..."
                sh '''
                    docker build -t ${DOCKER_IMAGE} .
                    docker tag ${DOCKER_IMAGE} ${DOCKER_TAG}
                    echo "✅ Docker image built successfully"
                '''
            }
        }
        
        stage('📤 Push to DockerHub') {
            steps {
                echo "🚀 Pushing image to DockerHub..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
                        docker push ${DOCKER_IMAGE}
                        docker push ${DOCKER_TAG}
                        echo "✅ Image pushed successfully"
                    '''
                }
            }
        }
        
        stage('☸️ Deploy to EKS') {
            steps {
                echo "🚀 Deploying to EKS cluster: ${EKS_CLUSTER}..."
                sh '''
                    aws eks update-kubeconfig --region ${AWS_REGION} --name ${EKS_CLUSTER}
                    kubectl apply -f k8s-deployment.yaml
                    kubectl apply -f k8s-service.yaml
                    kubectl rollout restart deployment/trend-app -n trend-app
                    kubectl rollout status deployment/trend-app -n trend-app --timeout=5m
                    echo "✅ Deployment successful"
                '''
            }
        }
        
        stage('✅ Verify Deployment') {
            steps {
                echo "🔎 Verifying deployment..."
                sh '''
                    echo "=== Kubernetes Pods ==="
                    kubectl get pods -n trend-app -o wide
                    
                    echo ""
                    echo "=== Kubernetes Services ==="
                    kubectl get svc -n trend-app -o wide
                '''
            }
        }
    }
    
    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
