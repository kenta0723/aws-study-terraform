output "ec2_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2.id
}