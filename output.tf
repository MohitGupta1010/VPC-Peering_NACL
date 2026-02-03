output "default-connect-custom-status" {
  value = aws_vpc_peering_connection.default-connect-custom.accept_status
}

output "AZ1-cidr-block" {
  value = data.aws_subnet.az-of-region.cidr_block
}

output "custom-EC2-private-ip" {
  value = module.custom-EC2.custom-EC2-ip
}

output "default-EC2-public-ip" {
  value = module.default-EC2.default-EC2-ip
}

output "custom-vpc-resource-details" {
  value = {
    custom-vpc-id         = module.vpc.custom-vpc-id,
    custom-subnet-id      = module.subnet.subnet-id,
    custom-network-acl-id = module.network-acl.nacl-id,
    custom-route-table    = module.RouteTable.route-table-id,
    custom-IG             = module.IG.internet-gateway
  }
}
