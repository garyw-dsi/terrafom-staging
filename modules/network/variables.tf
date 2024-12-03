variable "region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR Blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDR Blocks"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}