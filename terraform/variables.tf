variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "ecs_desired_count" {
  description = "ECS counts to provision in AWS"
  type        = number
  default     = 2
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_token" {
  description = "Docker Hub token"
  type        = string
}