output "postgres_file_system_id" {
  description = "The ID of the EFS file system for PostgreSQL"
  value       = aws_efs_file_system.postgres.id
}

output "static_file_system_id" {
  description = "The ID of the EFS file system for static files"
  value       = aws_efs_file_system.static.id
}

output "media_file_system_id" {
  description = "The ID of the EFS file system for media files"
  value       = aws_efs_file_system.media.id
}