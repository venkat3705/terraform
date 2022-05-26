variable "create_bucket" {
    type = bool
    description = "bucket creation required or not"
    default = true  
}

variable "bucket_name" {
    type = string
    description = "provide s3 bucket name"
}

variable "acl" {
    type = string
    description = "provide bucket acl like public-read, private, public-read-write"
    default = "private"
  
}

variable "force_destroy" {
    type = bool
    description = "bucket force destroy true or false. defaults to false"
    default = false
  
}

variable "website" {
    type = map(string)
    description = "value"
    default = { } 
}

variable "versioning" {
  type = map(string)
  description = "value"
  default = { }
}

variable "server_side_encryption_configuration" {
  type = any
  description = "provide bucket and object encryption details"
  default = { }
}

variable "encryption" {
    type = bool
    description = "encryption enabled or not"
    default = false
}

variable "kms_master_key_id" {
  type = string
  description = "provide encrytpion key arn"
  default = ""
}

variable "sse_algorithm" {
  type = string
  description = "algorithm type"
  default = "AES256"
}

variable "bucket_key_enabled" {
  type = bool
  description = "bucket key enable or not"
  default = false
}

variable "logging" {
  type = map(string)
  description = "provide bucket loggin details"
  default = {}
}

variable "replication_configuration" {
  type = any
  description = "Provide replication configuration"
  default = {}
  
}