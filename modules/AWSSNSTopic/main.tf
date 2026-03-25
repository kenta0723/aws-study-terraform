


resource "aws_sns_topic" "aws_SNS_Topic" {
  name = "aws-study-topic"
}

resource "aws_sns_topic_subscription" "aws_SNS_Topic_email" {

  topic_arn = aws_sns_topic.aws_SNS_Topic.arn
  protocol  = "email"
  endpoint  = var.my_email_address
}