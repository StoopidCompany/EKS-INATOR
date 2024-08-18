data "aws_kms_key" "db" {
  key_id = var.rds_kms_key_id
}

################################################################################
# Aurora
################################################################################

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.8.0"

  name           = "${var.name}-${var.stage}"
  engine         = var.rds_database_engine
  engine_version = var.rds_database_engine_version
  engine_mode    = var.rds_database_engine_mode
  database_name  = var.name

  master_username                                        = random_pet.username.id
  manage_master_user_password                            = true
  manage_master_user_password_rotation                   = true
  master_user_password_rotation_automatically_after_days = var.rds_password_rotation_automatically_after_days

  storage_encrypted = true
  kms_key_id        = data.aws_kms_key.db.arn

  vpc_id               = var.vpc_id
  db_subnet_group_name = var.vpc_database_subnet_group_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = var.vpc_private_subnets_cidr_blocks
    }
  }

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = var.rds_skip_final_snapshot

  serverlessv2_scaling_configuration = {
    min_capacity = var.rds_scaling_min_capacity
    max_capacity = var.rds_scaling_max_capacity
  }

  instance_class = var.rds_instance_class
  instances = {
    one = {}
    two = {}
  }

  tags = {
    Environment = upper(var.stage)
  }
}

################################################################################
# Additional Resources
################################################################################

resource "random_pet" "username" {
  length    = 2
  separator = "_"
}

################################################################################
# Output
################################################################################

output "aurora_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora.cluster_endpoint
}

output "aurora_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora.cluster_reader_endpoint
}

output "aurora_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora.cluster_database_name
}

output "aurora_cluster_port" {
  description = "The database port"
  value       = module.aurora.cluster_port
}

output "aurora_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora.cluster_master_password
  sensitive   = true
}

output "aurora_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora.cluster_master_username
  sensitive   = true
}
