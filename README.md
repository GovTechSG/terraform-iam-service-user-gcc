## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.iam_attach_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_access\_key | Create user access key if enabled | `bool` | `true` | no |
| enable\_gcci\_boundary | toggle for gcci boundary to allow non-gcc accounts to create role | `bool` | `true` | no |
| pgp\_key | pgp key to use to encrypt the access keys - use 'gpg --export %KEY\_ID% \| base64 -w 0' to get this value | `string` | n/a | yes |
| purpose | a reason why this user should exist | `string` | n/a | yes |
| user\_attach\_policy | map(string) of existing policies to attach directly to user | `map(string)` | `{}` | no |
| user\_policy | IAM policy attached directly to user | `string` | `""` | no |
| username | username for the user | `string` | `"gcc-default-user"` | no |
| username\_prefix | prefix for username | `string` | `"service"` | no |

## Outputs

| Name | Description |
|------|-------------|
| access\_key | base64-encoded, encrypted access key of the user, use `base64 -d` to decrypt and `gpg -d encrypted.txt` |
| access\_key\_id | id of the access key |
| arn | arn of the created iam user |
| id | id of the created iam user |
| name | username of the created iam user |
