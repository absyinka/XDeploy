# Output the ALB DNS name
output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.app_lb.dns_name
}

# Output the ECR repository URI
output "ecr_repository_urls" {
  # value       = aws_ecr_repository.app_repo.repository_url
  description = "The URLs of the ECR repositories"
  value       = { for repo in aws_ecr_repository.app_repo : repo.name => repo.repository_url }
}