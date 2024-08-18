data "aws_availability_zones" "_" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones._.names, 0, 3)
}

################################################################################
# Virtual Private Cloud 
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${var.name}-${var.stage}"
  cidr = var.vpc_cidr

  azs                 = local.azs
  intra_subnets       = [for az in local.azs : cidrsubnet(var.vpc_cidr, 8, index(local.azs, az))]
  private_subnets     = [for az in local.azs : cidrsubnet(var.vpc_cidr, 8, index(local.azs, az) + 4)]
  public_subnets      = [for az in local.azs : cidrsubnet(var.vpc_cidr, 8, index(local.azs, az) + 8)]
  database_subnets    = [for az in local.azs : cidrsubnet(var.vpc_cidr, 8, index(local.azs, az) + 12)]
  elasticache_subnets = [for az in local.azs : cidrsubnet(var.vpc_cidr, 8, index(local.azs, az) + 16)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}-${var.stage}" = "shared"
    "kubernetes.io/role/elb"                         = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}-${var.stage}" = "shared"
    "kubernetes.io/role/internal-elb"                = "1"
  }

  tags = {
    Environment = upper(var.stage)
  }
}

################################################################################
# Output
################################################################################

output "vpc_id" {
  description = "The base VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The base VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_control_plane_subnet_ids" {
  description = "Intra subnet IDS for EKS control plane"
  value       = module.vpc.intra_subnets
}

output "vpc_database_subnet_group_name" {
  description = "The database subnet group name"
  value       = module.vpc.database_subnet_group_name
}

output "vpc_private_subnets_cidr_blocks" {
  description = "The CIDR blocks for private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "vpc_private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "nat_public_ips" {
  description = "The public IP for the NAT"
  value       = module.vpc.nat_public_ips
}
