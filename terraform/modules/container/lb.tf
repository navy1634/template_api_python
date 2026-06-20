resource "aws_lb_target_group" "this" {
  name        = "${var.project_name}-${var.container_type}-tg"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    enabled = true
    path    = "/api/health"
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}
