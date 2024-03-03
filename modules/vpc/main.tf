module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr

  azs                 = var.azs
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  public_subnet_names = var.public_subnet_names

  enable_nat_gateway = var.enable_nat_gateway

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}