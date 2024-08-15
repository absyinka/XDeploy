variable "secret_name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
}

variable "dockerhub_username" {
  description = "Docker Hub Username"
  type        = string
  sensitive   = true
}

variable "dockerhub_token" {
  description = "Docker Hub token"
  type        = string
  sensitive   = true
}