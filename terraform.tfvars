# Provide the region.
region = "ap-southeast-1"

# Provide any subnet id of default vpc in any region.
subnet-id = "subnet-0da1690e4d1e2d9b3"

# Provide the key name (used to ssh in instance) available in that region.
key-name = "singapore-az-1"

# Provide arguments to create a custom vpc in selected region.
vpc-config = {
    name = "custom-vpc"
    cidr-block = "10.0.0.0/16"
}

# Provide subnet cidr to set it up under custom vpc, cidr should be in /16 - /28 range.
subnet-cidr-block = "10.0.1.0/24"

# Provide arguments for custom EC2 to launch under custom vpc.
custom-EC2-config = {
    ami = "ami-08d59269edddde222"
    instance-type = "t3.micro"
}

# Provide config for default EC2 to launch under default vpc.
default-EC2-config = {
    ami = "ami-08d59269edddde222"
    instance_type = "t3.micro"
    key_name = "singapore-az-1"
    availability_zone = "ap-southeast-1b"  # since passed the subnet id of ap-southeast-1b 
}