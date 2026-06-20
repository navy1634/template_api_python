variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "secrets_arns" {
  type        = list(string)
  description = "List of Secrets Manager ARNs the task execution role can read"
}
