variable "account_id" {
  description = "The AWS account ID"
  type        = string
  nullable    = false
}

variable "name" {
  description = "The common name for resources."
  type        = string
  nullable    = false
}

variable "region" {
  description = "The AWS region"
  type        = string
  nullable    = false
}

variable "stage" {
  description = "The stage for this environment."
  type        = string
  default     = "prod"
}

################################################################################
# EKS
################################################################################

variable "eks_cluster_version" {
  description = "The Kubernetes version to use"
  type        = string
  nullable    = false
}

variable "eks_default_node_group_size" {
  description = "The EC2 instance size of the managed node_group"
  type        = string
  default     = "t3.2xlarge"
}

variable "eks_default_disk_size" {
  description = "The disk size for the default group"
  type        = string
  default     = 20
}

################################################################################
# RDS
################################################################################

variable "rds_backup_retention_period" {
  description = "How long to keep RDS backups"
  type        = number
  default     = 0
}

variable "rds_database_engine" {
  description = "The type of database to run"
  type        = string
  default     = "aurora-postgresql"
}

variable "rds_database_engine_version" {
  description = "The version of the database to use"
  type        = string
  default     = "15.3"
}

variable "rds_database_engine_mode" {
  description = "The mode for the database"
  type        = string
  default     = "provisioned"
}

variable "rds_instance_class" {
  description = "The size of the RDS instance"
  type        = string
  default     = "db.serverless"
}

variable "rds_kms_key_id" {
  description = "The KMS encryption key for RDS"
  type        = string
  nullable    = false
}

variable "rds_password_rotation_automatically_after_days" {
  description = "How many days between password rotations"
  type        = number
  default     = 5
}

variable "rds_scaling_max_capacity" {
  description = "The max number of replicated dbs"
  type        = number
  default     = 10
}

variable "rds_scaling_min_capacity" {
  description = "The minimum number of replicated dbs"
  type        = number
  default     = 2
}

variable "rds_skip_final_snapshot" {
  description = "Do we skip the final snapshot on delete?"
  type        = bool
  default     = true
}

