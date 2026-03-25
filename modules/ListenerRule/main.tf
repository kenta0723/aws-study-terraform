


resource "aws_lb_listener" "ALBlistener" {

  load_balancer_arn = var.aws_ELB_arn
  port              = 80
  protocol          = "HTTP"

  default_action {

    target_group_arn = var.alb_tg_arn
    type             = "forward"

  }
}