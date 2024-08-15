output "dockerhub_credentials_arn" {
  description = "The ARN of the Docker Hub credentials secret"
  value       = aws_secretsmanager_secret.dockerhub_credentials.arn
}
