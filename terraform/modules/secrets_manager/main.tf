resource "aws_secretsmanager_secret" "dockerhub_credentials" {
  name = var.secret_name
  lifecycle {
    prevent_destroy = true
    ignore_changes = [name]
  }
}

resource "aws_secretsmanager_secret_version" "dockerhub_credentials" {
  secret_id     = aws_secretsmanager_secret.dockerhub_credentials.id
  secret_string = jsonencode({
    username = var.dockerhub_username
    token = var.dockerhub_token
  })
}