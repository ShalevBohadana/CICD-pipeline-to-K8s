variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "environment" {
  type    = string
  default = "dev"
}
variable "node_count" {
  description = "Number of worker nodes in the EKS node group"
  type        = number
  default     = 2
}
