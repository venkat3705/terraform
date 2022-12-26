variable "env" {
    type = string 
    default = "Dev"
    description = "Environment Name"  
}

variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "Enter your cidr range. it defaults to 10.0.0.0/16"  
}

variable "igw_dest_cidr" {
    type = string
    default = "0.0.0.0/0"
}

variable "project_name" {
    type = string
    default = "Demo-tf"
}