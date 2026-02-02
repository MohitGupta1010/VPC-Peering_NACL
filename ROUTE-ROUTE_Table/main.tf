resource "aws_route_table" "custom-route" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway-id
  }
  route {
    cidr_block                = var.cidr-block
    vpc_peering_connection_id = var.peering-connection-id
  }

  tags = {
    Name = "custom"
  }
}


resource "aws_route_table_association" "custom-routetable-association-with-subnet" {
  subnet_id      = var.subnet-id
  route_table_id = aws_route_table.custom-route.id
}