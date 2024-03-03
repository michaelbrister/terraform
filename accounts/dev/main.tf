module "my_vpc" {
  source = "../../modules/vpc"

  vpc_name            = "my-vpc"
  cidr                = "10.0.0.0/16"
  environment         = "dev"
  public_subnet_names = ["public_subnet_names"]
  public_subnets      = ["10.0.101.0/24"]

  private_subnets      = ["10.0.1.0/24"]
  private_subnet_names = ["my-private-subnet"]
}