


resource "aws_lb_target_group" "aws_study_tg" {

  vpc_id = var.vpc_id

  name = "aws-study-tg"

  port             = 8080
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  target_type      = "instance"

  #-------------
  #health-check
  #-------------

  health_check {

    interval            = 30
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = "5"
    matcher             = "200,300,301"
    unhealthy_threshold = "2"

  }

  tags = {
    Name = "ec2_targetgroup"
  }
}

#-------------
#ELB-TargetGroup-attachment
#-------------

resource "aws_lb_target_group_attachment" "aws_elb_attachment" {
  target_group_arn = aws_lb_target_group.aws_study_tg.arn
  target_id        = var.aws_study_ec2_id
  #-----EC2をELBTargetGroupに紐づけ-----
}