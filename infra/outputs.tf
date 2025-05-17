output "vpc_id" {
  description = "Root: The ID of the VPC created by the vpc module"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Root: IDs of public subnets from the vpc module"
  value       = module.vpc.public_subnet_ids
}

output "private_subnets" {
  description = "Root: IDs of private subnets from the vpc module"
  value       = module.vpc.private_subnet_ids
}

output "eks_endpoint" {
  description = "Root: EKS cluster endpoint from the eks module"
  value       = module.eks.cluster_endpoint
}

output "ecr_url" {
  description = "Root: ECR repository URL from the ecr module"
  value       = module.ecr.repository_url
}
