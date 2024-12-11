provider "aws" {
  region = "ap-southeast-1"
}
resource "aws_key_pair" "chinh-key" {
  key_name = "chinh-key"
  public_key = file("./keypair/id_rsa.pub")
}
resource "aws_instance" "chinh-demo-instance" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.chinh-key.key_name
  tags = {
    name = "chinh demo"
  }
  vpc_security_group_ids = [aws_security_group.chinh-security-group.id]
}


resource "aws_security_group" "chinh-security-group" {
  name = "chinh-security-group"
  description = "chinh-security-group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}