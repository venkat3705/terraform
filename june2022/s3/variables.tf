variable "bucket_name" {
    type = string 
    description = "enter bucket name"
}

variable "bucket_acl" {
    type = string
    description = "bucket acl"
    default = "private"   
}

variable "bucket_versioning" {
  type = map(string)
  description = "bucket versioning"
  default = {}
}

variable "bucket_website" {
  type = map(string)
  description = "enter website index and error documents"
  default = {}
}

variable "force_destroy" {
    type = bool
    description = "bucket force destroy true or false, defaults to false"
    default = false
}