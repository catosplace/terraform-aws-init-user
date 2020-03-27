# Terraform AWS Init User Module
Terraform module that creates a `terraform-init` user for use in bootstrapping
situations.

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.54 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| common\_tags | A map of tags to be added to all resources | `map(string)` | `{}` | no |
| default\_region | Configure the default AWS region for the AWS provider | `string` | `"ap-southeast-2"` | no |
| name | The init user name | `string` | `"terraform-init"` | no |
| user\_tags | Additional tags for the iam user | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| user\_access\_key | Generated terraform-init user AWS Access Key |
| user\_id | The terraform-init user identifier |
| user\_secret\_access\_key | Generated terraform-init user AWS Secret Access Key |

