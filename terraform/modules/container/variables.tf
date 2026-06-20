variable "project_name" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "container_type" {
  type        = string
  description = "Container type"
}

variable "cluster_id" {
  type        = string
  description = "ECS Cluster ID"
}

variable "port" {
  description = "Port for the load balancer"
  type        = number
  default     = 80
}

variable "listener_arn" {
  type        = string
  description = "ARN of the load balancer listener"
}

variable "priority" {
  type        = number
  description = "Priority for the ALB listener rule"
}

variable "task_role_arn" {
  type        = string
  description = "ARN of the target role"
}

variable "task_execution_role_arn" {
  type        = string
  description = "ARN of the task execution role"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "container_environments" {
  type        = list(object({ name = string, value = string }))
  description = "Cluster Environments"
}

variable "container_secrets" {
  type        = list(object({ name = string, valueFrom = string }))
  description = "Cluster Secrets"
}
