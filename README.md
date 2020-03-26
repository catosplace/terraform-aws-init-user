# Terraform AWS Init User Module
Terraform module that creates a `terraform-init` user for use in bootstrapping
situations.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.54 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| common\_tags | A map of tags to be added to all resources | `map(string)` | `{}` | no |
| name | The name for this module | `string` | `"terraform-init"` | no |
| user\_tags | Additional tags for the iam user | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| terraform\_init\_user\_access\_key | Generated terraform-init user AWS Access Key |
| terraform\_init\_user\_secret\_access\_key | Generated terraform-init user AWS Secret Access Key |

