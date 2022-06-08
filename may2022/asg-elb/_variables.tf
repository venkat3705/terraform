variable "vpc_cidr_block" {
  type        = string
  description = "provide your CIDR Range"
  default     = "10.0.0.0/16"
}

variable "project" {
  type        = string
  description = "enter your project name"
  default     = "test"
}