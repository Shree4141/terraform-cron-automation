terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.34.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

#VPC

resource "aws_vpc" "devops" {
  cidr_block       = "171.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Devops_VPC"
  }
}


#Subnet

resource "aws_subnet" "Devops1" {
  vpc_id     = aws_vpc.devops.id
  cidr_block = "171.0.0.0/17"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Devops_SUB1"
  }
}

resource "aws_subnet" "Devops2" {
  vpc_id     = aws_vpc.devops.id
  cidr_block = "171.0.128.0/18"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Devops_SUB2"
  }
}

resource "aws_subnet" "Devops3" {
  vpc_id     = aws_vpc.devops.id
  cidr_block = "171.0.192.0/27"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Devops_SUB3"
  }
}

#Internet
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.devops.id

  tags = {
    Name = "Devops_IGW"
  }
}

# route table
resource "aws_route_table" "RouteT" {
  vpc_id = aws_vpc.devops.id

  route  {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Devops_RT"
  }
}

# route table association
resource "aws_route_table_association" "AssRT1" {
  subnet_id      = aws_subnet.Devops1.id
  route_table_id = aws_route_table.RouteT.id
}

resource "aws_route_table_association" "AssRT2" {
  subnet_id      = aws_subnet.Devops2.id
  route_table_id = aws_route_table.RouteT.id
}

resource "aws_route_table_association" "AssRT3" {
  subnet_id      = aws_subnet.Devops3.id
  route_table_id = aws_route_table.RouteT.id
}

resource "aws_security_group" "DevSec" {
  name   = "DevopsSec"
  vpc_id = aws_vpc.devops.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_key_pair" "newkey" {

    key_name = "newkey"
    public_key = file("newkey.pub")
  
}

resource "aws_instance" "devIns" {

  ami = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.Devops1.id
  key_name = aws_key_pair.newkey.key_name
  vpc_security_group_ids = [aws_security_group.DevSec.id]
  user_data = file("web.sh")

  tags = {
    Name = "Devops_Instance"
  }
}

output "public_ip" {
    value = aws_instance.devIns.public_ip
  
}

  

  
