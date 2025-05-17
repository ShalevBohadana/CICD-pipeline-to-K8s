terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 4.0" }
  }
}

# Provider A: no assume, used for bootstrapping the role
provider "aws" {
  alias  = "bootstrap"
  region = var.aws_region
}

# Provider B: assume the role, used for all other resources
provider "aws" {
  alias  = "main"
  region = var.aws_region
  assume_role {
    role_arn     = aws_iam_role.terraform_infra.arn
    session_name = "terraform-main"
  }
}
