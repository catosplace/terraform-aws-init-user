# ------------------------------------------------------------------------------
# SET THE TERRAFORM BACKEND
# We use the local backend for bootstrap purposes.
# ------------------------------------------------------------------------------

terraform {
  backend "local" {}
}
