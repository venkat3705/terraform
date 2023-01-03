
variable "bucket_name" {
  type        = string
  description = "Please enter your bucket name"
  default     = "mvrr-tf-sample-bucket-1"
}

variable "owner" {
  type        = string
  description = "Enter owner name"
  default = "administrator"
}
