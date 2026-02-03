# variable "privatekey" {
#   type = string
# }

variable "subnet-id" {
  type        = string
  default     = "subnet-0b1e1c74e9f3feb70"
  description = "The subnet id of ap-south-1a availability zone that comes under default zone or add any other zone if you want"
}

variable "key-name" {
  type        = string
  default     = "second_exam"
  description = "Key that is used to take ssh on both vpc instance and gonna attach to them"
}

variable "vpc-config" {
  type = object({
    name       = string
    cidr-block = string
  })
  default = {
    name       = "custom-vpc"
    cidr-block = "10.0.0.0/16"
  }
}

variable "subnet-cidr-block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "custom-EC2-config" {
  type = object({
    ami           = string
    instance-type = string
  })
  default = {
    ami           = "ami-00ca570c1b6d79f36"
    instance-type = "t3.micro"
  }
}

variable "default-EC2-config" {
  type = object({
    ami               = string,
    instance_type     = string,
    key_name          = string,
    availability_zone = string,
  })
  default = {
    ami               = "ami-00ca570c1b6d79f36"
    instance_type     = "t3.micro"
    key_name          = "second_exam"
    availability_zone = "ap-south-1a"
  }

}

