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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The AWS account ID | `string` | n/a | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | The Kubernetes version to use | `string` | n/a | yes |
| <a name="input_eks_general_node_group_size"></a> [eks\_general\_node\_group\_size](#input\_eks\_general\_node\_group\_size) | The EC2 instance size of the managed node\_group | `string` | `"t3.medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | The common name for resources. | `string` | n/a | yes |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | How long to keep RDS backups | `number` | `0` | no |
| <a name="input_rds_database_engine"></a> [rds\_database\_engine](#input\_rds\_database\_engine) | The type of database to run | `string` | `"aurora-postgresql"` | no |
| <a name="input_rds_database_engine_mode"></a> [rds\_database\_engine\_mode](#input\_rds\_database\_engine\_mode) | The mode for the database | `string` | `"provisioned"` | no |
| <a name="input_rds_database_engine_version"></a> [rds\_database\_engine\_version](#input\_rds\_database\_engine\_version) | The version of the database to use | `string` | `"15.3"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The size of the RDS instance | `string` | `"db.serverless"` | no |
| <a name="input_rds_kms_key_id"></a> [rds\_kms\_key\_id](#input\_rds\_kms\_key\_id) | The KMS encryption key for RDS | `string` | n/a | yes |
| <a name="input_rds_password_rotation_automatically_after_days"></a> [rds\_password\_rotation\_automatically\_after\_days](#input\_rds\_password\_rotation\_automatically\_after\_days) | How many days between password rotations | `number` | `5` | no |
| <a name="input_rds_scaling_max_capacity"></a> [rds\_scaling\_max\_capacity](#input\_rds\_scaling\_max\_capacity) | The max number of replicated dbs | `number` | `10` | no |
| <a name="input_rds_scaling_min_capacity"></a> [rds\_scaling\_min\_capacity](#input\_rds\_scaling\_min\_capacity) | The minimum number of replicated dbs | `number` | `2` | no |
| <a name="input_rds_skip_final_snapshot"></a> [rds\_skip\_final\_snapshot](#input\_rds\_skip\_final\_snapshot) | Do we skip the final snapshot on delete? | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region | `string` | n/a | yes |
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
| <a name="output_eks_cluster_iam_role_arn"></a> [eks\_cluster\_iam\_role\_arn](#output\_eks\_cluster\_iam\_role\_arn) | The IAM role ARN for the node group for the cluster |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | The name of the base EKS cluster name |
| <a name="output_eks_cluster_oidc_issuer_url"></a> [eks\_cluster\_oidc\_issuer\_url](#output\_eks\_cluster\_oidc\_issuer\_url) | The OIDC URL |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | The public IP for the NAT |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The base VPC ARN |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The base VPC ID |
| <a name="output_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#output\_vpc\_private\_subnet\_ids) | The IDs of the private subnets |
<!-- END_TF_DOCS -->