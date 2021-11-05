resource "aws_instance" "ec2-intance" {
  ami           = "ami-054a31f1b3bf90920" # ubuntu 20.04
  instance_type = "t2.micro"
  key_name = "terraform-key"

  tags = {
    Name = "compute-tes"
  }

  network_interface {
    device_index            = 0
    network_interface_id    = aws_network_interface.instance-eni.id
  }
}

resource "aws_network_interface" "instance-eni" {
    subnet_id         = aws_subnet.public-subnet.id
    private_ips        = ["10.0.101.181"]
    security_groups   = [aws_security_group.intance-sg.id ]
}

/*
    eip is important to fix the intance ip
*/
resource "aws_eip" "lb" {
  instance = aws_instance.ec2-intance.id
  vpc      = true
}

/*
    security group
*/

resource "aws_security_group" "intance-sg" {
  name        = "allow ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
      description      = "Allow ssh connection from all internet"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "allow_tls"
  }
}