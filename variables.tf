variable "pgp_key" {
  description = "pgp key to use to encrypt the access keys - use 'gpg --export %KEY_ID% | base64 -w 0' to get this value"
  type        = string
}

variable "purpose" {
  description = "a reason why this user should exist"
  type        = string
}

variable "username" {
  description = "username for the user"
  type        = string
  default     = "gcc-default-user"
}

variable "user_policy" {
  description = "policy attached to user through group"
  type        = string
  default     = ""
}

variable "user_attach_policy" {
  description = "map(string) of existing policies to attach"
  type        = map(string)
  default     = {}
}