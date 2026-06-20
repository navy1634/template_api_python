## ECS Security Group
resource "aws_security_group" "this" {
  name        = "${var.project_name}-ecs-container"
  vpc_id      = var.vpc_id
  description = "Allow HTTP and HTTPS access to ECS Container from ALB"
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
