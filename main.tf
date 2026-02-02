# Getting the cidr block of the default az ap-south-1a
data "aws_subnet" "ap-south-1a" {
  id = var.subnet-id
}

module "vpc" {
  source     = "./VPC"
  name       = "custom-vpc"
  cidr-block = "10.0.0.0/16"
}

module "subnet" {
  source     = "./SUBNETS"
  vpc-id     = module.vpc.custom-vpc-id
  cidr-block = "10.0.1.0/24"
  depends_on = [module.vpc]
}

module "network-acl" {
  source     = "./Network-ACL"
  vpc-id     = module.vpc.custom-vpc-id
  subnet-id  = module.subnet.subnet-id
  cidr-block = data.aws_subnet.ap-south-1a.cidr_block # by declaring these line motive is that only connection from default-vpc az1 will connect to custom-vpc.
  #cidr-block-all = "0.0.0.0/0"                         # remember to uncomment from Network-ACL main and variable, all traffic will be allowed in custom-vpc
  depends_on = [module.vpc, module.subnet, data.aws_subnet.ap-south-1a]
}

module "IG" {
  source     = "./IG"
  vpc-id     = module.vpc.custom-vpc-id
  depends_on = [module.vpc]
}

module "RouteTable" {
  source                = "./ROUTE-ROUTE_Table"
  vpc-id                = module.vpc.custom-vpc-id
  subnet-id             = module.subnet.subnet-id
  gateway-id            = module.IG.internet-gateway
  cidr-block            = data.aws_subnet.ap-south-1a.cidr_block
  peering-connection-id = aws_vpc_peering_connection.default-connect-custom.id
}

module "custom-EC2" {
  source        = "./CUSTOM-EC2"
  vpc-id        = module.vpc.custom-vpc-id
  ami           = "ami-00ca570c1b6d79f36"
  instance-type = "t3.micro"
  key-name      = var.key-name
  subnet-id     = module.subnet.subnet-id
  depends_on    = [module.vpc]
}

module "default-EC2" {
  source = "./default-EC2"
  # privatekey = var.privatekey
  default-server-config = {
    ami               = "ami-00ca570c1b6d79f36"
    instance_type     = "t3.micro"
    key_name          = var.key-name
    availability_zone = "ap-south-1a"
  }
}

# Adding route table entry for subnet of ap-south-1a to point to peering connection.

data "aws_route_table" "ap-south-1a-route-table" {
  subnet_id = var.subnet-id
}

resource "aws_route" "route" {
  route_table_id            = data.aws_route_table.ap-south-1a-route-table.id
  destination_cidr_block    = module.subnet.custom-subnet-cidr-block
  vpc_peering_connection_id = aws_vpc_peering_connection.default-connect-custom.id
  depends_on                = [aws_vpc_peering_connection.default-connect-custom, module.subnet]
}

# Below vpc is for telling terraform to use already available one and make aware of it, to use for peering in between default-vpc and custom-vpc

data "aws_vpc" "default" {
  default = "true"
}


# VPC Peering between the default-vpc and custom-vpc

resource "aws_vpc_peering_connection" "default-connect-custom" {
  vpc_id      = data.aws_vpc.default.id
  auto_accept = "true"
  peer_vpc_id = module.vpc.custom-vpc-id
  tags = {
    Name = "my-default-custom"
  }
}


