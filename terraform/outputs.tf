output "ecs_cluster_name" {
  value = module.ecs_module.ecs_cluster_name
}

output "ecs_service_name" {
  value = module.ecs_module.ecs_service_name
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb_ecr.alb_dns_name
}

output "ecr_repository_urls" {
  description = "The URL of the ECR repository"
  value       = module.alb_ecr.ecr_repository_urls
}