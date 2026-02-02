variable "default-server-config" {
  type = object({
    ami               = string,
    instance_type     = string,
    key_name          = string,
    availability_zone = string,
  })

  # default = {
  #   ami = "ami-00ca570c1b6d79f36"
  #   instance_type = "t3.micro"
  #   key_name = "second_exam"
  #   availability_zone = "ap-south-1a"
  # }
}

# variable "privatekey"{
#   type = string
# }

# Added the private key as a form of variable in user .bash_profile by TF_VAR_privatekey="$(cat ~localadmin/second_exam.pem)"