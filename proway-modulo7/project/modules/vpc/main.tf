resource "aws_vpc" "dart_vpc" {
  cidr_block = "172.200.0.0/16"
  tags = {
    Name = "dart-vpc"
  }
}

resource "aws_subnet" "sn_priv01" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "dart-sn_priv01"
  }
}
resource "aws_subnet" "sn_priv02" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "dart-sn_priv02"
  }
}
resource "aws_subnet" "sn_pub01" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "dart-sn_pub01"
  }
}
resource "aws_subnet" "sn_pub02" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "dart-sn_pub02"
  }
}

resource "aws_security_group" "dart_nginx_sg" {
    vpc_id = aws_vpc.dart_vpc.id
    name = "dart_nginx_sg"
    tags = {
      Name = "dart-nginx_sg"
    }
}

resource "aws_vpc_security_group_egress_rule" "dart_egress_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
} 

resource "aws_vpc_security_group_ingress_rule" "dart_ingress_80_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}
resource "aws_vpc_security_group_ingress_rule" "dart_ingress_22_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

