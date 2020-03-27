# ------------------------------------------------------------------------------
# CREATE AN AWS IAM POLICY DOCUMENT
# Create the terraform-init AWS IAM policy document that provides the resouce
# permissions for the bootstrap terraform-init user.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "terraform_init" {

  statement {
    sid = "AllowOrgCreation"

    actions = [
      "organizations:CreateOrganization",
      "organizations:DescribeOrganization",
      "organizations:CreateAccount",
      "organizations:ListAccounts",
      "organizations:DescribeAccount",
      "organizations:DescribeCreateAccountStatus",
      "organizations:ListRoots",
      "organizations:ListAWSServiceAccessForOrganization",
      "organizations:ListParents",
      "organizations:ListTagsForResource"
    ]

    resources = [
      "*"
    ]
  }
}

# ------------------------------------------------------------------------------
# CREATE AN AWS IAM POLICY
# Create the terraform-init user AWS IAM policy from the IAM policy document.
# This policy gets attached to the terraform-init user.
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "terraform_init_user" {
  name   = format("%s_policy", var.name)
  path   = "/"
  policy = data.aws_iam_policy_document.terraform_init.json
}
