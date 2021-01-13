#
# iam-service-user-gcc
# ------------
# this module assists in creating an iam user for gcc for service use
#

locals {
  name = "service-${var.username}"
}

# ref: https://www.terraform.io/docs/providers/aws/d/caller_identity.html
data "aws_caller_identity" "current" {}

# ref https://www.terraform.io/docs/providers/aws/r/iam_user.html
resource "aws_iam_user" "iam_user" {
  name                 = local.name
  force_destroy        = true
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/GCCIAccountBoundary"

  tags = {
    applied_with = "terraform"
    purpose      = var.purpose
    module_url   = "https://gitlab.com/govtechsingapore/gdsace/terraform-modules/iam-service-user-gcc"
  }
}

# ref https://www.terraform.io/docs/providers/aws/r/iam_access_key.html
resource "aws_iam_access_key" "iam_user" {
  user    = aws_iam_user.iam_user.name
  pgp_key = var.pgp_key
}

resource "aws_iam_group" "group" {
  name = "${local.name}-group"
}

resource "aws_iam_group_policy" "per_policy" {
  name  = "${local.name}-policy"
  group = aws_iam_group.group.name

  policy = var.user_policy
}

resource "aws_iam_group_policy_attachment" "attachment" {
  for_each   = var.user_attach_policy
  group      = aws_iam_group.group.name
  policy_arn = each.value
}

resource "aws_iam_group_membership" "group" {
  name = "${local.name}-group-membership"

  users = [
    aws_iam_user.iam_user.name
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_access_key" "access_key" {
  user    = aws_iam_user.iam_user.name
  pgp_key = var.pgp_key
}