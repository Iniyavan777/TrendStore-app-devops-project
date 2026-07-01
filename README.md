# DevOps Task 2 - Trend App Deployment

## Application
- Repo: https://github.com/Vennilavanguvi/Trend.git
- My Repo: https://github.com/Iniyavan777/devops-task2
- DockerHub: https://hub.docker.com/r/iniyacloud03/trend

## Tools Used
- Docker
- Terraform
- Kubernetes (Minikube)
- Jenkins
- Uptime Kuma (Monitoring)
- GitHub

## Setup Instructions

### 1. Clone Repo
git clone https://github.com/Iniyavan777/devops-task2.git

### 2. Build Docker Image
docker build -t iniyacloud03/trend:latest .

### 3. Terraform Infrastructure
cd terraform
terraform init
terraform apply -auto-approve

### 4. Deploy to Kubernetes
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

### 5. Jenkins Pipeline
- Auto triggers on every GitHub push
- Builds, pushes to DockerHub, deploys to Kubernetes

## Pipeline Stages
1. Clone - pulls code from GitHub
2. Build - builds Docker image
3. Push - pushes to DockerHub
4. Deploy - deploys to Kubernetes
## Monitoring
- Uptime Kuma running at http://98.81.91.19:3001
