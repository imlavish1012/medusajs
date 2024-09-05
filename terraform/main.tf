provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecr" {
  source      = "./modules/ecr"
  environment = var.environment
}

module "rds" {
  source = "./modules/rds"

  environment                 = var.environment
  db_name                     = var.db_name
  db_password                 = local.sh_secrets.DB_PASSWORD
  db_user                     = var.db_user
  db_port                     = var.db_port
  db_instance_type            = var.db_instance_type
  vpc_id                      = var.vpc_id
  vpc_cidr                    = var.vpc_cidr
  allocated_storage           = var.allocated_storage
  max_allocated_storage       = var.max_allocated_storage
  private_subnet_ids          = var.private_subnet_ids
  airflow-ecs-security-group  = module.ecs-fargate.airflow-ecs-security-group
  superset-ecs-security-group = module.ecs-fargate.superset-ecs-security-group
  engine_version              = var.engine_version
  parameter_group_name        = var.parameter_group_name
  allow_major_version_upgrade = var.allow_major_version_upgrade
  iops                        = var.iops
}

module "ecs-cluster" {
  source = "./modules/ecs-cluster"

  environment = var.environment
}

module "alb" {
  source = "./modules/alb"

  environment                = var.environment
  vpc_id                     = var.vpc_id
  public_subnet_ids          = var.public_subnet_ids
  airflow_health_check_path  = var.airflow_health_check_path
  sh_health_check_path       = var.sh_health_check_path
  vpc_ng1_cidr               = var.vpc_ng1_cidr
  vpc_ng2_cidr               = var.vpc_ng2_cidr
  vpc_cidr                   = var.vpc_cidr
  zone_id                    = local.sh_secrets.ZONE_ID
  alb_certificate_arn        = local.sh_secrets.ALB_CERTIFICATE_ARN
  superset_health_check_path = var.superset_health_check_path
  access_logs_bucket         = var.access_logs_bucket
}