data "aws_vpc" "default" {
  default = true
}


resource "aws_security_group" "default-sg" {
  name        = "default-sg"
  description = "Creating a Security group to allow all incoming traffic"
  vpc_id      = data.aws_vpc.default.id


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

resource "aws_instance" "default-EC2" {
  ami                    = var.default-server-config.ami
  instance_type          = var.default-server-config.instance_type
  key_name               = var.default-server-config.key_name
  vpc_security_group_ids = [aws_security_group.default-sg.id]
  availability_zone      = var.default-server-config.availability_zone

  # connection {
  #   type        = "ssh"
  #   user        = "ec2-user"
  #   private_key = var.privatekey
  #   host        = self.public_ip
  # }

  # provisioner "file" {
  #   on_failure  = continue
  #   source      = "/home/localadmin/second_exam.pem"
  #   destination = "/home/ec2-user/second_exam.pem"
  # }

  tags = {
    Name = "default-EC2"
  }
}
