// documentation link 
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "vpc" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ec2vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.101.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "route_table_association" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public.id
}