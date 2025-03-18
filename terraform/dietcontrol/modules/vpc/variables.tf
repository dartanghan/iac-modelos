variable "project_region" {
    type = string
}


variable "project_name" {
    type=string
}

variable "vpc_cidr_block"{
    type=string
    default="172.30.0.0/16"
}