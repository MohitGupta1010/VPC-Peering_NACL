

resource "aws_subnet" "custom-subnet" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.cidr-block
  map_public_ip_on_launch = true
  tags = {
    Name = "custom-subnet"
  }
}
