variable "project" {
  type        = string
  default     = "Learning"
  description = "Provide your project name"

}

variable "owner" {
  type        = string
  default     = "siva"
  description = "Provider owner information"

}

variable "block_public_acls" {
  type        = bool
  default     = false
  description = "this is for enable public acl for bucket"
}

variable "create_user" {
  type        = bool
  default     = false
  description = "create user or not"
}

variable "sample" {
  type        = bool
  default     = false
  description = "create user or not"
}