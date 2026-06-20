variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "db_user" {
  type        = string
  description = "RDS User Name"
}
variable "db_password" {
  type        = string
  description = "RDS User Name"
  sensitive   = true
}

variable "instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "17.4"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "Public subnet CIDR block"
}

