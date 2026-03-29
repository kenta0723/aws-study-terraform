#------------------
#CloudWatch
#------------------
resource "aws_cloudwatch_metric_alarm" "aws_study_cloudwatch" {


  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"

  #--- N 回の評価のうち、「しきい値超過」が M 回存在したらアラートにする ---
  #---NがEvaluationPeriods　MがDatapointsToAlarm---
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"

  period    = "300"
  statistic = "Average"
  threshold = "0.1"

  alarm_name        = "EC2CPUUtilization"
  alarm_description = "EC2のアラーム使用率が5分間で0.1を超えたらトリガー"
  dimensions = {
    InstanceId = var.aws_study_ec2_id
  }

  actions_enabled = "true"
  alarm_actions   = [var.aws_sns_topic_arn]

}

#------------------
#ロググループの作成
#------------------
resource "aws_cloudwatch_log_group" "cloudwatchlogs" {
  name = "aws-waf-logs-study"

  tags = {
    Name = "CloudwatchLogsGroup"
  }
}

resource "aws_cloudwatch_log_resource_policy" "cloudwatch_resource_policy" {
  policy_name = "cloudwatchlogs_resource_policy"
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSWAFLogsToCloudWatch"
        Effect = "Allow"
        Principal = {
          Service = "waf.amazonaws.com"
        },
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = aws_cloudwatch_log_group.cloudwatchlogs.arn
      }
    ]
  })
}