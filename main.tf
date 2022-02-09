#
# iam-service-user-gcc
# ------------
# this module assists in creating an iam user for gcc for service use
#

locals {
  name = "${var.username_prefix}-${var.username}"
}

# ref: https://www.terraform.io/docs/providers/aws/d/caller_identity.html
data "aws_caller_identity" "current" {}

# ref https://www.terraform.io/docs/providers/aws/r/iam_user.html
resource "aws_iam_user" "iam_user" {
  name                 = local.name
  force_destroy        = true
  permissions_boundary  = var.enable_gcci_boundary ? "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/GCCIAccountBoundary" : ""

  tags = {
    applied_with = "terraform"
    purpose      = var.purpose
    module_url   = "https://gitlab.com/govtechsingapore/gdsace/terraform-modules/iam-service-user-gcc"
  }
}

# ref https://www.terraform.io/docs/providers/aws/r/iam_access_key.html
resource "aws_iam_access_key" "iam_user" {
  count   = var.pgp_key == "" ? 0 : 1
  user    = aws_iam_user.iam_user.name
  pgp_key = var.pgp_key
}

# ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy
resource "aws_iam_user_policy" "iam_policy" {
  count = var.user_policy == "" ? 0 : 1
  name = "${local.name}-policy"
  user = aws_iam_user.iam_user.name
  policy = var.user_policy
}

# ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment
resource "aws_iam_user_policy_attachment" "iam_attach_policy" {
  user = aws_iam_user.iam_user.name
  for_each = var.user_attach_policy
  policy_arn = each.value
}