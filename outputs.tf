output "frontend_alb_dns" {
  description = "Frontend Load Balancer DNS"
  value       = module.ecs_frontend.alb_dns_name
}

output "backend_alb_dns" {
  description = "Backend Load Balancer DNS"
  value       = module.ecs_backend.alb_dns_name
}

output "frontend_ecr_repository" {
  description = "Frontend ECR repository URL"
  value       = module.ecr_frontend.repository_url
}

output "backend_ecr_repository" {
  description = "Backend ECR repository URL"
  value       = module.ecr_backend.repository_url
}