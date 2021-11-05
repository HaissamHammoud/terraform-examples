// documentation link 
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "ecs-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.ecs-vpc.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.ecs-vpc.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "ecs-internet-gateway" {
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
    Name = "main"
  }
}