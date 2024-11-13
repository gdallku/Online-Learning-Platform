terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "oln-tfstate"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}


provider "aws" {
  region = "eu-west-3"
}

module "bastion" {
  source = "./bastion"

  vpc_id                = module.vpc.vpc_id
  public_subnet-1a_id   = module.vpc.public_subnet-1a_id
  public_subnet-1b_id   = module.vpc.public_subnet-1b_id
  aws_security_group_id = module.vpc.aws_security_group_id
}
module "vpc" {
  source = "./vpc"

}

module "s3" {
  source = "./s3"
}
module "dynamodb" {
  source = "./dynamodb"

}
module "efs" {
  source = "./efs"

}

module "rds" {
  source = "./rds"

  vpc_id               = module.vpc.vpc_id
  private_subnet-1a_id = module.vpc.private_subnet-1a_id
  private_subnet-1b_id = module.vpc.private_subnet-1b_id
}
module "cloudwatch" {
  source = "./cloudwatch"

  public_subnet-1a_id = module.vpc.public_subnet-1a_id
  public_subnet-1b_id = module.vpc.public_subnet-1b_id
}
