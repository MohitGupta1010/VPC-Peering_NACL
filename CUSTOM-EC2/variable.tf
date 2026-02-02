# The main reason for declaring here is don't want to reference again via variable while module
# creation in main.tf again need to declare variable.tf for overall folder.

variable "ami" {
  type = string
}

variable "instance-type" {
  type = string
}

variable "key-name" {
  type = string
}

variable "subnet-id" {
  type = string
}

variable "vpc-id" {
  type = string
}
