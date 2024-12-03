output "frontend_sg_id" {
  description = "Security Group ID for the frontend"
  value       = aws_security_group.frontend_sg.id
}

output "backend_sg_id" {
  description = "Security Group ID for the backend"
  value       = aws_security_group.backend_sg.id
}

output "vpc_endpoint_sg_id" {
  description = "Security Group ID for the VPC endpoint"
  value       = aws_security_group.vpc_endpoint_sg.id
}
