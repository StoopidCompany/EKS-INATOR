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

variable "vpc_cidr" {
  description = "The starting CIDR value"
  type        = string
  default     = "10.0.0.0/16"
}
