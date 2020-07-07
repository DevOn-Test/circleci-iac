terraform {
  required_version = "~> 0.12.0"
}

provider "aws" {
  region = "ap-south-1"

  assume_role {
#    role_arn     = "arn:aws:iam::151176323318:role/OrganizationAccountAccessRole"
    role_arn     = var.role_arn
#    session_name = "SESSION_NAME"
#    external_id  = "EXTERNAL_ID"
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.44.0"

  name = "myvpc"

  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
#  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#  enable_ipv6 = true

#  enable_nat_gateway = true
#  single_nat_gateway = true

  public_subnet_tags = {
    Name = "overridden-name-public"
  }

  tags = {
    Owner       = "Santosh"
    Environment = "Test"
  }

  vpc_tags = {
    Name = "vpc-myvpc"
  }
}

