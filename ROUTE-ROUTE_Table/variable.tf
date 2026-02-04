variable "vpc-id" {
  type = string
}

variable "subnet-id" {
  type = string
}

variable "gateway-id" {
  type = string
}

variable "peering-connection-id" {
  type = string
}

variable "cidr-block" {
  type = string
}

variable "cidr-block-vpc" {
  type        = string
  description = "A cidr block same as vpc cidr to add a local route entry in route table"
}