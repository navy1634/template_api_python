output "alb_arn" {
  value       = aws_lb_listener.http.arn
  description = "The ARN of the HTTP listener"
}

output "task_execution_role_arn" {
  value       = aws_iam_role.task_execution_role.arn
  description = "The ARN of the IAM role that allows ECS tasks to call AWS services on your behalf"
}

output "task_role_arn" {
  value       = aws_iam_role.task_role.arn
  description = "The ARN of the IAM role that allows ECS tasks to call AWS services on your behalf"
}

output "cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "The ID of the ECS cluster"
}
