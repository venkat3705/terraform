variable "bucket_name" {
    type = string
    description = "Enter your bucket name"
}

variable "acl" {
    type = string
    description = "acl defaults to private, you can choose public-read, public-read-write, authenticated-read"
    default = "private"
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}

variable "website" {
    type = map(string)
    description = "provide statice website configuration"
    default = {}
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}