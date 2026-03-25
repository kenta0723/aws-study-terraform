


#subnetをパブリックに置くためにsubnet1a,1cを引用
variable "subnet_1a_id" {
  type = string
}

variable "subnet_1c_id" {
  type = string
}
#ELB用securitygroupを使うため引用
variable "ELB_sg_id" {
  type = string
}

