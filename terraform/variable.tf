variable "environment" {
  description = "A name to describe the environment we're creating."
}

variable "scribe_environment" {
  description = "The name of the scribe environment"
}

variable "sentry_enabled" {
  description = "Sentry integration is enabled"
}

variable "aws_profile" {
  description = "The AWS-CLI profile for the account to create resources in."
}

variable "account_id" {
  description = "Account ID to deploy"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "superset_health_check_path" {
  description = "The default superset health check path"
}

variable "cdn_access_logs_bucket" {
  description = "The name of the bucket to store the cdn logs in"
}

variable "access_logs_bucket" {
  description = "The name of the bucket to store the alb logs in"
}

variable "superset_postgres_db" {
  description = "Superset Postgres DB Name"
}

variable "superset_container_port" {
  type = number
}

variable "vpc_ng1_cidr" {
  description = "Specify natgateway cidr block that is allowed to access the Go-App LoadBalancer"
}

variable "vpc_ng2_cidr" {
  description = "Specify natgateway cidr block that is allowed to access the Go-App LoadBalancer"
}

variable "aws_region" {
  description = "The AWS region to create resources in."
}

variable "vpc_cidr" {
  description = "The IP range to attribute to the virtual network."
}

variable "sh_db_name" {
  description = "SH backend Postgres DB Name"
}

variable "aliases" {
  description = "alternate domain name"
}

variable "public_subnet_cidrs" {
  description = "The IP ranges to use for the public subnets in your VPC."
  type        = list(any)
}

variable "public_subnet_ids" {
  type        = list(any)
  description = "List of public subnet ids to place the loadbalancer in"
}

variable "private_subnet_cidrs" {
  description = "The IP ranges to use for the private subnets in your VPC."
  type        = list(any)
}

variable "availability_zones" {
  description = "The AWS availability zones to create subnets in."
  type        = list(any)
}

variable "database_dialect" {
  description = "Superset Database Dialect"
}

variable "superset_load_examples" {
  description = "Superset load examples"
}

variable "cypress_config" {
  description = "Superset Cypress Config"
}

variable "compose_project_name" {
  description = "Superset Compose Project Name"
}

variable "redis_port" {
  description = "Superset Redis Port"
}

variable "superset_port" {
  description = "Superset Port"
}

# variable "deregistration_delay" {
#   default     = "300"
#   description = "The default deregistration delay"
# }

variable "private_subnet_ids" {
  type        = list(any)
  description = "The list of private subnets ids to use"
}

variable "private_subnet_id_2a" {
  description = "The list of private subnet id to use in efs"
}

variable "private_subnet_id_2b" {
  description = "The list of private subnet id to use in efs"
}

variable "db_name" {
  description = "Database Name"
}

variable "db_user" {
  description = "Database Password"
}

variable "db_port" {
  description = "Database Port"
}

variable "db_instance_type" {
  description = "Database Instance Type"
}

variable "network_mode" {
  description = "Network mode for activemq task definition"
}

variable "airflow_uid" {
  description = "Airflow UID"
}

variable "airflow_core_dags_paused_at_creation" {
  description = "AIRFLOW CORE DAGS ARE PAUSED AT CREATION"
}

variable "airflow_core_executor" {
  description = "Airflow Core Executor"
}

variable "airflow_core_load_examples" {
  description = "AIRFLOW CORE LOAD EXAMPLES"
}

variable "airflow_database_load_default_connections" {
  description = "AIRFLOW DATABASE LOAD DEFAULT CONNECTIONS"
}

variable "sqlalchemy_silence_uber_warning" {
  description = "SQLALCHEMY SILENCE UBER WARNING"
}

variable "airflow_db_upgrade" {
  description = "AIRFLOW DB UPGRADE"
}

variable "airflow_www_user_create" {
  description = "AIRFLOW WWW USER CREATE"
}

variable "airflow_api_auth_backends" {
  description = "AIRFLOW API AUTH BACKENDS"
}

variable "airflow_core_dagbag_import_error_traceback_depth" {
  description = "Airflow core dagbag import error traceback depth"
}

variable "mail_recipients_allowlist_enabled" {
  default     = true
  description = "Allow sending emails to the domain other than 7bulls.com and scribe.com"
}

variable "request_logging_include_query_string" {
  default     = true
  description = "Logging of the querystrings"
}

variable "request_logging_include_payload" {
  description = "Logging of the payloads"
}

variable "inform_about_expired_plans_enabled" {
  description = "Enable sending notifications on team plan subscription expiry."
}

variable "active_mq_enabled" {
  default     = true
  description = "Use ActiveMQ for websocket connections"
}

variable "server_port" {
  type = string
}

variable "active_mq_port" {
  type = string
}

variable "ecs_sh_container_port" {
  type = number
}

variable "ecs_airflow_container_port" {
  type = number
}

variable "airflow_health_check_path" {
  description = "The default airflow health check path"
}

variable "sh_health_check_path" {
  description = "The default sh health check path"
}

variable "domain_name" {
  description = "name of domain"
}

variable "airflow_core_max_active_tasks_per_dag" {
  description = "airflow_core_max_active_tasks_per_dag"
}

variable "airflow_core_max_active_tasks" {
  description = "airflow_core_max_active_tasks"
}

variable "allocated_storage" {
  description = "storage of rds"
}

variable "max_allocated_storage" {
  description = "maximum threshold storage of rds"
}

variable "airflow_metrics_statsd_on" {
  description = "Airflow Metrics to be enable or disable"
}

variable "airflow_metrics_statsd_port" {
  description = "Airflow Metrics Port"
}

variable "airflow_metrics_statsd_prefix" {
  description = "Airflow Metrics Prefix"
}

variable "engine_version" {
  description = "PostgreSQL Major Version"
}

variable "parameter_group_name" {
  description = "PostgreSQL Parameter Group Name"
}

variable "allow_major_version_upgrade" {
  description = "PostgreSQL Major Version Upgrade"
}

variable "syslog_max_rows" {
  description = "Syslog max rows to keep per team"
}

variable "syslog_max_age" {
  description = "Syslog max days to keep per team"
}

variable "iops" {
  description = "RDS Storage IOPS"
}