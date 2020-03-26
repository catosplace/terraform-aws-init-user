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

resource "aws_iam_policy" "terraform_init_user" {
  name   = "terraform_init_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.terraform_init.json
}
