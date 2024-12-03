# Main Terraform Configuration

# Provider Configuration
provider "aws" {
  region = var.region
}

# Generate a random suffix for unique resource names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Network Module
module "network" {
  source = "./modules/network"

  region               = var.region
  environment          = var.environment
  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  azs                  = ["${var.region}a", "${var.region}b"]
}

# ECR Module for Frontend and Backend
module "ecr_frontend" {
  source = "./modules/ecr"

  repository_name = "frontend-${random_string.suffix.result}"
}

module "ecr_backend" {
  source = "./modules/ecr"

  repository_name = "backend-${random_string.suffix.result}"
}

# Security Module
module "security" {
  source = "./modules/security"

  vpc_id              = module.network.vpc_id
  allowed_cidr_blocks = [module.network.vpc_cidr_block]
}

# ECS Module for Frontend
module "ecs_frontend" {
  source = "./modules/ecs"

  environment  = var.environment
  project_name = "${var.project_name}-frontend"

  vpc_id  = module.network.vpc_id
  subnets = module.network.private_subnet_ids

  container_port  = 3000
  container_image = module.ecr_frontend.repository_url

  alb_subnets     = module.network.public_subnet_ids
  security_groups = [module.security.frontend_sg_id]

  # Auto Scaling Configuration
  min_tasks     = 2
  max_tasks     = 6
  desired_tasks = 2
}

# ECS Module for Backend
module "ecs_backend" {
  source = "./modules/ecs"

  environment  = var.environment
  project_name = "${var.project_name}-backend"

  vpc_id  = module.network.vpc_id
  subnets = module.network.private_subnet_ids

  container_port  = 8000
  container_image = module.ecr_backend.repository_url

  alb_subnets     = module.network.public_subnet_ids
  security_groups = [module.security.backend_sg_id]

  # Auto Scaling Configuration
  min_tasks     = 2
  max_tasks     = 6
  desired_tasks = 2
}

# VPC Endpoint for Secure Communication
resource "aws_vpc_endpoint" "privatelink" {
  vpc_id            = module.network.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"

  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.security.vpc_endpoint_sg_id]
}