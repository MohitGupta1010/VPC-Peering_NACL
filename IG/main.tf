

resource "aws_internet_gateway" "custom-ig" {
  vpc_id = var.vpc-id
  tags = {
    Name = "custom-ig"
  }
}
