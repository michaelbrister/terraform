variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "private_subnet_names" {
  description = "List of private subnet names"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "public_subnet_names" {
  description = "List of public subnet names"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment ( dev / stage / prod )"
  type        = string
}