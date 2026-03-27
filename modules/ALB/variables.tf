#subnetをパブリックに置くためにsubnet1a,1cを引用
variable "subnet_1a_id" {
  description = "Subnet ID for ap-northeast-1a"
  type        = string
}

variable "subnet_1c_id" {
  description = "Subnet ID for ap-northeast-1c"
  type        = string
}
#ELB用securitygroupを使うため引用
variable "elb_sg_id" {
  description = "Security Group ID for ELB"
  type        = string
}

