output "cloudwatchlogs_arn" {
  description = "ARN of Cloud Watch Logs"
  value       = aws_cloudwatch_log_group.cloudwatchlogs.arn
}