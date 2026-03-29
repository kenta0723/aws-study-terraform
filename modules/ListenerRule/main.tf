resource "aws_lb_listener" "elblistener" {

  load_balancer_arn = var.aws_elb_arn
  port              = 80
  protocol          = "HTTP"

  default_action {

    target_group_arn = var.alb_tg_arn
    type             = "forward"

  }
}