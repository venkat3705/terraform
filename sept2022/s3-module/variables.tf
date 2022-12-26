variable "bucket_name" {
    type = string
    description = "Enter your bucket Name"  
}

variable "acl" {
    type = string
    description = "Bucket acl "
    default = "private"
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}

variable "website" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}