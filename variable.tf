# variable "privatekey" {
#   type = string
# }

variable "subnet-id" {
  type        = string
  default     = "subnet-0b1e1c74e9f3feb70"
  description = "The subnet id of ap-south-1a availability zone that comes under default zone"
}

variable "key-name" {
  type        = string
  default     = "second_exam"
  description = "Key that is used to take ssh on both vpc instance"
}