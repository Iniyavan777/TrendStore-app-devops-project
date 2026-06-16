variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "trend-app"
}

variable "environment" {
  default = "production"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "eks_cluster_name" {
  default = "trend-eks-cluster"
}
