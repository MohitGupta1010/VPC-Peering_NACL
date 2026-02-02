resource "aws_network_acl" "custom-nacl" {
  vpc_id     = var.vpc-id
  subnet_ids = [var.subnet-id]
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr-block
    # cidr_block = var.cidr-block-all
    from_port = 0
    to_port   = 0
  }


  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr-block
    # cidr_block = var.cidr-block-all
    from_port = 0
    to_port   = 0
  }

  tags = {
    Name = "custom-nacl"
  }
}