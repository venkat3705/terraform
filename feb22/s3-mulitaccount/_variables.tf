variable "versioning" {
  type        = bool
  description = "versioning enabled defaults to false"
  default     = false

}

variable "force_destroy" {
  type        = bool
  description = "bucket force destroy deafults to false. choose your option true or false"
  default     = false

}

variable "bucket_name" {
  type        = string
  description = "enter bucket name"
}

variable "env" {
    type = string
    description = "enter your environment name"  
}