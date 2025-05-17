variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "AMI ID to use for the Jenkins server (Amazon Linux 2)"
  type        = string
}

variable "subnet_id" {
  description = "Private subnet ID for the Jenkins server"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the Jenkins server"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name with TerraformInfraRole attached"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair for access"
  type        = string
}
variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "iam_instance_profile" {
  description = "Instance profile name for Jenkins EC2"
  type        = string
}
variable "tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
}
variable "vpc_id" {
  description = "VPC ID where Jenkins will be deployed"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR block to allow SSH access"
  type = string 
}