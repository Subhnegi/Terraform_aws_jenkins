resource "aws_security_group" "jenkinsMasterSg" {
  name_prefix = "jenkinsMasterSg"
  description = "jenkinsSg using terraform"
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow tcp"
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "jenkinsMaster" {
  ami             = "ami-0866a3c8686eaeeba"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.jenkinsMasterSg.id ]
  key_name = "jenkinsMasterNewKey"
  user_data       = filebase64("userdata.sh")
}

output "domaiName" {
  value = aws_instance.jenkinsMaster.public_ip
}