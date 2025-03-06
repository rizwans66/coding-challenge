terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source            = "./modules/compute"
  vpc_id            = module.networking.vpc_id  # Now correctly references default VPC
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.networking.security_group_id
}

