resource "aws_secretsmanager_secret" "dockerhub_credentials" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "dockerhub_credentials" {
  secret_id     = aws_secretsmanager_secret.dockerhub_credentials.id
  secret_string = jsonencode({
    username = var.dockerhub_username
    password = var.dockerhub_password
  })
}