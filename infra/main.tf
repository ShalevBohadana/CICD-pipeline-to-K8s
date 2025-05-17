locals {
  common_tags = {
    Environment = var.environment
    Project     = "ci-cd-pipeline-demo"
    Owner       = "ShalevBohadana"
  }
}

module "vpc" {
  source   = "./modules/vpc"
  cidr     = "10.0.0.0/16"     # matches variable "cidr"
  az_count = 2                 # matches variable "az_count"
  tags     = local.common_tags # matches variable "tags"
}

module "eks" {
  source             = "./modules/eks"
  environment        = var.environment
  cluster_name       = "sample-eks-${var.environment}"
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  node_count         = var.node_count
  tags               = local.common_tags
}


module "ecr" {
  source    = "./modules/ecr"
  repo_name = "sample-app"
  tags      = local.common_tags
}
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "auth" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.auth.token
}
