# ------------------------------------------------------------------------------
# PIN TERRAFORM VERSION TO >= 0.12
# ------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = "~> 2.54"
  }
}

# ------------------------------------------------------------------------------
# DEFAULT TERRAFORM EXAMPLE
# ------------------------------------------------------------------------------

module "terraform_init" {
  source = "../"
}
