output "default-EC2-ip" {
  value = aws_instance.default-EC2.public_ip
}