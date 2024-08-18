################################################################################
# Aurora
################################################################################

output "aurora_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora.aurora_cluster_endpoint
}

output "aurora_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora.aurora_cluster_reader_endpoint
}

output "aurora_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora.aurora_cluster_database_name
}

output "aurora_cluster_port" {
  description = "The database port"
  value       = module.aurora.aurora_cluster_port
}

output "aurora_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora.aurora_cluster_master_password
  sensitive   = true
}

output "aurora_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora.aurora_cluster_master_username
  sensitive   = true
}

################################################################################
# EKS
################################################################################

output "eks_cluster_name" {
  description = "The name of the base EKS cluster name"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_arn" {
  description = "The ARN of the base EKS cluster"
  value       = module.eks.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the base EKS cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The auth data"
  value       = module.eks.eks_cluster_certificate_authority_data
}

output "eks_cluster_oidc_issuer_url" {
  description = "The OIDC URL"
  value       = module.eks.eks_cluster_oidc_issuer_url
}

output "eks_cluster_iam_role_arn" {
  description = "The IAM role ARN for the cluster"
  value       = module.eks.eks_cluster_iam_role_arn
}

output "eks_cluster_node_group_role_arn" {
  description = "The IAM role ARN for the node group for the cluster"
  value       = module.eks.eks_managed_node_group_iam_role_arns["general"]
}

################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The base VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The base VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.vpc_private_subnet_ids
}

output "nat_public_ips" {
  description = "The public IP for the NAT"
  value       = module.vpc.nat_public_ips
}
