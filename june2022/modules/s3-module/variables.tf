variable "users" {
  type        = list(any)
  description = "Enter your users list"
  default     = ["tf-example", "tf-demo", "tf-some"]
}

variable "buckets" {
  type        = set(string)
  description = "enter your buckets list"
  default     = ["rssr-for-each-example", "rssr-for-each-sample", "rssr-for-each-demo"]

}