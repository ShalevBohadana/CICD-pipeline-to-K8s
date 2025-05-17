variable "cidr" {
  description = "VPC CIDR block (e.g. 10.0.0.0/16)"
  type        = string
}

variable "az_count" {
  description = "Number of Availability Zones / public subnets"
  type        = number
}

variable "tags" {
  description = "Common tags map to apply to all VPC resources"
  type        = map(string)
}
