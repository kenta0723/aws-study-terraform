output "alb_tg_arn" {
  description = "ARN of ELB Target Group"
  value       = aws_lb_target_group.lb_tg.arn
}