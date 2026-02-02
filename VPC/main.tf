
resource "aws_vpc" "custom-vpc" {
  cidr_block           = var.cidr-block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }

}