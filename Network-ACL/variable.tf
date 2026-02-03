variable "vpc-id" {
  type = string
}

variable "subnet-id" {
  type = string
}

variable "cidr-block" {
  type = string
}

# variable "cidr-block-all" {
#   description = "allowed all subnet to communicate with custom-vpc subnet if vpc peering is acheived in between both"
#   type = string
# }

