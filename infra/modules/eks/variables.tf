variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
}


variable "node_count" {
  description = "Number of worker nodes in the node group"
  type        = number
  default     = 2
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version for the cluster"
  default     = "1.28"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
}
