output "ec2_sg_id" {
  description = "Security Group ID for EC2"
  value       = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS"
  value       = aws_security_group.rds_sg.id
}

output "elb_sg_id" {
  description = "Security Group ID for ELB"
  value       = aws_security_group.elb_sg.id
}