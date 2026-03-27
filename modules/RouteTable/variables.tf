variable "vpc_id" {
  description = "VPC ID to create resources in"
  type        = string
}

variable "igw_id" {
  description = "IGW ID to create resources in"
  type        = string
}

variable "subnet_1a_id" {
  description = "Subnet ID for ap-northeast-1a"
  type        = string
}

variable "subnet_1c_id" {
  description = "Subnet ID for ap-northeast-1c"
  type        = string
}