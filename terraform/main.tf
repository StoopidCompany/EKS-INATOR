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
          "arn:aws:ec2:${var.region}:${var.account_id}:volume/*",
          "arn:aws:ec2:${var.region}:${var.account_id}:instance/*"
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
          "arn:aws:ecr:${var.region}:${var.account_id}:repository/*"
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

  account_id = var.account_id
  region     = var.region

  name  = var.name
  stage = var.stage

  eks_cluster_version         = var.eks_cluster_version
  eks_default_node_group_size = var.eks_default_node_group_size
  eks_default_disk_size       = var.eks_default_disk_size

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

  rds_backup_retention_period = var.rds_backup_retention_period
  rds_database_engine         = var.rds_database_engine
  rds_database_engine_version = var.rds_database_engine_version
  rds_database_engine_mode    = var.rds_database_engine_mode

  rds_instance_class = var.rds_instance_class

  rds_kms_key_id = var.rds_kms_key_id

  rds_password_rotation_automatically_after_days = var.rds_password_rotation_automatically_after_days
  rds_scaling_max_capacity                       = var.rds_scaling_max_capacity
  rds_scaling_min_capacity                       = var.rds_scaling_min_capacity
  rds_skip_final_snapshot                        = var.rds_skip_final_snapshot

  vpc_id                          = module.vpc.vpc_id
  vpc_database_subnet_group_name  = module.vpc.vpc_database_subnet_group_name
  vpc_private_subnets_cidr_blocks = module.vpc.vpc_private_subnets_cidr_blocks

  depends_on = [module.vpc]
}
