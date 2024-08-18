data "aws_region" "_" {}
data "aws_caller_identity" "_" {}

locals {
  account_id = data.aws_caller_identity._.account_id
  region     = data.aws_region._.name
}

################################################################################
# Virtual Private Cloud
################################################################################

module "vpc" {
  source = "./modules/vpc"
  name   = var.name
  stage  = var.stage
}

################################################################################
# IAM
################################################################################

resource "aws_iam_policy" "eks_ec2_permissions" {
  name        = "EKSEC2Permissions"
  description = "EKS EC2 permissions for node group"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateVolume",
          "ec2:AttachVolume",
          "ec2:DeleteVolume",
          "ec2:DetachVolume",
          "ec2:CreateTags",
          "ec2:DescribeNetworkInterfaces"
        ],
        Resource = [
          "arn:aws:ec2:${local.region}:${local.account_id}:volume/*",
          "arn:aws:ec2:${local.region}:${local.account_id}:instance/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "eks_ecr_permissions" {
  name        = "EKSECRPermissions"
  description = "EKS additional permissions for node group"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = [
          "arn:aws:ecr:${local.region}:${local.account_id}:repository/*"
        ]
      }
    ]
  })
}

################################################################################
# Elastic Kubernetes Service
################################################################################

module "eks" {
  source = "./modules/eks"

  account_id = local.account_id
  region     = local.region

  name  = var.name
  stage = var.stage

  eks_cluster_version = "1.3"

  iam_eks_ec2_permissions_arn = aws_iam_policy.eks_ec2_permissions.arn
  iam_eks_ecr_permissions_arn = aws_iam_policy.eks_ecr_permissions.arn

  vpc_id                       = module.vpc.vpc_id
  vpc_control_plane_subnet_ids = module.vpc.vpc_control_plane_subnet_ids
  vpc_private_subnet_ids       = module.vpc.vpc_private_subnet_ids

  depends_on = [module.vpc, aws_iam_policy.eks_ec2_permissions, aws_iam_policy.eks_ecr_permissions]
}

################################################################################
# Relational Database Service - Aurora
################################################################################

module "aurora" {
  source = "./modules/aurora"

  name  = var.name
  stage = var.stage

  rds_kms_key_id = var.rds_kms_key_id

  vpc_id                          = module.vpc.vpc_id
  vpc_database_subnet_group_name  = module.vpc.vpc_database_subnet_group_name
  vpc_private_subnets_cidr_blocks = module.vpc.vpc_private_subnets_cidr_blocks

  depends_on = [module.vpc]
}
