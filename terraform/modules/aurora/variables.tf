variable "name" {
  description = "The common name for resources"
  type        = string
  nullable    = false
}

variable "stage" {
  description = "The environment stage"
  type        = string
  nullable    = false
}

################################################################################
# Relational Database Service
################################################################################

variable "rds_backup_retention_period" {
  description = "How long to keep RDS backups"
  type        = number
  nullable    = false
}

variable "rds_database_engine" {
  description = "The type of database to run"
  type        = string
  nullable    = false
}

variable "rds_database_engine_version" {
  description = "The version of the database to use"
  type        = string
  nullable    = false
}

variable "rds_database_engine_mode" {
  description = "The mode for the database"
  type        = string
  nullable    = false
}

variable "rds_instance_class" {
  description = "The size of the RDS instance"
  type        = string
  nullable    = false
}

variable "rds_kms_key_id" {
  description = "The KMS encryption key for RDS"
  type        = string
  nullable    = false
}

variable "rds_password_rotation_automatically_after_days" {
  description = "How many days between password rotations"
  type        = number
  nullable    = false
}

variable "rds_scaling_max_capacity" {
  description = "The max number of replicated dbs"
  type        = number
  nullable    = false
}

variable "rds_scaling_min_capacity" {
  description = "The minimum number of replicated dbs"
  type        = number
  nullable    = false
}

variable "rds_skip_final_snapshot" {
  description = "Do we skip the final snapshot on delete?"
  type        = bool
  nullable    = false
}

################################################################################
# Virtual Private Cloud
################################################################################

variable "vpc_id" {
  description = "The ID of the VPC to join this to"
  type        = string
  nullable    = false
}

variable "vpc_database_subnet_group_name" {
  description = "The name of the subnet group to join this to"
  type        = string
  nullable    = false
}

variable "vpc_private_subnets_cidr_blocks" {
  description = "The CIDR blocks for the private subnets"
  type        = list(any)
  nullable    = false
}
