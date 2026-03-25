


resource "aws_wafv2_web_acl" "webACL" {
  name        = "aws-study-acl"
  description = "waf to cloudwatch"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = "true"
    metric_name                = "aws-study-waf"
    sampled_requests_enabled   = "true"
  }

  rule {


    name     = "AWS-AWSmanegedRulesCommonRuleset"
    priority = "1"
    visibility_config {
      cloudwatch_metrics_enabled = "true"
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = "true"
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesCommonRuleSet"

      }
    }
    override_action {
      none {}
    }

  }

}

resource "aws_wafv2_web_acl_association" "webaclssociation" {
  resource_arn = var.aws_ELB_arn
  web_acl_arn  = aws_wafv2_web_acl.webACL.arn
}


resource "aws_wafv2_web_acl_logging_configuration" "waf-traficlogs" {
  resource_arn = aws_wafv2_web_acl.webACL.arn
  log_destination_configs = [
    var.cloudwatchlogs_arn
  ]
}