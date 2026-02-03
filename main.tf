# Getting the cidr block of the default az az-of-region
data "aws_subnet" "az-of-region" {
  id = var.subnet-id
}

module "vpc" {
  source     = "./VPC"
  name       = var.vpc-config.name
  cidr-block = var.vpc-config.cidr-block
}

module "subnet" {
  source     = "./SUBNETS"
  vpc-id     = module.vpc.custom-vpc-id
  cidr-block = var.subnet-cidr-block
  depends_on = [module.vpc]
}

module "network-acl" {
  source     = "./Network-ACL"
  vpc-id     = module.vpc.custom-vpc-id
  subnet-id  = module.subnet.subnet-id
  cidr-block = data.aws_subnet.az-of-region.cidr_block # by declaring these line motive is that only connection from default-vpc az1 will connect to custom-vpc.
  #cidr-block-all = "0.0.0.0/0"                         # remember to uncomment from Network-ACL main and variable, all traffic will be allowed in custom-vpc
  depends_on = [module.vpc, module.subnet, data.aws_subnet.az-of-region]
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
  cidr-block            = data.aws_subnet.az-of-region.cidr_block
  peering-connection-id = aws_vpc_peering_connection.default-connect-custom.id
}

module "custom-EC2" {
  source        = "./CUSTOM-EC2"
  vpc-id        = module.vpc.custom-vpc-id
  ami           = var.custom-EC2-config.ami
  instance-type = var.custom-EC2-config.instance-type
  key-name      = var.key-name
  subnet-id     = module.subnet.subnet-id
  depends_on    = [module.vpc]
}

module "default-EC2" {
  source = "./default-EC2"
  # privatekey = var.privatekey
  default-server-config = {
    ami               = var.default-EC2-config.ami
    instance_type     = var.default-EC2-config.instance_type
    key_name          = var.key-name
    availability_zone = var.default-EC2-config.availability_zone
  }
}

# Adding route table entry for subnet of az-of-region to point to peering connection.

data "aws_route_table" "az-of-region-route-table" {
  subnet_id = var.subnet-id
}

resource "aws_route" "route" {
  route_table_id            = data.aws_route_table.az-of-region-route-table.id
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


