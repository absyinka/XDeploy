resource "aws_efs_file_system" "postgres" {
  creation_token = "${var.creation_token}-postgres"
}

resource "aws_efs_mount_target" "postgres_mount" {
  file_system_id  = aws_efs_file_system.postgres.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
}

resource "aws_efs_file_system" "static" {
  creation_token = "${var.creation_token}-static"
}

resource "aws_efs_mount_target" "static_mount" {
  file_system_id  = aws_efs_file_system.static.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
}

resource "aws_efs_file_system" "media" {
  creation_token = "${var.creation_token}-media"
}

resource "aws_efs_mount_target" "media_mount" {
  file_system_id  = aws_efs_file_system.media.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
}
