# IAM Service User

Creates a IAM user account with a provided policy to control IAM permissions. Since this is a service role that is meant for programmatic access via applcations/automations, an MFA will not be required for authenticating as this user.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| pgp\_key | pgp key to use to encrypt the access keys - use 'gpg --export %KEY\_ID% \| base64 -w 0' to get this value | `string` | n/a | yes |
| purpose | a reason why this user should exist | `string` | n/a | yes |
| user\_attach\_policy | map(string) of existing policies to attach | `map(string)` | `{}` | no |
| user\_policy | policy attached to user through group | `string` | `""` | no |
| username | username for the user | `string` | `"gcc-default-user"` | no |
| enable\_gcci\_boundary | permission boundary toggle | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| access\_key | base64-encoded, encrypted access key of the user, use `base64 -d` to decrypt and `gpg -d encrypted.txt` |
| access\_key\_id | id of the access key |
| arn | arn of the created iam user |
| id | id of the created iam user |
| name | username of the created iam user |

