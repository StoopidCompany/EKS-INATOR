<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ./modules/aurora | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.eks_ec2_permissions](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_ecr_permissions](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/resources/iam_policy) | resource |
| [aws_caller_identity._](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/data-sources/caller_identity) | data source |
| [aws_region._](https://registry.terraform.io/providers/hashicorp/aws/5.61.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The common name for resources. | `string` | n/a | yes |
| <a name="input_rds_kms_key_id"></a> [rds\_kms\_key\_id](#input\_rds\_kms\_key\_id) | The KMS encryption key ARN for use by RDS. | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage for this environment. | `string` | `"prod"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_cluster_database_name"></a> [aurora\_cluster\_database\_name](#output\_aurora\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_aurora_cluster_endpoint"></a> [aurora\_cluster\_endpoint](#output\_aurora\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_aurora_cluster_master_password"></a> [aurora\_cluster\_master\_password](#output\_aurora\_cluster\_master\_password) | The database master password |
| <a name="output_aurora_cluster_master_username"></a> [aurora\_cluster\_master\_username](#output\_aurora\_cluster\_master\_username) | The database master username |
| <a name="output_aurora_cluster_port"></a> [aurora\_cluster\_port](#output\_aurora\_cluster\_port) | The database port |
| <a name="output_aurora_cluster_reader_endpoint"></a> [aurora\_cluster\_reader\_endpoint](#output\_aurora\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | The ARN of the base EKS cluster |
| <a name="output_eks_cluster_certificate_authority_data"></a> [eks\_cluster\_certificate\_authority\_data](#output\_eks\_cluster\_certificate\_authority\_data) | The auth data |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | The endpoint for the base EKS cluster |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | The name of the base EKS cluster name |
| <a name="output_eks_cluster_oidc_issuer_url"></a> [eks\_cluster\_oidc\_issuer\_url](#output\_eks\_cluster\_oidc\_issuer\_url) | The OIDC URL |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | The public IP for the NAT |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The base VPC ARN |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The base VPC ID |
| <a name="output_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#output\_vpc\_private\_subnet\_ids) | The IDs of the private subnets |
<!-- END_TF_DOCS -->