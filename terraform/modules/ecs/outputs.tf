output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "service_id" {
  value = aws_ecs_service.this.id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.this.name
}
