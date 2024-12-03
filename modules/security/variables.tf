variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Adjust this as needed based on your security requirements
}
