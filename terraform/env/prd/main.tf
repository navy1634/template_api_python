locals {
  env       = "prod"
  region    = "ap-northeast-1"
  project   = "template"
}

data "aws_secretsmanager_secret" "db" {
  name = "rds/template/secrets"
}

# VPC
module "vpc" {
  source       = "../../modules/vpc"
  project_name = local.project
}

# ECS
## Load Balancer
module "cluster" {
  source            = "../../modules/cluster"
  project_name      = local.project
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  secrets_arns      = [data.aws_secretsmanager_secret.db.arn]
}

## API
module "api_container" {
  source                  = "../../modules/container"
  project_name            = local.project
  region                  = local.region
  container_type          = "api"
  port                    = 80
  priority                = 10
  cluster_id              = module.cluster.cluster_id
  listener_arn            = module.cluster.alb_arn
  vpc_id                  = module.vpc.vpc_id
  vpc_cidr_block          = module.vpc.vpc_cidr_block
  subnet_ids              = module.vpc.private_subnet_ids
  task_execution_role_arn = module.cluster.task_execution_role_arn
  task_role_arn           = module.cluster.task_role_arn
  container_environments = [
    { name = "DATABASE_USER", value = "${data.aws_secretsmanager_secret.db.arn}:username::" },
    { name = "DATABASE_NAME", value = "template" },
    { name = "DATABASE_HOST", value = module.database.db_host },
  ]
  container_secrets = [
    { name = "DATABASE_PASSWORD", valueFrom = "${data.aws_secretsmanager_secret.db.arn}:password::" },
  ]
}

# # WEB
# module "web_container" {
#   source                  = "../../modules/container"
#   project_name            = local.project
#   region                  = local.region
#   container_type          = "web"
#   port                    = 80
#   priority                = 0
#   cluster_id              = module.cluster.cluster_id
#   listener_arn            = module.cluster.alb_arn
#   vpc_id                  = module.vpc.vpc_id
#   vpc_cidr_block          = module.vpc.vpc_cidr_block
#   subnet_ids              = module.vpc.public_subnet_ids
#   subnet_cidr_blocks      = module.vpc.public_subnet_cidr_blocks
#   task_execution_role_arn = module.cluster.task_execution_role_arn
#   task_role_arn           = module.cluster.task_role_arn
# }

# RDS
module "database" {
  source                    = "../../modules/database"
  project_name              = local.project
  instance_type             = "db.t4g.micro"
  engine_version            = "18.3"
  db_user                   = "${data.aws_secretsmanager_secret.db.arn}:username::"
  db_password               = "${data.aws_secretsmanager_secret.db.arn}:password::"
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids
  private_subnet_cidr_block = module.vpc.private_subnet_cidr_blocks[0]
}
