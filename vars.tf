variable "eks-name" {
  default = "eks-first-cluster"
}
variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}


variable "public_subnets_cidr" {
  default = [
    "10.20.0.0/19",
    "10.20.32.0/19"
  ]
  type = list(any)
}

variable "private_subnets_cidr" {
  default = [
    "10.20.64.0/19",
    "10.20.96.0/19",
  ]
  type = list(any)
}

# variable "environment" {
# description = "The environment which to fetch the configuration for."
# type = string
# }