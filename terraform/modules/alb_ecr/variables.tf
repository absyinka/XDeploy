# VPC ID where the resources will be provisioned
variable "vpc_id" {
  description = "VPC ID where the load balancer will be deployed."
  type        = string
}

# List of subnet IDs for the ALB
variable "subnet_ids" {
  description = "List of subnet IDs for the load balancer."
  type        = list(string)
}

# Name of the ECR repository
variable "ecr_repo_names" {
  description = "Name of the ECR repository to be created."
  type        = list(string)
}

# Name for the project
variable "project_name" {
  description = "The name of the project."
  type        = string
}
