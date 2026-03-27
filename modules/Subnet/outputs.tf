output "public_1a_id" {
  description = "Public Subnet ID for ap-northeast-1a"
  value       = aws_subnet.public_1a.id
}

output "public_1c_id" {
  description = "Public Subnet ID for ap-northeast-1c"
  value       = aws_subnet.public_1c.id
}

output "db_subnet_group_id" {
  description = "DB Subnet Group ID for the RDS"
  value       = aws_db_subnet_group.rdsdbsubnetgroup.id
}

