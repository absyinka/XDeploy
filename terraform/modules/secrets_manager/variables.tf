variable "secret_name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_token" {
  description = "Docker Hub access token"
  type        = string
}