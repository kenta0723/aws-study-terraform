resource "aws_sns_topic" "aws_sns_topic" {
  name = "aws-study-topic"
}

resource "aws_sns_topic_subscription" "aws_sns_topic_email" {

  topic_arn = aws_sns_topic.aws_sns_topic.arn
  protocol  = "email"
  endpoint  = var.my_email_address
}