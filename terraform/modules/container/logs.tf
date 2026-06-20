## CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.container_type}/container"
  retention_in_days = 365
}
