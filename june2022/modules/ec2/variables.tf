variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "select your instance type"
}

variable "ami_id" {
  type        = string
  default     = "ami-068257025f72f470d"
  description = "enter your ami id"
}