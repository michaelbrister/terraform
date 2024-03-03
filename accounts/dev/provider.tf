terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 0.5"
    }
  }

  backend "s3" {
    encrypt        = true
    bucket         = "my-tf-state-1234"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "my-tf-lock"
  }
}