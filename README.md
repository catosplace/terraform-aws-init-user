# Terraform AWS Init User Module
Terraform module that creates a `terraform-init` user for use in bootstrapping
situations.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.54 |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| terraform\_init\_user\_access\_key | Generated terraform-init user AWS Access Key |
| terraform\_init\_user\_secret\_access\_key | Generated terraform-init user AWS Secret Access Key |

