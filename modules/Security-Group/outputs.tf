output "aws_study_sg_id" {
  value = aws_security_group.aws_study_sg.id
}

output "RDS_id" {
  value = aws_security_group.aws_study_sg_rds.id
}

output "ELB_sg_id" {
  value = aws_security_group.aws_study_ELB_sg.id
}