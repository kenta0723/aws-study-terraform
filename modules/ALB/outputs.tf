output "aws_elb_arn" {
  description = "ARN of ELB"
  value       = aws_lb.aws_elb.arn
}