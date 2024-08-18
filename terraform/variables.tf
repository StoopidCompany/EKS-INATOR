variable "name" {
  description = "The common name for resources."
  type        = string
  nullable    = false
}

variable "rds_kms_key_id" {
  description = "The KMS encryption key ARN for use by RDS."
  type        = string
  nullable    = false
}

variable "stage" {
  description = "The stage for this environment."
  type        = string
  default     = "prod"
}
