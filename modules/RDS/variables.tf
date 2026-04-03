variable "db_masterpassword" {
  description = "Master Password for the RDS"
  type        = string
}

variable "db_masteryourname" {
  description = "Master username for the RDS"
  type        = string
}

variable "rds_sg_id" {
  description = "Security Group ID for the RDS"
  type        = string
}

variable "db_subnet_group_id" {
  description = "DB Subnet Group ID for the RDS"
  type        = string

}