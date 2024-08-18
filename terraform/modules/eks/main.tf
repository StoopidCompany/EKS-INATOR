################################################################################
# Elastic Kubernetes Service
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.12.0"

  cluster_name    = "${var.name}-${var.stage}"
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.vpc_private_subnet_ids
  control_plane_subnet_ids = var.vpc_control_plane_subnet_ids

  # EKS Managed Node Group
  eks_managed_node_groups = {
    general = {
      name = var.stage

      instance_types = [var.eks_general_node_group_size]

      min_size     = 1
      max_size     = 10
      desired_size = 1

      labels = {
        role = "general"
      }
    }
  }

  tags = {
    Environment = upper(var.stage)
  }
}

################################################################################
# IAM
################################################################################

resource "aws_iam_policy_attachment" "eks_ec2_permissions" {
  name = "EKSEC2Permissions"
  roles = [
    module.eks.eks_managed_node_groups.general.iam_role_name
  ]
  policy_arn = var.iam_eks_ec2_permissions_arn
}

resource "aws_iam_policy_attachment" "eks_ecr_permissions" {
  name = "EKSECRPermissions"
  roles = [
    module.eks.eks_managed_node_groups.general.iam_role_name
  ]
  policy_arn = var.iam_eks_ecr_permissions_arn
}

################################################################################
# Output
################################################################################

output "eks_cluster_name" {
  description = "The name of the base EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "The ARN of the base EKS cluster"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the base EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The auth data"
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_oidc_issuer_url" {
  description = "The OIDC URL"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_iam_role_arn" {
  description = "The IAM role ARN for the node group for the cluster"
  value       = module.eks.cluster_iam_role_arn
}
