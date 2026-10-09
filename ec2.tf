resource "aws_instance" "server_1" {
  ami           = "ami-00e236d9d38e7c625"
  instance_type = "t3.micro"

  key_name = "sjce-keypair"

  subnet_id = aws_subnet.subnet_1.id

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "devops-server-1"
  }
}

resource "aws_instance" "server_2" {
  ami           = "ami-00e236d9d38e7c625"
  instance_type = "t3.micro"

  key_name = "sjce-keypair"

  subnet_id = aws_subnet.subnet_2.id

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "devops-server-2"
  }
}