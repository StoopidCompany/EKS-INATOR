variable "account_id" {
  description = "The AWS account ID"
  type        = string
  nullable    = false
}

variable "eks_cluster_version" {
  description = "The Kubernetes version to deploy"
  type        = string
  nullable    = false
}

variable "eks_general_node_group_size" {
  description = "The EC2 instance size of the managed node_group"
  type        = string
  default     = "t3.medium"
}

variable "iam_eks_ec2_permissions_arn" {
  description = "The ARN for the permissions for EKS to use EC2"
  type        = string
  nullable    = false
}

variable "iam_eks_ecr_permissions_arn" {
  description = "The ARN for the permissions for EKS to use ECR"
  type        = string
  nullable    = false
}

variable "name" {
  description = "The common name for resources"
  type        = string
  nullable    = false
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "stage" {
  description = "The environment stage"
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = "The VPC this will belong to"
  type        = string
  nullable    = false
}

variable "vpc_private_subnet_ids" {
  description = "The subnet IDS for the private subnet"
  type        = list(any)
  nullable    = false
}

variable "vpc_control_plane_subnet_ids" {
  description = "The subnet IDS for the control plan"
  type        = list(any)
  nullable    = false
}
