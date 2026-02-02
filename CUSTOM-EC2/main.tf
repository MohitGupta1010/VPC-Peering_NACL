# Deploy a EC2 in custom VPC 

resource "aws_security_group" "custom-sg" {
  name        = "custom-sg"
  description = "Adding a security group to custom vpc with all traffic"
  vpc_id      = var.vpc-id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "custom-EC2" {
  ami                         = var.ami
  instance_type               = var.instance-type
  key_name                    = var.key-name
  subnet_id                   = var.subnet-id
  vpc_security_group_ids      = [aws_security_group.custom-sg.id]
  associate_public_ip_address = true

  # Implement below provisioner only if custom security group allow both side traffic anywhere from ipv4
  # connection {
  #   type        = "ssh"
  #   user        = "ec2-user"
  #   private_key = var.privatekey
  #   host        = self.public_ip
  # }
  # provisioner "remote-exec" {
  #   on_failure = continue
  #   inline = [
  #     "sudo yum install httpd -y",
  #     "sudo systemctl enable httpd --now"
  #   ]
  # }

  tags = {
    Name = "custom-EC2"
  }
}
