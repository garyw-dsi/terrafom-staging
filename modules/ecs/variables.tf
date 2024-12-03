variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Private subnets for ECS tasks"
  type        = list(string)
}

variable "alb_subnets" {
  description = "Public subnets for Application Load Balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups for ECS tasks and ALB"
  type        = list(string)
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 3000
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units"
  type        = number
  default     = 256
}

variable "fargate_memory" {
  description = "Fargate instance memory"
  type        = number
  default     = 512
}

variable "desired_tasks" {
  description = "Number of desired tasks"
  type        = number
  default     = 2
}

variable "min_tasks" {
  description = "Minimum number of tasks"
  type        = number
  default     = 2
}

variable "max_tasks" {
  description = "Maximum number of tasks"
  type        = number
  default     = 6
}